Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856318787F
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732522085; cv=none; b=JyLXOvQwsKOs6FtrM4vqPc/DounFqp9gWyeu1gUsxgJu8nA6vzRHzbKNaYLV9KDCyFL0HEfD4O3t7K+Kl5ghVKXcTgF5YWxwb/D5xAbMPmf8dq/WExv4kdlRa/vPQvJHatvjQEBYnWVtLRkpLH2hk4s1vVsf7NDf0oeIYPTC1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732522085; c=relaxed/simple;
	bh=NTga8ihc8IyEdeplsR918oRPPdjb35Nbjzjlp/GxVAk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IjsiSc3Jfx/GeH5y3RpHxOutIapUP/Ejq5x/o9fQqmsjKkc0YrSwwuIV0ZujosmXvRYLMeLV8zEH4iegIw/MGy4Xu/OkULPo6gReoaON60wtriwA31Q0JKGgqU0Xm83JlV43+Bp8Xodp+VZ6V8g9I1P9TJ9AUQkZSyKE0Ng/Tvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AsHkrJB1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AsHkrJB1"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 94AE2138012D;
	Mon, 25 Nov 2024 03:08:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 25 Nov 2024 03:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732522081; x=1732608481; bh=K8P82mu92MK2+tPlco2pX3mIezqiGW2XdIi
	veeuJ3Cg=; b=AsHkrJB1L8PmM5pzrpFoVU7L9MjcKhQYZUoHuF3uySwQTU2w6eX
	UK4g9O/hqTeIsnnYUn18FbctPnuPYr9VSU87YpYUHXBylzaKW6Mo8/cU5AiXcjaa
	xVh7hAt7BKiWS2lK5NCNMfQ3eoQTDTO3JCGiPImgJVbh5CVMCu0d/eLdC+QOsp6e
	x9GtTXJ/ZZeETC9INiO5DI+af2nmcs2Sa0uvibLWYzq9Qlai8PURgq/Ez8iI+oTn
	NuOC5fNzswwMrTjDKp9Mxozu5SuuWBl3q0BnQCbPZFSeAOLBWv+q2wixAUxHghQw
	i9EINiwSxVu08rD+8eJUFVcJQSReczID5ig==
X-ME-Sender: <xms:YTBEZ378RsQQbeiZgGqWstfqr73mmX02q-90TZHU8J1xgDeSxg7G3A>
    <xme:YTBEZ87RMKkc0_XevqxGN_YUJaoqea6ILwPRw0hdtkzV4LA2mM1uqk1crvExba2yc
    kLlnO7EHvX0LRa6Zg>
X-ME-Received: <xmr:YTBEZ-fAkOtQThhRa8B2izYoq1OXiL3enGX1Nt5cJnpOy5R0BM2Hb-jgPLgMcgfJdrkjvqZ7goT59qfTIYPRz0G81BMAw1n6386KxXk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcu
    oehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefgudefje
    dvjedtvdfghedtieeuueegleetjeffledvgfeftdfhfeetudejveevfeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhorhdrtgiipdhgohhoghhlvghsohhurhgtvgdrtghomh
    dpghhithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhdpphhkshdrihhmnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlfi
    hnsehlfihnrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YTBEZ4IYycUZFDcVrpNStMO_9RQBRnA53pC4rrOMH6iTI2t0szhnmw>
    <xmx:YTBEZ7L_v3Llcx_v17Vt5RVjbjys5DUIqtUHGMQrAcjTALIFn-F0Pw>
    <xmx:YTBEZxxnePBvYzJWdOcUTjVr0D0we-uYaPZlyhNMVjvRuvy-ifwfUQ>
    <xmx:YTBEZ3KgVFhD4gggbrbNObPzNHtVLKmmNhtwH_zIAOXhuObEu4BdVQ>
    <xmx:YTBEZz0URPiVlyMll9N_V-dAQDQjX6FE87trKmXss49_AbKo-i3FTGYo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 03:08:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2024, #09; Mon, 25)
X-master-at: 6ea2d9d271a56afa0e77cd45796ea0592aa9c2d4
X-next-at: dd8b44aac527cac716a395b3fa3356e4ab8b63dd
Date: Mon, 25 Nov 2024 17:07:59 +0900
Message-ID: <xmqqttbv4ty8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Git 2.47.1 has been tagged; its primary purpose is to synchronise
the gitk subtree with that of J6t, the new maintainer of gitk.
Thanks Johaness for volunteering.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-scm/git/

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

