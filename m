Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4537C43381
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696D264DDA
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242641AbhCDAWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62447 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442520AbhCCKTu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 05:19:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 029AA108A7E;
        Wed,  3 Mar 2021 05:14:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=D
        i5DO99VhlpKKHcjxMFAj3bZVtI=; b=ZDTEcauVPj+aEh4UCSp/jXxJXRwew0iD1
        wipZTK/dri/Q9ihBEwcgX1KI/I8UA6Dy/RHiKt2RUDkUMlu5xhdP0pEIcHm2WXtf
        o4bzWhJRdMAReEggzUoe+JhQXqAfEem5jQfS5hK9RYxykYAyCtNesou/RxPMJQ9e
        1aIsaBoSSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Gw8
        RWAZMvfv4B6RfDIJDR1LAvWsY8ie4BLFFgmXwWdrVTXnEhUfcNLIq5plGwU+8y0H
        iCxIoUTVQ1rYWQC3hXb4NQb62Rn8H+w1tmKxa2bkRkVruzikAmjAJrbB/6DVQgz5
        hCmDOrR3TbhAy4FwttM8Mxjxx2miNy/O4PjAH2dE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF086108A7D;
        Wed,  3 Mar 2021 05:14:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 27BD0108A7A;
        Wed,  3 Mar 2021 05:14:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2021, #01; Tue, 2)
X-master-at: f01623b2c9d14207e497b21ebc6b3ec4afaf4b46
X-next-at: b75b4e4ce211a6bec04cdfcb7eadec68c4e7c388
Date:   Wed, 03 Mar 2021 02:14:43 -0800
Message-ID: <xmqqlfb4k0h8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46F2136E-7C09-11EB-ACA3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

A release candidate Git v2.31.0-rc1 has been tagged.

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

* ab/detox-gettext-tests (2021-02-10) 4 commits
  (merged to 'next' on 2021-02-17 at bd3d771557)
 + tests: remove most uses of test_i18ncmp
 + tests: remove last uses of C_LOCALE_OUTPUT
 + tests: remove most uses of C_LOCALE_OUTPUT
 + tests: remove last uses of GIT_TEST_GETTEXT_POISON=false

 Removal of GIT_TEST_GETTEXT_POISON continues.


* ab/diff-deferred-free (2021-02-11) 2 commits
  (merged to 'next' on 2021-02-12 at 5e24106122)
 + diff: plug memory leak from regcomp() on {log,diff} -I
 + diff: add an API for deferred freeing

 A small memleak in "diff -I<regexp>" has been corrected.


* ab/pager-exit-log (2021-02-01) 4 commits
  (merged to 'next' on 2021-02-12 at ffe9f2d364)
 + pager: properly log pager exit code when signalled
 + run-command: add braces for "if" block in wait_or_whine()
 + pager: test for exit code with and without SIGPIPE
 + pager: refactor wait_for_pager() function

 When a pager spawned by us exited, the trace log did not record its
 exit status correctly, which has been corrected.
 The original "what should we do with SIGPIPE?" question remains, though.


* ab/test-lib (2021-02-12) 11 commits
  (merged to 'next' on 2021-02-12 at 666a0422dc)
 + test-lib-functions: assert correct parameter count
 + test-lib-functions: remove bug-inducing "diagnostics" helper param
 + test libs: rename "diff-lib" to "lib-diff"
 + t/.gitattributes: sort lines
 + test-lib-functions: move function to lib-bitmap.sh
 + test libs: rename gitweb-lib.sh to lib-gitweb.sh
 + test libs: rename bundle helper to "lib-bundle.sh"
 + test-lib-functions: remove generate_zero_bytes() wrapper
 + test-lib-functions: move test_set_index_version() to its user
 + test lib: change "error" to "BUG" as appropriate
 + test-lib: remove check_var_migration
 (this branch is used by ab/pickaxe-pcre2.)

 Test framework clean-up.


* ah/commit-graph-leakplug (2021-02-22) 1 commit
  (merged to 'next' on 2021-02-22 at 1330b452db)
 + commit-graph: avoid leaking topo_levels slab in write_commit_graph()

 Plug a minor memory leak.


