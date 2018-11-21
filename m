Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AD531F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 09:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbeKUTeF (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 14:34:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57350 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeKUTeF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 14:34:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AECA210FBB1;
        Wed, 21 Nov 2018 04:00:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=G
        laeSWpNlnnaRrrp74EPdVEAcbI=; b=SY1bBsCLJEp6C4q6xIRK0d2A26Rpy1QJu
        WO7nYI8k6OL553fDGCeVYeH6DEVJgG2L+Gbx+ZZCU0QPb1Yds4jZPNqfleOpJ12f
        GXmYz3bISJ0f1w1SRsuAmqCzSYIAdrlItu+9cynUn2cPJ6kEoc8PGl7ngkWVdSuT
        1UPsfcB8lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=b9w
        gusLz/kVc0xNtVpTfzB6Qn9+iB7eKxJbl6fK6das0pj306Yx1fwpF2SMRM9CZiaw
        B4ktWT81csh5KNcFaObVx//fXIWmOxgSMlb4VRKrnzdOadLddy1gG80XWFci7AT7
        gau8XgDq8CejXpdnBnH7FcQn0Q3RxV7YVPdp+GTQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6E7010FBB0;
        Wed, 21 Nov 2018 04:00:18 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB2BC10FBAF;
        Wed, 21 Nov 2018 04:00:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2018, #06; Wed, 21)
X-master-at: bb75be6cb916297f271c846f2f9caa3daaaec718
X-next-at: 68bc7959f8dc2d629c09be1a52f1b95b977b3a13
Date:   Wed, 21 Nov 2018 18:00:16 +0900
Message-ID: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE2FC836-ED6B-11E8-91B3-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The group of last-minute fixes marked as "Will merge to 'master'"
hopefully will be part of -rc1.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/dynamic-gettext-poison (2018-11-09) 2 commits
  (merged to 'next' on 2018-11-18 at 13247a3be6)
 + Makefile: ease dynamic-gettext-poison transition
 + i18n: make GETTEXT_POISON a runtime option

 Our testing framework uses a special i18n "poisoned localization"
 feature to find messages that ought to stay constant but are
 incorrectly marked to be translated.  This feature has been made
 into a runtime option (it used to be a compile-time option).


* ab/range-diff-no-patch (2018-11-14) 3 commits
  (merged to 'next' on 2018-11-17 at c42e0891d0)
 + range-diff: make diff option behavior (e.g. --stat) consistent
 + range-diff: fix regression in passing along diff options
 + range-diff doc: add a section about output stability

 The "--no-patch" option, which can be used to get a high-level
 overview without the actual line-by-line patch difference shown, of
 the "range-diff" command was earlier broken, which has been
 corrected.


* ab/rebase-in-c-escape-hatch (2018-11-16) 2 commits
  (merged to 'next' on 2018-11-17 at a01be221c7)
 + tests: add a special setup where rebase.useBuiltin is off
 + rebase doc: document rebase.useBuiltin

 The recently merged "rebase in C" has an escape hatch to use the
 scripted version when necessary, but it hasn't been documented,
 which has been corrected.


* ag/p3400-force-checkout (2018-11-12) 1 commit
  (merged to 'next' on 2018-11-17 at 87ff48d52a)
 + p3400: replace calls to `git checkout -b' by `git checkout -B'

 Perf test tweak.


* cb/notes-freeing-always-null-fix (2018-11-13) 1 commit
  (merged to 'next' on 2018-11-17 at 47aeec5fc9)
 + builtin/notes: remove unnecessary free

 Code cleanup.


* dd/poll-dot-h (2018-11-14) 1 commit
  (merged to 'next' on 2018-11-18 at b6745f3308)
 + git-compat-util: prefer poll.h to sys/poll.h

 A build update.


* ds/push-squelch-ambig-warning (2018-11-07) 1 commit
  (merged to 'next' on 2018-11-18 at 5e8b3db129)
 + pack-objects: ignore ambiguous object warnings

 "git push" used to check ambiguities between object-names and
 refnames while processing the list of refs' old and new values,
 which was unnecessary (as it knew that it is feeding raw object
 names).  This has been optimized out.


* ds/reachable-topo-order (2018-11-02) 7 commits
  (merged to 'next' on 2018-11-13 at 4155d01aee)
 + t6012: make rev-list tests more interesting
 + revision.c: generation-based topo-order algorithm
 + commit/revisions: bookkeeping before refactoring
 + revision.c: begin refactoring --topo-order logic
 + test-reach: add rev-list tests
 + test-reach: add run_three_modes method
 + prio-queue: add 'peek' operation

 The revision walker machinery learned to take advantage of the
 commit generation numbers stored in the commit-graph file.


* jk/close-duped-fd-before-unlock-for-bundle (2018-11-17) 1 commit
  (merged to 'next' on 2018-11-17 at 2fe598284e)
 + bundle: dup() output descriptor closer to point-of-use

 When "git bundle" aborts due to an empty commit ranges
 (i.e. resulting in an empty pack), it left a file descriptor to an
 lockfile open, which resulted in leftover lockfile on Windows where
 you cannot remove a file with an open file descriptor.  This has
 been corrected.


* jk/curl-ldflags (2018-11-05) 1 commit
  (merged to 'next' on 2018-11-13 at d1387a3aa0)
 + build: link with curl-defined linker flags

 The way -lcurl library gets linked has been simplified by taking
 advantage of the fact that we can just ask curl-config command how.


* jk/unused-parameter-fixes (2018-11-06) 14 commits
  (merged to 'next' on 2018-11-13 at 8d3625b4ae)
 + midx: double-check large object write loop
 + assert NOARG/NONEG behavior of parse-options callbacks
 + parse-options: drop OPT_DATE()
 + apply: return -1 from option callback instead of calling exit(1)
 + cat-file: report an error on multiple --batch options
 + tag: mark "--message" option with NONEG
 + show-branch: mark --reflog option as NONEG
 + format-patch: mark "--no-numbered" option with NONEG
 + status: mark --find-renames option with NONEG
 + cat-file: mark batch options with NONEG
 + pack-objects: mark index-version option as NONEG
 + ls-files: mark exclude options as NONEG
 + am: handle --no-patch-format option
 + apply: mark include/exclude options as NONEG

 Various functions have been audited for "-Wunused-parameter" warnings
 and bugs in them got fixed.


* jk/verify-sig-merge-into-void (2018-11-07) 3 commits
  (merged to 'next' on 2018-11-13 at a207be60ed)
 + pull: handle --verify-signatures for unborn branch
 + merge: handle --verify-signatures for unborn branch
 + merge: extract verify_merge_signature() helper

 "git merge" and "git pull" that merges into an unborn branch used
 to completely ignore "--verify-signatures", which has been
 corrected.


* js/apply-recount-allow-noop (2018-11-13) 1 commit
  (merged to 'next' on 2018-11-17 at e413fa105f)
 + apply --recount: allow "no-op hunks"

 When editing a patch in a "git add -i" session, a hunk could be
 made to no-op.  The "git apply" program used to reject a patch with
 such a no-op hunk to catch user mistakes, but it is now updated to
 explicitly allow a no-op hunk in an edited patch.


* js/builtin-rebase-perf-fix (2018-11-13) 3 commits
  (merged to 'next' on 2018-11-17 at 9e9db8c8e1)
 + built-in rebase: reinstate `checkout -q` behavior where appropriate
 + rebase: prepare reset_head() for more flags
 + rebase: consolidate clean-up code before leaving reset_head()

 Code clean-up with correction to make the reimplemented "git
 rebase" a more faithful rewrite of the original, which also regains
 performance.


* js/config-sequence (2018-11-16) 1 commit
  (merged to 'next' on 2018-11-17 at fefca0bbe8)
 + config: report a bug if git_dir exists without commondir

 A sanity check for start-up sequence has been added in the config
 API codepath.


* js/fuzz-cxxflags (2018-11-16) 1 commit
  (merged to 'next' on 2018-11-17 at 5e589a5237)
 + Makefile: use FUZZ_CXXFLAGS for linking fuzzers

 The build procedure to link for fuzzing test has been made
 customizable with a new Makefile variable.


* js/mailmap (2018-11-12) 1 commit
  (merged to 'next' on 2018-11-17 at 673bfc4cfa)
 + Update .mailmap

 Update the mailmap to unify multiple entries for the authors with
 commits since v2.10.


* js/mingw-create-hard-link (2018-11-14) 1 commit
  (merged to 'next' on 2018-11-17 at 27f866db16)
 + mingw: use `CreateHardLink()` directly

 Windows update.


* js/mingw-msdn-url (2018-11-16) 1 commit
  (merged to 'next' on 2018-11-17 at a6a9afddbf)
 + mingw: replace an obsolete link with the superseding one

 The URL to an MSDN page in a comment has been updated.


* js/mingw-res-rebuild (2018-11-07) 1 commit
  (merged to 'next' on 2018-11-13 at fb736827d1)
 + Windows: force-recompile git.res for differing architectures

 Windows build update.


* js/rebase-am-options (2018-11-16) 2 commits
  (merged to 'next' on 2018-11-17 at f956d9b948)
 + rebase: validate -C<n> and --whitespace=<mode> parameters early
 + rebase: really just passthru the `git am` options

 The way "git rebase" parses and forwards the command line options
 meant for underlying "git am" has been revamped, which fixed for
 options with parameters that were not passed correctly.


* js/rebase-autostash-detach-fix (2018-11-08) 2 commits
  (merged to 'next' on 2018-11-17 at 15957b4a5a)
 + built-in rebase --autostash: leave the current branch alone if possible
 + built-in rebase: demonstrate regression with --autostash

 "git rebase --autostash" did not correctly re-attach the HEAD at times.


* js/rebase-r-and-merge-head (2018-11-13) 5 commits
  (merged to 'next' on 2018-11-17 at 6bb27df7b1)
 + status: rebase and merge can be in progress at the same time
 + built-in rebase --skip/--abort: clean up stale .git/<name> files
 + rebase -i: include MERGE_HEAD into files to clean up
 + rebase -r: do not write MERGE_HEAD unless needed
 + rebase -r: demonstrate bug with conflicting merges

 Bugfix for the recently graduated "git rebase --rebase-merges".


* js/test-git-installed (2018-11-16) 5 commits
  (merged to 'next' on 2018-11-18 at 61474ba19e)
 + tests: explicitly use `git.exe` on Windows
 + tests: do not require Git to be built when testing an installed Git
 + t/lib-gettext: test installed git-sh-i18n if GIT_TEST_INSTALLED is set
 + tests: respect GIT_TEST_INSTALLED when initializing repositories
 + tests: fix GIT_TEST_INSTALLED's PATH to include t/helper/

 Update the "test installed Git" mode of our test suite to work better.


* lj/mingw-pthread-cond (2018-11-14) 1 commit
  (merged to 'next' on 2018-11-17 at 46abe4100d)
 + win32: replace pthread_cond_*() with much simpler code

 Code simplification.


* mg/gpg-fingerprint-test (2018-11-05) 2 commits
  (merged to 'next' on 2018-11-13 at 71f11020c4)
 + t/t7510-signed-commit.sh: add signing subkey to Eris Discordia key
 + t/t7510-signed-commit.sh: Add %GP to custom format checks

 Add a few tests for a topic already in 'master'.


* nd/command-list-gen-fix (2018-11-12) 1 commit
  (merged to 'next' on 2018-11-17 at a6ff6baa0b)
 + build: fix broken command-list.h generation with core.autocrlf

 Build tweak.


* nd/doc-extensions (2018-11-16) 1 commit
  (merged to 'next' on 2018-11-17 at 09306064d5)
 + doc: move extensions.worktreeConfig to the right place

 Doc update.


* nd/format-patch-cover-letter-stat-width (2018-11-13) 1 commit
  (merged to 'next' on 2018-11-18 at 65a464977d)
 + format-patch: respect --stat in cover letter's diffstat

 "git format-patch --stat=<width>" can be used to specify the width
 used by the diffstat (shown in the cover letter).


* nd/pthreads (2018-11-05) 14 commits
  (merged to 'next' on 2018-11-13 at bb6914b3f8)
 + Clean up pthread_create() error handling
 + read-cache.c: initialize copy_len to shut up gcc 8
 + read-cache.c: reduce branching based on HAVE_THREADS
 + read-cache.c: remove #ifdef NO_PTHREADS
 + pack-objects: remove #ifdef NO_PTHREADS
 + preload-index.c: remove #ifdef NO_PTHREADS
 + grep: clean up num_threads handling
 + grep: remove #ifdef NO_PTHREADS
 + attr.c: remove #ifdef NO_PTHREADS
 + name-hash.c: remove #ifdef NO_PTHREADS
 + index-pack: remove #ifdef NO_PTHREADS
 + send-pack.c: move async's #ifdef NO_PTHREADS back to run-command.c
 + run-command.h: include thread-utils.h instead of pthread.h
 + thread-utils: macros to unconditionally compile pthreads API

 The codebase has been cleaned up to reduce "#ifndef NO_PTHREADS".


* ra/rev-parse-exclude-glob (2018-11-13) 2 commits
  (merged to 'next' on 2018-11-17 at 396dd7a2c2)
 + refs: fix some exclude patterns being ignored
 + refs: show --exclude failure with --branches/tags/remotes=glob

 "rev-parse --exclude=<pattern> --branches=<pattern>" etc. did not
 quite work, which has been corrected.


* sb/cocci-pending (2018-11-14) 1 commit
  (merged to 'next' on 2018-11-18 at dd271722d3)
 + coccicheck: introduce 'pending' semantic patches

 A coding convention around the Coccinelle semantic patches to have
 two classes to ease code migration process has been proposed and
 its support has been added to the Makefile.


* sg/ref-filter-wo-repository (2018-11-16) 1 commit
  (merged to 'next' on 2018-11-17 at c0bec63990)
 + ref-filter: don't look for objects when outside of a repository

 "git ls-remote --sort=<thing>" can feed an object that is not yet
 available into the comparison machinery and segfault, which has
 been corrected to check such a request upfront and reject it.


* tb/print-size-t-with-uintmax-format (2018-11-12) 1 commit
  (merged to 'next' on 2018-11-18 at 752e51c7ed)
 + Upcast size_t variables to uintmax_t when printing

 Code preparation to replace ulong vars with size_t vars where
 appropriate.


* tb/xcurl-off-t (2018-11-12) 1 commit
  (merged to 'next' on 2018-11-18 at ac2a4bc14a)
 + remote-curl.c: xcurl_off_t is not portable (on 32 bit platfoms)

 The xcurl_off_t() helper function is used to cast size_t to
 curl_off_t, but some compilers gave warnings against the code to
 ensure the casting is done without wraparound, when size_t is
 narrower than curl_off_t.  This warning has been squelched.

--------------------------------------------------
[New Topics]

* dl/merge-cleanup-scissors-fix (2018-11-21) 2 commits
 - merge: add scissors line on merge conflict
 - t7600: clean up 'merge --squash c3 with c7' test

 The list of conflicted paths shown in the editor while concluding a
 conflicted merge was shown above the scissors line when the
 clean-up mode is set to "scissors", even though it was commented
 out just like the list of updated paths and other information to
 help the user explain the merge better.

 Will merge to 'next'.


* aw/pretty-trailers (2018-11-19) 5 commits
 - pretty: add support for separator option in %(trailers)
 - strbuf: separate callback for strbuf_expand:ing literals
 - pretty: add support for "valueonly" option in %(trailers)
 - pretty: allow showing specific trailers
 - pretty: single return path in %(trailers) handling

 The %(trailers) formatter in "git log --format=..."  now allows to
 optionally pick trailers selectively by keyword, show only values,
 etc.


* nd/attr-pathspec-in-tree-walk (2018-11-19) 5 commits
 - tree-walk: support :(attr) matching
 - dir.c: move, rename and export match_attrs()
 - pathspec.h: clean up "extern" in function declarations
 - tree-walk.c: make tree_entry_interesting() take an index
 - tree.c: make read_tree*() take 'struct repository *'

 The traversal over tree objects has learned to honor
 ":(attr:label)" pathspec match, which has been implemented only for
 enumerating paths on the filesystem.


* ab/commit-graph-progress-fix (2018-11-20) 1 commit
 - commit-graph: split up close_reachable() progress output


* sg/test-BUG (2018-11-20) 1 commit
 - tests: send "bug in the test script" errors to the script's stderr

 test framework has been updated to make a bug in the test script
 (as opposed to bugs in Git that are discovered by running the
 tests) stand out more prominently.

 Will merge to 'next'.


* sg/test-cmp-rev (2018-11-20) 1 commit
 - test-lib-functions: make 'test_cmp_rev' more informative on failure

 Test framework update.

 Will merge to 'next'.


* ss/msvc-strcasecmp (2018-11-20) 1 commit
 - msvc: directly use MS version (_stricmp) of strcasecmp

 MSVC update.

 Will merge to 'next'.


* cc/delta-islands (2018-11-21) 3 commits
  (merged to 'next' on 2018-11-21 at 3bac399f83)
 + pack-objects: fix off-by-one in delta-island tree-depth computation
 + pack-objects: zero-initialize tree_depth/layer arrays
 + pack-objects: fix tree_depth and layer invariants

 A few issues in the implementation of "delta-islands" feature has
 been corrected.

 Will merge to 'master'.


* jn/eoie-ieot (2018-11-21) 3 commits
  (merged to 'next' on 2018-11-21 at 9eb98a38f0)
 + index: make index.threads=true enable ieot and eoie
 + ieot: default to not writing IEOT section
 + eoie: default to not writing EOIE section
 (this branch is used by jn/unknown-index-extensions.)

 As the warning message shown by existing versions of Git for
 unknown index extensions is a bit too alarming, two new extensions
 are held back and not written by default for the upcoming release.

 Will merge to 'master'.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions
 (this branch uses jn/eoie-ieot.)

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* js/builtin-rebase-perf-fix-err-fix (2018-11-21) 1 commit
  (merged to 'next' on 2018-11-21 at 9c351cfc4a)
 + rebase: warn about the correct tree's OID

 The object name of the tree reported in a recently added error
 message was wrong, which has been corrected.

 Will merge to 'master'.


* js/rebase-am-options-fix (2018-11-21) 1 commit
  (merged to 'next' on 2018-11-21 at 4da85e17c2)
 + legacy-rebase: backport -C<n> and --whitespace=<option> checks

 Recently, built-in "rebase" tightened the error checking for a few
 options that are passed to underlying "am", but we forgot to make
 the matching change to the scripted version, which has been
 corrected.

 Will merge to 'master'.


* nd/clone-case-smashing-warning (2018-11-21) 1 commit
  (merged to 'next' on 2018-11-21 at 68bc7959f8)
 + clone: fix colliding file detection on APFS

 Recently added check for case smashing filesystems did not
 correctly utilize the cached stat information, leading to false
 breakage detected by our test suite, which has been corrected.

 Will merge to 'master'.


* tz/build-tech-midx-doc (2018-11-21) 1 commit
  (merged to 'next' on 2018-11-21 at 15dd462db0)
 + Documentation: build technical/multi-pack-index

 A documentation page that is referred to by other pages was not
 built by mistake, which has been corrected.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* lt/date-human (2018-07-09) 1 commit
 - Add 'human' date format

 A new date format "--date=human" that morphs its output depending
 on how far the time is from the current time has been introduced.
 "--date=auto" can be used to use this new format when the output is
 goint to the pager or to the terminal and otherwise the default
 format.

--------------------------------------------------
[Cooking]

* ab/push-example-in-doc (2018-11-14) 1 commit
  (merged to 'next' on 2018-11-18 at 8fd935a19c)
 + push: change needlessly ambiguous example in error

 An error message that sugggests how to give correct arguments to
 "git push" has been updated.

 Will cook in 'next'.


* en/fast-export-import (2018-11-17) 11 commits
  (merged to 'next' on 2018-11-18 at 87bbbffc95)
 + fast-export: add a --show-original-ids option to show original names
 + fast-import: remove unmaintained duplicate documentation
 + fast-export: add --reference-excluded-parents option
 + fast-export: ensure we export requested refs
 + fast-export: when using paths, avoid corrupt stream with non-existent mark
 + fast-export: move commit rewriting logic into a function for reuse
 + fast-export: avoid dying when filtering by paths and old tags exist
 + fast-export: use value from correct enum
 + git-fast-export.txt: clarify misleading documentation about rev-list args
 + git-fast-import.txt: fix documentation for --quiet option
 + fast-export: convert sha1 to oid

 Small fixes and features for fast-export and fast-import, mostly on
 the fast-export side.

 Will cook in 'next'.


* nd/checkout-dwim-fix (2018-11-14) 1 commit
  (merged to 'next' on 2018-11-18 at 3d714e7719)
 + checkout: disambiguate dwim tracking branches and local files

 "git checkout frotz" (without any double-dash) avoids ambiguity by
 making sure 'frotz' cannot be interpreted as a revision and as a
 path at the same time.  This safety has been updated to check also
 a unique remote-tracking branch 'frotz' in a remote, when dwimming
 to create a local branch 'frotz' out of a remote-tracking branch
 'frotz' from a remote.

 Will cook in 'next'.


* nd/checkout-noisy (2018-11-20) 2 commits
 - t0027: squelch checkout path run outside test_expect_* block
 - checkout: print something when checking out paths

 "git checkout [<tree-ish>] path..." learned to report the number of
 paths that have been checked out of the index or the tree-ish,
 which gives it the same degree of noisy-ness as the case in which
 the command checks out a branch.


* sg/clone-initial-fetch-configuration (2018-11-16) 3 commits
  (merged to 'next' on 2018-11-18 at cae0f3985b)
 + Documentation/clone: document ignored configuration variables
 + clone: respect additional configured fetch refspecs during initial fetch
 + clone: use a more appropriate variable name for the default refspec

 Refspecs configured with "git -c var=val clone" did not propagate
 to the resulting repository, which has been corrected.

 Will cook in 'next'.


* cc/shared-index-permbits (2018-11-19) 1 commit
  (merged to 'next' on 2018-11-19 at 79df716844)
 + read-cache: make the split index obey umask settings

 The way .git/index and .git/sharedindex* files were initially
 created gave these files different perm bits until they were
 adjusted for shared repository settings.  This was made consistent.

 Will merge to 'master'.


* en/rebase-merge-on-sequencer (2018-11-08) 2 commits
 - rebase: implement --merge via git-rebase--interactive
 - git-rebase, sequencer: extend --quiet option for the interactive machinery

 "git rebase --merge" as been reimplemented by reusing the internal
 machinery used for "git rebase -i".


* fc/http-version (2018-11-09) 1 commit
  (merged to 'next' on 2018-11-18 at 42f5155095)
 + http: add support selecting http version

 The "http.version" configuration variable can be used with recent
 enough cURL library to force the version of HTTP used to talk when
 fetching and pushing.

 Will cook in 'next'.


* dl/remote-save-to-push (2018-11-13) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.


* jk/loose-object-cache (2018-11-13) 9 commits
  (merged to 'next' on 2018-11-18 at 276691a21b)
 + fetch-pack: drop custom loose object cache
 + sha1-file: use loose object cache for quick existence check
 + object-store: provide helpers for loose_objects_cache
 + sha1-file: use an object_directory for the main object dir
 + handle alternates paths the same as the main object dir
 + sha1_file_name(): overwrite buffer instead of appending
 + rename "alternate_object_database" to "object_directory"
 + submodule--helper: prefer strip_suffix() to ends_with()
 + fsck: do not reuse child_process structs

 Code clean-up with optimization for the codepath that checks
 (non-)existence of loose objects.

 Will cook in 'next'.


* js/protocol-advertise-multi (2018-11-17) 1 commit
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.


* js/smart-http-detect-remote-error (2018-11-17) 3 commits
  (merged to 'next' on 2018-11-18 at 5c6edfcb85)
 + remote-curl: die on server-side errors
 + remote-curl: tighten "version 2" check for smart-http
 + remote-curl: refactor smart-http discovery

 Some errors from the other side coming over smart HTTP transport
 were not noticed, which has been corrected.

 Will cook in 'next'.


* nb/branch-show-other-worktrees-head (2018-11-12) 2 commits
 - branch: mark and colorize a branch differently if it is checked out in a linked worktree
 - ref-filter: add worktree atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.

 Expecting a reroll.


* nd/the-index (2018-11-12) 22 commits
  (merged to 'next' on 2018-11-18 at 73d1d8594e)
 + rebase-interactive.c: remove the_repository references
 + rerere.c: remove the_repository references
 + pack-*.c: remove the_repository references
 + pack-check.c: remove the_repository references
 + notes-cache.c: remove the_repository references
 + line-log.c: remove the_repository reference
 + diff-lib.c: remove the_repository references
 + delta-islands.c: remove the_repository references
 + cache-tree.c: remove the_repository references
 + bundle.c: remove the_repository references
 + branch.c: remove the_repository reference
 + bisect.c: remove the_repository reference
 + blame.c: remove implicit dependency the_repository
 + sequencer.c: remove implicit dependency on the_repository
 + sequencer.c: remove implicit dependency on the_index
 + transport.c: remove implicit dependency on the_index
 + notes-merge.c: remove implicit dependency the_repository
 + notes-merge.c: remove implicit dependency on the_index
 + list-objects.c: reduce the_repository references
 + list-objects-filter.c: remove implicit dependency on the_index
 + wt-status.c: remove implicit dependency the_repository
 + wt-status.c: remove implicit dependency on the_index

 More codepaths become aware of working with in-core repository
 instance other than the default "the_repository".

 Will cook in 'next'.


* ot/ref-filter-object-info (2018-11-12) 5 commits
  (merged to 'next' on 2018-11-18 at ad4c086678)
 + ref-filter: add docs for new options
 + ref-filter: add tests for deltabase
 + ref-filter: add deltabase option
 + ref-filter: add tests for objectsize:disk
 + ref-filter: add objectsize:disk option

 The "--format=<placeholder>" option of for-each-ref, branch and tag
 learned to show a few more traits of objects that can be learned by
 the object_info API.

 Will cook in 'next'.


* sb/diff-color-moved-config-option-fixup (2018-11-14) 1 commit
 - diff: align move detection error handling with other options


* ab/push-dwim-dst (2018-11-14) 7 commits
  (merged to 'next' on 2018-11-18 at 36567023be)
 + push doc: document the DWYM behavior pushing to unqualified <dst>
 + push: test that <src> doesn't DWYM if <dst> is unqualified
 + push: add an advice on unqualified <dst> push
 + push: move unqualified refname error into a function
 + push: improve the error shown on unqualified <dst> push
 + i18n: remote.c: mark error(...) messages for translation
 + remote.c: add braces in anticipation of a follow-up change

 "git push $there $src:$dst" rejects when $dst is not a fully
 qualified refname and not clear what the end user meant.  The
 codepath has been taught to give a clearer error message, and also
 guess where the push should go by taking the type of the pushed
 object into account (e.g. a tag object would want to go under
 refs/tags/).

 Will cook in 'next'.


* md/list-lazy-objects-fix (2018-10-29) 1 commit
 - list-objects.c: don't segfault for missing cmdline objects

 "git rev-list --exclude-promissor-objects" had to take an object
 that does not exist locally (and is lazily available) from the
 command line without barfing, but the code dereferenced NULL.

 That sympotom may be worth addressing, but I think the "fix" is
 overly broad and is wrong.  Giving a missing object should be
 diagnosed as an error, not swept under the rug silently.


* nd/i18n (2018-11-12) 16 commits
  (merged to 'next' on 2018-11-18 at 5215bd2f7d)
 + fsck: mark strings for translation
 + fsck: reduce word legos to help i18n
 + parse-options.c: mark more strings for translation
 + parse-options.c: turn some die() to BUG()
 + parse-options: replace opterror() with optname()
 + repack: mark more strings for translation
 + remote.c: mark messages for translation
 + remote.c: turn some error() or die() to BUG()
 + reflog: mark strings for translation
 + read-cache.c: add missing colon separators
 + read-cache.c: mark more strings for translation
 + read-cache.c: turn die("internal error") to BUG()
 + attr.c: mark more string for translation
 + archive.c: mark more strings for translation
 + alias.c: mark split_cmdline_strerror() strings for translation
 + git.c: mark more strings for translation

 More _("i18n") markings.

 Will cook in 'next'.


* sb/more-repo-in-api (2018-11-14) 23 commits
  (merged to 'next' on 2018-11-19 at e5d2a129da)
 + t/helper/test-repository: celebrate independence from the_repository
 + path.h: make REPO_GIT_PATH_FUNC repository agnostic
 + commit: prepare free_commit_buffer and release_commit_memory for any repo
 + commit-graph: convert remaining functions to handle any repo
 + submodule: don't add submodule as odb for push
 + submodule: use submodule repos for object lookup
 + pretty: prepare format_commit_message to handle arbitrary repositories
 + commit: prepare logmsg_reencode to handle arbitrary repositories
 + commit: prepare repo_unuse_commit_buffer to handle any repo
 + commit: prepare get_commit_buffer to handle any repo
 + commit-reach: prepare in_merge_bases[_many] to handle any repo
 + commit-reach: prepare get_merge_bases to handle any repo
 + commit-reach.c: allow get_merge_bases_many_0 to handle any repo
 + commit-reach.c: allow remove_redundant to handle any repo
 + commit-reach.c: allow merge_bases_many to handle any repo
 + commit-reach.c: allow paint_down_to_common to handle any repo
 + commit: allow parse_commit* to handle any repo
 + object: parse_object to honor its repository argument
 + object-store: prepare has_{sha1, object}_file to handle any repo
 + object-store: prepare read_object_file to deal with any repo
 + object-store: allow read_object_file_extended to read from any repo
 + packfile: allow has_packed_and_bad to handle arbitrary repositories
 + sha1_file: allow read_object to read objects in arbitrary repositories

 The in-core repository instances are passed through more codepaths.

 Will cook in 'next'.
 cf. <20181115221254.45373-1-jonathantanmy@google.com>


* en/merge-path-collision (2018-11-08) 10 commits
  (merged to 'next' on 2018-11-18 at 3ec9286e0b)
 + merge-recursive: combine error handling
 + t6036, t6043: increase code coverage for file collision handling
 + merge-recursive: improve rename/rename(1to2)/add[/add] handling
 + merge-recursive: use handle_file_collision for add/add conflicts
 + merge-recursive: improve handling for rename/rename(2to1) conflicts
 + merge-recursive: fix rename/add conflict handling
 + merge-recursive: new function for better colliding conflict resolutions
 + merge-recursive: increase marker length with depth of recursion
 + t6036, t6042: testcases for rename collision of already conflicting files
 + t6042: add tests for consistency in file collision conflict handling

 Updates for corner cases in merge-recursive.

 Will cook in 'next'.


* sd/stash-wo-user-name (2018-11-19) 1 commit
  (merged to 'next' on 2018-11-19 at 0838b091ea)
 + stash: tolerate missing user identity

 A properly configured username/email is required under
 user.useConfigOnly in order to create commits; now "git stash"
 (even though it creates commit objects to represent stash entries)
 command is excempt from the requirement.

 Will cook in 'next'.


* bc/sha-256 (2018-11-14) 12 commits
 - hash: add an SHA-256 implementation using OpenSSL
 - sha256: add an SHA-256 implementation using libgcrypt
 - Add a base implementation of SHA-256 support
 - commit-graph: convert to using the_hash_algo
 - t/helper: add a test helper to compute hash speed
 - sha1-file: add a constant for hash block size
 - t: make the sha1 test-tool helper generic
 - t: add basic tests for our SHA-1 implementation
 - cache: make hashcmp and hasheq work with larger hashes
 - hex: introduce functions to print arbitrary hashes
 - sha1-file: provide functions to look up hash algorithms
 - sha1-file: rename algorithm to "sha1"

 Add sha-256 hash and plug it through the code to allow building Git
 with the "NewHash".


* js/vsts-ci (2018-10-16) 13 commits
 . travis: fix skipping tagged releases
 . README: add a build badge (status of the Azure Pipelines build)
 . tests: record more stderr with --write-junit-xml in case of failure
 . tests: include detailed trace logs with --write-junit-xml upon failure
 . git-p4: use `test_atexit` to kill the daemon
 . git-daemon: use `test_atexit` in the tests
 . tests: introduce `test_atexit`
 . ci: add a build definition for Azure DevOps
 . ci/lib.sh: add support for Azure Pipelines
 . tests: optionally write results as JUnit-style .xml
 . test-date: add a subcommand to measure times in shell scripts
 . ci/lib.sh: encapsulate Travis-specific things
 . ci: rename the library of common functions

 Prepare to run test suite on Azure DevOps.

 Ejected out of 'pu', as doing so seems to help other topics get
 tested at TravisCI.

 https://travis-ci.org/git/git/builds/452713184 is a sample of a
 build whose tests on 4 hang (with this series in).  Ejecting it
 gave us https://travis-ci.org/git/git/builds/452778963 which still
 shows breakages from other topics not yet in 'next', but at least
 the tests do not stall.


* du/branch-show-current (2018-10-26) 1 commit
 - branch: introduce --show-current display option

 "git branch" learned a new subcommand "--show-current".

 Is the discussion on this topic over?  What was the outcome?


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* ag/sequencer-reduce-rewriting-todo (2018-11-12) 16 commits
 . rebase--interactive: move transform_todo_file() to rebase--interactive.c
 . sequencer: fix a call to error() in transform_todo_file()
 . sequencer: use edit_todo_list() in complete_action()
 . rebase-interactive: rewrite edit_todo_list() to handle the initial edit
 . rebase-interactive: append_todo_help() changes
 . rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
 . sequencer: refactor skip_unnecessary_picks() to work on a todo_list
 . sequencer: change complete_action() to use the refactored functions
 . sequencer: make sequencer_make_script() write its script to a strbuf
 . sequencer: refactor rearrange_squash() to work on a todo_list
 . sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
 . sequencer: refactor check_todo_list() to work on a todo_list
 . sequencer: introduce todo_list_write_to_file()
 . sequencer: refactor transform_todos() to work on a todo_list
 . sequencer: make the todo_list structure public
 . sequencer: changes in parse_insn_buffer()

 The scripted version of "git rebase -i" wrote and rewrote the todo
 list many times during a single step of its operation, and the
 recent C-rewrite made a faithful conversion of the logic to C.  The
 implementation has been updated to carry necessary information
 around in-core to avoid rewriting the same file over and over
 unnecessarily.

 With too many topics in-flight that touch sequencer and rebaser,
 this need to wait giving precedence to other topics that fix bugs.


* sb/submodule-recursive-fetch-gets-the-tip (2018-10-31) 11 commits
 - builtin/fetch: check for submodule updates in any ref update
 - fetch: try fetching submodules if needed objects were not fetched
 - submodule.c: fetch in submodules git directory instead of in worktree
 - submodule: migrate get_next_submodule to use repository structs
 - repository: repo_submodule_init to take a submodule struct
 - submodule: store OIDs in changed_submodule_names
 - submodule.c: tighten scope of changed_submodule_names struct
 - submodule.c: sort changed_submodule_names before searching it
 - submodule.c: fix indentation
 - sha1-array: provide oid_array_filter
 - Merge branch 'ao/submodule-wo-gitmodules-checked-out' into sb/submodule-recursive-fetch-gets-the-tip

 "git fetch --recurse-submodules" may not fetch the necessary commit
 that is bound to the superproject, which is getting corrected.

 Is the discussion on this topic over?  What was the outcome?


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* ps/stash-in-c (2018-10-15) 21 commits
 . stash: replace all `write-tree` child processes with API calls
 . stash: optimize `get_untracked_files()` and `check_changes()`
 . stash: convert `stash--helper.c` into `stash.c`
 . stash: convert save to builtin
 . stash: make push -q quiet
 . stash: convert push to builtin
 . stash: convert create to builtin
 . stash: convert store to builtin
 . stash: convert show to builtin
 . stash: convert list to builtin
 . stash: convert pop to builtin
 . stash: convert branch to builtin
 . stash: convert drop and clear to builtin
 . stash: convert apply to builtin
 . stash: mention options in `show` synopsis
 . stash: add tests for `git stash show` config
 . stash: rename test cases to be more descriptive
 . t3903: modernize style
 . stash: improve option parsing test coverage
 . strbuf.c: add `strbuf_join_argv()`
 . sha1-name.c: add `get_oidf()` which acts like `get_oid()`

 "git stash" rewritten in C.

 Expecting a reroll, probably on top of the sd/stash-wo-user-name
 topic after it stabilizes.  The series is almost there.
 cf. <20181015221040.GD4883@hank.intra.tgummerer.com>


* pw/add-p-select (2018-07-26) 4 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select modified lines correctly
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Will discard.
 No further feedbacks on the topic for quite some time.

 cf. <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net>
 I found the feature to be hard to explain, and may result in more
 end-user complaints, but let's see.

--------------------------------------------------
[Discarded]

* ab/reject-alias-loop (2018-10-19) 1 commit
  (merged to 'next' on 2018-10-26 at bc213f1bef)
 + alias: detect loops in mixed execution mode

 Two (or more) aliases that mutually refer to each other can form an
 infinite loop; we now attempt to notice and stop.

 Discarded.
 Reverted out of 'next'.
 cf. <87sh0slvxm.fsf@evledraar.gmail.com>


* gl/bundle-unlock-before-aborting (2018-11-14) 1 commit
 . bundle: rollback lock file while refusing to create an empty bundle

 Superseded by jk/close-duped-fd-before-unlock-for-bundle


* js/remote-archive-v2 (2018-09-28) 4 commits
  (merged to 'next' on 2018-10-12 at 5f34377f60)
 + archive: allow archive over HTTP(S) with proto v2
 + archive: implement protocol v2 archive command
 + archive: use packet_reader for communications
 + archive: follow test standards around assertions

 The original implementation of "git archive --remote" more or less
 bypassed the transport layer and did not work over http(s).  The
 version 2 of the protocol is defined to allow going over http(s) as
 well as Git native transport.

 Retracted; reverted out of next.
 cf. <20181114195142.GI126896@google.com>
