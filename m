Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961A643
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920997; cv=none; b=cxriSUV0i5KTjYUiyN77l3XMOOR+nEy+zzVprAtmNdu3PvOv2X8gOdn73bldnQZOSn2D0j0SPxKt/rnzvXhIaoOKTKCefgnxHRSOvhUfza1VgKng7QPYpHjyyfMQF2mfKkb32+4W6UONqxUCh+sTa98E/XGK6LDhngudW5iui4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920997; c=relaxed/simple;
	bh=wKEJ5NsdwYoMXBZIO+L1dW4OBM4JRyNwdM86Owda0jk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cthz1usNcFJonUB8BSzjzyXo4qD512pv7v3gasVFUEvnzFRFjwWa0LP3flmLhp7iChBiUuNYfdJTlWte2MYwYekiq7UpnxbvIvBmuWPE2OogJaGhQ53XaZ0u6lGWx0yAaEXdwNE6DdxK1LBmP4BxWnEuvcUY5L1gnXueQEKyNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SmIkXm3a; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SmIkXm3a"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A31FE2859B;
	Fri,  2 Feb 2024 19:43:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=w
	KEJ5NsdwYoMXBZIO+L1dW4OBM4JRyNwdM86Owda0jk=; b=SmIkXm3a3+abNNRqL
	ltdnUMk7nVMmox4DrsJ1d+kUr0pzDKSPGf0bQMeIGerS+jY3rdtHxBZ0QgT4Wkme
	u1jDVS6OMrIO0m6XcJn2qtSIjLL9YRlWPORiyN1lDQzn599PcsDKgLBzgMqB7cCN
	F0/AQ9IeS8ZUWfKgpIjGU4ayxg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BEE22859A;
	Fri,  2 Feb 2024 19:43:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A22D228599;
	Fri,  2 Feb 2024 19:43:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2024, #01; Fri, 2)
X-master-at: 2a540e432fe5dff3cfa9d3bf7ca56db2ad12ebb9
X-next-at: 05954cdfa36fd5c325af9dde784879dcc78384ff
Date: Fri, 02 Feb 2024 16:43:06 -0800
Message-ID: <xmqqr0hutm1x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3367448C-C22D-11EE-A120-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

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

* ad/custom-merge-placeholder-for-symbolic-pathnames (2024-01-24) 1 commit
  (merged to 'next' on 2024-01-24 at d9cf4e227d)
 + merge-ll: expose revision names to custom drivers

 The labels on conflict markers for the common ancestor, our version,
 and the other version are available to custom 3-way merge driver
 via %S, %X, and %Y placeholders.
 source: <pull.1648.v4.git.git.1706126951879.gitgitgadget@gmail.com>


* jc/coc-whitespace-fix (2024-01-23) 1 commit
  (merged to 'next' on 2024-01-26 at 6fb290ad59)
 + CoC: whitespace fix

 Docfix.
 source: <xmqqmssvnb8d.fsf_-_@gitster.g>


* jc/ls-files-doc-update (2024-01-25) 1 commit
  (merged to 'next' on 2024-01-26 at a71aeec3d3)
 + ls-files: avoid the verb "deprecate" for individual options

 The documentation for the --exclude-per-directory option marked it
 as deprecated, which confused readers into thinking there may be a
 plan to remove it in the future, which was not our intention.
 source: <xmqqjznybfp4.fsf@gitster.g>


* jc/reffiles-tests (2024-01-22) 12 commits
  (merged to 'next' on 2024-01-24 at 0d1aaa6807)
 + t5312: move reffiles specific tests to t0601
 + t4202: move reffiles specific tests to t0600
 + t3903: make drop stash test ref backend agnostic
 + t1503: move reffiles specific tests to t0600
 + t1415: move reffiles specific tests to t0601
 + t1410: move reffiles specific tests to t0600
 + t1406: move reffiles specific tests to t0600
 + t1405: move reffiles specific tests to t0601
 + t1404: move reffiles specific tests to t0600
 + t1414: convert test to use Git commands instead of writing refs manually
 + remove REFFILES prerequisite for some tests in t1405 and t2017
 + t3210: move to t0601

 Tests on ref API are moved around to prepare for reftable.
 cf. <Za5TW-q4cKS8pNNc@tanuki>
 source: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>


* jk/fetch-auto-tag-following-fix (2024-01-24) 1 commit
  (merged to 'next' on 2024-01-26 at d058f1511b)
 + transport-helper: re-examine object dir after fetching

 Fetching via protocol v0 over Smart HTTP transport sometimes failed
 to correctly auto-follow tags.
 source: <20240124010056.GA2603087@coredump.intra.peff.net>


