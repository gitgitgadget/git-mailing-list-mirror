From: Petr Baudis <pasky@ucw.cz>
Subject: Re: More git pull problems
Date: Tue, 19 Apr 2005 10:35:52 +0200
Message-ID: <20050419083551.GD2393@pasky.ji.cz>
References: <E1DNlmx-00029W-L2@flint.arm.linux.org.uk> <20050419080251.A11988@flint.arm.linux.org.uk> <20050419082341.GC2393@pasky.ji.cz> <20050419093113.D13488@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 10:32:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNo9K-00011S-0s
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 10:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVDSIgD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 04:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVDSIgD
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 04:36:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65209 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261170AbVDSIfx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 04:35:53 -0400
Received: (qmail 5332 invoked by uid 2001); 19 Apr 2005 08:35:52 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050419093113.D13488@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 10:31:13AM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> On Tue, Apr 19, 2005 at 10:23:41AM +0200, Petr Baudis wrote:
> > Dear diary, on Tue, Apr 19, 2005 at 09:02:51AM CEST, I got a letter
> > where Russell King <rmk@arm.linux.org.uk> told me that...
> > > My automatic pull this morning produced the following messages, which
> > > seem to indicate that something's up with git pull now.
> > > 
> > > git-pasky-0.4 (7bef49b5d53218ed3fa8bac291b5515c6479810c)
> > > 
> > > > New branch: 945a2562ee9e632bc6b3399fd49e028c39d19023
> > > > Tracked branch, applying changes...
> > > > Fast-forwarding 945a2562ee9e632bc6b3399fd49e028c39d19023 -> 945a2562ee9e632bc6b3399fd49e028c39d19023
> > > > 	on top of 945a2562ee9e632bc6b3399fd49e028c39d19023...
> > > > gitdiff.sh: trying to diff 67607f05a66e36b2f038c77cfb61350d2110f7e8 against itself
> > 
> > This means nothing more than you pulled your tracked branch for the
> > first time, but before you already had the latest copy; this wouldn't
> > have happened with subsequent pulls, and it was fixed some time ago - it
> > would be really nice if you could try the new pull and merge.
> 
> That's not the case.  This tree has been sitting around for about 6 days
> now, and every day at 7am it gets a git pull.  One thing which did change
> was the version of git installed, which now has this "fast forwarding"
> feature in.

Yes, the way to store this information changed. But by now, it [the
$orig_head which caused the havoc] is completely informational anyway
and git pull is completely rewritten not to need it for the merging
itself; just for the fancy stuff like showing diff-tree.

If I go for the pull/update change (or even if I don't), I might drop
this information anyway; I basically needed it only before merge-base
was around anyway, so that I would know what tree to use as the merge
base.

> Maybe gitmerge.sh should check whether it needs to do anything before
> attempting to do something?

That's the case with the latest git-pasky night version.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
