Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7FF2066FD
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355177; cv=none; b=DYkRJjAFoCS2XM6cmgf080kLOPoNDyS2KwzXQFWRAJYrUduoZ2ElrZ5+wNrOPlZ7t60VCDbgPKwNDJQf6B+twS/fJNC85AMrQCtw5GgRISwbXmGi8+zeZ6EWFyj+/DC082nyU9eU75oWqTdwshq8hL4wLgNJhd+x/R1ymetEPXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355177; c=relaxed/simple;
	bh=0grv/Iey1e68eGbwRqeS7M7YT432X1wDJ7L1CtiR+q8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OlgCTgE03QFPRrs1qmp5DB7Qqa/TRd0PZCjR3dq4CuvT4G8ykiRZABnsWnUAsyKSoeQ6/tSprWABJXFAPHAnSyow+fsw5HdPQdhdnHHEA49lmsK8beLciNJ7gkojw4jNT6DL9JhiBMVsubH6hV8Iaxccvq8I3Rg/zNTWK5N/gPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvB3Qvyz; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvB3Qvyz"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5841311400FD;
	Wed,  4 Dec 2024 18:32:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 04 Dec 2024 18:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733355172; x=
	1733441572; bh=+yKtbhMN6LGpiEnpbfA7LTqCN+/Hf6eKU1ucSxOBmwA=; b=Z
	vB3QvyzWEG/P0MtGOaCFzVTlevJ+p7V8+7xcclkD0f8mZiVUPtVBxKnZA+MILKWK
	2snf2LlQaXYlO38I7kmEIABC810ZXhXCNn017LkYLFoIKp1FGJ8spbxsiRPSJqlx
	btwOAxzcV8WS6uZQgLns4+Gk1+pJNIxsq8FzwREEAIkN2VfC8ENbUUqu/ijGlhCS
	DCIJyK3R13LBJp+jUdj+dnhA+oQ3b33wnJO5n+WeeyXVY4yJeCB8Wh6Gfr/AbIv3
	B68MX9PcK61VNmwxt+Oy/vYqS+zbL07Eq3zeXlCoB2CJaFvQMz8WzyMsZcL3thyr
	H2BDOcUx2Ymts42ImWBKA==
X-ME-Sender: <xms:pOZQZyIKJGYonLf5zbYQv8bIGC9ti0DxQvWj9uRQJmRwUnlmtxw_JQ>
    <xme:pOZQZ6L4wPkUFtps1PxJ0q4hGvBjZ9Flvnv0IqMT3hsacyGPD94GVY_9mSQg7S_dt
    IE1DkMj5cAcqYoD1w>
X-ME-Received: <xmr:pOZQZyvBQ18GYJcIqeUaiZU6aoKxroXGKJLh7tgcUNC9LtkaOxCHERhHqZV8e0pAO-4f5-YbWmdaIGeeSlLoSNkRyat2ZsBhTYx79CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkf
    gfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehg
    ihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettdejheeuue
    elieelueeugefffedtteegueegueetfeegveduudeiieeivdekvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgpdhorhdrtgiipdhgohhoghhlvghsohhurhgtvgdrtghomhdpgh
    hithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhdpphhkshdrihhmpdhmrghkrdguvghv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlfihnsehlfihnrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:pOZQZ3ZN7RGw8Ngkl58ntR0iK0RIjMrwHAa44mCRYKwJ1ZTtUYHajw>
    <xmx:pOZQZ5bDrc7hf9bwmLw9PuljrrF24rCrD9pL0WCuLfo7lmfASfxT3w>
    <xmx:pOZQZzCn4wC2-Ke8eu9RqECFK5i_ieF-0YZ73GhbZt2kKv0ShgIVpA>
    <xmx:pOZQZ_bgABzths6PRihTGBY7st86DbEff0OhcMByhpn3yJw7U1G74Q>
    <xmx:pOZQZ9HCx2G_fRvpVECiupV6d01WSG084GY3XY2_1k6ESK6iibGp4UyY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Dec 2024 18:32:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2024, #02; Thu, 5)
