From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2008, #02; Sun, 14)
Date: Sun, 14 Dec 2008 00:24:54 -0800
Message-ID: <7v7i632mg9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 09:26:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBmJ1-0001yk-Mk
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 09:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbYLNIZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 03:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbYLNIZE
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 03:25:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbYLNIZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 03:25:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D2CAC87E6F;
	Sun, 14 Dec 2008 03:25:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 86EAE87E6E; Sun,
 14 Dec 2008 03:24:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B3317AF8-C9B8-11DD-B241-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103052>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

As we have already passed -rc2, things queued in 'next' let alone 'pu' are
unlikely to be merged to 'master' by the end of year unless otherwise
noted.

----------------------------------------------------------------
[New Topics]

* wp/add-p-goto (Thu Dec 4 10:22:40 2008 +0000) 2 commits
 + Add 'g' command to go to a hunk
 + Add subroutine to display one-line summary of hunks

* jn/gitweb-blame (Thu Dec 11 01:33:29 2008 +0100) 3 commits
 - gitweb: cache $parent_commit info in git_blame()
 - gitweb: A bit of code cleanup in git_blame()
 - gitweb: Move 'lineno' id from link to row element in git_blame

I've briefly looked at the resurrection of Ajaxy blame that comes on top
of this series and it looked promising.

* mv/um-pdf (Wed Dec 10 23:44:50 2008 +0100) 1 commit
 - Add support for a pdf version of the user manual

I do not have a new enough combination of dblatex and asciidoc myself but
this would help interested people.

* np/auto-thread (Sat Dec 13 15:06:40 2008 -0500) 2 commits
 + pack-objects: don't use too many threads with few objects
 + autodetect number of CPUs by default when using threads

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

----------------------------------------------------------------
[Post 1.6.1 items]

* gb/gitweb-patch (Sat Dec 6 16:02:35 2008 +0100) 3 commits
 - gitweb: link to patch(es) view from commit and log views
 - gitweb: add patches view
 - gitweb: add patch view

Updated series.  Reviews and Acks?

* lt/reset-merge (Wed Dec 3 18:00:12 2008 -0800) 2 commits
 + Document "git-reset --merge"
 + Add 'merge' mode to 'git reset'

With updated documents.

* wp/add-patch-find (Thu Nov 27 04:08:03 2008 +0000) 3 commits
 . In add --patch, Handle K,k,J,j slightly more gracefully.
 . Add / command in add --patch
 . git-add -i/-p: Change prompt separater from slash to comma

I am still holding onto this earlier topic to add '/' subcommand to allow
finding a hunk with given text, but I'd rather not merge/rebase it on top
of wp/add-p-goto series myself.  Waiting for a reroll.

* cb/mergetool (Fri Dec 12 21:48:41 2008 +0000) 4 commits
 - mergetool: Don't keep temporary merge files unless told to
 - mergetool: Add prompt to continue after failing to merge a file
 - Add -y/--no-prompt option to mergetool
 - Fix some tab/space inconsistencies in git-mergetool.sh

Updated series.  Waiting for comments from the original author (Ted) and
other interested parties.

----------------------------------------------------------------
[Graduated to "master"]

* jc/rm-i-t-a (Fri Nov 28 19:56:34 2008 -0800) 5 commits
 + git add --intent-to-add: do not let an empty blob be committed by
   accident
 + git add --intent-to-add: fix removal of cached emptiness
 + builtin-rm.c: explain and clarify the "local change" logic
 + Merge branch 'nd/narrow' (early part) into jc/add-i-t-a
 + Extend index to save more flags

As intent-to-add index entry is a new feature for 1.6.1, it probably is a
good idea to merge this to 'master'.  Nitpicks and bugfixes are very much
appreciated.

* jn/gitweb-utf8 (Mon Dec 1 19:01:42 2008 +0100) 1 commit
 + gitweb: Fix handling of non-ASCII characters in inserted HTML
   files.

A bugfix.

----------------------------------------------------------------
[Will merge to "master" soon]

