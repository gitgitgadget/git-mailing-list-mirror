From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Thu, 28 Dec 2006 21:44:38 -0800
Message-ID: <7vtzzfp86x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 29 06:44:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0AXr-0005o1-F9
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 06:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWL2Fok (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 00:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWL2Fok
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 00:44:40 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:45628 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827AbWL2Foj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 00:44:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229054438.WHZR7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Fri, 29 Dec 2006 00:44:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4Vks1W0071kojtg0000000; Fri, 29 Dec 2006 00:44:52 -0500
To: git@vger.kernel.org
X-master-at: eff73751bb94b0241fd2204effb8680fe9973cbf
X-next-at: 3c1f051a8e726067eeef4981fde7b484ba137f2f
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35583>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* sp/merge (Thu Dec 28 02:35:34 2006 -0500) 5 commits
 - Improve merge performance by avoiding in-index merges.
 - Avoid git-fetch in `git-pull .` when possible.
 + Use merge-recursive in git-am -3.
 + Allow merging bare trees in merge-recursive.
 + Move better_branch_name above get_ref in merge-recursive.

Good intentions, very attractive, somewhat disruptive and might
be risky breaking existing users.  I'd like at least the earlier
parts to be in v1.5.0-rc1.

* jc/curl (Wed Dec 27 13:59:26 2006 -0800) 1 commit
 + Work around http-fetch built with cURL 7.16.0

Waiting for an Ack.

* sp/mmap (Wed Dec 27 02:46:23 2006 -0500) 22 commits
 - Fix random segfaults in pack-objects.
 - Cleanup read_cache_from error handling.
 - Replace mmap with xmmap, better handling MAP_FAILED.
 - Release pack windows before reporting out of memory.
 - Default core.packdGitWindowSize to 1 MiB if NO_MMAP.
 - Test suite for sliding window mmap implementation.
 - Create pack_report() as a debugging aid.
 - Support unmapping windows on 'temporary' packfiles.
 - Improve error message when packfile mmap fails.
 - Ensure core.packedGitWindowSize cannot be less than 2 pages.
 - Load core configuration in git-verify-pack.
 - Fully activate the sliding window pack access.
 - Unmap individual windows rather than entire files.
 - Document why header parsing won't exceed a window.
 - Loop over pack_windows when inflating/accessing data.
 - Replace use_packed_git with window cursors.
 - Refactor how we open pack files to prepare for multiple windows.
 - Create read_or_die utility routine.
 - Use off_t for index and pack file lengths.
 - Refactor packed_git to prepare for sliding mmap windows.
 - Introduce new config option for mmap limit.
 - Replace unpack_entry_gently with unpack_entry.

Known breakage exists that this series is highly suspected.
Will diagnose and merge to 'next' after fixing.

* jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700) 1 commit
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch
   (part 2)

I promised this to wait until February.  Most likely to be in
v1.5.1.   

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

These are on hold or will not be merged ever.
