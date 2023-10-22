Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8874D125BB
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N2FwL1Ae"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D2EF2
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 15:17:51 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 44B2D23405;
	Sun, 22 Oct 2023 18:17:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=u
	gm+GH7yzV0OpU7dSEpTM+Fxx9rjARqQ6Be9EvNHvR4=; b=N2FwL1AeOnao7/g0e
	TBFHJWVYFcSeaD93ynDZLGn5zavxGzT7Ywb6o07hMM8qb+nE2gNyWMhpSSYJ/Pm0
	75cHOK7DGJZd5D9W81TCRJdnNiFkZJTL99j5Nv5Ju8/DnLflW+lOpjp0NTYc6I0y
	WUz9b2rQDAfT2Lrwp6IR6anNvI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C6A423404;
	Sun, 22 Oct 2023 18:17:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B9D6D23403;
	Sun, 22 Oct 2023 18:17:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2023, #08; Sun, 22)
X-master-at: ceadf0f3cf51550166a387ec8508bb55e7883057
X-next-at: 7ce3cef56b63eab50c97e020dbcc89a4d2035129
Date: Sun, 22 Oct 2023 15:17:46 -0700
Message-ID: <xmqq8r7uqp2t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D4CAE622-7128-11EE-8C97-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

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
review some of them myself, but obviously not all.  For now I will
refrain from adding more topics to 'seen' that are not reviewed at
all.

I'll be away from the keyboard for most of the later half of the
week, and the updates to my tree will be slower than usual.

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

* ak/pretty-decorate-more-fix (2023-10-09) 1 commit
  (merged to 'next' on 2023-10-12 at 3cbb4c2268)
 + pretty: fix ref filtering for %(decorate) formats

 Unlike "git log --pretty=%D", "git log --pretty="%(decorate)" did
 not auto-initialize the decoration subsystem, which has been
 corrected.
 source: <20231008202307.1568477-1-andy.koppe@gmail.com>


* ps/rewritten-is-per-worktree-doc (2023-10-10) 1 commit
  (merged to 'next' on 2023-10-12 at 501b960e8c)
 + doc/git-worktree: mention "refs/rewritten" as per-worktree refs

 Doc update.
 source: <985ac850eb6e60ae76601acc8bfbcd56f99348b4.1696935657.git.ps@pks.im>


* ty/merge-tree-strategy-options (2023-10-11) 2 commits
  (merged to 'next' on 2023-10-12 at 9b873601df)
 + merge: introduce {copy|clear}_merge_options()
  (merged to 'next' on 2023-09-29 at aa65b54416)
 + merge-tree: add -X strategy option

 "git merge-tree" learned to take strategy backend specific options
 via the "-X" option, like "git merge" does.
 source: <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>


* vd/loose-ref-iteration-optimization (2023-10-09) 4 commits
  (merged to 'next' on 2023-10-12 at 99e2f83855)
 + files-backend.c: avoid stat in 'loose_fill_ref_dir'
 + dir.[ch]: add 'follow_symlink' arg to 'get_dtype'
 + dir.[ch]: expose 'get_dtype'
 + ref-cache.c: fix prefix matching in ref iteration

 The code to iterate over loose references have been optimized to
 reduce the number of lstat() system calls.
 source: <pull.1594.v2.git.1696888736.gitgitgadget@gmail.com>

--------------------------------------------------
[New Topics]

* jc/am-doc-whitespace-action-fix (2023-10-18) 1 commit
  (merged to 'next' on 2023-10-20 at 9200d39c08)
 + am: align placeholder for --whitespace option with apply

 Docfix.

 Will merge to 'master'.
 source: <xmqqwmvjzeqd.fsf@gitster.g>


* da/t7601-style-fix (2023-10-18) 1 commit
  (merged to 'next' on 2023-10-20 at 8e7326458c)
 + t7601: use "test_path_is_file" etc. instead of "test -f"

 Coding style update.

 Will merge to 'master'.
 source: <20231018124538.68549-2-anonolitunya@gmail.com>


