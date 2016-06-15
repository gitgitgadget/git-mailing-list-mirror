From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2009, #04; Sun, 23)
Date: Sun, 23 Aug 2009 18:01:50 -0700
Message-ID: <7v1vn2qb29.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 03:02:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfNwm-0002kl-Vn
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 03:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbZHXBB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 21:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbZHXBB6
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 21:01:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbZHXBB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 21:01:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A9EB3355DF;
	Sun, 23 Aug 2009 21:01:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=ZLen
	WF+oZYwy2HRH9Ac25+xdcYs=; b=tQ9PP4x2Hdz8zHnJgakjmPmX0kS872ppGA7H
	NFE1AU5kLoxa+wG63JeoPFMJoOFFjSyrXP8IzLweO0vEoKHRatrJBmP7kFuLrfwp
	sXsLvCBlRaublVYasJglWDO50v3ZTqLpUkTKRC8bZhKOl3JdR5dwrRqvUoats0Gn
	4HYaXjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=adx
	DL72+bDSMxNFNqrE/1ZwdTfSoxEJIDy3LZRsWAZFSliD5RtSIbE/cTPGtheldm71
	sjpwUZrQV00H/TIfecAxsfYA6N4IyjshIT5Hr728ebY+UP1lk1p2gprtZyg4/9zD
	Nd90rkmNjyDOI0AECEnACqdRldjlI4p5pGw6zN+A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 98D4E355DE;
	Sun, 23 Aug 2009 21:01:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4C560355DD; Sun, 23 Aug 2009
 21:01:52 -0400 (EDT)
X-master-at: 2e1176d51ef4fc07f487818acdfcf2fc4b789203
X-next-at: 38eb7501aaddd72a8e6007f281d6a3cfa42a2a02
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B7A5F7E6-9049-11DE-A77A-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126897>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

After the 1.6.5 cycle, the next release will be 1.7.0, and we will push
out the planned "push safety" change.  1.7.0 would be a good time to
introduce "justifiable" changes that are not strictly backward compatible.

During 1.6.5 cycle, 'next' will hold topics meant for 1.6.5 and 1.7.0.

--------------------------------------------------
[Graduated to "master"]

* bc/mailsplit-cr-at-eol (2009-08-04) 4 commits
  (merged to 'next' on 2009-08-06 at 6bc7c5c)
 + Allow mailsplit (and hence git-am) to handle mails with CRLF line-endings
 + builtin-mailsplit.c: remove read_line_with_nul() since it is no longer used
 + builtin-mailinfo,builtin-mailsplit: use strbufs
 + strbuf: add new function strbuf_getwholeline()

* gb/apply-ignore-whitespace (2009-08-04) 1 commit
  (merged to 'next' on 2009-08-06 at 59e2c86)
 + git apply: option to ignore whitespace differences

* cc/replace (2009-05-27) 14 commits.
  (merged to 'next' on 2009-08-02 at b9c4bc0)
 + t6050: check pushing something based on a replaced commit
 + Documentation: add documentation for "git replace"
 + Add git-replace to .gitignore
 + builtin-replace: use "usage_msg_opt" to give better error messages
 + parse-options: add new function "usage_msg_opt"
 + builtin-replace: teach "git replace" to actually replace
 + Add new "git replace" command
 + environment: add global variable to disable replacement
 + mktag: call "check_sha1_signature" with the replacement sha1
 + replace_object: add a test case
 + object: call "check_sha1_signature" with the replacement sha1
 + sha1_file: add a "read_sha1_file_repl" function
 + replace_object: add mechanism to replace objects found in "refs/replace/"
 + refs: add a "for_each_replace_ref" function

* ld/p4 (2009-07-30) 1 commit
  (merged to 'next' on 2009-08-14 at 36d310d)
 + git-p4: stream from perforce to speed up clones

* mr/gitweb-xz (2009-08-06) 3 commits
  (merged to 'next' on 2009-08-14 at b63b8e6)
 + gitweb: add support for XZ compressed snapshots
 + gitweb: update INSTALL regarding specific snapshot settings
 + gitweb: support to globally disable a snapshot format

* jc/verify-pack-stat (2009-08-07) 1 commit
  (merged to 'next' on 2009-08-10 at f80d0e9)
 + verify-pack --stat-only: show histogram without verifying
--------------------------------------------------
[New Topics]

* jc/mailinfo-scissors (2009-08-23) 1 commit
 - Teach mailinfo to ignore everything before -- >8 -- mark

* tf/diff-whitespace-incomplete-line (2009-08-23) 2 commits.
 - xutils: Fix xdl_recmatch() on incomplete lines
 - xutils: Fix hashing an incomplete line with whitespaces at the end

