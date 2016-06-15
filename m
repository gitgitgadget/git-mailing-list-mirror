From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2014, #02; Mon, 7)
Date: Mon, 07 Apr 2014 15:19:28 -0700
Message-ID: <xmqqmwfwlr4f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 00:20:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXHtY-0006td-K7
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 00:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927AbaDGWTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 18:19:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755780AbaDGWTj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 18:19:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FDDF7B858;
	Mon,  7 Apr 2014 18:19:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Y
	rJFbXodH6RqbOuMISGI7meBsow=; b=V5rMbLDHe1eVANVIEibAAIUj7qo/3gkPf
	4Ok18lKn3tH3nDQVQXhhVAvkqobopHsoKzhQcA5O19BnDH+G+Bone1fvzG80Q8xU
	4/qBTWpChdvK06EiyN/ITPoUD0GxFi2sZm5H79LeU9PwEW4QgtuqzlVjmAVSOSSM
	Zc8d5zJ7zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Wsy
	0Lx167Jc2UglFzKDUkOEHxZon+jtl3I2xm/onxVjJvsG9NMAOagx6pLRpD04wtFg
	0Zv4/J7zd3rEFsVO6CcyzraSIQzoDvldMlQxn9kd7vdgyqWf7/3GboYeMAmwHmLe
	Ynptp1+v1zV9fa7bldW8E8qR7rtxJwswRwygznvE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B3087B856;
	Mon,  7 Apr 2014 18:19:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1CA07B855;
	Mon,  7 Apr 2014 18:19:29 -0400 (EDT)
X-master-at: e4eef26d985177e4bdd32bf58b6ae40e7ae67289
X-next-at: 0306834402c2cffa7f83ae33bcc31a47c1cdccd0
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B00A87EA-BEA2-11E3-8341-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245910>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jl/status-added-submodule-is-never-ignored (2014-04-07) 2 commits
 - commit -m: commit staged submodules regardless of ignore config
 - status/commit: show staged submodules regardless of ignore config


* mh/multimail (2014-04-07) 1 commit
 - git-multimail: update to version 1.0.0

--------------------------------------------------
[Stalled]

* tr/merge-recursive-index-only (2014-02-05) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()
 (this branch is used by tr/remerge-diff.)

 Will hold.


* tr/remerge-diff (2014-02-26) 5 commits
 . log --remerge-diff: show what the conflict resolution changed
 . name-hash: allow dir hashing even when !ignore_case
 . merge-recursive: allow storing conflict hunks in index
 . revision: fold all merge diff variants into an enum merge_diff_mode
 . combine-diff: do not pass revs->dense_combined_merges redundantly
 (this branch uses tr/merge-recursive-index-only.)

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Needs to be rebased, now kb/fast-hashmap topic is in.


* sz/mingw-index-pack-threaded (2014-03-19) 1 commit
 - Enable index-pack threading in msysgit.

 What is the status of this topic?  A failure report exists
 ($gmane/245170), and I am aware of Duy's $gmane/245034 but that was
 where the discussion stalled.  Is everybody waiting for everybody
 else to get the discussion unstuck?


* bc/blame-crlf-test (2014-02-18) 1 commit
 - blame: add a failing test for a CRLF issue.

 I have a feeling that a fix for this should be fairly isolated and
 trivial (it should be just the matter of paying attention to the
 crlf settings when synthesizing the fake commit)---perhaps somebody
 can squash in a fix to this?


* jk/makefile (2014-02-05) 16 commits
 - FIXUP
 - move LESS/LV pager environment to Makefile
 - Makefile: teach scripts to include make variables
 - FIXUP
 - Makefile: auto-build C strings from make variables
 - Makefile: drop *_SQ variables
 - FIXUP
 - Makefile: add c-quote helper function
 - Makefile: introduce sq function for shell-quoting
 - Makefile: always create files via make-var
 - Makefile: store GIT-* sentinel files in MAKE/
 - Makefile: prefer printf to echo for GIT-*
 - Makefile: use tempfile/mv strategy for GIT-*
 - Makefile: introduce make-var helper function
 - Makefile: fix git-instaweb dependency on gitweb
 - Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS

 Simplify the Makefile rules and macros that exist primarily for
 quoting purposes, and make it easier to robustly express the
 dependency rules.

 Expecting a reroll.


