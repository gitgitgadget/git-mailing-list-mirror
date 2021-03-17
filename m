Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF87C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 22:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD1364F18
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 22:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhCQWV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 18:21:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56577 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhCQWVH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 18:21:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70063A57A9;
        Wed, 17 Mar 2021 18:21:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=U
        bk64jnW8Gk2PD2zqH4KCuSL53g=; b=HbbeklEejqZK8ieedTLRgMhH0pHzW6gh/
        QLiQDibkkwE45ifGA9mPsqvhZh0U+paR5NbTozDUzprbz+Zobf2pDmsPXmK/oF3D
        H2AW+dt/8qBAW6VePjDpbK53zCD37DGCbhVQFRUqljfcq5zeRhWxLCVNMH2kQuY5
        vD5So28OtI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Qjg
        jFQof1udPWHryPLHvMud+xeiHeyku4mcVPOBwBfsi58qBp2H0lbutJWmzirSPn8I
        HBKaFlvJVVXSpAXVZ7vSvJgGwieOTG4D6r88bPNvME9S4Eo5nL3yPrhq5iwzCllL
        M8uC/R7N5rvlBCEI8bZsX+hs3F1nFGDcwlyw0I+g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66CC2A57A5;
        Wed, 17 Mar 2021 18:21:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF0E0A57A3;
        Wed, 17 Mar 2021 18:21:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2021, #05; Wed, 17)
X-master-at: a5828ae6b52137b913b978e16cd2334482eb4c1f
X-next-at: 576ba9dcdaf1007243f5a5cb4bf1a1e7b8fcf850
Date:   Wed, 17 Mar 2021 15:21:05 -0700
Message-ID: <xmqqblbhtoa6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10CE6802-876F-11EB-B118-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Git 2.31 has been tagged.  We will hopefully either (1) not see
brown-paper-bag breakages at all, or (2) will see some but can
immediately deal with them, in coming couple of days.  After that,
the 2.32 cycle will gain steam, starting next week.  Let's see.

Many topics marked as "Will cook in 'next'" should be marked for
merging to 'master' now, but that hasn't happened yet.  Please
nominate those that should be kicked back from 'next' to 'seen', if
there are any.  Please also nominate those that should be among the
first batch of topics to be in 'master' (after a handful of 2.31
regression fixes go through 'next' down to 'master', that is).

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-vcs/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[New Topics]

* jc/calloc-fix (2021-03-15) 1 commit
 - xcalloc: use CALLOC_ARRAY() when applicable

 Code clean-up.

 Will merge to 'next'.


* ab/tree-walk-with-object-type (2021-03-17) 32 commits
 - tree-walk.h API: add a tree_entry_extract_type() function
 - blame: emit a better error on 'git blame directory'
 - tree-walk.h API: add a get_tree_entry_path() function
 - tree-walk.h API: add get_tree_entry_all()
 - tree-walk.h API: add a tree_entry_extract_all() function
 - tree-entry.h API: rename tree_entry_extract() to tree_entry_extract_mode()
 - tree-walk.h API: document and format tree_entry_extract()
 - tree-walk.h API: add get_tree_entry_type()
 - match-trees: use "tmp" for mode in shift_tree_by()
 - tree-walk.h API: rename get_tree_entry() to get_tree_entry_mode()
 - tree-walk.h API: formatting changes for subsequent commit
 - tree-walk.h users: use temporary variable(s) for "mode"
 - fsck.c: switch on "object_type" in fsck_walk_tree()
 - merge-ort: correct reference to test in 62fdec17a11
 - merge-tree tests: test for the mode comparison in same_entry()
 - tree-walk.h users: migrate miscellaneous "mode" to "object_type"
 - tree-walk.h users: refactor chained "mode" if/else into switch
 - tree-walk.h users: migrate "p->mode &&" pattern
 - tree.h API: make read_tree_fn_t take an "enum object_type"
 - archive: get rid of 'stage' parameter
 - tree.h users: format argument lists in archive.c
 - tree.h: format argument lists of read_tree_recursive() users
 - tree-walk.h users: switch object_type(...) to new .object_type
 - cache.h: have base_name_compare() take "is tree?", not "mode"
 - diff tests: test that "mode" is passed when sorting
 - mktree tests: test that "mode" is passed when sorting
 - fast-import tests: test for sorting dir/file foo v.s. foo.txt
 - tree-walk.c: migrate to using new "object_type" field when possible
 - tree-walk.h: add object_type member to name_entry
 - cache.h: add a comment to object_type()
 - notes & match-trees: use name_entry's "pathlen" member
 - diff.c: remove redundant canon_mode() call
 (this branch uses ab/read-tree.)

 Code clean-up.

 I am not exactly sure where this series wants to go, other than
 unnecessarily churning the code.  Seems to break "diff --no-index"
 rather badly, too (e.g. t4050, t4002, among others).


