Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FA0320357
	for <e@80x24.org>; Fri,  7 Jul 2017 19:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbdGGT0j (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 15:26:39 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35226 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdGGT0h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 15:26:37 -0400
Received: by mail-pg0-f66.google.com with SMTP id d193so5089739pgc.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 12:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=f29SSd1y+tGzGK4y38dAOHurazUtpYzkPwLcx76wLmA=;
        b=YoQKxMlHa+fM7TN3Qrs2pmwm7RBjRdMm6H/j6xGUzWJDvM7wApLaAXpjKgz2X+e1hf
         x4a+o7bIdYRCsgFPrr2tz1tsjBkX7yl5nbCNw7/ctnwcJNjyGzkr+rHw1tPn6+JpX9Bc
         dL/vXZAr6oQcQL+e92jYimNVWGdSRn9xm+gV56LvUwbjESi1cYLCD7Lrx2B6wjk/UrQn
         kXk8gDjrt0DJWXZzNmT+mwfXO6DwLACpG7V2LVPqr3V6nJ1Yesu5RzRrmjk8X2CvjtO2
         wwUItnBWcaxYtCOgTizUs4PaeoIq4eBPNcCpw7On+K/2sCpsmpca0JLs0C9R4TzvH9zL
         IBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=f29SSd1y+tGzGK4y38dAOHurazUtpYzkPwLcx76wLmA=;
        b=QPSWyXBfbhTo/ZFJuwP0W5+SakIO+sN3cPQSt9lfp8ItbfvP5qhWFcNMxwmxSMhA8V
         Pms7W+aGuLRIv5ifLbS9YkvYPmfUEDsAebntk4kvZnwlrop4HMaMj+/94IxYCaiTexdz
         JxI8RI5qeO6X4sLjRRnKRBWThTHWqO+mA9jy6LLmUBbfA6JJwBv7/p5TZVLR2TTP9SEu
         jPRVL+agTwjsyqYHqIjex1yTPGvvtI3RCc3y3W5Bf1my2IM6i0++qrurDxgFkIxGyzxQ
         JzWNWNBE771wxxW7MM/XG14dTe2tfxJSx7LKbovJH4TvC41gCMgK+9zLvrNkR7J6yCTj
         yh0A==
X-Gm-Message-State: AIVw112Q0xuyPsUyxdakeZiyRxw+H86lmOfSnz+2qBOnY3XqHSwgGBYg
        b27AgKBu6hHK89uwUn0zyyHW
X-Received: by 10.98.53.134 with SMTP id c128mr33085728pfa.36.1499455596278;
        Fri, 07 Jul 2017 12:26:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ac1c:ce85:2088:9c06])
        by smtp.gmail.com with ESMTPSA id o29sm7985570pfa.60.2017.07.07.12.26.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 12:26:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2017, #02; Fri, 7)
X-master-at: 8b2efe2a0fd93b8721879f796d848a9ce785647f
X-next-at: a9c46e097be495732ddb19ee1f57e62e5b35db6c
Date:   Fri, 07 Jul 2017 12:26:34 -0700
Message-ID: <xmqqa84gaw0l.fsf@gitster.mtv.corp.google.com>
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

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/sha1dc-maint (2017-07-03) 1 commit
  (merged to 'next' on 2017-07-05 at ac69c90b7e)
 + sha1dc: update from upstream
 (this branch is used by ab/sha1dc.)

 Update the sha1dc again to fix portability glitches.


* ab/strbuf-addftime-tzname-boolify (2017-07-01) 2 commits
  (merged to 'next' on 2017-07-05 at 81e6795eb3)
 + strbuf: change an always NULL/"" strbuf_addftime() param to bool
 + strbuf.h comment: discuss strbuf_addftime() arguments in order

 strbuf_addftime() is further getting tweaked.


* aw/contrib-subtree-doc-asciidoctor (2017-06-27) 1 commit
  (merged to 'next' on 2017-06-30 at af23bd111b)
 + subtree: honour USE_ASCIIDOCTOR when set

 The Makefile rule in contrib/subtree for building documentation
 learned to honour USE_ASCIIDOCTOR just like the main documentation
 set does.


* jc/utf8-fprintf (2017-06-28) 1 commit
  (merged to 'next' on 2017-06-30 at a8cc490818)
 + submodule--helper: do not call utf8_fprintf() unnecessarily

 Code cleanup.


