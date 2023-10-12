Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8D2B5C1
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 23:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PCIIONo9"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B46C9
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 16:22:02 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DA4183B0FC;
	Thu, 12 Oct 2023 19:22:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=g
	ZZxti2E4oKcyBlnH8x/fXQFEUQNM6gDxmME7/OQFJw=; b=PCIIONo9LoAG1tdac
	TaSafw9Hc7IYeRon/NVfo5VrGj3THiEyQkBJianQy+oFN5E3/IKc4iTMF9pqBgiQ
	TpGezd23s1/4vPuhOr+RJAGTqGSnldmgsC0y13Ypqo1duwSbJZgJ52jk8s5pG/8u
	VKat6/2pXjnWeUMmRqoyQRAL34=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D2D5B3B0FB;
	Thu, 12 Oct 2023 19:22:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5B1AE3B0F9;
	Thu, 12 Oct 2023 19:21:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2023, #05; Thu, 12)
X-master-at: 59167d7d09fd7a1d64aa1d5be73bc484f6621894
X-next-at: aed0368e0ec22719bf8aa6dece549de780395f82
Date: Thu, 12 Oct 2023 16:21:56 -0700
Message-ID: <xmqqmswn2zqj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 23CE232C-6956-11EE-9483-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

There are too many topics marked with "Needs review" label.  I can
help reviewing some of them myself, but obviously it will not scale.

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

* jm/git-status-submodule-states-docfix (2023-10-04) 1 commit
  (merged to 'next' on 2023-10-04 at 520b7711a4)
 + git-status.txt: fix minor asciidoc format issue

 Docfix.
 source: <pull.1591.v3.git.1696386165616.gitgitgadget@gmail.com>


* js/ci-coverity (2023-10-05) 6 commits
  (merged to 'next' on 2023-10-05 at 253788f0d1)
 + coverity: detect and report when the token or project is incorrect
 + coverity: allow running on macOS
 + coverity: support building on Windows
 + coverity: allow overriding the Coverity project
 + coverity: cache the Coverity Build Tool
 + ci: add a GitHub workflow to submit Coverity scans

 GitHub CI workflow has learned to trigger Coverity check.
 source: <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>


* rs/parse-opt-ctx-cleanup (2023-10-03) 1 commit
  (merged to 'next' on 2023-10-04 at d5d0a2ce3b)
 + parse-options: drop unused parse_opt_ctx_t member

 Code clean-up.
 source: <ebcaa9e1-d306-4c93-adec-3f35d7040531@web.de>

--------------------------------------------------
[New Topics]

* jc/fail-stash-to-store-non-stash (2023-10-11) 1 commit
 - stash: be careful what we store

 Feeding "git stash store" with a random commit that was not created
 by "git stash create" now errors out.

 Will merge to 'next'?
 source: <xmqqbkd4lwj0.fsf_-_@gitster.g>


* jc/doc-unit-tests-fixup (2023-10-11) 1 commit
 - SQUASH???
 (this branch uses js/doc-unit-tests and js/doc-unit-tests-with-cmake.)

 Quick fix for jc/doc-unit-tests topic to unbreak CI running on 'seen'.
 source: <xmqqwmvskf8t.fsf@gitster.g>


* bc/racy-4gb-files (2023-10-12) 2 commits
 - Prevent git from rehashing 4GiB files
 - t: add a test helper to truncate files

 The index file has room only for lower 32-bit of the file size in
 the cached stat information, which means cached stat information
 will have 0 in its sd_size member for a file whose size is multiple
 of 4GiB.  This is mistaken for a racily clean path.  Avoid it by
 storing a bogus sd_size value instead for such files.

 Waiting for review response.
 source: <20231012160930.330618-1-sandals@crustytoothpaste.net>


* ds/mailmap-entry-update (2023-10-12) 1 commit
  (merged to 'next' on 2023-10-12 at 3de300ac62)
 + mailmap: change primary address for Derrick Stolee

 Update mailmap entry for Derrick.

 Will merge to 'master' immediately.
 source: <pull.1592.git.1697131834003.gitgitgadget@gmail.com>


