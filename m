Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C19BC433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 01:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384028AbhLDBk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 20:40:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54150 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354316AbhLDBkz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 20:40:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C424166F61;
        Fri,  3 Dec 2021 20:37:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=zxfiaj7AS6P1NZJ6O5o8aAlMY
        JfRXyWUo5m89EFjt8k=; b=WL+u+oLh4WNuM8EP1J+hBh3EElzspVKXJfGeuH56b
        1DRn35+gB7a0JJnp+yHyHUSpzQPQdJrWSYI/QdmOyB62nyBGbJ/ZQZGnH7QnsyHQ
        bvUtR8I5UxJ/ZM22Z8qKwO2Y4gsMcNc1ULDVm0uEj+dqdDUul8uhxEB3lfncMS7s
        MY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 74DEC166F60;
        Fri,  3 Dec 2021 20:37:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6ECE6166F5D;
        Fri,  3 Dec 2021 20:37:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2021, #01; Fri, 3)
X-master-at: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
X-next-at: a8338297339b1ab064e799c15c4fc56c122ef967
Date:   Fri, 03 Dec 2021 17:37:23 -0800
Message-ID: <xmqqh7bpqhf0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BC722FB2-54A2-11EC-BD95-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is probably the first issue of the "What's cooking" report, in
which all topics have some sort of description.

That's a small achievement, at least for me.

Even better, each and every topic is annotated with some sort of
verdict (like "Will discard", "Expecting a reroll", "Will merge to
'next'?" etc.).  There is no topic in the "Undecided" category when
this report is fed to "cook -w" script (found in the 'todo' branch).

A handful of topics are added to 'next', and we have about 40 topics
cooking there.  For them, the future is automated---they spend about
a week in 'next', and if we find issues in them, we incrementally
improve them, or get merged to 'master'.

Then we have about a dozen topics that are marked for 'next' (please
raise your hand if you have objection before a real damage is done),
and 8 more that may be ready for 'next' (please raise your hand if
you want to nudge them in either direction, for or against).







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

A few topics for regression fixes have been merged to 'next' and
will be merged to 'master' shortly.  There are many topics listed as
"New" that are in 'seen', but I haven't read many of them (and I
shouldn't have anyway, before dealing with regression fixes) and
haven't gave any summary comments in this report, either, yet.

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
[New Topics]

* ab/cat-file (2021-11-29) 10 commits
 - cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)
 - object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
 - cat-file: correct and improve usage information
 - cat-file: fix remaining usage bugs
 - cat-file: make --batch-all-objects a CMDMODE
 - cat-file: move "usage" variable to cmd_cat_file()
 - cat-file docs: fix SYNOPSIS and "-h" output
 - parse-options API: add a usage_msg_optf()
 - cat-file tests: test messaging on bad objects/paths
 - cat-file tests: test bad usage

 Assorted updates to "git cat-file", especially "-h".

 Needs review.
 Even though this is at its third round, there wasn't any meaningful
 reviews other than typofixes in the earliest round, which may or
 may not be still relevant.  The last round needs a serious review
 before becoming eligible for 'next'.
 source: <patch-v3-10.10-45a24f97c88-20211129T195357Z-avarab@gmail.com>


* ab/grep-patterntype (2021-11-29) 7 commits
 - grep: simplify config parsing and option parsing
 - grep API: call grep_config() after grep_init()
 - grep.c: don't pass along NULL callback value
 - built-ins: trust the "prefix" from run_builtin()
 - grep tests: add missing "grep.patternType" config test
 - log tests: check if grep_config() is called by "log"-like cmds
 - grep.h: remove unused "regex_t regexp" from grep_opt

 Some code clean-up in the "git grep" machinery.

 Need to pick up a reroll.
 cf. <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
 source: <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>


* en/rebase-x-fix (2021-11-29) 1 commit
  (merged to 'next' on 2021-12-03 at a833829733)
 + sequencer: avoid adding exec commands for non-commit creating commands

 "git rebase -x" added an unnecessary 'exec' instructions before
 'noop', which has been corrected.

 Will merge to 'master'.
 source: <pull.1149.git.git.1638244719381.gitgitgadget@gmail.com>


* js/use-builtin-add-i (2021-12-01) 2 commits
 - add -i: default to the built-in implementation
 - t2016: require the PERL prereq only when necessary

 "git add -i" was rewritten in C some time ago and has been in
 testing; the reimplementation is now exposed to general public by
 default.

 On hold.
 There are known breakages on macOS.
 cf. <nycvar.QRO.7.76.6.2112021832060.63@tvgsbejvaqbjf.bet>
 source: <pull.1087.git.1638281655.gitgitgadget@gmail.com>


* jt/conditional-config-on-remote-url (2021-11-29) 2 commits
 - config: include file if remote URL matches a glob
 - config: make git_config_include() static

 The conditional inclusion mechanism of configuration files using
 "[includeIf <condition>]" learns to base its decision on the
 URL of the remote repository the repository interacts with.

 Need to pick up a reroll.
 cf. <cover.1638487815.git.jonathantanmy@google.com>
 source: <3b3af0da983c65ac8282b14141495f6859cd575a.1638217387.git.jonatha=
ntanmy@google.com>


* tb/cruft-packs (2021-11-29) 17 commits
 - sha1-file.c: don't freshen cruft packs
 - builtin/gc.c: conditionally avoid pruning objects via loose
 - builtin/repack.c: add cruft packs to MIDX during geometric repack
 - builtin/repack.c: use named flags for existing_packs
 - builtin/repack.c: allow configuring cruft pack generation
 - builtin/repack.c: support generating a cruft pack
 - builtin/pack-objects.c: --cruft with expiration
 - reachable: report precise timestamps from objects in cruft packs
 - reachable: add options to add_unseen_recent_objects_to_traversal
 - builtin/pack-objects.c: --cruft without expiration
 - builtin/pack-objects.c: return from create_object_entry()
 - t/helper: add 'pack-mtimes' test-tool
 - pack-mtimes: support writing pack .mtimes files
 - chunk-format.h: extract oid_version()
 - pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
 - pack-mtimes: support reading .mtimes files
 - Documentation/technical: add cruft-packs.txt

 Instead of leaving unreachable objects in loose form when packing,
 or ejecting them into loose form when repacking, gather them in a
 packfile with an auxiliary file that records the last-use time of
 these objects.

 Expecting a reroll.
 source: <cover.1638224692.git.me@ttaylorr.com>


* cb/save-term-across-editor-invocation (2021-12-01) 3 commits
 - fixup! editor: allow for saving/restoring terminal state
 - editor: allow for saving/restoring terminal state
 - terminal: teach save_term to fail when not foreground

 Some editors are reported to leave the terminal in funny state
 after they exit on Windows.  Work it around by saving and restoring
 the terminal state when needed.

 Expecting a reroll.
 cf. <CAPUEsphktbdxeV7hvF52Or3CVHS8oOk5-WV=3DxfEZa8kfCVVnVg@mail.gmail.co=
