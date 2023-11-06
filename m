Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4356B659
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 02:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X3eas2zE"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9167FB
	for <git@vger.kernel.org>; Sun,  5 Nov 2023 18:47:50 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D0462BF56;
	Sun,  5 Nov 2023 21:47:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Y
	j4tGdXvEJYS4zTVURbnKTkjkjE/nfOCpSZre1OQpEo=; b=X3eas2zE1t3AzvsUB
	hR9XHAKEyMBNDgCXrAScvpKyNonx0ka5tQ0ht2K2DhfElu7iOB/k4yAp5KGBteHb
	5lXdLmt9mYAKlnrj0OUC3Sljh+USFlnMIS4dKoblippt3ypcxMVQ0Fj8fHdb/gph
	nPTiPGatTnZKS+tFwqgT0j9XjE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8514B2BF55;
	Sun,  5 Nov 2023 21:47:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 064CA2BF52;
	Sun,  5 Nov 2023 21:47:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2023, #02; Mon, 6)
X-master-at: bc5204569f7db44d22477485afd52ea410d83743
X-next-at: f7406347cdb3b53eeb25238b9d8d215caf633a80
Date: Mon, 06 Nov 2023 11:47:43 +0900
Message-ID: <xmqq1qd3fvhs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DCE6252A-7C4E-11EE-AE2E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

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

* jw/git-add-attr-pathspec (2023-11-04) 1 commit
 - attr: enable attr pathspec magic for git-add and git-stash

 "git add" and "git stash" learned to support the ":(attr:...)"
 magic pathspec.

 Will merge to 'next'?
 source: <20231103163449.1578841-1-jojwang@google.com>


* la/strvec-header-fix (2023-11-03) 1 commit
  (merged to 'next' on 2023-11-03 at db23d8a911)
 + strvec: drop unnecessary include of hex.h

 Code clean-up.

 Will merge to 'master'.
 source: <pull.1608.git.1698958277454.gitgitgadget@gmail.com>


* jk/chunk-bounds (2023-11-04) 1 commit
  (merged to 'next' on 2023-11-06 at ae9fbc1700)
 + t: avoid perl's pack/unpack "Q" specifier

 Test portability fix.

 Will merge to 'master'.
 source: <20231103162019.GB1470570@coredump.intra.peff.net>


* js/ci-use-macos-13 (2023-11-03) 1 commit
  (merged to 'next' on 2023-11-06 at f7406347cd)
 + ci: upgrade to using macos-13

 Replace macos-12 used at GitHub CI with macos-13.

 Will merge to 'master'.
 source: <pull.1607.git.1698996455218.gitgitgadget@gmail.com>

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

* jc/strbuf-comment-line-char (2023-11-01) 4 commits
 - strbuf: move env-using functions to environment.c
 - strbuf: make add_lines() public
 - strbuf_add_commented_lines(): drop the comment_line_char parameter
 - strbuf_commented_addf(): drop the comment_line_char parameter

 Code simplification.
 source: <cover.1698791220.git.jonathantanmy@google.com>


* ps/show-ref (2023-11-01) 12 commits
  (merged to 'next' on 2023-11-02 at 987bb117f5)
 + t: use git-show-ref(1) to check for ref existence
 + builtin/show-ref: add new mode to check for reference existence
 + builtin/show-ref: explicitly spell out different modes in synopsis
 + builtin/show-ref: ensure mutual exclusiveness of subcommands
 + builtin/show-ref: refactor options for patterns subcommand
 + builtin/show-ref: stop using global vars for `show_one()`
 + builtin/show-ref: stop using global variable to count matches
 + builtin/show-ref: refactor `--exclude-existing` options
 + builtin/show-ref: fix dead code when passing patterns
 + builtin/show-ref: fix leaking string buffer
 + builtin/show-ref: split up different subcommands
 + builtin/show-ref: convert pattern to a local variable
 (this branch is used by ps/ref-tests-update.)

 Teach "git show-ref" a mode to check the existence of a ref.

 Will merge to 'master'.
 source: <cover.1698739941.git.ps@pks.im>