* jx/remote-archive-over-smart-http (2024-01-22) 6 commits
  (merged to 'next' on 2024-01-23 at 5fa4633015)
 + transport-helper: call do_take_over() in process_connect
 + transport-helper: call do_take_over() in connect_helper
 + http-backend: new rpc-service for git-upload-archive
 + transport-helper: protocol v2 supports upload-archive
 + remote-curl: supports git-upload-archive service
 + transport-helper: no connection restriction in connect_helper

 "git archive --remote=<remote>" learned to talk over the smart
 http (aka stateless) transport.
 source: <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>


* kl/allow-working-in-dot-git-in-non-bare-repository (2024-01-20) 1 commit
  (merged to 'next' on 2024-01-24 at e77b796e11)
 + setup: allow cwd=.git w/ bareRepository=explicit

 The "disable repository discovery of a bare repository" check,
 triggered by setting safe.bareRepository configuration variable to
 'explicit', has been loosened to exclude the ".git/" directory inside
 a non-bare repository from the check.  So you can do "cd .git &&
 git cmd" to run a Git command that works on a bare repository without
 explicitly specifying $GIT_DIR now.
 source: <pull.1645.git.1705709303098.gitgitgadget@gmail.com>


* pb/ci-github-skip-logs-for-broken-tests (2024-01-22) 1 commit
  (merged to 'next' on 2024-01-23 at f5e3ab2092)
 + ci(github): also skip logs of broken test cases

 GitHub CI update.
 cf. <dbe25fff-e1d4-41f2-8f8f-c538e8c2a77e@github.com>
 source: <pull.1649.git.git.1705808313306.gitgitgadget@gmail.com>


* pb/complete-log-more (2024-01-22) 4 commits
  (merged to 'next' on 2024-01-24 at 081d2a92fa)
 + completion: complete missing 'git log' options
 + completion: complete --encoding
 + completion: complete --patch-with-raw
 + completion: complete missing rev-list options

 The completion script (in contrib/) learned more options that can
 be used with "git log".
 source: <pull.1650.git.git.1705810071.gitgitgadget@gmail.com>


* rj/advice-disable-how-to-disable (2024-01-16) 2 commits
  (merged to 'next' on 2024-01-23 at f456f4937d)
 + advice: allow disabling the automatic hint in advise_if_enabled()
 + Merge branch 'rj/advice-delete-branch-not-fully-merged' into rj/advice-disable-how-to-disable

 All conditional "advice" messages show how to turn them off, which
 becomes repetitive.  Setting advice.* configuration explicitly on
 now omits the instruction part.
 source: <6a842ef8-b390-4739-9eef-e867d55ed5ea@gmail.com>


* rs/parse-options-with-keep-unknown-abbrev-fix (2024-01-22) 2 commits
  (merged to 'next' on 2024-01-23 at a216b482cd)
 + parse-options: simplify positivation handling
 + parse-options: fully disable option abbreviation with PARSE_OPT_KEEP_UNKNOWN

 "git diff --no-rename A B" did not disable rename detection but did
 not trigger an error from the command line parser.
 source: <579fd5bc-3bfd-427f-b22d-dab5e7e56eb2@web.de>
 source: <fb3c679a-5f00-4934-b028-6b2d081cd5b2@web.de>


* sd/negotiate-trace-fix (2024-01-03) 1 commit
  (merged to 'next' on 2024-01-24 at 6305853ab2)
 + push: region_leave trace for negotiate_using_fetch

 Tracing fix.
 source: <20240103224054.1940209-1-delmerico@google.com>


* zf/subtree-split-fix (2024-01-25) 1 commit
  (merged to 'next' on 2024-01-26 at a09e02f208)
 + subtree: fix split processing with multiple subtrees present

 "git subtree" (in contrib/) update.
 source: <pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com>

--------------------------------------------------
[New Topics]

* jc/t0091-with-unknown-git (2024-01-30) 1 commit
  (merged to 'next' on 2024-01-31 at 3dfcad1b18)
 + t0091: allow test in a repository without tags

 The test did not work when Git was built from a repository without
 tags.

 Will merge to 'master'.
 source: <xmqqv87aabk3.fsf@gitster.g>


* ps/reftable-backend (2024-02-02) 3 commits
 - ci: add jobs to test with the reftable backend
 - refs: introduce reftable backend
 - Merge branch 'ps/tests-with-ref-files-backend' into ps/reftable-backend
 (this branch uses ps/tests-with-ref-files-backend.)

 Integrate the reftable code into the refs framework as a backend.

 Needs review.
 source: <cover.1706862705.git.ps@pks.im>


