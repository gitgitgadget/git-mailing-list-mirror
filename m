Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA48174EE4
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731714399; cv=none; b=Uh2AID3GzPWtBhcTlvoPD8C65Vbb+8veam31NvBo9R+SAoK1km+CKI8WbKpBFWPb1u6IFmgCaXswlVW83r+Ix/TCmgvE/Sz6FaIimxZ8zsjmLplWwzocEhCHAOPTljh16gIx55dB5dRNP93/wmN1wPZCSN+zSdoZMzZdoSm2Vng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731714399; c=relaxed/simple;
	bh=seuu4cTUMDSxP/PZw1ylCGHS5Q0T/Vplk7xpLCbX3rM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FhvFxuNYRoAVTYBZBubjScDrdINwu4VTtrGK1HJUEOc063hnOx1wh5ahdiAQ92h+ZQTrS9iHfjLz06a/wlEzr9pj5BqP4aEpjB6d7dufyUJRcZAttzWu8icbZO36TXRIeUWyMuvzlOxfY0XOlRnmkTIIahp3vrteRbjov30+U88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZZwNdg/m; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZwNdg/m"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 562C52540166;
	Fri, 15 Nov 2024 18:46:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 15 Nov 2024 18:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731714395; x=1731800795; bh=C8B4ridftCH5DHk78Mh2vyWlZQUH2x4VsxU
	VBVepSHw=; b=ZZwNdg/mVoJ3D2DsiE7uyR7/tw78MeTi3+6L+VKObGn6SgWel7n
	FtgFpKxlN9mBovZ/G6haLsmNyGGWc2bW5PESO9J4JBhM6+Y4iYHzXQqw53fRnpOy
	yl1fpEGxMefTXALtg2y/W0eZ2veWuemCh0mRV32ckL15x1sESbsnazcNBaKXMNBU
	c8TDcSn3wwNExL0AsrUEEOuLaM5HB3ciBLV6ff3jDTmUJ6aeYQRSUhmM7KpL2Du2
	1yBDaYSTvwuu3oBbpcBAL+eOROL/MUY36UBfq09tEu991+orZiHzWDj1sVnE83M7
	OYcgKCVcd8nGPjcPH7D9AjCTh1sFSff0LPA==
X-ME-Sender: <xms:Wt03Z14zU0OVIaylC2IlElKdaxVege9YpA6x4bR8Y_4Kiv5sdVHa9A>
    <xme:Wt03Zy5vMZG0F97FyIawun_YqmxRp9hAMyqfdLeF3jDIHDn43bxJlekwJ8zI5_utp
    b87qQ97P-6s3yRVsg>
X-ME-Received: <xmr:Wt03Z8cCuJUnUfLL8nxWT60NL3DGvJM_G-wIP1dGo-Po3cY0idGagB8ieVduk9uKcGDuxjJfyRvvRwyhMrsIdVADmB7KqI-1hTSj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdehgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkf
    gfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceo
    ghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepgfdufeejvd
    ejtddvgfehtdeiueeugeelteejffelvdfgfedthfeftedujeevveefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpohhrrdgtiidpghhoohhglhgvshhouhhrtggvrdgtohhmpd
    hgihhthhhusgdrtghomhdpghhithhlrggsrdgtohhmpdhpkhhsrdhimhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhifnh
    eslhifnhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Wt03Z-JkL3i7mEiLAuP66cJK3wp2FWvYEpm2HjWE6LsvyRsXfxpPSQ>
    <xmx:W903Z5LEbPnhoK3iLf4yjCkJYD61uhzUKh3YXWCnHJ-mIjDyufJjWQ>
    <xmx:W903Z3x6aT8Kznn_mKC70KsVNdLtiDkqrutZ83R_Gb7C9zJEo3SH_A>
    <xmx:W903Z1Ig4qjiexhvbo_Ke3N4vBb7--KCS5dSR2RK6IADR5jITJ2LZg>
    <xmx:W903Z50zQE2kazlaMSxxRo0kLsR_lapNnVp0RyOjuembOgzQat2bc-mZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 18:46:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2024, #06; Thu, 14)