* ah/rebase-no-fork-point-config (2021-02-24) 1 commit
  (merged to 'next' on 2021-02-24 at 8e56891909)
 + rebase: add a config option for --no-fork-point

 "git rebase --[no-]fork-point" gained a configuration variable
 rebase.forkPoint so that users do not have to keep specifying a
 non-default setting.


* bc/signed-objects-with-both-hashes (2021-02-10) 6 commits
  (merged to 'next' on 2021-02-11 at 391cc85104)
 + gpg-interface: remove other signature headers before verifying
 + ref-filter: hoist signature parsing
 + commit: allow parsing arbitrary buffers with headers
 + gpg-interface: improve interface for parsing tags
 + commit: ignore additional signatures when parsing signed commits
 + ref-filter: switch some uses of unsigned long to size_t

 Signed commits and tags now allow verification of objects, whose
 two object names (one in SHA-1, the other in SHA-256) are both
 signed.


* cw/pack-config-doc (2021-02-22) 1 commit
  (merged to 'next' on 2021-02-22 at cfd2f5ccd1)
 + doc: mention bigFileThreshold for packing

 Doc update.


* dl/doc-config-camelcase (2021-02-24) 3 commits
  (merged to 'next' on 2021-02-24 at 5315e84c47)
 + index-format doc: camelCase core.excludesFile
 + blame-options.txt: camelcase blame.blankBoundary
 + i18n.txt: camel case and monospace "i18n.commitEncoding"

 A handful of multi-word configuration variable names in
 documentation that are spelled in all lowercase have been corrected
 to use the more canonical camelCase.


* dl/stash-cleanup (2021-02-11) 7 commits
  (merged to 'next' on 2021-02-11 at ae1cde1380)
 + stash: declare ref_stash as an array
 + t3905: use test_cmp() to check file contents
 + t3905: replace test -s with test_file_not_empty
 + t3905: remove nested git in command substitution
 + t3905: move all commands into test cases
 + t3905: remove spaces after redirect operators
 + git-stash.txt: be explicit about subcommand options
 (this branch is used by dl/stash-show-untracked.)

 Documentation, code and test clean-up around "git stash".
 This is an early part of a topic that added a new feature to the
 command, but the implementation is expected to need a handful of
 iterations; I split the preparatory part up to fast-track it.


* ds/chunked-file-api (2021-02-24) 18 commits
  (merged to 'next' on 2021-02-24 at 6002da063c)
 + commit-graph.c: display correct number of chunks when writing
  (merged to 'next' on 2021-02-22 at 5f0e28cfb2)
 + chunk-format: add technical docs
 + chunk-format: restore duplicate chunk checks
 + midx: use 64-bit multiplication for chunk sizes
 + midx: use chunk-format read API
 + commit-graph: use chunk-format read API
 + chunk-format: create read chunk API
 + midx: use chunk-format API in write_midx_internal()
 + midx: drop chunk progress during write
 + midx: return success/failure in chunk write methods
 + midx: add num_large_offsets to write_midx_context
 + midx: add pack_perm to write_midx_context
 + midx: add entries to write_midx_context
 + midx: use context in write_midx_pack_names()
 + midx: rename pack_info to write_midx_context
 + commit-graph: use chunk-format write API
 + chunk-format: create chunk format write API
 + commit-graph: anonymize data in chunk_write_fn
 (this branch is used by ds/commit-graph-generation-config and tb/reverse-midx.)

 The common code to deal with "chunked file format" that is shared
 by the multi-pack-index and commit-graph files have been factored
 out, to help codepaths for both filetypes to become more robust.


* ds/merge-base-independent (2021-02-22) 5 commits
  (merged to 'next' on 2021-02-24 at 9fad5352ea)
 + commit-reach: stale commits may prune generation further
 + commit-reach: use heuristic in remove_redundant()
 + commit-reach: move compare_commits_by_gen
 + commit-reach: use one walk in remove_redundant()
 + commit-reach: reduce requirements for remove_redundant()

 The code to implement "git merge-base --independent" was poorly
 done and was kept from the very beginning of the feature.