* js/win32-retry-pipe-write-on-enospc (2024-01-30) 1 commit
  (merged to 'next' on 2024-01-31 at 60ad589fd0)
 + win32: special-case `ENOSPC` when writing to a pipe

 Update to the code that writes to pipes on Windows.

 Will merge to 'master'.
 source: <pull.1648.git.1706650619950.gitgitgadget@gmail.com>


* jc/make-libpath-template (2024-01-31) 2 commits
  (merged to 'next' on 2024-01-31 at 559d5138bc)
 + Makefile: simplify output of the libpath_template
 + Makefile: reduce repetitive library paths

 The Makefile often had to say "-L$(path) -R$(path)" that repeats
 the path to the same library directory for link time and runtime.
 A Makefile template is used to reduce such repetition.

 Will merge to 'master'.
 source: <20240131174220.4160560-1-gitster@pobox.com>


* cb/use-freebsd-13-2-at-cirrus-ci (2024-01-31) 1 commit
  (merged to 'next' on 2024-01-31 at f89dc8a289)
 + ci: update FreeBSD cirrus job

 Cirrus CI jobs started breaking because we specified version of
 FreeBSD that is no longer available, which has been corrected.

 Will merge to 'master'.
 source: <20240131191325.33228-1-carenas@gmail.com>


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


* ps/reftable-styles (2024-02-01) 9 commits
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

 Needs review.
 source: <cover.1706772591.git.ps@pks.im>


* pb/imap-send-wo-curl-build-fix (2024-02-01) 1 commit
 - imap-send: add missing "strbuf.h" include under NO_CURL

 Build fix.

 Will merge to 'next'.
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
 - sparse-index: pass string length to index_file_exists()

 A caller called index_file_exists() that takes a string expressed
 as <ptr, length> with a wrong length, which has been corrected.

 Will merge to 'next'.
 source: <pull.1649.git.1706897095273.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* jc/comment-style-fixes (2024-01-29) 3 commits
  (merged to 'next' on 2024-01-30 at a58d48a9ce)
 + reftable/pq_test: comment style fix
 + merge-ort.c: comment style fix
 + builtin/worktree: comment style fixes

 Rewrite //-comments to /* comments */ in files whose comments
 prevalently use the latter.

 Will merge to 'master'.
 source: <20240129202839.2234084-1-gitster@pobox.com>


* jk/diff-external-with-no-index (2024-01-29) 1 commit
  (merged to 'next' on 2024-01-30 at 30c3e9f91d)
 + diff: handle NULL meta-info when spawning external diff

 "git diff --no-index file1 file2" segfaulted while invoking the
 external diff driver, which has been corrected.

 Reverted out of 'next' for now, seems to break "win test (n)" jobs.
 cf. <xmqqh6irwtkd.fsf@gitster.g>
 source: <20240129015708.GA1762343@coredump.intra.peff.net>


* jk/unit-tests-buildfix (2024-01-31) 3 commits
  (merged to 'next' on 2024-01-31 at 00df31c4c8)
 + t/Makefile: get UNIT_TESTS list from C sources
 + Makefile: remove UNIT_TEST_BIN directory with "make clean"
 + Makefile: use mkdir_p_parent_template for UNIT_TEST_BIN

 Build dependency around unit tests has been fixed.

 Will merge to 'master'.
 source: <20240130053714.GA165967@coredump.intra.peff.net>


* js/merge-tree-3-trees (2024-01-29) 1 commit
  (merged to 'next' on 2024-01-30 at 0c77b04e59)
 + merge-tree: accept 3 trees as arguments

 "git merge-tree" has learned that the three trees involved in the
 3-way merge only need to be trees, not necessarily commits.

 Will merge to 'master'.
 source: <pull.1647.v2.git.1706474063109.gitgitgadget@gmail.com>


* jt/p4-spell-re-with-raw-string (2024-01-29) 1 commit
  (merged to 'next' on 2024-01-30 at 42b03b58eb)
 + git-p4: use raw string literals for regular expressions

 "git p4" update to squelch warnings from Python.

 Will merge to 'master'.
 source: <pull.1639.v2.git.1706312496608.gitgitgadget@gmail.com>


* kh/maintenance-use-xdg-when-it-should (2024-01-29) 1 commit
  (merged to 'next' on 2024-01-30 at c449ac74bf)
 + config: add back code comment

 Comment fix.

 Will merge to 'master'.
 source: <48d66e94ece3b763acbe933561d82157c02a5f58.1706466321.git.code@khaugsbakk.name>


* mh/credential-oauth-refresh-token-with-wincred (2024-01-29) 1 commit
 - credential/wincred: store oauth_refresh_token

 Teach wincred credential backend to support oauth refresh token the
 same way as credential-cache and credential-libsecret backends.

 Will merge to 'next'.
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


