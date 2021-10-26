Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3E2C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 03:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C6D60F9D
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 03:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhJZDub (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 23:50:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60555 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhJZDua (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 23:50:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62EBAE02FB;
        Mon, 25 Oct 2021 23:48:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=S
        dbxFoFwzMMmUgpKxWoERUPeVc2IyjAqOTyH+KduSc4=; b=Lu4kbafYZYdm2TC7T
        KRKFfl6Z6ylqGadeGzinZ1iW5xyOe+JE9qA63QpEhpIBpsETg8ReKWvHmKMd48fG
        kXs0WF+pDZi9cdSdWKD+FgpRmZUgqseMHFigXUv9EDbyA2VVLHSUgJLU8PAUHVgX
        uZKndiNvFKFvqWJpnGm/MHvnKU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45612E02FA;
        Mon, 25 Oct 2021 23:48:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 523E9E02F9;
        Mon, 25 Oct 2021 23:48:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2021, #06; Mon, 25)
X-master-at: e9e5ba39a78c8f5057262d49e261b42a8660d5b9
X-next-at: c40950c09aa26fafb743328ce2dee3ba26b22eec
Date:   Mon, 25 Oct 2021 20:48:04 -0700
Message-ID: <xmqq5ytkzbt7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86AD0DD6-360F-11EC-9EF1-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen',
which means nothing more than that I have found them of interest for
some reason (like "it may have hard-to-resolve conflicts with
another topic already in flight" or "this may turn out to be
useful").  Do not read too much into a topic being in (or not in)
'seen'.  The ones marked with '.' do not appear in any of the
integration branches, but I am still holding onto them.

The fifteenth batch of topics are in 'master'.  I expect that this
is more-or-less what we can expect in the -rc0, unless there is a
hotfix to what's already merged.

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

* ab/fix-commit-error-message-upon-unwritable-object-store (2021-10-12) 2 commits
  (merged to 'next' on 2021-10-14 at 08c52f5cd5)
 + commit: fix duplication regression in permission error output
 + unwritable tests: assert exact error output

 "git commit" gave duplicated error message when the object store
 was unwritable, which has been corrected.


* ab/fix-make-lint-docs (2021-10-15) 4 commits
  (merged to 'next' on 2021-10-18 at 22ebb3213f)
 + doc lint: make "lint-docs" non-.PHONY
 + doc build: speed up "make lint-docs"
 + doc lint: emit errors on STDERR
 + doc lint: fix error-hiding regression

 Build fix.


* ab/fsck-unexpected-type (2021-10-01) 17 commits
  (merged to 'next' on 2021-10-14 at 10edc78c9c)
 + fsck: report invalid object type-path combinations
 + fsck: don't hard die on invalid object types
 + object-file.c: stop dying in parse_loose_header()
 + object-file.c: return ULHR_TOO_LONG on "header too long"
 + object-file.c: use "enum" return type for unpack_loose_header()
 + object-file.c: simplify unpack_loose_short_header()
 + object-file.c: make parse_loose_header_extended() public
 + object-file.c: return -1, not "status" from unpack_loose_header()
 + object-file.c: don't set "typep" when returning non-zero
 + cat-file tests: test for current --allow-unknown-type behavior
 + cat-file tests: add corrupt loose object test
 + cat-file tests: test for missing/bogus object with -t, -s and -p
 + cat-file tests: move bogus_* variable declarations earlier
 + fsck tests: test for garbage appended to a loose object
 + fsck tests: test current hash/type mismatch behavior
 + fsck tests: refactor one test to use a sub-repo
 + fsck tests: add test for fsck-ing an unknown type

 "git fsck" has been taught to report mismatch between expected and
 actual types of an object better.


* ab/mark-leak-free-tests (2021-10-12) 10 commits
  (merged to 'next' on 2021-10-18 at c522807d5d)
 + leak tests: mark some misc tests as passing with SANITIZE=leak
 + leak tests: mark various "generic" tests as passing with SANITIZE=leak
 + leak tests: mark some read-tree tests as passing with SANITIZE=leak
 + leak tests: mark some ls-files tests as passing with SANITIZE=leak
 + leak tests: mark all checkout-index tests as passing with SANITIZE=leak
 + leak tests: mark all trace2 tests as passing with SANITIZE=leak
 + leak tests: mark all ls-tree tests as passing with SANITIZE=leak
 + leak tests: run various "test-tool" tests in t00*.sh SANITIZE=leak
 + leak tests: run various built-in tests in t00*.sh SANITIZE=leak
 + Merge branch 'ab/sanitize-leak-ci' into ab/mark-leak-free-tests

 Bunch of tests are marked as "passing leak check".


* ab/mark-leak-free-tests-more (2021-10-07) 8 commits
  (merged to 'next' on 2021-10-18 at fe798f77b8)
 + merge: add missing strbuf_release()
 + ls-files: add missing string_list_clear()
 + ls-files: fix a trivial dir_clear() leak
 + tests: fix test-oid-array leak, test in SANITIZE=leak
 + tests: fix a memory leak in test-oidtree.c
 + tests: fix a memory leak in test-parse-options.c
 + tests: fix a memory leak in test-prio-queue.c
 + Merge branch 'ab/sanitize-leak-ci' into ab/mark-leak-free-tests-more

 Bunch of tests are marked as "passing leak check".


* ab/parse-options-cleanup (2021-10-08) 10 commits
  (merged to 'next' on 2021-10-18 at 305d339ad9)
 + parse-options: change OPT_{SHORT,UNSET} to an enum
 + parse-options tests: test optname() output
 + parse-options.[ch]: make opt{bug,name}() "static"
 + commit-graph: stop using optname()
 + parse-options.c: move optname() earlier in the file
 + parse-options.h: make the "flags" in "struct option" an enum
 + parse-options.c: use exhaustive "case" arms for "enum parse_opt_result"
 + parse-options.[ch]: consistently use "enum parse_opt_result"
 + parse-options.[ch]: consistently use "enum parse_opt_flags"
 + parse-options.h: move PARSE_OPT_SHELL_EVAL between enums

 Random changes to parse-options implementation.


* ab/pkt-line-cleanup (2021-10-15) 2 commits
  (merged to 'next' on 2021-10-18 at 79b07663da)
 + pkt-line.[ch]: remove unused packet_read_line_buf()
 + pkt-line.[ch]: remove unused packet_buf_write_len()

 Code clean-up.


* ab/test-cleanly-recreate-trash-directory (2021-10-15) 1 commit
  (merged to 'next' on 2021-10-18 at 6fdb43973b)
 + test-lib.sh: try to re-chmod & retry on failed trash removal

 Improve test framework around unwritable directories.


* ab/test-lib-diff-cleanup (2021-10-15) 2 commits
  (merged to 'next' on 2021-10-18 at 5229c5d01d)
 + tests: stop using top-level "README" and "COPYING" files
 + "lib-diff" tests: make "README" and "COPYING" test data smaller

 Test clean-up.


* ab/unpack-trees-leakfix (2021-10-13) 4 commits
  (merged to 'next' on 2021-10-14 at bb54827704)
 + sequencer: fix a memory leak in do_reset()
 + sequencer: add a "goto cleanup" to do_reset()
 + unpack-trees: don't leak memory in verify_clean_subdirectory()
 + Merge branch 'ab/sanitize-leak-ci' into ab/unpack-trees-leakfix

 Leakfix.


* da/mergetools-special-case-xxdiff-exit-128 (2021-10-13) 1 commit
  (merged to 'next' on 2021-10-18 at 0dd8a08c63)
 + mergetools/xxdiff: prevent segfaults from stopping difftool

 The xxdiff difftool backend can exit with status 128, which the
 difftool-helper that launches the backend takes as a significant
 failure, when it is not significant at all.  Work it around.


* fs/ssh-signing (2021-09-10) 9 commits
  (merged to 'next' on 2021-10-11 at b456b95672)
 + ssh signing: test that gpg fails for unknown keys
 + ssh signing: tests for logs, tags & push certs
 + ssh signing: duplicate t7510 tests for commits
 + ssh signing: verify signatures using ssh-keygen
 + ssh signing: provide a textual signing_key_id
 + ssh signing: retrieve a default key from ssh-agent
 + ssh signing: add ssh key format and signing code
 + ssh signing: add test prereqs
 + ssh signing: preliminary refactoring and clean-up
 (this branch is used by fs/ssh-signing-fix and fs/ssh-signing-key-lifetime.)

 Use ssh public crypto for object and push-cert signing.


* fs/ssh-signing-fix (2021-10-18) 5 commits
  (merged to 'next' on 2021-10-18 at 5ffa706433)
 + gpg-interface: fix leak of strbufs in get_ssh_key_fingerprint()
 + gpg-interface: fix leak of "line" in parse_ssh_output()
  (merged to 'next' on 2021-10-14 at 97735c6091)
 + ssh signing: clarify trustlevel usage in docs
 + ssh signing: fmt-merge-msg tests & config parse
 + Merge branch 'fs/ssh-signing' into fs/ssh-signing-fix
 (this branch is used by fs/ssh-signing-key-lifetime; uses fs/ssh-signing.)

 Fix-up for the other topic already in 'next'.


* jc/doc-commit-header-continuation-line (2021-10-12) 1 commit
  (merged to 'next' on 2021-10-18 at 99b71c0aaf)
 + signature-format.txt: explain and illustrate multi-line headers

 Doc update.


* jh/perf-remove-test-times (2021-10-04) 1 commit
  (merged to 'next' on 2021-10-14 at 473a26166c)
 + t/perf/perf-lib.sh: remove test_times.* at the end test_perf_()

 Perf test fix.


* js/userdiff-cpp (2021-10-25) 7 commits
  (merged to 'next' on 2021-10-25 at 2158813163)
 + userdiff-cpp: back out the digit-separators in numbers
  (merged to 'next' on 2021-10-18 at fea77f6c4e)
 + userdiff-cpp: learn the C++ spaceship operator
 + userdiff-cpp: permit the digit-separating single-quote in numbers
 + userdiff-cpp: prepare test cases with yet unsupported features
 + userdiff-cpp: tighten word regex
 + t4034: add tests showing problematic cpp tokenizations
 + t4034/cpp: actually test that operator tokens are not split

 Userdiff patterns for the C++ language has been updated.


* jt/no-abuse-alternate-odb-for-submodules (2021-10-08) 9 commits
  (merged to 'next' on 2021-10-14 at ae49a2ceda)
 + submodule: trace adding submodule ODB as alternate
 + submodule: pass repo to check_has_commit()
 + object-file: only register submodule ODB if needed
 + merge-{ort,recursive}: remove add_submodule_odb()
 + refs: peeling non-the_repository iterators is BUG
 + refs: teach arbitrary repo support to iterators
 + refs: plumb repo into ref stores
 + Merge branch 'jk/ref-paranoia' into jt/no-abuse-alternate-odb-for-submodules
 + Merge branch 'jt/add-submodule-odb-clean-up' into jt/no-abuse-alternate-odb-for-submodules

 Follow through the work to use the repo interface to access
 submodule objects in-process, instead of abusing the alternate
 object database interface.


* pw/sparse-cache-tree-verify-fix (2021-10-18) 2 commits
  (merged to 'next' on 2021-10-18 at 0186a643cc)
 + t1092: run "rebase --apply" without "-q" in testing
  (merged to 'next' on 2021-10-11 at 2f90c87850)
 + sparse index: fix use-after-free bug in cache_tree_verify()

 Recent sparse-index addition, namely any use of index_name_pos(),
 can expand sparse index entries and breaks any code that walks
 cache-tree or existing index entries.  One such instance of such a
 breakage has been corrected.


* rs/add-dry-run-without-objects (2021-10-12) 1 commit
  (merged to 'next' on 2021-10-14 at a42928e134)
 + add: don't write objects with --dry-run

 Stop "git add --dry-run" from creating new blob and tree objects.


* rs/disable-gc-during-perf-tests (2021-10-11) 1 commit
  (merged to 'next' on 2021-10-14 at e0dd4b9bd4)
 + perf: disable automatic housekeeping

 Avoid performance measurements from getting ruined by gc and other
 housekeeping pauses interfering in the middle.


* tb/fix-midx-rename-while-mapped (2021-10-15) 5 commits
  (merged to 'next' on 2021-10-18 at 52e552caae)
 + midx.c: guard against commit_lock_file() failures
 + midx.c: lookup MIDX by object directory during repack
 + midx.c: lookup MIDX by object directory during expire
 + midx.c: extract MIDX lookup by object_dir
 + Merge branch 'tb/repack-write-midx' into tb/fix-midx-rename-while-mapped

 The codepath to write a new version of .midx multi-pack index files
 has learned to release the mmaped memory holding the current
 version of .midx before removing them from the disk, as some
 platforms do not allow removal of a file that still has mapping.

--------------------------------------------------
[New Topics]

* ab/generate-command-list (2021-10-23) 10 commits
 - generate-cmdlist.sh: replace "cut", "tr" and "grep" with pure-shell
 - generate-cmdlist.sh: replace "grep' invocation with a shell version
 - generate-cmdlist.sh: do not shell out to "sed"
 - generate-cmdlist.sh: stop sorting category lines
 - generate-cmdlist.sh: replace for loop by printf's auto-repeat feature
 - generate-cmdlist.sh: run "grep | sort", not "sort | grep"
 - generate-cmdlist.sh: don't call get_categories() from category_list()
 - generate-cmdlist.sh: spawn fewer processes
 - generate-cmdlist.sh: trivial whitespace change
 - command-list.txt: sort with "LC_ALL=C sort"

 Build optimization.


* ab/ref-filter-leakfix (2021-10-20) 3 commits
  (merged to 'next' on 2021-10-23 at 8066971a3d)
 + branch: use ref_sorting_release()
 + ref-filter API user: add and use a ref_sorting_release()
 + tag: use a "goto cleanup" pattern, leak less memory
 (this branch is used by jc/fix-ref-sorting-parse.)

 "git for-each-ref" family of commands were leaking the ref_sorting
 instances that hold sorting keys specified by the user; this has
 been corrected.

 Will merge to 'master'.


* bs/doc-blame-color-lines (2021-10-20) 1 commit
  (merged to 'next' on 2021-10-23 at 4da10a5162)
 + git config doc: fix recent ASCIIDOC formatting regression

 Doc fix.

 Will merge to 'master'.


* jc/fix-pull-ff-only-when-already-up-to-date (2021-10-20) 1 commit
 - pull: --ff-only should make it a noop when already-up-to-date

 "git pull --ff-only" and "git pull --rebase --ff-only" should make
 it a no-op to attempt pulling from a remote that is behind us, but
 instead the command errored out by saying it was impossible to
 fast-forward, which may technically be true, but not a useful thing
 to diagnose as an error.  This has been corrected.

 Will merge to 'next'?


* ab/make-sparse-for-real (2021-10-21) 1 commit
  (merged to 'next' on 2021-10-23 at f7a8389fb3)
 + Makefile: remove redundant GIT-CFLAGS dependency from "sparse"

 Fix-up for a recent topic.

 Will merge to 'master'.


* ab/plug-handle-path-exclude-leak (2021-10-21) 1 commit
  (merged to 'next' on 2021-10-23 at 6be5d7bea8)
 + config.c: don't leak memory in handle_path_include()

 Leakfix.

 Will merge to 'master'.


* ab/plug-random-leaks (2021-10-23) 6 commits
  (merged to 'next' on 2021-10-23 at 9c04a95718)
 + reflog: free() ref given to us by dwim_log()
 + submodule--helper: fix small memory leaks
 + clone: fix a memory leak of the "git_dir" variable
 + grep: fix a "path_list" memory leak
 + grep: use object_array_clear() in cmd_grep()
 + grep: prefer "struct grep_opt" over its "void *" equivalent

 Leakfix.

 Will merge to 'master'.


* ab/sh-retire-helper-functions (2021-10-21) 6 commits
 - git-sh-setup: remove "sane_grep", it's not needed anymore
 - git-sh-setup: remove unused sane_egrep() function
 - git-instaweb: unconditionally assume that gitweb is mod_perl capable
 - Makefile: remove $(NO_CURL) from $(SCRIPT_DEFINES)
 - Makefile: remove $(GIT_VERSION) from $(SCRIPT_DEFINES)
 - Makefile: move git-SCRIPT-DEFINES adjacent to $(SCRIPT_DEFINES)

 Make a few helper functions unused and then lose them.


* ab/sh-retire-rebase-preserve-merges (2021-10-21) 2 commits
  (merged to 'next' on 2021-10-23 at f1fede7500)
 + git-sh-setup: remove messaging supporting --preserve-merges
 + git-sh-i18n: remove unused eval_ngettext()

 Code clean-up to remove unused helpers.

 Will merge to 'master'.


* ow/stash-count-in-status-porcelain-output (2021-10-21) 2 commits
 - status: print stash info with --porcelain=v2 --show-stash
 - status: count stash entries in separate function

 Allow "git status --porcelain=v2" to show the number of stash
 entries with --show-stash like the normal output does.

 Will merge to 'next'.


* tb/plug-pack-bitmap-leaks (2021-10-21) 9 commits
 - pack-bitmap.c: more aggressively free in free_bitmap_index()
 - pack-bitmap.c: don't leak type-level bitmaps
 - pack-bitmap.c: avoid leaking via midx_bitmap_filename()
 - builtin/multi-pack-index.c: don't leak concatenated options
 - builtin/repack.c: avoid leaking child arguments
 - builtin/pack-objects.c: don't leak memory via arguments
 - t/helper/test-read-midx.c: free MIDX within read_midx_file()
 - midx.c: don't leak MIDX from verify_midx_file
 - midx.c: clean up chunkfile after reading the MIDX

 Leakfix.

 Will merge to 'next'?


* bs/archive-doc-compression-level (2021-10-25) 1 commit
  (merged to 'next' on 2021-10-25 at 9360d864a2)
 + archive: describe compression level option

 Update "git archive" documentation and give explicit mention on the
 compression level for both zip and tar.gz format.

 Will merge to 'master'.


* es/pretty-describe-more (2021-10-23) 3 commits
 - pretty: add abbrev option to %(describe)
 - pretty: add tag option to %(describe)
 - pretty.c: rename describe options variable to more descriptive name

 Extend "git log --format=%(describe)" placeholder to allow passing
 selected command-line options to the underlying "git describe"
 command.

 Expecting a reroll.


* fs/ssh-signing-key-lifetime (2021-10-23) 8 commits
 - ssh signing: fmt-merge-msg/check_signature with tag date
 - ssh signing: verify-tag/check_signature with tag date
 - ssh signing: git log/check_signature with commit date
 - ssh signing: verify-commit/check_signature with commit date
 - ssh signing: add key lifetime test prereqs
 - ssh signing: extend check_signature to accept payload metadata
 - Merge branch 'fs/ssh-signing-fix' into fs/ssh-signing-key-lifetime
 - Merge branch 'fs/ssh-signing' into fs/ssh-signing-key-lifetime

 Extend the signing of objects with SSH keys and learn to pay
 attention to the key validity time range when verifying.

 Expecting a reroll.
 cf. <51099904-a962-eb23-8baf-9ce15fff7d10@gigacodes.de>


* jc/branch-copy-doc (2021-10-23) 1 commit
 - branch (doc): -m/-c copies config and reflog

 "git branch -c/-m new old" was not described to copy config, which
 has been corrected.

 Will merge to 'next'?


* jc/doc-format-patch-clarify-auto-base (2021-10-23) 1 commit
 - format-patch (doc): clarify --base=auto

 Rephrase the description of "format-patch --base=auto".

 Will merge to 'next'?


* jc/doc-submitting-patches-choice-of-base (2021-10-25) 2 commits
 - (wip) reword the final review part
 - SubmittingPatchs: clarify choice of base and testing

 Extend the guidance to choose the base commit to build your work
 on, and hint/nudge contributors to read others' changes.


* js/expand-runtime-prefix (2021-10-25) 1 commit
  (merged to 'next' on 2021-10-25 at 7ff05e8222)
 + config.txt: fix typo

 Typofix.

 Will merge to 'master'.


* ma/doc-folder-to-directory (2021-10-25) 3 commits
 - gitweb.txt: change "folder" to "directory"
 - gitignore.txt: change "folder" to "directory"
 - git-multi-pack-index.txt: change "folder" to "directory"

 Consistently use 'directory', not 'folder', to call the filesystem
 entity that collects a group of files and, eh, directories.

 Will merge to 'next' and then to 'master'.


* ma/doc-git-version (2021-10-25) 1 commit
  (merged to 'next' on 2021-10-25 at 9f74afec0c)
 + git.txt: fix typo

 Typofix.

 Will merge to 'master'.


* rd/http-backend-code-simplification (2021-10-25) 1 commit
 - http-backend: remove a duplicated code branch

 (slight) Code simplification.

 Will merge to 'next'?


* sg/sparse-index-not-that-common-a-command (2021-10-25) 1 commit
 - command-list.txt: remove 'sparse-index' from main help

 Drop "git sparse-index" from the list of common commands.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* ar/submodule-update (2021-10-13) 9 commits
 . submodule--helper: rename helper functions
 . submodule--helper: remove unused helpers
 . submodule: move core cmd_update() logic to C
 . submodule--helper: run update using child process struct
 . submodule--helper: allow setting superprefix for init_submodule()
 . submodule--helper: refactor get_submodule_displaypath()
 . submodule--helper: rename helpers for update-clone
 . submodule--helper: get remote names from any repository
 . submodule--helper: split up ensure_core_worktree()

 Rewrite of "git submodule update" in C.

 Kicked out of 'seen' to make room for es/superproject-aware-submodules
 which is among the topics this topic stomps on.


* pw/diff-color-moved-fix (2021-08-05) 13 commits
 - diff: drop unused options parameter from cmp_in_block_with_wsd()
 - diff --color-moved: intern strings
 - diff: use designated initializers for emitted_diff_symbol
 - diff --color-moved-ws=allow-indentation-change: improve hash lookups
 - diff --color-moved: stop clearing potential moved blocks
 - diff --color-moved: shrink potential moved blocks as we go
 - diff --color-moved: unify moved block growth functions
 - diff --color-moved: call comparison function directly
 - diff --color-moved-ws=allow-indentation-change: simplify and optimize
 - diff: simplify allow-indentation-change delta calculation
 - diff --color-moved: avoid false short line matches and bad zerba coloring
 - diff --color-moved=zebra: fix alternate coloring
 - diff --color-moved: add perf tests

 Originally merged to 'next' on 2021-08-05

 Long-overdue correctness and performance update to "diff
 --color-moved" feature.

 Expecting a reroll.
 cf. <8bec1a6d-5052-50c3-4100-e6348289d581@gmail.com>


* cf/fetch-set-upstream-while-detached (2021-07-06) 1 commit
 - fetch: fix segfault on --set-upstream while on a detached HEAD

 "git fetch --set-upstream" while on detached HEAD segfaulted
 instead of noticing that such an operation did not make sense.

 Expecting a reroll.
 cf. <xmqqsg0ri5mq.fsf@gitster.g>

--------------------------------------------------
[Cooking]

* gc/remote-with-fewer-static-global-variables (2021-10-20) 4 commits
 - remote: add struct repository parameter to external functions
 - remote: remove the_repository->remote_state from static methods
 - remote: use remote_state parameter internally
 - remote: move static variables into per-repository struct

 Code clean-up to eventually allow information on remotes defined
 for an arbitrary repository to be read.

 Expecting a reroll.

 Breaks pushremote_get() and causes "git push" to segfault; there
 might be other similar breakages.
 cf. <xmqqtuhbo2tn.fsf@gitster.g>


* jk/loosen-urlmatch (2021-10-12) 1 commit
  (merged to 'next' on 2021-10-25 at f66ca39ebe)
 + urlmatch: add underscore to URL_HOST_CHARS

 Treat "_" as any other URL-valid characters in an URL when matching
 the per-URL configuration variable names.

 Will merge to 'master'.


* ab/test-bail (2021-10-14) 2 commits
  (merged to 'next' on 2021-10-23 at 4a16ebdb74)
 + test-lib.sh: use "Bail out!" syntax on bad SANITIZE=leak use
 + test-lib.sh: de-duplicate error() teardown code

 A new feature has been added to abort early in the test framework.

 Will merge to 'master'.


* ab/config-based-hooks-2 (2021-10-20) 14 commits
 - run-command: remove old run_hook_{le,ve}() hook API
 - receive-pack: convert push-to-checkout hook to hook.h
 - read-cache: convert post-index-change to use hook.h
 - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
 - git-p4: use 'git hook' to run hooks
 - send-email: use 'git hook run' for 'sendemail-validate'
 - git hook run: add an --ignore-missing flag
 - merge: convert post-merge to use hook.h
 - hooks: convert 'post-checkout' hook to hook library
 - am: convert applypatch to use hook.h
 - rebase: convert pre-rebase to use hook.h
 - gc: use hook library for pre-auto-gc hook
 - hook: add 'run' subcommand
 - Merge branch 'ab/config-based-hooks-1' into ab/config-based-hooks-2

 More "config-based hooks".


* ab/ignore-replace-while-working-on-commit-graph (2021-10-15) 3 commits
  (merged to 'next' on 2021-10-25 at 5ed4266a96)
 + commit-graph: don't consider "replace" objects with "verify"
 + commit-graph tests: fix another graph_git_two_modes() helper
 + commit-graph tests: fix error-hiding graph_git_two_modes() helper
 (this branch is used by gc/use-repo-settings.)

 Teach "git commit-graph" command not to allow using replace objects
 at all, as we do not use the commit-graph at runtime when we see
 object replacement.

 Will merge to 'master'.


* so/stash-staged (2021-10-18) 1 commit
  (merged to 'next' on 2021-10-25 at 68b88e35c4)
 + stash: implement '--staged' option for 'push' and 'save'

 "git stash" learned the "--staged" option to stash away what has
 been added to the index (and nothing else).

 Will merge to 'master'.


* vd/sparse-sparsity-fix-on-read (2021-10-21) 3 commits
 - sparse-index: update do_read_index to ensure correct sparsity
 - sparse-index: add ensure_correct_sparsity function
 - test-read-cache.c: prepare_repo_settings after config init

 Ensure that the sparseness of the in-core index matches the
 index.sparse configuration specified by the repository immediately
 after the on-disk index file is read.


* jc/fix-ref-sorting-parse (2021-10-20) 2 commits
 - for-each-ref: delay parsing of --sort=<atom> options
 - Merge branch 'ab/ref-filter-leakfix' into jc/fix-ref-sorting-parse
 (this branch uses ab/ref-filter-leakfix.)

 Things like "git -c branch.sort=bogus branch new HEAD", i.e. the
 operation modes of the "git branch" command that do not need the
 sort key information, no longer errors out by seeing a bogus sort
 key.

 Will merge to 'next'.


* jc/tutorial-format-patch-base (2021-10-23) 1 commit
 - MyFirstContribution: teach to use "format-patch --base=auto"

 Teach and encourage first-time contributors to this project to
 state the base commit when they submit their topic.

 Will merge to 'next'.


* jk/http-push-status-fix (2021-10-18) 2 commits
  (merged to 'next' on 2021-10-23 at 9704ff261d)
 + transport-helper: recognize "expecting report" error from send-pack
 + send-pack: complain about "expecting report" with --helper-status

 "git push" client talking to an HTTP server did not diagnose the
 lack of the final status report from the other side correctly,
 which has been corrected.

 Will merge to 'master'.


* js/branch-track-inherit (2021-10-18) 1 commit
 - branch: add flags and config to inherit tracking

 "git -c branch.autosetupmerge=inherit branch new old" makes "new"
 to have the same upstream as the "old" branch, instead of marking
 "old" itself as its upstream.

 Under discussion.
 cf. <87a6j6tbsv.fsf@gmgdl.gmail.com>


* rb/doc-commit-header-continuation-line (2021-10-11) 1 commit
 - signature-format.txt: add space to fix gpgsig continuation line

 Values in the header portion of commit object can be multi-lined
 by a single SP indentation of the second and subsequent lines, and
 this applies to an empty line as well.  Update an example in the
 technical documentation to highlight it.

 Will discard.

 Superseded by the jc/doc-commit-header-continuation-line topic.


* jh/builtin-fsmonitor-part2 (2021-10-21) 29 commits
 - t7527: test status with untracked-cache and fsmonitor--daemon
 - fsmonitor: force update index after large responses
 - fsmonitor--daemon: use a cookie file to sync with file system
 - fsmonitor--daemon: periodically truncate list of modified files
 - t/perf/p7519: add fsmonitor--daemon test cases
 - t/perf/p7519: speed up test on Windows
 - t/helper/test-chmtime: skip directories on Windows
 - t/perf: avoid copying builtin fsmonitor files into test repo
 - t7527: create test for fsmonitor--daemon
 - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
 - help: include fsmonitor--daemon feature flag in version info
 - fsmonitor--daemon: implement handle_client callback
 - compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacOS
 - compat/fsmonitor/fsm-listen-darwin: add macos header files for FSEvent
 - compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on Windows
 - fsmonitor--daemon: create token-based changed path cache
 - fsmonitor--daemon: define token-ids
 - fsmonitor--daemon: add pathname classification
 - fsmonitor--daemon: implement 'start' command
 - fsmonitor--daemon: implement 'run' command
 - compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
 - compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
 - fsmonitor--daemon: implement 'stop' and 'status' commands
 - fsmonitor--daemon: add a built-in fsmonitor daemon
 - fsmonitor: document builtin fsmonitor
 - fsmonitor: use IPC to query the builtin FSMonitor daemon
 - fsmonitor: config settings are repository-specific
 - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 - fsmonitor: enhance existing comments

 Built-in fsmonitor (part 2).


* ld/sparse-diff-blame (2021-10-15) 3 commits
 - blame: enable and test the sparse index
 - diff: enable and test the sparse index
 - Merge branch 'vd/sparse-reset' into ld/sparse-diff-blame
 (this branch uses vd/sparse-reset.)

 Teach diff and blame to work well with sparse index.


* mp/absorb-submodule-git-dir-upon-deinit (2021-10-07) 1 commit
 - submodule: absorb git dir instead of dying on deinit

 "git submodule deinit" for a submodule whose .git metadata
 directory is embedded in its working tree refused to work, until
 the submodule gets converted to use the "absorbed" form where the
 metadata directory is stored in superproject, and a gitfile at the
 top-level of the working tree of the submodule points at it.  The
 command is taught to convert such submodules to the absorbed form
 as needed.

 Under review.
 cf. <xmqqwnmopqqk.fsf@gitster.g>


* ns/remerge-diff (2021-10-08) 8 commits
 - doc/diff-options: explain the new --remerge-diff option
 - show, log: adapt Elijah Newren's changes to common tmp-objdir API
 - show, log: provide a --remerge-diff capability
 - merge-ort: capture and print ll-merge warnings in our preferred fashion
 - ll-merge: add API for capturing warnings in a strbuf instead of stderr
 - merge-ort: add ability to record conflict messages in a file
 - merge-ort: mark a few more conflict messages as omittable
 - Merge branch 'ns/tmp-objdir' into ns/remerge-diff
 (this branch uses ns/tmp-objdir.)

 A new presentation for two-parent merge "--remerge-diff" can be
 used to show the difference between mechanical (and possibly
 conflicted) merge results and the recorded resolution.

 On hold.
 This is Elijah's remerge-diff rebased on ns/tmp-objdir to share the
 "create objects temporarily, only to discard without committing
 them to longer-term storage" infrastructure with another topic.


* ns/tmp-objdir (2021-10-04) 2 commits
  (merged to 'next' on 2021-10-23 at 358d376f61)
 + tmp-objdir: disable ref updates when replacing the primary odb
 + tmp-objdir: new API for creating temporary writable databases
 (this branch is used by ns/batched-fsync and ns/remerge-diff.)

 New interface into the tmp-objdir API to help in-core use of the
 quarantine feature.

 Will merge to 'master'.


* vd/sparse-reset (2021-10-11) 8 commits
 - unpack-trees: improve performance of next_cache_entry
 - reset: make --mixed sparse-aware
 - reset: make sparse-aware (except --mixed)
 - reset: integrate with sparse index
 - reset: expand test coverage for sparse checkouts
 - sparse-index: update command for expand/collapse test
 - reset: preserve skip-worktree bit in mixed reset
 - reset: rename is_missing to !is_in_reset_tree
 (this branch is used by ld/sparse-diff-blame.)

 Various operating modes of "git reset" have been made to work
 better with the sparse index.

 Needs review.


* gc/use-repo-settings (2021-10-15) 4 commits
  (merged to 'next' on 2021-10-25 at 3d38c09a8d)
 + gc: perform incremental repack when implictly enabled
 + fsck: verify multi-pack-index when implictly enabled
 + fsck: verify commit graph when implicitly enabled
 + Merge branch 'ab/ignore-replace-while-working-on-commit-graph' into gc/use-repo-settings
 (this branch uses ab/ignore-replace-while-working-on-commit-graph.)

 It is wrong to read some settings directly from the config
 subsystem, as things like feature.experimental can affect their
 default values.

 Will merge to 'master'.


* pw/fix-some-issues-in-reset-head (2021-10-01) 12 commits
 - rebase -m: don't fork git checkout
 - rebase --apply: set ORIG_HEAD correctly
 - rebase --apply: fix reflog
 - reset_head(): take struct rebase_head_opts
 - rebase: cleanup reset_head() calls
 - reset_head(): make default_reflog_action optional
 - reset_head(): factor out ref updates
 - reset_head(): remove action parameter
 - reset_head(): don't run checkout hook if there is an error
 - reset_head(): fix checkout
 - rebase: factor out checkout for up to date branch
 - Merge branch 'pw/rebase-of-a-tag-fix' into pw/fix-some-issues-in-reset-head

 Fix "some issues" in a helper function reset_head().

 Expecting a reroll.
 Needs a lot better explanation, including what the issues are,
 which codepaths the helper is used and to do what, and tests to
 protect the fixes.


* es/superproject-aware-submodules (2021-10-14) 4 commits
 - submodule: record superproject gitdir during 'update'
 - submodule: record superproject gitdir during absorbgitdirs
 - introduce submodule.superprojectGitDir record
 - t7400-submodule-basic: modernize inspect() helper

 A configuration variable in a submodule points at the location of
 the superproject it is bound to (RFC).

 Under discussion.
 cf. <911ab2c1-8a11-d9d0-4b28-fc801112f6da@gmail.com>


* tp/send-email-completion (2021-10-07) 3 commits
 - send-email docs: add format-patch options
 - send-email: programmatically generate bash completions
 - send-email: terminate --git-completion-helper with LF

 The command line complation for "git send-email" options have been
 tweaked to make it easier to keep it in sync with the command itself.

 Expecting a reroll.
 cf. <87fst7lkjx.fsf@evledraar.gmail.com>


* hm/paint-hits-in-log-grep (2021-10-15) 4 commits
  (merged to 'next' on 2021-10-25 at e3edea3fa9)
 + grep/pcre2: fix an edge case concerning ascii patterns and UTF-8 data
 + pretty: colorize pattern matches in commit messages
 + grep: refactor next_match() and match_one_pattern() for external use
 + Merge branch 'jk/grep-haystack-is-read-only' into hm/paint-hits-in-log-grep

 "git log --grep=string --author=name" learns to highlight hits just
 like "git grep string" does.

 Will merge to 'master'.


* ks/submodule-add-message-fix (2021-10-23) 1 commit
  (merged to 'next' on 2021-10-25 at 377e759528)
 + submodule--helper: fix incorrect newlines in an error message

 Message regression fix.

 Will merge to 'master'.


* ns/batched-fsync (2021-10-08) 8 commits
  (merged to 'next' on 2021-10-25 at e45c907d41)
 + core.fsyncobjectfiles: performance tests for add and stash
 + core.fsyncobjectfiles: tests for batch mode
 + unpack-objects: use the bulk-checkin infrastructure
 + update-index: use the bulk-checkin infrastructure
 + core.fsyncobjectfiles: add windows support for batch mode
 + core.fsyncobjectfiles: batched disk flushes
 + bulk-checkin: rename 'state' variable and separate 'plugged' boolean
 + Merge branch 'ns/tmp-objdir' into ns/batched-fsync
 (this branch uses ns/tmp-objdir.)

 The "core.fsyncobjectfiles" configuration variable can now be set
 to "batch" for improved performance.

 Will merge to 'master'.


* en/zdiff3 (2021-09-20) 2 commits
 - update documentation for new zdiff3 conflictStyle
 - xdiff: implement a zealous diff3, or "zdiff3"

 "Zealous diff3" style of merge conflict presentation has been added.


* js/scalar (2021-10-07) 15 commits
 - scalar: accept -C and -c options before the subcommand
 - scalar: implement the `version` command
 - scalar: implement the `delete` command
 - scalar: teach 'reconfigure' to optionally handle all registered enlistments
 - scalar: allow reconfiguring an existing enlistment
 - scalar: implement the `run` command
 - scalar: teach 'clone' to support the --single-branch option
 - scalar: implement the `clone` subcommand
 - scalar: implement 'scalar list'
 - scalar: let 'unregister' handle a deleted enlistment directory gracefully
 - scalar: 'unregister' stops background maintenance
 - scalar: 'register' sets recommended config and starts maintenance
 - scalar: create test infrastructure
 - scalar: start documenting the command
 - scalar: create a rudimentary executable

 Add pieces from "scalar" to contrib/.

 What's the status of this thing?


* ms/customizable-ident-expansion (2021-09-01) 1 commit
 - keyword expansion: make "$Id$" string configurable

 Instead of "$Id$", user-specified string (like $FreeBSD$) can be
 used as an in-blob placeholder for keyword expansion.

 What's the status of this one?  Meh?


* ab/refs-errno-cleanup (2021-10-16) 21 commits
 - refs API: post-migration API renaming [2/2]
 - refs API: post-migration API renaming [1/2]
 - refs API: don't expose "errno" in run_transaction_hook()
 - refs API: make expand_ref() & repo_dwim_log() not set errno
 - refs API: make resolve_ref_unsafe() not set errno
 - refs API: make refs_ref_exists() not set errno
 - refs API: make refs_resolve_refdup() not set errno
 - refs tests: ignore ignore errno in test-ref-store helper
 - refs API: ignore errno in worktree.c's find_shared_symref()
 - refs API: ignore errno in worktree.c's add_head_info()
 - refs API: make files_copy_or_rename_ref() et al not set errno
 - refs API: make loose_fill_ref_dir() not set errno
 - refs API: make resolve_gitlink_ref() not set errno
 - refs API: remove refs_read_ref_full() wrapper
 - refs/files: remove "name exist?" check in lock_ref_oid_basic()
 - reflog tests: add --updateref tests
 - refs API: make refs_rename_ref_available() static
 - refs API: make parse_loose_ref_contents() not set errno
 - refs API: make refs_read_raw_ref() not set errno
 - refs API: add a version of refs_resolve_ref_unsafe() with "errno"
 - branch tests: test for errno propagating on failing read

 The "remainder" of hn/refs-errno-cleanup topic.

 Will merge to 'next'.


* ab/only-single-progress-at-once (2021-10-13) 10 commits
 - progress.c: add & assert a "global_progress" variable
 - various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
 - pack-bitmap-write.c: don't return without stop_progress()
 - progress.c: add temporary variable from progress struct
 - progress.c: call progress_interval() from progress_test_force_update()
 - progress.c: move signal handler functions lower
 - progress.c tests: test some invalid usage
 - progress.c tests: make start/stop verbs on stdin
 - progress.c test helper: add missing braces
 - leak tests: fix a memory leaks in "test-progress" helper

 Further tweaks on progress API.

 Need to pick up an updated version.
 cf. <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>


* hn/reftable (2021-10-08) 19 commits
 - Add "test-tool dump-reftable" command.
 - reftable: add dump utility
 - reftable: implement stack, a mutable database of reftable files.
 - reftable: implement refname validation
 - reftable: add merged table view
 - reftable: add a heap-based priority queue for reftable records
 - reftable: reftable file level tests
 - reftable: read reftable files
 - reftable: generic interface to tables
 - reftable: write reftable files
 - reftable: a generic binary tree implementation
 - reftable: reading/writing blocks
 - Provide zlib's uncompress2 from compat/zlib-compat.c
 - reftable: (de)serialization for the polymorphic record type.
 - reftable: add blocksource, an abstraction for random access reads
 - reftable: utility functions
 - reftable: add error related functionality
 - reftable: add LICENSE
 - hash.h: provide constants for the hash IDs

 The "reftable" backend for the refs API, without integrating into
 the refs subsystem.

--------------------------------------------------
[Discarded]

* en/remerge-diff (2021-08-31) 7 commits
 . doc/diff-options: explain the new --remerge-diff option
 . show, log: provide a --remerge-diff capability
 . tmp-objdir: new API for creating and removing primary object dirs
 . merge-ort: capture and print ll-merge warnings in our preferred fashion
 . ll-merge: add API for capturing warnings in a strbuf instead of stderr
 . merge-ort: add ability to record conflict messages in a file
 . merge-ort: mark a few more conflict messages as omittable

 A new presentation for two-parent merge "--remerge-diff" can be
 used to show the difference between mechanical (and possibly
 conflicted) merge results and the recorded resolution.
