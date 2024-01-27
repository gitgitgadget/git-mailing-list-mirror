Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAE38C14
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706317219; cv=none; b=gQUvmKcdKL30PDAQGsv+JUMinnLsURZ1PfOTSJjkWP6xIG72XJC8ubXe3JapXvq1+UcFfrVAu9HqfcqFZoXRrhvK7HsI6T6lGpD4UlRbAL18NP7z6iKgsFWime3470x1bn1+pPWPkKgzLnV0RBoHiBS5a0oO7lxydQLpg7AFa48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706317219; c=relaxed/simple;
	bh=Sc+ZXu1MEEGOuzncRsWJ7FileInN3N1XWEKNCb+72Yk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hj/pGfHUdwRXiQl2GO/Xc+3WHE16yETEm4wPB4KFU38xOOSFn+qw6r0csBmGsbieuC6eXDnmjHdzIqtIDujMS1x4g+k3/Aa6PcT4k8UETAMPEM1c9A0GPrmyDal/4L5+TrkSDt8pAvOrHUh5rqMzsk8Y7bZBtueEvvKWw8O3Q8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N6Earv4o; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N6Earv4o"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BF231CC4FD;
	Fri, 26 Jan 2024 20:00:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=S
	c+ZXu1MEEGOuzncRsWJ7FileInN3N1XWEKNCb+72Yk=; b=N6Earv4oQ08H3KyjP
	VCa/OJws+X13D3/cuQP1xcpioZsYd+/FVxzjH3DxQXSVFytBZtZC8RONqftcM8/J
	HI0i885V3zAaRd1/m/PSq1X58X4XtVtIcVPm6vEzUd5Gw9CC3GXGkiG8qe2ZCG7U
	k9VtPlc/asYThsU0kN6n5iqRz0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE0CF1CC4F8;
	Fri, 26 Jan 2024 20:00:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F15611CC4E3;
	Fri, 26 Jan 2024 20:00:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2024, #08; Fri, 26)
X-master-at: b50a608ba20348cb3dfc16a696816d51780e3f0f
X-next-at: 3e4c9d132487b980300188f22102599edd76b6cd
Date: Fri, 26 Jan 2024 17:00:02 -0800
Message-ID: <xmqq5xzflhf1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 684ADE4E-BCAF-11EE-9894-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

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

* al/unit-test-ctype (2024-01-16) 1 commit
  (merged to 'next' on 2024-01-19 at fcdad0d06c)
 + unit-tests: rewrite t/helper/test-ctype.c as a unit test

 Move test-ctype helper to the unit-test framework.
 source: <20240112102743.1440-1-ach.lumap@gmail.com>


* es/some-up-to-date-messages-must-stay (2024-01-12) 1 commit
  (merged to 'next' on 2024-01-16 at 2b598f7de2)
 + messages: mark some strings with "up-to-date" not to touch

 Comment updates to help developers not to attempt to modify
 messages from plumbing commands that must stay constant.

 It might make sense to reassess the plumbing needs every few years,
 but that should be done as a separate effort.
 source: <20240112171910.11131-1-ericsunshine@charter.net>


* gt/test-commit-o-i-options (2024-01-17) 2 commits
  (merged to 'next' on 2024-01-19 at 0377e2c148)
 + t7501: add tests for --amend --signoff
 + t7501: add tests for --include and --only

 A few tests to "git commit -o <pathspec>" and "git commit -i
 <pathspec>" has been added.
 source: <20240117161421.17333-1-shyamthakkar001@gmail.com>


* jt/tests-with-reftable (2024-01-12) 2 commits
  (merged to 'next' on 2024-01-19 at 498d203a57)
 + t5541: remove lockfile creation
 + t1401: remove lockfile creation

 Tweak a few tests not to manually modify the reference database
 (hence easier to work with other backends like reftable).
 source: <pull.1634.v2.git.1705004670.gitgitgadget@gmail.com>


* kh/maintenance-use-xdg-when-it-should (2024-01-18) 4 commits
  (merged to 'next' on 2024-01-19 at 9c8c7b2e9d)
 + maintenance: use XDG config if it exists
 + config: factor out global config file retrieval
 + config: rename global config function
 + config: format newlines

 When $HOME/.gitignore is missing but XDG config file available, we
 should write into the latter, not former.  "git gc" and "git
 maintenance" wrote into a wrong "global config" file, which have
 been corrected.
 source: <cover.1705593810.git.code@khaugsbakk.name>


* la/strvec-comment-fix (2024-01-12) 1 commit
  (merged to 'next' on 2024-01-19 at 120ef16493)
 + strvec: use correct member name in comments

 Comment fix.
 source: <pull.1640.git.1705043195997.gitgitgadget@gmail.com>


