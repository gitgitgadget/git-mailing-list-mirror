Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F871F404
	for <e@80x24.org>; Wed, 27 Dec 2017 21:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbdL0Vev (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 16:34:51 -0500
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:60682 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdL0Vet (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 16:34:49 -0500
Received: from pb-sasl-trial3.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id CC61022F9E;
        Wed, 27 Dec 2017 16:34:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=u
        SYRHRckzyPDWiRjzV5JZPyZVrs=; b=nAf32OTqDZKhiM/UtzMXOf4EHYtsu2viO
        cWVigwY2TdY4LeW8pctWB5iIXjnSXsOuM2qLVS/WOn4Z5jtpBI8pVhH+MjVew4xd
        +SaSBXAK1GdG0RE+4OLm++TDc3Iijvzv2avXkY+0ajROVVJAeceJxYJ97u2emg4b
        i85RGwH32M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=rQV
        LxBrnbHK6XuFeaz+BM5qvouox2pywny6GvYZs9NWLi/9HbdaKNxNejc2VKNvXQNS
        CbPyi4UJ/wTi2sQSLLrrBZ73v+ex/MTgoHLXYRZjrsbpQD3gWQMfv4WczoPH9HgM
        3P3R7KDtkxbnKU+ySEe+yp/7U/ed3ypsosjfuNOE=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id A8BF622F9D;
        Wed, 27 Dec 2017 16:34:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D86F5B8C16;
        Wed, 27 Dec 2017 16:34:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2017, #05; Wed, 27)
X-master-at: 29533fb16899725af9306e0c3b83da8954c0e48a
X-next-at: 6967081ed51529cca3ee7e069552338903ad0b30
Date:   Wed, 27 Dec 2017 13:34:45 -0800
Message-ID: <xmqq608rn9ca.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2B37A88-EB4D-11E7-A5D3-575F0C78B957-77302942!pb-smtp2.pobox.com
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

* bw/submodule-sans-cache-compat (2017-12-12) 3 commits
  (merged to 'next' on 2017-12-14 at 6893bdeed3)
 + submodule: convert get_next_submodule to not rely on the_index
 + submodule: used correct index in is_staging_gitmodules_ok
 + submodule: convert stage_updated_gitmodules to take a struct index_state

 Code clean-up.


* db/doc-workflows-neuter-the-maintainer (2017-12-08) 1 commit
  (merged to 'next' on 2017-12-14 at 740788d890)
 + doc: reword gitworkflows.txt for neutrality

 Docfix.


* es/clone-shared-worktree (2017-12-11) 1 commit
  (merged to 'next' on 2017-12-14 at 248ef92bda)
 + clone: support 'clone --shared' from a worktree

 "git clone --shared" to borrow from a (secondary) worktree did not
 work, even though "git clone --local" did.  Both are now accepted.


* es/worktree-checkout-hook (2017-12-07) 1 commit
  (merged to 'next' on 2017-12-14 at 907d958351)
 + worktree: invoke post-checkout hook (unless --no-checkout)

 "git worktree add" learned to run the post-checkout hook, just like
 "git checkout" does, after the initial checkout.


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


* jk/cvsimport-quoting (2017-12-08) 1 commit
  (merged to 'next' on 2017-12-14 at ea99dc966c)
 + cvsimport: apply shell-quoting regex globally

 Typo/Logico fix.


* jt/decorate-api (2017-12-08) 1 commit
  (merged to 'next' on 2017-12-14 at b14858df40)
 + decorate: clean up and document API

 A few structures and variables that are implementation details of
 the decorate API have been renamed and then the API got documented
 better.


* jt/transport-no-more-rsync (2017-12-12) 1 commit
  (merged to 'next' on 2017-12-14 at 456913ad25)
 + transport: remove unused "push" in vtable
 (this branch is used by jt/transport-hide-vtable.)

 Code clean-up.


* ks/branch-cleanup (2017-12-07) 4 commits
  (merged to 'next' on 2017-12-14 at af0a906984)
 + builtin/branch: strip refs/heads/ using skip_prefix
 + branch: update warning message shown when copying a misnamed branch
 + branch: group related arguments of create_branch()
 + branch: improve documentation and naming of create_branch() parameters

 Code clean-up.


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

 With a configuration variable rebase.abbreviateCommands set,
 "git rebase -i" produces the todo list with a single-letter
 command names.


* ot/pretty (2017-12-12) 2 commits
  (merged to 'next' on 2017-12-14 at d80fe80aed)
 + format: create docs for pretty.h
 + format: create pretty.h file

 Code clean-up.


* rb/quick-install-doc (2017-12-12) 1 commit
  (merged to 'next' on 2017-12-14 at 96c17a83fa)
 + install-doc-quick: allow specifying what ref to install

 The build procedure now allows not just the repositories but also
 the refs to be used to take pre-formatted manpages and html
 documents to install.


* rs/am-builtin-leakfix (2017-12-07) 1 commit
  (merged to 'next' on 2017-12-14 at 30bf70d2cb)
 + am: release strbuf after use in split_mail_mbox()

 Leakfix.


* rs/fmt-merge-msg-leakfix (2017-12-08) 1 commit
  (merged to 'next' on 2017-12-14 at b87794d837)
 + transport-helper: plug strbuf and string_list leaks

 Leakfix.


* rs/fmt-merge-msg-string-leak-fix (2017-12-07) 1 commit
  (merged to 'next' on 2017-12-14 at 26fa3fe23e)
 + fmt-merge-msg: avoid leaking strbuf in shortlog()

 Leakfix.


* rs/strbuf-read-once-reset-length (2017-12-07) 1 commit
  (merged to 'next' on 2017-12-14 at 6d12e08217)
 + strbuf: release memory on read error in strbuf_read_once()

 Leakfix.


* sb/test-helper-excludes (2017-12-12) 1 commit
  (merged to 'next' on 2017-12-14 at 3bfbc1c65e)
 + t/helper: ignore everything but sources

 Simplify the ignore rules for t/helper directory.


* tb/check-crlf-for-safe-crlf (2017-12-08) 2 commits
  (merged to 'next' on 2017-12-08 at 5279b80103)
 + t0027: Adapt the new MIX tests to Windows
  (merged to 'next' on 2017-12-05 at 7adaa1fe01)
 + convert: tighten the safe autocrlf handling

 The "safe crlf" check incorrectly triggered for contents that does
 not use CRLF as line endings, which has been corrected.


* tb/delimit-pretty-trailers-args-with-comma (2017-12-08) 1 commit
  (merged to 'next' on 2017-12-14 at 7bf4f561ad)
 + docs/pretty-formats: mention commas in %(trailers) syntax

 Doc updates.

--------------------------------------------------
[New Topics]

* ab/commit-m-with-fixup (2017-12-22) 2 commits
 - commit: add support for --fixup <commit> -m"<extra message>"
 - commit doc: document that -c, -C, -F and --fixup with -m error

 "git commit --fixup" did not allow "-m<message>" option to be used
 at the same time; allow it to annotate resulting commit with more
 text.


* db/doc-config-section-names-with-bs (2017-12-22) 1 commit
 - config.txt: document behavior of backslashes in subsections

 Doc update.

 Will merge to 'next'.


* ew/empty-merge-with-dirty-index (2017-12-22) 1 commit
 - Merge branch 'ew/empty-merge-with-dirty-index-maint' into ew/empty-merge-with-dirty-index
 (this branch uses ew/empty-merge-with-dirty-index-maint.)

 "git merge -s recursive" did not correctly abort when the index is
 dirty, if the merged tree happened to be the same as the current
 HEAD, which has been fixed.

 Will merge to 'next'.


* ew/empty-merge-with-dirty-index-maint (2017-12-22) 3 commits
 - merge-recursive: avoid incorporating uncommitted changes in a merge
 - move index_has_changes() from builtin/am.c to merge.c for reuse
 - t6044: recursive can silently incorporate dirty changes in a merge
 (this branch is used by ew/empty-merge-with-dirty-index.)

 "git merge -s recursive" did not correctly abort when the index is
 dirty, if the merged tree happened to be the same as the current
 HEAD, which has been fixed.

 Will merge to 'next'.


* jd/fix-strbuf-add-urlencode-bytes (2017-12-22) 1 commit
 - strbuf: fix urlencode format string on signed char

 Bytes with high-bit set were encoded incorrectly and made
 credential helper fail.

 Will merge to 'next'.


* ld/p4-multiple-shelves (2017-12-22) 1 commit
 - git-p4: update multiple shelved change lists

 "git p4" update.

 Will merge to 'next'.


* rs/use-argv-array-in-child-process (2017-12-22) 2 commits
 - send-pack: use internal argv_array of struct child_process
 - http: use internal argv_array of struct child_process

 Code cleanup.

 Will merge to 'next'.


* tb/test-lint-wc-l (2017-12-22) 1 commit
 - check-non-portable-shell.pl: `wc -l` may have leading WS

 Test update.

 Will merge to 'next'.


* bw/oidmap-autoinit (2017-12-27) 1 commit
 - oidmap: ensure map is initialized


* dk/describe-all-output-fix (2017-12-27) 1 commit
 - describe: prepend "tags/" when describing tags with embedded name

 An old regression in "git describe --all $annotated_tag^0" has been
 fixed.

 Will merge to 'next'.


* js/sequencer-cleanups (2017-12-27) 5 commits
 - sequencer: do not invent whitespace when transforming OIDs
 - sequencer: report when noop has an argument
 - sequencer: remove superfluous conditional
 - sequencer: strip bogus LF at end of error messages
 - rebase: do not continue when the todo list generation failed

 Code cleanup.

 Will merge to 'next'.


* nd/fix-untracked-cache-invalidation (2017-12-27) 3 commits
 - update-index doc: note a fixed bug in the untracked cache
 - dir.c: fix missing dir invalidation in untracked code
 - status: add a failing test showing a core.untrackedCache bug


* nd/ita-wt-renames-in-status (2017-12-27) 6 commits
 - wt-status.c: handle worktree renames
 - wt-status.c: rename rename-related fields in wt_status_change_data
 - wt-status.c: catch unhandled diff status codes
 - wt-status.c: coding style fix
 - Use DIFF_DETECT_RENAME for detect_rename assignments
 - t2203: test status output with porcelain v2 format

 "git status" after moving a path in the working tree (hence making
 it appear "removed") and then adding with the -N option (hence
 making that appear "added") detected it as a rename, but did not
 report the  old and new pathnames correctly.

 Will merge to 'next'.


* sg/travis-skip-identical-test (2017-12-27) 2 commits
 - travis-ci: record and skip successfully built trees
 - travis-ci: don't try to create the cache directory unnecessarily
 (this branch uses sg/travis-fixes.)

 Avoid repeatedly testing the same tree in TravisCI that have been
 tested successfully already.

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

* ew/svn-crlf (2017-12-14) 2 commits
  (merged to 'next' on 2017-12-27 at 1b81bd634d)
 + Merge branch 'svn-crlf' of git://bogomips.org/git-svn into ew/svn-crlf
 + git-svn: convert CRLF to LF in commit message to SVN

 "git svn" has been updated to strip CRs in the commit messages, as
 recent versions of Subversion rejects them.

 Will merge to 'master'.


* tz/lib-git-svn-svnserve-tests (2017-12-14) 2 commits
  (merged to 'next' on 2017-12-27 at 54513f6e20)
 + t/lib-git-svn.sh: improve svnserve tests with parallel make test
 + t/lib-git-svn: cleanup inconsistent tab/space usage

 Will merge to 'master'.


* bp/fsmonitor (2017-12-18) 1 commit
  (merged to 'next' on 2017-12-27 at ce216e2978)
 + p7519: improve check for prerequisite WATCHMAN

 Test fix.

 Will merge to 'master'.


* js/enhanced-version-info (2017-12-14) 2 commits
  (merged to 'next' on 2017-12-27 at a95dd96a78)
 + version --build-options: report commit, too, if possible
 + version --build-options: also report host CPU

 "git version --build-options" learned to report the host CPU and
 the exact commit object name the binary was built from.

 Will merge to 'master'.


* jt/transport-hide-vtable (2017-12-14) 2 commits
  (merged to 'next' on 2017-12-27 at 8dc27cfb53)
 + transport: make transport vtable more private
 + clone, fetch: remove redundant transport check

 Code clean-up.

 Will merge to 'master'.


* ks/rebase-error-messages (2017-12-19) 3 commits
  (merged to 'next' on 2017-12-27 at 80c62260ad)
 + rebase: rebasing can also be done when HEAD is detached
 + rebase: distinguish user input by quoting it
 + rebase: consistently use branch_name variable

 Error messages from "git rebase" have been somewhat cleaned up.

 Will merge to 'master'.


* nm/imap-send-quote-server-folder-name (2017-12-18) 1 commit
  (merged to 'next' on 2017-12-27 at 79326a0b77)
 + imap-send: URI encode server folder

 "git imap-send" did not correctly quote the folder name when
 making a request to the server, which has been corrected.

 Will merge to 'master'.


* np/send-email-header-parsing (2017-12-15) 1 commit
 - send-email: extract email-parsing code into a subroutine

 Code refactoring.

 Undecided.


* sr/http-sslverify-config-doc (2017-12-18) 1 commit
  (merged to 'next' on 2017-12-27 at 84a461c4b5)
 + config: document default value of http.sslVerify

 Docfix.

 Will merge to 'master'.


* jh/memihash-opt (2017-12-22) 1 commit
 - t/helper/test-lazy-name-hash: fix compilation

 Squelch compiler warning.

 Will merge to 'next'.


* ks/doc-previous-checkout (2017-12-19) 1 commit
  (merged to 'next' on 2017-12-27 at c706239a69)
 + Doc/check-ref-format: clarify information about @{-N} syntax

 Doc update.

 Will merge to 'master'.


* rs/revision-keep-pending (2017-12-19) 1 commit
  (merged to 'next' on 2017-12-27 at 20a9527941)
 + revision: introduce prepare_revision_walk_extended()

 Code clean-up.

 Will merge to 'master'.


* ws/curl-http-proxy-over-https (2017-12-19) 1 commit
  (merged to 'next' on 2017-12-27 at 895bf2f94b)
 + http: support CURLPROXY_HTTPS

 Git has been taught to support an https:// URL used for http.proxy
 when using recent versions of libcurl.

 Will merge to 'master'.


* av/fsmonitor-updates (2017-12-19) 5 commits
 - fsmonitor: Remove debugging lines from t/t7519-status-fsmonitor.sh
 - fsmonitor: complete the last line of test-dump-fsmonitor output
 - fsmonitor: update helper tool, now that flags are filled later
 - fsmonitor: include dir.h for untracked_cache_invalidate_path()
 - dir.c: update comments to match argument name


* jh/partial-clone-doc (2017-12-14) 1 commit
  (merged to 'next' on 2017-12-27 at 3695847773)
 + partial-clone: design doc

 Will merge to 'master'.


* jk/test-suite-tracing (2017-12-08) 4 commits
  (merged to 'next' on 2017-12-27 at 7034a51474)
 + t/Makefile: introduce TEST_SHELL_PATH
 + test-lib: make "-x" work with "--verbose-log"
 + t5615: avoid re-using descriptor 4
 + test-lib: silence "-x" cleanup under bash

 Assorted fixes around running tests with "-x" tracing option.

 Will merge to 'master'.


* hi/merge-verify-sig-config (2017-12-19) 3 commits
  (merged to 'next' on 2017-12-27 at 34360fb1c1)
 + t5573, t7612: clean up after unexpected success of 'pull' and 'merge'
  (merged to 'next' on 2017-12-14 at cdc511dc36)
 + t: add tests for pull --verify-signatures
 + merge: add config option for verifySignatures

 "git merge" learned to pay attention to merge.verifySignatures
 configuration variable and pretend as if '--verify-signatures'
 option was given from the command line.

 Will merge to 'master'.


* sg/travis-fixes (2017-12-27) 4 commits
 - travis-ci: only print test failures if there are test results available
 - travis-ci: save prove state for the 32 bit Linux build
 - travis-ci: don't install default addon packages for the 32 bit Linux build
 - travis-ci: fine tune the use of 'set -x' in 'ci/*' scripts
 (this branch is used by sg/travis-skip-identical-test.)

 Assorted updates for TravisCI integration.

 Will merge to 'next'.


* bw/path-doc (2017-12-13) 1 commit
  (merged to 'next' on 2017-12-19 at 2cddee77ca)
 + path: document path functions

 Doc updates.

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


* ab/simplify-perl-makefile (2017-12-22) 2 commits
 - perl: avoid *.pmc and fix Error.pm further
  (merged to 'next' on 2017-12-13 at 1b791d2503)
 + Makefile: replace perl/Makefile.PL with simple make rules

 The build procedure for perl/ part has been greatly simplified by
 weaning ourselves off of MakeMaker.

 Waiting for an Ack.


* cc/skip-to-optional-val (2017-12-11) 7 commits
  (merged to 'next' on 2017-12-27 at 1b189d8556)
 + t4045: reindent to make helpers readable
 + diff: add tests for --relative without optional prefix value
 + diff: use skip_to_optional_arg_default() in parsing --relative
 + diff: use skip_to_optional_arg_default()
 + diff: use skip_to_optional_arg()
 + index-pack: use skip_to_optional_arg()
 + git-compat-util: introduce skip_to_optional_arg()

 Introduce a helper to simplify code to parse a common pattern that
 expects either "--key" or "--key=<something>".

 Will merge to 'master'.


* ra/prompt-eread-fix (2017-12-06) 2 commits
  (merged to 'next' on 2017-12-27 at ae870af11d)
 + git-prompt: fix reading files with windows line endings
 + git-prompt: make __git_eread intended use explicit

 Update the shell prompt script (in contrib/) to strip trailing CR
 from strings read from various "state" files.

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

 Also, it may be too complex solution for the problem.
 cf. <20171204171308.GA13332@sigill.intra.peff.net>


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


* pw/sequencer-in-process-commit (2017-12-22) 11 commits
 - sequencer: assign only free()able strings to gpg_sign
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

 Will merge to 'next'.


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
 (this branch is used by jh/partial-clone.)

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
 (this branch uses jh/fsck-promisors.)

 The machinery to clone & fetch, which in turn involves packing and
 unpacking objects, have been told how to omit certain objects using
 the filtering mechanism introduced by the jh/object-filtering
 topic, and also mark the resulting pack as a promisor pack to
 tolerate missing objects, taking advantage of the mechanism
 introduced by the jh/fsck-promisors topic.


* sb/describe-blob (2017-12-19) 7 commits
  (merged to 'next' on 2017-12-27 at 1249ca9213)
 + builtin/describe.c: describe a blob
 + builtin/describe.c: factor out describe_commit
 + builtin/describe.c: print debug statements earlier
 + builtin/describe.c: rename `oid` to avoid variable shadowing
 + revision.h: introduce blob/tree walking in order of the commits
 + list-objects.c: factor out traverse_trees_and_blobs
 + t6120: fix typo in test name

 "git describe" was taught to dig trees deeper to find a
 <commit-ish>:<path> that refers to a given blob object.

 Will merge to 'master'.


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