What are you looking for?  We are in -rc ;-)

----------------------------------------------------------------
[On Hold]

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

* ds/uintmax-config (Mon Nov 3 09:14:28 2008 -0900) 1 commit
 - autoconf: Enable threaded delta search when pthreads are supported

Rebased to 'master', that introduced NO_PTHREADS.

* cc/bisect-replace (Mon Nov 24 22:20:30 2008 +0100) 9 commits
 - bisect: add "--no-replace" option to bisect without using replace
   refs
 - rev-list: make it possible to disable replacing using "--no-
   bisect-replace"
 - bisect: use "--bisect-replace" options when checking merge bases
 - merge-base: add "--bisect-replace" option to use fixed up revs
 - commit: add "bisect_replace_all" prototype to "commit.h"
 - rev-list: add "--bisect-replace" to list revisions with fixed up
   history
 - Documentation: add "git bisect replace" documentation
 - bisect: add test cases for "git bisect replace"
 - bisect: add "git bisect replace" subcommand

I really hate the idea of introducing a potentially much more useful
replacement of the existing graft mechanism and tie it very tightly to
bisect, making it unusable from outside.

 (1) I do not think "bisect replace" workflow is a practical and usable
     one;

 (2) The underlying mechanism to express "this object replaces that other
     object" is much easier to work with than what the graft does which is
     "the parents of this commit are these", and idea to use the normal
     ref to point at them means this can potentially be used for
     transferring the graft information across repositories, which the
     current graft mechanism cannot do.

 (3) Because I like the aspect (2) of this series so much, it deeply
     disappoints and troubles me that this is implemented minimally near
     the surface, and that it is controlled by the "bisect" Porcelain
     alone, by explicitly passing command line arguments.

I think a mechanism like this should be added to replace grafts, but it
should always be enabled for normal revision traversal operation, while
always disabled for object enumeration and transfer operation (iow, fsck,
fetch and push should use the real ancestry information recorded in the
underlying objects, while rev-list, log, etc. should always use the
replaced objects).  I have a suspicion that even cat-file could honor it.

* nd/narrow (Sun Nov 30 17:54:38 2008 +0700) 17 commits
 - wt-status: show sparse checkout info
 - Introduce default sparse patterns (core.defaultsparse)
 - checkout: add new options to support sparse checkout
 - clone: support sparse checkout with --sparse-checkout option
 - unpack_trees(): add support for sparse checkout
 - unpack_trees(): keep track of unmerged entries
 - Introduce "sparse patterns"
 - Merge branch 'master' into nd/narrow
 + t2104: touch portability fix
 + grep: skip files outside sparse checkout area
 + checkout_entry(): CE_NO_CHECKOUT on checked out entries.
 + Prevent diff machinery from examining worktree outside sparse
   checkout
 + ls-files: Add tests for --sparse and friends
 + update-index: add --checkout/--no-checkout to update
   CE_NO_CHECKOUT bit
 + update-index: refactor mark_valid() in preparation for new options
 + ls-files: add options to support sparse checkout
 + Introduce CE_NO_CHECKOUT bit

Kicked back to 'on hold' until 1.6.1 final by popular demand; will be
dropped from 'next' (see recent discussion on the interaction between the
checkout area and commands such as "grep").

* jc/clone-symref-2 (Sat Nov 29 23:38:21 2008 -0800) 7 commits
 - clone: test the new HEAD detection logic
 - Merge commit 'HEAD@{2}' into HEAD
 - upload-pack: send the HEAD information
 - clone: find the current branch more explicitly
 - connect.c::read_extra_info(): find where HEAD points at
 - connect.c::read_extra_info(): prepare to receive more than server
   capabilities
 - get_remote_heads(): refactor code to read "server capabilities"

This is no way meant for 1.6.1, let alone next, yet.

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

This seems to have a deadlock during communication between the peers.
Someone needs to pick up this topic and resolve the deadlock before it can
continue.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use,
but gitk will be hit due to tcl/tk's limitation, so I am holding
this back for now.

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer
