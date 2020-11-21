Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE95C388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 22:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC3520663
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 22:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bqy+Alyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgKUW56 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 17:57:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64140 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgKUW55 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 17:57:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A15F2110A9B;
        Sat, 21 Nov 2020 17:57:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=/
        L8PtsvJ+jO44JH5sWwBK3sRSdk=; b=bqy+Alyy1jgi1GGwISb+36PIHB3lmZeyr
        6HznyMPTUWGie4lb1gW+/ofhJD9ftJBe9QeSHhioML4a/I5KuZmmX/yUH1JYUzBU
        0hmNZJhbEplzwKsSinvetPYBCyXsKUtFfpf4I6GVMoPH1N953vrKSPRFRPhxpKWg
        mlvhcUrdsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=hLp
        0lhHDM7/tYaxGucxqSVRc4q1hBCiPfum2+cfVf1RIjMK/NQb03X9x9XwP9eAHeIb
        IHb4zraCiQ6H21AxMUUazbS6CKE1xOA4dn054mmWMGTH30L6BG/zU2Ol/6ixQRpD
        bAFjDg7ktHhbEsXuimKrMGA+rhEL7JKFa6pOq2JE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AAEB110A9A;
        Sat, 21 Nov 2020 17:57:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BF1B4110A99;
        Sat, 21 Nov 2020 17:57:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2020, #04; Thu, 19)
X-master-at: faefdd61ec7c7f6f3c8c9907891465ac9a2a1475
X-next-at: 04529851e543a22b6ba47fbb72737de4c325bb07
Date:   Sat, 21 Nov 2020 14:57:42 -0800
Message-ID: <xmqqwnyeqpw9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6FEFE64-2C4C-11EB-AF2E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The sixth batch of topics are in 'master' and the tests are being
prepared not to be disrupted by a potential change of the default
name for the initial branch.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into.  Some repositories have
only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/

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

* ds/maintenance-part-3 (2020-10-16) 8 commits
  (merged to 'next' on 2020-11-10 at fe9475c696)
 + maintenance: add troubleshooting guide to docs
 + maintenance: use 'incremental' strategy by default
 + maintenance: create maintenance.strategy config
 + maintenance: add start/stop subcommands
 + maintenance: add [un]register subcommands
 + for-each-repo: run subcommands on configured repos
 + maintenance: add --schedule option and config
 + maintenance: optionally skip --auto process
 (this branch is used by ds/maintenance-part-4.)

 Parts of "git maintenance" to ease writing crontab entries (and
 other scheduling system configuration) for it.


* dd/upload-pack-stateless-eof (2020-10-30) 1 commit
  (merged to 'next' on 2020-11-09 at 01a1f1d4fd)
 + upload-pack: allow stateless client EOF just prior to haves

 "git fetch --depth=<n>" over the stateless RPC / smart HTTP
 transport handled EOF from the client poorly at the server end.


* dg/bswap-msvc (2020-11-11) 2 commits
  (merged to 'next' on 2020-11-11 at 6b9e819b17)
 + compat/bswap.h: don't assume MSVC is little-endian
  (merged to 'next' on 2020-11-09 at 91a67b86f7)
 + compat/bswap.h: simplify MSVC endianness detection

 Define ARM64 compiled with MSVC to be little-endian.


* en/merge-ort-api-null-impl (2020-11-02) 4 commits
  (merged to 'next' on 2020-11-10 at ed9eed1558)
 + merge,rebase,revert: select ort or recursive by config or environment
 + fast-rebase: demonstrate merge-ort's API via new test-tool command
 + merge-ort-wrappers: new convience wrappers to mimic the old merge API
 + merge-ort: barebones API of new merge strategy with empty implementation
 (this branch is used by en/merge-ort-impl.)

 Preparation for a new merge strategy.


* en/merge-tests (2020-10-26) 9 commits
  (merged to 'next' on 2020-11-09 at 8ac9fe94a7)
 + t6423: add more details about direct resolution of directories
 + t6423: note improved ort handling with untracked files
 + t6423, t6436: note improved ort handling with dirty files
 + merge tests: expect slight differences in output for recursive vs. ort
 + t6423: expect improved conflict markers labels in the ort backend
 + t6404, t6423: expect improved rename/delete handling in ort backend
 + t6416: correct expectation for rename/rename(1to2) + directory/file
 + merge tests: expect improved directory/file conflict handling in ort
 + t/: new helper for tests that pass with ort but fail with recursive

 Preparation for a new merge strategy.


* jc/blame-ignore-fix (2020-11-10) 1 commit
  (merged to 'next' on 2020-11-10 at 384ace449d)
 + blame: silently ignore invalid ignore file objects

 "git blame --ignore-revs-file=<file>" learned to ignore a
 non-existent object name in the input, instead of complaining.


* jc/line-log-takes-no-pathspec (2020-11-04) 1 commit
  (merged to 'next' on 2020-11-09 at 47c2c88b9d)
 + log: diagnose -L used with pathspec as an error

 "git log -L<range>:<path>" is documented to take no pathspec, but
 this was not enforced by the command line option parser, which has
 been corrected.


* jc/sparse-error-for-developer-build (2020-10-31) 1 commit
  (merged to 'next' on 2020-11-10 at 8cfbe66736)
 + Makefile: enable -Wsparse-error for DEVELOPER build

 "make DEVELOPER=1 sparse" used to run sparse and let it emit
 warnings; now such warnings will cause an error.


* jk/format-patch-output (2020-11-04) 3 commits
  (merged to 'next' on 2020-11-09 at 1f1bb6ebff)
 + format-patch: support --output option
 + format-patch: tie file-opening logic to output_directory
 + format-patch: refactor output selection

 "git format-patch --output=there" did not work as expected and
 instead crashed.  The option is now supported.


* js/default-branch-name-adjust-t5515 (2020-11-02) 4 commits
  (merged to 'next' on 2020-11-09 at 568ba5aba5)
 + t5515: use `main` as the name of the main branch for testing (conclusion)
 + t5515: use `main` as the name of the main branch for testing (part 3)
 + t5515: use `main` as the name of the main branch for testing (part 2)
 + t5515: use `main` as the name of the main branch for testing (part 1)

 Prepare a test script to transition of the default branch name to
 'main'.


* nk/perf-fsmonitor (2020-10-26) 10 commits
  (merged to 'next' on 2020-11-09 at 9fed160a17)
 + t/perf/fsmonitor: add benchmark for dirty status
 + t/perf/fsmonitor: perf comparison of multiple fsmonitor integrations
 + t/perf/fsmonitor: initialize test with git reset
 + t/perf/fsmonitor: factor setup for fsmonitor into function
 + t/perf/fsmonitor: silence initial git commit
 + t/perf/fsmonitor: shorten DESC to basename
 + t/perf/fsmonitor: factor description out for readability
 + t/perf/fsmonitor: improve error message if typoing hook name
 + t/perf/fsmonitor: move watchman setup to one-time-repo-setup
 + t/perf/fsmonitor: separate one time repo initialization

 Add t/perf support for fsmonitor.


* pb/blame-funcname-range-userdiff (2020-11-01) 8 commits
  (merged to 'next' on 2020-11-10 at 221bb3f773)
 + blame: simplify 'setup_blame_bloom_data' interface
 + blame: simplify 'setup_scoreboard' interface
 + blame: enable funcname blaming with userdiff driver
 + line-log: mention both modes in 'blame' and 'log' short help
 + doc: add more pointers to gitattributes(5) for userdiff
 + blame-options.txt: also mention 'funcname' in '-L' description
 + doc: line-range: improve formatting
 + doc: log, gitk: move '-L' description to 'line-range-options.txt'

 "git blame -L :funcname -- path" did not work well for a path for
 which a userdiff driver is defined.


* pw/rebase-i-orig-head (2020-11-04) 4 commits
  (merged to 'next' on 2020-11-10 at 038a5295f5)
 + rebase -i: simplify get_revision_ranges()
 + rebase -i: use struct object_id when writing state
 + rebase -i: use struct object_id rather than looking up commit
 + rebase -i: stop overwriting ORIG_HEAD buffer

 "git rebase -i" did not store ORIG_HEAD correctly.
 cf. <xmqq7drbbcj5.fsf@gitster.c.googlers.com>


* rs/archive-high-compression (2020-11-09) 1 commit
  (merged to 'next' on 2020-11-10 at 9bee80950e)
 + archive: support compression levels beyond 9

 "git archive" now allows compression level higher than "-9"
 when generating tar.gz output.


* rs/empty-reflog-check-fix (2020-11-01) 1 commit
  (merged to 'next' on 2020-11-09 at 3da6b6fef0)
 + stash: simplify reflog emptiness check

 The code to see if "git stash drop" can safely remove refs/stash
 has been made more carerful.

--------------------------------------------------
[New Topics]

* rs/hashwrite-be64 (2020-11-12) 3 commits
  (merged to 'next' on 2020-11-18 at 60385c6fa1)
 + pack-write: use hashwrite_be64()
 + midx: use hashwrite_be64()
 + csum-file: add hashwrite_be64()

 Code simplification.

 Will merge to 'master'.


* sg/bisect-approximately-halfway (2020-11-12) 1 commit
  (merged to 'next' on 2020-11-18 at b13026a0f3)
 + bisect: loosen halfway() check for a large number of commits

 "git bisect start/next" in a large span of history spends a lot of
 time trying to come up with exactly the half-way point; this can be
 optimized by stopping when we see a commit that is close enough to
 the half-way point.

 Will merge to 'master'.


* tb/pack-bitmap (2020-11-19) 24 commits
 - pack-bitmap-write: better reuse bitmaps
 - pack-bitmap-write: relax unique rewalk condition
 - pack-bitmap-write: use existing bitmaps
 - pack-bitmap: factor out 'add_commit_to_bitmap()'
 - pack-bitmap: factor out 'bitmap_for_commit()'
 - pack-bitmap-write: ignore BITMAP_FLAG_REUSE
 - pack-bitmap-write: build fewer intermediate bitmaps
 - pack-bitmap.c: check reads more aggressively when loading
 - pack-bitmap-write: rename children to reverse_edges
 - t5310: add branch-based checks
 - commit: implement commit_list_contains()
 - bitmap: add bitmap_diff_nonzero()
 - pack-bitmap-write: fill bitmap with commit history
 - pack-bitmap-write: pass ownership of intermediate bitmaps
 - pack-bitmap-write: reimplement bitmap writing
 - ewah: add bitmap_dup() function
 - ewah: implement bitmap_or()
 - ewah: make bitmap growth less aggressive
 - ewah: factor out bitmap growth
 - rev-list: die when --test-bitmap detects a mismatch
 - t5310: drop size of truncated ewah bitmap
 - pack-bitmap: bounds-check size of cache extension
 - pack-bitmap: fix header size check
 - ewah/ewah_bitmap.c: grow buffer past 1

 Various improvement to the codepath that writes out pack bitmaps.


* ab/retire-parse-remote (2020-11-16) 3 commits
  (merged to 'next' on 2020-11-18 at 80d4d8290c)
 + parse-remote: remove this now-unused library
 + submodule: remove sh function in favor of helper
 + submodule: use "fetch" logic instead of custom remote discovery

 "git-parse-remote" shell script library outlived its usefulness.

 Will merge to 'master'.


* jk/4gb-idx (2020-11-16) 5 commits
  (merged to 'next' on 2020-11-18 at 2f99b73bda)
 + packfile: detect overflow in .idx file size checks
 + block-sha1: take a size_t length parameter
 + fsck: correctly compute checksums on idx files larger than 4GB
 + use size_t to store pack .idx byte offsets
 + compute pack .idx byte offsets using size_t

 The code was not prepared to deal with pack .idx file that is
 larger than 4GB.

 Will merge to 'master'.


* ma/list-object-filter-opt-msgfix (2020-11-16) 1 commit
  (merged to 'next' on 2020-11-18 at 7cf396ee81)
 + list-objects-filter-options: fix function name in BUG

 Error message fix.

 Will merge to 'master'.
 We can further update it to lose the hand-maintained function name
 from the message, but that can be done separately.


* mt/rm-sparse-checkout (2020-11-16) 1 commit
 - rm: honor sparse checkout patterns
 (this branch uses mt/grep-sparse-checkout.)

 "git rm" follows suit to "git grep" to ignore paths outside the
 sparsity pattern when the sparse checkout feature is in use.


* pb/pull-rebase-recurse-submodules (2020-11-16) 4 commits
 - pull: check for local submodule modifications with the right range
 - t5572: describe '--rebase' tests a little more
 - t5572: add notes on a peculiar test
 - pull --rebase: compute rebase arguments in separate function

 "git pull --rebase --recurse-submodules" checked for local changes
 in a wrong range and failed to run correctly when it should.

 Will merge to 'next'.


* pk/subsub-fetch-fix (2020-11-12) 1 commit
  (merged to 'next' on 2020-11-18 at bdd3b21b7c)
 + submodules: fix of regression on fetching of non-init subsub-repo

 "git fetch" did not work correctly with nested submodules where the
 innermost submodule that is not of interest got updated in the
 upstream, which has been corrected.

 Will merge to 'master'.


* rs/archive-plug-leak-refname (2020-11-16) 1 commit
  (merged to 'next' on 2020-11-19 at 270ba7b8be)
 + archive: release refname after use

 Memleak fix.

 Will merge to 'master'.


* rs/chdir-notify-unleak (2020-11-16) 1 commit
 - chdir-notify: UNLEAK registrated callback entries

 Mark some stuff on list_head chain with UNLEAK() macro to squelch
 leak checker.

 Will merge to 'next'.


* rs/plug-diff-cache-leak (2020-11-16) 1 commit
 - diff-lib: plug minor memory leaks in do_diff_cache()

 Memleak fix.

 Will merge to 'next'.


* sg/t5310-jgit-wants-sha1 (2020-11-16) 1 commit
  (merged to 'next' on 2020-11-19 at 72fb4e7155)
 + t5310-pack-bitmaps: skip JGit tests with SHA256

 Since jgit does not yet work with SHA-256 repositories, mark the
 tests that uses it not to run unless we are testing with ShA-1
 repositories.

 Will merge to 'master'.


* tb/repack-simplify (2020-11-17) 3 commits
 - builtin/repack.c: don't move existing packs out of the way
 - builtin/repack.c: keep track of what pack-objects wrote
 - repack: make "exts" array available outside cmd_repack()

 Simplify the logic to deal with a repack operation that ended up
 creating the same packfile.

 Will merge to 'next'.


* dd/help-autocorrect-never (2020-11-18) 1 commit
 - help.c: allow help.autocorrect to say "do not even compute suggestions"

 "git $cmd $args", when $cmd is not a recognised subcommand, by
 default tries to see if $cmd is a typo of an existing subcommand
 and optionally executes the corrected command if there is only one
 possibility, depending on the setting of help.autocorrect; the
 users can now disable the whole thing, including the cycles spent
 to find a likely typo, by setting the configuration variable to
 'never'.


* jc/ci-github-set-env (2020-11-17) 1 commit
  (merged to 'next' on 2020-11-19 at 00ff5e06ac)
 + ci: avoid `set-env` construct in print-test-failures.sh

 Another CI adjustment.

 Will merge to 'master'.


* jc/init-doc-default-branch (2020-11-18) 1 commit
 - "init" doc: mention the configurability more clearly

 Doc update.

 Weatherbaloon.


* js/default-branch-name-tests-final-stretch (2020-11-19) 29 commits
 - tests: drop prereq `PREPARE_FOR_MAIN_BRANCH` where no longer needed
 - t99*: adjust the references to the default branch name "main"
 - tests(git-p4): transition to the default branch name `main`
 - t9[5-7]*: adjust the references to the default branch name "main"
 - t9[0-4]*: adjust the references to the default branch name "main"
 - t8*: adjust the references to the default branch name "main"
 - t7[5-9]*: adjust the references to the default branch name "main"
 - t7[0-4]*: adjust the references to the default branch name "main"
 - t6[4-9]*: adjust the references to the default branch name "main"
 - t64*: preemptively adjust alignment to prepare for `master` -> `main`
 - t6[0-3]*: adjust the references to the default branch name "main"
 - t5[6-9]*: adjust the references to the default branch name "main"
 - t55[4-9]*: adjust the references to the default branch name "main"
 - t55[23]*: adjust the references to the default branch name "main"
 - t551*: adjust the references to the default branch name "main"
 - t550*: adjust the references to the default branch name "main"
 - t5503: prepare aligned comment for replacing `master` with `main`
 - t5[0-4]*: adjust the references to the default branch name "main"
 - t5323: prepare centered comment for `master` -> `main`
 - t4*: adjust the references to the default branch name "main"
 - t3[5-9]*: adjust the references to the default branch name "main"
 - t34*: adjust the references to the default branch name "main"
 - t3416: preemptively adjust alignment in a comment
 - t3[0-3]*: adjust the references to the default branch name "main"
 - t2*: adjust the references to the default branch name "main"
 - t[01]*: adjust the references to the default branch name "main"
 - t0060: preemptively adjust alignment
 - tests: mark tests relying on the current default for `init.defaultBranch`
 - Merge 'jk/diff-release-filespec-fix' into js/default-branch-name-tests-final-stretch
 (this branch uses jk/diff-release-filespec-fix.)

 Prepare tests not to be affected by the name of the default branch
 "git init" creates.


* js/t2106-cleanup (2020-11-18) 3 commits
 - t2106: ensure that the checkout fails for the expected reason
 - t2106: make test independent of the current main branch name
 - t2106: adjust style to the current conventions

 A test script got cleaned up and then made not to depend on the
 value of init.defaultBranch.

 Will merge to 'next'.


* js/t3040-cleanup (2020-11-18) 1 commit
 - t3040: remove stale note

 Cleanup.

 Will merge to 'next'.


* js/t4015-wo-master (2020-11-19) 1 commit
 - t4015: let the test pass with any default branch name

 A test script got cleaned up not to depend on the value of
 init.defaultBranch.

 Will merge to 'next'.


* rs/gc-sort-func-cast-fix (2020-11-18) 1 commit
  (merged to 'next' on 2020-11-19 at 04529851e5)
 + gc: fix cast in compare_tasks_by_selection()

 Fix broken sorting of maintenance tasks.

 Will merge to 'master'.


* sg/tests-prereq (2020-11-18) 2 commits
 - tests: fix description of 'test_set_prereq'
 - tests: make sure nested lazy prereqs work reliably

 A lazily defined test prerequisite can now be defined in terms of
 another lazily defined test prerequisite.

 Will merge to 'next'.


* ds/config-literal-value (2020-11-19) 6 commits
 - config: implement --literal-value with --get*
 - config: plumb --literal-value into config API
 - config: add --literal-value option, un-implemented
 - config: convert multi_replace to flags
 - t1300: add test for --replace-all with value_regex
 - t1300: test "set all" mode with value_regex
 (this branch is used by ds/maintenance-part-3.)


* ds/maintenance-part-3 (2020-11-19) 2 commits
 - maintenance: use 'git config --literal-value'
 - Merge branch 'ds/config-literal-value' into ds/maintenance-part-3
 (this branch uses ds/config-literal-value.)

 "git maintenance" command had trouble working in a directory whose
 pathname contained an ERE metacharacter like '+'.

 Will merge to 'next'.


* js/pull-rebase-use-advise (2020-11-19) 1 commit
 - pull: colorize the hint about setting `pull.rebase`


* js/t1309-master-to-topic (2020-11-19) 1 commit
 - t1309: use a neutral branch name in the `onbranch` test cases

--------------------------------------------------
[Stalled]