* js/fsck-name-object (2017-06-28) 1 commit
  (merged to 'next' on 2017-06-30 at 9a08514cf2)
 + t1450: use egrep for regexp "alternation"

 Test fix.


* js/t5534-rev-parse-gives-multi-line-output-fix (2017-07-05) 1 commit
  (merged to 'next' on 2017-07-05 at 5f964c44ba)
 + t5534: fix misleading grep invocation

 A few tests that tried to verify the contents of push certificates
 did not use 'git rev-parse' to formulate the line to look for in
 the certificate correctly.


* rs/apply-avoid-over-reading (2017-07-01) 1 commit
  (merged to 'next' on 2017-07-05 at 35730f3a47)
 + apply: use starts_with() in gitdiff_verify_name()

 Code clean-up to fix possible buffer over-reading.


* sb/merge-recursive-code-cleanup (2017-06-30) 1 commit
  (merged to 'next' on 2017-07-05 at 4228240520)
 + merge-recursive: use DIFF_XDL_SET macro

 Code clean-up.


* xz/send-email-batch-size (2017-07-05) 1 commit
  (merged to 'next' on 2017-07-05 at 92f3c31fbd)
 + send-email: --batch-size to work around some SMTP server limit

 "git send-email" learned to overcome some SMTP server limitation
 that does not allow many pieces of e-mails to be sent over a single
 session.

--------------------------------------------------
[New Topics]

* jc/allow-lazy-cas (2017-07-06) 1 commit
 - push: disable lazy --force-with-lease by default

 Because "git push --force-with-lease[=<ref>]" that relies on the
 stability of remote-tracking branches is unsafe when something
 fetches into the repository behind user's back, it is now disabled
 by default.  A new configuration variable can be used to enable it
 by users who know what they are doing.  This would pave the way to
 possibly turn `--force` into `--force-with-lease`.

 Will wait for feedback, then merge to and cook in 'next'.


* ks/typofix-commit-c-comment (2017-07-06) 1 commit
  (merged to 'next' on 2017-07-07 at 64e98fc832)
 + builtin/commit.c: fix a typo in the comment

 Typofix.

 Will merge to 'master'.


* bb/unicode-10.0 (2017-07-07) 1 commit
  (merged to 'next' on 2017-07-07 at a9c46e097b)
 + unicode: update the width tables to Unicode 10

 Update the character width tables.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


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


* sg/clone-refspec-from-command-line-config (2017-06-16) 2 commits
 - Documentation/clone: document ignored configuration variables
 - clone: respect additional configured fetch refspecs during initial fetch
 (this branch is used by sg/remote-no-string-refspecs.)

 "git clone -c var=val" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.

 Waiting for a response.
 cf. <20170617112228.vugswym4o4owf6wj@sigill.intra.peff.net>
 cf. <xmqqmv8zhdap.fsf@gitster.mtv.corp.google.com>


* js/rebase-i-final (2017-06-15) 10 commits
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

 Expecting a reroll.
 This is at its v5.
 cf. <cover.1497444257.git.johannes.schindelin@gmx.de>

--------------------------------------------------
[Cooking]

* bc/object-id (2017-07-04) 12 commits
 - sha1_name: convert GET_SHA1* flags to GET_OID*
 - sha1_name: convert get_sha1* to get_oid*
 - Convert remaining callers of get_sha1 to get_oid.
 - builtin/verify-tag: convert to struct object_id
 - builtin/unpack-file: convert to struct object_id
 - bisect: convert bisect_checkout to struct object_id
 - builtin/update_ref: convert to struct object_id
 - sequencer: convert to struct object_id
 - remote: convert struct push_cas to struct object_id
 - submodule: convert submodule config lookup to use object_id
 - builtin/merge-tree: convert remaining caller of get_sha1 to object_id
 - builtin/fsck: convert remaining caller of get_sha1 to object_id

 Conversion from uchar[20] to struct object_id continues.


* jk/reflog-walk (2017-07-07) 8 commits
 - reflog-walk: apply --since/--until to reflog dates
 - reflog-walk: stop using fake parents
 - rev-list: check reflog_info before showing usage
 - get_revision_1(): replace do-while with an early return
 - log: do not free parents when walking reflog
 - revision: disallow reflog walking with revs->limited
 - t1414: document some reflog-walk oddities
 - Merge branch 'jk/reflog-walk-maint' into jk/reflog-walk
 (this branch uses jk/reflog-walk-maint.)

 Numerous bugs in walking of reflogs via "log -g" and friends have
 been fixed.

 Will wait for feedback, then merge to and cook in 'next'.


