Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92B9E92FFD
	for <git@archiver.kernel.org>; Sat,  7 Oct 2023 08:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjJGIUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Oct 2023 04:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjJGIUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2023 04:20:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC84DA6
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 01:20:05 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 155EA1BCB83;
        Sat,  7 Oct 2023 04:20:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=H
        uGEcDtI/gYtnRzhcJXbHqX05S/ChN1QE/WFkDqL+SY=; b=QnYoaccdu3kI8TB/g
        cKQRg+OEz2Jb6LKH7F/OaQZNxZLglt8ULQbsqRgan1BwyC9aoRWUG6wx+iFrbndo
        TOaLXzl6jjntfn1v1XIs+6E99RaszbVIXmKD2gtpiJyzzpVCFqd5cCZUMEZQI9Jd
        hKXTEEhxuMxEcCnmgc0/qIH8gE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBD3D1BCB81;
        Sat,  7 Oct 2023 04:20:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC4831BCB80;
        Sat,  7 Oct 2023 04:20:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2023, #03; Fri, 6)
X-master-at: 3a06386e314565108ad56a9bdb8f7b80ac52fb69
X-next-at: 5fc05c94dcc1fa9e0ac97428e887ec52d78ec652
Date:   Sat, 07 Oct 2023 01:20:02 -0700
Message-ID: <xmqqh6n24zf1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50F7D020-64EA-11EE-83E5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
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
[New Topics]

* jc/merge-ort-attr-index-fix (2023-10-05) 1 commit
 - merge-ort: initialize repo in index state

 Fix "git merge-tree" to stop segfaulting when the --attr-source
 option is used.

 Waiting for review response.
 source: <pull.1583.git.git.1696519349407.gitgitgadget@gmail.com>


* jk/decoration-and-other-leak-fixes (2023-10-05) 3 commits
  (merged to 'next' on 2023-10-06 at 5fc05c94dc)
 + daemon: free listen_addr before returning
 + revision: clear decoration structs during release_revisions()
 + decorate: add clear_decoration() function

 Leakfix.

 Will merge to 'master'.
 source: <20231005212802.GA982892@coredump.intra.peff.net>


* sn/typo-grammo-phraso-fixes (2023-10-05) 5 commits
 - t/README: fix multi-prerequisite example
 - doc/gitk: s/sticked/stuck/
 - git-jump: admit to passing merge mode args to ls-files
 - doc/diff-options: improve wording of the log.diffMerges mention
 - doc: fix some typos, grammar and wording issues

 Many typos, ungrammatical sentences and wrong phrasing have been
 fixed.

 Needs review.
 source: <20231003082107.3002173-1-stepnem@smrk.net>


* so/diff-merges-dd (2023-10-05) 3 commits
 - completion: complete '--dd'
 - diff-merges: introduce '--dd' option
 - diff-merges: improve --diff-merges documentation

 "git log" and friends learned "--dd" that is a short-hand for
 "--diff-merges=first-parent -p".

 Expecting a reroll.
 cf. <871qe7r3rk.fsf@osv.gnss.ru>
 source: <20231004214558.210339-1-sorganov@gmail.com>


* vd/loose-ref-iteration-optimization (2023-10-06) 4 commits
 - files-backend.c: avoid stat in 'loose_fill_ref_dir'
 - dir.[ch]: add 'follow_symlink' arg to 'get_dtype'
 - dir.[ch]: expose 'get_dtype'
 - ref-cache.c: fix prefix matching in ref iteration

 The code to iterate over loose references have been optimized to
 reduce the number of lstat() system calls.
 source: <pull.1594.git.1696615769.gitgitgadget@gmail.com>


* jc/update-list-references-to-lore (2023-10-06) 1 commit
 - doc: update list archive reference to use lore.kernel.org

 source: <xmqq7cnz741s.fsf@gitster.g>

--------------------------------------------------
[Stalled]

* cc/git-replay (2023-09-07) 15 commits
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

 Waiting for review response.
 cf. <52277471-4ddd-b2e0-62ca-c2a5b59ae418@gmx.de>
 cf. <58daa706-7efb-51dd-9061-202ef650b96a@gmx.de>
 cf. <f0e75d47-c277-9fbb-7bcd-53e4e5686f3c@gmx.de>
 source: <20230907092521.733746-1-christian.couder@gmail.com>