X-master-at: 25b0f41288718625b18495de23cc066394c09a92
X-next-at: bc8a4e45283384156c5b1b511874d1a3b06e3306
Date: Sat, 16 Nov 2024 08:46:32 +0900
Message-ID: <xmqqy11kys9z.fsf@gitster.g>
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

A few commits to update git-gui are in.  There are still too many
topics that are left unreviewed, and the 'next' branch is not
gaining topics as quickly as it usually would.

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

* ak/t1016-style (2024-11-03) 1 commit
  (merged to 'next' on 2024-11-05 at ee100e90d3)
 + t1016: clean up style

 Test modernization.
 source: <20241103135111.13508-1-algonell@gmail.com>


* en/shallow-exclude-takes-a-ref-fix (2024-11-04) 2 commits
  (merged to 'next' on 2024-11-05 at 8c5d52930b)
 + doc: correct misleading descriptions for --shallow-exclude
 + upload-pack: fix ambiguous error message

 The "--shallow-exclude=<ref>" option to various history transfer
 commands takes a ref, not an arbitrary revision.
 source: <pull.1822.git.1730746964.gitgitgadget@gmail.com>


* jt/commit-graph-missing (2024-11-05) 2 commits
  (merged to 'next' on 2024-11-06 at b4dd083c2a)
 + fetch-pack: die if in commit graph but not obj db
 + Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"

 A regression where commit objects missing from a commit-graph can
 cause an infinite loop when doing a fetch in a partial clone has
 been fixed.
 source: <cover.1730833754.git.jonathantanmy@google.com>


* ps/leakfixes-part-9 (2024-11-04) 22 commits
  (merged to 'next' on 2024-11-05 at 0260dbd8bd)
 + list-objects-filter-options: work around reported leak on error
 + builtin/merge: release output buffer after performing merge
 + dir: fix leak when parsing "status.showUntrackedFiles"
 + t/helper: fix leaking buffer in "dump-untracked-cache"
 + t/helper: stop re-initialization of `the_repository`
 + sparse-index: correctly free EWAH contents
 + dir: release untracked cache data
 + combine-diff: fix leaking lost lines
 + builtin/tag: fix leaking key ID on failure to sign
 + transport-helper: fix leaking import/export marks
 + builtin/commit: fix leaking cleanup config
 + trailer: fix leaking strbufs when formatting trailers
 + trailer: fix leaking trailer values
 + builtin/commit: fix leaking change data contents
 + upload-pack: fix leaking URI protocols
 + pretty: clear signature check
 + diff-lib: fix leaking diffopts in `do_diff_cache()`
 + revision: fix leaking bloom filters
 + builtin/grep: fix leak with `--max-count=0`
 + grep: fix leak in `grep_splice_or()`
 + t/helper: fix leaks in "reach" test tool
 + builtin/ls-remote: plug leaking server options
 (this branch is used by ps/leakfixes-part-10.)

 More leakfixes.
 source: <cover.1730786195.git.ps@pks.im>


* ps/mingw-rename (2024-11-06) 3 commits
  (merged to 'next' on 2024-11-06 at 6dd2fffec7)
 + compat/mingw: support POSIX semantics for atomic renames
 + compat/mingw: allow deletion of most opened files
 + compat/mingw: share file handles created via `CreateFileW()`

 The MinGW compatibility layer has been taught to support POSIX
 semantics for atomic renames when other process(es) have a file
 opened at the destination path.
 cf. <1483501d-d798-46d6-93f5-f5edaf915e99@kdbg.org>
 source: <cover.1730042775.git.ps@pks.im>

--------------------------------------------------
[New Topics]

* ja/git-add-doc-markup (2024-11-12) 1 commit
  (merged to 'next' on 2024-11-13 at 1af6d17105)
 + doc: git-add.txt: convert to new style convention

 Documentation mark-up updates.

 Will merge to 'master'.
 source: <pull.1826.git.1731348891108.gitgitgadget@gmail.com>


* ja/git-diff-doc-markup (2024-11-12) 5 commits
 - doc: git-diff: apply format changes to config part
 - doc: git-diff: apply format changes to diff-generate-patch
 - doc: git-diff: apply format changes to diff-format
 - doc: git-diff: apply format changes to diff-options
 - doc: git-diff: apply new documentation guidelines

 Documentation mark-up updates.
 source: <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>


