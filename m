Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538409461
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268564; cv=none; b=aho6t3r8C6x7rz7qs3Azga5zBmd///L9xfx6quwtP7znkAiO2Kk50fS7z6eYT+JXPtzKj+xRZqKAnDcaDDXXsx5CTIhzHrxOpwafPg1iSJrzWIH4Nx428ZQfWDk8wifkkPRVqQ7y6VwN7ANO61adggua/4PB/YDClj+HVnCmdjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268564; c=relaxed/simple;
	bh=x8H1aeDCYI/l9pzhkd9KbGahtJy7MqNzIJ/h9HJUH2E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bo8pR/2TcaijjtEb6w6D37xIGyGy0d1Kpy/7DUgcgorTvuyrAhbphQq0/k+uT7fdge3eA2M+RIGiNZDE1+jHkb7LWl6C5i8kgJIOkyoLwf+9IeIEPmvbfpy+LojdDkE3wnSuCyQAgAfKzchbviz1L2xbDLGzLjVHW6t83lkS9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PhVNfnhe; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PhVNfnhe"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C6B551D6DFC;
	Tue,  6 Feb 2024 20:15:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=x
	8H1aeDCYI/l9pzhkd9KbGahtJy7MqNzIJ/h9HJUH2E=; b=PhVNfnhe7WZCH1FPK
	hk2kmpnVMVivrmlJydFVn4k2NA+fFAiriRUVQrkvIaA5NwrM4BXMyxz2h6Cm0xf7
	vTcLUcVUwtcyUbbFlFwGh2nayu5hHE51sfgSAEHF1UzIII5pAtcd5TZgPCvkNLAl
	M7TIWbAOhn/TM4sL+nAYNaefWY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF5A81D6DFB;
	Tue,  6 Feb 2024 20:15:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9ED11D6DFA;
	Tue,  6 Feb 2024 20:15:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2024, #03; Tue, 6)
X-master-at: 235986be822c9f8689be2e9a0b7804d0b1b6d821
X-next-at: 7a6a6b9afef46aae13590758ab4d6e6832820410
Date: Tue, 06 Feb 2024 17:15:57 -0800
Message-ID: <xmqqcyt9dqgi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 73718E4E-C556-11EE-8D41-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

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
[Graduated to 'master']

* cb/use-freebsd-13-2-at-cirrus-ci (2024-01-31) 1 commit
  (merged to 'next' on 2024-01-31 at f89dc8a289)
 + ci: update FreeBSD cirrus job

 Cirrus CI jobs started breaking because we specified version of
 FreeBSD that is no longer available, which has been corrected.
 source: <20240131191325.33228-1-carenas@gmail.com>


* jc/comment-style-fixes (2024-01-29) 3 commits
  (merged to 'next' on 2024-01-30 at a58d48a9ce)
 + reftable/pq_test: comment style fix
 + merge-ort.c: comment style fix
 + builtin/worktree: comment style fixes

 Rewrite //-comments to /* comments */ in files whose comments
 prevalently use the latter.
 source: <20240129202839.2234084-1-gitster@pobox.com>


* jc/make-libpath-template (2024-01-31) 2 commits
  (merged to 'next' on 2024-01-31 at 559d5138bc)
 + Makefile: simplify output of the libpath_template
 + Makefile: reduce repetitive library paths

 The Makefile often had to say "-L$(path) -R$(path)" that repeats
 the path to the same library directory for link time and runtime.
 A Makefile template is used to reduce such repetition.
 source: <20240131174220.4160560-1-gitster@pobox.com>


* jc/reftable-core-fsync (2024-01-30) 2 commits
  (merged to 'next' on 2024-01-30 at c3a79b6172)
 + reftable/stack: fsync "tables.list" during compaction
  (merged to 'next' on 2024-01-24 at cea12beddb)
 + reftable: honor core.fsync
 (this branch is used by ps/reftable-multi-level-indices-fix.)

 The write codepath for the reftable data learned to honor
 core.fsync configuration.
 source: <7bdafc9bd7f53f38a24d69a563615b6ad484e1ba.1706592127.git.ps@pks.im>