* pw/rebase-sigint (2023-09-07) 1 commit
 - rebase -i: ignore signals when forking subprocesses

 If the commit log editor or other external programs (spawned via
 "exec" insn in the todo list) receive internactive signal during
 "git rebase -i", it caused not just the spawned program but the
 "Git" process that spawned them, which is often not what the end
 user intended.  "git" learned to ignore SIGINT and SIGQUIT while
 waiting for these subprocesses.

 Expecting a reroll.
 cf. <12c956ea-330d-4441-937f-7885ab519e26@gmail.com>
 source: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>


* tk/cherry-pick-sequence-requires-clean-worktree (2023-06-01) 1 commit
 - cherry-pick: refuse cherry-pick sequence if index is dirty

 "git cherry-pick A" that replays a single commit stopped before
 clobbering local modification, but "git cherry-pick A..B" did not,
 which has been corrected.

 Expecting a reroll.
 cf. <999f12b2-38d6-f446-e763-4985116ad37d@gmail.com>
 source: <pull.1535.v2.git.1685264889088.gitgitgadget@gmail.com>


* jc/diff-cached-fsmonitor-fix (2023-09-15) 3 commits
 - diff-lib: fix check_removed() when fsmonitor is active
 - Merge branch 'jc/fake-lstat' into jc/diff-cached-fsmonitor-fix
 - Merge branch 'js/diff-cached-fsmonitor-fix' into jc/diff-cached-fsmonitor-fix
 (this branch uses jc/fake-lstat.)

 The optimization based on fsmonitor in the "diff --cached"
 codepath is resurrected with the "fake-lstat" introduced earlier.

 It is unknown if the optimization is worth resurrecting, but in case...
 source: <xmqqr0n0h0tw.fsf@gitster.g>

--------------------------------------------------
[Cooking]

* jk/commit-graph-leak-fixes (2023-10-03) 10 commits
  (merged to 'next' on 2023-10-06 at 5d202ef8b9)
 + commit-graph: clear oidset after finishing write
 + commit-graph: free write-context base_graph_name during cleanup
 + commit-graph: free write-context entries before overwriting
 + commit-graph: free graph struct that was not added to chain
 + commit-graph: delay base_graph assignment in add_graph_to_chain()
 + commit-graph: free all elements of graph chain
 + commit-graph: move slab-clearing to close_commit_graph()
 + merge: free result of repo_get_merge_bases()
 + commit-reach: free temporary list in get_octopus_merge_bases()
 + t6700: mark test as leak-free

 Leakfix.

 Will merge to 'master'.
 source: <20231003202504.GA7697@coredump.intra.peff.net>


* jm/git-status-submodule-states-docfix (2023-10-04) 1 commit
  (merged to 'next' on 2023-10-04 at 520b7711a4)
 + git-status.txt: fix minor asciidoc format issue

 Docfix.

 Will merge to 'master'.
 source: <pull.1591.v3.git.1696386165616.gitgitgadget@gmail.com>


* rs/parse-opt-ctx-cleanup (2023-10-03) 1 commit
  (merged to 'next' on 2023-10-04 at d5d0a2ce3b)
 + parse-options: drop unused parse_opt_ctx_t member

 Code clean-up.

 Will merge to 'master'.
 source: <ebcaa9e1-d306-4c93-adec-3f35d7040531@web.de>


* tb/repack-max-cruft-size (2023-10-05) 4 commits
  (merged to 'next' on 2023-10-06 at b3ca6df3b9)
 + builtin/repack.c: avoid making cruft packs preferred
 + builtin/repack.c: implement support for `--max-cruft-size`
 + builtin/repack.c: parse `--max-pack-size` with OPT_MAGNITUDE
 + t7700: split cruft-related tests to t7704

 "git repack" learned "--max-cruft-size" to prevent cruft packs from
 growing without bounds.

 Will merge to 'master'.
 source: <cover.1696293862.git.me@ttaylorr.com>
 source: <035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com>


* ak/color-decorate-symbols (2023-10-03) 1 commit
 - decorate: add color.decorate.symbols config option

 A new config for coloring.

 Needs review.
 source: <20231003205442.22963-1-andy.koppe@gmail.com>


* jc/attr-tree-config (2023-10-04) 2 commits
 - attr: add attr.allowInvalidSource config to allow invalid revision
 - attr: add attr.tree for setting the treeish to read attributes from

 The attribute subsystem learned to honor `attr.tree` configuration
 that specifies which tree to read the .gitattributes files from.

 Needs review.
 source: <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>


