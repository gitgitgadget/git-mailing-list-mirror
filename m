Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F35E1F406
	for <e@80x24.org>; Tue, 19 Dec 2017 22:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbdLSWA6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 17:00:58 -0500
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:50247 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdLSWAy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 17:00:54 -0500
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 495D02D591;
        Tue, 19 Dec 2017 17:00:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=H
        jwC16VT6OQbg4VJn2nh0qz/NoA=; b=cxwDGg6MgBWYpIPGAgAIdwlmCJY1kBtoH
        FxF8UL98DV4dIs4Z/0rTNhlydWfqj/eFhue111IUbcpHJnd2nQZsEozMBN04uuuo
        M0Jehi/PPvtpFnc/q7dwK4w1jkMeX33u34b7kEVnlMw1lbsj3kiVLIiG5fecJe3I
        qBzpXecoQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=kO/
        D5RF+H8qDYIIzdG72b0et+k962PPW4q1j3b3Sg8adm1UxW+8/D2fQw52j0T6b0+T
        Cg3j8FgSy/CMvF7eveS8j9dJjB/MIxAsjKdEbX8s5U2/Lz1tH++EhG/0ruEhPWVk
        no6Mspo19dTdmB06L7Z02jfHorwsO/ny6dHSAxuU=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 1D4B92D590;
        Tue, 19 Dec 2017 17:00:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DCA4BB1BBB;
        Tue, 19 Dec 2017 17:00:51 -0500 (EST)
From:   Junio C Hamano <junio@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2017, #04; Tue, 19)
X-master-at: 936d1b989416a95f593bf81ccae8ac62cd83f279
X-next-at: cfbfd45ee6e49007fdeb00008904064ba98f65e0
Date:   Tue, 19 Dec 2017 14:00:49 -0800
Message-ID: <xmqqshc6tm26.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 144016AA-E508-11E7-B781-575F0C78B957-77302942!pb-smtp2.pobox.com
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

* ar/unconfuse-three-dots (2017-12-06) 8 commits
  (merged to 'next' on 2017-12-13 at 33bd0b67c0)
 + t2020: test variations that matter
 + t4013: test new output from diff --abbrev --raw
 + diff: diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value
 + t4013: prepare for upcoming "diff --raw --abbrev" output format change
 + checkout: describe_detached_head: remove ellipsis after committish
 + print_sha1_ellipsis: introduce helper
 + Documentation: user-manual: limit usage of ellipsis
 + Documentation: revisions: fix typo: "three dot" ---> "three-dot" (in line with "two-dot").

 Ancient part of codebase still shows dots after an abbreviated
 object name just to show that it is not a full object name, but
 these ellipses are confusing to people who newly discovered Git
 who are used to seeing abbreviated object names and find them
 confusing with the range syntax.


* bw/pathspec-match-submodule-boundary (2017-12-05) 1 commit
  (merged to 'next' on 2017-12-13 at e256d292a4)
 + pathspec: only match across submodule boundaries when requested

 An v2.12-era regression in pathspec match logic, which made it look
 into submodule tree even when it is not desired, has been fixed.


* bw/submodule-config-cleanup (2017-12-06) 1 commit
  (merged to 'next' on 2017-12-13 at c952bf1b84)
 + diff-tree: read the index so attribute checks work in bare repositories

 Recent update to the submodule configuration code broke "diff-tree"
 by accidentally stopping to read from the index upfront.


* en/merge-recursive-icase-removal (2017-11-27) 1 commit
  (merged to 'next' on 2017-12-13 at 85c6538a2a)
 + merge-recursive: ignore_case shouldn't reject intentional removals

 The code internal to the recursive merge strategy was not fully
 prepared to see a path that is renamed to try overwriting another
 path that is only different in case on case insensitive systems.
 This does not matter in the current code, but will start to matter
 once the rename detection logic starts taking hints from nearby
 paths moving to some directory and moves a new path along with them.


* en/rename-progress (2017-12-02) 5 commits
  (merged to 'next' on 2017-12-04 at 49b39d2297)
 + diffcore-rename: make diff-tree -l0 mean -l<large>
  (merged to 'next' on 2017-11-20 at 77a2e0ddd9)
 + sequencer: show rename progress during cherry picks
 + diff: remove silent clamp of renameLimit
 + progress: fix progress meters when dealing with lots of work
 + sequencer: warn when internal merge may be suboptimal due to renameLimit

 Historically, the diff machinery for rename detection had a
 hardcoded limit of 32k paths; this is being lifted to allow users
 trade cycles with a (possibly) easier to read result.