* jc/doc-opt-tilde-expand (2024-11-25) 1 commit
 - doc: option value may be separate for valid reasons

 Doc update.

 Will merge to 'next'.
 source: <xmqqh67w6m4m.fsf@gitster.g>

--------------------------------------------------
[Cooking]

* kn/midx-wo-the-repository (2024-11-25) 11 commits
 - midx: inline the `MIDX_MIN_SIZE` definition
 - midx: pass down `hash_algo` to `get_split_midx_filename_ext`
 - midx: pass down `hash_algo` to `get_midx_filename[_ext]`
 - midx: pass `repository` to `load_multi_pack_index`
 - midx: cleanup internal usage of `the_repository` and `the_hash_algo`
 - midx-write: pass down repository to `write_midx_file[_only]`
 - write-midx: add repository field to `write_midx_context`
 - midx-write: use `revs->repo` inside `read_refs_snapshot`
 - midx-write: pass down repository to static functions
 - builtin: pass repository to sub commands
 - Merge branch 'kn/the-repository' into kn/midx-wo-the-repository
 (this branch uses kn/the-repository.)

 Yet another "pass the repository through the callchain" topic.

 Expecting a reroll.
 source: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>


* tb/unsafe-hash-test (2024-11-21) 2 commits
 - t/helper/test-tool: implement sha1-unsafe helper
 - t/helper/test-sha1: prepare for an unsafe mode

 Preliminary addition to the test tool to allow a plain SHA-1 hash
 algorithm without collision protection.

 Comments?
 source: <cover.1730833506.git.me@ttaylorr.com>


* jt/bundle-fsck (2024-11-22) 5 commits
 - transport: propagate fsck configuration during bundle fetch
 - fetch-pack: expose `fetch_pack_config_cb()`
 - fetch-pack: introduce `fetch_pack_options`
 - bundle: support fsck message configuration
 - bundle: add bundle verification options type

 "git bundle --unbundle" and "git clone" running on a bundle file
 both learned to trigger fsck over the new objects with configurable
 fck check levels.

 Expecting a reroll.
 source: <20241121204119.1440773-1-jltobler@gmail.com>


* tb/boundary-traversal-fix (2024-11-22) 1 commit
  (merged to 'next' on 2024-11-25 at f312b2f8eb)
 + pack-bitmap.c: typofix in `find_boundary_objects()`

 A trivial "correctness" fix that does not yet matter in practice.

 Will merge to 'master'.
 source: <cf49115db4e8dcd406a17c946659c2eef3ec6045.1732229420.git.me@ttaylorr.com>


* tb/use-test-file-size-more (2024-11-22) 1 commit
  (merged to 'next' on 2024-11-25 at 2bdd016a16)
 + t/perf: use 'test_file_size' in more places

 Use the right helper program to measure file size in performance tests.

 Will merge to 'master'.
 source: <50c1368630684f235548d2e9a68d4de3745b5fe6.1732220875.git.me@ttaylorr.com>


* bc/allow-upload-pack-from-other-people (2024-11-15) 1 commit
 - Allow cloning from repositories owned by another user

 Loosen overly strict ownership check introduced in the recent past,
 to keep the promise "cloning a suspicious repository is a safe
 first step to inspect it".

 Comments?
 source: <20241115005404.3747302-2-sandals@crustytoothpaste.net>


* kn/ref-transaction-hook-with-reflog (2024-11-15) 1 commit
  (merged to 'next' on 2024-11-20 at 23399887d7)
 + refs: don't invoke reference-transaction hook for reflogs

 The ref-transaction hook triggered for reflog updates, which has
 been corrected.

 Will merge to 'master'.
 source: <20241114-348-do-not-call-the-reference-transaction-hooks-for-reflogs-v1-1-ece7260ee3c1@gmail.com>


* bc/c23 (2024-11-18) 2 commits
  (merged to 'next' on 2024-11-20 at bd29255bf3)
 + reflog: rename unreachable
 + index-pack: rename struct thread_local

 C23 compatibility updates.

 Will merge to 'master'.
 source: <20241117013149.576671-1-sandals@crustytoothpaste.net>


