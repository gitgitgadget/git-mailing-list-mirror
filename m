From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Mon, 01 Jan 2007 16:07:43 -0800
Message-ID: <7vwt4647g0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 02 01:07:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1XC1-0006W3-1i
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 01:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbXABAHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 19:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbXABAHq
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 19:07:46 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47798 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792AbXABAHp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 19:07:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102000744.KJMP29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Mon, 1 Jan 2007 19:07:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 607y1W00g1kojtg0000000; Mon, 01 Jan 2007 19:07:59 -0500
To: git@vger.kernel.org
X-master-at: f4bf2184ae8b79f95b9f56c1ea5455d04e559299
X-next-at: ab5a14ddd366930434971dece31431687121dba8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35752>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* sp/mmap (Sat Dec 30 22:13:43 2006 -0500) 25 commits
 + Update packedGit config option documentation.
 + mmap: set FD_CLOEXEC for file descriptors we keep open for mmap()
 + pack-objects: fix use of use_pack().
 + Fix random segfaults in pack-objects.
 + Cleanup read_cache_from error handling.
 + Replace mmap with xmmap, better handling MAP_FAILED.
 + Release pack windows before reporting out of memory.
 + Default core.packdGitWindowSize to 1 MiB if NO_MMAP.
 + Test suite for sliding window mmap implementation.
 + Create pack_report() as a debugging aid.
 + Support unmapping windows on 'temporary' packfiles.
 + Improve error message when packfile mmap fails.
 + Ensure core.packedGitWindowSize cannot be less than 2 pages.
 + Load core configuration in git-verify-pack.
 + Fully activate the sliding window pack access.
 + Unmap individual windows rather than entire files.
 + Document why header parsing won't exceed a window.
 + Loop over pack_windows when inflating/accessing data.
 + Replace use_packed_git with window cursors.
 + Refactor how we open pack files to prepare for multiple windows.
 + Create read_or_die utility routine.
 + Use off_t for index and pack file lengths.
 + Refactor packed_git to prepare for sliding mmap windows.
 + Introduce new config option for mmap limit.
 + Replace unpack_entry_gently with unpack_entry.

This is what I was looking at on Cygwin on my wife's box today
(I do not have an easy access to Windows boxes otherwise so my
Cygwin testing is limited to only weekends when I am at home).

* jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
 + git-merge: preserve and merge local changes when doing fast
   forward

Johannes's suggestion to record a tree object instead of
LOCAL_DIFF is roger but not wilco yet --- I haven't thought
through the issue to see an improvement in the suggestion.  We
will be clobbering both index and the working tree, and I think
"diff --binary HEAD" and "write-tree" record the equivalent
amount of information given a HEAD for recovery.

* sp/merge (Sun Dec 31 00:02:13 2006 -0500) 3 commits
 - Refresh the index before starting merge-recursive.
 - Improve merge performance by avoiding in-index merges.
 - Avoid git-fetch in `git-pull .` when possible.

Three patches in the earlier part of this series have graduated
to 'master' as I think they are useful.

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel
* jc/explain (Mon Dec 4 19:35:04 2006 -0800) 1 commit
 - git-explain
* jc/web (Wed Nov 8 14:54:09 2006 -0800) 1 commit
 - gitweb: steal loadavg throttle from kernel.org
* jc/pickaxe (Sun Nov 5 11:52:43 2006 -0800) 1 commit
 - blame: --show-stats for easier optimization work.
* jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700) 1 commit
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch
   (part 2)

These are on hold.
