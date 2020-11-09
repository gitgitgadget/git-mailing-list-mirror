Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB46FC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 23:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E5B206BE
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 23:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GnkYYZ35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgKIXnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 18:43:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53156 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKIXnI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 18:43:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 118FF107F36;
        Mon,  9 Nov 2020 18:42:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=r
        j3UMYgLDT4d8g3zVt83X5T1qwY=; b=GnkYYZ35dADrEtsK1LiCN0J07LICP3s1t
        DymeuSAhoMm90fLp0402qgH5+L8eQu+22FJSyV3v27N04XK+4M+aF56I2/JkGMau
        WT8ex1nzao15Tuar89Wu6DTNcifoXrPZoS+n1sTo4dnodM+q+KpN73gZbWaNNEY0
        WcjpNVizCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=eTl
        P9QQN8D4U+kz+5zvSK9XsW9idJRbaflFtBCwGpVWdtnrhzVen+ZTlpvLC9S+9OWO
        ZAhsYh7qkt9BznFXXJVEawZZASRiSk2MPpjnVClXMZa5TWMgSw7kcIXj/UXTNICn
        5gkXNt6y/6d+TA0lkN5JKctN7YLve/a4w86YhZEE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09AC1107F34;
        Mon,  9 Nov 2020 18:42:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 33C43107F33;
        Mon,  9 Nov 2020 18:42:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2020, #02; Mon, 9)
X-master-at: e4d83eee9239207622e2b1cc43967da5051c189c
X-next-at: ecc2c50aac43ae8229607396347f6663b03b4deb
Date:   Mon, 09 Nov 2020 15:42:54 -0800
Message-ID: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AC57AA8-22E5-11EB-AE4C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The third and fourth batches of topics in this cycle are in 'master'
now, including some microprojects by candidates for the Outreachy
program.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into.  Some repositories have
only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/

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

* ab/git-remote-exit-code (2020-10-27) 1 commit
  (merged to 'next' on 2020-10-30 at 1fc119404b)
 + remote: add meaningful exit code on missing/existing

 Exit codes from "git remote add" etc. were not usable by scripted
 callers.


* as/tests-cleanup (2020-10-18) 1 commit
  (merged to 'next' on 2020-10-28 at fd199beb31)
 + t2200,t9832: avoid using 'git' upstream in a pipe

 Micro clean-up of a couple of test scripts.


* en/dir-rename-tests (2020-10-16) 4 commits
  (merged to 'next' on 2020-10-28 at 7bbe123e70)
 + t6423: more involved rules for renaming directories into each other
 + t6423: update directory rename detection tests with new rule
 + t6423: more involved directory rename test
 + directory-rename-detection.txt: update references to regression tests
 (this branch is used by en/merge-tests.)

 More preliminary tests have been added to document desired outcome
 of various "directory rename" situations.


* fc/zsh-completion (2020-10-28) 29 commits
  (merged to 'next' on 2020-11-02 at 2c5e3a73ad)
 + zsh: update copyright notices
 + completion: bash: remove old compat wrappers
 + completion: bash: cleanup cygwin check
 + completion: bash: trivial cleanup
 + completion: zsh: add simple version check
 + completion: zsh: trivial simplification
 + completion: zsh: add alias descriptions
 + completion: zsh: improve command tags
 + completion: zsh: refactor command completion
 + completion: zsh: shuffle functions around
 + completion: zsh: simplify file_direct
 + completion: zsh: simplify nl_append
 + completion: zsh: trivial cleanup
 + completion: zsh: simplify direct compadd
 + completion: zsh: simplify compadd functions
 + completion: zsh: fix splitting of words
 + completion: zsh: add missing direct_append
 + completion: fix conflict with bashcomp
 + completion: zsh: fix completion for --no-.. options
 + completion: bash: remove zsh wrapper
 + completion: bash: synchronize zsh wrapper
 + completion: zsh: fix for command aliasing
 + completion: prompt: fix color for Zsh
 + completion: zsh: update slave script locations
 + completion: zsh: fix for directories with spaces
 + completion: zsh: reorganize install instructions
 + completion: zsh: fix bash script extension
 + completion: zsh: fix name due to broken autoloading
 + completion: zsh: fix __gitcomp_direct()

 Zsh autocompletion (in contrib/) update.


