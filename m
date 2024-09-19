Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BF618C31
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 03:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726718359; cv=none; b=fpE8fju00gotonJz9yb6go5K2vEoIrnDuCUvNZw3Rc87ZJT3ht6tFxA5v9jpBZLer7sKOSxqIDHHayLPNS9dyE/lQ7wUpYbvfPoI0AfFm5l/uqwL9Ka/KmVVZ3b/ifegpKzv60PtvTa718T5yGMXX629QNFJi+f/Mc5S3rDfjHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726718359; c=relaxed/simple;
	bh=N5/lRcsBxq56l6/lfvUy5xTvgdtS2YJsO9qAy/mQJio=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sn+UuW3/AyLTjo796ZZ7lKVqATbVGn6TS+rX6f85i6ax7/+XtRco2aaap42ahQuPJSwCNdgX3Os4LEAUAG6q3FAJmv5UBu3XNxwy7TaJrpGZpBJAYKh18JT8laC/sA/mi3uGdwwCaur9Et1vmXH8a22+9exbbrOmai+9BoA9950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KK5qsFIc; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KK5qsFIc"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8076C188B8;
	Wed, 18 Sep 2024 23:59:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=N
	5/lRcsBxq56l6/lfvUy5xTvgdtS2YJsO9qAy/mQJio=; b=KK5qsFIcm9IlVPIDH
	rd8Mgqy4paUOrEtysBaueaQMVVdVLWUEOQj+6YccHUJjRO6zoy8iJXirjnTLiT6b
	ajsKBWvSa3c76lcnz8mfRyc340ucQ+JvXtR4Msw54H2nospCUQAeZwHuS2GUX0kg
	rA6QZxtdU6QGVjvb8P4TSGMiPw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 77B7B188B7;
	Wed, 18 Sep 2024 23:59:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5DD3188B6;
	Wed, 18 Sep 2024 23:59:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2024, #07; Wed, 18)
X-master-at: 6531f31ef3bead57a3255fa08efa6e7553c5a9a7
X-next-at: cf0dbffa2232233e2e6152dc28148e12ec9aa900
Date: Wed, 18 Sep 2024 20:59:13 -0700
Message-ID: <xmqqikus8fam.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 892B6F66-763B-11EF-B1E2-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

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

* jc/cmake-unit-test-updates (2024-09-18) 4 commits
 - cmake: generalize the handling of the `UNIT_TEST_OBJS` list
 - cmake: stop looking for `REFTABLE_TEST_OBJS` in the Makefile
 - cmake: rename clar-related variables to avoid confusion
 - Merge branch 'ps/reftable-exclude' into jc/cmake-unit-test-updates
 (this branch uses ps/reftable-exclude.)

 CMake adjustments for recent changes around unit tests.

 Will merge to 'next'.
 source: <pull.1797.git.1726687769585.gitgitgadget@gmail.com>

--------------------------------------------------
[Graduated to 'master']

* es/chainlint-message-updates (2024-09-10) 3 commits
  (merged to 'next' on 2024-09-11 at a3fd02a009)
 + chainlint: reduce annotation noise-factor
 + chainlint: make error messages self-explanatory
 + chainlint: don't be fooled by "?!...?!" in test body

 The error messages from the test script checker have been improved.
 source: <20240910041013.68948-1-ericsunshine@charter.net>


* jc/ci-upload-artifact-and-linux32 (2024-09-09) 1 commit
  (merged to 'next' on 2024-09-11 at 62991bef5b)
 + ci: remove 'Upload failed tests' directories' step from linux32 jobs
 (this branch is used by jk/ci-linux32-update.)

 CI started failing completely for linux32 jobs, as the step to
 upload failed test directory uses GitHub actions that is deprecated
 and is now disabled.  Remove the step so at least we will know if
 the tests are passing.
 source: <xmqqy140o2kb.fsf@gitster.g>