* jk/gcc15 (2024-11-18) 6 commits
  (merged to 'next' on 2024-11-20 at fa92bcdeb9)
 + object-file: inline empty tree and blob literals
 + object-file: treat cached_object values as const
 + object-file: drop oid field from find_cached_object() return value
 + object-file: move empty_tree struct into find_cached_object()
 + object-file: drop confusing oid initializer of empty_tree struct
 + object-file: prefer array-of-bytes initializer for hash literals

 GCC 15 compatibility updates.

 Will merge to 'master'.
 source: <20241118095423.GA3990835@coredump.intra.peff.net>


* kh/trailer-in-glossary (2024-11-18) 1 commit
  (merged to 'next' on 2024-11-20 at fad433e2f4)
 + Documentation/glossary: describe "trailer"

 Doc updates.

 Will merge to 'master'.
 source: <ba35ba3ec212860a3151cfad582a384a50c55e6a.1731871683.git.code@khaugsbakk.name>


* en/fast-import-avoid-self-replace (2024-11-19) 1 commit
  (merged to 'next' on 2024-11-20 at 751ee6b395)
 + fast-import: avoid making replace refs point to themselves

 "git fast-import" can be tricked into a replace ref that maps an
 object to itself, which is a useless thing to do.

 Will merge to 'master'.
 source: <pull.1824.v2.git.1731968389590.gitgitgadget@gmail.com>


* jt/index-pack-allow-promisor-only-while-fetching (2024-11-20) 1 commit
  (merged to 'next' on 2024-11-20 at 9bd7657760)
 + index-pack: teach --promisor to forbid pack name

 We now ensure "index-pack" is used with the "--promisor" option
 only during a "git fetch".

 Will merge to 'master'.
 source: <20241119201016.22713-1-jonathantanmy@google.com>


* ps/gc-stale-lock-warning (2024-11-20) 1 commit
  (merged to 'next' on 2024-11-20 at 1099c31715)
 + builtin/gc: provide hint when maintenance hits a stale schedule lock

 Give a bit of advice/hint message when "git maintenance" stops finding a
 lock file left by another instance that still is potentially running.

 Will merge to 'master'.
 source: <20241119-pks-maintenance-hint-with-stale-lock-v1-1-f9f9a98e12a0@pks.im>


* tb/incremental-midx-part-2 (2024-11-20) 15 commits
 - midx: implement writing incremental MIDX bitmaps
 - pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
 - pack-bitmap.c: keep track of each layer's type bitmaps
 - ewah: implement `struct ewah_or_iterator`
 - pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
 - pack-bitmap.c: compute disk-usage with incremental MIDXs
 - pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
 - pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
 - pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
 - pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
 - pack-bitmap.c: open and store incremental bitmap layers
 - pack-revindex: prepare for incremental MIDX bitmaps
 - Documentation: describe incremental MIDX bitmaps
 - Merge branch 'tb/pseudo-merge-bitmap-fixes' into tb/incremental-midx-part-2
 - Merge branch 'tb/incremental-midx-part-1' into tb/incremental-midx-part-2

 Incrementally updating multi-pack index files.

 Needs review.
 source: <cover.1732054032.git.me@ttaylorr.com>


* ja/git-diff-doc-markup (2024-11-19) 5 commits
 - doc: git-diff: apply format changes to config part
 - doc: git-diff: apply format changes to diff-generate-patch
 - doc: git-diff: apply format changes to diff-format
 - doc: git-diff: apply format changes to diff-options
 - doc: git-diff: apply new documentation guidelines

 Documentation mark-up updates.

 Will merge to 'next'?
 source: <pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>


* ps/clar-build-improvement (2024-11-18) 4 commits
  (merged to 'next' on 2024-11-20 at d88840a15d)
 + Makefile: let clar header targets depend on their scripts
 + cmake: use verbatim arguments when invoking clar commands
 + cmake: use SH_EXE to execute clar scripts
 + t/unit-tests: convert "clar-generate.awk" into a shell script

 Fix for clar unit tests to support CMake build.

 Will merge to 'master'.
 source: <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>


* pb/mergetool-errors (2024-11-25) 5 commits
 - git-difftool--helper.sh: exit upon initialize_merge_tool errors
 - git-mergetool--lib.sh: add error message for unknown tool variant
 - git-mergetool--lib.sh: add error message if 'setup_user_tool' fails
 - git-mergetool--lib.sh: use TOOL_MODE when erroring about unknown tool
 - completion: complete '--tool-help' in 'git mergetool'

 End-user experience of "git mergetool" when the command errors out
 has been improved.

 Will merge to 'next'?
 source: <pull.1827.v2.git.1732305022.gitgitgadget@gmail.com>


