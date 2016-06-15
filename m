From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2011, #07; Wed, 24)
Date: Wed, 24 Aug 2011 17:09:09 -0700
Message-ID: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 02:09:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwNVY-0008GG-6X
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 02:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab1HYAJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 20:09:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915Ab1HYAJN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 20:09:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 747DF42D8;
	Wed, 24 Aug 2011 20:09:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	igFpaeRPcmZOcZKi4eNDjJfLbM=; b=CNA40FfsqDpthVYTgR5bDqN4zcbwj/J3E
	aE1kQX8I2tpkJY8lVdFxGr662hma4oFxUrSW8bF6TLt7mPvE6TB9UYJc0/+KhJno
	vkUV+e44fZ4oITBkJLaDStqxFsm+Zd9kvEw4Tk89v1vYcg7NAuOJyO7Nkyw+0W/x
	aiET3Z0QN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=e4b
	N4UCmR5zhp5tgSmwID0Kcu6phrplzZTPNsVdq2Jg3Wih9qcZaXawXr4yZ5Pe0fi5
	ANCI1X1ZQO+ZL1OOKjTdOB43TXyXMydjpyi4INf7AWaAcHChs3wtF0sQC28ei5Ro
	4B7IPXSZfEaDF2P3BQY+oGEQCne5U3GHcydqMehk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A76742D7;
	Wed, 24 Aug 2011 20:09:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D1C742D3; Wed, 24 Aug 2011
 20:09:11 -0400 (EDT)
X-master-at: b7fcd007153b5021ed70ddc0a224127f14601bbc
X-next-at: aa5cf7ba43e1b74c3a0aae0ca2989879d9a46233
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7574350E-CEAE-11E0-BF35-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180054>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

I've sifted topics to the ones meant for 1.7.7 and the others that I'd
prefer to cook a bit longer in "next" during the upcoming feature freeze,
which should happen by the end of the week.

Please help us make the upcoming release as solid as we could. Thanks.

--------------------------------------------------
[Stalled]

* jk/add-i-hunk-filter (2011-07-27) 5 commits
  (merged to 'next' on 2011-08-11 at 8ff9a56)
 + add--interactive: add option to autosplit hunks
 + add--interactive: allow negatation of hunk filters
 + add--interactive: allow hunk filtering on command line
 + add--interactive: factor out regex error handling
 + add--interactive: refactor patch mode argument processing

Needs documentation updates.

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

* sr/transport-helper-fix-rfc (2011-07-19) 2 commits
 - t5800: point out that deleting branches does not work
 - t5800: document inability to push new branch with old content

* po/cygwin-backslash (2011-08-05) 2 commits
 - On Cygwin support both UNIX and DOS style path-names
 - git-compat-util: add generic find_last_dir_sep that respects is_dir_sep

I think a further refactoring (no, not my suggestion) was offered?

--------------------------------------------------
[Cooking]

* jc/merge-reword (2011-05-25) 1 commit
  (merged to 'next' on 2011-08-24 at aa5cf7b)
 + merge: reword the final message

Will merge to "master".

* nk/branch-v-abbrev (2011-07-01) 1 commit
  (merged to 'next' on 2011-08-24 at e9152cf)
 + branch -v: honor core.abbrev

Will merge to "master".

* jk/pager-with-external-command (2011-08-19) 1 commit
  (merged to 'next' on 2011-08-24 at 083f5da)
 + support pager.* for external commands
 (this branch is used by jk/pager-with-alias and jk/pager-with-alias; uses jk/color-and-pager.)

Up to this part (but not "alias") the topic looked unconditionally a good
thing to do.

Will aim to merge to "master" by -rc1.

* fk/use-kwset-pickaxe-grep-f (2011-08-20) 5 commits
  (merged to 'next' on 2011-08-23 at 93ba509)
 + Use kwset in grep
 + Use kwset in pickaxe
 + Adapt the kwset code to Git
 + Add string search routines from GNU grep
 + Add obstack.[ch] from EGLIBC 2.10

Will aim to merge to "master" by -rc1.

