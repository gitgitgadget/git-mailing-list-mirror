Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CEE15A8
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mw3CeXqM"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 201D71BC7D1;
	Fri,  5 Jan 2024 20:14:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
	jH/4k9+BozHf00r2H43PGn4mB2BIcF9urrUj5/w8lw=; b=Mw3CeXqMYwGVRtULT
	6I8ttWscSUzmKr1QgtwV7P8df5el2/qtoALtqYdO77TUMW+nutOG5OXxvT3R97hv
	9oxPwIqyXpfdmhAU8zXOTneesRATOXYjxMNROKDGZcvvJX83IRrRG200b9RapVlE
	rHwaxtc0naOTzfoaXODjr7yQkM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B84E1BC7D0;
	Fri,  5 Jan 2024 20:14:00 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C0A611BC7CF;
	Fri,  5 Jan 2024 20:13:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2024, #02; Fri, 5)
X-master-at: a26002b62827b89a19b1084bd75d9371d565d03c
X-next-at: b435a96ce80ec65acd71d7318b1fc27d53dfa924
Date: Fri, 05 Jan 2024 17:13:58 -0800
Message-ID: <xmqq34vbnu09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DF319F50-AC30-11EE-A181-25B3960A682E-77302942!pb-smtp2.pobox.com

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

* ms/rebase-insnformat-doc-fix (2024-01-03) 1 commit
  (merged to 'next' on 2024-01-04 at d68f2be39b)
 + Documentation: fix statement about rebase.instructionFormat

 Docfix.

 Will merge to 'master'.
 source: <pull.1629.git.git.1704305663254.gitgitgadget@gmail.com>


* cp/git-flush-is-an-env-bool (2024-01-04) 1 commit
  (merged to 'next' on 2024-01-04 at b435a96ce8)
 + write-or-die: make GIT_FLUSH a Boolean environment variable

 Unlike other environment variables that took the usual
 true/false/yes/no as well as 0/1, GIT_FLUSH only understood 0/1,
 which has been corrected.

 Will merge to 'master'.
 source: <pull.1628.v3.git.1704363617842.gitgitgadget@gmail.com>


* sd/negotiate-trace-fix (2024-01-03) 1 commit
 - push: region_leave trace for negotiate_using_fetch

 Tracing fix.

 Waiting for a review response.
 cf. <xmqqbka27zu9.fsf@gitster.g>
 source: <20240103224054.1940209-1-delmerico@google.com>


* sk/mingw-owner-check-error-message-improvement (2024-01-04) 1 commit
 - mingw: give more details about unsafe directory's ownership

 In addition to (rather cryptic) Security Identifiers, show username
 and domain in the error message when we barf on mismatch between
 the Git directory and the current user.

 Waiting for a review by the area maintainer.
 cf. <xmqqbka07te6.fsf@gitster.g>
 source: <20240104192202.2124-2-soekkle@freenet.de>


* ib/rebase-reschedule-doc (2024-01-05) 1 commit
 - rebase: clarify --reschedule-failed-exec default

 Doc update.

 Will merge to 'next'.
 source: <20240105011424.1443732-2-illia.bobyr@gmail.com>