* jk/reflog-walk-maint (2017-07-07) 4 commits
  (merged to 'next' on 2017-07-07 at 611554ba2f)
 + reflog-walk: include all fields when freeing complete_reflogs
 + reflog-walk: don't free reflogs added to cache
 + reflog-walk: duplicate strings in complete_reflogs list
  (merged to 'next' on 2017-07-06 at 7408dd80a1)
 + reflog-walk: skip over double-null oid due to HEAD rename
 (this branch is used by jk/reflog-walk.)

 After "git branch --move" of the currently checked out branch, the
 code to walk the reflog of HEAD via "log -g" and friends
 incorrectly stopped at the reflog entry that records the renaming
 of the branch.

 Will merge to 'master'.


* sb/hashmap-cleanup (2017-07-05) 10 commits
 - t/helper/test-hashmap: use custom data instead of duplicate cmp functions
 - name-hash.c: drop hashmap_cmp_fn cast
 - submodule-config.c: drop hashmap_cmp_fn cast
 - remote.c: drop hashmap_cmp_fn cast
 - patch-ids.c: drop hashmap_cmp_fn cast
 - convert/sub-process: drop cast to hashmap_cmp_fn
 - config.c: drop hashmap_cmp_fn cast
 - builtin/describe: drop hashmap_cmp_fn cast
 - builtin/difftool.c: drop hashmap_cmp_fn cast
 - attr.c: drop hashmap_cmp_fn cast
 (this branch uses sb/hashmap-customize-comparison; is tangled with sb/diff-color-move.)

 Many uses of comparision callback function the hashmap API uses
 cast the callback function type when registering it to
 hashmap_init(), which defeats the compile time type checking when
 the callback interface changes (e.g. gaining more parameters).
 The callback implementations have been updated to take "void *"
 pointers and cast them to the type they expect instead.

 Will wait for feedback, then merge to and cook in 'next'.


* tb/push-to-cygwin-unc-path (2017-07-05) 1 commit
 - cygwin: allow pushing to UNC paths

 On Cygwin, similar to Windows, "git push //server/share/repository"
 ought to mean a repository on a network share that can be accessed
 locally, but this did not work correctly due to stripping the double
 slashes at the beginning.

 This may need to be heavily tested before it gets unleashed to the
 wild, as the change is at a fairly low-level code and would affect
 not just the code to decide if the push destination is local.  There
 may be unexpected fallouts in the path normalization.

 Will wait for feedback, then merge to and cook in 'next'.


* ab/grep-lose-opt-regflags (2017-06-30) 6 commits
  (merged to 'next' on 2017-07-05 at 375c0b92ea)
 + grep: remove redundant REG_NEWLINE when compiling fixed regex
 + grep: remove regflags from the public grep_opt API
 + grep: remove redundant and verbose re-assignments to 0
 + grep: remove redundant "fixed" field re-assignment to 0
 + grep: adjust a redundant grep pattern type assignment
 + grep: remove redundant double assignment to 0

 Code cleanup.

 Will merge to 'master'.


* ks/commit-assuming-only-warning-removal (2017-06-30) 2 commits
  (merged to 'next' on 2017-07-05 at 462a72df95)
 + commit-template: distinguish status information unconditionally
 + commit-template: remove outdated notice about explicit paths

 An old message shown in the commit log template was removed, as it
 has outlived its usefulness.

 Will merge to 'master'.


* sb/hashmap-customize-comparison (2017-06-30) 3 commits
  (merged to 'next' on 2017-07-06 at cc420805f3)
 + hashmap: migrate documentation from Documentation/technical into header
 + patch-ids.c: use hashmap correctly
 + hashmap.h: compare function has access to a data field
 (this branch is used by sb/diff-color-move and sb/hashmap-cleanup.)

 Update the hashmap API so that data to customize the behaviour of
 the comparison function can be specified at the time a hashmap is
 initialized.

 Will merge to 'master'.


* mt/p4-parse-G-output (2017-07-05) 1 commit
 . git-p4: parse marshal output "p4 -G" in p4 changes

 Use "p4 -G" to make "p4 changes" output more Python-friendly
 to parse.

 Needs review/ack from git-p4 folks.
 It still seems to break when merged to 'pu'.


