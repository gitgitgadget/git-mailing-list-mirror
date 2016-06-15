From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2011, #05; Fri, 19)
Date: Fri, 19 Aug 2011 15:19:44 -0700
Message-ID: <7vsjox11tr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 00:19:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuXPv-0005pX-Ae
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 00:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab1HSWTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 18:19:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37905 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754575Ab1HSWTr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 18:19:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D58EC47C7;
	Fri, 19 Aug 2011 18:19:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=F
	TpLihDggM7TdcVGfWfRZ/JtG0o=; b=rveSrJ+74nBmj93zgSjJEA2sNvWCyt8hF
	2X8S1UU6mQ3C8KB8jqG/yEKsSsQvsN05qpE36MdX4PUmYydEfT3BNhrchOijosRd
	Jgb8AsMcznmknbEJm3vBsqpyQKzoLZFdwz/wnFFF6kGcqSax6/wVupKIqIQXR87b
	k3HHFwLOsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=FmE
	16NcYbi91FvjWw7Sn0xaEG5HM0cx6cbBIyvJBR2KMlZ8arSE2EcTYb+UqsezyPZJ
	Ik+6iKU7W9CBdLwCp9DDfHvs7OAO5YE767VyM34tNc9W35/AYHGol3p0T2kVDbZ6
	8eQI362WHu6t3IWPxyO+jd3a/mVEN5ZOvm32SfSc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB8B447C6;
	Fri, 19 Aug 2011 18:19:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA6CC47C5; Fri, 19 Aug 2011
 18:19:45 -0400 (EDT)
X-master-at: cee426811c981c62c4b236ebdcb47d1c2945cf56
X-next-at: b5fcad02a1cc9cc1c2b8ebaef4ad67d0f9101c98
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 582BABAE-CAB1-11E0-A2DC-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179735>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

There are a few 'fixup!' commits queued in topics still in 'pu', so that
authors have a choice to just say "that fix looks good, squash it in!"
instead of going through an extra round.

--------------------------------------------------
[New Topics]

* jc/traverse-commit-list (2011-08-17) 3 commits
 - revision.c: update show_object_with_name() without using malloc()
 - revision.c: add show_object_with_name() helper function
 - rev-list: fix finish_object() call

* rc/diff-cleanup-records (2011-08-17) 2 commits
 - Merge branch 'rc/histogram-diff' into HEAD
 - xdiff/xprepare: improve O(n*m) performance in xdl_cleanup_records()

* fk/make-auto-header-dependencies (2011-08-18) 1 commit
 - Makefile: Use computed header dependencies if the compiler supports it

* jk/color-and-pager (2011-08-18) 10 commits
 - want_color: automatically fallback to color.ui
 - diff: don't load color config in plumbing
 - config: refactor get_colorbool function
 - color: delay auto-color decision until point of use
 - git_config_colorbool: refactor stdout_is_tty handling
 - diff: refactor COLOR_DIFF from a flag into an int
 - setup_pager: set GIT_PAGER_IN_USE
 - t7006: use test_config helpers
 - test-lib: add helper functions for config
 - t7006: modernize calls to unset
 (this branch is used by jk/pager-with-alias.)

Looked reasonable.
Will merge to "next".

* jk/pager-with-alias (2011-08-18) 2 commits
 - support pager.* for aliases
 - support pager.* for external commands
 (this branch uses jk/color-and-pager.)

* nd/decorate-grafts (2011-08-19) 5 commits
 - log: decorate "replaced" on to replaced commits
 - log: decorate grafted commits with "grafted"
 - Move write_shallow_commits to fetch-pack.c
 - Add for_each_commit_graft() to iterate all grafts
 - decoration: do not mis-decorate refs with same prefix

Looked reasonable.
Will merge to "next".

* va/p4-branch-import (2011-08-19) 4 commits
 - git-p4: Add simple test case for branch import
 - git-p4: Allow branch definition with git config
 - git-p4: Allow filtering Perforce branches by user
 - git-p4: Correct branch base depot path detection
 (this branch uses va/p4-rename-copy.)

* va/p4-rename-copy (2011-08-18) 4 commits
 - git-p4: Add test case for copy detection.
 - git-p4: Add test case for rename detection.
 - git-p4: Add description of rename/copy detection options.
 - git-p4: Allow setting rename/copy detection threshold.
 (this branch is used by va/p4-branch-import.)

