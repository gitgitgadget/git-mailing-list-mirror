From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2011, #05; Sun, 31)
Date: Sun, 31 Jul 2011 20:36:18 -0700
Message-ID: <7vd3gpkdl9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 05:54:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnjaE-0004hk-Mz
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 05:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab1HADgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 23:36:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41609 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926Ab1HADgV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 23:36:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 967FD5FD3;
	Sun, 31 Jul 2011 23:36:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=E
	DRCBt+PoiXmqMeMoR0CNDfGwzU=; b=FsXzqCLnAVNT/YjRDhKanmqsNeYeLj343
	f7WmKafWVfpS6iT5YGvz1X6/G/lznzkFUklnKK5dFv/ErjUay0FDbFABnIm33bCZ
	UiIWY4EBA9tLlEcIYA2g4G60CIukS3SfO/EPk8fFAKOZ3jGa+zw2OkQsJTEyO00y
	b9CzBPAx/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Ylk
	rGCUte8NQl1MbmADugvYRjxufITb/STUO7u/1fYibsLBS5EVfhTMH+CnpDJyCFDD
	KPsdULWOP4urBHut2jPs0o6qnha9PkKpFV+qrln2uaTdVhV17J4DRoRu79gEYA9o
	nVr+TcdB1G5mzHwFkXIYFsTg9wTlNbx/2kiqS6No=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D5EE5FD2;
	Sun, 31 Jul 2011 23:36:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC8055FD1; Sun, 31 Jul 2011
 23:36:19 -0400 (EDT)
X-master-at: b35acb53458d0f99ba2400b902980b35e5acc2d3
X-next-at: ec3e38edaac75ed4160d114e62c74b1d1d55c320
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B8E1572-BBEF-11E0-A8C4-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178304>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

--------------------------------------------------
[New Topics]

* cb/maint-exec-error-report (2011-07-31) 1 commit
 - error_routine: use parent's stderr if exec fails

* cb/maint-quiet-push (2011-07-31) 1 commit
 - propagate --quiet to send-pack/receive-pack

* jl/submodule-update-quiet (2011-07-28) 1 commit
 - submodule: update and add must honor --quiet flag

* jn/gitweb-config-list-case (2011-07-31) 1 commit
 - gitweb: Git config keys are case insensitive, make config search too

--------------------------------------------------
[Stalled]

* nk/branch-v-abbrev (2011-07-01) 1 commit
 - branch -v: honor core.abbrev

Perhaps needs an updated commit log message?

* di/fast-import-doc (2011-07-13) 2 commits
 - doc/fast-import: document feature import-marks-if-exists
 - doc/fast-import: clarify notemodify command

Comments from fast-import folks?

* jh/receive-count-limit (2011-05-23) 10 commits
 - receive-pack: Allow server to refuse pushes with too many objects
 - pack-objects: Estimate pack size; abort early if pack size limit is exceeded
 - send-pack/receive-pack: Allow server to refuse pushing too large packs
 - pack-objects: Allow --max-pack-size to be used together with --stdout
 - send-pack/receive-pack: Allow server to refuse pushes with too many commits
 - pack-objects: Teach new option --max-commit-count, limiting #commits in pack
 - receive-pack: Prepare for addition of the new 'limit-*' family of capabilities
 - Tighten rules for matching server capabilities in server_supports()
 - send-pack: Attempt to retrieve remote status even if pack-objects fails
 - Update technical docs to reflect side-band-64k capability in receive-pack

Would need another round to separate per-pack and per-session limits.

* jm/mergetool-pathspec (2011-06-22) 2 commits
 - mergetool: Don't assume paths are unmerged
 - mergetool: Add tests for filename with whitespace

I think this is a good idea, but it probably needs a re-roll.
Cf. $gmane/176254, 176255, 166256