* po/everyday-doc (2014-01-27) 1 commit
 - Make 'git help everyday' work

 This may make the said command to emit something, but the source is
 not meant to be formatted into a manual pages to begin with, and
 also its contents are a bit stale.  It may be a good first step in
 the right direction, but needs more work to at least get the
 mark-up right before public consumption.

 Will hold.


* jk/branch-at-publish-rebased (2014-01-17) 5 commits
 - t1507 (rev-parse-upstream): fix typo in test title
 - implement @{publish} shorthand
 - branch_get: provide per-branch pushremote pointers
 - branch_get: return early on error
 - sha1_name: refactor upstream_mark

 Give an easier access to the tracking branches from "other" side in
 a triangular workflow by introducing B@{publish} that works in a
 similar way to how B@{upstream} does.

 Meant to be used as a basis for whatever Ram wants to build on.

 Will hold.


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting for a reroll.


* jl/submodule-recursive-checkout (2013-12-26) 5 commits
 - Teach checkout to recursively checkout submodules
 - submodule: teach unpack_trees() to update submodules
 - submodule: teach unpack_trees() to repopulate submodules
 - submodule: teach unpack_trees() to remove submodule contents
 - submodule: prepare for recursive checkout of submodules

 Expecting a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* np/pack-v4 (2013-09-18) 90 commits
 . packv4-parse.c: add tree offset caching
 . t1050: replace one instance of show-index with verify-pack
 . index-pack, pack-objects: allow creating .idx v2 with .pack v4
 . unpack-objects: decode v4 trees
 . unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.

 Needs to be rebased, now the pack-bitmap series is in.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* ib/rev-parse-parseopt-argh (2014-04-01) 1 commit
  (merged to 'next' on 2014-04-01 at 025578d)
 + rev-parse: fix typo in example on manpage

 Finishing touch to a new topic scheduled for 2.0

 Will merge to 'master'.


* mh/lockfile (2014-04-07) 25 commits
 - trim_last_path_elm(): replace last_path_elm()
 - resolve_symlink(): take a strbuf parameter
 - resolve_symlink(): use a strbuf for internal scratch space
 - Change lock_file::filename into a strbuf
 - commit_lock_file(): use a strbuf to manage temporary space
 - try_merge_strategy(): use a statically-allocated lock_file object
 - try_merge_strategy(): remove redundant lock_file allocation
 - lockfile: avoid transitory invalid states
 - commit_lock_file(): make committing an unlocked lockfile a NOP
 - commit_lock_file(): inline temporary variable
 - remove_lock_file(): call rollback_lock_file()
 - lock_file(): exit early if lockfile cannot be opened
 - write_packed_entry_fn(): convert cb_data into a (const int *)
 - prepare_index(): declare return value to be (const char *)
 - delete_ref_loose(): don't muck around in the lock_file's filename
 - lockfile: define a constant LOCK_SUFFIX_LEN
 - lockfile.c: document the various states of lock_file objects
 - struct lock_file: replace on_list field with flags field
 - lock_file(): always add lock_file object to lock_file_list
 - hold_lock_file_for_append(): release lock on errors
 - lockfile: unlock file if lockfile permissions cannot be adjusted
 - rollback_lock_file(): set fd to -1
 - rollback_lock_file(): do not clear filename redundantly
 - unable_to_lock_die(): rename function from unable_to_lock_index_die()
 - api-lockfile: expand the documentation

 Refactor and fix corner-case bugs in the lockfile API.


* mh/update-ref-batch-create-fix (2014-04-02) 1 commit
  (merged to 'next' on 2014-04-04 at 97e3f12)
 + update-ref: fail create operation over stdin if ref already exists

 Will merge to 'master'.


* jk/pack-bitmap (2014-04-04) 2 commits
  (merged to 'next' on 2014-04-04 at 0306834)
 + pack-objects: do not reuse packfiles without --delta-base-offset
 + add `ignore_missing_links` mode to revwalk

 Will merge to 'master'.


