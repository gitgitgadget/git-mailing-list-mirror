Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49944C79
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372005; cv=none; b=fkSqtMJ5fTa1URc+dcPdvYfyDfq3vCF7vz0Z+DOZ+gwdy3VFDmuhyt79rvrgVm7XnQY6C0LxAjMczPfI1dOHxP1/Nj1p61e4qxFC7V0Scu4NEEeO3q6+5vYImTMylOABXIt3ZUD1vCvqAdDOPSVUhzSBBwDYdX4wnBCTfNNOqKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372005; c=relaxed/simple;
	bh=CnQb184pF07KK7HhIkLUUa4VgL0kq7whLl8oL7DMOzk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jwdfOIptWWV9I3hSlYH/lzZwFHoC7VA7vuMxItNYNWwXZ4+KemvLg/Z26kq+aImdVQiVQj/+POFHbmpd+Mr31iUWWESdCtjMviKnfLp3LdCtbu/epEn9I+anNdz7b2wBxXisBm7JlVM85lvp+vfATLiBS4uO0A8tB8JVDKp4Enk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sv4gpvOt; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sv4gpvOt"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d8b679d7f2so1163635a91.1
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727372002; x=1727976802; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3MaoHOGJCrC5dkH8ml/NuIfQ1xft31Jqs97a0zp9ZPo=;
        b=Sv4gpvOtbKtqcXk/pgyeCtS58qkRjXN5LHHNsRkKXx+6nZThXMqeuVHqhp3tucTg7z
         fNGpdVIFi+o4Q+QUauNfNdKayenff8Gwo7Ph9hVODuVKQpU76n+acRRXapoiJK5oWP8v
         D8CRA3wD7Jy3x6IiSYhmOJn9IgRdWiF9Q4t/UXMJVc6yo1HibNtrGzMF4zIjKMUjWu1Y
         S+aOqb8oJQ66sX8Xf31AHyBaWncL5DuWmGkCc/VQyZwlyPYG7rxAAdklLM3k4ahAKpTa
         g0l3d3X2GCiEDrBuT1K4vPWH2O0B6WcQmYqZfoUZhq/+ENZmUBaYc+V2M6rqxboUc8x0
         0b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372002; x=1727976802;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MaoHOGJCrC5dkH8ml/NuIfQ1xft31Jqs97a0zp9ZPo=;
        b=TKpA5l7Iw5WYsvErJcuFAmcKIZ4TeQlGLdYPIY30SGD//cMI4N27MJxJYrqwktwukN
         oA9vjws3kSQS8nPJ0+a6MMli9tH2sYb0M+fhldNM3aZA10Kgl99IPWD6PTob88JUnGmx
         yb4PwFGigjRxUodXT0h5y/IE3jGeinYqnwSmpa0naECWn18Ej1lODmKP9XhECYu2unYm
         41Hkem91BKFc8G6rQwscPAkSSaQfL+9mAh7TGmZ5hz62dWbc/QEYx/T6yVFPUHDKagT5
         6AnZabwDm8sDKM6mewjCaXy0Wco4nFh6B/58eNvi9zC/JmI9JEibxgq4EJ+AhTrRE+o0
         QByg==
X-Gm-Message-State: AOJu0YxYV3rs8jLhSu/bom9Z60dcXxA1zpyQXLa1/PwREL2ODijZjCDJ
	FlczCFqJhvALqHr/teDRTGsTSOFJFrgaHWzhM7nq43m+zFsCWqxvJGD1mg==
X-Google-Smtp-Source: AGHT+IENJ6VtQL0CQyY4AydE+/Cx6+JV9sG/9JLNogUZnt9fkSIgIAIwfRIiq7hqSIbmfakfwx0Nnw==
X-Received: by 2002:a17:90a:e147:b0:2d8:a672:186d with SMTP id 98e67ed59e1d1-2e0b8b1bd0amr598990a91.20.1727372001534;
        Thu, 26 Sep 2024 10:33:21 -0700 (PDT)