* jk/generation-numbers (2011-07-14) 7 commits
 - limit "contains" traversals based on commit generation
 - check commit generation cache validity against grafts
 - pretty: support %G to show the generation number of a commit
 - commit: add commit_generation function
 - add metadata-cache infrastructure
 - decorate: allow storing values instead of pointers
 - Merge branch 'jk/tag-contains-ab' (early part) into HEAD

The initial "tag --contains" de-pessimization without need for generation
numbers is already in; backburnered.

--------------------------------------------------
[Cooking]

* jc/streaming-filter (2011-07-22) 1 commit
  (merged to 'next' on 2011-07-22 at 2081cd7)
 + streaming: free git_istream upon closing

A large leak found and plugged.
Will merge to "master".

* jn/gitweb-system-config (2011-07-24) 1 commit
 - gitweb: Introduce common system-wide settings for convenience

Will merge to "next".

* js/ls-tree-error (2011-07-25) 2 commits
 - Ensure git ls-tree exits with a non-zero exit code if read_tree_recursive fails.
 - Add a test to check that git ls-tree sets non-zero exit code on error.

Will merge to "next".

* jc/merge-reword (2011-05-25) 2 commits
 - merge: mark the final "Merge made by..." message for l10n
 - merge: reword the final message

Probably the topmost commit should be dropped.

* jk/reset-reflog-message-fix (2011-07-22) 1 commit
 - reset: give better reflog messages

Will merge to "next".

* jk/add-i-hunk-filter (2011-07-27) 5 commits
 - add--interactive: add option to autosplit hunks
 - add--interactive: allow negatation of hunk filters
 - add--interactive: allow hunk filtering on command line
 - add--interactive: factor out regex error handling
 - add--interactive: refactor patch mode argument processing

* mh/check-attr-listing (2011-07-27) 19 commits
 - Rename struct git_attr_check to git_attr_value
 - git-check-attr: Fix command-line handling to match docs
 - git-check-attr: Drive two tests using the same raw data
 - git-check-attr: Add an --all option to show all attributes
 - git-check-attr: Error out if no pathnames are specified
 - git-check-attr: Process command-line args more systematically
 - git-check-attr: Handle each error separately
 - git-check-attr: Extract a function error_with_usage()
 - git-check-attr: Introduce a new variable
 - git-check-attr: Extract a function output_attr()
 - Allow querying all attributes on a file
 - git-check-attr: Use git_attr_name()
 - Provide access to the name attribute of git_attr
 - git-check-attr: Add tests of command-line parsing
 - git-check-attr: Add missing "&&"
 - Disallow the empty string as an attribute name
 - Remove anachronism from comment
 - doc: Correct git_attr() calls in example code
 - doc: Add a link from gitattributes(5) to git-check-attr(1)

Need to replace this with a more recent reroll.

* jc/maint-reset-unmerged-path (2011-07-13) 1 commit
  (merged to 'next' on 2011-07-19 at bbc2d54)
 + reset [<commit>] paths...: do not mishandle unmerged paths
 (this branch is used by jc/diff-index-refactor.)

Will merge to "master".

* jc/diff-index-refactor (2011-07-13) 2 commits
 - diff-lib: refactor run_diff_index() and do_diff_cache()
 - diff-lib: simplify do_diff_cache()
 (this branch uses jc/maint-reset-unmerged-path.)

Will merge to "next".

* sr/transport-helper-fix-rfc (2011-07-19) 2 commits
 - t5800: point out that deleting branches does not work
 - t5800: document inability to push new branch with old content
 (this branch uses sr/transport-helper-fix.)

* vi/make-test-vector-less-specific (2011-07-19) 1 commit
  (merged to 'next' on 2011-07-25 at 1973192)
 + tests: cleanup binary test vector files

Will merge to "master".

