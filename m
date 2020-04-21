Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A541C54FCB
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 01:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40A22084D
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 01:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vejmpk2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgDUB52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 21:57:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62854 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgDUB52 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 21:57:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2673D4215;
        Mon, 20 Apr 2020 21:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=i
        5a0zMG/F4AbZyv2Uj2WxdvhZm0=; b=vejmpk2arz8ZM/mYkh/WO/bPH7szIG4dR
        Sh7rr1HM4PBKzJhSH2eJq1B7fA9KPnthae3bLn3T+bTwy1K9kojUsgEcPT9ItvPI
        WmJ6Aci3EfkowwwWk+UA/x5WrX+QVwhwajmZOjsEdyjiIYNrf+p/DTTIUrcFP9cE
        NBwaXC/Nks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=oYo
        B67NGlSrSasqyurmLsWSaLKE39xnShh/o2hm6V1vH3KIaWKVYD/0yZnUDfn1D4Qw
        AMsiR9IOIn1WJRWTte6G85DfgXDaF19j23wvg3iInOdQULguFcMvlWNOf6vYReIr
        UNT1DcvT1B5Rrq1pUQPBW1mVzHP5sFkTErTtKFUo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA1F1D4214;
        Mon, 20 Apr 2020 21:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA5EFD420C;
        Mon, 20 Apr 2020 21:57:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Apr 2020, #02; Mon, 20)
X-master-at: 048abe1751e6727bfbacf7b80466d78e04631f94
X-next-at: 435bf60bd57ed99bd0d44f7afa315bac6c9e97ab
Date:   Mon, 20 Apr 2020 18:57:14 -0700
Message-ID: <xmqq8sipppmt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CE65E8E-8373-11EA-8B60-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Having to issue two security fixes on a pair of very similar issues
was embarrassing, but hopefully that's behind us.  Let's restart
merging things down.  I am hoping that we can merge all topics
marked to be merged to 'next' by early next week, so please make
loud noises if I mistakenly marked stuff that are not yet ready.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* eb/mboxrd-doc (2020-04-15) 1 commit
 - Documentation: explain "mboxrd" pretty format

 Doc update.

 Will merge to 'next'.


* mt/grep-cquote-path (2020-04-20) 1 commit
 - grep: follow conventions for printing paths w/ unusual chars

 "git grep" did not quote a path with unusual character like other
 commands (like "git diff", "git status") do, but did quote when run
 from a subdirectory, both of which has been corrected.

 Will merge to 'next'.


* tb/diff-tree-with-notes (2020-04-20) 1 commit
 - diff-tree.c: load notes machinery when required

 "git diff-tree --pretty --notes" used to hit an assertion failure,
 as it forgot to initialize the notes subsystem.

 Will merge to 'next'.


* tm/zsh-complete-switch-restore (2020-04-17) 1 commit
 - complete: zsh: add missing sub cmd completion candidates

 zsh command line completion (in contrib/) update.

 Will merge to 'next'.


* vd/range-diff-with-custom-pretty-format-fix (2020-04-15) 2 commits
 - range-diff: avoid negative string precision
 - range-diff: fix a crash in parsing git-log output

 "git range-diff" fixes.

 Will merge to 'next'.
 cf. <20200416010734.GE36156@syl.local>


* dl/test-must-fail-fixes-4 (2020-04-20) 8 commits
 - t9902: don't use `test_must_fail __git_*`
 - t9819: don't use test_must_fail with p4
 - t9164: use test_must_fail only on git commands
 - t9160: use test_path_is_missing()
 - t9141: use test_path_is_missing()
 - t7508: don't use `test_must_fail test_cmp`
 - t7408: replace incorrect uses of test_must_fail
 - t6030: use test_path_is_missing()

 Test clean-up.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* jk/use-quick-lookup-in-clone-for-tag-following (2020-04-01) 1 commit
  (merged to 'next' on 2020-04-15 at 11d6110e99)
 + clone: use "quick" lookup while following tags

 The logic to auto-follow tags by "git clone --single-branch" was
 not careful to avoid lazy-fetching unnecessary tags, which has been
 corrected.

 Will merge to 'master'.


* ds/commit-graph-expiry-fix (2020-04-01) 1 commit
  (merged to 'next' on 2020-04-20 at 4afb3de947)
 + commit-graph: fix buggy --expire-time option

 "git commit-graph write --expire-time=<timestamp>" did not use the
 given timestamp correctly, which has been corrected.

 Will merge to 'master'.


* ds/t5319-touch-fix (2020-04-01) 1 commit
  (merged to 'next' on 2020-04-20 at 41ccdb3fcd)
 + t5319: replace 'touch -m' with 'test-tool chmtime'

 Tests update to use "test-chmtime" instead of "touch -t".

 Will merge to 'master'.


* en/sequencer-reflog-action (2020-04-07) 1 commit
  (merged to 'next' on 2020-04-15 at 6c635bdaa1)
 + sequencer: honor GIT_REFLOG_ACTION

 "git rebase -i" did not leave the reflog entries correctly.

 Will merge to 'master'.


