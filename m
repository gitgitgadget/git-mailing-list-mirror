Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C61EC01D
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725404496; cv=none; b=h7peN5fP7Kc7K4n4EZ60ieTDXGm0ypFGY317T23BYGioijL4Yib5ix6kWuuWKTjs1gb9SlhGRoxa5P6BBEXipZjCSImnv34AcwZAly7X7sjc8CNsgNpRCNU0OeD23dhrjNTLHMhYCvaZCPWRG1OXf0Xopfw2AFQ2GIsWXEvzJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725404496; c=relaxed/simple;
	bh=N+onZ4KGFt/HRjdQ2nWjnPAl1xxKoOWWRhm83lekuo0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AqtBi3r1zgKmQ+SM+cDBX+tOSonQBayhCSyoB+PLEpEVB/2ESHvy6KXyxZuRw/fQLOfXBk3SognVVmiPEiHGHoSPFQal/cj3RS4dJK+8FSeqPI1Q29KQPzJE3+WlBnZjnCN02HZwqt0yMzqsrK00o+2HVT9k2vQZOMZpyL86bjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nGkDxVIk; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nGkDxVIk"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 235E62B228;
	Tue,  3 Sep 2024 19:01:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=N
	+onZ4KGFt/HRjdQ2nWjnPAl1xxKoOWWRhm83lekuo0=; b=nGkDxVIkdtNqffH3a
	uy4392FKyI5xI/BvNvwRiKy8lm9M+vyBRz+gTrLNWaYLWXtgMZ0xQGixbL1QK92N
	95VSEXSnKruytXhbZ/I2g0KFUhTDpAKhOoBTL7Q3M3rPXKZ99GMoJ9pSL9F4idOo
	Q/GZafEM0nciRuNJmw51K7AYIM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A1F82B227;
	Tue,  3 Sep 2024 19:01:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 702932B225;
	Tue,  3 Sep 2024 19:01:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2024, #01; Tue, 3)
X-master-at: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
X-next-at: 6671bf1ecabbf7840b87cd84d969d780cc17b8ad
Date: Tue, 03 Sep 2024 16:01:31 -0700
Message-ID: <xmqqr0a0fik4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 762EC5D8-6A48-11EF-B3C2-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

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

* aa/cat-file-batch-output-doc (2024-08-22) 1 commit
  (merged to 'next' on 2024-08-25 at 2c8a616d2c)
 + docs: explain the order of output in the batched mode of git-cat-file(1)

 Docfix.
 source: <pull.1768.v3.git.git.1724356231639.gitgitgadget@gmail.com>


* cl/config-regexp-docfix (2024-08-23) 1 commit
  (merged to 'next' on 2024-08-25 at 8deaa7a660)
 + doc: replace 3 dash with correct 2 dash in git-config(1)

 Docfix.
 source: <20240823-fix-doc-regexp-v2-1-e4eafdd60378@gmail.com>


* dh/runtime-prefix-on-zos (2024-08-22) 1 commit
  (merged to 'next' on 2024-08-25 at 54a7e6c9c4)
 + exec_cmd: RUNTIME_PREFIX on z/OS systems

 Support for the RUNTIME_PREFIX feature has been added to z/OS port.
 source: <pull.1769.git.git.1724334732249.gitgitgadget@gmail.com>


* jc/config-doc-update (2024-08-26) 2 commits
  (merged to 'next' on 2024-08-27 at e2cf493099)
 + git-config.1: fix description of --regexp in synopsis
 + git-config.1: --get-all description update

 Docfix.
 source: <xmqq34mrkxre.fsf@gitster.g>


* js/fetch-push-trace2-annotation (2024-08-22) 3 commits
  (merged to 'next' on 2024-08-25 at df89edbe16)
 + send-pack: add new tracing regions for push
 + fetch: add top-level trace2 regions
 + trace2: implement trace2_printf() for event target

 More trace2 events at key points on push and fetch code paths have
 been added.
 source: <cover.1724363615.git.steadmon@google.com>


