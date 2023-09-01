Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588A9CA0FE8
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 23:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbjIAXWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 19:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjIAXWa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 19:22:30 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66862E72
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 16:22:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E567A270DC;
        Fri,  1 Sep 2023 19:22:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=Q
        lrA2SfxgdtmFD4s7KzhBYw9Xio4HsGpMObF7muTKGk=; b=cGuhfmg7ujZGgtApI
        dR2JP8WGHOPoOS6+fFtjaUn/NFNPVXg9O0mC870sJXAkyGDDjiU3yy9oWlHL1eXM
        KDmJ8oliJUbaOgp9G70TUNBXRQ8wKgqoKjLizYTqWjU3TJbZJXM/cA8eYrrhIyZv
        2ckWoQ7vc7AtvlBmici9Mfekso=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD831270DB;
        Fri,  1 Sep 2023 19:22:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7D3D9270DA;
        Fri,  1 Sep 2023 19:22:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2023, #01; Fri, 1)
X-master-at: d814540bb75bbd2257f9a6bf59661a84fe8cf3cf
X-next-at: 54e51ff1ac8d5254ec31bb709a94c598aa7cdeda
Date:   Fri, 01 Sep 2023 16:22:19 -0700
Message-ID: <xmqqttsdo4wk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6610ADD4-491E-11EE-AA92-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

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

* ch/t6300-verify-commit-test-cleanup (2023-08-23) 2 commits
  (merged to 'next' on 2023-08-24 at 15b842867e)
 + t/t6300: drop magic filtering
 + t/lib-gpg: forcibly run a trustdb update

 Test clean-up.
 source: <20230822150149.541ccb35@leda.eworm.net>


* ds/scalar-updates (2023-08-28) 3 commits
  (merged to 'next' on 2023-08-28 at 093e6bcb9c)
 + scalar reconfigure: help users remove buggy repos
 + setup: add discover_git_directory_reason()
 + scalar: add --[no-]src option

 Scalar updates.
 source: <pull.1569.v3.git.1693230746.gitgitgadget@gmail.com>


* jc/ci-skip-same-commit (2023-08-25) 1 commit
  (merged to 'next' on 2023-08-28 at e978717961)
 + ci: avoid building from the same commit in parallel

 Tweak GitHub Actions CI so that pushing the same commit to multiple
 branch tips at the same time will not waste building and testing
 the same thing twice.
 source: <1da763f3-60bf-a572-2c71-336b1fa5553d@gmx.de>


* jc/diff-exit-code-with-w-fixes (2023-08-21) 5 commits
  (merged to 'next' on 2023-08-23 at 436a0aec3d)
 + diff: the -w option breaks --exit-code for --raw and other output modes
 + t4040: remove test that succeeded for a wrong reason
 + diff: teach "--stat -w --exit-code" to notice differences
 + diff: mode-only change should be noticed by "--patch -w --exit-code"
 + diff: move the fallback "--exit-code" code down

 "git diff -w --exit-code" with various options did not work
 correctly, which is being addressed.
 source: <20230818235932.3253552-1-gitster@pobox.com>


* jc/mv-d-to-d-error-message-fix (2023-08-11) 1 commit
  (merged to 'next' on 2023-08-21 at 2220d22d6f)
 + mv: fix error for moving directory to another

 Typofix in an error message.
 source: <xmqqjzu1njt0.fsf@gitster.g>


* jk/diff-result-code-cleanup (2023-08-21) 7 commits
  (merged to 'next' on 2023-08-25 at 3b1280d42f)
 + diff: drop useless "status" parameter from diff_result_code()
 + diff: drop useless return values in git-diff helpers
 + diff: drop useless return from run_diff_{files,index} functions
 + diff: die when failing to read index in git-diff builtin
 + diff: show usage for unknown builtin_diff_files() options
 + diff-files: avoid negative exit value
 + diff: spell DIFF_INDEX_CACHED out when calling run_diff_index()

 "git diff --no-such-option" and other corner cases around the exit
 status of the "diff" command has been corrected.
 source: <20230821201358.GA2663749@coredump.intra.peff.net>


* ob/format-patch-description-file (2023-08-21) 1 commit
  (merged to 'next' on 2023-08-25 at 89ea619311)
 + format-patch: add --description-file option

 "git format-patch" learns a way to feed cover letter description,
 that (1) can be used on detached HEAD where there is no branch
 description available, and (2) also can override the branch
 description if there is one.
 source: <20230821170720.577820-1-oswald.buddenhagen@gmx.de>


