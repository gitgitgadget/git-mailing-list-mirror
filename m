From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Add "clone" support to lntree
Date: Sat, 16 Apr 2005 04:58:44 +0200
Message-ID: <20050416025844.GY7417@pasky.ji.cz>
References: <Pine.LNX.4.21.0504152142360.30848-100000@iabervon.org> <20050416024755.GX7417@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 04:55:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMdSj-0006Rd-7Y
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 04:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbVDPC6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 22:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVDPC6s
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 22:58:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57574 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262589AbVDPC6q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 22:58:46 -0400
Received: (qmail 25855 invoked by uid 2001); 16 Apr 2005 02:58:44 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <20050416024755.GX7417@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 16, 2005 at 04:47:55AM CEST, I got a letter
where Petr Baudis <pasky@ucw.cz> told me that...
> 	git branch --- creates a branch from a given commit
> 			(when passed empty commit, creates a branch
> 			from the current commit and sets the working
> 			tree to that branch)
> Note that there is a bug in current git update - it will allow you to
> bring several of your trees to follow the same branch, or even a remote
> branch. This is not even supposed to work, and will be fixed when I get
> some sleep. You will be able to do git pull even on local branches, and
> the proper solution for this will be just tracking the branch you want
> to follow.

I must admit that I'm not entirely decided yet, so I'd love to hear your
opinion.

I'm wondering, whether each tree should be fixed to a certain branch.
That is, you decide a name when you do git fork, and then the tree
always follows that branch. (It always has to follow [be bound to]
*some* branch, and each branch can be followed by only a single tree at
a time.)

Currently, you can at anytime "mark" a new branch (by git branch) and
you can freely "rebranch" your tree (by git update). An alternative
approach would be to disallow git update to "rebranch" and remove the
git branch command (you'd always do git fork).

 From what I know, the alternative approach is nearer to what BK takes,
and it would be _slightly_ simpler (maybe). OTOH the current approach is
I believe more powerful, and could require less resources.

WWhat do you think,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
