From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Support projects including other projects
Date: Wed, 11 May 2005 22:37:10 -0700
Message-ID: <7v8y2lknsp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505120057250.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 07:30:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW6H6-0006uU-4s
	for gcvg-git@gmane.org; Thu, 12 May 2005 07:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVELFhv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 01:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVELFhv
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 01:37:51 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:55201 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261170AbVELFhi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 01:37:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512053711.MTYL22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 01:37:11 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505120057250.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Thu, 12 May 2005 01:19:13 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> When a particular cogito commit is made, it is impossible to tell whether
DB> the next git-pb will work with it; the current set of patches could be
DB> rejected in mainline git, and different support for the same functionality
DB> added which requires something different from cogito...

 ... Many problems with the approach of saying "this Cogito
     requires this git-pb" omitted here; I agree that alone
     may not solve problems ...

DB> I think your idea is theoretically possible, but that it is just too
DB> impractical...

I do not think it is my idea.  Maybe I misunderstood what you
meant, but here is what you wrote in the message I responded to.

    ... There is a bit of convenience to having the tools magically
    do the right thing when you check out the child project, but the
    thing that really requires tool support is that you need to be
    able to find the version of git-pb which matches the version of
    cogito you're trying to build (and you might be searching the
    history for where a bug was introduced, so you may not be able
    to use the latest of either).

That part is fine.  I already agreed that recording such version
dependency would be a good thing.  I disagreed with the
"solution", however, of having that recorded at the core level:

    The solution is to add a header to commits: "include {hash}",
    which simply says that the given hash, which is from the core
    project, is the commit needed to build this commit of the
    non-core project. This comes from an argument to commit-tree
    ("-I", perhaps), and the parsing code needs to identify the
    reference so that fsck-cache stays happy.

I do not think the issues you are raising are solved by having
that "include {hash}" thing in the commit like you propose here,
instead of keeping it outside of the commit like I suggested.

What I meant to say was just I do not think having this "version
dependency" in the core or outside of the core would make any
difference.

