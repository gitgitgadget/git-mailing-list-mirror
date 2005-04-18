From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 10:23:32 +0100
Message-ID: <20050418102332.A21081@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org> <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 11:21:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNSQk-0001gJ-J4
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 11:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVDRJYX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 05:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVDRJYW
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 05:24:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25615 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261904AbVDRJXk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 05:23:40 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNSTd-0000X9-Mq; Mon, 18 Apr 2005 10:23:34 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNSTc-0006Rb-Hg; Mon, 18 Apr 2005 10:23:32 +0100
To: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org>; from torvalds@osdl.org on Sun, Apr 17, 2005 at 04:24:24PM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 17, 2005 at 04:24:24PM -0700, Linus Torvalds wrote:
> On Sun, 17 Apr 2005, Russell King wrote:
> > I pulled it tonight into a pristine tree (which of course worked.)
> 
> Goodie.

Note the "pristine".  Now comes the real test...

> > In doing so, I noticed that I'd messed up one of the commits - there's
> > a missing new file.  Grr.  I'll put that down to being a newbie git.
> 
> Actually, you should put that down to horribly bad interface tools.  With
> BK, we had these nice tools that pointed out that there were files that
> you might want to commit (ie "bk citool"), and made this very obvious.
> 
> Tools absolutely matter. And it will take time for us to build up that 
> kind of helper infrastructure. So being newbie might be part of it, but 
> it's the smaller part, I say. Rough interfaces is a big issue.

Ok, I just tried pulling your tree into the tree you pulled from, and
got this:

Tree change: e7905b2f22eb5d5308c9122b9c06c2d02473dd4f ee423ea56280512778a5961ee58a785a73acb7d1
...
*100644->100644 blob    46f0a3caae02b4bb8f903d7ac86456aa0c37954b->ba4afd7956173b6f89eb6b0b9ad23b392d5c0aee      arch/arm/kernel/process.c
*100644->100644 blob    4a36fa7192e11df36f5e0928b064239dabe1e305->ec0bc8f315ab5d78a4220e176e7aee76d52d1c74      arch/arm/kernel/traps.c
*100644->100644 blob    311d19ee00208faf02359f9e7c5394577a40f253->bf923a953703c6ca0c88eac3b2850cf07b838996      arch/arm/lib/changebit.S
*100644->100644 blob    c07afa31695654e6489ec59c3f837183b325e9da->41f89b3a393d5af939f04f63c5bf4991b2bf6599      arch/arm/lib/clearbit.S
...
Tracked branch, applying changes...
Merging e7905b2f22eb5d5308c9122b9c06c2d02473dd4f -> ee423ea56280512778a5961ee58a785a73acb7d1
        to df4449813c900973841d0fa5a9e9bc7186956e1e...
COPYING: needs update
CREDITS: needs update
Documentation/00-INDEX: needs update
Documentation/BK-usage/00-INDEX: needs update
...
patching file arch/arm/kernel/process.c
Reversed (or previously applied) patch detected!  Skipping patch.
2 out of 2 hunks ignored -- saving rejects to file arch/arm/kernel/process.c.rejpatching file arch/arm/kernel/traps.c
Reversed (or previously applied) patch detected!  Skipping patch.
3 out of 3 hunks ignored -- saving rejects to file arch/arm/kernel/traps.c.rej
patching file arch/arm/lib/changebit.S
Reversed (or previously applied) patch detected!  Skipping patch.
2 out of 2 hunks ignored -- saving rejects to file arch/arm/lib/changebit.S.rej
patching file arch/arm/lib/clearbit.S
Reversed (or previously applied) patch detected!  Skipping patch.
2 out of 2 hunks ignored -- saving rejects to file arch/arm/lib/clearbit.S.rej

so obviously git pull isn't able to indentify what's already in the
local repository.

Interestingly, the files listed above as having rejects are excluded
from the list of "needs update".  And I don't know why git is staying
that these files need updating, because they haven't changed since
they were initially checked out.

This was with some random version of git-pasky-0.04.  Unfortunately,
this version doesn't have the sha1 ID appended, so I couldn't say
definitively that it's the latest and greatest.  It might be a day
old.

-- 
Russell King