Received: from localhost (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1e5ac1sm3799307a91.34.2024.09.26.10.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 10:33:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2024, #11; Thu, 26)
X-master-at: 3857aae53f3633b7de63ad640737c657387ae0c6
X-next-at: e261f169bdc0d967eadb9c1eae13d86b6873c213
Date: Thu, 26 Sep 2024 10:33:20 -0700
Message-ID: <xmqqploqjp5r.fsf@gitster.g>
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

An early preview release Git 2.47-rc0 has been tagged.

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

* ak/doc-sparse-co-typofix (2024-09-23) 1 commit
  (merged to 'next' on 2024-09-24 at 74edc0657c)
 + Documentation/technical: fix a typo

 Docfix.
 source: <20240920082815.8192-1-algonell@gmail.com>


* ak/typofix-builtins (2024-09-24) 1 commit
  (merged to 'next' on 2024-09-24 at d7702a68b7)
 + builtin: fix typos

 Typofix.
 source: <20240924130906.21392-1-algonell@gmail.com>


* cb/ci-freebsd-13-4 (2024-09-20) 1 commit
  (merged to 'next' on 2024-09-23 at 18be138bfd)
 + ci: update FreeBSD image to 13.4

 CI updates.
 source: <20240920201409.8723-1-carenas@gmail.com>


* jk/sendemail-mailmap-doc (2024-09-25) 1 commit
  (merged to 'next' on 2024-09-25 at d4f69efebf)
 + send-email: document --mailmap and associated configuration

 Docfix.
 source: <20240923222429.4102405-1-jacob.e.keller@intel.com>


* rs/diff-exit-code-binary (2024-09-23) 1 commit
  (merged to 'next' on 2024-09-24 at 1e597c407c)
 + diff: report modified binary files as changes in builtin_diff()

 "git diff --exit-code" ignored modified binary files, which has
 been corrected.
 source: <500a8e0a-9fbd-4b7b-b2f2-026a4293bc9f@web.de>

--------------------------------------------------
[Cooking]

* ds/sparse-checkout-expansion-advice (2024-09-23) 1 commit
 - sparse-checkout: disable advice in 'disable'

 When "git sparse-checkout disable" turns a sparse checkout into a
 regular checkout, the index is fully expanded.  This totally
 expected behaviour however had an "oops, we are expanding the
 index" advice message, which has been corrected.

 Comments?
 source: <pull.1800.git.1727119882901.gitgitgadget@gmail.com>


* ps/includeif-onbranch-cornercase-fix (2024-09-24) 2 commits
  (merged to 'next' on 2024-09-24 at 229c0bf0e5)
 + config: fix evaluating "onbranch" with nonexistent git dir
 + t1305: exercise edge cases of "onbranch" includes

 "git --git-dir=nowhere cmd" failed to properly notice that it
 wasn't in any repository while processing includeIf.onbranch
 configuration and instead crashed.

 Will merge to 'master'.
 source: <cover.1727171197.git.ps@pks.im>


* jk/http-leakfixes (2024-09-25) 28 commits
 - http-push: clean up local_refs at exit
 - http-push: clean up loose request when falling back to packed
 - http-push: clean up objects list
 - http-push: free xml_ctx.cdata after use
 - http-push: free remote_ls_ctx.dentry_name
 - http-push: free transfer_request strbuf
 - http-push: free transfer_request dest field
 - http-push: free curl header lists
 - http-push: free repo->url string
 - http-push: clear refspecs before exiting
 - http-walker: free fake packed_git list
 - remote-curl: free HEAD ref with free_one_ref()
 - http: stop leaking buffer in http_get_info_packs()
 - http: call git_inflate_end() when releasing http_object_request
 - http: fix leak of http_object_request struct
 - http: fix leak when redacting cookies from curl trace
 - transport-helper: fix leak of dummy refs_list
 - fetch-pack: clear pack lockfiles list
 - fetch: free "raw" string when shrinking refspec
 - transport-helper: fix strbuf leak in push_refs_with_push()
 - send-pack: free cas options before exit
 - commit: avoid leaking already-saved buffer
 - fetch-pack, send-pack: clean up shallow oid array
 - fetch-pack: free object filter before exiting
 - connect: clear child process before freeing in diagnostic mode
 - fetch-pack: fix leaking sought refs
 - shallow: fix leak when unregistering last shallow root
 - http-fetch: clear leaking git-index-pack(1) arguments

 Leakfixes.

 Needs review.
 source: <20240924214930.GA1143523@coredump.intra.peff.net>


* jk/test-lsan-improvements (2024-09-25) 3 commits
 - test-lib: check for leak logs after every test
 - test-lib: show leak-sanitizer logs on --immediate failure
 - test-lib: stop showing old leak logs

 Usability improvements for running tests in leak-checking mode.

 Needs review.
 source: <20240924213404.GA1142219@coredump.intra.peff.net>


* es/worktree-repair-copied (2024-09-23) 1 commit
 - worktree: repair copied repository and linked worktrees

 The heuristics in "git worktree repair" can be confused when a
 worktree and its repository are copied and break correctly
 configured worktree and repository that point at each other, which
 has been corrected.

 Needs review.
 source: <20240923075416.54289-1-ericsunshine@charter.net>


* rs/archive-with-attr-pathspec-fix (2024-09-23) 1 commit
  (merged to 'next' on 2024-09-24 at a81fb17e49)
 + archive: load index before pathspec checks

 "git archive" with pathspec magic that uses the attribute
 information did not work well, which has been corrected.

 Will merge to 'master'.
 source: <66c3e9fa-ecfe-4af2-a970-c1afdbc2b7f2@web.de>


* rs/commit-graph-ununleak (2024-09-23) 1 commit
  (merged to 'next' on 2024-09-24 at 5845eca9ce)
 + commit-graph: remove unnecessary UNLEAK

 Code clean-up.

 Will merge to 'master'.
 source: <c3a712d5-8e50-453d-be90-f5bf34de744c@web.de>


* cw/fix-reachable-in-repo-with-promisor (2024-09-19) 2 commits
 - fetch-pack.c: do not declare local commits as "have" in partial repos
 - packfile: split promisor objects oidset into two

 "git gc" in a partial clone (i.e. lacking objects that can be
 lazily fetched from promisor remotes) collected more than objects
 that promisor-remote can give.

 Needs review.
 source: <20240802073143.56731-1-hanyang.tony@bytedance.com>


* ds/background-maintenance-with-credential (2024-09-20) 3 commits
  (merged to 'next' on 2024-09-24 at 379a7a1003)
 + scalar: configure maintenance during 'reconfigure'
 + maintenance: add custom config to background jobs
 + credential: add new interactive config option

 Background tasks "git maintenance" runs may need to use credential
 information when going over the network, but a credential helper
 may work only in an interactive environment, and end up blocking a
 scheduled task waiting for UI.  Credential helpers can now behave
 differently when they are not running interactively.

 Will merge to 'master'.
 source: <pull.1798.git.1726790423.gitgitgadget@gmail.com>


* jc/breaking-changes-early-adopter-option (2024-09-19) 1 commit
 - BreakingChanges: early adopter option

 Describe the policy to introduce breaking changes.

 Comments?
 source: <xmqq7cb77810.fsf@gitster.g>


* ps/reftable-concurrent-writes (2024-09-24) 3 commits
  (merged to 'next' on 2024-09-24 at 04df72ad69)
 + refs/reftable: reload locked stack when preparing transaction
 + reftable/stack: allow locking of outdated stacks
 + refs/reftable: introduce "reftable.lockTimeout"

 Give timeout to the locking code to write to reftable.

 Will merge to 'master'.
 source: <cover.1727155858.git.ps@pks.im>


* pw/submodule-process-sigpipe (2024-09-20) 1 commit
  (merged to 'next' on 2024-09-24 at 9e1ce951c6)
 + submodule status: propagate SIGPIPE

 When a subprocess to work in a submodule spawned by "git submodule"
 fails with SIGPIPE, the parent Git process caught the death of it,
 but gave a generic "failed to work in that submodule", which was
 misleading.  We now behave as if the parent got SIGPIPE and die.

 Will merge to 'master'.
 source: <pull.1799.git.1726837642511.gitgitgadget@gmail.com>


* ps/leakfixes-part-7 (2024-09-16) 24 commits
 - diffcore-break: fix leaking filespecs when merging broken pairs
 - revision: fix leaking parents when simplifying commits
 - builtin/maintenance: fix leak in `get_schedule_cmd()`
 - builtin/maintenance: fix leaking config string
 - promisor-remote: fix leaking partial clone filter
 - grep: fix leaking grep pattern
 - submodule: fix leaking submodule ODB paths
 - trace2: destroy context stored in thread-local storage
 - builtin/difftool: plug several trivial memory leaks
 - builtin/repack: fix leaking configuration
 - diffcore-order: fix leaking buffer when parsing orderfiles
 - parse-options: free previous value of `OPTION_FILENAME`
 - diff: fix leaking orderfile option
 - builtin/pull: fix leaking "ff" option
 - dir: fix off by one errors for ignored and untracked entries
 - builtin/submodule--helper: fix leaking remote ref on errors
 - t/helper: fix leaking subrepo in nested submodule config helper
 - builtin/submodule--helper: fix leaking error buffer
 - builtin/submodule--helper: clear child process when not running it
 - submodule: fix leaking update strategy
 - git: fix leaking argv when handling builtins
 - builtin/help: fix leaking `html_path` when reading config multiple times
 - builtin/help: fix dangling reference to `html_path`
 - Merge branch 'ps/leakfixes-part-6' into ps/leakfixes-part-7

 More leak-fixes.

 Will merge to 'next'?
 cf. <ZulXjXSozNrXgMUM@pks.im>
 source: <cover.1726484308.git.ps@pks.im>


* ps/reftable-alloc-failures (2024-09-24) 24 commits
 - reftable: handle trivial allocation failures
 - reftable/tree: handle allocation failures
 - reftable/pq: handle allocation failures when adding entries
 - reftable/block: handle allocation failures
 - reftable/blocksource: handle allocation failures
 - reftable/iter: handle allocation failures when creating indexed table iter
 - reftable/stack: handle allocation failures in auto compaction
 - reftable/stack: handle allocation failures in `stack_compact_range()`
 - reftable/stack: handle allocation failures in `reftable_new_stack()`
 - reftable/stack: handle allocation failures on reload
 - reftable/reader: handle allocation failures in `reader_init_iter()`
 - reftable/reader: handle allocation failures for unindexed reader
 - reftable/merged: handle allocation failures in `merged_table_init_iter()`
 - reftable/writer: handle allocation failures in `reftable_new_writer()`
 - reftable/writer: handle allocation failures in `writer_index_hash()`
 - reftable/record: handle allocation failures when decoding records
 - reftable/record: handle allocation failures on copy
 - reftable/basics: handle allocation failures in `parse_names()`
 - reftable/basics: handle allocation failures in `reftable_calloc()`
 - reftable: introduce `reftable_strdup()`
 - reftable/basics: merge "publicbasics" into "basics"
 - reftable/error: introduce out-of-memory error code
 - Merge branch 'ps/reftable-exclude' into ps/reftable-alloc-failures
 - Merge branch 'cp/unit-test-reftable-stack' into ps/reftable-alloc-failures

 The reftable library is now prepared to expect that the memory
 allocation function given to it may fail to allocate and to deal
 with such an error.

 Will merge to 'next'?
 source: <cover.1727158127.git.ps@pks.im>


* jc/strbuf-commented-something (2024-09-12) 2 commits
 - strbuf: retire strbuf_commented_lines()
 - strbuf: retire strbuf_commented_addf()

 Update two functions whose callers always pass the same global
 variable to omit the redundant parameter and use the global in the
 callee themselves.

 On hold.
 source: <20240912205301.1809355-1-gitster@pobox.com>


* cc/promisor-remote-capability (2024-09-10) 4 commits
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2
 - strbuf: refactor strbuf_trim_trailing_ch()
 - version: refactor strbuf_sanitize()

 The v2 protocol learned to allow the server to advertise possible
 promisor remotes, and the client to respond with what promissor
 remotes it uses, so that the server side can omit objects that the
 client can lazily obtain from these other promissor remotes.

 Comments?
 source: <20240910163000.1985723-1-christian.couder@gmail.com>


* ds/pack-name-hash-tweak (2024-09-19) 6 commits
 - test-tool: add helper for name-hash values
 - p5313: add size comparison test
 - git-repack: update usage to match docs
 - pack-objects: add GIT_TEST_FULL_NAME_HASH
 - repack: test --full-name-hash option
 - pack-objects: add --full-name-hash option

 In a repository with too many (more than --window size) similarly
 named files, "git repack" would not find good delta-base candidate
 and worse, it may not use a blob from exactly the same path as a
 good delta-base candidate.  Optionally replace the name hash so
 that only blobs at the same path and nothing else are used as
 delta-base candidate.

 On hold.
 cf. <34346998-deac-4e1f-9d5f-218f664e9e08@gmail.com>
 source: <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>


* tb/weak-sha1-for-tail-sum (2024-09-24) 8 commits
 - csum-file.c: use unsafe SHA-1 implementation when available
 - Makefile: allow specifying a SHA-1 for non-cryptographic uses
 - hash.h: scaffolding for _unsafe hashing variants
 - sha1: do not redefine `platform_SHA_CTX` and friends
 - pack-objects: use finalize_object_file() to rename pack/idx/etc
 - finalize_object_file(): implement collision check
 - finalize_object_file(): refactor unlink_or_warn() placement
 - finalize_object_file(): check for name collision before renaming

 The checksum at the tail of files are now computed without
 collision detection protection.

 Needs review.
 source: <cover.1727199118.git.me@ttaylorr.com>


* gt/unit-test-oidset (2024-08-25) 1 commit
 - unit-tests: add tests for oidset.h

 Another unit-test.

 Expecting a reroll.
 source: <20240824172028.39419-1-shyamthakkar001@gmail.com>


* sj/ref-contents-check (2024-09-18) 5 commits
 - ref: add symlink ref content check for files backend
 - ref: add symref content check for files backend
 - ref: add more strict checks for regular refs
 - ref: port git-fsck(1) regular refs check for files backend
 - ref: initialize "fsck_ref_report" with zero

 "git fsck" learned to issue warnings on "curiously formatted" ref
 contents that have always been taken valid but something Git
 wouldn't have written itself (e.g., missing terminating end-of-line
 after the full object name).

 Needs review.
 source: <ZuRzCyjQFilGhj8j@ArchLinux>