* jx/fetch-atomic-error-message-fix (2023-10-19) 2 commits
 - fetch: no redundant error message for atomic fetch
 - t5574: test porcelain output of atomic fetch

 "git fetch --atomic" issued an unnecessary empty error message,
 which has been corrected.

 Needs review.
 source: <ced46baeb1c18b416b4b4cc947f498bea2910b1b.1697725898.git.zhiyou.jx@alibaba-inc.com>


* mm/p4-symlink-with-lfs (2023-10-19) 1 commit
  (merged to 'next' on 2023-10-20 at 9c05ce7e85)
 + git-p4 shouldn't attempt to store symlinks in LFS

 "git p4" tried to store symlinks to LFS when told, but has been
 fixed not to do so, because it does not make sense.

 Will merge to 'master'.
 source: <20231019002558.867830-1-mmcclain@noprivs.com>


* jk/send-email-fix-addresses-from-composed-messages (2023-10-20) 3 commits
  (merged to 'next' on 2023-10-22 at 43221cc3a4)
 + send-email: handle to/cc/bcc from --compose message
 + Revert "send-email: extract email-parsing code into a subroutine"
 + doc/send-email: mention handling of "reply-to" with --compose

 The codepath to handle recipient addresses `git send-email
 --compose` learns from the user was completely broken, which has
 been corrected.

 Will merge to 'master'.
 source: <20231020100343.GA2194322@coredump.intra.peff.net>


* ms/doc-push-fix (2023-10-20) 1 commit
  (merged to 'next' on 2023-10-22 at 7ce3cef56b)
 + git-push doc: more visibility for -q option

 Docfix.

 Will merge to 'master'.
 source: <20231020184627.14336-1-msuchanek@suse.de>


* ob/rebase-cleanup (2023-10-20) 3 commits
  (merged to 'next' on 2023-10-22 at 05e14ca4fc)
 + rebase: move parse_opt_keep_empty() down
 + rebase: handle --strategy via imply_merge() as well
 + rebase: simplify code related to imply_merge()

 Code clean-up.

 Will merge to 'master'.
 source: <20231020093654.922890-1-oswald.buddenhagen@gmx.de>


* wx/merge-ort-comment-typofix (2023-10-21) 1 commit
  (merged to 'next' on 2023-10-22 at ad1e33883a)
 + merge-ort.c: fix typo 'neeed' to 'needed'

 Typofix.

 Will merge to 'master'.
 source: <pull.1592.v3.git.git.1697942768555.gitgitgadget@gmail.com>

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

* jc/commit-new-underscore-index-fix (2023-10-17) 1 commit
  (merged to 'next' on 2023-10-22 at 0e4787303d)
 + commit: do not use cryptic "new_index" in end-user facing messages

 Message fix.

 Will merge to 'master'.
 source: <xmqqo7gwvd8c.fsf_-_@gitster.g>


* js/bugreport-in-the-same-minute (2023-10-16) 1 commit
 - bugreport: include +i in outfile suffix as needed

 Instead of auto-generating a filename that is already in use for
 output and fail the command, `git bugreport` learned to fuzz the
 filename to avoid collisions with existing files.

 Needs review.
 source: <20231016214045.146862-2-jacob@initialcommit.io>


* kh/pathspec-error-wo-repository-fix (2023-10-20) 1 commit
  (merged to 'next' on 2023-10-22 at 4f77af1e40)
 + grep: die gracefully when outside repository

 The pathspec code carelessly dereferenced NULL while emitting an
 error message, which has been corrected.

 Will merge to 'master'.
 source: <5c8ef6bec1c99e0fae7ada903885a8e77f8137f9.1697819838.git.code@khaugsbakk.name>


* kh/t7900-cleanup (2023-10-17) 9 commits
 - t7900: fix register dependency
 - t7900: factor out packfile dependency
 - t7900: fix `print-args` dependency
 - t7900: fix `pfx` dependency
 - t7900: factor out common schedule setup
 - t7900: factor out inheritance test dependency
 - t7900: create commit so that branch is born
 - t7900: setup and tear down clones
 - t7900: remove register dependency

 Test clean-up.

 Needs review.
 source: <cover.1697319294.git.code@khaugsbakk.name>


