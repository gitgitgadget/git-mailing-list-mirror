Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C95C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 01:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B60664EC9
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 01:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhBKBdG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 20:33:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59552 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhBKBc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 20:32:58 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4317108512;
        Wed, 10 Feb 2021 20:32:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=M
        XVWpZTa1DV9FqoEQlr/zS44roc=; b=bCB+IgzuyYP7wyL0c4GqEPAbfIBTmKD/C
        cCEu90Zo+tcAQws4o7SN53EWJ5IYZe9qPaCIPhLinWW8hpIfW5t3AaWTu8ijxE4s
        6hoD9xpKkK0WKhmP8TJaz2GFNxzVpLTCpjhX8R6JTrwNvUVjp6uowCYKD6lhhNhv
        GAgy5IRNtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=jB2
        OYlU6xI+8N9/62clJUqcdZaudGLlwVDOdMcsrTBP3VxXW4W4igVqzNTA1ZdB7Ss2
        8uKntJUnTAXZs9s+2iynxVtI4/Q9PP7Lt69fQddeJ6yARIoFU2Q47xT4j6lgBXx/
        UjPhdqJP/Ge2kZKFd2Sth3nGtqrmC0Ap08CBGFIg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BCBB7108511;
        Wed, 10 Feb 2021 20:32:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E163D10850F;
        Wed, 10 Feb 2021 20:32:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2021, #02; Wed, 10)
X-master-at: f9f2520108bab26a750bcbb00518dc27672cf0a2
X-next-at: 12f37433bd80c76d67aa57b8e233c31bae0a769d
Date:   Wed, 10 Feb 2021 17:32:05 -0800
Message-ID: <xmqqim6zz8x6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3B77870-6C08-11EB-BCAE-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The seventh batch of topics are in 'master'.  On the 'maint' front,
bunch of fixes that have already been in 'master' were merged there
and the result has been tagged as Git 2.30.1.

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

* ab/detox-gettext-tests (2021-01-21) 3 commits
  (merged to 'next' on 2021-02-01 at 5573b4913c)
 + tests: remove uses of GIT_TEST_GETTEXT_POISON=false
 + tests: remove support for GIT_TEST_GETTEXT_POISON
 + ci: remove GETTEXT_POISON jobs

 Get rid of "GETTEXT_POISON" support altogether, which may or may
 not be controversial.


* ab/grep-pcre-invalid-utf8 (2021-01-24) 2 commits
  (merged to 'next' on 2021-02-01 at 60be521876)
 + grep/pcre2: better support invalid UTF-8 haystacks
 + grep/pcre2 tests: don't rely on invalid UTF-8 data test

 Update support for invalid UTF-8 in PCRE2.


* ab/lose-grep-debug (2021-01-26) 1 commit
  (merged to 'next' on 2021-01-31 at 9b7548efce)
 + grep/log: remove hidden --debug and --grep-debug options

 Lose the debugging aid that may have been useful in the past, but
 no longer is, in the "grep" codepaths.


* ab/retire-pcre1 (2021-01-23) 2 commits
  (merged to 'next' on 2021-02-01 at 532a0a8228)
 + Remove support for v1 of the PCRE library
 + config.mak.uname: remove redundant NO_LIBPCRE1_JIT flag

 The support for deprecated PCRE1 library has been dropped.


* ds/cache-tree-basics (2021-01-15) 10 commits
  (merged to 'next' on 2021-01-25 at 29ee74df7b)
 + cache-tree: speed up consecutive path comparisons
 + cache-tree: use ce_namelen() instead of strlen()
 + index-format: discuss recursion of cache-tree better
 + index-format: update preamble to cache tree extension
 + index-format: use 'cache tree' over 'cached tree'
 + cache-tree: trace regions for prime_cache_tree
 + cache-tree: trace regions for I/O
 + cache-tree: use trace2 in cache_tree_update()
 + unpack-trees: add trace2 regions
 + tree-walk: report recursion counts
 (this branch is used by ds/more-index-cleanups.)

 Document, clean-up and optimize the code around the cache-tree
 extension in the index.


* ds/more-index-cleanups (2021-01-23) 9 commits
  (merged to 'next' on 2021-02-01 at bcdfa11e73)
 + t1092: test interesting sparse-checkout scenarios
 + test-lib: test_region looks for trace2 regions
 + sparse-checkout: load sparse-checkout patterns
 + name-hash: use trace2 regions for init
 + repository: add repo reference to index_state
 + fsmonitor: de-duplicate BUG()s around dirty bits
 + cache-tree: extract subtree_pos()
 + cache-tree: simplify verify_cache() prototype
 + cache-tree: clean up cache_tree_update()

 Cleaning various codepaths up.


* en/ort-conflict-handling (2021-01-04) 10 commits
  (merged to 'next' on 2021-01-25 at 369c1516c4)
 + merge-ort: add handling for different types of files at same path
 + merge-ort: copy find_first_merges() implementation from merge-recursive.c
 + merge-ort: implement format_commit()
 + merge-ort: copy and adapt merge_submodule() from merge-recursive.c
 + merge-ort: copy and adapt merge_3way() from merge-recursive.c
 + merge-ort: flesh out implementation of handle_content_merge()
 + merge-ort: handle book-keeping around two- and three-way content merge
 + merge-ort: implement unique_path() helper
 + merge-ort: handle directory/file conflicts that remain
 + merge-ort: handle D/F conflict where directory disappears due to merge
 (this branch is used by en/merge-ort-perf.)

 ORT merge strategy learns more support for merge conflicts.


