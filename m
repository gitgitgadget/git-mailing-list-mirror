From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2014, #03; Thu, 11)
Date: Thu, 11 Sep 2014 15:52:35 -0700
Message-ID: <xmqq38bxdb2k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 00:52:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSDEL-0006c0-GA
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 00:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbaIKWwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 18:52:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52143 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160AbaIKWwj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 18:52:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B7B23A398;
	Thu, 11 Sep 2014 18:52:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=U
	XzXq9XEA694unxEkDtNrdDYJR4=; b=CvA8WuvsxmXsdhy42lB5q1gvm5lKGrsTu
	K8O01A6n/UMxvxVHCyzcZ/V8GQz/k/zJEiIWlFh/OjvAvf4e3hE0PmuP2qACPTjM
	B43LEdYzSDOPXgYYN2ji2jWj8cFSZmE6U6PnH9/q1QlEpz9dJpMC2WQrnpCCN+hy
	6dzhe2Mzkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Bf+
	/y0lkl28fZ6KmKdzQEZo4d+mHJPm2RS/oPegJYtgX7ro2HqtHJPkMonnqq914GOV
	nxZQ40Z057VcirqqGYvnv0XqmqOfVreQiA4skegGiR/G0gO4UjkZpsgJlqnhzyMz
	PaSwJFZ6QRWT+pk7eRKAXVTiHO5UcVLOZ8L4pNcE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 425EE3A396;
	Thu, 11 Sep 2014 18:52:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 532D73A395;
	Thu, 11 Sep 2014 18:52:37 -0400 (EDT)
X-master-at: ce1d3a93a6405b8a0313491df3099919ed3d150f
X-next-at: 9363127135f6ed0af0d141c3fc3ac63acc2d9010
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 538667D4-3A06-11E4-8E8D-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256888>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The third batch of topics have graduated to 'master'.  There are too
many topics waiting to be in 'next' but without comments and reviews
on the list, which is somewhat disturbing.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* br/http-init-fix (2014-08-21) 2 commits
  (merged to 'next' on 2014-09-03 at 6d42f5e)
 + http: style fixes for curl_multi_init error check
 + http.c: die if curl_*_init fails

 Code clean-up.


* br/imap-send-simplify-tunnel-child-process (2014-09-02) 3 commits
  (merged to 'next' on 2014-09-04 at a182987)
 + imap-send: simplify v_issue_imap_cmd() and get_cmd_result() using starts_with()
 + imap-send.c: imap_folder -> imap_server_conf.folder
 + git-imap-send: simplify tunnel construction

 Code clean-up.


* dt/cache-tree-repair (2014-09-03) 5 commits
  (merged to 'next' on 2014-09-03 at 1c8ff65)
 + cache-tree: do not try to use an invalidated subtree info to build a tree
  (merged to 'next' on 2014-08-26 at 6faccdb)
 + cache-tree: Write updated cache-tree after commit
 + cache-tree: subdirectory tests
 + test-dump-cache-tree: invalid trees are not errors
 + cache-tree: create/update cache-tree on checkout

 Add a few more places in "commit" and "checkout" that make sure
 that the cache-tree is fully populated in the index.


* et/spell-poll-infinite-with-minus-one-only (2014-08-22) 1 commit
  (merged to 'next' on 2014-09-03 at 5be5957)
 + upload-pack: keep poll(2)'s timeout to -1

 We used to pass -1000 to poll(2), expecting it to also mean "no
 timeout", which should be spelled as -1.


* jk/contrib-subtree-make-all (2014-08-18) 1 commit
  (merged to 'next' on 2014-09-03 at 919d889)
 + subtree: make "all" default target of Makefile


* jk/fast-import-fixes (2014-08-25) 2 commits
  (merged to 'next' on 2014-09-04 at 74838e5)
 + fast-import: fix buffer overflow in dump_tags
 + fast-import: clean up pack_data pointer in end_packfile

 With sufficiently long refnames, fast-import could have overflown
 an on-stack buffer.