* mj/gitweb-unreadable-config-error (2024-01-10) 1 commit
  (merged to 'next' on 2024-01-19 at 790b7a7855)
 + gitweb: die when a configuration file cannot be read

 When given an existing but unreadable file as a configuration file,
 gitweb behaved as if the file did not exist at all, but now it
 errors out.  This is a change that may break backward compatibility.
 source: <20240110225709.30168-1-marcelo.jimenez@gmail.com>


* ne/doc-filter-blob-limit-fix (2024-01-16) 1 commit
  (merged to 'next' on 2024-01-19 at 4f78975728)
 + rev-list-options: fix off-by-one in '--filter=blob:limit=<n>' explainer

 Docfix.
 source: <pull.1645.git.git.1705261850650.gitgitgadget@gmail.com>


* ps/commit-graph-write-leakfix (2024-01-15) 1 commit
  (merged to 'next' on 2024-01-19 at df537fac39)
 + commit-graph: fix memory leak when not writing graph

 Leakfix.
 source: <0feab5e7d5bc6275e2c7671cd8f6786ea86fd610.1702891190.git.ps@pks.im>


* ps/completion-with-reftable-fix (2024-01-16) 5 commits
  (merged to 'next' on 2024-01-19 at 8854a7d903)
 + completion: treat dangling symrefs as existing pseudorefs
 + completion: silence pseudoref existence check
 + completion: improve existence check for pseudo-refs
 + t9902: verify that completion does not print anything
 + completion: discover repo path in `__git_pseudoref_exists ()`

 Completion update to prepare for reftable
 source: <cover.1705314554.git.ps@pks.im>


* ps/gitlab-ci-macos (2024-01-18) 6 commits
  (merged to 'next' on 2024-01-19 at a239dc8140)
 + ci: add macOS jobs to GitLab CI
 + ci: make p4 setup on macOS more robust
 + ci: handle TEST_OUTPUT_DIRECTORY when printing test failures
 + Makefile: detect new Homebrew location for ARM-based Macs
 + t7527: decrease likelihood of racing with fsmonitor daemon
 + Merge branch 'ps/gitlab-ci-static-analysis' into ps/gitlab-ci-macos

 CI for GitLab learned to drive macOS jobs.
 source: <cover.1705573336.git.ps@pks.im>


* ps/worktree-refdb-initialization (2024-01-08) 7 commits
  (merged to 'next' on 2024-01-19 at e8c649a3ac)
 + builtin/worktree: create refdb via ref backend
 + worktree: expose interface to look up worktree by name
 + builtin/worktree: move setup of commondir file earlier
 + refs/files: skip creation of "refs/{heads,tags}" for worktrees
 + setup: move creation of "refs/" into the files backend
 + refs: prepare `refs_init_db()` for initializing worktree refs
 + Merge branch 'ps/refstorage-extension' into ps/worktree-refdb-initialization

 Instead of manually creating refs/ hierarchy on disk upon a
 creation of a secondary worktree, which is only usable via the
 files backend, use the refs API to populate it.
 source: <cover.1704705733.git.ps@pks.im>


* rj/advice-delete-branch-not-fully-merged (2024-01-11) 3 commits
  (merged to 'next' on 2024-01-19 at 7102eb6b79)
 + branch: make the advice to force-deleting a conditional one
 + advice: fix an unexpected leading space
 + advice: sort the advice related lists
 (this branch is used by rj/advice-disable-how-to-disable.)

 The error message given when "git branch -d branch" fails due to
 commits unique to the branch has been split into an error and a new
 conditional advice message.
 source: <4aedc15c-4b3f-4f5e-abea-581b501600f8@gmail.com>


* vd/fsck-submodule-url-test (2024-01-19) 4 commits
  (merged to 'next' on 2024-01-19 at dad35ae82c)
 + submodule-config.c: strengthen URL fsck check
 + t7450: test submodule urls
 + test-submodule: remove command line handling for check-name
 + submodule-config.h: move check_submodule_url

 Tighten URL checks fsck makes in a URL recorded for submodules.
 source: <pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>

--------------------------------------------------
[New Topics]

* jc/coc-whitespace-fix (2024-01-23) 1 commit
  (merged to 'next' on 2024-01-26 at 6fb290ad59)
 + CoC: whitespace fix

 Docfix.

 Will merge to 'master'.
 source: <xmqqmssvnb8d.fsf_-_@gitster.g>