* ob/sequencer-empty-hint-fix (2023-08-24) 1 commit
  (merged to 'next' on 2023-08-24 at 626c52ad72)
 + sequencer: rectify empty hint in call of require_clean_work_tree()

 The use of API between two calls to require_clean_work_tree() from
 the sequencer code has been cleaned up for consistency.
 source: <20230824150046.802008-1-oswald.buddenhagen@gmx.de>


* py/git-gui-updates (2023-08-24) 16 commits
  (merged to 'next' on 2023-08-28 at df0b742344)
 + Merge https://github.com/prati0100/git-gui
 + Merge branch 'ml/cygwin-fixes'
 + git-gui - use mkshortcut on Cygwin
 + git-gui - use cygstart to browse on Cygwin
 + git-gui - remove obsolete Cygwin specific code
 + git gui Makefile - remove Cygwin modifications
 + Merge branch 'ab/makeflags'
 + Makefiles: change search through $(MAKEFLAGS) for GNU make 4.4
 + Merge branch 'js/windows-rce'
 + Work around Tcl's default `PATH` lookup
 + Move the `_which` function (almost) to the top
 + Move is_<platform> functions to the beginning
 + is_Cygwin: avoid `exec`ing anything
 + windows: ignore empty `PATH` elements
 + Merge branch 'vk/readme-typo'
 + git-gui: Fix a typo in README

 Git GUI updates.


* sl/sparse-check-attr (2023-08-11) 3 commits
  (merged to 'next' on 2023-08-21 at c202b15517)
 + check-attr: integrate with sparse-index
 + attr.c: read attributes in a sparse directory
 + t1092: add tests for 'git check-attr'

 Teach "git check-attr" work better with sparse-index.
 cf. <3b2a5b4b-ab8f-746b-6b69-8e8262b6390b@github.com>
 source: <20230811142211.4547-1-cheskaqiqi@gmail.com>


* tb/commit-graph-verify-fix (2023-08-21) 4 commits
  (merged to 'next' on 2023-08-23 at 2b4b74bb0d)
 + commit-graph: avoid repeated mixed generation number warnings
 + t/t5318-commit-graph.sh: test generation zero transitions during fsck
 + commit-graph: verify swapped zero/non-zero generation cases
 + commit-graph: introduce `commit_graph_generation_from_graph()`

 The commit-graph verification code that detects mixture of zero and
 non-zero generation numbers has been updated.
 source: <cover.1692653671.git.me@ttaylorr.com>


* ts/unpacklimit-config-fix (2023-08-22) 1 commit
  (merged to 'next' on 2023-08-23 at 4fabd9a697)
 + transfer.unpackLimit: fetch/receive.unpackLimit takes precedence

 transfer.unpackLimit ought to be used as a fallback, but overrode
 fetch.unpackLimit and receive.unpackLimit instead.
 source: <xmqqpm3eh7f6.fsf@gitster.g>

--------------------------------------------------
[New Topics]

* dd/format-patch-rfc-updates (2023-08-31) 1 commit
  (merged to 'next' on 2023-09-01 at ad87c89ee3)
 + format-patch: --rfc honors what --subject-prefix sets

 "git format-patch --rfc --subject-prefix=<foo>" used to ignore the
 "--subject-prefix" option and used "[RFC PATCH]"; now we will add
 "RFC" prefix to whatever subject prefix is specified.

 This is a backward compatible change that may deserve a note.

 Will merge to 'master'.
 source: <20230830064646.30904-1-sir@cmpwn.com>


* jk/test-lsan-denoise-output (2023-08-28) 1 commit
  (merged to 'next' on 2023-08-29 at 9642d76264)
 + test-lib: ignore uninteresting LSan output

 Tests with LSan from time to time seem to emit harmless message
 that makes our tests unnecessarily flakey; we work it around by
 filtering the uninteresting output.

 Will merge to 'master'.
 source: <20230828183735.GA3015072@coredump.intra.peff.net>


