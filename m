Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3021A130495
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 23:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925090; cv=none; b=MfqtJtuDi9aFN9R4wdsoVM4xZ9Ie9LZoqXv+5JLXXHcPvtBsYdlmLlVzLjH/pXGHogMUZaQ37XrMUhT9UPjf45roerzVBrObpD5jCUXrZ3sbV7XWktmzDn+D9BUFBk6UuEqERmLUZqmZR4ZK81cczrH4KIjgm/xwSvvMx0Ano9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925090; c=relaxed/simple;
	bh=vIMAamg/nj32AoJCmp7p42SMUyG7iK6Q8YLfOsN2vxg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SCVOyECwbZZuA1NllE3hBQIP46NuM3yHklVgL7iZ1IJJgNCNY4weTXMPzBkEVL2DrNBpjWP92fClZeLYVnS7su4nH7/pEsDMBBmMdoshMQ9Gp33CqbAr6+MGJYPq/8bGGCMsbsHEwvH01tboqgzb4bhNQcaEbhrTVAL56BIDFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jtH9F6Q+; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jtH9F6Q+"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E07B82DA17;
	Mon,  9 Sep 2024 19:38:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=v
	IMAamg/nj32AoJCmp7p42SMUyG7iK6Q8YLfOsN2vxg=; b=jtH9F6Q+VLXd2IEq0
	hyycn7fsGSc80SreOq3stF9ASMpK0VerX9WrdmPM99lGT9y4PB32slI0yHzKFbb6
	ombaZFwXIIlgRu/wz0a3DSLILzXj7nZS8XNV4Obrxcr/g2POs62bCbHhi+4AkfDn
	v4C1ngFscZVsd31DM4CxJtdWRI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C9E432DA16;
	Mon,  9 Sep 2024 19:38:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12FDE2DA15;
	Mon,  9 Sep 2024 19:38:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2024, #03; Mon, 9)
X-master-at: 4c42d5ff284067fa32837421408bebfef996bf81
X-next-at: a09f0889bb33dc86ffe53d14730c994b00d10e9e
Date: Mon, 09 Sep 2024 16:38:04 -0700
Message-ID: <xmqqseu8o0tf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 90290226-6F04-11EF-9003-9B0F950A682E-77302942!pb-smtp2.pobox.com

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
[New Topics]

* rj/cygwin-has-dev-tty (2024-09-08) 1 commit
  (merged to 'next' on 2024-09-09 at 5c5726050f)
 + config.mak.uname: add HAVE_DEV_TTY to cygwin config section

 Cygwin does have /dev/tty support that is needed by things like
 single-key input mode.

 Will merge to 'master'.
 source: <e3339b4d-dab1-4247-b70e-d3224bab1b6b@ramsayjones.plus.com>


* ah/apply-3way-ours (2024-09-09) 1 commit
 - apply: support --ours, --theirs, and --union for three-way merges

 "git apply --3way" learned to take "--ours" and other options.

 Will merge to 'next'.
 source: <20240909141109.3102-2-alexhenrie24@gmail.com>


* ds/pack-name-hash-tweak (2024-09-09) 4 commits
 - p5313: add size comparison test
 - p5314: add a size test for name-hash collisions
 - git-repack: update usage to match docs
 - pack-objects: add --full-name-hash option

 In a repository with too many (more than --window size) similarly
 named files, "git repack" would not find good delta-base candidate
 and worse, it may not use a blob from exactly the same path as a
 good delta-base candidate.  Optionally replace the name hash so
 that only blobs at the same path and nothing else are used as
 delta-base candidate.

 Needs review.
 source: <pull.1785.git.1725890210.gitgitgadget@gmail.com>