X-master-at: 23692e08c638df0de3344357658fb7e6fd20d931
X-next-at: a4f8a869558d59677e8d9798666a23391f0b4ca8
Date: Thu, 05 Dec 2024 08:32:50 +0900
Message-ID: <xmqqy10v10t9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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
[Graduated to 'master']

* bc/drop-ancient-libcurl-and-perl (2024-10-23) 12 commits
  (merged to 'next' on 2024-11-27 at aa7866a3ab)
 + gitweb: make use of s///r
 + Require Perl 5.26.0
 + INSTALL: document requirement for libcurl 7.61.0
 + git-curl-compat: remove check for curl 7.56.0
 + git-curl-compat: remove check for curl 7.53.0
 + git-curl-compat: remove check for curl 7.52.0
 + git-curl-compat: remove check for curl 7.44.0
 + git-curl-compat: remove check for curl 7.43.0
 + git-curl-compat: remove check for curl 7.39.0
 + git-curl-compat: remove check for curl 7.34.0
 + git-curl-compat: remove check for curl 7.25.0
 + git-curl-compat: remove check for curl 7.21.5

 Drop support for older libcURL and Perl.
 source: <20241023004600.1645313-1-sandals@crustytoothpaste.net>


* ja/git-diff-doc-markup (2024-11-19) 5 commits
  (merged to 'next' on 2024-11-27 at b33b5ae49b)
 + doc: git-diff: apply format changes to config part
 + doc: git-diff: apply format changes to diff-generate-patch
 + doc: git-diff: apply format changes to diff-format
 + doc: git-diff: apply format changes to diff-options
 + doc: git-diff: apply new documentation guidelines

 Documentation mark-up updates.
 source: <pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>


* kn/pass-repo-to-builtin-sub-sub-commands (2024-11-26) 1 commit
  (merged to 'next' on 2024-11-27 at 668c0913f5)
 + builtin: pass repository to sub commands
 (this branch is used by kn/midx-wo-the-repository.)

 Built-in Git subcommands are supplied the repository object to work
 with; they learned to do the same when they invoke sub-subcommands.
 source: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>


* ps/bisect-double-free-fix (2024-11-26) 2 commits
  (merged to 'next' on 2024-11-27 at e163bce018)
 + bisect: address Coverity warning about potential double free
 + Merge branch 'ps/leakfixes-part-10' into ps/bisect-double-free-fix
 (this branch uses ps/leakfixes-part-10.)

 Work around Coverity warning that would not trigger in practice.
 source: <20241125-pks-leak-fixes-address-double-free-v1-1-d33fd8ebf55b@pks.im>


* ps/gc-stale-lock-warning (2024-11-25) 2 commits
  (merged to 'next' on 2024-11-26 at ed3858b2ea)
 + t7900: fix host-dependent behaviour when testing git-maintenance(1)
  (merged to 'next' on 2024-11-20 at 1099c31715)
 + builtin/gc: provide hint when maintenance hits a stale schedule lock

 Give a bit of advice/hint message when "git maintenance" stops finding a
 lock file left by another instance that still is potentially running.
 source: <20241119-pks-maintenance-hint-with-stale-lock-v1-1-f9f9a98e12a0@pks.im>
 source: <eb504a75147d8609be66e131d239a69d192d693d.1732511129.git.ps@pks.im>


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
 (this branch is used by ps/bisect-double-free-fix and rj/strvec-splice-fix.)

 Leakfixes.
 source: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>


* ps/ref-backend-migration-optim (2024-11-26) 12 commits
  (merged to 'next' on 2024-11-26 at 7bb66a1faf)
 + reftable: rename scratch buffer
 + refs: adapt `initial_transaction` flag to be unsigned
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

 The migration procedure between two ref backends has been optimized.
 source: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
 source: <20241125-pks-refs-migration-optimization-followup-v1-0-0e1b4a2af384@pks.im>


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
 source: <Zz3MON9_9DGD6nsy@ArchLinux>


