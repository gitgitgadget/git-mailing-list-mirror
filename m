Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF2AC433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 03:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF4D61972
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 03:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCWDr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 23:47:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62320 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhCWDrM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 23:47:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5ED71277CF;
        Mon, 22 Mar 2021 23:47:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=j
        zlWl0v+58+Z93HZBo62aRrQnd0=; b=xCPyjhgEzK2vQBubuqHMe8IMX6SbP2DG2
        WHF6u5TuQuo3R905PmkWm7XLTLVTdTTX2ZV0ver941smtPS138VsyFkEU5J/HjLy
        bOcpz8AqSr/bcwk3y6ReeZVmYYs2nVl5bRJSHX3QV8841MEiB/LJsWTS8hRNV8IZ
        34KrzBQ8o4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=kil
        iP5zev4X6pC+b5jOMemtUSOJpj8XyqbbMEH3kuxIq8MPOszZ0dq61XqatKd4I88W
        gMKMk+Vt/RE3Cl7Fh6bOEH2mQoFg/38OE3j86uRyDIespLrRqFYXtVE2eN2aHyz6
        9CIROvbAo/lw7RfnLYnfPhqNg5MckFrXhOiEnEuw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ACA071277CE;
        Mon, 22 Mar 2021 23:47:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D87D41277CD;
        Mon, 22 Mar 2021 23:47:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2021, #07; Mon, 22)
X-master-at: 142430338477d9d1bb25be66267225fb58498d92
X-next-at: 6335e70b5e894eb553908aed65279cb1c81a147e
Date:   Mon, 22 Mar 2021 20:47:06 -0700
Message-ID: <xmqq35wm5y6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 716335A2-8B8A-11EB-AE3F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The tip of the 'next' has been rewound and rebuilt from the tip of
'master'.  Matheus's parallel checkout (part 1) topic has been
ejected from 'next' to be replaced with a new iteration when it
comes.

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
[Graduated to 'master']

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


* ab/remote-write-config-in-camel-case (2021-02-24) 2 commits
  (merged to 'next' on 2021-03-01 at a01bd0d8e4)
 + remote: write camel-cased *.pushRemote on rename
 + remote: add camel-cased *.tagOpt key, like clone

 Update C code that sets a few configuration variables when a remote
 is configured so that it spells configuration variable names in the
 canonical camelCase.


* bc/clone-bare-with-conflicting-config (2021-03-10) 1 commit
  (merged to 'next' on 2021-03-14 at 963a86199c)
 + builtin/init-db: handle bare clones when core.bare set to false

 "git -c core.bare=false clone --bare ..." would have segfaulted,
 which has been corrected.


* dl/cat-file-doc-cleanup (2021-03-03) 2 commits
  (merged to 'next' on 2021-03-13 at f1a216175a)
 + git-cat-file.txt: remove references to "sha1"
 + git-cat-file.txt: monospace args, placeholders and filenames

 Doc cleanup.


* dl/stash-show-untracked (2021-03-05) 2 commits
  (merged to 'next' on 2021-03-08 at 510d4cfa5f)
 + stash show: learn stash.showIncludeUntracked
 + stash show: teach --include-untracked and --only-untracked

 "git stash show" learned to optionally show untracked part of the
 stash.


* ds/commit-graph-generation-config (2021-02-25) 2 commits
  (merged to 'next' on 2021-03-01 at 926537ea97)
 + commit-graph: use config to specify generation type
 + commit-graph: create local repository pointer

 A new configuration variable has been introduced to allow choosing
 which version of the generation number gets used in the
 commit-graph file.


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
 (this branch is used by en/ort-perf-batch-10, en/ort-perf-batch-9 and en/ort-readiness.)

 Rename detection rework continues.