* jk/ci-linux32-update (2024-09-13) 5 commits
  (merged to 'next' on 2024-09-13 at e937339388)
 + ci: add Ubuntu 16.04 job to GitLab CI
 + ci: use regular action versions for linux32 job
 + ci: use more recent linux32 image
 + ci: unify ubuntu and ubuntu32 dependencies
 + ci: drop run-docker scripts
 (this branch uses jc/ci-upload-artifact-and-linux32.)

 CI updates
 source: <20240912094238.GA589050@coredump.intra.peff.net>


* ps/clar-unit-test (2024-09-10) 15 commits
  (merged to 'next' on 2024-09-11 at ccc0289490)
 + Makefile: rename clar-related variables to avoid confusion
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
 cf. <d5b1c95b-cbdc-4711-849e-c2cfc67787ee@gmail.com>
 source: <cover.1725459142.git.ps@pks.im>

--------------------------------------------------
[Cooking]

* jk/diag-unexpected-remote-helper-death (2024-09-14) 1 commit
  (merged to 'next' on 2024-09-16 at f2aa29beac)
 + print an error when remote helpers die during capabilities

 When a remote-helper dies before Git writes to it, SIGPIPE killed
 Git silently.  We now explain the situation a bit better to the end
 user in our error message.

 Will merge to 'master'.
 source: <20240914064130.GA1284567@coredump.intra.peff.net>


* ak/typofixes (2024-09-16) 3 commits
  (merged to 'next' on 2024-09-16 at 4bbdd5ce45)
 + cbtree: fix a typo
 + bloom: fix a typo
 + attr: fix a typo

 Trivial typofixes.

 Will merge to 'master'.
 source: <20240915230522.129253-1-algonell@gmail.com>


* jk/jump-quickfix-fixes (2024-09-16) 2 commits
  (merged to 'next' on 2024-09-16 at 53aa9e5b22)
 + git-jump: ignore deleted files in diff mode
 + git-jump: always specify column 1 for diff entries

 A few usability fixes to "git jump" (in contrib/).

 Will merge to 'master'.
 source: <20240915111119.GA2017770@coredump.intra.peff.net>


* jk/t9001-deflake (2024-09-16) 1 commit
  (merged to 'next' on 2024-09-16 at 285ebc4223)
 + t9001: use a more distinct fake BugID

 Test fix.

 Will merge to 'master'.
 source: <20240915113115.GA2019070@coredump.intra.peff.net>


* ps/apply-leakfix (2024-09-17) 6 commits
  (merged to 'next' on 2024-09-18 at 99e318345e)
 + apply: refactor `struct image` to use a `struct strbuf`
 + apply: rename members that track line count and allocation length
 + apply: refactor code to drop `line_allocated`
 + apply: introduce macro and function to init images
 + apply: rename functions operating on `struct image`
 + apply: reorder functions to move image-related things together

 "git apply" had custom buffer management code that predated before
 use of strbuf got widespread, which has been updated to use strbuf,
 which also plugged some memory leaks.

 Will merge to 'master'.
 source: <cover.1726567217.git.ps@pks.im>


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
 (this branch uses ps/leakfixes-part-6.)

 More leak-fixes.

 Needs review.
 source: <cover.1726484308.git.ps@pks.im>


* ps/reftable-alloc-failures (2024-09-16) 24 commits
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
 (this branch uses ps/reftable-exclude.)

 The reftable library is now prepared to expect that the memory
 allocation function given to it may fail to allocate and to deal
 with such an error.

 Needs review.
 source: <cover.1726489647.git.ps@pks.im>


* bb/unicode-width-table-16 (2024-09-12) 1 commit
  (merged to 'next' on 2024-09-13 at 87dc391469)
 + unicode: update the width tables to Unicode 16

 Update the character width table for Unicode 16.

 Will merge to 'master'.
 source: <20240912204047.1020213-1-dev+git@drbeat.li>


* jc/strbuf-commented-something (2024-09-12) 2 commits
 - strbuf: retire strbuf_commented_lines()
 - strbuf: retire strbuf_commented_addf()

 Update two functions whose callers always pass the same global
 variable to omit the redundant parameter and use the global in the
 callee themselves.

 On hold.
 source: <20240912205301.1809355-1-gitster@pobox.com>


