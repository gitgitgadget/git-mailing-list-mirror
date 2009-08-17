From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/2] git_remote_cvs: Honor DESTDIR in the Makefile
Date: Mon, 17 Aug 2009 03:58:30 +0200
Message-ID: <200908170358.30347.johan@herland.net>
References: <7v7hx35ym1.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0908162251360.8306@pacific.mpi-cbg.de>
 <20090816210300.GB23522@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org, barkalow@iabervon.org,
	mhagger@alum.mit.edu
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 03:58:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McrUd-0006LW-K4
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 03:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547AbZHQB6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 21:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756479AbZHQB6b
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 21:58:31 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49960 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756470AbZHQB6b (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Aug 2009 21:58:31 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOI00LML05J1G90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 17 Aug 2009 03:58:31 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOI004VY05IYN90@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 17 Aug 2009 03:58:31 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.17.14822
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <20090816210300.GB23522@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126107>

On Sunday 16 August 2009, David Aguilar wrote:
> I'll see if we rework this so that we end up passing "" to
> --root instead of /.  I'm going to be gone for a few hours so
> probably won't be able to try it out until tonight.

Thanks a lot for your work! I will send an updated series shortly which will 
include v2 of your DESTDIR/Makefile fixes, and also the fixes you suggested 
earlier (including _lots_ of PEP8 fixes).

> Another thing to consider --
>
> Debian once submitted a bug against another Python app asking
> that we not place modules in site-packages unless we
> plan on having other applications importing those modules.
>
> The more appropriate place for them if we don't plan on that is
> $(prefix)/share/git-core/git_remote_cvs or something like that.
>
> I guess that's another thing to think about.

Yes, Debian raises a valid point. I haven't thought much about making the 
git_remote_cvs package into something that would be useful for other 
applications. (I just assumed that the Python convention was to install it 
into site-packages regardless...) For now, I'll concentrate on git-remote-
cvs, and leave it to others to figure out if anything in the git_remote_cvs 
package is useful for other programs.

Note that there's a small chicken-and-egg problem here as well: If Debian 
refuses us to install into site-packages, it will be harder for other Python 
programs to discover (and import) the git_remote_cvs package.

BTW, when we're on the subject of packaging: There are some variables in 
git_remote_cvs/setup.py where I'm not sure what the correct value should be:

- version - should this follow Git's version number, or is it independent?
- author (and author_email + url) - For now, I'm referring to the Git 
community. Should this be more specific/

Feedback welcome.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