* dd/no-gpg-sign (2020-04-03) 6 commits
  (merged to 'next' on 2020-04-15 at 3a326e99af)
 + Documentation: document merge option --no-gpg-sign
 + Documentation: merge commit-tree --[no-]gpg-sign
 + Documentation: reword commit --no-gpg-sign
 + Documentation: document am --no-gpg-sign
 + cherry-pick/revert: honour --no-gpg-sign in all case
 + rebase.c: honour --no-gpg-sign

 "git rebase" learned the "--no-gpg-sign" option to countermand
 commit.gpgSign the user may have.

 Will merge to 'master'.


* en/rebase-doc-hooks-called-by-accident (2020-04-05) 1 commit
  (merged to 'next' on 2020-04-20 at 1011f8a876)
 + git-rebase.txt: add another hook to the hooks section, and explain more

 "git rebase" happens to call some hooks meant for "checkout" and
 "commit" by this was not a designed behaviour than historical
 accident.  This has been documented.

 Will merge to 'master'.


* jk/fast-import-use-hashmap (2020-04-06) 1 commit
  (merged to 'next' on 2020-04-20 at 76e8908efe)
 + fast-import: replace custom hash with hashmap.c

 The custom hash function used by "git fast-import" has been
 replaced with the one from hashmap.c, which gave us a nice
 performance boost.

 Will merge to 'master'.


* js/t0007-typofix (2020-04-05) 1 commit
  (merged to 'next' on 2020-04-15 at ac9f86e08f)
 + t0007: fix a typo

 Typofix in a test script.

 Will merge to 'master'.


* jt/avoid-prefetch-when-able-in-diff (2020-04-07) 4 commits
  (merged to 'next' on 2020-04-20 at 02b52c34bf)
 + diff: restrict when prefetching occurs
 + diff: refactor object read
 + diff: make diff_populate_filespec_options struct
 + promisor-remote: accept 0 as oid_nr in function

 "git diff" in a partial clone learned to avoid lazy loading blob
 objects in more casese when they are not needed.

 Will merge to 'master'.


* lx/submodule-clear-variables (2020-04-02) 1 commit
  (merged to 'next' on 2020-04-20 at c18cd924c9)
 + git-submodule.sh: setup uninitialized variables

 The "git submodule" command did not initialize a few variables it
 internally uses and was affected by variable settings leaked from
 the environment.

 Will merge to 'master'.


* pb/pull-fetch-doc (2020-04-05) 2 commits
  (merged to 'next' on 2020-04-15 at cf530f230f)
 + pull doc: correct outdated description of an example
 + pull doc: refer to a specific section in 'fetch' doc

 The more aggressive updates to remote-tracking branches we had for
 the past 7 years or so were not reflected in the documentation,
 which has been corrected.

 Will merge to 'master'.


* dd/ci-swap-azure-pipelines-with-github-actions (2020-04-10) 14 commits
  (merged to 'next' on 2020-04-20 at 40d0486c23)
 + ci: let GitHub Actions upload failed tests' directories
 + ci: add a problem matcher for GitHub Actions
 + tests: when run in Bash, annotate test failures with file name/line number
 + ci: retire the Azure Pipelines definition
 + README: add a build badge for the GitHub Actions runs
 + ci: configure GitHub Actions for CI/PR
 + ci: run gem with sudo to install asciidoctor
 + ci: explicit install all required packages
 + ci: fix the `jobname` of the `GETTEXT_POISON` job
 + ci/lib: set TERM environment variable if not exist
 + ci/lib: allow running in GitHub Actions
 + ci/lib: if CI type is unknown, show the environment variables
 + Merge branch 'dd/ci-musl-libc' into HEAD
 + Merge branch 'dd/test-with-busybox' into HEAD
 (this branch uses dd/ci-musl-libc and dd/test-with-busybox.)

 Update the CI configuration to use GitHub Actions, retiring the one
 based on Azure Pipelines.

 Will merge to 'master'.


* eb/format-patch-no-encode-headers (2020-04-07) 1 commit
  (merged to 'next' on 2020-04-15 at 368840cd6c)
 + format-patch: teach --no-encode-email-headers

 The output from "git format-patch" uses RFC 2047 encoding for
 non-ASCII letters on From: and Subject: headers, so that it can
 directly be fed to e-mail programs.  A new option has been added
 to produce these headers in raw.

 Will merge to 'master'.


* js/mingw-fixes (2020-04-10) 3 commits
  (merged to 'next' on 2020-04-15 at 11a3d39d2b)
 + mingw: help debugging by optionally executing bash with strace
 + mingw: do not treat `COM0` as a reserved file name
 + mingw: use modern strftime implementation if possible

 Misc fixes for Windows.

 Will merge to 'master'.


