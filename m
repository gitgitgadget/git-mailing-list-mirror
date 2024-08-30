Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B51BF7FB
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050674; cv=none; b=Q8CGZBRI4pO9cXfK9hJk7VvfLk3BnbHngUM2G8MCi3YHH6vGoF7Dosp6HN4K3AzeePyueT0KqL/m3XDs2tmIIRbLnOj+ZP59B6fMLj3zLEsxTuqn4rZ7HWLzj52FzVPBUTntMdblPIoWqUyF2Yzr5DU3jib2oKV+0zmyK1bkZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050674; c=relaxed/simple;
	bh=Iz3yKYR53CIU1ZgHLwhAQ/XVLTRwLIRIedA6A3lXANM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=egk1YSQ5CH3sddF7OY80ZxJvXto0FR258wqQH5kg+6HzrOJZ1b5RvbdhGypSgSV9Q9UXeXlAFITojmFTgiacrNyKKwIQdchE2ZXGBQoef/4sa524siddwmTPye3K/M8ayn6uudDIJySbAX3C93kVEOhxmjgzT6TKeEAF5WkqEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nCGk7aMg; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nCGk7aMg"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B58EF21CAA;
	Fri, 30 Aug 2024 16:44:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=I
	z3yKYR53CIU1ZgHLwhAQ/XVLTRwLIRIedA6A3lXANM=; b=nCGk7aMgqZwB2cYk3
	GIgUnF6vMDFDnY6nSMoGUUsB8h15/YDAQtGhVzdsus0tAFaClhHcylLSOJ54Z6wu
	S3zbmw9Lm5tPm+YAzjpfLemtJMBw+6ybHGO1zEZHpapRchQko5ko2D+Td8dplfCJ
	4xiGfL/G82ME0kZ9+Ie04zlGCs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AD03B21CA9;
	Fri, 30 Aug 2024 16:44:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1289B21CA8;
	Fri, 30 Aug 2024 16:44:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2024, #11; Fri, 30)
X-master-at: 4590f2e9412378c61eac95966709c78766d326ba
X-next-at: e5961a9dc9590638e72dd338e78d082f29b3e746
Date: Fri, 30 Aug 2024 13:44:27 -0700
Message-ID: <xmqqed65rb9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A7037B30-6710-11EF-AB2A-9B0F950A682E-77302942!pb-smtp2.pobox.com

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

* ah/git-prompt-portability (2024-08-20) 8 commits
  (merged to 'next' on 2024-08-21 at 14fa411577)
 + git-prompt: support custom 0-width PS1 markers
 + git-prompt: ta-da! document usage in other shells
 + git-prompt: don't use shell $'...'
 + git-prompt: add some missing quotes
 + git-prompt: replace [[...]] with standard code
 + git-prompt: don't use shell arrays
 + git-prompt: fix uninitialized variable
 + git-prompt: use here-doc instead of here-string

 The command line prompt support used to be littered with bash-isms,
 which has been corrected to work with more shells.

 source: <pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>


* cp/unit-test-reftable-block (2024-08-28) 12 commits
  (merged to 'next' on 2024-08-28 at 4974e39ddb)
 + t-reftable-block: mark unused argv/argc
  (merged to 'next' on 2024-08-22 at 234d8701da)
 + t-reftable-block: add tests for index blocks
 + t-reftable-block: add tests for obj blocks
 + t-reftable-block: add tests for log blocks
 + t-reftable-block: remove unnecessary variable 'j'
 + t-reftable-block: use xstrfmt() instead of xstrdup()
 + t-reftable-block: use block_iter_reset() instead of block_iter_close()
 + t-reftable-block: use reftable_record_key() instead of strbuf_addstr()
 + t-reftable-block: use reftable_record_equal() instead of check_str()
 + t-reftable-block: release used block reader
 + t: harmonize t-reftable-block.c with coding guidelines
 + t: move reftable/block_test.c to the unit testing framework

 Another test for reftable library ported to the unit test framework.
 cf. <ZsbdFU9aBQvqE3pb@tanuki>

 source: <20240821124150.4463-1-chandrapratap3519@gmail.com>