* jk/http-auth-keyring (2011-07-21) 14 commits
 - credentials: add "getpass" helper
 - credentials: add "store" helper
 - credentials: add "cache" helper
 - docs: end-user documentation for the credential subsystem
 - http: use hostname in credential description
 - allow the user to configure credential helpers
 - look for credentials in config before prompting
 - http: use credential API to get passwords
 - fixup! introduce credentials API
 - introduce credentials API
 - http: retry authentication failures for all http requests
 - remote-curl: don't retry auth failures with dumb protocol
 - improve httpd auth tests
 - url: decode buffers that are not NUL-terminated

Looked mostly reasonable except for the limitation that it is not clear
how to deal with a site at which a user needs to use different passwords 
for different repositories.

* tc/minix (2011-07-20) 1 commit
  (merged to 'next' on 2011-07-25 at 36ad29f)
 + Makefile: add Minix configuration options.

* sr/transport-helper-fix (2011-07-19) 21 commits
  (merged to 'next' on 2011-07-19 at e1ef414)
 + transport-helper: die early on encountering deleted refs
 + transport-helper: implement marks location as capability
 + transport-helper: Use capname for refspec capability too
 + transport-helper: change import semantics
 + transport-helper: update ref status after push with export
 + transport-helper: use the new done feature where possible
 + transport-helper: check status code of finish_command
 + transport-helper: factor out push_update_refs_status
 + fast-export: support done feature
 + fast-import: introduce 'done' command
 + git-remote-testgit: fix error handling
 + git-remote-testgit: only push for non-local repositories
 + remote-curl: accept empty line as terminator
 + remote-helpers: export GIT_DIR variable to helpers
 + git_remote_helpers: push all refs during a non-local export
 + transport-helper: don't feed bogus refs to export push
 + git-remote-testgit: import non-HEAD refs
 + t5800: document some non-functional parts of remote helpers
 + t5800: use skip_all instead of prereq
 + t5800: factor out some ref tests
 + transport-helper: fix minor leak in push_refs_with_export
 (this branch is used by sr/transport-helper-fix-rfc.)

Will merge to "master".

* jk/clone-detached (2011-06-07) 4 commits
  (merged to 'next' on 2011-07-25 at 013d7d0)
 + clone: always fetch remote HEAD
 + make copy_ref globally available
 + consider only branches in guess_remote_head
 + t: add tests for cloning remotes with detached HEAD

Will merge to "master".

* jc/pack-order-tweak (2011-07-08) 2 commits
  (merged to 'next' on 2011-07-25 at 1460c31)
 + pack-objects: optimize "recency order"
 + core: log offset pack data accesses happened

* js/ref-namespaces (2011-07-21) 5 commits
  (merged to 'next' on 2011-07-25 at 5b7dcfe)
 + ref namespaces: tests
 + ref namespaces: documentation
 + ref namespaces: Support remote repositories via upload-pack and receive-pack
 + ref namespaces: infrastructure
 + Fix prefix handling in ref iteration functions

* rc/histogram-diff (2011-07-12) 7 commits
  (merged to 'next' on 2011-07-25 at 3351028)
 + xdiff/xprepare: use a smaller sample size for histogram diff
 + xdiff/xprepare: skip classification
 + teach --histogram to diff
 + t4033-diff-patience: factor out tests
 + xdiff/xpatience: factor out fall-back-diff function
 + xdiff/xprepare: refactor abort cleanups
 + xdiff/xprepare: use memset()

* rr/revert-cherry-pick-continue (2011-07-27) 18 commits
 - revert: Introduce --continue to continue the operation
 - revert: Don't implictly stomp pending sequencer operation
 - revert: Remove sequencer state when no commits are pending
 - reset: Make reset remove the sequencer state
 - revert: Introduce --reset to remove sequencer state
 - revert: Make pick_commits functionally act on a commit list
 - revert: Save command-line options for continuing operation
 - revert: Save data for continuing after conflict resolution
 - revert: Don't create invalid replay_opts in parse_args
 - revert: Separate cmdline parsing from functional code
 - revert: Introduce struct to keep command-line options
 - revert: Eliminate global "commit" variable
 - revert: Propogate errors upwards from do_pick_commit
 - revert: Rename no_replay to record_origin
 - revert: Don't check lone argument in get_encoding
 - revert: Simplify and inline add_message_to_msg
 - config: Introduce functions to write non-standard file
 - advice: Introduce error_resolve_conflict