* js/stash-p-fix (2020-04-08) 2 commits
  (merged to 'next' on 2020-04-20 at 435bf60bd5)
 + stash -p: (partially) fix bug concerning split hunks
 + t3904: fix incorrect demonstration of a bug

 Allowing the user to split a patch hunk while "git stash -p" does
 not work well; a band-aid has been added to make this (partially)
 work better.

 Will merge to 'master'.


* js/subtree-doc-update-to-asciidoctor-2 (2020-04-08) 1 commit
  (merged to 'next' on 2020-04-20 at db1ed7a858)
 + subtree: fix build with AsciiDoctor 2

 Doc markup update.

 Will merge to 'master'.


* pw/rebase-i-more-options (2020-04-07) 7 commits
 - SQUASH??? - avoid test numbering crashes
 - t3433: improve coverage
 - Revert "sequencer: allow callers of read_author_script() to ignore fields"
 - rebase -i: fix --committer-date-is-author-date
 - t3433: only compare commit dates
 - t3433: remove loops from tests
 - Revert "Revert "Merge branch 'ra/rebase-i-more-options'""

 "git rebase -i" learns a bit more options.

 Expecting a reroll.
 cf. <43d06bc0-b2ee-0ae6-f22c-9850e4033d45@gmail.com>


* bc/constant-memequal (2020-04-09) 1 commit
  (merged to 'next' on 2020-04-20 at 31180dae7d)
 + builtin/receive-pack: use constant-time comparison for HMAC value

 Validation of push certificate has been made more robust against
 timing attacks.

 Will merge to 'master'.


* ds/revision-show-pulls (2020-04-10) 1 commit
  (merged to 'next' on 2020-04-15 at 89b4d86a3a)
 + revision: --show-pulls adds helpful merges

 "git log" learned "--show-pulls" that helps pathspec limited
 history views; a merge commit that takes the whole change from a
 side branch, which is normally omitted from the output, is shown
 in addition to the commits that introduce real changes.

 Will merge to 'master'.


* en/rebase-no-keep-empty (2020-04-11) 3 commits
  (merged to 'next' on 2020-04-15 at 9908cee7c0)
 + rebase: fix an incompatible-options error message
 + rebase: reinstate --no-keep-empty
 + rebase -i: mark commits that begin empty in todo editor
 (this branch is used by jt/rebase-allow-duplicate.)

 "git rebase" (again) learns to honor "--no-keep-empty", which lets
 the user to discard commits that are empty from the beginning (as
 opposed to the ones that become empty because of rebasing).  The
 interactive rebase also marks commits that are empty in the todo.

 Will merge to 'master'.


* jc/missing-ref-store-fix (2020-04-09) 2 commits
  (merged to 'next' on 2020-04-15 at 83caf48c7a)
 + repository: mark the "refs" pointer as private
 + sha1-name: do not assume that the ref store is initialized

 We've left the command line parsing of "git log :/a/b/" broken for
 about a full year without anybody noticing, which has been
 corrected.

 Will merge to 'master'.


* jk/config-use-size-t (2020-04-10) 6 commits
  (merged to 'next' on 2020-04-20 at 4af9fea74f)
 + config: reject parsing of files over INT_MAX
 + config: use size_t to store parsed variable baselen
 + git_config_parse_key(): return baselen as size_t
 + config: drop useless length variable in write_pair()
 + parse_config_key(): return subsection len as size_t
 + remote: drop auto-strlen behavior of make_branch() and make_rewrite()

 The config API made mixed uses of int and size_t types to represent
 length of various pieces of text it parsed, which has been updated
 to use the correct type (i.e. size_t) throughout.

 Will merge to 'master'.


* js/flush-prompt-before-interative-input (2020-04-10) 2 commits
  (merged to 'next' on 2020-04-15 at 051407eb3a)
 + interactive: explicitly `fflush` stdout before expecting input
 + interactive: refactor code asking the user for interactive input

 The interactive input from various codepaths are consolidated and
 any prompt possibly issued earlier are fflush()ed before we read.

 Will merge to 'master'.


* js/mingw-is-hidden-test-fix (2020-04-11) 3 commits
  (merged to 'next' on 2020-04-15 at 1e11f552f7)
 + t: restrict `is_hidden` to be called only on Windows
 + mingw: make test_path_is_hidden more robust
 + t: consolidate the `is_hidden` functions

 A Windows-specific test element has been made more robust against
 misuse from both user's environment and programmer's errors.

 Will merge to 'master'.


* js/mingw-isilon-nfs (2020-04-10) 1 commit
  (merged to 'next' on 2020-04-15 at 4bac536980)
 + mingw: cope with the Isilon network file system

 Will merge to 'master'.


* ma/config-doc-fix (2020-04-09) 1 commit
  (merged to 'next' on 2020-04-15 at 256175ec38)
 + config.txt: move closing "----" to cover entire listing

 Doc update.

 Will merge to 'master'.


* ma/simplify-merge-config-parsing (2020-04-11) 1 commit
  (merged to 'next' on 2020-04-15 at d2915301e4)
 + merge: use skip_prefix to parse config key

 Code simplification.

 Will merge to 'master'.


