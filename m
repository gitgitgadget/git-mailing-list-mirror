Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA58C1FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 22:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbdC0Wf5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 18:35:57 -0400
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:51242 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbdC0Wfz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 18:35:55 -0400
Received: from pb-sasl-trial2.pobox.com (ro.sql.pobox.com [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 166E225D98;
        Mon, 27 Mar 2017 18:35:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=p
        On2QaQFQLUKRAO8CbQ2Tc4bi3g=; b=pgkfU6J/I2joW4bUYm15mfkUxJG/wf8wn
        39/QCdg0dKbl3kmNswBhLRIK9xTSlchLn7siD8CVEV+pKrmZqVySmOZWkIH2ppQo
        XQXSRxaEx7091L2BQ88qwtVoMaAhoqlNqtLd9WL26db+I685neBrX1yxhhGhdJic
        CHogg+0//Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=rEV
        A5t4lRUfJDbuXbggY2279N9kWQTLIZDwfDhOVUAxiHMUYGp+RvJ7s7Gf8CmCQJfb
        36OpkgYLHnax7NTrMHg8Fg0SnzcakymuTPnD3gsfYWHXU5XYI5zEvey94W3byGvd
        2CGBihg1okgS6oHsep/UN8LAMtNXXvaXSeiLk1uU=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id D928925D97;
        Mon, 27 Mar 2017 18:35:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E7E7684995;
        Mon, 27 Mar 2017 18:35:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2017, #11; Mon, 27)
X-master-at: e0ef7fe78c46e6919d249b9547948a3bb7321dea
X-next-at: f7d0c115f90496503bfc6438d37aefdbb8a4e9f5
Date:   Mon, 27 Mar 2017 15:35:45 -0700
Message-ID: <xmqqlgrqz6ta.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8AC50D4-133D-11E7-8C14-FC50AE2156B6-77302942!pb-smtp2.pobox.com
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

* jc/lint-runaway-here-doc (2017-03-23) 1 commit
  (merged to 'next' on 2017-03-24 at c1f1ca1bd7)
 + tests: lint for run-away here-doc

 The test framework learned to detect unterminated here documents.


* jk/prefix-filename (2017-03-21) 6 commits
  (merged to 'next' on 2017-03-22 at 6d180ed430)
 + bundle: use prefix_filename with bundle path
 + prefix_filename: simplify windows #ifdef
 + prefix_filename: return newly allocated string
 + prefix_filename: drop length parameter
 + prefix_filename: move docstring to header file
 + hash-object: fix buffer reuse with --path in a subdirectory

 Code clean-up with minor bugfixes.


* jk/quote-env-path-list-component (2017-03-22) 1 commit
  (merged to 'next' on 2017-03-24 at 78843c4f9d)
 + t5615: fix a here-doc syntax error

 A test fix.


* km/config-grammofix (2017-03-23) 1 commit
  (merged to 'next' on 2017-03-24 at 75ddbbc6f9)
 + doc/config: grammar fixes for core.{editor,commentChar}

 Doc update.


* km/t1400-modernization (2017-03-21) 5 commits
  (merged to 'next' on 2017-03-22 at e9c3154ca4)
 + t1400: use test_when_finished for cleanup
 + t1400: remove a set of unused output files
 + t1400: use test_path_is_* helpers
 + t1400: set core.logAllRefUpdates in "logged by touch" tests
 + t1400: rename test descriptions to be unique

 Code clean-up.


* sb/describe-broken (2017-03-22) 1 commit
  (merged to 'next' on 2017-03-24 at 2262cbf415)
 + builtin/describe: introduce --broken flag

 "git describe --dirty" dies when it cannot be determined if the
 state in the working tree matches that of HEAD (e.g. broken
 repository or broken submodule).  The command learned a new option
 "git describe --broken" to give "$name-broken" (where $name is the
 description of HEAD) in such a case.


* sb/push-options-via-transport (2017-03-22) 2 commits
  (merged to 'next' on 2017-03-24 at c5535bec3b)
 + remote-curl: allow push options
 + send-pack: send push options correctly in stateless-rpc case

 Recently we started passing the "--push-options" through the
 external remote helper interface; now the "smart HTTP" remote
 helper understands what to do with the passed information.


* sb/submodule-update-initial-runs-custom-script (2017-03-22) 1 commit
  (merged to 'next' on 2017-03-24 at 628200c3b1)
 + t7406: correct test case for submodule-update initial population

 A test fix.


* sb/t3600-rephrase (2017-03-22) 1 commit
  (merged to 'next' on 2017-03-24 at 5ec1eee490)
 + t3600: rename test to describe its functionality

 A test retitling.


* st/verify-tag (2017-03-24) 1 commit
  (merged to 'next' on 2017-03-24 at d26313d4ab)
 + t7004, t7030: fix here-doc syntax errors

 A few unterminated here documents in tests were fixed, which in
 turn revealed incorrect expectations the tests make. These tests
 have been updated.

--------------------------------------------------
[New Topics]

* ab/case-insensitive-upstream-and-push-marker (2017-03-27) 1 commit
 - rev-parse: match @{upstream}, @{u} and @{push} case-insensitively

 On many keyboards, typing "@{" involves holding down SHIFT key and
 one can easily end up with "@{Up..." when typing "@{upstream}".  As
 the upstream/push keywords do not appear anywhere else in the syntax,
 we can safely accept them case insensitively without introducing
 ambiguity or confusion  to solve this.

 Will merge to 'next'.


* bc/object-id (2017-03-26) 21 commits
 - Documentation: update and rename api-sha1-array.txt
 - Rename sha1_array to oid_array
 - Convert sha1_array_for_each_unique and for_each_abbrev to object_id
 - Convert sha1_array_lookup to take struct object_id
 - Convert remaining callers of sha1_array_lookup to object_id
 - Make sha1_array_append take a struct object_id *
 - sha1-array: convert internal storage for struct sha1_array to object_id
 - builtin/pull: convert to struct object_id
 - submodule: convert check_for_new_submodule_commits to object_id
 - sha1_name: convert disambiguate_hint_fn to take object_id
 - sha1_name: convert struct disambiguate_state to object_id
 - test-sha1-array: convert most code to struct object_id
 - parse-options-cb: convert sha1_array_append caller to struct object_id
 - fsck: convert init_skiplist to struct object_id
 - builtin/receive-pack: convert portions to struct object_id
 - builtin/receive-pack: fix incorrect pointer arithmetic
 - builtin/pull: convert portions to struct object_id
 - builtin/diff: convert to struct object_id
 - Convert GIT_SHA1_RAWSZ used for allocation to GIT_MAX_RAWSZ
 - Convert GIT_SHA1_HEXSZ used for allocation to GIT_MAX_HEXSZ
 - Define new hash-size constants for allocating memory

 Conversion from unsigned char [40] to struct object_id continues.


* rs/freebsd-getcwd-workaround (2017-03-26) 1 commit
 - strbuf: support long paths w/o read rights in strbuf_getcwd() on FreeBSD

 FreeBSD implementation of getcwd(3) behaved differently when an
 intermediate directory is unreadable/unsearchable depending on the
 length of the buffer provided, which our strbuf_getcwd() was not
 aware of.  strbuf_getcwd() has been taught to cope with it better.

 Will merge to 'next'.


* jk/sha1dc (2017-03-26) 1 commit
  (merged to 'next' on 2017-03-27 at 91bf9f06b4)
 + sha1dc: avoid CPP macro collisions

 sha1dc/sha1.c wanted to check the endianness of the target platform
 at compilation time and used a CPP macro with a rather overly
 generic name, "BIGENDIAN", to pass the result of the check around
 in the file.  It wasn't prepared for the same macro set to 0
 (false) by the platform to signal that the target is _not_ a big
 endian box, and assumed that the endianness detection logic it has
 alone would be the one that is setting the macro, resulting in a
 breakage on Windows.  This has been fixed by using a bit less
 generic name for the same purpose.

 Will merge to 'master'.


* mg/describe-debug-l10n (2017-03-27) 2 commits
 - l10n: de: translate describe debug terms
 - describe: localize debug output fully

 Some debugging output from "git describe" were marked for l10n,
 but some weren't.  Mark missing ones for l10n.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* sg/clone-refspec-from-command-line-config (2017-02-27) 1 commit
 - clone: respect configured fetch respecs during initial fetch

 Expecting a reroll.
 cf. <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
 cf. <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
 Some nits but looks ok.


* sk/dash-is-previous (2017-03-01) 5 commits
 - revert.c: delegate handling of "-" shorthand to setup_revisions
 - sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
 - revision.c: args starting with "-" might be a revision
 - revision.c: swap if/else blocks
 - revision.c: do not update argv with unknown option

 A dash "-" can be written to mean "the branch that was previously
 checked out" in more places.

 Needs review.
 cf. <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>


* ls/filter-process-delayed (2017-03-06) 1 commit
 - convert: add "status=delayed" to filter process protocol

 What's the status of this one???
 cf. <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>


* nd/worktree-move (2017-01-27) 7 commits
 . fixup! worktree move: new command
 . worktree remove: new command
 . worktree move: refuse to move worktrees with submodules
 . worktree move: accept destination as directory
 . worktree move: new command
 . worktree.c: add update_worktree_location()
 . worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Tentatively ejected as it seems to break 'pu' when merged.


* pb/bisect (2017-02-18) 28 commits
 - fixup! bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 - bisect--helper: remove the dequote in bisect_start()
 - bisect--helper: retire `--bisect-auto-next` subcommand
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--bisect-write` subcommand
 - bisect--helper: `bisect_replay` shell function in C
 - bisect--helper: `bisect_log` shell function in C
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: `bisect_state` & `bisect_head` shell function in C
 - bisect--helper: `bisect_autostart` shell function in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
 - t6030: no cleanup with bad merge base
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 - bisect--helper: `bisect_reset` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - t6030: explicitly test for bisection cleanup
 - bisect--helper: `bisect_clean_state` shell function in C
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Move more parts of "git bisect" to C.

 Expecting a reroll.
 cf. <CAFZEwPPXPPHi8KiEGS9ggzNHDCGhuqMgH9Z8-Pf9GLshg8+LPA@mail.gmail.com>
 cf. <CAFZEwPM9RSTGN54dzaw9gO9iZmsYjJ_d1SjUD4EzSDDbmh-XuA@mail.gmail.com>
 cf. <CAFZEwPNUXcNY9Qdz=_B7q2kQuaecPzJtTMGdv8YMUPEz2vnp8A@mail.gmail.com>


* sh/grep-tree-obj-tweak-output (2017-01-20) 2 commits
 - grep: use '/' delimiter for paths
 - grep: only add delimiter if there isn't one already

 "git grep", when fed a tree-ish as an input, shows each hit
 prefixed with "<tree-ish>:<path>:<lineno>:".  As <tree-ish> is
 almost always either a commit or a tag that points at a commit, the
 early part of the output "<tree-ish>:<path>" can be used as the
 name of the blob and given to "git show".  When <tree-ish> is a
 tree given in the extended SHA-1 syntax (e.g. "<commit>:", or
 "<commit>:<dir>"), however, this results in a string that does not
 name a blob (e.g. "<commit>::<path>" or "<commit>:<dir>:<path>").
 "git grep" has been taught to be a bit more intelligent about these
 cases and omit a colon (in the former case) or use slash (in the
 latter case) to produce "<commit>:<path>" and
 "<commit>:<dir>/<path>" that can be used as the name of a blob.

 Expecting a reroll?  Is this good enough with known limitations?


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.

 Will discard.

--------------------------------------------------
[Cooking]

* ab/test-readme-updates (2017-03-26) 3 commits
 - t/README: clarify the test_have_prereq documentation
 - t/README: change "Inside <X> part" to "Inside the <X> part"
 - t/README: link to metacpan.org, not search.cpan.org

 Doc updates.

 Will merge to 'next'.


* js/rebase-i-reword-to-run-hooks (2017-03-27) 3 commits
 - sequencer: allow the commit-msg hooks to run during a `reword`
 - sequencer: make commit options more extensible
 - t7504: document regression: reword no longer calls commit-msg

 A recent update to "rebase -i" stopped running hooks for the "git
 commit" command during "reword" action, which has been fixed.

 Will merge to 'next'.


* ab/branch-list-doc (2017-03-24) 2 commits
  (merged to 'next' on 2017-03-27 at 4bb47907ee)
 + branch doc: update description for `--list`
 + branch doc: change `git branch <pattern>` to use `<branchname>`

 Doc update.

 Will merge to 'master'.


* sg/completion-ctags (2017-03-23) 3 commits
  (merged to 'next' on 2017-03-27 at cf8c081f7d)
 + completion: offer ctags symbol names for 'git log -S', '-G' and '-L:'
 + completion: extract completing ctags symbol names into helper function
 + completion: put matching ctags symbol names directly into COMPREPLY
 (this branch uses sg/completion-refs-speedup.)

 Command line completion updates.

 Will merge to 'master'.


* sg/skip-prefix-in-prettify-refname (2017-03-23) 1 commit
  (merged to 'next' on 2017-03-27 at f7d0c115f9)
 + refs.c: use skip_prefix() in prettify_refname()

 Code cleanup.

 Will merge to 'master'.


* sb/submodule-short-status (2017-03-27) 7 commits
 - submodule.c: correctly handle nested submodules in is_submodule_modified
 - short status: improve reporting for submodule changes
 - submodule.c: stricter checking for submodules in is_submodule_modified
 - submodule.c: port is_submodule_modified to use porcelain 2
 - submodule.c: convert is_submodule_modified to use strbuf_getwholeline
 - submodule.c: factor out early loop termination in is_submodule_modified
 - submodule.c: use argv_array in is_submodule_modified

 The output from "git status --short" has been extended to show
 various kinds of dirtyness in submodules differently; instead of to
 "M" for modified, 'm' and '?' can be shown to signal changes only
 to the working tree of the submodule but not the commit that is
 checked out.

 Waiting for further comments.
 The endgame looked mostly OK.


* jk/fast-import-cleanup (2017-03-24) 4 commits
  (merged to 'next' on 2017-03-27 at 9f6058007f)
 + pack.h: define largest possible encoded object size
 + encode_in_pack_object_header: respect output buffer length
 + fast-import: use xsnprintf for formatting headers
 + fast-import: use xsnprintf for writing sha1s

 Code clean-up.

 Will merge to 'master'.


* jk/pager-in-use (2017-03-24) 1 commit
  (merged to 'next' on 2017-03-27 at 513f007025)
 + pager_in_use: use git_env_bool()

 Code clean-up.

 Will merge to 'master'.


* jh/memihash-opt (2017-03-24) 8 commits
  (merged to 'next' on 2017-03-24 at f1aa0c4d37)
 + name-hash: add test-lazy-init-name-hash to .gitignore
 + name-hash: add perf test for lazy_init_name_hash
 + name-hash: add test-lazy-init-name-hash
 + name-hash: perf improvement for lazy_init_name_hash
 + hashmap: document memihash_cont, hashmap_disallow_rehash api
 + hashmap: add disallow_rehash setting
 + hashmap: allow memihash computation to be continued
 + name-hash: specify initial size for istate.dir_hash table

 The name-hash used for detecting paths that are different only in
 cases (which matter on case insensitive filesystems) has been
 optimized to take advantage of multi-threading when it makes sense.

 Will merge to 'master'.


* sg/completion-refs-speedup (2017-03-23) 14 commits
  (merged to 'next' on 2017-03-27 at 6bb275710d)
 + completion: speed up branch and tag completion
 + completion: fill COMPREPLY directly when completing fetch refspecs
 + completion: fill COMPREPLY directly when completing refs
 + completion: let 'for-each-ref' sort remote branches for 'checkout' DWIMery
 + completion: let 'for-each-ref' filter remote branches for 'checkout' DWIMery
 + completion: let 'for-each-ref' strip the remote name from remote branches
 + completion: let 'for-each-ref' and 'ls-remote' filter matching refs
 + completion: don't disambiguate short refs
 + completion: don't disambiguate tags and branches
 + completion: support excluding full refs
 + completion: support completing fully qualified non-fast-forward refspecs
 + completion: support completing full refs after '--option=refs/<TAB>'
 + completion: wrap __git_refs() for better option parsing
 + completion: remove redundant __gitcomp_nl() options from _git_commit()
 (this branch is used by sg/completion-ctags.)

 The refs completion for large number of refs has been sped up,
 partly by giving up disambiguating ambiguous refs and partly by
 eliminating most of the shell processing between 'git for-each-ref'
 and 'ls-remote' and Bash's completion facility.

 Will merge to 'master'.


* mh/separate-ref-cache (2017-03-27) 20 commits
 - do_for_each_entry_in_dir(): delete function
 - files_pack_refs(): use reference iteration
 - commit_packed_refs(): use reference iteration
 - cache_ref_iterator_begin(): make function smarter
 - get_loose_ref_cache(): new function
 - get_loose_ref_dir(): function renamed from get_loose_refs()
 - do_for_each_entry_in_dir(): eliminate `offset` argument
 - refs: handle "refs/bisect/" in `loose_fill_ref_dir()`
 - ref-cache: use a callback function to fill the cache
 - refs: record the ref_store in ref_cache, not ref_dir
 - ref-cache: introduce a new type, ref_cache
 - refs: split `ref_cache` code into separate files
 - ref-cache: rename `remove_entry()` to `remove_entry_from_dir()`
 - ref-cache: rename `find_ref()` to `find_ref_entry()`
 - ref-cache: rename `add_ref()` to `add_ref_entry()`
 - refs_verify_refname_available(): use function in more places
 - refs_verify_refname_available(): implement once for all backends
 - refs_ref_iterator_begin(): new function
 - refs_read_raw_ref(): new function
 - get_ref_dir(): don't call read_loose_refs() for "refs/bisect"
 (this branch uses nd/files-backend-git-dir; is tangled with nd/prune-in-worktree and nd/worktree-kill-parse-ref.)

 The internals of the refs API around the cached refs has been
 streamlined.

 Waiting for nd/files-backend-git-dir to settle.


* ah/log-decorate-default-to-auto (2017-03-24) 1 commit
  (merged to 'next' on 2017-03-24 at ce353ebfb5)
 + log: if --decorate is not given, default to --decorate=auto

 The default behaviour of "git log" in an interactive session has
 been changed to enable "--decorate".

 Will merge to 'master'.


* ab/doc-submitting (2017-03-26) 2 commits
 - doc/SubmittingPatches: show how to get a CLI commit summary
 - doc/SubmittingPatches: clarify the casing convention for "area: change..."

 Doc update.

 Will merge to 'next'.


* bw/grep-recurse-submodules (2017-03-18) 2 commits
  (merged to 'next' on 2017-03-21 at a57e2f0129)
 + grep: fix builds with with no thread support
 + grep: set default output method

 Build fix for NO_PTHREADS build.

 Will merge to 'master'.


* ja/doc-l10n (2017-03-20) 3 commits
 - SQUASH???
 - l10n: add git-add.txt to localized man pages
 - l10n: introduce framework for localizing man pages

 A proposal to use po4a to localize our manual pages.


* tg/stash-push-fixup (2017-03-22) 3 commits
  (merged to 'next' on 2017-03-24 at e6b9e04213)
 + stash: keep untracked files intact in stash -k
 + stash: pass the pathspec argument to git reset
 + stash: don't show internal implementation details

 Recent enhancement to "git stash push" command to support pathspec
 to allow only a subset of working tree changes to be stashed away
 was found to be too chatty and exposed the internal implementation
 detail (e.g. when it uses reset to match the index to HEAD before
 doing other things, output from reset seeped out).  These, and
 other chattyness has been fixed.

 Will merge to 'master'.


* nd/prune-in-worktree (2017-03-27) 12 commits
 - rev-list: expose and document --single-worktree
 - revision.c: --reflog add HEAD reflog from all worktrees
 - files-backend: make reflog iterator go through per-worktree reflog
 - revision.c: --all adds HEAD from all worktrees
 - refs: remove dead for_each_*_submodule()
 - revision.c: use refs_for_each*() instead of for_each_*_submodule()
 - refs: add refs_head_ref()
 - refs: move submodule slash stripping code to get_submodule_ref_store
 - refs.c: refactor get_submodule_ref_store(), share common free block
 - revision.c: --indexed-objects add objects from all worktrees
 - revision.c: refactor add_index_objects_to_pending()
 - revision.h: new flag in struct rev_info wrt. worktree-related refs
 (this branch uses nd/files-backend-git-dir and nd/worktree-kill-parse-ref; is tangled with mh/separate-ref-cache.)

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.

 Waiting for nd/files-backend-git-dir to settle.


* nd/worktree-kill-parse-ref (2017-03-27) 4 commits
 - refs: kill set_worktree_head_symref()
 - worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
 - refs: introduce get_worktree_ref_store()
 - environment.c: fix potential segfault by get_git_common_dir()
 (this branch is used by nd/prune-in-worktree; uses nd/files-backend-git-dir; is tangled with mh/separate-ref-cache.)

 (hopefully) a beginning of safer "git worktree" that is resistant
 to "gc".

 Waiting for nd/files-backend-git-dir to settle.


* nd/files-backend-git-dir (2017-03-27) 28 commits
 - refs.h: add a note about sorting order of for_each_ref_*
 - t1406: new tests for submodule ref store
 - t1405: some basic tests on main ref store
 - t/helper: add test-ref-store to test ref-store functions
 - refs: delete pack_refs() in favor of refs_pack_refs()
 - files-backend: avoid ref api targetting main ref store
 - refs: new transaction related ref-store api
 - refs: add new ref-store api
 - refs: rename get_ref_store() to get_submodule_ref_store() and make it public
 - files-backend: replace submodule_allowed check in files_downcast()
 - refs: move submodule code out of files-backend.c
 - path.c: move some code out of strbuf_git_path_submodule()
 - refs.c: make get_main_ref_store() public and use it
 - refs.c: kill register_ref_store(), add register_submodule_ref_store()
 - refs.c: flatten get_ref_store() a bit
 - refs: rename lookup_ref_store() to lookup_submodule_ref_store()
 - refs.c: introduce get_main_ref_store()
 - files-backend: remove the use of git_path()
 - files-backend: add and use files_ref_path()
 - files-backend: add and use files_reflog_path()
 - files-backend: move "logs/" out of TMP_RENAMED_LOG
 - files-backend: convert git_path() to strbuf_git_path()
 - files-backend: make sure files_rename_ref() always reach the end
 - files-backend: add and use files_packed_refs_path()
 - files-backend: delete dead code in files_init_db()
 - files-backend.c: delete dead code in files_ref_iterator_begin()
 - files-backend: make files_log_ref_write() static
 - refs.h: add forward declaration for structs used in this file
 (this branch is used by mh/separate-ref-cache, nd/prune-in-worktree and nd/worktree-kill-parse-ref.)

 The "submodule" specific field in the ref_store structure is
 replaced with a more generic "gitdir" that can later be used also
 when dealing with ref_store that represents the set of refs visible
 from the other worktrees.

 Will merge to 'next' after waiting for a few days for further comments.
 Looking good.


* ab/ref-filter-no-contains (2017-03-24) 16 commits
 - tag: add tests for --with and --without
 - ref-filter: reflow recently changed branch/tag/for-each-ref docs
 - ref-filter: add --no-contains option to tag/branch/for-each-ref
 - tag: change --point-at to default to HEAD
 - tag: implicitly supply --list given another list-like option
 - tag: change misleading --list <pattern> documentation
 - parse-options: add OPT_NONEG to the "contains" option
 - tag: add more incompatibles mode tests
 - for-each-ref: partly change <object> to <commit> in help
 - tag tests: fix a typo in a test description
 - tag: remove a TODO item from the test suite
 - ref-filter: add test for --contains on a non-commit
 - ref-filter: make combining --merged & --no-merged an error
 - tag doc: reword --[no-]merged to talk about commits, not tips
 - tag doc: split up the --[no-]merged documentation
 - tag doc: move the description of --[no-]merged earlier

 "git tag/branch/for-each-ref" family of commands long allowed to
 filter the refs by "--contains X" (show only the refs that are
 descendants of X), "--merged X" (show only the refs that are
 ancestors of X), "--no-merged X" (show only the refs that are not
 ancestors of X).  One curious omission, "--no-contains X" (show
 only the refs that are not descendants of X) has been added to
 them.

 Will merge to 'next'.


* jc/name-rev (2017-03-16) 2 commits
 - name-rev: favor describing with tags and use committer date to tiebreak
 - name-rev: refactor logic to see if a new candidate is a better name

 "git name-rev" penalized lightweight tags too much, making them
 almost useless especially when the command is run with "--tags".
 Give the same precedence to lightweight tags as annotated tags as
 the base for naming a commit.

 Waiting for jc/p4-current-branch-fix to settle.


* bw/recurse-submodules-relative-fix (2017-03-17) 5 commits
 - ls-files: fix bug when recursing with relative pathspec
 - ls-files: fix typo in variable name
 - grep: fix bug when recursing with relative pathspec
 - setup: allow for prefix to be passed to git commands
 - grep: fix help text typo

 A few commands that recently learned the "--recurse-submodule"
 option misbehaved when started from a subdirectory of the
 superproject.

 Will merge to 'next'.


* jc/p4-current-branch-fix (2017-03-27) 2 commits
 - DONTMERGE git-p4: "name-rev HEAD" is not a way to find the current branch
 - git-p4: add failing test for name-rev rather than symbolic-ref

 "git p4" used "name-rev HEAD" when it wants to learn what branch is
 checked out; it should use "symbolic-ref HEAD".

 The tip one (i.e. real fix) needs to be redone by somebody
 competent with Python and git-p4 codebase.


* bw/submodule-is-active (2017-03-18) 10 commits
  (merged to 'next' on 2017-03-22 at 4c05cb5ab4)
 + submodule add: respect submodule.active and submodule.<name>.active
 + submodule--helper init: set submodule.<name>.active
 + clone: teach --recurse-submodules to optionally take a pathspec
 + submodule init: initialize active submodules
 + submodule: decouple url and submodule interest
 + submodule--helper clone: check for configured submodules using helper
 + submodule sync: use submodule--helper is-active
 + submodule sync: skip work for inactive submodules
 + submodule status: use submodule--helper is-active
 + submodule--helper: add is-active subcommand

 "what URL do we want to update this submodule?" and "are we
 interested in this submodule?" are split into two distinct
 concepts, and then the way used to express the latter got extended,
 paving a way to make it easier to manage a project with many
 submodules and make it possible to later extend use of multiple
 worktrees for a project with submodules.

 Will merge to 'master'.


* sb/checkout-recurse-submodules (2017-03-16) 19 commits
  (merged to 'next' on 2017-03-22 at 48b49d572c)
 + builtin/read-tree: add --recurse-submodules switch
 + builtin/checkout: add --recurse-submodules switch
 + entry.c: create submodules when interesting
 + unpack-trees: check if we can perform the operation for submodules
 + unpack-trees: pass old oid to verify_clean_submodule
 + update submodules: add submodule_move_head
 + submodule.c: get_super_prefix_or_empty
 + update submodules: move up prepare_submodule_repo_env
 + submodules: introduce check to see whether to touch a submodule
 + update submodules: add a config option to determine if submodules are updated
 + update submodules: add submodule config parsing
 + make is_submodule_populated gently
 + lib-submodule-update.sh: define tests for recursing into submodules
 + lib-submodule-update.sh: replace sha1 by hash
 + lib-submodule-update: teach test_submodule_content the -C <dir> flag
 + lib-submodule-update.sh: do not use ./. as submodule remote
 + lib-submodule-update.sh: reorder create_lib_submodule_repo
 + submodule--helper.c: remove duplicate code
 + connect_work_tree_and_git_dir: safely create leading directories

 "git checkout" is taught the "--recurse-submodules" option.

 Will merge to 'master'.


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2017-02-27 at 7373a1b73d)
 + setup_git_env: avoid blind fall-back to ".git"

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2017-02-27 at 2c0f5f73d8)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 Will cook in 'next'.


* jc/bundle (2016-03-03) 6 commits
 - index-pack: --clone-bundle option
 - Merge branch 'jc/index-pack' into jc/bundle
 - bundle v3: the beginning
 - bundle: keep a copy of bundle file name in the in-core bundle header
 - bundle: plug resource leak
 - bundle doc: 'verify' is not about verifying the bundle

 The beginning of "split bundle", which could be one of the
 ingredients to allow "git clone" traffic off of the core server
 network to CDN.