* jh/fsmonitor-prework (2021-03-17) 1 commit
 - fsmonitor: avoid global-buffer-overflow READ when checking trivial response

 The fsmonitor interface read from its input without making sure
 there is something to read from.  This bug is new in 2.31
 timeframe.

 Will merge to 'next'.


* jk/bisect-peel-tag-fix (2021-03-17) 1 commit
 - bisect: peel annotated tags to commits

 "git bisect" reimplemented more in C during 2.30 timeframe did not
 take an annotated tag as a good/bad endpoint well.  This regression
 has been corrected.

 Will merge to 'next'.


* js/fsmonitor-unpack-fix (2021-03-17) 2 commits
 - fsmonitor: do not forget to release the token in `discard_index()`
 - fsmonitor: fix memory corruption in some corner cases

 The data structure used by fsmonitor interface was not properly
 duplicated during an in-core merge, leading to use-after-free etc.

 Will merge to 'next'.


* jt/clone-unborn-head (2021-03-17) 1 commit
 - t5606: run clone branch name test with protocol v2

 Test fix.

 Will merge to 'next'.


* km/config-doc-typofix (2021-03-17) 1 commit
 - config.txt: add missing period

 Docfix.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* mt/parallel-checkout-part-1 (2020-12-16) 9 commits
 - entry: add checkout_entry_ca() taking preloaded conv_attrs
 - entry: move conv_attrs lookup up to checkout_entry()
 - entry: extract update_ce_after_write() from write_entry()
 - entry: make fstat_output() and read_blob_entry() public
 - entry: extract a header file for entry.c functions
 - convert: add classification for conv_attrs struct
 - convert: add get_stream_filter_ca() variant
 - convert: add [async_]convert_to_working_tree_ca() variants
 - convert: make convert_attrs() and convert structs public

 Parallel checkout.

 Looking good.


* ag/merge-strategies-in-c (2021-03-15) 14 commits
 - SQUASH??? CALLOC_ARRAY()
 - sequencer: use the "octopus" merge strategy without forking
 - sequencer: use the "resolve" strategy without forking
 - merge: use the "octopus" strategy without forking
 - merge: use the "resolve" strategy without forking
 - merge-octopus: rewrite in C
 - merge-recursive: move better_branch_name() to merge.c
 - merge-resolve: rewrite in C
 - merge-index: don't fork if the requested program is `git-merge-one-file'
 - merge-index: libify merge_one_path() and merge_all()
 - merge-one-file: rewrite in C
 - update-index: move add_cacheinfo() to read-cache.c
 - t6060: modify multiple files to expose a possible issue with merge-index
 - t6407: modernise tests

 The resolve and octopus merge strategy backends have been rewritten
 in C.

 Got enough review comments to get updated.

--------------------------------------------------
[Cooking]

* ab/fsck-api-cleanup (2021-03-17) 19 commits
 - fetch-pack: use new fsck API to printing dangling submodules
 - fetch-pack: use file-scope static struct for fsck_options
 - fetch-pack: don't needlessly copy fsck_options
 - fsck.c: move gitmodules_{found,done} into fsck_options
 - fsck.c: add an fsck_set_msg_type() API that takes enums
 - fsck.c: pass along the fsck_msg_id in the fsck_error callback
 - fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
 - fsck.c: give "FOREACH_MSG_ID" a more specific name
 - fsck.c: undefine temporary STR macro after use
 - fsck.c: call parse_msg_type() early in fsck_set_msg_type()
 - fsck.h: re-order and re-assign "enum fsck_msg_type"
 - fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
 - fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
 - fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
 - fsck.c: move definition of msg_id into append_msg_id()
 - fsck.c: rename variables in fsck_set_msg_type() for less confusion
 - fsck.h: use "enum object_type" instead of "int"
 - fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
 - fsck.c: refactor and rename common config callback

 Fsck API clean-up.
 cf. <20210317182054.5986-1-avarab@gmail.com>