* js/submodule-fix-misuse-of-path-and-name (2023-10-03) 6 commits
  (merged to 'next' on 2023-10-06 at 1054b6e752)
 + t7420: test that we correctly handle renamed submodules
 + t7419: test that we correctly handle renamed submodules
 + t7419, t7420: use test_cmp_config instead of grepping .gitmodules
 + t7419: actually test the branch switching
 + submodule--helper: return error from set-url when modifying failed
 + submodule--helper: use submodule_from_path in set-{url,branch}

 In .gitmodules files, submodules are keyed by their names, and the
 path to the submodule whose name is $name is specified by the
 submodule.$name.path variable.  There were a few codepaths that
 mixed the name and path up when consulting the submodule database,
 which have been corrected.  It took long for these bugs to be found
 as the name of a submodule initially is the same as its path, and
 the problem does not surface until it is moved to a different path,
 which apparently happens very rarely.

 Will merge to 'master'.
 source: <0a0a157f88321d25fdb0be771a454b3410a449f3.camel@archlinux.org>


* cw/prelim-cleanup (2023-09-29) 4 commits
  (merged to 'next' on 2023-10-03 at 5985929612)
 + parse: separate out parsing functions from config.h
 + config: correct bad boolean env value error message
 + wrapper: reduce scope of remove_or_warn()
 + hex-ll: separate out non-hash-algo functions

 Shuffle some bits across headers and sources to prepare for
 libification effort.

 Will merge to 'master'.
 source: <cover.1696021277.git.jonathantanmy@google.com>


* ds/init-diffstat-width (2023-09-29) 1 commit
  (merged to 'next' on 2023-10-03 at 18383ac895)
 + diff --stat: set the width defaults in a helper function

 Code clean-up.

 Will merge to 'master'.
 source: <d45d1dac1a20699e370905b88b6fd0ec296751e7.1695441501.git.dsimic@manjaro.org>


* ar/diff-index-merge-base-fix (2023-10-02) 1 commit
  (merged to 'next' on 2023-10-06 at 0ff4dfc0e1)
 + diff: fix --merge-base with annotated tags

 "git diff --merge-base X other args..." insisted that X must be a
 commit and errored out when given an annotated tag that peels to a
 commit, but we only need it to be a committish.  This has been
 corrected.

 Will merge to 'master'.
 source: <20231001151845.3621551-1-hi@alyssa.is>


* eb/limit-bulk-checkin-to-blobs (2023-09-26) 1 commit
  (merged to 'next' on 2023-10-02 at 89c9c95966)
 + bulk-checkin: only support blobs in index_bulk_checkin

 The "streaming" interface used for bulk-checkin codepath has been
 narrowed to take only blob objects for now, with no real loss of
 functionality.

 Will merge to 'master'.
 source: <87msx99b9o.fsf_-_@gmail.froward.int.ebiederm.org>


* js/update-urls-in-doc-and-comment (2023-09-26) 4 commits
 - doc: refer to internet archive
 - doc: update links for andre-simon.de
 - doc: update links to current pages
 - doc: switch links to https

 Stale URLs have been updated to their current counterparts (or
 archive.org) and HTTP links are replaced with working HTTPS links.

 Needs review.
 source: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>


* la/trailer-cleanups (2023-09-26) 4 commits
 - trailer: only use trailer_block_* variables if trailers were found
 - trailer: use offsets for trailer_start/trailer_end
 - trailer: find the end of the log message
 - commit: ignore_non_trailer computes number of bytes to ignore

 Code clean-up.

 Needs review.
 source: <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>


* eb/hash-transition (2023-10-02) 30 commits
 - t1016-compatObjectFormat: add tests to verify the conversion between objects
 - t1006: test oid compatibility with cat-file
 - t1006: rename sha1 to oid
 - test-lib: compute the compatibility hash so tests may use it
 - builtin/ls-tree: let the oid determine the output algorithm
 - object-file: handle compat objects in check_object_signature
 - tree-walk: init_tree_desc take an oid to get the hash algorithm
 - builtin/cat-file: let the oid determine the output algorithm
 - rev-parse: add an --output-object-format parameter
 - repository: implement extensions.compatObjectFormat
 - object-file: update object_info_extended to reencode objects
 - object-file-convert: convert commits that embed signed tags
 - object-file-convert: convert commit objects when writing
 - object-file-convert: don't leak when converting tag objects
 - object-file-convert: convert tag objects when writing
 - object-file-convert: add a function to convert trees between algorithms
 - object: factor out parse_mode out of fast-import and tree-walk into in object.h
 - cache: add a function to read an OID of a specific algorithm
 - tag: sign both hashes
 - commit: export add_header_signature to support handling signatures on tags
 - commit: convert mergetag before computing the signature of a commit
 - commit: write commits for both hashes
 - object-file: add a compat_oid_in parameter to write_object_file_flags
 - object-file: update the loose object map when writing loose objects
 - loose: compatibilty short name support
 - loose: add a mapping between SHA-1 and SHA-256 for loose objects
 - repository: add a compatibility hash algorithm
 - object-names: support input of oids in any supported hash
 - oid-array: teach oid-array to handle multiple kinds of oids
 - object-file-convert: stubs for converting from one object format to another

 Teach a repository to work with both SHA-1 and SHA-256 hash algorithms.

 Needs review.
 source: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>