* jk/checkout-index-errors (2020-10-27) 2 commits
  (merged to 'next' on 2020-10-30 at 77dddffe1b)
 + checkout-index: propagate errors to exit code
 + checkout-index: drop error message from empty --stage=all
 (this branch is used by mt/parallel-checkout-part-1.)

 "git checkout-index" did not consistently signal an error with its
 exit status.


* jk/committer-date-is-author-date-fix-simplify (2020-10-26) 1 commit
  (merged to 'next' on 2020-10-30 at 9ba3fad57d)
 + am, sequencer: stop parsing our own committer ident

 Code simplification.


* jk/perl-warning (2020-10-21) 1 commit
  (merged to 'next' on 2020-10-28 at 5fcb98f2ff)
 + perl: check for perl warnings while running tests

 Dev support.
 cf. <20201022032400.GC1480820@coredump.intra.peff.net>


* jk/sideband-more-error-checking (2020-10-29) 1 commit
  (merged to 'next' on 2020-10-30 at 8131784691)
 + sideband: diagnose more sideband anomalies

 The code to detect premature EOF in the sideband demultiplexer has
 been cleaned up.


* js/default-branch-name-adjust-t5411 (2020-10-31) 4 commits
  (merged to 'next' on 2020-11-02 at d625eda73c)
 + t5411: finish preparing for `main` being the default branch name
 + t5411: adjust the remaining support files for init.defaultBranch=main
 + t5411: start adjusting the support files for init.defaultBranch=main
 + t5411: start using the default branch name "main"

 Prepare a test script to transition of the default branch name to
 'main'.


* mr/bisect-in-c-3 (2020-10-16) 7 commits
  (merged to 'next' on 2020-10-28 at 435792b62f)
 + bisect--helper: retire `--bisect-autostart` subcommand
 + bisect--helper: retire `--write-terms` subcommand
 + bisect--helper: retire `--check-expected-revs` subcommand
 + bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
 + bisect--helper: retire `--next-all` subcommand
 + bisect--helper: retire `--bisect-clean-state` subcommand
 + bisect--helper: finish porting `bisect_start()` to C

 Rewriting "git bisect" in C continues.


* nk/diff-files-vs-fsmonitor (2020-10-20) 7 commits
  (merged to 'next' on 2020-10-28 at d3af804056)
 + p7519-fsmonitor: add a git add benchmark
 + p7519-fsmonitor: refactor to avoid code duplication
 + perf lint: add make test-lint to perf tests
 + t/perf: add fsmonitor perf test for git diff
 + t/perf/p7519-fsmonitor.sh: warm cache on first git status
 + t/perf/README: elaborate on output format
 + fsmonitor: use fsmonitor data in `git diff`
 (this branch is used by nk/perf-fsmonitor.)

 "git diff" and other commands that share the same machinery to
 compare with working tree files have been taught to take advantage
 of the fsmonitor data when available.


* pb/ref-filter-with-crlf (2020-10-29) 2 commits
  (merged to 'next' on 2020-10-30 at 8be77584c5)
 + log, show: add tests for messages containing CRLF
 + ref-filter: handle CRLF at end-of-line more gracefully

 A commit and tag object may have CR at the end of each and
 every line (you can create such an object with hash-object or
 using --cleanup=verbatim to decline the default clean-up
 action), but it would make it impossible to have a blank line
 to separate the title from the body of the message.  Be lenient
 and accept a line with lone CR on it as a blank line, too.

--------------------------------------------------
[New Topics]

* dd/upload-pack-stateless-eof (2020-10-30) 1 commit
  (merged to 'next' on 2020-11-09 at 01a1f1d4fd)
 + upload-pack: allow stateless client EOF just prior to haves

 "git fetch --depth=<n>" over the stateless RPC / smart HTTP
 transport handled EOF from the client poorly at the server end.

 Will merge to 'master'.


* js/trace2-session-id (2020-11-02) 11 commits
 - receive-pack: log received client trace2 SID
 - send-pack: advertise trace2 SID in capabilities
 - upload-pack, serve: log received client trace2 SID
 - fetch-pack: advertise trace2 SID in capabilities
 - transport: log received server trace2 SID
 - serve: advertise trace2 SID in v2 capabilities
 - receive-pack: advertise trace2 SID in v0 capabilities
 - upload-pack: advertise trace2 SID in v0 capabilities
 - trace2: add a public function for getting the SID
 - docs: new trace2.advertiseSID option
 - docs: new capability to advertise trace2 SIDs

 The transport layer was taught to optionally exchange the session
 ID assigned by the trace2 subsystem during fetch/push transactions.