* jc/t0091-with-unknown-git (2024-01-30) 1 commit
  (merged to 'next' on 2024-01-31 at 3dfcad1b18)
 + t0091: allow test in a repository without tags

 The test did not work when Git was built from a repository without
 tags.
 source: <xmqqv87aabk3.fsf@gitster.g>


* jk/diff-external-with-no-index (2024-01-29) 1 commit
  (merged to 'next' on 2024-01-30 at 30c3e9f91d)
 + diff: handle NULL meta-info when spawning external diff

 "git diff --no-index file1 file2" segfaulted while invoking the
 external diff driver, which has been corrected.
 source: <20240129015708.GA1762343@coredump.intra.peff.net>


* js/win32-retry-pipe-write-on-enospc (2024-01-30) 1 commit
  (merged to 'next' on 2024-01-31 at 60ad589fd0)
 + win32: special-case `ENOSPC` when writing to a pipe

 Update to the code that writes to pipes on Windows.
 source: <pull.1648.git.1706650619950.gitgitgadget@gmail.com>


* jt/p4-spell-re-with-raw-string (2024-01-29) 1 commit
  (merged to 'next' on 2024-01-30 at 42b03b58eb)
 + git-p4: use raw string literals for regular expressions

 "git p4" update to squelch warnings from Python.
 source: <pull.1639.v2.git.1706312496608.gitgitgadget@gmail.com>


* kh/maintenance-use-xdg-when-it-should (2024-01-29) 1 commit
  (merged to 'next' on 2024-01-30 at c449ac74bf)
 + config: add back code comment

 Comment fix.
 source: <48d66e94ece3b763acbe933561d82157c02a5f58.1706466321.git.code@khaugsbakk.name>


* ps/reftable-compacted-tables-permission-fix (2024-01-26) 1 commit
  (merged to 'next' on 2024-01-29 at dbb06e1571)
 + reftable/stack: adjust permissions of compacted tables

 Reftable bugfix.
 source: <a211818108053754aca002726d0206623a347952.1706263589.git.ps@pks.im>


* ps/tests-with-ref-files-backend (2024-01-29) 6 commits
  (merged to 'next' on 2024-01-30 at 376b9c9c1b)
 + t: mark tests regarding git-pack-refs(1) to be backend specific
 + t5526: break test submodule differently
 + t1419: mark test suite as files-backend specific
 + t1302: make tests more robust with new extensions
 + t1301: mark test for `core.sharedRepository` as reffiles specific
 + t1300: make tests more robust with non-default ref backends
 (this branch is used by ps/reftable-backend.)

 Prepare existing tests on refs to work better with non-default
 backends.
 source: <cover.1706525813.git.ps@pks.im>


* rj/test-with-leak-check (2024-01-29) 4 commits
  (merged to 'next' on 2024-01-31 at 76e4596666)
 + t0080: mark as leak-free
 + test-lib: check for TEST_PASSES_SANITIZE_LEAK
 + t6113: mark as leak-free
 + t5332: mark as leak-free

 More tests that are supposed to pass leak sanitizer are marked as such.
 source: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>


* tb/pack-bitmap-drop-unused-struct-member (2024-01-29) 1 commit
  (merged to 'next' on 2024-01-30 at f3749b15fc)
 + pack-bitmap: drop unused `reuse_objects`

 Code clean-up.
 source: <0bbaf9a3591765161872fb71383263edb0c7ef83.1706328008.git.me@ttaylorr.com>

--------------------------------------------------
[New Topics]

* gt/at-is-synonym-for-head-in-add-patch (2024-02-03) 3 commits
 - SQUASH???
 - add-patch: classify '@' as a synonym for 'HEAD'
 - add-patch: remove unnecessary NEEDSWORK comment

 Teach "git checkout -p" and friends that "@" is a synonym for
 "HEAD".
 source: <20240202150434.11256-1-shyamthakkar001@gmail.com>


