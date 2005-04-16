From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Re: Add "clone" support to lntree
Date: Fri, 15 Apr 2005 23:17:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504152307050.30848-100000@iabervon.org>
References: <20050416025844.GY7417@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 05:13:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMdk2-0007UJ-W5
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 05:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVDPDQm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 23:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVDPDQm
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 23:16:42 -0400
Received: from iabervon.org ([66.92.72.58]:20997 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262605AbVDPDQj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 23:16:39 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMdno-0005Bz-00; Fri, 15 Apr 2005 23:17:00 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050416025844.GY7417@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Apr 2005, Petr Baudis wrote:

> Dear diary, on Sat, Apr 16, 2005 at 04:47:55AM CEST, I got a letter
> where Petr Baudis <pasky@ucw.cz> told me that...
> > 	git branch --- creates a branch from a given commit
> > 			(when passed empty commit, creates a branch
> > 			from the current commit and sets the working
> > 			tree to that branch)
> > Note that there is a bug in current git update - it will allow you to
> > bring several of your trees to follow the same branch, or even a remote
> > branch. This is not even supposed to work, and will be fixed when I get
> > some sleep. You will be able to do git pull even on local branches, and
> > the proper solution for this will be just tracking the branch you want
> > to follow.
> 
> I must admit that I'm not entirely decided yet, so I'd love to hear your
> opinion.
> 
> I'm wondering, whether each tree should be fixed to a certain branch.
> That is, you decide a name when you do git fork, and then the tree
> always follows that branch. (It always has to follow [be bound to]
> *some* branch, and each branch can be followed by only a single tree at
> a time.)

I don't think I'm following the use of branches. Currently, what I do is
have a git-pasky and a git-linus, and fork off a working directory from
one of these for each thing I want to work on. I do some work, commit as I
make progress, and then do a diff against the remote head to get a patch
to send off. If I want to do a series of patches which depend on each
other, I fork my next directory off of my previous one rather than off of
a remote base. I haven't done much rebasing, so I haven't worked out how I
would do that most effectively.

I think I can make this space efficient by hardlinking unmodified blobs to
a directory of cached expanded blobs.

	-Daniel
*This .sig left intentionally blank*