* ds/blame-on-bloom (2020-04-16) 3 commits
 - blame: use changed-path Bloom filters
 - tests: write commit-graph with Bloom filters
 - revision: complicated pathspecs disable filters
 (this branch uses gs/commit-graph-path-filter.)

 "git blame" learns to take advantage of the "changed-paths" Bloom
 filter stored in the commit-graph file.

 Will merge to 'next'.


* dd/iso-8601-updates (2020-04-15) 2 commits
 - date.c: allow compact version of ISO-8601 datetime
 - date.c: skip fractional second part of ISO-8601

 The approxidate parser learns to parse seconds with fraction.

 Expecting further work.
 cf. <20200417133647.GA26701@danh.dev>


* ds/log-exclude-decoration-config (2020-04-16) 2 commits
 - log: add log.excludeDecoration config option
 - log-tree: make ref_filter_match() a helper method

 The "--decorate-refs" and "--decorate-refs-exclude" options "git
 log" takes have learned a companion configuration variable
 log.excludeDecoration that sits at the lowest priority in the
 family.

 Will merge to 'next'.


* jk/credential-parsing-end-of-host-in-URL (2020-04-15) 1 commit
  (merged to 'next' on 2020-04-15 at 55bc3eb7cb)
 + credential: treat "?" and "#" in URLs as end of host

 Parsing of URL for the credential helper has been corrected.

 Will merge to 'master'.


* lr/freshen-file-fix (2020-04-15) 1 commit
  (merged to 'next' on 2020-04-20 at e9370b0a81)
 + freshen_file(): use NULL `times' for implicit current-time

 The code that refreshes the last access and modified time of
 on-disk packfiles and loose object files have been updated.

 Will merge to 'master'.


* tb/commit-graph-split-strategy (2020-04-15) 7 commits
 - commit-graph.c: introduce '--[no-]check-oids'
 - commit-graph.h: replace 'commit_hex' with 'commits'
 - oidset: introduce 'oidset_size'
 - builtin/commit-graph.c: introduce split strategy 'replace'
 - builtin/commit-graph.c: introduce split strategy 'no-merge'
 - builtin/commit-graph.c: support for '--split[=<strategy>]'
 - t/helper/test-read-graph.c: support commit-graph chains

 "git commit-graph write" learned different ways to write out split
 files.


* gs/commit-graph-path-filter (2020-04-09) 16 commits
 - bloom: ignore renames when computing changed paths
 - commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
 - t4216: add end to end tests for git log with Bloom filters
 - revision.c: add trace2 stats around Bloom filter usage
 - revision.c: use Bloom filters to speed up path based revision walks
 - commit-graph: add --changed-paths option to write subcommand
 - commit-graph: reuse existing Bloom filters during write
 - commit-graph: write Bloom filters to commit graph file
 - commit-graph: examine commits by generation number
 - commit-graph: examine changed-path objects in pack order
 - commit-graph: compute Bloom filters for changed paths
 - diff: halt tree-diff early after max_changes
 - bloom.c: core Bloom filter implementation for changed paths.
 - bloom.c: introduce core Bloom filter constructs
 - bloom.c: add the murmur3 hash implementation
 - commit-graph: define and use MAX_NUM_CHUNKS
 (this branch is used by ds/blame-on-bloom.)

 Introduce an extension to the commit-graph to make it efficient to
 check for the paths that were modified at each commit using Bloom
 filters.

 Will merge to 'next'.


* ag/rebase-merge-allow-ff-under-abbrev-command (2020-03-30) 2 commits
  (merged to 'next' on 2020-04-15 at b4679f7c7c)
 + t3432: test `--merge' with `rebase.abbreviateCommands = true', too
 + sequencer: don't abbreviate a command if it doesn't have a short form

 "git rebase" with the merge backend did not work well when the
 rebase.abbreviateCommands configuration was set.

 Will merge to 'master'.


* jk/oid-array-cleanups (2020-03-30) 7 commits
  (merged to 'next' on 2020-04-15 at d6155cd023)
 + oidset: stop referring to sha1-array
 + ref-filter: stop referring to "sha1 array"
 + bisect: stop referring to sha1_array
 + test-tool: rename sha1-array to oid-array
 + oid_array: rename source file from sha1-array
 + oid_array: use size_t for iteration
 + oid_array: use size_t for count and allocation

 Code cleanup.

 Will merge to 'master'.


* jx/proc-receive-hook (2020-04-15) 8 commits
 - SQUASH???
 - doc: add documentation for the proc-receive hook
 - receive-pack: new config receive.procReceiveRefs
 - refs.c: refactor to reuse ref_is_hidden()
 - send-pack: extension for client-side status report
 - receive-pack: add new proc-receive hook
 - connect: export parse_feature_value()
 - transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.