* gk/tracing-optimization (2017-12-06) 2 commits
  (merged to 'next' on 2017-12-13 at d6bfac03ad)
 + trace: improve performance while category is disabled
 + trace: remove trace key normalization

 The tracing infrastructure has been optimized for cases where no
 tracing is requested.


* jt/diff-anchored-patience (2017-11-28) 1 commit
  (merged to 'next' on 2017-12-13 at 5f4843d7a0)
 + diff: support anchoring line(s)

 "git diff" learned a variant of the "--patience" algorithm, to
 which the user can specify which 'unique' line to be used as
 anchoring points.


* ls/editor-waiting-message (2017-12-07) 2 commits
  (merged to 'next' on 2017-12-13 at 494b5b41e3)
 + launch_editor(): indicate that Git waits for user input
 + refactor "dumb" terminal determination

 Git shows a message to tell the user that it is waiting for the
 user to finish editing when spawning an editor, in case the editor
 opens to a hidden window or somewhere obscure and the user gets
 lost.


* ls/git-gui-no-double-utf8-author-name (2017-12-05) 2 commits
  (merged to 'next' on 2017-12-13 at be577d6e1b)
 + Merge branch 'ls/no-double-utf8-author-name' of ../git-gui into ls/git-gui-no-double-utf8-author-name
 + git-gui: prevent double UTF-8 conversion

 Amending commits in git-gui broke the author name that is non-ascii
 due to incorrect enconding conversion.


* sb/clone-recursive-submodule-doc (2017-12-05) 1 commit
  (merged to 'next' on 2017-12-13 at abfed699db)
 + Documentation/git-clone: improve description for submodule recursing

 Doc update.


* sg/setup-doc-update (2017-12-07) 1 commit
  (merged to 'next' on 2017-12-13 at 4355c6e0ef)
 + setup.c: fix comment about order of .git directory discovery

 Comment update.


* tg/worktree-create-tracking (2017-12-06) 6 commits
  (merged to 'next' on 2017-12-13 at 830b68c660)
 + add worktree.guessRemote config option
 + worktree: add --guess-remote flag to add subcommand
 + worktree: make add <path> <branch> dwim
 + worktree: add --[no-]track option to the add subcommand
 + worktree: add can be created from any commit-ish
 + checkout: factor out functions to new lib file

 The way "git worktree add" determines what branch to create from
 where and checkout in the new worktree has been updated a bit.

--------------------------------------------------
[New Topics]

* ew/svn-crlf (2017-12-14) 2 commits
 - Merge branch 'svn-crlf' of git://bogomips.org/git-svn into ew/svn-crlf
 - git-svn: convert CRLF to LF in commit message to SVN

 "git svn" has been updated to strip CRs in the commit messages, as
 recent versions of Subversion rejects them.

 Will merge to 'next'.


* tz/lib-git-svn-svnserve-tests (2017-12-14) 2 commits
 - t/lib-git-svn.sh: improve svnserve tests with parallel make test
 - t/lib-git-svn: cleanup inconsistent tab/space usage

 Will merge to 'next'.


* bp/fsmonitor (2017-12-18) 1 commit
 - p7519: improve check for prerequisite WATCHMAN

 Test fix.

 Will merge to 'next'.


* js/enhanced-version-info (2017-12-14) 2 commits
 - version --build-options: report commit, too, if possible
 - version --build-options: also report host CPU

 "git version --build-options" learned to report the host CPU and
 the exact commit object name the binary was built from.

 Will merge to 'next'.


* jt/transport-hide-vtable (2017-12-14) 2 commits
 - transport: make transport vtable more private
 - clone, fetch: remove redundant transport check
 (this branch uses jt/transport-no-more-rsync.)

 Code clean-up.

 Will merge to 'next'.


* ks/rebase-error-messages (2017-12-19) 3 commits
 - rebase: rebasing can also be done when HEAD is detached
 - rebase: distinguish user input by quoting it
 - rebase: consistently use branch_name variable

 Error messages from "git rebase" have been somewhat cleaned up.

 Will merge to 'next'.


