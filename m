From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2014, #03; Wed, 16)
Date: Wed, 16 Jul 2014 15:01:32 -0700
Message-ID: <xmqqwqbdq7yb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:01:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7XGk-0004oh-UJ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbaGPWBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:01:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55447 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbaGPWBk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:01:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3FE82A5C4;
	Wed, 16 Jul 2014 18:01:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=r
	m20i2vwgZHNaCqZnSrqfUEh7cc=; b=RKjhpfp/z5OTwtlVw8TkkbjAbLFmSrPck
	m60/Eu0h0FY4Sh4Ne9J73MOMBNwGNgfsNPlAhTRswPNOJqmj4kQGywF/tEAhxVqH
	ZMgfjzO8lnEAfINfEEMorcJqr2Mu5Iau0Nsf2wqhyGQrRzzvMOhaqOKFL2BOLq4o
	ROOC5EY6/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=jOG
	OTjDz45neOUEdG8x2pxfr99vdRNqce35yuKlK8iB75JmJVjc42/EhNdoFPNsR+UN
	jshtKa7HaZerbsiT37acpBUe++z0MpScBcIFGMl2xQhzVfpOmI2XpBA2gYIkD2Qd
	YI6u4lNgfsmrK8p+O4Eb2iQk+QRlC3ub11ebOE/4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CA42E2A5C3;
	Wed, 16 Jul 2014 18:01:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E62B32A5BF;
	Wed, 16 Jul 2014 18:01:33 -0400 (EDT)
X-master-at: f2c9f21369931c2e4254e49d8f3b3fac5ba8a60b
X-next-at: 90283d95492651270a8e9db89e85c40d47c28585
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C00D9750-0D34-11E4-B3D3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253697>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

We would need to start slowing down to prepare for -rc0 preview at
the end of this week and then feature freeze.  Some topics that
joined 'next' late may want to stay there for the remainder of this
cycle.  Many of the accumulated fixes have been flushed to 'maint'
and Git 2.0.2 has been tagged.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ek/alt-odb-entry-fix (2014-07-15) 1 commit
 - sha1_file: do not add own object directory as alternate

 Will merge to 'next'.


* jk/rebase-am-fork-point (2014-07-16) 2 commits
 - rebase: omit patch-identical commits with --fork-point
 - rebase--am: use --cherry-pick instead of --ignore-if-in-upstream

 Will merge to 'next'.


* jk/stable-prio-queue (2014-07-15) 4 commits
 - t5539: update a flaky test
 - paint_down_to_common: use prio_queue
 - prio-queue: make output stable with respect to insertion
 - prio-queue: factor out compare and swap operations


* jk/tag-sort (2014-07-13) 2 commits
 - tag: support configuring --sort via .gitconfig
 - tag: fix --sort tests to use cat<<-\EOF format

 v10 ($gmane/253695) needs to be picked up and replace these.


* nd/path-max-must-go (2014-07-14) 3 commits
  (merged to 'next' on 2014-07-15 at ce68dde)
 + prep_exclude: remove the artificial PATH_MAX limit
 + dir.h: move struct exclude declaration to top level
 + dir.c: coding style fix

 Will merge to 'master'.


* sk/mingw-uni-fix (2014-07-15) 3 commits
 - tests: do not pass iso8859-1 encoded parameter
 - Win32: Unicode file name support (dirent)
 - Win32: Unicode file name support (except dirent)

 Will merge to 'next'.


* ta/config-set (2014-07-15) 2 commits
 - test-config: add tests for the config_set API
 - add `config_set` API for caching config-like files

 Still being discussed.


* kb/avoid-fchmod-for-now (2014-07-16) 1 commit
 - config: use chmod() instead of fchmod()

 Replaces the only two uses of fchmod() with chmod() because the
 former does not work on Windows port and because luckily we can.


