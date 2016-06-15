From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2009, #03; Thu, 20)
Date: Thu, 20 Aug 2009 19:48:20 -0700
Message-ID: <7veir5naq3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 04:48:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeKBD-00048T-AG
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 04:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbZHUCs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 22:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbZHUCs3
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 22:48:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbZHUCs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 22:48:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C737B313A0;
	Thu, 20 Aug 2009 22:48:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=M/ED
	7eOIsM5kxbDIlzstDo7Ik1Y=; b=sGmTKoryR7p64zAqtthkbtAHaaLjn1MhoHR1
	HDiub/Iq2dju5u0XMVCgADMmmbFS1Sda631n9AL9p1YJLX7iRLMvAVEw7m2ZJaYX
	W62R2S+QDWz+eqvsBcKj7chEp4C3JqjhcJb9iPBAdNfLrRQp+yDkSNCmbqM+g+sB
	P/On2/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=HRe
	RbuEjELeyo7K0euL9hkmR55T2JTNhhQiJunQ7+68GgOIIt0Q9HjftIksxytK/61+
	VIC6mSQD/YSAHNbbxSu2w6XdXTffQXSCi/c2/6GuLPJVjrOvGi+/wu9RCISfiPkF
	d+iTpeUmO6vDRKROoE3XqdhBHjCBvgYyxW5P6ezo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B60F03139E;
	Thu, 20 Aug 2009 22:48:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 70A1031395; Thu, 20 Aug 2009
 22:48:24 -0400 (EDT)
X-master-at: 044239b0a1fbdcccefafe1dab5f9c21e5a2a9150
X-next-at: ea167d76afdd01db4b4f4cbd6429abff15cc2ccc
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 19CFD99A-8DFD-11DE-BD6A-3142836986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126667>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

After the 1.6.5 cycle, the next release will be 1.7.0, and we will push
out the planned "push safety" change.  1.7.0 would be a good time to
introduce "justifiable" changes that are not strictly backward compatible.

During 1.6.5 cycle, 'next' will hold topics meant for 1.6.5 and 1.7.0.

--------------------------------------------------
[New Topics]

* aj/fix-read-tree-from-scratch (2009-08-17) 1 commit
  (merged to 'next' on 2009-08-20 at 7a04133)
 + read-tree: Fix regression with creation of a new index file.

* as/maint-graph-interesting-fix (2009-08-18) 1 commit.
 - graph API: fix bug in graph_is_interesting()

* jc/1.7.0-status (2009-08-15) 7 commits
 - git-status: adjust tests
 - git status: not "commit --dry-run" anymore
 - git stat -s: short status output
 - git stat: pathspec limits, unlike traditional "git status"
 - git stat: show traditional status headers and trailers as well
 - git stat: honor relative paths setting
 - git stat: the beginning
 (this branch uses jc/shortstatus.)

* jc/maint-checkout-index-to-prefix (2009-08-16) 1 commit
  (merged to 'next' on 2009-08-20 at 2f6aea2)
 + check_path(): allow symlinked directories to checkout-index --prefix

* jc/maint-unpack-objects-strict (2009-08-13) 1 commit.
 - Fix "unpack-objects --strict"

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

* lh/short-decorate (2009-08-15) 1 commit
  (merged to 'next' on 2009-08-18 at b8c1d96)
 + git-log: allow --decorate[=short|full]

* oa/stash-na (2009-08-11) 1 commit
  (merged to 'next' on 2009-08-14 at 12c2e2b)
 + git stash: Give friendlier errors when there is nothing to apply

* sr/gfi-options (2009-08-13) 3 commits
 - fast-import: test the new option command
 - fast-import: add option command
 - fast-import: put option parsing code in seperate functions

--------------------------------------------------
[Graduated to "master"]

* bc/maint-am-email (Thu Aug 6 20:08:13 2009 -0500) 2 commits
 + git-am: print fair error message when format detection fails
 + am: allow individual e-mail files as input

It seems that the "not mbox but a single piece of e-mail" format was
something many people relied on.  Hopefully this can also be sent
to 'maint'.

* js/maint-cover-letter-non-ascii (Mon Aug 10 18:22:22 2009 +0200) 2 commits
 + Correctly mark cover letters' encodings if they are not pure ASCII
 + Expose the has_non_ascii() function

* jk/maint-merge-msg-fix (Sun Aug 9 06:02:51 2009 -0400) 3 commits
 + merge: indicate remote tracking branches in merge message
 + merge: fix incorrect merge message for ambiguous tag/branch
 + add tests for merge message headings

* jc/maint-clean-nested-dir-safety (Tue Jun 30 15:33:45 2009 -0700) 1 commit
 + clean: require double -f options to nuke nested git repository and
   work tree

--------------------------------------------------
[Stalled]

