Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73432C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 23:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 531E261465
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 23:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbhJDXqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 19:46:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60242 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhJDXqI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 19:46:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B746514B729;
        Mon,  4 Oct 2021 19:44:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=W
        6PmcS5SuobcuESBfdZuZ5QqpAyimXigcYjlnxF6dNI=; b=ViY42Ps9JxQTto9Rs
        br4sCQnlI3TzoQtZdxKGhlpCEe+9lDkPns9w8KIvB9PkB9jumSbzXXBvhvna2W1A
        rwg4yB1rnFK3xYC8GHoQp+KoSYGcMpxhogtBIJ1RkLhWApbdKsVrS9jgk5XU4E2X
        Kzbm+eT14hKeA2D6tStzdgmDb0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B085E14B727;
        Mon,  4 Oct 2021 19:44:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0D57114B726;
        Mon,  4 Oct 2021 19:44:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2021, #01; Mon, 4)
X-master-at: 0785eb769886ae81e346df10e88bc49ffc0ac64e
X-next-at: a309979bdfa2728e6961a1392c14b7ffd5cb9fa6
Date:   Mon, 04 Oct 2021 16:44:14 -0700
Message-ID: <xmqqo884tkxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC43F810-256C-11EC-A4F0-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen',
which means nothing more than that I have found them of interest for
some reason (like "it may have hard-to-resolve conflicts with
another topic already in flight" or "this may turn out to be
useful").  Do not read too much into a topic being in (or not in)
'seen'.  The ones marked with '.' do not appear in any of the
integration branches, but I am still holding onto them.

Quite a few topics have graduated to 'master' and a handful of
topics are getting readied for 'next'.

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

* ab/auto-depend-with-pedantic (2021-09-22) 1 commit
  (merged to 'next' on 2021-09-28 at 532f2aa26e)
 + Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work with DEVOPTS=pedantic

 Improve build procedure for developers.


* ab/bundle-remove-verbose-option (2021-09-23) 1 commit
  (merged to 'next' on 2021-09-28 at 8251d269a2)
 + bundle: remove ignored & undocumented "--verbose" flag

 Doc update.


* ab/make-clean-depend-dirs (2021-09-22) 1 commit
  (merged to 'next' on 2021-09-28 at 20483ade7d)
 + Makefile: clean .depend dirs under COMPUTE_HEADER_DEPENDENCIES != yes

 "make clean" has been updated to remove leftover .depend/
 directories, even when it is not told to use them to compute header
 dependencies.


* ab/make-compdb-fix (2021-09-27) 1 commit
  (merged to 'next' on 2021-09-29 at b3439753df)
 + Makefile: pass -Wno-pendantic under GENERATE_COMPILATION_DATABASE=yes

 Build update.


* ab/refs-files-cleanup (2021-08-25) 13 commits
  (merged to 'next' on 2021-09-23 at eb5668523f)
 + refs/files: remove unused "errno != ENOTDIR" condition
 + refs/files: remove unused "errno == EISDIR" code
 + refs/files: remove unused "oid" in lock_ref_oid_basic()
 + refs API: remove OID argument to reflog_expire()
 + reflog expire: don't lock reflogs using previously seen OID
 + refs/files: add a comment about refs_reflog_exists() call
 + refs: make repo_dwim_log() accept a NULL oid
 + refs/debug: re-indent argument list for "prepare"
 + refs/files: remove unused "skip" in lock_raw_ref() too
 + refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
 + refs: drop unused "flags" parameter to lock_ref_oid_basic()
 + refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
 + refs/packet: add missing BUG() invocations to reflog callbacks
 (this branch is used by ab/refs-errno-cleanup and hn/refs-errno-cleanup.)

 Continued work on top of the hn/refs-errno-cleanup topic.


* ah/connect-parse-feature-v0-fix (2021-09-27) 1 commit
  (merged to 'next' on 2021-09-29 at 93a45727a2)
 + connect: also update offset for features without values

 Protocol v0 clients can get stuck parsing a malformed feature line.


* bs/difftool-msg-tweak (2021-09-22) 1 commit
  (merged to 'next' on 2021-09-29 at 22d485e560)
 + difftool: fix word spacing in the usage strings

 Message tweak.


* bs/ls-files-opt-help-text-update (2021-09-22) 1 commit
  (merged to 'next' on 2021-09-28 at d27c228644)
 + ls-files: use imperative mood for -X and -z option description

 Help text for "ls-files" options have been updated.


* cb/cvsserver (2021-09-16) 3 commits
  (merged to 'next' on 2021-09-23 at 98f5f3f9cf)
 + Documentation: cleanup git-cvsserver
 + git-cvsserver: protect against NULL in crypt(3)
 + git-cvsserver: use crypt correctly to compare password hashes

 "git cvsserver" had a long-standing bug in its authentication code,
 which has finally been corrected (it is unclear and is a separate
 question if anybody is seriously using it, though).


* da/difftool-dir-diff-symlink-fix (2021-09-23) 1 commit
  (merged to 'next' on 2021-09-28 at e2170ed0d7)
 + difftool: fix symlink-file writing in dir-diff mode
 (this branch is used by da/difftool.)

 "git difftool --dir-diff" mishandled symbolic links.


* ds/perf-test-built-path-fix (2021-09-22) 1 commit
  (merged to 'next' on 2021-09-28 at 18a21483d9)
 + t/perf/run: fix bin-wrappers computation

 Perf test fix.


* en/stash-df-fix (2021-09-10) 3 commits
  (merged to 'next' on 2021-09-20 at 513c11fb11)
 + stash: restore untracked files AFTER restoring tracked files
 + stash: avoid feeding directories to update-index
 + t3903: document a pair of directory/file bugs

 "git stash", where the tentative change involves changing a
 directory to a file (or vice versa), was confused, which has been
 corrected.


* hn/refs-errno-cleanup (2021-08-25) 4 commits
  (merged to 'next' on 2021-09-23 at 502e6b6b08)
 + refs: make errno output explicit for read_raw_ref_fn
 + refs/files-backend: stop setting errno from lock_ref_oid_basic
 + refs: remove EINVAL errno output from specification of read_raw_ref_fn
 + refs file backend: move raceproof_create_file() here
 (this branch is used by ab/refs-errno-cleanup; uses ab/refs-files-cleanup.)

 Futz with the way 'errno' is relied on in the refs API to carry the
 failure modes up the call chain.


* jk/clone-unborn-head-in-bare (2021-09-20) 1 commit
  (merged to 'next' on 2021-09-20 at 93c93b8d51)
 + clone: handle unborn branch in bare repos

 "git clone" from a repository whose HEAD is unborn into a bare
 repository didn't follow the branch name the other side used, which
 is corrected.


* jk/http-redact-fix (2021-09-22) 1 commit
  (merged to 'next' on 2021-09-28 at ef4570a5d1)
 + http: match headers case-insensitively when redacting

 Sensitive data in the HTTP trace were supposed to be redacted, but
 we failed to do so in HTTP/2 requests.


* jx/ci-l10n (2021-09-09) 1 commit
  (merged to 'next' on 2021-09-23 at b2d7f5eecb)
 + ci: new github-action for git-l10n code review

 CI help for l10n.


* rs/close-pack-leakfix (2021-09-24) 1 commit
  (merged to 'next' on 2021-09-28 at b14502faa0)
 + packfile: release bad_objects in close_pack()

 Leakfix.

--------------------------------------------------
[New Topics]

* ab/retire-decl-of-missing-unused-funcs (2021-10-01) 4 commits
  (merged to 'next' on 2021-10-03 at a49287eaa9)
 + config.h: remove unused git_config_get_untracked_cache() declaration
 + log-tree.h: remove unused function declarations
 + grep.h: remove unused grep_threads_ok() declaration
 + builtin.h: remove cmd_tar_tree() declaration

 Remove external declaration of functions that no longer exist.

 Will merge to 'master'.


* pw/fix-some-issues-in-reset-head (2021-10-01) 12 commits
 - rebase -m: don't fork git checkout
 - rebase --apply: set ORIG_HEAD correctly
 - rebase --apply: fix reflog
 - reset_head(): take struct rebase_head_opts
 - rebase: cleanup reset_head() calls
 - reset_head(): make default_reflog_action optional
 - reset_head(): factor out ref updates
 - reset_head(): remove action parameter
 - reset_head(): don't run checkout hook if there is an error
 - reset_head(): fix checkout
 - rebase: factor out checkout for up to date branch
 - Merge branch 'pw/rebase-of-a-tag-fix' into pw/fix-some-issues-in-reset-head
 (this branch uses pw/rebase-of-a-tag-fix.)

 Fix "some issues" in a helper function reset_head().

 Expecting a reroll.
 Needs a lot better explanation, including what the issues are,
 which codepaths the helper is used and to do what, and tests to
 protect the fixes.


* rs/mergesort (2021-10-01) 9 commits
  (merged to 'next' on 2021-10-03 at 29a672574f)
 + mergesort: use ranks stack
 + p0071: test performance of llist_mergesort()
 + p0071: measure sorting of already sorted and reversed files
 + test-mergesort: add unriffle_skewed mode
 + test-mergesort: add unriffle mode
 + test-mergesort: add generate subcommand
 + test-mergesort: add test subcommand
 + test-mergesort: add sort subcommand
 + test-mergesort: use strbuf_getline()

 The mergesort implementation used to sort linked list has been
 optimized.

 Will merge to 'master'.


* bs/doc-blame-color-lines (2021-10-01) 2 commits
 - blame: document --color-* options
 - blame: describe default output format

 The "--color-lines" and "--color-by-age" options of "git blame"
 have been missing, which are now documented.

 Expecting a reroll.
 cf. <CAPig+cSWutBRQK+Qy=nkaDZRvy4trVNPuo+cF-quC2rBwNe2fw@mail.gmail.com>


* mr/bisect-in-c-4 (2021-10-01) 1 commit
 - bisect--helper: add space between colon and following sentence

 Message fix.

 Will merge to 'next'.


* cm/save-restore-terminal (2021-10-04) 2 commits
 - editor: save and reset terminal after calling EDITOR
 - terminal: teach git how to save/restore its terminal settings

 An editor session launched during a Git operation (e.g. during 'git
 commit') can leave the terminal in a funny state.  The code path
 has updated to save the terminal state before, and restore it
 after, it spawns an editor.

 Will merge to 'next'.


* rs/p3400-lose-tac (2021-10-03) 1 commit
 - p3400: stop using tac(1)

 Test portability update.

 Will merge to 'next'.


* ja/doc-status-types-and-copies (2021-10-04) 4 commits
 - Documentation/git-status: mention how to detect copies
 - Documentation/git-status: document porcelain status T (typechange)
 - Documentation/diff-format: state in which cases porcelain status is T
 - Documentation/git-status: remove impossible porcelain status DR and DC

 A few kinds of changes "git status" can show were not described.

 Will merge to 'next'.


* tb/aggregate-ignore-leading-whitespaces (2021-10-04) 1 commit
 - t/perf/aggregate.perl: tolerate leading spaces

 Test portability update.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* ar/submodule-update (2021-09-20) 8 commits
 . submodule--helper: rename helper functions
 . submodule--helper: remove unused helpers
 . submodule--helper: remove update-clone subcommand
 . submodule: move core cmd_update() logic to C
 . submodule--helper: refactor get_submodule_displaypath()
 . submodule--helper: rename helpers for update-clone
 . submodule--helper: get remote names from any repository
 . submodule--helper: split up ensure_core_worktree()

 Rewrite of "git submodule update" in C.

 Kicked out of 'seen' to make room for es/superproject-aware-submodules
 which is among the topics this topic stomps on.

--------------------------------------------------
[Cooking]

* ab/designated-initializers (2021-09-27) 5 commits
  (merged to 'next' on 2021-10-03 at 179f652de6)
 + cbtree.h: define cb_init() in terms of CBTREE_INIT
 + *.h: move some *_INIT to designated initializers
 + *.h _INIT macros: don't specify fields equal to 0
 + *.[ch] *_INIT macros: use { 0 } for a "zero out" idiom
 + submodule-config.h: remove unused SUBMODULE_INIT macro
 (this branch is used by ab/designated-initializers-more.)

 Code clean-up.

 Will merge to 'master'.


* ab/designated-initializers-more (2021-10-01) 6 commits
 - builtin/remote.c: add and use SHOW_INFO_INIT
 - builtin/remote.c: add and use a REF_STATES_INIT
 - urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
 - builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
 - daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
 - Merge branch 'ab/designated-initializers' into ab/designated-initializers-more
 (this branch uses ab/designated-initializers.)

 Code clean-up.

 Will merge to 'next'?


* lh/systemd-timers (2021-09-27) 1 commit
  (merged to 'next' on 2021-10-03 at 81834609ea)
 + maintenance: fix test t7900-maintenance.sh

 Testfix.

 Will merge to 'master'.


* os/status-docfix (2021-09-28) 1 commit
  (merged to 'next' on 2021-10-03 at a13019916a)
 + doc: fix capitalization in "git status --porcelain=v2" description

 Docfix.

 Will merge to 'master'.


* ab/parse-options-cleanup (2021-10-01) 11 commits
 - parse-options: change OPT_{SHORT,UNSET} to an enum
 - parse-options tests: test optname() output
 - parse-options.[ch]: make opt{bug,name}() "static"
 - commit-graph: stop using optname()
 - parse-options.c: move optname() earlier in the file
 - parse-options.h: make the "flags" in "struct option" an enum
 - parse-options.c: use exhaustive "case" arms for "enum parse_opt_type"
 - parse-options.c: use exhaustive "case" arms for "enum parse_opt_result"
 - parse-options.[ch]: consistently use "enum parse_opt_result"
 - parse-options.[ch]: consistently use "enum parse_opt_flags"
 - parse-options.h: move PARSE_OPT_SHELL_EVAL between enums

 Random changes to parse-options implementation.

 Will merge to 'next'?


* ab/retire-git-config-key-is-valid (2021-09-28) 1 commit
  (merged to 'next' on 2021-10-03 at fc7a0a55d1)
 + config.c: remove unused git_config_key_is_valid()

 Code cleanup.

 Will merge to 'master'.


* ab/retire-refs-unused-funcs (2021-09-28) 5 commits
  (merged to 'next' on 2021-10-03 at f91e74fa7d)
 + refs/ref-cache.[ch]: remove "incomplete" from create_dir_entry()
 + refs/ref-cache.c: remove "mkdir" parameter from find_containing_dir()
 + refs/ref-cache.[ch]: remove unused add_ref_entry()
 + refs/ref-cache.[ch]: remove unused remove_entry_from_dir()
 + refs.[ch]: remove unused ref_storage_backend_exists()

 Code cleanup.

 Will merge to 'master'.


* ab/retire-string-list-init (2021-09-28) 1 commit
  (merged to 'next' on 2021-10-03 at 4834949cc3)
 + string-list.[ch]: remove string_list_init() compatibility function

 Code cleanup.

 Will merge to 'master'.


* mt/grep-submodule-textconv (2021-09-29) 1 commit
 - grep: demonstrate bug with textconv attributes and submodules

 "git grep --recurse-submodules" takes trees and blobs from the
 submodule repository, but the textconv settings when processing a
 blob from the submodule is not taken from the submodule repository.
 A demonstration is added to demonstrate the issue, without fixing
 it.

 Will merge to 'next'.


* es/superproject-aware-submodules (2021-08-19) 5 commits
 - fixup! introduce submodule.superprojectGitDir record
 - submodule: record superproject gitdir during 'update'
 - submodule: record superproject gitdir during absorbgitdirs
 - introduce submodule.superprojectGitDir record
 - t7400-submodule-basic: modernize inspect() helper

 A configuration variable in a submodule points at the location of
 the superproject it is bound to (RFC).

 Brought back to 'seen' to see if it still plays well with the rest
 of 'seen', without the conflicting ar/submodule-update topic.


* ab/fsck-unexpected-type (2021-10-01) 17 commits
 - fsck: report invalid object type-path combinations
 - fsck: don't hard die on invalid object types
 - object-file.c: stop dying in parse_loose_header()
 - object-file.c: return ULHR_TOO_LONG on "header too long"
 - object-file.c: use "enum" return type for unpack_loose_header()
 - object-file.c: simplify unpack_loose_short_header()
 - object-file.c: make parse_loose_header_extended() public
 - object-file.c: return -1, not "status" from unpack_loose_header()
 - object-file.c: don't set "typep" when returning non-zero
 - cat-file tests: test for current --allow-unknown-type behavior
 - cat-file tests: add corrupt loose object test
 - cat-file tests: test for missing/bogus object with -t, -s and -p
 - cat-file tests: move bogus_* variable declarations earlier
 - fsck tests: test for garbage appended to a loose object
 - fsck tests: test current hash/type mismatch behavior
 - fsck tests: refactor one test to use a sub-repo
 - fsck tests: add test for fsck-ing an unknown type

 "git fsck" has been taught to report mismatch between expected and
 actual types of an object better.

 Will merge to 'next'?


* ab/config-based-hooks-1 (2021-09-27) 8 commits
 - hook-list.h: add a generated list of hooks, like config-list.h
 - hook.c users: use "hook_exists()" instead of "find_hook()"
 - hook.c: add a hook_exists() wrapper and use it in bugreport.c
 - hook.[ch]: move find_hook() from run-command.c to hook.c
 - Makefile: remove an out-of-date comment
 - Makefile: don't perform "mv $@+ $@" dance for $(GENERATED_H)
 - Makefile: stop hardcoding {command,config}-list.h
 - Makefile: mark "check" target as .PHONY

 Mostly preliminary clean-up in the hook API.

 Will merge to 'next'.


* ab/http-pinned-public-key-mismatch (2021-09-27) 1 commit
  (merged to 'next' on 2021-10-03 at cd67328eed)
 + http: check CURLE_SSL_PINNEDPUBKEYNOTMATCH when emitting errors

 HTTPS error handling updates.

 Will merge to 'master'.


* jk/ref-paranoia (2021-09-27) 16 commits
  (merged to 'next' on 2021-10-03 at 8c2cb6a3a6)
 + refs: drop "broken" flag from for_each_fullref_in()
 + ref-filter: drop broken-ref code entirely
 + ref-filter: stop setting FILTER_REFS_INCLUDE_BROKEN
 + repack, prune: drop GIT_REF_PARANOIA settings
 + refs: turn on GIT_REF_PARANOIA by default
 + refs: omit dangling symrefs when using GIT_REF_PARANOIA
 + refs: add DO_FOR_EACH_OMIT_DANGLING_SYMREFS flag
 + refs-internal.h: reorganize DO_FOR_EACH_* flag documentation
 + refs-internal.h: move DO_FOR_EACH_* flags next to each other
 + t5312: be more assertive about command failure
 + t5312: test non-destructive repack
 + t5312: create bogus ref as necessary
 + t5312: drop "verbose" helper
 + t5600: provide detached HEAD for corruption failures
 + t5516: don't use HEAD ref for invalid ref-deletion tests
 + t7900: clean up some more broken refs
 (this branch is used by jt/no-abuse-alternate-odb-for-submodules.)

 The ref iteration code used to optionally allow dangling refs to be
 shown, which has been tightened up.

 Will merge to 'master'.


* pw/rebase-reread-todo-after-editing (2021-09-24) 2 commits
  (merged to 'next' on 2021-09-28 at c67d5e383e)
 + rebase: fix todo-list rereading
 + sequencer.c: factor out a function

 The code to re-read the edited todo list in "git rebase -i" was
 made more robust.

 Will merge to 'master'.


* gc/doc-first-contribution-reroll (2021-09-22) 1 commit
  (merged to 'next' on 2021-09-29 at b7dea55eae)
 + MyFirstContribution: Document --range-diff option when writing v2

 Doc update.

 Will merge to 'master'.


* jk/grep-haystack-is-read-only (2021-09-22) 5 commits
  (merged to 'next' on 2021-09-28 at 1660a6be89)
 + grep: store grep_source buffer as const
 + grep: mark "haystack" buffers as const
 + grep: stop modifying buffer in grep_source_1()
 + grep: stop modifying buffer in show_line()
 + grep: stop modifying buffer in strip_timestamp
 (this branch is used by hm/paint-hits-in-log-grep.)

 Code clean-up in the "grep" machinery.

 Will merge to 'master'.


* js/win-lazyload-buildfix (2021-09-28) 3 commits
  (merged to 'next' on 2021-10-03 at 26802e5d73)
 + Makefile: restrict -Wpedantic and -Wno-pedantic-ms-format better
 + lazyload.h: use an even more generic function pointer than FARPROC
 + lazyload.h: fix warnings about mismatching function pointer types

 Compilation fix.

 Will merge to 'master'.


* ab/make-sparse-for-real (2021-09-22) 1 commit
 - Makefile: make the "sparse" target non-.PHONY

 Prevent "make sparse" from running for the source files that
 haven't been modified.

 Will merge to 'next'?


* ew/midx-doc-update (2021-09-24) 1 commit
  (merged to 'next' on 2021-09-28 at f2cbe598eb)
 + doc/technical: update note about core.multiPackIndex

 Doc tweak.

 Will merge to 'master'.


* jt/no-abuse-alternate-odb-for-submodules (2021-10-01) 10 commits
 - fixup! refs: plumb repo into ref stores
 - submodule: trace adding submodule ODB as alternate
 - submodule: pass repo to check_has_commit()
 - object-file: only register submodule ODB if needed
 - merge-{ort,recursive}: remove add_submodule_odb()
 - refs: peeling non-the_repository iterators is BUG
 - refs: teach arbitrary repo support to iterators
 - refs: plumb repo into ref stores
 - Merge branch 'jk/ref-paranoia' into jt/no-abuse-alternate-odb-for-submodules
 - Merge branch 'jt/add-submodule-odb-clean-up' into jt/no-abuse-alternate-odb-for-submodules
 (this branch uses jk/ref-paranoia and jt/add-submodule-odb-clean-up.)

 Follow through the work to use the repo interface to access
 submodule objects in-process, instead of abusing the alternate
 object database interface.


* tp/send-email-completion (2021-09-22) 3 commits
 - send-email docs: add format-patch options
 - send-email: move bash completions to core script
 - send-email: terminate --git-completion-helper with LF

 The command line complation for "git send-email" options have been
 tweaked to make it easier to keep it in sync with the command itself.

 Stalled.
 cf. <YU6+BWC+xvGJP3b0@carlos-mbp.lan>


* hm/paint-hits-in-log-grep (2021-09-29) 3 commits
 - pretty: colorize pattern matches in commit messages
 - grep: refactor next_match() and match_one_pattern() for external use
 - Merge branch 'jk/grep-haystack-is-read-only' into hm/paint-hits-in-log-grep
 (this branch uses jk/grep-haystack-is-read-only.)

 "git log --grep=string --author=name" learns to highlight hits just
 like "git grep string" does.

 Will merge to 'next'?


* ab/repo-settings-cleanup (2021-09-22) 5 commits
  (merged to 'next' on 2021-09-28 at 43d70c31e1)
 + repository.h: don't use a mix of int and bitfields
 + repo-settings.c: simplify the setup
 + read-cache & fetch-negotiator: check "enum" values in switch()
 + environment.c: remove test-specific "ignore_untracked..." variable
 + wrapper.c: add x{un,}setenv(), and use xsetenv() in environment.c

 Code cleanup.

 Will merge to 'master'.


* da/difftool (2021-09-30) 6 commits
  (merged to 'next' on 2021-10-03 at 3ba0335e4e)
 + difftool: add a missing space to the run_dir_diff() comments
 + difftool: remove an unnecessary call to strbuf_release()
 + difftool: refactor dir-diff to write files using helper functions
 + difftool: create a tmpdir path without repeated slashes
 + Merge branch 'da/difftool-dir-diff-symlink-fix' into da/difftool
 + Merge branch 'ab/retire-option-argument' into da/difftool

 Code clean-up in "git difftool".

 Will merge to 'master'.


* en/removing-untracked-fixes (2021-09-27) 12 commits
 - Documentation: call out commands that nuke untracked files/directories
 - Comment important codepaths regarding nuking untracked files/dirs
 - unpack-trees: avoid nuking untracked dir in way of locally deleted file
 - unpack-trees: avoid nuking untracked dir in way of unmerged file
 - Change unpack_trees' 'reset' flag into an enum
 - Remove ignored files by default when they are in the way
 - unpack-trees: make dir an internal-only struct
 - unpack-trees: introduce preserve_ignored to unpack_trees_options
 - read-tree, merge-recursive: overwrite ignored files by default
 - checkout, read-tree: fix leak of unpack_trees_options.dir
 - t2500: add various tests for nuking untracked files
 - Merge branch 'en/am-abort-fix' into en/removing-untracked-fixes

 Various fixes in code paths that move untracked files away to make room.

 Will merge to 'next'.


* ks/submodule-add-message-fix (2021-09-20) 1 commit
 - submodule--helper: fix incorrect newlines in an error message

 Message regression fix.

 Waiting for a response.
 cf. <m27df9lvm1.fsf@gmail.com>


* tb/commit-graph-usage-fix (2021-09-22) 2 commits
  (merged to 'next' on 2021-09-28 at f021339c39)
 + builtin/multi-pack-index.c: disable top-level --[no-]progress
 + builtin/commit-graph.c: don't accept common --[no-]progress

 Regression in "git commit-graph" command line parsing has been
 corrected.

 Will merge to 'master'.


* ws/refer-to-forkpoint-config-in-rebase-doc (2021-09-20) 1 commit
  (merged to 'next' on 2021-09-29 at 49181eaafb)
 + Document `rebase.forkpoint` in rebase man page

 Doc update.

 Will merge to 'master'.


* ns/batched-fsync (2021-10-04) 9 commits
 . core.fsyncobjectfiles: performance tests for add and stash
 . core.fsyncobjectfiles: tests for batch mode
 . unpack-objects: use the bulk-checkin infrastructure
 . update-index: use the bulk-checkin infrastructure
 . core.fsyncobjectfiles: add windows support for batch mode
 . core.fsyncobjectfiles: batched disk flushes
 . bulk-checkin: rename 'state' variable and separate 'plugged' boolean
 . tmp-objdir: disable ref updates when replacing the primary odb
 . tmp-objdir: new API for creating temporary writable databases

 The "core.fsyncobjectfiles" configuration variable can now be set
 to "batch" for improved performance.

 Under discussion.

 Handling of temporary object directory is worked out with the
 en/remerge-diff topic.


* jh/builtin-fsmonitor-part1 (2021-09-20) 7 commits
 - t/helper/simple-ipc: convert test-simple-ipc to use start_bg_command
 - run-command: create start_bg_command
 - simple-ipc/ipc-win32: add Windows ACL to named pipe
 - simple-ipc/ipc-win32: add trace2 debugging
 - simple-ipc: move definition of ipc_active_state outside of ifdef
 - simple-ipc: preparations for supporting binary messages.
 - trace2: add trace2_child_ready() to report on background children

 Built-in fsmonitor (part 1).

 Will merge to 'next'.


* ab/align-parse-options-help (2021-09-22) 4 commits
 - parse-options: properly align continued usage output
 - git rev-parse --parseopt tests: add more usagestr tests
 - send-pack: properly use parse_options() API for usage string
 - parse-options API users: align usage output in C-strings

 When "git cmd -h" shows more than one line of usage text (e.g.
 the cmd subcommand may take sub-sub-command), parse-options API
 learned to align these lines, even across i18n/l10n.

 Will merge to 'next'?


* ab/help-config-vars (2021-09-23) 9 commits
 - help: move column config discovery to help.c library
 - help / completion: make "git help" do the hard work
 - help tests: test --config-for-completion option & output
 - help: simplify by moving to OPT_CMDMODE()
 - help: correct logic error in combining --all and --guides
 - help: correct logic error in combining --all and --config
 - help tests: add test for --config output
 - help: correct usage & behavior of "git help --guides"
 - help: correct the usage string in -h and documentation

 Teach "git help -c" into helping the command line completion of
 configuration variables.

 Will merge to 'next'?


* tb/repack-write-midx (2021-10-01) 9 commits
 - builtin/repack.c: pass `--refs-snapshot` when writing bitmaps
 - builtin/repack.c: make largest pack preferred
 - builtin/repack.c: support writing a MIDX while repacking
 - builtin/repack.c: extract showing progress to a variable
 - builtin/repack.c: rename variables that deal with non-kept packs
 - builtin/repack.c: keep track of existing packs unconditionally
 - midx: preliminary support for `--refs-snapshot`
 - builtin/multi-pack-index.c: support `--stdin-packs` mode
 - midx: expose `write_midx_file_only()` publicly

 "git repack" has been taught to generate multi-pack reachability
 bitmaps.

 Will merge to 'next'?


* ds/add-rm-with-sparse-index (2021-09-28) 13 commits
 - advice: update message to suggest '--sparse'
 - mv: refuse to move sparse paths
 - rm: skip sparse paths with missing SKIP_WORKTREE
 - rm: add --sparse option
 - add: update --renormalize to skip sparse paths
 - add: update --chmod to skip sparse paths
 - add: implement the --sparse option
 - add: skip tracked paths outside sparse-checkout cone
 - add: fail when adding an untracked sparse file
 - dir: fix pattern matching on dirs
 - dir: select directories correctly
 - t1092: behavior for adding sparse files
 - t3705: test that 'sparse_entry' is unstaged

 "git add", "git mv", and "git rm" have been adjusted to avoid
 updating paths outside of the sparse-checkout definition unless
 the user specifies a "--sparse" option.

 Will merge to 'next'.


* tb/midx-write-propagate-namehash (2021-09-17) 7 commits
  (merged to 'next' on 2021-09-29 at 24732fcfc8)
 + t5326: test propagating hashcache values
 + p5326: generate pack bitmaps before writing the MIDX bitmap
 + p5326: don't set core.multiPackIndex unnecessarily
 + p5326: create missing 'perf-tag' tag
 + midx.c: respect 'pack.writeBitmapHashcache' when writing bitmaps
 + pack-bitmap.c: propagate namehash values from existing bitmaps
 + t/helper/test-bitmap.c: add 'dump-hashes' mode

 "git multi-pack-index write --bitmap" learns to propagate the
 hashcache from original bitmap to resulting bitmap.

 Will merge to 'master'.


* pw/rebase-of-a-tag-fix (2021-09-22) 10 commits
  (merged to 'next' on 2021-09-28 at 980add2a67)
 + rebase: dereference tags
 + rebase: use lookup_commit_reference_by_name()
 + rebase: use our standard error return value
 + t3407: rework rebase --quit tests
 + t3407: strengthen rebase --abort tests
 + t3407: use test_path_is_missing
 + t3407: rename a variable
 + t3407: use test_cmp_rev
 + t3407: use test_commit
 + t3407: run tests in $TEST_DIRECTORY
 (this branch is used by pw/fix-some-issues-in-reset-head.)

 "git rebase <upstream> <tag>" failed when aborted in the middle, as
 it mistakenly tried to write the tag object instead of peeling it
 to HEAD.

 Will merge to 'master'.


* en/zdiff3 (2021-09-20) 2 commits
 - update documentation for new zdiff3 conflictStyle
 - xdiff: implement a zealous diff3, or "zdiff3"

 "Zealous diff3" style of merge conflict presentation has been added.


* jt/add-submodule-odb-clean-up (2021-09-09) 3 commits
  (merged to 'next' on 2021-09-28 at 4d843448be)
 + revision: remove "submodule" from opt struct
 + repository: support unabsorbed in repo_submodule_init
 + submodule: remove unnecessary unabsorbed fallback
 (this branch is used by jt/no-abuse-alternate-odb-for-submodules.)

 More code paths that use the hack to add submodule's object
 database to the set of alternate object store have been cleaned up.

 Will merge to 'master'.


* js/scalar (2021-09-14) 15 commits
 - scalar: accept -C and -c options before the subcommand
 - scalar: implement the `version` command
 - scalar: implement the `delete` command
 - scalar: teach 'reconfigure' to optionally handle all registered enlistments
 - scalar: allow reconfiguring an existing enlistment
 - scalar: implement the `run` command
 - scalar: teach 'clone' to support the --single-branch option
 - scalar: implement the `clone` subcommand
 - scalar: implement 'scalar list'
 - scalar: let 'unregister' handle a deleted enlistment directory gracefully
 - scalar: 'unregister' stops background maintenance
 - scalar: 'register' sets recommended config and starts maintenance
 - scalar: create test infrastructure
 - scalar: start documenting the command
 - scalar: create a rudimentary executable

 Add pieces from "scalar" to contrib/.

 Waiting for a response.
 cf. <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>


* ab/sanitize-leak-ci (2021-09-23) 2 commits
  (merged to 'next' on 2021-10-03 at dcd62a3fc6)
 + tests: add a test mode for SANITIZE=leak, run it in CI
 + Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS

 CI learns to run the leak sanitizer builds.

 Will merge to 'master'.


* ms/customizable-ident-expansion (2021-09-01) 1 commit
 - keyword expansion: make "$Id$" string configurable

 Instead of "$Id$", user-specified string (like $FreeBSD$) can be
 used as an in-blob placeholder for keyword expansion.


* js/retire-preserve-merges (2021-09-07) 11 commits
  (merged to 'next' on 2021-09-10 at f645ffd7a3)
 + sequencer: restrict scope of a formerly public function
 + rebase: remove a no-longer-used function
 + rebase: stop mentioning the -p option in comments
 + rebase: remove obsolete code comment
 + rebase: drop the internal `rebase--interactive` command
 + git-svn: drop support for `--preserve-merges`
 + rebase: drop support for `--preserve-merges`
 + pull: remove support for `--rebase=preserve`
 + tests: stop testing `git rebase --preserve-merges`
 + remote: warn about unhandled branch.<name>.rebase values
 + t5520: do not use `pull.rebase=preserve`

 The "--preserve-merges" option of "git rebase" has been removed.

 Will cook in 'next'.


* en/remerge-diff (2021-08-31) 7 commits
 - doc/diff-options: explain the new --remerge-diff option
 - show, log: provide a --remerge-diff capability
 - tmp-objdir: new API for creating and removing primary object dirs
 - merge-ort: capture and print ll-merge warnings in our preferred fashion
 - ll-merge: add API for capturing warnings in a strbuf instead of stderr
 - merge-ort: add ability to record conflict messages in a file
 - merge-ort: mark a few more conflict messages as omittable

 A new presentation for two-parent merge "--remerge-diff" can be
 used to show the difference between mechanical (and possibly
 conflicted) merge results and the recorded resolution.

 Expecting a reroll.

 Handling of temporary object directory is worked out with the
 ns/batched-fsync topic.


* sg/test-split-index-fix (2021-09-07) 7 commits
  (merged to 'next' on 2021-09-29 at 661ae75778)
 + read-cache: fix GIT_TEST_SPLIT_INDEX
 + tests: disable GIT_TEST_SPLIT_INDEX for sparse index tests
 + read-cache: look for shared index files next to the index, too
 + t1600-index: disable GIT_TEST_SPLIT_INDEX
 + t1600-index: don't run git commands upstream of a pipe
 + t1600-index: remove unnecessary redirection
 + Merge branch 'ds/sparse-index-ignored-files' into sg/test-split-index-fix

 Test updates.

 Will merge to 'master'.


* ab/refs-errno-cleanup (2021-08-25) 4 commits
 - refs: make errno output explicit for refs_resolve_ref_unsafe
 - refs: explicitly return failure_errno from parse_loose_ref_contents
 - branch tests: test for errno propagating on failing read
 - refs: add failure_errno to refs_read_raw_ref() signature

 The "remainder" of hn/refs-errno-cleanup topic.

 What's the status of this one?  Meh?


* ab/lib-subtest (2021-09-22) 9 commits
 - test-lib tests: get rid of copy/pasted mock test code
 - test-lib tests: assert 1 exit code, not non-zero
 - test-lib tests: refactor common part of check_sub_test_lib_test*()
 - test-lib tests: avoid subshell for "test_cmp" for readability
 - test-lib tests: don't provide a description for the sub-tests
 - test-lib tests: split up "write and run" into two functions
 - test-lib tests: move "run_sub_test" to a new lib-subtest.sh
 - Merge branch 'ps/t0000-output-directory-fix' into ab/lib-subtest
 - Merge branch 'jk/t0000-subtests-fix' into ab/lib-subtest

 Updates to the tests in t0000 to test the test framework.

 Will merge to 'next'.


* ab/only-single-progress-at-once (2021-09-22) 8 commits
 - progress.c: add & assert a "global_progress" variable
 - pack-bitmap-write.c: add a missing stop_progress()
 - progress.c: add temporary variable from progress struct
 - progress.c: stop eagerly fflush(stderr) when not a terminal
 - progress.c: call progress_interval() from progress_test_force_update()
 - progress.c: move signal handler functions lower
 - progress.c tests: test some invalid usage
 - progress.c tests: make start/stop verbs on stdin

 Further tweaks on progress API.


* fs/ssh-signing (2021-09-10) 9 commits
 - ssh signing: test that gpg fails for unknown keys
 - ssh signing: tests for logs, tags & push certs
 - ssh signing: duplicate t7510 tests for commits
 - ssh signing: verify signatures using ssh-keygen
 - ssh signing: provide a textual signing_key_id
 - ssh signing: retrieve a default key from ssh-agent
 - ssh signing: add ssh key format and signing code
 - ssh signing: add test prereqs
 - ssh signing: preliminary refactoring and clean-up

 Use ssh public crypto for object and push-cert signing.

 Will merge to 'next'?


* cf/fetch-set-upstream-while-detached (2021-07-06) 1 commit
 - fetch: fix segfault on --set-upstream while on a detached HEAD

 "git fetch --set-upstream" while on detached HEAD segfaulted
 instead of noticing that such an operation did not make sense.

 Expecting a reroll.
 cf. <xmqqsg0ri5mq.fsf@gitster.g>


* pw/diff-color-moved-fix (2021-08-05) 13 commits
 - diff: drop unused options parameter from cmp_in_block_with_wsd()
 - diff --color-moved: intern strings
 - diff: use designated initializers for emitted_diff_symbol
 - diff --color-moved-ws=allow-indentation-change: improve hash lookups
 - diff --color-moved: stop clearing potential moved blocks
 - diff --color-moved: shrink potential moved blocks as we go
 - diff --color-moved: unify moved block growth functions
 - diff --color-moved: call comparison function directly
 - diff --color-moved-ws=allow-indentation-change: simplify and optimize
 - diff: simplify allow-indentation-change delta calculation
 - diff --color-moved: avoid false short line matches and bad zerba coloring
 - diff --color-moved=zebra: fix alternate coloring
 - diff --color-moved: add perf tests

 Originally merged to 'next' on 2021-08-05

 Long-overdue correctness and performance update to "diff
 --color-moved" feature.

 Expecting a reroll.
 cf. <8bec1a6d-5052-50c3-4100-e6348289d581@gmail.com>


* hn/reftable (2021-10-01) 24 commits
 - reftable: avoid non portable compile time pointer to function
 - config.mak.uname: last release and snapshots of Minix still use zlib 1.2.3
 - fixup! reftable: implement stack, a mutable database of reftable files.
 - fixup! reftable: add a heap-based priority queue for reftable records
 - squash! reftable: reading/writing blocks
 - Add "test-tool dump-reftable" command.
 - reftable: add dump utility
 - reftable: implement stack, a mutable database of reftable files.
 - reftable: implement refname validation
 - reftable: add merged table view
 - reftable: add a heap-based priority queue for reftable records
 - reftable: reftable file level tests
 - reftable: read reftable files
 - reftable: generic interface to tables
 - reftable: write reftable files
 - reftable: a generic binary tree implementation
 - reftable: reading/writing blocks
 - Provide zlib's uncompress2 from compat/zlib-compat.c
 - reftable: (de)serialization for the polymorphic record type.
 - reftable: add blocksource, an abstraction for random access reads
 - reftable: utility functions
 - reftable: add error related functionality
 - reftable: RFC: add LICENSE
 - hash.h: provide constants for the hash IDs

 The "reftable" backend for the refs API, without integrating into
 the refs subsystem.

 Expecting a reroll.

--------------------------------------------------
[Discarded]

* ao/p4-avoid-decoding (2021-04-12) 2 commits
 . git-p4: do not decode data from perforce by default
 . git-p4: avoid decoding more data from perforce

 "git p4" in Python-2 days used to accept a lot more kinds of data
 from Perforce server as uninterrupted byte sequence, but after
 switching to Python-3, too many things are expected to be in UTF-8,
 which broke traditional use cases.

 Have been stalled for too long.
 cf. <20210504220153.1d9f0cb2@ado-tr>


* tv/p4-fallback-encoding (2021-04-30) 1 commit
 . git-p4: git-p4.fallbackEncoding to specify non UTF-8 charset

 "git p4" learns the fallbackEncoding configuration variable to
 safely accept changeset descriptions that aren't written in UTF-8.

 Have been stalled for too long.
 cf. <CAKu1iLUaLuAZWqjNK4tfhhR=YaSt4MdQ+90ZY-JcEh_SeHyYCw@mail.gmail.com>


* jh/builtin-fsmonitor (2021-09-03) 37 commits
 . fixup! fsmonitor--daemon: implement handle_client callback
 . SQUASH??? https://github.com/git/git/runs/3438543601?check_suite_focus=true#step:5:136
 . BANDAID: sparse fixes
 . t7527: test FS event reporing on MacOS WRT case and Unicode
 . fsmonitor: handle shortname for .git
 . t7527: test status with untracked-cache and fsmonitor--daemon
 . fsmonitor: force update index after large responses
 . fsmonitor: enhance existing comments
 . fsmonitor--daemon: use a cookie file to sync with file system
 . fsmonitor--daemon: periodically truncate list of modified files
 . t7527: create test for fsmonitor--daemon
 . t/perf/p7519: add fsmonitor--daemon test cases
 . t/perf: avoid copying builtin fsmonitor files into test repo
 . t/perf/p7519: speed up test using "test-tool touch"
 . t/helper/test-touch: add helper to touch a series of files
 . fsmonitor--daemon: implement handle_client callback
 . fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
 . fsmonitor-fs-listen-macos: add macos header files for FSEvent
 . fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
 . fsmonitor--daemon: create token-based changed path cache
 . fsmonitor--daemon: define token-ids
 . fsmonitor--daemon: add pathname classification
 . fsmonitor: do not try to operate on bare repos
 . fsmonitor--daemon: implement 'start' command
 . fsmonitor--daemon: implement 'run' command
 . fsmonitor-fs-listen-macos: stub in backend for MacOS
 . fsmonitor-fs-listen-win32: stub in backend for Windows
 . t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
 . fsmonitor--daemon: implement 'stop' and 'status' commands
 . fsmonitor--daemon: add a built-in fsmonitor daemon
 . fsmonitor: use IPC to query the builtin FSMonitor daemon
 . fsmonitor: config settings are repository-specific
 . help: include fsmonitor--daemon feature flag in version info
 . fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 . fsmonitor--daemon: update fsmonitor documentation
 . fsmonitor--daemon: man page
 . simple-ipc: preparations for supporting binary messages.

 An attempt to write and ship with a watchman equivalent tailored
 for our use.

 Will be rerolled in pieces.


* ab/config-based-hooks-base (2021-09-09) 36 commits
 . hooks: fix a TOCTOU in "did we run a hook?" heuristic
 . receive-pack: convert receive hooks to hook.h
 . post-update: use hook.h library
 . receive-pack: convert 'update' hook to hook.h
 . hooks: allow callers to capture output
 . run-command: allow capturing of collated output
 . reference-transaction: use hook.h to run hooks
 . hook tests: use a modern style for "pre-push" tests
 . hook tests: test for exact "pre-push" hook input
 . transport: convert pre-push hook to hook.h
 . hook: convert 'post-rewrite' hook in sequencer.c to hook.h
 . hook: provide stdin by string_list or callback
 . run-command: add stdin callback for parallelization
 . am: convert 'post-rewrite' hook to hook.h
 . hook: support passing stdin to hooks
 . run-command: allow stdin for run_processes_parallel
 . run-command: remove old run_hook_{le,ve}() hook API
 . receive-pack: convert push-to-checkout hook to hook.h
 . read-cache: convert post-index-change to use hook.h
 . commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
 . git-p4: use 'git hook' to run hooks
 . send-email: use 'git hook run' for 'sendemail-validate'
 . git hook run: add an --ignore-missing flag
 . merge: convert post-merge to use hook.h
 . hooks: convert 'post-checkout' hook to hook library
 . am: convert applypatch to use hook.h
 . rebase: convert pre-rebase to use hook.h
 . gc: use hook library for pre-auto-gc hook
 . hook: add 'run' subcommand
 . hook-list.h: add a generated list of hooks, like config-list.h
 . hook.c users: use "hook_exists()" instead of "find_hook()"
 . hook.c: add a hook_exists() wrapper and use it in bugreport.c
 . hook.[ch]: move find_hook() from run-command.c to hook.c
 . Makefile: remove an out-of-date comment
 . Makefile: stop hardcoding {command,config}-list.h
 . Makefile: mark "check" target as .PHONY
 (this branch is used by es/config-based-hooks.)

 Restructuring of (a subset of) Emily's config-based-hooks series,
 to demonstrate that a series can be presented as a more logical and
 focused progression.

 Will be rerolled in pieces.


* es/config-based-hooks (2021-09-09) 6 commits
 . hook: allow out-of-repo 'git hook' invocations
 . hook: include hooks from the config
 . hook: introduce "git hook list"
 . hook: allow parallel hook execution
 . fixup! hook: run a list of hooks instead
 . hook: run a list of hooks instead
 (this branch uses ab/config-based-hooks-base.)

 Revamp the hooks subsystem to allow multiple of them to trigger
 upon the same event and control via the configuration variables.


* cb/make-compdb-fix (2021-09-22) 1 commit
 . Makefile: avoid breaking compilation database generation with DEVELOPER

 Adjust to recent change to use -pedantic for developer builds.

 Replaced by the ab/make-compdb-fix topic that uses the same
 approach as the ab/auto-depend-with-pedantic topic.


* ab/pack-objects-stdin (2021-07-09) 5 commits
 . pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
 . pack-objects.c: do stdin parsing via revision.c's API
 . revision.[ch]: add a "handle_stdin_line" API
 . revision.h: refactor "disable_stdin" and "read_from_stdin"
 . upload-pack: run is_repository_shallow() before setup_revisions()

 Introduce handle_stdin_line callback to revision API and uses it.

 Retracted for now.


* ah/unleak-revisions (2021-09-20) 2 commits
 . log: UNLEAK original pending objects
 . log: UNLEAK rev to silence a large number of leaks

 Mark a few structures with UNLEAK() to help leak detection CI jobs.

 Retracted.
 cf. <05754f9c-cd58-30f5-e2d3-58b9221d2770@ahunt.org>


* rs/p5311-use-test-file-size (2021-10-03) 1 commit
 . p5311: handle spaces in wc(1) output

 Test portability update.

 The tb/aggregate-ignore-leading-whitespaces supersedes this topic.


