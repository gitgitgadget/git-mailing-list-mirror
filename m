Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78B2C433C1
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 00:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839EA61983
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 00:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhCaAO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 20:14:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61718 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhCaAOz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 20:14:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63F9111BFD9;
        Tue, 30 Mar 2021 20:14:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=p
        M1dNPgebB9Aa1hZtHwjm8xvPbk=; b=u5ztBk0Wu9Jz6mKe6fWtB3wr1TqAokQtF
        zEzRIvvalZ+DaedHXrL7ld14si/wDCQNsNYPCCw0/aFzyaB/gAYi5gwiWWSM+npv
        B/AEhMpNM3YeP7bHrvTghtP0Zg9KbsZg4gEHvB5czCtzQFBgcBWpFNOlnEbviRUD
        HlTroSk6tU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=XZV
        rK2BiPJnhsdWo8JPxRJO7ocJ6IkJ9DmhgtgOZtC8hj0CoRj1FCizaDfsZt0H1ce3
        os3CsDvXfFYou/wJYedoL4HAgvb1lqEkXuzcFYdvnCG0sVuTSRxmyWQhTr8oqttL
        HmSB43MOcE324OoWypq62GkzG3uByupleGtSG7V8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C78811BFD8;
        Tue, 30 Mar 2021 20:14:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6F9BF11BFD7;
        Tue, 30 Mar 2021 20:14:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2021, #08; Tue, 30)
X-master-at: a65ce7f831aa5fcc596c6d23fcde543d98b39bd7
X-next-at: f1725819714fbcd96c47ae5f14e00cc01045272f
Date:   Tue, 30 Mar 2021 17:14:50 -0700
Message-ID: <xmqqv99889hh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D3081B0-91B6-11EB-B4DA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

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

* ab/detox-gettext-tests (2021-03-23) 1 commit
  (merged to 'next' on 2021-03-24 at 00123ddc8d)
 + mktag tests: fix broken "&&" chain

 Testfix.


* ab/diff-no-index-tests (2021-03-22) 2 commits
  (merged to 'next' on 2021-03-24 at a099113753)
 + diff --no-index tests: test mode normalization
 + diff --no-index tests: add test for --exit-code

 More test coverage over "diff --no-index".


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


* ab/read-tree (2021-03-20) 8 commits
  (merged to 'next' on 2021-03-24 at e1241a4890)
 + tree.h API: simplify read_tree_recursive() signature
 + tree.h API: expose read_tree_1() as read_tree_at()
 + archive: stop passing "stage" through read_tree_recursive()
 + ls-files: refactor away read_tree()
 + ls-files: don't needlessly pass around stage variable
 + tree.c API: move read_tree() into builtin/ls-files.c
 + ls-files tests: add meaningful --with-tree tests
 + show tests: add test for "git show <tree>"
 (this branch is used by ds/sparse-index and ds/sparse-index-protections.)

 Code simplification by removing support for a caller that is long gone.


* ab/remove-rebase-usebuiltin (2021-03-23) 1 commit
  (merged to 'next' on 2021-03-24 at 39517a1c41)
 + rebase: remove transitory rebase.useBuiltin setting & env

 Remove the final hint that we used to have a scripted "git rebase".


* bs/asciidoctor-installation-hints (2021-03-19) 1 commit
  (merged to 'next' on 2021-03-24 at 93980207f7)
 + INSTALL: note on using Asciidoctor to build doc

 Doc update.


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


* cs/http-use-basic-after-failed-negotiate (2021-03-22) 1 commit
  (merged to 'next' on 2021-03-24 at 252983daa3)
 + remote-curl: fall back to basic auth if Negotiate fails

 When accessing a server with a URL like https://user:pass@site/, we
 did not to fall back to the basic authentication with the
 credential material embedded in the URL after the "Negotiate"
 authentication failed.  Now we do.


* hx/pack-objects-chunk-comment (2021-03-24) 1 commit
  (merged to 'next' on 2021-03-24 at e1c9ec9b71)
 + pack-objects: fix comment of reused_chunk.difference

 Comment update.


* jc/doc-format-patch-clarify (2021-03-24) 1 commit
  (merged to 'next' on 2021-03-26 at 421c7c469f)
 + format-patch: give an overview of what a "patch" message is

 Explain pieces of the format-patch output upfront before the rest
 of the documentation starts referring to them.


