Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B8BC2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D071020786
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oxaTBLgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgKBW1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:27:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57878 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgKBW1v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:27:51 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F37FE2B5F;
        Mon,  2 Nov 2020 17:27:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
        s7NFhGeQBVonqyXk6z6TXpMvBY=; b=oxaTBLgYXBocrzQOjaLPm3NG+hITDm8J5
        HQOBVEV5Vj1YaOF0SA1NL4/rST3Xx9FOfxQxqO++38wpnHc9SPRL+CbfFA+jyb06
        5nPbVTSeogWoR7v35DvuINjk+la570eIFXH0aVgaWsS84AtZwvkGzBgOOcXs7jNX
        +iWD8WDWmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=XK5
        7uerjjdQCwUf2e928Jlw8J/HQtBAIgdGLbpbZR4ai+G7nLtquJCII0gLTscFO4c7
        aK63zs4l8bsABmdRG5j98maC4B57n5nSD6xoGwGyj6bqR21yzwqPBCMjkPEJZ9q5
        Ub92YYumAx9BfsR1mieW1NaC0MEQ0Ik/ACnUVaRk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 776AFE2B5D;
        Mon,  2 Nov 2020 17:27:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 79E3AE2B5C;
        Mon,  2 Nov 2020 17:27:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2020, #01; Mon, 2)
X-master-at: 7f7ebe054af6d831b999d6c2241b9227c4e4e08d
X-next-at: 8a58376a318e85947bf4bf3a28f36953a18963f5
Date:   Mon, 02 Nov 2020 14:27:40 -0800
Message-ID: <xmqqh7q7s8bn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F7F20B6-1D5A-11EB-B246-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The third batch of topics in this cycle are in 'master' now,
including some microprojects by candidates for the Outreachy
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

* as/sample-push-to-checkout-hook (2020-10-16) 1 commit
  (merged to 'next' on 2020-10-26 at 644026c2f6)
 + hook: add sample template for push-to-checkout

 Add a sample 'push-to-checkout' hook, that performs the same as
 what the built-in default action does.


* bc/svn-hash-oid-fix (2020-10-21) 1 commit
  (merged to 'next' on 2020-10-26 at 743b549d5d)
 + svn: use correct variable name for short OID

 A recent oid->hash conversion missed one spot, breaking "git svn".


* bk/sob-dco (2020-10-20) 4 commits
  (merged to 'next' on 2020-10-26 at d0e5066a7e)
 + Documentation: stylistically normalize references to Signed-off-by:
 + SubmittingPatches: clarify DCO is our --signoff rule
 + Documentation: clarify and expand description of --signoff
 + doc: preparatory clean-up of description on the sign-off option

 Document that the meaning of a Signed-off-by trailer can vary from
 project to project in the end-user documentation, and clarify what
 it means to this project.


* cm/t7xxx-cleanup (2020-10-22) 6 commits
  (merged to 'next' on 2020-10-26 at 8b58e54942)
 + t7102: prepare expected output inside test_expect_* block
 + t7201: put each command on a separate line
 + t7201: use 'git -C' to avoid subshell
 + t7102,t7201: remove whitespace after redirect operator
 + t7102,t7201: remove unnecessary blank spaces in test body
 + t7101,t7102,t7201: modernize test formatting

 Originally merged to 'next' on 2020-10-23

 Micro clean-up.


* ct/t0000-use-test-path-is-file (2020-10-18) 1 commit
  (merged to 'next' on 2020-10-26 at 9b70aa748f)
 + t0000: use test_path_is_file instead of "test -f"

 Originally merged to 'next' on 2020-10-23

 Micro clean-up of a test script.