Need to replace this with a more recent reroll.

* en/merge-recursive (2011-07-14) 50 commits
 - fixup! Do not assume that qsort is stable
 - t3030: fix accidental success in symlink rename
 - merge-recursive: Fix working copy handling for rename/rename/add/add
 - merge-recursive: add handling for rename/rename/add-dest/add-dest
 - merge-recursive: Have conflict_rename_delete reuse modify/delete code
 - merge-recursive: Make modify/delete handling code reusable
 - merge-recursive: Consider modifications in rename/rename(2to1) conflicts
 - merge-recursive: Create function for merging with branchname:file markers
 - merge-recursive: Record more data needed for merging with dual renames
 - merge-recursive: Defer rename/rename(2to1) handling until process_entry
 - merge-recursive: Small cleanups for conflict_rename_rename_1to2
 - merge-recursive: Fix rename/rename(1to2) resolution for virtual merge base
 - merge-recursive: Introduce a merge_file convenience function
 - merge-recursive: Fix modify/delete resolution in the recursive case
 - merge-recursive: Provide more info in conflict markers with file renames
 - merge-recursive: Cleanup and consolidation of rename_conflict_info
 - merge-recursive: Consolidate process_entry() and process_df_entry()
 - merge-recursive: Improve handling of rename target vs. directory addition
 - merge-recursive: Add comments about handling rename/add-source cases
 - merge-recursive: Make dead code for rename/rename(2to1) conflicts undead
 - merge-recursive: Fix deletion of untracked file in rename/delete conflicts
 - merge-recursive: When we detect we can skip an update, actually skip it
 - merge-recursive: Split update_stages_and_entry; only update stages at end
 - merge-recursive: Consolidate different update_stages functions
 - merge-recursive: Allow make_room_for_path() to remove D/F entries
 - merge-recursive: Split was_tracked() out of would_lose_untracked()
 - merge-recursive: Save D/F conflict filenames instead of unlinking them
 - merge-recursive: Fix code checking for D/F conflicts still being present
 - merge-recursive: Fix sorting order and directory change assumptions
 - merge-recursive: Fix recursive case with D/F conflict via add/add conflict
 - merge-recursive: Avoid working directory changes during recursive case
 - merge-recursive: Remember to free generated unique path names
 - merge-recursive: Mark some diff_filespec struct arguments const
 - merge-recursive: Correct a comment
 - merge-recursive: Make BUG message more legible by adding a newline
 - t6022: Add testcase for merging a renamed file with a simple change
 - t6022: New tests checking for unnecessary updates of files
 - t6022: Remove unnecessary untracked files to make test cleaner
 - t6036: criss-cross + rename/rename(1to2)/add-source + modify/modify
 - t6036: criss-cross w/ rename/rename(1to2)/modify+rename/rename(2to1)/modify
 - t6036: tests for criss-cross merges with various directory/file conflicts
 - t6036: criss-cross with weird content can fool git into clean merge
 - t6036: Add differently resolved modify/delete conflict in criss-cross test
 - t6042: Ensure rename/rename conflicts leave index and workdir in sane state
 - t6042: Add failing testcases for rename/rename/add-{source,dest} conflicts
 - t6042: Add tests for content issues with modify/rename/directory conflicts
 - t6042: Add a testcase where undetected rename causes silent file deletion
 - t6042: Add a pair of cases where undetected renames cause issues
 - t6042: Add failing testcase for rename/modify/add-source conflict
 - t6042: Add a testcase where git deletes an untracked file

Looked at up to 38/48; looks basically sound.