m>
 source: <20211202035446.1154-1-carenas@gmail.com>


* jk/log-decorate-opts-with-implicit-decorate (2021-12-01) 2 commits
 - log: load decorations with --simplify-by-decoration
 - log: handle --decorate-refs with userformat "%d"

 When "git log" implicitly enabled the "decoration" processing
 without being explicitly asked with "--decorate" option, it failed
 to read and honor the settings given by the "--decorate-refs"
 option.

 Will merge to 'next'?
 source: <YahbseXEC66dK0k8@coredump.intra.peff.net>


* jl/subtree-check-parents-argument-passing-fix (2021-12-01) 1 commit
 - subtree: fix argument handling in check_parents

 Fix performance-releated bug in "git subtree" (in contrib/).

 Expecting a reroll.
 cf. <nycvar.QRO.7.76.6.2112031610590.63@tvgsbejvaqbjf.bet>
 source: <pull.1086.v2.git.1638424290015.gitgitgadget@gmail.com>

--------------------------------------------------
[Stalled]

* ar/submodule-update (2021-10-13) 9 commits
 . submodule--helper: rename helper functions
 . submodule--helper: remove unused helpers
 . submodule: move core cmd_update() logic to C
 . submodule--helper: run update using child process struct
 . submodule--helper: allow setting superprefix for init_submodule()
 . submodule--helper: refactor get_submodule_displaypath()
 . submodule--helper: rename helpers for update-clone
 . submodule--helper: get remote names from any repository
 . submodule--helper: split up ensure_core_worktree()

 Rewrite of "git submodule update" in C.

 Expecting a reroll?
 cf. <YWiXL+plA7GHfuVv@google.com>
 source: <20211013051805.45662-10-raykar.ath@gmail.com>


* cf/fetch-set-upstream-while-detached (2021-07-06) 1 commit
 - fetch: fix segfault on --set-upstream while on a detached HEAD

 "git fetch --set-upstream" while on detached HEAD segfaulted
 instead of noticing that such an operation did not make sense.

 Expecting a reroll.
 A low hanging fruit to make this usable is an addition of a few tests;
 any takers?
 cf. <CAPig+cTRXTGe-MNTy=3D2gk1eX8G+0fa303nrLnEtX1uHUC2usmg@mail.gmail.co=
m>
 cf. <xmqqsg0ri5mq.fsf@gitster.g>
 source: <20210706162238.575988-1-clemens@endorphin.org>


* ms/customizable-ident-expansion (2021-09-01) 1 commit
 - keyword expansion: make "$Id$" string configurable

 Instead of "$Id$", user-specified string (like $FreeBSD$) can be
 used as an in-blob placeholder for keyword expansion.

 Will discard.
 Stalled for too long.
 cf. <xmqqfsuosvrh.fsf@gitster.g>
 cf. <211101.86fssf3bn3.gmgdl@evledraar.gmail.com>
 source: <pull.1074.v3.git.git.1630462385587.gitgitgadget@gmail.com>


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
 - Merge branch 'pw/rebase-of-a-tag-fix' into pw/fix-some-issues-in-reset=
-head

 Fix "some issues" in a helper function reset_head().

 Will discard.
 This needs a lot better explanation, including what the issues are,
 which codepaths the helper is used in and to do what, and tests to
 protect the fixes.
 source: <pull.1049.git.1633082702.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* ab/ambiguous-object-name (2021-11-26) 6 commits
 - object-name: re-use "struct strbuf" in show_ambiguous_object()
 - object-name: iterate ambiguous objects before showing header
 - object-name: show date for ambiguous tag objects
 - object-name: make ambiguous object output translatable
 - object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
 - object-name tests: add tests for ambiguous object blind spots

 Error output given in response to an ambiguous object name has been
 improved.

 Needs review.
 An earlier iteration that was much smaller had seen some reviews,
 but the latest round enlarged its scope and needs to be reviewed
 afresh.
 source: <patch-v5-6.6-78bb0995f08-20211125T215529Z-avarab@gmail.com>


* cb/add-p-single-key-fix (2021-11-28) 1 commit
  (merged to 'next' on 2021-12-03 at 8d4f16e620)
 + add -p: avoid use of undefined $key when ReadKey -> EOF

 The single-key-input mode in "git add -p" had some code to handle
 keys that generate a sequence of input via ReadKey(), which did not
 handle end-of-file correctly, which has been fixed.

 Will merge to 'master'.
 source: <20211128174903.5623-1-carenas@gmail.com>


* cb/mingw-gmtime-r (2021-11-27) 1 commit
  (merged to 'next' on 2021-12-03 at 785278d40e)
 + mingw: avoid fallback for {local,gm}time_r()

 Build fix on Windows.

 Will merge to 'master'.
 source: <pull.1142.v2.git.git.1638008132992.gitgitgadget@gmail.com>


* ds/trace2-regions-in-tests (2021-11-29) 2 commits
 - t/t*: remove custom GIT_TRACE2_EVENT_NESTING
 - test-lib.sh: set GIT_TRACE2_EVENT_NESTING

 The default setting for trace2 event nesting was too low to cause
 test failures, which is worked around by bumping it up in the test
 framework.

 Will merge to 'next'.
 source: <pull.1085.git.1638193666.gitgitgadget@gmail.com>


* hn/allow-bogus-oid-in-ref-tests (2021-12-02) 8 commits
 - t1430: create valid symrefs using test-helper
 - t1430: remove refs using test-tool
 - refs: introduce REF_SKIP_REFNAME_VERIFICATION flag
 - refs: introduce REF_SKIP_OID_VERIFICATION flag
 - refs: update comment.
 - test-ref-store: plug memory leak in cmd_delete_refs
 - test-ref-store: parse symbolic flag constants
 - test-ref-store: remove force-create argument for create-reflog

 The test helper for refs subsystem learned to write bogus and/or
 nonexistent object name to refs to simulate error situations we
 want to test Git in.

 Will merge to 'next'.
 source: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>


* hn/t1404-df-limitation-is-ref-files-only (2021-11-29) 1 commit
 - t1404: mark directory/file conflict tests with REFFILES

 Test update.

 Will merge to 'next'.
 source: <pull.1148.v2.git.git.1638210022966.gitgitgadget@gmail.com>


* jc/reflog-iterator-callback-doc (2021-11-28) 1 commit
 - refs: document callback for reflog-ent iterators

 Document the parameters given to the reflog entry iterator callback
 functions.

 Will merge to 'next'?
 source: <xmqqk0gs5bgw.fsf@gitster.g>


