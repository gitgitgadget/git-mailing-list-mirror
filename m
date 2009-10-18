From: Johan Herland <johan@herland.net>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 19:23:19 +0200
Message-ID: <200910181923.19511.johan@herland.net>
References: <20091018144158.GA9789@gandalf.dynalias.org>
 <200910181703.20607.johan@herland.net>
 <20091018152054.GA3956@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Norbert Preining <preining@logic.at>
X-From: git-owner@vger.kernel.org Sun Oct 18 19:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzZuq-0006rC-0p
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 19:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbZJRRrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 13:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbZJRRrr
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 13:47:47 -0400
Received: from smtp.getmail.no ([84.208.15.66]:58573 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754724AbZJRRrq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2009 13:47:46 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KRQ00G2Q0AWHP10@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 18 Oct 2009 19:23:20 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KRQ00DEX0AVIC20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 18 Oct 2009 19:23:20 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.18.170916
User-Agent: KMail/1.12.2 (Linux/2.6.30-ARCH; KDE/4.3.2; x86_64; ; )
In-reply-to: <20091018152054.GA3956@gamma.logic.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130605>

On Sunday 18 October 2009, Norbert Preining wrote:
> On So, 18 Okt 2009, Johan Herland wrote:
> >     $ git describe
> >     v1.0.4-14-g2414721
> >
> > where the "v1.0.4" part is the last tag that the current state is based
> > on, the "14" part is the number of commit between that tag and the
> > current
> 
> So if we have only one tag (initial) then it would count the number
> of commits?

Yes. You can create the 'initial' tag with

  git rev-list HEAD | tail -n1 | xargs git tag initial

and from then on

  git describe --tags --match initial | cut -d'-' -f2

will give you the increasing "revision" number you're looking for. Just be 
aware that if you have two parallel branches with the same number of 
commits, they will give you the same number. I.e. this only works for a 
single, stable (i.e. no history rewrites), branch of development.


Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