* js/unit-test-suite-runner (2024-02-03) 7 commits
 - t/Makefile: run unit tests alongside shell tests
 - unit tests: add rule for running with test-tool
 - test-tool run-command testsuite: support unit tests
 - test-tool run-command testsuite: remove hardcoded filter
 - test-tool run-command testsuite: get shell from env
 - t0080: turn t-basic unit test into a helper
 - Merge branch 'jk/unit-tests-buildfix' into js/unit-test-suite-runner
 (this branch uses jk/unit-tests-buildfix.)

 The "test-tool" has been taught to run testsuite tests in parallel,
 bypassing the need to use the "prove" tool.
 source: <cover.1706921262.git.steadmon@google.com>


* jc/sign-buffer-failure-propagation-fix (2024-02-06) 1 commit
 - tag: fix sign_buffer() call to create a signed tag


* js/check-null-from-read-object-file (2024-02-06) 1 commit
 - Always check the return value of `repo_read_object_file()`

 source: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>


* pb/template-for-single-commit-pr (2024-02-06) 1 commit
 - .github/PULL_REQUEST_TEMPLATE.md: add a note about single-commit PRs

 source: <pull.1665.v2.git.git.1707225612576.gitgitgadget@gmail.com>


* ps/report-failure-from-git-stash (2024-02-06) 1 commit
 - builtin/stash: report failure to write to index

 source: <cb098cf88cbfcbf7c4872f8887856629b909cb91.1707197653.git.ps@pks.im>


* tb/multi-pack-reuse-experiment (2024-02-05) 2 commits
 - pack-objects: enable multi-pack reuse via `feature.experimental`
 - t5332-multi-pack-reuse.sh: extract pack-objects helper functions

 source: <cover.1707173415.git.me@ttaylorr.com>

--------------------------------------------------
[Cooking]

* ps/reftable-backend (2024-02-02) 3 commits
 - ci: add jobs to test with the reftable backend
 - refs: introduce reftable backend
 - Merge branch 'ps/tests-with-ref-files-backend' into ps/reftable-backend

 Integrate the reftable code into the refs framework as a backend.

 Will merge to 'next'.
 source: <cover.1706862705.git.ps@pks.im>


* cc/rev-list-allow-missing-tips (2024-02-01) 3 commits
 - rev-list: add --allow-missing-tips to be used with --missing=...
 - t6022: fix 'even though' typo in comment
 - revision: clarify a 'return NULL' in get_reference()

 "git rev-list --missing=print" have learned to optionally take
 "--allow-missing-tips", which allows the objects at the starting
 points to be missing.

 Needs review.
 source: <20240201115809.1177064-1-christian.couder@gmail.com>


* ps/reftable-iteration-perf (2024-02-01) 7 commits
 - reftable/reader: add comments to `table_iter_next()`
 - reftable/record: don't try to reallocate ref record name
 - reftable/block: swap buffers instead of copying
 - reftable/pq: allocation-less comparison of entry keys
 - reftable/merged: skip comparison for records of the same subiter
 - reftable/merged: allocation-less dropping of shadowed records
 - reftable/record: introduce function to compare records by key

 The code to iterate over refs with the reftable backend has seen
 some optimization.

 Needs review.
 source: <cover.1706782841.git.ps@pks.im>


* ps/reftable-styles (2024-02-06) 9 commits
 - reftable/record: improve semantics when initializing records
 - reftable/merged: refactor initialization of iterators
 - reftable/merged: refactor seeking of records
 - reftable/stack: use `size_t` to track stack length
 - reftable/stack: use `size_t` to track stack slices during compaction
 - reftable/stack: index segments with `size_t`
 - reftable/stack: fix parameter validation when compacting range
 - reftable: introduce macros to allocate arrays
 - reftable: introduce macros to grow arrays

 Code clean-up in various reftable code paths.

 Will merge to 'next'.
 source: <cover.1707200355.git.ps@pks.im>


* pb/imap-send-wo-curl-build-fix (2024-02-01) 1 commit
  (merged to 'next' on 2024-02-05 at 18368f61a7)
 + imap-send: add missing "strbuf.h" include under NO_CURL

 Build fix.

 Will merge to 'master'.
 source: <pull.1664.git.git.1706833113569.gitgitgadget@gmail.com>