* dl/diff-merge-base (2020-09-21) 10 commits
  (merged to 'next' on 2020-10-26 at 114d94030b)
 + contrib/completion: complete `git diff --merge-base`
 + builtin/diff-tree: learn --merge-base
 + builtin/diff-index: learn --merge-base
 + t4068: add --merge-base tests
 + diff-lib: define diff_get_merge_base()
 + diff-lib: accept option flags in run_diff_index()
 + contrib/completion: extract common diff/difftool options
 + git-diff.txt: backtick quote command text
 + git-diff-index.txt: make --cached description a proper sentence
 + t4068: remove unnecessary >tmp

 "git diff A...B" learned "git diff --merge-base A B", which is a
 longer short-hand to say the same thing.


* dl/resurrect-update-for-sha256 (2020-10-08) 2 commits
  (merged to 'next' on 2020-10-26 at 7e94297aa4)
 + contrib/git-resurrect.sh: use hash-agnostic OID pattern
 + contrib/git-resurrect.sh: indent with tabs

 Originally merged to 'next' on 2020-10-23

 "git resurrect" script (in contrib/) learned that the object names
 may be longer than 40-hex depending on the hash function in use.


* ds/commit-graph-merging-fix (2020-10-09) 2 commits
  (merged to 'next' on 2020-10-26 at a0cf763826)
 + commit-graph: don't write commit-graph when disabled
 + commit-graph: ignore duplicates when merging layers

 When "git commit-graph" detects the same commit recorded more than
 once while it is merging the layers, it used to die.  The code now
 ignores all but one of them and continues.


* ds/maintenance-commit-graph-auto-fix (2020-10-12) 2 commits
  (merged to 'next' on 2020-10-26 at 429d1371d8)
 + maintenance: core.commitGraph=false prevents writes
 + maintenance: test commit-graph auto condition

 Test-coverage enhancement of running commit-graph task "git
 maintenance" as needed led to discovery and fix of a bug.


* en/sequencer-rollback-lock-cleanup (2020-10-21) 1 commit
  (merged to 'next' on 2020-10-26 at 1234e8297f)
 + sequencer: remove duplicate rollback_lock_file() call

 Code clean-up.


* en/t7518-unflake (2020-10-18) 1 commit
  (merged to 'next' on 2020-10-26 at 443459f7ca)
 + t7518: fix flaky grep invocation

 Originally merged to 'next' on 2020-10-23

 Work around flakiness in a test.


* en/test-selector (2020-10-18) 3 commits
  (merged to 'next' on 2020-10-26 at 3d6e77c3ff)
 + test-lib: reduce verbosity of skipped tests
 + t6006, t6012: adjust tests to use 'setup' instead of synonyms
 + test-lib: allow selecting tests by substring/glob with --run

 Our test scripts can be told to run only individual pieces while
 skipping others with the "--run=..." option; they were taught to
 take a substring of test title, in addition to numbers, to name the
 test pieces to run.


* es/test-cmp-typocatcher (2020-10-20) 1 commit
  (merged to 'next' on 2020-10-26 at 62d89db753)
 + Revert "test_cmp: diagnose incorrect arguments"

 A test helper "test_cmp A B" was taught to diagnose missing files A
 or B as a bug in test, but some tests legitimately wanted to notice
 a failure to even create file B as an error, in addition to leaving
 the expected result in it, and were misdiagnosed as a bug.  This
 has been corrected.


* es/tutorial-mention-asciidoc-early (2020-10-16) 1 commit
  (merged to 'next' on 2020-10-28 at 96e0d84d94)
 + MyFirstContribution: clarify asciidoc dependency

 Doc update.


* jc/doc-final-resend (2020-10-26) 1 commit
  (merged to 'next' on 2020-10-30 at 2dd2c8a0d9)
 + SubmittingPatches: clarify the purpose of the final resend

 Update developer doc.


* jk/fast-import-marks-alloc-fix (2020-10-15) 1 commit
  (merged to 'next' on 2020-10-26 at 2f0a73fd48)
 + fast-import: fix over-allocation of marks storage

 "git fast-import" wasted a lot of memory when many marks were in use.