* jk/make-simplify-dependencies (2014-08-26) 3 commits
  (merged to 'next' on 2014-09-03 at 820a600)
 + Makefile: drop CHECK_HEADER_DEPENDENCIES code
 + Makefile: use `find` to determine static header dependencies
 + i18n: treat "make pot" as an explicitly-invoked target

 Admit that keeping LIB_H up-to-date, only for those that do not use
 the automatically generated dependencies, is a losing battle, and
 make it conservative by making everything depend on anything.


* jk/name-decoration-alloc (2014-08-27) 3 commits
  (merged to 'next' on 2014-09-04 at 05f0d29)
 + log-tree: use FLEX_ARRAY in name_decoration
 + log-tree: make name_decoration hash static
 + log-tree: make add_name_decoration a public function

 The API to allocate the structure to keep track of commit
 decoration was cumbersome to use, inviting lazy code to
 overallocate memory.


* jk/prune-top-level-refs-after-packing (2014-08-25) 1 commit
  (merged to 'next' on 2014-09-04 at bfe3873)
 + pack-refs: prune top-level refs like "refs/foo"

 After "pack-refs --prune" packed refs at the top-level, it failed
 to prune them.


* jn/unpack-trees-checkout-m-carry-deletion (2014-08-25) 3 commits
  (merged to 'next' on 2014-09-04 at e15803a)
 + checkout -m: attempt merge when deletion of path was staged
 + unpack-trees: use 'cuddled' style for if-else cascade
 + unpack-trees: simplify 'all other failures' case

 "git checkout -m" did not switch to another branch while carrying
 the local changes forward when a path was deleted from the index.


* mm/discourage-commit-a-to-finish-conflict-resolution (2014-08-28) 1 commit
  (merged to 'next' on 2014-09-03 at e3f872f)
 + merge, pull: stop advising 'commit -a' in case of conflict


* nd/fetch-pass-quiet-to-gc-child-process (2014-08-18) 2 commits
  (merged to 'next' on 2014-09-04 at 028cd42)
 + fetch: silence git-gc if --quiet is given
 + fetch: convert argv_gc_auto to struct argv_array

 Progress output from "git gc --auto" was visible in "git fetch -q".


* nd/large-blobs (2014-08-18) 5 commits
  (merged to 'next' on 2014-09-04 at 16d7c62)
 + diff: shortcut for diff'ing two binary SHA-1 objects
 + diff --stat: mark any file larger than core.bigfilethreshold binary
 + diff.c: allow to pass more flags to diff_populate_filespec
 + sha1_file.c: do not die failing to malloc in unpack_compressed_entry
 + wrapper.c: introduce gentle xmallocz that does not die()

 Teach a few codepaths to punt (instead of dying) when large blobs
 that would not fit in core are involved in the operation.


* nd/mv-code-cleaning (2014-09-03) 8 commits
  (merged to 'next' on 2014-09-03 at 4315447)
 + mv: no SP between function name and the first opening parenthese
 + mv: combine two if(s)
 + mv: unindent one level for directory move code
 + mv: move index search code out
 + mv: remove an "if" that's always true
 + mv: split submodule move preparation code out
 + mv: flatten error handling code block
 + mv: mark strings for translations

 Code clean-up.


* rs/child-process-init (2014-08-20) 4 commits
  (merged to 'next' on 2014-09-03 at c17c06c)
 + run-command: inline prepare_run_command_v_opt()
 + run-command: call run_command_v_opt_cd_env() instead of duplicating it
 + run-command: introduce child_process_init()
 + run-command: introduce CHILD_PROCESS_INIT

 Code clean-up.


* rs/list-optim (2014-08-25) 2 commits
  (merged to 'next' on 2014-09-04 at eecaf99)
 + walker: avoid quadratic list insertion in mark_complete
 + sha1_name: avoid quadratic list insertion in handle_one_ref

 Fix a couple of "accumulate into a sorted list" to "accumulate and
 then sort the list".