* jc/github-actions-update (2024-02-02) 1 commit
 - Merge branch 'jc/maint-github-actions-update' into jc/github-actions-update
 (this branch uses jc/maint-github-actions-update.)

 An evil merge of the other topic to a more modern codebase.

 Will merge to 'next'?


* jc/maint-github-actions-update (2024-02-02) 2 commits
 - GitHub Actions: update to github-script@v7
 - GitHub Actions: update to checkout@v4
 (this branch is used by jc/github-actions-update.)

 Squelch node.js 16 deprecation warnings from GitHub Actions CI
 by updating actions/github-script and actions/checkout that use
 node.js 20.

 Needs review.
 source: <20240202203935.1240458-1-gitster@pobox.com>


* jh/sparse-index-expand-to-path-fix (2024-02-02) 1 commit
  (merged to 'next' on 2024-02-06 at 17ec59dd9a)
 + sparse-index: pass string length to index_file_exists()

 A caller called index_file_exists() that takes a string expressed
 as <ptr, length> with a wrong length, which has been corrected.

 Will merge to 'master'.
 source: <pull.1649.git.1706897095273.gitgitgadget@gmail.com>


* jk/unit-tests-buildfix (2024-02-02) 4 commits
  (merged to 'next' on 2024-02-02 at 8838dd21e8)
 + t/Makefile: say the default target upfront
  (merged to 'next' on 2024-01-31 at 00df31c4c8)
 + t/Makefile: get UNIT_TESTS list from C sources
 + Makefile: remove UNIT_TEST_BIN directory with "make clean"
 + Makefile: use mkdir_p_parent_template for UNIT_TEST_BIN
 (this branch is used by js/unit-test-suite-runner.)

 Build dependency around unit tests has been fixed.

 Will merge to 'master'.
 source: <20240130053714.GA165967@coredump.intra.peff.net>
 source: <xmqqjznmtjr9.fsf@gitster.g>


* js/merge-tree-3-trees (2024-02-06) 5 commits
 - Always check `parse_tree*()`'s return value
 - t4301: verify that merge-tree fails on missing blob objects
 - merge-ort: do check `parse_tree()`'s return value
 - merge-tree: fail with a non-zero exit code on missing tree objects
  (merged to 'next' on 2024-01-30 at 0c77b04e59)
 + merge-tree: accept 3 trees as arguments

 "git merge-tree" has learned that the three trees involved in the
 3-way merge only need to be trees, not necessarily commits.

 Will cook in 'next'
 source: <pull.1647.v2.git.1706474063109.gitgitgadget@gmail.com>
 source: <pull.1651.git.1707212981.gitgitgadget@gmail.com>


* mh/credential-oauth-refresh-token-with-wincred (2024-01-29) 1 commit
  (merged to 'next' on 2024-02-05 at 68880a751a)
 + credential/wincred: store oauth_refresh_token

 Teach wincred credential backend to support oauth refresh token the
 same way as credential-cache and credential-libsecret backends.

 Will merge to 'master'.
 source: <pull.1534.v3.git.1706477103039.gitgitgadget@gmail.com>


* pb/complete-config (2024-01-29) 5 commits
 - completion: add an use _ _git_compute_second_level_config_vars_for_section
 - builtin/help: add --config-all-for-completion
 - completion: add and use _ _git_compute_first_level_config_vars_for_section
 - completion: complete 'submodule.*' config variables
 - completion: add space after config variable names also in Bash 3

 The command line completion script (in contrib/) learned to
 complete configuration variable names better.

 Needs review.
 source: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>


* rj/complete-reflog (2024-01-26) 4 commits
 - completion: reflog show <log-options>
 - completion: reflog with implicit "show"
 - completion: introduce __git_find_subcommand
 - completion: introduce __gitcomp_subcommand

 The command line completion script (in contrib/) learned to
 complete "git reflog" better.

 Needs review.
 source: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>


