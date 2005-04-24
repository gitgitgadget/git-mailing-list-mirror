From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: unseeking?
Date: Sun, 24 Apr 2005 11:01:16 -0700
Message-ID: <20050424180116.GC11094@tumblerings.org>
References: <20050424160514.GI1507@pasky.ji.cz> <Pine.LNX.4.21.0504241305370.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 19:58:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPlMy-0005M9-LH
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 19:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVDXSDA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 14:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVDXSDA
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 14:03:00 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:34208 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S262357AbVDXSCo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 14:02:44 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DPlPw-0004BK-Ql; Sun, 24 Apr 2005 11:01:16 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504241305370.30848-100000@iabervon.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 24, 2005 at 01:25:35PM -0400, Daniel Barkalow wrote:
> On Sun, 24 Apr 2005, Petr Baudis wrote:
> 
> > Dear diary, on Sun, Apr 24, 2005 at 05:47:54PM CEST, I got a letter
> > where Zack Brown <zbrown@tumblerings.org> told me that...
> 
> > git fork seconddeveloper ../mygitdir
> 
> Doesn't that have to be from the first one to the second one (rather than
> the other way)?

That works a little better for me, but neither really works. If I do

git fork currdir newdir

I get

cat: .git/HEAD: No such file or directory
Invalid id: 
grep: .git/remotes: No such file or directory
/home/zbrown/git/git-pasky-0.6.2/gitfork.sh: line 41: .git/heads/mygitdir: No
such file or directory
cat: .git/HEAD: No such file or directory
Invalid id: 
error: no access to SHA1 file directory
fatal: invalid cache
error: no access to SHA1 file directory
fatal: cache corrupted
Branch mygitdir ready in mygitdir3 with head 

If I cd into mygitdir3, I see a .git directory, but no files. If I do a 'git
pull', it asks me where to pull from, and I don't know what to tell it.

> > > 4) fork, seek, tag, and track are a little mysterious to me. I can guess at what
> > > these things do in general, but the specifics are confusing, and the README is a
> > > little vague.
> > 
> > Try head git*.sh. ;-)
> 
> Which is to say, there are useful comments at the beginnings of the
> scripts. I.e., you really want "head `which gitfork.sh`"

I've looked at the scripts, but I don't find the comments specific enough. For
instance, for gitfork.sh:

# Create a branch sharing the objects database.
# Copyright (c) Petr Baudis, 2005
#
# This script creates a new branch (or revives an unused old branch)
# in a given directory, sharing the same objects database with the
# branch in the current directory, and forking from it at the latest
# commit (in the case of a new branch). You can use the name
# of the branch as an ID in all the other branches sharing the
# objects database.
#
# The new directory has a fresh checkout of the branch.
#
# Takes the desired branch name, its directory name, and potentially
# the head commit ID (for new branch).

I'm sure this is all accurate information, but I'm still unclear about several
points:

1) when I fork directory A into directory B, is A at all different from B
when the fork completes, and if so, how?

2) Are A and B altered by the forking process? i.e., is this an event that is
recorded in the repo, or is it just the equivalent of 'checking out' the repo?

3) What is the significance of a branch 'name'? Is this like a tag?

4) In normal work-flow, when would forks be created, as opposed to other ways
of getting a tree?

Thanks,
Zack

> 
> 	-Daniel
> *This .sig left intentionally blank*
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
