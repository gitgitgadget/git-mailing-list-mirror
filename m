Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5012E1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 20:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388859AbfHAUF2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 16:05:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52741 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388633AbfHAUF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 16:05:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5743F76B1F;
        Thu,  1 Aug 2019 16:05:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=r
        F8KvR1GngHguKhsUvf0fLvVoFI=; b=VqSa5HGm6gkIUaxp+gKbWAvRf6kUZuXDa
        65JPnsgVWQNS8jJR/0JIu0l7XFxvtQ4BwG+t1q90kazCMz1xbjBn9b6cI+A124J3
        Dse0s7DuL8/gG1aKHKXkgXiKiVh0sq0E5OrolphtvLSwpQkDn0RfOc+Ibfi4Xt5Q
        fAK8EXWhFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Ipe
        UOfeN0jfJVfK3raJ0ti6O8XGyq+UyHOyLKQ0s0mHtTQSsf/kdJMVE02EuInxRA6V
        IXZrwPIwnI7CDsufCr1pnqmBuJVHmzVBgzXiDgM3d3InR9wHTVUQ6UfGXnrv3Z2R
        HOLhyHbMsZgn9F2yU8t42zA/uOA9yE7ajxOf1nq0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CE4B76B1E;
        Thu,  1 Aug 2019 16:05:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7054B76B1D;
        Thu,  1 Aug 2019 16:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2019, #01; Thu, 1)
X-master-at: 51cf315870bbb7254ddf06c84fe03b41bc48eebd
X-next-at: 66108df07cb19d083b2ca07a23f4bf494216042f
Date:   Thu, 01 Aug 2019 13:05:12 -0700
Message-ID: <xmqqv9vgmz2f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACDD427E-B497-11E9-90E6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/hash-independent-tests-part-4 (2019-07-01) 10 commits
  (merged to 'next' on 2019-07-29 at d1efaea0ec)
 + t2203: avoid hard-coded object ID values
 + t1710: make hash independent
 + t1007: remove SHA1 prerequisites
 + t0090: make test pass with SHA-256
 + t0027: make hash size independent
 + t6030: make test work with SHA-256
 + t5000: make hash independent
 + t1450: make hash size independent
 + t1410: make hash size independent
 + t: add helper to convert object IDs to paths

 Update to the tests to help SHA-256 transition continues.


* cb/xdiff-no-system-includes-in-dot-c (2019-07-28) 3 commits
  (merged to 'next' on 2019-07-29 at 35ea0d8cba)
 + xdiff: remove duplicate headers from xpatience.c
 + xdiff: remove duplicate headers from xhistogram.c
 + xdiff: drop system includes in xutils.c
 (this branch uses jk/no-system-includes-in-dot-c.)

 Compilation fix.


* jc/dir-iterator-test-fix (2019-07-30) 1 commit
  (merged to 'next' on 2019-07-31 at 8637ae9f34)
 + test-dir-iterator: do not assume errno values

 Test fix.


* jk/no-system-includes-in-dot-c (2019-06-19) 2 commits
  (merged to 'next' on 2019-07-29 at 8081b8c13d)
 + wt-status.h: drop stdio.h include
 + verify-tag: drop signal.h include
 (this branch is used by cb/xdiff-no-system-includes-in-dot-c.)

 Compilation fix.


* jk/repack-silence-auto-bitmap-warning (2019-07-31) 3 commits
  (merged to 'next' on 2019-07-31 at 3aa218347c)
 + repack: simplify handling of auto-bitmaps and .keep files
 + repack: silence warnings when auto-enabled bitmaps cannot be built
 + t7700: clean up .keep file in bitmap-writing test

 Squelch unneeded and misleading warnings from "repack" when the
 command attempts to generate pack bitmaps without explicitly asked
 for by the user.


* jk/sort-iter-test-output (2019-07-31) 1 commit
  (merged to 'next' on 2019-07-31 at 449695af8f)
 + t: sort output of hashmap iteration

 Test fix.


--------------------------------------------------
[New Topics]

* ds/feature-macros (2019-07-30) 5 commits
 - repo-settings: create feature.experimental setting
 - repo-settings: create feature.manyFiles setting
 - repo-settings: parse core.untrackedCache
 - repo-settings: add feature.manyCommits setting
 - repo-settings: consolidate some config settings


* mt/grep-submodules-working-tree (2019-07-30) 1 commit
 - grep: fix worktree case in submodules

 "git grep --recurse-submodules" that looks at the working tree
 files looked at the contents in the index in submodules, instead of
 files in the working tree.

 Will merge to 'next'.