* ni/die-message-fix-for-git-add (2023-10-17) 1 commit
  (merged to 'next' on 2023-10-22 at f46c5dfd63)
 + builtin/add.c: clean up die() messages

 Message updates.

 Will merge to 'master'.
 source: <20231017113946.747-1-naomi.ibeh69@gmail.com>


* ps/git-repack-doc-fixes (2023-10-16) 2 commits
  (merged to 'next' on 2023-10-22 at df64849f26)
 + doc/git-repack: don't mention nonexistent "--unpacked" option
 + doc/git-repack: fix syntax for `-g` shorthand option

 Doc updates.

 Will merge to 'master'.
 source: <cover.1697440686.git.ps@pks.im>


* tb/merge-tree-write-pack (2023-10-19) 7 commits
 - builtin/merge-tree.c: implement support for `--write-pack`
 - bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
 - bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
 - bulk-checkin: implement `SOURCE_INCORE` mode for `bulk_checkin_source`
 - bulk-checkin: refactor deflate routine to accept a `bulk_checkin_source`
 - bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
 - bulk-checkin: extract abstract `bulk_checkin_source`

 "git merge-tree" learned "--write-pack" to record its result
 without creating loose objects.

 Will merge to 'next'?
 source: <cover.1697736516.git.me@ttaylorr.com>


* tb/format-pack-doc-update (2023-10-12) 2 commits
 - Documentation/gitformat-pack.txt: fix incorrect MIDX documentation
 - Documentation/gitformat-pack.txt: fix typo

 Doc update.

 Expecting a reroll.
 cf. <xmqq5y3b4id2.fsf@gitster.g>
 source: <cover.1697144959.git.me@ttaylorr.com>


* ps/do-not-trust-commit-graph-blindly-for-existence (2023-10-13) 1 commit
 - commit: detect commits that exist in commit-graph but not in the ODB
 (this branch is used by kn/rev-list-missing-fix.)

 The codepath to traverse the commit-graph learned to notice that a
 commit is missing (e.g., corrupt repository lost an object), even
 though it knows something about the commit (like its parents) from
 what is in commit-graph.

 Comments?
 source: <b0bf576c51a706367a758b8e30eca37edb9c2734.1697200576.git.ps@pks.im>


* tb/pair-chunk-expect-size (2023-10-14) 8 commits
 - midx: read `OOFF` chunk with `pair_chunk_expect()`
 - midx: read `OIDL` chunk with `pair_chunk_expect()`
 - midx: read `OIDF` chunk with `pair_chunk_expect()`
 - commit-graph: read `BIDX` chunk with `pair_chunk_expect()`
 - commit-graph: read `GDAT` chunk with `pair_chunk_expect()`
 - commit-graph: read `CDAT` chunk with `pair_chunk_expect()`
 - commit-graph: read `OIDF` chunk with `pair_chunk_expect()`
 - chunk-format: introduce `pair_chunk_expect()` helper
 (this branch uses jk/chunk-bounds.)

 Code clean-up for jk/chunk-bounds topic.

 Comments?
 source: <45cac29403e63483951f7766c6da3c022c68d9f0.1697225110.git.me@ttaylorr.com>
 source: <cover.1697225110.git.me@ttaylorr.com>


* jc/fail-stash-to-store-non-stash (2023-10-11) 1 commit
  (merged to 'next' on 2023-10-16 at e26db57315)
 + stash: be careful what we store

 Feeding "git stash store" with a random commit that was not created
 by "git stash create" now errors out.

 Will merge to 'master'.
 source: <xmqqbkd4lwj0.fsf_-_@gitster.g>