* en/ort-perf-batch-9 (2021-03-10) 8 commits
 - diffcore-rename: avoid doing basename comparisons for irrelevant sources
 - merge-ort: skip rename detection entirely if possible
 - merge-ort: use relevant_sources to filter possible rename sources
 - merge-ort: precompute whether directory rename detection is needed
 - merge-ort: introduce wrappers for alternate tree traversal
 - merge-ort: add data structures for an alternate tree traversal
 - merge-ort: precompute subset of sources for which we need rename detection
 - diffcore-rename: enable filtering possible rename sources
 (this branch uses en/ort-perf-batch-8.)

 More ort.

 Ready?


* js/http-pki-credential-store (2021-03-11) 2 commits
 - http: drop the check for an empty proxy password before approving
 - http: store credential when PKI auth is used

 The http codepath learned to let the credential layer to cache the
 password used to unlock a certificate that has successfully been
 used.

 Will merge to 'next'.


* rs/avoid-null-statement-after-macro-call (2021-03-17) 2 commits
 - mem-pool: drop trailing semicolon from macro definition
 - block-sha1: drop trailing semicolon from macro definition

 Fix macros that can silently inject unintended null-statements.

 Will merge to 'next'.


* rs/calloc-array (2021-03-15) 3 commits
 - cocci: allow xcalloc(1, size)
 - use CALLOC_ARRAY
 - git-compat-util.h: drop trailing semicolon from macro definition

 CALLOC_ARRAY() macro replaces many uses of xcalloc().

 Will merge to 'next'.


* jk/slimmed-down (2021-03-14) 1 commit
 - vcs-svn: remove header files as well

 Unused code removal.

 Will merge to 'next'.


* dl/stash-show-untracked (2021-03-05) 2 commits
  (merged to 'next' on 2021-03-08 at 510d4cfa5f)
 + stash show: learn stash.showIncludeUntracked
 + stash show: teach --include-untracked and --only-untracked

 "git stash show" learned to optionally show untracked part of the
 stash.

 Will cook in 'next'.


* hn/reftable (2021-03-12) 15 commits
 - Add "test-tool dump-reftable" command.
 - git-prompt: prepare for reftable refs backend
 - Reftable support for git-core
 - reftable: rest of library
 - reftable: reftable file level tests
 - reftable: read reftable files
 - reftable: write reftable files
 - reftable: a generic binary tree implementation
 - reftable: reading/writing blocks
 - reftable: (de)serialization for the polymorphic record type.
 - reftable: add blocksource, an abstraction for random access reads
 - reftable: utility functions
 - reftable: add error related functionality
 - reftable: add LICENSE
 - init-db: set the_repository->hash_algo early on

 The "reftable" backend for the refs API.


* ab/tests-cleanup-around-sha1 (2021-03-10) 4 commits
 - tests: get rid of $_x05 from the test suite
 - shortlog tests: rewrite to get rid of --abbrev=35 hardcoding
 - test-lib: remove unused $_x40 and $_z40 variables
 - git-bisect: remove unused SHA-1 $x40 shell variable

 Remove variables that hold regexp and glob that match fixed number
 of hexadecimal digits from the test suite.

 Expecting a reroll.
 At least the last one weakens a test and should be dropped; there
 may be similar breakage due to not understanding what they are
 trying to test.


* jk/filter-branch-sha256 (2021-03-10) 3 commits
  (merged to 'next' on 2021-03-14 at e4e624590a)
 + filter-branch: drop $_x40 glob
 + filter-branch: drop multiple-ancestor warning
 + t7003: test ref rewriting explicitly

 Code clean-up.

 Will cook in 'next'.
 In the longer term, we might want to remove filter-branch and nudge
 folks to more modern tools.


* ab/make-cocci-dedup (2021-03-12) 5 commits
 - Makefile/coccicheck: use --include-headers-for-types
 - Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
 - Makefile/coccicheck: allow for setting xargs concurrency
 - Makefile/coccicheck: speed up and fix bug with duplicate hunks
 - Makefile/coccicheck: add comment heading for all SPATCH flags

 Coccicheck update.

 Expecting a reroll.
 IIUC, the "speed up" claimed in the intermediate steps are all gone
 when correctness is brought back in with the last step.  The series
 needs a restructuring to avoid confuing readers with "it produces
 incorrect result very quickly" followed by "we now produce right
 result, even more correct than the original, but we are not all
 that fast" progression.


