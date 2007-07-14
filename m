From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: mtimes of working files
Date: Sat, 14 Jul 2007 01:36:33 +0100
Message-ID: <1184373393.2785.99.camel@shinybook.infradead.org>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com>
	 <Pine.LNX.4.64.0707111940080.4516@racer.site>
	 <20070711202615.GE3069@efreet.light.src>
	 <200707120857.53090.andyparkins@gmail.com>
	 <1184261246.31598.139.camel@pmac.infradead.org>
	 <20070713003700.GA21304@thunk.org>
	 <1184367619.2785.58.camel@shinybook.infradead.org>
	 <alpine.LFD.0.999.0707131617270.20061@woody.linux-foundation.org>
	 <1184370414.2785.79.camel@shinybook.infradead.org>
	 <alpine.LFD.0.999.0707131704000.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, Andy Parkins <andyparkins@gmail.com>,
	git@vger.kernel.org, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 02:35:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Vbp-0002wN-6G
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 02:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbXGNAfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 20:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754123AbXGNAfi
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 20:35:38 -0400
Received: from canuck.infradead.org ([209.217.80.40]:43794 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbXGNAfh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 20:35:37 -0400
Received: from shinybook-bcm.infradead.org ([2001:8b0:10b:1:20a:95ff:fef3:9992])
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1I9Vbg-0006WS-Nj; Fri, 13 Jul 2007 20:35:33 -0400
In-Reply-To: <alpine.LFD.0.999.0707131704000.20061@woody.linux-foundation.org>
X-Mailer: Evolution 2.10.2 (2.10.2-2.fc7.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52427>

On Fri, 2007-07-13 at 17:10 -0700, Linus Torvalds wrote:
> 
> On Sat, 14 Jul 2007, David Woodhouse wrote:
> > 
> > On the occasions I actually try to _use_ branches, I find it very
> > suboptimal.
> 
> This seems to be very personal.

Yeah, much of it. Although I've also seen other people trying to get to
grips with git and tripping up over branches recently. It _was_ getting
easier, for a while :)

> But I literally tend to just use branches for something small. I don't 
> personally tend to have any long-term live branches (apart from the remove 
> ones, obviously). I create a branch, do something in it, merge it, and 
> go back to master.

I don't usually bother with that. I just do something in HEAD and then
reset (possibly after pushing it to some tree elsewhere for posterity).

> I don't even use ccache, and I don't care. Probably because most of the 
> time the rebuild time really isn't that long for me, and for the kernel, 
> the much more painful part is actually the rebooting part.

I can usually find some other machine to reboot than the machine I'm
working on. Don't these people send you enough toys? :)

I've also spent most of the last year travelling and hence working on my
laptop, which isn't the beefiest build machine I've ever had the
pleasure of using. Changing branches, when I've done it, really has been
a pain.

> But the place where branches *really* rock is when you don't even switch 
> to them, but use the data from them locally (cherry-picking from them, 
> or doing something like "git show origin/pu:builtin-blame.c" etc).

You can achieve much of that just by sharing object directories, and
I'll admit that sometimes I do set up temporary branches just for the
purpose of cherry-picking by name ('foo^^' etc.) without having to paste
sha1sums from the other tree.

> And for that to work, you have to get used to having multiple branches in 
> the tree, even if you don't check them out - and once you do that, 
> switching between them isn't really that confusing any more, because it's 
> already part of your "mind map" of how the repo works.

I'm sure it's true that if I persist I'll get used to it, as will the
newbies who have trouble with branches. But mostly I suspect that I'll
get used to it by learning how best to work around it and keep separate
trees of my own, even when people persist in having multiple branches on
their servers. And while today's set of newbies will get used to it,
tomorrow's set of newbies will also find it troubling.

Nothing really prevents you from using branches _locally_ if you want
to, but still keeping separate trees on the _servers_. I just think that
might be a more cunning way forward. But as you correctly point out,
that's just my personal viewpoint.

-- 
dwmw2