* rs/free-and-null (2017-06-29) 1 commit
  (merged to 'next' on 2017-07-06 at 9c9e1d59a2)
 + coccinelle: polish FREE_AND_NULL rules

 Code cleanup.

 Will merge to 'master'.


* ab/wildmatch (2017-06-23) 1 commit
  (merged to 'next' on 2017-07-07 at 34482a9a4f)
 + wildmatch: remove unused wildopts parameter

 Minor code cleanup.

 Will merge to 'master'.


* ex/deprecate-empty-pathspec-as-match-all (2017-06-23) 2 commits
  (merged to 'next' on 2017-06-26 at d026281517)
 + pathspec: die on empty strings as pathspec
 + t0027: do not use an empty string as a pathspec element

 The final step to make an empty string as a pathspec element
 illegal.  We started this by first deprecating and warning a
 pathspec that has such an element in 2.11 (Nov 2016).

 Hopefully we can merge this down to the 'master' by the end of the
 year?  A deprecation warning period that is about 1 year does not
 sound too bad.

 Will cook in 'next'.


* sb/pull-rebase-submodule (2017-06-27) 4 commits
 - builtin/fetch cleanup: always set default value for submodule recursing
 - pull: optionally rebase submodules (remote submodule changes only)
 - builtin/fetch: parse recurse-submodules-default at default options parsing
 - builtin/fetch: factor submodule recurse parsing out to submodule config

 "git pull --rebase --recurse-submodules" learns to rebase the
 branch in the submodules to an updated base.

 Will merge to 'next'.


* pw/unquote-path-in-git-pm (2017-06-30) 4 commits
  (merged to 'next' on 2017-07-05 at 538ab4d599)
 + t9700: add tests for Git::unquote_path()
 + Git::unquote_path(): throw an exception on bad path
 + Git::unquote_path(): handle '\a'
 + add -i: move unquote_path() to Git.pm

 Code refactoring.

 Will merge to 'master'.


* mh/packed-ref-store (2017-07-03) 30 commits
  (merged to 'next' on 2017-07-05 at 6c68c603cc)
 + read_packed_refs(): die if `packed-refs` contains bogus data
 + t3210: add some tests of bogus packed-refs file contents
 + repack_without_refs(): don't lock or unlock the packed refs
 + commit_packed_refs(): remove call to `packed_refs_unlock()`
 + clear_packed_ref_cache(): don't protest if the lock is held
 + packed_refs_unlock(), packed_refs_is_locked(): new functions
 + packed_refs_lock(): report errors via a `struct strbuf *err`
 + packed_refs_lock(): function renamed from lock_packed_refs()
 + commit_packed_refs(): use a staging file separate from the lockfile
 + commit_packed_refs(): report errors rather than dying
 + packed_ref_store: make class into a subclass of `ref_store`
 + packed-backend: new module for handling packed references
 + packed_read_raw_ref(): new function, replacing `resolve_packed_ref()`
 + packed_ref_store: support iteration
 + packed_peel_ref(): new function, extracted from `files_peel_ref()`
 + repack_without_refs(): take a `packed_ref_store *` parameter
 + get_packed_ref(): take a `packed_ref_store *` parameter
 + rollback_packed_refs(): take a `packed_ref_store *` parameter
 + commit_packed_refs(): take a `packed_ref_store *` parameter
 + lock_packed_refs(): take a `packed_ref_store *` parameter
 + add_packed_ref(): take a `packed_ref_store *` parameter
 + get_packed_refs(): take a `packed_ref_store *` parameter
 + get_packed_ref_cache(): take a `packed_ref_store *` parameter
 + validate_packed_ref_cache(): take a `packed_ref_store *` parameter
 + clear_packed_ref_cache(): take a `packed_ref_store *` parameter
 + packed_ref_store: move `packed_refs_lock` member here
 + packed_ref_store: move `packed_refs_path` here
 + packed_ref_store: new struct
 + add_packed_ref(): teach function to overwrite existing refs
 + t1408: add a test of stale packed refs covered by loose refs

 The "ref-store" code reorganization continues.

 Will merge to 'master'.


* sb/submodule-doc (2017-06-22) 1 commit
 - submodules: overhaul documentation

 Doc update.

 Will merge to 'next'.