* jk/p5303-sed-portability-fix (2021-01-29) 1 commit
  (merged to 'next' on 2021-01-31 at 5f2957e738)
 + p5303: avoid sed GNU-ism

 A perf script was made more portable.


* jk/pretty-lazy-load-commit (2021-01-28) 1 commit
  (merged to 'next' on 2021-02-01 at acf7353a32)
 + pretty: lazy-load commit data when expanding user-format

 Some pretty-format specifiers do not need the data in commit object
 (e.g. "%H"), but we were over-eager to load and parse it, which has
 been made even lazier.


* jk/t0000-cleanups (2021-01-28) 4 commits
  (merged to 'next' on 2021-01-31 at 357f8fe097)
 + t0000: consistently use single quotes for outer tests
 + t0000: run cleaning test inside sub-test
 + t0000: run prereq tests inside sub-test
 + t0000: keep clean-up tests together

 Code clean-up.


* jk/use-oid-pos (2021-01-28) 6 commits
  (merged to 'next' on 2021-01-31 at 10ccafb739)
 + oid_pos(): access table through const pointers
 + hash_pos(): convert to oid_pos()
 + rerere: use strmap to store rerere directories
 + rerere: tighten rr-cache dirname check
 + rerere: check dirname format while iterating rr_cache directory
 + commit_graft_pos(): take an oid instead of a bare hash

 Code clean-up to ensure our use of hashtables using object names as
 keys use the "struct object_id" objects, not the raw hash values.


* jk/weather-balloon-require-variadic-macro (2021-01-27) 1 commit
  (merged to 'next' on 2021-01-31 at 8d5207bd85)
 + git-compat-util: always enable variadic macros

 We've carried compatibility codepaths for compilers without
 variadic macros for quite some time, but the world may be ready for
 them to be removed.  Force compilation failure on exotic platforms
 where variadic macros are not available to find out who screams in
 such a way that we can easily revert if it turns out that the world
 is not yet ready.


* js/rebase-i-commit-cleanup-fix (2021-01-28) 1 commit
  (merged to 'next' on 2021-01-31 at 358f562e1f)
 + rebase -i: do leave commit message intact in fixup! chains

 When "git rebase -i" processes "fixup" insn, there is no reason to
 clean up the commit log message, but we did the usual stripspace
 processing.  This has been corrected.


* jv/pack-objects-narrower-ref-iteration (2021-01-22) 1 commit
  (merged to 'next' on 2021-01-26 at 8a0d178c01)
 + builtin/pack-objects.c: avoid iterating all refs

 The "pack-objects" command needs to iterate over all the tags when
 automatic tag following is enabled, but it actually iterated over
 all refs and then discarded everything outside "refs/tags/"
 hierarchy, which was quite wasteful.


* pb/blame-funcname-range-userdiff (2021-01-30) 1 commit
  (merged to 'next' on 2021-01-31 at 107d10fe4f)
 + annotate-tests: quote variable expansions containing path names

 Test fix.


* pb/ci-matrix-wo-shortcut (2021-01-27) 1 commit
  (merged to 'next' on 2021-01-31 at 2384693758)
 + ci: do not cancel all jobs of a matrix if one fails

 Our setting of GitHub CI test jobs were a bit too eager to give up
 once there is even one failure found.  Tweak the knob to allow
 other jobs keep running even when we see a failure, so that we can
 find more failures in a single run.


* ph/use-delete-refs (2021-01-21) 1 commit
  (merged to 'next' on 2021-01-26 at e03486152e)
 + use delete_refs when deleting tags or branches

 When removing many branches and tags, the code used to do so one
 ref at a time.  There is another API it can use to delete multiple
 refs, and it makes quite a lot of performance difference when the
 refs are packed.


* rs/worktree-list-verbose (2021-01-30) 7 commits
  (merged to 'next' on 2021-02-01 at b57a6ce4c6)
 + worktree: teach `list` verbose mode
 + worktree: teach `list` to annotate prunable worktree
 + worktree: teach `list --porcelain` to annotate locked worktree
 + t2402: ensure locked worktree is properly cleaned up
 + worktree: teach worktree_lock_reason() to gently handle main worktree
 + worktree: teach worktree to lazy-load "prunable" reason
 + worktree: libify should_prune_worktree()

 `git worktree list` now annotates worktrees as prunable, shows
 locked and prunable attributes in --porcelain mode, and gained
 a --verbose option.
 cf. <CAPig+cTt-TyOR8kc6YvBVLpf-bgFdJ+FVYA2NvG_Vvn7tMbBkQ@mail.gmail.com>


* sg/t7800-difftool-robustify (2021-01-09) 1 commit
  (merged to 'next' on 2021-01-31 at fb72af8200)
 + t7800-difftool: don't accidentally match tmp dirs

 Test fix.


* sg/test-stress-jobs (2021-01-26) 1 commit
  (merged to 'next' on 2021-02-01 at 0b7aae84e3)
 + test-lib: prevent '--stress-jobs=X' from being ignored

 Test framework fix.


