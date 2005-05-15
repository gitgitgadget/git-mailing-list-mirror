From: Petr Baudis <pasky@ucw.cz>
Subject: Re: README rewrite
Date: Sun, 15 May 2005 19:28:03 +0200
Message-ID: <20050515172802.GH13024@pasky.ji.cz>
References: <20050515044244.GA7391@tumblerings.org> <20050515044941.GB7391@tumblerings.org> <4286F146.2090302@saville.com> <42876B30.1070404@saville.com> <20050515154041.GD7391@tumblerings.org> <20050515155315.GE7391@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wink Saville <wink@saville.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 19:28:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXMuK-00046E-8D
	for gcvg-git@gmane.org; Sun, 15 May 2005 19:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVEOR2N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 13:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVEOR2N
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 13:28:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15285 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261161AbVEOR2I (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 13:28:08 -0400
Received: (qmail 12810 invoked by uid 2001); 15 May 2005 17:28:03 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050515155315.GE7391@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 15, 2005 at 05:53:15PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> On Sun, May 15, 2005 at 08:40:41AM -0700, Zack Brown wrote:
> > This much I think I understand. What I don't understand is how to actually use
> > branches. I don't see a Cogito command to create or destroy them.
> 
> Or I'm blind. The cg-branch-add command is right there. It also has a long
> comment at the top of the script. Unfortunately the comment only describes how
> to use the command, not what exactly branches are or how to work with them.
> 
> Clearly 'branches' are diverging branches of development. But if I have my
> own tree, with several branches in it, it's unclear to me how to specify
> which branch I'm actually working on at any given moment.

I think it's actually very BKish. Each repository has its own "master"
branch, which always corresponds with your current branch of
development. That is, your working tree is always represented by the
"master" branch.

The rest of branches are "remote", that is they just point at the other
repositories. When you want to get the new changes from them, you
cg-pull, or cg-update to merge them to your branch too.

So if you want to create a new branch, you cg-clone the original branch.
And if you want to refer to the new branch in any other branch, you
cg-branch-add it in the other branch.

So the local branch is the "master" branch, the rest are "remote"
branches. Note that there is a theoretical support for multiple local
branches, but I decided not to make things even more confusing and there
is no Cogito interface for managing them now.

I will add cg-switch which will switch the master branch to some other
branch (e.g. cg-switch linus will rename your current master to
master-1234 or something, update your "origin" branch to point to the
"linus" branch, and make your "master" branch to point at the same
commit as the "origin" branch). I might also do something like
cg-branch-add --local, which will add a local branch and you could then
cg-switch to it too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