* rs/ref-transaction-1 (2014-07-16) 20 commits
 - refs.c: make delete_ref use a transaction
 - refs.c: make prune_ref use a transaction to delete the ref
 - refs.c: remove lock_ref_sha1
 - refs.c: remove the update_ref_write function
 - refs.c: remove the update_ref_lock function
 - refs.c: make lock_ref_sha1 static
 - walker.c: use ref transaction for ref updates
 - fast-import.c: use a ref transaction when dumping tags
 - receive-pack.c: use a reference transaction for updating the refs
 - refs.c: change update_ref to use a transaction
 - branch.c: use ref transaction for all ref updates
 - fast-import.c: change update_branch to use ref transactions
 - sequencer.c: use ref transactions for all ref updates
 - commit.c: use ref transactions for updates
 - replace.c: use the ref transaction functions for updates
 - tag.c: use ref transactions when doing updates
 - refs.c: add transaction.status and track OPEN/CLOSED/ERROR
 - refs.c: make ref_transaction_begin take an err argument
 - refs.c: update ref_transaction_delete to check for error and return status
 - refs.c: change ref_transaction_create to do error checking and return status
 (this branch is used by rs/ref-transaction; uses rs/ref-transaction-0.)

 The second batch of the transactional ref update series.


* rs/unify-is-branch (2014-07-16) 1 commit
 - refs.c: add a public is_branch function

 Will merge to 'next'.

--------------------------------------------------
[Graduated to "master"]

* ah/fix-http-push (2014-07-13) 1 commit
  (merged to 'next' on 2014-07-14 at 5d06516)
 + http-push.c: make CURLOPT_IOCTLDATA a usable pointer

 An ancient rewrite passed a wrong pointer to a curl library
 function in a rarely used code path.


* cb/filter-branch-prune-empty-degenerate-merges (2014-07-01) 1 commit
  (merged to 'next' on 2014-07-10 at 860cfea)
 + filter-branch: eliminate duplicate mapped parents

 "filter-branch" left an empty single-parent commit that results when
 all parents of a merge commit gets mapped to the same commit, even
 under "--prune-empty".


* cc/replace-edit (2014-06-25) 3 commits
  (merged to 'next' on 2014-07-10 at 097cd5e)
 + replace: use argv_array in export_object
 + avoid double close of descriptors handed to run_command
 + replace: replace spaces with tabs in indentation
 (this branch is used by jk/replace-edit-raw.)

 Teach "git replace" an "--edit" mode.


* ep/submodule-code-cleanup (2014-06-30) 1 commit
  (merged to 'next' on 2014-07-10 at d4de30a)
 + submodule.c: use the ARRAY_SIZE macro


* jk/replace-edit-raw (2014-06-25) 1 commit
  (merged to 'next' on 2014-07-10 at b934bb0)
 + replace: add a --raw mode for --edit
 (this branch uses cc/replace-edit.)

 Teach "git replace --edit" mode a "--raw" option to allow
 editing the bare-metal representation data of objects.


* jk/skip-prefix (2014-07-10) 1 commit
  (merged to 'next' on 2014-07-14 at 0fbd06e)
 + tag: use skip_prefix instead of magic numbers
 (this branch is used by jk/tag-sort.)

 One more to an already graduated topic.


* jk/strip-suffix (2014-06-30) 9 commits
  (merged to 'next' on 2014-07-10 at e6cfa29)
 + prepare_packed_git_one: refactor duplicate-pack check
 + verify-pack: use strbuf_strip_suffix
 + strbuf: implement strbuf_strip_suffix
 + index-pack: use strip_suffix to avoid magic numbers
 + use strip_suffix instead of ends_with in simple cases
 + replace has_extension with ends_with
 + implement ends_with via strip_suffix
 + add strip_suffix function
 + sha1_file: replace PATH_MAX buffer with strbuf in prepare_packed_git_one()


* jl/test-lint-scripts (2014-07-10) 2 commits
  (merged to 'next' on 2014-07-14 at c03721c)
 + t/Makefile: always test all lint targets when running tests
 + t/Makefile: check helper scripts for non-portable shell commands too


* mg/fix-log-mergetag-color (2014-07-10) 1 commit
  (merged to 'next' on 2014-07-14 at e90dba1)
 + log: correctly identify mergetag signature verification status


* mk/merge-incomplete-files (2014-06-30) 2 commits
  (merged to 'next' on 2014-07-10 at d1115f4)
 + git-merge-file: do not add LF at EOF while applying unrelated change
 + t6023-merge-file.sh: fix and mark as broken invalid tests

 Merging changes into a file that ends in an incomplete line made the
 last line into a complete one, even when the other branch did not
 change anything around the end of file.