* ab/read-tree (2021-03-17) 9 commits
 - tree.h API: expose read_tree_1() as read_tree_at()
 - show tests: add test for "git show <tree>"
 - tree.h API: rename read_tree_recursive() to read_tree()
 - tree.h API: remove "stage" parameter from read_tree_recursive()
 - tree.h API: remove support for starting at prefix != ""
 - ls-files: refactor away read_tree()
 - ls-files: don't needlessly pass around stage variable
 - tree.c API: move read_tree() into builtin/ls-files.c
 - ls-files tests: add meaningful --with-tree tests
 (this branch is used by ab/tree-walk-with-object-type.)

 Code simplification by removing support for a caller that is long gone.

 Expecting a reroll.
 Mostly good, but the progression shows "oops we screwed up" earlier
 in the series that is then fixed later.


* ab/unexpected-object-type (2021-03-08) 7 commits
 - tag: don't misreport type of tagged objects in errors
 - object tests: add test for unexpected objects in tags
 - object.c: add a utility function for "expected type X, got Y"
 - tree.c: fix misindentation in parse_tree_gently()
 - oid_object_info(): return "enum object_type"
 - object.c: make type_from_string() return "enum object_type"
 - object.c: refactor type_from_string_gently()

 Error reporting upon object type mismatch has been improved

 Expecting a reroll.
 Looked good except for some rewrites.


* ah/make-fuzz-all-doc-update (2021-03-08) 1 commit
  (merged to 'next' on 2021-03-13 at e82816998f)
 + Makefile: update 'make fuzz-all' docs to reflect modern clang

 Update insn in Makefile comments to run fuzz-all target.

 Will cook in 'next'.


* ah/plugleaks (2021-03-14) 9 commits
 - transport: also free remote_refs in transport_disconnect()
 - parse-options: don't leak alias help messages
 - parse-options: convert bitfield values to use binary shift
 - init-db: silence template_dir leak when converting to absolute path
 - init: remove git_init_db_config() while fixing leaks
 - worktree: fix leak in dwim_branch()
 - clone: free or UNLEAK further pointers when finished
 - reset: free instead of leaking unneeded ref
 - symbolic-ref: don't leak shortened refname in check_symref()

 Plug or annotate remaining leaks that trigger while running the
 very basic set of tests.

 Ready?


* bc/clone-bare-with-conflicting-config (2021-03-10) 1 commit
  (merged to 'next' on 2021-03-14 at 963a86199c)
 + builtin/init-db: handle bare clones when core.bare set to false

 "git -c core.bare=false clone --bare ..." would have segfaulted,
 which has been corrected.

 Will cook in 'next'.


* dl/cat-file-doc-cleanup (2021-03-03) 2 commits
  (merged to 'next' on 2021-03-13 at f1a216175a)
 + git-cat-file.txt: remove references to "sha1"
 + git-cat-file.txt: monospace args, placeholders and filenames

 Doc cleanup.

 Will cook in 'next'.


* jr/doc-ignore-typofix (2021-03-03) 1 commit
  (merged to 'next' on 2021-03-13 at 0ce1e751b1)
 + doc: .gitignore documentation typofix

 Doc cleanup.

 Will cook in 'next'.


* rr/mailmap-entry-self (2021-03-08) 1 commit
  (merged to 'next' on 2021-03-13 at 9f98a99713)
 + Add entry for Ramkumar Ramachandra

 Will cook in 'next'.


* rs/xcalloc-takes-nelem-first (2021-03-08) 1 commit
  (merged to 'next' on 2021-03-14 at 312660a5ce)
 + fix xcalloc() argument order

 Code cleanup.

 Will cook in 'next'.


* sv/t9801-test-path-is-file-cleanup (2021-03-03) 1 commit
  (merged to 'next' on 2021-03-13 at 14997360bb)
 + t9801: replace test -f with test_path_is_file

 Test cleanup.

 Will cook in 'next'.


* tb/git-mv-icase-fix (2021-03-03) 1 commit
  (merged to 'next' on 2021-03-14 at 700e7556f1)
 + git mv foo FOO ; git mv foo bar gave an assert

 Fix a corner case bug in "git mv" on case insensitive systems,
 which was introduced in 2.29 timeframe.

 Will cook in 'next'.


* tb/push-simple-uses-branch-merge-config (2021-03-13) 1 commit
 - Documentation/git-push.txt: correct configuration typo

 Doc update.
 cf. <YEaM7ruZCvaQQbPI@nand.local>


* ab/remote-write-config-in-camel-case (2021-02-24) 2 commits
  (merged to 'next' on 2021-03-01 at a01bd0d8e4)
 + remote: write camel-cased *.pushRemote on rename
 + remote: add camel-cased *.tagOpt key, like clone

 Update C code that sets a few configuration variables when a remote
 is configured so that it spells configuration variable names in the
 canonical camelCase.

 Will cook in 'next'.


