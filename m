Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC22D1F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 21:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfHNV1e (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 17:27:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60174 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbfHNV1d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 17:27:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B5836A8EE;
        Wed, 14 Aug 2019 17:27:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=M
        em4EJqakduVR552Q8J/if0He24=; b=DcrIUAg5VYjK61FklnTyYAi527Q4PDYHV
        /yuyBt3wTnGT0n6PCMV88TaQiXhw/fQ0XG0fJtUzMrPOYg2E0fq3s10OCfdyV3yR
        VKSJSLMDm7g01QRDpWy8gPaQXVyoBp5TTvGGhb+/2kPOFTmsm8TL5GpAPkihO8H7
        Wbjt3oPCo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=DPi
        xXEkwZiWE0ioPMXrPDEtXEWBCLqrVmNMS3dXzzWHcky0j0YOn2nPc1dyKnztAuWu
        BVtfAQ90ZW5DXprZzJppaFRPAaKL7L6AnbTKvBt01ervCqHpuxDAClCTsjQXG5vh
        6fJIh/Q1tC8EfKEDZ6AxAmbNekWcgI9w2r1TEZV4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5486F6A8ED;
        Wed, 14 Aug 2019 17:27:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5EB2C6A8EC;
        Wed, 14 Aug 2019 17:27:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2019, #04; Wed, 14)
X-master-at: ff66981f4593aec0f3b3eeace0eacb7dbe44fd8c
X-next-at: e5444969c986fc1503282c63d33931021c78d991
Date:   Wed, 14 Aug 2019 14:27:16 -0700
Message-ID: <xmqq36i35tfv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B1F8914-BEDA-11E9-9A49-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

We have a handful of topics in 'next', but as far as I can tell,
there is not anything that is so urgent and needs to go in the
upcoming release.  Hence the upcoming 2.23 release would hopefully
be pretty much the same as the tip of the 'master' as of today.

Unless we find something else that is glaringly wrong there in the
next few days, that is.  But in such a case it is likely we'd need
to delay the release to deal with the issue.  Let's hope there isn't
such a serious regression.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/hash-independent-tests-part-4 (2019-08-08) 2 commits
  (merged to 'next' on 2019-08-08 at fd54f4fafc)
 + t0000: reword comments for "local" test
 + t: decrease nesting in test_oid_to_path

 Test fix.


* ds/commit-graph-incremental (2019-08-07) 1 commit
  (merged to 'next' on 2019-08-07 at 9094f5b305)
 + commit-graph: release strbufs after use

 Leakfix.


* ds/commit-graph-octopus-fix (2019-08-05) 1 commit
  (merged to 'next' on 2019-08-07 at 9f8eaf7c4e)
 + commit-graph: fix bug around octopus merges

 commit-graph did not handle commits with more than two parents
 correctly, which has been corrected.


* en/disable-dir-rename-in-recursive-merge (2019-08-06) 1 commit
  (merged to 'next' on 2019-08-07 at f1efcbfd99)
 + merge-recursive: avoid directory rename detection in recursive case

 "merge-recursive" hit a BUG() when building a virtual merge base
 detected a directory rename.


* ja/l10n-fixes (2019-08-06) 1 commit
  (merged to 'next' on 2019-08-07 at 24aa435a4b)
 + l10n: reformat some localized strings for v2.23.0

 A few messages have been updated to help localization better.


* mr/doc-can-not-to-cannot (2019-08-05) 1 commit
  (merged to 'next' on 2019-08-07 at 128135f4e4)
 + doc: typo: s/can not/cannot/ and s/is does/does/

 Docfix.


* mt/dir-iterator-updates (2019-08-07) 2 commits
  (merged to 'next' on 2019-08-07 at 68e9a16b4a)
 + test-dir-iterator: use path argument directly
 + dir-iterator: release strbuf after use

 Leakfix.


* nd/switch-and-restore (2019-08-05) 1 commit
  (merged to 'next' on 2019-08-07 at 6a047a8092)
 + restore: fix typo in docs

 Docfix.


* rs/plug-strbuf-reak-in-read-alt-refs (2019-08-07) 1 commit
  (merged to 'next' on 2019-08-07 at bd704faa3e)
 + sha1-file: release strbuf after use

 Leakfix.

--------------------------------------------------
[New Topics]

* py/git-gui-do-quit (2019-08-07) 2 commits
 - Merge branch 'py/call-do-quit-before-exit' of github.com:gitster/git-gui into py/git-gui-do-quit
 - git-gui: call do_quit before destroying the main window

 "git gui" learned to call the clean-up procedure before exiting.

 Will merge to 'next'.


* rs/nedalloc-fixlets (2019-08-07) 2 commits
  (merged to 'next' on 2019-08-09 at 0e9286fb70)
 + nedmalloc: avoid compiler warning about unused value
 + nedmalloc: do assignments only after the declaration section

 Compilation fix.

 Will cook in 'next'.


* jk/perf-no-dups (2019-08-12) 1 commit
  (merged to 'next' on 2019-08-14 at 3010a7d19f)
 + t/perf: rename duplicate-numbered test script

 Test & perf scripts must use unique numeric prefix, but a pair
 shared the same number, which is fixed here.

 Will cook in 'next'.


* en/fast-import-merge-doc (2019-08-12) 1 commit
  (merged to 'next' on 2019-08-14 at 65efc63345)
 + git-fast-import.txt: clarify that multiple merge commits are allowed

 Doc update.

 Will cook in 'next'.


* bc/reread-attributes-during-rebase (2019-08-13) 3 commits
 - SQUASH???
 - apply: reload .gitattributes after patching it
 - path: add a function to check for path suffix

 The "git am" based backend of "git rebase" ignored the result of
 updating ".gitattributes" done in one step when replaying
 subsequent steps.

 Will squash the tip commit in and then merge to 'next'.


* jk/drop-release-pack-memory (2019-08-13) 1 commit
 - packfile: drop release_pack_memory()

 xmalloc() used to have a mechanism to ditch memory and address
 space resources as the last resort upon seeing an allocation
 failure from the underlying malloc(), which made the code complex
 and thread-unsafe with dubious benefit, as major memory resource
 users already do limit their uses with various other mechanisms.
 It has been simplified away.

 Will merge to 'next'.


* sg/complete-configuration-variables (2019-08-13) 11 commits
 - completion: complete config variables and values for 'git clone --config='
 - completion: complete config variables names and values for 'git clone -c'
 - completion: complete values of configuration variables after 'git -c var='
 - completion: complete configuration sections and variable names for 'git -c'
 - completion: split _git_config()
 - completion: simplify inner 'case' pattern in __gitcomp()
 - completion: use 'sort -u' to deduplicate config variable names
 - completion: deduplicate configuration sections
 - completion: add tests for 'git config' completion
 - completion: complete more values of more 'color.*' configuration variables
 - completion: fix a typo in a comment

 Command line completion updates for "git -c var.name=val"

 Will merge to 'next'.


* sg/worktree-remove-errormsg (2019-08-13) 1 commit
  (merged to 'next' on 2019-08-14 at e5444969c9)
 + worktree remove: clarify error message on dirty worktree

 Error message update/clarification.

 Will cook in 'next'.


* mt/threaded-grep-in-object-store (2019-08-13) 4 commits
 - grep: re-enable threads in some non-worktree cases
 - grep: disable grep_read_mutex when possible
 - grep: allow locks to be enabled individually
 - object-store: add lock to read_object_file_extended()


* pd/fetch-jobs (2019-08-13) 5 commits
 . fetch: make --jobs control submodules and remotes
 . fetch: add the --submodule-fetch-jobs option
 . fetch: add the fetch.jobs config key
 . fetch: add the "--fetch-jobs" option
 . fetch: rename max_children to max_children_for_submodules

 "git fetch --jobs" is getting taught to also run fetch jobs in
 parallel when fetching from multiple remote repositories.


* cb/fetch-set-upstream (2019-08-14) 1 commit
 - pull, fetch: add --set-upstream option

 "git fetch" learned "--set-upstream" option to help those who first
 clone from their private fork they intend to push to, add the true
 upstream via "git remote add" and then "git fetch" from it.

--------------------------------------------------
[Stalled]

* js/trace2-json-schema (2019-07-25) 3 commits
 . ci: run trace2 schema validation in the CI suite
 . trace2: add a schema validator for trace2 events
 . trace2: add a JSON schema for trace2 events

 The JSON output produced by "trace2" subsystem now has JSON schema
 defined on it, to allow us validate the output and catch deviation.

 The CI integration may be a bit too heavy-handed.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* jc/format-patch-delay-message-id (2019-04-05) 1 commit
 - format-patch: move message-id and related headers to the end

 The location "git format-patch --thread" adds the Message-Id:
 header in the series of header fields has been moved down, which
 may help working around a suspected bug in GMail MSA, reported at
 <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>

 Waiting for feedback to see if it truly helps.
 Needs tests.


* jt/fetch-cdn-offload (2019-03-12) 9 commits
 - SQUASH???
 - upload-pack: send part of packfile response as uri
 - fetch-pack: support more than one pack lockfile
 - upload-pack: refactor reading of pack-objects out
 - Documentation: add Packfile URIs design doc
 - Documentation: order protocol v2 sections
 - http-fetch: support fetching packfiles by URL
 - http: improve documentation of http_pack_request
 - http: use --stdin when getting dumb HTTP pack

 WIP for allowing a response to "git fetch" to instruct the bulk of
 the pack contents to be instead taken from elsewhere (aka CDN).


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.

 Expecting a reroll.
 cf. <CANq=j3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.com>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* dl/remote-save-to-push (2018-12-11) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 Anybody who wants to champion this topic?
 I am personally not yet quite convinced if this is worth pursuing.

--------------------------------------------------
[Cooking]

* sg/commit-graph-validate (2019-08-05) 3 commits
  (merged to 'next' on 2019-08-09 at 87f61abb73)
 + commit-graph: error out on invalid commit oids in 'write --stdin-commits'
 + commit-graph: turn a group of write-related macro flags into an enum
 + t5318-commit-graph: use 'test_expect_code'

 The code to write commit-graph over given commit object names has
 been made a bit more robust.

 Will cook in 'next'.


* sg/show-failed-test-names (2019-08-05) 2 commits
  (merged to 'next' on 2019-08-09 at c49ece8a0d)
 + tests: show the test name and number at the start of verbose output
 + t0000-basic: use realistic test script names in the verbose tests

 The first line of verbose output from each test piece now carries
 the test name and number to help scanning with eyeballs.

 Will cook in 'next'.


* js/pre-merge-commit-hook (2019-08-07) 4 commits
 - merge: --no-verify to bypass pre-merge-commit hook
 - git-merge: honor pre-merge-commit hook
 - merge: do no-verify like commit
 - t7503: verify proper hook execution

 A new "pre-merge-commit" hook has been introduced.

 Will merge to 'next'.


* jk/eoo (2019-08-06) 3 commits
 - gitcli: document --end-of-options
 - parse-options: allow --end-of-options as a synonym for "--"
 - revision: allow --end-of-options to end option parsing

 The command line parser learned "--end-of-options" notation; the
 standard convention for scripters to have hardcoded set of options
 first on the command line, and force the command to treat end-user
 input as non-options, has been to use "--" as the delimiter, but
 that would not work for commands that use "--" as a delimiter
 between revs and pathspec.

 Will merge to 'next'.


* jk/repo-init-cleanup (2019-08-06) 3 commits
 - config: stop checking whether the_repository is NULL
 - common-main: delay trace2 initialization
 - t1309: use short branch name in includeIf.onbranch test

 Further clean-up of the initialization code.


* cb/pcre2-chartables-leakfix (2019-08-06) 3 commits
 - grep: avoid leak of chartables in PCRE2
 - grep: make PCRE2 aware of custom allocator
 - grep: make PCRE1 aware of custom allocator

 WIP.


* jh/trace2-pretty-output (2019-08-09) 7 commits
 - trace2: cleanup whitespace in perf format
 - trace2: cleanup whitespace in normal format
 - quote: add sq_append_quote_argv_pretty()
 - trace2: trim trailing whitespace in normal format error message
 - trace2: remove dead code in maybe_add_string_va()
 - trace2: trim whitespace in region messages in perf target format
 - trace2: cleanup column alignment in perf target format

 Output from trace2 subsystem is formatted more prettily now.

 Will merge to 'next'.


* sc/pack-refs-deletion-racefix (2019-08-02) 1 commit
  (merged to 'next' on 2019-08-09 at 6bd6c85fbb)
 + pack-refs: always refresh after taking the lock file

 "git pack-refs" can lose refs that are created while running, which
 is getting corrected.

 Will cook in 'next'.


* vn/restore-empty-ita-corner-case-fix (2019-08-02) 2 commits
  (merged to 'next' on 2019-08-09 at ad2d7630d1)
 + restore: add test for deleted ita files
 + checkout.c: unstage empty deleted ita files

 "git checkout" and "git restore" to re-populate the index from a
 tree-ish (typically HEAD) did not work correctly for a path that
 was removed and then added again with the intent-to-add bit, when
 the corresponding working tree file was empty.  This has been
 corrected.

 Will cook in 'next'.


* ds/feature-macros (2019-08-13) 6 commits
 - repo-settings: create feature.experimental setting
 - repo-settings: create feature.manyFiles setting
 - repo-settings: parse core.untrackedCache
 - commit-graph: turn on commit-graph by default
 - t6501: use 'git gc' in quiet mode
 - repo-settings: consolidate some config settings

 A mechanism to affect the default setting for a (related) group of
 configuration variables is introduced.

 Will merge to 'next'.


* mt/grep-submodules-working-tree (2019-07-30) 1 commit
  (merged to 'next' on 2019-08-02 at e1a46a195f)
 + grep: fix worktree case in submodules

 "git grep --recurse-submodules" that looks at the working tree
 files looked at the contents in the index in submodules, instead of
 files in the working tree.

 Will cook in 'next'.


* jk/tree-walk-overflow (2019-08-01) 6 commits
  (merged to 'next' on 2019-08-02 at 116467c77a)
 + tree-walk: harden make_traverse_path() length computations
 + tree-walk: add a strbuf wrapper for make_traverse_path()
 + tree-walk: accept a raw length for traverse_path_len()
 + tree-walk: use size_t consistently
 + tree-walk: drop oid from traverse_info
 + setup_traverse_info(): stop copying oid

 Codepaths to walk tree objects have been audited for integer
 overflows and hardened.

 Will cook in 'next'.


* sg/t5510-test-i18ngrep-fix (2019-07-31) 1 commit
  (merged to 'next' on 2019-08-02 at 678564fda2)
 + t5510-fetch: fix negated 'test_i18ngrep' invocation
 (this branch is used by sg/do-not-skip-non-httpd-tests.)

 Test fix.

 Will cook in 'next'.


* sg/do-not-skip-non-httpd-tests (2019-08-02) 3 commits
  (merged to 'next' on 2019-08-02 at e700df0693)
 + t: warn against adding non-httpd-specific tests after sourcing 'lib-httpd'
 + t5703: run all non-httpd-specific tests before sourcing 'lib-httpd.sh'
 + t5510-fetch: run non-httpd-specific test before sourcing 'lib-httpd.sh'
 (this branch uses sg/t5510-test-i18ngrep-fix.)

 Test fix.

 Will cook in 'next'.


* vn/reset-deleted-ita (2019-07-26) 1 commit
 - reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.

 Expecting a reroll.


* ra/rebase-i-more-options (2019-08-13) 6 commits
 - rebase: add --author-date-is-committer-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_rename
 - rebase -i: support --committer-date-is-author-date
 - sequencer: add NULL checks under read_author_script
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learned a few options that are known by "git
 rebase" proper.

 Almost there.


* js/rebase-r-strategy (2019-07-31) 16 commits
 - rebase -r: do not (re-)generate root commits with `--root` *and* `--onto`
 - t3418: test `rebase -r` with merge strategies
 - t/lib-rebase: prepare for testing `git rebase --rebase-merges`
 - rebase -r: support merge strategies other than `recursive`
 - t3427: fix another incorrect assumption
 - t3427: accommodate for the `rebase --merge` backend having been replaced
 - t3427: fix erroneous assumption
 - t3427: condense the unnecessarily repetitive test cases into three
 - t3427: move the `filter-branch` invocation into the `setup` case
 - t3427: simplify the `setup` test case significantly
 - t3427: add a clarifying comment
 - rebase: fold git-rebase--common into the -p backend
 - sequencer: the `am` and `rebase--interactive` scripts are gone
 - .gitignore: there is no longer a built-in `git-rebase--interactive`
 - t3400: stop referring to the scripted rebase
 - Drop unused git-rebase--am.sh

 "git rebase --rebase-merges" learned to drive different merge
 strategies and pass strategy specific options to them.

 Will merge to 'next'.


* js/builtin-add-i (2019-07-18) 11 commits
 - built-in add -i: implement the `help` command
 - built-in add -i: use color in the main loop
 - built-in add -i: support `?` (prompt help)
 - built-in add -i: show unique prefixes of the commands
 - Add a function to determine unique prefixes for a list of strings
 - built-in add -i: implement the main loop
 - built-in add -i: color the header in the `status` command
 - built-in add -i: refresh the index before running `status`
 - built-in add -i: implement the `status` command
 - diff: export diffstat interface
 - Start to implement a built-in version of `git add --interactive`

 The beginning of rewriting "git add -i" in C.

 Expecting a response and possibly a reroll.
 cf. <xmqqwofyozka.fsf@gitster-ct.c.googlers.com>
 cf. <xmqqsgqmoyz1.fsf@gitster-ct.c.googlers.com>


* es/walken-tutorial (2019-08-07) 1 commit
 - documentation: add tutorial for revision walking

 A tutorial on object enumeration.


* ab/no-kwset (2019-07-01) 10 commits
  (merged to 'next' on 2019-07-15 at ed0479ce3d)
 + grep: use PCRE v2 for optimized fixed-string search
 + grep: remove the kwset optimization
 + grep: drop support for \0 in --fixed-strings <pattern>
 + grep: make the behavior for NUL-byte in patterns sane
 + grep tests: move binary pattern tests into their own file
 + grep tests: move "grep binary" alongside the rest
 + grep: inline the return value of a function call used only once
 + t4210: skip more command-line encoding tests on MinGW
 + grep: don't use PCRE2?_UTF8 with "log --encoding=<non-utf8>"
 + log tests: test regex backends in "--encode=<enc>" tests
 (this branch is used by ab/pcre-jit-fixes.)

 Retire use of kwset library, which is an optimization for looking
 for fixed strings, with use of pcre2 JIT.

 Kicked out of 'next' to give the topic a chance to get rebooted.


* ab/pcre-jit-fixes (2019-07-26) 7 commits
 - grep: do not enter PCRE2_UTF mode on fixed matching
 - grep: stess test PCRE v2 on invalid UTF-8 data
 - grep: create a "is_fixed" member in "grep_pat"
 - grep: consistently use "p->fixed" in compile_regexp()
 - grep: stop using a custom JIT stack with PCRE v1
 - grep: stop "using" a custom JIT stack with PCRE v2
 - grep: remove overly paranoid BUG(...) code
 (this branch uses ab/no-kwset.)

 A few simplification and bugfixes to PCRE interface.


* md/list-objects-filter-combo (2019-06-28) 10 commits
 - list-objects-filter-options: make parser void
 - list-objects-filter-options: clean up use of ALLOC_GROW
 - list-objects-filter-options: allow mult. --filter
 - strbuf: give URL-encoding API a char predicate fn
 - list-objects-filter-options: make filter_spec a string_list
 - list-objects-filter-options: move error check up
 - list-objects-filter: implement composite filters
 - list-objects-filter-options: always supply *errbuf
 - list-objects-filter: put omits set in filter struct
 - list-objects-filter: encapsulate filter components

 The list-objects-filter API (used to create a sparse/lazy clone)
 learned to take a combined filter specification.

 Will merge to 'next'.


* cc/multi-promisor (2019-06-25) 15 commits
 - Move core_partial_clone_filter_default to promisor-remote.c
 - Move repository_format_partial_clone to promisor-remote.c
 - Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
 - remote: add promisor and partial clone config to the doc
 - partial-clone: add multiple remotes in the doc
 - t0410: test fetching from many promisor remotes
 - builtin/fetch: remove unique promisor remote limitation
 - promisor-remote: parse remote.*.partialclonefilter
 - Use promisor_remote_get_direct() and has_promisor_remote()
 - promisor-remote: use repository_format_partial_clone
 - promisor-remote: add promisor_remote_reinit()
 - promisor-remote: implement promisor_remote_get_direct()
 - Add initial support for many promisor remotes
 - fetch-object: make functions return an error code
 - t0410: remove pipes after git commands

 Teach the lazy clone machinery that there can be more than one
 promisor remote and consult them in order when downloading missing
 objects on demand.

 Will merge to 'next'.


* jc/format-patch-noclobber (2019-02-22) 1 commit
 - format-patch: --no-clobber refrains from overwriting output files

 "git format-patch" used to overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Will discard.


* dl/rebase-i-keep-base (2019-04-25) 6 commits
 - rebase: teach rebase --keep-base
 - rebase: fast-forward --fork-point in more cases
 - rebase: fast-forward --onto in more cases
 - rebase: refactor can_fast_forward into goto tower
 - t3432: test rebase fast-forward behavior
 - t3431: add rebase --fork-point tests

 "git rebase --keep-base <upstream>" tries to find the original base
 of the topic being rebased and rebase on top of that same base,
 which is useful when running the "git rebase -i" (and its limited
 variant "git rebase -x").

 The command also has learned to fast-forward in more cases where it
 can instead of replaying to recreate identical commits.

 On hold.
 cf. <20190508001252.15752-1-avarab@gmail.com>
 cf. <20190719210156.GA9688@archbookpro.localdomain>