* nm/imap-send-quote-server-folder-name (2017-12-18) 1 commit
 - imap-send: URI encode server folder

 "git imap-send" did not correctly quote the folder name when
 making a request to the server, which has been corrected.

 Will merge to 'next'.


* np/send-email-header-parsing (2017-12-15) 1 commit
 - send-email: extract email-parsing code into a subroutine

 Code refactoring.

 Undecided.


* sr/http-sslverify-config-doc (2017-12-18) 1 commit
 - config: document default value of http.sslVerify

 Docfix.

 Will merge to 'next'.


* jh/memihash-opt (2017-12-19) 1 commit
 - t/helper/test-lazy-name-hash: fix compilation

 Squelch compiler warning.

 Will merge to 'next'.


* ks/doc-previous-checkout (2017-12-19) 1 commit
 - Doc/check-ref-format: clarify information about @{-N} syntax

 Doc update.

 Will merge to 'next'.


* rs/revision-keep-pending (2017-12-19) 1 commit
 - revision: introduce prepare_revision_walk_extended()

 Code clean-up.

 Will merge to 'next'.


* ws/curl-http-proxy-over-https (2017-12-19) 1 commit
 - http: support CURLPROXY_HTTPS

 Git has been taught to support an https:// URL used for http.proxy
 when using recent versions of libcurl.

 Will merge to 'next'.


* av/fsmonitor-updates (2017-12-19) 5 commits
 - fsmonitor: Remove debugging lines from t/t7519-status-fsmonitor.sh
 - fsmonitor: complete the last line of test-dump-fsmonitor output
 - fsmonitor: update helper tool, now that flags are filled later
 - fsmonitor: include dir.h for untracked_cache_invalidate_path()
 - dir.c: update comments to match argument name

--------------------------------------------------
[Stalled]

* jc/merge-symlink-ours-theirs (2017-09-26) 1 commit
 - merge: teach -Xours/-Xtheirs to symbolic link merge

 "git merge -Xours/-Xtheirs" learned to use our/their version when
 resolving a conflicting updates to a symbolic link.

 Needs review.


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


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Expecting a reroll.


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

--------------------------------------------------
[Cooking]

* es/worktree-checkout-hook (2017-12-07) 1 commit
  (merged to 'next' on 2017-12-14 at 907d958351)
 + worktree: invoke post-checkout hook (unless --no-checkout)

 "git worktree add" learned to run the post-checkout hook, just like
 "git checkout" does, after the initial checkout.

 Will merge to 'master'.


* rs/am-builtin-leakfix (2017-12-07) 1 commit
  (merged to 'next' on 2017-12-14 at 30bf70d2cb)
 + am: release strbuf after use in split_mail_mbox()

 Leakfix.

 Will merge to 'master'.


* rs/fmt-merge-msg-string-leak-fix (2017-12-07) 1 commit
  (merged to 'next' on 2017-12-14 at 26fa3fe23e)
 + fmt-merge-msg: avoid leaking strbuf in shortlog()

 Leakfix.

 Will merge to 'master'.


* rs/strbuf-read-once-reset-length (2017-12-07) 1 commit
  (merged to 'next' on 2017-12-14 at 6d12e08217)
 + strbuf: release memory on read error in strbuf_read_once()

 Leakfix.

 Will merge to 'master'.


* db/doc-workflows-neuter-the-maintainer (2017-12-08) 1 commit
  (merged to 'next' on 2017-12-14 at 740788d890)
 + doc: reword gitworkflows.txt for neutrality

 Docfix.

 Will merge to 'master'.


* es/clone-shared-worktree (2017-12-11) 1 commit
  (merged to 'next' on 2017-12-14 at 248ef92bda)
 + clone: support 'clone --shared' from a worktree

 "git clone --shared" to borrow from a (secondary) worktree did not
 work, even though "git clone --local" did.  Both are now accepted.

 Will merge to 'master'.


* jh/partial-clone-doc (2017-12-14) 1 commit
 - partial-clone: design doc

 Will merge to 'next'.


* jk/cvsimport-quoting (2017-12-08) 1 commit
  (merged to 'next' on 2017-12-14 at ea99dc966c)
 + cvsimport: apply shell-quoting regex globally

 Typo/Logico fix.

 Will merge to 'master'.