* jc/maint-autofix-tag-in-head (2011-08-19) 1 commit
  (merged to 'next' on 2011-08-23 at 18cee02)
 + commit: reduce use of redundant global variables

Will merge to "master".

* bw/doc-repo-layout (2011-08-23) 2 commits
  (merged to 'next' on 2011-08-24 at 605c730)
 + Mark http-fetch without -a as deprecated
 + Documentation: Grammar correction, wording fixes and cleanup

Will merge to "master".

* ci/forbid-unwanted-current-branch-update (2011-08-22) 2 commits
  (merged to 'next' on 2011-08-24 at 1e93b67)
 + Show interpreted branch name in error messages
 + Prevent force-updating of the current branch

Will aim to merge to "master" by -rc1.

* di/fast-import-blob-tweak (2011-08-22) 2 commits
  (merged to 'next' on 2011-08-24 at 52eef2a)
 + fast-import: treat cat-blob as a delta base hint for next blob
 + fast-import: count and report # of calls to diff_delta in stats

Will aim to merge to "master" by -rc1.

* di/fast-import-tagging (2011-08-23) 2 commits
  (merged to 'next' on 2011-08-24 at 67e0937)
 + fast-import: allow to tag newly created objects
 + fast-import: add tests for tagging blobs

Will aim to merge to "master" by -rc1.

* di/fast-import-deltified-tree (2011-08-14) 2 commits
  (merged to 'next' on 2011-08-23 at ee30265)
 + fast-import: prevent producing bad delta
 + fast-import: add a test for tree delta base corruption

Will aim to merge to "master" by -rc1.

* di/fast-import-ident (2011-08-11) 5 commits
  (merged to 'next' on 2011-08-23 at 9b86391)
 + fsck: improve committer/author check
 + fsck: add a few committer name tests
 + fast-import: check committer name more strictly
 + fast-import: don't fail on omitted committer name
 + fast-import: add input format tests

Will aim to merge to "master" by -rc1.

* di/fast-import-doc (2011-08-17) 1 commit
  (merged to 'next' on 2011-08-23 at dab4088)
 + doc/fast-import: document feature import-marks-if-exists

Will merge to "master".

* jc/combine-diff-callback (2011-08-20) 1 commit
  (merged to 'next' on 2011-08-24 at 9f9b42d)
 + combine-diff: support format_callback
 (this branch is used by fg/submodule-ff-check-before-push.)

Will merge to "master".

* jc/maint-clone-alternates (2011-08-23) 2 commits
  (merged to 'next' on 2011-08-23 at 7280deb)
 + clone: clone from a repository with relative alternates
 + clone: allow more than one --reference

Will aim to merge to "master" by -rc1.

* nd/maint-clone-gitdir (2011-08-22) 2 commits
  (merged to 'next' on 2011-08-24 at cbf052b)
 + clone: allow to clone from .git file
 + read_gitfile_gently(): rename misnamed function to read_gitfile()

Will aim to merge to "master" by -rc1.

* jc/traverse-commit-list (2011-08-22) 3 commits
  (merged to 'next' on 2011-08-24 at df50dd7)
 + revision.c: update show_object_with_name() without using malloc()
 + revision.c: add show_object_with_name() helper function
 + rev-list: fix finish_object() call

Not urgent; will not be in 1.7.7.

* rc/diff-cleanup-records (2011-08-17) 2 commits
  (merged to 'next' on 2011-08-23 at b8414f5)
 + Merge branch 'rc/histogram-diff' into HEAD
 + xdiff/xprepare: improve O(n*m) performance in xdl_cleanup_records()

Will aim to merge to "master" by -rc1.

* fk/make-auto-header-dependencies (2011-08-18) 1 commit
  (merged to 'next' on 2011-08-24 at 3da2c25)
 + Makefile: Use computed header dependencies if the compiler supports it

Not urgent; will not be in 1.7.7.

* jk/color-and-pager (2011-08-19) 10 commits
  (merged to 'next' on 2011-08-23 at cbb9495)
 + want_color: automatically fallback to color.ui
 + diff: don't load color config in plumbing
 + config: refactor get_colorbool function
 + color: delay auto-color decision until point of use
 + git_config_colorbool: refactor stdout_is_tty handling
 + diff: refactor COLOR_DIFF from a flag into an int
 + setup_pager: set GIT_PAGER_IN_USE
 + t7006: use test_config helpers
 + test-lib: add helper functions for config
 + t7006: modernize calls to unset
 (this branch is used by jk/pager-with-alias and jk/pager-with-external-command.)