* ds/commit-graph-generation-config (2021-02-25) 2 commits
  (merged to 'next' on 2021-03-01 at 926537ea97)
 + commit-graph: use config to specify generation type
 + commit-graph: create local repository pointer

 A new configuration variable has been introduced to allow choosing
 which version of the generation number gets used in the
 commit-graph file.

 Will cook in 'next'.


* mt/cleanly-die-upon-missing-required-filter (2021-02-26) 1 commit
  (merged to 'next' on 2021-03-01 at 357954af7c)
 + convert: fail gracefully upon missing clean cmd on required filter

 We had a code to diagnose and die cleanly when a required
 clean/smudge filter is missing, but an assert before that
 unnecessarily fired, hiding the end-user facing die() message.

 Will cook in 'next'.


* ab/describe-tests-fix (2021-03-01) 10 commits
 - test-lib: return 1 from test_expect_{success,failure}
 - svn tests: refactor away a "set -e" in test body
 - svn tests: remove legacy re-setup from init-clone test
 - describe tests: support -C in "check_describe"
 - describe tests: fix nested "test_expect_success" call
 - describe tests: convert setup to use test_commit
 - test-lib functions: add an --annotated-tag option to "test_commit"
 - describe tests: always assert empty stderr from "describe"
 - describe tests: refactor away from glob matching
 - describe tests: improve test for --work-tree & --dirty

 Various updates to tests around "git describe"

 Expecting a reroll.
 cf.


* en/ort-perf-batch-8 (2021-02-26) 10 commits
  (merged to 'next' on 2021-03-07 at f03b2c1acd)
 + diffcore-rename: compute dir_rename_guess from dir_rename_counts
 + diffcore-rename: limit dir_rename_counts computation to relevant dirs
 + diffcore-rename: compute dir_rename_counts in stages
 + diffcore-rename: extend cleanup_dir_rename_info()
 + diffcore-rename: move dir_rename_counts into dir_rename_info struct
 + diffcore-rename: add function for clearing dir_rename_count
 + Move computation of dir_rename_count from merge-ort to diffcore-rename
 + diffcore-rename: add a mapping of destination names to their indices
 + diffcore-rename: provide basic implementation of idx_possible_rename()
 + diffcore-rename: use directory rename guided basename comparisons
 (this branch is used by en/ort-perf-batch-9.)

 Rename detection rework continues.

 Will cook in 'next'.


* jk/perf-in-worktrees (2021-02-26) 2 commits
  (merged to 'next' on 2021-03-02 at ea298cb298)
 + t/perf: avoid copying worktree files from test repo
 + t/perf: handle worktrees as test repos

 Perf test update to work better in secondary worktrees.

 Will cook in 'next'.


* ps/update-ref-trans-hook-doc (2021-03-01) 2 commits
  (merged to 'next' on 2021-03-14 at 41c418967d)
 + githooks.txt: clarify documentation on reference-transaction hook
 + githooks.txt: replace mentions of SHA-1 specific properties

 Doc update.

 Will cook in 'next'.


* zh/format-patch-fractional-reroll-count (2021-03-01) 1 commit
 - format-patch: allow a non-integral version numbers


* ab/make-cleanup (2021-02-23) 5 commits
 - Makefile: add {program,xdiff,test,git,fuzz}-objs & objects targets
 - Makefile: split OBJECTS into OBJECTS and GIT_OBJS
 - Makefile: sort OBJECTS assignment for subsequent change
 - Makefile: split up long OBJECTS line
 - Makefile: guard against TEST_OBJS in the environment

 Reorganize Makefile to allow building git.o and other essential
 objects without extra stuff needed only for testing.

 Will merge to 'next'.


* ab/grep-pcre2-allocfix (2021-02-17) 10 commits
  (merged to 'next' on 2021-03-04 at 26d2b726b1)
 + grep/pcre2: move definitions of pcre2_{malloc,free}
 + grep/pcre2: move back to thread-only PCREv2 structures
 + grep/pcre2: actually make pcre2 use custom allocator
 + grep/pcre2: use pcre2_maketables_free() function
 + grep/pcre2: use compile-time PCREv2 version test
 + grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug mode
 + grep/pcre2: prepare to add debugging to pcre2_malloc()
 + grep/pcre2: correct reference to grep_init() in comment
 + grep/pcre2: drop needless assignment to NULL
 + grep/pcre2: drop needless assignment + assert() on opt->pcre2

 Updates to memory allocation code around the use of pcre2 library.

 Will cook in 'next'.