* so/format-patch-doc-on-default-diff-format (2020-10-31) 1 commit
  (merged to 'next' on 2020-11-04 at 692e0b2f7a)
 + doc/diff-options: fix out of place mentions of '--patch/-p'

 Docfix.

 Will merge to 'master'.


* jc/sparse-error-for-developer-build (2020-10-31) 1 commit
 - Makefile: enable -Wsparse-error for DEVELOPER build

 "make DEVELOPER=1 sparse" used to run sparse and let it emit
 warnings; now such warnings will cause an error.

 Will merge to 'next'.


* pb/blame-funcname-range-userdiff (2020-11-01) 8 commits
 - blame: simplify 'setup_blame_bloom_data' interface
 - blame: simplify 'setup_scoreboard' interface
 - blame: enable funcname blaming with userdiff driver
 - line-log: mention both modes in 'blame' and 'log' short help
 - doc: add more pointers to gitattributes(5) for userdiff
 - blame-options.txt: also mention 'funcname' in '-L' description
 - doc: line-range: improve formatting
 - doc: log, gitk: move '-L' description to 'line-range-options.txt'

 "git blame -L :funcname -- path" did not work well for a path for
 which a userdiff driver is defined.

 Will merge to 'next'.


* rs/clear-commit-marks-in-repo (2020-10-31) 2 commits
  (merged to 'next' on 2020-11-04 at cb1e1d73cf)
 + bisect: clear flags in passed repository
 + object: allow clear_commit_marks_all to handle any repo

 Code clean-up.

 Will merge to 'master'.


* rs/pack-write-hashwrite-simplify (2020-11-01) 1 commit
  (merged to 'next' on 2020-11-04 at 7194d3e811)
 + pack-write: use hashwrite_be32() instead of double-buffering array

 Code clean-up.

 Will merge to 'master'.


* sd/prompt-local-variable (2020-11-01) 1 commit
  (merged to 'next' on 2020-11-04 at ddc4192867)
 + git-prompt.sh: localize `option` in __git_ps1_show_upstream

 Code clean-up.

 Will merge to 'master'.


* so/log-diff-merge (2020-11-09) 27 commits
 - doc/git-show: include --diff-merges description
 - doc/rev-list-options: document --first-parent implies --diff-merges=first-parent
 - doc/diff-generate-patch: mention new --diff-merges option
 - doc/git-log: describe new --diff-merges options
 - t4013: add test for --diff-merges=first-parent
 - diff-merges: implement new values for --diff-merges
 - diff-merges: make -m/-c/--cc explicitly mutually exclusive
 - diff-merges: refactor opt settings into separate functions
 - diff-merges: get rid of now empty diff_merges_init_revs()
 - diff-merges: group diff-merge flags next to each other inside 'rev_info'
 - diff-merges: split 'ignore_merges' field
 - diff-merges: fix -m to properly override -c/--cc
 - t4013: add tests for -m failing to override -c/--cc
 - t4013: support test_expect_failure through ':failure' magic
 - diff-merges: revise revs->diff flag handling
 - diff-merges: introduce revs->first_parent_merges flag
 - diff-merges: new function diff_merges_set_dense_combined_if_unset()
 - diff-merges: new function diff_merges_suppress()
 - diff-merges: re-arrange functions to match the order they are called in
 - diff-merges: rename diff_merges_default_to_enable() to match semantics
 - diff-merges: move checks for first_parent_only out of the module
 - diff-merges: rename all functions to have common prefix
 - revision: move diff merges functions to its own diff-merges.c
 - revision: provide implementation for diff merges tweaks
 - revision: factor out initialization of diff-merge related settings
 - revision: factor out setup of diff-merge related settings
 - revision: factor out parsing of diff-merge related options

 "git log" learned a new "--diff-merges=<how>" option.


* cw/ci-ghwf-check-ws-errors (2020-11-03) 1 commit
  (merged to 'next' on 2020-11-04 at dc1121823c)
 + ci: make the whitespace checker more robust

 Dev support update.

 Will merge to 'master'.


