From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Sun, 04 Feb 2007 01:35:50 -0800
Message-ID: <7vwt2ytgcp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 10:35:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDdmv-0007K1-DW
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 10:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbXBDJfw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 04:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbXBDJfw
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 04:35:52 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:33332 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752185AbXBDJfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 04:35:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204093551.FRVG4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 04:35:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KMbq1W00G1kojtg0000000; Sun, 04 Feb 2007 04:35:51 -0500
X-master-at: ec8048913217d8ff6e54950a0cb8ab2e739a1d1f
X-next-at: 79b8f6b583d63fcaea57bae19609e2a2b651a570
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38671>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* np/dreflog (Sat Feb 3 23:31:47 2007 -0800) 12 commits
 + show-branch -g: default to the current branch.
 + Let git-checkout always drop any detached head
 + Enable HEAD@{...} and make it independent from the current branch
 + scan reflogs independently from refs
 + add reflog when moving HEAD to a new branch
 + create_symref(): do not assume pathname from git_path() persists
   long enough
 + add logref support to git-symbolic-ref
 + move create_symref() past log_ref_write()
 + add reflog entries for HEAD when detached
 + enable separate reflog for HEAD
 + lock_ref_sha1_basic(): remember the original name of a ref when
   resolving it
 + make reflog filename independent from struct ref_lock

Earlier I predicted that this will not stabilize before 1.5.0
happens, but I was wrong.  I'd like to have this in 1.5.0.  Will
merge to 'master' soon.

Big thanks to Nico.

* ml/gitk (Thu Feb 1 08:46:38 2007 -0500) 2 commits
 - Make gitk work reasonably well on Cygwin.
 - gitk - remove trailing whitespace from a few lines.

Waiting for Paul's blessing, but I might just go ahead and apply
them to my tree before 1.5.0 happens.

* jc/blame (Tue Jan 30 01:11:08 2007 -0800) 1 commit
 - git-blame: no rev means start from the working tree file.

This changes the semantics of "git blame" without the revision
parameter.  It does not annotate HEAD version but annotates the
working tree changes as well.  Since it is a behaviour change,
it might make sense to have it in 1.5.0 if we ever want to do
this.

All the rest are outside of the scope of 1.5.0 and are on hold.

* js/reverse (Sat Jan 20 23:04:02 2007 +0100) 1 commit
 + Teach revision machinery about --reverse
* jc/fetch (Tue Jan 16 13:43:28 2007 -0800) 5 commits
 - git-fetch: rewrite expand_ref_wildcard in C
 - git-fetch: rewrite another shell loop in C
 - git-fetch: move more code into C.
 - git-fetch--tool: start rewriting parts of git-fetch in C.
 - git-fetch: split fetch_main into fetch_dumb and fetch_native
* jc/merge-base (Tue Jan 9 01:32:25 2007 -0800) 4 commits
 + in_merge_bases(): optimization
 + merge_base(): move traversal into a separate function.
 + Allow in_merge_bases() to take more than one reference commits.
 + Make merge-base a built-in.
* sp/merge (Thu Dec 28 02:35:17 2006 -0500) 1 commit
 - Avoid git-fetch in `git-pull .` when possible.
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel
* jc/explain (Mon Dec 4 19:35:04 2006 -0800) 1 commit
 - git-explain
* jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
 + git-merge: preserve and merge local changes when doing fast
   forward
* jc/web (Wed Nov 8 14:54:09 2006 -0800) 1 commit
 - gitweb: steal loadavg throttle from kernel.org
* jc/pickaxe (Sun Nov 5 11:52:43 2006 -0800) 1 commit
 - blame: --show-stats for easier optimization work.
* jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700) 1 commit
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch
   (part 2)