* jk/test-suite-tracing (2017-12-08) 4 commits
 - t/Makefile: introduce TEST_SHELL_PATH
 - test-lib: make "-x" work with "--verbose-log"
 - t5615: avoid re-using descriptor 4
 - test-lib: silence "-x" cleanup under bash

 Assorted fixes around running tests with "-x" tracing option.

 Will merge to 'next'.


* jt/decorate-api (2017-12-08) 1 commit
  (merged to 'next' on 2017-12-14 at b14858df40)
 + decorate: clean up and document API

 A few structures and variables that are implementation details of
 the decorate API have been renamed and then the API got documented
 better.

 Will merge to 'master'.


* ks/branch-cleanup (2017-12-07) 4 commits
  (merged to 'next' on 2017-12-14 at af0a906984)
 + builtin/branch: strip refs/heads/ using skip_prefix
 + branch: update warning message shown when copying a misnamed branch
 + branch: group related arguments of create_branch()
 + branch: improve documentation and naming of create_branch() parameters

 Code clean-up.

 Will merge to 'master'.


* rs/fmt-merge-msg-leakfix (2017-12-08) 1 commit
  (merged to 'next' on 2017-12-14 at b87794d837)
 + transport-helper: plug strbuf and string_list leaks

 Leakfix.

 Will merge to 'master'.


* tb/delimit-pretty-trailers-args-with-comma (2017-12-08) 1 commit
  (merged to 'next' on 2017-12-14 at 7bf4f561ad)
 + docs/pretty-formats: mention commas in %(trailers) syntax

 Doc updates.

 Will merge to 'master'.


* bw/submodule-sans-cache-compat (2017-12-12) 3 commits
  (merged to 'next' on 2017-12-14 at 6893bdeed3)
 + submodule: convert get_next_submodule to not rely on the_index
 + submodule: used correct index in is_staging_gitmodules_ok
 + submodule: convert stage_updated_gitmodules to take a struct index_state

 Code clean-up.

 Will merge to 'master'.


* hi/merge-verify-sig-config (2017-12-19) 3 commits
 - t5573, t7612: clean up after unexpected success of 'pull' and 'merge'
  (merged to 'next' on 2017-12-14 at cdc511dc36)
 + t: add tests for pull --verify-signatures
 + merge: add config option for verifySignatures

 "git merge" learned to pay attention to merge.verifySignatures
 configuration variable and pretend as if '--verify-signatures'
 option was given from the command line.

 Will merge to 'next'.


* ot/pretty (2017-12-12) 2 commits
  (merged to 'next' on 2017-12-14 at d80fe80aed)
 + format: create docs for pretty.h
 + format: create pretty.h file

 Code clean-up.

 Will merge to 'master'.


* sb/test-helper-excludes (2017-12-12) 1 commit
  (merged to 'next' on 2017-12-14 at 3bfbc1c65e)
 + t/helper: ignore everything but sources

 Simplify the ignore rules for t/helper directory.

 Will merge to 'master'.


* sg/travis-fixes (2017-12-12) 4 commits
  (merged to 'next' on 2017-12-14 at c33f0c119a)
 + travis-ci: use 'set -x' in 'ci/*' scripts for extra tracing output
 + travis-ci: set GIT_TEST_HTTPD in 'ci/lib-travisci.sh'
 + travis-ci: move setting environment variables to 'ci/lib-travisci.sh'
 + travis-ci: introduce a $jobname variable for 'ci/*' scripts

 Assorted updates for TravisCI integration.

 Will merge to 'master'.


* bw/path-doc (2017-12-13) 1 commit
  (merged to 'next' on 2017-12-19 at 2cddee77ca)
 + path: document path functions

 Doc updates.

 Will merge to 'master'.


* jt/transport-no-more-rsync (2017-12-12) 1 commit
  (merged to 'next' on 2017-12-14 at 456913ad25)
 + transport: remove unused "push" in vtable
 (this branch is used by jt/transport-hide-vtable.)

 Code clean-up.

 Will merge to 'master'.


* rb/quick-install-doc (2017-12-12) 1 commit
  (merged to 'next' on 2017-12-14 at 96c17a83fa)
 + install-doc-quick: allow specifying what ref to install

 The build procedure now allows not just the repositories but also
 the refs to be used to take pre-formatted manpages and html
 documents to install.

 Will merge to 'master'.