* ps/reftable-exclude (2024-09-09) 7 commits
 - refs/reftable: wire up support for exclude patterns
 - reftable/reader: make table iterator reseekable
 - t/unit-tests: introduce reftable library
 - Makefile: stop listing test library objects twice
 - builtin/receive-pack: fix exclude patterns when announcing refs
 - refs: properly apply exclude patterns to namespaced refs
 - Merge branch 'cp/unit-test-reftable-stack' into ps/reftable-exclude
 (this branch uses cp/unit-test-reftable-stack.)

 The reftable backend learned to more efficiently handle exclude
 patterns while enumerating the refs.

 Needs review.
 source: <cover.1725881266.git.ps@pks.im>

--------------------------------------------------
[Cooking]

* ds/doc-wholesale-disabling-advice-messages (2024-09-06) 1 commit
  (merged to 'next' on 2024-09-07 at a52a31f161)
 + advice: recommend GIT_ADVICE=0 for tools

 The environment GIT_ADVICE has been intentionally kept undocumented
 to discourage its use by interactive users.  Add documentation to
 help tool writers.

 Will merge to 'master'.
 source: <pull.1781.v2.git.1725654155162.gitgitgadget@gmail.com>


* jk/sparse-fdleak-fix (2024-09-06) 3 commits
  (merged to 'next' on 2024-09-07 at 2551aeee9e)
 + sparse-checkout: use fdopen_lock_file() instead of xfdopen()
 + sparse-checkout: check commit_lock_file when writing patterns
 + sparse-checkout: consolidate cleanup when writing patterns

 A file descriptor left open is now properly closed when "git
 sparse-checkout" updates the sparse patterns.

 Will merge to 'master'.
 source: <20240906034557.GA3693911@coredump.intra.peff.net>


* bl/trailers-and-incomplete-last-line-fix (2024-09-06) 1 commit
  (merged to 'next' on 2024-09-09 at a09f0889bb)
 + interpret-trailers: handle message without trailing newline

 The interpret-trailers command failed to recognise the end of the
 message when the commit log ends in an incomplete line.

 Will merge to 'master'.
 source: <20240906145743.2059405-1-brianmlyles@gmail.com>


* sp/mailmap (2024-09-06) 1 commit
  (merged to 'next' on 2024-09-07 at aa952cf271)
 + .mailmap document current address.

 Update to a mailmap entry.

 Will merge to 'master'.
 source: <20240906153003.110200-2-ischis2@cox.net>


* jc/doc-skip-fetch-all-and-prefetch (2024-09-09) 1 commit
  (merged to 'next' on 2024-09-09 at a2bf302636)
 + doc: remote.*.skip{DefaultUpdate,FetchAll} stops prefetch

 Doc updates.

 Will merge to 'master'.
 source: <xmqqseu8u8m0.fsf@gitster.g>


* rs/diff-exit-code-fix (2024-09-08) 2 commits
  (merged to 'next' on 2024-09-09 at f52bb4afb2)
 + diff: report dirty submodules as changes in builtin_diff()
 + diff: report copies and renames as changes in run_diff_cmd()

 In a few corner cases "git diff --exit-code" failed to report
 "changes" (e.g., renamed without any content change), which has
 been corrected.

 Will merge to 'master'.
 source: <0864c86a-5562-4780-92c5-59d6c1a35aad@web.de>


* jk/free-commit-buffer-of-skipped-commits (2024-08-30) 1 commit
  (merged to 'next' on 2024-09-03 at a8fb72a4d5)
 + revision: free commit buffers for skipped commits

 The code forgot to discard unnecessary in-core commit buffer data
 for commits that "git log --skip=<number>" traversed but omitted
 from the output, which has been corrected.

 Will merge to 'master'.
 source: <20240830205331.GA1038751@coredump.intra.peff.net>


* ah/mergetols-vscode (2024-09-01) 1 commit
  (merged to 'next' on 2024-09-04 at 425c5c83e2)
 + mergetools: vscode: new tool

 "git mergetool" learned to use VSCode as a merge backend.

 Will merge to 'master'.
 source: <20240902025918.99657-1-alexhenrie24@gmail.com>