Will aim to merge to "master" by -rc1.

* jk/pager-with-alias (2011-08-19) 1 commit
 - support pager.* for aliases
 (this branch uses jk/color-and-pager, jk/pager-with-external-command and jk/pager-with-external-command.)

Perhaps will drop.

* nd/decorate-grafts (2011-08-19) 5 commits
  (merged to 'next' on 2011-08-23 at 475d27e)
 + log: decorate "replaced" on to replaced commits
 + log: decorate grafted commits with "grafted"
 + Move write_shallow_commits to fetch-pack.c
 + Add for_each_commit_graft() to iterate all grafts
 + decoration: do not mis-decorate refs with same prefix

Will aim to merge to "master" by -rc1.

* va/p4-branch-import (2011-08-22) 4 commits
  (merged to 'next' on 2011-08-24 at f67f8af)
 + git-p4: Add simple test case for branch import
 + git-p4: Allow branch definition with git config
 + git-p4: Allow filtering Perforce branches by user
 + git-p4: Correct branch base depot path detection
 (this branch uses va/p4-rename-copy.)

Will merge to "master".

* va/p4-rename-copy (2011-08-22) 5 commits
  (merged to 'next' on 2011-08-24 at f1faa94)
 + git-p4: Process detectCopiesHarder with --bool
 + git-p4: Add test case for copy detection
 + git-p4: Add test case for rename detection
 + git-p4: Add description of rename/copy detection options
 + git-p4: Allow setting rename/copy detection threshold
 (this branch is used by va/p4-branch-import.)

Will merge to "master".

* da/difftool-mergtool-refactor (2011-08-19) 4 commits
  (merged to 'next' on 2011-08-23 at a1cc3be)
 + mergetools/meld: Use '--output' when available
 + mergetool--lib: Refactor tools into separate files
 + mergetool--lib: Make style consistent with git
 + difftool--helper: Make style consistent with git

Will merge to "master".

* mg/branch-set-upstream-previous (2011-08-19) 1 commit
  (merged to 'next' on 2011-08-23 at acef0b6)
 + branch.c: use the parsed branch name

Will merge to "master".

* di/parse-options-split (2011-08-11) 2 commits
  (merged to 'next' on 2011-08-23 at 6cd667f)
 + Reduce parse-options.o dependencies
 + parse-options: export opterr, optbug

Will merge to "master".

* mh/attr (2011-08-14) 7 commits
  (merged to 'next' on 2011-08-23 at 22faa6e)
 + Unroll the loop over passes
 + Change while loop into for loop
 + Determine the start of the states outside of the pass loop
 + Change parse_attr() to take a pointer to struct attr_state
 + Increment num_attr in parse_attr_line(), not parse_attr()
 + Document struct match_attr
 + Add a file comment

Will aim to merge to "master" by -rc1.

* mh/iterate-refs (2011-08-14) 6 commits
 - Retain caches of submodule refs
 - Store the submodule name in struct cached_refs
 - Allocate cached_refs objects dynamically
 - Change the signature of read_packed_refs()
 - Access reference caches only through new function get_cached_refs()
 - Extract a function clear_cached_refs()

I did not see anything fundamentally wrong with this series, but it was
unclear what the benefit of these changes are.  If the series were to read
parts of the ref hierarchy (like refs/heads/) lazily, the story would
have been different, though.

Not urgent; will not be in 1.7.7.

* jn/plug-empty-tree-leak (2011-08-16) 2 commits
  (merged to 'next' on 2011-08-23 at aee2184)
 + merge-recursive: take advantage of hardcoded empty tree
 + revert: plug memory leak in "cherry-pick root commit" codepath

Will merge to "master".

* ac/describe-dirty-refresh (2011-08-11) 1 commit
  (merged to 'next' on 2011-08-23 at b873611)
 + describe: Refresh the index when run with --dirty