* jx/remote-archive-over-smart-http (2023-10-04) 4 commits
 - archive: support remote archive from stateless transport
 - transport-helper: call do_take_over() in connect_helper
 - transport-helper: call do_take_over() in process_connect
 - transport-helper: no connection restriction in connect_helper

 "git archive --remote=<remote>" learned to talk over the smart
 http (aka stateless) transport.

 Needs review.
 source: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>


* jx/sideband-chomp-newline-fix (2023-10-04) 3 commits
 - pkt-line: do not chomp newlines for sideband messages
 - pkt-line: memorize sideband fragment in reader
 - test-pkt-line: add option parser for unpack-sideband

 Sideband demultiplexer fixes.

 Needs review.
 source: <cover.1696425168.git.zhiyou.jx@alibaba-inc.com>


* ty/merge-tree-strategy-options (2023-09-25) 1 commit
  (merged to 'next' on 2023-09-29 at aa65b54416)
 + merge-tree: add -X strategy option

 "git merge-tree" learned to take strategy backend specific options
 via the "-X" option, like "git merge" does.

 Will merge to 'master'.
 source: <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>


* js/ci-coverity (2023-10-05) 6 commits
  (merged to 'next' on 2023-10-05 at 253788f0d1)
 + coverity: detect and report when the token or project is incorrect
 + coverity: allow running on macOS
 + coverity: support building on Windows
 + coverity: allow overriding the Coverity project
 + coverity: cache the Coverity Build Tool
 + ci: add a GitHub workflow to submit Coverity scans

 GitHub CI workflow has learned to trigger Coverity check.

 Will merge to 'master'.
 source: <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>


* js/config-parse (2023-09-21) 5 commits
 - config-parse: split library out of config.[c|h]
 - config.c: accept config_parse_options in git_config_from_stdin
 - config: report config parse errors using cb
 - config: split do_event() into start and flush operations
 - config: split out config_parse_options

 The parsing routines for the configuration files have been split
 into a separate file.

 Needs review.
 source: <cover.1695330852.git.steadmon@google.com>


* jc/fake-lstat (2023-09-15) 1 commit
 - cache: add fake_lstat()
 (this branch is used by jc/diff-cached-fsmonitor-fix.)

 A new helper to let us pretend that we called lstat() when we know
 our cache_entry is up-to-date via fsmonitor.

 Needs review.
 source: <xmqqcyykig1l.fsf@gitster.g>


* kn/rev-list-ignore-missing-links (2023-09-20) 1 commit
 - revision: add `--ignore-missing-links` user option

 Surface the .ignore_missing_links bit that stops the revision
 traversal from stopping and dying when encountering a missing
 object to a new command line option of "git rev-list", so that the
 objects that are required but are missing can be enumerated.

 What's the status of this thing?
 source: <20230920104507.21664-1-karthik.188@gmail.com>


* rs/parse-options-value-int (2023-09-18) 2 commits
 - parse-options: use and require int pointer for OPT_CMDMODE
 - parse-options: add int value pointer to struct option

 A bit of type safety for the "value" pointer used in the
 parse-options API.

 What's the status of this thing?
 source: <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>