* da/difftool-mergtool-refactor (2011-08-19) 4 commits
 - mergetools/meld: Use '--output' when available
 - mergetool--lib: Refactor tools into separate files
 - mergetool--lib: Make style consistent with git
 - difftool--helper: Make style consistent with git

* mg/branch-set-upstream-previous (2011-08-19) 1 commit
 - branch.c: use the parsed branch name

--------------------------------------------------
[Graduated to "master"]

* cb/maint-exec-error-report (2011-08-01) 2 commits
  (merged to 'next' on 2011-08-05 at 2764424)
 + notice error exit from pager
 + error_routine: use parent's stderr if exec fails

* cb/maint-quiet-push (2011-08-08) 2 commits
  (merged to 'next' on 2011-08-08 at 917d73b)
 + receive-pack: do not overstep command line argument array
  (merged to 'next' on 2011-08-01 at 87df938)
 + propagate --quiet to send-pack/receive-pack

* db/am-skip-blank-at-the-beginning (2011-08-11) 1 commit
  (merged to 'next' on 2011-08-11 at 3637843)
 + am: ignore leading whitespace before patch

* jc/maint-combined-diff-work-tree (2011-08-04) 1 commit
  (merged to 'next' on 2011-08-05 at 976a4d4)
 + diff -c/--cc: do not mistake "resolved as deletion" as "use working tree"

* jc/maint-smart-http-race-upload-pack (2011-08-08) 1 commit
  (merged to 'next' on 2011-08-11 at 3f24b64)
 + helping smart-http/stateless-rpc fetch race

* js/bisect-no-checkout (2011-08-09) 11 commits
  (merged to 'next' on 2011-08-11 at 6c94a45)
 + bisect: add support for bisecting bare repositories
 + bisect: further style nitpicks
 + bisect: replace "; then" with "\n<tab>*then"
 + bisect: cleanup whitespace errors in git-bisect.sh.
 + bisect: add documentation for --no-checkout option.
 + bisect: add tests for the --no-checkout option.
 + bisect: introduce --no-checkout support into porcelain.
 + bisect: introduce support for --no-checkout option.
 + bisect: add tests to document expected behaviour in presence of broken trees.
 + bisect: use && to connect statements that are deferred with eval.
 + bisect: move argument parsing before state modification.

* js/ref-namespaces (2011-07-21) 5 commits
  (merged to 'next' on 2011-07-25 at 5b7dcfe)
 + ref namespaces: tests
 + ref namespaces: documentation
 + ref namespaces: Support remote repositories via upload-pack and receive-pack
 + ref namespaces: infrastructure
 + Fix prefix handling in ref iteration functions

* js/sh-style (2011-08-05) 2 commits
  (merged to 'next' on 2011-08-11 at 4a4c22c)
 + filter-branch.sh: de-dent usage string
 + misc-sh: fix up whitespace in some other .sh files.

* ma/am-exclude (2011-08-09) 2 commits
  (merged to 'next' on 2011-08-11 at cf0ba4d)
 + am: Document new --exclude=<path> option
  (merged to 'next' on 2011-08-05 at 658e57c)
 + am: pass exclude down to apply

* mh/check-attr-listing (2011-08-04) 23 commits
  (merged to 'next' on 2011-08-11 at f73ad50)
 + Rename git_checkattr() to git_check_attr()
 + git-check-attr: Fix command-line handling to match docs
 + git-check-attr: Drive two tests using the same raw data
 + git-check-attr: Add an --all option to show all attributes
 + git-check-attr: Error out if no pathnames are specified
 + git-check-attr: Process command-line args more systematically
 + git-check-attr: Handle each error separately
 + git-check-attr: Extract a function error_with_usage()
 + git-check-attr: Introduce a new variable
 + git-check-attr: Extract a function output_attr()
 + Allow querying all attributes on a file
 + Remove redundant check
 + Remove redundant call to bootstrap_attr_stack()
 + Extract a function collect_all_attrs()
 + Teach prepare_attr_stack() to figure out dirlen itself
 + git-check-attr: Use git_attr_name()
 + Provide access to the name attribute of git_attr
 + git-check-attr: Add tests of command-line parsing
 + git-check-attr: Add missing "&&"
 + Disallow the empty string as an attribute name
 + Remove anachronism from comment
 + doc: Correct git_attr() calls in example code
 + doc: Add a link from gitattributes(5) to git-check-attr(1)
 (this branch is used by mh/check-attr-relative.)