* jk/unused-post-2.42 (2023-08-29) 22 commits
  (merged to 'next' on 2023-08-30 at ab0538e754)
 + update-ref: mark unused parameter in parser callbacks
 + gc: mark unused descriptors in scheduler callbacks
 + bundle-uri: mark unused parameters in callbacks
 + fetch: mark unused parameter in ref_transaction callback
 + credential: mark unused parameter in urlmatch callback
 + grep: mark unused parmaeters in pcre fallbacks
 + imap-send: mark unused parameters with NO_OPENSSL
 + worktree: mark unused parameters in noop repair callback
 + negotiator/noop: mark unused callback parameters
 + add-interactive: mark unused callback parameters
 + grep: mark unused parameter in output function
 + test-trace2: mark unused argv/argc parameters
 + trace2: mark unused config callback parameter
 + trace2: mark unused us_elapsed_absolute parameters
 + stash: mark unused parameter in diff callback
 + ls-tree: mark unused parameter in callback
 + commit-graph: mark unused data parameters in generation callbacks
 + worktree: mark unused parameters in each_ref_fn callback
 + pack-bitmap: mark unused parameters in show_object callback
 + ref-filter: mark unused parameters in parser callbacks
 + sequencer: mark repository argument as unused
 + sequencer: use repository parameter in short_commit_name()

 Unused parameters to functions are marked as such, and/or removed,
 in order to bring us closer to -Wunused-parameter clean.

 Will merge to 'master'.
 source: <20230829234305.GA226944@coredump.intra.peff.net>


* js/ci-san-skip-p4-and-svn-tests (2023-08-29) 1 commit
  (merged to 'next' on 2023-08-29 at 9617f99668)
 + ci(linux-asan-ubsan): let's save some time

 Flakey "git p4" tests, as well as "git svn" tests, are now skipped
 in the (rather expensive) sanitizer CI job.

 Will merge to 'master'.
 source: <pull.1578.v2.git.1693342048633.gitgitgadget@gmail.com>


* tb/multi-cruft-pack (2023-08-29) 4 commits
  (merged to 'next' on 2023-08-30 at 15f0b56ed0)
 + Documentation/gitformat-pack.txt: drop mixed version section
 + Documentation/gitformat-pack.txt: remove multi-cruft packs alternative
 + builtin/pack-objects.c: support `--max-pack-size` with `--cruft`
 + builtin/pack-objects.c: remove unnecessary strbuf_reset()

 Use of --max-pack-size to allow multiple packfiles to be created is
 now supported even when we are sending unreachable objects to cruft
 packs.

 Will merge to 'master'.
 source: <cover.1693262936.git.me@ttaylorr.com>


* jk/ci-retire-allow-ref (2023-08-30) 2 commits
  (merged to 'next' on 2023-08-31 at 5fe4861f16)
 + ci: deprecate ci/config/allow-ref script
 + ci: allow branch selection through "vars"

 CI update.

 Will merge to 'master'.
 source: <20230830194919.GA1709446@coredump.intra.peff.net>


* ws/git-svn-retire-faketerm (2023-08-30) 1 commit
  (merged to 'next' on 2023-08-31 at cb6e0d658d)
 + git-svn: drop FakeTerm hack

 Code clean-up.

 Will merge to 'master'.
 source: <xmqqa5u888lz.fsf_-_@gitster.g>


* jk/unused-post-2.42-part2 (2023-08-31) 10 commits
 - parse-options: mark unused parameters in noop callback
 - interpret-trailers: mark unused "unset" parameters in option callbacks
 - parse-options: add more BUG_ON() annotations
 - merge: do not pass unused opt->value parameter
 - parse-options: mark unused "opt" parameter in callbacks
 - parse-options: prefer opt->value to globals in callbacks
 - checkout-index: delay automatic setting of to_tempfile
 - format-patch: use OPT_STRING_LIST for to/cc options
 - merge: simplify parsing of "-n" option
 - merge: make xopts a strvec

 Unused parameters to functions are marked as such, and/or removed,
 in order to bring us closer to -Wunused-parameter clean.

 Will merge to 'next'?
 source: <20230831211637.GA949188@coredump.intra.peff.net>


* jk/tree-name-and-depth-limit (2023-08-31) 10 commits
 - lower core.maxTreeDepth default to 2048
 - tree-diff: respect max_allowed_tree_depth
 - list-objects: respect max_allowed_tree_depth
 - read_tree(): respect max_allowed_tree_depth
 - traverse_trees(): respect max_allowed_tree_depth
 - add core.maxTreeDepth config
 - fsck: detect very large tree pathnames
 - tree-walk: rename "error" variable
 - tree-walk: drop MAX_TRAVERSE_TREES macro
 - tree-walk: reduce stack size for recursive functions

 We now limit depth of the tree objects and maximum length of
 pathnames recorded in tree objects.
 source: <20230831061735.GA2702156@coredump.intra.peff.net>


