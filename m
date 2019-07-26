Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAFE81F462
	for <e@80x24.org>; Fri, 26 Jul 2019 00:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfGZATn (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 20:19:43 -0400
Received: from pb-sasl-trial20.pobox.com ([173.228.157.50]:52176 "EHLO
        pb-sasl-trial20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfGZATn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 20:19:43 -0400
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id B3A9235D63;
        Thu, 25 Jul 2019 20:19:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=Y
        MKs+XnmeKuQ4G9NDfpzppWDvFI=; b=SqC9SP74BUF5LkWI4CEo2p6sfJfbc4inJ
        lgi2NJaxfVfrttCF2roR5Yf1fCKBeA6KhG3ho3cYJlUMCTIMXJjqj5PzQmGGeTJa
        BDY6rLX6rZY2XWHQUOOtWeVbYEgOIQAV63PRKvB0ZQuTyibFBw61u1olOeN0Terv
        RnAo76KuFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=cwi
        0PaUfRHnN06E1I05H6FTNuX1xka7ZVQir7f6S7N5jjh/OFxb4pR8/ZWeoUnQK56b
        LamzvGnBYUQfGfqCrWt1T3AYS8+6+HL3W+iQkp2WmXN8zbJ8g9qBn2YEdR8mRU//
        wysZBGmETYTvZjR23wGOwlONyDRvSpGHb925aovM=
Received: from pb-smtp21.sea.icgroup.com (pb-smtp21.pobox.com [10.110.30.21])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 969A835D62;
        Thu, 25 Jul 2019 20:19:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 89B0370166;
        Thu, 25 Jul 2019 20:19:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2019, #06; Thu, 25)
X-master-at: 3034dab9ed6b11970a53099a7b3ca981f1461365
X-next-at: 0f2c4a37fdba75d06ae7254c4b30ed7739985214
Date:   Thu, 25 Jul 2019 17:19:23 -0700
Message-ID: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0668BE7A-AF3B-11E9-9379-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The seventh batch is in; I've merged fix-up topics that has been in
'master' for some time (i.e. up to the third batch of this cycle)
down to 'maint'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/test-env (2019-07-11) 9 commits
  (merged to 'next' on 2019-07-15 at 42e86beb20)
 + env--helper: mark a file-local symbol as static
  (merged to 'next' on 2019-07-09 at 096658f382)
 + tests: make GIT_TEST_FAIL_PREREQS a boolean
 + tests: replace test_tristate with "git env--helper"
 + tests README: re-flow a previously changed paragraph
 + tests: make GIT_TEST_GETTEXT_POISON a boolean
 + t6040 test: stop using global "script" variable
 + config.c: refactor die_bad_number() to not call gettext() early
 + env--helper: new undocumented builtin wrapping git_env_*()
 + config tests: simplify include cycle test

 Many GIT_TEST_* environment variables control various aspects of
 how our tests are run, but a few followed "non-empty is true, empty
 or unset is false" while others followed the usual "there are a few
 ways to spell true, like yes, on, etc., and also ways to spell
 false, like no, off, etc." convention.


* ac/log-use-mailmap-by-default-transition (2019-07-15) 3 commits
  (merged to 'next' on 2019-07-19 at e5669de950)
 + tests: defang pager tests by explicitly disabling the log.mailmap warning
 + documentation: mention --no-use-mailmap and log.mailmap false setting
 + log: add warning for unspecified log.mailmap setting

 The "git log" command learns to issue a warning when log.mailmap
 configuration is not set and --[no-]mailmap option is not used, to
 prepare users for future versions of Git that uses the mailmap by
 default.


* di/readme-markup-fix (2019-07-18) 1 commit
  (merged to 'next' on 2019-07-19 at 339470d824)
 + README: fix rendering of text in angle brackets

 Docfix.


* es/local-atomic-push-failure-with-http (2019-07-16) 2 commits
  (merged to 'next' on 2019-07-19 at 8d5b776a96)
 + transport-helper: avoid var decl in for () loop control
  (merged to 'next' on 2019-07-15 at 960e92d24f)
 + transport-helper: enforce atomic in push_refs_with_push

 "git push --atomic" that goes over the transport-helper (namely,
 the smart http transport) failed to prevent refs to be pushed when
 it can locally tell that one of the ref update will fail without
 having to consult the other end, which has been corrected.


* jc/denoise-rm-to-resolve (2019-07-18) 1 commit
  (merged to 'next' on 2019-07-19 at 12f7e5d413)
 + rm: resolving by removal is not a warning-worthy event

 "git rm" to resolve a conflicted path leaked an internal message
 "needs merge" before actually removing the path, which was
 confusing.  This has been corrected.


* jc/post-c89-rules-doc (2019-07-18) 1 commit
  (merged to 'next' on 2019-07-19 at 8acd58e189)
 + CodingGuidelines: spell out post-C89 rules

 We have been trying out a few language features outside c89; the
 coding guidelines document did not talk about them and instead had
 a blanket ban against them.


* jk/test-commit-bulk (2019-07-23) 6 commits
  (merged to 'next' on 2019-07-23 at edc849c7dd)
 + t6200: use test_commit_bulk
 + t5703: use test_commit_bulk
 + t5702: use test_commit_bulk
 + t3311: use test_commit_bulk
 + t5310: increase the number of bitmapped commits
 + test-lib: introduce test_commit_bulk

 A test helper has been introduced to optimize preparation of test
 repositories with many simple commits, and a handful of test
 scripts have been updated to use it.


* js/clean-report-too-long-a-path (2019-07-19) 1 commit
  (merged to 'next' on 2019-07-19 at b7da0a821c)
 + clean: show an error message when the path is too long

 "git clean" silently skipped a path when it cannot lstat() it; now
 it gives a warning.


* js/mingw-spawn-with-spaces-in-path (2019-07-16) 1 commit
  (merged to 'next' on 2019-07-19 at 33dd6d0401)
 + mingw: support spawning programs containing spaces in their names

 Window 7 update ;-)


* js/unmap-before-ext-diff (2019-07-11) 1 commit
  (merged to 'next' on 2019-07-15 at 7aa292c66c)
 + diff: munmap() file contents before running external diff

 Windows update.


* mt/dir-iterator-updates (2019-07-11) 10 commits
  (merged to 'next' on 2019-07-19 at 2ebb586ce6)
 + clone: replace strcmp by fspathcmp
 + clone: use dir-iterator to avoid explicit dir traversal
 + clone: extract function from copy_or_link_directory
 + clone: copy hidden paths at local clone
 + dir-iterator: add flags parameter to dir_iterator_begin
 + dir-iterator: refactor state machine model
 + dir-iterator: use warning_errno when possible
 + dir-iterator: add tests for dir-iterator API
 + clone: better handle symlinked files at .git/objects/
 + clone: test for our behavior on odd objects/* content

 Adjust the dir-iterator API and apply it to the local clone
 optimization codepath.


* rm/gpg-program-doc-fix (2019-07-12) 1 commit
  (merged to 'next' on 2019-07-15 at ef358ec2e9)
 + gpg(docs): use correct --verify syntax

 Docfix.


* sr/gpg-interface-stop-at-the-end (2019-07-16) 1 commit
  (merged to 'next' on 2019-07-19 at 5d38aa1236)
 + gpg-interface: do not scan past the end of buffer

 A codepath that reads from GPG for signed object verification read
 past the end of allocated buffer, which has been fixed.


* tg/range-diff-output-update (2019-07-11) 14 commits
  (merged to 'next' on 2019-07-15 at b847d206ed)
 + range-diff: add headers to the outer hunk header
 + range-diff: add filename to inner diff
 + range-diff: add section header instead of diff header
 + range-diff: suppress line count in outer diff
 + range-diff: don't remove funcname from inner diff
 + range-diff: split lines manually
 + range-diff: fix function parameter indentation
 + apply: make parse_git_diff_header public
 + apply: only pass required data to gitdiff_* functions
 + apply: only pass required data to find_name_*
 + apply: only pass required data to check_header_line
 + apply: only pass required data to git_header_name
 + apply: only pass required data to skip_tree_prefix
 + apply: replace marc.info link with public-inbox

 "git range-diff" output has been tweaked for easier identification
 of which part of what file the patch shown is about.


* tg/stash-keep-index-with-removed-paths (2019-07-16) 1 commit
  (merged to 'next' on 2019-07-19 at d4ae24a939)
 + stash: fix handling removed files with --keep-index

 "git stash --keep-index" did not work correctly on paths that have
 been removed, which has been fixed.


* vn/xmmap-gently (2019-07-14) 1 commit
  (merged to 'next' on 2019-07-19 at d95c1d2be3)
 + read-cache.c: do not die if mmap fails

 Clean-up an error codepath.

--------------------------------------------------
[New Topics]

* bb/grep-pcre2-bug-message-fix (2019-07-23) 1 commit
  (merged to 'next' on 2019-07-23 at 8bd5a68618)
 + grep: print the pcre2_jit_on value

 BUG() message fix.

 The codepath may want to just simply be removed, though.


* ra/rebase-i-more-options (2019-07-23) 4 commits
 - SQUASH???
 - rebase -i: support --committer-date-is-author-date
 - sequencer: add NULL checks under read_author_script
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learned a few options that are known by "git
 rebase" proper.

 Needs a bit of fixups, at least.


* sg/travis-gcc-4.8 (2019-07-19) 1 commit
  (merged to 'next' on 2019-07-25 at e3d546eb15)
 + travis-ci: build with GCC 4.8 as well

 Add a job to build with a tad older GCC to make sure we are still
 buildable.

 Will merge to 'master'.


* ab/pcre-jit-fixes (2019-07-24) 3 commits
 - grep: stop using a custom JIT stack with PCRE v1
 - grep: stop "using" a custom JIT stack with PCRE v2
 - grep: remove overly paranoid BUG(...) code

 A few simplification and bugfixes to PCRE interface.

 Will merge to 'next'.


* jk/xdiff-clamp-funcname-context-index (2019-07-23) 1 commit
  (merged to 'next' on 2019-07-25 at b2944a0ba6)
 + xdiff: clamp function context indices in post-image

 The internal diff machinery can be made to read out of bounds while
 looking for --funcion-context line in a corner case, which has been
 corrected.

 Will merge to 'master'.


* js/rebase-cleanup (2019-07-25) 2 commits
  (merged to 'next' on 2019-07-25 at 3d9cedf470)
 + git: mark cmd_rebase as requiring a worktree
 + rebase: fix white-space

 A few leftover cleanup to "git rebase" in C.

 Will merge to 'master'.


* js/rebase-r-strategy (2019-07-25) 12 commits
 - rebase -r: do not (re-)generate root commits with `--root` *and* `--onto`
 - t3418: test `rebase -r` with merge strategies
 - t/lib-rebase: prepare for testing `git rebase --rebase-merges`
 - rebase -r: support merge strategies other than `recursive`
 - t3427: mark two test cases as requiring support for `git rebase -p`
 - t3427: fix another incorrect assumption
 - t3427: accommodate for the `rebase --merge` backend having been replaced
 - t3427: fix erroneous assumption
 - t3427: condense the unnecessarily repetitive test cases into three
 - t3427: move the `filter-branch` invocation into the `setup` case
 - t3427: simplify the `setup` test case significantly
 - t3427: add a clarifying comment

 "git rebase --rebase-merges" learned to drive different merge
 strategies and pass strategy specific options to them.


* js/trace2-json-schema (2019-07-25) 3 commits
 - ci: run trace2 schema validation in the CI suite
 - trace2: add a schema validator for trace2 events
 - trace2: add a JSON schema for trace2 events

 The JSON output produced by "trace2" subsystem now has JSON schema
 defined on it, to allow us validate the output and catch deviation.

 The CI integration may be a bit too heavy-handed.

--------------------------------------------------
[Stalled]

* cb/xdiff-no-system-includes-in-dot-c (2019-06-19) 1 commit
 - xdiff: avoid accidental redefinition of LFS feature in OpenIndiana

 Compilation fix.

 Will be rerolled together with patches from the
 jk/no-system-includes-in-dot-c topic.


* jk/no-system-includes-in-dot-c (2019-06-19) 2 commits
 - wt-status.h: drop stdio.h include
 - verify-tag: drop signal.h include

 Compilation fix.

 Will be rerolled with the above.


* nd/index-dump-in-json (2019-06-26) 11 commits
 - SQUASH???
 - t3008: use the new SINGLE_CPU prereq
 - read-cache.c: dump "IEOT" extension as json
 - read-cache.c: dump "EOIE" extension as json
 - resolve-undo.c: dump "REUC" extension as json
 - fsmonitor.c: dump "FSMN" extension as json
 - split-index.c: dump "link" extension as json
 - dir.c: dump "UNTR" extension as json
 - cache-tree.c: dump "TREE" extension as json
 - read-cache.c: dump common extension info in json
 - ls-files: add --json to dump the index

 "ls-files" learned "--debug-json" option to dump the contents and
 the extensions of the index file.

 At least the fixup at the tip needs to be squashed into the right
 commit.  Also the new test seems flaky.


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


* js/visual-studio (2019-07-18) 24 commits
 - git: avoid calling aliased builtins via their dashed form
 - t5505,t5516: create .git/branches/ when needed
 - bin-wrappers: append `.exe` to target paths if necessary
 - .gitignore: ignore Visual Studio's temporary/generated files
 - .gitignore: touch up the entries regarding Visual Studio
 - vcxproj: also link-or-copy builtins
 - msvc: add a Makefile target to pre-generate the Visual Studio solution
 - contrib/buildsystems: add a backend for modern Visual Studio versions
 - contrib/buildsystems: handle options starting with a slash
 - contrib/buildsystems: also handle -lexpat
 - contrib/buildsystems: handle libiconv, too
 - contrib/buildsystems: handle the curl library option
 - contrib/buildsystems: error out on unknown option
 - contrib/buildsystems: optionally capture the dry-run in a file
 - contrib/buildsystems: redirect errors of the dry run into a log file
 - contrib/buildsystems: ignore gettext stuff
 - contrib/buildsystems: handle quoted spaces in filenames
 - contrib/buildsystems: fix misleading error message
 - contrib/buildsystems: ignore irrelevant files in Generators/
 - contrib/buildsystems: ignore invalidcontinue.obj
 - Vcproj.pm: urlencode '<' and '>' when generating VC projects
 - Vcproj.pm: do not configure VCWebServiceProxyGeneratorTool
 - Vcproj.pm: list git.exe first to be startup project
 - Vcproj.pm: auto-generate GUIDs

 Support building Git with Visual Studio

 The ".git/branches" bit needs to be ejected and treated separately,
 but other than that, the topic looked reasonable.


* bc/hash-independent-tests-part-4 (2019-07-01) 10 commits
 - t2203: avoid hard-coded object ID values
 - t1710: make hash independent
 - t1007: remove SHA1 prerequisites
 - t0090: make test pass with SHA-256
 - t0027: make hash size independent
 - t6030: make test work with SHA-256
 - t5000: make hash independent
 - t1450: make hash size independent
 - t1410: make hash size independent
 - t: add helper to convert object IDs to paths

 Update to the tests to help SHA-256 transition continues.

 Will merge to 'next'.


* es/walken-tutorial (2019-07-02) 1 commit
 - documentation: add tutorial for revision walking

 Yet another revision walker tutorial.


* ds/early-access (2019-07-01) 3 commits
 - repo-settings: pack.useSparse=true
 - repo-settings: use index.version=4 by default
 - repo-settings: create core.featureAdoptionRate setting

 A mechanism to enable newish configuration settings in bulk has
 been invented.

 Will replace with a redesigned variant which is being discussed
 when the dust settles.
 cf. <pull.292.v2.git.gitgitgadget@gmail.com> (v2)


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

 Retire use of kwset library, which is an optimization for looking
 for fixed strings, with use of pcre2 JIT.

 Needs to wait for a few pcre JIT related fixups, including the
 handling of non-UTF8 haystack.


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