* so/log-diff-merge (2020-12-21) 32 commits
  (merged to 'next' on 2021-01-25 at 63977ef287)
 + t4013: add tests for --diff-merges=first-parent
 + doc/git-show: include --diff-merges description
 + doc/rev-list-options: document --first-parent changes merges format
 + doc/diff-generate-patch: mention new --diff-merges option
 + doc/git-log: describe new --diff-merges options
 + diff-merges: add '--diff-merges=1' as synonym for 'first-parent'
 + diff-merges: add old mnemonic counterparts to --diff-merges
 + diff-merges: let new options enable diff without -p
 + diff-merges: do not imply -p for new options
 + diff-merges: implement new values for --diff-merges
 + diff-merges: make -m/-c/--cc explicitly mutually exclusive
 + diff-merges: refactor opt settings into separate functions
 + diff-merges: get rid of now empty diff_merges_init_revs()
 + diff-merges: group diff-merge flags next to each other inside 'rev_info'
 + diff-merges: split 'ignore_merges' field
 + diff-merges: fix -m to properly override -c/--cc
 + t4013: add tests for -m failing to override -c/--cc
 + t4013: support test_expect_failure through ':failure' magic
 + diff-merges: revise revs->diff flag handling
 + diff-merges: handle imply -p on -c/--cc logic for log.c
 + diff-merges: introduce revs->first_parent_merges flag
 + diff-merges: new function diff_merges_set_dense_combined_if_unset()
 + diff-merges: new function diff_merges_suppress()
 + diff-merges: re-arrange functions to match the order they are called in
 + diff-merges: rename diff_merges_default_to_enable() to match semantics
 + diff-merges: move checks for first_parent_only out of the module
 + diff-merges: rename all functions to have common prefix
 + revision: move diff merges functions to its own diff-merges.c
 + revision: provide implementation for diff merges tweaks
 + revision: factor out initialization of diff-merge related settings
 + revision: factor out setup of diff-merge related settings
 + revision: factor out parsing of diff-merge related options

 "git log" learned a new "--diff-merges=<how>" option.


* tb/ls-refs-optim (2021-01-22) 3 commits
  (merged to 'next' on 2021-01-26 at 09edbf7d9a)
 + ls-refs.c: traverse prefixes of disjoint "ref-prefix" sets
 + ls-refs.c: initialize 'prefixes' before using it
 + refs: expose 'for_each_fullref_in_prefixes'

 The ls-refs protocol operation has been optimized to narrow the
 sub-hierarchy of refs/ it walks to produce response.


* zh/ls-files-deduplicate (2021-01-23) 3 commits
  (merged to 'next' on 2021-01-26 at af7522d2cf)
 + ls-files.c: add --deduplicate option
 + ls_files.c: consolidate two for loops into one
 + ls_files.c: bugfix for --deleted and --modified

 "git ls-files" can and does show multiple entries when the index is
 unmerged, which is a source for confusion unless -s/-u option is in
 use.  A new option --deduplicate has been introduced.

--------------------------------------------------
[New Topics]

* js/range-diff-one-side-only (2021-02-06) 6 commits
  (merged to 'next' on 2021-02-08 at 8c35ed8523)
 + range-diff: offer --left-only/--right-only options
 + range-diff: move the diffopt initialization down one layer
 + range-diff: combine all options in a single data structure
 + range-diff: simplify code spawning `git log`
 + range-diff: libify the read_patches() function again
 + range-diff: avoid leaking memory in two error code paths

 The "git range-diff" command learned "--(left|right)-only" option
 to show only one side of the compared range.

 Will merge to 'master'.


* cm/rebase-i-updates (2021-02-10) 11 commits
 - doc/rebase -i: fix typo in the documentation of 'fixup' command
 - t/t3437: fixup the test 'multiple fixup -c opens editor once'
 - t/t3437: use named commits in the tests
 - t/t3437: simplify and document the test helpers
 - t/t3437: check the author date of fixed up commit
 - t/t3437: remove the dependency of 'expected-message' file from tests
 - t/t3437: fixup here-docs in the 'setup' test
 - t/lib-rebase: update the documentation of FAKE_LINES
 - rebase -i: clarify and fix 'fixup -c' rebase-todo help
 - sequencer: rename a few functions
 - sequencer: fixup the datatype of the 'flag' argument
 (this branch uses cm/rebase-i.)

 Follow-up fixes to "cm/rebase-i" topic.

 Will merge to 'next' after waiting for a few more days for comments.


* cw/pack-vs-bigfilethreashold (2021-02-09) 2 commits
 - fixup! doc: mention bigFileThreshold for packing
 - doc: mention bigFileThreshold for packing

 Doc update.

 Expecting a reroll.
 cf. <F63929A8-7BC9-43A7-9E7B-118433F62588@gmx.ch>


* ds/maintenance-pack-refs (2021-02-09) 2 commits
 - maintenance: incremental strategy runs pack-refs weekly
 - maintenance: add pack-refs task

 "git maintenance" tool learned a new "pack-refs" maintenance task.

 Will merge to 'next' after waiting for a few more days for comments.



* jk/mailmap-only-at-root (2021-02-10) 1 commit
 - mailmap: only look for .mailmap in work tree

 The .mailmap is documented to be read only from the root level of a
 working tree, but a stray file in a bare repository also was read
 by accident, which has been corrected.

 Will merge to 'next'.


* jk/rev-list-disk-usage (2021-02-09) 3 commits
 - fixup! rev-list: add --disk-usage option for calculating disk usage
 - rev-list: add --disk-usage option for calculating disk usage
 - t: add --no-tag option to test_commit

 "git rev-list" command learned "--disk-usage" option.