* jc/grep-f-relative-to-cwd (2023-10-12) 1 commit
 - grep: -f <path> is relative to $cwd

 "cd sub && git grep -f patterns" tried to read "patterns" file at
 the top level of the working tree; it has been corrected to read
 "sub/patterns" instead.

 Needs review.
 source: <xmqqedhzg37z.fsf@gitster.g>

--------------------------------------------------
[Stalled]

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

* tb/path-filter-fix (2023-10-10) 17 commits
 - bloom: introduce `deinit_bloom_filters()`
 - commit-graph: reuse existing Bloom filters where possible
 - object.h: fix mis-aligned flag bits table
 - commit-graph: drop unnecessary `graph_read_bloom_data_context`
 - commit-graph.c: unconditionally load Bloom filters
 - bloom: prepare to discard incompatible Bloom filters
 - bloom: annotate filters with hash version
 - commit-graph: new filter ver. that fixes murmur3
 - repo-settings: introduce commitgraph.changedPathsVersion
 - t4216: test changed path filters with high bit paths
 - t/helper/test-read-graph: implement `bloom-filters` mode
 - bloom.h: make `load_bloom_filter_from_graph()` public
 - t/helper/test-read-graph.c: extract `dump_graph_info()`
 - gitformat-commit-graph: describe version 2 of BDAT
 - commit-graph: ensure Bloom filters are read with consistent settings
 - revision.c: consult Bloom filters for root commits
 - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Needs (hopefully final and quick) review.
 source: <cover.1696969994.git.me@ttaylorr.com>


* ak/pretty-decorate-more-fix (2023-10-09) 1 commit
  (merged to 'next' on 2023-10-12 at 3cbb4c2268)
 + pretty: fix ref filtering for %(decorate) formats

 Unlike "git log --pretty=%D", "git log --pretty="%(decorate)" did
 not auto-initialize the decoration subsystem, which has been
 corrected.

 Will merge to 'master'.
 source: <20231008202307.1568477-1-andy.koppe@gmail.com>


* en/docfixes (2023-10-09) 25 commits
 - documentation: add missing parenthesis
 - documentation: add missing quotes
 - documentation: add missing fullstops
 - documentation: add some commas where they are helpful
 - documentation: fix whitespace issues
 - documentation: fix capitalization
 - documentation: fix punctuation
 - documentation: use clearer prepositions
 - documentation: add missing hyphens
 - documentation: remove unnecessary hyphens
 - documentation: add missing article
 - documentation: fix choice of article
 - documentation: whitespace is already generally plural
 - documentation: fix singular vs. plural
 - documentation: fix verb vs. noun
 - documentation: fix adjective vs. noun
 - documentation: fix verb tense
 - documentation: employ consistent verb tense for a list
 - documentation: fix subject/verb agreement
 - documentation: remove extraneous words
 - documentation: add missing words
 - documentation: fix apostrophe usage
 - documentation: fix typos
 - documentation: fix small error
 - documentation: wording improvements

 Documentation typo and grammo fixes.

 Needs review.
 source: <pull.1595.git.1696747527.gitgitgadget@gmail.com>


* kn/rev-list-missing-fix (2023-10-09) 3 commits
 . rev-list: add commit object support in `--missing` option
 . rev-list: move `show_commit()` to the bottom
 . revision: rename bit to `do_not_die_on_missing_objects`

 "git rev-list --missing" did not work for missing commit objects,
 which has been corrected.

 Needs review.
 Seems to break CI job with extra environment settings.
 cf. <xmqqil7etndo.fsf@gitster.g>
 source: <20231009105528.17777-1-karthik.188@gmail.com>


* sn/cat-file-doc-update (2023-10-09) 1 commit
  (merged to 'next' on 2023-10-10 at 6719ba7bd4)
 + doc/cat-file: make synopsis and description less confusing

 "git cat-file" documentation updates.

 Will merge to 'master'.
 source: <20231009175604.2361700-1-stepnem@smrk.net>


* xz/commit-title-soft-limit-doc (2023-10-09) 1 commit
  (merged to 'next' on 2023-10-10 at 0bf3d9ed51)
 + doc: correct the 50 characters soft limit (+)

 Doc update.

 Will merge to 'master'.
 source: <pull.1585.v2.git.git.1696778367151.gitgitgadget@gmail.com>