* jk/fast-import-marks-cleanup (2020-10-16) 1 commit
  (merged to 'next' on 2020-10-26 at 1ba987dd54)
 + fast-import: remove duplicated option-parsing line

 Code clean-up.


* jk/no-common (2020-10-16) 1 commit
  (merged to 'next' on 2020-10-26 at c888cb8b28)
 + config.mak.dev: build with -fno-common

 Dev support to catch a tentative definition of a variable in our C
 code as an error.


* jk/report-fn-typedef (2020-10-16) 1 commit
  (merged to 'next' on 2020-10-26 at fa4e128b65)
 + usage: define a type for a reporting function

 Code clean-up.


* js/avoid-split-sideband-message (2020-10-27) 3 commits
  (merged to 'next' on 2020-10-27 at 06b2f75522)
 + test-pkt-line: drop colon from sideband identity
  (merged to 'next' on 2020-10-26 at 1b550f3245)
 + sideband: report unhandled incomplete sideband messages as bugs
 + sideband: avoid reporting incomplete sideband messages
 (this branch is used by jk/sideband-more-error-checking.)

 The side-band status report can be sent at the same time as the
 primary payload multiplexed, but the demultiplexer on the receiving
 end incorrectly split a single status report into two, which has
 been corrected.


* js/ci-ghwf-dedup-tests (2020-10-12) 2 commits
  (merged to 'next' on 2020-10-26 at 4832a8f40b)
 + ci: make the "skip-if-redundant" check more defensive
 + ci: work around old records of GitHub runs

 Originally merged to 'next' on 2020-10-23

 GitHub Actions automated test improvement to skip tests on a tree
 identical to what has already been tested.


* js/default-branch-name-part-4-minus-1 (2020-10-23) 9 commits
  (merged to 'next' on 2020-10-26 at 0a66b76c66)
 + t1400: prepare for `main` being default branch name
 + tests: prepare aligned mentions of the default branch name
 + t9902: prepare a test for the upcoming default branch name
 + t3200: prepare for `main` being shorter than `master`
 + t5703: adjust a test case for the upcoming default branch name
 + t6200: adjust suppression pattern to also match "main"
 + tests: start moving to a different default main branch name
 + t9801: use `--` in preparation for default branch rename
 + fmt-merge-msg: also suppress "into main" by default
 (this branch is used by js/default-branch-name-adjust-t5411.)

 Adjust tests so that they won't scream when the default initial
 branch name is changed to 'main'.


* js/t7006-cleanup (2020-10-21) 1 commit
  (merged to 'next' on 2020-10-26 at b8582f842d)
 + t7006: Use test_path_is_* functions in test script

 Code clean-up.


* jt/apply-reverse-twice (2020-10-20) 1 commit
  (merged to 'next' on 2020-10-26 at f060893eb7)
 + apply: when -R, also reverse list of sections

 "git apply -R" did not handle patches that touch the same path
 twice correctly, which has been corrected.  This is most relevant
 in a patch that changes a path from a regular file to a symbolic
 link (and vice versa).


* lo/zsh-completion (2020-10-16) 1 commit
  (merged to 'next' on 2020-10-26 at 100dc6adde)
 + completion: fix zsh installation instructions

 Update instructions for command line completion (in contrib/) for zsh.


* mk/diff-ignore-regex (2020-10-20) 2 commits
  (merged to 'next' on 2020-10-26 at c68727da93)
 + diff: add -I<regex> that ignores matching changes
 + merge-base, xdiff: zero out xpparam_t structures

 "git diff" family of commands learned the "-I<regex>" option to
 ignore hunks whose changed lines all match the given pattern.


* nk/dir-c-comment-update (2020-10-16) 1 commit
  (merged to 'next' on 2020-10-26 at 3a4cb82ad6)
 + dir.c: fix comments to agree with argument name

 Update stale in-code comment.