* rs/ref-transaction-1 (2014-09-03) 22 commits
  (merged to 'next' on 2014-09-03 at 68e20b8)
 + update-ref --stdin: pass transaction around explicitly
 + update-ref --stdin: narrow scope of err strbuf
 + refs.c: make delete_ref use a transaction
 + refs.c: make prune_ref use a transaction to delete the ref
 + refs.c: remove lock_ref_sha1
 + refs.c: remove the update_ref_write function
 + refs.c: remove the update_ref_lock function
 + refs.c: make lock_ref_sha1 static
 + walker.c: use ref transaction for ref updates
 + fast-import.c: use a ref transaction when dumping tags
 + receive-pack.c: use a reference transaction for updating the refs
 + refs.c: change update_ref to use a transaction
 + branch.c: use ref transaction for all ref updates
 + fast-import.c: change update_branch to use ref transactions
 + sequencer.c: use ref transactions for all ref updates
 + commit.c: use ref transactions for updates
 + replace.c: use the ref transaction functions for updates
 + tag.c: use ref transactions when doing updates
 + refs.c: add transaction.status and track OPEN/CLOSED
 + refs.c: make ref_transaction_begin take an err argument
 + refs.c: update ref_transaction_delete to check for error and return status
 + refs.c: change ref_transaction_create to do error checking and return status
 (this branch is used by rs/ref-transaction, rs/ref-transaction-multi, rs/ref-transaction-reflog and rs/ref-transaction-rename.)

 The second batch of the transactional ref update series.


* ta/config-set-1 (2014-08-07) 8 commits
  (merged to 'next' on 2014-09-03 at 184b2ef)
 + add tests for `git_config_get_string_const()`
 + add a test for semantic errors in config files
 + rewrite git_config() to use the config-set API
 + config: add `git_die_config()` to the config-set API
 + change `git_config()` return value to void
 + add line number and file name info to `config_set`
 + config.c: fix accuracy of line number in errors
 + config.c: mark error and warnings strings for translation
 (this branch is used by ta/config-set-2.)

 Use the new caching config-set API in git_config() calls.