* ps/leakfixes-part-5 (2024-08-22) 21 commits
  (merged to 'next' on 2024-08-25 at 5dde5192bb)
 + transport: fix leaking negotiation tips
 + transport: fix leaking arguments when fetching from bundle
 + builtin/fetch: fix leaking transaction with `--atomic`
 + remote: fix leaking peer ref when expanding refmap
 + remote: fix leaks when matching refspecs
 + remote: fix leaking config strings
 + builtin/fetch-pack: fix leaking refs
 + sideband: fix leaks when configuring sideband colors
 + builtin/send-pack: fix leaking refspecs
 + transport: fix leaking OID arrays in git:// transport data
 + t/helper: fix leaking multi-pack-indices in "read-midx"
 + builtin/repack: fix leaks when computing packs to repack
 + midx-write: fix leaking hashfile on error cases
 + builtin/archive: fix leaking `OPT_FILENAME()` value
 + builtin/upload-archive: fix leaking args passed to `write_archive()`
 + builtin/merge-tree: fix leaking `-X` strategy options
 + pretty: fix leaking key/value separator buffer
 + pretty: fix memory leaks when parsing pretty formats
 + convert: fix leaks when resetting attributes
 + mailinfo: fix leaking header data
 + Merge branch 'ps/leakfixes-part-4' into ps/leakfixes-part-5

 Even more leak fixes.
 source: <cover.1724315484.git.ps@pks.im>


* ps/reftable-concurrent-compaction (2024-08-23) 11 commits
  (merged to 'next' on 2024-08-26 at 3fc3e86224)
 + reftable/stack: fix segfault when reload with reused readers fails
 + reftable/stack: reorder swapping in the reloaded stack contents
 + reftable/reader: keep readers alive during iteration
 + reftable/reader: introduce refcounting
 + reftable/stack: fix broken refnames in `write_n_ref_tables()`
 + reftable/reader: inline `reader_close()`
 + reftable/reader: inline `init_reader()`
 + reftable/reader: rename `reftable_new_reader()`
 + reftable/stack: inline `stack_compact_range_stats()`
 + reftable/blocksource: drop malloc block source
 + Merge branch 'ps/reftable-drop-generic' into ps/reftable-concurrent-compaction

 The code path for compacting reftable files saw some bugfixes
 against concurrent operation.
 source: <cover.1724420744.git.ps@pks.im>


* rs/remote-leakfix (2024-08-23) 1 commit
  (merged to 'next' on 2024-08-26 at 77eb8b251e)
 + remote: plug memory leaks at early returns

 Leakfix.
 source: <82cb986c-6830-4d9a-bad1-fe4cab6a76eb@web.de>

--------------------------------------------------
[New Topics]

* jc/unused-on-windows (2024-08-30) 1 commit
  (merged to 'next' on 2024-08-30 at a2a2aa6e59)
 + refs/files-backend: work around -Wunused-parameter

 Fix more fallouts from -Werror=unused-parameter.

 Will merge to 'master'.
 source: <xmqqjzfxrekm.fsf@gitster.g>


* jk/free-commit-buffer-of-skipped-commits (2024-08-30) 1 commit
  (merged to 'next' on 2024-09-03 at a8fb72a4d5)
 + revision: free commit buffers for skipped commits

 The code forgot to discard unnecessary in-core commit buffer data
 for commits that "git log --skip=<number>" traversed but omitted
 from the output, which has been corrected.

 Will merge to 'master'.
 source: <20240830205331.GA1038751@coredump.intra.peff.net>


* ah/mergetols-vscode (2024-09-01) 1 commit
 - mergetools: vscode: new tool

 "git mergetool" learned to use VSCode as a merge backend.

 Will merge to 'next'.
 source: <20240902025918.99657-1-alexhenrie24@gmail.com>


* rj/compat-terminal-unused-fix (2024-09-01) 1 commit
 - compat/terminal: mark parameter of git_terminal_prompt() UNUSED

 Build fix.

 Will merge to 'next'.
 source: <ce1c1d66-e0eb-4143-b334-1a83c0492415@ramsayjones.plus.com>