* ab/sha1dc-build (2017-12-12) 4 commits
 - Makefile: use the sha1collisiondetection submodule by default
 - sha1dc_git.h: re-arrange an ifdef chain for a subsequent change
 - Makefile: under "make dist", include the sha1collisiondetection submodule
 - Makefile: don't error out under DC_SHA1_EXTERNAL if DC_SHA1_SUBMODULE=auto

 Push the submodule version of collision-detecting SHA-1 hash
 implementation a bit harder on builders.

 The earlier two may make sense, but leaning toward rejecting the last step.
 cf. <xmqqk1xw6c24.fsf@gitster.mtv.corp.google.com>


* ab/simplify-perl-makefile (2017-12-11) 1 commit
  (merged to 'next' on 2017-12-13 at 1b791d2503)
 + Makefile: replace perl/Makefile.PL with simple make rules

 The build procedure for perl/ part has been greatly simplified by
 weaning ourselves off of MakeMaker.

 Needs fix-up.
 cf. <CACBZZX4ZqVm2HnAbKjdZV=95gq4s7b=gycH3x-sd+zJiWEgDfg@mail.gmail.com>


* cc/skip-to-optional-val (2017-12-11) 7 commits
 - t4045: reindent to make helpers readable
 - diff: add tests for --relative without optional prefix value
 - diff: use skip_to_optional_arg_default() in parsing --relative
 - diff: use skip_to_optional_arg_default()
 - diff: use skip_to_optional_arg()
 - index-pack: use skip_to_optional_arg()
 - git-compat-util: introduce skip_to_optional_arg()

 Introduce a helper to simplify code to parse a common pattern that
 expects either "--key" or "--key=<something>".

 Will merge to 'next'.


* lb/rebase-i-short-command-names (2017-12-05) 9 commits
  (merged to 'next' on 2017-12-14 at 0637be0782)
 + t3404: add test case for abbreviated commands
 + rebase -i: learn to abbreviate command names
 + rebase -i -x: add exec commands via the rebase--helper
 + rebase -i: update functions to use a flags parameter
 + rebase -i: replace reference to sha1 with oid
 + rebase -i: refactor transform_todo_ids
 + rebase -i: set commit to null in exec commands
 + Documentation: use preferred name for the 'todo list' script
 + Documentation: move rebase.* configs to new file

 Allow a single-letter command name in the "rebase -i" todo list.

 Will merge to 'master'.


* ra/prompt-eread-fix (2017-12-06) 2 commits
 - git-prompt: fix reading files with windows line endings
 - git-prompt: make __git_eread intended use explicit

 Update the shell prompt script (in contrib/) to strip trailing CR
 from strings read from various "state" files.

 Will merge to 'next'.


* tb/check-crlf-for-safe-crlf (2017-12-08) 2 commits
  (merged to 'next' on 2017-12-08 at 5279b80103)
 + t0027: Adapt the new MIX tests to Windows
  (merged to 'next' on 2017-12-05 at 7adaa1fe01)
 + convert: tighten the safe autocrlf handling

 The "safe crlf" check incorrectly triggered for contents that does
 not use CRLF as line endings, which has been corrected.

 Will merge to 'master'.


* cc/require-tcl-tk-for-build (2017-11-29) 2 commits
 - travis-ci: avoid new tcl/tk build requirement
 - Makefile: check that tcl/tk is installed

 A first-time builder of Git may have installed neither tclsh nor
 msgfmt, in which case git-gui and gitk part will fail and break the
 build.  As a workaround, refuse to run a build when tclsh is not
 installed and NO_TCLTK is not set.

 Undecided.
 I still feel that requring tclsh to be installed, with or without
 "escape hatch" for experts, may be too heavy-handed.


* mk/http-backend-content-length (2017-11-27) 4 commits
 - SQUASH???
 - t5560-http-backend-noserver.sh: add CONTENT_LENGTH cases
 - SQUASH???
 - http-backend: respect CONTENT_LENGTH as specified by rfc3875

 The http-backend (used for smart-http transport) used to slurp the
 whole input until EOF, without paying attention to CONTENT_LENGTH
 that is supplied in the environment and instead expecting the Web
 server to close the input stream.  This has been fixed.

 Expecting a reroll.
 Suggested fixes to be used when rerolling is queued, but I'd
 prefer _not_ squashing them myself.