* jk/filter-branch-sha256 (2021-03-10) 3 commits
  (merged to 'next' on 2021-03-14 at e4e624590a)
 + filter-branch: drop $_x40 glob
 + filter-branch: drop multiple-ancestor warning
 + t7003: test ref rewriting explicitly

 Code clean-up.
 In the longer term, we might want to remove filter-branch and nudge
 folks to more modern tools.


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


* jk/perf-in-worktrees (2021-02-26) 2 commits
  (merged to 'next' on 2021-03-02 at ea298cb298)
 + t/perf: avoid copying worktree files from test repo
 + t/perf: handle worktrees as test repos

 Perf test update to work better in secondary worktrees.


* jr/doc-ignore-typofix (2021-03-03) 1 commit
  (merged to 'next' on 2021-03-13 at 0ce1e751b1)
 + doc: .gitignore documentation typofix

 Doc cleanup.


* mt/cleanly-die-upon-missing-required-filter (2021-02-26) 1 commit
  (merged to 'next' on 2021-03-01 at 357954af7c)
 + convert: fail gracefully upon missing clean cmd on required filter

 We had a code to diagnose and die cleanly when a required
 clean/smudge filter is missing, but an assert before that
 unnecessarily fired, hiding the end-user facing die() message.


* ps/update-ref-trans-hook-doc (2021-03-01) 2 commits
  (merged to 'next' on 2021-03-14 at 41c418967d)
 + githooks.txt: clarify documentation on reference-transaction hook
 + githooks.txt: replace mentions of SHA-1 specific properties

 Doc update.


* rr/mailmap-entry-self (2021-03-08) 1 commit
  (merged to 'next' on 2021-03-13 at 9f98a99713)
 + Add entry for Ramkumar Ramachandra

 Will merge to 'master'.


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


* sv/t9801-test-path-is-file-cleanup (2021-03-03) 1 commit
  (merged to 'next' on 2021-03-13 at 14997360bb)
 + t9801: replace test -f with test_path_is_file

 Test cleanup.

--------------------------------------------------
[New Topics]

* ab/diff-no-index-tests (2021-03-22) 2 commits
 - diff --no-index tests: test mode normalization
 - diff --no-index tests: add test for --exit-code

 More test coverage over "diff --no-index".

 Will merge to 'next'.


* cs/http-use-basic-after-failed-negotiate (2021-03-22) 1 commit
 - remote-curl: fall back to basic auth if Negotiate fails

 When accessing a server with a URL like https://user:pass@site/, we
 did not to fall back to the basic authentication with the
 credential material embedded in the URL after the "Negotiate"
 authentication failed.  Now we do.

 Will merge to 'next'.

--------------------------------------------------
[Cooking]

* ds/sparse-index (2021-03-20) 20 commits
 - p2000: add sparse-index repos
 - sparse-index: loose integration with cache_tree_verify()
 - cache-tree: integrate with sparse directory entries
 - sparse-checkout: disable sparse-index
 - sparse-checkout: toggle sparse index from builtin
 - sparse-index: create extension for compatibility
 - sparse-index: check index conversion happens
 - unpack-trees: allow sparse directories
 - submodule: sparse-index should not collapse links
 - sparse-index: convert from full to sparse
 - sparse-checkout: hold pattern list in index
 - unpack-trees: ensure full index
 - test-tool: don't force full index
 - test-read-cache: print cache entries with --table
 - t1092: compare sparse-checkout to sparse-index
 - sparse-index: implement ensure_full_index()
 - sparse-index: add guard to ensure full index
 - t1092: clean up script quoting
 - t/perf: add performance test for sparse operations
 - sparse-index: design doc and format update
 (this branch is used by ds/sparse-index-protections; uses ab/read-tree.)