* dr/midx-avoid-int-underflow (2020-03-28) 1 commit
  (merged to 'next' on 2020-04-15 at eb2343a5eb)
 + midx.c: fix an integer underflow

 When fed a midx that records no objects, some codepaths tried to
 loop from 0 through (num_objects-1), which, due to integer
 arithmetic wrapping around, made it nonsense operation with out of
 bounds array accesses.  The code has been corrected to reject such
 an midx file.

 Will merge to 'master'.


* ak/run-command-on-cygwin-fix (2020-03-27) 1 commit
  (merged to 'next' on 2020-04-15 at 9e98b82a7f)
 + run-command: trigger PATH lookup properly on Cygwin

 Utitiles run via the run_command() API were not spawned correctly
 on Cygwin, when the paths to them are given as a full path with
 backslashes.

 Will merge to 'master'.


* dd/ci-musl-libc (2020-04-06) 6 commits
 + travis: build and test on Linux with musl libc and busybox
 + ci/linux32: libify install-dependencies step
 + ci: refactor docker runner script
 + ci/linux32: parameterise command to switch arch
 + ci/lib-docker: preserve required environment variables
 + ci: make MAKEFLAGS available inside the Docker container in the Linux32 job
 (this branch is used by dd/ci-swap-azure-pipelines-with-github-actions.)

 A new CI job to build and run test suite on linux with musl libc
 has been added.

 Will merge to 'master'.


* dr/doc-recurse-submodules (2020-04-06) 5 commits
  (merged to 'next' on 2020-04-20 at 601e10f9a1)
 + doc: --recurse-submodules mostly applies to active submodules
 + doc: be more precise on (fetch|push).recurseSubmodules
 + doc: explain how to deactivate submodule.recurse completely
 + doc: document --recurse-submodules for reset and restore
 + doc: list all commands affected by submodule.recurse

 Documentation updates around the "--recurse-submodules" option.

 Will merge to 'master'.


* dr/push-remoteref-fix (2020-04-06) 2 commits
  (merged to 'next' on 2020-04-15 at ecf60dc488)
 + remote.c: fix handling of %(push:remoteref)
 + remote.c: fix %(push) for triangular workflows

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Will merge to 'master'.


* jc/doc-test-leaving-early (2020-03-29) 1 commit
  (merged to 'next' on 2020-04-20 at 4bd94585d1)
 + t/README: suggest how to leave test early with failure

 Document the recommended way to abort a failing test early (e.g. by
 exiting a loop), which is to say "return 1".

 Will merge to 'master'.


* jk/build-with-right-curl (2020-04-05) 3 commits
 - Makefile: avoid running curl-config unnecessarily
 - Makefile: use curl-config --cflags
 - Makefile: avoid running curl-config multiple times

 The build procedure did not use the libcurl library and its include
 files correctly for a custom-built installation.

 On hold.
 cf. <20200404145829.GB679473@coredump.intra.peff.net>


* jk/harden-protocol-v2-delim-handling (2020-03-29) 3 commits
  (merged to 'next' on 2020-04-15 at c983535405)
 + test-lib-functions: simplify packetize() stdin code
 + upload-pack: handle unexpected delim packets
 + test-lib-functions: make packetize() more efficient

 The server-end of the v2 protocol to serve "git clone" and "git
 fetch" was not prepared to see a delim packets at unexpected
 places, which led to a crash.

 Will merge to 'master'.


* jk/p5310-drop-non-bitmap-timing (2020-03-27) 1 commit
  (merged to 'next' on 2020-04-15 at 7aac76cab2)
 + p5310: stop timing non-bitmap pack-to-disk

 Perf-test update.

 Will merge to 'master'.


* jk/test-cleanup (2020-03-27) 2 commits
  (merged to 'next' on 2020-04-15 at bce8b2d5ed)
 + t/lib-*.sh: drop executable bit
 + t/lib-credential.sh: drop shebang line

 Test cleanup.

 Will merge to 'master'.


* ps/transactional-update-ref-stdin (2020-04-02) 9 commits
 - update-ref: implement interactive transaction handling
 - update-ref: read commands in a line-wise fashion
 - update-ref: move transaction handling into `update_refs_stdin()`
 - update-ref: pass end pointer instead of strbuf
 - update-ref: drop unused argument for `parse_refname`
 - update-ref: organize commands in an array
 - strbuf: provide function to append whole lines
 - git-update-ref.txt: add missing word
 - refs: fix segfault when aborting empty transaction

 "git update-ref --stdin" learned a handful of new verbs to let the
 user control ref update transactions more explicitly, which helps
 as an ingredient to implement two-phase commit-style atomic
 ref-updates across multiple repositories.

 Will merge to 'next'.


* ag/sequencer-i18n-messages (2020-03-28) 1 commit
  (merged to 'next' on 2020-04-15 at d6b38d12cf)
 + sequencer: mark messages for translation

 Message fix.

 Will merge to 'master'.


* dl/wrapper-fix-indentation (2020-03-28) 1 commit
  (merged to 'next' on 2020-04-15 at e6b9c16b1b)
 + wrapper: indent with tabs

 Coding style fix.

 Will merge to 'master'.