* en/rename-directory-detection (2017-12-13) 35 commits
 - SQUASH???
 - merge-recursive: ensure we write updates for directory-renamed file
 - merge-recursive: avoid spurious rename/rename conflict from dir renames
 - directory rename detection: new testcases showcasing a pair of bugs
 - merge-recursive: fix remaining directory rename + dirty overwrite cases
 - merge-recursive: fix overwriting dirty files involved in renames
 - merge-recursive: avoid clobbering untracked files with directory renames
 - merge-recursive: apply necessary modifications for directory renames
 - merge-recursive: when comparing files, don't include trees
 - merge-recursive: check for file level conflicts then get new name
 - merge-recursive: add computation of collisions due to dir rename & merging
 - merge-recursive: add a new hashmap for storing file collisions
 - merge-recursive: check for directory level conflicts
 - merge-recursive: add get_directory_renames()
 - merge-recursive: make a helper function for cleanup for handle_renames
 - merge-recursive: add a new hashmap for storing directory renames
 - merge-recursive: split out code for determining diff_filepairs
 - merge-recursive: make !o->detect_rename codepath more obvious
 - merge-recursive: fix leaks of allocated renames and diff_filepairs
 - merge-recursive: introduce new functions to handle rename logic
 - merge-recursive: move the get_renames() function
 - directory rename detection: tests for handling overwriting dirty files
 - directory rename detection: tests for handling overwriting untracked files
 - directory rename detection: miscellaneous testcases to complete coverage
 - directory rename detection: testcases exploring possibly suboptimal merges
 - directory rename detection: more involved edge/corner testcases
 - directory rename detection: testcases checking which side did the rename
 - directory rename detection: files/directories in the way of some renames
 - directory rename detection: partially renamed directory testcase/discussion
 - directory rename detection: testcases to avoid taking detection too far
 - directory rename detection: directory splitting testcases
 - directory rename detection: basic testcases
 - merge-recursive: add explanation for src_entry and dst_entry
 - merge-recursive: fix logic ordering issue
 - Tighten and correct a few testcases for merging and cherry-picking

 Rename detection logic in "diff" family that is used in "merge" has
 learned to guess when all of x/a, x/b and x/c have moved to z/a,
 z/b and z/c, it is likely that x/d added in the meantime would also
 want to move to z/d by taking the hint that the entire directory
 'x' moved to 'z'.

 Needs review.


* sb/diff-blobfind (2017-12-12) 1 commit
  (merged to 'next' on 2017-12-13 at 9a27a20c5f)
 + diffcore: add a filter to find a specific blob

 "git diff" family of commands learned --blobfind=<object-name> that
 allows you to limit the output only to a change that involves the
 named blob object (either changing the contents from or to it).

 Will merge to 'master'.


* pw/sequencer-in-process-commit (2017-12-13) 10 commits
  (merged to 'next' on 2017-12-13 at ec4d2b9c84)
 + sequencer: improve config handling
  (merged to 'next' on 2017-12-06 at a4212f7ebd)
 + t3512/t3513: remove KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
 + sequencer: try to commit without forking 'git commit'
 + sequencer: load commit related config
 + sequencer: simplify adding Signed-off-by: trailer
 + commit: move print_commit_summary() to libgit
 + commit: move post-rewrite code to libgit
 + Add a function to update HEAD after creating a commit
 + commit: move empty message checks to libgit
 + t3404: check intermediate squash messages

 The sequencer infrastructure is shared across "git cherry-pick",
 "git rebase -i", etc., and has always spawned "git commit" when it
 needs to create a commit.  It has been taught to do so internally,
 when able, by reusing the codepath "git commit" itself uses, which
 gives performance boost for a few tens of percents in some sample
 scenarios.

 Will merge to 'master'.


* dj/runtime-prefix (2017-12-05) 4 commits
 . exec_cmd: RUNTIME_PREFIX on some POSIX systems
 . Makefile: add Perl runtime prefix support
 . Makefile: add support for "perllibdir"
 . Makefile: generate Perl header from template file

 A build-time option has been added to allow Git to be told to refer
 to its associated files relative to the main binary, in the same
 way that has been possible on Windows for quite some time, for
 Linux, BSDs and Darwin.

 Tentatively kicked out of 'next' to see how well another topic
 ab/simplify-perl-makefile that heavily conflicts with this fares.