* ps/send-pack-unhide-error-in-atomic-push (2024-11-15) 6 commits
 - push: not send push-options to server with --dry-run
 - push: only ignore finish_connect() for dry-run mode
 - t5543: atomic push reports exit code failure
 - t5504: modernize test by moving heredocs into test bodies
 - push: fix the behavior of the Done message for porcelain
 - t5548: new test cases for push --porcelain and --dry-run

 "git push --atomic --porcelain" used to ignore failures from the
 other side, losing the error status from the child process, which
 has been corrected.

 Needs review.
 source: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>


* ps/ref-backend-migration-optim (2024-11-21) 10 commits
  (merged to 'next' on 2024-11-25 at ee2e588790)
 + reftable/block: optimize allocations by using scratch buffer
 + reftable/block: rename `block_writer::buf` variable
 + reftable/writer: optimize allocations by using a scratch buffer
 + refs: don't normalize log messages with `REF_SKIP_CREATE_REFLOG`
 + refs: skip collision checks in initial transactions
 + refs: use "initial" transaction semantics to migrate refs
 + refs/files: support symbolic and root refs in initial transaction
 + refs: introduce "initial" transaction flag
 + refs/files: move logic to commit initial transaction
 + refs: allow passing flags when setting up a transaction

 Optimize migration procedure between two ref backends.

 Will merge to 'master'.
 source: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>


* js/log-remerge-keep-ancestry (2024-11-12) 1 commit
 - log: --remerge-diff needs to keep around commit parents

 "git log -p --remerge-diff --reverse" was completely broken.

 Expecting a hopefully small and final reroll.
 cf. <xmqqa5e5berx.fsf@gitster.g>
 source: <pull.1825.v2.git.1731350009491.gitgitgadget@gmail.com>


* ps/reftable-iterator-reuse (2024-11-19) 9 commits
 - refs/reftable: reuse iterators when reading refs
 - reftable/merged: drain priority queue on reseek
 - reftable/stack: add mechanism to notify callers on reload
 - refs/reftable: refactor reflog expiry to use reftable backend
 - refs/reftable: refactor reading symbolic refs to use reftable backend
 - refs/reftable: read references via `struct reftable_backend`
 - refs/reftable: handle reloading stacks in the reftable backend
 - refs/reftable: encapsulate reftable stack
 - Merge branch 'ps/reftable-detach' into ps/reftable-iterator-reuse
 (this branch uses ps/reftable-detach.)

 Optimize reading random references out of the reftable backend by
 allowing reuse of iterator objects.

 Expecting a reroll.
 cf. <ZzMaX8HCj3GO5JUJ@pks.im>
 source: <cover.1730792627.git.ps@pks.im>


* jc/move-is-bare-repository-cfg-variable-to-repo (2024-11-07) 3 commits
 - repository: BUG when is_bare_cfg is not initialized
 - setup: initialize is_bare_cfg
 - git: remove is_bare_repository_cfg global variable

 Code rewrite to turn the is_bare_repository_cfg global variable
 into a member in the the_repo singleton repository object.

 Waiting for response to reviews.
 source: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>


* jk/describe-perf (2024-11-07) 4 commits
 - describe: stop traversing when we run out of names
 - describe: stop digging for max_candidates+1
 - t/perf: add tests for git-describe
 - t6120: demonstrate weakness in disjoint-root handling

 "git describe" optimization.

 Comments?
 source: <20241106192236.GC880133@coredump.intra.peff.net>


* js/range-diff-diff-merges (2024-11-11) 1 commit
 - range-diff: optionally include merge commits' diffs in the analysis

 "git range-diff" learned to optionally show and compare merge
 commits in the ranges being compared, with the --diff-merges
 option.

 Almost there.
 cf. <CABPp-BHNVEvYx4KwmiSQhPqidhPffb5hGBt=uT5NKqBPXC4j0w@mail.gmail.com>
 source: <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>