Will merge to "master".

* en/merge-recursive-2 (2011-08-14) 57 commits
  (merged to 'next' on 2011-08-23 at ba6ad0d)
 + merge-recursive: Don't re-sort a list whose order we depend upon
 + merge-recursive: Fix virtual merge base for rename/rename(1to2)/add-dest
 + t6036: criss-cross + rename/rename(1to2)/add-dest + simple modify
 + merge-recursive: Avoid unnecessary file rewrites
 + t6022: Additional tests checking for unnecessary updates of files
 + merge-recursive: Fix spurious 'refusing to lose untracked file...' messages
 + t6022: Add testcase for spurious "refusing to lose untracked" messages
 + t3030: fix accidental success in symlink rename
 + merge-recursive: Fix working copy handling for rename/rename/add/add
 + merge-recursive: add handling for rename/rename/add-dest/add-dest
 + merge-recursive: Have conflict_rename_delete reuse modify/delete code
 + merge-recursive: Make modify/delete handling code reusable
 + merge-recursive: Consider modifications in rename/rename(2to1) conflicts
 + merge-recursive: Create function for merging with branchname:file markers
 + merge-recursive: Record more data needed for merging with dual renames
 + merge-recursive: Defer rename/rename(2to1) handling until process_entry
 + merge-recursive: Small cleanups for conflict_rename_rename_1to2
 + merge-recursive: Fix rename/rename(1to2) resolution for virtual merge base
 + merge-recursive: Introduce a merge_file convenience function
 + merge-recursive: Fix modify/delete resolution in the recursive case
 + merge-recursive: When we detect we can skip an update, actually skip it
 + merge-recursive: Provide more info in conflict markers with file renames
 + merge-recursive: Cleanup and consolidation of rename_conflict_info
 + merge-recursive: Consolidate process_entry() and process_df_entry()
 + merge-recursive: Improve handling of rename target vs. directory addition
 + merge-recursive: Add comments about handling rename/add-source cases
 + merge-recursive: Make dead code for rename/rename(2to1) conflicts undead
 + merge-recursive: Fix deletion of untracked file in rename/delete conflicts
 + merge-recursive: Split update_stages_and_entry; only update stages at end
 + merge-recursive: Allow make_room_for_path() to remove D/F entries
 + string-list: Add API to remove an item from an unsorted list
 + merge-recursive: Split was_tracked() out of would_lose_untracked()
 + merge-recursive: Save D/F conflict filenames instead of unlinking them
 + merge-recursive: Fix code checking for D/F conflicts still being present
 + merge-recursive: Fix sorting order and directory change assumptions
 + merge-recursive: Fix recursive case with D/F conflict via add/add conflict
 + merge-recursive: Avoid working directory changes during recursive case
 + merge-recursive: Remember to free generated unique path names
 + merge-recursive: Consolidate different update_stages functions
 + merge-recursive: Mark some diff_filespec struct arguments const
 + merge-recursive: Correct a comment
 + merge-recursive: Make BUG message more legible by adding a newline
 + t6022: Add testcase for merging a renamed file with a simple change
 + t6022: New tests checking for unnecessary updates of files
 + t6022: Remove unnecessary untracked files to make test cleaner
 + t6036: criss-cross + rename/rename(1to2)/add-source + modify/modify
 + t6036: criss-cross w/ rename/rename(1to2)/modify+rename/rename(2to1)/modify
 + t6036: tests for criss-cross merges with various directory/file conflicts
 + t6036: criss-cross with weird content can fool git into clean merge
 + t6036: Add differently resolved modify/delete conflict in criss-cross test
 + t6042: Add failing testcases for rename/rename/add-{source,dest} conflicts
 + t6042: Ensure rename/rename conflicts leave index and workdir in sane state
 + t6042: Add tests for content issues with modify/rename/directory conflicts
 + t6042: Add a testcase where undetected rename causes silent file deletion
 + t6042: Add a pair of cases where undetected renames cause issues
 + t6042: Add failing testcase for rename/modify/add-source conflict
 + t6042: Add a testcase where git deletes an untracked file

Will aim to merge to "master" by -rc1.