* jk/fail-prereq-testfix (2021-03-18) 1 commit
  (merged to 'next' on 2021-03-22 at efbda3a7ce)
 + t: annotate !PTHREADS tests with !FAIL_PREREQS

 Originally merged to 'next' on 2021-03-19

 GIT_TEST_FAIL_PREREQS is a mechanism to skip test pieces with
 prerequisites to catch broken tests that depend on the side effects
 of optional pieces, but did not work at all when negative
 prerequisites were involved.


* js/http-pki-credential-store (2021-03-11) 2 commits
  (merged to 'next' on 2021-03-22 at 0df16bc9b3)
 + http: drop the check for an empty proxy password before approving
 + http: store credential when PKI auth is used

 Originally merged to 'next' on 2021-03-19

 The http codepath learned to let the credential layer to cache the
 password used to unlock a certificate that has successfully been
 used.


* mt/checkout-remove-nofollow (2021-03-18) 2 commits
  (merged to 'next' on 2021-03-24 at 7a0bd7a95f)
 + checkout: don't follow symlinks when removing entries
 + symlinks: update comment on threaded_check_leading_path()

 When "git checkout" removes a path that does not exist in the
 commit it is checking out, it wasn't careful enough not to follow
 symbolic links, which has been corrected.


* nk/diff-index-fsmonitor (2021-03-18) 3 commits
  (merged to 'next' on 2021-03-22 at 3d4fa0bc51)
 + fsmonitor: add perf test for git diff HEAD
 + fsmonitor: add assertion that fsmonitor is valid to check_removed
 + fsmonitor: skip lstat deletion check during git diff-index

 Originally merged to 'next' on 2021-03-19

 "git diff-index" codepath has been taught to trust fsmonitor status
 to reduce number of lstat() calls.


* rf/send-email-hookspath (2021-03-23) 1 commit
  (merged to 'next' on 2021-03-24 at 84079a6e0f)
 + git-send-email: Respect core.hooksPath setting

 "git send-email" learned to honor the core.hooksPath configuration.


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


* tb/push-simple-uses-branch-merge-config (2021-03-13) 1 commit
  (merged to 'next' on 2021-03-22 at bec0a72090)
 + Documentation/git-push.txt: correct configuration typo

 Originally merged to 'next' on 2021-03-19

 Doc update.

--------------------------------------------------
[New Topics]

* zh/commit-trailer (2021-03-23) 1 commit
 - commit: add --trailer option

 "git commit" learned "--trailer <key>[=<value>]" option; together
 with the interpret-trailers command, this will make it easier to
 support custom trailers.

 Will merge to 'next'.


* ab/userdiff-tests (2021-03-23) 10 commits
 - blame tests: simplify userdiff driver test
 - blame tests: don't rely on t/t4018/ directory
 - userdiff: remove support for "broken" tests
 - userdiff tests: list builtin drivers via test-tool
 - userdiff tests: explicitly test "default" pattern
 - userdiff: add and use for_each_userdiff_driver()
 - userdiff style: normalize pascal regex declaration
 - userdiff style: declare patterns with consistent style
 - userdiff style: re-order drivers in alphabetical order
 - userdiff: refactor away the parse_bool() function

 A bit of code clean-up and a lot of test clean-up around userdiff
 area.

 A reroll promised "at some point".
 cf. <87im5gp2ze.fsf@evledraar.gmail.com>


* ds/clarify-hashwrite (2021-03-26) 1 commit
  (merged to 'next' on 2021-03-30 at 701f5c0696)
 + csum-file: make hashwrite() more readable

 The hashwrite() API always resulted in a call to write(2), even
 when writing a small amount of bytes that would still fit in the
 internal buffer held by the hashfile struct.  It has been updated
 to delay the writing until the buffer is filled or the hashfile
 concluded for performance.

 Will merge to 'master'.


* en/ort-perf-batch-11 (2021-03-25) 7 commits
 - merge-ort, diffcore-rename: employ cached renames when possible
 - merge-ort: add helper functions for using cached renames
 - merge-ort: preserve cached renames for the appropriate side
 - merge-ort: avoid accidental API mis-use
 - merge-ort: add code to check for whether cached renames can be reused
 - merge-ort: populate caches of rename detection results
 - merge-ort: add data structures for in-memory caching of rename detection
 (this branch uses en/ort-perf-batch-10, en/ort-perf-batch-9 and en/ort-readiness.)