* tb/boundary-traversal-fix (2024-11-22) 1 commit
  (merged to 'next' on 2024-11-25 at f312b2f8eb)
 + pack-bitmap.c: typofix in `find_boundary_objects()`

 A trivial "correctness" fix that does not yet matter in practice.
 source: <cf49115db4e8dcd406a17c946659c2eef3ec6045.1732229420.git.me@ttaylorr.com>


* tb/use-test-file-size-more (2024-11-22) 1 commit
  (merged to 'next' on 2024-11-25 at 2bdd016a16)
 + t/perf: use 'test_file_size' in more places

 Use the right helper program to measure file size in performance tests.
 source: <50c1368630684f235548d2e9a68d4de3745b5fe6.1732220875.git.me@ttaylorr.com>

--------------------------------------------------
[New Topics]

* jt/fix-fattening-promisor-fetch (2024-12-04) 4 commits
 - index-pack: work around false positive use of uninitialized variable
 - index-pack --promisor: also check commits' trees
 - index-pack --promisor: don't check blobs
 - index-pack --promisor: dedup before checking links

 Fix performance regression of a recent "fatten promisor pack with
 local objects" protection against an unwanted gc.

 Need to squash the fix-up at the tip.
 source: <cover.1733262661.git.jonathantanmy@google.com>


* kk/doc-ancestry-path (2024-12-04) 1 commit
 - doc: mention rev-list --ancestry-path restrictions

 The --ancestry-path option is designed to be given a commit that is
 on the path, which was not documented, which has been corrected.

 Will merge to 'next'.
 source: <CADYQcGrD5KtM1sZQbccAtDaLmUXD8Gxv_nUWmapjfZm=TMq=Jw@mail.gmail.com>

--------------------------------------------------
[Cooking]

* kh/doc-bundle-typofix (2024-12-02) 1 commit
  (merged to 'next' on 2024-12-04 at 5da441ce36)
 + Documentation/git-bundle.txt: fix word join typo

 Typofix.

 Will merge to 'master'.
 source: <164b94bab9214f6030909df8f1e7c476b7f79e55.1732822997.git.code@khaugsbakk.name>


* kh/doc-update-ref-grammofix (2024-12-02) 1 commit
  (merged to 'next' on 2024-12-04 at 9905f16afc)
 + Documentation/git-update-ref.txt: add missing word

 Grammofix.

 Will merge to 'master'.
 source: <6cc7a9d60216c966bcf77675aa22a39cfa8993e2.1732906187.git.code@khaugsbakk.name>


* ps/build-sign-compare (2024-12-04) 15 commits
 - sign-compare: 32-bit support
 - t/helper: don't depend on implicit wraparound
 - scalar: address -Wsign-compare warnings
 - builtin/patch-id: fix type of `get_one_patchid()`
 - builtin/blame: fix type of `length` variable when emitting object ID
 - gpg-interface: address -Wsign-comparison warnings
 - daemon: fix type of `max_connections`
 - daemon: fix loops that have mismatching integer types
 - global: trivial conversions to fix `-Wsign-compare` warnings
 - diff.h: fix index used to loop through unsigned integer
 - config.mak.dev: drop `-Wno-sign-compare`
 - global: mark code units that generate warnings with `-Wsign-compare`
 - compat/win32: fix -Wsign-compare warning in "wWinMain()"
 - compat/regex: explicitly ignore "-Wsign-compare" warnings
 - git-compat-util: introduce macros to disable "-Wsign-compare" warnings

 Start working to make the codebase buildable with -Wsign-compare.
 source: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>


* rj/strvec-splice-fix (2024-12-04) 2 commits
 - strvec: `strvec_splice()` to a statically initialized vector
 - Merge branch 'ps/leakfixes-part-10' into rj/strvec-splice-fix

 Correct strvec_splice() that misbehaved when the strvec is empty.
 source: <5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>