* jc/1.7.0-send-email-no-thread-default (2009-08-22) 1 commit
  (merged to 'next' on 2009-08-22 at 5106de8)
 + send-email: make --no-chain-reply-to the default

* lt/approxidate (2009-08-22) 2 commits
 - Further 'approxidate' improvements
 - Improve on 'approxidate'

* mm/reset-report (2009-08-21) 2 commits
 - reset: make the reminder output consistent with "checkout"
 - Rename REFRESH_SAY_CHANGED to REFRESH_IN_PORCELAIN.

* wl/insta-mongoose (2009-08-21) 1 commit
 - Add support for the Mongoose web server.
--------------------------------------------------
[Stalled]

* sr/gfi-options (2009-08-13) 3 commits
 - fast-import: test the new option command
 - fast-import: add option command
 - fast-import: put option parsing code in seperate functions

What is this used by?

* lt/block-sha1 (2009-08-17) 4 commits
  (merged to 'next' on 2009-08-18 at 67a1ce8)
 + remove ARM and Mozilla SHA1 implementations
 + block-sha1: guard gcc extensions with __GNUC__
 + make sure byte swapping is optimal for git
 + block-sha1: make the size member first in the context struct

Finishing touches ;-)  There were a few Solaris portability patches
floated around that I didn't pick up, waiting for them to finalize.

* js/stash-dwim (2009-07-27) 1 commit.
  (merged to 'next' on 2009-08-16 at 67896c4)
 + Make 'git stash -k' a short form for 'git stash save --keep-index'
 (this branch is used by tr/reset-checkout-patch.)

* tr/reset-checkout-patch (2009-08-18) 8 commits.
  (merged to 'next' on 2009-08-18 at e465bb3)
 + tests: disable interactive hunk selection tests if perl is not available
  (merged to 'next' on 2009-08-16 at 67896c4)
 + DWIM 'git stash save -p' for 'git stash -p'
 + Implement 'git stash save --patch'
 + Implement 'git checkout --patch'
 + Implement 'git reset --patch'
 + builtin-add: refactor the meat of interactive_add()
 + Add a small patch-mode testing library
 + git-apply--interactive: Refactor patch mode code
 (this branch uses js/stash-dwim.)

There was a discussion on better DWIMmery for the above two topics to (1)
forbid "git stash save --anything-with-dash" and (2) redirect with any
option "git stash --opt" to "git stash save --opt", to keep it flexible
and safe at the same time.  I think it is a sane thing to do, but nothing
has happened lately.

* jn/gitweb-blame (2009-08-06) 3 commits
 - gitweb: Create links leading to 'blame_incremental' using JavaScript
 - gitweb: Incremental blame (WIP)
 - gitweb: Add optional "time to generate page" info in footer

Ajax-y blame WIP

* db/vcs-helper (2009-08-09) 17 commits
 - Allow helpers to request marks for fast-import
 - Allow helpers to report in "list" command that the ref is unchanged
 - Add support for "import" helper command
 - transport-helper_init(): fix a memory leak in error path
 - Add a config option for remotes to specify a foreign vcs
 - Allow programs to not depend on remotes having urls
 - Allow fetch to modify refs
 - Use a function to determine whether a remote is valid
 - Use a clearer style to issue commands to remote helpers
  (merged to 'next' on 2009-08-07 at f3533ba)
 + Makefile: install hardlinks for git-remote-<scheme> supported by libcurl if possible
 + Makefile: do not link three copies of git-remote-* programs
 + Makefile: git-http-fetch does not need expat
  (merged to 'next' on 2009-08-06 at 15da79d)
 + http-fetch: Fix Makefile dependancies
 + Add transport native helper executables to .gitignore
  (merged to 'next' on 2009-08-05 at 33d491e)
 + git-http-fetch: not a builtin
 + Use an external program to implement fetching with curl
 + Add support for external programs for handling native fetches
 (this branch is used by jh/cvs-helper.)

There was a discussion that suggests that the use of colon ':' before vcs
helper name needs to be corrected.  Nothing happened since.

* je/send-email-no-subject (2009-08-05) 1 commit
 - send-email: confirm on empty mail subjects

This seems to break t9001.  Near the tip of 'pu' I have a iffy
workaround.

--------------------------------------------------
[Cooking]