* ds/maintenance-part-4 (2020-11-04) 4 commits
 - maintenance: use Windows scheduled tasks
 - maintenance: use launchctl on macOS
 - maintenance: include 'cron' details in docs
 - maintenance: extract platform-specific scheduling
 (this branch uses ds/maintenance-part-3.)

 Follow-up on the "maintenance part-3" which introduced scheduled
 maintenance tasks to support platforms whose native scheduling
 methods are not 'cron'.


* en/merge-ort-impl (2020-11-06) 21 commits
 - merge-ort: free data structures in merge_finalize()
 - merge-ort: add implementation of record_unmerged_index_entries()
 - tree: enable cmp_cache_name_compare() to be used elsewhere
 - merge-ort: add implementation of checkout()
 - merge-ort: basic outline for merge_switch_to_result()
 - merge-ort: step 3 of tree writing -- handling subdirectories as we go
 - merge-ort: step 2 of tree writing -- function to create tree object
 - merge-ort: step 1 of tree writing -- record basenames, modes, and oids
 - merge-ort: have process_entries operate in a defined order
 - merge-ort: add a preliminary simple process_entries() implementation
 - merge-ort: avoid recursing into identical trees
 - merge-ort: record stage and auxiliary info for every path
 - merge-ort: compute a few more useful fields for collect_merge_info
 - merge-ort: avoid repeating fill_tree_descriptor() on the same tree
 - merge-ort: implement a very basic collect_merge_info()
 - merge-ort: add an err() function similar to one from merge-recursive
 - merge-ort: use histogram diff
 - merge-ort: port merge_start() from merge-recursive
 - merge-ort: add some high-level algorithm structure
 - merge-ort: setup basic internal data structures
 - Merge branch 'en/strmap' into en/merge-ort-impl
 (this branch uses en/merge-ort-api-null-impl and en/strmap.)


* js/default-branch-name-adjust-t5515 (2020-11-02) 4 commits
  (merged to 'next' on 2020-11-09 at 568ba5aba5)
 + t5515: use `main` as the name of the main branch for testing (conclusion)
 + t5515: use `main` as the name of the main branch for testing (part 3)
 + t5515: use `main` as the name of the main branch for testing (part 2)
 + t5515: use `main` as the name of the main branch for testing (part 1)

 Prepare a test script to transition of the default branch name to
 'main'.

 Will merge to 'master'.


* jt/push-with-base (2020-11-02) 5 commits
 . SQUASH???
 . Doc: push with --base
 . remote-curl: teach --base for http(s)://
 . push: teach --base for ssh:// and file://
 . connect: refactor building of Extra Parameters

 "git push" learns a way to tell an object that it expects the other
 side to have and is usable as a common ancestor, which can be used
 by the other side to shrink its initial ref advertisement.


* rs/worktree-list-show-locked (2020-11-03) 1 commit
  (merged to 'next' on 2020-11-04 at 5f4fa51a91)
 + t2402: fix typo

 Typofix.

 Will merge to 'master'.


* jc/abbrev-doc (2020-11-04) 1 commit
  (merged to 'next' on 2020-11-09 at 09efe81b8b)
 + doc: clarify that --abbrev=<n> is about the minimum length

 The documentation on the "--abbrev=<n>" option did not say the
 output may be longer than "<n>" hexdigits, which has been
 clarified.

 Will merge to 'master'.


* jc/line-log-takes-no-pathspec (2020-11-04) 1 commit
  (merged to 'next' on 2020-11-09 at 47c2c88b9d)
 + log: diagnose -L used with pathspec as an error

 "git log -L<range>:<path>" is documented to take no pathspec, but
 this was not enforced by the command line option parser, which has
 been corrected.

 Will merge to 'master'.


* jk/format-patch-output (2020-11-04) 3 commits
  (merged to 'next' on 2020-11-09 at 1f1bb6ebff)
 + format-patch: support --output option
 + format-patch: tie file-opening logic to output_directory
 + format-patch: refactor output selection

 "git format-patch --output=there" did not work as expected and
 instead crashed.  The option is now supported.

 Will merge to 'master'.


* rs/empty-reflog-check-fix (2020-11-01) 1 commit
  (merged to 'next' on 2020-11-09 at 3da6b6fef0)
 + stash: simplify reflog emptiness check

 The code to see if "git stash drop" can safely remove refs/stash
 has been made more carerful.

 Will merge to 'master'.