* jc/forbid-head-as-tagname (2024-12-03) 4 commits
 - tag: "git tag" refuses to use HEAD as a tagname
 - t5604: do not expect that HEAD can be a valid tagname
 - refs: drop strbuf_ prefix from helpers
 - refs: move ref name helpers around

 "git tag" has been taught to refuse to create refs/tags/HEAD
 as such a tag will be confusing in the context of UI provided by
 the Git Porcelain commands.

 Will merge to 'next'?
 source: <20241203023240.3852850-1-gitster@pobox.com>


* en/fast-import-verify-path (2024-12-04) 3 commits
 - t9300: test verification of renamed paths
  (merged to 'next' on 2024-12-02 at 2932fa51e4)
 + fast-import: disallow more path components
  (merged to 'next' on 2024-11-27 at 8b145bb543)
 + fast-import: disallow "." and ".." path components

 "git fast-import" learned to reject paths with ".."  and "." as
 their components to avoid creating invalid tree objects.

 Will merge to 'next' and then to 'master'.
 source: <pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com>
 source: <pull.1832.git.1732740464398.gitgitgadget@gmail.com>
 source: <20241203210652.GA1413195@coredump.intra.peff.net>


* sj/refs-symref-referent-fix (2024-11-27) 1 commit
  (merged to 'next' on 2024-11-28 at 65eba16b56)
 + ref-cache: fix invalid free operation in `free_ref_entry`

 A double-free that may not trigger in practice by luck has been
 corrected in the reference resolution code.

 Will merge to 'master'.
 source: <Z0Xd-cYPNNrxwuAB@ArchLinux>


* bf/fetch-set-head-config (2024-12-04) 5 commits
 - remote set-head: set followRemoteHEAD to "warn" if "always"
 - fetch set_head: add warn-if-not-$branch option
 - fetch set_head: move warn advice into advise_if_enabled
  (merged to 'next' on 2024-12-04 at 69bfc59fb5)
 + fetch: add configuration for set_head behaviour
 + Merge branch 'bf/set-head-symref' into bf/fetch-set-head-config
 (this branch uses bf/set-head-symref.)

 "git fetch" honors "remote.<remote>.followRemoteHEAD" settings to
 tweak the remote-tracking HEAD in "refs/remotes/<remote>/HEAD".

 Will merge to 'next'?
 source: <20241128230806.2058962-1-bence@ferdinandy.com>
 source: <20241204104003.514905-1-bence@ferdinandy.com>


* jc/doc-error-message-guidelines (2024-11-29) 1 commit
  (merged to 'next' on 2024-12-04 at 2d19ff44e5)
 + CodingGuidelines: a handful of error message guidelines

 Developer documentation update.

 Will merge to 'master'.
 source: <xmqqa5dkqjmr.fsf_-_@gitster.g>


* jc/doc-opt-tilde-expand (2024-11-25) 1 commit
  (merged to 'next' on 2024-12-02 at e345717b87)
 + doc: option value may be separate for valid reasons

 Describe a case where an option value needs to be spelled as a
 separate argument, i.e. "--opt val", not "--opt=val".

 Will merge to 'master'.
 source: <xmqqh67w6m4m.fsf@gitster.g>


* kn/midx-wo-the-repository (2024-12-04) 10 commits
 - midx: inline the `MIDX_MIN_SIZE` definition
 - midx: pass down `hash_algo` to functions using global variables
 - midx: pass `repository` to `load_multi_pack_index`
 - midx: cleanup internal usage of `the_repository` and `the_hash_algo`
 - midx-write: pass down repository to `write_midx_file[_only]`
 - write-midx: add repository field to `write_midx_context`
 - midx-write: use `revs->repo` inside `read_refs_snapshot`
 - midx-write: pass down repository to static functions
 - Merge branch 'kn/pass-repo-to-builtin-sub-sub-commands' into kn/midx-wo-the-repository
 - Merge branch 'kn/the-repository' into kn/midx-wo-the-repository
 (this branch uses kn/the-repository.)

 Yet another "pass the repository through the callchain" topic.

 Will merge to 'next'.
 source: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>