* en/pull-do-not-rebase-after-fast-forwarding (2020-03-27) 1 commit
  (merged to 'next' on 2020-04-15 at 3aa725ff45)
 + pull: avoid running both merge and rebase

 "git pull --rebase" tried to run a rebase even after noticing that
 the pull results in a fast-forward and no rebase is needed nor
 sensible, for the past few years due to a mistake nobody noticed.

 Will merge to 'master'.


* jc/allow-strlen-substitution-in-shell-scripts (2020-03-29) 1 commit
  (merged to 'next' on 2020-04-15 at 262424efdc)
 + CodingGuidelines: allow ${#posix} == strlen($posix)

 Coding guideline update.

 Will merge to 'master'.


* jm/gitweb-fastcgi-utf8 (2020-03-29) 1 commit
  (merged to 'next' on 2020-04-15 at adb7f2373a)
 + gitweb: fix UTF-8 encoding when using CGI::Fast

 Gitweb update.

 Will merge to 'master'.


* js/walk-doc-optim (2020-03-30) 1 commit
  (merged to 'next' on 2020-04-15 at ca36c04a23)
 + MyFirstObjectWalk: remove unnecessary conditional statement

 Code cleanup.

 Will merge to 'master'.


* jx/atomic-push (2020-04-17) 5 commits
  (merged to 'next' on 2020-04-20 at 266d6934d8)
 + transport-helper: new method reject_atomic_push()
 + transport-helper: mark failure for atomic push
 + send-pack: mark failure of atomic push properly
 + t5543: never report what we do not push
 + send-pack: fix inconsistent porcelain output

 "git push --atomic" used to show failures for refs that weren't
 even pushed, which has been corrected.

 Will merge to 'master'.


* ma/doc-discard-docbook-xsl-1.73 (2020-03-31) 7 commits
  (merged to 'next' on 2020-04-20 at c280472e02)
 + user-manual.conf: don't specify [listingblock]
 + INSTALL: drop support for docbook-xsl before 1.74
 + manpage-normal.xsl: fold in manpage-base.xsl
 + manpage-bold-literal.xsl: stop using git.docbook.backslash
 + Doc: drop support for docbook-xsl before 1.73.0
 + Doc: drop support for docbook-xsl before 1.72.0
 + Doc: drop support for docbook-xsl before 1.71.1

 Raise the minimum required version of docbook-xsl package to 1.74,
 as 1.74.0 was from late 2008, which is more than 10 years old, and
 drop compatibility cruft from our documentation suite.

 Will merge to 'master'.


* pb/rebase-doc-typofix (2020-03-28) 1 commit
  (merged to 'next' on 2020-04-15 at 8cd8422990)
 + git-rebase.txt: fix typo

 Typofix.

 Will merge to 'master'.


* rs/pull-options-sync-code-and-doc (2020-03-28) 2 commits
  (merged to 'next' on 2020-04-15 at d743f43034)
 + pull: pass documented fetch options on
 + pull: remove --update-head-ok from documentation

 "git pull" shares many options with underlying "git fetch", but
 some of them were not documented and some of those that would make
 sense to pass down were not passed down.

 Will merge to 'master'.


* en/fill-directory-exponential (2020-04-01) 12 commits
 - completion: fix 'git add' on paths under an untracked directory
 - Fix error-prone fill_directory() API; make it only return matches
 - dir: replace double pathspec matching with single in treat_directory()
 - dir: include DIR_KEEP_UNTRACKED_CONTENTS handling in treat_directory()
 - dir: replace exponential algorithm with a linear one
 - dir: refactor treat_directory to clarify control flow
 - dir: fix confusion based on variable tense
 - dir: fix broken comment
 - dir: consolidate treat_path() and treat_one_path()
 - dir: fix simple typo in comment
 - t3000: add more testcases testing a variety of ls-files issues
 - t7063: more thorough status checking

 The directory traversal code had redundant recursive calls which
 made its performance characteristics exponential with respect to
 the depth of the tree, which was corrected.

 Will merge to 'next'.


* dd/test-with-busybox (2020-03-26) 8 commits
  (merged to 'next' on 2020-04-15 at 8177191066)
 + t5703: feed raw data into test-tool unpack-sideband
 + t4124: tweak test so that non-compliant diff(1) can also be used
 + t7063: drop non-POSIX argument "-ls" from find(1)
 + t5616: use rev-parse instead to get HEAD's object_id
 + t5003: skip conversion test if unzip -a is unavailable
 + t5003: drop the subshell in test_lazy_prereq
 + test-lib-functions: test_cmp: eval $GIT_TEST_CMP
 + t4061: use POSIX compliant regex(7)
 (this branch is used by dd/ci-swap-azure-pipelines-with-github-actions.)

 Various tests have been updated to work around issues found with
 shell utilities that come with busybox etc.

 Will merge to 'master'.


* dl/libify-a-few (2020-03-24) 2 commits
  (merged to 'next' on 2020-04-20 at 84eb704a32)
 + Lib-ify prune-packed
 + Lib-ify fmt-merge-msg

 Code in builtin/*, i.e. those can only be called from within
 built-in subcommands, that implements bulk of a couple of
 subcommands have been moved to libgit.a so that they could be used
 by others.

 Will merge to 'master'.


* dl/test-must-fail-fixes-3 (2020-03-27) 8 commits
  (merged to 'next' on 2020-04-15 at dd0130c158)
 + t5801: teach compare_refs() to accept !
 + t5612: stop losing return codes of git commands
 + t5612: don't use `test_must_fail test_cmp`
 + t5607: reorder `nongit test_must_fail`
 + t5550: simplify no matching line check
 + t5512: stop losing return codes of git commands
 + t5512: stop losing git exit code in here-docs
 + t5512: don't use `test_must_fail test_cmp`

 Test clean-up continues.

 Will merge to 'master'.


* en/sparse-checkout (2020-03-27) 18 commits
  (merged to 'next' on 2020-04-15 at 3e295e445d)
 + sparse-checkout: provide a new reapply subcommand
 + unpack-trees: failure to set SKIP_WORKTREE bits always just a warning
 + unpack-trees: provide warnings on sparse updates for unmerged paths too
 + unpack-trees: make sparse path messages sound like warnings
 + unpack-trees: split display_error_msgs() into two
 + unpack-trees: rename ERROR_* fields meant for warnings to WARNING_*
 + unpack-trees: move ERROR_WOULD_LOSE_SUBMODULE earlier
 + sparse-checkout: use improved unpack_trees porcelain messages
 + sparse-checkout: use new update_sparsity() function
 + unpack-trees: add a new update_sparsity() function
 + unpack-trees: pull sparse-checkout pattern reading into a new function
 + unpack-trees: do not mark a dirty path with SKIP_WORKTREE
 + unpack-trees: allow check_updates() to work on a different index
 + t1091: make some tests a little more defensive against failures
 + unpack-trees: simplify pattern_list freeing
 + unpack-trees: simplify verify_absent_sparse()
 + unpack-trees: remove unused error type
 + unpack-trees: fix minor typo in comment

 "sparse-checkout" UI improvements.

 Will merge to 'master'.


* js/import-tars-do-not-make-phony-files-from-pax-headers (2020-03-24) 1 commit
  (merged to 'next' on 2020-04-15 at 408afae2c9)
 + import-tars: ignore the global PAX header

 The import-tars importer (in contrib/fast-import/) used to create
 phony files at the top-level of the repository when the archive
 contains global PAX headers, which made its own logic to detect and
 omit the common leading directory ineffective, which has been
 corrected.

 Will merge to 'master'.


* js/test-junit-finalization-fix (2020-03-23) 1 commit
  (merged to 'next' on 2020-04-15 at 0d6a975146)
 + tests(junit-xml): avoid invalid XML

 Test fix.

 Will merge to 'master'.


* js/tests-gpg-integration-on-windows (2020-03-26) 5 commits
  (merged to 'next' on 2020-04-15 at 48a13eb0b2)
 + tests: increase the verbosity of the GPG-related prereqs
 + tests: turn GPG, GPGSM and RFC1991 into lazy prereqs
 + tests: do not let lazy prereqs inside `test_expect_*` turn off tracing
 + t/lib-gpg.sh: stop pretending to be a stand-alone script
 + tests(gpg): allow the gpg-agent to start on Windows

 Enable tests that require GnuPG on Windows.

 Will merge to 'master'.


* dl/merge-autostash (2020-04-10) 22 commits
 - pull: pass --autostash to merge
 - t5520: make test_pull_autostash() accept expect_parent_num
 - merge: teach --autostash option
 - sequencer: implement apply_autostash_oid()
 - sequencer: implement save_autostash()
 - sequencer: unlink autostash in apply_autostash()
 - sequencer: extract perform_autostash() from rebase
 - rebase: generify create_autostash()
 - rebase: extract create_autostash()
 - reset: extract reset_head() from rebase
 - rebase: generify reset_head()
 - rebase: use apply_autostash() from sequencer.c
 - sequencer: rename stash_sha1 to stash_oid
 - sequencer: make apply_autostash() accept a path
 - rebase: use read_oneliner()
 - sequencer: make read_oneliner() extern
 - sequencer: configurably warn on non-existent files
 - sequencer: make read_oneliner() accept flags
 - sequencer: make file exists check more efficient
 - sequencer: stop leaking buf
 - t7600: use test_write_lines()
 - Makefile: ASCII-sort += lists

 "git merge" learns the "--autostash" option.

 Will merge to 'next'.


* js/trace2-env-vars (2020-03-23) 1 commit
  (merged to 'next' on 2020-04-15 at 1aad0adfa0)
 + trace2: teach Git to log environment variables

 Trace2 enhancement to allow logging of the environment variables.

 Will merge to 'master'.


* ar/test-style-fixes (2020-03-22) 2 commits
  (merged to 'next' on 2020-04-15 at 50ed75bccf)
 + t: fix whitespace around &&
 + t9500: remove spaces after redirect operators

 Style fixes.

 Will merge to 'master'.


* ds/doc-clone-filter (2020-03-22) 1 commit
  (merged to 'next' on 2020-04-15 at 16276689b3)
 + clone: document --filter options

 Doc update.

 Will merge to 'master'.


* jk/t3419-drop-expensive-tests (2020-03-22) 1 commit
  (merged to 'next' on 2020-04-15 at a17ac8f996)
 + t3419: drop EXPENSIVE tests

 Test update.

 Will merge to 'master'.


* jt/connectivity-check-optim-in-partial-clone (2020-03-29) 1 commit
  (merged to 'next' on 2020-04-15 at 1b3692b7fb)
 + connected: always use partial clone optimization

 Simplify the commit ancestry connectedness check in a partial clone
 repository in which "promised" objects are assumed to be obtainable
 lazily on-demand from promisor remote repositories.

 Will merge to 'master'.


* mt/test-lib-bundled-short-options (2020-03-25) 1 commit
  (merged to 'next' on 2020-04-15 at 7fa0c56d91)
 + test-lib: allow short options to be bundled

 Minor test usability improvement.

 Will merge to 'master'.


* bk/p4-pre-edit-changelist (2020-02-14) 7 commits
  (merged to 'next' on 2020-04-15 at 3e7cecd445)
 + git-p4: add RCS keyword status message
 + git-p4: add p4 submit hooks
 + git-p4: restructure code in submit
 + git-p4: add --no-verify option
 + git-p4: add p4-pre-submit exit text
 + git-p4: create new function run_git_hook
 + git-p4: rewrite prompt to be Windows compatible

 "git p4" learned four new hooks and also "--no-verify" option to
 bypass them (and the existing "p4-pre-submit" hook).

 Will merge to 'master'.


* jt/rebase-allow-duplicate (2020-04-11) 1 commit
  (merged to 'next' on 2020-04-15 at 56a9d83adf)
 + rebase --merge: optionally skip upstreamed commits
 (this branch uses en/rebase-no-keep-empty.)

 Allow "git rebase" to reapply all local commits, even if the may be
 already in the upstream, without checking first.

 Will merge to 'master'.


* bc/faq (2020-03-30) 1 commit
  (merged to 'next' on 2020-04-15 at 2d4c46ca7a)
 + docs: add a FAQ

 Doc update.

 Will merge to 'master'.


* jc/log-no-mailmap (2020-03-16) 3 commits
  (merged to 'next' on 2020-04-20 at b43968e73e)
 + log: give --[no-]use-mailmap a more sensible synonym --[no-]mailmap
 + clone: reorder --recursive/--recurse-submodules
 + parse-options: teach "git cmd -h" to show alias as alias

 "git log" learns "--[no-]mailmap" as a synonym to "--[no-]use-mailmap"

 Will merge to 'master'.


* hn/reftable (2020-04-20) 10 commits
 - Reftable support for git-core
 - Add reftable library
 - reftable: clarify how empty tables should be written
 - reftable: define version 2 of the spec to accomodate SHA256
 - reftable: file format documentation
 - Add .gitattributes for the reftable/ directory
 - refs: document how ref_iterator_advance_fn should handle symrefs
 - create .git/refs in files-backend.c
 - Iterate over the "refs/" namespace in for_each_[raw]ref
 - refs.h: clarify reflog iteration order

 A new refs backend "reftable" to replace the traditional
 combination of packed-refs files and one-file-per-ref loose refs
 has been implemented and integrated for improved performance and
 atomicity.

 At v9
 cf. <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>


* es/bugreport (2020-04-16) 5 commits
 - bugreport: add compiler info
 - bugreport: add uname info
 - bugreport: gather git version and build info
 - bugreport: add tool to generate debugging info
 - help: move list_config_help to builtin/help

 The "bugreport" tool.

 Will merge to 'next'.

--------------------------------------------------
[Discarded]

* jc/rebase-backend-keep-old-default (2020-03-10) 1 commit
 . rebase: do not switch the default to 'merge' just yet

 The "merge" backend of "git rebase" still has a few bugs and
 unexpected behaviour that need to be ironed out before it becomes
 the default.  Let's switch the default back to the "apply" backend
 for now.


* vn/reset-deleted-ita (2019-07-26) 1 commit
 . reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.


* tb/commit-graph-split-merge (2020-03-24) 3 commits
  (merged to 'next' on 2020-03-31 at 2183baf09c)
 + builtin/commit-graph.c: support '--input=graphed'
 + builtin/commit-graph.c: introduce '--input=<source>'
 + builtin/commit-graph.c: support '--split[=<strategy>]'

 The code to write out the commit-graph has been taught a few
 options to control if the resulting graph chains should be merged
 or a single new incremental graph is created.

 Discarded---tb/commit-graph-split-strategy supersedes this.