* cc/sequencer-rebase-i (2009-08-21) 17 commits.
 - rebase -i: use "git sequencer--helper --cherry-pick"
 - sequencer: add "--cherry-pick" option to "git sequencer--helper"
 - sequencer: add "do_commit()" and related functions
 - pick: libify "pick_help_msg()"
 - revert: libify pick
 - rebase -i: use "git sequencer--helper --fast-forward"
 - sequencer: let "git sequencer--helper" callers set "allow_dirty"
 - sequencer: add "--fast-forward" option to "git sequencer--helper"
 - sequencer: add "do_fast_forward()" to perform a fast forward
 - rebase -i: use "git sequencer--helper --reset-hard"
 - sequencer: add "--reset-hard" option to "git sequencer--helper"
 - sequencer: add comments about reset_almost_hard()
 - sequencer: add "reset_almost_hard()" and related functions
 - rebase -i: use "git sequencer--helper --make-patch"
 - sequencer: free memory used in "make_patch" function
 - sequencer: add "make_patch" function to save a patch
 - sequencer: add "builtin-sequencer--helper.c"

Migrating "rebase -i" bit by bit to C.  I am inclined to agree with Dscho
that maybe this approach forces the migration to follow the structure of
the shell script too much, and could force a suboptimal end result, but
we'll see.

* aj/fix-read-tree-from-scratch (2009-08-17) 1 commit
  (merged to 'next' on 2009-08-20 at 7a04133)
 + read-tree: Fix regression with creation of a new index file.

Will merge.

* as/maint-graph-interesting-fix (2009-08-18) 1 commit.
 - graph API: fix bug in graph_is_interesting()

I need to queue the associated test after getting it signed-off.

* jc/1.7.0-status (2009-08-15) 3 commits
  (merged to 'next' on 2009-08-22 at b3507bb)
 + git status: not "commit --dry-run" anymore
 + git stat -s: short status output
 + git stat: the beginning of "status that is not a dry-run of commit"
 (this branch uses jc/shortstatus.)

As promised, I squashed incremental "fix-up" into the commits they fix;
this will be kept in 'next' until 1.7.0

* jc/shortstatus (2009-08-15) 11 commits
  (merged to 'next' on 2009-08-15 at 7e40766)
 + git commit --dry-run -v: show diff in color when asked
 + Documentation/git-commit.txt: describe --dry-run
  (merged to 'next' on 2009-08-12 at 53bda17)
 + wt-status: collect untracked files in a separate "collect" phase
 + Make git_status_config() file scope static to builtin-commit.c
 + wt-status: move wt_status_colors[] into wt_status structure
 + wt-status: move many global settings to wt_status structure
 + commit: --dry-run
  (merged to 'next' on 2009-08-06 at fe8cb94)
 + status: show worktree status of conflicted paths separately
 + wt-status.c: rework the way changes to the index and work tree are summarized
 + diff-index: keep the original index intact
 + diff-index: report unmerged new entries
 (this branch is used by jc/1.7.0-status.)

Will cook for a bit more and then merge.

* jc/maint-checkout-index-to-prefix (2009-08-16) 1 commit
  (merged to 'next' on 2009-08-20 at 2f6aea2)
 + check_path(): allow symlinked directories to checkout-index --prefix

Will merge.

* jc/maint-unpack-objects-strict (2009-08-13) 1 commit.
  (merged to 'next' on 2009-08-23 at 38eb750)
 + Fix "unpack-objects --strict"

* jh/submodule-foreach (2009-08-20) 9 commits
  (merged to 'next' on 2009-08-20 at 671bea4)
 + git clone: Add --recursive to automatically checkout (nested) submodules
 + t7407: Use 'rev-parse --short' rather than bash's substring expansion notation
  (merged to 'next' on 2009-08-18 at f4a881d)
 + git submodule status: Add --recursive to recurse into nested submodules
 + git submodule update: Introduce --recursive to update nested submodules
 + git submodule foreach: Add --recursive to recurse into nested submodules
 + git submodule foreach: test access to submodule name as '$name'
 + Add selftest for 'git submodule foreach'
 + git submodule: Cleanup usage string and add option parsing to cmd_foreach()
 + git submodule foreach: Provide access to submodule name, as '$name'

* jl/submodule-summary-diff-files (2009-08-15) 2 commits
  (merged to 'next' on 2009-08-15 at 165bd8e)
 + Documentaqtion/git-submodule.txt: Typofix
  (merged to 'next' on 2009-08-14 at a702e78)
 + git submodule summary: add --files option

Will merge.

* lh/short-decorate (2009-08-15) 1 commit
  (merged to 'next' on 2009-08-18 at b8c1d96)
 + git-log: allow --decorate[=short|full]

Will merge.

* oa/stash-na (2009-08-11) 1 commit
  (merged to 'next' on 2009-08-14 at 12c2e2b)
 + git stash: Give friendlier errors when there is nothing to apply

Will merge.

* jh/notes (2009-07-29) 8 commits.
 - t3302-notes-index-expensive: Speed up create_repo()
 - fast-import: Add support for importing commit notes
 - First draft of notes tree parser with support for fanout subtrees
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