* po/size-t-for-vs (2021-12-01) 3 commits
  (merged to 'next' on 2021-12-02 at 489c5b0046)
 + object-file.c: LLP64 compatibility, upcast unity for left shift
 + diffcore-delta.c: LLP64 compatibility, upcast unity for left shift
 + repack.c: LLP64 compatibility, upcast unity for left shift

 On platforms where ulong is shorter than size_t, code paths that
 shifted 1 or 1U to the left lacked the necessary cast to size_t,
 which have been corrected.

 Will merge to 'master'.
 source: <20211201002902.1042-4-philipoakley@iee.email>


* yn/complete-date-format-options (2021-11-25) 1 commit
  (merged to 'next' on 2021-12-03 at 4f37a904a1)
 + completion: add human and auto: date format

 The completion script (in contrib/) learns that the "--date"
 option of commands from the "git log" family takes "human" and
 "auto" as valid values.

 Will merge to 'master'.
 source: <pull.1083.git.1637666875171.gitgitgadget@gmail.com>


* jc/grep-patterntype-default-doc (2021-11-29) 1 commit
 - grep: clarify what `grep.patternType=3Ddefault` means

 Doc update.

 Will merge to 'next'.
 source: <xmqq7dcq62af.fsf@gitster.g>


* ab/ci-updates (2021-11-23) 5 commits
 - CI: don't run "make test" twice in one job
 - CI: use "$runs_on_pool", not "$jobname" to select packages & config
 - CI: rename the "Linux32" job to lower-case "linux32"
 - CI: use shorter names that fit in UX tooltips
 - CI: remove Travis CI support

 Drop support for TravisCI and update test workflows at GitHub.

 Will merge to 'next'.
 source: <cover-v4-0.5-00000000000-20211123T134300Z-avarab@gmail.com>


* en/keep-cwd (2021-12-01) 11 commits
 - t2501: simplify the tests since we can now assume desired behavior
 - dir: new flag to remove_dir_recurse() to spare the original_cwd
 - dir: avoid incidentally removing the original_cwd in remove_path()
 - stash: do not attempt to remove startup_info->original_cwd
 - rebase: do not attempt to remove startup_info->original_cwd
 - clean: do not attempt to remove startup_info->original_cwd
 - symlinks: do not include startup_info->original_cwd in dir removal
 - unpack-trees: add special cwd handling
 - unpack-trees: refuse to remove startup_info->original_cwd
 - setup: introduce startup_info->original_cwd
 - t2501: add various tests for removing the current working directory

 Many git commands that deal with working tree files try to remove a
 directory that becomes empty (i.e. "git switch" from a branch that
 has the directory to another branch that does not would attempt
 remove all files in the directory and the directory itself).  This
 drops users into an unfamiliar situation if the command was run in
 a subdirectory that becomes subject to removal due to the command.
 The commands have been taught to keep an empty directory if it is
 the directory they were started in to avoid surprising users.

 Needs review.
 There are some comments on earlier rounds; the latest one needs a
 serious review or at least Acks from past commentors.
 source: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>


* ab/run-command (2021-11-25) 9 commits
 - run-command API: remove "env" member, always use "env_array"
 - difftool: use "env_array" to simplify memory management
 - run-command API: remove "argv" member, always use "args"
 - run-command API users: use strvec_push(), not argv construction
 - run-command API users: use strvec_pushl(), not argv construction
 - run-command tests: use strvec_pushv(), not argv assignment
 - run-command API users: use strvec_pushv(), not argv assignment
 - upload-archive: use regular "struct child_process" pattern
 - worktree: stop being overly intimate with run_command() internals

 API clean-up.

 Will merge to 'next'.
 cf. <211130.86k0gpcpy2.gmgdl@evledraar.gmail.com>
 cf. <CAPig+cSvFgJTiq8pXrWy_7ukQwE1y9ZGwMgKmyjWuQHdNGxiDQ@mail.gmail.com>
 source: <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>


* hn/create-reflog-simplify (2021-11-22) 1 commit
  (merged to 'next' on 2021-12-02 at 87ff49b776)
 + refs: drop force_create argument of create_reflog API

 A small simplification of API.

 Will merge to 'master'.
 source: <pull.1144.git.git.1637590749342.gitgitgadget@gmail.com>


* hn/reflog-tests (2021-12-02) 5 commits
 - refs/debug: trim trailing LF from reflog message
 - test-ref-store: tweaks to for-each-reflog-ent format
 - t1405: check for_each_reflog_ent_reverse() more thoroughly
 - test-ref-store: don't add newline to reflog message
 - show-branch: show reflog message

 Prepare tests on ref API to help testing reftable backends.

 Will merge to 'next'.
 source: <pull.1145.v3.git.git.1638466593.gitgitgadget@gmail.com>


* jt/midx-doc-fix (2021-11-22) 1 commit
  (merged to 'next' on 2021-12-02 at eac9f263ae)
 + Doc: no midx and partial clone relation

 Docfix.

 Will merge to 'master'.
 source: <20211122184114.3328662-1-jonathantanmy@google.com>


* tl/ls-tree-oid-only (2021-11-22) 1 commit
 - ls-tree.c: support `--oid-only` option for "git-ls-tree"

 "git ls-tree" learns "--oid-only" option, similar to "--name-only".

 Expecting a reroll.
 source: <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyronet=
eng@gmail.com>


* jk/t7006-sigpipe-tests-fix (2021-11-22) 3 commits
  (merged to 'next' on 2021-12-02 at eefd61931f)
 + t7006: simplify exit-code checks for sigpipe tests
 + t7006: clean up SIGPIPE handling in trace2 tests
 + run-command: unify signal and regular logic for wait_or_whine()

 The function to cull a child process and determine the exit status
 had two separate code paths for normal callers and callers in a
 signal handler, and the latter did not yield correct value when the
 child has caught a signal.  The handling of the exit status has
 been unified for these two code paths.  An existing test with
 flakiness has also been corrected.

 Will merge to 'master'.
 source: <YZrSALOrdhuunHwp@coredump.intra.peff.net>


* em/missing-pager (2021-11-24) 1 commit
  (merged to 'next' on 2021-12-03 at 22ad721b52)
 + pager: fix crash when pager program doesn't exist

 When a non-existent program is given as the pager, we tried to
 reuse an uninitialized child_process structure and crashed, which
 has been fixed.

 Will merge to 'master'.
 source: <20211125000239.2336-1-ematsumiya@suse.de>


* ab/checkout-branch-info-leakfix (2021-11-18) 1 commit
  (merged to 'next' on 2021-12-02 at 5922388782)
 + checkout: fix "branch info" memory leaks

 Leakfix.

 Will merge to 'master'.
 source: <patch-v4-1.1-57bcd0cbc23-20211116T182604Z-avarab@gmail.com>