* jt/trace2-BUG (2021-02-09) 1 commit
  (merged to 'next' on 2021-02-09 at 94911ad676)
 + usage: trace2 BUG() invocations

 Even though invocations of "die()" were logged to the trace2
 system, "BUG()"s were not, which has been corrected.

 Will merge to 'master'.


* mt/checkout-index-corner-cases (2021-02-09) 2 commits
 - checkout-index: omit entries with no tempname from --temp output
 - write_entry(): fix misuses of `path` in error messages

 The error codepath around the "--temp/--prefix" feature of "git
 checkout-index" has been improved.

 Expecting additional tests.


* mt/grep-cached-untracked (2021-02-09) 1 commit
 - grep: error out if --untracked is used with --cached

 "git grep --untracked" is meant to be "let's ALSO find in these
 files on the filesystem" when looking for matches in the working
 tree files, and does not make any sense if the primary search is
 done against the index, or the tree objects.  The "--cached" and
 "--untracked" options have been marked as mutually incompatible.

 Will merge to 'next'.


* tb/ci-run-cocci-with-18.04 (2021-02-08) 1 commit
  (merged to 'next' on 2021-02-09 at c50bc53527)
 + .github/workflows/main.yml: run static-analysis on bionic

 The version of Ubuntu Linux used by default at GitHub Actions CI
 has been updated to one that lack coccinelle; until it gets fixed,
 work it around by sticking to the previous release (18.04).

 Will merge to 'master'.


* ab/test-lib (2021-02-10) 12 commits
 - test-lib-functions: split out {debug,path,text} helpers
 - test-lib-functions: assert correct parameter count
 - test-lib-functions: remove bug-inducing "diagnostics" helper param
 - test libs: rename "diff-lib" to "lib-diff"
 - t/.gitattributes: sort lines
 - test-lib-functions: move function to lib-bitmap.sh
 - test libs: rename gitweb-lib.sh to lib-gitweb.sh
 - test libs: rename bundle helper to "lib-bundle.sh"
 - test-lib-functions: remove generate_zero_bytes() wrapper
 - test-lib-functions: move test_set_index_version() to its user
 - test lib: change "error" to "BUG" as appropriate
 - test-lib: remove check_var_migration

 Test framework clean-up.


* dl/stash-cleanup (2021-02-09) 7 commits
 - stash: declare ref_stash as an array
 - t3905: use test_cmp() to check file contents
 - t3905: replace test -s with test_file_not_empty
 - t3905: remove nested git in command substitution
 - t3905: move all commands into test cases
 - t3905: remove spaces after redirect operators
 - git-stash.txt: be explicit about subcommand options

 Documentation, code and test clean-up around "git stash".

 Will merge to 'next' and to 'master' soonish.
 This is an early part of a topic that added a new feature to the 
 command, but the implementation is expected to need a handful of
 iterations; I split the preparatory part up to fast-track it.


* ew/rev-parse-since-test (2021-02-10) 1 commit
 - t1500: ensure current --since= behavior remains

 Test to make sure "git rev-parse one-thing one-thing" gives
 the same thing twice (when one-thing is --since=X).

 Will merge to 'next'.


* js/fsck-name-objects-fix (2021-02-10) 2 commits
 - fsck --name-objects: be more careful parsing generation numbers
 - t1450: robustify `remove_object()`

 Fix "git fsck --name-objects" which apparently has not been used by
 anybody who is motivated enough to report breakage.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jk/symlinked-dotgitx-files (2020-10-23) 9 commits
 - docs: document symlink restrictions for .git* files
 - fsck: complain when .gitattributes or .gitignore is a symlink
 - verify_path(): disallow symlinks in .gitattributes and .gitignore
 - t0060: test obscured .gitattributes and .gitignore matching
 - t7450: test .gitmodules symlink matching against obscured names
 - t7450: test verify_path() handling of gitmodules
 - t7415: rename to expand scope
 - fsck_tree(): wrap some long lines
 - fsck_tree(): fix shadowed variable

 "git fsck" and the corresponding check done during the transport
 learned to ensure that in-tree files like `.gitignore` and
 `.gitattributes` are not symbolic links.

 It seems that there are real projects with .gitignore recorded as
 symlinks, which may need to loosen the fsck setting.  Do we need to
 introduce a class that is separate from symlinked .gitmodules that
 has potential consequences that is more/less grave, so that these
 projects can opt out of the new checks?


* sm/curl-retry (2020-10-13) 3 commits
 - http: automatically retry some requests
 - replace CURLOPT_FILE With CURLOPT_WRITEDATA
 - remote-curl: add testing for intelligent retry for HTTP

 The http transport has been taught to retry a failed request that
 may reasonably be retried.

 Expecting a reroll.
 cf. <20201015000410.GB328643@google.com>
 cf. <CAM4o00eefXK2CJ_FxwwVPpBKL01JsJANf+SdjCtw_0NVV82L+Q@mail.gmail.com>


* ar/fetch-transfer-ipversion (2020-09-16) 1 commit
 - config: option transfer.ipversion to set transport protocol version for network fetches

 Adds transfer.ipversion configuration variable.

 Needs more work.


* jc/war-on-dashed-git (2020-12-21) 2 commits
 - fixup??? git: catch an attempt to run "git-foo"
 - git: catch an attempt to run "git-foo"

 The first step to remove on-disk binaries for built-in subcommands
 by soliciting objections.

 On hold for now.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* ag/merge-strategies-in-c (2020-11-24) 13 commits
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