* jh/object-filtering (2017-12-05) 9 commits
  (merged to 'next' on 2017-12-05 at 3a56b51085)
 + rev-list: support --no-filter argument
 + list-objects-filter-options: support --no-filter
 + list-objects-filter-options: fix 'keword' typo in comment
  (merged to 'next' on 2017-11-27 at e5008c3b28)
 + pack-objects: add list-objects filtering
 + rev-list: add list-objects filtering support
 + list-objects: filter objects in traverse_commit_list
 + oidset: add iterator methods to oidset
 + oidmap: add oidmap iterator methods
 + dir: allow exclusions from blob in addition to file
 (this branch is used by jh/fsck-promisors and jh/partial-clone.)

 In preparation for implementing narrow/partial clone, the object
 walking machinery has been taught a way to tell it to "filter" some
 objects from enumeration.

 Will merge to 'master'.


* jh/fsck-promisors (2017-12-08) 10 commits
 - gc: do not repack promisor packfiles
 - rev-list: support termination at promisor objects
 - sha1_file: support lazily fetching missing objects
 - introduce fetch-object: fetch one promisor object
 - index-pack: refactor writing of .keep files
 - fsck: support promisor objects as CLI argument
 - fsck: support referenced promisor objects
 - fsck: support refs pointing to promisor objects
 - fsck: introduce partialclone extension
 - extension.partialclone: introduce partial clone extension
 (this branch is used by jh/partial-clone; uses jh/object-filtering.)

 In preparation for implementing narrow/partial clone, the machinery
 for checking object connectivity used by gc and fsck has been
 taught that a missing object is OK when it is referenced by a
 packfile specially marked as coming from trusted repository that
 promises to make them available on-demand and lazily.


* jh/partial-clone (2017-12-08) 13 commits
 - t5616: test bulk prefetch after partial fetch
 - fetch: inherit filter-spec from partial clone
 - t5616: end-to-end tests for partial clone
 - fetch-pack: restore save_commit_buffer after use
 - unpack-trees: batch fetching of missing blobs
 - clone: partial clone
 - partial-clone: define partial clone settings in config
 - fetch: support filters
 - fetch: refactor calculation of remote list
 - fetch-pack: test support excluding large blobs
 - fetch-pack: add --no-filter
 - fetch-pack, index-pack, transport: partial clone
 - upload-pack: add object filtering for partial clone
 (this branch uses jh/fsck-promisors and jh/object-filtering.)

 The machinery to clone & fetch, which in turn involves packing and
 unpacking objects, have been told how to omit certain objects using
 the filtering mechanism introduced by the jh/object-filtering
 topic, and also mark the resulting pack as a promisor pack to
 tolerate missing objects, taking advantage of the mechanism
 introduced by the jh/fsck-promisors topic.


* sb/describe-blob (2017-12-19) 7 commits
 - builtin/describe.c: describe a blob
 - builtin/describe.c: factor out describe_commit
 - builtin/describe.c: print debug statements earlier
 - builtin/describe.c: rename `oid` to avoid variable shadowing
 - revision.h: introduce blob/tree walking in order of the commits
 - list-objects.c: factor out traverse_trees_and_blobs
 - t6120: fix typo in test name

 "git describe" was taught to dig trees deeper to find a
 <commit-ish>:<path> that refers to a given blob object.

 Will merge to 'next'.


* pb/bisect-helper-2 (2017-10-28) 8 commits
 - t6030: make various test to pass GETTEXT_POISON tests
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `bisect_reset` shell function in C

 Expecting a reroll.
 cf. <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>


* ot/mru-on-list (2017-10-01) 1 commit
 - mru: use double-linked list from list.h

 The first step to getting rid of mru API and using the
 doubly-linked list API directly instead.

 Is there any remaining issues on this one?


* jm/svn-pushmergeinfo-fix (2017-09-17) 1 commit
 - git-svn: fix svn.pushmergeinfo handling of svn+ssh usernames.

 "git svn dcommit" did not take into account the fact that a
 svn+ssh:// URL with a username@ (typically used for pushing) refers
 to the same SVN repository without the username@ and failed when
 svn.pushmergeinfo option is set.

 Needs a test, perhaps as a follow-up patch.

 Will merge to 'next'.