* jc/ls-files-doc-update (2024-01-25) 1 commit
  (merged to 'next' on 2024-01-26 at a71aeec3d3)
 + ls-files: avoid the verb "deprecate" for individual options

 The documentation for the --exclude-per-directory option marked it
 as deprecated, which confused readers into thinking there may be a
 plan to remove it in the future, which was not our intention.

 Will merge to 'master'.
 source: <xmqqjznybfp4.fsf@gitster.g>


* jk/fetch-auto-tag-following-fix (2024-01-24) 1 commit
  (merged to 'next' on 2024-01-26 at d058f1511b)
 + transport-helper: re-examine object dir after fetching

 Fetching via protocol v0 over Smart HTTP transport sometimes failed
 to correctly auto-follow tags.

 Will merge to 'master'.
 source: <20240124010056.GA2603087@coredump.intra.peff.net>


* ps/reftable-compacted-tables-permission-fix (2024-01-26) 1 commit
 - reftable/stack: adjust permissions of compacted tables

 Reftable bugfix.

 Will merge to 'next'.
 source: <a211818108053754aca002726d0206623a347952.1706263589.git.ps@pks.im>


* jc/index-pack-fsck-levels (2024-01-26) 2 commits
 - index-pack: --fsck-objects to take an optional argument for fsck msgs
 - index-pack: test and document --strict=<msg-id>=<severity>...

 The "--fsck-objects" option of "git index-pack" now can take the
 optional parameter to tweak severity of different fsck errors.

 Expecting a reroll.
 cf. <BF772E83-2BFE-4652-A742-67FADF3D8FE2@gmail.com>
 source: <pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>


* zf/subtree-split-fix (2024-01-25) 1 commit
  (merged to 'next' on 2024-01-26 at a09e02f208)
 + subtree: fix split processing with multiple subtrees present

 "git subtree" (in contrib/) update.

 Will merge to 'master'.
 source: <pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com>


* ps/reftable-multi-level-indices-fix (2024-01-26) 6 commits
 - reftable: document reading and writing indices
 - reftable/writer: fix writing multi-level indices
 - reftable/writer: simplify writing index records
 - reftable/writer: use correct type to iterate through index entries
 - reftable/reader: be more careful about errors in indexed seeks
 - Merge branch 'jc/reftable-core-fsync' into ps/reftable-multi-level-indices-fix
 (this branch uses jc/reftable-core-fsync.)

 Write multi-level indices for reftable has been corrected.
 source: <cover.1706263918.git.ps@pks.im>

--------------------------------------------------
[Cooking]

* al/t2400-depipe (2024-01-20) 1 commit
  (merged to 'next' on 2024-01-22 at a20d4a9a7f)
 + t2400: avoid losing exit status to pipes

 Coding style fix.

 Will merge to 'master'.
 source: <20240120021547.199-1-ach.lumap@gmail.com>


* kl/allow-working-in-dot-git-in-non-bare-repository (2024-01-20) 1 commit
  (merged to 'next' on 2024-01-24 at e77b796e11)
 + setup: allow cwd=.git w/ bareRepository=explicit

 Loosen "disable repository discovery of a bare repository" check,
 triggered by setting safe.bareRepository configuration variable to
 'explicit', to exclude the ".git/" directory inside a non-bare
 repository from the check.

 Will merge to 'master'.
 source: <pull.1645.git.1705709303098.gitgitgadget@gmail.com>


* rs/parse-options-with-keep-unknown-abbrev-fix (2024-01-22) 2 commits
  (merged to 'next' on 2024-01-23 at a216b482cd)
 + parse-options: simplify positivation handling
 + parse-options: fully disable option abbreviation with PARSE_OPT_KEEP_UNKNOWN

 "git diff --no-rename A B" did not disable rename detection but did
 not trigger an error from the command line parser.

 Will merge to 'master'.
 source: <579fd5bc-3bfd-427f-b22d-dab5e7e56eb2@web.de>
 source: <fb3c679a-5f00-4934-b028-6b2d081cd5b2@web.de>


* pb/ci-github-skip-logs-for-broken-tests (2024-01-22) 1 commit
  (merged to 'next' on 2024-01-23 at f5e3ab2092)
 + ci(github): also skip logs of broken test cases

 GitHub CI update.

 Will merge to 'master'.
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

 Will merge to 'master'.
 source: <pull.1650.git.git.1705810071.gitgitgadget@gmail.com>


* jc/reftable-core-fsync (2024-01-23) 1 commit
  (merged to 'next' on 2024-01-24 at cea12beddb)
 + reftable: honor core.fsync
 (this branch is used by ps/reftable-multi-level-indices-fix.)

 The write codepath for the reftable data learned to honor
 core.fsync configuration.

 Will merge to 'master'.
 source: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com>


