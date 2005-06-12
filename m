From: David Roundy <droundy@abridgegame.org>
Subject: Re: [OT] mutually supervised developers
Date: Sun, 12 Jun 2005 07:47:49 -0400
Message-ID: <20050612114745.GA9670@abridgegame.org>
References: <7vy89gsiak.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506111612140.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>, darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Sun Jun 12 13:48:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhQxJ-0007m1-KT
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 13:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVFLLxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 07:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVFLLxU
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 07:53:20 -0400
Received: from user-10bj72p.cable.mindspring.com ([64.185.156.89]:5415 "EHLO
	localhost") by vger.kernel.org with ESMTP id S262308AbVFLLxR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2005 07:53:17 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DhQwQ-0002WB-1C; Sun, 12 Jun 2005 07:47:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>, darcs-devel@darcs.net
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506111612140.2286@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 11, 2005 at 04:14:38PM -0700, Linus Torvalds wrote:
> On Sat, 11 Jun 2005, Junio C Hamano wrote:
> > 
> > I am wondering if the world would be a better place if this
> > fictitious project sets up public repositories in the following
> > way:
> > 
> >  (1) each developer's own repository is public;
> > 
> >  (2) these developers pull from each other "only good stuff",
> >      rejecting things he or she feels questionable.  Let's
> >      forget that current GIT does not give a direct support for
> >      cherrypicking for now.
> > 
> >  (3) the public canonical repository is updated to contain the
> >      intersection (_not_ union) of these developer repositories.
> >      Let's also forget that current GIT does not have automated
> >      way to do such a thing.
> 
> I've thought about it, but one problem ends up being the history.
> 
> Even if both developers have the same patches, they may not have gotten
> them in the same order, which means that it's basically impossible to
> retain history when doign an intersection. Unions are different - we can
> just add the new history when we create a union.

Right, cherry picking and history don't go well together--which is why
darcs doesn't normally store a real history (although it can do so--you
just can't keep certain portions of the history unless you accept the
patches involved).

There are also issues in defining the intersection of all patches.  Ideally
if you take the union of that intersection with one of the original
repositories, you'd get that same repository back, but most naive
implementations of union/intersection won't have that property, which would
lead to confusion and inconvenience.

This sort of workflow would actually be pretty easy to implement in darcs,
if someone were interested.

On Sat, 11 Jun 2005, Junio C Hamano wrote:
> Would people find something like this arrangement workable and
> worthwhile?

I think the biggest issue would be the one mentioned about the problems
with a single lazy developer.  But I think rather than some sort of
majority rule (or "if three developers think it's okay, then it's okay"),
keeping the number of relevant developers down would make sense.  This also
makes sense in that unless you've got seriously dedicated developers, you
don't want to force everyone to read every patch.  I think if you went with
a system like this and wanted many maintainers involved, it would probably
best to organize things hierarchically.
-- 
David Roundy
http://www.darcs.net