* en/diffcore-rename (2021-02-15) 8 commits
  (merged to 'next' on 2021-02-22 at 243d0182da)
 + merge-ort: call diffcore_rename() directly
 + gitdiffcore doc: mention new preliminary step for rename detection
 + diffcore-rename: guide inexact rename detection based on basenames
 + diffcore-rename: complete find_basename_matches()
 + diffcore-rename: compute basenames of source and dest candidates
 + t4001: add a test comparing basename similarity and content similarity
 + diffcore-rename: filter rename_src list when possible
 + diffcore-rename: no point trying to find a match better than exact

 Performance optimization work on the rename detection continues.


* es/maintenance-of-bare-repositories (2021-02-23) 1 commit
  (merged to 'next' on 2021-02-24 at 73a40e23b3)
 + maintenance: fix incorrect `maintenance.repo` path with bare repository

 The "git maintenance register" command had trouble registering bare
 repositories, which had been corrected.


* hn/reftable-tables-doc-update (2021-02-23) 1 commit
  (merged to 'next' on 2021-02-25 at cfeadb4945)
 + doc/reftable: document how to handle windows

 Documentation update.


* hv/trailer-formatting (2021-02-15) 4 commits
  (merged to 'next' on 2021-02-25 at 7d1d5ecf59)
 + ref-filter: use pretty.c logic for trailers
 + pretty.c: capture invalid trailer argument
 + pretty.c: refactor trailer logic to `format_set_trailers_options()`
 + t6300: use function to test trailer options

 The logic to handle "trailer" related placeholders in the
 "--format=" mechanisms in the "log" family and "for-each-ref"
 family is getting unified.


* jc/diffcore-rotate (2021-02-16) 1 commit
  (merged to 'next' on 2021-02-22 at f17c341d20)
 + diff: --{rotate,skip}-to=<path>
 (this branch is used by zh/difftool-skip-to.)

 "git {diff,log} --{skip,rotate}-to=<path>" allows the user to
 discard diff output for early paths or move them to the end of the
 output.


* jc/maint-column-doc-typofix (2021-02-19) 1 commit
  (merged to 'next' on 2021-02-22 at d927f64824)
 + Documentation: typofix --column description

 Doc update.


* jc/push-delete-nothing (2021-02-23) 1 commit
  (merged to 'next' on 2021-02-24 at 9d5481ea10)
 + push: do not turn --delete '' into a matching push

 "git push $there --delete ''" should have been diagnosed as an
 error, but instead turned into a matching push, which has been
 corrected.


* jh/fsmonitor-prework (2021-02-16) 11 commits
  (merged to 'next' on 2021-02-17 at 1943efb5ac)
 + fsmonitor: refactor initialization of fsmonitor_last_update token
 + fsmonitor: allow all entries for a folder to be invalidated
 + fsmonitor: log FSMN token when reading and writing the index
 + fsmonitor: log invocation of FSMonitor hook to trace2
 + read-cache: log the number of scanned files to trace2
 + read-cache: log the number of lstat calls to trace2
 + preload-index: log the number of lstat calls to trace2
 + p7519: add trace logging during perf test
 + p7519: move watchman cleanup earlier in the test
 + p7519: fix watchman watch-list test on Windows
 + p7519: do not rely on "xargs -d" in test

 Preliminary changes to fsmonitor integration.


* jh/untracked-cache-fix (2021-02-24) 1 commit
  (merged to 'next' on 2021-02-25 at 79d1e40211)
 + dir: fix malloc of root untracked_cache_dir

 An under-allocation for the untracked cache data has been corrected.


* jk/rev-list-disk-usage (2021-02-17) 4 commits
  (merged to 'next' on 2021-02-22 at 37a29a3495)
 + docs/rev-list: add some examples of --disk-usage
 + docs/rev-list: add an examples section
  (merged to 'next' on 2021-02-11 at 6fb701f287)
 + rev-list: add --disk-usage option for calculating disk usage
 + t: add --no-tag option to test_commit
 (this branch is used by ab/pickaxe-pcre2.)

 "git rev-list" command learned "--disk-usage" option.


* js/doc-proto-v2-response-end (2021-02-17) 1 commit
  (merged to 'next' on 2021-02-17 at 9d5d479469)
 + doc: fix naming of response-end-pkt

 Docfix.


* js/params-vs-args (2021-02-23) 1 commit
  (merged to 'next' on 2021-02-24 at 0a1ff0bc16)
 + replace "parameters" by "arguments" in error messages

 Messages update.