* mc/typofix (2020-11-05) 1 commit
  (merged to 'next' on 2020-11-09 at ed6106b6e3)
 + doc: fixing two trivial typos in Documentation/

 Docfix.

 Will merge to 'master'.


* jc/format-patch-name-max (2020-11-06) 1 commit
 - format-patch: make output filename configurable

 The maximum length of output filenames "git format-patch" creates
 has become configurable (used to be capped at 64).

 Will merge to 'next'?


* jk/diff-release-filespec-fix (2020-11-06) 1 commit
  (merged to 'next' on 2020-11-09 at 6d89b9602d)
 + diff: allow passing NULL to diff_free_filespec_data()

 Running "git diff" while allowing external diff in a state with
 unmerged paths used to segfault, which has been corrected.

 Will merge to 'master'.


* js/ci-github-set-env (2020-11-06) 1 commit
  (merged to 'next' on 2020-11-09 at c4ce007b4c)
 + ci: avoid using the deprecated `set-env` construct

 CI update.

 Will merge to 'master'.


* js/test-file-size (2020-11-06) 1 commit
  (merged to 'next' on 2020-11-09 at b3594d0150)
 + tests: consolidate the `file_size` function into `test-lib-functions.sh`

 Test clean-up.

 Will merge to 'master'.


* jx/t5411-flake-fix (2020-11-09) 1 commit
 . t5411: consistent result for proc-receive broken test

 A flakey test has been cleaned up.

 This merely is sweeping an underlying breakage under the rug.
 cf. <20201109231246.GA677345@coredump.intra.peff.net>


* dg/bswap-msvc (2020-11-09) 1 commit
  (merged to 'next' on 2020-11-09 at 91a67b86f7)
 + compat/bswap.h: simplify MSVC endianness detection

 Code simplification.

 Will merge to 'master'.


* js/p4-default-branch (2020-11-09) 1 commit
  (merged to 'next' on 2020-11-09 at a4b08b45da)
 + p4: respect init.defaultBranch

 "git p4" now honors init.defaultBranch configuration.

 Will merge to 'master'.


* js/test-whitespace-fixes (2020-11-09) 6 commits
  (merged to 'next' on 2020-11-09 at 383388929a)
 + t9603: use tabs for indentation
 + t5570: remove trailing padding
 + t5400,t5402: consistently indent with tabs, not with spaces
 + t3427: adjust stale comment
 + t3406: indent with tabs, not spaces
 + t1004: insert missing "branch" in a message

 Test code clean-up.

 Will merge to 'master'.


* rs/archive-high-compression (2020-11-09) 1 commit
 - archive: support compression levels beyond 9

 "git archive" now allows compression level higher than "-9"
 when generating tar.gz output.

 Will merge to 'next'?

--------------------------------------------------
[Stalled]

* es/config-hooks (2020-10-16) 8 commits
 - hook: replace find_hook() with hook_exists()
 - hook: add 'run' subcommand
 - parse-options: parse into strvec
 - hook: implement hookcmd.<name>.skip
 - hook: include hookdir hook in list
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.


* ag/merge-strategies-in-c (2020-10-06) 11 commits
 . sequencer: use the "octopus" merge strategy without forking
 . sequencer: use the "resolve" strategy without forking
 . merge: use the "octopus" strategy without forking
 . merge: use the "resolve" strategy without forking
 . merge-octopus: rewrite in C
 . merge-recursive: move better_branch_name() to merge.c
 . merge-resolve: rewrite in C
 . merge-index: don't fork if the requested program is `git-merge-one-file'
 . merge-index: libify merge_one_path() and merge_all()
 . merge-one-file: rewrite in C
 . t6027: modernise tests

 The resolve and octopus merge strategy backends have been rewritten
 in C.

 Expecting an update.
 cf.<693f417c-5612-7878-a055-2810f62af3b4@gmail.com>


