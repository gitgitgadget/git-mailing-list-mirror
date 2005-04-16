From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Add "clone" support to lntree
Date: Sat, 16 Apr 2005 04:47:55 +0200
Message-ID: <20050416024755.GX7417@pasky.ji.cz>
References: <Pine.LNX.4.21.0504152142360.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 04:44:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMdIO-0005lO-8S
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 04:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVDPCsC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 22:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbVDPCsC
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 22:48:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49382 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262578AbVDPCr5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 22:47:57 -0400
Received: (qmail 24821 invoked by uid 2001); 16 Apr 2005 02:47:55 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504152142360.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 16, 2005 at 03:56:03AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> I often want to take a base tree, which I keep tracking some remote head,
> and make a local working tree that starts from it. This makes "git ln -c
> <dest>" give you a tree that you can just start working in and then diff
> against the head you'd started from and send off.
> 
> Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

I'm sorry but you are late, I added it about a hour and half ago or so.
:-) Check git fork. (I *want* separate command than git lntree. In fact,
I think I should make git lntree gitXlntree.sh instead, since it is
really internal command for git-tools and the user should probably never
need it for anything. git lntree is too lowlevel.)

Actually, I don't like the name at all, though. Some people may find
pondering about names pointless, but when I'm going to type them in
every day for the rest of my life, they better should not be stupid. ;-)

So, what are your clever ideas about git fork's proper name? Or should
we leave it as is?

Summary of current related git commands (yes, they are already around
and should be actually all working):

	git addremote --- registers a remote branch (name - URL pair)
	git branch --- creates a branch from a given commit
			(when passed empty commit, creates a branch
			from the current commit and sets the working
			tree to that branch)
	git clone --- creates a local GIT repository from a remote one
	git export --- checks out given commit to a separate directory
			(without any GIT information)
	git fork --- creates a new branch and working tree from
			the current working tree, sharing the same
			local GIT repository
	git lntree --- creates a "treeshell" sharing the same GIT
			repository with the current tree

If you think any other of those should be renamed, this is the time to
speak up. Oh well, I think I'll regret asking about this at all... ;-)

Note that there is a bug in current git update - it will allow you to
bring several of your trees to follow the same branch, or even a remote
branch. This is not even supposed to work, and will be fixed when I get
some sleep. You will be able to do git pull even on local branches, and
the proper solution for this will be just tracking the branch you want
to follow.

So, I'll fix that tomorrow, enable you to fork to an existing but unused
branch, fix git pull of remote branch by several local branches, and
write a lot of documentation.

Kind regards,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