* js/doc-unit-tests-with-cmake (2023-08-31) 4 commits
 - artifacts-tar: when including `.dll` files, don't forget the unit-tests
 - unit-tests: do show relative file paths
 - unit-tests: do not mistake `.pdb` files for being executable
 - cmake: also build unit tests
 (this branch uses js/doc-unit-tests.)

 Update the base topic to work with CMake builds.
 source: <pull.1579.git.1693462532.gitgitgadget@gmail.com>


* ew/hash-with-openssl-evp (2023-08-31) 1 commit
 - treewide: fix various bugs w/ OpenSSL 3+ EVP API

 Fix-up new-ish code to support OpenSSL EVP API.

 Will merge to 'next'?
 source: <20230901020928.M610756@dcvr>

--------------------------------------------------
[Stalled]

* js/doc-unit-tests (2023-08-17) 3 commits
 - ci: run unit tests in CI
 - unit tests: add TAP unit test framework
 - unit tests: Add a project plan document
 (this branch is used by js/doc-unit-tests-with-cmake.)

 Process to add some form of low-level unit tests has started.

 Comments?
 source: <cover.1692297001.git.steadmon@google.com>


* ak/pretty-decorate-more (2023-08-21) 8 commits
 - decorate: use commit color for HEAD arrow
 - pretty: add pointer and tag options to %(decorate)
 - pretty: add %(decorate[:<options>]) format
 - decorate: color each token separately
 - decorate: avoid some unnecessary color overhead
 - decorate: refactor format_decorations()
 - pretty-formats: enclose options in angle brackets
 - pretty-formats: define "literal formatting code"

 "git log --format" has been taught the %(decorate) placeholder.

 What's the status of this thing?
 source: <20230820185009.20095-1-andy.koppe@gmail.com>


* cc/repack-sift-filtered-objects-to-separate-pack (2023-08-13) 8 commits
 . gc: add `gc.repackFilterTo` config option
 . repack: implement `--filter-to` for storing filtered out objects
 . gc: add `gc.repackFilter` config option
 . repack: add `--filter=<filter-spec>` option
 . repack: refactor finding pack prefix
 . repack: refactor finishing pack-objects command
 . t/helper: add 'find-pack' test-tool
 . pack-objects: allow `--filter` without `--stdout`

 "git repack" machinery learns to pay attention to the "--filter="
 option.

 Kicked out of the 'seen', as it still seems to be failing tests.
 cf. https://github.com/git/git/actions/runs/5850998716/job/15861158252#step:4:1822
 source: <20230812000011.1227371-1-christian.couder@gmail.com>


* cc/git-replay (2023-06-03) 15 commits
 - replay: stop assuming replayed branches do not diverge
 - replay: add --contained to rebase contained branches
 - replay: add --advance or 'cherry-pick' mode
 - replay: disallow revision specific options and pathspecs
 - replay: use standard revision ranges
 - replay: make it a minimal server side command
 - replay: remove HEAD related sanity check
 - replay: remove progress and info output
 - replay: add an important FIXME comment about gpg signing
 - replay: don't simplify history
 - replay: introduce pick_regular_commit()
 - replay: die() instead of failing assert()
 - replay: start using parse_options API
 - replay: introduce new builtin
 - t6429: remove switching aspects of fast-rebase

 No reviews?
 source: <20230602102533.876905-1-christian.couder@gmail.com>


* tk/cherry-pick-sequence-requires-clean-worktree (2023-06-01) 1 commit
 - cherry-pick: refuse cherry-pick sequence if index is dirty

 "git cherry-pick A" that replays a single commit stopped before
 clobbering local modification, but "git cherry-pick A..B" did not,
 which has been corrected.

 Expecting a reroll.
 cf. <999f12b2-38d6-f446-e763-4985116ad37d@gmail.com>
 source: <pull.1535.v2.git.1685264889088.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* rs/parse-options-help-text-is-optional (2023-08-28) 1 commit
  (merged to 'next' on 2023-08-29 at 5466f7fcb2)
 + parse-options: allow omitting option help text

 It may be tempting to leave the help text NULL for a command line
 option that is either hidden or too obvious, but "git subcmd -h"
 and "git subcmd --help-all" would have segfaulted if done so.  Now
 the help text is optional.

 Will merge to 'master'.
 source: <2b08dc43-621d-2170-c4a6-c2aac33a9a19@web.de>