* cc/sequencer-rebase-i (2009-08-05) 8 commits.
 - rebase -i: use "git sequencer--helper --reset-hard"
 - sequencer: add "--reset-hard" option to "git sequencer--helper"
 - sequencer: add comments about reset_almost_hard()
 - sequencer: add "reset_almost_hard()" and related functions
 - rebase -i: use "git sequencer--helper --make-patch"
 - sequencer: free memory used in "make_patch" function
 - sequencer: add "make_patch" function to save a patch
 - sequencer: add "builtin-sequencer--helper.c"

More sequencer updates.  I didn't look at the latest round that had a
handful "oops, fix that earlier botch" patches, expecting a cleaner
reroll (which hasn't happened yet).

* pb/tracking (2009-07-16) 7 commits.
 . branch.c: if remote is not config'd for branch, don't try delete push config
 . branch, checkout: introduce autosetuppush
 . move deletion of merge configuration to branch.c
 . remote: add per-remote autosetupmerge and autosetuprebase configuration
 . introduce a struct tracking_config
 . branch: install_branch_config and struct tracking refactoring
 . config: allow false and true values for branch.autosetuprebase

Has been ejected from 'pu' for some time, expecting a reroll.

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

* ld/p4 (2009-07-30) 1 commit
  (merged to 'next' on 2009-08-14 at 36d310d)
 + git-p4: stream from perforce to speed up clones

Should graduate to 'master' soon.

* mr/gitweb-xz (2009-08-06) 3 commits
  (merged to 'next' on 2009-08-14 at b63b8e6)
 + gitweb: add support for XZ compressed snapshots
 + gitweb: update INSTALL regarding specific snapshot settings
 + gitweb: support to globally disable a snapshot format

Should graduate to 'master' soon.

* jh/cvs-helper (2009-08-18) 7 commits
 - More fixes to the git-remote-cvs installation procedure
 - Fix the Makefile-generated path to the git_remote_cvs package
   in git-remote-cvs
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

* jc/verify-pack-stat (2009-08-07) 1 commit
  (merged to 'next' on 2009-08-10 at f80d0e9)
 + verify-pack --stat-only: show histogram without verifying

* lt/block-sha1 (2009-08-17) 4 commits
  (merged to 'next' on 2009-08-18 at 67a1ce8)
 + remove ARM and Mozilla SHA1 implementations
 + block-sha1: guard gcc extensions with __GNUC__
 + make sure byte swapping is optimal for git
 + block-sha1: make the size member first in the context struct

Finishing touches ;-)  There were a few Solaris portability patches
floated around that I didn't pick up, waiting for them to finalize.

* nd/sparse (2009-08-11) 8 commits
 . --sparse for porcelains
 . Support sparse checkout in unpack_trees() and read-tree
 . unpack-trees.c: generalize verify_* functions
 . dir.c: export excluded_1() and add_excludes_from_file_1()
 . excluded_1(): support exclude "directories" in index
 . Read .gitignore from index if it is assume-unchanged
 . Avoid writing to buffer in add_excludes_from_file_1()
  (merged to 'next' on 2009-08-20 at ea167d7)
 + Prevent diff machinery from examining assume-unchanged entries on worktree

The first one was an independent fix; the rest will be discarded and
replaced with the "return of no-checkout" series.

* bc/mailsplit-cr-at-eol (2009-08-04) 4 commits
  (merged to 'next' on 2009-08-06 at 6bc7c5c)
 + Allow mailsplit (and hence git-am) to handle mails with CRLF line-endings
 + builtin-mailsplit.c: remove read_line_with_nul() since it is no longer used
 + builtin-mailinfo,builtin-mailsplit: use strbufs
 + strbuf: add new function strbuf_getwholeline()

Will merge.

* gb/apply-ignore-whitespace (2009-08-04) 1 commit
  (merged to 'next' on 2009-08-06 at 59e2c86)
 + git apply: option to ignore whitespace differences

Will merge.

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

Will merge.

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

* jn/gitweb-blame (2009-08-06) 3 commits
 - gitweb: Create links leading to 'blame_incremental' using JavaScript
 - gitweb: Incremental blame (WIP)
 - gitweb: Add optional "time to generate page" info in footer

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

There was a discussion on better DWIMmery to (1) forbid "git stash save
--anything-with-dash" and (2) redirect with any option "git stash --opt"
to "git stash save --opt", to keep it flexible and safe at the same time.
I think it is a sane thing to do.

* js/stash-dwim (2009-07-27) 1 commit.
  (merged to 'next' on 2009-08-16 at 67896c4)
 + Make 'git stash -k' a short form for 'git stash save --keep-index'
 (this branch is used by tr/reset-checkout-patch.)

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

* ne/rev-cache (2009-08-17) 6 commits
 . support for path name caching of blobs/trees in rev-cache
 . full integration of rev-cache into git's revision walker, completed test suite
 . administrative functions for rev-cache, and start of integration into git
 . non-commit object support for rev-cache
 . bare minimum revision cache system, no integration with git
 . revision caching documentation: man page and technical discussion

* ps/blame (2009-03-12) 1 commit.
 . blame.c: start libifying the blame infrastructure