* nd/split-index (2014-06-13) 32 commits
  (merged to 'next' on 2014-07-08 at 49325ef)
 + t1700: new tests for split-index mode
 + t2104: make sure split index mode is off for the version test
 + read-cache: force split index mode with GIT_TEST_SPLIT_INDEX
 + read-tree: note about dropping split-index mode or index version
 + read-tree: force split-index mode off on --index-output
 + rev-parse: add --shared-index-path to get shared index path
 + update-index --split-index: do not split if $GIT_DIR is read only
 + update-index: new options to enable/disable split index mode
 + split-index: strip pathname of on-disk replaced entries
 + split-index: do not invalidate cache-tree at read time
 + split-index: the reading part
 + split-index: the writing part
 + read-cache: mark updated entries for split index
 + read-cache: save deleted entries in split index
 + read-cache: mark new entries for split index
 + read-cache: split-index mode
 + read-cache: save index SHA-1 after reading
 + entry.c: update cache_changed if refresh_cache is set in checkout_entry()
 + cache-tree: mark istate->cache_changed on prime_cache_tree()
 + cache-tree: mark istate->cache_changed on cache tree update
 + cache-tree: mark istate->cache_changed on cache tree invalidation
 + unpack-trees: be specific what part of the index has changed
 + resolve-undo: be specific what part of the index has changed
 + update-index: be specific what part of the index has changed
 + read-cache: be specific what part of the index has changed
 + read-cache: be strict about "changed" in remove_marked_cache_entries()
 + read-cache: store in-memory flags in the first 12 bits of ce_flags
 + read-cache: relocate and unexport commit_locked_index()
 + read-cache: new API write_locked_index instead of write_index/write_cache
 + sequencer: do not update/refresh index if the lock cannot be held
 + ewah: delete unused ewah_read_mmap_native declaration
 + ewah: fix constness of ewah_read_mmap
 (this branch is used by jc/reopen-lock-file.)

 An experiment to use two files (the base file and incremental
 changes relative to it) to represent the index to reduce I/O cost
 of rewriting a large index when only small part of the working tree
 changes.


* po/error-message-style (2014-07-10) 1 commit
  (merged to 'next' on 2014-07-14 at ed17678)
 + doc: give some guidelines for error messages


* rs/code-cleaning (2014-07-10) 5 commits
  (merged to 'next' on 2014-07-14 at d5a89c8)
 + fsck: simplify fsck_commit_buffer() by using commit_list_count()
 + commit: use commit_list_append() instead of duplicating its code
 + merge: simplify merge_trivial() by using commit_list_append()
 + use strbuf_addch for adding single characters
 + use strbuf_addbuf for adding strbufs


* tb/crlf-tests (2014-07-08) 2 commits
  (merged to 'next' on 2014-07-08 at 40764b7)
 + t0027: combinations of core.autocrlf, core.eol and text
 + t0025: rename the test files


* zk/log-graph-showsig (2014-07-09) 1 commit
  (merged to 'next' on 2014-07-14 at 4429c2e)
 + log: fix indentation for --graph --show-signature

 The "--show-signature" option did not pay much attention to
 "--graph".

--------------------------------------------------
[Stalled]

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

 What is the status of this one?  I think I saw reviews by Michael
 but after that I do not recall seeing any updates.


* mh/lockfile (2014-04-15) 25 commits
 . trim_last_path_elm(): replace last_path_elm()
 . resolve_symlink(): take a strbuf parameter
 . resolve_symlink(): use a strbuf for internal scratch space
 . change lock_file::filename into a strbuf
 . commit_lock_file(): use a strbuf to manage temporary space
 . try_merge_strategy(): use a statically-allocated lock_file object
 . try_merge_strategy(): remove redundant lock_file allocation
 . struct lock_file: declare some fields volatile
 . lockfile: avoid transitory invalid states
 . commit_lock_file(): die() if called for unlocked lockfile object
 . commit_lock_file(): inline temporary variable
 . remove_lock_file(): call rollback_lock_file()
 . lock_file(): exit early if lockfile cannot be opened
 . write_packed_entry_fn(): convert cb_data into a (const int *)
 . prepare_index(): declare return value to be (const char *)
 . delete_ref_loose(): don't muck around in the lock_file's filename
 . cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
 . lockfile.c: document the various states of lock_file objects
 . lock_file(): always add lock_file object to lock_file_list
 . hold_lock_file_for_append(): release lock on errors
 . lockfile: unlock file if lockfile permissions cannot be adjusted
 . rollback_lock_file(): set fd to -1
 . rollback_lock_file(): do not clear filename redundantly
 . api-lockfile: expand the documentation
 . unable_to_lock_die(): rename function from unable_to_lock_index_die()

 Ejected from 'pu' to unclutter.
 Expecting a reroll.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