* tb/unsafe-hash-test (2024-11-21) 2 commits
 - t/helper/test-tool: implement sha1-unsafe helper
 - t/helper/test-sha1: prepare for an unsafe mode

 Preliminary addition to the test tool to allow a plain SHA-1 hash
 algorithm without collision protection.

 Comments?
 cf. <xmqqr073antj.fsf@gitster.g>
 source: <cover.1730833506.git.me@ttaylorr.com>


* jt/bundle-fsck (2024-11-28) 4 commits
  (merged to 'next' on 2024-12-04 at bfd07a8936)
 + transport: propagate fsck configuration during bundle fetch
 + fetch-pack: split out fsck config parsing
 + bundle: support fsck message configuration
 + bundle: add bundle verification options type

 "git bundle --unbundle" and "git clone" running on a bundle file
 both learned to trigger fsck over the new objects with configurable
 fck check levels.

 Will merge to 'master'.
 cf. <Z08VoOHGZ1wecUx6@pks.im>
 source: <20241127233312.27710-1-jltobler@gmail.com>


* bc/allow-upload-pack-from-other-people (2024-11-15) 1 commit
  (merged to 'next' on 2024-12-02 at bf711f018c)
 + Allow cloning from repositories owned by another user

 Loosen overly strict ownership check introduced in the recent past,
 to keep the promise "cloning a suspicious repository is a safe
 first step to inspect it".

 Will merge to 'master'.
 cf. <xmqqed2yzc5z.fsf@gitster.g>
 source: <20241115005404.3747302-2-sandals@crustytoothpaste.net>


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


* pb/mergetool-errors (2024-11-25) 5 commits
  (merged to 'next' on 2024-12-02 at b439b146c2)
 + git-difftool--helper.sh: exit upon initialize_merge_tool errors
 + git-mergetool--lib.sh: add error message for unknown tool variant
 + git-mergetool--lib.sh: add error message if 'setup_user_tool' fails
 + git-mergetool--lib.sh: use TOOL_MODE when erroring about unknown tool
 + completion: complete '--tool-help' in 'git mergetool'

 End-user experience of "git mergetool" when the command errors out
 has been improved.

 Will merge to 'master'.
 source: <pull.1827.v2.git.1732305022.gitgitgadget@gmail.com>


* ps/send-pack-unhide-error-in-atomic-push (2024-11-14) 2 commits
 - transport: don't ignore git-receive-pack(1) exit code on atomic push
 - t5504: modernize test by moving heredocs into test bodies

 "git push --atomic --porcelain" used to ignore failures from the
 other side, losing the error status from the child process, which
 has been corrected.

 Needs review.
 source: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>


* js/log-remerge-keep-ancestry (2024-11-12) 1 commit
 - log: --remerge-diff needs to keep around commit parents

 "git log -p --remerge-diff --reverse" was completely broken.

 Expecting a hopefully small and final reroll.
 cf. <xmqqa5e5berx.fsf@gitster.g>
 source: <pull.1825.v2.git.1731350009491.gitgitgadget@gmail.com>


* ps/reftable-iterator-reuse (2024-11-26) 11 commits
  (merged to 'next' on 2024-12-02 at 3c1d2e2a6a)
 + refs/reftable: reuse iterators when reading refs
 + reftable/merged: drain priority queue on reseek
 + reftable/stack: add mechanism to notify callers on reload
 + refs/reftable: refactor reflog expiry to use reftable backend
 + refs/reftable: refactor reading symbolic refs to use reftable backend
 + refs/reftable: read references via `struct reftable_backend`
 + refs/reftable: figure out hash via `reftable_stack`
 + reftable/stack: add accessor for the hash ID
 + refs/reftable: handle reloading stacks in the reftable backend
 + refs/reftable: encapsulate reftable stack
 + Merge branch 'ps/reftable-detach' into ps/reftable-iterator-reuse
 (this branch uses ps/reftable-detach.)

 Optimize reading random references out of the reftable backend by
 allowing reuse of iterator objects.

 Will merge to 'master'.
 source: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>