* cc/repack-sift-filtered-objects-to-separate-pack (2023-10-02) 9 commits
  (merged to 'next' on 2023-10-03 at e5a4824609)
 + gc: add `gc.repackFilterTo` config option
 + repack: implement `--filter-to` for storing filtered out objects
 + gc: add `gc.repackFilter` config option
 + repack: add `--filter=<filter-spec>` option
 + pack-bitmap-write: rebuild using new bitmap when remapping
 + repack: refactor finding pack prefix
 + repack: refactor finishing pack-objects command
 + t/helper: add 'find-pack' test-tool
 + pack-objects: allow `--filter` without `--stdout`

 "git repack" machinery learns to pay attention to the "--filter="
 option.

 Will merge to 'master'.
 cf. <ZRsknb4NxNHTR21E@nand.local>
 source: <20231002165504.1325153-1-christian.couder@gmail.com>


* la/trailer-test-and-doc-updates (2023-09-07) 13 commits
  (merged to 'next' on 2023-10-06 at 69fef35819)
 + trailer doc: <token> is a <key> or <keyAlias>, not both
 + trailer doc: separator within key suppresses default separator
 + trailer doc: emphasize the effect of configuration variables
 + trailer --unfold help: prefer "reformat" over "join"
 + trailer --parse docs: add explanation for its usefulness
 + trailer --only-input: prefer "configuration variables" over "rules"
 + trailer --parse help: expose aliased options
 + trailer --no-divider help: describe usual "---" meaning
 + trailer: trailer location is a place, not an action
 + trailer doc: narrow down scope of --where and related flags
 + trailer: add tests to check defaulting behavior with --no-* flags
 + trailer test description: this tests --where=after, not --where=before
 + trailer tests: make test cases self-contained

 Test coverage for trailers has been improved.

 Will merge to 'master'.
 source: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>


* js/doc-unit-tests (2023-08-17) 3 commits
 - ci: run unit tests in CI
 - unit tests: add TAP unit test framework
 - unit tests: Add a project plan document
 (this branch is used by js/doc-unit-tests-with-cmake.)

 Process to add some form of low-level unit tests has started.

 Expecting a reroll.
 cf. <0b6de919-8dbf-454f-807b-5abb64388cb7@gmail.com>
 source: <cover.1692297001.git.steadmon@google.com>


* js/doc-unit-tests-with-cmake (2023-09-25) 7 commits
 - cmake: handle also unit tests
 - cmake: use test names instead of full paths
 - cmake: fix typo in variable name
 - artifacts-tar: when including `.dll` files, don't forget the unit-tests
 - unit-tests: do show relative file paths
 - unit-tests: do not mistake `.pdb` files for being executable
 - cmake: also build unit tests
 (this branch uses js/doc-unit-tests.)

 Update the base topic to work with CMake builds.

 Expecting a reroll.
 cf. <ZSCRFNkzXZb3fBaU@google.com>
 source: <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>


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

 What's the status of this thing?
 cf. <20230830200218.GA5147@szeder.dev>
 cf. <20230901205616.3572722-1-jonathantanmy@google.com>
 cf. <20230924195900.GA1156862@szeder.dev>
 source: <cover.1693413637.git.jonathantanmy@google.com>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>


* rj/status-bisect-while-rebase (2023-08-01) 1 commit
 - status: fix branch shown when not only bisecting

 "git status" is taught to show both the branch being bisected and
 being rebased when both are in effect at the same time.

 Needs review.
 cf. <xmqqtttia3vn.fsf@gitster.g>
 source: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>

--------------------------------------------------
[Discarded]

* tb/ci-coverity (2023-09-21) 1 commit
 . .github/workflows: add coverity action

 GitHub CI workflow has learned to trigger Coverity check.

 Superseded by the js/ci-coverity topic.
 source: <b23951c569660e1891a7fb3ad2c2ea1952897bd7.1695332105.git.me@ttaylorr.com>


* cw/git-std-lib (2023-09-11) 7 commits
 . SQUASH???
 . git-std-lib: add test file to call git-std-lib.a functions
 . git-std-lib: introduce git standard library
 . parse: create new library for parsing strings and env values
 . config: correct bad boolean env value error message
 . wrapper: remove dependency to Git-specific internal file
 . hex-ll: split out functionality from hex

 Another libification effort.

 Superseded by the cw/prelim-cleanup topic.
 cf. <xmqqy1hfrk6p.fsf@gitster.g>
 cf. <20230915183927.1597414-1-jonathantanmy@google.com>
 source: <20230908174134.1026823-1-calvinwan@google.com>


* so/diff-merges-d (2023-09-11) 2 commits
 - diff-merges: introduce '-d' option
 - diff-merges: improve --diff-merges documentation

 Superseded by the so/diff-merges-dd topic.
 source: <20230909125446.142715-1-sorganov@gmail.com>