* sg/fsck-config-in-doc (2019-07-29) 1 commit
 - Documentation/git-fsck.txt: include fsck.* config variables

 Doc update.

 Will merge to 'next'.


* jk/tree-walk-overflow (2019-07-31) 6 commits
 - tree-walk: harden make_traverse_path() length computations
 - tree-walk: add a strbuf wrapper for make_traverse_path()
 - tree-walk: accept a raw length for traverse_path_len()
 - tree-walk: use size_t consistently
 - tree-walk: drop oid from traverse_info
 - setup_traverse_info(): stop copying oid

 Codepaths to walk tree objects have been audited for integer
 overflows and hardened.

 Will merge to 'next'.


* js/early-config-with-onbranch (2019-07-31) 1 commit
  (merged to 'next' on 2019-08-01 at 26b713c824)
 + config: work around bug with includeif:onbranch and early config

 The recently added [includeif "onbranch:branch"] feature does not
 work well with an early config mechanism, as it attempts to find
 out what branch we are on before we even haven't located the git
 repository.  The inclusion during early config scan is ignored to
 work around this issue.

 Will merge to 'master'.


* jc/log-mailmap-flip-defaults (2019-08-01) 1 commit
  (merged to 'next' on 2019-08-01 at 80cddd7895)
 + log: flip the --mailmap default unconditionally


* sg/t5510-test-i18ngrep-fix (2019-07-31) 1 commit
 - t5510-fetch: fix negated 'test_i18ngrep' invocation
 (this branch is used by sg/do-not-skip-non-httpd-tests.)

 Test fix.

 Will merge to 'next'.


* sg/do-not-skip-non-httpd-tests (2019-08-01) 3 commits
 - tests: warn against appending non-httpd-specific tests at the end
 - t5703: run all non-httpd-specific tests before sourcing 'lib-httpd.sh'
 - t5510-fetch: run non-httpd-specific test before sourcing 'lib-httpd.sh'
 (this branch uses sg/t5510-test-i18ngrep-fix.)

 Test fix.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

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

* vn/reset-deleted-ita (2019-07-26) 1 commit
 - reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.

 Expecting a reroll.


* ra/rebase-i-more-options (2019-07-23) 4 commits
 - SQUASH???
 - rebase -i: support --committer-date-is-author-date
 - sequencer: add NULL checks under read_author_script
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learned a few options that are known by "git
 rebase" proper.

 Needs a bit of fixups, at least.


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


* js/trace2-json-schema (2019-07-25) 3 commits
 . ci: run trace2 schema validation in the CI suite
 . trace2: add a schema validator for trace2 events
 . trace2: add a JSON schema for trace2 events

 The JSON output produced by "trace2" subsystem now has JSON schema
 defined on it, to allow us validate the output and catch deviation.

 The CI integration may be a bit too heavy-handed.


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


* js/visual-studio (2019-07-29) 23 commits
 - git: avoid calling aliased builtins via their dashed form
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

 The bits about .git/branches/* have been dropped from the series.
 We may want to drop the support for it, but until that happens, the
 tests should rely on the existence of the support to pass.


* es/walken-tutorial (2019-07-02) 1 commit
 - documentation: add tutorial for revision walking

 Yet another revision walker tutorial.


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

--------------------------------------------------
[Discarded]

* nd/index-dump-in-json (2019-06-26) 11 commits
 . SQUASH???
 . t3008: use the new SINGLE_CPU prereq
 . read-cache.c: dump "IEOT" extension as json
 . read-cache.c: dump "EOIE" extension as json
 . resolve-undo.c: dump "REUC" extension as json
 . fsmonitor.c: dump "FSMN" extension as json
 . split-index.c: dump "link" extension as json
 . dir.c: dump "UNTR" extension as json
 . cache-tree.c: dump "TREE" extension as json
 . read-cache.c: dump common extension info in json
 . ls-files: add --json to dump the index

 "ls-files" learned "--debug-json" option to dump the contents and
 the extensions of the index file.

 Retracted at least for now.
 cf. <CACsJy8A8fJZq6k2i_e0EpkxN8SZ4+8h1FA0eV6e9xFLaMDcsPg@mail.gmail.com>


* ds/early-access (2019-07-01) 3 commits
 . repo-settings: pack.useSparse=true
 . repo-settings: use index.version=4 by default
 . repo-settings: create core.featureAdoptionRate setting

 A mechanism to enable newish configuration settings in bulk has
 been invented.

 ds/feature-macros has replaced this topic.
