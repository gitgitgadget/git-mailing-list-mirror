From: "Neal Kreitzinger" <neal@rsss.com>
Subject: nested git repos (not submodules)
Date: Thu, 9 Feb 2012 20:34:42 -0600
Message-ID: <jh1vo3$7af$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 03:35:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvgKF-0003iC-M8
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 03:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758783Ab2BJCe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 21:34:59 -0500
Received: from plane.gmane.org ([80.91.229.3]:53156 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758089Ab2BJCe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 21:34:58 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RvgK5-0003SG-IW
	for git@vger.kernel.org; Fri, 10 Feb 2012 03:34:53 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 03:34:53 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 03:34:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190372>

In the worktree of a particular git repo, the user has made a subdir 
(worktree/subdir) of the worktree (worktree/.git) its own repo 
(worktree/subdir/.git).  Is there a danger of worktree/.git and 
worktree/subdir/.git crossing wires?  Are literally nested git repos (whose 
worktrees are in turn tracked as subdirs by upper-level git repo(s)) a 
supported/valid model in regards to git.git (NOT git-addons)?

Symptomatically, I have observed the following so far:
(1) worktree/.git is "ignoring" (or unaware of) worktree/subdir/.git because 
it is treating subdir/ as if subdir/.git wasn't there and is not listing 
subdir/.git as untracked.  I'm not sure if this is an unintended side-effect 
of git ignoring .git(s) automatically, or if having subdir/.git's (w/out 
having them defined as submodules) is an expected 
(reasonable/sane/recommended) model for git.git users.
(2) running git commands with pwd=worktree/subdir/ acts upon 
worktree/subdir/.git (subdir/ is regarded as the toplevel of subdir/.git as 
opposed to a subdir of worktree/.git) and is seemingly oblivious to 
worktree.git.

I suspect submodules is the "correct" way to implement the effect of nested 
git repos.  That being said, this literal nested git repo is a temporary 
band-aid and I don't expect it to be propogated, but I do have to deal 
(react) with it in the meantime.  I'm thinking I can manage that and deal 
with annoyances as they arise, unless there are any unseen landmines I'm not 
aware of.  Please advise.

(I also wouldn't be surprised to hear that this is exactly how submodules 
really first started in theory or practice.)

Thanks in advance for any feedback.

v/r,
neal 