* jk/symlinked-dotgitx-files (2020-10-23) 9 commits
  (merged to 'next' on 2020-10-26 at c1dd37b024)
 + docs: document symlink restrictions for .git* files
 + fsck: complain when .gitattributes or .gitignore is a symlink
 + verify_path(): disallow symlinks in .gitattributes and .gitignore
 + t0060: test obscured .gitattributes and .gitignore matching
 + t7450: test .gitmodules symlink matching against obscured names
 + t7450: test verify_path() handling of gitmodules
 + t7415: rename to expand scope
 + fsck_tree(): wrap some long lines
 + fsck_tree(): fix shadowed variable

 Originally merged to 'next' on 2020-10-23

 "git fsck" and the corresponding check done during the transport
 learned to ensure that in-tree files like `.gitignore` and
 `.gitattributes` are not symbolic links.

 It seems that there are real projects with .gitignore recorded as
 symlinks, which may need to loosen the fsck setting.  Do we need to
 introduce a class that is separate from symlinked .gitmodules that
 probably is with potential consequences that is more/less grave?


* es/config-hooks (2020-10-16) 8 commits
 - hook: replace find_hook() with hook_exists()
 - hook: add 'run' subcommand
 - parse-options: parse into strvec
 - hook: implement hookcmd.<name>.skip
 - hook: include hookdir hook in list
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.


* hn/reftable (2020-10-01) 13 commits
 . reftable: "test-tool dump-reftable" command.
 . reftable: rest of library
 . reftable: file level tests
 . reftable: read reftable files
 . reftable: write reftable files
 . reftable: a generic binary tree implementation
 . reftable: reading/writing blocks
 . reftable: (de)serialization for the polymorphic record type.
 . reftable: utility functions
 . reftable: add a barebones unittest framework
 . vcxproj: adjust for the reftable changes
 . reftable: define the public API
 . reftable: add LICENSE

 The reftable backend for the refs API.

 Expecting a reroll.
 Seems not to build for Windows folks.
 cf. <nycvar.QRO.7.76.6.2010021555290.50@tvgsbejvaqbjf.bet>
 cf. <nycvar.QRO.7.76.6.2010021557570.50@tvgsbejvaqbjf.bet>


* sm/curl-retry (2020-10-13) 3 commits
 - http: automatically retry some requests
 - replace CURLOPT_FILE With CURLOPT_WRITEDATA
 - remote-curl: add testing for intelligent retry for HTTP

 The http transport has been taught to retry a failed request that
 may reasonably be retried.

 Expecting a reroll.
 cf. <20201015000410.GB328643@google.com>
 cf. <CAM4o00eefXK2CJ_FxwwVPpBKL01JsJANf+SdjCtw_0NVV82L+Q@mail.gmail.com>


* sv/t7001-modernize (2020-09-25) 11 commits
 - t7001: move cleanup code from outside the tests into them
 - t7001: use `test` rather than `[`
 - t7001: use here-docs instead of echo
 - t7001: put each command on a separate line
 - t7001: use ': >' rather than 'touch'
 - t7001: change (cd <path> && git foo) to (git -C <path> foo)
 - t7001: remove whitespace after redirect operators
 - t7001: change the style for cd according to subshell
 - t7001: remove unnecessary blank lines
 - t7001: use TAB instead of spaces
 - t7001: convert tests from the old style to the current style

 Test script modernization.

 Expecting a reroll.
 cf. <20200925170256.11490-1-shubhunic@gmail.com>


* ew/decline-core-abbrev (2020-09-01) 1 commit
 - core.abbrev <off|false|no> disables abbreviations

 Allow the configuration to specify no abbreviation regardless of
 the hash algorithm.

 Expecting a reroll.  The intent is very good.


* bc/rev-parse-path-format (2020-10-09) 2 commits
 - rev-parse: add option for absolute or relative path formatting
 - abspath: add a function to resolve paths with missing components

 "git rev-parse" can be explicitly told to give output as absolute
 or relative path.


* ar/fetch-transfer-ipversion (2020-09-16) 1 commit
 - config: option transfer.ipversion to set transport protocol version for network fetches

 Adds transfer.ipversion configuration variable.

 Needs more work.


* vv/send-email-with-less-secure-apps-access (2020-08-29) 1 commit
 - Documentation/git-send-email.txt: Mention less secure app access might need to enable.

 Doc update.

 Expecting a reroll.
 cf. <xmqqwo1hi9nv.fsf@gitster.c.googlers.com>
 cf. <xmqqft85i72s.fsf@gitster.c.googlers.com>


* jc/war-on-dashed-git (2020-08-27) 1 commit
 - git: catch an attempt to run "git-foo"

 The first step to remove on-disk binaries for built-in subcommands
 by soliciting objections.

 On hold for now.


* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Discard for now.
 cf. <xmqqv9gu7c61.fsf@gitster.c.googlers.com>
 cf. <20200911214358.acl3hy2e763begoo@feanor>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Needs Review]