* sc/sequencer-gpg-octopus (2020-10-18) 3 commits
  (merged to 'next' on 2020-10-26 at e1c956e52a)
 + t3435: add tests for rebase -r GPG signing
 + sequencer: pass explicit --no-gpg-sign to merge
 + sequencer: fix gpg option passed to merge subcommand

 "git rebase --rebase-merges" did not correctly pass --gpg-sign
 command line option to underlying "git merge" when replaying a merge
 using non-default merge strategy or when replaying an octopus merge
 (because replaying a two-head merge with the default strategy was
 done in a separate codepath, the problem did not trigger for most
 users), which has been corrected.


* tk/credential-config (2020-10-16) 1 commit
  (merged to 'next' on 2020-10-26 at 6ab486f389)
 + credential: load default config

 "git credential' didn't honor the core.askPass configuration
 variable (among other things), which has been corrected.


* ve/userdiff-bash (2020-10-22) 1 commit
  (merged to 'next' on 2020-10-26 at 2b34be98fe)
 + userdiff: support Bash

 The userdiff pattern learned to identify the function definition in
 POSIX shells and bash.

--------------------------------------------------
[New Topics]

* dd/upload-pack-stateless-eof (2020-10-30) 1 commit
 - upload-pack: allow stateless client EOF just prior to haves


* js/trace2-session-id (2020-10-31) 11 commits
 - upload-pack.c: fix a sparse warning
 - receive-pack: log received client trace2 SID
 - send-pack: advertise trace2 SID in capabilities
 - upload-pack, serve: log received client trace2 SID
 - fetch-pack: advertise trace2 SID in capabilities
 - transport: log received server trace2 SID
 - serve: advertise trace2 SID in v2 capabilities
 - receive-pack: advertise trace2 SID in v0 capabilities
 - upload-pack: advertise trace2 SID in v0 capabilities
 - docs: new trace2.advertiseSID option
 - docs: new capability to advertise trace2 SIDs


* so/format-patch-doc-on-default-diff-format (2020-10-31) 1 commit
 - doc/diff-options: fix out of place mentions of '--patch/-p'


* jc/sparse-error-for-developer-build (2020-10-31) 1 commit
 - Makefile: enable -Wsparse-error for DEVELOPER build


* pb/blame-funcname-range-userdiff (2020-11-01) 8 commits
 - blame: simplify 'setup_blame_bloom_data' interface
 - blame: simplify 'setup_scoreboard' interface
 - blame: enable funcname blaming with userdiff driver
 - line-log: mention both modes in 'blame' and 'log' short help
 - doc: add more pointers to gitattributes(5) for userdiff
 - blame-options.txt: also mention 'funcname' in '-L' description
 - doc: line-range: improve formatting
 - doc: log, gitk: move '-L' description to 'line-range-options.txt'


* rs/clear-commit-marks-in-repo (2020-10-31) 2 commits
 - bisect: clear flags in passed repository
 - object: allow clear_commit_marks_all to handle any repo


* rs/empty-stash-check-fix (2020-11-01) 1 commit
 - stash: simplify reflog emptiness check


* rs/pack-write-hashwrite-simplify (2020-11-01) 1 commit
 - pack-write: use hashwrite_be32() instead of double-buffering array


* sd/prompt-local-variable (2020-11-01) 1 commit
 - git-prompt.sh: localize `option` in __git_ps1_show_upstream


* so/log-diff-merge (2020-11-01) 26 commits
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

--------------------------------------------------
[Stalled]

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

 cf. <20201015000410.GB328643@google.com>


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


* ss/submodule-add-in-c (2020-10-07) 3 commits
 . t7400: add test to check 'submodule add' for tracked paths
 . submodule: port submodule subcommand 'add' from shell to C
 . dir: change the scope of function 'directory_exists_in_index()'

 "git submodule add" being rewritten in C.

--------------------------------------------------
[Cooking]

* jk/sideband-more-error-checking (2020-10-29) 1 commit
  (merged to 'next' on 2020-10-30 at 8131784691)
 + sideband: diagnose more sideband anomalies

 The code to detect premature EOF in the sideband demultiplexer has
 been cleaned up.

 Will merge to 'master'.


