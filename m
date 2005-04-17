From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [1/5] Parsing code in revision.h
Date: Sun, 17 Apr 2005 15:45:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171531180.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504171221130.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 21:41:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNFeQ-0004Mb-D8
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 21:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVDQTpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 15:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVDQTpe
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 15:45:34 -0400
Received: from iabervon.org ([66.92.72.58]:35846 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261438AbVDQTpT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 15:45:19 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNFi2-0007Ka-00; Sun, 17 Apr 2005 15:45:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171221130.7211@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Linus Torvalds wrote:

> On Sun, 17 Apr 2005, Petr Baudis wrote:
> > 
> > Someone started the avalanche by adding date to the structure. Of
> > course, date is smaller, but it leads people (including me) out of the
> > way.
> 
> Yeah, the naming and the structure comes from "rev-tree.c", so there's a 
> bit of historical baggage already. 
> 
> Anyway, I don't think you should need it. I cleaned up things a bit, and 
> wrote a really simple "merge-base" thing that does base the "best" hit on 
> date, which ends up probably doing the right thing in practice.

Yours reads the whole commit history; I intentionally wrote mine to
only read as far back as turns out to be necessary. I think that looking
at the whole history is going to be impractical when you're trying to
merge in a bunch of patches against the latest release, even if you pull
the history out of a cache. When it's one step on one side and a dozen on
the other, it matters a whole lot if there's a year of history behind the
common ancestor(s).

So I still think it's best to have a non-recursive commit parser, and do
the recursion only as needed for the operation under consideration.

	-Daniel
*This .sig left intentionally blank*