* ps/declare-pack-redundamt-dead (2024-09-03) 1 commit
 - Documentation/BreakingChanges: announce removal of git-pack-redundant(1)

 "git pack-redundant" has been marked for removal in Git 3.0.

 Will merge to 'next'.
 source: <a6be9f5e9eb1f426b1a17b89e3db1bc7532758b5.1725264748.git.ps@pks.im>


* pw/rebase-autostash-fix (2024-09-03) 1 commit
 - rebase: apply and cleanup autostash when rebase fails to start

 "git rebase --autostash" failed to resurrect the autostashed
 changes when the command gets aborted after giving back control
 asking for hlep in conflict resolution.

 Will merge to 'next'?
 source: <pull.1772.v2.git.1725289979450.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* tb/multi-pack-reuse-fix (2024-08-27) 5 commits
 - builtin/pack-objects.c: do not open-code `MAX_PACK_OBJECT_HEADER`
 - pack-bitmap.c: avoid repeated `pack_pos_to_offset()` during reuse
 - builtin/pack-objects.c: translate bit positions during pack-reuse
 - pack-bitmap: tag bitmapped packs with their corresponding MIDX
 - t/t5332-multi-pack-reuse.sh: verify pack generation with --strict

 A data corruption bug when multi-pack-index is used and the same
 objects are stored in multiple packfiles has been corrected.

 Needs review.
 source: <cover.1724793201.git.me@ttaylorr.com>


* jk/unused-parameters (2024-08-28) 7 commits
  (merged to 'next' on 2024-08-30 at 2c5169ff52)
 + CodingGuidelines: mention -Wunused-parameter and UNUSED
 + config.mak.dev: enable -Wunused-parameter by default
 + compat: mark unused parameters in win32/mingw functions
 + compat: disable -Wunused-parameter in win32/headless.c
 + compat: disable -Wunused-parameter in 3rd-party code
 + t-reftable-readwrite: mark unused parameter in callback function
 + gc: mark unused config parameter in virtual functions
 (this branch is used by jc/maybe-unused.)

 Make our codebase compilable with the -Werror=unused-parameter
 option.

 Will merge to 'master'.
 source: <20240828035722.GA3998881@coredump.intra.peff.net>
 source: <CAPig+cQLr+vAzkt8UJNVCeE8osGEcEfFunG36oqxa0k8JamJzQ@mail.gmail.com>


* es/chainlint-message-updates (2024-08-29) 2 commits
 - chainlint: reduce annotation noise-factor
 - chainlint: make error messages self-explanatory

 The error messages from the test script checker have been improved.

 Expecting a reroll.
 cf. <CAPig+cQ+6am7-BSnWZz5=C0Q1Vyng0T4goB+ZE9TKJMrpi_Jpg@mail.gmail.com>
 source: <20240829091625.41297-1-ericsunshine@charter.net>


* ps/environ-wo-the-repository (2024-08-30) 21 commits
 - environment: stop storing "core.notesRef" globally
 - environment: stop storing "core.warnAmbiguousRefs" globally
 - environment: stop storing "core.preferSymlinkRefs" globally
 - environment: stop storing "core.logAllRefUpdates" globally
 - refs: stop modifying global `log_all_ref_updates` variable
 - branch: stop modifying `log_all_ref_updates` variable
 - repo-settings: track defaults close to `struct repo_settings`
 - repo-settings: split out declarations into a standalone header
 - environment: guard state depending on a repository
 - environment: reorder header to split out `the_repository`-free section
 - environment: move `set_git_dir()` and related into setup layer
 - environment: make `get_git_namespace()` self-contained
 - environment: move `odb_mkstemp()` into object layer
 - config: make dependency on repo in `read_early_config()` explicit
 - config: document `read_early_config()` and `read_very_early_config()`
 - environment: make `get_git_work_tree()` accept a repository
 - environment: make `get_graft_file()` accept a repository
 - environment: make `get_index_file()` accept a repository
 - environment: make `get_object_directory()` accept a repository
 - environment: make `get_git_common_dir()` accept a repository
 - environment: make `get_git_dir()` accept a repository

 Code clean-up.

 Needs review.
 source: <cover.1725008897.git.ps@pks.im>