* jc/index-pack-fsck-levels (2024-02-01) 2 commits
  (merged to 'next' on 2024-02-02 at 0e4ef26aa1)
 + index-pack: --fsck-objects to take an optional argument for fsck msgs
 + index-pack: test and document --strict=<msg-id>=<severity>...

 The "--fsck-objects" option of "git index-pack" now can take the
 optional parameter to tweak severity of different fsck errors.

 Will merge to 'master'.
 source: <pull.1658.v4.git.git.1706751483.gitgitgadget@gmail.com>


* ps/reftable-multi-level-indices-fix (2024-02-01) 6 commits
 - reftable: document reading and writing indices
 - reftable/writer: fix writing multi-level indices
 - reftable/writer: simplify writing index records
 - reftable/writer: use correct type to iterate through index entries
 - reftable/reader: be more careful about errors in indexed seeks
 - Merge branch 'jc/reftable-core-fsync' into ps/reftable-multi-level-indices-fix

 Write multi-level indices for reftable has been corrected.

 Will merge to 'next'.
 source: <cover.1706773842.git.ps@pks.im>


* cp/unit-test-prio-queue (2024-01-22) 1 commit
  (merged to 'next' on 2024-02-01 at 38aa6559b0)
 + tests: move t0009-prio-queue.sh to the new unit testing framework

 Migrate priority queue test to unit testing framework.

 Will merge to 'master'.
 source: <pull.1642.v4.git.1705865326185.gitgitgadget@gmail.com>


* ml/log-merge-with-cherry-pick-and-other-pseudo-heads (2024-01-17) 2 commits
 - revision: implement `git log --merge` also for rebase/cherry_pick/revert
 - revision: ensure MERGE_HEAD is a ref in prepare_show_merge

 "git log --merge" learned to pay attention to CHERRY_PICK_HEAD and
 other kinds of *_HEAD pseudorefs.

 Comments?
 source: <xmqqzfxa9usx.fsf@gitster.g>


* bk/complete-bisect (2024-01-29) 9 commits
 - SQUASH???
 - completion: add tests for git-bisect
 - completion: bisect: recognize but do not complete view subcommand
 - completion: bisect: complete log opts for visualize subcommand
 - completion: log: use __git_complete_log_opts
 - completion: new function __git_complete_log_opts
 - completion: bisect: complete missing --first-parent and --no-checkout options
 - completion: bisect: complete custom terms and related options
 - completion: bisect: complete bad, new, old, and help subcommands

 Command line completion support (in contrib/) has been
 updated for "git bisect".

 Comments?
 cf. <ZaofJhHsFjRxx7a3@tanuki>
 source: <20240128223447.342493-1-britton.kerin@gmail.com>


* bk/complete-dirname-for-am-and-format-patch (2024-01-12) 1 commit
 - completion: dir-type optargs for am, format-patch

 Command line completion support (in contrib/) has been
 updated for a few commands to complete directory names where a
 directory name is expected.

 Needs review.
 source: <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>


* bk/complete-send-email (2024-01-12) 1 commit
 - completion: don't complete revs when --no-format-patch

 Command line completion support (in contrib/) has been taught to
 avoid offering revision names as candidates to "git send-email" when
 the command is used to send pre-generated files.

 Needs review.
 source: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>


