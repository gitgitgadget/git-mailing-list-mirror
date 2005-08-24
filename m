From: Junio C Hamano <junkio@cox.net>
Subject: Re: Automatic merge failed, fix up by hand
Date: Tue, 23 Aug 2005 20:52:51 -0700
Message-ID: <7vhddgj8j0.fsf@assigned-by-dhcp.cox.net>
References: <1124831571.13042.27.camel@firebird.lenb.worldpath.net>
	<7vhddgnw9q.fsf@assigned-by-dhcp.cox.net>
	<1124836282.14730.4.camel@toshiba>
	<7vzmr8mci2.fsf@assigned-by-dhcp.cox.net>
	<7vek8kmb2a.fsf@assigned-by-dhcp.cox.net>
	<7v3bp0m9ax.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508231823420.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Len Brown <len.brown@intel.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 05:53:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7mKC-0002oe-3S
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 05:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbVHXDxE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 23:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVHXDxE
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 23:53:04 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38392 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750970AbVHXDxC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 23:53:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050824035255.UXAQ25443.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 23:52:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508231823420.3317@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 23 Aug 2005 18:28:33 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7702>

Linus Torvalds <torvalds@osdl.org> writes:

> Ok, I think your approach is the correct one. Just list all the commits, 
> and let the merge logic figure out which one is the best one.
>
> Just returning several entries is the correct thing to do, because then
> you can make the distance function be based on the tree diffs, like you
> do. That's _much_ better than trying to make the distance be based on some
> topology.
>
> So I append this patch just as a historical curiosity. Junio's patch is 
> clearly superior.
>
> 		Linus

Of course it is clearly superior, because it is not _my_ patch
but *yours*.

I just did what you earlier told the world how things should
work, based on this message:

    Date:	Mon, 11 Apr 2005 16:48:25 -0700 (PDT)
    From:	Linus Torvalds <torvalds@osdl.org>
    Subject: Re: git: patch for parent-id and idea for merge
    Message-ID: <Pine.LNX.4.58.0504111631360.1267@ppc970.osdl.org>

    Btw, I've changed the semantics of "rev-tree" once again.
    ...
    In other words, it will give you a way to figure out which changeset to
    use as the common one. It's always going to be a parent of one of these
    edge-commits that has all of its reachability bits set. Which one.. Now
    that's the question. Maybe just the most recent one, or maybe actually use
    "diff-tree" to see which one generates the fewest conflicts.