* ds/sparse-diff-index (2024-08-22) 1 commit
  (merged to 'next' on 2024-08-23 at d33f670977)
 + diff-index: integrate with the sparse index

 The underlying machinery for "git diff-index" has long been made to
 expand the sparse index as needed, but the command fully expanded
 the sparse index upfront, which now has been taught not to do.

 source: <pull.1777.git.1724342607793.gitgitgadget@gmail.com>


* gt/unit-test-urlmatch-normalization (2024-08-20) 1 commit
  (merged to 'next' on 2024-08-21 at 3efed1ed8d)
 + t: migrate t0110-urlmatch-normalization to the new framework

 Another rewrite of test.

 source: <20240820152008.21354-2-shyamthakkar001@gmail.com>


* mt/rebase-x-quiet (2024-08-21) 1 commit
  (merged to 'next' on 2024-08-22 at 1018555d89)
 + rebase --exec: respect --quiet

 "git rebase -x --quiet" was not quiet, which was corrected.

 source: <f105b34b8e6b33448f4d0ef07d51b7bbf4e71aaa.1724203912.git.matheus.tavb@gmail.com>


* ps/reftable-drop-generic (2024-08-28) 17 commits
  (merged to 'next' on 2024-08-28 at 987000f60d)
 + reftable: mark unused parameters in empty iterator functions
  (merged to 'next' on 2024-08-22 at c6706c1b16)
 + reftable/generic: drop interface
 + t/helper: refactor to not use `struct reftable_table`
 + t/helper: use `hash_to_hex_algop()` to print hashes
 + t/helper: inline printing of reftable records
 + t/helper: inline `reftable_table_print()`
 + t/helper: inline `reftable_stack_print_directory()`
 + t/helper: inline `reftable_reader_print_file()`
 + t/helper: inline `reftable_dump_main()`
 + reftable/dump: drop unused `compact_stack()`
 + reftable/generic: move generic iterator code into iterator interface
 + reftable/iter: drop double-checking logic
 + reftable/stack: open-code reading refs
 + reftable/merged: stop using generic tables in the merged table
 + reftable/merged: rename `reftable_new_merged_table()`
 + reftable/merged: expose functions to initialize iterators
 + Merge branch 'ps/reftable-stack-compaction' into ps/reftable-drop-generic

 The code in the reftable library has been cleaned up by discarding
 unused "generic" interface.

 source: <cover.1724308389.git.ps@pks.im>

--------------------------------------------------
[New Topics]

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
 - grep: prefer UNUSED to MAYBE_UNUSED for pcre allocators
 - gc: drop MAYBE_UNUSED annotation from used parameter

 Code clean-up.

 Will merge to 'next'.
 source: <20240829200807.GA430283@coredump.intra.peff.net>

--------------------------------------------------
[Cooking]

* rs/remote-leakfix (2024-08-23) 1 commit
  (merged to 'next' on 2024-08-26 at 77eb8b251e)
 + remote: plug memory leaks at early returns

 Leakfix.

 Will merge to 'master'.
 source: <82cb986c-6830-4d9a-bad1-fe4cab6a76eb@web.de>


* gt/unit-test-oid-array (2024-08-25) 1 commit
 - t: port helper/test-oid-array.c to unit-tests/t-oid-array.c

 Another unit-test.

 Expecting a (hopefully small and final) reroll.
 cf. <CAP8UFD3mq+k8QXDrFAp5bfoCN+sNgm3vJvuhryxVYDaj-SZU0g@mail.gmail.com>
 source: <20240824170223.36080-1-shyamthakkar001@gmail.com>


* gt/unit-test-oidset (2024-08-25) 1 commit
 - unit-tests: add tests for oidset.h

 Another unit-test.

 Expecting a reroll.
 source: <20240824172028.39419-1-shyamthakkar001@gmail.com>