* tb/path-filter-fix (2023-08-30) 15 commits
 - bloom: introduce `deinit_bloom_filters()`
 - commit-graph: reuse existing Bloom filters where possible
 - object.h: fix mis-aligned flag bits table
 - commit-graph: drop unnecessary `graph_read_bloom_data_context`
 - commit-graph.c: unconditionally load Bloom filters
 - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
 - bloom: prepare to discard incompatible Bloom filters
 - bloom: annotate filters with hash version
 - commit-graph: new filter ver. that fixes murmur3
 - repo-settings: introduce commitgraph.changedPathsVersion
 - t4216: test changed path filters with high bit paths
 - t/helper/test-read-graph: implement `bloom-filters` mode
 - bloom.h: make `load_bloom_filter_from_graph()` public
 - t/helper/test-read-graph.c: extract `dump_graph_info()`
 - gitformat-commit-graph: describe version 2 of BDAT

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Needs more work?
 cf. <20230830200218.GA5147@szeder.dev>
 source: <cover.1693413637.git.jonathantanmy@google.com>


* js/config-parse (2023-08-23) 4 commits
 - config-parse: split library out of config.[c|h]
 - config.c: accept config_parse_options in git_config_from_stdin
 - config: report config parse errors using cb
 - config: split out config_parse_options

 The parsing routines for the configuration files have been split
 into a separate file.

 Needs review.
 source: <cover.1692827403.git.steadmon@google.com>


* tb/mark-more-tests-as-leak-free (2023-08-29) 3 commits
  (merged to 'next' on 2023-08-29 at c1db288281)
 + leak tests: mark t5583-push-branches.sh as leak-free
 + leak tests: mark t3321-notes-stripspace.sh as leak-free
 + leak tests: mark a handful of tests as leak-free

 Tests that are known to pass with LSan are now marked as such.

 Will merge to 'master'.
 source: <cover.1693263171.git.me@ttaylorr.com>


* jc/update-index-show-index-version (2023-08-18) 3 commits
 - test-tool: retire "index-version"
 - update-index: add --show-index-version
 - update-index doc: v4 is OK with JGit and libgit2

 "git update-index" learns "--show-index-version" to inspect
 the index format version used by the on-disk index file.

 Needs review.
 source: <20230818233729.2766281-1-gitster@pobox.com>


* ob/revert-of-revert-is-reapply (2023-08-21) 2 commits
 - git-revert.txt: add discussion
 - sequencer: beautify subject of reverts of reverts

 The default log message created by "git revert", when reverting a
 commit that records a revert, has been tweaked.

 Expecting a (hopefully small and final) reroll.
 cf. <ZOZnNDd2pMX6M2Au@nand.local>
 source: <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>


* la/trailer-cleanups (2023-08-06) 5 commits
 - trailer: rename *_DEFAULT enums to *_UNSPECIFIED
 - trailer: teach find_patch_start about --no-divider
 - trailer: split process_command_line_args into separate functions
 - trailer: split process_input_file into separate pieces
 - trailer: separate public from internal portion of trailer_iterator

 Code clean-up.

 Expecting a reroll.
 cf. <owlyy1iifq0n.fsf@fine.c.googlers.com>
 source: <pull.1563.git.1691211879.gitgitgadget@gmail.com>


* la/trailer-test-and-doc-updates (2023-08-10) 14 commits
 - SQUASH???
 - trailer doc: <token> is a <key> or <keyAlias>, not both
 - trailer doc: separator within key suppresses default separator
 - trailer doc: emphasize the effect of configuration variables
 - trailer --unfold help: prefer "reformat" over "join"
 - trailer --parse docs: add explanation for its usefulness
 - trailer --only-input: prefer "configuration variables" over "rules"
 - trailer --parse help: expose aliased options
 - trailer --no-divider help: describe usual "---" meaning
 - trailer: trailer location is a place, not an action
 - trailer doc: narrow down scope of --where and related flags
 - trailer: add tests to check defaulting behavior with --no-* flags
 - trailer test description: this tests --where=after, not --where=before
 - trailer tests: make test cases self-contained

 Test coverage for trailers has been improved.

 Expecting a reroll.
 cf. <owlyh6p5fpi7.fsf@fine.c.googlers.com>
 source: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function
 (this branch uses jc/unresolve-removal.)

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230731224409.4181277-1-gitster@pobox.com>