* sv/t7001-modernize (2021-02-09) 10 commits
 - t7001: use `test` rather than `[`
 - t7001: use here-docs instead of echo
 - t7001: put each command on a separate line
 - t7001: use '>' rather than 'touch'
 - t7001: avoid using `cd` outside of subshells
 - t7001: remove whitespace after redirect operators
 - t7001: modernize subshell formatting
 - t7001: remove unnecessary blank lines
 - t7001: indent with TABs instead of spaces
 - t7001: modernize test formatting

 Test script modernization.


* mt/grep-sparse-checkout (2021-02-09) 1 commit
 - grep: honor sparse-checkout on working tree searches

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.

 Break out and fast-track bugfix from the remainder of the topic.
 cf. <CABPp-BFkACtF6LHkFJNt9dTOmwfQbf8ZO=BTrPYwPSmbqc9+hg@mail.gmail.com>


* ab/make-cleanup (2021-02-01) 6 commits
 - Makefile: add {program,xdiff,test,git}-objs & objects targets
 - Makefile: split OBJECTS into OBJECTS and GIT_OBJS
 - Makefile: sort OBJECTS assignment for subsequent change
 - Makefile: split up long OBJECTS line
 - Makefile: guard against TEST_OBJS in the environment
 - Makefile: remove "all" on "$(FUZZ_OBJS)"

 Reorganize Makefile to allow building git.o and other essential
 objects without extra stuff needed only for testing.


* ds/commit-graph-genno-fix (2021-02-01) 6 commits
  (merged to 'next' on 2021-02-03 at b3a9e11efb)
 + commit-graph: prepare commit graph
 + commit-graph: be extra careful about mixed generations
 + commit-graph: compute generations separately
 + commit-graph: validate layers for generation data
 + commit-graph: always parse before commit_graph_data_at()
 + commit-graph: use repo_parse_commit
 (this branch uses ak/corrected-commit-date; is tangled with ds/chunked-file-api and ds/merge-base-independent.)

 Fix incremental update of commit-graph file around corrected commit
 date data.

 Will merge to 'master'.


* jh/simple-ipc (2021-02-01) 13 commits
 - simple-ipc: add Unix domain socket implementation
 - unix-socket: do not call die in unix_stream_connect()
 - unix-socket: add no-chdir option to unix_stream_listen()
 - unix-socket: add options to unix_stream_listen()
 - unix-socket: elimiate static unix_stream_socket() helper function
 - simple-ipc: add t/helper/test-simple-ipc and t0052
 - simple-ipc: add win32 implementation
 - simple-ipc: design documentation for new IPC mechanism
 - pkt-line: accept additional options in read_packetized_to_strbuf()
 - pkt-line: (optionally) libify the packet readers
 - pkt-line: optionally skip the flush packet in write_packetized_from_buf()
 - pkt-line: add write_packetized_from_buf2() that takes scratch buffer
 - pkt-line: promote static buffer in packet_write_gently() to callers

 A simple IPC interface gets introduced to build services like
 fsmonitor on top.


* ab/pager-exit-log (2021-02-01) 4 commits
 - pager: properly log pager exit code when signalled
 - run-command: add braces for "if" block in wait_or_whine()
 - pager: test for exit code with and without SIGPIPE
 - pager: refactor wait_for_pager() function

 When a pager spawned by us exited, the trace log did not record its
 exit status correctly, which has been corrected.


* jk/complete-branch-force-delete (2021-02-03) 3 commits
  (merged to 'next' on 2021-02-03 at 6454bb89b5)
 + doc/git-branch: fix awkward wording for "-c"
 + completion: handle other variants of "branch -m"
 + completion: treat "branch -D" the same way as "branch -d"

 The command line completion (in contrib/) completed "git branch -d"
 with branch names, but "git branch -D" offered tagnames in addition,
 which has been corrected.  "git branch -M" had the same problem.

 Will merge to 'master'.


* ta/hash-function-transition-doc (2021-02-05) 6 commits
 - doc: use https links
 - doc hash-function-transition: move rationale upwards
 - doc hash-function-transition: fix incomplete sentence
 - doc hash-function-transition: use upper case consistently
 - doc hash-function-transition: use SHA-1 and SHA-256 consistently
 - doc hash-function-transition: fix asciidoc output

 Update formatting and grammar of the hash transition plan
 documentation, plus some updates.

 Will merge to 'next' after waiting for comments for a few days.


* ds/chunked-file-api (2021-02-05) 17 commits
 - chunk-format: add technical docs
 - chunk-format: restore duplicate chunk checks
 - midx: use 64-bit multiplication for chunk sizes
 - midx: use chunk-format read API
 - commit-graph: use chunk-format read API
 - chunk-format: create read chunk API
 - midx: use chunk-format API in write_midx_internal()
 - midx: drop chunk progress during write
 - midx: return success/failure in chunk write methods
 - midx: add num_large_offsets to write_midx_context
 - midx: add pack_perm to write_midx_context
 - midx: add entries to write_midx_context
 - midx: use context in write_midx_pack_names()
 - midx: rename pack_info to write_midx_context
 - commit-graph: use chunk-format write API
 - chunk-format: create chunk format write API
 - commit-graph: anonymize data in chunk_write_fn
 (this branch uses ak/corrected-commit-date; is tangled with ds/commit-graph-genno-fix and ds/merge-base-independent.)

 The common code to deal with "chunked file format" that is shared
 by the multi-pack-index and commit-graph files have been factored
 out, to help codepaths for both filetypes to become more rebust.

 Will merge to 'next' after waiting for a few days.