* jc/maybe-unused (2024-08-29) 2 commits
  (merged to 'next' on 2024-08-30 at e5961a9dc9)
 + CodingGuidelines: also mention MAYBE_UNUSED
 + Merge branch 'jk/unused-parameters' into jc/maybe-unused
 (this branch uses jk/unused-parameters.)

 Developer doc updates.

 Will merge to 'master'.
 source: <xmqq4j73w5up.fsf_-_@gitster.g>


* jk/maybe-unused-cleanup (2024-08-29) 2 commits
  (merged to 'next' on 2024-08-30 at 0ff6ea5748)
 + grep: prefer UNUSED to MAYBE_UNUSED for pcre allocators
 + gc: drop MAYBE_UNUSED annotation from used parameter

 Code clean-up.

 Will merge to 'master'.
 source: <20240829200807.GA430283@coredump.intra.peff.net>


* gt/unit-test-oid-array (2024-09-01) 1 commit
 - t: port helper/test-oid-array.c to unit-tests/t-oid-array.c

 Another unit-test.

 Will merge to 'next'?
 source: <20240901212649.4910-1-shyamthakkar001@gmail.com>


* gt/unit-test-oidset (2024-08-25) 1 commit
 - unit-tests: add tests for oidset.h

 Another unit-test.

 Expecting a reroll.
 source: <20240824172028.39419-1-shyamthakkar001@gmail.com>


* ps/leakfixes-part-6 (2024-08-26) 22 commits
 - builtin/repack: fix leaking keep-pack list
 - merge-ort: fix two leaks when handling directory rename modifications
 - match-trees: fix leaking prefixes in `shift_tree()`
 - builtin/fmt-merge-msg: fix leaking buffers
 - builtin/grep: fix leaking object context
 - builtin/pack-objects: plug leaking list of keep-packs
 - builtin/repack: fix leaking line buffer when packing promisors
 - negotiator/skipping: fix leaking commit entries
 - shallow: fix leaking members of `struct shallow_info`
 - shallow: free grafts when unregistering them
 - object: clear grafts when clearing parsed object pool
 - gpg-interface: fix misdesigned signing key interfaces
 - send-pack: fix leaking push cert nonce
 - remote: fix leak in reachability check of a remote-tracking ref
 - remote: fix leaking tracking refs
 - builtin/submodule--helper: fix leaking refs on push-check
 - submodule: fix leaking fetch task data
 - upload-pack: fix leaking child process data on reachability checks
 - builtin/push: fix leaking refspec query result
 - send-pack: fix leaking common object IDs
 - fetch-pack: fix memory leaks on fetch negotiation
 - t/test-lib: allow skipping leak checks for passing tests

 More leakfixes.

 Needs review.
 Expecting a reroll.
 cf. <ZtGKJfgBo17Vz8wY@tanuki>
 source: <cover.1724656120.git.ps@pks.im>


* jk/send-email-mailmap (2024-08-27) 3 commits
  (merged to 'next' on 2024-08-30 at a5cf30460a)
 + send-email: add mailmap support via sendemail.mailmap and --mailmap
 + check-mailmap: add options for additional mailmap sources
 + check-mailmap: accept "user@host" contacts

 "git send-email" learned "--mailmap" option to allow rewriting the
 recipient addresses.

 Will merge to 'master'.
 source: <20240827-jk-send-email-mailmap-support-v3-0-bec5ba9be391@gmail.com>


* sj/ref-contents-check (2024-09-03) 4 commits
 - ref: add symlink ref content check for files backend
 - ref: add symref content check for files backend
 - ref: add regular ref content check for files backend
 - ref: initialize "fsck_ref_report" with zero

 "git fsck" learned to issue warnings on "curiously formatted" ref
 contents that have always been taken valid but something Git
 wouldn't have written itself (e.g., missing terminating end-of-line
 after the full object name).

 Ready?
 source: <Ztb-mgl50cwGVO8A@ArchLinux>