* tb/reverse-midx (2021-03-11) 17 commits
 - midx.c: improve cache locality in midx_pack_order_cmp()
 - pack-revindex: write multi-pack reverse indexes
 - pack-write.c: extract 'write_rev_file_order'
 - pack-revindex: read multi-pack reverse indexes
 - Documentation/technical: describe multi-pack reverse indexes
 - midx: make some functions non-static
 - midx: keep track of the checksum
 - midx: don't free midx_name early
 - midx: allow marking a pack as preferred
 - t/helper/test-read-midx.c: add '--show-objects'
 - builtin/multi-pack-index.c: display usage on unrecognized command
 - builtin/multi-pack-index.c: don't enter bogus cmd_mode
 - builtin/multi-pack-index.c: split sub-commands
 - builtin/multi-pack-index.c: define common usage with a macro
 - builtin/multi-pack-index.c: don't handle 'progress' separately
 - builtin/multi-pack-index.c: inline 'flags' with options
 - Merge branch 'ds/chunked-file-api' into tb/reverse-midx

 An on-disk reverse-index to map the in-pack location of an object
 back to its object name across multiple packfiles is introduced.


* ab/pickaxe-pcre2 (2021-02-18) 24 commits
 - pickaxe -G: don't special-case create/delete
 - pickaxe -G: terminate early on matching lines
 - xdiff-interface: support early exit in xdiff_outf()
 - xdiff-interface: allow early return from xdiff_emit_{line,hunk}_fn
 - pickaxe -S: slightly optimize contains()
 - pickaxe: rename variables in has_changes() for brevity
 - pickaxe -S: support content with NULs under --pickaxe-regex
 - pickaxe: assert that we must have a needle under -G or -S
 - pickaxe: refactor function selection in diffcore-pickaxe()
 - perf: add performance test for pickaxe
 - pickaxe/style: consolidate declarations and assignments
 - diff.h: move pickaxe fields together again
 - pickaxe: die when --find-object and --pickaxe-all are combined
 - pickaxe: die when -G and --pickaxe-regex are combined
 - pickaxe tests: test for -G, -S and --find-object incompatibility
 - pickaxe tests: add test for "log -S" not being a regex
 - pickaxe tests: add test for diffgrep_consume() internals
 - pickaxe tests: refactor to use test_commit --append --printf
 - test-lib functions: add --printf option to test_commit
 - test-lib-functions: reword "test_commit --append" docs
 - test-lib-functions: document and test test_commit --no-tag
 - grep/pcre2 tests: reword comments referring to kwset
 - Merge branch 'jk/rev-list-disk-usage' into ab/pickaxe-pcre2
 - Merge branch 'ab/test-lib' into ab/pickaxe-pcre2

 Rewrite the backend for "diff -G/-S" to use pcre2 engine when
 available.


* cm/rebase-i-fixup-amend-reword (2021-03-15) 6 commits
 - doc/git-commit: add documentation for fixup=[amend|reword] options
 - t3437: use --fixup with options to create amend! commit
 - t7500: add tests for --fixup=[amend|reword] options
 - commit: add a reword suboption to --fixup
 - commit: add amend suboption to --fixup to create amend! commit
 - sequencer: export and rename subject_length()
 (this branch uses cm/rebase-i and cm/rebase-i-updates.)

 "git commit --fixup=<commit>", which was to tweak the changes made
 to the contents while keeping the original log message intact,
 learned "--fixup=(amend|reword):<commit>", that can be used to
 tweak both the message and the contents, and only the message,
 respectively.


* jk/open-dotgitx-with-nofollow (2021-02-16) 6 commits
  (merged to 'next' on 2021-02-25 at a784bf7be6)
 + mailmap: do not respect symlinks for in-tree .mailmap
 + exclude: do not respect symlinks for in-tree .gitignore
 + attr: do not respect symlinks for in-tree .gitattributes
 + exclude: add flags parameter to add_patterns()
 + attr: convert "macro_ok" into a flags field
 + add open_nofollow() helper

 It does not make sense to make ".gitattributes", ".gitignore" and
 ".mailmap" symlinks, as they are supposed to be usable from the
 object store (think: bare repositories where HEAD:.mailmap etc. are
 used).  When these files are symbolic links, we used to read the
 contents of the files pointed by them by mistake, which has been
 corrected.

 Will cook in 'next'.