* rc/trace-upload-pack (2023-10-30) 1 commit
  (merged to 'next' on 2023-11-01 at 90892b5cf0)
 + upload-pack: add tracing for fetches

 Trace2 update.

 Will merge to 'master'.
 source: <pull.1598.v2.git.1697577168128.gitgitgadget@gmail.com>


* bc/merge-file-object-input (2023-11-02) 2 commits
  (merged to 'next' on 2023-11-02 at ccbba9416c)
 + merge-file: add an option to process object IDs
 + git-merge-file doc: drop "-file" from argument placeholders

 "git merge-file" learns a mode to read three contents to be merged
 from blob objects.

 Will merge to 'master'.
 source: <20231101192419.794162-1-sandals@crustytoothpaste.net>


* jc/test-i18ngrep (2023-11-02) 2 commits
  (merged to 'next' on 2023-11-03 at 78406f8d94)
 + tests: teach callers of test_i18ngrep to use test_grep
 + test framework: further deprecate test_i18ngrep

 Another step to deprecate test_i18ngrep.

 Will merge to 'master'.
 source: <20231031052330.3762989-1-gitster@pobox.com>


* an/clang-format-typofix (2023-11-01) 1 commit
  (merged to 'next' on 2023-11-02 at 7f639690ab)
 + clang-format: fix typo in comment

 Typofix.

 Will merge to 'master'.
 source: <pull.1602.v2.git.git.1698759629166.gitgitgadget@gmail.com>


* jk/tree-name-and-depth-limit (2023-11-02) 1 commit
  (merged to 'next' on 2023-11-06 at 041423344c)
 + max_tree_depth: lower it for MSVC to avoid stack overflows

 Further limit tree depth max to avoid Windows build running out of
 the stack space.

 Will merge to 'master'.
 source: <pull.1604.v2.git.1698843810814.gitgitgadget@gmail.com>


* ar/submitting-patches-doc-update (2023-10-24) 1 commit
  (merged to 'next' on 2023-10-30 at e140009eb6)
 + SubmittingPatches: call gitk's command "Copy commit reference"

 Doc update.

 Will merge to 'master'.
 source: <20231024195123.911431-1-rybak.a.v@gmail.com>


* es/bugreport-no-extra-arg (2023-10-29) 2 commits
  (merged to 'next' on 2023-11-01 at 4ca0a9c77c)
 + bugreport: reject positional arguments
 + t0091-bugreport: stop using i18ngrep

 "git bugreport" learned to complain when it received a command line
 argument that it will not use.

 Will merge to 'master'.
 source: <20231026155459.2234929-1-nasamuffin@google.com>


* js/my-first-contribution-update (2023-10-28) 1 commit
  (merged to 'next' on 2023-11-01 at 94590ee724)
 + Include gettext.h in MyFirstContribution tutorial

 Documentation update.

 Will merge to 'master'.
 source: <20231017041503.3249-1-jacob@initialcommit.io>


* ms/send-email-validate-fix (2023-10-26) 1 commit
  (merged to 'next' on 2023-11-01 at f9dd32186b)
 + send-email: move validation code below process_address_list

 "git send-email" did not have certain pieces of data computed yet
 when it tried to validate the outging messages and its recipient
 addresses, which has been sorted out.

 Will merge to 'master'.
 source: <ddd4bfdd-ed14-44f4-89d3-192332bbc1c4@amd.com>


* ps/ci-gitlab (2023-11-02) 8 commits
 - ci: add support for GitLab CI
 - ci: install test dependencies for linux-musl
 - ci: squelch warnings when testing with unusable Git repo
 - ci: unify setup of some environment variables
 - ci: split out logic to set up failed test artifacts
 - ci: group installation of Docker dependencies
 - ci: make grouping setup more generic
 - ci: reorder definitions for grouping functions

 Add support for GitLab CI.

 Comments?
 source: <cover.1698843660.git.ps@pks.im>