* jk/test-malloc-debug-check (2024-11-14) 2 commits
 - test-lib: move malloc-debug setup after $PATH setup
  (merged to 'next' on 2024-11-13 at 9aa0331ba1)
 + test-lib: check malloc debug LD_PRELOAD before using

 Avoid build/test breakage on a system without working malloc debug
 support dynamic library.

 Will merge to 'next'.
 source: <20241111070134.GA675125@coredump.intra.peff.net>
 source: <20241114012729.GA1148710@coredump.intra.peff.net>


* ps/clar-build-improvement (2024-11-12) 4 commits
 - Makefile: let clar header targets depend on their scripts
 - cmake: use verbatim arguments when invoking clar commands
 - cmake: use SH_EXE to execute clar scripts
 - t/unit-tests: convert "clar-generate.awk" into a shell script

 Fix for clar unit tests to support CMake build.

 Will merge to 'next'?
 source: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>


* jk/fetch-prefetch-double-free-fix (2024-11-12) 3 commits
 - refspec: store raw refspecs inside refspec_item
 - refspec: drop separate raw_nr count
 - fetch: adjust refspec->raw_nr when filtering prefetch refspecs

 Double-free fix.

 Will merge to 'next'.
 source: <20241112083204.GA2636868@coredump.intra.peff.net>


* pb/mergetool-errors (2024-11-13) 5 commits
 - git-difftool--helper.sh: exit upon initialize_merge_tool errors
 - git-mergetool--lib.sh: add error message for unknown tool variant
 - git-mergetool--lib.sh: add error message in 'setup_user_tool'
 - git-mergetool--lib.sh: use TOOL_MODE when erroring about unknown tool
 - completion: complete '--tool-help' in 'git mergetool'

 End-user experience of "git mergetool" when the command errors out
 has been improved.

 Will merge to next'?
 source: <pull.1827.git.1731459128.gitgitgadget@gmail.com>


* ps/send-pack-unhide-error-in-atomic-push (2024-11-14) 2 commits
 - transport: don't ignore git-receive-pack(1) exit code on atomic push
 - t5504: modernize test by moving heredocs into test bodies

 "git push --atomic --porcelain" used to ignore failures from the
 other side, losing the error status from the child process, which
 has been corrected.

 Comments?
 source: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>


* sm/difftool (2024-11-13) 1 commit
 - builtin/difftool: intialize some hashmap variables

 Use of some uninitialized variables in "git difftool" has been
 corrected.

 Will merge to 'next'.
 source: <20241112162320.818091-1-simon.marchi@polymtl.ca>


* tb/multi-pack-reuse-dupfix (2024-11-14) 2 commits
 - pack-objects: only perform verbatim reuse on the preferred pack
 - t5332-multi-pack-reuse.sh: demonstrate duplicate packing failure

 Object reuse code based on multi-pack-index sent an unwanted copy
 of object.

 Will merge to 'next'.
 source: <cover.1731518931.git.me@ttaylorr.com>

--------------------------------------------------
[Cooking]

* ps/ref-backend-migration-optim (2024-11-08) 10 commits
 - reftable/block: optimize allocations by using scratch buffer
 - reftable/block: rename `block_writer::buf` variable
 - reftable/writer: optimize allocations by using a scratch buffer
 - refs: don't normalize log messages with `REF_SKIP_CREATE_REFLOG`
 - refs: skip collision checks in initial transactions
 - refs: use "initial" transaction semantics to migrate refs
 - refs/files: support symbolic and root refs in initial transaction
 - refs: introduce "initial" transaction flag
 - refs/files: move logic to commit initial transaction
 - refs: allow passing flags when setting up a transaction

 Optimize migration procedure between two ref backends.

 Needs review.
 source: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>


* js/log-remerge-keep-ancestry (2024-11-12) 1 commit
 - log: --remerge-diff needs to keep around commit parents

 "git log -p --remerge-diff --reverse" was completely broken.

 Expecting a hopefully small and final reroll.
 cf. <xmqqa5e5berx.fsf@gitster.g>
 source: <pull.1825.v2.git.1731350009491.gitgitgadget@gmail.com>