* ad/custom-merge-placeholder-for-symbolic-pathnames (2024-01-24) 1 commit
  (merged to 'next' on 2024-01-24 at d9cf4e227d)
 + merge-ll: expose revision names to custom drivers

 The labels on conflict markers for the common ancestor, our version,
 and the other version are available to custom 3-way merge driver
 via %S, %X, and %Y placeholders.

 Will merge to 'master'.
 source: <pull.1648.v4.git.git.1706126951879.gitgitgadget@gmail.com>


* cp/unit-test-prio-queue (2024-01-22) 1 commit
 - tests: move t0009-prio-queue.sh to the new unit testing framework

 Migrate priority queue test to unit testing framework.
 source: <pull.1642.v4.git.1705865326185.gitgitgadget@gmail.com>


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

 Will merge to 'master'.
 cf. <Za5TW-q4cKS8pNNc@tanuki>
 source: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>


* ml/log-merge-with-cherry-pick-and-other-pseudo-heads (2024-01-17) 2 commits
 - revision: implement `git log --merge` also for rebase/cherry_pick/revert
 - revision: ensure MERGE_HEAD is a ref in prepare_show_merge

 "git log --merge" learned to pay attention to CHERRY_PICK_HEAD and
 other kinds of *_HEAD pseudorefs.

 Comments?
 source: <xmqqzfxa9usx.fsf@gitster.g>


* nb/rebase-x-shell-docfix (2024-01-17) 1 commit
  (merged to 'next' on 2024-01-22 at db49e10354)
 + rebase: fix documentation about used shell in -x

 Doc update.

 Will merge to 'master'.
 source: <20240117085347.948960-1-nik.borisov@suse.com>


* tc/show-ref-exists-fix (2024-01-18) 1 commit
  (merged to 'next' on 2024-01-22 at 831452f2dd)
 + builtin/show-ref: treat directory as non-existing in --exists

 Update to a new feature recently added, "git show-ref --exists".

 Will merge to 'master'.
 source: <20240110141559.387815-2-toon@iotcl.com>


* gt/t0024-style-fixes (2024-01-20) 2 commits
  (merged to 'next' on 2024-01-22 at 36b46efbd0)
 + t0024: style fix
 + t0024: avoid losing exit status to pipes

 Coding style fix.

 Will merge to 'master'.
 source: <20240118215407.8609-1-shyamthakkar001@gmail.com>


* jc/majordomo-to-subspace (2024-01-20) 1 commit
  (merged to 'next' on 2024-01-22 at 6a95f43de4)
 + Docs: majordomo@vger.kernel.org has been decomissioned

 Doc update.

 Will merge to 'master'.
 source: <xmqqmst1hsd6.fsf@gitster.g>


* js/oss-fuzz-build-in-ci (2024-01-19) 2 commits
  (merged to 'next' on 2024-01-22 at 2954da5a39)
 + ci: build and run minimal fuzzers in GitHub CI
 + fuzz: fix fuzz test build rules

 oss-fuzz tests are built and run in CI.

 Will merge to 'master'.
 source: <cover.1705700054.git.steadmon@google.com>


* kn/for-all-refs (2024-01-24) 4 commits
 - for-each-ref: avoid filtering on empty pattern
 - refs: introduce `refs_for_each_all_refs()`
 - refs: extract out `loose_fill_ref_dir_regular_file()`
 - refs: introduce `is_pseudoref()` and `is_headref()`

 "git for-each-ref" filters its output with prefixes given from the
 command line, but it did not honor an empty string to mean "pass
 everything", which has been corrected.

 Expecting a reroll?
 cf. <xmqqfrymeega.fsf@gitster.g>
 source: <20240124152726.124873-1-karthik.188@gmail.com>


* ps/not-so-many-refs-are-special (2024-01-19) 7 commits
  (merged to 'next' on 2024-01-22 at f70f463847)
 + Documentation: add "special refs" to the glossary
 + refs: redefine special refs
 + refs: convert MERGE_AUTOSTASH to become a normal pseudo-ref
 + sequencer: introduce functions to handle autostashes via refs
 + refs: convert AUTO_MERGE to become a normal pseudo-ref
 + sequencer: delete REBASE_HEAD in correct repo when picking commits
 + sequencer: clean up pseudo refs with REF_NO_DEREF

 Define "special ref" as a very narrow set that consists of
 FETCH_HEAD and MERGE_HEAD, and clarify everything else that used to
 be classified as such are actually just pseudorefs.

 Will merge to 'master'.
 source: <cover.1705659748.git.ps@pks.im>


