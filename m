From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/10] re-based and expanded tree-walker cleanup patches
Date: Mon, 29 May 2006 15:31:28 -0700
Message-ID: <7virno79a7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 30 00:31:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkqGs-0000nD-L4
	for gcvg-git@gmane.org; Tue, 30 May 2006 00:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWE2Wbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 18:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWE2Wbb
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 18:31:31 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:16303 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751441AbWE2Wba (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 18:31:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060529223129.LIRW18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 May 2006 18:31:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 29 May 2006 12:15:01 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20990>

Linus Torvalds <torvalds@osdl.org> writes:

> Ok, this is largely the same series as the previous 1..4 patches, but 
> rebased on top of the current master tree because the cache-tree patches 
> added some tree_entry_list walkers (which accounts for one extra patch in 
> the series, and some trivial merge fixups).
>
> Two new patches then clean up fsck-objects, which really didn't want the 
> old tree_entry_list at all (and had added some hacks to the list entry 
> just because fsck actually needed to check the raw data).
>
> Another two new patches convert the last remnant of tree_entry_list in 
> revision.c and fetch.c respectively to the new world order.
>
> And the final patch then moves the "tree_entry_list" crud into the only 
> remaining user, namely builtin-read-tree.c. That file is pretty messy and 
> hard to convert, and I don't want to touch it right now, so I left it with 
> the nasty compatibility functions. But now that's at least well-contained.
>
> I think the series is all good, and should replace the old one in "next" 
> (and cook there for a while just to make sure it's ok).

Sorry for having you have done this -- last night I've merged
the series without rebasing and have the result in "next".  I'll
compare to see if you have spotted my mismerges there tonight.

This reminds me of one issue.

        From: Junio C Hamano <junkio@cox.net>
        Subject: Necessity of "evil" merge and topic branches
        Cc: git@vger.kernel.org
        Date: Wed, 17 May 2006 23:25:55 -0700
        Message-ID: <7vy7wz6e8c.fsf@assigned-by-dhcp.cox.net>

I have such an evil-merge branch merged in "next" to deal with
necessarily adjustments; it is 0a2586c, which is the tip of its
own branch.  I was hoping this way I can merge it in to "master"
when I want to pull your yesterday's series.