* ps/reftable-iterator-reuse (2024-11-08) 9 commits
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

 Needs review.
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

 Expecting a reroll.
 cf <20241106192650.GA912471@coredump.intra.peff.net>
 source: <20241106192236.GC880133@coredump.intra.peff.net>


* js/range-diff-diff-merges (2024-11-11) 1 commit
 - range-diff: optionally include merge commits' diffs in the analysis

 "git range-diff" learned to optionally show and compare merge
 commits in the ranges being compared, with the --diff-merges
 option.

 Almost there.
 cf. <CABPp-BHNVEvYx4KwmiSQhPqidhPffb5hGBt=uT5NKqBPXC4j0w@mail.gmail.com>
 source: <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>


* ps/leakfixes-part-10 (2024-11-13) 28 commits
 - t: remove TEST_PASSES_SANITIZE_LEAK annotations
 - test-lib: unconditionally enable leak checking
 - t: remove unneeded !SANITIZE_LEAK prerequisites
 - t: mark some tests as leak free
 - t5601: work around leak sanitizer issue
 - git-compat-util: drop now-unused `UNLEAK()` macro
 - global: drop `UNLEAK()` annotation
 - t/helper: fix leaking commit graph in "read-graph" subcommand
 - builtin/branch: fix leaking sorting options
 - builtin/init-db: fix leaking directory paths
 - builtin/help: fix leaks in `check_git_cmd()`
 - help: fix leaking return value from `help_unknown_cmd()`
 - help: fix leaking `struct cmdnames`
 - help: refactor to not use globals for reading config
 - builtin/sparse-checkout: fix leaking sanitized patterns
 - split-index: fix memory leak in `move_cache_to_base_index()`
 - git: refactor builtin handling to use a `struct strvec`
 - git: refactor alias handling to use a `struct strvec`
 - strvec: introduce new `strvec_splice()` function
 - line-log: fix leak when rewriting commit parents
 - bisect: fix various cases where we leak commit list items
 - bisect: fix leaking commit list items in `check_merge_base()`
 - bisect: fix multiple leaks in `bisect_next_all()`
 - bisect: fix leaking `current_bad_oid`
 - bisect: fix leaking string in `handle_bad_merge_base()`
 - bisect: fix leaking good/bad terms when reading multipe times
 - builtin/blame: fix leaking blame entries with `--incremental`
 - Merge branch 'ps/leakfixes-part-9' into ps/leakfixes-part-10

 Leakfixes.

 Will merge to 'next'?
 source: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>


* kh/sequencer-comment-char (2024-11-13) 3 commits
 - sequencer: comment commit messages properly
 - sequencer: comment `--reference` subject line properly
 - sequencer: comment checked-out branch properly

 The sequencer failed to honor core.commentString in some places.

 Expecting a reroll to improve tests.
 cf. <5ed77fab-678d-4a06-bbd0-ea25462a7562@gmail.com>
 cf. <4c623fcf-01dd-4056-80c1-b3c860ab7f87@gmail.com>
 cf. <711b59d7-e649-4031-8924-a16fb632b4d4@gmail.com>
 source: <cover.1731406513.git.code@khaugsbakk.name>


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


* jt/repack-local-promisor (2024-11-12) 4 commits
  (merged to 'next' on 2024-11-13 at 895d633576)
 + index-pack: repack local links into promisor packs
 + t5300: move --window clamp test next to unclamped
 + t0410: use from-scratch server
 + t0410: make test description clearer

 "git gc" discards any objects that are outside promisor packs that
 are referred to by an object in a promisor pack, and we do not
 refetch them from the promisor at runtime, resulting an unusable
 repository.  Work it around by including these objects in the
 referring promisor pack at the receiving end of the fetch.

 Will merge to 'master'.
 source: <cover.1730491845.git.jonathantanmy@google.com>


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

 Needs review.
 source: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>


* kh/bundle-docs (2024-11-08) 4 commits
 - Documentation/git-bundle.txt: discuss naïve backups
 - Documentation/git-bundle.txt: mention --all in spec. refs
 - Documentation/git-bundle.txt: remove old `--all` example
 - Documentation/git-bundle.txt: mention full backup example

 Documentation improvements to more prominently call out the use of
 '--all' when creating bundles.

 Will merge to 'next'?
 source: <cover.1730979849.git.code@khaugsbakk.name>