* rj/compat-terminal-unused-fix (2024-09-01) 1 commit
  (merged to 'next' on 2024-09-04 at 4ad97be799)
 + compat/terminal: mark parameter of git_terminal_prompt() UNUSED

 Build fix.

 Will merge to 'master'.
 source: <ce1c1d66-e0eb-4143-b334-1a83c0492415@ramsayjones.plus.com>


* ps/declare-pack-redundamt-dead (2024-09-03) 1 commit
  (merged to 'next' on 2024-09-04 at 6a97b07329)
 + Documentation/BreakingChanges: announce removal of git-pack-redundant(1)

 "git pack-redundant" has been marked for removal in Git 3.0.

 Will merge to 'master'.
 source: <a6be9f5e9eb1f426b1a17b89e3db1bc7532758b5.1725264748.git.ps@pks.im>


* pw/rebase-autostash-fix (2024-09-03) 1 commit
 - rebase: apply and cleanup autostash when rebase fails to start

 "git rebase --autostash" failed to resurrect the autostashed
 changes when the command gets aborted after giving back control
 asking for hlep in conflict resolution.

 Will merge to 'next'?
 source: <pull.1772.v2.git.1725289979450.gitgitgadget@gmail.com>


* cp/unit-test-reftable-stack (2024-09-09) 6 commits
  (merged to 'next' on 2024-09-09 at 0dddbbb60d)
 + t-reftable-stack: add test for stack iterators
 + t-reftable-stack: add test for non-default compaction factor
 + t-reftable-stack: use reftable_ref_record_equal() to compare ref records
 + t-reftable-stack: use Git's tempfile API instead of mkstemp()
 + t: harmonize t-reftable-stack.c with coding guidelines
 + t: move reftable/stack_test.c to the unit testing framework
 (this branch is used by ps/reftable-exclude.)

 Another reftable test migrated to the unit-test framework.

 Will merge to 'master'.
 source: <20240908041632.4948-1-chandrapratap3519@gmail.com>


* kl/cat-file-on-sparse-index (2024-09-04) 2 commits
  (merged to 'next' on 2024-09-06 at a3c78e9398)
 + builtin/cat-file: mark 'git cat-file' sparse-index compatible
 + t1092: allow run_on_* functions to use standard input

 "git cat-file" works well with the sparse-index, and gets marked as
 such.

 Will merge to 'master'.
 source: <pull.1770.v4.git.git.1725401207.gitgitgadget@gmail.com>


* ps/index-pack-outside-repo-fix (2024-09-04) 1 commit
  (merged to 'next' on 2024-09-05 at d7ff867595)
 + builtin/index-pack: fix segfaults when running outside of a repo

 "git verify-pack" and "git index-pack" started dying outside a
 repository, which has been corrected.

 Will merge to 'master'.
 source: <9a4267b8854312351f82286b6025d0a3d0e66743.1725429169.git.ps@pks.im>


* ps/pack-refs-auto-heuristics (2024-09-04) 3 commits
  (merged to 'next' on 2024-09-06 at 068ed2f7ae)
 + refs/files: use heuristic to decide whether to repack with `--auto`
 + t0601: merge tests for auto-packing of refs
 + wrapper: introduce `log2u()`

 "git pack-refs --auto" for the files backend was too aggressive,
 which has been a bit tamed.

 Will merge to 'master'.
 source: <cover.1725439407.git.ps@pks.im>


* ds/scalar-no-tags (2024-09-06) 1 commit
  (merged to 'next' on 2024-09-07 at fc06d19cfb)
 + scalar: add --no-tags option to 'scalar clone'

 The "scalar clone" command learned the "--no-tags" option.

 Will merge to 'master'.
 source: <pull.1780.v2.git.1725654102035.gitgitgadget@gmail.com>