* ps/leakfixes-part-10 (2024-11-21) 28 commits
  (merged to 'next' on 2024-11-25 at 7284f186b8)
 + t: remove TEST_PASSES_SANITIZE_LEAK annotations
 + test-lib: unconditionally enable leak checking
 + t: remove unneeded !SANITIZE_LEAK prerequisites
 + t: mark some tests as leak free
 + t5601: work around leak sanitizer issue
 + git-compat-util: drop now-unused `UNLEAK()` macro
 + global: drop `UNLEAK()` annotation
 + t/helper: fix leaking commit graph in "read-graph" subcommand
 + builtin/branch: fix leaking sorting options
 + builtin/init-db: fix leaking directory paths
 + builtin/help: fix leaks in `check_git_cmd()`
 + help: fix leaking return value from `help_unknown_cmd()`
 + help: fix leaking `struct cmdnames`
 + help: refactor to not use globals for reading config
 + builtin/sparse-checkout: fix leaking sanitized patterns
 + split-index: fix memory leak in `move_cache_to_base_index()`
 + git: refactor builtin handling to use a `struct strvec`
 + git: refactor alias handling to use a `struct strvec`
 + strvec: introduce new `strvec_splice()` function
 + line-log: fix leak when rewriting commit parents
 + bisect: fix various cases where we leak commit list items
 + bisect: fix leaking commit list items in `check_merge_base()`
 + bisect: fix multiple leaks in `bisect_next_all()`
 + bisect: fix leaking `current_bad_oid`
 + bisect: fix leaking string in `handle_bad_merge_base()`
 + bisect: fix leaking good/bad terms when reading multipe times
 + builtin/blame: fix leaking blame entries with `--incremental`
 + Merge branch 'ps/leakfixes-part-9' into ps/leakfixes-part-10

 Leakfixes.

 Will merge to 'master'.
 source: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>


* kh/sequencer-comment-char (2024-11-25) 3 commits
 - sequencer: comment commit messages properly
 - sequencer: comment `--reference` subject line properly
 - sequencer: comment checked-out branch properly

 The sequencer failed to honor core.commentString in some places.

 Will merge to 'next'?
 source: <cover.1732481200.git.code@khaugsbakk.name>


* ds/full-name-hash (2024-11-04) 7 commits
 - test-tool: add helper for name-hash values
 - pack-objects: disable --full-name-hash when shallow
 - p5313: add size comparison test
 - git-repack: update usage to match docs
 - pack-objects: add GIT_TEST_FULL_NAME_HASH
 - repack: add --full-name-hash option
 - pack-objects: add --full-name-hash option

 "git pack-objects" and its wrapper "git repack" learned an option
 to use an alternative path-hash function to improve delta-base
 selection to produce a packfile with deeper history than window
 size.

 Needs review.
 source: <pull.1823.git.1730775907.gitgitgadget@gmail.com>


* ds/path-walk-1 (2024-11-11) 6 commits
 - path-walk: mark trees and blobs as UNINTERESTING
 - path-walk: visit tags and cached objects
 - path-walk: allow consumer to specify object types
 - t6601: add helper for testing path-walk API
 - test-lib-functions: add test_cmp_sorted
 - path-walk: introduce an object walk by path

 Introduce a new API to visit objects in batches based on a common
 path, or by type.

 Comments?
 source: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>


* bc/ancient-ci (2024-11-01) 3 commits
 - Add additional CI jobs to avoid accidental breakage
 - ci: remove clause for Ubuntu 16.04
 - gitlab-ci: switch from Ubuntu 16.04 to 20.04

 Drop support for ancient environments in various CI jobs.

 Needs review.
 source: <20241031234934.3451390-1-sandals@crustytoothpaste.net>


* cw/worktree-extension (2024-11-01) 9 commits
 - worktree: refactor `repair_worktree_after_gitdir_move()`
 - worktree: add relative cli/config options to `repair` command
 - worktree: add relative cli/config options to `move` command
 - worktree: add relative cli/config options to `add` command
 - worktree: add `write_worktree_linking_files()` function
 - worktree: refactor infer_backlink return
 - worktree: add `relativeWorktrees` extension
 - setup: correctly reinitialize repository version
 - Merge branch 'cw/config-extensions' into cw/worktree

 Introduce a new repository extension to prevent older Git versions
 from mis-interpreting worktrees created with relative paths.

 Expecting a reroll.
 cf. <D5SS3P7WQG4F.1I20Z59IDQMD1@pm.me>
 source: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>