* jk/git-pm-bare-repo-fix (2024-09-13) 2 commits
  (merged to 'next' on 2024-09-13 at 7f9bb8501c)
 + Git.pm: use "rev-parse --absolute-git-dir" rather than perl code
 + Git.pm: fix bare repository search with Directory option

 In Git 2.39, Git.pm stopped working in a bare repository, which has
 been corrected.

 Will merge to 'master'.
 source: <20240912223413.GA649897@coredump.intra.peff.net>


* jc/t5512-sigpipe-fix (2024-09-13) 1 commit
  (merged to 'next' on 2024-09-16 at 96075b5dd1)
 + t5512.40 sometimes dies by SIGPIPE

 Test fix.

 Will merge to 'master'.
 source: <xmqqmskbwe1a.fsf@gitster.g>


* jk/interop-test-build-options (2024-09-12) 1 commit
  (merged to 'next' on 2024-09-13 at 0ab66e77a1)
 + t/interop: allow per-version make options

 The support to customize build options to adjust for older versions
 and/or older systems for the interop tests has been improved.

 Will merge to 'master'.
 source: <20240911061009.GA1538383@coredump.intra.peff.net>


* jk/no-openssl-with-openssl-sha1 (2024-09-12) 1 commit
  (merged to 'next' on 2024-09-13 at 07f5e4856d)
 + imap-send: handle NO_OPENSSL even when openssl exists

 The "imap-send" now allows to be compiled with NO_OPENSSL and
 OPENSSL_SHA1 defined together.

 Will merge to 'master'.
 source: <20240911061257.GA1538490@coredump.intra.peff.net>


* ma/test-libcurl-prereq (2024-09-11) 2 commits
  (merged to 'next' on 2024-09-13 at 6d4ad6b054)
 + t0211: add missing LIBCURL prereq
 + t1517: add missing LIBCURL prereq

 Test portability fix.

 Will merge to 'master'.
 source: <cover.1726049108.git.martin.agren@gmail.com>


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


* ps/reftable-exclude (2024-09-16) 7 commits
  (merged to 'next' on 2024-09-18 at 1f00fce314)
 + refs/reftable: wire up support for exclude patterns
 + reftable/reader: make table iterator reseekable
 + t/unit-tests: introduce reftable library
 + Makefile: stop listing test library objects twice
 + builtin/receive-pack: fix exclude patterns when announcing refs
 + refs: properly apply exclude patterns to namespaced refs
 + Merge branch 'cp/unit-test-reftable-stack' into ps/reftable-exclude
 (this branch is used by jc/cmake-unit-test-updates and ps/reftable-alloc-failures.)

 The reftable backend learned to more efficiently handle exclude
 patterns while enumerating the refs.

 Will merge to 'master'.
 source: <cover.1726476401.git.ps@pks.im>


* pw/rebase-autostash-fix (2024-09-03) 1 commit
  (merged to 'next' on 2024-09-13 at 6b41d66efd)
 + rebase: apply and cleanup autostash when rebase fails to start

 "git rebase --autostash" failed to resurrect the autostashed
 changes when the command gets aborted after giving back control
 asking for hlep in conflict resolution.

 Will merge to 'master'.
 source: <pull.1772.v2.git.1725289979450.gitgitgadget@gmail.com>


* jc/pass-repo-to-builtins (2024-09-13) 4 commits
  (merged to 'next' on 2024-09-16 at 7711bb0214)
 + add: pass in repo variable instead of global the_repository
 + builtin: remove USE_THE_REPOSITORY for those without the_repository
 + builtin: remove USE_THE_REPOSITORY_VARIABLE from builtin.h
 + builtin: add a repository parameter for builtin functions

 The convention to calling into built-in command implementation has
 been updated to pass the repository, if known, together with the
 prefix value.

 Will merge to 'master'.
 source: <pull.1778.v3.git.git.1726262177.gitgitgadget@gmail.com>


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

 Expecting a reroll.
 cf. <ZugMUv1xbnjYH-el@pks.im>
 source: <cover.1725651952.git.me@ttaylorr.com>