* jc/pass-repo-to-builtins (2024-09-05) 4 commits
 - fixup! builtin: remove USE_THE_REPOSITORY_VARIABLE from builtin.h
 - add: pass in repo variable instead of global the_repository
 - builtin: remove USE_THE_REPOSITORY_VARIABLE from builtin.h
 - builtin: add a repository parameter for builtin functions

 The convention to calling into built-in command implementation has
 been updated to pass the repository, if known, together with the
 prefix value.

 Needs review.
 source: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>


* jk/messages-with-excess-lf-fix (2024-09-05) 1 commit
  (merged to 'next' on 2024-09-06 at edb0958483)
 + drop trailing newline from warning/error/die messages

 One-line messages to "die" and other helper functions will get LF
 added by these helper functions, but many existing messages had an
 unnecessary LF at the end, which have been corrected.

 Will merge to 'master'.
 source: <20240905085149.GA2340826@coredump.intra.peff.net>


* tb/weak-sha1-for-tail-sum (2024-09-06) 9 commits
 - csum-file.c: use fast SHA-1 implementation when available
 - Makefile: allow specifying a SHA-1 for non-cryptographic uses
 - hash.h: scaffolding for _fast hashing variants
 - sha1: do not redefine `platform_SHA_CTX` and friends
 - i5500-git-daemon.sh: use compile-able version of Git without OpenSSL
 - pack-objects: use finalize_object_file() to rename pack/idx/etc
 - finalize_object_file(): implement collision check
 - finalize_object_file(): refactor unlink_or_warn() placement
 - finalize_object_file(): check for name collision before renaming

 The checksum at the tail of files are now computed without
 collision detection protection.

 Will merge to 'next'?
 source: <cover.1725651952.git.me@ttaylorr.com>


* tb/multi-pack-reuse-fix (2024-08-27) 5 commits
  (merged to 'next' on 2024-09-06 at 552494ec2f)
 + builtin/pack-objects.c: do not open-code `MAX_PACK_OBJECT_HEADER`
 + pack-bitmap.c: avoid repeated `pack_pos_to_offset()` during reuse
 + builtin/pack-objects.c: translate bit positions during pack-reuse
 + pack-bitmap: tag bitmapped packs with their corresponding MIDX
 + t/t5332-multi-pack-reuse.sh: verify pack generation with --strict

 A data corruption bug when multi-pack-index is used and the same
 objects are stored in multiple packfiles has been corrected.

 Will merge to 'master'.
 cf. <20240905091043.GB2556395@coredump.intra.peff.net>
 source: <cover.1724793201.git.me@ttaylorr.com>


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


* gt/unit-test-oid-array (2024-09-01) 1 commit
  (merged to 'next' on 2024-09-05 at 92d0881bb0)
 + t: port helper/test-oid-array.c to unit-tests/t-oid-array.c

 Another unit-test.

 Will merge to 'master'.
 source: <20240901212649.4910-1-shyamthakkar001@gmail.com>


* gt/unit-test-oidset (2024-08-25) 1 commit
 - unit-tests: add tests for oidset.h

 Another unit-test.

 Expecting a reroll.
 source: <20240824172028.39419-1-shyamthakkar001@gmail.com>


* ps/leakfixes-part-6 (2024-09-05) 22 commits
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

 Will merge to 'next'?
 source: <cover.1725530720.git.ps@pks.im>


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
  (merged to 'next' on 2024-09-05 at 9a30adb035)
 + mailinfo: we parse fixed headers

 Code clean-up.

 Will merge to 'master'.
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


