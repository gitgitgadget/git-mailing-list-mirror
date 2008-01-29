From: "Ed S. Peschko" <esp5@pge.com>
Subject: simple cvs-like git wrapper
Date: Tue, 29 Jan 2008 12:40:48 -0800
Message-ID: <20080129204048.GA9612@venus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 22:24:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJxwP-0006DX-Bd
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 22:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbYA2VXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 16:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYA2VXw
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 16:23:52 -0500
Received: from mta06.pge.com ([131.90.0.76]:34432 "EHLO mta06.pge.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774AbYA2VXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 16:23:51 -0500
X-Greylist: delayed 2580 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2008 16:23:51 EST
Received: from mta17.comp.pge.com (mta17.comp.pge.com [10.244.4.52])
	by mta06.pge.com (Switch-3.3.1/Switch-3.2.4) with ESMTP id m0TKenhw004721
	for <git@vger.kernel.org>; Tue, 29 Jan 2008 12:40:50 -0800 (PST)
Received: from mdssdr01.utility.pge.com (mdssdr01.utility.pge.com [10.244.52.48])
	by mta17.comp.pge.com (Switch-3.3.1/Switch-3.3.0) with ESMTP id m0TKemWO010685
	for <git@vger.kernel.org>; Tue, 29 Jan 2008 12:40:48 -0800 (PST)
Received: (from esp5@localhost)
	by mdssdr01.utility.pge.com (8.11.7p3+Sun/8.11.7) id m0TKemO13658
	for git@vger.kernel.org; Tue, 29 Jan 2008 12:40:48 -0800 (PST)
X-Authentication-Warning: mdssdr01.utility.pge.com: esp5 set sender to esp5@pge.com using -f
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71997>

hey all,

We've been trying out git here for a while now, and we've noticed two
things that we both like and dislike: git's flexibility, and git's
flexibility.


Git's flexibility is great in the sense that power users can basically
bend git to their will, but its' flexibility is also causing workflow
issues in our environment, where beginning users can get lost in all 
the options that it has, and this is causing communication issues for 
these folks with the rest of our team.


Hence, I was hoping that people could suggest ways of 
simplifying git, making a cvs-like frontend for people to use. 

I was thinking of something like this:

gvs branch <branch name>: 

	creates a branch for people to start making edits on in their
	localized copy.

gvs commit:

	commits that branch to a centralized git repository.

gvs update:

    Takes the latest changes, from all branches, that everyone 
	else has committed into the centralized git repository, and merges 
	them onto the current branch. 

gvs list:

	lists all the branches that have been merged into the current
	workspace.


In other words, what I'm looking for is sort of 'cvs+'.  Instead of
working on one, synchronized branch as per cvs, we want to work on several,
parallel, branches that synchronize on intervals.

We basically want this for managing related changesets - we want 
to be able to switch from one patch branch to another and commit them
separately - but we don't want to sacrifice the automatic integration
that you get from cvs by doing:

	cvs update

on a given branch.

Anyways, hope this makes sense. I'm not sure how feasible the above is - 
it's meant to be as simple it can be, with as much DWIM-ness as possible.  
Any feedback is appreciated.


Ed

(
ps - We could just use CVS of course, but that's just too simple, 
with no easy way of managing which change goes along with which 
feature request... 
)