* js/default-branch-name-adjust-t5411 (2020-10-31) 4 commits
  (merged to 'next' on 2020-11-02 at d625eda73c)
 + t5411: finish preparing for `main` being the default branch name
 + t5411: adjust the remaining support files for init.defaultBranch=main
 + t5411: start adjusting the support files for init.defaultBranch=main
 + t5411: start using the default branch name "main"

 Prepare a test script to transition of the default branch name to
 'main'.

 Will merge to 'master'.


* av/fsmonitor-cleanup (2020-10-21) 2 commits
 - fsmonitor: make output of test-dump-fsmonitor more concise
 - fsmonitor: stop inline'ing mark_fsmonitor_valid / _invalid

 Code clean-up.

 Unneeded?  Perhaps will drop.
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


* jk/perl-warning (2020-10-21) 1 commit
  (merged to 'next' on 2020-10-28 at 5fcb98f2ff)
 + perl: check for perl warnings while running tests

 Dev support.

 Will merge to 'master'.
 cf. <20201022032400.GC1480820@coredump.intra.peff.net>


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

 Will merge to 'master'.


* ab/git-remote-exit-code (2020-10-27) 1 commit
  (merged to 'next' on 2020-10-30 at 1fc119404b)
 + remote: add meaningful exit code on missing/existing

 Exit codes from "git remote add" etc. were not usable by scripted
 callers.

 Will merge to 'master'.


* en/merge-ort-api-null-impl (2020-10-29) 4 commits
 - merge,rebase,revert: select ort or recursive by config or environment
 - fast-rebase: demonstrate merge-ort's API via new test-tool command
 - merge-ort-wrappers: new convience wrappers to mimic the old merge API
 - merge-ort: barebones API of new merge strategy with empty implementation

 Preparation for a new merge strategy.

 Looking good.


* en/merge-tests (2020-10-26) 9 commits
 - t6423: add more details about direct resolution of directories
 - t6423: note improved ort handling with untracked files
 - t6423, t6436: note improved ort handling with dirty files
 - merge tests: expect slight differences in output for recursive vs. ort
 - t6423: expect improved conflict markers labels in the ort backend
 - t6404, t6423: expect improved rename/delete handling in ort backend
 - t6416: correct expectation for rename/rename(1to2) + directory/file
 - merge tests: expect improved directory/file conflict handling in ort
 - t/: new helper for tests that pass with ort but fail with recursive
 (this branch uses en/dir-rename-tests.)

 Preparation for a new merge strategy.


* jk/committer-date-is-author-date-fix-simplify (2020-10-26) 1 commit
  (merged to 'next' on 2020-10-30 at 9ba3fad57d)
 + am, sequencer: stop parsing our own committer ident

 Code simplification.

 Will merge to 'master'.


* sj/untracked-files-in-submodule-directory-is-not-dirty (2020-10-26) 1 commit
 - diff: do not show submodule with untracked files as "-dirty"

 "git diff" showed a submodule working tree with untracked cruft as
 "Submodule commit <objectname>-dirty", but a natural expectation is
 that the "-dirty" indicator would align with "git describe --dirty",
 which does not consider having untracked files in the working tree
 as source of dirtiness.  The inconsistency has been fixed.

 Needs doc update.


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

 Will merge to 'master'.


* nk/perf-fsmonitor (2020-10-26) 10 commits
 - t/perf/fsmonitor: add benchmark for dirty status
 - t/perf/fsmonitor: perf comparison of multiple fsmonitor integrations
 - t/perf/fsmonitor: initialize test with git reset
 - t/perf/fsmonitor: factor setup for fsmonitor into function
 - t/perf/fsmonitor: silence initial git commit
 - t/perf/fsmonitor: shorten DESC to basename
 - t/perf/fsmonitor: factor description out for readability
 - t/perf/fsmonitor: improve error message if typoing hook name
 - t/perf/fsmonitor: move watchman setup to one-time-repo-setup
 - t/perf/fsmonitor: separate one time repo initialization
 (this branch uses nk/diff-files-vs-fsmonitor.)

 Add t/perf support for fsmonitor.