* rs/pretty-describe (2021-03-11) 5 commits
  (merged to 'next' on 2021-03-12 at e987259477)
 + archive: expand only a single %(describe) per archive
  (merged to 'next' on 2021-03-01 at bee9248828)
 + pretty: document multiple %(describe) being inconsistent
 + t4205: assert %(describe) test coverage
  (merged to 'next' on 2021-02-25 at 2347ed8fe6)
 + pretty: add merge and exclude options to %(describe)
 + pretty: add %(describe)

 "git log --format='...'" learned "%(describe)" placeholder.

 Will cook in 'next'.


* cm/rebase-i-updates (2021-02-10) 11 commits
  (merged to 'next' on 2021-02-12 at e29227780b)
 + doc/rebase -i: fix typo in the documentation of 'fixup' command
 + t/t3437: fixup the test 'multiple fixup -c opens editor once'
 + t/t3437: use named commits in the tests
 + t/t3437: simplify and document the test helpers
 + t/t3437: check the author date of fixed up commit
 + t/t3437: remove the dependency of 'expected-message' file from tests
 + t/t3437: fixup here-docs in the 'setup' test
 + t/lib-rebase: update the documentation of FAKE_LINES
 + rebase -i: clarify and fix 'fixup -c' rebase-todo help
 + sequencer: rename a few functions
 + sequencer: fixup the datatype of the 'flag' argument
 (this branch is used by cm/rebase-i-fixup-amend-reword; uses cm/rebase-i.)

 Follow-up fixes to "cm/rebase-i" topic.

 Will cook in 'next', together with "cm/rebase-i".


* jh/simple-ipc (2021-03-15) 13 commits
 - SQUASH??? CALLOC_ARRAY()
 - t0052: add simple-ipc tests and t/helper/test-simple-ipc tool
 - simple-ipc: add Unix domain socket implementation
 - unix-stream-server: create unix domain socket under lock
 - unix-socket: disallow chdir() when creating unix domain sockets
 - unix-socket: add backlog size option to unix_stream_listen()
 - unix-socket: eliminate static unix_stream_socket() helper function
 - simple-ipc: add win32 implementation
 - simple-ipc: design documentation for new IPC mechanism
 - pkt-line: add options argument to read_packetized_to_strbuf()
 - pkt-line: add PACKET_READ_GENTLE_ON_READ_ERROR option
 - pkt-line: do not issue flush packets in write_packetized_*()
 - pkt-line: eliminate the need for static buffer in packet_write_gently()

 A simple IPC interface gets introduced to build services like
 fsmonitor on top.

 Will merge to 'next'.


* cm/rebase-i (2021-01-29) 9 commits
  (merged to 'next' on 2021-02-01 at 4f9aa6cec3)
 + doc/git-rebase: add documentation for fixup [-C|-c] options
 + rebase -i: teach --autosquash to work with amend!
 + t3437: test script for fixup [-C|-c] options in interactive rebase
 + rebase -i: add fixup [-C | -c] command
 + sequencer: use const variable for commit message comments
 + sequencer: pass todo_item to do_pick_commit()
 + rebase -i: comment out squash!/fixup! subjects from squash message
 + sequencer: factor out code to append squash message
 + rebase -i: only write fixup-message when it's needed
 (this branch is used by cm/rebase-i-fixup-amend-reword and cm/rebase-i-updates.)

 "rebase -i" is getting cleaned up and also enhanced.

 Will cook in 'next', together with "cm/rebase-i-updates".


* tb/geometric-repack (2021-03-05) 13 commits
  (merged to 'next' on 2021-03-08 at def1c48d43)
 + builtin/repack.c: reword comment around pack-objects flags
 + builtin/repack.c: be more conservative with unsigned overflows
 + builtin/repack.c: assign pack split later
 + t7703: test --geometric repack with loose objects
 + builtin/repack.c: do not repack single packs with --geometric
  (merged to 'next' on 2021-02-25 at a854fdbaff)
 + builtin/repack.c: add '--geometric' option
 + packfile: add kept-pack cache for find_kept_pack_entry()
 + builtin/pack-objects.c: rewrite honor-pack-keep logic
 + p5303: measure time to repack with keep
 + p5303: add missing &&-chains
 + builtin/pack-objects.c: add '--stdin-packs' option
 + revision: learn '--no-kept-objects'
 + packfile: introduce 'find_kept_pack_entry()'

 "git repack" so far has been only capable of repacking everything
 under the sun into a single pack (or split by size).  A cleverer
 strategy to reduce the cost of repacking a repository has been
 introduced.

 Will cook in 'next'.