* fg/submodule-ff-check-before-push (2011-08-20) 2 commits
  (merged to 'next' on 2011-08-24 at 398e764)
 + push: teach --recurse-submodules the on-demand option
 + push: Don't push a repository with unpushed submodules
 (this branch uses jc/combine-diff-callback.)

Will aim to merge to "master" by -rc1.

* hv/submodule-update-none (2011-08-11) 2 commits
  (merged to 'next' on 2011-08-24 at 5302fc1)
 + add update 'none' flag to disable update of submodule by default
 + submodule: move update configuration variable further up

Not urgent; will not be in 1.7.7.

* jc/lookup-object-hash (2011-08-11) 6 commits
  (merged to 'next' on 2011-08-24 at 5825411)
 + object hash: replace linear probing with 4-way cuckoo hashing
 + object hash: we know the table size is a power of two
 + object hash: next_size() helper for readability
 + pack-objects --count-only
 + object.c: remove duplicated code for object hashing
 + object.c: code movement for readability

I do not think there is anything fundamentally wrong with this series, but
the risk of breakage far outweighs observed performance gain in one
particular workload. Will keep it in 'next' at least for one cycle.

Not urgent; will not be in 1.7.7.

* js/i18n-scripts (2011-08-08) 5 commits
  (merged to 'next' on 2011-08-23 at a1b5529)
 + submodule: take advantage of gettextln and eval_gettextln.
 + stash: take advantage of eval_gettextln
 + pull: take advantage of eval_gettextln
 + git-am: take advantage of gettextln and eval_gettextln.
 + gettext: add gettextln, eval_gettextln to encode common idiom

Will merge to "master".

* fg/submodule-git-file-git-dir (2011-08-22) 2 commits
  (merged to 'next' on 2011-08-23 at 762194e)
 + Move git-dir for submodules
 + rev-parse: add option --resolve-git-dir <path>

I do not think there is anything fundamentally wrong with this series, but
the risk of breakage outweighs any benefit for having this new
feature. Will keep it in 'next' at least for one cycle.

Not urgent; will not be in 1.7.7.

* jk/http-auth-keyring (2011-08-03) 13 commits
  (merged to 'next' on 2011-08-03 at b06e80e)
 + credentials: add "getpass" helper
 + credentials: add "store" helper
 + credentials: add "cache" helper
 + docs: end-user documentation for the credential subsystem
 + http: use hostname in credential description
 + allow the user to configure credential helpers
 + look for credentials in config before prompting
 + http: use credential API to get passwords
 + introduce credentials API
 + http: retry authentication failures for all http requests
 + remote-curl: don't retry auth failures with dumb protocol
 + improve httpd auth tests
 + url: decode buffers that are not NUL-terminated

Looked mostly reasonable except for the limitation that it is not clear
how to deal with a site at which a user needs to use different passwords 
for different repositories. Will keep it in "next" at least for one cycle,
until we start hearing real-world success reports on the list.

Not urgent; will not be in 1.7.7.

* rr/revert-cherry-pick-continue (2011-08-08) 18 commits
  (merged to 'next' on 2011-08-24 at 712c115)
 + revert: Propagate errors upwards from do_pick_commit
 + revert: Introduce --continue to continue the operation
 + revert: Don't implicitly stomp pending sequencer operation
 + revert: Remove sequencer state when no commits are pending
 + reset: Make reset remove the sequencer state
 + revert: Introduce --reset to remove sequencer state
 + revert: Make pick_commits functionally act on a commit list
 + revert: Save command-line options for continuing operation
 + revert: Save data for continuing after conflict resolution
 + revert: Don't create invalid replay_opts in parse_args
 + revert: Separate cmdline parsing from functional code
 + revert: Introduce struct to keep command-line options
 + revert: Eliminate global "commit" variable
 + revert: Rename no_replay to record_origin
 + revert: Don't check lone argument in get_encoding
 + revert: Simplify and inline add_message_to_msg
 + config: Introduce functions to write non-standard file
 + advice: Introduce error_resolve_conflict

Will keep it in 'next' at least for one cycle.
Not urgent; will not be in 1.7.7.