* kh/bundle-docs (2024-11-18) 4 commits
  (merged to 'next' on 2024-11-20 at d70c2c32ce)
 + Documentation/git-bundle.txt: discuss naïve backups
 + Documentation/git-bundle.txt: mention --all in spec. refs
 + Documentation/git-bundle.txt: remove old `--all` example
 + Documentation/git-bundle.txt: mention full backup example

 Documentation improvements to more prominently call out the use of
 '--all' when creating bundles.

 Will merge to 'master'.
 source: <cover.1731768344.git.code@khaugsbakk.name>


* as/show-index-uninitialized-hash (2024-11-11) 2 commits
 - t5300: add test for 'show-index --object-format'
 - show-index: fix uninitialized hash function

 Regression fix for 'show-index' when run outside of a repository.

 Comments?
 source: <20241109092739.14276-1-abhijeet.nkt@gmail.com>


* ps/reftable-detach (2024-11-19) 8 commits
 - reftable/system: provide thin wrapper for lockfile subsystem
 - reftable/stack: drop only use of `get_locked_file_path()`
 - reftable/system: provide thin wrapper for tempfile subsystem
 - reftable/stack: stop using `fsync_component()` directly
 - reftable/system: stop depending on "hash.h"
 - reftable: explicitly handle hash format IDs
 - reftable/system: move "dir.h" to its only user
 - Merge branch 'ps/reftable-strbuf' into ps/reftable-detach
 (this branch is used by ps/reftable-iterator-reuse.)

 Isolates the reftable subsystem from the rest of Git's codebase by
 using fewer pieces of Git's infrastructure.

 Needs review.
 source: <cover.1731943954.git.ps@pks.im>


* km/config-remote-by-name (2024-10-21) 1 commit
 - config: support remote name in includeIf.hasconfig condition

 Support conditionally including configuration by remote name, instead
 of just URL.

 Needs review.
 source: <20241020173216.40852-2-ken@kmatsui.me>


* y5/diff-pager (2024-10-21) 1 commit
 - diff: setup pager only before diff contents truly ready

 Delay setting up the pager in 'git diff' until after the diff contents
 itself is fully prepared.

 Needs review.
 source: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>


* bc/drop-ancient-libcurl-and-perl (2024-10-23) 12 commits
 - gitweb: make use of s///r
 - Require Perl 5.26.0
 - INSTALL: document requirement for libcurl 7.61.0
 - git-curl-compat: remove check for curl 7.56.0
 - git-curl-compat: remove check for curl 7.53.0
 - git-curl-compat: remove check for curl 7.52.0
 - git-curl-compat: remove check for curl 7.44.0
 - git-curl-compat: remove check for curl 7.43.0
 - git-curl-compat: remove check for curl 7.39.0
 - git-curl-compat: remove check for curl 7.34.0
 - git-curl-compat: remove check for curl 7.25.0
 - git-curl-compat: remove check for curl 7.21.5

 Drop support for older libcURL and Perl.

 Under discussion.
 source: <20241023004600.1645313-1-sandals@crustytoothpaste.net>


* es/oss-fuzz (2024-10-16) 3 commits
 - fuzz: port fuzz-url-decode-mem from OSS-Fuzz
 - fuzz: port fuzz-parse-attr-line from OSS-Fuzz
 - fuzz: port fuzz-credential-from-url-gently from OSS-Fuzz

 Backport oss-fuzz tests for us to our codebase.

 Needs review.
 source: <cover.1728939687.git.steadmon@google.com>


* bf/set-head-symref (2024-11-25) 10 commits
 - fetch set_head: handle mirrored bare repositories
 - fetch: set remote/HEAD if it does not exist
 - refs: add create_only option to refs_update_symref_extended
 - refs: add TRANSACTION_CREATE_EXISTS error
 - remote set-head: better output for --auto
 - remote set-head: refactor for readability
 - refs: atomically record overwritten ref in update_symref
 - refs: standardize output of refs_read_symbolic_ref
 - t/t5505-remote: test failure of set-head
 - t/t5505-remote: set default branch to main

 When "git fetch $remote" notices that refs/remotes/$remote/HEAD is
 missing and discovers what branch the other side points with its
 HEAD, refs/remotes/$remote/HEAD is updated to point to it.

 Will merge to 'next'?
 source: <20241122123138.66960-1-bence@ferdinandy.com>


