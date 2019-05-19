Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0261F461
	for <e@80x24.org>; Sun, 19 May 2019 17:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfESRPm (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 13:15:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60015 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfESRPl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 13:15:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 591886528D;
        Sun, 19 May 2019 05:20:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=rTTdYpFJPFnXISTf/qcRdT12k
        dM=; b=awqSIm6kU1zsFkFh/yqE8Oh0/TPmI/5m3Fk8mO7XoL10hFm0xAAxK2xP/
        3ZNmQHnbVGULj9QxIwZi0JDHCIT+YfbpR1CZmPIDNPzE1uZt/KQmlK1iCf+qduy0
        +k6LzSflpud3ZcNboC+ofnjPzWZUyoHUpPM8YIDlFFuUj4YbTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=OS4a5oyUReb7ybcuVCT
        gbKm9ANLocYM2nHslSvD4GRHruHbtkdW4q4KBIh0xoRVLPTimJLtcPPVz0WpHp7z
        9s40ZoSt1OEW+j7aTf/MrXxAUC8VHcsN6Wzm4IBoPNMUT9jTQAi/ZxzKkv/yipCq
        nIbhQ65q0Ps7h672bEZ9fvnI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5191A6528A;
        Sun, 19 May 2019 05:20:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4442765284;
        Sun, 19 May 2019 05:20:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2019, #03; Sun, 19)
X-master-at: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
X-next-at: 3120a1824446a317099b597aac098c4ec420be6e
Date:   Sun, 19 May 2019 18:20:01 +0900
Message-ID: <xmqqpnoeztq6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 48A25A20-7A17-11E9-9E76-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The first release candidate Git 2.22-rc1 has been tagged.  There
still are a few topics from 'next' that need to go to 'master'
before the final, but otherwise this should be pretty close to the
final version.  Knock knock...

I'll go offline for a week or so and then tag -rc2 early next week
after I come back to the US.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/perf-installed-fix (2019-05-08) 6 commits
  (merged to 'next' on 2019-05-13 at ccd997a142)
 + perf-lib.sh: forbid the use of GIT_TEST_INSTALLED
 + perf tests: add "bindir" prefix to git tree test results
 + perf-lib.sh: remove GIT_TEST_INSTALLED from perf-lib.sh
 + perf-lib.sh: make "./run <revisions>" use the correct gits
 + perf aggregate: remove GIT_TEST_INSTALLED from --codespeed
 + perf README: correct docs for 3c8f12c96c regression

 Performance test framework has been broken and measured the version
 of Git that happens to be on $PATH, not the specified one to
 measure, for a while, which has been corrected.
 cf. <20190507105434.9600-1-avarab@gmail.com>


* ab/sha1dc (2019-05-14) 1 commit
  (merged to 'next' on 2019-05-16 at a663e08047)
 + sha1dc: update from upstream

 Update collision-detecting SHA-1 code to build properly on HP-UX.


* ab/trace2-typofix (2019-05-13) 1 commit
  (merged to 'next' on 2019-05-13 at f1229d4d9d)
 + trace2: fix up a missing "leave" entry point

 Typofix.


* bl/t4253-exit-code-from-format-patch (2019-05-07) 1 commit
  (merged to 'next' on 2019-05-15 at 4893c65956)
 + t4253-am-keep-cr-dos: avoid using pipes

 Avoid patterns to pipe output from a git command to feed another
 command in tests.


* cb/http-push-null-in-message-fix (2019-05-15) 1 commit
  (merged to 'next' on 2019-05-16 at d9709e0c40)
 + http-push: prevent format overflow warning with gcc >=3D 9

 Code clean-up.


* cm/notes-comment-fix (2019-05-07) 1 commit
  (merged to 'next' on 2019-05-15 at af8fffab26)
 + notes: correct documentation of format_display_notes()

 A stale in-code comment has been updated.


* cw/diff-highlight (2019-05-09) 1 commit
  (merged to 'next' on 2019-05-13 at 050d707166)
 + diff-highlight: use correct /dev/null for UNIX and Windows

 Portability fix for a diff-highlight tool (in contrib/).


* dl/branch-from-3dot-merge-base (2019-05-07) 2 commits
  (merged to 'next' on 2019-05-13 at 2eb387070e)
 + branch: make create_branch accept a merge base rev
 + t2018: cleanup in current test

 "git branch new A...B" and "git checkout -b new A...B" have been
 taught that in their contexts, the notation A...B means "the merge
 base between these two commits", just like "git checkout A...B"
 detaches HEAD at that commit.
 cf. <cover.1556366347.git.liu.denton@gmail.com>


* dl/difftool-mergetool (2019-05-13) 7 commits
  (merged to 'next' on 2019-05-15 at 19ecd284b3)
 + difftool: fallback on merge.guitool
 + difftool: make --gui, --tool and --extcmd mutually exclusive
 + mergetool: fallback to tool when guitool unavailable
 + mergetool--lib: create gui_mode function
 + mergetool: use get_merge_tool function
 + t7610: add mergetool --gui tests
 + t7610: unsuppress output

 Update "git difftool" and "git mergetool" so that the combinations
 of {diff,merge}.{tool,guitool} configuration variables serve as
 fallback settings of each other in a sensible order.
 cf. <cover.1556518203.git.liu.denton@gmail.com> (v5)


* dl/warn-tagging-a-tag (2019-05-09) 1 commit
  (merged to 'next' on 2019-05-13 at a2f6365923)
 + tag: fix typo in nested tagging hint

 Typofix.


* ds/cvsexportcommit-force-text (2019-05-07) 1 commit
  (merged to 'next' on 2019-05-15 at 9874698ae0)
 + cvsexportcommit: force crlf translation

 "git cvsexportcommit" running on msys did not expect cvsnt showed
 "cvs status" output with CRLF line endings.


* ds/midx-too-many-packs (2019-05-07) 2 commits
  (merged to 'next' on 2019-05-15 at 7203801e27)
 + midx: add packs to packed_git linked list
 + midx: pass a repository pointer

 The code to generate the multi-pack idx file was not prepared to
 see too many packfiles and ran out of open file descriptor, which
 has been corrected.


* ds/trace2-document-env-vars (2019-05-13) 1 commit
  (merged to 'next' on 2019-05-15 at 7d28c6bd35)
 + trace2: add variable description to git.txt

 Doc update.


* en/unicode-in-refnames (2019-04-26) 1 commit
  (merged to 'next' on 2019-05-15 at 53662a2843)
 + Honor core.precomposeUnicode in more places

 On a filesystem like HFS+, the names of the refs stored as filesystem
 entities may become different from what the end-user expects, just
 like files in the working tree get "renamed".  Work around the
 mismatch by paying attention to the core.precomposeUnicode
 configuration.


* es/check-non-portable-pre-5.10 (2019-05-13) 1 commit
  (merged to 'next' on 2019-05-15 at 49228ada86)
 + check-non-portable-shell: support Perl versions older than 5.10

 Developer support update.


* id/windows-dep-aslr (2019-05-13) 2 commits
  (merged to 'next' on 2019-05-13 at 33d57069f8)
 + mingw: enable DEP and ASLR
 + mingw: do not let ld strip relocations

 Allow DEP and ASLR for Windows build to for security hardening.


* jc/set-packet-header-signature-fix (2019-05-16) 1 commit
  (merged to 'next' on 2019-05-16 at 6af28982a1)
 + pkt-line: drop 'const'-ness of a param to set_packet_header()

 Code clean-up.


* jk/apache-lsan (2019-05-08) 1 commit
  (merged to 'next' on 2019-05-13 at 1a055a6df0)
 + t/lib-httpd: pass LSAN_OPTIONS through apache

 Allow tests that involve httpd to be run under leak sanitizer, just
 like we can already do so under address sanitizer.


* jk/cocci-batch (2019-05-08) 2 commits
  (merged to 'next' on 2019-05-13 at 8bbbfd3438)
 + coccicheck: make batch size of 0 mean "unlimited"
 + coccicheck: optionally batch spatch invocations

 Optionally "make coccicheck" can feed multiple source files to
 spatch, gaining performance while spending more memory.


* jk/get-oid-indexed-object-name (2019-05-15) 1 commit
  (merged to 'next' on 2019-05-16 at f4788d4b4a)
 + get_oid: handle NULL repo->index

 The codepath to parse :<path> that obtains the object name for an
 indexed object has been made more robust.


* js/commit-graph-parse-leakfix (2019-05-07) 1 commit
  (merged to 'next' on 2019-05-13 at 18df8ac778)
 + commit-graph: fix memory leak

 Leakfix.


* js/difftool-no-index (2019-05-09) 1 commit
  (merged to 'next' on 2019-05-16 at 7b918fa9a4)
 + difftool --no-index: error out on --dir-diff (and don't crash)

 The "--dir-diff" mode of "git difftool" is not useful in "--no-index"
 mode; they are now explicitly marked as mutually incompatible.


* js/fsmonitor-refresh-after-discarding-index (2019-05-08) 2 commits
  (merged to 'next' on 2019-05-15 at 01dce0bf0e)
 + fsmonitor: force a refresh after the index was discarded
 + fsmonitor: demonstrate that it is not refreshed after discard_index()

 The fsmonitor interface got out of sync after the in-core index
 file gets discarded, which has been corrected.


* js/parseopt-unknown-cb-returns-an-enum (2019-05-14) 1 commit
  (merged to 'next' on 2019-05-16 at 0feef071b7)
 + parse-options: adjust `parse_opt_unknown_cb()`s declared return type

 Code clean-up.


* js/rebase-i-label-shown-in-status-fix (2019-05-13) 1 commit
  (merged to 'next' on 2019-05-15 at c7fefa1f9c)
 + status: fix display of rebase -ir's `label` command

 "git status" did not know that the "label" instruction in the
 todo-list "rebase -i -r" uses should not be shown as a hex object
 name.


* js/stash-in-c-use-builtin-doc (2019-05-15) 1 commit
  (merged to 'next' on 2019-05-16 at 26c8bfc106)
 + stash: document stash.useBuiltin

 Doc update.


* js/t5580-unc-alternate-test (2019-05-07) 1 commit
  (merged to 'next' on 2019-05-15 at dfff4a6397)
 + t5580: verify that alternates can be UNC paths

 An additional test for MinGW


* js/t6500-use-windows-pid-on-mingw (2019-05-08) 1 commit
  (merged to 'next' on 2019-05-13 at 24e5e27eb7)
 + t6500(mingw): use the Windows PID of the shell

 Future-proof a test against an update to MSYS2 runtime v3.x series.
 cf. <pull.185.git.gitgitgadget@gmail.com>
 It might be helpful in the longer term to encapsulate the code that
 uses /proc/$$/winpid into a helper function and use it anywhere $$
 is referenced, but let's defer it until we see such a callsite that
 would be helped by such a move.


* mh/http-fread-api-fix (2019-05-08) 1 commit
  (merged to 'next' on 2019-05-13 at f6af2d38d7)
 + Make fread/fwrite-like functions in http.c more like fread/fwrite.

 A pair of private functions in http.c that had names similar to
 fread/fwrite did not return the number of elements, which was found
 to be confusing.


* nd/parse-options-aliases (2019-05-07) 1 commit
  (merged to 'next' on 2019-05-13 at c77cc06452)
 + parse-options: don't emit "ambiguous option" for aliases

 Attempt to use an abbreviated option in "git clone --recurs" is
 responded by a request to disambiguate between --recursive and
 --recurse-submodules, which is bad because these two are synonyms.
 The parse-options API has been extended to define such synonyms
 more easily and not produce an unnecessary failure.


* nd/submodule-helper-incomplete-line-fix (2019-05-08) 1 commit
  (merged to 'next' on 2019-05-13 at cd52f49825)
 + submodule--helper: add a missing \n

 Typofix.


* sg/ci-libsvn-perl (2019-05-07) 1 commit
  (merged to 'next' on 2019-05-15 at 8453976768)
 + ci: install 'libsvn-perl' instead of 'git-svn'

 To run tests for Git SVN, our scripts for CI used to install the
 git-svn package (in the hope that it would bring in the right
 dependencies).  This has been updated to install the more direct
 dependency, namely, libsvn-perl.


* tt/no-ipv6-fallback-for-winxp (2019-05-07) 1 commit
  (merged to 'next' on 2019-05-15 at f6c80e2c1b)
 + mingw: remove obsolete IPv6-related code

 Code cleanup.


* tz/test-lib-check-working-jgit (2019-05-15) 1 commit
  (merged to 'next' on 2019-05-16 at 7ca75a34bf)
 + test-lib: try harder to ensure a working jgit

 A prerequiste check in the test suite to see if a working jgit is
 available was made more robust.

--------------------------------------------------
[New Topics]

* ab/fail-prereqs-in-test (2019-05-14) 1 commit
  (merged to 'next' on 2019-05-16 at d1be55f485)
 + tests: add a special setup where prerequisites fail

 Developer support to emulate unsatisfied prerequisites in tests to
 ensure that the remainer of the tests still succeeds when tests
 with prerequisites are skipped.

 Will cook in 'next'.


* jk/help-unknown-ref-fix (2019-05-15) 2 commits
  (merged to 'next' on 2019-05-19 at e3e01160f7)
 + help_unknown_ref(): check for refname ambiguity
 + help_unknown_ref(): duplicate collected refnames

 Improve the code to show args with potential typo that cannot be
 interpreted as a commit-ish.

 Will cook in 'next'.


* js/rebase-cleanup (2019-05-15) 5 commits
  (merged to 'next' on 2019-05-16 at ccfed8f263)
 + rebase: fold git-rebase--common into the -p backend
 + sequencer: the `am` and `rebase--interactive` scripts are gone
 + .gitignore: there is no longer a built-in `git-rebase--interactive`
 + t3400: stop referring to the scripted rebase
 + Drop unused git-rebase--am.sh

 Update supporting parts of "git rebase" to remove code that should
 no longer be used.

 Will cook in 'next'.


* jt/partial-clone-missing-ref-delta-base (2019-05-15) 2 commits
 - index-pack: prefetch missing REF_DELTA bases
 - t5616: refactor packfile replacement

 "git fetch" into a lazy clone forgot to fetch base objects that are
 necessary to complete delta in a thin packfile, which has been
 corrected.


* bl/userdiff-octave (2019-05-19) 1 commit
  (merged to 'next' on 2019-05-19 at 9ea1180d6c)
 + userdiff: add Octave

 The pattern "git diff/grep" use to extract funcname and words
 boundary for Matlab has been extend to cover Octave, which is more
 or less equivalent.

 Will cook in 'next'.


* ew/update-server-info (2019-05-15) 1 commit
  (merged to 'next' on 2019-05-19 at bf4f2871ab)
 + update-server-info: avoid needless overwrites

 "git update-server-info" learned not to rewrite the file with the
 same contents.

 Will cook in 'next'.


* nd/corrupt-worktrees (2019-05-15) 1 commit
  (merged to 'next' on 2019-05-16 at d92c25f800)
 + worktree add: be tolerant of corrupt worktrees

 "git worktree add" used to fail when another worktree connected to
 the same repository was corrupt, which has been corrected.

 Will cook in 'next'.


* mh/import-transport-fd-fix (2019-05-16) 2 commits
  (merged to 'next' on 2019-05-19 at 5e86f92f7a)
 + Use xmmap_gently instead of xmmap in use_pack
 + dup() the input fd for fast-import used for remote helpers

 The ownership rule for the file descriptor to fast-import remote
 backend was mixed up, leading to unrelated file descriptor getting
 closed, which has been fixed.

 Will cook in 'next'.


* ab/deprecate-R-for-dynpath (2019-05-19) 1 commit
  (merged to 'next' on 2019-05-19 at 944976e981)
 + Makefile: remove the NO_R_TO_GCC_LINKER flag

 The way of specifying the path to find dynamic libraries at runtime
 has been simplified.  The old default to pass -R/path/to/dir has been
 replaced with the new default to pass -Wl,-rpath,/path/to/dir,
 which is the more recent GCC uses.  Those who need to build with an
 old GCC can still use "CC_LD_DYNPATH=3D-R"

 Will cook in 'next'.


* ba/clone-remote-submodules (2019-05-19) 1 commit
 - clone: add `--remote-submodules` flag

 "git clone --recurse-submodules" learned to set up the submodules
 to ignore commit object names recorded in the superproject gitlink
 and instead use the commits that happen to be at the tip of the
 remote-tracking branches from the get-go, by passing the new
 "--remote-submodules" option.


* ds/close-object-store (2019-05-19) 3 commits
 - packfile: close_all_packs to close_object_store
 - packfile: close commit-graph in close_all_packs
 - commit-graph: use raw_object_store when closing
 (this branch uses ds/commit-graph-write-refactor.)

 The commit-graph file is now part of the "files that the runtime
 may keep open file descriptors on, all of which would need to be
 closed when done with the object store", and the file descriptor to
 an existing commit-graph file now is closed before "gc" finializes
 a new instance to replace it.

 Waiting on ds/commit-graph-write-refactor to stabilize.


* ja/diff-opt-typofix (2019-05-19) 1 commit
  (merged to 'next' on 2019-05-19 at fedb594191)
 + diff: fix mistake in translatable strings

 Typofix.

 Will merge to 'master'.


* ml/userdiff-rust (2019-05-17) 1 commit
  (merged to 'next' on 2019-05-19 at 1266fddce5)
 + userdiff: add built-in pattern for rust

 The pattern "git diff/grep" use to extract funcname and words
 boundary for Rust has been added.

 Will cook in 'next'.


* pw/rebase-edit-message-for-replayed-merge (2019-05-19) 1 commit
  (merged to 'next' on 2019-05-19 at dc3e30641c)
 + rebase -r: always reword merge -c

 A "merge -c" instruction during "git rebase --rebase-merges" should
 give the user a chance to edit the log message, even when there is
 otherwise no need to create a new merge and replace the existing
 one (i.e. fast-forward instead), but did not.  Which has been
 corrected.

 Will cook in 'next'.

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
 <CAHk-=3DwhP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>

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

 Stalled


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will drop as "add -i in C" topic seems to be getting ready to test.


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.

 Expecting a reroll.
 cf. <CANq=3Dj3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.co=
m>


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

* sb/format-patch-base-patch-id-fix (2019-05-08) 2 commits
  (merged to 'next' on 2019-05-15 at 1ab7d2b71c)
 + format-patch: make --base patch-id output stable
 + format-patch: inform user that patch-id generation is unstable

 The recently added "--base" option of "format-patch" computed the
 patch-ids for prerequisite patches in an unstable way, which has
 been updated to compute in a way that is compatible with "git
 patch-id --stable".

 Will cook in 'next'.


* ab/send-email-transferencoding-fix (2019-05-19) 7 commits
 . send-email: fix regression in sendemail.identity parsing
 . send-email: document --no-[to|cc|bcc]
 . send-email: fix broken transferEncoding tests
 . send-email: remove cargo-culted multi-patch pattern in tests
  (merged to 'next' on 2019-05-13 at 38c6a1e7e0)
 + send-email: do defaults -> config -> getopt in that order
 + send-email: rename the @bcclist variable for consistency
 + send-email: move the read_config() function above getopts

 Since "git send-email" learned to take 'auto' as the value for the
 transfer-encoding, it by mistake stopped honoring the values given
 to the configuration variables sendemail.transferencoding and/or
 sendemail.<ident>.transferencoding.  This has been corrected to
 (finally) redoing the order of setting the default, reading the
 configuration and command line options.

 Will merge to and cook in 'next'.


* dl/format-patch-notes-config (2019-05-17) 2 commits
  (merged to 'next' on 2019-05-19 at d3f6f1872b)
 + format-patch: teach format.notes config option
 + git-format-patch.txt: document --no-notes option

 "git format-patch" learns a configuration to set the default for
 its --notes=3D<ref> option.

 Will cook in 'next'.


* jk/unused-params-final-batch (2019-05-13) 14 commits
  (merged to 'next' on 2019-05-15 at ef7435264c)
 + verify-commit: simplify parameters to run_gpg_verify()
 + show-branch: drop unused parameter from show_independent()
 + rev-list: drop unused void pointer from finish_commit()
 + remove_all_fetch_refspecs(): drop unused "remote" parameter
 + receive-pack: drop unused "commands" from prepare_shallow_update()
 + pack-objects: drop unused rev_info parameters
 + name-rev: drop unused parameters from is_better_name()
 + mktree: drop unused length parameter
 + wt-status: drop unused status parameter
 + read-cache: drop unused parameter from threaded load
 + clone: drop dest parameter from copy_alternates()
 + submodule: drop unused prefix parameter from some functions
 + builtin: consistently pass cmd_* prefix to parse_options
 + cmd_{read,write}_tree: rename "unused" variable that is used

 Remove many unused parameters throughout the codebase, with the
 ultimate aim to allow us compile with -Wunused-parameter cleanly.

 Will cook in 'next'.


* nd/init-relative-template-fix (2019-05-13) 1 commit
  (merged to 'next' on 2019-05-15 at 4d5b17f712)
 + init: make --template path relative to $CWD

 A relative pathname given to "git init --template=3D<path> <repo>"
 ought to be relative to the directory "git init" gets invoked in,
 but it instead was made relative to the repository, which has been
 corrected.

 Will cook in 'next'.


* an/ignore-doc-update (2019-05-08) 1 commit
 - gitignore.txt: make slash-rules more readable

 The description about slashes in gitignore patterns (used to
 indicate things like "anchored to this level only" and "only
 matches directories") has been revamped.

 Almost there.
 cf. <20190507104507.18735-1-admin@in-ici.net>


* en/fast-export-encoding (2019-05-14) 5 commits
  (merged to 'next' on 2019-05-16 at c88bd3edb5)
 + fast-export: do automatic reencoding of commit messages only if reques=
ted
 + fast-export: differentiate between explicitly UTF-8 and implicitly UTF=
-8
 + fast-export: avoid stripping encoding header if we cannot reencode
 + fast-import: support 'encoding' commit header
 + t9350: fix encoding test to actually test reencoding

 The "git fast-export/import" pair has been taught to handle commits
 with log messages in encoding other than UTF-8 better.

 Will cook in 'next'.


* nd/merge-quit (2019-05-19) 2 commits
  (merged to 'next' on 2019-05-19 at 9880e7ee4e)
 + merge: add --quit
 + merge: remove drop_save() in favor of remove_merge_branch_state()

 "git merge" learned "--quit" option that cleans up the in-progress
 merge while leaving the working tree and the index still in a mess.

 Will cook in 'next'.


* pw/rebase-abort-clean-rewritten (2019-05-15) 4 commits
 - rebase --abort/--quit: cleanup refs/rewritten
 - sequencer: return errors from sequencer_remove_state()
 - rebase: warn if state directory cannot be removed
 - rebase: fix a memory leak

 "git rebase --abort" used to leave refs/rewritten/ when concluding
 "git rebase -r", which has been corrected.

 On hold.
 cf. <20190514180349.17245-1-phillip.wood123@gmail.com>


* nb/branch-show-other-worktrees-head (2019-05-07) 3 commits
 - branch: add worktree info on verbose output
 - branch: update output to include worktree info
 - ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.


* es/first-contrib-tutorial (2019-05-19) 2 commits
  (merged to 'next' on 2019-05-19 at 9ddfae82bf)
 + documentation: add anchors to MyFirstContribution
 + documentation: add tutorial for first contribution

 A new tutorial targetting specifically aspiring git-core
 developers.

 Will cook in 'next'.
 cf. <20190517190359.21676-1-emilyshaffer@google.com> (v6)


* cc/multi-promisor (2019-04-15) 17 commits
 - Move core_partial_clone_filter_default to promisor-remote.c
 - Move repository_format_partial_clone to promisor-remote.c
 - Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
 - remote: add promisor and partial clone config to the doc
 - partial-clone: add multiple remotes in the doc
 - t0410: test fetching from many promisor remotes
 - builtin/fetch: remove unique promisor remote limitation
 - promisor-remote: parse remote.*.partialclonefilter
 - diff: use promisor-remote.h instead of fetch-object.h
 - Use promisor_remote_get_direct() and has_promisor_remote()
 - promisor-remote: use repository_format_partial_clone
 - promisor-remote: add promisor_remote_reinit()
 - promisor-remote: implement promisor_remote_get_direct()
 - Add initial support for many promisor remotes
 - fetch-object: make functions return an error code
 - t0410: remove pipes after git commands
 - Merge branch 'jt/batch-fetch-blobs-in-diff' into cc/multi-promisor

 Teach the lazy clone machinery that there can be more than one
 promisor remote and consult them in order when downloading missing
 objects on demand.

 Needs review.


* nd/switch-and-restore (2019-05-07) 43 commits
 - Declare both git-switch and git-restore experimental
 - help: move git-diff and git-reset to different groups
 - doc: promote "git restore"
 - user-manual.txt: prefer 'merge --abort' over 'reset --hard'
 - completion: support restore
 - t: add tests for restore
 - restore: support --patch
 - restore: replace --force with --ignore-unmerged
 - restore: default to --source=3DHEAD when only --staged is specified
 - restore: reject invalid combinations with --staged
 - restore: add --worktree and --staged
 - checkout: factor out worktree checkout code
 - restore: disable overlay mode by default
 - restore: make pathspec mandatory
 - restore: take tree-ish from --source option instead
 - checkout: split part of it to new command 'restore'
 - doc: promote "git switch"
 - completion: support switch
 - t: add tests for switch
 - switch: make --orphan switch to an empty tree
 - switch: reject if some operation is in progress
 - switch: no worktree status unless real branch switch happens
 - switch: implicit dwim, use --no-guess to disable it
 - switch: add short option for --detach
 - switch: only allow explicit detached HEAD
 - switch: reject "do nothing" case
 - switch: stop accepting pathspec
 - switch: remove -l
 - switch: add --discard-changes
 - switch: better names for -b and -B
 - checkout: split part of it to new command 'switch'
 - checkout: split options[] array in three pieces
 - checkout: move 'confict_style' and 'dwim_..' to checkout_opts
 - checkout: make "opts" in cmd_checkout() a pointer
 - checkout: factor out some code in parse_branchname_arg()
 - checkout: keep most #include sorted
 - checkout: inform the user when removing branch state
 - checkout: advice how to get out of detached HEAD mode
 - t: rename t2014-switch.sh to t2014-checkout-switch.sh
 - git-checkout.txt: fix monospace typeset
 - doc: document --overwrite-ignore
 - git-checkout.txt: fix one syntax line
 - git-checkout.txt: spell out --no-option

 Two new commands "git switch" and "git restore" are introduced to
 split "checking out a branch to work on advancing its history" and
 "checking out paths out of the index and/or a tree-ish to work on
 advancing the current history" out of the single "git checkout"
 command.

 The "switch" part seems more or less ready for testing.  Perhaps
 we should split this back into two topics and merge it to 'next'.
 cf. <20190329103919.15642-1-pclouds@gmail.com> (switch v6)
 cf. <20190425094600.15673-1-pclouds@gmail.com> (restore v3)


* jc/format-patch-noclobber (2019-02-22) 1 commit
 - format-patch: --no-clobber refrains from overwriting output files

 "git format-patch" used to overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Undecided but inclined to discard.


* am/p4-branches-excludes (2019-04-02) 8 commits
 - git-p4: respect excluded paths when detecting branches
 - git-p4: add failing test for "git-p4: respect excluded paths when dete=
cting branches"
 - git-p4: don't exclude other files with same prefix
 - git-p4: add failing test for "don't exclude other files with same pref=
ix"
 - git-p4: don't groom exclude path list on every commit
 - git-p4: match branches case insensitively if configured
 - git-p4: add failing test for "git-p4: match branches case insensitivel=
y if configured"
 - git-p4: detect/prevent infinite loop in gitCommitByP4Change()

 "git p4" update.

 Is this ready for 'next'?


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
 cf. <xmqqa7fxionx.fsf@gitster-ct.c.googlers.com>


* nd/worktree-name-sanitization (2019-05-15) 1 commit
  (merged to 'next' on 2019-05-16 at 9a2dd33122)
 + worktree add: sanitize worktree names

 In recent versions of Git, per-worktree refs are exposed in
 refs/worktrees/<wtname>/ hierarchy, which means that worktree names
 must be a valid refname component.  The code now sanitizes the names
 given to worktrees, to make sure these refs are well-formed.

 Will cook in 'next'.


* ds/commit-graph-write-refactor (2019-05-13) 11 commits
 - commit-graph: extract write_commit_graph_file()
 - commit-graph: extract copy_oids_to_commits()
 - commit-graph: extract count_distinct_commits()
 - commit-graph: extract fill_oids_from_all_packs()
 - commit-graph: extract fill_oids_from_commit_hex()
 - commit-graph: extract fill_oids_from_packs()
 - commit-graph: create write_commit_graph_context
 - commit-graph: remove Future Work section
 - commit-graph: collapse parameters into flags
 - commit-graph: return with errors during write
 - commit-graph: fix the_repository reference
 (this branch is used by ds/close-object-store.)

 Renamed from commit-graph-format-v2 and changed scope.

 Expecting a reroll.
 I think it is almost there, modulo a few internal API details..
 cf. <pull.112.v4.git.gitgitgadget@gmail.com> (v4)
 cf. <17829620-1084-74e5-54ad-aa95990f4dbd@gmail.com>


* br/blame-ignore (2019-05-17) 10 commits
 - SQUASH??? test-lint -- seq not portable
 - SQUASH??? error: decl-after-stmt
 - blame: use the fingerprint heuristic to match ignored lines
 - blame: add a fingerprint heuristic to match ignored lines
 - blame: optionally track line fingerprints during fill_blame_origin()
 - blame: add config options for the output of ignored or unblamable line=
s
 - blame: add the ability to ignore commits and their changes
 - blame: use a helper function in blame_chunk()
 - Move oidset_parse_file() to oidset.c
 - fsck: rename and touch up init_skiplist()

 "git blame" learned to "ignore" commits in the history, whose
 effects (as well as their presence) get ignored.

 cf. <20190515214503.77162-1-brho@google.com> (v7)

--------------------------------------------------
[Discarded]

* nd/precious (2019-04-09) 1 commit
 . Introduce "precious" file concept

 "git clean" learned to pay attention to the 'precious' attributes
 and keep untracked paths with the attribute instead of removing
 when the "--keep-precious" is given.

 Retracted.
 cf. <CACsJy8AEZ-Lz6zgEsuNukvphB9TTa9FAC1gK05fhnie2xtfc9w@mail.gmail.com>

 I am not sure what aspect of this longer-term "precious" vision,
 which gets taught to various commands and use cases individually
 and incrementally, =C3=86var finds problematic, which I understand is
 the reason of redtraction.


* jc/send-email-transferencoding-fix (2019-05-09) 2 commits
 . send-email: honor transferencoding config option again
 . send-email: update the mechanism to set default configuration values

 Replaced by  =C3=86var's "do the default in the right order" approach.
 cf. <20190508105607.178244-1-gitster@pobox.com> (v2)
