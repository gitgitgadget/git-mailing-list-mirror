Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46AE20A10
	for <e@80x24.org>; Fri, 29 Sep 2017 04:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbdI2EeZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 00:34:25 -0400
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:52012 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbdI2EeX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 00:34:23 -0400
Received: from pb-sasl-trial3.pobox.com (localhost [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 1CDF42066B;
        Fri, 29 Sep 2017 00:34:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=9
        LHig8dhxEFwzHXANRxZ6kZ95bE=; b=bOFpEOwsujW1HD/RBu0iCbOLWCbXy/Pth
        htONmK+4TiJUcsCJmXenqnA4bvbHGgQPkExrU9Esf0x2y/hsXJzLiL9sVR0v/sTa
        86Nyx6CKtbQrVP3E/KnQiXTnZAiKSDv+9vpPSfNJDpsa9QRiTNzRma69Qdnr+wVW
        7thAzWNcJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=RJt
        tCWShw/AOKmKrA4hbR1Cc3/ufP8qmmlLNHiqTp140KO+316NtdriRfrSen800L8g
        Kd9v3txYpdxaNIXVUX4/VunUJ/5yYxvKCjdAiyIkypC1X2K/nrGmOnmHd/L7C6HJ
        PzafxSaPYlIAIwUMcAiJxMeCgkrmsznEzptvOjsk=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id ECB812066A;
        Fri, 29 Sep 2017 00:34:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EA04AFCC3;
        Fri, 29 Sep 2017 00:34:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2017, #06; Fri, 29)
X-master-at: ea220ee40cbb03a63ebad2be902057bf742492fd
X-next-at: c088eec7b5eaefc58ab32b335cb69cb3d5e2cd78
Date:   Fri, 29 Sep 2017 13:34:17 +0900
Message-ID: <xmqqlgkyxgvq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7510A11C-A4CF-11E7-824A-8EF31968708C-77302942!pb-smtp1.pobox.com
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

* hn/typofix (2017-09-22) 1 commit
  (merged to 'next' on 2017-09-25 at 489ad60f5b)
 + submodule.h: typofix


* ic/fix-filter-branch-to-handle-tag-without-tagger (2017-09-22) 4 commits
  (merged to 'next' on 2017-09-25 at c7550033df)
 + filter-branch: use hash-object instead of mktag
 + filter-branch: stash away ref map in a branch
 + filter-branch: preserve and restore $GIT_AUTHOR_* and $GIT_COMMITTER_*
 + filter-branch: reset $GIT_* before cleaning up

 "git filter-branch" cannot reproduce a history with a tag without
 the tagger field, which only ancient versions of Git allowed to be
 created.  This has been corrected.


* ik/userdiff-html-h-element-fix (2017-09-24) 1 commit
  (merged to 'next' on 2017-09-25 at e3cbe89672)
 + userdiff: fix HTML hunk header regexp

 The built-in pattern to detect the "function header" for HTML did
 not match <H1>..<H6> elements without any attributes, which has
 been fixed.


* jc/merge-x-theirs-docfix (2017-09-25) 1 commit
  (merged to 'next' on 2017-09-26 at 5a7d954982)
 + merge-strategies: avoid implying that "-s theirs" exists

 The documentation for '-X<option>' for merges was misleadingly
 written to suggest that "-s theirs" exists, which is not the case.


* jk/describe-omit-some-refs (2017-09-17) 1 commit
  (merged to 'next' on 2017-09-24 at c373c71279)
 + describe: fix matching to actually match all patterns
 (this branch is used by mk/describe-match-with-all.)

 "git describe --match" learned to take multiple patterns in v2.13
 series, but the feature ignored the patterns after the first one
 and did not work at all.  This has been fixed.


* jk/diff-blob (2017-09-22) 1 commit
  (merged to 'next' on 2017-09-25 at 38286c8ff5)
 + cat-file: handle NULL object_context.path

 "git cat-file --textconv" started segfaulting recently, which
 has been corrected.


* jk/doc-read-tree-table-asciidoctor-fix (2017-09-24) 1 commit
  (merged to 'next' on 2017-09-25 at 070163b964)
 + doc: put literal block delimiter around table

 A docfix.


* jk/fallthrough (2017-09-22) 3 commits
  (merged to 'next' on 2017-09-25 at ad96c37620)
 + consistently use "fallthrough" comments in switches
 + curl_trace(): eliminate switch fallthrough
 + test-line-buffer: simplify command parsing

 Many codepaths have been updated to squelch -Wimplicit-fallthrough
 warnings from Gcc 7 (which is a good code hygiene).


* jm/status-ignored-directory-optim (2017-09-19) 1 commit
  (merged to 'next' on 2017-09-24 at ca50f5ed41)
 + Improve performance of git status --ignored

 "git status --ignored", when noticing that a directory without any
 tracked path is ignored, still enumerated all the ignored paths in
 the directory, which is unnecessary.  The codepath has been
 optimized to avoid this overhead.


* js/win32-lazyload-dll (2017-09-26) 1 commit
  (merged to 'next' on 2017-09-26 at 04577bf1c5)
 + Win32: simplify loading of DLL functions

 Add a helper in anticipation for its need in a future topic RSN.


* jt/fast-export-copy-modify-fix (2017-09-21) 1 commit
  (merged to 'next' on 2017-09-24 at c02bfe1902)
 + fast-export: do not copy from modified file

 "git fast-export" with -M/-C option issued "copy" instruction on a
 path that is simultaneously modified, which was incorrect.


* ks/doc-use-camelcase-for-config-name (2017-09-25) 1 commit
  (merged to 'next' on 2017-09-26 at 7b4d2115af)
 + doc: camelCase the config variables to improve readability

 Doc update.


* ma/leakplugs (2017-09-24) 6 commits
  (merged to 'next' on 2017-09-25 at 69d381a96a)
 + pack-bitmap[-write]: use `object_array_clear()`, don't leak
 + object_array: add and use `object_array_pop()`
 + object_array: use `object_array_clear()`, not `free()`
 + leak_pending: use `object_array_clear()`, not `free()`
 + commit: fix memory leak in `reduce_heads()`
 + builtin/commit: fix memory leak in `prepare_index()`

 Memory leaks in various codepaths have been plugged.


* mk/describe-match-with-all (2017-09-20) 2 commits
  (merged to 'next' on 2017-09-24 at f96d58dd83)
 + describe: teach --match to handle branches and remotes
 + Merge branch 'jk/describe-omit-some-refs' into mk/describe-match-with-all

 "git describe --match <pattern>" has been taught to play well with
 the "--all" option.


* mk/diff-delta-avoid-large-offset (2017-08-11) 1 commit
  (merged to 'next' on 2017-09-26 at b4983ac027)
 + diff-delta: do not allow delta offset truncation

 The delta format used in the packfile cannot reference data at
 offset larger than what can be expressed in 4-byte, but the
 generator for the data failed to make sure the offset does not
 overflow.  This has been corrected.


* mk/diff-delta-uint-may-be-shorter-than-ulong (2017-08-10) 1 commit
  (merged to 'next' on 2017-09-26 at 0ccd9346d7)
 + diff-delta: fix encoding size that would not fit in "unsigned int"

 The machinery to create xdelta used in pack files received the
 sizes of the data in size_t, but lost the higher bits of them by
 storing them in "unsigned int" during the computation, which is
 fixed.


* rj/no-sign-compare (2017-09-22) 4 commits
  (merged to 'next' on 2017-09-25 at 71ee264ce6)
 + ALLOC_GROW: avoid -Wsign-compare warnings
 + cache.h: hex2chr() - avoid -Wsign-compare warnings
 + commit-slab.h: avoid -Wsign-compare warnings
 + git-compat-util.h: xsize_t() - avoid -Wsign-compare warnings

 Many codepaths have been updated to squelch -Wsign-compare
 warnings.


* rs/mailinfo-qp-decode-fix (2017-09-24) 1 commit
  (merged to 'next' on 2017-09-25 at d48c594041)
 + mailinfo: don't decode invalid =XY quoted-printable sequences

 "git mailinfo" was loose in decoding quoted printable and produced
 garbage when the two letters after the equal sign are not
 hexadecimal.  This has been fixed.


* rs/resolve-ref-optional-result (2017-09-24) 3 commits
  (merged to 'next' on 2017-09-25 at b0f31228bb)
 + refs: pass NULL to resolve_ref_unsafe() if hash is not needed
 + refs: pass NULL to refs_resolve_ref_unsafe() if hash is not needed
 + refs: make sha1 output parameter of refs_resolve_ref_unsafe() optional

 Code clean-up.


* sb/doc-config-submodule-update (2017-09-24) 1 commit
  (merged to 'next' on 2017-09-25 at 447014b4ce)
 + Documentation/config: clarify the meaning of submodule.<name>.update


* sb/merge-commit-msg-hook (2017-09-22) 1 commit
  (merged to 'next' on 2017-09-25 at 096e0502a8)
 + Documentation/githooks: mention merge in commit-msg hook

 As "git commit" to conclude a conflicted "git merge" honors the
 commit-msg hook, "git merge" that records a merge commit that
 cleanly auto-merges should, but it didn't.
 * sb/merge-commit-msg-hook (2017-09-22) 1 commit
 (merged to 'next' on 2017-09-25 at 096e0502a8)
 + Documentation/githooks: mention merge in commit-msg hook

 Add documentation for a topic that has recently graduated to the
 'master' branch.

--------------------------------------------------
[New Topics]

* er/fast-import-dump-refs-on-checkpoint (2017-09-29) 2 commits
 - SQUASH???
 - fast-import: checkpoint: dump branches/tags/marks even if object_count==0

 The checkpoint command "git fast-import" did not flush updates to
 refs and marks unless at least one object was created since the
 last checkpoint, which has been corrected, as these things can
 happen without any new object getting created.


* hn/path-ownership-comment (2017-09-27) 2 commits
  (merged to 'next' on 2017-09-28 at 7cf8481c29)
 + read_gitfile_gently: clarify return value ownership.
 + real_path: clarify return value ownership

 Add comment to a few functions that use a short-lived buffer the
 caller can peek and copy out of.

 Will merge to 'master'.


* hn/string-list-doc (2017-09-27) 1 commit
  (merged to 'next' on 2017-09-28 at ffc8f65f4a)
 + string-list.h: move documentation from Documentation/api/ into header

 Doc reorg.

 Will merge to 'master'.


* hn/submodule-comment (2017-09-26) 1 commit
  (merged to 'next' on 2017-09-28 at a071ca3fde)
 + submodule.c: describe submodule_to_gitdir() in a new comment

 Will merge to 'master'.


* jk/no-optional-locks (2017-09-27) 1 commit
  (merged to 'next' on 2017-09-28 at eaffe9c638)
 + git: add --no-optional-locks option

 Some commands (most notably "git status") makes an opportunistic
 update when performing a read-only operation to help optimize later
 operations in the same repository.  The new "--no-optional-locks"
 option can be passed to Git to disable them.

 Will merge to 'master'.


* jk/read-in-full (2017-09-27) 7 commits
  (merged to 'next' on 2017-09-28 at 9d109b9233)
 + worktree: check the result of read_in_full()
 + worktree: use xsize_t to access file size
 + distinguish error versus short read from read_in_full()
 + avoid looking at errno for short read_in_full() returns
 + prefer "!=" when checking read_in_full() result
 + notes-merge: drop dead zero-write code
 + files-backend: prefer "0" for write_in_full() error check

 Code clean-up to prevent future mistakes by copying and pasting
 code that checks the result of read_in_full() function.

 Will merge to 'master'.


* jk/validate-headref-fix (2017-09-27) 3 commits
  (merged to 'next' on 2017-09-28 at dcea9d16f9)
 + validate_headref: use get_oid_hex for detached HEADs
 + validate_headref: use skip_prefix for symref parsing
 + validate_headref: NUL-terminate HEAD buffer

 Code clean-up.

 Will merge to 'master'.


* sb/diff-color-move (2017-09-28) 1 commit
  (merged to 'next' on 2017-09-28 at cbdbc741be)
 + diff: correct newline in summary for renamed files

 The output from "git diff --summary" was broken in a recent topic
 that has been merged to 'master' and lost a LF after reporting of
 mode change.  This has been fixed.

 Will merge to 'master'.


* sb/submodule-diff-header-fix (2017-09-28) 1 commit
  (merged to 'next' on 2017-09-28 at 10e0f59303)
 + submodule: correct error message for missing commits

 Error message tweak.

 Will merge to 'master'.


* sb/test-submodule-update-config (2017-09-27) 1 commit
  (merged to 'next' on 2017-09-28 at 497214603c)
 + t7406: submodule.<name>.update command must not be run from .gitmodules

 Will merge to 'master'.


* ad/doc-markup-fix (2017-09-29) 1 commit
 - doc: correct command formatting

 Docfix.

 Will merge to 'next'.


* jr/hash-migration-plan-doc (2017-09-28) 1 commit
 - technical doc: add a design doc for hash function transition

 Lay out plans for weaning us off of SHA-1.

 Will merge to 'next'.


* ot/mru-on-list (2017-09-28) 1 commit
 - mru: use double-linked list from list.h

 The first step to getting rid of mru API and using the
 doubly-linked list API directly instead.

 Needs review.
 Outreachy.


* rb/compat-poll-fix (2017-09-29) 1 commit
 - poll.c: always set revents, even if to zero

 Backports a moral equivalent of 2015 fix to the poll emulation from
 the upstream gnulib to fix occasional breakages on HPE NonStop.

 Needs review.


--------------------------------------------------
[Stalled]

* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Needs resurrecting by making sure the fix is good and still applies
 (or adjusted to today's codebase).


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

--------------------------------------------------
[Cooking]

* mr/doc-negative-pathspec (2017-09-25) 1 commit
  (merged to 'next' on 2017-09-29 at 147bb7ef8b)
 + docs: improve discoverability of exclude pathspec

 Doc updates.

 Will merge to 'master'.


* jm/svn-pushmergeinfo-fix (2017-09-17) 1 commit
 - git-svn: fix svn.pushmergeinfo handling of svn+ssh usernames.

 "git svn dcommit" did not take into account the fact that a
 svn+ssh:// URL with a username@ (typically used for pushing) refers
 to the same SVN repository without the username@ and failed when
 svn.pushmergeinfo option is set.

 Needs a test, perhaps as a follow-up patch.


* mg/merge-base-fork-point (2017-09-17) 3 commits
 - merge-base: find fork-point outside partial reflog
 - merge-base: return fork-point outside reflog
 - t6010: test actual test output

 "merge-base --fork-point $branch $commit" is used to guess on which
 commit among the commits that were once at the tip of the $branch the
 $commit was built on top of, and it learns these historical tips from
 the reflog of the $branch.  When the true fork-point is lost due to
 pruning of old reflog entries, the command does not give any output,
 because it has no way to guess correctly and does not want to mislead
 the user with a wrong guess.

 The command has been updated to give the best but not known to be
 correct guess, based on a hope that a merge-base between $commit and a
 virtual merge across all the reflog entries that still are available
 for $branch may still be a closer to the true fork-point than the
 merge-base between $commit and the current tip of the $branch.

 This may have to be offered by an additional option, to allow the
 users that are prepared to see a potentially incorrect guess to opt
 into the feature, without affecting the current callers that may not
 be prepared to accept a guess that is not known to be correct.

 What's the doneness of this one?


* bc/rev-parse-parseopt-fix (2017-09-25) 7 commits
  (merged to 'next' on 2017-09-26 at f3e013eaa4)
 + parse-options: only insert newline in help text if needed
 + parse-options: write blank line to correct output stream
 + t0040,t1502: Demonstrate parse_options bugs
  (merged to 'next' on 2017-09-24 at e479bce0ff)
 + git-rebase: don't ignore unexpected command line arguments
 + rev-parse parseopt: interpret any whitespace as start of help text
 + rev-parse parseopt: do not search help text for flag chars
 + t1502: demonstrate rev-parse --parseopt option mis-parsing

 Recent versions of "git rev-parse --parseopt" did not parse the
 option specification that does not have the optional flags (*=?!)
 correctly, which has been corrected.

 Will merge to 'master'.


* ds/find-unique-abbrev-optim (2017-09-19) 4 commits
 - SQUASH???
 - sha1_name: parse less while finding common prefix
 - sha1_name: unroll len loop in find_unique_abbrev_r()
 - sha1_name: create perf test for find_unique_abbrev()


* cc/perf-run-config (2017-09-24) 9 commits
 - perf: store subsection results in "test-results/$GIT_PERF_SUBSECTION/"
 - perf/run: show name of rev being built
 - perf/run: add run_subsection()
 - perf/run: update get_var_from_env_or_config() for subsections
 - perf/run: add get_subsections()
 - perf/run: add calls to get_var_from_env_or_config()
 - perf/run: add GIT_PERF_DIRS_OR_REVS
 - perf/run: add get_var_from_env_or_config()
 - perf/run: add '--config' option to the 'run' script

 Needs review.


* mg/merge-pre-merge-hook (2017-09-24) 4 commits
 - t7503: add tests for pre-merge-hook
 - merge: --no-verify to bypass pre-merge hook
 - merge: do no-verify like commit
 - git-merge: honor pre-merge hook

 "git merge" learned a 'pre-merge' hook, that would be triggered
 before the merge commit is created by a clean auto-merge.

 Waiting for review to conclude.


* js/rebase-i-final (2017-07-27) 10 commits
  (merged to 'next' on 2017-09-26 at ea3f8f5e11)
 + rebase -i: rearrange fixup/squash lines using the rebase--helper
 + t3415: test fixup with wrapped oneline
 + rebase -i: skip unnecessary picks using the rebase--helper
 + rebase -i: check for missing commits in the rebase--helper
 + t3404: relax rebase.missingCommitsCheck tests
 + rebase -i: also expand/collapse the SHA-1s via the rebase--helper
 + rebase -i: do not invent onelines when expanding/collapsing SHA-1s
 + rebase -i: remove useless indentation
 + rebase -i: generate the script via rebase--helper
 + t3415: verify that an empty instructionFormat is handled as before

 The final batch to "git rebase -i" updates to move more code from
 the shell script to C.

 Will merge to 'master'.


* bp/fsmonitor (2017-09-24) 12 commits
 - fsmonitor: add a performance test
 - fsmonitor: add a sample integration script for Watchman
 - fsmonitor: add test cases for fsmonitor extension
 - split-index: disable the fsmonitor extension when running the split index test
 - fsmonitor: add a test tool to dump the index extension
 - update-index: add fsmonitor support to update-index
 - ls-files: Add support in ls-files to display the fsmonitor valid bit
 - fsmonitor: add documentation for the fsmonitor extension.
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - update-index: add a new --force-write-index option
 - preload-index: add override to enable testing preload-index
 - bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status" and other
 operations that need to see which paths have been modified.

 Looking mostly ready.  Further comments?


* bw/protocol-v1 (2017-09-27) 9 commits
 - i5700: add interop test for protocol transition
 - http: tell server that the client understands v1
 - connect: tell server that the client understands v1
 - connect: teach client to recognize v1 server response
 - upload-pack, receive-pack: introduce protocol version 1
 - daemon: recognize hidden request arguments
 - protocol: introduce protocol extention mechanisms
 - pkt-line: add packet_write function
 - connect: in ref advertisement, shallows are last

 A new mechanism to upgrade the wire protocol in place is proposed
 and demonstrated that it works with the older versions of Git
 without harming them.


* mh/mmap-packed-refs (2017-09-25) 21 commits
  (merged to 'next' on 2017-09-29 at 3639417666)
 + packed-backend.c: rename a bunch of things and update comments
 + mmapped_ref_iterator: inline into `packed_ref_iterator`
 + ref_cache: remove support for storing peeled values
 + packed_ref_store: get rid of the `ref_cache` entirely
 + ref_store: implement `refs_peel_ref()` generically
 + packed_read_raw_ref(): read the reference from the mmapped buffer
 + packed_ref_iterator_begin(): iterate using `mmapped_ref_iterator`
 + read_packed_refs(): ensure that references are ordered when read
 + packed_ref_cache: keep the `packed-refs` file mmapped if possible
 + packed-backend.c: reorder some definitions
 + mmapped_ref_iterator_advance(): no peeled value for broken refs
 + mmapped_ref_iterator: add iterator over a packed-refs file
 + packed_ref_cache: remember the file-wide peeling state
 + read_packed_refs(): read references with minimal copying
 + read_packed_refs(): make parsing of the header line more robust
 + read_packed_refs(): only check for a header at the top of the file
 + read_packed_refs(): use mmap to read the `packed-refs` file
 + die_unterminated_line(), die_invalid_line(): new functions
 + packed_ref_cache: add a backlink to the associated `packed_ref_store`
 + prefix_ref_iterator: break when we leave the prefix
 + ref_iterator: keep track of whether the iterator output is ordered

 Operations that do not touch (majority of) packed refs have been
 optimized by making accesses to packed-refs file lazy; we no longer
 pre-parse everything, and an access to a single ref in the
 packed-refs does not touch majority of irrelevant refs, either.

 Will merge to 'master'.


* pc/submodule-helper (2017-09-25) 4 commits
 - submodule: port submodule subcommand 'status' from shell to C
 - submodule: port set_name_rev() from shell to C
 - submodule--helper: introduce for_each_listed_submodule()
 - submodule--helper: introduce get_submodule_displaypath()

 GSoC.
 Looking better; it appeared to me that 3/4 is totally superfluous, though.


* bc/hash-algo (2017-08-20) 5 commits
 - hash-algo: switch empty tree and blob lookups to use hash abstraction
 - hash-algo: integrate hash algorithm support with repo setup
 - hash-algo: add structure representing hash algorithm
 - setup: expose enumerated repo info
 - Merge branch 'bc/vcs-svn-cleanup' into bc/hash-algo

 RFC
 cf. <20170821000022.26729-1-sandals@crustytoothpaste.net>


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Will be rerolled after tc/curl-with-backports stabilizes.


* sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
 - Documentation/checkout: clarify submodule HEADs to be detached
 - recursive submodules: detach HEAD from new state

 "git checkout --recursive" may overwrite and rewind the history of
 the branch that happens to be checked out in submodule
 repositories, which might not be desirable.  Detach the HEAD but
 still allow the recursive checkout to succeed in such a case.

 Undecided.
 This needs justification in a larger picture; it is unclear why
 this is better than rejecting recursive checkout, for example.


* jk/check-ref-format-oor-fix (2017-07-14) 1 commit
 - check-ref-format: require a repository for --branch

 Discussion slowly continues...
 cf. <20170717172709.GL93855@aiede.mtv.corp.google.com>
 cf. <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>


* rs/sha1-file-micro-optim (2017-07-09) 2 commits
 - SQUASH???
 - sha1_file: add slash once in for_each_file_in_obj_subdir()

 Code cleanup.

 Perhaps drop.
 cf. <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>


* jc/allow-lazy-cas (2017-07-06) 1 commit
 - push: disable lazy --force-with-lease by default

 Because "git push --force-with-lease[=<ref>]" that relies on the
 stability of remote-tracking branches is unsafe when something
 fetches into the repository behind user's back, it is now disabled
 by default.  A new configuration variable can be used to enable it
 by users who know what they are doing.  This would pave the way to
 possibly turn `--force` into `--force-with-lease`.

 Will discard.
 Independent from disabling the feature by default, this stirred up
 a discussion to replace the DWIM heuristics with a better one, which
 deserves to be its own topic.
 cf. <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>


* ex/deprecate-empty-pathspec-as-match-all (2017-06-23) 2 commits
  (merged to 'next' on 2017-08-14 at 24db08a6e8)
 + pathspec: die on empty strings as pathspec
 + t0027: do not use an empty string as a pathspec element

 The final step to make an empty string as a pathspec element
 illegal.  We started this by first deprecating and warning a
 pathspec that has such an element in 2.11 (Nov 2016).

 Hopefully we can merge this down to the 'master' by the end of the
 year?  A deprecation warning period that is about 1 year does not
 sound too bad.

 Will cook in 'next'.
 As the draft RelNotes says, let's merge this to 'master' after
 this release cycle.


* sd/branch-copy (2017-09-24) 4 commits
  (merged to 'next' on 2017-09-28 at a6eceefa02)
 + branch: fix "copy" to never touch HEAD
 + branch: add a --copy (-c) option to go with --move (-m)
 + branch: add test for -m renaming multiple config sections
 + config: create a function to format section headers

 "git branch" learned "-c/-C" to create and switch to a new branch
 by copying an existing one.

 Will merge to 'master'.