* mr/opt-set-ptr (2014-03-31) 3 commits
  (merged to 'next' on 2014-04-03 at a26385b)
 + parse-options: remove unused OPT_SET_PTR
 + parse-options: add cast to correct pointer type to OPT_SET_PTR
 + MSVC: fix t0040-parse-options crash

 OPT_SET_PTR() implementation was broken on IL32P64 platforms;
 it turns out that the macro is not used by any real user.

 Will merge to 'master'.


* mt/patch-id-stable (2014-03-31) 3 commits
 - patch-id-test: test --stable and --unstable flags
 - patch-id: document new behaviour
 - patch-id: make it stable against hunk reordering

 Introduce a new way to compute patch-id for a patch that is not
 affected by the order of the paths that appear in the input.

 Will merge to 'next' and keep it there for the remainder of this cycle.


* jl/nor-or-nand-and (2014-03-31) 4 commits
  (merged to 'next' on 2014-04-04 at b5d1ac5)
 + code and test: fix misuses of "nor"
 + comments: fix misuses of "nor"
 + contrib: fix misuses of "nor"
 + Documentation: fix misuses of "nor"

 Eradicate mistaken use of "nor" (that is, essentially "nor" used
 not in "neither A nor B" ;-)) from in-code comments, command output
 strings, and documentations.

 Will merge to 'master'.


* mh/ref-transaction (2014-04-07) 27 commits
 - ref_transaction_commit(): work with transaction->updates in place
 - struct ref_update: add a type field
 - struct ref_update: add a lock field
 - ref_transaction_commit(): simplify code using temporary variables
 - struct ref_update: store refname as a FLEX_ARRAY
 - struct ref_update: rename field "ref_name" to "refname"
 - refs: remove API function update_refs()
 - update-ref --stdin: reimplement using reference transactions
 - refs: add a concept of a reference transaction
 - update-ref --stdin: harmonize error messages
 - update-ref --stdin: improve the error message for unexpected EOF
 - t1400: test one mistake at a time
 - update-ref --stdin -z: deprecate interpreting the empty string as zeros
 - update-ref.c: extract a new function, parse_next_sha1()
 - t1400: test that stdin -z update treats empty <newvalue> as zeros
 - update-ref --stdin: simplify error messages for missing oldvalues
 - update-ref --stdin: make error messages more consistent
 - update-ref --stdin: improve error messages for invalid values
 - update-ref.c: extract a new function, parse_refname()
 - parse_cmd_verify(): copy old_sha1 instead of evaluating <oldvalue> twice
 - update-ref --stdin: read the whole input at once
 - update_refs(): fix constness
 - refs.h: rename the action_on_err constants
 - t1400: add some more tests involving quoted arguments
 - parse_arg(): really test that argument is properly terminated
 - t1400: provide more usual input to the command
 - t1400: fix name and expected result of one test

 Update "update-ref --stdin [-z]" and then introduce a transactional
 support for (multi-)reference updates.


* jc/apply-ignore-whitespace (2014-03-26) 1 commit
  (merged to 'next' on 2014-04-04 at 53779a7)
 + apply --ignore-space-change: lines with and without leading whitespaces do not match

 "--ignore-space-change" option of "git apply" ignored the
 spaces at the beginning of line too aggressively, which is
 inconsistent with the option of the same name "diff" and "git diff"
 have.

 Will keep in 'next' for the remainder of this cycle.


* jc/rev-parse-argh-dashed-multi-words (2014-03-24) 3 commits
  (merged to 'next' on 2014-03-31 at 1c48649)
 + parse-options: make sure argh string does not have SP or _
 + update-index: teach --cacheinfo a new syntax "mode,sha1,path"
 + parse-options: multi-word argh should use dash to separate words

 Make sure that the help text given to describe the "<param>" part
 of the "git cmd --option=<param>" does not contain SP or _,
 e.g. "--gpg-sign=<key-id>" option for "git commit" is not spelled
 as "--gpg-sign=<key id>".

 Will merge to 'master'.


* jk/commit-dates-parsing-fix (2014-04-01) 2 commits
  (merged to 'next' on 2014-04-04 at c16eeb0)
 + t4212: loosen far-in-future test for AIX
 + date: recognize bogus FreeBSD gmtime output

 Will merge to 'master' and later to 'maint'.