* en/ort-perf-batch-10 (2021-03-18) 8 commits
 - diffcore-rename: determine which relevant_sources are no longer relevant
 - merge-ort: record the reason that we want a rename for a file
 - diffcore-rename: add computation of number of unknown renames
 - diffcore-rename: check if we have enough renames for directories early on
 - diffcore-rename: only compute dir_rename_count for relevant directories
 - merge-ort: record the reason that we want a rename for a directory
 - merge-ort, diffcore-rename: tweak dirs_removed and relevant_source type
 - diffcore-rename: take advantage of "majority rules" to skip more renames
 (this branch is used by en/ort-readiness; uses en/ort-perf-batch-9.)


* jk/fail-prereq-testfix (2021-03-18) 1 commit
  (merged to 'next' on 2021-03-22 at efbda3a7ce)
 + t: annotate !PTHREADS tests with !FAIL_PREREQS

 Originally merged to 'next' on 2021-03-19

 GIT_TEST_FAIL_PREREQS is a mechanism to skip test pieces with
 prerequisites to catch broken tests that depend on the side effects
 of optional pieces, but did not work at all when negative
 prerequisites were involved.

 Will merge to 'master'.


* mt/add-rm-in-sparse-checkout (2021-03-18) 7 commits
 - rm: honor sparse checkout patterns
 - add: warn when asked to update SKIP_WORKTREE entries
 - refresh_index(): add REFRESH_DONT_MARK_SPARSE_MATCHES flag
 - pathspec: allow to ignore SKIP_WORKTREE entries on index matching
 - add: make --chmod and --renormalize honor sparse checkouts
 - t3705: add tests for `git add` in sparse checkouts
 - add: include magic part of pathspec on --refresh error

 "git add" and "git rm" learned not to touch those paths that are
 outside of sparse checkout.

 Expecting a reroll.
 cf. <xmqqlfajnn6w.fsf@gitster.g>


* mt/checkout-remove-nofollow (2021-03-18) 2 commits
 - checkout: don't follow symlinks when removing entries
 - symlinks: update comment on threaded_check_leading_path()

 When "git checkout" removes a path that does not exist in the
 commit it is checking out, it wasn't careful enough not to follow
 symbolic links, which has been corrected.

 Will merge to 'next'.


* mt/parallel-checkout-part-2 (2021-03-21) 5 commits
 - parallel-checkout: add design documentation
 - parallel-checkout: support progress displaying
 - parallel-checkout: add configuration options
 - parallel-checkout: make it truly parallel
 - unpack-trees: add basic support for parallel checkout
 (this branch uses mt/parallel-checkout-part-1.)


* nk/diff-index-fsmonitor (2021-03-18) 3 commits
  (merged to 'next' on 2021-03-22 at 3d4fa0bc51)
 + fsmonitor: add perf test for git diff HEAD
 + fsmonitor: add assertion that fsmonitor is valid to check_removed
 + fsmonitor: skip lstat deletion check during git diff-index

 Originally merged to 'next' on 2021-03-19

 "git diff-index" codepath has been taught to trust fsmonitor status
 to reduce number of lstat() calls.

 Will merge to 'master'.


* ps/pack-bitmap-optim (2021-03-22) 1 commit
 - pack-bitmap: avoid traversal of objects referenced by uninteresting tag

 Optimize "rev-list --use-bitmap-index --objects" corner case that
 uses negative tags as the stopping points.

 Needs review.
 cf. <xmqqk0q4ov95.fsf@gitster.g>


* bs/asciidoctor-installation-hints (2021-03-19) 1 commit
 - INSTALL: note on using Asciidoctor to build doc

 Doc update.

 Will merge to 'next'.


* dl/complete-stash (2021-03-18) 3 commits
 - git-completion.bash: use __gitcomp_builtin() in _git_stash()
 - git-completion.bash: fix `git <args>... stash branch` bug
 - git-completion.bash: extract from else in _git_stash()

 Update "git stash branch<TAB>" command line completion (in contrib/).

 Expecting a reroll.
 cf. <xmqqtup7nnld.fsf@gitster.g>