* ds/merge-base-independent (2021-02-01) 5 commits
 - commit-reach: stale commits may prune generation further
 - commit-reach: use heuristic in remove_redundant()
 - commit-reach: move compare_commits_by_gen
 - commit-reach: use one walk in remove_redundant()
 - commit-reach: reduce requirements for remove_redundant()
 (this branch uses ak/corrected-commit-date; is tangled with ds/chunked-file-api and ds/commit-graph-genno-fix.)

 The code to implement "git merge-base --independent" was poorly
 done and was kept from the very beginning of the feature.


* hv/trailer-formatting (2021-02-06) 3 commits
 - ref-filter: use pretty.c logic for trailers
 - pretty.c: capture invalid trailer argument
 - pretty.c: refactor trailer logic to `format_set_trailers_options()`

 The logic to handle "trailer" related placeholders in the
 "--format=" mechanisms in the "log" family and "for-each-ref"
 family is getting unified.

 Ready for 'next'?


* sh/mergetool-hideresolved (2021-02-09) 3 commits
  (merged to 'next' on 2021-02-09 at c3ed19b2ec)
 + mergetool: add per-tool support and overrides for the hideResolved flag
 + mergetool: break setup_tool out into separate initialization function
 + mergetool: add hideResolved configuration

 "git mergetool" feeds three versions (base, local and remote) of
 a conflicted path unmodified.  The command learned to optionally
 prepare these files with unconflicted parts already resolved.

 Will merge to 'master'.


* tb/precompose-prefix-too (2021-02-03) 1 commit
  (merged to 'next' on 2021-02-05 at 1dd43136b1)
 + MacOS: precompose_argv_prefix()

 When commands are started from a subdirectory, they may have to
 compare the path to the subdirectory (called prefix and found out
 from $(pwd)) with the tracked paths.  On macOS, $(pwd) and
 readdir() yield decomposed path, while the tracked paths are
 usually normalized to the precomposed form, causing mismatch.  This
 has been fixed by taking the same approach used to normalize the
 command line arguments.

 Will merge to 'master'.


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
 (this branch is used by cm/rebase-i-updates.)

 "rebase -i" is getting cleaned up and also enhanced.

 Will cook in 'next' while waiting for the 'updates' topic.


* tb/geometric-repack (2021-02-03) 8 commits
 - builtin/repack.c: add '--geometric' option
 - packfile: add kept-pack cache for find_kept_pack_entry()
 - builtin/pack-objects.c: rewrite honor-pack-keep logic
 - p5303: measure time to repack with keep
 - p5303: add missing &&-chains
 - builtin/pack-objects.c: add '--stdin-packs' option
 - revision: learn '--no-kept-objects'
 - packfile: introduce 'find_kept_pack_entry()'

 "git repack" so far has been only capable of repacking everything
 under the sun into a single pack (or split by size).  A cleverer
 strategy to reduce the cost of repacking a repository has been
 introduced.


* ah/rebase-no-fork-point-config (2021-01-21) 1 commit
 - rebase: add a config option for --no-fork-point

 "git rebase --[no-]fork-point" gained a configuration variable
 rebase.forkPoint so that users do not have to keep specifying a
 non-default setting.

 Expecting a reroll to update its tests.
 cf. <CAMMLpeTDNLUz9UVnL3aVK=J7X50Sq8L-OVGaoEsT5AY6EQON-g@mail.gmail.com>


* js/range-diff-wo-dotdot (2021-02-06) 3 commits
  (merged to 'next' on 2021-02-08 at 9ae8b46d99)
 + range-diff(docs): explain how to specify commit ranges
 + range-diff/format-patch: handle commit ranges other than A..B
 + range-diff/format-patch: refactor check for commit range

 There are other ways than ".." for a single token to denote a
 "commit range", namely "<rev>^!" and "<rev>^-<n>", but "git
 range-diff" did not understand them.

 Will merge to 'master'.


* jx/t5411-unique-filenames (2021-01-22) 2 commits
 - t5411: refactor check of refs using test_cmp_refs
 - t5411: use different out file to prevent overwriting

 Avoid individual tests in t5411 from getting affected by each other
 by forcing them to use separate output files during the test.


* jt/transfer-fsck-across-packs (2021-01-25) 5 commits
 - SQUASH??? test fix
 - fetch-pack: print and use dangling .gitmodules
 - fetch-pack: with packfile URIs, use index-pack arg
 - http-fetch: allow custom index-pack args
 - http: allow custom index-pack args

 The approach to "fsck" the incoming objects in "index-pack" is
 attractive for performance reasons (we have them already in core,
 inflated and ready to be inspected), but fundamentally cannot be
 applied fully when we receive more than one pack stream, as a tree
 object in one pack may refer to a blob object in another pack as
 ".gitmodules", when we want to inspect blobs that are used as
 ".gitmodules" file, for example.  Teach "index-pack" to emit
 objects that must be inspected later and check them in the calling
 "fetch-pack" process.


* jv/upload-pack-filter-spec-quotefix (2021-02-02) 2 commits
  (merged to 'next' on 2021-02-03 at 2e34f74e3a)
 + t5544: clarify 'hook works with partial clone' test
  (merged to 'next' on 2021-01-31 at 789bf4154e)
 + upload-pack.c: fix filter spec quoting bug

 Fix in passing custom args from "git clone" to "upload-pack" on the
 other side.

 Will merge to 'master'.