* mh/check-attr-relative (2011-08-04) 6 commits
  (merged to 'next' on 2011-08-11 at f94550c)
 + test-path-utils: Add subcommand "prefix_path"
 + test-path-utils: Add subcommand "absolute_path"
 + git-check-attr: Normalize paths
 + git-check-attr: Demonstrate problems with relative paths
 + git-check-attr: Demonstrate problems with unnormalized paths
 + git-check-attr: test that no output is written to stderr
 (this branch uses mh/check-attr-listing.)

* rc/histogram-diff (2011-08-08) 12 commits
  (merged to 'next' on 2011-08-11 at 684dfd1)
 + xdiff/xhistogram: drop need for additional variable
 + xdiff/xhistogram: rely on xdl_trim_ends()
 + xdiff/xhistogram: rework handling of recursed results
 + xdiff: do away with xdl_mmfile_next()
  (merged to 'next' on 2011-08-03 at f9e2328)
 + Make test number unique
  (merged to 'next' on 2011-07-25 at 3351028)
 + xdiff/xprepare: use a smaller sample size for histogram diff
 + xdiff/xprepare: skip classification
 + teach --histogram to diff
 + t4033-diff-patience: factor out tests
 + xdiff/xpatience: factor out fall-back-diff function
 + xdiff/xprepare: refactor abort cleanups
 + xdiff/xprepare: use memset()

--------------------------------------------------
[Stalled]

* jc/merge-reword (2011-05-25) 2 commits
 - merge: mark the final "Merge made by..." message for l10n
 - merge: reword the final message

Probably the topmost commit should be dropped.

* nk/branch-v-abbrev (2011-07-01) 1 commit
 - branch -v: honor core.abbrev

Perhaps needs an updated commit log message?

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

* di/fast-import-doc (2011-08-17) 1 commit
 - doc/fast-import: document feature import-marks-if-exists

Comments from fast-import folks?

* di/fast-import-deltified-tree (2011-08-14) 2 commits
 - fast-import: prevent producing bad delta
 - fast-import: add a test for tree delta base corruption

Comments from fast-import folks?

* di/fast-import-ident (2011-08-11) 5 commits
 - fsck: improve committer/author check
 - fsck: add a few committer name tests
 - fast-import: check committer name more strictly
 - fast-import: don't fail on omitted committer name
 - fast-import: add input format tests

Comments from fast-import folks?

* di/parse-options-split (2011-08-11) 2 commits
 - Reduce parse-options.o dependencies
 - parse-options: export opterr, optbug

Looked reasonable.
Will merge to "next".

* mh/attr (2011-08-14) 7 commits
 - Unroll the loop over passes
 - Change while loop into for loop
 - Determine the start of the states outside of the pass loop
 - Change parse_attr() to take a pointer to struct attr_state
 - Increment num_attr in parse_attr_line(), not parse_attr()
 - Document struct match_attr
 - Add a file comment

All looked reasonable.
Will merge to "next".

* mh/iterate-refs (2011-08-14) 6 commits
 - Retain caches of submodule refs
 - Store the submodule name in struct cached_refs
 - Allocate cached_refs objects dynamically
 - Change the signature of read_packed_refs()
 - Access reference caches only through new function get_cached_refs()
 - Extract a function clear_cached_refs()

I did not see anything wrong per-se, but it was unclear what the benefit
of these changes are. I probably need to read it once again.

* jn/plug-empty-tree-leak (2011-08-16) 2 commits
 - merge-recursive: take advantage of hardcoded empty tree
 - revert: plug memory leak in "cherry-pick root commit" codepath

Both looked reasonable.
Will merge to "next".

* ac/describe-dirty-refresh (2011-08-11) 1 commit
 - describe: Refresh the index when run with --dirty

Will merge to "next", but needs Sign-off.