* ps/clar-unit-test (2024-09-04) 14 commits
  (merged to 'next' on 2024-09-05 at 87fb0a399a)
 + clar: add CMake support
 + t/unit-tests: convert ctype tests to use clar
 + t/unit-tests: convert strvec tests to use clar
 + t/unit-tests: implement test driver
 + Makefile: wire up the clar unit testing framework
 + Makefile: do not use sparse on third-party sources
 + Makefile: make hdr-check depend on generated headers
 + Makefile: fix sparse dependency on GENERATED_H
 + clar: stop including `shellapi.h` unnecessarily
 + clar(win32): avoid compile error due to unused `fs_copy()`
 + clar: avoid compile error with mingw-w64
 + t/clar: fix compatibility with NonStop
 + t: import the clar unit testing framework
 + t: do not pass GIT_TEST_OPTS to unit tests with prove

 Import clar unit tests framework libgit2 folks invented for our
 use.

 Will merge to 'master'.
 cf. <d5b1c95b-cbdc-4711-849e-c2cfc67787ee@gmail.com>
 source: <cover.1725459142.git.ps@pks.im>


* js/libgit-rust (2024-09-06) 6 commits
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


* jc/range-diff-lazy-setup (2024-08-09) 2 commits
 - remerge-diff: clean up temporary objdir at a central place
 - remerge-diff: lazily prepare temporary objdir on demand

 Code clean-up.

 Will merge to 'next'.
 source: <xmqqr0ax9vlk.fsf@gitster.g>


* jc/too-many-arguments (2024-08-06) 4 commits
 - miscellaneous: avoid "too many arguments"
 - notes: avoid "too many arguments"
 - cat-file: avoid "too many arguments"
 - refs: avoid "too many arguments"

 Error message clarification.

 On hold.
 source: <20240806003539.3292562-1-gitster@pobox.com>


* ja/doc-synopsis-markup (2024-09-05) 3 commits
 - doc: apply synopsis simplification on git-clone and git-init
 - doc: update the guidelines to reflect the current formatting rules
 - doc: introduce a synopsis typesetting

 The way AsciiDoc is used for SYNOPSIS part of the manual pages has
 been revamped.  The sources, at least for the simple cases, got
 vastly pleasant to work with.

 Waiting for comments.
 source: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>


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

--------------------------------------------------
[Will discard]

* cc/promisor-remote-capability (2024-07-31) 4 commits
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2
 - strbuf: refactor strbuf_trim_trailing_ch()
 - version: refactor strbuf_sanitize()

 The v2 protocol learned to allow the server to advertise possible
 promisor remotes, and the client to respond with what promissor
 remotes it uses, so that the server side can omit objects that the
 client can lazily obtain from these other promissor remotes.

 Will discard.
 Has been expecting a reroll for too long.
 cf. <ZrDYIFolRlERFdUT@tanuki>
 source: <20240731134014.2299361-1-christian.couder@gmail.com>


* tc/fetch-bundle-uri (2024-07-24) 3 commits
 - fetch: use bundle URIs when having creationToken heuristic
 - transport: introduce transport_has_remote_bundle_uri()
 - clone: remove double bundle list clear code

 Allow "git fetch" take advantage of bundleURI feature.

 Will discard.
 Has been expecting a reroll for too long.
 source: <ZqObobw8FsDMkllm@tanuki>

--------------------------------------------------
[Discarded]

* pp/add-parse-range-unit-test (2024-08-28) 2 commits
 . SQUASH???
 . apply: add unit tests for parse_range

 A unit test for code that parses the hunk offset and length from a
 patch fragment header as been added.

 Has been expecting a reroll for too long.
 cf. <b7eca313-9ea8-4132-ba1d-ed9236e07095@gmail.com>
 source: <pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>


* sk/enable-prefetch-per-remote (2024-09-05) 1 commit
 . remote: prefetch config

 The prefetch task of "git maintenance" learned to honor the
 "remote.<name>.prefetch" configuration variable, which can be used
 to selectively disable prefetching from selected remote
 repositories.

 Retracted.
 cf. <CAG=Um+0X3Umt-2TQ-BGeefqdGxfVoy2Ug0tGKLycrX=_pj=oJw@mail.gmail.com>
 source: <pull.1779.v4.git.1725565398681.gitgitgadget@gmail.com>