* sd/branch-copy (2017-06-18) 3 commits
 - branch: add a --copy (-c) option to go with --move (-m)
 - branch: add test for -m renaming multiple config sections
 - config: create a function to format section headers

 "git branch" learned "-c/-C" to create and switch to a new branch
 by copying an existing one.

 Undecided.

 I personally do not think "branch --copy master backup" while on
 "master" that switches to "backup" is a good UI, and I *will* say
 "I told you so" when users complain after we merge this down to
 'next' and eventually to 'master'.


* ls/filter-process-delayed (2017-06-30) 7 commits
  (merged to 'next' on 2017-07-05 at a35e644082)
 + convert: add "status=delayed" to filter process protocol
 + convert: refactor capabilities negotiation
 + convert: move multiple file filter error handling to separate function
 + convert: put the flags field before the flag itself for consistent style
 + t0021: write "OUT <size>" only on success
 + t0021: make debug log file name configurable
 + t0021: keep filter log files on comparison

 The filter-process interface learned to allow a process with long
 latency give a "delayed" response.

 Will merge to 'master'.


* ab/sha1dc (2017-07-03) 2 commits
  (merged to 'next' on 2017-07-06 at 5a783032b7)
 + sha1collisiondetection: automatically enable when submodule is populated
 + sha1dc: optionally use sha1collisiondetection as a submodule

 The "collission-detecting" implementation of SHA-1 hash we borrowed
 from is replaced by directly binding the upstream project as our
 submodule.  Glitches on minority platforms are still being worked out.

 Will merge to 'master'.


* bp/fsmonitor (2017-06-12) 6 commits
 - fsmonitor: add a sample query-fsmonitor hook script for Watchman
 - fsmonitor: add documentation for the fsmonitor extension.
 - fsmonitor: add test cases for fsmonitor extension
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - dir: make lookup_untracked() available outside of dir.c
 - bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status".

 Expecting a reroll.
 cf. <bade1166-e646-b05a-f65b-adb8da8ba0a7@gmail.com>


* sb/diff-color-move (2017-06-30) 26 commits
  (merged to 'next' on 2017-07-06 at 758ed40e4f)
 + diff: document the new --color-moved setting
 + diff.c: add dimming to moved line detection
 + diff.c: color moved lines differently, plain mode
 + diff.c: color moved lines differently
 + diff.c: buffer all output if asked to
 + diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
 + diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
 + diff.c: convert word diffing to use emit_diff_symbol
 + diff.c: convert show_stats to use emit_diff_symbol
 + diff.c: convert emit_binary_diff_body to use emit_diff_symbol
 + submodule.c: migrate diff output to use emit_diff_symbol
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
 + diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR_{PLUS, MINUS}
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS[_PORCELAIN]
 + diff.c: migrate emit_line_checked to use emit_diff_symbol
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
 + diff.c: introduce emit_diff_symbol
 + diff.c: factor out diff_flush_patch_all_file_pairs
 + diff.c: move line ending check into emit_hunk_header
 + diff.c: readability fix
 + Merge branch 'sb/hashmap-customize-comparison' into sb/diff-color-move
 (this branch uses sb/hashmap-customize-comparison; is tangled with sb/hashmap-cleanup.)

 "git diff" has been taught to optionally paint new lines that are
 the same as deleted lines elsewhere differently from genuinely new
 lines.

 Will merge to 'master'.

--------------------------------------------------
[Discarded]

* mh/packed-ref-store-prep-extra (2017-06-18) 1 commit
 . prefix_ref_iterator_advance(): relax the check of trim length

 Split out of mh/packed-ref-store-prep.


* nd/prune-in-worktree (2017-04-24) 12 commits
 . rev-list: expose and document --single-worktree
 . revision.c: --reflog add HEAD reflog from all worktrees
 . files-backend: make reflog iterator go through per-worktree reflog
 . revision.c: --all adds HEAD from all worktrees
 . refs: remove dead for_each_*_submodule()
 . revision.c: use refs_for_each*() instead of for_each_*_submodule()
 . refs: add refs_head_ref()
 . refs: move submodule slash stripping code to get_submodule_ref_store
 . refs.c: refactor get_submodule_ref_store(), share common free block
 . revision.c: --indexed-objects add objects from all worktrees
 . revision.c: refactor add_index_objects_to_pending()
 . revision.h: new flag in struct rev_info wrt. worktree-related refs

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.