* la/trailer-api (2024-02-06) 28 commits
 - trailer: introduce "template" term for readability
 - trailer_set_*(): put out parameter at the end
 - trailer: unify "--trailer ..." arg handling
 - trailer: deprecate "new_trailer_item" struct from API
 - trailer_add_arg_item(): drop new_trailer_item usage
 - trailer: add new helper functions to API
 - trailer: prepare to delete "parse_trailers_from_command_line_args()"
 - trailer: spread usage of "trailer_block" language
 - trailer: retire trailer_info_get() from API
 - trailer: make trailer_info struct private
 - sequencer: use the trailer iterator
 - trailer: teach iterator about non-trailer lines
 - trailer: finish formatting unification
 - format_trailer_info(): avoid double-printing the separator
 - format_trailer_info(): teach it about opts->trim_empty
 - trailer: begin formatting unification
 - format_trailer_info(): append newline for non-trailer lines
 - format_trailer_info(): drop redundant unfold_value()
 - format_trailer_info(): use trailer_item objects
 - format_trailers_from_commit(): indirectly call trailer_info_get()
 - format_trailer_info(): move "fast path" to caller
 - format_trailers(): use strbuf instead of FILE
 - trailer_info_get(): reorder parameters
 - trailer: start preparing for formatting unification
 - trailer: move interpret_trailers() to interpret-trailers.c
 - trailer: prepare to expose functions as part of API
 - shortlog: add test for de-duplicating folded trailers
 - trailer: free trailer_info _after_ all related usage

 Code clean-up.

 Needs review.
 source: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>


* cp/apply-core-filemode (2023-12-26) 3 commits
 - apply: code simplification
 - apply: correctly reverse patch's pre- and post-image mode bits
 - apply: ignore working tree filemode when !core.filemode

 "git apply" on a filesystem without filemode support have learned
 to take a hint from what is in the index for the path, even when
 not working with the "--index" or "--cached" option, when checking
 the executable bit match what is required by the preimage in the
 patch.

 Needs review.
 source: <20231226233218.472054-1-gitster@pobox.com>


* ja/doc-placeholders-fix (2023-12-26) 2 commits
  (merged to 'next' on 2024-02-05 at 047da8cbb0)
 + doc: enforce placeholders in documentation
 + doc: enforce dashes in placeholders

 Docfix.

 Will merge to 'master'.
 source: <pull.1626.git.1703539287.gitgitgadget@gmail.com>


* jc/bisect-doc (2023-12-09) 1 commit
 - bisect: document "terms" subcommand more fully

 Doc update.

 Needs review.
 source: <xmqqzfyjmk02.fsf@gitster.g>


* tb/path-filter-fix (2024-01-31) 16 commits
 - bloom: introduce `deinit_bloom_filters()`
 - commit-graph: reuse existing Bloom filters where possible
 - object.h: fix mis-aligned flag bits table
 - commit-graph: new Bloom filter version that fixes murmur3
 - commit-graph: unconditionally load Bloom filters
 - bloom: prepare to discard incompatible Bloom filters
 - bloom: annotate filters with hash version
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

 Waiting for a final ack?
 cf. <ZcFjkfbsBfk7JQIH@nand.local>
 source: <cover.1706741516.git.me@ttaylorr.com>


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


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>

--------------------------------------------------
[Discarded]

* tb/pair-chunk-expect (2023-11-10) 8 commits
 . midx: read `OOFF` chunk with `pair_chunk_expect()`
 . midx: read `OIDL` chunk with `pair_chunk_expect()`
 . commit-graph: read `BIDX` chunk with `pair_chunk_expect()`
 . commit-graph: read `GDAT` chunk with `pair_chunk_expect()`
 . commit-graph: read `CDAT` chunk with `pair_chunk_expect()`
 . commit-graph: read `OIDL` chunk with `pair_chunk_expect()`
 . chunk-format: introduce `pair_chunk_expect()` helper
 . Merge branch 'jk/chunk-bounds-more' into HEAD

 Further code clean-up.

 Retracted for now.
 cf. <ZcFjkfbsBfk7JQIH@nand.local>
 source: <cover.1699569246.git.me@ttaylorr.com>


* kn/for-all-refs (2024-01-29) 4 commits
  (merged to 'next' on 2024-01-30 at e7a9234a8b)
 + for-each-ref: avoid filtering on empty pattern
 + refs: introduce `refs_for_each_all_refs()`
 + refs: extract out `loose_fill_ref_dir_regular_file()`
 + refs: introduce `is_pseudoref()` and `is_headref()`

 "git for-each-ref" filters its output with prefixes given from the
 command line, but it did not honor an empty string to mean "pass
 everything", which has been corrected.

 Reverted out of 'next' to revamp its UI.
 source: <20240129113527.607022-1-karthik.188@gmail.com>