* hn/reftable (2020-10-01) 13 commits
 . reftable: "test-tool dump-reftable" command.
 . reftable: rest of library
 . reftable: file level tests
 . reftable: read reftable files
 . reftable: write reftable files
 . reftable: a generic binary tree implementation
 . reftable: reading/writing blocks
 . reftable: (de)serialization for the polymorphic record type.
 . reftable: utility functions
 . reftable: add a barebones unittest framework
 . vcxproj: adjust for the reftable changes
 . reftable: define the public API
 . reftable: add LICENSE

 The reftable backend for the refs API.

 Expecting a reroll.
 Seems not to build for Windows folks.
 cf. <nycvar.QRO.7.76.6.2010021555290.50@tvgsbejvaqbjf.bet>
 cf. <nycvar.QRO.7.76.6.2010021557570.50@tvgsbejvaqbjf.bet>


* sm/curl-retry (2020-10-13) 3 commits
 - http: automatically retry some requests
 - replace CURLOPT_FILE With CURLOPT_WRITEDATA
 - remote-curl: add testing for intelligent retry for HTTP

 The http transport has been taught to retry a failed request that
 may reasonably be retried.

 Expecting a reroll.
 cf. <20201015000410.GB328643@google.com>
 cf. <CAM4o00eefXK2CJ_FxwwVPpBKL01JsJANf+SdjCtw_0NVV82L+Q@mail.gmail.com>


* sv/t7001-modernize (2020-09-25) 11 commits
 - t7001: move cleanup code from outside the tests into them
 - t7001: use `test` rather than `[`
 - t7001: use here-docs instead of echo
 - t7001: put each command on a separate line
 - t7001: use ': >' rather than 'touch'
 - t7001: change (cd <path> && git foo) to (git -C <path> foo)
 - t7001: remove whitespace after redirect operators
 - t7001: change the style for cd according to subshell
 - t7001: remove unnecessary blank lines
 - t7001: use TAB instead of spaces
 - t7001: convert tests from the old style to the current style

 Test script modernization.

 Expecting a reroll.
 cf. <20200925170256.11490-1-shubhunic@gmail.com>


* ew/decline-core-abbrev (2020-09-01) 1 commit
 - core.abbrev <off|false|no> disables abbreviations

 Allow the configuration to specify no abbreviation regardless of
 the hash algorithm.

 Expecting a reroll.  The intent is very good.


* bc/rev-parse-path-format (2020-10-09) 2 commits
 - rev-parse: add option for absolute or relative path formatting
 - abspath: add a function to resolve paths with missing components

 "git rev-parse" can be explicitly told to give output as absolute
 or relative path.


* ar/fetch-transfer-ipversion (2020-09-16) 1 commit
 - config: option transfer.ipversion to set transport protocol version for network fetches

 Adds transfer.ipversion configuration variable.

 Needs more work.


* vv/send-email-with-less-secure-apps-access (2020-08-29) 1 commit
 - Documentation/git-send-email.txt: Mention less secure app access might need to enable.

 Doc update.

 Expecting a reroll.
 cf. <xmqqwo1hi9nv.fsf@gitster.c.googlers.com>
 cf. <xmqqft85i72s.fsf@gitster.c.googlers.com>


* jc/war-on-dashed-git (2020-08-27) 1 commit
 - git: catch an attempt to run "git-foo"

 The first step to remove on-disk binaries for built-in subcommands
 by soliciting objections.

 On hold for now.


* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Discard for now.
 cf. <xmqqv9gu7c61.fsf@gitster.c.googlers.com>
 cf. <20200911214358.acl3hy2e763begoo@feanor>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Needs Review]

* ss/submodule-add-in-c (2020-10-07) 3 commits
 . t7400: add test to check 'submodule add' for tracked paths
 . submodule: port submodule subcommand 'add' from shell to C
 . dir: change the scope of function 'directory_exists_in_index()'

 "git submodule add" being rewritten in C.


* mt/parallel-checkout-part-1 (2020-11-04) 19 commits
 - ci: run test round with parallel-checkout enabled
 - parallel-checkout: add tests related to .gitattributes
 - parallel-checkout: add tests related to clone collisions
 - parallel-checkout: add tests for basic operations
 - checkout-index: add parallel checkout support
 - builtin/checkout.c: complete parallel checkout support
 - make_transient_cache_entry(): optionally alloc from mem_pool
 - parallel-checkout: support progress displaying
 - parallel-checkout: make it truly parallel
 - unpack-trees: add basic support for parallel checkout
 - entry: add checkout_entry_ca() which takes preloaded conv_attrs
 - entry: move conv_attrs lookup up to checkout_entry()
 - entry: extract cache_entry update from write_entry()
 - entry: make fstat_output() and read_blob_entry() public
 - entry: extract a header file for entry.c functions
 - convert: add conv_attrs classification
 - convert: add get_stream_filter_ca() variant
 - convert: add [async_]convert_to_working_tree_ca() variants
 - convert: make convert_attrs() and convert structs public

 Parallel checkout.