* jk/commit-graph-slab-clear-fix (2024-01-05) 1 commit
 - commit-graph: retain commit slab when closing NULL commit_graph

 Clearing in-core repository (happens during e.g., "git fetch
 --recurse-submodules" with commit graph enabled) made in-core
 commit object in an inconsistent state by discarding the necessary
 data from commit-graph too early, which has been corrected.

 Will merge to 'next'.
 source: <20240105054142.GA2035092@coredump.intra.peff.net>


* jk/index-pack-lsan-false-positive-fix (2024-01-05) 1 commit
 - index-pack: spawn threads atomically

 Fix false positive reported by leak sanitizer.

 Will merge to 'next'.
 source: <20240105085034.GA3078476@coredump.intra.peff.net>

--------------------------------------------------
[Cooking]

* cp/sideband-array-index-comment-fix (2023-12-28) 1 commit
 - sideband.c: remove redundant 'NEEDSWORK' tag

 In-code comment fix.

 Will merge to 'next'.
 source: <pull.1625.v4.git.1703750460527.gitgitgadget@gmail.com>


* ps/worktree-refdb-initialization (2023-12-28) 6 commits
 - builtin/worktree: create refdb via ref backend
 - worktree: expose interface to look up worktree by name
 - builtin/worktree: move setup of commondir file earlier
 - refs/files: skip creation of "refs/{heads,tags}" for worktrees
 - setup: move creation of "refs/" into the files backend
 - refs: prepare `refs_init_db()` for initializing worktree refs

 Instead of manually creating refs/ hierarchy on disk upon a
 creation of a secondary worktree, which is only usable via the
 files backend, use the refs API to populate it.

 May want to wait until other topics solidify a bit more.
 cf. <xmqqedf6gpt8.fsf@gitster.g>
 source: <cover.1703754513.git.ps@pks.im>


* ml/doc-merge-updates (2023-12-20) 2 commits
  (merged to 'next' on 2023-12-28 at 7a6329a219)
 + Documentation/git-merge.txt: use backticks for command wrapping
 + Documentation/git-merge.txt: fix reference to synopsis

 Doc update.

 Will merge to 'master'.
 source: <20231220195342.17590-1-mi.al.lohmann@gmail.com>


* cp/apply-core-filemode (2023-12-26) 3 commits
 - apply: code simplification
 - apply: correctly reverse patch's pre- and post-image mode bits
 - apply: ignore working tree filemode when !core.filemode

 "git apply" on a filesystem without filemode support have learned
 to take a hint from what is in the index for the path, even when
 not working with the "--index" or "--cached" option, when checking
 the executable bit match what is required by the preimage in the
 patch.

 Needs review.
 source: <20231226233218.472054-1-gitster@pobox.com>


* jc/archive-list-with-extra-args (2023-12-21) 1 commit
  (merged to 'next' on 2023-12-28 at 2d5c20e67f)
 + archive: "--list" does not take further options

 "git archive --list extra garbage" silently ignored excess command
 line parameters, which has been corrected.

 Will merge to 'master'.
 source: <xmqqmsu3mnix.fsf@gitster.g>


* jk/t1006-cat-file-objectsize-disk (2024-01-03) 2 commits
  (merged to 'next' on 2024-01-03 at a492c6355c)
 + t1006: prefer shell loop to awk for packed object sizes
  (merged to 'next' on 2023-12-28 at d82812e636)
 + t1006: add tests for %(objectsize:disk)

 Test update.

 Will merge to 'master'.
 source: <20231221094722.GA570888@coredump.intra.peff.net>
 source: <20240103090152.GB1866508@coredump.intra.peff.net>


* js/contributor-docs-updates (2023-12-27) 9 commits
  (merged to 'next' on 2024-01-02 at 0e072117cd)
 + SubmittingPatches: hyphenate non-ASCII
 + SubmittingPatches: clarify GitHub artifact format
 + SubmittingPatches: clarify GitHub visual
 + SubmittingPatches: provide tag naming advice
 + SubmittingPatches: update extra tags list
 + SubmittingPatches: discourage new trailers
 + SubmittingPatches: drop ref to "What's in git.git"
 + CodingGuidelines: write punctuation marks
 + CodingGuidelines: move period inside parentheses

 Doc update.

 Will merge to 'master'.
 source: <pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>


* al/unit-test-ctype (2024-01-05) 1 commit
 - unit-tests: rewrite t/helper/test-ctype.c as a unit test

 Move test-ctype helper to the unit-test framework.

 Will merge to 'next'.
 source: <20240105161413.10422-1-ach.lumap@gmail.com>


* bk/bisect-doc-fix (2023-12-27) 1 commit
 - doc: use singular form of repeatable path arg

 Synopsis fix.

 Expecting a reroll.
 source: <3d46bca1-96d4-43ba-a912-1f7c76942287@smtp-relay.sendinblue.com>


* en/sparse-checkout-eoo (2023-12-26) 2 commits
  (merged to 'next' on 2023-12-28 at 3ddf2ebab6)
 + sparse-checkout: be consistent with end of options markers
 + Merge branch 'jk/end-of-options' into jc/sparse-checkout-set-add-end-of-options

 "git sparse-checkout (add|set) --[no-]cone --end-of-options" did
 not handle "--end-of-options" correctly after a recent update.

 Will merge to 'master'.
 source: <pull.1625.v2.git.git.1703619562639.gitgitgadget@gmail.com>


* ja/doc-placeholders-fix (2023-12-26) 2 commits
 - doc: enforce placeholders in documentation
 - doc: enforce dashes in placeholders

 Docfix.

 Needs review.
 source: <pull.1626.git.1703539287.gitgitgadget@gmail.com>


* jc/sparse-checkout-set-default-fix (2023-12-26) 1 commit
  (merged to 'next' on 2023-12-28 at a558eccf8e)
 + sparse-checkout: use default patterns for 'set' only !stdin

 "git sparse-checkout set" added default patterns even when the
 patterns are being fed from the standard input, which has been
 corrected.

 Will merge to 'master'.
 source: <20231221065925.3234048-3-gitster@pobox.com>


* rs/fast-import-simplify-mempool-allocation (2023-12-26) 1 commit
  (merged to 'next' on 2023-12-28 at 16e6dd2a69)
 + fast-import: use mem_pool_calloc()

 Code simplification.

 Will merge to 'master'.
 source: <50c1f410-ca37-4c1c-a28b-3e9fad49f2b4@web.de>


* rs/mem-pool-improvements (2023-12-28) 2 commits
  (merged to 'next' on 2023-12-28 at aa03d9441c)
 + mem-pool: simplify alignment calculation
 + mem-pool: fix big allocations

 MemPool allocator fixes.

 Will merge to 'master'.
 source: <fa89d269-1a23-4ed6-bebc-30c0b629f444@web.de>


* ps/refstorage-extension (2024-01-02) 13 commits
 - t9500: write "extensions.refstorage" into config
 - builtin/clone: introduce `--ref-format=` value flag
 - builtin/init: introduce `--ref-format=` value flag
 - builtin/rev-parse: introduce `--show-ref-format` flag
 - t: introduce GIT_TEST_DEFAULT_REF_FORMAT envvar
 - setup: introduce GIT_DEFAULT_REF_FORMAT envvar
 - setup: introduce "extensions.refStorage" extension
 - setup: set repository's formats on init
 - setup: start tracking ref storage format
 - refs: refactor logic to look up storage backends
 - worktree: skip reading HEAD when repairing worktrees
 - t: introduce DEFAULT_REPO_FORMAT prereq
 - Merge branch 'ps/clone-into-reftable-repository' into ps/refstorage-extension

 Introduce a new extension "refstorage" so that we can mark a
 repository that uses a non-default ref backend, like reftable.

 Will merge to 'next'.
 source: <cover.1703833818.git.ps@pks.im>


* ps/reftable-fixes-and-optims (2024-01-03) 9 commits
 - reftable/merged: transfer ownership of records when iterating
 - reftable/merged: really reuse buffers to compute record keys
 - reftable/record: store "val2" hashes as static arrays
 - reftable/record: store "val1" hashes as static arrays
 - reftable/record: constify some parts of the interface
 - reftable/writer: fix index corruption when writing multiple indices
 - reftable/stack: do not auto-compact twice in `reftable_stack_add()`
 - reftable/stack: do not overwrite errors when compacting
 - Merge branch 'ps/reftable-fixes' into ps/reftable-fixes-and-optims

 More fixes and optimizations to the reftable backend.

 Will merge to 'next'.
 source: <cover.1704262787.git.ps@pks.im>


* tb/multi-pack-verbatim-reuse (2023-12-14) 26 commits
  (merged to 'next' on 2024-01-04 at 891ac0fa2c)
 + t/perf: add performance tests for multi-pack reuse
 + pack-bitmap: enable reuse from all bitmapped packs
 + pack-objects: allow setting `pack.allowPackReuse` to "single"
 + t/test-lib-functions.sh: implement `test_trace2_data` helper
 + pack-objects: add tracing for various packfile metrics
 + pack-bitmap: prepare to mark objects from multiple packs for reuse
 + pack-revindex: implement `midx_pair_to_pack_pos()`
 + pack-revindex: factor out `midx_key_to_pack_pos()` helper
 + midx: implement `midx_preferred_pack()`
 + git-compat-util.h: implement checked size_t to uint32_t conversion
 + pack-objects: include number of packs reused in output
 + pack-objects: prepare `write_reused_pack_verbatim()` for multi-pack reuse
 + pack-objects: prepare `write_reused_pack()` for multi-pack reuse
 + pack-objects: pass `bitmapped_pack`'s to pack-reuse functions
 + pack-objects: keep track of `pack_start` for each reuse pack
 + pack-objects: parameterize pack-reuse routines over a single pack
 + pack-bitmap: return multiple packs via `reuse_partial_packfile_from_bitmap()`
 + pack-bitmap: simplify `reuse_partial_packfile_from_bitmap()` signature
 + ewah: implement `bitmap_is_empty()`
 + pack-bitmap: pass `bitmapped_pack` struct to pack-reuse functions
 + midx: implement `midx_locate_pack()`
 + midx: implement `BTMP` chunk
 + midx: factor out `fill_pack_info()`
 + pack-bitmap: plug leak in find_objects()
 + pack-bitmap-write: deep-clear the `bb_commit` slab
 + pack-objects: free packing_data in more places

 Streaming spans of packfile data used to be done only from a
 single, primary, pack in a repository with multiple packfiles.  It
 has been extended to allow reuse from other packfiles, too.

 Will merge to 'master'.
 cf. <ZXurD1NTZ4TAs7WZ@nand.local>
 source: <cover.1702592603.git.me@ttaylorr.com>


* jc/bisect-doc (2023-12-09) 1 commit
 - bisect: document "terms" subcommand more fully

 Doc update.

 Needs review.
 source: <xmqqzfyjmk02.fsf@gitster.g>


* en/header-cleanup (2023-12-26) 12 commits
  (merged to 'next' on 2023-12-28 at 1ccddc2a10)
 + treewide: remove unnecessary includes in source files
 + treewide: add direct includes currently only pulled in transitively
 + trace2/tr2_tls.h: remove unnecessary include
 + submodule-config.h: remove unnecessary include
 + pkt-line.h: remove unnecessary include
 + line-log.h: remove unnecessary include
 + http.h: remove unnecessary include
 + fsmonitor--daemon.h: remove unnecessary includes
 + blame.h: remove unnecessary includes
 + archive.h: remove unnecessary include
 + treewide: remove unnecessary includes in source files
 + treewide: remove unnecessary includes from header files

 Remove unused header "#include".

 Will merge to 'master'.
 source: <pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>


* jw/builtin-objectmode-attr (2023-12-28) 1 commit
  (merged to 'next' on 2024-01-02 at 4c3784b3a1)
 + attr: add builtin objectmode values support

 The builtin_objectmode attribute is populated for each path
 without adding anything in .gitattributes files, which would be
 useful in magic pathspec, e.g., ":(attr:builtin_objectmode=100755)"
 to limit to executables.

 Will merge to 'master'.
 cf. <xmqq5y0ssknj.fsf@gitster.g>
 source: <20231116054437.2343549-1-jojwang@google.com>


* tb/pair-chunk-expect (2023-11-10) 8 commits
 - midx: read `OOFF` chunk with `pair_chunk_expect()`
 - midx: read `OIDL` chunk with `pair_chunk_expect()`
 - commit-graph: read `BIDX` chunk with `pair_chunk_expect()`
 - commit-graph: read `GDAT` chunk with `pair_chunk_expect()`
 - commit-graph: read `CDAT` chunk with `pair_chunk_expect()`
 - commit-graph: read `OIDL` chunk with `pair_chunk_expect()`
 - chunk-format: introduce `pair_chunk_expect()` helper
 - Merge branch 'jk/chunk-bounds-more' into HEAD

 Further code clean-up.

 Needs review.
 source: <cover.1699569246.git.me@ttaylorr.com>


* tb/path-filter-fix (2023-10-18) 17 commits
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

 Expecting a reroll?
 cf. <20231023202212.GA5470@szeder.dev>
 source: <cover.1697653929.git.me@ttaylorr.com>


* ak/color-decorate-symbols (2023-10-23) 7 commits
 - log: add color.decorate.pseudoref config variable
 - refs: exempt pseudorefs from pattern prefixing
 - refs: add pseudorefs array and iteration functions
 - log: add color.decorate.ref config variable
 - log: add color.decorate.symbol config variable
 - log: use designated inits for decoration_colors
 - config: restructure color.decorate documentation

 A new config for coloring.

 Needs review.
 source: <20231023221143.72489-1-andy.koppe@gmail.com>


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


* jx/remote-archive-over-smart-http (2023-12-14) 4 commits
 - archive: support remote archive from stateless transport
 - transport-helper: call do_take_over() in connect_helper
 - transport-helper: call do_take_over() in process_connect
 - transport-helper: no connection restriction in connect_helper

 "git archive --remote=<remote>" learned to talk over the smart
 http (aka stateless) transport.

 Needs review.
 source: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>


* jx/sideband-chomp-newline-fix (2023-12-18) 3 commits
  (merged to 'next' on 2024-01-04 at 1237898a22)
 + pkt-line: do not chomp newlines for sideband messages
 + pkt-line: memorize sideband fragment in reader
 + test-pkt-line: add option parser for unpack-sideband

 Sideband demultiplexer fixes.

 Will merge to 'master'.
 source: <cover.1702823801.git.zhiyou.jx@alibaba-inc.com>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>

--------------------------------------------------
[Discarded]

* jc/sparse-checkout-eoo (2023-12-21) 5 commits
 . sparse-checkout: tighten add_patterns_from_input()
 . sparse-checkout: use default patterns for 'set' only !stdin
 . SQUASH??? end-of-options test
 . sparse-checkout: take care of "--end-of-options" in set/add/check-rules
 + Merge branch 'jk/end-of-options' into jc/sparse-checkout-set-add-end-of-options

 "git sparse-checkout (add|set) --[no-]cone --end-of-options" did
 not handle "--end-of-options" correctly after a recent update.

 Superseded by the en/sparse-checkout-eoo topic.
 source: <20231221065925.3234048-1-gitster@pobox.com>


* tb/merge-tree-write-pack (2023-10-23) 5 commits
 . builtin/merge-tree.c: implement support for `--write-pack`
 . bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
 . bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
 . bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
 . bulk-checkin: extract abstract `bulk_checkin_source`

 "git merge-tree" learned "--write-pack" to record its result
 without creating loose objects.

 Broken when an object created during a merge is needed to continue merge
 cf. <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
 cf. <ZZWOtnP2IHNldcy6@nand.local>
 source: <cover.1698101088.git.me@ttaylorr.com>