* jt/transfer-fsck-across-packs (2021-02-22) 4 commits
  (merged to 'next' on 2021-02-22 at 76f1327431)
 + fetch-pack: print and use dangling .gitmodules
 + fetch-pack: with packfile URIs, use index-pack arg
 + http-fetch: allow custom index-pack args
 + http: allow custom index-pack args

 The approach to "fsck" the incoming objects in "index-pack" is
 attractive for performance reasons (we have them already in core,
 inflated and ready to be inspected), but fundamentally cannot be
 applied fully when we receive more than one pack stream, as a tree
 object in one pack may refer to a blob object in another pack as
 ".gitmodules", when we want to inspect blobs that are used as
 ".gitmodules" file, for example.  Teach "index-pack" to emit
 objects that must be inspected later and check them in the calling
 "fetch-pack" process.


* ma/doc-markup-fix (2021-02-18) 3 commits
  (merged to 'next' on 2021-02-22 at a8e9e712c8)
 + gitmailmap.txt: fix rendering of e-mail addresses
 + git.txt: fix monospace rendering
 + rev-list-options.txt: fix rendering of bonus paragraph

 Docfix.


* mt/add-chmod-fixes (2021-02-24) 3 commits
  (merged to 'next' on 2021-02-24 at 6c0977f3be)
 + add: propagate --chmod errors to exit status
 + add: mark --chmod error string for translation
 + add --chmod: don't update index when --dry-run is used

 Various fixes on "git add --chmod".


* mt/checkout-index-corner-cases (2021-02-16) 2 commits
  (merged to 'next' on 2021-02-17 at 81dad9735b)
 + checkout-index: omit entries with no tempname from --temp output
 + write_entry(): fix misuses of `path` in error messages

 The error codepath around the "--temp/--prefix" feature of "git
 checkout-index" has been improved.


* mt/grep-sparse-checkout (2021-02-09) 1 commit
  (merged to 'next' on 2021-02-24 at 246fc2ad56)
 + grep: honor sparse-checkout on working tree searches

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.


* mz/doc-notes-are-not-anchors (2021-02-10) 1 commit
  (merged to 'next' on 2021-02-17 at 81f92a74b2)
 + docs: clarify that refs/notes/ do not keep the attached objects alive

 Objects that lost references can be pruned away, even when they
 have notes attached to it (and these notes will become dangling,
 which in turn can be pruned with "git notes prune").  This has been
 clarified in the documentation.


* ns/raise-write-index-buffer-size (2021-02-24) 1 commit
  (merged to 'next' on 2021-02-25 at 8f43f67ba7)
 + read-cache: make the index write buffer size 128K

 Raise the buffer size used when writing the index file out from
 (obviously too small) 8kB to (clearly sufficiently large) 128kB.
 We may want to extend this to use a value the platform suggests as
 the best size with a follow-up patch, but this should do for now.


* rs/blame-optim (2021-02-17) 1 commit
  (merged to 'next' on 2021-02-17 at e54665eeb3)
 + blame: remove unnecessary use of get_commit_info()

 Optimization in "git blame"


* sh/mergetools-vimdiff1 (2021-02-23) 1 commit
  (merged to 'next' on 2021-02-24 at dbd4c6684c)
 + mergetools/vimdiff: add vimdiff1 merge tool variant

 Mergetools update.


* sv/t7001-modernize (2021-02-11) 10 commits
  (merged to 'next' on 2021-02-25 at 368861a00d)
 + t7001: use `test` rather than `[`
 + t7001: use here-docs instead of echo
 + t7001: put each command on a separate line
 + t7001: use '>' rather than 'touch'
 + t7001: avoid using `cd` outside of subshells
 + t7001: remove whitespace after redirect operators
 + t7001: modernize subshell formatting
 + t7001: remove unnecessary blank lines
 + t7001: indent with TABs instead of spaces
 + t7001: modernize test formatting

 Test script modernization.


* ta/hash-function-transition-doc (2021-02-05) 6 commits
  (merged to 'next' on 2021-02-12 at f620f3cfd3)
 + doc: use https links
 + doc hash-function-transition: move rationale upwards
 + doc hash-function-transition: fix incomplete sentence
 + doc hash-function-transition: use upper case consistently
 + doc hash-function-transition: use SHA-1 and SHA-256 consistently
 + doc hash-function-transition: fix asciidoc output

 Update formatting and grammar of the hash transition plan
 documentation, plus some updates.