* mt/grep-sparse-checkout (2020-09-10) 9 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: correctly read worktree configs in submodules
 - config: make do_git_config_sequence receive a 'struct repository'
 - t/helper/test-config: unify exit labels
 - t/helper/test-config: diagnose missing arguments
 - t/helper/test-config: be consistent with exit codes
 - t1308-config-set: avoid false positives when using test-config
 - doc: grep: unify info on configuration variables

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.

--------------------------------------------------
[Cooking]

* av/fsmonitor-cleanup (2020-10-21) 2 commits
 - fsmonitor: make output of test-dump-fsmonitor more concise
 - fsmonitor: stop inline'ing mark_fsmonitor_valid / _invalid

 Code clean-up.

 Will discard.
 Unneeded?
 cf. <20201022183822.GA781760@nand.local>


* jc/sequencer-stopped-sha-simplify (2020-10-21) 1 commit
  (merged to 'next' on 2020-11-02 at ba3dd9eaf4)
 + sequencer: tolerate abbreviated stopped-sha file

 Recently the format of an internal state file "rebase -i" uses has
 been tightened up for consistency, which would hurt those who start
 "rebase -i" with old git and then continue with new git.  Loosen
 the reader side a bit (which we may want to tighten again in a year
 or so).

 Will merge to 'master'


* en/merge-ort-api-null-impl (2020-11-02) 4 commits
 - merge,rebase,revert: select ort or recursive by config or environment
 - fast-rebase: demonstrate merge-ort's API via new test-tool command
 - merge-ort-wrappers: new convience wrappers to mimic the old merge API
 - merge-ort: barebones API of new merge strategy with empty implementation
 (this branch is used by en/merge-ort-impl.)

 Preparation for a new merge strategy.

 Will merge to 'next'.


* en/merge-tests (2020-10-26) 9 commits
  (merged to 'next' on 2020-11-09 at 8ac9fe94a7)
 + t6423: add more details about direct resolution of directories
 + t6423: note improved ort handling with untracked files
 + t6423, t6436: note improved ort handling with dirty files
 + merge tests: expect slight differences in output for recursive vs. ort
 + t6423: expect improved conflict markers labels in the ort backend
 + t6404, t6423: expect improved rename/delete handling in ort backend
 + t6416: correct expectation for rename/rename(1to2) + directory/file
 + merge tests: expect improved directory/file conflict handling in ort
 + t/: new helper for tests that pass with ort but fail with recursive

 Preparation for a new merge strategy.

 Will merge to 'master'.


* sj/untracked-files-in-submodule-directory-is-not-dirty (2020-10-26) 1 commit
 - diff: do not show submodule with untracked files as "-dirty"

 "git diff" showed a submodule working tree with untracked cruft as
 "Submodule commit <objectname>-dirty", but a natural expectation is
 that the "-dirty" indicator would align with "git describe --dirty",
 which does not consider having untracked files in the working tree
 as source of dirtiness.  The inconsistency has been fixed.

 Needs doc update and also adjusting "git status".


* nk/perf-fsmonitor (2020-10-26) 10 commits
  (merged to 'next' on 2020-11-09 at 9fed160a17)
 + t/perf/fsmonitor: add benchmark for dirty status
 + t/perf/fsmonitor: perf comparison of multiple fsmonitor integrations
 + t/perf/fsmonitor: initialize test with git reset
 + t/perf/fsmonitor: factor setup for fsmonitor into function
 + t/perf/fsmonitor: silence initial git commit
 + t/perf/fsmonitor: shorten DESC to basename
 + t/perf/fsmonitor: factor description out for readability
 + t/perf/fsmonitor: improve error message if typoing hook name
 + t/perf/fsmonitor: move watchman setup to one-time-repo-setup
 + t/perf/fsmonitor: separate one time repo initialization

 Add t/perf support for fsmonitor.

 Will merge to 'master'.


