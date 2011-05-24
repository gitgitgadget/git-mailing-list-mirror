From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 04/10] receive-pack: Prepare for addition of the new
 'limit-*' family of capabilities
Date: Tue, 24 May 2011 02:16:48 +0200
Message-ID: <201105240216.49225.johan@herland.net>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
 <1306111923-16859-5-git-send-email-johan@herland.net>
 <7v8vtxt3yf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 02:18:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOfKD-0002po-UY
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 02:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757860Ab1EXASP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 20:18:15 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43720 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757836Ab1EXASN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 20:18:13 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLO00BVWBIC3160@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 24 May 2011 02:18:12 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 504AC179971F_DDAF8F2B	for <git@vger.kernel.org>; Tue,
 24 May 2011 00:16:50 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id F3BD017971D7_DDAF8F1F	for <git@vger.kernel.org>; Tue,
 24 May 2011 00:16:49 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLO00KRDBG1F910@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 24 May 2011 02:16:49 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <7v8vtxt3yf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174299>

On Monday 23 May 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > This adds some technical documentation on the 'limit-*' family of
> > capabilities that will be added in the following commits.
> > 
> > Also refactor the generation of the capabilities declaration in
> > receive-pack. This will also be further expanded in the following
> > commits.
> > 
> > Signed-off-by: Johan Herland <johan@herland.net>
> > ---
> > ...
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index e1ba4dc..c55989d 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -106,15 +106,23 @@ static int receive_pack_config(const char *var,
> > const char *value, void *cb)
> > 
> >  	return git_default_config(var, value, cb);
> >  
> >  }
> > 
> > +static const char *capabilities()
> 
> static const char *capabilities(void)

Thanks, will be in the next iteration


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