* ab/make-dependency (2021-11-18) 24 commits
 - Makefile: move ".SUFFIXES" rule to shared.mak
 - Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
 - Makefile: disable GNU make built-in wildcard rules
 - Makefile: use $(file) I/O instead of "FORCE" when possible
 - Makefile: correct the dependency graph of hook-list.h
 - Makefiles: add and use wildcard "mkdir -p" template
 - Makefile: use $(wspfx) for $(QUIET...) in shared.mak
 - Makefile: add "$(QUIET)" boilerplate to shared.mak
 - Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}
 - Makefile: re-add and use the "shellquote" macros
 - Makefile: move $(comma), $(empty) and $(space) to shared.mak
 - Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
 - Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
 - Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
 - Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
 - Makefile: adjust Perl-related comments & whitespace
 - Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
 - Makefile: guard Perl-only variable assignments
 - Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
 - Makefile: clean perl/build/ even with NO_PERL=3DY
 - Makefile: use "=3D" not ":=3D" for po/* and perl/*
 - Makefile: don't set up "perl/build" rules under NO_PERL=3DY
 - Makefile: don't invoke msgfmt with --statistics
 - Merge branch 'ab/sh-retire-helper-functions' into ab/make-dependency

 Dependency clean-up.

 Needs review.
 There are some comments on earlier rounds; the latest one needs a
 serious review or at least Acks from past commentors.
 source: <patch-v4-23.23-48a3927d972-20211117T101807Z-avarab@gmail.com>


* ah/advice-pull-has-no-preference-between-rebase-and-merge (2021-11-19) =
1 commit
  (merged to 'next' on 2021-12-02 at 1b49913760)
 + pull: don't say that merge is "the default strategy"

 The advice message given by "git pull" when the user hasn't made a
 choice between merge and rebase still said that the merge is the
 default, which no longer is the case.  This has been corrected.

 Will merge to 'master'.
 source: <20211118154317.639118-1-alexhenrie24@gmail.com>


* ds/fetch-pull-with-sparse-index (2021-11-29) 3 commits
 - ls-files: add --sparse option
 - fetch/pull: use the sparse index
 - Merge branch 'ld/sparse-diff-blame' into ds/fetch-pull-with-sparse-ind=
ex
 (this branch uses ld/sparse-diff-blame and vd/sparse-reset.)

 "git fetch" and "git pull" are now declared sparse-index clean.
 Also "git ls-files" learns the "--sparse" option to help debugging.

 Expecting a reroll?
 Discussion seems to have stalled, with a few loose ends questions.
 source: <pull.1080.git.1637077083.gitgitgadget@gmail.com>


* fs/ssh-signing-other-keytypes (2021-11-19) 2 commits
 - ssh signing: make sign/amend test more resilient
 - ssh signing: support non ssh-* keytypes

 The cryptographic signing using ssh keys can specify literal keys
 for keytypes whose name do not begin with the "ssh-" prefix by
 using the "key::" prefix mechanism (e.g. "key::ecdsa-sha2-nistp256").

 Will merge to 'next'?
 source: <20211119150707.3924636-1-fs@gigacodes.de>


* fs/test-prereq (2021-12-01) 3 commits
 - test-lib: make BAIL_OUT() work in tests and prereq
 - test-lib: introduce required prereq for test runs
 - test-lib: show missing prereq summary

 The test framework learns to list unsatisfied test prerequisites,
 and optionally error out when prerequisites that are expected to be
 satisfied are not.

 Will merge to 'next'.
 source: <20211201085315.576865-1-fs@gigacodes.de>


* jk/t5319-midx-corruption-test-deflake (2021-11-18) 1 commit
  (merged to 'next' on 2021-12-02 at 0ac4fd64aa)
 + t5319: corrupt more bytes of the midx checksum

 Test fix.

 Will merge to 'master'.
 source: <YZQk6t1veegeAlYh@coredump.intra.peff.net>


* js/trace2-avoid-recursive-errors (2021-11-18) 1 commit
  (merged to 'next' on 2021-12-02 at c5b1e5ddec)
 + trace2: disable tr2_dst before warning on write errors

 trace2 error code path fix.

 Will merge to 'master'.
 source: <5a9e49e7f1540d762374382e1769edf112cf093f.1637272706.git.steadmo=
n@google.com>


* pw/xdiff-classify-record-in-histogram (2021-11-18) 3 commits
  (merged to 'next' on 2021-12-02 at 5ccd12d09b)
 + xdiff: simplify comparison
 + xdiff: avoid unnecessary memory allocations
 + diff histogram: intern strings

 "diff --histogram" optimization.

 Will merge to 'master'.
 source: <b0bc773f51e114d96ad6efd1ebd03fb6e7646288.1637148025.git.gitgitg=
adget@gmail.com>


* rs/mergesort (2021-11-18) 1 commit
  (merged to 'next' on 2021-12-02 at 0490b0ffbd)
 + mergesort: avoid left shift overflow

 Bitop fix for platforms whose "long" is 32-bit.

 Will merge to 'master'.
 source: <5eabbe1c-4c0f-559a-da21-423afec89e7e@web.de>


* xw/am-empty (2021-12-01) 3 commits
 - am: support --allow-empty to record specific empty patches
 - am: support --empty=3D<option> to handle empty patches
 - doc: git-format-patch: describe the option --always

 "git am" learns "--empty=3D(die|drop|keep)" option to tweak what is
 done to a piece of e-mail without a patch in it.

 Expecting a reroll.
 The new and the third patch seems iffy.
 source: <pull.1076.v14.git.1638329848.gitgitgadget@gmail.com>


* hk/ci-checkwhitespace-commentfix (2021-11-19) 1 commit
  (merged to 'next' on 2021-12-02 at 971178fe99)
 + ci(check-whitespace): update stale file top comments

 Comment fix.

 Will merge to 'master'.
 source: <pull.1143.git.git.1637347813367.gitgitgadget@gmail.com>


* jk/fetch-pack-avoid-sigpipe-to-index-pack (2021-11-19) 1 commit
  (merged to 'next' on 2021-12-02 at e2cc1ae46a)
 + fetch-pack: ignore SIGPIPE when writing to index-pack

 "git fetch", when received a bad packfile, can fail with SIGPIPE.
 This wasn't wrong per-se, but we now detect the situation and fail
 in a more predictable way.

 Will merge to 'master'.
 source: <YZgQD3lrw4+i4EMd@coredump.intra.peff.net>


* jk/refs-g11-workaround (2021-11-19) 1 commit
  (merged to 'next' on 2021-12-02 at 1025235670)
 + refs: work around gcc-11 warning with REF_HAVE_NEW

 Workaround for a false-alarm by gcc-11

 Will merge to 'master'.
 source: <YZgW/pz6CbpaywDa@coredump.intra.peff.net>


* mp/absorb-submodule-git-dir-upon-deinit (2021-11-19) 1 commit
  (merged to 'next' on 2021-12-03 at afc462a692)
 + submodule: absorb git dir instead of dying on deinit

 "git submodule deinit" for a submodule whose .git metadata
 directory is embedded in its working tree refused to work, until
 the submodule gets converted to use the "absorbed" form where the
 metadata directory is stored in superproject, and a gitfile at the
 top-level of the working tree of the submodule points at it.  The
 command is taught to convert such submodules to the absorbed form
 as needed.

 Will merge to 'master'.
 source: <pull.1078.v7.git.git.1637319387717.gitgitgadget@gmail.com>


* rj/receive-pack-avoid-sigpipe-during-status-reporting (2021-11-10) 1 co=
mmit
 - receive-pack: ignore SIGPIPE while reporting status to client

 When the "git push" command is killed while the receiving end is
 trying to report what happened to the ref update proposals, the
 latter used to die, due to SIGPIPE.  The code now ignores SIGPIPE
 to increase our chances to run the post-receive hook after it
 happens.

 Will merge to 'next'.
 source: <20211110092942.1648429-1-robin@jarry.cc>


* ab/parse-options-cleanup (2021-11-10) 1 commit
 - parse-options.c: use "enum parse_opt_result" for parse_nodash_opt()

 Change the type of an internal function to return an enum (instead
 of int) and replace -2 that was used to signal an error with -1.

 Will merge to 'next'?
 It is disturbing that a change claimed to be clean-up is not a faithful
 conversion, though.
 source: <patch-v2-1.1-376f76bb44e-20211110T012523Z-avarab@gmail.com>


* cw/protocol-v2-doc-fix (2021-11-11) 1 commit
  (merged to 'next' on 2021-12-02 at 59f42a7cfc)
 + protocol-v2.txt: align delim-pkt spec with usage

 Doc update.

 Will merge to 'master'.
 source: <20211111220048.1702896-1-calvinwan@google.com>


* jt/pack-header-lshift-overflow (2021-11-11) 1 commit
  (merged to 'next' on 2021-12-02 at 89c37479db)
 + packfile: avoid overflowing shift during decode

 The code to decode the length of packed object size has been
 corrected.

 Will merge to 'master'.
 source: <20211110234033.3144165-1-jonathantanmy@google.com>


* bc/require-c99 (2021-12-01) 1 commit
  (merged to 'next' on 2021-12-02 at 76aa8bc2d0)
 + git-compat-util: add a test balloon for C99 support

 Weather balloon to break people with compilers that do not support
 C99.

 Will merge to 'master'.
 source: <20211201014050.38002-2-sandals@crustytoothpaste.net>


* jc/c99-var-decl-in-for-loop (2021-12-03) 1 commit
  (merged to 'next' on 2021-12-03 at 57100223b2)
 + revision: use C99 declaration of variable in for() loop

 Weather balloon to find compilers that do not grok variable
 declaration in the for() loop.

 Will merge to 'master'.
 source: <xmqqpmr2j5lq.fsf_-_@gitster.g>


* tl/midx-docfix (2021-11-18) 1 commit
  (merged to 'next' on 2021-12-02 at 0fae3ebdef)
 + midx: fix a formatting issue in "multi-pack-index.txt"

 Doc mark-up fix.

 Will merge to 'master'.
 source: <9b910a44f4143c94787110a688f2b17ba4eeb0fc.1637218943.git.dyronet=
eng@gmail.com>


* ak/protect-any-current-branch (2021-12-01) 8 commits
 - branch: protect branches checked out in all worktrees
 - receive-pack: protect current branch for bare repository worktree
 - receive-pack: clean dead code from update_worktree()
 - fetch: protect branches checked out in all worktrees
 - worktree: simplify find_shared_symref() memory ownership model
 - branch: lowercase error messages
 - receive-pack: lowercase error messages
 - fetch: lowercase error messages

 "git fetch" without the "--update-head-ok" option ought to protect
 a checked out branch from getting updated, to prevent the working
 tree that checks it out to go out of sync.  The code was written
 before the use of "git worktree" got widespread, and only checked
 the branch that was checked out in the current worktree, which has
 been updated.
 (originally called ak/fetch-not-overwrite-any-current-branch)

 Will merge to 'next'?
 source: <20211201221547.1796213-1-andersk@mit.edu>


* jk/test-bitmap-fix (2021-11-05) 1 commit
  (merged to 'next' on 2021-12-02 at c273d402fb)
 + test_bitmap_hashes(): handle repository without bitmaps

 Tighten code for testing pack-bitmap.

 Will merge to 'master'.
 source: <YYTy6+DG5guzJIO7@coredump.intra.peff.net>


* jk/jump-merge-with-pathspec (2021-11-09) 1 commit
  (merged to 'next' on 2021-12-02 at fea901973d)
 + git-jump: pass "merge" arguments to ls-files

 The "merge" subcommand of "git jump" (in contrib/) silently ignored
 pathspec and other parameters.

 Will merge to 'master'.
 source: <YYqjY/zcBWyqY8/5@coredump.intra.peff.net>


* jk/strbuf-addftime-seconds-since-epoch (2021-11-04) 1 commit
  (merged to 'next' on 2021-12-02 at d0b158d899)
 + strbuf_addftime(): handle "%s" manually

 The "--date=3Dformat:<strftime>" gained a workaround for the lack of
 system support for a non-local timezone to handle "%s" placeholder.

 Will merge to 'master'.
 source: <YYEihoLbEGi44dDb@coredump.intra.peff.net>


* js/ci-no-directional-formatting (2021-11-04) 1 commit
  (merged to 'next' on 2021-12-02 at bc756bc586)
 + ci: disallow directional formatting

 CI has been taught to catch some Unicode directional formatting
 sequence that can be used in certain mischief.

 Will merge to 'master'.
 source: <pull.1071.v3.git.1636031609982.gitgitgadget@gmail.com>


* tw/var-default-branch (2021-11-03) 1 commit
  (merged to 'next' on 2021-12-02 at 944512852e)
 + var: add GIT_DEFAULT_BRANCH variable

 "git var GIT_DEFAULT_BRANCH" is a way to see what name is used for
 the newly created branch if "git init" is run.

 Will merge to 'master'.
 source: <20211103201702.117771-1-thomas@t-8ch.de>


* ab/mark-leak-free-tests-even-more (2021-11-01) 15 commits
  (merged to 'next' on 2021-12-03 at 1d8c342dab)
 + leak tests: mark some fast-import tests as passing with SANITIZE=3Dlea=
k
 + leak tests: mark some config tests as passing with SANITIZE=3Dleak
 + leak tests: mark some status tests as passing with SANITIZE=3Dleak
 + leak tests: mark some clone tests as passing with SANITIZE=3Dleak
 + leak tests: mark some add tests as passing with SANITIZE=3Dleak
 + leak tests: mark some diff tests as passing with SANITIZE=3Dleak
 + leak tests: mark some apply tests as passing with SANITIZE=3Dleak
 + leak tests: mark some notes tests as passing with SANITIZE=3Dleak
 + leak tests: mark some update-index tests as passing with SANITIZE=3Dle=
ak
 + leak tests: mark some rev-parse tests as passing with SANITIZE=3Dleak
 + leak tests: mark some rev-list tests as passing with SANITIZE=3Dleak
 + leak tests: mark some misc tests as passing with SANITIZE=3Dleak
 + leak tests: mark most gettext tests as passing with SANITIZE=3Dleak
 + leak tests: mark "sort" test as passing SANITIZE=3Dleak
 + leak tests: mark a read-tree test as passing SANITIZE=3Dleak

 More tests are marked as leak-free.

 Will merge to 'master'.
 source: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>


* if/redact-packfile-uri (2021-11-11) 2 commits
  (merged to 'next' on 2021-12-02 at 81213be9ac)
 + http-fetch: redact url on die() message
 + fetch-pack: redact packfile urls in traces

 Redact the path part of packfile URI that appears in the trace output.

 Will merge to 'master'.
 source: <pull.1052.v7.git.1636588289.gitgitgadget@gmail.com>


* ew/test-wo-fsync (2021-10-29) 1 commit
 - tests: disable fsync everywhere

 Allow running our tests while disabling fsync.

 Will merge to 'next'?
 Received a lukewarm reactions overall.  Perhaps we should drop instead?
 source: <20211029001552.GA29647@dcvr>


* ja/doc-cleanup (2021-11-09) 10 commits
  (merged to 'next' on 2021-12-02 at f72204942f)
 + init doc: --shared=3D0xxx does not give umask but perm bits
 + doc: git-init: clarify file modes in octal.
 + doc: git-http-push: describe the refs as pattern pairs
 + doc: uniformize <URL> placeholders' case
 + doc: use three dots for indicating repetition instead of star
 + doc: git-ls-files: express options as optional alternatives
 + doc: use only hyphens as word separators in placeholders
 + doc: express grammar placeholders between angle brackets
 + doc: split placeholders as individual tokens
 + doc: fix git credential synopsis

 Doc update.

 Will merge to 'master'.
 source: <20211106184858.11500-1-jn.avila@free.fr>


* re/color-default-reset (2021-10-28) 3 commits
 - color: allow colors to be prefixed with "reset"
 - color: support "default" to restore fg/bg color
 - color: add missing GIT_COLOR_* white/black constants

 "default" and "reset" colors have been added to our palette.

 Will merge to 'next'?
 Seems to have stalled, but I am OK to merge it as-is.
 cf. <881B4747-B0B5-459B-B673-06972275A8B8@gmail.com>
 source: <pull.1117.git.git.1635210227532.gitgitgadget@gmail.com>
 source: <pull.1116.git.git.1635201156.gitgitgadget@gmail.com>


* jc/fix-first-object-walk (2021-10-29) 2 commits
  (merged to 'next' on 2021-12-02 at 43a5c1ec03)
 + docs: add headers in MyFirstObjectWalk
 + docs: fix places that break compilation in MyFirstObjectWalk

 Doc update.

 Will merge to 'master'.
 source: <pull.1063.v3.git.1635537163.gitgitgadget@gmail.com>


* pw/diff-color-moved-fix (2021-10-27) 15 commits
 - diff --color-moved: intern strings
 - diff: use designated initializers for emitted_diff_symbol
 - diff --color-moved-ws=3Dallow-indentation-change: improve hash lookups
 - diff --color-moved: stop clearing potential moved blocks
 - diff --color-moved: shrink potential moved blocks as we go
 - diff --color-moved: unify moved block growth functions
 - diff --color-moved: call comparison function directly
 - diff --color-moved-ws=3Dallow-indentation-change: simplify and optimiz=
e
 - diff: simplify allow-indentation-change delta calculation
 - diff --color-moved: avoid false short line matches and bad zerba color=
ing
 - diff --color-moved=3Dzebra: fix alternate coloring
 - diff --color-moved: rewind when discarding pmb
 - diff --color-moved: factor out function
 - diff --color-moved: clear all flags on blocks that are too short
 - diff --color-moved: add perf tests

 Long-overdue correctness and performance update to "diff
 --color-moved" feature.

 Need to pick up the reroll before merging to 'next'.
 cf. <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>


* ab/generate-command-list (2021-11-05) 10 commits
  (merged to 'next' on 2021-12-02 at 37a575b37f)
 + generate-cmdlist.sh: don't parse command-list.txt thrice
 + generate-cmdlist.sh: replace "grep' invocation with a shell version
 + generate-cmdlist.sh: do not shell out to "sed"
 + generate-cmdlist.sh: stop sorting category lines
 + generate-cmdlist.sh: replace for loop by printf's auto-repeat feature
 + generate-cmdlist.sh: run "grep | sort", not "sort | grep"
 + generate-cmdlist.sh: don't call get_categories() from category_list()
 + generate-cmdlist.sh: spawn fewer processes
 + generate-cmdlist.sh: trivial whitespace change
 + command-list.txt: sort with "LC_ALL=3DC sort"

 Build optimization.

 Will merge to 'master'.
 source: <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>


* es/pretty-describe-more (2021-11-01) 3 commits
 - pretty: add abbrev option to %(describe)
 - pretty: add tag option to %(describe)
 - pretty.c: rework describe options parsing for better extensibility

 Extend "git log --format=3D%(describe)" placeholder to allow passing
 selected command-line options to the underlying "git describe"
 command.

 Will merge to 'next'.
 source: <20211031171510.1646396-1-eschwartz@archlinux.org>


* fs/ssh-signing-key-lifetime (2021-12-01) 7 commits
 - ssh signing: verify ssh-keygen in test prereq
 - ssh signing: make fmt-merge-msg consider key lifetime
 - ssh signing: make verify-tag consider key lifetime
 - ssh signing: make git log verify key lifetime
 - ssh signing: make verify-commit consider key lifetime
 - ssh signing: add key lifetime test prereqs
 - ssh signing: use sigc struct to pass payload

 Extend the signing of objects with SSH keys and learn to pay
 attention to the key validity time range when verifying.

 Will merge to 'next'?
 source: <20211130141112.78193-1-fs@gigacodes.de>


* jc/doc-submitting-patches-choice-of-base (2021-10-25) 2 commits
 - (wip) reword the final review part
 - SubmittingPatchs: clarify choice of base and testing

 Extend the guidance to choose the base commit to build your work
 on, and hint/nudge contributors to read others' changes.

 Expecting a reroll.
 Stalled after one incremental update suggestion.
 cf. <xmqqa6ix2g6a.fsf@gitster.g>
 source: <xmqqa6izcwio.fsf_-_@gitster.g>


* gc/remote-with-fewer-static-global-variables (2021-11-18) 5 commits
  (merged to 'next' on 2021-12-02 at d7ea1696e5)
 + remote: die if branch is not found in repository
 + remote: remove the_repository->remote_state from static methods
 + remote: use remote_state parameter internally
 + remote: move static variables into per-repository struct
 + t5516: add test case for pushing remote refspecs

 Code clean-up to eventually allow information on remotes defined
 for an arbitrary repository to be read.

 Will merge to 'master'.
 source: <20211118005325.64971-1-chooglen@google.com>


* ab/config-based-hooks-2 (2021-11-24) 18 commits
 - run-command: remove old run_hook_{le,ve}() hook API
 - receive-pack: convert push-to-checkout hook to hook.h
 - read-cache: convert post-index-change to use hook.h
 - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
 - git-p4: use 'git hook' to run hooks
 - send-email: use 'git hook run' for 'sendemail-validate'
 - git hook run: add an --ignore-missing flag
 - hooks: convert worktree 'post-checkout' hook to hook library
 - hooks: convert non-worktree 'post-checkout' hook to hook library
 - merge: convert post-merge to use hook.h
 - am: convert applypatch-msg to use hook.h
 - rebase: convert pre-rebase to use hook.h
 - hook API: add a run_hooks_l() wrapper
 - am: convert {pre,post}-applypatch to use hook.h
 - gc: use hook library for pre-auto-gc hook
 - hook API: add a run_hooks() wrapper
 - hook: add 'run' subcommand
 - Merge branch 'ab/config-based-hooks-1' into ab/config-based-hooks-2

 More "config-based hooks".

 Needs review.
 At this point, as =C3=86var and Emily both read the major part of this
 series, a final and quick read-over plus an Ack by Emily on her
 part plus a serious review on the patches attributed to =C3=86var by
 somebody other than =C3=86var would be sufficient to move it in some
 direction (hopefully forward).
 source: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>


* vd/sparse-sparsity-fix-on-read (2021-11-24) 4 commits
  (merged to 'next' on 2021-12-02 at 1ec68669cb)
 + sparse-index: update do_read_index to ensure correct sparsity
 + sparse-index: add ensure_correct_sparsity function
 + sparse-index: avoid unnecessary cache tree clearing
 + test-read-cache.c: prepare_repo_settings after config init

 Ensure that the sparseness of the in-core index matches the
 index.sparse configuration specified by the repository immediately
 after the on-disk index file is read.

 Will merge to 'master'.
 source: <pull.1059.v5.git.1637626833.gitgitgadget@gmail.com>


* js/branch-track-inherit (2021-11-18) 1 commit
 - branch: add flags and config to inherit tracking

 "git -c branch.autosetupmerge=3Dinherit branch new old" makes "new"
 to have the same upstream as the "old" branch, instead of marking
 "old" itself as its upstream.

 Expecting a reroll.
 cf. <YaaYyFhDrvEbenWa@google.com>
 source: <7ad7507f183332cb2b5fdf2eb76fbbc9dd7199ef.1637085915.git.steadmo=
n@google.com>


* jh/builtin-fsmonitor-part2 (2021-10-21) 29 commits
 - t7527: test status with untracked-cache and fsmonitor--daemon
 - fsmonitor: force update index after large responses
 - fsmonitor--daemon: use a cookie file to sync with file system
 - fsmonitor--daemon: periodically truncate list of modified files
 - t/perf/p7519: add fsmonitor--daemon test cases
 - t/perf/p7519: speed up test on Windows
 - t/helper/test-chmtime: skip directories on Windows
 - t/perf: avoid copying builtin fsmonitor files into test repo
 - t7527: create test for fsmonitor--daemon
 - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daem=
on
 - help: include fsmonitor--daemon feature flag in version info
 - fsmonitor--daemon: implement handle_client callback
 - compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacO=
S
 - compat/fsmonitor/fsm-listen-darwin: add macos header files for FSEvent
 - compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on Wind=
ows
 - fsmonitor--daemon: create token-based changed path cache
 - fsmonitor--daemon: define token-ids
 - fsmonitor--daemon: add pathname classification
 - fsmonitor--daemon: implement 'start' command
 - fsmonitor--daemon: implement 'run' command
 - compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
 - compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
 - fsmonitor--daemon: implement 'stop' and 'status' commands
 - fsmonitor--daemon: add a built-in fsmonitor daemon
 - fsmonitor: document builtin fsmonitor
 - fsmonitor: use IPC to query the builtin FSMonitor daemon
 - fsmonitor: config settings are repository-specific
 - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 - fsmonitor: enhance existing comments

 Built-in fsmonitor (part 2).

 Expecting a reroll.
 Seems that the discussion stalled.
 cf. <d9c3ef61-768c-3560-2858-3438c355a742@jeffhostetler.com>
 source: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>


* ld/sparse-diff-blame (2021-11-29) 3 commits
 - blame: enable and test the sparse index
 - diff: enable and test the sparse index
 - Merge branch 'vd/sparse-reset' into ld/sparse-diff-blame
 (this branch is used by ds/fetch-pull-with-sparse-index; uses vd/sparse-=
reset.)

 Teach diff and blame to work well with sparse index.

 Need to pick up a reroll.
 cf. <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
 source: <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>


* ns/remerge-diff (2021-10-27) 9 commits
 - doc/diff-options: explain the new --remerge-diff option
 - show, log: adapt Elijah Newren's changes to common tmp-objdir API
 - show, log: provide a --remerge-diff capability
 - merge-ort: capture and print ll-merge warnings in our preferred fashio=
n
 - ll-merge: add API for capturing warnings in a strbuf instead of stderr
 - merge-ort: add ability to record conflict messages in a file
 - merge-ort: mark a few more conflict messages as omittable
 - Merge branch 'ns/tmp-objdir' into ns/remerge-diff
 - Merge branch 'ns/tmp-objdir' into ns/remerge-diff
 (this branch uses ns/tmp-objdir.)

 A new presentation for two-parent merge "--remerge-diff" can be
 used to show the difference between mechanical (and possibly
 conflicted) merge results and the recorded resolution.

 Expecting a reroll.
 cf. <CABPp-BHq4DnkCZZ+HcnGiZYKHpWJgzMBjMDuWbbTFYPesm2sXA@mail.gmail.com>
 This is Elijah's remerge-diff rebased on ns/tmp-objdir to share the
 "create objects temporarily, only to discard without committing
 them to longer-term storage" infrastructure with another topic.


* ns/tmp-objdir (2021-10-27) 4 commits
 - fixup! tmp-objdir: new API for creating temporary writable databases
 - fixup! tmp-objdir: new API for creating temporary writable databases
 - tmp-objdir: disable ref updates when replacing the primary odb
 - tmp-objdir: new API for creating temporary writable databases
 (this branch is used by ns/batched-fsync and ns/remerge-diff.)

 New interface into the tmp-objdir API to help in-core use of the
 quarantine feature.

 Expecting a reroll.
 cf. <CANQDOddCC7+gGUy1VBxxwvN7ieP+N8mQhbxK2xx6ySqZc6U7-g@mail.gmail.com>
 cf. <CABPp-BHq4DnkCZZ+HcnGiZYKHpWJgzMBjMDuWbbTFYPesm2sXA@mail.gmail.com>
 cf. <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
 cf. <ef5a087813b7dfd232a9366eee09774d197e2307.1635287730.git.gitgitgadge=
t@gmail.com>


* vd/sparse-reset (2021-11-29) 8 commits
  (merged to 'next' on 2021-12-02 at 47b1095f39)
 + unpack-trees: improve performance of next_cache_entry
 + reset: make --mixed sparse-aware
 + reset: make sparse-aware (except --mixed)
 + reset: integrate with sparse index
 + reset: expand test coverage for sparse checkouts
 + sparse-index: update command for expand/collapse test
 + reset: preserve skip-worktree bit in mixed reset
 + reset: rename is_missing to !is_in_reset_tree
 (this branch is used by ds/fetch-pull-with-sparse-index and ld/sparse-di=
ff-blame.)

 Various operating modes of "git reset" have been made to work
 better with the sparse index.

 Will merge to 'master'.
 source: <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>


* es/superproject-aware-submodules (2021-11-18) 5 commits
 - submodule: use config to find superproject worktree
 - submodule: record superproject gitdir during 'update'
 - submodule: record superproject gitdir during absorbgitdirs
 - introduce submodule.superprojectGitDir record
 - t7400-submodule-basic: modernize inspect() helper

 A configuration variable in a submodule points at the location of
 the superproject it is bound to (RFC).

 Expecting a reroll.
 cf. <20211117234300.2598132-1-jonathantanmy@google.com>
 source: <20211117005701.371808-1-emilyshaffer@google.com>


* ns/batched-fsync (2021-10-27) 9 commits
 - Merge branch 'ns/tmp-objdir' into ns/batched-fsync
 - core.fsyncobjectfiles: performance tests for add and stash
 - core.fsyncobjectfiles: tests for batch mode
 - unpack-objects: use the bulk-checkin infrastructure
 - update-index: use the bulk-checkin infrastructure
 - core.fsyncobjectfiles: add windows support for batch mode
 - core.fsyncobjectfiles: batched disk flushes
 - bulk-checkin: rename 'state' variable and separate 'plugged' boolean
 - Merge branch 'ns/tmp-objdir' into ns/batched-fsync
 (this branch uses ns/tmp-objdir.)

 The "core.fsyncobjectfiles" configuration variable can now be set
 to "batch" for improved performance.

 Expecting a reroll.
 cf. <CABPp-BHq4DnkCZZ+HcnGiZYKHpWJgzMBjMDuWbbTFYPesm2sXA@mail.gmail.com>
 source: <f4fa20f591e580107b961aa1ca46d844603559d6.1633366668.git.gitgitg=
adget@gmail.com>


* en/zdiff3 (2021-12-01) 2 commits
 - update documentation for new zdiff3 conflictStyle
 - xdiff: implement a zealous diff3, or "zdiff3"

 "Zealous diff3" style of merge conflict presentation has been added.

 Will merge to 'next'.
 source: <pull.1036.v5.git.git.1638317108.gitgitgadget@gmail.com>


* js/scalar (2021-12-01) 17 commits
 - scalar: implement the `version` command
 - scalar: implement the `delete` command
 - scalar: teach 'reconfigure' to optionally handle all registered enlist=
ments
 - scalar: allow reconfiguring an existing enlistment
 - scalar: implement the `run` command
 - scalar: teach 'clone' to support the --single-branch option
 - scalar: implement the `clone` subcommand
 - scalar: implement 'scalar list'
 - scalar: let 'unregister' handle a deleted enlistment directory gracefu=
lly
 - scalar: 'unregister' stops background maintenance
 - scalar: 'register' sets recommended config and starts maintenance
 - ci: also run the `scalar` tests
 - cmake: optionally build `scalar`, too
 - scalar: create test infrastructure
 - scalar: start documenting the command
 - scalar: create a rudimentary executable
 - scalar: add a README with a roadmap

 Add pieces from "scalar" to contrib/.

 Need to pick up the reroll before merging to 'next'.
 cf. <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
 source: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>


* ab/only-single-progress-at-once (2021-11-03) 8 commits
 - progress.c: add & assert a "global_progress" variable
 - various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
 - pack-bitmap-write.c: don't return without stop_progress()
 - progress.c: add temporary variable from progress struct
 - progress.c tests: test some invalid usage
 - progress.c tests: make start/stop commands on stdin
 - progress.c test helper: add missing braces
 - leak tests: fix a memory leaks in "test-progress" helper

 Further tweaks on progress API.

 Needs review.
 The last three rounds has seen little reaction, even though earlier
 round saw a lot of responses. The latest round needs a serious
 review or at least Acks from past commentors.
 source: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>


* hn/reftable (2021-10-08) 19 commits
  (merged to 'next' on 2021-12-03 at 767ec5d9b3)
 + Add "test-tool dump-reftable" command.
 + reftable: add dump utility
 + reftable: implement stack, a mutable database of reftable files.
 + reftable: implement refname validation
 + reftable: add merged table view
 + reftable: add a heap-based priority queue for reftable records
 + reftable: reftable file level tests
 + reftable: read reftable files
 + reftable: generic interface to tables
 + reftable: write reftable files
 + reftable: a generic binary tree implementation
 + reftable: reading/writing blocks
 + Provide zlib's uncompress2 from compat/zlib-compat.c
 + reftable: (de)serialization for the polymorphic record type.
 + reftable: add blocksource, an abstraction for random access reads
 + reftable: utility functions
 + reftable: add error related functionality
 + reftable: add LICENSE
 + hash.h: provide constants for the hash IDs

 The "reftable" backend for the refs API, without integrating into
 the refs subsystem, has been added.

 Will merge to 'master'.
 source: <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