* ta/config-set-2 (2014-08-13) 15 commits
  (merged to 'next' on 2014-09-03 at f2eff02)
 + builtin/apply.c: replace `git_config()` with `git_config_get_string_const()`
 + merge-recursive.c: replace `git_config()` with `git_config_get_int()`
 + ll-merge.c: refactor `read_merge_config()` to use `git_config_string()`
 + fast-import.c: replace `git_config()` with `git_config_get_*()` family
 + branch.c: replace `git_config()` with `git_config_get_string()
 + alias.c: replace `git_config()` with `git_config_get_string()`
 + imap-send.c: replace `git_config()` with `git_config_get_*()` family
 + pager.c: replace `git_config()` with `git_config_get_value()`
 + builtin/gc.c: replace `git_config()` with `git_config_get_*()` family
 + rerere.c: replace `git_config()` with `git_config_get_*()` family
 + fetchpack.c: replace `git_config()` with `git_config_get_*()` family
 + archive.c: replace `git_config()` with `git_config_get_bool()` family
 + read-cache.c: replace `git_config()` with `git_config_get_*()` family
 + http-backend.c: replace `git_config()` with `git_config_get_bool()` family
 + daemon.c: replace `git_config()` with `git_config_get_bool()` family
 (this branch uses ta/config-set-1.)

 Update git_config() users with callback functions for a very narrow
 scope with calls to config-set API that lets us query a single
 variable.

--------------------------------------------------
[New Topics]

* jc/hash-object (2014-09-11) 3 commits
 - hash-object: add --literally option
 - hash-object: pass 'write_object' as a flag
 - hash-object: reduce file-scope statics
 (this branch is used by jc/hash-object-fsck-tag.)

 "hash-object" learned a new "--literally" option to hash any random
 garbage into a loose object, to allow us to create a test data for
 mechanisms to catch corrupt objects.


* jc/hash-object-fsck-tag (2014-09-11) 2 commits
 - t1450: make sure fsck detects a malformed tagger line
 - Merge branch 'js/fsck-tag-validation' into HEAD
 (this branch uses jc/hash-object and js/fsck-tag-validation.)

 Using "hash-object --literally", test one of the new breakages
 js/fsck-tag-validation topic teaches "fsck" to catch is caught.


* jk/fsck-exit-code-fix (2014-09-10) 1 commit
 - fsck: exit with non-zero status upon error from fsck_obj()

 "git fsck" failed to report that it found corrupt objects via its
 exit status in some cases.

 Will merge to 'next'.


* js/fsck-tag-validation (2014-09-11) 6 commits
 - Make sure that index-pack --strict checks tag objects
 - Add regression tests for stricter tag fsck'ing
 - fsck: check tag objects' headers
 - Make sure fsck_commit_buffer() does not run out of the buffer
 - fsck_object(): allow passing object data separately from the object itself
 - Refactor type_from_string() to allow continuing after detecting an error
 (this branch is used by jc/hash-object-fsck-tag.)

 Teach "git fsck" to inspect the contents of annotated tag objects.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* rs/ref-transaction-multi (2014-09-03) 7 commits
 - ### rs/ref-transaction-multi
 - refs.c: make the *_packed_refs functions static
 - refs.c: make repack_without_refs static
 - remote.c: use a transaction for deleting refs
 - refs.c: write updates to packed refs when a transaction has more than one ref
 - refs.c: move reflog updates into its own function
 - ### rs/ref-transaction-rename
 (this branch uses rs/ref-transaction, rs/ref-transaction-reflog and rs/ref-transaction-rename.)

 Follow-up on rs/ref-transaction series to use the packed-ref to
 achieve atomicity when multiple refs are involved.

 It appears that rs/ref-transaction series is being rerolled, so
 these will be rerolled as well.


* rs/ref-transaction-rename (2014-09-03) 6 commits
 - refs.c: rollback the lockfile before we die() in repack_without_refs
 - refs.c: update rename_ref to use a transaction
 - refs.c: use packed refs when deleting refs during a transaction
 - refs.c: return error instead of dying when locking fails during transaction
 - refs.c: allow passing raw git_committer_info as email to _update_reflog
 - ### rs/ref-transaction-reflog
 (this branch is used by rs/ref-transaction-multi; uses rs/ref-transaction and rs/ref-transaction-reflog.)

 Follow-up on rs/ref-transaction series to make renaming a ref
 transactional (i.e. "delete old and create new" should not leave
 an in-between state behind when it fails).

 It appears that rs/ref-transaction series is being rerolled, so
 these will be rerolled as well.


* rs/ref-transaction-reflog (2014-09-03) 16 commits
 - refs.c: allow deleting refs with a broken sha1
 - refs.c: remove lock_any_ref_for_update
 - refs.c: make unlock_ref/close_ref/commit_ref static
 - refs.c: rename log_ref_setup to create_reflog
 - reflog.c: use a reflog transaction when writing during expire
 - refs.c: allow multiple reflog updates during a single transaction
 - refs.c: only write reflog update if msg is non-NULL
 - refs.c: add a flag to allow reflog updates to truncate the log
 - refs.c: add a transaction function to append a reflog entry
 - lockfile.c: make hold_lock_file_for_append preserve meaningful errno
 - refs.c: add a function to append a reflog entry to a fd
 - refs.c: add a new update_type field to ref_update
 - refs.c: rename the transaction functions
 - refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 - refs.c: make ref_transaction_create a wrapper to ref_transaction_update
 - ### rs/ref-transaction
 (this branch is used by rs/ref-transaction-multi and rs/ref-transaction-rename; uses rs/ref-transaction.)

 Cover updates to reflog with the same transaction mechanism as used
 for reflog manipulations.

 It appears that rs/ref-transaction series is being rerolled, so
 these will be rerolled as well.


* rs/ref-transaction (2014-09-03) 13 commits
 - refs.c: fix handling of badly named refs
 - refs.c: make write_ref_sha1 static
 - fetch.c: change s_update_ref to use a ref transaction
 - refs.c: propagate any errno==ENOTDIR from _commit back to the callers
 - refs.c: pass a skip list to name_conflict_fn
 - refs.c: call lock_ref_sha1_basic directly from commit
 - refs.c: move the check for valid refname to lock_ref_sha1_basic
 - refs.c: pass NULL as *flags to read_ref_full
 - refs.c: pass the ref log message to _create/delete/update instead of _commit
 - refs.c: add an err argument to delete_ref_loose
 - wrapper.c: add a new function unlink_or_msg
 - wrapper.c: simplify warn_if_unremovable
 - ### rs/ref-transaction-1
 (this branch is used by rs/ref-transaction-multi, rs/ref-transaction-reflog and rs/ref-transaction-rename.)

 Rerolled and was asked to wait.  Seems to break "git remote rm".


* hv/submodule-config (2014-06-30) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names

 Kicked back to 'pu' per request ($gmane/255610).


* jt/timer-settime (2014-08-29) 9 commits
 - use timer_settime() for new platforms
 - autoconf: check for timer_settime()
 - autoconf: check for struct itimerspec
 - autoconf: check for struct sigevent
 - autoconf: check for struct timespec
 - autoconf: check for timer_t
 - autoconf: check for setitimer()
 - autoconf: check for struct itimerval
 - git-compat-util.h: add missing semicolon after struct itimerval

 Reviewed, discussed and wanting for a reroll.


* jk/pack-bitmap (2014-08-04) 1 commit
 - pack-bitmap: do not use gcc packed attribute

 Hold, waiting for Karsten's replacement.


* cb/mergetool-difftool (2014-07-21) 2 commits
 - difftool: don't assume that default sh is sane
 - mergetool: don't require a work tree for --tool-help

 Update the way the "difftool --help" shows the help message that is
 shared with the "mergetool" to reduce one shell dependency.

 Will be rerolled.


* rr/mergetool-temporary-filename-tweak (2014-08-21) 1 commit
 - Allow the user to change the temporary file name for mergetool

 Needs rerolling (new paragraph in doc seems to be in a wrong place)


* jk/tag-contains (2014-06-30) 8 commits
 . perf: add tests for tag --contains
 . tag: use commit_contains
 . commit: provide a fast multi-tip contains function
 . string-list: add pos to iterator callback
 . add functions for memory-efficient bitmaps
 . paint_down_to_common: use prio_queue
 . tag: factor out decision to stream tags
 . tag: allow --sort with -n

 Expecting a reroll.


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 - SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 - git-add--interactive: Preserve diff heading when splitting hunks

 Waiting for a reroll.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 - gitweb: Harden UTF-8 handling in generated links

 $gmane/250758?


* rh/prompt-tests (2014-06-05) 11 commits
 - t9904: new __git_ps1 tests for Zsh
 - test-lib: make it possible to override how test code is eval'd
 - lib-prompt-tests.sh: add variable for string that encodes percent in PS1
 - lib-prompt-tests.sh: put all tests inside a function
 - t9903: move prompt tests to a new lib-prompt-tests.sh file
 - t9903: move PS1 color code variable definitions to lib-bash.sh
 - t9903: include "Bash" in test names via new $shellname var
 - t9903: run pc mode tests again with PS1 expansion disabled
 - t9903: move test name prefix to a separate variable
 - t9903: put the Bash pc mode prompt test cases in a function
 - t9903: remove Zsh test from the suite of Bash prompt tests

 Expecting a reroll to limit the damage to test_eval_; also reported
 to be broken with older zsh that are still in the field ($gmane/251231).


* ss/userdiff-update-csharp-java (2014-06-02) 2 commits
 - userdiff: support Java try keyword
 - userdiff: support C# async methods and correct C# keywords

 Reviews sent; waiting for a response.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


* jk/makefile (2014-02-05) 16 commits
 . FIXUP
 . move LESS/LV pager environment to Makefile
 . Makefile: teach scripts to include make variables
 . FIXUP
 . Makefile: auto-build C strings from make variables
 . Makefile: drop *_SQ variables
 . FIXUP
 . Makefile: add c-quote helper function
 . Makefile: introduce sq function for shell-quoting
 . Makefile: always create files via make-var
 . Makefile: store GIT-* sentinel files in MAKE/
 . Makefile: prefer printf to echo for GIT-*
 . Makefile: use tempfile/mv strategy for GIT-*
 . Makefile: introduce make-var helper function
 . Makefile: fix git-instaweb dependency on gitweb
 . Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS

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

 Waiting for a reroll (thread ending at $gmane/254746)


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


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* as/calloc-takes-nmemb-then-size (2014-09-03) 1 commit
 - calloc() and xcalloc() takes nmemb and then size

 Code clean-up.

 Will merge to 'next'.


* tb/complete-diff-ignore-blank-lines (2014-09-03) 1 commit
 - completion: Add --ignore-blank-lines for diff

 Will merge to 'next'.


* jc/parseopt-verify-short-name (2014-09-04) 1 commit
 - parse-options: detect attempt to add a duplicate short option name

 Add checks for a common programming mistake to assign the same
 short option name to two separate options to help developers.

 Will merge to 'next'.


* rs/more-uses-of-skip-prefix (2014-09-02) 2 commits
 - pack-write: simplify index_pack_lockfile using skip_prefix() and xstrfmt()
 - connect: simplify check_ref() using skip_prefix() and starts_with()

 Code clean-up.

 Will merge to 'next'.


* kb/perf-trace (2014-09-08) 1 commit
 - trace: correct trace_strbuf() parameter type for !HAVE_VARIADIC_MACROS

 Compilation fix for some compilers.

 Will merge to 'next'.


* rs/export-strbuf-addchars (2014-09-08) 2 commits
 - strbuf: use strbuf_addchars() for adding a char multiple times
 - strbuf: export strbuf_addchars()

 Code clean-up.

 Will merge to 'next'.


* tr/remerge-diff (2014-09-08) 8 commits
 - log --remerge-diff: show what the conflict resolution changed
 - name-hash: allow dir hashing even when !ignore_case
 - merge-recursive: allow storing conflict hunks in index
 - merge_diff_mode: fold all merge diff variants into an enum
 - combine-diff: do not pass revs->dense_combined_merges redundantly
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Review comments sent.


* mh/lockfile (2014-09-11) 33 commits
 - lockfile.c: store absolute path
 - Extract a function commit_lock_file_to()
 - trim_last_path_elm(): replace last_path_elm()
 - resolve_symlink(): take a strbuf parameter
 - resolve_symlink(): use a strbuf for internal scratch space
 - Change lock_file::filename into a strbuf
 - commit_lock_file(): use a strbuf to manage temporary space
 - try_merge_strategy(): use a statically-allocated lock_file object
 - try_merge_strategy(): remove redundant lock_file allocation
 - struct lock_file: declare some fields volatile
 - lockfile: avoid transitory invalid states
 - git_config_set_multivar_in_file(): avoid call to rollback_lock_file()
 - dump_marks(): remove a redundant call to rollback_lock_file()
 - api-lockfile: document edge cases
 - commit_lock_file(): rollback lock file on failure to rename
 - commit_lock_file(): if close fails, roll back
 - commit_lock_file(): die() if called for unlocked lockfile object
 - commit_lock_file(): inline temporary variable
 - remove_lock_file(): call rollback_lock_file()
 - lock_file(): exit early if lockfile cannot be opened
 - write_packed_entry_fn(): convert cb_data into a (const int *)
 - prepare_index(): declare return value to be (const char *)
 - delete_ref_loose(): don't muck around in the lock_file's filename
 - cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
 - lockfile.c: document the various states of lock_file objects
 - lock_file(): always add lock_file object to lock_file_list
 - hold_lock_file_for_append(): release lock on errors
 - lockfile: unlock file if lockfile permissions cannot be adjusted
 - rollback_lock_file(): set fd to -1
 - rollback_lock_file(): exit early if lock is not active
 - rollback_lock_file(): do not clear filename redundantly
 - api-lockfile: expand the documentation
 - unable_to_lock_die(): rename function from unable_to_lock_index_die()

 Rerolled and reviews starting.


* nd/multiple-work-trees (2014-09-03) 32 commits
 . t2025: add a test to make sure grafts is working from a linked checkout
 . checkout: don't require a work tree when checking out into a new one
 . git_path(): keep "info/sparse-checkout" per work-tree
 . count-objects: report unused files in $GIT_DIR/repos/...
 . gc: support prune --repos
 . gc: factor out gc.pruneexpire parsing code
 . gc: style change -- no SP before closing parenthesis
 . prune: strategies for linked checkouts
 . checkout: reject if the branch is already checked out elsewhere
 . checkout: clean up half-prepared directories in --to mode
 . checkout: support checking out into a new working directory
 . use new wrapper write_file() for simple file writing
 . wrapper.c: wrapper to open a file, fprintf then close
 . setup.c: support multi-checkout repo setup
 . setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 . setup.c: convert check_repository_format_gently to use strbuf
 . setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 . setup.c: convert is_git_directory() to use strbuf
 . git-stash: avoid hardcoding $GIT_DIR/logs/....
 . *.sh: avoid hardcoding $GIT_DIR/hooks/...
 . git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 . $GIT_COMMON_DIR: a new environment variable
 . commit: use SEQ_DIR instead of hardcoding "sequencer"
 . fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 . reflog: avoid constructing .lock path with git_path
 . *.sh: respect $GIT_INDEX_FILE
 . git_path(): be aware of file relocation in $GIT_DIR
 . path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 . path.c: rename vsnpath() to do_git_path()
 . git_snpath(): retire and replace with strbuf_git_path()
 . path.c: make get_pathname() call sites return const char *
 . path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.

 Re-reroll posted but haven't had a chance to pick it up yet.
 The series already received a few comments.


* cc/interpret-trailers (2014-05-28) 11 commits
 - Documentation: add documentation for 'git interpret-trailers'
 - trailer: add tests for commands in config file
 - trailer: execute command from 'trailer.<name>.command'
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from file or stdin
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - trailer: process trailers from input message and arguments
 - trailer: add data structures and basic functions

 A new filter to programatically edit the tail end of the commit log
 messages.

 Comments & reviews?


* bb/date-iso-strict (2014-08-29) 1 commit
 - pretty: provide a strict ISO 8601 date format

 "log --date=iso" uses a slight variant of ISO 8601 format that is
 made more human readable.  A new "--date=iso-strict" option gives
 datetime output that is more strictly conformant.

 Will merge to 'next'.


* jk/commit-author-parsing (2014-08-29) 6 commits
 - determine_author_info(): copy getenv output
 - determine_author_info(): reuse parsing functions
 - date: use strbufs in date-formatting functions
 - record_author_date(): use find_commit_header()
 - record_author_date(): fix memory leak on malformed commit
 - commit: provide a function to find a header in a buffer

 Code clean-up.

 Will merge to 'next'.


* jk/fast-export-anonymize (2014-08-28) 2 commits
 - docs/fast-export: explain --anonymize more completely
 - teach fast-export an --anonymize option

 Sometimes users want to report a bug they experience on their
 repository, but they are not at liberty to share the contents of
 the repository.  "fast-export" was taught an "--anonymize" option
 to replace blob contents, names of people and paths and log
 messages with bland and simple strings to help them.

 Will merge to 'next'.


* jk/index-pack-threading-races (2014-08-29) 1 commit
 - index-pack: fix race condition with duplicate bases

 When receiving an invalid pack stream that records the same object
 twice, multiple threads got confused due to a race.  We should
 reject or correct such a stream upon receiving, but that will be a
 larger change.

 Will merge to 'next'.


* jk/send-pack-many-refspecs (2014-08-26) 1 commit
 - send-pack: take refspecs over stdin

 The number of refs that can be pushed at once over smart HTTP was
 limited by the command line length.  The limitation has been lifted
 by passing these refs from the standard input of send-pack.

 Will merge to 'next'.


* jp/index-with-corrupt-stages (2014-08-29) 2 commits
 - read_index_unmerged(): remove unnecessary loop index adjustment
 - read_index_from(): catch out of order entries when reading an index file

 A broken reimplementation of Git could write an invalid index that
 records both stage #0 and higher stage entries for the same path.
 Notice and reject such an index, as there is no sensible fallback
 (we do not know if the broken tool wanted to resolve and forgot to
 remove higher stage entries, or if it wanted to unresolve and
 forgot to remove the stage#0 entry).

 Will merge to 'next'.


* mb/build-contrib-svn-fe (2014-08-28) 1 commit
 - contrib/svn-fe: fix Makefile

 Will merge to 'next'.


* mb/fast-import-delete-root (2014-08-29) 2 commits
 - fast-import: fix segfault in store_tree()
 - t9300: test filedelete command

 An attempt to remove the entire tree in the "git fast-import" input
 stream caused it to misbehave.

 Will merge to 'next'.


* ah/grammofix (2014-09-02) 1 commit
 - grammofix in user-facing messages

 Will merge to 'next'.


* da/styles (2014-09-02) 1 commit
 - stylefix: asterisks stick to the variable, not the type

 Will merge to 'next'.


* da/use-rev-parse-verify-quiet-in-stash (2014-09-09) 1 commit
 - stash: prefer --quiet over shell redirection of the standard error stream

 Will merge to 'next'.


* mk/reachable-protect-detached-head (2014-09-03) 1 commit
 - reachable.c: add HEAD to reachability starting commits

 Will merge to 'next'.


* rs/merge-tree-simplify (2014-09-02) 1 commit
 - merge-tree: remove unused df_conflict arguments

 Code clean-up.

 Will merge to 'next'.


* rs/simplify-config-include (2014-09-02) 1 commit
 - config: simplify git_config_include()

 Code clean-up.

 Will merge to 'next'.


* rs/simplify-http-walker (2014-09-02) 1 commit
 - http-walker: simplify process_alternates_response() using strbuf

 Code clean-up.

 Will merge to 'next'.


* tb/crlf-tests (2014-09-02) 3 commits
 - MinGW: update tests to handle a native eol of crlf
 - Makefile: propagate NATIVE_CRLF to C
 - t0027: Tests for core.eol=native, eol=lf, eol=crlf

 Will merge to 'next'.


* ta/config-add-to-empty-or-true-fix (2014-08-18) 1 commit
  (merged to 'next' on 2014-08-29 at d219212)
 + make config --add behave correctly for empty and NULL values

 We may want to undo the "a^" bit along the lines of $gmane/255445


* sp/stream-clean-filter (2014-08-28) 6 commits
 - convert: stream from fd to required clean filter to reduce used address space
 - copy_fd(): do not close the input file descriptor
 - mmap_limit: introduce GIT_MMAP_LIMIT to allow testing expected mmap size
 - memory_limit: use git_env_ulong() to parse GIT_ALLOC_LIMIT
 - config.c: add git_env_ulong() to parse environment variable
 - convert: drop arguments other than 'path' from would_convert_to_git()

 Rerolled.  Comments & reviews?


* jc/push-cert (2014-09-08) 22 commits
 - signed push: allow stale nonce in stateless mode
 - signed push: fortify against replay attacks
 - signed push: add "pushee" header to push certificate
 - signed push: remove duplicated protocol info
 - send-pack: send feature request on push-cert packet
 - receive-pack: GPG-validate push certificates
 - push: the beginning of "git push --signed"
 - pack-protocol doc: typofix for PKT-LINE
 - gpg-interface: move parse_signature() to where it should be
 - gpg-interface: move parse_gpg_output() to where it should be
 - send-pack: clarify that cmds_sent is a boolean
 - send-pack: refactor inspecting and resetting status and sending commands
 - send-pack: rename "new_refs" to "need_pack_data"
 - receive-pack: factor out capability string generation
 - send-pack: factor out capability string generation
 - send-pack: always send capabilities
 - send-pack: refactor decision to send update per ref
 - send-pack: move REF_STATUS_REJECT_NODELETE logic a bit higher
 - receive-pack: factor out queueing of command
 - receive-pack: do not reuse old_sha1[] for other things
 - receive-pack: parse feature request a bit earlier
 - receive-pack: do not overallocate command structure

 Allow "git push" request to be signed, so that it can be verified
 audited, using the GPG signature of the person who pushed, that the
 tips of branches at a public repository really point the commits
 the pusher wanted to, without having to "trust" the server.

 Comments & reviews?


* jc/test-lazy-prereq (2014-06-13) 1 commit
 - tests: drop GIT_*_TIMING_TESTS environment variable support

 Test-script clean-up.

 Comments & reviews?
 Otherwise will merge to 'next'.


* mt/patch-id-stable (2014-06-10) 1 commit
 - patch-id: change default to stable

 Teaches "git patch-id" to compute the patch ID that does not change
 when the files in a single patch is reordered. As this new algorithm
 is backward incompatible, the last bit to flip it to be the default
 is left out of 'master' for now.

 Nobody seems to be jumping up & down requesting this last step.
 Perhaps will drop.