* rj/test-with-leak-check (2024-01-29) 4 commits
  (merged to 'next' on 2024-01-31 at 76e4596666)
 + t0080: mark as leak-free
 + test-lib: check for TEST_PASSES_SANITIZE_LEAK
 + t6113: mark as leak-free
 + t5332: mark as leak-free

 More tests that are supposed to pass leak sanitizer are marked as such.

 Will merge to 'master'.
 source: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>


* tb/pack-bitmap-drop-unused-struct-member (2024-01-29) 1 commit
  (merged to 'next' on 2024-01-30 at f3749b15fc)
 + pack-bitmap: drop unused `reuse_objects`

 Code clean-up.

 Will merge to 'master'.
 source: <0bbaf9a3591765161872fb71383263edb0c7ef83.1706328008.git.me@ttaylorr.com>


* ps/reftable-compacted-tables-permission-fix (2024-01-26) 1 commit
  (merged to 'next' on 2024-01-29 at dbb06e1571)
 + reftable/stack: adjust permissions of compacted tables

 Reftable bugfix.

 Will merge to 'master'.
 source: <a211818108053754aca002726d0206623a347952.1706263589.git.ps@pks.im>


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
 (this branch uses jc/reftable-core-fsync.)

 Write multi-level indices for reftable has been corrected.

 Needs review.
 source: <cover.1706773842.git.ps@pks.im>


* jc/reftable-core-fsync (2024-01-30) 2 commits
  (merged to 'next' on 2024-01-30 at c3a79b6172)
 + reftable/stack: fsync "tables.list" during compaction
  (merged to 'next' on 2024-01-24 at cea12beddb)
 + reftable: honor core.fsync
 (this branch is used by ps/reftable-multi-level-indices-fix.)

 The write codepath for the reftable data learned to honor
 core.fsync configuration.

 Will merge to 'master'.
 source: <7bdafc9bd7f53f38a24d69a563615b6ad484e1ba.1706592127.git.ps@pks.im>


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


* kn/for-all-refs (2024-01-29) 4 commits
  (merged to 'next' on 2024-01-30 at e7a9234a8b)
 + for-each-ref: avoid filtering on empty pattern
 + refs: introduce `refs_for_each_all_refs()`
 + refs: extract out `loose_fill_ref_dir_regular_file()`
 + refs: introduce `is_pseudoref()` and `is_headref()`

 "git for-each-ref" filters its output with prefixes given from the
 command line, but it did not honor an empty string to mean "pass
 everything", which has been corrected.

 Will merge to 'master'.
 source: <20240129113527.607022-1-karthik.188@gmail.com>


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


* la/trailer-api (2024-01-30) 10 commits
 - trailer: introduce "template" term for readability
 - trailer: delete obsolete argument handling code from API
 - trailer: move arg handling to interpret-trailers.c
 - trailer: prepare to move parse_trailers_from_command_line_args() to builtin
 - trailer: spread usage of "trailer_block" language
 - trailer: make trailer_info struct private
 - sequencer: use the trailer iterator
 - trailer: unify trailer formatting machinery
 - trailer: move interpret_trailers() to interpret-trailers.c
 - trailer: prepare to expose functions as part of API

 Code clean-up.

 Needs review.
 cf. <xmqqa5ol409k.fsf@gitster.g>
 source: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>


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

 Will merge to 'master'.
 source: <cover.1706525813.git.ps@pks.im>


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
 - doc: enforce placeholders in documentation
 - doc: enforce dashes in placeholders

 Docfix.

 Will merge to 'next'.
 source: <pull.1626.git.1703539287.gitgitgadget@gmail.com>


* jc/bisect-doc (2023-12-09) 1 commit
 - bisect: document "terms" subcommand more fully

 Doc update.

 Needs review.
 source: <xmqqzfyjmk02.fsf@gitster.g>


* tb/pair-chunk-expect (2023-11-10) 8 commits
 - midx: read `OOFF` chunk with `pair_chunk_expect()`
 - midx: read `OIDL` chunk with `pair_chunk_expect()`
 - commit-graph: read `BIDX` chunk with `pair_chunk_expect()`
 - commit-graph: read `GDAT` chunk with `pair_chunk_expect()`
 - commit-graph: read `CDAT` chunk with `pair_chunk_expect()`
 - commit-graph: read `OIDL` chunk with `pair_chunk_expect()`
 - chunk-format: introduce `pair_chunk_expect()` helper
 - Merge branch 'jk/chunk-bounds-more' into HEAD

 Further code clean-up.

 Needs review.
 source: <cover.1699569246.git.me@ttaylorr.com>


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