* ss/submodule-add-in-c (2020-10-07) 3 commits
 . t7400: add test to check 'submodule add' for tracked paths
 . submodule: port submodule subcommand 'add' from shell to C
 . dir: change the scope of function 'directory_exists_in_index()'

 "git submodule add" being rewritten in C.


* mt/parallel-checkout-part-1 (2020-11-04) 19 commits
 - ci: run test round with parallel-checkout enabled
 - parallel-checkout: add tests related to .gitattributes
 - parallel-checkout: add tests related to clone collisions
 - parallel-checkout: add tests for basic operations
 - checkout-index: add parallel checkout support
 - builtin/checkout.c: complete parallel checkout support
 - make_transient_cache_entry(): optionally alloc from mem_pool
 - parallel-checkout: support progress displaying
 - parallel-checkout: make it truly parallel
 - unpack-trees: add basic support for parallel checkout
 - entry: add checkout_entry_ca() which takes preloaded conv_attrs
 - entry: move conv_attrs lookup up to checkout_entry()
 - entry: extract cache_entry update from write_entry()
 - entry: make fstat_output() and read_blob_entry() public
 - entry: extract a header file for entry.c functions
 - convert: add conv_attrs classification
 - convert: add get_stream_filter_ca() variant
 - convert: add [async_]convert_to_working_tree_ca() variants
 - convert: make convert_attrs() and convert structs public

 Parallel checkout.


* mt/grep-sparse-checkout (2020-09-10) 9 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: correctly read worktree configs in submodules
 - config: make do_git_config_sequence receive a 'struct repository'
 - t/helper/test-config: unify exit labels
 - t/helper/test-config: diagnose missing arguments
 - t/helper/test-config: be consistent with exit codes
 - t1308-config-set: avoid false positives when using test-config
 - doc: grep: unify info on configuration variables
 (this branch is used by mt/rm-sparse-checkout.)

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.

--------------------------------------------------
[Cooking]

* ag/merge-strategies-in-c (2020-11-16) 12 commits
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
 - t6027: modernise tests

 The resolve and octopus merge strategy backends have been rewritten
 in C.


* ps/update-ref-multi-transaction (2020-11-16) 4 commits
 - update-ref: disallow "start" for ongoing transactions
 - p1400: use `git-update-ref --stdin` to test multiple transactions
 - update-ref: allow creation of multiple transactions
 - t1400: avoid touching refs on filesystem

 "git update-ref --stdin" learns to take multiple transactions in a
 single session.


* fc/bash-completion-alias-of-alias (2020-11-17) 3 commits
  (merged to 'next' on 2020-11-18 at 4241203041)
 + completion: bash: improve alias loop detection
  (merged to 'next' on 2020-11-10 at 75f1f2b8a8)
 + completion: bash: check for alias loop
 + completion: bash: support recursive aliases

 The command line completion script (in contrib/) learned to expand
 commands that are alias of alias.

 Will merge to 'master'.


* jk/rev-parse-end-of-options (2020-11-10) 3 commits
  (merged to 'next' on 2020-11-11 at 2d517d1608)
 + rev-parse: handle --end-of-options
 + rev-parse: put all options under the "-" check
 + rev-parse: don't accept options after dashdash

 "git rev-parse" learned the "--end-of-options" to help scripts to
 safely take a parameter that is supposed to be a revision, e.g.
 "git rev-parse --verify -q --end-of-options $rev".

 Will merge to 'master'.


* fc/bash-completion-post-2.29 (2020-11-10) 26 commits
 - completion: bash: shuffle __gitcomp functions
 - completion: bash: cleanup __gitcomp* invocations
 - completion: bash: add __gitcomp_opts
 - completion: bash: improve __gitcomp description
 - completion: bash: rename _get_comp_words_by_ref()
 - completion: bash: trivial cleanup
 - completion: bash: cleanup _get_comp_words_by_ref()
 - completion: bash: refactor _get_comp_words_by_ref()
 - completion: bash: simplify _get_comp_words_by_ref()
 - test: completion: switch __gitcomp_nl prefix test
 - completion: bash: simplify config_variable_name
 - completion: bash: improve __gitcomp suffix code
 - completion: bash: change suffix check in __gitcomp
 - completion: bash: simplify __gitcomp
 - completion: bash: refactor __gitcomp
 - completion: bash: simplify equal suffix check
 - completion: bash: factor out check in __gitcomp
 - completion: bash: get rid of any non-append code
 - completion: bash: get rid of _append() functions
 - completion: bash: remove non-append functionality
 - test: completion: add run_func() helper
 - test: completion: fix currently typed words
 - completion: bash: do not modify COMP_WORDBREAKS
 - completion: bash: fix for suboptions with value
 - completion: bash: add correct suffix in variables
 - completion: bash: fix prefix detection in branch.*