* ab/tests-various-fixup (2021-01-23) 10 commits
  (merged to 'next' on 2021-02-01 at a604a6e217)
 + rm tests: actually test for SIGPIPE in SIGPIPE test
 + archive tests: use a cheaper "zipinfo -h" invocation to get header
 + upload-pack tests: avoid a non-zero "grep" exit status
 + git-svn tests: rewrite brittle tests to use "--[no-]merges".
 + git svn mergeinfo tests: refactor "test -z" to use test_must_be_empty
 + git svn mergeinfo tests: modernize redirection & quoting style
 + cache-tree tests: explicitly test HEAD and index differences
 + cache-tree tests: use a sub-shell with less indirection
 + cache-tree tests: remove unused $2 parameter
 + cache-tree tests: refactor for modern test style

 Various test updates.

 Will merge to 'master'.


* en/ort-directory-rename (2021-01-20) 18 commits
  (merged to 'next' on 2021-02-01 at 5c1cdd13a1)
 + merge-ort: fix a directory rename detection bug
 + merge-ort: process_renames() now needs more defensiveness
 + merge-ort: implement apply_directory_rename_modifications()
 + merge-ort: add a new toplevel_dir field
 + merge-ort: implement handle_path_level_conflicts()
 + merge-ort: implement check_for_directory_rename()
 + merge-ort: implement apply_dir_rename() and check_dir_renamed()
 + merge-ort: implement compute_collisions()
 + merge-ort: modify collect_renames() for directory rename handling
 + merge-ort: implement handle_directory_level_conflicts()
 + merge-ort: implement compute_rename_counts()
 + merge-ort: copy get_renamed_dir_portion() from merge-recursive.c
 + merge-ort: add outline of get_provisional_directory_renames()
 + merge-ort: add outline for computing directory renames
 + merge-ort: collect which directories are removed in dirs_removed
 + merge-ort: initialize and free new directory rename data structures
 + merge-ort: add new data structures for directory rename detection
 + Merge branch 'en/merge-ort-3' into en/ort-directory-rename
 (this branch is used by en/merge-ort-perf.)

 ORT merge strategy learns to infer "renamed directory" while
 merging.

 Will merge to 'master'.


* bc/signed-objects-with-both-hashes (2021-02-09) 7 commits
 - SQUASH???
 - gpg-interface: remove other signature headers before verifying
 - ref-filter: hoist signature parsing
 - commit: allow parsing arbitrary buffers with headers
 - gpg-interface: improve interface for parsing tags
 - commit: ignore additional signatures when parsing signed commits
 - ref-filter: switch some uses of unsigned long to size_t

 Signed commits and tags now allow verification of objects, whose
 two object names (one in SHA-1, the other in SHA-256) are both
 signed.

 Looking good.


* tb/pack-revindex-on-disk (2021-01-28) 10 commits
  (merged to 'next' on 2021-02-01 at bd6a780213)
 + t5325: check both on-disk and in-memory reverse index
 + pack-revindex: ensure that on-disk reverse indexes are given precedence
 + t: support GIT_TEST_WRITE_REV_INDEX
 + t: prepare for GIT_TEST_WRITE_REV_INDEX
 + Documentation/config/pack.txt: advertise 'pack.writeReverseIndex'
 + builtin/pack-objects.c: respect 'pack.writeReverseIndex'
 + builtin/index-pack.c: write reverse indexes
 + builtin/index-pack.c: allow stripping arbitrary extensions
 + pack-write.c: prepare to write 'pack-*.rev' files
 + packfile: prepare for the existence of '*.rev' files

 Introduce an on-disk file to record revindex for packdata, which
 traditionally was always created on the fly and only in-core.

 Will merge to 'master'.


* en/merge-ort-perf (2021-01-23) 6 commits
  (merged to 'next' on 2021-02-01 at ca3c07579b)
 + merge-ort: begin performance work; instrument with trace2_region_* calls
 + merge-ort: ignore the directory rename split conflict for now
 + merge-ort: fix massive leak
 + Merge branch 'en/ort-directory-rename' into en/merge-ort-perf
 + Merge branch 'en/ort-conflict-handling' into en/merge-ort-perf
 + Merge branch 'en/diffcore-rename' into en/merge-ort-perf
 (this branch uses en/ort-directory-rename.)

 The "ort" merge strategy.

 Will merge to 'master'.


* ak/corrected-commit-date (2021-01-18) 11 commits
  (merged to 'next' on 2021-01-26 at deae33ec7d)
 + doc: add corrected commit date info
 + commit-reach: use corrected commit dates in paint_down_to_common()
 + commit-graph: use generation v2 only if entire chain does
 + commit-graph: implement generation data chunk
 + commit-graph: implement corrected commit date
 + commit-graph: return 64-bit generation number
 + commit-graph: add a slab to store topological levels
 + t6600-test-reach: generalize *_three_modes
 + commit-graph: consolidate fill_commit_graph_info
 + revision: parse parent in indegree_walk_step()
 + commit-graph: fix regression when computing Bloom filters
 (this branch is used by ds/chunked-file-api, ds/commit-graph-genno-fix and ds/merge-base-independent.)

 The commit-graph learned to use corrected commit dates instead of
 the generation number to help topological revision traversal.

 Will merge to 'master' together with ds/commit-graph-genno-fix.