* ps/environ-wo-the-repository (2024-09-12) 21 commits
  (merged to 'next' on 2024-09-16 at c08e3eb6b8)
 + environment: stop storing "core.notesRef" globally
 + environment: stop storing "core.warnAmbiguousRefs" globally
 + environment: stop storing "core.preferSymlinkRefs" globally
 + environment: stop storing "core.logAllRefUpdates" globally
 + refs: stop modifying global `log_all_ref_updates` variable
 + branch: stop modifying `log_all_ref_updates` variable
 + repo-settings: track defaults close to `struct repo_settings`
 + repo-settings: split out declarations into a standalone header
 + environment: guard state depending on a repository
 + environment: reorder header to split out `the_repository`-free section
 + environment: move `set_git_dir()` and related into setup layer
 + environment: make `get_git_namespace()` self-contained
 + environment: move object database functions into object layer
 + config: make dependency on repo in `read_early_config()` explicit
 + config: document `read_early_config()` and `read_very_early_config()`
 + environment: make `get_git_work_tree()` accept a repository
 + environment: make `get_graft_file()` accept a repository
 + environment: make `get_index_file()` accept a repository
 + environment: make `get_object_directory()` accept a repository
 + environment: make `get_git_common_dir()` accept a repository
 + environment: make `get_git_dir()` accept a repository

 Code clean-up.

 Will merge to 'master'.
 source: <cover.1726139990.git.ps@pks.im>


* gt/unit-test-oidset (2024-08-25) 1 commit
 - unit-tests: add tests for oidset.h

 Another unit-test.

 Expecting a reroll.
 source: <20240824172028.39419-1-shyamthakkar001@gmail.com>


* ps/leakfixes-part-6 (2024-09-05) 22 commits
  (merged to 'next' on 2024-09-13 at 9be3125b10)
 + builtin/repack: fix leaking keep-pack list
 + merge-ort: fix two leaks when handling directory rename modifications
 + match-trees: fix leaking prefixes in `shift_tree()`
 + builtin/fmt-merge-msg: fix leaking buffers
 + builtin/grep: fix leaking object context
 + builtin/pack-objects: plug leaking list of keep-packs
 + builtin/repack: fix leaking line buffer when packing promisors
 + negotiator/skipping: fix leaking commit entries
 + shallow: fix leaking members of `struct shallow_info`
 + shallow: free grafts when unregistering them
 + object: clear grafts when clearing parsed object pool
 + gpg-interface: fix misdesigned signing key interfaces
 + send-pack: fix leaking push cert nonce
 + remote: fix leak in reachability check of a remote-tracking ref
 + remote: fix leaking tracking refs
 + builtin/submodule--helper: fix leaking refs on push-check
 + submodule: fix leaking fetch task data
 + upload-pack: fix leaking child process data on reachability checks
 + builtin/push: fix leaking refspec query result
 + send-pack: fix leaking common object IDs
 + fetch-pack: fix memory leaks on fetch negotiation
 + t/test-lib: allow skipping leak checks for passing tests
 (this branch is used by ps/leakfixes-part-7.)

 More leakfixes.

 Will merge to 'master'.
 source: <cover.1725530720.git.ps@pks.im>


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


* ja/doc-synopsis-markup (2024-09-05) 3 commits
  (merged to 'next' on 2024-09-16 at d471154a0b)
 + doc: apply synopsis simplification on git-clone and git-init
 + doc: update the guidelines to reflect the current formatting rules
 + doc: introduce a synopsis typesetting

 The way AsciiDoc is used for SYNOPSIS part of the manual pages has
 been revamped.  The sources, at least for the simple cases, got
 vastly pleasant to work with.

 Will merge to 'master'.
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