* bc/racy-4gb-files (2023-10-13) 2 commits
  (merged to 'next' on 2023-10-16 at c60962dfee)
 + Prevent git from rehashing 4GiB files
 + t: add a test helper to truncate files

 The index file has room only for lower 32-bit of the file size in
 the cached stat information, which means cached stat information
 will have 0 in its sd_size member for a file whose size is multiple
 of 4GiB.  This is mistaken for a racily clean path.  Avoid it by
 storing a bogus sd_size value instead for such files.

 Will merge to 'master'.
 source: <20231012160930.330618-1-sandals@crustytoothpaste.net>


* jc/grep-f-relative-to-cwd (2023-10-12) 1 commit
 - grep: -f <path> is relative to $cwd

 "cd sub && git grep -f patterns" tried to read "patterns" file at
 the top level of the working tree; it has been corrected to read
 "sub/patterns" instead.

 Needs review.
 source: <xmqqedhzg37z.fsf@gitster.g>


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

 Needs (hopefully final and quick) review.
 source: <cover.1697653929.git.me@ttaylorr.com>


* en/docfixes (2023-10-09) 25 commits
  (merged to 'next' on 2023-10-17 at 1e3cdeb427)
 + documentation: add missing parenthesis
 + documentation: add missing quotes
 + documentation: add missing fullstops
 + documentation: add some commas where they are helpful
 + documentation: fix whitespace issues
 + documentation: fix capitalization
 + documentation: fix punctuation
 + documentation: use clearer prepositions
 + documentation: add missing hyphens
 + documentation: remove unnecessary hyphens
 + documentation: add missing article
 + documentation: fix choice of article
 + documentation: whitespace is already generally plural
 + documentation: fix singular vs. plural
 + documentation: fix verb vs. noun
 + documentation: fix adjective vs. noun
 + documentation: fix verb tense
 + documentation: employ consistent verb tense for a list
 + documentation: fix subject/verb agreement
 + documentation: remove extraneous words
 + documentation: add missing words
 + documentation: fix apostrophe usage
 + documentation: fix typos
 + documentation: fix small error
 + documentation: wording improvements

 Documentation typo and grammo fixes.

 Will merge to 'master'.
 source: <pull.1595.git.1696747527.gitgitgadget@gmail.com>


* kn/rev-list-missing-fix (2023-10-22) 4 commits
 - rev-list: add commit object support in `--missing` option
 - rev-list: move `show_commit()` to the bottom
 - revision: rename bit to `do_not_die_on_missing_objects`
 - Merge branch 'ps/do-not-trust-commit-graph-blindly-for-existence' into kn/rev-list-missing-fix
 (this branch uses ps/do-not-trust-commit-graph-blindly-for-existence.)

 "git rev-list --missing" did not work for missing commit objects,
 which has been corrected.

 Comments?
 source: <20231019121024.194317-1-karthik.188@gmail.com>


* jk/chunk-bounds (2023-10-14) 21 commits
  (merged to 'next' on 2023-10-16 at 68c9e37980)
 + t5319: make corrupted large-offset test more robust
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
 (this branch is used by tb/pair-chunk-expect-size.)

 The codepaths that read "chunk" formatted files have been corrected
 to pay attention to the chunk size and notice broken files.

 Will merge to 'master'.
 source: <20231009205544.GA3281950@coredump.intra.peff.net>


* sn/typo-grammo-phraso-fixes (2023-10-05) 5 commits
  (merged to 'next' on 2023-10-18 at 575d767f9a)
 + t/README: fix multi-prerequisite example
 + doc/gitk: s/sticked/stuck/
 + git-jump: admit to passing merge mode args to ls-files
 + doc/diff-options: improve wording of the log.diffMerges mention
 + doc: fix some typos, grammar and wording issues

 Many typos, ungrammatical sentences and wrong phrasing have been
 fixed.

 Will merge to 'master'.
 source: <20231003082107.3002173-1-stepnem@smrk.net>