* tr/merge-recursive-index-only (2014-02-05) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()
 (this branch is used by tr/remerge-diff.)


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


* jh/submodule-tests (2014-04-17) 1 commit
 - t7410: 210 tests for various 'git submodule update' scenarios

 More or less abandoned.  Will drop.

--------------------------------------------------
[Cooking]

* jc/reopen-lock-file (2014-07-14) 1 commit
 - lockfile: allow reopening a closed but still locked file

 Needed in the "commit -p" code path to update the cache tree in the
 index.


* jk/alloc-commit-id (2014-07-13) 8 commits
  (merged to 'next' on 2014-07-16 at f14c01a)
 + diff-tree: avoid lookup_unknown_object
 + object_as_type: set commit index
 + alloc: factor out commit index
 + add object_as_type helper for casting objects
 + parse_object_buffer: do not set object type
 + move setting of object->type to alloc_* functions
 + alloc: write out allocator definitions
 + alloc.c: remove the alloc_raw_commit_node() function

 Make sure all in-core commit objects are assigned a unique number
 so that they can be annotated using the commit-slab API.

 Will merge to 'master'.


* jk/remote-curl-squelch-extra-errors (2014-07-10) 3 commits
  (merged to 'next' on 2014-07-14 at a2efa2f)
 + remote-curl: mark helper-protocol errors more clearly
 + remote-curl: use error instead of fprintf(stderr)
 + remote-curl: do not complain on EOF from parent git

 Will merge to 'master'.


* rs/ref-transaction-0 (2014-07-14) 19 commits
  (merged to 'next' on 2014-07-14 at b21bcee)
 + refs.c: change ref_transaction_update() to do error checking and return status
 + refs.c: remove the onerr argument to ref_transaction_commit
 + update-ref: use err argument to get error from ref_transaction_commit
 + refs.c: make update_ref_write update a strbuf on failure
 + refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
 + refs.c: log_ref_write should try to return meaningful errno
 + refs.c: make resolve_ref_unsafe set errno to something meaningful on error
 + refs.c: commit_packed_refs to return a meaningful errno on failure
 + refs.c: make remove_empty_directories always set errno to something sane
 + refs.c: verify_lock should set errno to something meaningful
 + refs.c: make sure log_ref_setup returns a meaningful errno
 + refs.c: add an err argument to repack_without_refs
 + lockfile.c: make lock_file return a meaningful errno on failurei
 + lockfile.c: add a new public function unable_to_lock_message
 + refs.c: add a strbuf argument to ref_transaction_commit for error logging
 + refs.c: allow passing NULL to ref_transaction_free
 + refs.c: constify the sha arguments for ref_transaction_create|delete|update
 + refs.c: ref_transaction_commit should not free the transaction
 + refs.c: remove ref_transaction_rollback
 (this branch is used by rs/ref-transaction and rs/ref-transaction-1.)

 Early part of the "ref transaction" topic.
 Will merge to 'master'.


* nd/multiple-work-trees (2014-07-14) 31 commits
 - checkout: don't require a work tree when checking out into a new one
 - git_path(): keep "info/sparse-checkout" per work-tree
 - count-objects: report unused files in $GIT_DIR/repos/...
 - gc: support prune --repos
 - gc: factor out gc.pruneexpire parsing code
 - gc: style change -- no SP before closing parenthesis
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

 Will merge to 'next' and cook there for a while.


* ak/profile-feedback-build (2014-07-08) 4 commits
  (merged to 'next' on 2014-07-14 at c40e86e)
 + Fix profile feedback with -jN and add profile-fast
 + Run the perf test suite for profile feedback too
 + Don't define away __attribute__ on gcc
 + Use BASIC_FLAGS for profile feedback

 Will merge to 'master'.


* cc/for-each-mergetag (2014-07-07) 1 commit
  (merged to 'next' on 2014-07-15 at c5dd3ee)
 + commit: add for_each_mergetag()
 (this branch is used by cc/replace-graft.)

 Will merge to 'master'.