The cvs-helper series depends on this one.

* ne/rev-cache (2009-08-21) 6 commits
 . support for path name caching in rev-cache
 . full integration of rev-cache into git, completed test suite
 . administrative functions for rev-cache, start of integration into git
 . support for non-commit object caching in rev-cache
 . basic revision cache system, no integration or features
 . man page and technical discussion for rev-cache

Updated but seems to break tests when merged to 'pu'; didn't look at the
issue deeply.

* jh/cvs-helper (2009-08-18) 7 commits
 - More fixes to the git-remote-cvs installation procedure
 - Fix the Makefile-generated path to the git_remote_cvs package in git-remote-cvs
 - Add simple selftests of git-remote-cvs functionality
 - git-remote-cvs: Remote helper program for CVS repositories
 - 2/2: Add Python support library for CVS remote helper
 - 1/2: Add Python support library for CVS remote helper
 - Basic build infrastructure for Python scripts
 (this branch uses db/vcs-helper.)

Builds on db/vcs-helper.  The testing of Python part seemed to be
still fragile even with the latest fix on one of my boches with an
earlier round already installed, but I didn't look very deeply before
removing the older installation.

* nd/sparse (2009-08-20) 20 commits
 - sparse checkout: inhibit empty worktree
 - Add tests for sparse checkout
 - read-tree: add --no-sparse-checkout to disable sparse checkout support
 - unpack-trees(): ignore worktree check outside checkout area
 - unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final index
 - unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/sparse-checkout
 - unpack-trees.c: generalize verify_* functions
 - unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
 - Introduce "sparse checkout"
 - dir.c: export excluded_1() and add_excludes_from_file_1()
 - excluded_1(): support exclude files in index
 - unpack-trees(): carry skip-worktree bit over in merged_entry()
 - Read .gitignore from index if it is skip-worktree
 - Avoid writing to buffer in add_excludes_from_file_1()
 - Teach Git to respect skip-worktree bit (writing part)
 - Teach Git to respect skip-worktree bit (reading part)
 - Introduce "skip-worktree" bit in index, teach Git to get/set this bit
 - Add test-index-version
 - update-index: refactor mark_valid() in preparation for new options
  (merged to 'next' on 2009-08-20 at ea167d7)
 + Prevent diff machinery from examining assume-unchanged entries on worktree

The first one was an independent fix; the rest has been replaced with the
"return of no-checkout" series.

* jc/1.7.0-diff-whitespace-only-status (2009-05-23) 2 commits.
  (merged to 'next' on 2009-08-02 at 9c08420)
 + diff: Rename QUIET internal option to QUICK
 + diff: change semantics of "ignore whitespace" options

For 1.7.0.  This changes exit code from "git diff --ignore-whitespace" and
friends when there is no actual output.  It is a backward incompatible
change, but we could argue that it is a bugfix.

* jc/1.7.0-push-safety (2009-02-09) 2 commits
  (merged to 'next' on 2009-08-02 at 38b82fe)
 + Refuse deleting the current branch via push
 + Refuse updating the current branch in a non-bare repository via push

For 1.7.0.

* jc/log-tz (2009-03-03) 1 commit.
 - Allow --date=local --date=other-format to work as expected

* jc/mailinfo-remove-brackets (2009-07-15) 1 commit.
 - mailinfo: -b option keeps [bracketed] strings that is not a [PATCH] marker
--------------------------------------------------
[I have been too busy to purge these]

* ar/maint-1.6.2-merge-recursive-d-f (2009-05-11) 2 commits.
 . Fix for a merge where a branch has an F->D transition
 . Add a reminder test case for a merge with F/D transition

* jc/merge-convert (2009-01-26) 1 commit.
 . git-merge-file: allow converting the results for the work tree

* lt/read-directory (2009-05-15) 3 commits.
 . Add initial support for pathname conversion to UTF-8
 . read_directory(): infrastructure for pathname character set conversion
 . Add 'fill_directory()' helper function for directory traversal

* ps/blame (2009-03-12) 1 commit.
 . blame.c: start libifying the blame infrastructure

* pb/tracking (2009-07-16) 7 commits.
 . branch.c: if remote is not config'd for branch, don't try delete push config
 . branch, checkout: introduce autosetuppush
 . move deletion of merge configuration to branch.c
 . remote: add per-remote autosetupmerge and autosetuprebase configuration
 . introduce a struct tracking_config
 . branch: install_branch_config and struct tracking refactoring
 . config: allow false and true values for branch.autosetuprebase

Has been ejected from 'pu' for some time, expecting a reroll.
