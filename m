From: Johan Herland <johan@herland.net>
Subject: Re: Commit notes workflow
Date: Wed, 15 Jun 2011 12:53:57 +0200
Message-ID: <201106151253.57908.johan@herland.net>
References: <450570199.1013051308131850322.JavaMail.root@zimbra44-e7.priv.proxad.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Yann Dirson <dirson@bertin.fr>
To: ydirson@free.fr
X-From: git-owner@vger.kernel.org Wed Jun 15 12:54:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWnjh-00060U-OH
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 12:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab1FOKyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 06:54:04 -0400
Received: from smtp.opera.com ([213.236.208.81]:35300 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138Ab1FOKyC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 06:54:02 -0400
Received: from johanh.localnet (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p5FArxv2008367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 15 Jun 2011 10:53:59 GMT
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-Reply-To: <450570199.1013051308131850322.JavaMail.root@zimbra44-e7.priv.proxad.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175821>

On Wednesday 15. June 2011, ydirson@free.fr wrote:
> > I'm still unsure what that limitation brings to us.  OTOH, it has
> > at least one funny downside: when someone tries to refer to some
> > forbidden ref using --ref, it gets silently requalified:
> > 
> > $ git notes --ref=refs/remote-notes/foo add
> > $ find .git/refs/notes/ -type f
> > .git/refs/notes/refs/remote-notes/foo
> > $
> > 
> > It just seems so wrong...  Surely we can mitigate it by considering
> > a ref starting with "refs/" to be absolute, and thus never prepend
> > "refs/notes/" to it, but it rather sounds to me a symptom that we
> > may not want to filter things anyway.
> 
> While playing with this, I realized that when editing the template
> does not name the notes ref being edited.  When looking at the code,
> I notice that, contrarily to commit.c which uses stdio, notes.c uses
> write_or_die(), which is a bit less flexible for formatting.
> 
> I'd think we could me things more consistent - is there any objection
> to switch notes.c to using stdio for this ?

Go ahead, Doing things in line with commit.c seems good to me.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