* jc/config-doc-update (2024-08-26) 2 commits
  (merged to 'next' on 2024-08-27 at e2cf493099)
 + git-config.1: fix description of --regexp in synopsis
 + git-config.1: --get-all description update

 Docfix.

 Will merge to 'master'.
 source: <xmqq34mrkxre.fsf@gitster.g>


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
 source: <cover.1724656120.git.ps@pks.im>


* dh/runtime-prefix-on-zos (2024-08-22) 1 commit
  (merged to 'next' on 2024-08-25 at 54a7e6c9c4)
 + exec_cmd: RUNTIME_PREFIX on z/OS systems

 Support for the RUNTIME_PREFIX feature has been added to z/OS port.

 Will merge to 'master'.
 source: <pull.1769.git.git.1724334732249.gitgitgadget@gmail.com>


* cl/config-regexp-docfix (2024-08-23) 1 commit
  (merged to 'next' on 2024-08-25 at 8deaa7a660)
 + doc: replace 3 dash with correct 2 dash in git-config(1)

 Docfix.

 Will merge to 'master'.
 source: <20240823-fix-doc-regexp-v2-1-e4eafdd60378@gmail.com>


* aa/cat-file-batch-output-doc (2024-08-22) 1 commit
  (merged to 'next' on 2024-08-25 at 2c8a616d2c)
 + docs: explain the order of output in the batched mode of git-cat-file(1)

 Docfix.

 Will merge to 'master'.
 source: <pull.1768.v3.git.git.1724356231639.gitgitgadget@gmail.com>


* js/fetch-push-trace2-annotation (2024-08-22) 3 commits
  (merged to 'next' on 2024-08-25 at df89edbe16)
 + send-pack: add new tracing regions for push
 + fetch: add top-level trace2 regions
 + trace2: implement trace2_printf() for event target

 More trace2 events at key points on push and fetch code paths have
 been added.

 Will merge to 'master'.
 source: <cover.1724363615.git.steadmon@google.com>


* jk/send-email-mailmap (2024-08-27) 3 commits
  (merged to 'next' on 2024-08-30 at a5cf30460a)
 + send-email: add mailmap support via sendemail.mailmap and --mailmap
 + check-mailmap: add options for additional mailmap sources
 + check-mailmap: accept "user@host" contacts

 "git send-email" learned "--mailmap" option to allow rewriting the
 recipient addresses.

 Will merge to 'master'.
 source: <20240827-jk-send-email-mailmap-support-v3-0-bec5ba9be391@gmail.com>


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

 Will merge to 'master'.
 source: <cover.1724315484.git.ps@pks.im>


* sj/ref-contents-check (2024-08-28) 6 commits
 - SQUASH??? -Wunused-parameter fix
 - SQUASH??? remove unused parameters
 - ref: add symlink ref check for files backend
 - ref: add symbolic ref content check for files backend
 - ref: add regular ref content check for files backend
 - ref: initialize "fsck_ref_report" with zero

 Plumb through extra checks in refs API to "git fsck".

 Expecting a reroll.
 source: <Zs348uXMBdCuwF-2@ArchLinux>


* jc/mailinfo-header-cleanup (2024-08-20) 1 commit
 - mailinfo: we parse fixed headers

 Code clean-up.

 On hold.
 cf. <Zsb1rGQbglHMiBHI@tanuki>
 source: <xmqq1q2i6gw7.fsf@gitster.g>


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

 Will merge to 'master'.
 source: <cover.1724420744.git.ps@pks.im>


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


* ps/clar-unit-test (2024-08-20) 13 commits
 - clar: add CMake support
 - t/unit-tests: convert ctype tests to use clar
 - t/unit-tests: convert strvec tests to use clar
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

 Need to decide how to fill feature gap with our home-grown one
 cf. <b87700d2-0c9a-4d0c-9ee4-e6a91278d596@gmail.com>
 source: <cover.1724159966.git.ps@pks.im>


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

 Needs review.
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