* es/config-hooks (2021-03-10) 37 commits
 - docs: unify githooks and git-hook manpages
 - run-command: stop thinking about hooks
 - git-send-email: use 'git hook run' for 'sendemail-validate'
 - bugreport: use hook_exists instead of find_hook
 - receive-pack: convert receive hooks to hook.h
 - post-update: use hook.h library
 - proc-receive: acquire hook list from hook.h
 - receive-pack: convert 'update' hook to hook.h
 - reference-transaction: look for hooks in config
 - transport: convert pre-push hook to use config
 - hook: convert 'post-rewrite' hook to config
 - hooks: convert 'post-checkout' hook to hook library
 - git-p4: use 'git hook' to run hooks
 - receive-pack: convert push-to-checkout hook to hook.h
 - read-cache: convert post-index-change hook to use config
 - rebase: teach pre-rebase to use hook.h
 - gc: use hook library for pre-auto-gc hook
 - merge: use config-based hooks for post-merge hook
 - am: convert applypatch hooks to use config
 - commit: use config-based hooks
 - hooks: allow callers to capture output
 - run-command: allow capturing of collated output
 - hook: provide stdin by string_list or callback
 - run-command: add stdin callback for parallelization
 - hook: allow specifying working directory for hooks
 - hook: allow parallel hook execution
 - run-command: allow stdin for run_processes_parallel
 - hook: support passing stdin to hooks
 - hook: introduce hook_exists()
 - hook: add 'run' subcommand
 - parse-options: parse into strvec
 - hook: implement hookcmd.<name>.skip
 - hook: teach hook.runHookDir
 - hook: include hookdir hook in list
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.

 Looking good.

--------------------------------------------------
[Discarded]

* cw/pack-vs-bigfilethreashold (2021-02-09) 2 commits
 . fixup! doc: mention bigFileThreshold for packing
 . doc: mention bigFileThreshold for packing

 Doc update.

 cw/pack-config-doc supersedes this with a bit more coverage on
 related knobs.


* jh/simple-ipc-cleanups (2021-03-04) 9 commits
 - SQUASH???
 - simple-ipc: update design documentation with more details
 - test-simple-ipc: add --token=<token> string option
 - test-simple-ipc: refactor command line option processing in helper
 - unix-stream-server: add st_dev and st_mode to socket stolen checks
 - simple-ipc: move error handling up a level
 - unix-stream-server: create unix-stream-server.c
 - unix-socket: simplify initialization of unix_stream_listen_opts
 - pkt-line: remove buffer arg from write_packetized_from_fd_no_flush()

 After kicking jh/simple-ipc out of 'next' and rewinding
 jh/simple-ipc to contain the incremental clean-up in this follow-up
 topic, it is no longer needed, hence retired.


* es/config-hooks-part-1 (2021-02-16) 17 commits
 . hooks: allow callers to capture output
 . run-command: allow capturing of collated output
 . hook: provide stdin by string_list or callback
 . run-command: add stdin callback for parallelization
 . hook: allow specifying working directory for hooks
 . hook: allow parallel hook execution
 . run-command: allow stdin for run_processes_parallel
 . hook: support passing stdin to hooks
 . hook: replace find_hook() with hook_exists()
 . hook: add 'run' subcommand
 . parse-options: parse into strvec
 . hook: implement hookcmd.<name>.skip
 . hook: respect hook.runHookDir
 . hook: include hookdir hook in list
 . hook: add list command
 . hook: scaffolding for git-hook subcommand
 . doc: propose hooks managed by the config

 Now replaced by es/config-hooks topic.



* jk/symlinked-dotgitx-files (2020-10-23) 9 commits
 . docs: document symlink restrictions for .git* files
 . fsck: complain when .gitattributes or .gitignore is a symlink
 . verify_path(): disallow symlinks in .gitattributes and .gitignore
 . t0060: test obscured .gitattributes and .gitignore matching
 . t7450: test .gitmodules symlink matching against obscured names
 . t7450: test verify_path() handling of gitmodules
 . t7415: rename to expand scope
 . fsck_tree(): wrap some long lines
 . fsck_tree(): fix shadowed variable

 "git fsck" and the corresponding check done during the transport
 learned to ensure that in-tree files like `.gitignore` and
 `.gitattributes` are not symbolic links.

 It seems that there are real projects with .gitignore recorded as
 symlinks, which may need to loosen the fsck setting.  Do we need to
 introduce a class that is separate from symlinked .gitmodules that
 has potential consequences that is more/less grave, so that these
 projects can opt out of the new checks?