* so/diff-merges-dd (2023-10-09) 3 commits
  (merged to 'next' on 2023-10-16 at 71b5e29625)
 + completion: complete '--dd'
 + diff-merges: introduce '--dd' option
 + diff-merges: improve --diff-merges documentation

 "git log" and friends learned "--dd" that is a short-hand for
 "--diff-merges=first-parent -p".

 Will merge to 'master'.
 source: <20231009160535.236523-1-sorganov@gmail.com>


* jc/update-list-references-to-lore (2023-10-06) 1 commit
  (merged to 'next' on 2023-10-19 at 83a721a137)
 + doc: update list archive reference to use lore.kernel.org

 Doc update.

 Will merge to 'master'.
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


* ak/color-decorate-symbols (2023-10-19) 7 commits
 - log: show pseudorefs in decorations
 - refs: exempt pseudoref patterns from prefixing
 - log: add color.decorate.ref option for other refs
 - refs: separate decoration type from default filter
 - log: add color.decorate.symbol config option
 - log: use designated inits for decoration_colors
 - config: restructure color.decorate documentation

 A new config for coloring.

 Needs review.
 source: <20231003205442.22963-1-andy.koppe@gmail.com>


* jc/attr-tree-config (2023-10-13) 2 commits
  (merged to 'next' on 2023-10-19 at 202dc1c453)
 + attr: add attr.tree for setting the treeish to read attributes from
 + attr: read attributes from HEAD when bare repo

 The attribute subsystem learned to honor `attr.tree` configuration
 that specifies which tree to read the .gitattributes files from.

 Will merge to 'master'.
 source: <pull.1577.v5.git.git.1697218770.gitgitgadget@gmail.com>


* js/update-urls-in-doc-and-comment (2023-09-26) 4 commits
 - doc: refer to internet archive
 - doc: update links for andre-simon.de
 - doc: update links to current pages
 - doc: switch links to https

 Stale URLs have been updated to their current counterparts (or
 archive.org) and HTTP links are replaced with working HTTPS links.

 Needs review.
 source: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>


* la/trailer-cleanups (2023-10-20) 3 commits
 - trailer: use offsets for trailer_start/trailer_end
 - trailer: find the end of the log message
 - commit: ignore_non_trailer computes number of bytes to ignore

 Code clean-up.

 Will merge to 'next'?
 source: <pull.1563.v5.git.1697828495.gitgitgadget@gmail.com>


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


* js/doc-unit-tests (2023-10-16) 5 commits
 - fixup! ci: run unit tests in CI
 - fixup! unit tests: add TAP unit test framework
 - ci: run unit tests in CI
 - unit tests: add TAP unit test framework
 - unit tests: add a project plan document
 (this branch is used by js/doc-unit-tests-with-cmake.)

 Process to add some form of low-level unit tests has started.

 Expecting a (hopefully final and minor) reroll.
 cf. <20231016134421.21659-1-phillip.wood123@gmail.com>
 source: <cover.1696889529.git.steadmon@google.com>


* js/doc-unit-tests-with-cmake (2023-10-19) 7 commits
 - cmake: handle also unit tests
 - cmake: use test names instead of full paths
 - cmake: fix typo in variable name
 - artifacts-tar: when including `.dll` files, don't forget the unit-tests
 - unit-tests: do show relative file paths
 - unit-tests: do not mistake `.pdb` files for being executable
 - cmake: also build unit tests
 (this branch uses js/doc-unit-tests.)

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


* rj/status-bisect-while-rebase (2023-10-16) 1 commit
 - status: fix branch shown when not only bisecting

 "git status" is taught to show both the branch being bisected and
 being rebased when both are in effect at the same time.

 Needs review.
 source: <2e24ca9b-9c5f-f4df-b9f8-6574a714dfb2@gmail.com>

--------------------------------------------------
[Discarded]

* jc/doc-unit-tests-fixup (2023-10-11) 1 commit
 . SQUASH???
 (this branch uses js/doc-unit-tests and js/doc-unit-tests-with-cmake.)

 Quick fix for jc/doc-unit-tests topic to unbreak CI running on 'seen'.

 Superseded by a fixup! in the base series.
 source: <xmqqwmvskf8t.fsf@gitster.g>