* ps/ref-tests-update (2023-11-03) 10 commits
 - t: mark several tests that assume the files backend with REFFILES
 - t7900: assert the absence of refs via git-for-each-ref(1)
 - t7300: assert exact states of repo
 - t4207: delete replace references via git-update-ref(1)
 - t1450: convert tests to remove worktrees via git-worktree(1)
 - t: convert tests to not access reflog via the filesystem
 - t: convert tests to not access symrefs via the filesystem
 - t: convert tests to not write references via the filesystem
 - t: allow skipping expected object ID in `ref-store update-ref`
 - Merge branch 'ps/show-ref' into ps/ref-tests-update
 (this branch uses ps/show-ref.)

 Update ref-related tests.

 Will merge to 'next'?
 source: <cover.1698914571.git.ps@pks.im>


* rs/fix-arghelp (2023-10-29) 1 commit
  (merged to 'next' on 2023-11-01 at cd923d3362)
 + am, rebase: fix arghelp syntax of --empty

 Doc and help update.

 Will merge to 'master'.
 source: <10e09b2d-15d7-4af1-b24c-217f9e2f457a@web.de>


* rs/parse-options-cmdmode (2023-10-29) 2 commits
  (merged to 'next' on 2023-11-01 at b83328f1e7)
 + am: simplify --show-current-patch handling
 + parse-options: make CMDMODE errors more precise

 parse-options improvements for OPT_CMDMODE options.

 Will merge to 'master'.
 source: <4520156b-9418-493c-a50c-e61b42e805b3@web.de>


* rs/reflog-expire-single-worktree-fix (2023-10-29) 1 commit
  (merged to 'next' on 2023-11-01 at 6b4dab2cd2)
 + reflog: fix expire --single-worktree

 "git reflog expire --single-worktree" has been broken for the past
 20 months or so, which has been corrected.

 Will merge to 'master'.
 source: <63eade0e-bf2c-4906-8b4c-689797cff737@web.de>


* jx/fetch-atomic-error-message-fix (2023-10-19) 2 commits
 - fetch: no redundant error message for atomic fetch
 - t5574: test porcelain output of atomic fetch

 "git fetch --atomic" issued an unnecessary empty error message,
 which has been corrected.

 Needs review.
 source: <ced46baeb1c18b416b4b4cc947f498bea2910b1b.1697725898.git.zhiyou.jx@alibaba-inc.com>


* js/bugreport-in-the-same-minute (2023-10-16) 1 commit
 - bugreport: include +i in outfile suffix as needed

 Instead of auto-generating a filename that is already in use for
 output and fail the command, `git bugreport` learned to fuzz the
 filename to avoid collisions with existing files.

 Expecting a reroll.
 cf. <ZTtZ5CbIGETy1ucV.jacob@initialcommit.io>
 source: <20231016214045.146862-2-jacob@initialcommit.io>


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

 Perhaps discard?
 cf. <655ca147-c214-41be-919d-023c1b27b311@app.fastmail.com>
 source: <cover.1697319294.git.code@khaugsbakk.name>


* tb/merge-tree-write-pack (2023-10-23) 5 commits
 - builtin/merge-tree.c: implement support for `--write-pack`
 - bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
 - bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
 - bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
 - bulk-checkin: extract abstract `bulk_checkin_source`

 "git merge-tree" learned "--write-pack" to record its result
 without creating loose objects.

 Will merge to 'next'?
 source: <cover.1698101088.git.me@ttaylorr.com>


* tb/format-pack-doc-update (2023-11-01) 2 commits
  (merged to 'next' on 2023-11-02 at 538991fe9b)
 + Documentation/gitformat-pack.txt: fix incorrect MIDX documentation
 + Documentation/gitformat-pack.txt: fix typo

 Doc update.

 Will merge to 'master'.
 source: <cover.1698780244.git.me@ttaylorr.com>