* pw/rebase-i-after-failure (2023-08-01) 7 commits
 - rebase -i: fix adding failed command to the todo list
 - rebase --continue: refuse to commit after failed command
 - rebase: fix rewritten list for failed pick
 - sequencer: factor out part of pick_commits()
 - sequencer: use rebase_path_message()
 - rebase -i: remove patch file after conflict resolution
 - rebase -i: move unlink() calls

 Various fixes to the behaviour of "rebase -i" when the command got
 interrupted by conflicting changes.

 Expecting a reroll.
 The latter half of the series should be reviewed by those who have
 more stake in the sequencer code than myself.
 cf. <619e458b-218b-a790-dfb4-9200e201b513@gmail.com>
 source: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>


* jc/unresolve-removal (2023-07-31) 7 commits
 - checkout: allow "checkout -m path" to unmerge removed paths
 - checkout/restore: add basic tests for --merge
 - checkout/restore: refuse unmerging paths unless checking out of the index
 - update-index: remove stale fallback code for "--unresolve"
 - update-index: use unmerge_index_entry() to support removal
 - resolve-undo: allow resurrecting conflicted state that resolved to deletion
 - update-index: do not read HEAD and MERGE_HEAD unconditionally
 (this branch is used by jc/rerere-cleanup.)

 "checkout --merge -- path" and "update-index --unresolve path" did
 not resurrect conflicted state that was resolved to remove path,
 but now they do.

 Needs review.
 source: <20230731224409.4181277-1-gitster@pobox.com>


* rj/status-bisect-while-rebase (2023-08-01) 1 commit
 - status: fix branch shown when not only bisecting

 "git status" is taught to show both the branch being bisected and
 being rebased when both are in effect at the same time.

 Needs review.
 cf. <xmqqtttia3vn.fsf@gitster.g>
 source: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>

--------------------------------------------------
[Discarded]

* jt/path-filter-fix (2023-08-08) 8 commits
  (merged to 'next' on 2023-08-09 at 59952b9ec9)
 + commit-graph: fix small leak with invalid changedPathsVersion
  (merged to 'next' on 2023-08-03 at d99958c287)
 + commit-graph: new filter ver. that fixes murmur3
 + repo-settings: introduce commitgraph.changedPathsVersion
 + t4216: test changed path filters with high bit paths
 + t/helper/test-read-graph: implement `bloom-filters` mode
 + bloom.h: make `load_bloom_filter_from_graph()` public
 + t/helper/test-read-graph.c: extract `dump_graph_info()`
 + gitformat-commit-graph: describe version 2 of BDAT

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Reverted out of 'next', superseded by the tb/path-filter-fix topic.
 cf. <ZMqp6K2iXixWH/zT@nand.local>
 source: <cover.1690912539.git.jonathantanmy@google.com>
 source: <20230808192240.GA4091261@coredump.intra.peff.net>


* ab/tag-object-type-errors (2023-05-10) 4 commits
 . tag: don't emit potentially incorrect "object is a X, not a Y"
 . tag: don't misreport type of tagged objects in errors
 . object tests: add test for unexpected objects in tags
 . Merge branch 'jk/parse-object-type-mismatch' into ab/tag-object-type-errors

 Hardening checks around mismatched object types when one of those
 objects is a tag.

 Stalled for too long.
 source: <cover-v2-0.3-00000000000-20221230T011725Z-avarab@gmail.com>


* ob/send-email-interactive-failure (2023-08-29) 2 commits
 . SQUASH???
 . send-email: prompt-dependent exit codes

 "git send-email" exits with non-zero status when end-user
 interaction causes any prepared message not to be sent.

 Breaks existing users without even an opt-out knob.
 source: <20230821170720.577835-1-oswald.buddenhagen@gmx.de>


* ws/svn-with-new-readline (2023-08-11) 1 commit
 . git-svn: avoid creating more than one than one Term::ReadLine object

 Adjust to newer Term::ReadLine to prevent it from breaking
 the interactive prompt code in git-svn.

 Superseded by ws/git-svn-retire-faketerm
 source: <20230810011831.1423208-1-wesleys@opperschaap.net>