* mr/msvc-link-with-invalidcontinue (2014-03-28) 1 commit
  (merged to 'next' on 2014-03-31 at 051a29e)
 + MSVC: link in invalidcontinue.obj for better POSIX compatibility

 Will merge to 'master'.


* as/grep-fullname-config (2014-03-20) 1 commit
  (merged to 'next' on 2014-03-28 at 810a076)
 + grep: add grep.fullName config variable

 Add a configuration variable to force --full-name to be default for
 "git grep".

 This may cause regressions on scripted users that do not expect
 this new behaviour.

 Will keep in 'next' for the remainder of this cycle.


* nd/multiple-work-trees (2014-03-25) 28 commits
 - count-objects: report unused files in $GIT_DIR/repos/...
 - gc: support prune --repos
 - gc: style change -- no SP before closing bracket
 - prune: strategies for linked checkouts
 - checkout: detach if the branch is already checked out elsewhere
 - checkout: clean up half-prepared directories in --to mode
 - checkout: support checking out into a new working directory
 - use new wrapper write_file() for simple file writing
 - wrapper.c: wrapper to open a file, fprintf then close
 - setup.c: support multi-checkout repo setup
 - setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 - setup.c: convert check_repository_format_gently to use strbuf
 - setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 - setup.c: convert is_git_directory() to use strbuf
 - git-stash: avoid hardcoding $GIT_DIR/logs/....
 - *.sh: avoid hardcoding $GIT_DIR/hooks/...
 - git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 - $GIT_COMMON_DIR: a new environment variable
 - commit: use SEQ_DIR instead of hardcoding "sequencer"
 - fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 - reflog: avoid constructing .lock path with git_path
 - *.sh: respect $GIT_INDEX_FILE
 - git_path(): be aware of file relocation in $GIT_DIR
 - path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 - path.c: rename vsnpath() to do_git_path()
 - git_snpath(): retire and replace with strbuf_git_path()
 - path.c: make get_pathname() call sites return const char *
 - path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.

 Will hold.


* ks/tree-diff-nway (2014-04-07) 19 commits
 - combine-diff: speed it up, by using multiparent diff tree-walker directly
 - tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
 - Portable alloca for Git
  (merged to 'next' on 2014-03-31 at 16a7bd4)
 + tree-diff: reuse base str(buf) memory on sub-tree recursion
 + tree-diff: no need to call "full" diff_tree_sha1 from show_path()
 + tree-diff: rework diff_tree interface to be sha1 based
 + tree-diff: diff_tree() should now be static
 + tree-diff: remove special-case diff-emitting code for empty-tree cases
  (merged to 'next' on 2014-03-25 at cfcbdac)
 + tree-diff: simplify tree_entry_pathcmp
 + tree-diff: show_path prototype is not needed anymore
 + tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
 + tree-diff: move all action-taking code out of compare_tree_entry()
 + tree-diff: don't assume compare_tree_entry() returns -1,0,1
  (merged to 'next' on 2014-03-21 at d872679)
 + tree-diff: consolidate code for emitting diffs and recursion in one place
 + tree-diff: show_tree() is not needed
 + tree-diff: no need to pass match to skip_uninteresting()
 + tree-diff: no need to manually verify that there is no mode change for a path
 + combine-diff: move changed-paths scanning logic into its own function
 + combine-diff: move show_log_first logic/action out of paths scanning

 Instead of running N pair-wise diff-trees when inspecting a
 N-parent merge, find the set of paths that were touched by walking
 N+1 trees in parallel.  These set of paths can then be turned into
 N pair-wise diff-tree results to be processed through rename
 detections and such.  And N=2 case nicely degenerates to the usual
 2-way diff-tree, which is very nice.

 The preparatory steps are all in 'next'.

 Will merge to 'next' and keep it there for the remainder of this cycle.


* cc/interpret-trailers (2014-04-07) 12 commits
 - trailer: add blank line before the trailers if needed
 - Documentation: add documentation for 'git interpret-trailers'
 - trailer: add tests for commands in config file
 - trailer: execute command from 'trailer.<name>.command'
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from stdin
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - trailer: process trailers from stdin and arguments
 - trailer: add data structures and basic functions

 A new filter to programatically edit the tail end of the commit log
 messages.

 Will merge to 'next' and keep it there for the remainder of this cycle.
