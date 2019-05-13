Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F5261F461
	for <e@80x24.org>; Mon, 13 May 2019 16:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfEMQLe (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 12:11:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58080 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbfEMQLd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 12:11:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 132B75AE7E;
        Mon, 13 May 2019 12:11:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=lNXwj/rBYfexFd0kc9DRGBFLr
        sg=; b=iTFJSiEtEL4jBIwV8gg5vWk8v3VjyJH6i5F/Ds87tBIQsi2PimezRos52
        e6lT9pufhS7C0LlKYwVUIzPd0+LARU9pJ7z2z0noUODaQLVUa8IddVYpw2dH34EP
        dXJZa3pY907AQWl/Khn5l5WJOHuR93NzcqwNwV6VMQFEf9PUEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=khdnUKYsY3hRKk+9szO
        CGL2NNbgYiE+wg1e8iUMOOfPFH32pvgt0H6BmD1jzzNrCESCvPAJ6iR/lVnxLtJB
        SkXMhUyjvC2UEntmOyukXhqz86i46N74M8Bmj2cL1CCdCp/BtaieLP6xSH6pxng0
        /lu9sXJ7QbOUHaE+2xhHzqTk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC5FC5AE7C;
        Mon, 13 May 2019 12:11:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C16D25AE7A;
        Mon, 13 May 2019 12:11:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2019, #02; Tue, 14)
X-master-at: ab15ad1a3b4b04a29415aef8c9afa2f64fc194a2
X-next-at: e745c3d227fefd28dbcf0011398e178098d621e4
Date:   Tue, 14 May 2019 01:11:20 +0900
Message-ID: <xmqqa7fqbahj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C04ACECC-7599-11E9-B3E9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

An early preview 2.22-rc0 has been tagged.  Among the topics merged
to 'master' there might be some that are a bit undercooked, but
hopefully we can stabilize them quickly enough.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* cc/access-on-aix-workaround (2019-04-25) 1 commit
  (merged to 'next' on 2019-05-09 at 79b25b1954)
 + git-compat-util: work around for access(X_OK) under root

 Workaround for standard-compliant but less-than-useful behaviour of
 access(2) for the root user.


* dl/no-extern-in-func-decl (2019-05-05) 3 commits
  (merged to 'next' on 2019-05-09 at d165ac4cee)
 + *.[ch]: manually align parameter lists
 + *.[ch]: remove extern from function declarations using sed
 + *.[ch]: remove extern from function declarations using spatch

 Mechanically and systematically drop "extern" from function
 declarlation.


* dl/rev-tilde-doc-clarify (2019-05-08) 4 commits
  (merged to 'next' on 2019-05-09 at 6efd564b11)
 + revisions.txt: remove ambibuity between <rev>:<path> and :<path>
 + revisions.txt: mention <rev>~ form
 + revisions.txt: mark optional rev arguments with []
 + revisions.txt: change "rev" to "<rev>"

 Docfix.


* ew/repack-with-bitmaps-by-default (2019-03-18) 3 commits
  (merged to 'next' on 2019-05-09 at 4f8e8b01c8)
 + pack-objects: default to writing bitmap hash-cache
 + t5310: correctly remove bitmaps for jgit test
 + repack: enable bitmaps by default on bare repos

 The connectivity bitmaps are created by default in bare
 repositories now; also the pathname hash-cache is created by
 default to avoid making crappy deltas when repacking.
 cf. <87a7g2iuem.fsf@evledraar.gmail.com>


* jc/make-dedup-ls-files-output (2019-04-22) 1 commit
  (merged to 'next' on 2019-05-09 at e3d5825003)
 + Makefile: dedup list of files obtained from ls-files

 A "ls-files" that emulates "find" to enumerate files in the working
 tree resulted in duplicated Makefile rules that caused the build to
 issue an unnecessary warning during a trial build after merge
 conflicts are resolved in working tree *.h files but before the
 resolved results are added to the index.  This has been corrected.
 A not-so-low hanging fruit to teach ls-files to dedup either optionally
 or always has also been discussed, which probably is a good idea,
 to prevent mistakes similar to the bug this topic fixes in the future.


* jh/trace2 (2019-05-10) 2 commits
  (merged to 'next' on 2019-05-10 at 8b4b5564af)
 + trace2: fix up a missing "leave" entry point
  (merged to 'next' on 2019-05-09 at e1bba8aeac)
 + trace2: fix incorrect function pointer check

 A few embarrassing bugfixes.


* jh/trace2-sid-fix (2019-05-07) 11 commits
  (merged to 'next' on 2019-05-10 at 71c39675ec)
 + trace2: fixup access problem on /etc/gitconfig in read_very_early_conf=
ig
  (merged to 'next' on 2019-04-25 at a5c08f1226)
 + trace2: update docs to describe system/global config settings
 + trace2: make SIDs more unique
 + trace2: clarify UTC datetime formatting
 + trace2: report peak memory usage of the process
 + trace2: use system/global config for default trace2 settings
 + config: add read_very_early_config()
 + trace2: find exec-dir before trace2 initialization
 + trace2: add absolute elapsed time to start event
 + trace2: refactor setting process starting time
 + config: initialize opts structure in repo_read_config()

 Polishing of the new trace2 facility continues.  The system-level
 configuration can specify site-wide trace2 settings, which can be
 overridden with per-user configuration and environment variables.
 cf. <pull.169.v4.git.gitgitgadget@gmail.com> (v4)


* jk/ls-files-doc-markup-fix (2019-04-23) 1 commit
  (merged to 'next' on 2019-05-09 at a68fe0ae72)
 + doc/ls-files: put nested list for "-t" option into block

 Docfix.


* jk/p5302-avoid-collision-check-cost (2019-04-23) 1 commit
  (merged to 'next' on 2019-05-09 at 8dc92cad96)
 + p5302: create the repo in each index-pack test

 Fix index-pack perf test so that the repeated invocations always
 run in an empty repository, which emulates the initial clone
 situation better.


* jk/perf-aggregate-wo-libjson (2019-04-24) 1 commit
  (merged to 'next' on 2019-05-09 at e697c1993b)
 + t/perf: depend on perl JSON only when using --codespeed

 The script to aggregate perf result unconditionally depended on
 libjson-perl even though it did not have to, which has been
 corrected.


* js/partial-clone-connectivity-check (2019-05-05) 2 commits
  (merged to 'next' on 2019-05-10 at e1d3a6ebde)
 + t/perf: add perf script for partial clones
  (merged to 'next' on 2019-04-25 at ebd8b4bffd)
 + clone: do faster object check for partial clones

 During an initial "git clone --depth=3D..." partial clone, it is
 pointless to spend cycles for a large portion of the connectivity
 check that enumerates and skips promisor objects (which by
 definition is all objects fetched from the other side).  This has
 been optimized out.


* pw/clean-sequencer-state-upon-final-commit (2019-04-17) 2 commits
  (merged to 'next' on 2019-05-09 at cf6cce8ca7)
 + fix cherry-pick/revert status after commit
 + commit/reset: try to clean up sequencer state

 "git chery-pick" (and "revert" that shares the same runtime engine)
 that deals with multiple commits got confused when the final step
 gets stopped with a conflict and the user concluded the sequence
 with "git commit".  Attempt to fix it by cleaning up the state
 files used by these commands in such a situation.


* pw/rebase-i-internal (2019-04-19) 13 commits
  (merged to 'next' on 2019-05-09 at 1206aa6865)
 + rebase -i: run without forking rebase--interactive
 + rebase: use a common action enum
 + rebase -i: use struct rebase_options in do_interactive_rebase()
 + rebase -i: use struct rebase_options to parse args
 + rebase -i: use struct object_id for squash_onto
 + rebase -i: use struct commit when parsing options
 + rebase -i: remove duplication
 + rebase -i: combine rebase--interactive.c with rebase.c
 + rebase: use OPT_RERERE_AUTOUPDATE()
 + rebase: rename write_basic_state()
 + rebase: don't translate trace strings
 + sequencer: always discard index after checkout
 + Merge branch 'ag/sequencer-reduce-rewriting-todo' into pw/rebase-i-int=
ernal
 (this branch is used by pw/rebase-abort-clean-rewritten.)

 The internal implementation of "git rebase -i" has been updated to
 avoid forking a separate "rebase--interactive" process.

--------------------------------------------------
[New Topics]

* cw/diff-highlight (2019-05-09) 1 commit
  (merged to 'next' on 2019-05-13 at 050d707166)
 + diff-highlight: use correct /dev/null for UNIX and Windows

 Portability fix for a diff-highlight tool (in contrib/).

 Will merge to 'master'.


* dl/warn-tagging-a-tag (2019-05-09) 1 commit
  (merged to 'next' on 2019-05-13 at a2f6365923)
 + tag: fix typo in nested tagging hint

 Typofix.

 Will merge to 'master'.


* js/difftool-no-index (2019-05-09) 1 commit
 - difftool --no-index: error out on --dir-diff (and don't crash)

 The "--dir-diff" mode of "git difftool" is not useful in "--no-index"
 mode; they are now explicitly marked as mutually incompatible.

 Will merge to 'next'.


* nd/submodule-helper-incomplete-line-fix (2019-05-08) 1 commit
  (merged to 'next' on 2019-05-13 at cd52f49825)
 + submodule--helper: add a missing \n

 Typofix.

 Will merge to 'master'.


* sb/format-patch-base-patch-id-fix (2019-05-08) 2 commits
 - format-patch: make --base patch-id output stable
 - format-patch: inform user that patch-id generation is unstable

 The recently added "--base" option of "format-patch" computed the
 patch-ids for prerequisite patches in an unstable way, which has
 been updated to compute in a way that is compatible with "git
 patch-id --stable".

 Will merge to 'next'.


* ab/send-email-transferencoding-fix (2019-05-13) 3 commits
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

 Will merge to 'master'.


* ab/trace2-typofix (2019-05-13) 1 commit
  (merged to 'next' on 2019-05-13 at f1229d4d9d)
 + trace2: fix up a missing "leave" entry point

 Typofix.

 Will merge to 'master'.


* dl/format-patch-notes-config (2019-05-13) 2 commits
 - format-patch: teach format.notes config option
 - git-format-patch.txt: document --no-notes option

 "git format-patch" learns a configuration to set the default for
 its --notes=3D<ref> option.

 The interaction between config and option may be a little iffy.
 cf. <xmqqimufdqey.fsf@gitster-ct.c.googlers.com>


* ds/midx-too-many-packs (2019-05-07) 2 commits
 - midx: add packs to packed_git linked list
 - midx: pass a repository pointer

 The code to generate the multi-pack idx file was not prepared to
 see too many packfiles and ran out of open file descriptor, which
 has been corrected.

 Will merge to 'next'.


* ds/trace2-document-env-vars (2019-05-13) 1 commit
 - trace2: add variable description to git.txt

 Doc update.

 Will merge to 'next'.


* es/check-non-portable-pre-5.10 (2019-05-13) 1 commit
 - check-non-portable-shell: support Perl versions older than 5.10

 Developer support update.

 Will merge to 'next'.


* id/windows-dep-aslr (2019-05-13) 2 commits
  (merged to 'next' on 2019-05-13 at 33d57069f8)
 + mingw: enable DEP and ASLR
 + mingw: do not let ld strip relocations

 Allow DEP and ASLR for Windows build to for security hardening.

 Will merge to 'master'.


* jk/unused-params-final-batch (2019-05-13) 14 commits
 - verify-commit: simplify parameters to run_gpg_verify()
 - show-branch: drop unused parameter from show_independent()
 - rev-list: drop unused void pointer from finish_commit()
 - remove_all_fetch_refspecs(): drop unused "remote" parameter
 - receive-pack: drop unused "commands" from prepare_shallow_update()
 - pack-objects: drop unused rev_info parameters
 - name-rev: drop unused parameters from is_better_name()
 - mktree: drop unused length parameter
 - wt-status: drop unused status parameter
 - read-cache: drop unused parameter from threaded load
 - clone: drop dest parameter from copy_alternates()
 - submodule: drop unused prefix parameter from some functions
 - builtin: consistently pass cmd_* prefix to parse_options
 - cmd_{read,write}_tree: rename "unused" variable that is used

 Remove many unused parameters throughout the codebase, with the
 ultimate aim to allow us compile with -Wunused-parameter cleanly.

 Will merge to 'next'.


* js/rebase-i-label-shown-in-status-fix (2019-05-13) 1 commit
 - status: fix display of rebase -ir's `label` command

 "git status" did not know that the "label" instruction in the
 todo-list "rebase -i -r" uses should not be shown as a hex object
 name.

 Will merge to 'next'.


* nd/init-relative-template-fix (2019-05-13) 1 commit
 - init: make --template path relative to $CWD

 A relative pathname given to "git init --template=3D<path> <repo>"
 ought to be relative to the directory "git init" gets invoked in,
 but it instead was made relative to the repository, which has been
 corrected.

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

 Still being discussed.


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


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

 Will merge to 'master'.
 cf. <20190507105434.9600-1-avarab@gmail.com>


* an/ignore-doc-update (2019-05-08) 1 commit
 - gitignore.txt: make slash-rules more readable

 The description about slashes in gitignore patterns (used to
 indicate things like "anchored to this level only" and "only
 matches directories") has been revamped.

 Almost there.
 cf. <20190507104507.18735-1-admin@in-ici.net>


* bl/t4253-exit-code-from-format-patch (2019-05-07) 1 commit
 - t4253-am-keep-cr-dos: avoid using pipes

 Avoid patterns to pipe output from a git command to feed another
 command in tests.

 Will merge to 'next'.


* cm/notes-comment-fix (2019-05-07) 1 commit
 - notes: correct documentation of format_display_notes()

 A stale in-code comment has been updated.

 Will merge to 'next'.


* dl/branch-from-3dot-merge-base (2019-05-07) 2 commits
  (merged to 'next' on 2019-05-13 at 2eb387070e)
 + branch: make create_branch accept a merge base rev
 + t2018: cleanup in current test

 "git branch new A...B" and "git checkout -b new A...B" have been
 taught that in their contexts, the notation A...B means "the merge
 base between these two commits", just like "git checkout A...B"
 detaches HEAD at that commit.

 Will merge to 'master'.
 cf. <cover.1556366347.git.liu.denton@gmail.com>


* ds/cvsexportcommit-force-text (2019-05-07) 1 commit
 - cvsexportcommit: force crlf translation

 "git cvsexportcommit" running on msys did not expect cvsnt showed
 "cvs status" output with CRLF line endings.

 Will merge to 'next'.


* en/fast-export-encoding (2019-05-13) 5 commits
 - fast-export: do automatic reencoding of commit messages only if reques=
ted
 - fast-export: differentiate between explicitly utf-8 and implicitly utf=
-8
 - fast-export: avoid stripping encoding header if we cannot reencode
 - fast-import: support 'encoding' commit header
 - t9350: fix encoding test to actually test reencoding

 The "git fast-export/import" pair has been taught to handle commits
 with log messages in encoding other than UTF-8 better.

 Will merge to 'next'.
 cf. <20190510205335.19968-1-newren@gmail.com>


* jk/apache-lsan (2019-05-08) 1 commit
  (merged to 'next' on 2019-05-13 at 1a055a6df0)
 + t/lib-httpd: pass LSAN_OPTIONS through apache

 Allow tests that involve httpd to be run under leak sanitizer, just
 like we can already do so under address sanitizer.

 Will merge to 'master'.


* jk/cocci-batch (2019-05-08) 2 commits
  (merged to 'next' on 2019-05-13 at 8bbbfd3438)
 + coccicheck: make batch size of 0 mean "unlimited"
 + coccicheck: optionally batch spatch invocations

 Optionally "make coccicheck" can feed multiple source files to
 spatch, gaining performance while spending more memory.

 Will merge to 'master'.


* js/commit-graph-parse-leakfix (2019-05-07) 1 commit
  (merged to 'next' on 2019-05-13 at 18df8ac778)
 + commit-graph: fix memory leak

 Leakfix.

 Will merge to 'master'.


* js/fsmonitor-refresh-after-discarding-index (2019-05-08) 2 commits
 - fsmonitor: force a refresh after the index was discarded
 - fsmonitor: demonstrate that it is not refreshed after discard_index()

 The fsmonitor interface got out of sync after the in-core index
 file gets discarded, which has been corrected.

 Will merge to 'next'.


* js/t5580-unc-alternate-test (2019-05-07) 1 commit
 - t5580: verify that alternates can be UNC paths

 An additional test for MinGW

 Will merge to 'next'.


* js/t6500-use-windows-pid-on-mingw (2019-05-08) 1 commit
  (merged to 'next' on 2019-05-13 at 24e5e27eb7)
 + t6500(mingw): use the Windows PID of the shell

 Future-proof a test against an update to MSYS2 runtime v3.x series.

 Will merge to 'master'.
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

 Will merge to 'master'.


* nd/merge-quit (2019-05-13) 2 commits
 - merge: add --quit
 - merge: remove drop_save() in favor of remove_merge_branch_state()

 "git merge" learned "--quit" option that cleans up the in-progress
 merge while leaving the working tree and the index still in a mess.

 On hold.
 cf. <CACsJy8DTErpeoNHUkCieDafnjc3iwg6QKAp2VP-8tUNYh33tJA@mail.gmail.com>
 Windows seems to have problems with the code, and may need a
 follow-up fixes.


* nd/parse-options-aliases (2019-05-07) 1 commit
  (merged to 'next' on 2019-05-13 at c77cc06452)
 + parse-options: don't emit "ambiguous option" for aliases

 Attempt to use an abbreviated option in "git clone --recurs" is
 responded by a request to disambiguate between --recursive and
 --recurse-submodules, which is bad because these two are synonyms.
 The parse-options API has been extended to define such synonyms
 more easily and not produce an unnecessary failure.

 Will merge to 'master'.


* pw/rebase-abort-clean-rewritten (2019-05-08) 1 commit
 - rebase --abort: cleanup refs/rewritten

 "git rebase --abort" used to leave refs/rewritten/ when concluding
 "git rebase -r", which has been corrected.

 On hold.
 cf. <6726f99a-ec27-b72f-39d7-03eecb555197@gmail.com>


* sg/ci-libsvn-perl (2019-05-07) 1 commit
 - ci: install 'libsvn-perl' instead of 'git-svn'

 To run tests for Git SVN, our scripts for CI used to install the
 git-svn package (in the hope that it would bring in the right
 dependencies).  This has been updated to install the more direct
 dependency, namely, libsvn-perl.

 Will merge to 'next'.


* tt/no-ipv6-fallback-for-winxp (2019-05-07) 1 commit
 - mingw: remove obsolete IPv6-related code

 Code cleanup.

 Will merge to 'next'.


* nb/branch-show-other-worktrees-head (2019-05-07) 3 commits
 - branch: add worktree info on verbose output
 - branch: update output to include worktree info
 - ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.


* en/unicode-in-refnames (2019-04-26) 1 commit
 - Honor core.precomposeUnicode in more places

 On a filesystem like HFS+, the names of the refs stored as filesystem
 entities may become different from what the end-user expects, just
 like files in the working tree get "renamed".  Work around the
 mismatch by paying attention to the core.precomposeUnicode
 configuration.

 Will merge to 'next'.


* dl/difftool-mergetool (2019-05-13) 7 commits
 - difftool: fallback on merge.guitool
 - difftool: make --gui, --tool and --extcmd mutually exclusive
 - mergetool: fallback to tool when guitool unavailable
 - mergetool--lib: create gui_mode function
 - mergetool: use get_merge_tool function
 - t7610: add mergetool --gui tests
 - t7610: unsuppress output

 Update "git difftool" and "git mergetool" so that the combinations
 of {diff,merge}.{tool,guitool} configuration variables serve as
 fallback settings of each other in a sensible order.

 Will merge to 'next'.
 cf. <cover.1556518203.git.liu.denton@gmail.com> (v5)


* es/first-contrib-tutorial (2019-05-08) 2 commits
 - documentation: add anchors to MyFirstContribution
 - documentation: add tutorial for first contribution

 A new tutorial targetting specifically aspiring git-core
 developers.

 I think we are almost there.
 cf. <20190507213040.151799-1-emilyshaffer@google.com> (v5)


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


* nd/worktree-name-sanitization (2019-03-20) 2 commits
 - SQUASH???
 - worktree add: sanitize worktree names

 In recent versions of Git, per-worktree refs are exposed in
 refs/worktrees/<wtname>/ hierarchy, which means that worktree names
 must be a valid refname component.  The code now sanitizes the names
 given to worktrees, to make sure these refs are well-formed.

 I am inclined to squash the fix at the tip in and merge the result
 to 'next'.  Opinions?


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

 Renamed from commit-graph-format-v2 and changed scope.

 Expecting a reroll.
 I think it is almost there, modulo a few internal API details..
 cf. <pull.112.v4.git.gitgitgadget@gmail.com> (v4)
 cf. <17829620-1084-74e5-54ad-aa95990f4dbd@gmail.com>


* br/blame-ignore (2019-04-14) 6 commits
 - blame: use a fingerprint heuristic to match ignored lines
 - blame: optionally track line fingerprints during fill_blame_origin()
 - blame: add config options to handle output for ignored lines
 - blame: add the ability to ignore commits and their changes
 - blame: use a helper function in blame_chunk()
 - Move init_skiplist() outside of fsck

 "git blame" learned to "ignore" commits in the history, whose
 effects (as well as their presence) get ignored.

 Expecting a reroll.
 cf. <20190410162409.117264-1-brho@google.com> (v6)
 cf. <a742dd62-c84e-1f85-0663-4a3aa4d14989@google.com>
 cf. <3db6bad3-e7a5-af1d-3fe2-321bd17db2c6@google.com>

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


* nd/config-move-to (2019-01-14) 7 commits
 . config.h: fix hdr-check warnings
 . config: add --move-to
 . config: factor out set_config_source_file()
 . config: use OPT_FILENAME()
 . config.c: add repo_config_set_worktree_gently()
 . worktree.c: add get_worktree_config()
 . config.c: avoid git_path() in do_git_config_sequence()

 Dropped.
 cf. <CACsJy8DcaxBLCa2vK=3DMfoxkaHS0gDmdUsmamyqE2yOaoG_Esog@mail.gmail.co=
m>


* dm/some-stdio-functions-are-macro-on-freebsd (2019-02-01) 1 commit
 . http: cast result to FILE *

 Variants of BSD define fileno(fh) as a macro, breaking a program
 that passes a "void *" to it.

 Can be safely discarded.
 cf. <CACsJy8BcyD199L4qGv6-TP-8HD+GS+ZDNN5jspkh5uVaWekkoQ@mail.gmail.com>


* hs/send-email-transferencoding-fix (2019-04-10) 1 commit
 . send-email: honor transferencoding config option again

 cf. <xmqq8swi34h5.fsf@gitster-ct.c.googlers.com>
 Replaced by jc/send-email-transferencoding-fix


* jc/send-email-transferencoding-fix (2019-05-09) 2 commits
 . send-email: honor transferencoding config option again
 . send-email: update the mechanism to set default configuration values

 Replaced by  =C3=86var's "do the default in the right order" approach.
 cf. <20190508105607.178244-1-gitster@pobox.com> (v2)


* ds/midx-expire-repack (2019-04-25) 11 commits
 . t5319-multi-pack-index.sh: test batch size zero
 . midx: add test that 'expire' respects .keep files
 . multi-pack-index: test expire while adding packs
 . midx: implement midx_repack()
 . multi-pack-index: prepare 'repack' subcommand
 . multi-pack-index: implement 'expire' subcommand
 . midx: refactor permutation logic and pack sorting
 . midx: simplify computation of pack name lengths
 . multi-pack-index: prepare for 'expire' subcommand
 . Docs: rearrange subcommands for multi-pack-index
 . repack: refactor pack deletion for future use

 "git multi-pack-index expire/repack" are new subcommands that
 consult midx file and are used to drop unused pack files and
 coalesce small pack files that are still in use.

 Tentatively dropped
 cf. <20190424151428.170316-1-dstolee@microsoft.com> (v5)
 cf. <1733843e-f0e4-0e25-468b-64727f6855d5@gmail.com>