* en/merge-recursive-2 (2011-08-14) 57 commits
 - merge-recursive: Don't re-sort a list whose order we depend upon
 - merge-recursive: Fix virtual merge base for rename/rename(1to2)/add-dest
 - t6036: criss-cross + rename/rename(1to2)/add-dest + simple modify
 - merge-recursive: Avoid unnecessary file rewrites
 - t6022: Additional tests checking for unnecessary updates of files
 - merge-recursive: Fix spurious 'refusing to lose untracked file...' messages
 - t6022: Add testcase for spurious "refusing to lose untracked" messages
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
 - merge-recursive: When we detect we can skip an update, actually skip it
 - merge-recursive: Provide more info in conflict markers with file renames
 - merge-recursive: Cleanup and consolidation of rename_conflict_info
 - merge-recursive: Consolidate process_entry() and process_df_entry()
 - merge-recursive: Improve handling of rename target vs. directory addition
 - merge-recursive: Add comments about handling rename/add-source cases
 - merge-recursive: Make dead code for rename/rename(2to1) conflicts undead
 - merge-recursive: Fix deletion of untracked file in rename/delete conflicts
 - merge-recursive: Split update_stages_and_entry; only update stages at end
 - merge-recursive: Allow make_room_for_path() to remove D/F entries
 - string-list: Add API to remove an item from an unsorted list
 - merge-recursive: Split was_tracked() out of would_lose_untracked()
 - merge-recursive: Save D/F conflict filenames instead of unlinking them
 - merge-recursive: Fix code checking for D/F conflicts still being present
 - merge-recursive: Fix sorting order and directory change assumptions
 - merge-recursive: Fix recursive case with D/F conflict via add/add conflict
 - merge-recursive: Avoid working directory changes during recursive case
 - merge-recursive: Remember to free generated unique path names
 - merge-recursive: Consolidate different update_stages functions
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
 - t6042: Add failing testcases for rename/rename/add-{source,dest} conflicts
 - t6042: Ensure rename/rename conflicts leave index and workdir in sane state
 - t6042: Add tests for content issues with modify/rename/directory conflicts
 - t6042: Add a testcase where undetected rename causes silent file deletion
 - t6042: Add a pair of cases where undetected renames cause issues
 - t6042: Add failing testcase for rename/modify/add-source conflict
 - t6042: Add a testcase where git deletes an untracked file

Rerolled.
Will merge to "next".

* fg/submodule-ff-check-before-push (2011-08-09) 1 commit
 - push: Don't push a repository with unpushed submodules

* hv/submodule-update-none (2011-08-11) 2 commits
 - add update 'none' flag to disable update of submodule by default
 - submodule: move update configuration variable further up

Will merge to "next".

* jc/lookup-object-hash (2011-08-11) 6 commits
 - object hash: replace linear probing with 4-way cuckoo hashing
 - object hash: we know the table size is a power of two
 - object hash: next_size() helper for readability
 - pack-objects --count-only
 - object.c: remove duplicated code for object hashing
 - object.c: code movement for readability

* js/i18n-scripts (2011-08-08) 5 commits
 - submodule: take advantage of gettextln and eval_gettextln.
 - stash: take advantage of eval_gettextln
 - pull: take advantage of eval_gettextln
 - git-am: take advantage of gettextln and eval_gettextln.
 - gettext: add gettextln, eval_gettextln to encode common idiom

Will merge to "next".

* cb/maint-ls-files-error-report (2011-08-11) 1 commit
  (merged to 'next' on 2011-08-15 at 69f41cf)
 + ls-files: fix pathspec display on error

Will merge to "master".

* jn/maint-test-return (2011-08-11) 3 commits
  (merged to 'next' on 2011-08-15 at 5a42301)
 + t3900: do not reference numbered arguments from the test script
 + test: cope better with use of return for errors
 + test: simplify return value of test_run_

Will merge to "master".

* rt/zlib-smaller-window (2011-08-11) 2 commits
  (merged to 'next' on 2011-08-15 at e05b26b)
 + test: consolidate definition of $LF
 + Tolerate zlib deflation with window size < 32Kb

Will merge to "master".

* fg/submodule-git-file-git-dir (2011-08-16) 3 commits
 - fixup! Move git-dir for submodules
 - Move git-dir for submodules
 - rev-parse: add option --resolve-git-dir <path>

Will merge to "next", after squashing the top one.

* jk/add-i-hunk-filter (2011-07-27) 5 commits
  (merged to 'next' on 2011-08-11 at 8ff9a56)
 + add--interactive: add option to autosplit hunks
 + add--interactive: allow negatation of hunk filters
 + add--interactive: allow hunk filtering on command line
 + add--interactive: factor out regex error handling
 + add--interactive: refactor patch mode argument processing

Needs documentation updates.

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
for different repositories.

* rr/revert-cherry-pick-continue (2011-08-08) 18 commits
 - revert: Propagate errors upwards from do_pick_commit
 - revert: Introduce --continue to continue the operation
 - revert: Don't implicitly stomp pending sequencer operation
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
 - revert: Rename no_replay to record_origin
 - revert: Don't check lone argument in get_encoding
 - revert: Simplify and inline add_message_to_msg
 - config: Introduce functions to write non-standard file
 - advice: Introduce error_resolve_conflict

Will merge to "next".