* ds/sparse-index-protections (2021-03-20) 27 commits
 - name-hash: use expand_to_path()
 - sparse-index: expand_to_path()
 - revision: ensure full index
 - resolve-undo: ensure full index
 - read-cache: ensure full index
 - pathspec: ensure full index
 - merge-recursive: ensure full index
 - merge-ort: ensure full index
 - entry: ensure full index
 - dir: ensure full index
 - diff-lib: ensure full index
 - update-index: ensure full index
 - sparse-checkout: ensure full index
 - rm: ensure full index
 - merge-index: ensure full index
 - ls-files: ensure full index
 - grep: ensure full index
 - fsck: ensure full index
 - difftool: ensure full index
 - commit: ensure full index
 - checkout: ensure full index
 - checkout-index: ensure full index
 - add: ensure full index
 - cache: move ensure_full_index() to cache.h
 - sparse-index: API protection strategy
 - read-cache: expand on query into sparse-directory entry
 - *: remove 'const' qualifier for struct index_state
 (this branch uses ab/read-tree and ds/sparse-index.)

 Sparse-index technology demonstration.


* en/ort-readiness (2021-03-20) 13 commits
 - Add testing with merge-ort merge strategy
 - t6423: mark remaining expected failure under merge-ort as such
 - Revert "merge-ort: ignore the directory rename split conflict for now"
 - merge-recursive: add a bunch of FIXME comments documenting known bugs
 - merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a conflict
 - t: mark several submodule merging tests as fixed under merge-ort
 - merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entries
 - t6428: new test for SKIP_WORKTREE handling and conflicts
 - merge-ort: support subtree shifting
 - merge-ort: let renormalization change modify/delete into clean delete
 - merge-ort: have ll_merge() use a special attr_index for renormalization
 - merge-ort: add a special minimal index just for renormalization
 - merge-ort: use STABLE_QSORT instead of QSORT where required
 (this branch uses en/ort-perf-batch-10 and en/ort-perf-batch-9.)

 Plug the ort merge backend throughout the rest of the system, and
 start testing it as a replacement for the recursive backend.