* mr/bisect-in-c-4 (2021-02-03) 7 commits
  (merged to 'next' on 2021-02-05 at ea18026619)
 + bisect--helper: retire `--check-and-set-terms` subcommand
 + bisect--helper: reimplement `bisect_skip` shell function in C
 + bisect--helper: retire `--bisect-auto-next` subcommand
 + bisect--helper: use `res` instead of return in BISECT_RESET case option
 + bisect--helper: retire `--bisect-write` subcommand
 + bisect--helper: reimplement `bisect_replay` shell function in C
 + bisect--helper: reimplement `bisect_log` shell function in C

 Piecemeal of rewrite of "git bisect" in C continues.

 Will merge to 'master'.


* jt/clone-unborn-head (2021-02-05) 3 commits
  (merged to 'next' on 2021-02-08 at 3ba9f80e7f)
 + clone: respect remote unborn HEAD
 + connect, transport: encapsulate arg in struct
 + ls-refs: report unborn targets of symrefs

 "git clone" tries to locally check out the branch pointed at by
 HEAD of the remote repository after it is done, but the protocol
 did not convey the information necessary to do so when copying an
 empty repository.  The protocol v2 learned how to do so.

 Will merge to 'master'.


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


* es/config-hooks (2020-12-21) 34 commits
 - run-command: stop thinking about hooks
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
 - hook: replace find_hook() with hook_exists()
 - hook: add 'run' subcommand
 - parse-options: parse into strvec
 - hook: implement hookcmd.<name>.skip
 - hook: respect hook.runHookDir
 - hook: include hookdir hook in list
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.

 Expecting doc updates, but otherwise seems to be progressing nicely.


* hn/reftable (2020-12-21) 16 commits
 - SQUASH??? allow t0031 to run with any default branch name
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

--------------------------------------------------
[Discarded]

* ds/update-index (2021-01-09) 14 commits
 . update-index: remove static globals from callbacks
 . update-index: reduce static globals, part 2
 . update-index: reduce static globals, part 1
 . update-index: remove ce_match_stat(), all macros
 . update-index: replace several compatibility macros
 . update-index: use add_index_entry()
 . update-index: use remove_file_from_index()
 . update-index: use index_name_pos() over cache_name_pos()
 . update-index: use istate->cache_changed
 . update-index: use istate->cache_nr over active_nr
 . update-index: use istate->cache over active_cache
 . update-index: drop the_index, the_repository
 . rm: remove compatilibity macros
 . mv: remove index compatibility macros
 (this branch uses ag/merge-strategies-in-c.)

 The implementation of a few commands lost reliance of "the_index"
 compatibility macros by explicitly passing the index_state through
 the callchain.

 Retracted for now.
 cf. <a6906459-3a93-ecad-c460-b6c763819389@gmail.com>


* fc/mergetool-automerge (2021-01-09) 8 commits
 . fixup! mergetool: break setup_tool out into separate initialization function
 . fixup! fixup! mergetool: add automerge configuration
 . fixup! mergetool: add automerge configuration
 . mergetool: add automerge_enabled tool-specific override function
 . mergetool: break setup_tool out into separate initialization function
 . mergetool: add per-tool support for the autoMerge flag
 . mergetool: alphabetize the mergetool config docs
 . mergetool: add automerge configuration

 "git mergetool" feeds three versions (base, local and remote) of
 a conflicted path unmodified.  The command learned to optionally
 prepare these files with unconflicted parts already resolved.

 Superseded by the sh/mergetool-hideresolved topic.


* mt/rm-sparse-checkout (2020-12-08) 11 commits
 . rm: honor sparse checkout patterns
 . t7817: do not depend on any specific default branch name
 . config: add setting to ignore sparsity patterns in some cmds
 . grep: honor sparse checkout patterns
 . config: correctly read worktree configs in submodules
 . config: make do_git_config_sequence receive a 'struct repository'
 . t/helper/test-config: unify exit labels
 . t/helper/test-config: diagnose missing arguments
 . t/helper/test-config: be consistent with exit codes
 . t1308-config-set: avoid false positives when using test-config
 . doc: grep: unify info on configuration variables

 "git rm" follows suit to "git grep" to ignore paths outside the
 sparsity pattern when the sparse checkout feature is in use.

 Discarded for now, as it depends on an old iteration of
 mt/grep-sparse-checkout topic.


* fc/bash-completion-post-2.29 (2020-12-23) 4 commits
 . completion: bash: add correct suffix in variables
 . completion: bash: fix for multiple dash commands
 . completion: bash: fix for suboptions with value
 . completion: bash: fix prefix detection in branch.*

 Stalled for too long with breakage.
 Seems to break tests on Windows


* ss/submodule-add-in-c (2020-12-15) 3 commits
 . t7400: add test to check 'submodule add' for tracked paths
 . submodule: port submodule subcommand 'add' from shell to C
 . dir: change the scope of function 'directory_exists_in_index()'

 "git submodule add" being rewritten in C.

 Stalled for too long with breakage.
 The patches are split incorrectly; part of 1/3 belongs to 2/3
 cf. <nycvar.QRO.7.76.6.2012190104140.56@tvgsbejvaqbjf.bet>
 It seems to introduce a segfault on 'seen'.
 cf. <xmqqft3xflw7.fsf@gitster.c.googlers.com>