* jc/move-is-bare-repository-cfg-variable-to-repo (2024-11-07) 3 commits
 - repository: BUG when is_bare_cfg is not initialized
 - setup: initialize is_bare_cfg
 - git: remove is_bare_repository_cfg global variable

 Code rewrite to turn the is_bare_repository_cfg global variable
 into a member in the the_repo singleton repository object.

 Waiting for response to reviews.
 cf. <xmqqy116xvr3.fsf@gitster.g>
 source: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>


* jk/describe-perf (2024-11-07) 4 commits
  (merged to 'next' on 2024-12-02 at 0f34109a85)
 + describe: stop traversing when we run out of names
 + describe: stop digging for max_candidates+1
 + t/perf: add tests for git-describe
 + t6120: demonstrate weakness in disjoint-root handling

 "git describe" optimization.

 Will merge to 'master'.
 source: <20241106192236.GC880133@coredump.intra.peff.net>


* js/range-diff-diff-merges (2024-11-11) 1 commit
 - range-diff: optionally include merge commits' diffs in the analysis

 "git range-diff" learned to optionally show and compare merge
 commits in the ranges being compared, with the --diff-merges
 option.

 Expecting a (hopefully final and) small reroll.
 cf. <eb502feb-1563-b1b5-5345-784673c89c79@gmx.de>
 source: <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>


* kh/sequencer-comment-char (2024-11-26) 3 commits
  (merged to 'next' on 2024-11-28 at 84693f6bb7)
 + sequencer: comment commit messages properly
 + sequencer: comment `--reference` subject line properly
 + sequencer: comment checked-out branch properly

 The sequencer failed to honor core.commentString in some places.

 Will merge to 'master'.
 source: <cover.1732565412.git.code@khaugsbakk.name>


* ds/name-hash-tweaks (2024-12-03) 8 commits
 - pack-objects: add third name hash version
 - pack-objects: prevent name hash version change
 - test-tool: add helper for name-hash values
 - p5313: add size comparison test
 - pack-objects: add GIT_TEST_NAME_HASH_VERSION
 - repack: add --name-hash-version option
 - pack-objects: add --name-hash-version option
 - pack-objects: create new name-hash function version

 "git pack-objects" and its wrapper "git repack" learned an option
 to use an alternative path-hash function to improve delta-base
 selection to produce a packfile with deeper history than window
 size.
 source: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>


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
 cf. <Z0V8D4r5YbxjNvPs@pks.im>
 source: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>


* bc/ancient-ci (2024-11-01) 3 commits
  (merged to 'next' on 2024-12-02 at f6128744ce)
 + Add additional CI jobs to avoid accidental breakage
 + ci: remove clause for Ubuntu 16.04
 + gitlab-ci: switch from Ubuntu 16.04 to 20.04

 Drop support for ancient environments in various CI jobs.

 Will merge to 'master'.
 source: <20241031234934.3451390-1-sandals@crustytoothpaste.net>


* cw/worktree-extension (2024-12-02) 8 commits
 - worktree: refactor `repair_worktree_after_gitdir_move()`
 - worktree: add relative cli/config options to `repair` command
 - worktree: add relative cli/config options to `move` command
 - worktree: add relative cli/config options to `add` command
 - worktree: add `write_worktree_linking_files()` function
 - worktree: refactor infer_backlink return
 - worktree: add `relativeWorktrees` extension
 - setup: correctly reinitialize repository version

 Introduce a new repository extension to prevent older Git versions
 from mis-interpreting worktrees created with relative paths.

 Will merge to 'next'.
 cf. <103c7a4d-a74b-4381-a9c7-33a89d5db192@gmail.com>
 source: <20241129-wt_relative_options-v6-0-44e4e0bec8c3@pm.me>


* as/show-index-uninitialized-hash (2024-11-11) 2 commits
 - t5300: add test for 'show-index --object-format'
 - show-index: fix uninitialized hash function

 Regression fix for 'show-index' when run outside of a repository.

 Comments?
 source: <20241109092739.14276-1-abhijeet.nkt@gmail.com>