* js/add-i-color-fix (2020-11-16) 11 commits
 - add -i: verify in the tests that colors can be overridden
 - add -p: prefer color.diff.context over color.diff.plain
 - add -i (Perl version): color header to match the C version
 - add -i (built-in): use the same indentation as the Perl version
 - add -p (built-in): do not color the progress indicator separately
 - add -i (built-in): use correct names to load color.diff.* config
 - add -i (built-in): prevent the `reset` "color" from being configured
 - add -i: use `reset_color` consistently
 - add -p (built-in): imitate `xdl_format_hunk_hdr()` generating hunk headers
 - add -i (built-in): send error messages to stderr
 - add -i (built-in): do show an error message for incorrect inputs

 "git add -i" failed to honor custom colors configured to show
 patches, which has been corrected.


* ab/config-mak-uname-simplify (2020-11-11) 2 commits
  (merged to 'next' on 2020-11-12 at e1bd51ee71)
 + config.mak.uname: remove unused NEEDS_SSL_WITH_CURL flag
 + config.mak.uname: remove unused the NO_R_TO_GCC_LINKER flag

 Build configuration cleanup.

 Will merge to 'master'.


* pd/mergetool-nvimdiff (2020-11-11) 2 commits
  (merged to 'next' on 2020-11-12 at aff20da3a2)
 + mergetool: avoid letting `list_tool_variants` break user-defined setups
 + mergetools/bc: add `bc4` to the alias list for Beyond Compare

 Fix regression introduced when nvimdiff support in mergetool was added.

 Will merge to 'master'.


* js/trace2-session-id (2020-11-11) 11 commits
 - receive-pack: log received client session ID
 - send-pack: advertise session ID in capabilities
 - upload-pack, serve: log received client session ID
 - fetch-pack: advertise session ID in capabilities
 - transport: log received server session ID
 - serve: advertise session ID in v2 capabilities
 - receive-pack: advertise session ID in v0 capabilities
 - upload-pack: advertise session ID in v0 capabilities
 - trace2: add a public function for getting the SID
 - docs: new transfer.advertiseSID option
 - docs: new capability to advertise session IDs

 The transport layer was taught to optionally exchange the session
 ID assigned by the trace2 subsystem during fetch/push transactions.


* so/log-diff-merge (2020-11-09) 27 commits
 - doc/git-show: include --diff-merges description
 - doc/rev-list-options: document --first-parent implies --diff-merges=first-parent
 - doc/diff-generate-patch: mention new --diff-merges option
 - doc/git-log: describe new --diff-merges options
 - t4013: add test for --diff-merges=first-parent
 - diff-merges: implement new values for --diff-merges
 - diff-merges: make -m/-c/--cc explicitly mutually exclusive
 - diff-merges: refactor opt settings into separate functions
 - diff-merges: get rid of now empty diff_merges_init_revs()
 - diff-merges: group diff-merge flags next to each other inside 'rev_info'
 - diff-merges: split 'ignore_merges' field
 - diff-merges: fix -m to properly override -c/--cc
 - t4013: add tests for -m failing to override -c/--cc
 - t4013: support test_expect_failure through ':failure' magic
 - diff-merges: revise revs->diff flag handling
 - diff-merges: introduce revs->first_parent_merges flag
 - diff-merges: new function diff_merges_set_dense_combined_if_unset()
 - diff-merges: new function diff_merges_suppress()
 - diff-merges: re-arrange functions to match the order they are called in
 - diff-merges: rename diff_merges_default_to_enable() to match semantics
 - diff-merges: move checks for first_parent_only out of the module
 - diff-merges: rename all functions to have common prefix
 - revision: move diff merges functions to its own diff-merges.c
 - revision: provide implementation for diff merges tweaks
 - revision: factor out initialization of diff-merge related settings
 - revision: factor out setup of diff-merge related settings
 - revision: factor out parsing of diff-merge related options

 "git log" learned a new "--diff-merges=<how>" option.


* ds/maintenance-part-4 (2020-11-04) 4 commits
 - maintenance: use Windows scheduled tasks
 - maintenance: use launchctl on macOS
 - maintenance: include 'cron' details in docs
 - maintenance: extract platform-specific scheduling

 Follow-up on the "maintenance part-3" which introduced scheduled
 maintenance tasks to support platforms whose native scheduling
 methods are not 'cron'.


* en/merge-ort-impl (2020-11-11) 21 commits
 - merge-ort: free data structures in merge_finalize()
 - merge-ort: add implementation of record_unmerged_index_entries()
 - tree: enable cmp_cache_name_compare() to be used elsewhere
 - merge-ort: add implementation of checkout()
 - merge-ort: basic outline for merge_switch_to_result()
 - merge-ort: step 3 of tree writing -- handling subdirectories as we go
 - merge-ort: step 2 of tree writing -- function to create tree object
 - merge-ort: step 1 of tree writing -- record basenames, modes, and oids
 - merge-ort: have process_entries operate in a defined order
 - merge-ort: add a preliminary simple process_entries() implementation
 - merge-ort: avoid recursing into identical trees
 - merge-ort: record stage and auxiliary info for every path
 - merge-ort: compute a few more useful fields for collect_merge_info
 - merge-ort: avoid repeating fill_tree_descriptor() on the same tree
 - merge-ort: implement a very basic collect_merge_info()
 - merge-ort: add an err() function similar to one from merge-recursive
 - merge-ort: use histogram diff
 - merge-ort: port merge_start() from merge-recursive
 - merge-ort: add some high-level algorithm structure
 - merge-ort: setup basic internal data structures
 - Merge branch 'en/strmap' into en/merge-ort-impl
 (this branch uses en/strmap.)