* dt/cache-tree-repair (2014-07-14) 4 commits
 - cache-tree: Write updated cache-tree after commit
 - cache-tree: subdirectory tests
 - test-dump-cache-tree: invalid trees are not errors
 - cache-tree: create/update cache-tree on checkout

 Add a few more places in "commit" and "checkout" that make sure
 that the cache-tree is fully populated in the index.

 Will merge to 'next'.


* kb/hashmap-updates (2014-07-07) 4 commits
  (merged to 'next' on 2014-07-15 at 6dd6611)
 + hashmap: add string interning API
 + hashmap: add simplified hashmap_get_from_hash() API
 + hashmap: improve struct hashmap member documentation
 + hashmap: factor out getting a hash code from a SHA1

 Will merge to 'master'.


* cc/replace-graft (2014-07-07) 9 commits
 - replace: add test for --graft with a mergetag
 - replace: check mergetags when using --graft
 - replace: add test for --graft with signed commit
 - replace: remove signature when using --graft
 - contrib: add convert-grafts-to-replace-refs.sh
 - Documentation: replace: add --graft option
 - replace: add test for --graft
 - replace: add --graft option
 - replace: cleanup redirection style in tests
 (this branch uses cc/for-each-mergetag.)

 "git replace" learned a "--graft" option to rewrite parents of a
 commit.


* kb/perf-trace (2014-07-13) 17 commits
  (merged to 'next' on 2014-07-15 at 09ade08)
 + api-trace.txt: add trace API documentation
 + progress: simplify performance measurement by using getnanotime()
 + wt-status: simplify performance measurement by using getnanotime()
 + git: add performance tracing for git's main() function to debug scripts
 + trace: add trace_performance facility to debug performance issues
 + trace: add high resolution timer function to debug performance issues
 + trace: add 'file:line' to all trace output
 + trace: move code around, in preparation to file:line output
 + trace: add current timestamp to all trace output
 + trace: disable additional trace output for unit tests
 + trace: add infrastructure to augment trace output with additional info
 + sha1_file: change GIT_TRACE_PACK_ACCESS logging to use trace API
 + Documentation/git.txt: improve documentation of 'GIT_TRACE*' variables
 + trace: improve trace performance
 + trace: remove redundant printf format attribute
 + trace: consistently name the format parameter
 + trace: move trace declarations from cache.h to new trace.h

 Will merge to 'master'.


* hv/submodule-config (2014-06-30) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names

 Will merge to 'next' and cook there for a while.


* jl/submodule-tests (2014-07-14) 14 commits
  (merged to 'next' on 2014-07-14 at 0c750bb)
 + revert: add t3513 for submodule updates
 + stash: add t3906 for submodule updates
 + am: add t4255 for submodule updates
 + cherry-pick: add t3512 for submodule updates
 + pull: add t5572 for submodule updates
 + rebase: add t3426 for submodule updates
 + merge: add t7613 for submodule updates
 + bisect: add t6041 for submodule updates
 + reset: add t7112 for submodule updates
 + read-tree: add t1013 for submodule updates
 + apply: add t4137 for submodule updates
 + checkout: call the new submodule update test framework
 + submodules: add the lib-submodule-update.sh test library
 + test-lib: add test_dir_is_empty()

 Will merge to 'master'.


* rs/ref-transaction (2014-07-16) 9 commits
 - refs.c: make write_ref_sha1 static
 - fetch.c: change s_update_ref to use a ref transaction
 - refs.c: propagate any errno==ENOTDIR from _commit back to the callers
 - refs.c: pass a skip list to name_conflict_fn
 - refs.c: call lock_ref_sha1_basic directly from commit
 - refs.c: move the check for valid refname to lock_ref_sha1_basic
 - refs.c: pass NULL as *flags to read_ref_full
 - refs.c: pass the ref log message to _create/delete/update instead of _commit
 - refs.c: add an err argument to delete_ref_loose
 (this branch uses rs/ref-transaction-0 and rs/ref-transaction-1.)


* jc/test-lazy-prereq (2014-06-13) 1 commit
 - tests: drop GIT_*_TIMING_TESTS environment variable support

 Test-script clean-up.

 Will hold.


* mt/patch-id-stable (2014-06-10) 1 commit
 - patch-id: change default to stable

 Teaches "git patch-id" to compute the patch ID that does not change
 when the files in a single patch is reordered. As this new algorithm
 is backward incompatible, the last bit to flip it to be the default
 is left out of 'master' for now.

 Will hold.