* jk/chunk-bounds (2023-10-09) 20 commits
  (merged to 'next' on 2023-10-10 at 21139603ce)
 + chunk-format: drop pair_chunk_unsafe()
 + commit-graph: detect out-of-order BIDX offsets
 + commit-graph: check bounds when accessing BIDX chunk
 + commit-graph: check bounds when accessing BDAT chunk
 + commit-graph: bounds-check generation overflow chunk
 + commit-graph: check size of generations chunk
 + commit-graph: bounds-check base graphs chunk
 + commit-graph: detect out-of-bounds extra-edges pointers
 + commit-graph: check size of commit data chunk
 + midx: check size of revindex chunk
 + midx: bounds-check large offset chunk
 + midx: check size of object offset chunk
 + midx: enforce chunk alignment on reading
 + midx: check size of pack names chunk
 + commit-graph: check consistency of fanout table
 + midx: check size of oid lookup chunk
 + commit-graph: check size of oid fanout chunk
 + midx: stop ignoring malformed oid fanout chunk
 + t: add library for munging chunk-format files
 + chunk-format: note that pair_chunk() is unsafe

 The codepaths that read "chunk" formatted files have been corrected
 to pay attention to the chunk size and notice broken files.

 Will merge to 'master'.
 source: <20231009205544.GA3281950@coredump.intra.peff.net>


* ps/rewritten-is-per-worktree-doc (2023-10-10) 1 commit
  (merged to 'next' on 2023-10-12 at 501b960e8c)
 + doc/git-worktree: mention "refs/rewritten" as per-worktree refs

 Doc update.

 Will merge to 'master'.
 source: <985ac850eb6e60ae76601acc8bfbcd56f99348b4.1696935657.git.ps@pks.im>


* jc/merge-ort-attr-index-fix (2023-10-09) 1 commit
  (merged to 'next' on 2023-10-10 at b139b87502)
 + merge-ort: initialize repo in index state

 Fix "git merge-tree" to stop segfaulting when the --attr-source
 option is used.

 Will merge to 'master'.
 source: <pull.1583.v3.git.git.1696857660374.gitgitgadget@gmail.com>


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


* so/diff-merges-dd (2023-10-09) 3 commits
 - completion: complete '--dd'
 - diff-merges: introduce '--dd' option
 - diff-merges: improve --diff-merges documentation

 "git log" and friends learned "--dd" that is a short-hand for
 "--diff-merges=first-parent -p".

 Will merge to 'next'?
 source: <20231009160535.236523-1-sorganov@gmail.com>


* vd/loose-ref-iteration-optimization (2023-10-09) 4 commits
  (merged to 'next' on 2023-10-12 at 99e2f83855)
 + files-backend.c: avoid stat in 'loose_fill_ref_dir'
 + dir.[ch]: add 'follow_symlink' arg to 'get_dtype'
 + dir.[ch]: expose 'get_dtype'
 + ref-cache.c: fix prefix matching in ref iteration

 The code to iterate over loose references have been optimized to
 reduce the number of lstat() system calls.

 Will merge to 'master'.
 source: <pull.1594.v2.git.1696888736.gitgitgadget@gmail.com>


* jc/update-list-references-to-lore (2023-10-06) 1 commit
 - doc: update list archive reference to use lore.kernel.org

 Doc update.

 Needs review.
 source: <xmqq7cnz741s.fsf@gitster.g>


* cc/git-replay (2023-10-10) 14 commits
 - replay: stop assuming replayed branches do not diverge
 - replay: add --contained to rebase contained branches
 - replay: add --advance or 'cherry-pick' mode
 - replay: use standard revision ranges
 - replay: make it a minimal server side command
 - replay: remove HEAD related sanity check
 - replay: remove progress and info output
 - replay: add an important FIXME comment about gpg signing
 - replay: change rev walking options
 - replay: introduce pick_regular_commit()
 - replay: die() instead of failing assert()
 - replay: start using parse_options API
 - replay: introduce new builtin
 - t6429: remove switching aspects of fast-rebase

 Introduce "git replay", a tool meant on the server side without
 working tree to recreate a history.

 Needs (hopefully final and quick) review.
 source: <20231010123847.2777056-1-christian.couder@gmail.com>


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