* jc/format-patch-name-max (2020-11-09) 1 commit
  (merged to 'next' on 2020-11-11 at 17e19bb17a)
 + format-patch: make output filename configurable

 The maximum length of output filenames "git format-patch" creates
 has become configurable (used to be capped at 64).

 Will merge to 'master'.


* jk/diff-release-filespec-fix (2020-11-11) 2 commits
  (merged to 'next' on 2020-11-12 at 3b21625881)
 + t7800: simplify difftool test
  (merged to 'next' on 2020-11-09 at 6d89b9602d)
 + diff: allow passing NULL to diff_free_filespec_data()
 (this branch is used by js/default-branch-name-tests-final-stretch.)

 Running "git diff" while allowing external diff in a state with
 unmerged paths used to segfault, which has been corrected.

 Will merge to 'master'.


* jx/t5411-flake-fix (2020-11-11) 3 commits
  (merged to 'next' on 2020-11-18 at badb1fefe5)
 + receive-pack: use default version 0 for proc-receive
 + receive-pack: gently write messages to proc-receive
 + t5411: new helper filter_out_user_friendly_and_stable_output

 The exchange between receive-pack and proc-receive hook did not
 carefully check for errors.

 Will merge to 'master'.


* av/fsmonitor-cleanup (2020-10-21) 2 commits
 - fsmonitor: make output of test-dump-fsmonitor more concise
 - fsmonitor: stop inline'ing mark_fsmonitor_valid / _invalid

 Code clean-up.

 Will discard.
 Unneeded?
 cf. <20201022183822.GA781760@nand.local>


* sj/untracked-files-in-submodule-directory-is-not-dirty (2020-10-26) 1 commit
 - diff: do not show submodule with untracked files as "-dirty"

 "git diff" showed a submodule working tree with untracked cruft as
 "Submodule commit <objectname>-dirty", but a natural expectation is
 that the "-dirty" indicator would align with "git describe --dirty",
 which does not consider having untracked files in the working tree
 as source of dirtiness.  The inconsistency has been fixed.

 Needs doc update and also adjusting "git status".


* en/strmap (2020-11-11) 15 commits
  (merged to 'next' on 2020-11-12 at 41519a5f5c)
 + shortlog: use strset from strmap.h
 + Use new HASHMAP_INIT macro to simplify hashmap initialization
 + strmap: take advantage of FLEXPTR_ALLOC_STR when relevant
 + strmap: enable allocations to come from a mem_pool
 + strmap: add a strset sub-type
 + strmap: split create_entry() out of strmap_put()
 + strmap: add functions facilitating use as a string->int map
 + strmap: enable faster clearing and reusing of strmaps
 + strmap: add more utility functions
 + strmap: new utility functions
 + hashmap: provide deallocation function names
 + hashmap: introduce a new hashmap_partial_clear()
 + hashmap: allow re-use after hashmap_free()
 + hashmap: adjust spacing to fix argument alignment
 + hashmap: add usage documentation explaining hashmap_free[_entries]()
 (this branch is used by en/merge-ort-impl.)

 A speciailization of hashmap that uses a string as key has been
 introduced.  Hopefully it will see wider use over time.

 Will merge to 'master'.


* ak/corrected-commit-date (2020-10-08) 10 commits
 - doc: add corrected commit date info
 - commit-reach: use corrected commit dates in paint_down_to_common()
 - commit-graph: use generation v2 only if entire chain does
 - commit-graph: implement generation data chunk
 - commit-graph: implement corrected commit date
 - commit-graph: add a slab to store topological levels
 - commit-graph: return 64-bit generation number
 - commit-graph: consolidate fill_commit_graph_info
 - revision: parse parent in indegree_walk_step()
 - commit-graph: fix regression when computing Bloom filters

 The commit-graph learned to use corrected commit dates instead of
 the generation number to help topological revision traversal.

 Getting there.
 cf. <85y2jiqq3c.fsf@gmail.com>
 cf. <685afed6-f01f-5d22-80d4-00fdc11caf0a@gmail.com>
 cf. <20201103053629.GA13228@Abhishek-Arch>

--------------------------------------------------
[Discarded]

* jk/use-strset-in-shortlog (2020-11-05) 1 commit
 . shortlog: drop custom strset implementation

 Now a part of the en/strmap topic.


* jt/push-with-base (2020-11-02) 5 commits
 . SQUASH???
 . Doc: push with --base
 . remote-curl: teach --base for http(s)://
 . push: teach --base for ssh:// and file://
 . connect: refactor building of Extra Parameters

 "git push" learns a way to tell an object that it expects the other
 side to have and is usable as a common ancestor, which can be used
 by the other side to shrink its initial ref advertisement.