* ps/build (2024-11-22) 25 commits
 - fixup! Makefile: propagate Git version via generated header
 - fixup! Makefile: generate doc versions via GIT-VERSION-GEN
 - meson: fix conflicts with in-flight topics
 - Introduce support for the Meson build system
 - Documentation: add comparison of build systems
 - t: allow overriding build dir
 - t: better support for out-of-tree builds
 - Documentation: extract script to generate a list of mergetools
 - Documentation: teach "cmd-list.perl" about out-of-tree builds
 - Documentation: allow sourcing generated includes from separate dir
 - Makefile: simplify building of templates
 - Makefile: allow "bin-wrappers/" directory to exist
 - Makefile: refactor generators to be PWD-independent
 - Makefile: extract script to generate gitweb.js
 - Makefile: extract script to generate gitweb.cgi
 - Makefile: extract script to massage Shell scripts
 - Makefile: use "generate-perl.sh" to massage Perl library
 - Makefile: extract script to massage Perl scripts
 - Makefile: consistently use PERL_PATH
 - Makefile: generate doc versions via GIT-VERSION-GEN
 - Makefile: generate "git.rc" via GIT-VERSION-GEN
 - Makefile: propagate Git version via generated header
 - Makefile: refactor GIT-VERSION-GEN to be reusable
 - Makefile: consistently use @PLACEHOLDER@ to substitute
 - Makefile: use common template for GIT-BUILD-OPTIONS

 Build procedure update plus introduction of Mason based builds

 Getting there.
 source: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>


* ej/cat-file-remote-object-info (2024-11-11) 6 commits
 - cat-file: add remote-object-info to batch-command
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - fetch-pack: move fetch initialization
 - fetch-pack: refactor packet writing
 - cat-file: add declaration of variable i inside its for loop

 "git cat-file --batch" and friends can optionally ask a remote
 server about objects it does not have.

 Needs review.
 source: <20241108162441.50736-1-eric.peijian@gmail.com>


* cc/promisor-remote-capability (2024-09-10) 4 commits
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2
 - strbuf: refactor strbuf_trim_trailing_ch()
 - version: refactor strbuf_sanitize()

 The v2 protocol learned to allow the server to advertise possible
 promisor remotes, and the client to respond with what promissor
 remotes it uses, so that the server side can omit objects that the
 client can lazily obtain from these other promissor remotes.

 Comments?  I got an impression that this is premature without
 finishing the discussion on a larger picture.
 cf. <ZvpZv_fed_su4w2-@pks.im>
 source: <20240910163000.1985723-1-christian.couder@gmail.com>


* sj/ref-contents-check (2024-11-21) 9 commits
  (merged to 'next' on 2024-11-25 at 53e29ae705)
 + ref: add symlink ref content check for files backend
 + ref: check whether the target of the symref is a ref
 + ref: add basic symref content check for files backend
 + ref: add more strict checks for regular refs
 + ref: port git-fsck(1) regular refs check for files backend
 + ref: support multiple worktrees check for refs
 + ref: initialize ref name outside of check functions
 + ref: check the full refname instead of basename
 + ref: initialize "fsck_ref_report" with zero

 "git fsck" learned to issue warnings on "curiously formatted" ref
 contents that have always been taken valid but something Git
 wouldn't have written itself (e.g., missing terminating end-of-line
 after the full object name).

 Will merge to 'master'.
 source: <Zz3MON9_9DGD6nsy@ArchLinux>


* js/libgit-rust (2024-10-16) 5 commits
 - Makefile: add option to build and test libgit-rs and libgit-rs-sys
 - libgit: add higher-level libgit crate
 - libgit-sys: also export some config_set functions
 - libgit-sys: introduce Rust wrapper for libgit.a
 - common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.

 Needs review.
 source: <cover.1729032373.git.steadmon@google.com>


* kn/the-repository (2024-11-25) 10 commits
 - packfile.c: remove unnecessary prepare_packed_git() call
 - midx: add repository to `multi_pack_index` struct
 - config: make `packed_git_(limit|window_size)` non-global variables
 - config: make `delta_base_cache_limit` a non-global variable
 - packfile: pass down repository to `for_each_packed_object`
 - packfile: pass down repository to `has_object[_kept]_pack`
 - packfile: pass down repository to `odb_pack_name`
 - packfile: pass `repository` to static function in the file
 - packfile: use `repository` from `packed_git` directly
 - packfile: add repository to struct `packed_git`
 (this branch is used by kn/midx-wo-the-repository.)

 Various implicit uses of 'the_repoository' in the packfile code
 have been eliminated.

 Will merge to 'next'?
 source: <cover.1732269840.git.karthik.188@gmail.com>