* jc/mailinfo-header-cleanup (2024-08-20) 1 commit
 - mailinfo: we parse fixed headers

 Code clean-up.

 On hold.
 cf. <Zsb1rGQbglHMiBHI@tanuki>
 source: <xmqq1q2i6gw7.fsf@gitster.g>


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


* ps/clar-unit-test (2024-09-03) 14 commits
 - clar: add CMake support
 - t/unit-tests: convert ctype tests to use clar
 - t/unit-tests: convert strvec tests to use clar
 - t/unit-tests: implement test driver
 - Makefile: wire up the clar unit testing framework
 - Makefile: do not use sparse on third-party sources
 - Makefile: make hdr-check depend on generated headers
 - Makefile: fix sparse dependency on GENERATED_H
 - clar: stop including `shellapi.h` unnecessarily
 - clar(win32): avoid compile error due to unused `fs_copy()`
 - clar: avoid compile error with mingw-w64
 - t/clar: fix compatibility with NonStop
 - t: import the clar unit testing framework
 - t: do not pass GIT_TEST_OPTS to unit tests with prove

 Import clar unit tests framework libgit2 folks invented for our
 use.

 Ready?
 source: <cover.1725349234.git.ps@pks.im>


* js/libgit-rust (2024-08-09) 5 commits
 - cgit: add higher-level cgit crate
 - config: add git_configset_alloc() and git_configset_clear_and_free()
 - cgit-sys: add repo initialization and config access
 - cgit-sys: introduce Rust wrapper for libgit.a
 - common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.

 Comments?
 source: <cover.1723242556.git.steadmon@google.com>


* jc/range-diff-lazy-setup (2024-08-09) 2 commits
 - remerge-diff: clean up temporary objdir at a central place
 - remerge-diff: lazily prepare temporary objdir on demand

 Code clean-up.

 Comments?
 source: <xmqqr0ax9vlk.fsf@gitster.g>


* jc/too-many-arguments (2024-08-06) 4 commits
 - miscellaneous: avoid "too many arguments"
 - notes: avoid "too many arguments"
 - cat-file: avoid "too many arguments"
 - refs: avoid "too many arguments"

 Error message clarification.

 On hold.
 source: <20240806003539.3292562-1-gitster@pobox.com>


* cc/promisor-remote-capability (2024-07-31) 4 commits
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2
 - strbuf: refactor strbuf_trim_trailing_ch()
 - version: refactor strbuf_sanitize()

 The v2 protocol learned to allow the server to advertise possible
 promisor remotes, and the client to respond with what promissor
 remotes it uses, so that the server side can omit objects that the
 client can lazily obtain from these other promissor remotes.

 Expecting a reroll.
 cf. <ZrDYIFolRlERFdUT@tanuki>
 source: <20240731134014.2299361-1-christian.couder@gmail.com>


* ja/doc-synopsis-markup (2024-08-12) 3 commits
 - doc: apply synopsis simplification on git-clone and git-init
 - doc: update the guidelines to reflect the current formatting rules
 - doc: introduce a synopsis custom paragraph attribute

 The way AsciiDoc is used for SYNOPSIS part of the manual pages has
 been revamped.  The sources, at least for the simple cases, got
 vastly pleasant to work with.

 cf. <1986021.PYKUYFuaPT@cayenne>
 source: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>


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


* tc/fetch-bundle-uri (2024-07-24) 3 commits
 - fetch: use bundle URIs when having creationToken heuristic
 - transport: introduce transport_has_remote_bundle_uri()
 - clone: remove double bundle list clear code

 Allow "git fetch" take advantage of bundleURI feature.

 Expecting a reroll or retraction.
 source: <ZqObobw8FsDMkllm@tanuki>

--------------------------------------------------
[Will discard]

* pp/add-parse-range-unit-test (2024-08-28) 2 commits
 - SQUASH???
 - apply: add unit tests for parse_range

 A unit test for code that parses the hunk offset and length from a
 patch fragment header as been added.

 Has been expecting a reroll for too long.
 cf. <b7eca313-9ea8-4132-ba1d-ed9236e07095@gmail.com>
 source: <pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>