* ug/doc-commit-approxidate (2021-02-23) 1 commit
  (merged to 'next' on 2021-02-24 at 825686380e)
 + doc: mention approxidates for git-commit --date

 Doc update.


* zh/difftool-skip-to (2021-02-22) 1 commit
  (merged to 'next' on 2021-02-22 at eeff734f2b)
 + difftool.c: learn a new way start at specified file
 (this branch uses jc/diffcore-rotate.)

 "git difftool" learned "--skip-to=<path>" option to restart an
 interrupted session from an arbitrary path.

--------------------------------------------------
[New Topics]

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


* en/ort-perf-batch-8 (2021-02-26) 10 commits
 - diffcore-rename: compute dir_rename_guess from dir_rename_counts
 - diffcore-rename: limit dir_rename_counts computation to relevant dirs
 - diffcore-rename: compute dir_rename_counts in stages
 - diffcore-rename: extend cleanup_dir_rename_info()
 - diffcore-rename: move dir_rename_counts into dir_rename_info struct
 - diffcore-rename: add function for clearing dir_rename_count
 - Move computation of dir_rename_count from merge-ort to diffcore-rename
 - diffcore-rename: add a mapping of destination names to their indices
 - diffcore-rename: provide basic implementation of idx_possible_rename()
 - diffcore-rename: use directory rename guided basename comparisons

 Rename detection rework continues.