* rs/daemon-sanitize-dir-sep (2021-03-26) 1 commit
 - daemon: sanitize all directory separators

 "git daemon" has been tightened against systems that take backslash
 as directory separator.


* ar/userdiff-scheme (2021-03-27) 1 commit
 - userdiff: add support for Scheme

 Userdiff patterns for "Scheme" has been added.

 Expecting a reroll.


* js/cmake-vsbuild (2021-03-29) 4 commits
 - cmake(install): include vcpkg dlls
 - cmake: add a preparatory work-around to accommodate `vcpkg`
 - cmake(install): fix double .exe suffixes
 - cmake: support SKIP_DASHED_BUILT_INS

 CMake update for vsbuild.

 Will merge to 'next'.


* js/security-md (2021-03-27) 2 commits
 - Document how we do embargoed releases
 - SECURITY: describe how to report vulnerabilities

 SECURITY.md that is facing individual contributors and end users
 has been introduced.  Also a procedure to follow when preparing
 embargoed releases has been spelled out.


* ab/make-tags-quiet (2021-03-27) 1 commit
 - Makefile: add QUIET_GEN to "tags" and "TAGS" targets


* cc/downcase-opt-help (2021-03-29) 1 commit
 - column, range-diff: downcase option description


* en/sequencer-edit-upon-conflict-fix (2021-03-29) 1 commit
 - sequencer: fix edit handling for cherry-pick and revert messages


* gk/gitweb-redacted-email (2021-03-29) 1 commit
 - gitweb: redacted e-mail addresses feature.


* ll/clone-reject-shallow (2021-03-29) 1 commit
 - builtin/clone.c: add --reject-shallow option

--------------------------------------------------
[Cooking]

* ds/sparse-index (2021-03-30) 21 commits
 - p2000: add sparse-index repos
 - sparse-index: loose integration with cache_tree_verify()
 - cache-tree: integrate with sparse directory entries
 - sparse-checkout: disable sparse-index
 - sparse-checkout: toggle sparse index from builtin
 - sparse-index: add index.sparse config option
 - sparse-index: check index conversion happens
 - unpack-trees: allow sparse directories
 - submodule: sparse-index should not collapse links
 - sparse-index: convert from full to sparse
 - sparse-index: add 'sdir' index extension
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

 Both in-core and on-disk index has been updated to optionally omit
 individual entries and replace them with the tree object that
 corresponds to the directory that contains them when the "cone"
 mode of sparse checkout is in use.


* en/ort-perf-batch-10 (2021-03-18) 8 commits
 - diffcore-rename: determine which relevant_sources are no longer relevant
 - merge-ort: record the reason that we want a rename for a file
 - diffcore-rename: add computation of number of unknown renames
 - diffcore-rename: check if we have enough renames for directories early on
 - diffcore-rename: only compute dir_rename_count for relevant directories
 - merge-ort: record the reason that we want a rename for a directory
 - merge-ort, diffcore-rename: tweak dirs_removed and relevant_source type
 - diffcore-rename: take advantage of "majority rules" to skip more renames
 (this branch is used by en/ort-perf-batch-11 and en/ort-readiness; uses en/ort-perf-batch-9.)

 I made a mistake of picking these up before they got sufficient
 exposure to the reviewers and ended up a source of potential mess
 when it turns out that any of the earlier ones need rewriting (I
 probably should stop picking up nested series that exceeds reviewer
 bandwidth), but how ready is this and subsequent topics?


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


* mt/parallel-checkout-part-2 (2021-03-23) 5 commits
 - parallel-checkout: add design documentation
 - parallel-checkout: support progress displaying
 - parallel-checkout: add configuration options
 - parallel-checkout: make it truly parallel
 - unpack-trees: add basic support for parallel checkout
 (this branch uses mt/parallel-checkout-part-1.)


* ps/pack-bitmap-optim (2021-03-22) 1 commit
 - pack-bitmap: avoid traversal of objects referenced by uninteresting tag

 Optimize "rev-list --use-bitmap-index --objects" corner case that
 uses negative tags as the stopping points.

 Needs review.
 cf. <xmqqk0q4ov95.fsf@gitster.g>