* pw/rebase-i-orig-head (2020-11-04) 4 commits
 - rebase -i: simplify get_revision_ranges()
 - rebase -i: use struct object_id when writing state
 - rebase -i: use struct object_id rather than looking up commit
 - rebase -i: stop overwriting ORIG_HEAD buffer

 "git rebase -i" did not store ORIG_HEAD correctly.

 Will merge to 'next'.
 cf. <xmqq7drbbcj5.fsf@gitster.c.googlers.com>


* en/strmap (2020-11-06) 15 commits
 - shortlog: use strset from strmap.h
 - Use new HASHMAP_INIT macro to simplify hashmap initialization
 - strmap: take advantage of FLEXPTR_ALLOC_STR when relevant
 - strmap: enable allocations to come from a mem_pool
 - strmap: add a strset sub-type
 - strmap: split create_entry() out of strmap_put()
 - strmap: add functions facilitating use as a string->int map
 - strmap: enable faster clearing and reusing of strmaps
 - strmap: add more utility functions
 - strmap: new utility functions
 - hashmap: provide deallocation function names
 - hashmap: introduce a new hashmap_partial_clear()
 - hashmap: allow re-use after hashmap_free()
 - hashmap: adjust spacing to fix argument alignment
 - hashmap: add usage documentation explaining hashmap_free[_entries]()
 (this branch is used by en/merge-ort-impl.)

 A speciailization of hashmap that uses a string as key has been
 introduced.  Hopefully it will see wider use over time.

 Will merge to 'next'?


* jk/symlinked-dotgitx-files (2020-10-23) 9 commits
  (merged to 'next' on 2020-10-26 at c1dd37b024)
 + docs: document symlink restrictions for .git* files
 + fsck: complain when .gitattributes or .gitignore is a symlink
 + verify_path(): disallow symlinks in .gitattributes and .gitignore
 + t0060: test obscured .gitattributes and .gitignore matching
 + t7450: test .gitmodules symlink matching against obscured names
 + t7450: test verify_path() handling of gitmodules
 + t7415: rename to expand scope
 + fsck_tree(): wrap some long lines
 + fsck_tree(): fix shadowed variable

 Originally merged to 'next' on 2020-10-23

 "git fsck" and the corresponding check done during the transport
 learned to ensure that in-tree files like `.gitignore` and
 `.gitattributes` are not symbolic links.

 It seems that there are real projects with .gitignore recorded as
 symlinks, which may need to loosen the fsck setting.  Do we need
 to introduce a class that is separate from symlinked .gitmodules
 that probably is with potential consequences that is more grave?


* ak/corrected-commit-date (2020-10-08) 10 commits
 - doc: add corrected commit date info
 - commit-reach: use corrected commit dates in paint_down_to_common()
 - commit-graph: use generation v2 only if entire chain does
 - commit-graph: implement generation data chunk
 - commit-graph: implement corrected commit date
 - commit-graph: add a slab to store topological levels
 - commit-graph: return 64-bit generation number
 - commit-graph: consolidate fill_commit_graph_info
 - revision: parse parent in indegree_walk_step()
 - commit-graph: fix regression when computing Bloom filters

 The commit-graph learned to use corrected commit dates instead of
 the generation number to help topological revision traversal.

 Getting there.
 cf. <85y2jiqq3c.fsf@gmail.com>
 cf. <685afed6-f01f-5d22-80d4-00fdc11caf0a@gmail.com>
 cf. <20201103053629.GA13228@Abhishek-Arch>


* ds/maintenance-part-3 (2020-10-16) 8 commits
 - maintenance: add troubleshooting guide to docs
 - maintenance: use 'incremental' strategy by default
 - maintenance: create maintenance.strategy config
 - maintenance: add start/stop subcommands
 - maintenance: add [un]register subcommands
 - for-each-repo: run subcommands on configured repos
 - maintenance: add --schedule option and config
 - maintenance: optionally skip --auto process
 (this branch is used by ds/maintenance-part-4.)

 Parts of "git maintenance" to ease writing crontab entries (and
 other scheduling system configuration) for it.

 Will merge to 'next'?

--------------------------------------------------
[Discarded]

* jk/use-strset-in-shortlog (2020-11-05) 1 commit
 . shortlog: drop custom strset implementation

 Now a part of the en/strmap topic.