* jk/checkout-index-errors (2020-10-27) 2 commits
  (merged to 'next' on 2020-10-30 at 77dddffe1b)
 + checkout-index: propagate errors to exit code
 + checkout-index: drop error message from empty --stage=all
 (this branch is used by mt/parallel-checkout-part-1.)

 "git checkout-index" did not consistently signal an error with its
 exit status.

 Will merge to 'master'.


* pw/rebase-i-orig-head (2020-10-27) 4 commits
 - rebase -i: simplify get_revision_ranges()
 - rebase -i: use struct object_id when writing state
 - rebase -i: use struct object_id rather than looking up commit
 - rebase -i: stop overwriting ORIG_HEAD buffer

 "git rebase -i" did not

 Expecting an update to the log message, but otherwise the change
 looked sensible.
 cf. <xmqq7drbbcj5.fsf@gitster.c.googlers.com>


* en/strmap (2020-11-02) 13 commits
 - Use new HASHMAP_INIT macro to simplify hashmap initialization
 - strmap: take advantage of FLEXPTR_ALLOC_STR when relevant
 - strmap: enable allocations to come from a mem_pool
 - strmap: add a strset sub-type
 - strmap: add functions facilitating use as a string->int map
 - strmap: enable faster clearing and reusing of strmaps
 - strmap: add more utility functions
 - strmap: new utility functions
 - hashmap: provide deallocation function names
 - hashmap: introduce a new hashmap_partial_clear()
 - hashmap: allow re-use after hashmap_free()
 - hashmap: adjust spacing to fix argument alignment
 - hashmap: add usage documentation explaining hashmap_free[_entries]()

 A speciailization of hashmap that uses a string as key has been
 introduced.  Hopefully it will see wider use over time.

 Rerolled.
 cf. <20201023080202.GA4012156@coredump.intra.peff.net>
 cf. <CABPp-BFV8ZAu5vLarG2mX8gT5bfV31oqbd-vjAQF_YDcyNSRiw@mail.gmail.com>


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

 Will merge to 'master'.


* as/tests-cleanup (2020-10-18) 1 commit
  (merged to 'next' on 2020-10-28 at fd199beb31)
 + t2200,t9832: avoid using 'git' upstream in a pipe

 Micro clean-up of a couple of test scripts.

 Will merge to 'master'.


* en/dir-rename-tests (2020-10-16) 4 commits
  (merged to 'next' on 2020-10-28 at 7bbe123e70)
 + t6423: more involved rules for renaming directories into each other
 + t6423: update directory rename detection tests with new rule
 + t6423: more involved directory rename test
 + directory-rename-detection.txt: update references to regression tests
 (this branch is used by en/merge-tests.)

 More preliminary tests have been added to document desired outcome
 of various "directory rename" situations.

 Will merge to 'master'.


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

 Will merge to 'master'.


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

 Almost there.
 cf. <685afed6-f01f-5d22-80d4-00fdc11caf0a@gmail.com>


* mt/parallel-checkout-part-1 (2020-10-29) 19 commits
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
 (this branch uses jk/checkout-index-errors.)

 Parallel checkout.


* ds/maintenance-part-3 (2020-10-16) 8 commits
 - maintenance: add troubleshooting guide to docs
 - maintenance: use 'incremental' strategy by default
 - maintenance: create maintenance.strategy config
 - maintenance: add start/stop subcommands
 - maintenance: add [un]register subcommands
 - for-each-repo: run subcommands on configured repos
 - maintenance: add --schedule option and config
 - maintenance: optionally skip --auto process

 Parts of "git maintenance" to ease writing crontab entries (and
 other scheduling system configuration) for it.


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