* ps/reftable-detach (2024-11-19) 8 commits
  (merged to 'next' on 2024-12-02 at e105e787b6)
 + reftable/system: provide thin wrapper for lockfile subsystem
 + reftable/stack: drop only use of `get_locked_file_path()`
 + reftable/system: provide thin wrapper for tempfile subsystem
 + reftable/stack: stop using `fsync_component()` directly
 + reftable/system: stop depending on "hash.h"
 + reftable: explicitly handle hash format IDs
 + reftable/system: move "dir.h" to its only user
 + Merge branch 'ps/reftable-strbuf' into ps/reftable-detach
 (this branch is used by ps/reftable-iterator-reuse.)

 Isolates the reftable subsystem from the rest of Git's codebase by
 using fewer pieces of Git's infrastructure.

 Will merge to 'master'.
 source: <cover.1731943954.git.ps@pks.im>


* km/config-remote-by-name (2024-10-21) 1 commit
 - config: support remote name in includeIf.hasconfig condition

 Support conditionally including configuration by remote name, instead
 of just URL.

 Will discard?
 source: <20241020173216.40852-2-ken@kmatsui.me>


* y5/diff-pager (2024-10-21) 1 commit
 - diff: setup pager only before diff contents truly ready

 Delay setting up the pager in 'git diff' until after the diff contents
 itself is fully prepared.

 Will discard?
 source: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>


* es/oss-fuzz (2024-10-16) 3 commits
 - fuzz: port fuzz-url-decode-mem from OSS-Fuzz
 - fuzz: port fuzz-parse-attr-line from OSS-Fuzz
 - fuzz: port fuzz-credential-from-url-gently from OSS-Fuzz

 Backport oss-fuzz tests for us to our codebase.

 Will merge to 'next'.
 source: <cover.1728939687.git.steadmon@google.com>


* bf/set-head-symref (2024-11-25) 10 commits
  (merged to 'next' on 2024-12-02 at b142ff3d8e)
 + fetch set_head: handle mirrored bare repositories
 + fetch: set remote/HEAD if it does not exist
 + refs: add create_only option to refs_update_symref_extended
 + refs: add TRANSACTION_CREATE_EXISTS error
 + remote set-head: better output for --auto
 + remote set-head: refactor for readability
 + refs: atomically record overwritten ref in update_symref
 + refs: standardize output of refs_read_symbolic_ref
 + t/t5505-remote: test failure of set-head
 + t/t5505-remote: set default branch to main
 (this branch is used by bf/fetch-set-head-config.)

 When "git fetch $remote" notices that refs/remotes/$remote/HEAD is
 missing and discovers what branch the other side points with its
 HEAD, refs/remotes/$remote/HEAD is updated to point to it.

 Will merge to 'master'.
 source: <20241122123138.66960-1-bence@ferdinandy.com>


* ps/build (2024-12-02) 24 commits
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
 - Merge branch 'ps/clar-build-improvement' into ps/build

 Build procedure update plus introduction of Mason based builds

 Will merge to 'next'?
 source: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>


* ej/cat-file-remote-object-info (2024-11-25) 6 commits
 - cat-file: add remote-object-info to batch-command
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - fetch-pack: move fetch initialization
 - fetch-pack: refactor packet writing
 - cat-file: add declaration of variable i inside its for loop

 "git cat-file --batch" and friends can optionally ask a remote
 server about objects it does not have.

 Expecting a reroll.
 cf. <Z0RIrKwUnaWWm_gJ@pks.im>
 source: <20241125053616.25170-1-eric.peijian@gmail.com>


* js/libgit-rust (2024-10-16) 5 commits
 - Makefile: add option to build and test libgit-rs and libgit-rs-sys
 - libgit: add higher-level libgit crate
 - libgit-sys: also export some config_set functions
 - libgit-sys: introduce Rust wrapper for libgit.a
 - common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.

 Will discard?
 source: <cover.1729032373.git.steadmon@google.com>


* kn/the-repository (2024-12-04) 10 commits
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

 Will merge to 'next'.
 source: <cover.1733236936.git.karthik.188@gmail.com>
