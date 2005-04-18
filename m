From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 22:33:59 +0100
Message-ID: <20050418223359.A16789@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org> <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org> <20050418102332.A21081@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:31:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNdoy-0002U4-KK
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 23:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVDRVeL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 17:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVDRVeL
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 17:34:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42764 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261182AbVDRVeE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 17:34:04 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNdsX-00014v-Ed; Mon, 18 Apr 2005 22:34:01 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNdsV-0005Je-Vd; Mon, 18 Apr 2005 22:34:00 +0100
To: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050418102332.A21081@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Apr 18, 2005 at 10:23:32AM +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2005 at 10:23:32AM +0100, Russell King wrote:
> On Sun, Apr 17, 2005 at 04:24:24PM -0700, Linus Torvalds wrote:
> > On Sun, 17 Apr 2005, Russell King wrote:
> > > I pulled it tonight into a pristine tree (which of course worked.)
> > 
> > Goodie.
> 
> Note the "pristine".  Now comes the real test...
> 
> > > In doing so, I noticed that I'd messed up one of the commits - there's
> > > a missing new file.  Grr.  I'll put that down to being a newbie git.
> > 
> > Actually, you should put that down to horribly bad interface tools.  With
> > BK, we had these nice tools that pointed out that there were files that
> > you might want to commit (ie "bk citool"), and made this very obvious.
> > 
> > Tools absolutely matter. And it will take time for us to build up that 
> > kind of helper infrastructure. So being newbie might be part of it, but 
> > it's the smaller part, I say. Rough interfaces is a big issue.
> 
> Ok, I just tried pulling your tree into the tree you pulled from, and
> got this:
>...

Since this happened, I've been working out what state my tree is in,
and I restored it back to a state where I had one dangling commit head,
which was _my_ head.

I then checked whether my objects matched the objects which I uploaded
to master.kernel.org, and discovered I'd removed some extra ones.  With
them restored, I have an additional dangling commit.

Now, I'm pretty sure that I had an up to date tree when I did the
original commits, so I'm a little confused.

What I'm seeing is:

b4a9a5114b3c6da131a832a8e2cd1941161eb348
+- e7905b2f22eb5d5308c9122b9c06c2d02473dd4f
   +- dc90c0db0dd5214aca5304fd17ccd741031e5493 <-- extra dangling head
   +- 488faba31f59c5960aabbb2a5877a0f2923937a3
      +- 5d9a545981893629c8f95e2b8b50d15d18c6ddbc
         +- d5922e9c35d21f0b6b82d1fd8b1444cfce57ca34
            +- ff219d69be01af1fd04ada305b5fe7cd4c563cc6
               +- df4449813c900973841d0fa5a9e9bc7186956e1e <-- my head

It's very much like I somehow committed against the _parent_ of the
head, rather than the head itself.

However, I've lost the state that this tree was in when I did the initial
commit, so who knows why this happened...  I think it's something to
keep an eye out for though.

-- 
Russell King