* dl/complete-stash (2021-03-24) 3 commits
  (merged to 'next' on 2021-03-24 at ce573a99cc)
 + git-completion.bash: use __gitcomp_builtin() in _git_stash()
 + git-completion.bash: extract from else in _git_stash()
 + git-completion.bash: pass $__git_subcommand_idx from __git_main()

 Update "git stash branch<TAB>" command line completion (in contrib/).

 cf. <20210327183554.GD2271@szeder.dev>


* ds/sparse-index-protections (2021-03-23) 47 commits
 . name-hash: use expand_to_path()
 . sparse-index: expand_to_path()
 . revision: ensure full index
 . resolve-undo: ensure full index
 . read-cache: ensure full index
 . pathspec: ensure full index
 . merge-recursive: ensure full index
 . merge-ort: ensure full index
 . entry: ensure full index
 . dir: ensure full index
 . diff-lib: ensure full index
 . update-index: ensure full index
 . sparse-checkout: ensure full index
 . rm: ensure full index
 . merge-index: ensure full index
 . ls-files: ensure full index
 . grep: ensure full index
 . fsck: ensure full index
 . difftool: ensure full index
 . commit: ensure full index
 . checkout: ensure full index
 . checkout-index: ensure full index
 . add: ensure full index
 . cache: move ensure_full_index() to cache.h
 . sparse-index: API protection strategy
 . read-cache: expand on query into sparse-directory entry
 . *: remove 'const' qualifier for struct index_state
 . p2000: add sparse-index repos
 . sparse-index: loose integration with cache_tree_verify()
 . cache-tree: integrate with sparse directory entries
 . sparse-checkout: disable sparse-index
 . sparse-checkout: toggle sparse index from builtin
 . sparse-index: create extension for compatibility
 . sparse-index: check index conversion happens
 . unpack-trees: allow sparse directories
 . submodule: sparse-index should not collapse links
 . sparse-index: convert from full to sparse
 . sparse-checkout: hold pattern list in index
 . unpack-trees: ensure full index
 . test-tool: don't force full index
 . test-read-cache: print cache entries with --table
 . t1092: compare sparse-checkout to sparse-index
 . sparse-index: implement ensure_full_index()
 . sparse-index: add guard to ensure full index
 . t1092: clean up script quoting
 . t/perf: add performance test for sparse operations
 . sparse-index: design doc and format update

 Builds on top of the sparse-index infrastructure to mark operations
 that are not ready to mark with the sparse index, causing them to
 fall back on fully-populated index that they always have worked with.


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
 (this branch is used by en/ort-perf-batch-11; uses en/ort-perf-batch-10 and en/ort-perf-batch-9.)

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

 Expecting a (hopefully final) reroll.
 cf. <nycvar.QRO.7.76.6.2103241142220.50@tvgsbejvaqbjf.bet>


* mt/parallel-checkout-part-1 (2021-03-23) 9 commits
  (merged to 'next' on 2021-03-30 at e8995d1046)
 + entry: add checkout_entry_ca() taking preloaded conv_attrs
 + entry: move conv_attrs lookup up to checkout_entry()
 + entry: extract update_ce_after_write() from write_entry()
 + entry: make fstat_output() and read_blob_entry() public
 + entry: extract a header file for entry.c functions
 + convert: add classification for conv_attrs struct
 + convert: add get_stream_filter_ca() variant
 + convert: add [async_]convert_to_working_tree_ca() variants
 + convert: make convert_attrs() and convert structs public
 (this branch is used by mt/parallel-checkout-part-2.)

 Originally merged to 'next' on 2021-03-21

 Preparatory API changes for parallel checkout.

 Will merge to 'master'.


* ab/fsck-api-cleanup (2021-03-28) 19 commits
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
 - fsck.c: remove (mostly) redundant append_msg_id() function
 - fsck.c: rename variables in fsck_set_msg_type() for less confusion
 - fsck.h: use "enum object_type" instead of "int"
 - fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
 - fsck.c: refactor and rename common config callback

 Fsck API clean-up.

 Will merge to 'next'?
 cf. <xmqq5z1alnmu.fsf@gitster.g>


* en/ort-perf-batch-9 (2021-03-10) 8 commits
 - diffcore-rename: avoid doing basename comparisons for irrelevant sources
 - merge-ort: skip rename detection entirely if possible
 - merge-ort: use relevant_sources to filter possible rename sources
 - merge-ort: precompute whether directory rename detection is needed
 - merge-ort: introduce wrappers for alternate tree traversal
 - merge-ort: add data structures for an alternate tree traversal
 - merge-ort: precompute subset of sources for which we need rename detection
 - diffcore-rename: enable filtering possible rename sources
 (this branch is used by en/ort-perf-batch-10, en/ort-perf-batch-11 and en/ort-readiness.)

 The ort merge backend has been optimized by skipping irrelevant
 renames.

 Will merge to 'next'.


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