* bk/complete-bisect (2024-01-18) 5 commits
 - completion: git-bisect view recognized but not completed
 - completion: custom git-bisect terms
 - completion: move to maintain define-before-use
 - completion: git-log opts to bisect visualize
 - completion: complete new old actions, start opts

 Command line completion support (in contrib/) has been
 updated for "git bisect".

 Expecting a reroll.
 cf. <ZaofJhHsFjRxx7a3@tanuki>
 source: <20240118204323.1113859-1-britton.kerin@gmail.com>


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


* la/trailer-api (2024-01-12) 10 commits
 - trailer: delete obsolete argument handling code from API
 - trailer: move arg handling to interpret-trailers.c
 - trailer: prepare to move parse_trailers_from_command_line_args() to builtin
 - trailer: spread usage of "trailer_block" language
 - trailer: make trailer_info struct private
 - sequencer: use the trailer iterator
 - trailer: delete obsolete formatting functions
 - trailer: unify trailer formatting machinery
 - trailer: include "trailer" term in API functions
 - trailer: move process_trailers() to interpret-trailers.c

 Code clean-up.

 Expecting a (hopefully final and small) reroll.
 cf. <owlysf2l2bnj.fsf@fine.c.googlers.com>
 source: <pull.1632.git.1704869487.gitgitgadget@gmail.com>


* ps/tests-with-ref-files-backend (2024-01-24) 6 commits
 - t: mark tests regarding git-pack-refs(1) to be backend specific
 - t5526: break test submodule differently
 - t1419: mark test suite as files-backend specific
 - t1302: make tests more robust with new extensions
 - t1301: mark test for `core.sharedRepository` as reffiles specific
 - t1300: make tests more robust with non-default ref backends

 Prepare existing tests on refs to work better with non-default
 backends.

 Needs review.
 source: <cover.1706085756.git.ps@pks.im>


* en/diffcore-delta-final-line-fix (2024-01-18) 1 commit
  (merged to 'next' on 2024-01-22 at 7141d202cb)
 + diffcore-delta: avoid ignoring final 'line' of file

 Rename detection logic ignored the final line of a file if it is an
 incomplete line.

 Will merge to 'master'.
 source: <pull.1637.v2.git.1705119973690.gitgitgadget@gmail.com>


* ps/reftable-optimize-io (2024-01-18) 7 commits
  (merged to 'next' on 2024-01-22 at b867e8b9a8)
 + reftable/stack: fix race in up-to-date check
 + reftable/stack: unconditionally reload stack after commit
  (merged to 'next' on 2024-01-12 at 4096e880e0)
 + reftable/blocksource: use mmap to read tables
 + reftable/blocksource: refactor code to match our coding style
 + reftable/stack: use stat info to avoid re-reading stack list
 + reftable/stack: refactor reloading to use file descriptor
 + reftable/stack: refactor stack reloading to have common exit path

 Low-level I/O optimization for reftable.

 Will merge to 'master'.
 source: <cover.1704966670.git.ps@pks.im>
 source: <cover.1705585037.git.ps@pks.im>


* rj/advice-disable-how-to-disable (2024-01-16) 2 commits
  (merged to 'next' on 2024-01-23 at f456f4937d)
 + advice: allow disabling the automatic hint in advise_if_enabled()
 + Merge branch 'rj/advice-delete-branch-not-fully-merged' into rj/advice-disable-how-to-disable

 All conditional "advice" messages show how to turn them off, which
 becomes repetitive.  Add a configuration variable to omit the
 instruction.

 Will merge to 'master'.
 source: <6a842ef8-b390-4739-9eef-e867d55ed5ea@gmail.com>


* sd/negotiate-trace-fix (2024-01-03) 1 commit
  (merged to 'next' on 2024-01-24 at 6305853ab2)
 + push: region_leave trace for negotiate_using_fetch

 Tracing fix.

 Will merge to 'master'.
 source: <20240103224054.1940209-1-delmerico@google.com>


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

 Needs review.
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


* tb/path-filter-fix (2024-01-16) 17 commits
 - bloom: introduce `deinit_bloom_filters()`
 - commit-graph: reuse existing Bloom filters where possible
 - object.h: fix mis-aligned flag bits table
 - commit-graph: drop unnecessary `graph_read_bloom_data_context`
 - commit-graph.c: unconditionally load Bloom filters
 - bloom: prepare to discard incompatible Bloom filters
 - bloom: annotate filters with hash version
 - commit-graph: new Bloom filter version that fixes murmur3
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

 Will merge to 'next'.
 source: <cover.1705442923.git.me@ttaylorr.com>


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

 Will merge to 'master'.
 source: <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>