* tb/repack-max-cruft-size (2023-10-09) 5 commits
  (merged to 'next' on 2023-10-09 at 38f039e880)
 + repack: free existing_cruft array after use
  (merged to 'next' on 2023-10-06 at b3ca6df3b9)
 + builtin/repack.c: avoid making cruft packs preferred
 + builtin/repack.c: implement support for `--max-cruft-size`
 + builtin/repack.c: parse `--max-pack-size` with OPT_MAGNITUDE
 + t7700: split cruft-related tests to t7704

 "git repack" learned "--max-cruft-size" to prevent cruft packs from
 growing without bounds.

 Will merge to 'master'.
 source: <cover.1696293862.git.me@ttaylorr.com>
 source: <20231007172031.GA1524950@coredump.intra.peff.net>
 source: <035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com>


* ak/color-decorate-symbols (2023-10-03) 1 commit
 - decorate: add color.decorate.symbols config option

 A new config for coloring.

 Needs review.
 source: <20231003205442.22963-1-andy.koppe@gmail.com>


* jc/attr-tree-config (2023-10-11) 2 commits
 - attr: add attr.tree for setting the treeish to read attributes from
 - attr: read attributes from HEAD when bare repo

 The attribute subsystem learned to honor `attr.tree` configuration
 that specifies which tree to read the .gitattributes files from.

 Will merge to 'next'?
 source: <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>


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


* ar/diff-index-merge-base-fix (2023-10-02) 1 commit
  (merged to 'next' on 2023-10-06 at 0ff4dfc0e1)
 + diff: fix --merge-base with annotated tags

 "git diff --merge-base X other args..." insisted that X must be a
 commit and errored out when given an annotated tag that peels to a
 commit, but we only need it to be a committish.  This has been
 corrected.

 Will merge to 'master'.
 source: <20231001151845.3621551-1-hi@alyssa.is>


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


* ty/merge-tree-strategy-options (2023-10-11) 2 commits
  (merged to 'next' on 2023-10-12 at 9b873601df)
 + merge: introduce {copy|clear}_merge_options()
  (merged to 'next' on 2023-09-29 at aa65b54416)
 + merge-tree: add -X strategy option

 "git merge-tree" learned to take strategy backend specific options
 via the "-X" option, like "git merge" does.

 Will merge to 'master'.
 source: <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>


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


* rs/parse-options-value-int (2023-09-18) 2 commits
 - parse-options: use and require int pointer for OPT_CMDMODE
 - parse-options: add int value pointer to struct option

 A bit of type safety for the "value" pointer used in the
 parse-options API.

 Not ready yet.
 cf. <4014e490-c6c1-453d-b0ed-645220e3e614@web.de>
 source: <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>


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


* js/doc-unit-tests (2023-10-09) 3 commits
 - ci: run unit tests in CI
 - unit tests: add TAP unit test framework
 - unit tests: add a project plan document
 (this branch is used by jc/doc-unit-tests-fixup and js/doc-unit-tests-with-cmake.)

 Process to add some form of low-level unit tests has started.

 Expecting a reroll to address CI breakage.
 source: <cover.1696889529.git.steadmon@google.com>


* js/doc-unit-tests-with-cmake (2023-10-09) 7 commits
 - cmake: handle also unit tests
 - cmake: use test names instead of full paths
 - cmake: fix typo in variable name
 - artifacts-tar: when including `.dll` files, don't forget the unit-tests
 - unit-tests: do show relative file paths
 - unit-tests: do not mistake `.pdb` files for being executable
 - cmake: also build unit tests
 (this branch is used by jc/doc-unit-tests-fixup; uses js/doc-unit-tests.)

 Update the base topic to work with CMake builds.

 Needs review.
 source: <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>


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


* kn/rev-list-ignore-missing-links (2023-09-20) 1 commit
 . revision: add `--ignore-missing-links` user option

 Surface the .ignore_missing_links bit that stops the revision
 traversal from stopping and dying when encountering a missing
 object to a new command line option of "git rev-list", so that the
 objects that are required but are missing can be enumerated.

 Superseded by kn/rev-list-missing-fix
 source: <20230920104507.21664-1-karthik.188@gmail.com>
