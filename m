Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A126B1FD09
	for <e@80x24.org>; Mon, 29 May 2017 06:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbdE2GXv (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 02:23:51 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36208 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdE2GXr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 02:23:47 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so11169074pfb.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 23:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=PErsIfhVaWMEwRUfvgUhLtWK2YbYUNFRqgzozziZFZY=;
        b=t/fxnzhK7+wVfp5uy2XfG3qkKlbccODmUVx0v4yvGhwisdIKTbx7zrYwzelKOH/9os
         rWe30Cqp2ZtHK0Zg0ityNw1f+IbpRhfVvTWh57mrK5rlHbhU6iBNSteQoqo/pKTDyBBR
         B9267jsOyav7DGyqd7SqLg6EQqLIH5vuCUOB2dJl3L/abKMs1p0aG/FiHLmc6y0ppDoA
         AMFJ6ZBWjPcNvr/XKkFJUTxX3EZXRatdPqEt4dsSsrthP4noD39xDMfH/gnBQH5iEm4L
         rXgzGRudYdjIjR31D3NWtOooREKNyhRqahq6cOAN6qz8FxbFlL0/1JYiV5O0VvU6C5s2
         zXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=PErsIfhVaWMEwRUfvgUhLtWK2YbYUNFRqgzozziZFZY=;
        b=bpRCbmgwi/llok9h/oHzv4+ou/CxmAteX/v6Fgif0z7QHF2O1aT1gce0Peq7+Kw/V/
         isiY3pcZl3yH2xfYbFYyd+IUWxoq3I/hA0vafMcX7jrt08RkNIv1cZ6YyDYdPYj75V6X
         Mk0gYQO1Z3Y+VCLzJFfnqb5xsrewFdpZafv+t7IaAlIq+rfqD6aC96hc6FDJwnHFaFl9
         f2171WjSrsveLyixvsb3NQcURa68yvmmmyO/0lo2K7KsP2hDKE8iUJe711++JxpSsAaU
         6QfEuNudmsYzS6kyt5j42FSSA8LoB8HFjYvWazT2pRM5akbW32MDatEumPCepZ4/L2DW
         xE7w==
X-Gm-Message-State: AODbwcAG0+6HnlZ7gqQUEaetu31qAvMih4Ucf7SHrN9RSqyJVtJaa65x
        YvFUEwCVoERiokV3PLbakDw4
X-Received: by 10.99.101.132 with SMTP id z126mr17156079pgb.194.1496039025682;
        Sun, 28 May 2017 23:23:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id r69sm14880113pfi.33.2017.05.28.23.23.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 23:23:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2017, #08; Mon, 29)
X-master-at: e83352ef23cca2701953ed3c915f1db49b255a7d
X-next-at: 88ad292c901b5a8436ade109286d30c4942be41f
Date:   Mon, 29 May 2017 15:23:44 +0900
Message-ID: <xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

A bit more topics are now in 'master'.  One unfortunate thing is
that the SHA1 breakage in 2.13 for big-endian platforms were lost in
the noise with excitement felt by some subset of contributors with
the possible use of submodules.  The first step in the series is
neutral to the excitement, and should be fast-tracked down to
'maint' soonish.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/object-id (2017-05-08) 53 commits
  (merged to 'next' on 2017-05-20 at e7372733fb)
 + object: convert parse_object* to take struct object_id
 + tree: convert parse_tree_indirect to struct object_id
 + sequencer: convert do_recursive_merge to struct object_id
 + diff-lib: convert do_diff_cache to struct object_id
 + builtin/ls-tree: convert to struct object_id
 + merge: convert checkout_fast_forward to struct object_id
 + sequencer: convert fast_forward_to to struct object_id
 + builtin/ls-files: convert overlay_tree_on_cache to object_id
 + builtin/read-tree: convert to struct object_id
 + sha1_name: convert internals of peel_onion to object_id
 + upload-pack: convert remaining parse_object callers to object_id
 + revision: convert remaining parse_object callers to object_id
 + revision: rename add_pending_sha1 to add_pending_oid
 + http-push: convert process_ls_object and descendants to object_id
 + refs/files-backend: convert many internals to struct object_id
 + refs: convert struct ref_update to use struct object_id
 + ref-filter: convert some static functions to struct object_id
 + Convert struct ref_array_item to struct object_id
 + Convert the verify_pack callback to struct object_id
 + Convert lookup_tag to struct object_id
 + log-tree: convert to struct object_id
 + Convert lookup_tree to struct object_id
 + builtin/reflog: convert tree_is_complete to take struct object_id
 + tree: convert read_tree_1 to use struct object_id internally
 + Convert lookup_blob to struct object_id
 + Convert remaining callers of lookup_blob to object_id
 + builtin/unpack-objects: convert to struct object_id
 + pack: convert struct pack_idx_entry to struct object_id
 + Convert lookup_commit* to struct object_id
 + Convert remaining callers of lookup_commit_reference* to object_id
 + builtin/tag: convert to struct object_id
 + sequencer: convert some functions to struct object_id
 + shallow: convert shallow registration functions to object_id
 + revision: convert prepare_show_merge to struct object_id
 + notes-utils: convert internals to struct object_id
 + http-push: convert some static functions to struct object_id
 + tag: convert parse_tag_buffer to struct object_id
 + builtin/verify-commit: convert to struct object_id
 + reflog_expire: convert to struct object_id
 + parse-options-cb: convert to struct object_id
 + notes-cache: convert to struct object_id
 + submodule: convert merge_submodule to use struct object_id
 + fast-import: convert to struct object_id
 + fast-import: convert internal structs to struct object_id
 + builtin/rev-parse: convert to struct object_id
 + builtin/blame: convert static function to struct object_id
 + branch: convert to struct object_id
 + bundle: convert to struct object_id
 + builtin/prune: convert to struct object_id
 + builtin/name-rev: convert to struct object_id
 + Convert struct cache_tree to use struct object_id
 + Clean up outstanding object_id transforms.
 + fetch-pack: convert to struct object_id
 (this branch is used by mh/packed-ref-store-prep.)

 Conversion from uchar[20] to struct object_id continues.


* bm/interpret-trailers-cut-line-is-eom (2017-05-18) 1 commit
  (merged to 'next' on 2017-05-23 at 3e5ff08517)
 + interpret-trailers: honor the cut line

 "git interpret-trailers", when used as GIT_EDITOR for "git commit
 -v", looked for and appended to a trailer block at the very end,
 i.e. at the end of the "diff" output.  The command has been
 corrected to pay attention to the cut-mark line "commit -v" adds to
 the buffer---the real trailer block should appear just before it.


* bw/dir-c-stops-relying-on-the-index (2017-05-06) 14 commits
  (merged to 'next' on 2017-05-20 at 1f1b764ec8)
 + dir: convert fill_directory to take an index
 + dir: convert read_directory to take an index
 + dir: convert read_directory_recursive to take an index
 + dir: convert open_cached_dir to take an index
 + dir: convert is_excluded to take an index
 + dir: convert prep_exclude to take an index
 + dir: convert add_excludes to take an index
 + dir: convert is_excluded_from_list to take an index
 + dir: convert last_exclude_matching_from_list to take an index
 + dir: convert dir_add* to take an index
 + dir: convert get_dtype to take index
 + dir: convert directory_exists_in_index to take index
 + dir: convert read_skip_worktree_file_from_index to take an index
 + dir: stop using the index compatibility macros

 API update.


* ja/do-not-ask-needless-questions (2017-05-12) 3 commits
  (merged to 'next' on 2017-05-23 at 6b373cd892)
 + git-filter-branch: be more direct in an error message
 + read-tree -m: make error message for merging 0 trees less smart aleck
 + usability: don't ask questions if no reply is required

 Git sometimes gives an advice in a rhetorical question that does
 not require an answer, which can confuse new users and non native
 speakers.  Attempt to rephrase them.


* jc/read-tree-empty-with-m (2017-05-10) 1 commit
  (merged to 'next' on 2017-05-20 at 7e86815364)
 + read-tree: "read-tree -m --empty" does not make sense

 "git read-tree -m" (no tree-ish) gave a nonsense suggestion "use
 --empty if you want to clear the index".  With "-m", such a request
 will still fail anyway, as you'd need to name at least one tree-ish
 to be merged.


* jc/repack-threads (2017-04-27) 1 commit
  (merged to 'next' on 2017-05-20 at c1fd54a2a4)
 + repack: accept --threads=<n> and pass it down to pack-objects

 "git repack" learned to accept the --threads=<n> option and pass it
 to pack-objects.


* jk/alternate-ref-optim (2017-05-18) 1 commit
  (merged to 'next' on 2017-05-23 at 4b4b3ac463)
 + t5400: avoid concurrent writes into a trace file

 A test allowed both "git push" and "git receive-pack" on the other
 end write their traces into the same file.  This is OK on platforms
 that allows atomically appending to a file opened with O_APPEND,
 but on other platforms led to a mangled output, causing
 intermittent test failures.  This has been fixed by disabling
 traces from "receive-pack" in the test.


* jk/bug-to-abort (2017-05-22) 4 commits
  (merged to 'next' on 2017-05-22 at 20371eebb6)
 + usage: add NORETURN to BUG() function definitions
  (merged to 'next' on 2017-05-20 at db65acc882)
 + config: complain about --local outside of a git repo
 + setup_git_env: convert die("BUG") to BUG()
 + usage.c: add BUG() function

 Introduce the BUG() macro to improve die("BUG: ...").


* jk/diff-submodule-diff-inline (2017-05-08) 1 commit
  (merged to 'next' on 2017-05-20 at da7eb2626a)
 + diff: recurse into nested submodules for inline diff

 "git diff --submodule=diff" now recurses into nested submodules.


* jk/disable-pack-reuse-when-broken (2017-05-09) 2 commits
  (merged to 'next' on 2017-05-20 at 684e921273)
 + t5310: fix "; do" style
 + pack-objects: disable pack reuse for object-selection options

 "pack-objects" can stream a slice of an existing packfile out when
 the pack bitmap can tell that the reachable objects are all needed
 in the output, without inspecting individual objects.  This
 strategy however would not work well when "--local" and other
 options are in use, and need to be disabled.


* jk/doc-config-include (2017-05-12) 4 commits
  (merged to 'next' on 2017-05-23 at 4f60843265)
 + docs/config: consistify include.path examples
 + docs/config: avoid the term "expand" for includes
 + docs/config: give a relative includeIf example
 + docs/config: clarify include/includeIf relationship

 Clarify documentation for include.path and includeIf.<condition>.path
 configuration variables.


* jk/ignore-broken-tags-when-ignoring-missing-links (2017-05-20) 1 commit
  (merged to 'next' on 2017-05-23 at 977491e52a)
 + revision.c: ignore broken tags with ignore_missing_links

 Tag objects, which are not reachable from any ref, that point at
 missing objects were mishandled by "git gc" and friends (they
 should silently be ignored instead)


* jk/update-links-in-docs (2017-05-15) 1 commit
  (merged to 'next' on 2017-05-23 at 5b2df9fdbe)
 + doc: use https links to Wikipedia to avoid http redirects

 A few http:// links that are redirected to https:// in the
 documentation have been updated to https:// links.


* js/eol-on-ourselves (2017-05-10) 6 commits
  (merged to 'next' on 2017-05-20 at 8023c277d2)
 + t4051: mark supporting files as requiring LF-only line endings
 + Fix the remaining tests that failed with core.autocrlf=true
 + t3901: move supporting files into t/t3901/
 + completion: mark bash script as LF-only
 + git-new-workdir: mark script as LF-only
 + Fix build with core.autocrlf=true

 Make sure our tests would pass when the sources are checked out
 with "platform native" line ending convention by default on
 Windows.  Some "text" files out tests use and the test scripts
 themselves that are meant to be run with /bin/sh, ought to be
 checked out with eol=LF even on Windows.


* js/plug-leaks (2017-05-09) 26 commits
  (merged to 'next' on 2017-05-20 at fb136ea2dc)
 + checkout: fix memory leak
 + submodule_uses_worktrees(): plug memory leak
 + show_worktree(): plug memory leak
 + name-rev: avoid leaking memory in the `deref` case
 + remote: plug memory leak in match_explicit()
 + add_reflog_for_walk: avoid memory leak
 + shallow: avoid memory leak
 + line-log: avoid memory leak
 + receive-pack: plug memory leak in update()
 + fast-export: avoid leaking memory in handle_tag()
 + mktree: plug memory leaks reported by Coverity
 + pack-redundant: plug memory leak
 + setup_discovered_git_dir(): plug memory leak
 + setup_bare_git_dir(): help static analysis
 + split_commit_in_progress(): simplify & fix memory leak
 + checkout: fix memory leak
 + cat-file: fix memory leak
 + mailinfo & mailsplit: check for EOF while parsing
 + status: close file descriptor after reading git-rebase-todo
 + difftool: address a couple of resource/memory leaks
 + get_mail_commit_oid(): avoid resource leak
 + git_config_rename_section_in_file(): avoid resource leak
 + add_commit_patch_id(): avoid allocating memory unnecessarily
 + winansi: avoid buffer overrun
 + winansi: avoid use of uninitialized value
 + mingw: avoid memory leak when splitting PATH

 Fix memory leaks pointed out by Coverity (and people).


* km/log-showsignature-doc (2017-05-20) 1 commit
  (merged to 'next' on 2017-05-23 at f43ea11956)
 + config.txt: add an entry for log.showSignature

 Doc update.


* kn/ref-filter-branch-list (2017-05-20) 1 commit
  (merged to 'next' on 2017-05-23 at e0cc721af0)
 + ref-filter: resolve HEAD when parsing %(HEAD) atom

 "git for-each-ref --format=..." with %(HEAD) in the format used to
 resolve the HEAD symref as many times as it had processed refs,
 which was wasteful, and "git branch" shared the same problem.


* nd/split-index-unshare (2017-05-08) 2 commits
  (merged to 'next' on 2017-05-20 at 9048cdc2ce)
 + p3400: add perf tests for rebasing many changes
 + split-index: add and use unshare_split_index()

 Plug some leaks and updates internal API used to implement the
 split index feature to make it easier to avoid such a leak in the
 future.


* pw/rebase-i-regression-fix (2017-05-20) 3 commits
  (merged to 'next' on 2017-05-23 at 14676d0013)
 + rebase -i: add missing newline to end of message
 + rebase -i: silence stash apply
 + rebase -i: fix reflog message

 Regression fix to topic recently merged to 'master'.


* sb/checkout-recurse-submodules (2017-05-04) 3 commits
  (merged to 'next' on 2017-05-20 at f972b2069f)
 + submodule: properly recurse for read-tree and checkout
 + submodule: avoid auto-discovery in new working tree manipulator code
 + submodule_move_head: reuse child_process structure for futher commands

 "git checkout --recurse-submodules" did not quite work with a
 submodule that itself has submodules.


* sb/reset-recurse-submodules (2017-04-23) 4 commits
  (merged to 'next' on 2017-05-20 at 8adafdf1be)
 + builtin/reset: add --recurse-submodules switch
 + submodule.c: submodule_move_head works with broken submodules
 + submodule.c: uninitialized submodules are ignored in recursive commands
 + entry.c: submodule recursing: respect force flag correctly
 (this branch is used by sb/submodule-blanket-recursive.)

 "git reset" learned "--recurse-submodules" option.


* tg/stash-push-fixup (2017-05-17) 1 commit
  (merged to 'next' on 2017-05-23 at 338eb650f2)
 + completion: add git stash push

 The shell completion script (in contrib/) learned "git stash" has
 a new "push" subcommand.

--------------------------------------------------
[New Topics]

* ab/pcre-v2 (2017-05-26) 7 commits
 - grep: add support for PCRE v2
 - grep: un-break building with PCRE < 8.20
 - grep: un-break building with PCRE < 8.32
 - grep: add support for the PCRE v1 JIT API
 - log: add -P as a synonym for --perl-regexp
 - grep: skip pthreads overhead when using one thread
 - grep: don't redundantly compile throwaway patterns under threading
 (this branch uses ab/grep-preparatory-cleanup.)

 Update "perl-compatible regular expression" support to enable JIT
 and also allow linking with the newer PCRE v2 library.

 Will merge to 'next'.


* ab/ref-filter-no-contains (2017-05-23) 1 commit
  (merged to 'next' on 2017-05-29 at 5d39fd2961)
 + tag: duplicate mention of --contains should mention --no-contains

 Doc update to a recent topic.

 Will merge to 'master'.


* rs/mingw-path-lookup-simplify (2017-05-23) 1 commit
  (merged to 'next' on 2017-05-29 at 4365139a7f)
 + mingw: simplify PATH handling

 Code simplification.

 Will merge to 'master'.


* ab/sha1dc-maint (2017-05-22) 1 commit
 - sha1dc: update from upstream
 (this branch is used by ab/sha1dc.)

 The "collision detecting" SHA-1 implementation shipped with 2.13
 was quite broken on some big-endian platforms and/or platforms that
 do not like unaligned fetches.  Update to the upstream code which
 has already fixed these issues.

 Will merge to 'next'.


* ab/t3070-test-dedup (2017-05-29) 1 commit
 - wildmatch test: remove redundant duplicate test

 Test cleanup.

 Will merge to 'next'.


* ah/doc-filter-branch-export-env (2017-05-29) 1 commit
 - doc: filter-branch does not require re-export of vars

 Docfix.

 Will merge to 'next'.


* jk/connect-symref-info-leak-fix (2017-05-26) 1 commit
 - connect.c: fix leak in parse_one_symref_info()

 Leakfix.

 Will merge to 'next'.


* jk/pathspec-magic-disambiguation (2017-05-29) 6 commits
 - verify_filename(): flip order of checks
 - verify_filename(): treat ":(magic)" as a pathspec
 - check_filename(): handle ":^" path magic
 - check_filename(): use skip_prefix
 - check_filename(): refactor ":/" handling
 - t4208: add check for ":/" without matching file

 The convention for a command line is to follow "git cmdname
 --options" with revisions followed by an optional "--"
 disambiguator and then finally pathspecs.  When "--" is not there,
 we make sure early ones are all interpretable as revs (and do not
 look like paths) and later ones are the other way around.  A
 pathspec with "magic" (e.g. ":/p/a/t/h" that matches p/a/t/h from
 the top-level of the working tree, no matter what subdirectory you
 are working from) are conservatively judged as "not a path", which
 required disambiguation more often.  The command line parser
 learned to say "it's a pathspec" a bit more often when the syntax
 looks like so.


* sd/t3200-typofix (2017-05-29) 1 commit
 - branch test: fix invalid config key access

 Test fix.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


* mg/name-rev-debug (2017-03-31) 2 commits
 - describe: pass --debug down to name-rev
 - name-rev: provide debug output
 (this branch uses jc/name-rev-lw-tag.)

 "git describe --debug --contains" did not add any meaningful
 information, even though without "--contains" it did.

 Will discard for now.
 cf. <c85bc2a1-56d8-8a02-6089-2b8cb3d39e99@grubix.eu>


* nd/worktree-move (2017-04-20) 6 commits
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Expecting a reroll.
 cf. <20170420101024.7593-1-pclouds@gmail.com>
 cf. <20170421145916.mknekgqzhxffu7di@sigill.intra.peff.net>
 cf. <d0e81b1e-5869-299e-f462-4d43dc997bd1@ramsayjones.plus.com>


* ls/filter-process-delayed (2017-03-06) 1 commit
 - convert: add "status=delayed" to filter process protocol

 Expecting a reroll.
 cf. <04ECEBE5-CAC8-4344-B07A-6B7A7C795C94@gmail.com>


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

--------------------------------------------------
[Cooking]

* ah/doc-interpret-trailers-ifexists (2017-05-23) 1 commit
  (merged to 'next' on 2017-05-29 at cb353c1d21)
 + Documentation: fix reference to ifExists for interpret-trailers

 Documentation fix.

 Will merge to 'master'.


* ah/doc-pretty-format-fix (2017-05-23) 1 commit
  (merged to 'next' on 2017-05-29 at 6e3e8fd80d)
 + Documentation: fix formatting typo in pretty-formats.txt

 Documentation fix.

 Will merge to 'master'.


* sb/t5531-update-desc (2017-05-23) 1 commit
  (merged to 'next' on 2017-05-29 at 67a91db3cf)
 + t5531: fix test description

 The description strings for a few tests have been updated.

 Will merge to 'master'.


* ab/conditional-config-with-symlinks (2017-05-17) 1 commit
  (merged to 'next' on 2017-05-23 at 6162222c2e)
 + config: match both symlink & realpath versions in IncludeIf.gitdir:*

 The recently introduced "[includeIf "gitdir:$dir"] path=..."
 mechansim has further been taught to take symlinks into account.
 The directory "$dir" specified in "gitdir:$dir" may be a symlink to
 a real location, not something that $(getcwd) may return.  In such
 a case, a realpath of "$dir" is compared with the real path of the
 current repository to determine if the contents from the named path
 should be included.

 Will merge to 'master'.


* jc/skip-test-in-the-middle (2017-05-18) 2 commits
  (merged to 'next' on 2017-05-23 at 6c962b353b)
 + t5545: enhance test coverage when no http server is installed
 + test: allow skipping the remainder

 A recent update to t5545-push-options.sh started skipping all the
 tests in the script when a web server testing is disabled or
 unavailable, not just the ones that require a web server.  Non HTTP
 tests have been salvaged to always run in this script.

 Will merge to 'master'.


* mh/packed-ref-store-prep (2017-05-24) 26 commits
  (merged to 'next' on 2017-05-29 at e4f5e06b4c)
 + cache_ref_iterator_begin(): avoid priming unneeded directories
 + ref-filter: limit traversal to prefix
 + create_ref_entry(): remove `check_name` option
 + refs_ref_iterator_begin(): handle `GIT_REF_PARANOIA`
 + read_packed_refs(): report unexpected fopen() failures
 + read_packed_refs(): do more of the work of reading packed refs
 + get_packed_ref_cache(): assume "packed-refs" won't change while locked
 + should_pack_ref(): new function, extracted from `files_pack_refs()`
 + ref_update_reject_duplicates(): add a sanity check
 + ref_update_reject_duplicates(): use `size_t` rather than `int`
 + ref_update_reject_duplicates(): expose function to whole refs module
 + ref_transaction_prepare(): new optional step for reference updates
 + ref_transaction_commit(): check for valid `transaction->state`
 + files_transaction_cleanup(): new helper function
 + files_ref_store: put the packed files lock directly in this struct
 + files-backend: move `lock` member to `files_ref_store`
 + lockfile: add a new method, is_lock_file_locked()
 + ref_store: take a `msg` parameter when deleting references
 + refs: use `size_t` indexes when iterating over ref transaction updates
 + refs_ref_iterator_begin(): don't check prefixes redundantly
 + prefix_ref_iterator: don't trim too much
 + files-backend: use `die("BUG: ...")`, not `die("internal error: ...")`
 + ref_iterator_begin_fn(): fix docstring
 + refs.h: clarify docstring for the ref_transaction_update()-related fns
 + t3600: clean up permissions test properly
 + Merge branch 'bc/object-id'

 The implementation of "ref" API around the "packed refs" have been
 cleaned up, in preparation for further changes.

 Will merge to 'master'.


* sl/clean-d-ignored-fix (2017-05-24) 6 commits
  (merged to 'next' on 2017-05-29 at 837c255ae8)
 + clean: teach clean -d to preserve ignored paths
 + dir: expose cmp_name() and check_contains()
 + dir: hide untracked contents of untracked dirs
 + dir: recurse into untracked dirs for ignored files
 + t7061: status --ignored should search untracked dirs
 + t7300: clean -d should skip dirs with ignored files

 "git clean -d" used to clean directories that has ignored files,
 even though the command should not lose ignored ones without "-x".
 This has been corrected.

 Will merge to 'master'.


* ab/sha1dc (2017-05-22) 2 commits
 - sha1collisiondetection: automatically enable when submodule is populated
 - sha1dc: optionally use sha1collisiondetection as a submodule
 (this branch uses ab/sha1dc-maint.)

 The "collission-detecting" implementation of SHA-1 hash we borrowed
 from is replaced by directly binding the upstream project as our
 submodule.

 Will keep in 'pu' for a few CI cycles.
 Impact to the various build and release infrastructure of using
 submodule is not yet fully known, but this lets us dip our toes.


* bp/fsmonitor (2017-05-26) 6 commits
 - fsmonitor: add a sample query-fsmonitor hook script for Watchman
 - fsmonitor: add documentation for the fsmonitor extension.
 - fsmonitor: add test cases for fsmonitor extension
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - dir: make lookup_untracked() available outside of dir.c
 - bswap: add 64 bit endianness helper get_be64


* dk/send-email-avoid-net-smtp-ssl-when-able (2017-05-20) 1 commit
  (merged to 'next' on 2017-05-23 at fc59b8a1d4)
 + send-email: Net::SMTP::SSL is obsolete, use only when necessary

 "git send-email" now uses Net::SMTP::SSL, which is obsolete, only
 when needed.  Recent versions of Net::SMTP can do TLS natively.

 Will merge to 'master'.


* jc/name-rev-lw-tag (2017-03-29) 2 commits
  (merged to 'next' on 2017-05-23 at 3f88b6d73c)
 + name-rev: favor describing with tags and use committer date to tiebreak
 + name-rev: refactor logic to see if a new candidate is a better name
 (this branch is used by mg/name-rev-debug.)

 "git describe --contains" penalized light-weight tags so much that
 they were almost never considered.  Instead, give them about the
 same chance to be considered as an annotated tag that is the same
 age as the underlying commit would.

 Will merge to 'master'.


* jk/diff-blob (2017-05-24) 15 commits
  (merged to 'next' on 2017-05-29 at 5ecc979cc7)
 + diff: use blob path for blob/file diffs
 + diff: use pending "path" if it is available
 + diff: use the word "path" instead of "name" for blobs
 + diff: pass whole pending entry in blobinfo
 + handle_revision_arg: record paths for pending objects
 + handle_revision_arg: record modes for "a..b" endpoints
 + t4063: add tests of direct blob diffs
 + get_sha1_with_context: dynamically allocate oc->path
 + get_sha1_with_context: always initialize oc->symlink_path
 + sha1_name: consistently refer to object_context as "oc"
 + handle_revision_arg: add handle_dotdot() helper
 + handle_revision_arg: hoist ".." check out of range parsing
 + handle_revision_arg: stop using "dotdot" as a generic pointer
 + handle_revision_arg: simplify commit reference lookups
 + handle_revision_arg: reset "dotdot" consistently

 The result from "git diff" that compares two blobs, e.g. "git diff
 $commit1:$path $commit2:$path", used to be shown with the full
 object name as given on the command line, but it is more natural to
 use the $path in the output and use it to look up .gitattributes.

 Will merge to 'master'.


* js/bs-is-a-dir-sep-on-windows (2017-05-26) 2 commits
  (merged to 'next' on 2017-05-26 at 450b39f726)
 + Windows: do not treat a path with backslashes as a remote's nick name
 + mingw.h: permit arguments with side effects for is_dir_sep

 "foo\bar\baz" in "git fetch foo\bar\baz", even though there is no
 slashes in it, cannot be a nickname for a remote on Windows, as
 that is likely to be a pathname on a local filesystem.

 Will merge to 'master'.


* js/larger-timestamps (2017-05-20) 1 commit
  (merged to 'next' on 2017-05-23 at 16f7c9e677)
 + name-rev: change a "long" variable to timestamp_t

 A follow-up hotfix for a topic already in 'master'.

 Will merge to 'master'.


* sb/diff-color-move (2017-05-25) 17 commits
 - diff.c: color moved lines differently
 - diff: buffer all output if asked to
 - diff.c: emit_line includes whitespace highlighting
 - diff.c: convert diff_summary to use emit_line_*
 - diff.c: convert diff_flush to use emit_line_*
 - diff.c: convert word diffing to use emit_line_*
 - diff.c: convert show_stats to use emit_line_*
 - diff.c: convert emit_binary_diff_body to use emit_line_*
 - submodule.c: convert show_submodule_summary to use emit_line_fmt
 - diff.c: convert emit_rewrite_lines to use emit_line_*
 - diff.c: convert emit_rewrite_diff to use emit_line_*
 - diff.c: convert builtin_diff to use emit_line_*
 - diff.c: convert fn_out_consume to use emit_line
 - diff: introduce more flexible emit function
 - diff.c: factor out diff_flush_patch_all_file_pairs
 - diff: move line ending check into emit_hunk_header
 - diff: readability fix

 "git diff" has been taught to optionally paint new lines that are
 the same as deleted lines elsewhere differently from genuinely new
 lines.


* xz/send-email-batch-size (2017-05-23) 1 commit
 - send-email: --batch-size to work around some SMTP server limit

 "git send-email" learned to overcome some SMTP server limitation
 that does not allow many pieces of e-mails to be sent over a single
 session.

 Waiting for response.
 cf. <CACBZZX5GYV50rjg9X602JHqFPaoofH9TwDf_-r_MDu8-rmNV6Q@mail.gmail.com>


* jh/memihash-opt (2017-05-16) 5 commits
  (merged to 'next' on 2017-05-23 at 2f0293e8b8)
 + p0004: don't error out if test repo is too small
 + p0004: don't abort if multi-threaded is too slow
 + p0004: use test_perf
 + p0004: avoid using pipes
 + p0004: simplify calls of test-lazy-init-name-hash

 perf-test update.

 Will merge to 'master'.


* js/blame-lib (2017-05-25) 29 commits
 - blame: move entry prepend to libgit
 - blame: move scoreboard setup to libgit
 - blame: move scoreboard-related methods to libgit
 - blame: move fake-commit-related methods to libgit
 - blame: move origin-related methods to libgit
 - blame: move core structures to header
 - blame: create entry prepend function
 - blame: create scoreboard setup function
 - blame: create scoreboard init function
 - blame: rework methods that determine 'final' commit
 - blame: wrap blame_sort and compare_blame_final
 - blame: move progress updates to a scoreboard callback
 - blame: make sanity_check use a callback in scoreboard
 - blame: move no_whole_file_rename flag to scoreboard
 - blame: move xdl_opts flags to scoreboard
 - blame: move show_root flag to scoreboard
 - blame: move reverse flag to scoreboard
 - blame: move contents_from to scoreboard
 - blame: move copy/move thresholds to scoreboard
 - blame: move stat counters to scoreboard
 - blame: rename nth_line function
 - blame: rename ent_score function
 - blame: rename coalesce function
 - blame: rename origin-related functions
 - blame: rename scoreboard structure to blame_scoreboard
 - blame: rename origin structure to blame_origin
 - blame: remove unused parameters
 - blame: move textconv_object with related functions
 - blame: remove unneeded dependency on blob.h

 The internal logic used in "git blame" has been libified to make it
 easier to use by cgit.

 Will merge to 'next'.


* jt/send-email-validate-hook (2017-05-16) 1 commit
  (merged to 'next' on 2017-05-23 at 89848cb9ac)
 + send-email: support validate hook

 "git send-email" learned to run sendemail-validate hook to inspect
 and reject a message before sending it out.

 Will merge to 'master'.


* bw/pathspec-sans-the-index (2017-05-12) 6 commits
  (merged to 'next' on 2017-05-23 at 45c8ef3115)
 + pathspec: convert find_pathspecs_matching_against_index to take an index
 + pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP
 + ls-files: prevent prune_cache from overeagerly pruning submodules
 + pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag
 + submodule: add die_in_unpopulated_submodule function
 + pathspec: provide a more descriptive die message

 Simplify parse_pathspec() codepath and stop it from looking at the
 default in-core index.

 Will merge to 'master'.


* jt/fetch-allow-tip-sha1-implicitly (2017-05-16) 1 commit
  (merged to 'next' on 2017-05-23 at 690ed987df)
 + fetch-pack: always allow fetching of literal SHA1s

 There is no good reason why "git fetch $there $sha1" should fail
 when the $sha1 names an object at the tip of an advertised ref,
 even when the other side hasn't enabled allowTipSHA1InWant.

 Will merge to 'master'.


* ab/perf-wildmatch (2017-05-12) 2 commits
  (merged to 'next' on 2017-05-23 at 0adb7dac31)
 + perf: add test showing exponential growth in path globbing
 + perf: add function to setup a fresh test repo

 Add perf-test for wildmatch.

 Will merge to 'master'.


* ab/grep-preparatory-cleanup (2017-05-26) 31 commits
  (merged to 'next' on 2017-05-29 at f2cfa89d3e)
 + grep: assert that threading is enabled when calling grep_{lock,unlock}
 + grep: given --threads with NO_PTHREADS=YesPlease, warn
 + pack-objects: fix buggy warning about threads
 + pack-objects & index-pack: add test for --threads warning
 + test-lib: add a PTHREADS prerequisite
 + grep: move is_fixed() earlier to avoid forward declaration
 + grep: change internal *pcre* variable & function names to be *pcre1*
 + grep: change the internal PCRE macro names to be PCRE1
 + grep: factor test for \0 in grep patterns into a function
 + grep: remove redundant regflags assignments
 + grep: catch a missing enum in switch statement
 + perf: add a comparison test of log --grep regex engines with -F
 + perf: add a comparison test of log --grep regex engines
 + perf: add a comparison test of grep regex engines with -F
 + perf: add a comparison test of grep regex engines
 + perf: emit progress output when unpacking & building
 + perf: add a GIT_PERF_MAKE_COMMAND for when *_MAKE_OPTS won't do
 + grep: add tests to fix blind spots with \0 patterns
 + grep: prepare for testing binary regexes containing rx metacharacters
 + grep: add a test helper function for less verbose -f \0 tests
 + grep: add tests for grep pattern types being passed to submodules
 + grep: amend submodule recursion test for regex engine testing
 + grep: add tests for --threads=N and grep.threads
 + grep: change non-ASCII -i test to stop using --debug
 + grep: add a test for backreferences in PCRE patterns
 + grep: add a test asserting that --perl-regexp dies when !PCRE
 + log: make --regexp-ignore-case work with --perl-regexp
 + log: add exhaustive tests for pattern style options & config
 + test-lib: rename the LIBPCRE prerequisite to PCRE
 + grep & rev-list doc: stop promising libpcre for --perl-regexp
 + Makefile & configure: reword inaccurate comment about PCRE
 (this branch is used by ab/pcre-v2.)

 The internal implementation of "git grep" has seen some clean-up.

 Will merge to 'master'.


* dt/unpack-save-untracked-cache-extension (2017-05-20) 1 commit
  (merged to 'next' on 2017-05-23 at 3196d093d6)
 + unpack-trees: preserve index extensions

 When "git checkout", "git merge", etc. manipulates the in-core
 index, various pieces of information in the index extensions are
 discarded from the original state, as it is usually not the case
 that they are kept up-to-date and in-sync with the operation on the
 main index.  The untracked cache extension is copied across these
 operations now, which would speed up "git status" (as long as the
 cache is properly invalidated).

 Will merge to 'master'.


* sg/clone-refspec-from-command-line-config (2017-05-16) 4 commits
 - clone: use free_refspec() to free refspec list
 - remote: drop free_refspecs() function
 - Documentation/clone: document ignored configuration variables
 - clone: respect additional configured fetch refspecs during initial fetch

 "git clone -c var=val" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.

 Waiting for response.
 cf. <xmqqa864kops.fsf@gitster.mtv.corp.google.com>


* jh/close-index-before-stat (2017-04-28) 1 commit
  (merged to 'next' on 2017-05-16 at 0c0372eb02)
 + read-cache: close index.lock in do_write_index

 Originally merged to 'next' on 2017-04-30

 The timestamp of the index file is now taken after the file is
 closed, to help Windows, on which a stale timestamp is reported by
 fstat() on a file that is opened for writing and data was written
 but not yet closed.

 Will cook in 'next'.


* mb/diff-default-to-indent-heuristics (2017-05-09) 4 commits
  (merged to 'next' on 2017-05-29 at 7645575e21)
 + add--interactive: drop diff.indentHeuristic handling
 + diff: enable indent heuristic by default
 + diff: have the diff-* builtins configure diff before initializing revisions
 + diff: make the indent heuristic part of diff's basic configuration

 Make the "indent" heuristics the default in "diff" and diff.indentHeuristics
 configuration variable an escape hatch for those who do no want it.

 Will merge to 'master'.
 Looks like there may be follow-on work possible, but the topic
 itself is in good order.
 cf. <20170509033258.q7auj5p5lxs4tggd@sigill.intra.peff.net>


* nd/fopen-errors (2017-05-26) 13 commits
 - is_missing_file_error(): work around EINVAL on Windows
 - wrapper: factor out is_missing_file_error()
 - log: fix memory leak in open_next_file()
 - rerere.c: move error_errno() closer to the source system call
 - print errno when reporting a system call error
 - wrapper.c: make warn_on_inaccessible() static
 - wrapper.c: add and use fopen_or_warn()
 - wrapper.c: add and use warn_on_fopen_errors()
 - config.mak.uname: set FREAD_READS_DIRECTORIES for Darwin, too
 - config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
 - clone: use xfopen() instead of fopen()
 - use xfopen() in more places
 - git_fopen: fix a sparse 'not declared' warning

 We often try to open a file for reading whose existence is
 optional, and silently ignore errors from open/fopen; report such
 errors if they are not due to missing files.

 Waiting for comments on the two changes at the tip from Windows folks.


* js/rebase-i-final (2017-05-02) 10 commits
 - rebase -i: rearrange fixup/squash lines using the rebase--helper
 - t3415: test fixup with wrapped oneline
 - rebase -i: skip unnecessary picks using the rebase--helper
 - rebase -i: check for missing commits in the rebase--helper
 - t3404: relax rebase.missingCommitsCheck tests
 - rebase -i: also expand/collapse the SHA-1s via the rebase--helper
 - rebase -i: do not invent onelines when expanding/collapsing SHA-1s
 - rebase -i: remove useless indentation
 - rebase -i: generate the script via rebase--helper
 - t3415: verify that an empty instructionFormat is handled as before

 The final batch to "git rebase -i" updates to move more code from
 the shell script to C.

 Undecided; expecting a reroll.
 This is at its v4.
 cf. <cover.1493414945.git.johannes.schindelin@gmx.de>


* bw/forking-and-threading (2017-05-15) 14 commits
  (merged to 'next' on 2017-05-23 at 79a6a59851)
 + usage.c: drop set_error_handle()
 + run-command: restrict PATH search to executable files
 + run-command: expose is_executable function
 + run-command: block signals between fork and execve
 + run-command: add note about forking and threading
 + run-command: handle dup2 and close errors in child
 + run-command: eliminate calls to error handling functions in child
 + run-command: don't die in child when duping /dev/null
 + run-command: prepare child environment before forking
 + string-list: add string_list_remove function
 + run-command: use the async-signal-safe execv instead of execvp
 + run-command: prepare command before forking
 + t0061: run_command executes scripts without a #! line
 + t5550: use write_script to generate post-update hook

 The "run-command" API implementation has been made more robust
 against dead-locking in a threaded environment.

 Will merge to 'master'.


* bp/sub-process-convert-filter (2017-05-15) 11 commits
  (merged to 'next' on 2017-05-23 at 89f5420a82)
 + convert: update subprocess_read_status() to not die on EOF
 + sub-process: move sub-process functions into separate files
 + convert: rename reusable sub-process functions
 + convert: update generic functions to only use generic data structures
 + convert: separate generic structures and variables from the filter specific ones
 + convert: split start_multi_file_filter() into two separate functions
 + pkt-line: annotate packet_writel with LAST_ARG_MUST_BE_NULL
 + convert: move packet_write_line() into pkt-line as packet_writel()
 + pkt-line: add packet_read_line_gently()
 + pkt-line: fix packet_read_line() to handle len < 0 errors
 + convert: remove erroneous tests for errno == EPIPE

 Code from "conversion using external process" codepath has been
 extracted to a separate sub-process.[ch] module.

 Will merge to 'master'.


* nd/prune-in-worktree (2017-04-24) 12 commits
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

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.

 Expecting a reroll.
 Has been waiting for nd/worktree-kill-parse-ref to settle.
 cf. <CACsJy8ADCVBiLoPg_Tz0L6CMdh_eFmK4RYzfQ-PmUgBK7w9e=A@mail.gmail.com>

--------------------------------------------------
[Discard]

* ab/compat-regex-update (2017-05-12) 3 commits
 . DONTMERGE compat/regex: make it compile with -Werror=int-to-pointer-cast
 . compat/regex: update the gawk regex engine from upstream
 . compat/regex: add a README with a maintenance guide

 Update compat/regex we borrowed from gawk.  It seems that some
 customizations we made to the older one were dropped by mistake.

 Will discard.
 cf. <CACBZZX4UUwzRQmyH8joYaqHnuVTjVtGBHp+iZKcnAnwoM_ZJhg@mail.gmail.com>


* jk/no-looking-at-dotgit-outside-repo (2017-05-15) 1 commit
 . config: complain about --local outside of a git repo

 Will discard.
 Superseded by jk/bug-to-abort.


* js/retire-old-remote-spec (2017-05-12) 11 commits
 . PREVIEW: remove support for .git/remotes/ and .git/branches/
 . PREVIEW: t0060: stop testing support for .git/remotes/ and .git/branches/
 . PREVIEW: t5515: remove .git/remotes/ and .git/branches/ tests
 . PREVIEW: remote: remove support for migrating ancient remotes
 . PREVIEW: t5516: stop testing .git/branches/ functionality
 . PREVIEW: t5510: convert .git/remotes/ test to use a regular remote
 . Revert "Revert "Don't create the $GIT_DIR/branches directory on init""
 . remote: warn loud and clear when .git/remotes/ is *still* used
 . remote: warn loud and clear when .git/branches/ is *still* used
 . Documentation: really deprecate .git/remotes/ and .git/branches/
 . git-parse-remote: fix highly misleading man page

 Stop reading from .git/remotes/ and .git/branches/, two old ways
 that we have been supporting to configure short-hands for fetching
 from remote repositories.

 Will discard.
 The procedure of removing an old and unused feature is correctly
 followed by this series, but it is far from clear that the feature
 this attempts to remove is unused or useless.


* jc/checkout-working-tree-only (2017-04-27) 1 commit
 . checkout: add --working-tree-only option

 "git checkout <tree-ish> <pathspec>" learned a variant that does
 not update the index when doing its thing.

 Will discard.
 This was more of "the world could have been like this" illustration
 rather than a "let's make this change" proposal.


* sb/submodule-blanket-recursive (2017-05-23) 6 commits
 . builtin/push.c: respect 'submodule.recurse' option
 . builtin/grep.c: respect 'submodule.recurse' option
 . builtin/fetch.c: respect 'submodule.recurse' option
 . Introduce submodule.recurse option for worktree manipulators
 . submodule test invocation: only pass additional arguments
 . submodule.c: add has_submodules to check if we have any submodules

 A new configuration variable "submodule.recurse" can be set to true
 to force various commands run at the top-level superproject to
 behave as if they were invoked with the "--recurse-submodules"
 option.

 Retracted for now.
 cf. <CAGZ79kZexcwh=E6_ks83=pJh=ZvKnLvJ54eLsn+HURsTZOpvqg@mail.gmail.com>


* df/dir-iter-remove-subtree (2017-05-29) 5 commits
 . remove_subtree(): reimplement using iterators
 . dir_iterator: rewrite state machine model
 . dir_iterator: refactor dir_iterator_advance
 . remove_subtree(): test removing nested directories
 . dir_iterator: add tests for dir_iterator API

 Update the dir-iterator API and use it to reimplement
 remove_subtree().

 GSoC microproject.
 Ejected as it conflicts with other topics in flight in a
 non-trivial way.