* ag/merge-strategies-in-c (2021-03-17) 15 commits
 - sequencer: use the "octopus" merge strategy without forking
 - sequencer: use the "resolve" strategy without forking
 - merge: use the "octopus" strategy without forking
 - merge: use the "resolve" strategy without forking
 - merge-octopus: rewrite in C
 - merge-recursive: move better_branch_name() to merge.c
 - merge-resolve: rewrite in C
 - merge-one-file: rewrite in C
 - update-index: move add_cacheinfo() to read-cache.c
 - merge-index: add a new way to invoke `git-merge-one-file'
 - merge-index: drop the index
 - merge-index: libify merge_one_path() and merge_all()
 - t6060: add tests for removed files
 - t6060: modify multiple files to expose a possible issue with merge-index
 - t6407: modernise tests

 The resolve and octopus merge strategy backends have been rewritten
 in C.

 Ready?


* mt/parallel-checkout-part-1 (2021-03-21) 10 commits
 - stash: adjust for recent change to entry.h
 - entry: add checkout_entry_ca() taking preloaded conv_attrs
 - entry: move conv_attrs lookup up to checkout_entry()
 - entry: extract update_ce_after_write() from write_entry()
 - entry: make fstat_output() and read_blob_entry() public
 - entry: extract a header file for entry.c functions
 - convert: add classification for conv_attrs struct
 - convert: add get_stream_filter_ca() variant
 - convert: add [async_]convert_to_working_tree_ca() variants
 - convert: make convert_attrs() and convert structs public
 (this branch is used by mt/parallel-checkout-part-2.)

 Originally merged to 'next' on 2021-03-21

 Preparatory API changes for parallel checkout.

 Kicked out of 'next' tentatively and wait for a replacement.


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
 (this branch is used by en/ort-perf-batch-10 and en/ort-readiness.)

 The ort merge backend has been optimized by skipping irrelevant
 renames.


* js/http-pki-credential-store (2021-03-11) 2 commits
  (merged to 'next' on 2021-03-22 at 0df16bc9b3)
 + http: drop the check for an empty proxy password before approving
 + http: store credential when PKI auth is used

 Originally merged to 'next' on 2021-03-19

 The http codepath learned to let the credential layer to cache the
 password used to unlock a certificate that has successfully been
 used.

 Will merge to 'master'.


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


* ab/make-cocci-dedup (2021-03-22) 4 commits
 - Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
 - Makefile/coccicheck: allow for setting xargs concurrency
 - Makefile/coccicheck: speed up and fix bug with duplicate hunks
 - Makefile/coccicheck: add comment heading for all SPATCH flags

 Coccicheck update.

 cf. <cover.1616414951.git.avarab@gmail.com>


* ab/read-tree (2021-03-20) 8 commits
 - tree.h API: simplify read_tree_recursive() signature
 - tree.h API: expose read_tree_1() as read_tree_at()
 - archive: stop passing "stage" through read_tree_recursive()
 - ls-files: refactor away read_tree()
 - ls-files: don't needlessly pass around stage variable
 - tree.c API: move read_tree() into builtin/ls-files.c
 - ls-files tests: add meaningful --with-tree tests
 - show tests: add test for "git show <tree>"
 (this branch is used by ds/sparse-index and ds/sparse-index-protections.)

 Code simplification by removing support for a caller that is long gone.

 Will merge to 'next'.


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


* ah/plugleaks (2021-03-21) 9 commits
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


* tb/push-simple-uses-branch-merge-config (2021-03-13) 1 commit
  (merged to 'next' on 2021-03-22 at bec0a72090)
 + Documentation/git-push.txt: correct configuration typo

 Originally merged to 'next' on 2021-03-19

 Doc update.

 Will merge to 'master'.


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
 cf. <xmqq1rcj6hzr.fsf@gitster.g>


* zh/format-patch-fractional-reroll-count (2021-03-21) 1 commit
 - format-patch: allow a non-integral version numbers

 "git format-patch -v<n>" learned to allow a reroll count that is
 not an integer.

 Will merge to 'next'.


* ab/make-cleanup (2021-02-23) 5 commits
  (merged to 'next' on 2021-03-22 at e9e16c9fc4)
 + Makefile: add {program,xdiff,test,git,fuzz}-objs & objects targets
 + Makefile: split OBJECTS into OBJECTS and GIT_OBJS
 + Makefile: sort OBJECTS assignment for subsequent change
 + Makefile: split up long OBJECTS line
 + Makefile: guard against TEST_OBJS in the environment

 Originally merged to 'next' on 2021-03-19

 Reorganize Makefile to allow building git.o and other essential
 objects without extra stuff needed only for testing.

 Will merge to 'master'.


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

 Ready???


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

 Ready???


* cm/rebase-i-fixup-amend-reword (2021-03-15) 6 commits
  (merged to 'next' on 2021-03-22 at 6335e70b5e)
 + doc/git-commit: add documentation for fixup=[amend|reword] options
 + t3437: use --fixup with options to create amend! commit
 + t7500: add tests for --fixup=[amend|reword] options
 + commit: add a reword suboption to --fixup
 + commit: add amend suboption to --fixup to create amend! commit
 + sequencer: export and rename subject_length()
 (this branch uses cm/rebase-i and cm/rebase-i-updates.)

 Originally merged to 'next' on 2021-03-19

 "git commit --fixup=<commit>", which was to tweak the changes made
 to the contents while keeping the original log message intact,
 learned "--fixup=(amend|reword):<commit>", that can be used to
 tweak both the message and the contents, and only the message,
 respectively.

 Will merge to 'master'.


* cm/rebase-i-updates (2021-02-10) 11 commits
  (merged to 'next' on 2021-03-22 at 067e2829d9)
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

 Originally merged to 'next' on 2021-02-12

 Follow-up fixes to "cm/rebase-i" topic.

 Will merge to 'master'.


* jh/simple-ipc (2021-03-22) 12 commits
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
  (merged to 'next' on 2021-03-22 at d5612f5a75)
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

 Originally merged to 'next' on 2021-02-01

 "rebase -i" is getting cleaned up and also enhanced.

 Will merge to 'master'.


* tb/geometric-repack (2021-03-19) 14 commits
  (merged to 'next' on 2021-03-22 at 8147f00207)
 + builtin/pack-objects.c: ignore missing links with --stdin-packs
 + builtin/repack.c: reword comment around pack-objects flags
 + builtin/repack.c: be more conservative with unsigned overflows
 + builtin/repack.c: assign pack split later
 + t7703: test --geometric repack with loose objects
 + builtin/repack.c: do not repack single packs with --geometric
 + builtin/repack.c: add '--geometric' option
 + packfile: add kept-pack cache for find_kept_pack_entry()
 + builtin/pack-objects.c: rewrite honor-pack-keep logic
 + p5303: measure time to repack with keep
 + p5303: add missing &&-chains
 + builtin/pack-objects.c: add '--stdin-packs' option
 + revision: learn '--no-kept-objects'
 + packfile: introduce 'find_kept_pack_entry()'

 Originally merged to 'next' on 2021-03-08

 "git repack" so far has been only capable of repacking everything
 under the sun into a single pack (or split by size).  A cleverer
 strategy to reduce the cost of repacking a repository has been
 introduced.

 Will merge to 'master'.


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


* ab/tree-walk-with-object-type (2021-03-17) 32 commits
 . tree-walk.h API: add a tree_entry_extract_type() function
 . blame: emit a better error on 'git blame directory'
 . tree-walk.h API: add a get_tree_entry_path() function
 . tree-walk.h API: add get_tree_entry_all()
 . tree-walk.h API: add a tree_entry_extract_all() function
 . tree-entry.h API: rename tree_entry_extract() to tree_entry_extract_mode()
 . tree-walk.h API: document and format tree_entry_extract()
 . tree-walk.h API: add get_tree_entry_type()
 . match-trees: use "tmp" for mode in shift_tree_by()
 . tree-walk.h API: rename get_tree_entry() to get_tree_entry_mode()
 . tree-walk.h API: formatting changes for subsequent commit
 . tree-walk.h users: use temporary variable(s) for "mode"
 . fsck.c: switch on "object_type" in fsck_walk_tree()
 . merge-ort: correct reference to test in 62fdec17a11
 . merge-tree tests: test for the mode comparison in same_entry()
 . tree-walk.h users: migrate miscellaneous "mode" to "object_type"
 . tree-walk.h users: refactor chained "mode" if/else into switch
 . tree-walk.h users: migrate "p->mode &&" pattern
 . tree.h API: make read_tree_fn_t take an "enum object_type"
 . archive: get rid of 'stage' parameter
 . tree.h users: format argument lists in archive.c
 . tree.h: format argument lists of read_tree_recursive() users
 . tree-walk.h users: switch object_type(...) to new .object_type
 . cache.h: have base_name_compare() take "is tree?", not "mode"
 . diff tests: test that "mode" is passed when sorting
 . mktree tests: test that "mode" is passed when sorting
 . fast-import tests: test for sorting dir/file foo v.s. foo.txt
 . tree-walk.c: migrate to using new "object_type" field when possible
 . tree-walk.h: add object_type member to name_entry
 . cache.h: add a comment to object_type()
 . notes & match-trees: use name_entry's "pathlen" member
 . diff.c: remove redundant canon_mode() call
 (this branch uses ab/read-tree.)

 Code clean-up.

 I am not exactly sure where this series wants to go, other than
 unnecessarily churning the code.  Seems to break "diff --no-index"
 rather badly, too (e.g. t4050, t4002, among others).