* tb/incremental-midx-part-2 (2024-08-28) 16 commits
 - fixup! midx: implement writing incremental MIDX bitmaps
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

 Incremental updates of multi-pack index files.

 Needs review.
 source: <cover.1723760847.git.me@ttaylorr.com>


* js/libgit-rust (2024-09-09) 7 commits
 . SQUASH???
 . Makefile: add option to build and test libgit-rs and libgit-rs-sys
 . libgit: add higher-level libgit crate
 . config: add git_configset_alloc() and git_configset_clear_and_free()
 . libgit-sys: add repo initialization and config access
 . libgit-sys: introduce Rust wrapper for libgit.a
 . common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.

 Expecting a reroll.
 cf. <xmqqv7z8tjd7.fsf@gitster.g>
 source: <20240906221853.257984-1-calvinwan@google.com>


* jc/too-many-arguments (2024-08-06) 4 commits
 - miscellaneous: avoid "too many arguments"
 - notes: avoid "too many arguments"
 - cat-file: avoid "too many arguments"
 - refs: avoid "too many arguments"

 Error message clarification.

 On hold.
 source: <20240806003539.3292562-1-gitster@pobox.com>


* ja/doc-synopsis-markup (2024-09-24) 3 commits
 - doc: apply synopsis simplification on git-clone and git-init
 - doc: update the guidelines to reflect the current formatting rules
 - doc: introduce a synopsis typesetting

 The way AsciiDoc is used for SYNOPSIS part of the manual pages has
 been revamped.  The sources, at least for the simple cases, got
 vastly pleasant to work with.

 Reverted out of 'next', and then replaced.
 Will merge to 'next'?
 source: <pull.1766.v5.git.1727161730.gitgitgadget@gmail.com>


* ew/cat-file-optim (2024-08-25) 10 commits
 - cat-file: use writev(2) if available
 - cat-file: batch_write: use size_t for length
 - cat-file: batch-command uses content_limit
 - object_info: content_limit only applies to blobs
 - packfile: packed_object_info avoids packed_to_object_type
 - cat-file: use delta_base_cache entries directly
 - packfile: inline cache_or_unpack_entry
 - packfile: fix off-by-one in content_limit comparison
 - packfile: allow content-limit for cat-file
 - packfile: move sizep computation

 "git cat-file --batch" has been optimized.

 Waiting for review responses.
 source: <20240823224630.1180772-1-e@80x24.org>