* jk/open-returns-eintr (2021-03-01) 2 commits
  (merged to 'next' on 2021-03-02 at 7f0218e627)
 + config.mak.uname: enable OPEN_RETURNS_EINTR for macOS Big Sur
 + Makefile: add OPEN_RETURNS_EINTR knob

 Work around platforms whose open() is reported to return EINTR (it
 shouldn't, as we do our signals with SA_RESTART).

 Will cook in 'next'.


* jk/perf-in-worktrees (2021-02-26) 2 commits
  (merged to 'next' on 2021-03-02 at ea298cb298)
 + t/perf: avoid copying worktree files from test repo
 + t/perf: handle worktrees as test repos

 Perf test update to work better in secondary worktrees.

 Will cook in 'next'.


* ps/update-ref-trans-hook-doc (2021-03-01) 2 commits
 - githooks.txt: clarify documentation on reference-transaction hook
 - githooks.txt: replace mentions of SHA-1 specific properties


* tb/pack-revindex-on-disk (2021-02-26) 1 commit
 - pack-revindex.c: don't close unopened file descriptors


* zh/format-patch-fractional-reroll-count (2021-03-01) 1 commit
 - format-patch: allow a non-integral version numbers

--------------------------------------------------
[Stalled]

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


* es/config-hooks-part-1 (2021-02-16) 17 commits
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
 (this branch is used by es/config-hooks.)

 A way to specify hooks in the configuration files is introduced.

 Expecting another reroll??
 cf. <YC7o2rUQOEdiMdqh@google.com>


* dl/stash-show-untracked (2021-02-16) 4 commits
 - SQUASH???
 - SQUASH???
 - stash show: learn stash.showIncludeUntracked
 - stash show: teach --include-untracked and --only-untracked

 "git stash show" learned to optionally show untracked part of the
 stash.

 Expecting a reroll.
 cf. <cover.1613459474.git.liu.denton@gmail.com>


* ab/fsck-api-cleanup (2021-02-18) 10 commits
 - fsck.h: update FSCK_OPTIONS_* for object_name
 - fsck.c: give "FOREACH_MSG_ID" a more specific name
 - fsck.c: undefine temporary STR macro after use
 - fsck.c: call parse_msg_type() early in fsck_set_msg_type()
 - fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
 - fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
 - fsck.c: move definition of msg_id into append_msg_id()
 - fsck.c: rename variables in fsck_set_msg_type() for less confusion
 - fsck.h: use "enum object_type" instead of "int"
 - fsck.h: indent arguments to of fsck_set_msg_type

 Preliminary fsck API clean-up.

 Expecting a reroll.
 cf. <xmqqczwxc8bw.fsf@gitster.g>


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

* ab/make-cleanup (2021-02-23) 6 commits
 - Makefile: build "$(FUZZ_OBJS)" in CI, not under "all"
 - Makefile: add {program,xdiff,test,git,fuzz}-objs & objects targets
 - Makefile: split OBJECTS into OBJECTS and GIT_OBJS
 - Makefile: sort OBJECTS assignment for subsequent change
 - Makefile: split up long OBJECTS line
 - Makefile: guard against TEST_OBJS in the environment

 Reorganize Makefile to allow building git.o and other essential
 objects without extra stuff needed only for testing.

 The last step is of dubious value, but otherwise looked OK.
 cf. <YDVJZnmTiBYZ4iPM@coredump.intra.peff.net>


* ab/grep-pcre2-allocfix (2021-02-17) 10 commits
 - grep/pcre2: move definitions of pcre2_{malloc,free}
 - grep/pcre2: move back to thread-only PCREv2 structures
 - grep/pcre2: actually make pcre2 use custom allocator
 - grep/pcre2: use pcre2_maketables_free() function
 - grep/pcre2: use compile-time PCREv2 version test
 - grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug mode
 - grep/pcre2: prepare to add debugging to pcre2_malloc()
 - grep/pcre2: correct reference to grep_init() in comment
 - grep/pcre2: drop needless assignment to NULL
 - grep/pcre2: drop needless assignment + assert() on opt->pcre2

 Updates to memory allocation code around the use of pcre2 library.

 Needs review.
 cf. <20210218000728.13995-1-avarab@gmail.com>


* tb/reverse-midx (2021-02-24) 16 commits
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

 Needs review.
 cf. <20210216115801.4773-1-avarab@gmail.com>


* cm/rebase-i-fixup-amend-reword (2021-03-01) 6 commits
 - doc/git-commit: add documentation for fixup=[amend|reword] options
 - t3437: use --fixup with options to create amend! commit
 - t7500: add tests for --fixup=[amend|reword] options
 - commit: add a reword suboption to --fixup
 - commit: add amend suboption to --fixup to create amend! commit
 - sequencer: export subject_length()
 (this branch uses cm/rebase-i and cm/rebase-i-updates.)

 "git commit --fixup=<commit>", which was to tweak the changes made
 to the contents while keeping the original log message intact,
 learned "--fixup=(amend|reword):<commit>", that can be used to
 tweak both the message and the contents, and only the message,
 respectively.

 Getting there.
 cf. <20210301084512.27170-1-charvi077@gmail.com>


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


* rs/pretty-describe (2021-03-01) 4 commits
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


* jh/simple-ipc (2021-02-17) 12 commits
  (merged to 'next' on 2021-03-01 at 6604451f18)
 + t0052: add simple-ipc tests and t/helper/test-simple-ipc tool
 + simple-ipc: add Unix domain socket implementation
 + unix-socket: create `unix_stream_server__listen_with_lock()`
 + unix-socket: disallow chdir() when creating unix domain sockets
 + unix-socket: add backlog size option to unix_stream_listen()
 + unix-socket: elimiate static unix_stream_socket() helper function
 + simple-ipc: add win32 implementation
 + simple-ipc: design documentation for new IPC mechanism
 + pkt-line: add options argument to read_packetized_to_strbuf()
 + pkt-line: (optionally) libify the packet readers
 + pkt-line: do not issue flush packets in write_packetized_*()
 + pkt-line: eliminate the need for static buffer in packet_write_gently()

 A simple IPC interface gets introduced to build services like
 fsmonitor on top.

 Will cook in 'next'.


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


* tb/geometric-repack (2021-02-22) 8 commits
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


* es/config-hooks (2021-02-16) 17 commits
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
 (this branch uses es/config-hooks-part-1.)

 The "hooks defined in config" topic.

 Expecting doc updates, but otherwise seems to be progressing nicely.

--------------------------------------------------
[Discarded]

* cw/pack-vs-bigfilethreashold (2021-02-09) 2 commits
 . fixup! doc: mention bigFileThreshold for packing
 . doc: mention bigFileThreshold for packing

 Doc update.

 cw/pack-config-doc supersedes this with a bit more coverage on
 related knobs.