* ab/unexpected-object-type (2021-03-27) 10 commits
 - tag: don't misreport type of tagged objects in errors
 - object tests: add test for unexpected objects in tags
 - object.c: add and use oid_is_type_or_die_msg() function
 - object.c: add a utility function for "expected type X, got Y"
 - tree.c: fix misindentation in parse_tree_gently()
 - object-name.c: make dependency on object_type order more obvious
 - object-file.c: make oid_object_info() return "enum object_type"
 - object.c: make type_from_string() return "enum object_type"
 - object.c: refactor type_from_string_gently()
 - object.c: stop supporting len == -1 in type_from_string_gently()

 Error reporting upon object type mismatch has been improved

 cf. <YGBL88lYheyFmwCg@coredump.intra.peff.net>
 ... we would be much better off to say something like "somebody
 expected X to be a commit, but now somebody else expects it to be a
 blob", which is all that we can reliably say.


* ah/plugleaks (2021-03-21) 9 commits
  (merged to 'next' on 2021-03-30 at 78636ede89)
 + transport: also free remote_refs in transport_disconnect()
 + parse-options: don't leak alias help messages
 + parse-options: convert bitfield values to use binary shift
 + init-db: silence template_dir leak when converting to absolute path
 + init: remove git_init_db_config() while fixing leaks
 + worktree: fix leak in dwim_branch()
 + clone: free or UNLEAK further pointers when finished
 + reset: free instead of leaking unneeded ref
 + symbolic-ref: don't leak shortened refname in check_symref()

 Plug or annotate remaining leaks that trigger while running the
 very basic set of tests.

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


* zh/format-patch-fractional-reroll-count (2021-03-23) 1 commit
  (merged to 'next' on 2021-03-26 at 3c29ec9a02)
 + format-patch: allow a non-integral version numbers

 "git format-patch -v<n>" learned to allow a reroll count that is
 not an integer.

 Will merge to 'master'.


* tb/reverse-midx (2021-03-30) 17 commits
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

 Will merge to 'next'.


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

 Needs (hopefully the final round of) review.


* jh/simple-ipc (2021-03-22) 12 commits
  (merged to 'next' on 2021-03-24 at 3ebcedf89a)
 + t0052: add simple-ipc tests and t/helper/test-simple-ipc tool
 + simple-ipc: add Unix domain socket implementation
 + unix-stream-server: create unix domain socket under lock
 + unix-socket: disallow chdir() when creating unix domain sockets
 + unix-socket: add backlog size option to unix_stream_listen()
 + unix-socket: eliminate static unix_stream_socket() helper function
 + simple-ipc: add win32 implementation
 + simple-ipc: design documentation for new IPC mechanism
 + pkt-line: add options argument to read_packetized_to_strbuf()
 + pkt-line: add PACKET_READ_GENTLE_ON_READ_ERROR option
 + pkt-line: do not issue flush packets in write_packetized_*()
 + pkt-line: eliminate the need for static buffer in packet_write_gently()

 A simple IPC interface gets introduced to build services like
 fsmonitor on top.

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

* ab/make-cocci-dedup (2021-03-22) 4 commits
 . Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
 . Makefile/coccicheck: allow for setting xargs concurrency
 . Makefile/coccicheck: speed up and fix bug with duplicate hunks
 . Makefile/coccicheck: add comment heading for all SPATCH flags

 Coccicheck update.

 Retracted.
 cf. <cover.1616414951.git.avarab@gmail.com>
 cf. <87k0psnzv5.fsf@evledraar.gmail.com>


* ab/tests-cleanup-around-sha1 (2021-03-10) 4 commits
 - tests: get rid of $_x05 from the test suite
 - shortlog tests: rewrite to get rid of --abbrev=35 hardcoding
 - test-lib: remove unused $_x40 and $_z40 variables
 - git-bisect: remove unused SHA-1 $x40 shell variable

 Remove variables that hold regexp and glob that match fixed number
 of hexadecimal digits from the test suite.

 Retracted, to be replaced by another series.
 cf. <878s67o09v.fsf@evledraar.gmail.com>