* as/show-index-uninitialized-hash (2024-11-11) 2 commits
 - t5300: add test for 'show-index --object-format'
 - show-index: fix uninitialized hash function

 Regression fix for 'show-index' when run outside of a repository.

 Comments?
 source: <20241109092739.14276-1-abhijeet.nkt@gmail.com>


* ps/reftable-detach (2024-11-08) 8 commits
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
 source: <cover.1731047193.git.ps@pks.im>


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


* la/trailer-info (2024-10-14) 1 commit
  (merged to 'next' on 2024-11-13 at f038e226f6)
 + trailer: spread usage of "trailer_block" language

 Renaming a handful of variables and structure fields.

 Will merge to 'master'.
 source: <pull.1811.git.git.1728820722580.gitgitgadget@gmail.com>


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


* bf/set-head-symref (2024-10-23) 8 commits
 - fetch set_head: handle mirrored bare repositories
 - fetch: set remote/HEAD if it does not exist
 - refs: add create_only option to refs_update_symref_extended
 - refs: add TRANSACTION_CREATE_EXISTS error
 - remote set-head: better output for --auto
 - remote set-head: refactor for readability
 - refs: atomically record overwritten ref in update_symref
 - t/t5505-remote: set default branch to main

 When "git fetch $remote" notices that refs/remotes/$remote/HEAD is
 missing and discovers what branch the other side points with its
 HEAD, refs/remotes/$remote/HEAD is updated to point to it.

 Needs review.
 source: <20241023153736.257733-1-bence@ferdinandy.com>


* ps/build (2024-11-13) 19 commits
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
 - Makefile: refactor GIT-VERSION-GEN to be reusable
 - Makefile: extract script to generate gitweb.cgi
 - Makefile: extract script to massage Shell scripts
 - Makefile: use "generate-perl.sh" to massage Perl library
 - Makefile: extract script to massage Perl scripts
 - Makefile: consistently use PERL_PATH
 - Makefile: consistently use @PLACEHOLDER@ to substitute
 - Makefile: use common template for GIT-BUILD-OPTIONS

 Build procedure update plus introduction of Mason based builds

 Under discussion.
 source: <20241112-pks-meson-v6-0-648b30996827@pks.im>


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


* sj/ref-contents-check (2024-11-11) 9 commits
 - ref: add symlink ref content check for files backend
 - ref: check whether the target of the symref is a ref
 - ref: add basic symref content check for files backend
 - ref: add more strict checks for regular refs
 - ref: port git-fsck(1) regular refs check for files backend
 - ref: support multiple worktrees check for refs
 - ref: initialize ref name outside of check functions
 - ref: check the full refname instead of basename
 - ref: initialize "fsck_ref_report" with zero

 "git fsck" learned to issue warnings on "curiously formatted" ref
 contents that have always been taken valid but something Git
 wouldn't have written itself (e.g., missing terminating end-of-line
 after the full object name).

 Comments?
 source: <ZzCiCGxL4Adnd_eq@ArchLinux>


* js/libgit-rust (2024-10-16) 5 commits
 - Makefile: add option to build and test libgit-rs and libgit-rs-sys
 - libgit: add higher-level libgit crate
 - libgit-sys: also export some config_set functions
 - libgit-sys: introduce Rust wrapper for libgit.a
 - common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.

 Needs review.
 source: <cover.1729032373.git.steadmon@google.com>


* kn/the-repository (2024-11-12) 9 commits
 - midx: add repository to `multi_pack_index` struct
 - config: make `packed_git_(limit|window_size)` non-global variables
 - config: make `delta_base_cache_limit` a non-global variable
 - packfile: pass down repository to `for_each_packed_object`
 - packfile: pass down repository to `has_object[_kept]_pack`
 - packfile: pass down repository to `odb_pack_name`
 - packfile: pass `repository` to static function in the file
 - packfile: use `repository` from `packed_git` directly
 - packfile: add repository to struct `packed_git`

 Various implicit uses of 'the_repoository' in the packfile code
 have been eliminated.
 source: <cover.1731323350.git.karthik.188@gmail.com>