* ps/do-not-trust-commit-graph-blindly-for-existence (2023-11-01) 2 commits
  (merged to 'next' on 2023-11-01 at 06037376ee)
 + commit: detect commits that exist in commit-graph but not in the ODB
 + commit-graph: introduce envvar to disable commit existence checks
 (this branch is used by kn/rev-list-missing-fix.)

 The codepath to traverse the commit-graph learned to notice that a
 commit is missing (e.g., corrupt repository lost an object), even
 though it knows something about the commit (like its parents) from
 what is in commit-graph.

 Will merge to 'master'.
 source: <cover.1698736363.git.ps@pks.im>


* tb/pair-chunk-expect-size (2023-10-14) 8 commits
 - midx: read `OOFF` chunk with `pair_chunk_expect()`
 - midx: read `OIDL` chunk with `pair_chunk_expect()`
 - midx: read `OIDF` chunk with `pair_chunk_expect()`
 - commit-graph: read `BIDX` chunk with `pair_chunk_expect()`
 - commit-graph: read `GDAT` chunk with `pair_chunk_expect()`
 - commit-graph: read `CDAT` chunk with `pair_chunk_expect()`
 - commit-graph: read `OIDF` chunk with `pair_chunk_expect()`
 - chunk-format: introduce `pair_chunk_expect()` helper

 Code clean-up for jk/chunk-bounds topic.

 Comments?
 source: <45cac29403e63483951f7766c6da3c022c68d9f0.1697225110.git.me@ttaylorr.com>
 source: <cover.1697225110.git.me@ttaylorr.com>


* jc/grep-f-relative-to-cwd (2023-10-12) 1 commit
  (merged to 'next' on 2023-10-31 at 0d32547b18)
 + grep: -f <path> is relative to $cwd

 "cd sub && git grep -f patterns" tried to read "patterns" file at
 the top level of the working tree; it has been corrected to read
 "sub/patterns" instead.

 Will merge to 'master'.
 cf. <ZUAnEVk65VQQE263@nand.local>
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


* kn/rev-list-missing-fix (2023-11-01) 4 commits
  (merged to 'next' on 2023-11-02 at 2469dfc402)
 + rev-list: add commit object support in `--missing` option
 + rev-list: move `show_commit()` to the bottom
 + revision: rename bit to `do_not_die_on_missing_objects`
 + Merge branch 'ps/do-not-trust-commit-graph-blindly-for-existence' into kn/rev-list-missing-fix
 (this branch uses ps/do-not-trust-commit-graph-blindly-for-existence.)

 "git rev-list --missing" did not work for missing commit objects,
 which has been corrected.

 Will merge to 'master'.
 source: <20231026101109.43110-1-karthik.188@gmail.com>


* cc/git-replay (2023-11-03) 14 commits
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

 Will merge to 'next'?
 source: <20231102135151.843758-1-christian.couder@gmail.com>


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


* js/doc-unit-tests (2023-11-02) 3 commits
 - ci: run unit tests in CI
 - unit tests: add TAP unit test framework
 - unit tests: add a project plan document
 (this branch is used by js/doc-unit-tests-with-cmake.)

 Process to add some form of low-level unit tests has started.

 Will merge to 'next'?
 source: <cover.1698881249.git.steadmon@google.com>


* js/doc-unit-tests-with-cmake (2023-11-02) 7 commits
 - cmake: handle also unit tests
 - cmake: use test names instead of full paths
 - cmake: fix typo in variable name
 - artifacts-tar: when including `.dll` files, don't forget the unit-tests
 - unit-tests: do show relative file paths
 - unit-tests: do not mistake `.pdb` files for being executable
 - cmake: also build unit tests
 (this branch uses js/doc-unit-tests.)

 Update the base topic to work with CMake builds.

 Will merge to 'next'?
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
