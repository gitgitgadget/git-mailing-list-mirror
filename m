From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2009, #06; Sun, 30)
Date: Mon, 31 Aug 2009 00:03:53 -0700
Message-ID: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 09:04:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi0w6-00077w-Fc
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 09:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbZHaHEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 03:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbZHaHEE
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 03:04:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbZHaHEB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 03:04:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8AF2D3DCD2;
	Mon, 31 Aug 2009 03:04:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=PugB
	IJMJP3BGcwPYaNM8LXJ1ZTI=; b=L4LtEq+MnDc+v0HxDduSZGZyT88eHiF7gOBe
	kpR1ConsTvhq7dMF4XzkTaMGpAQVO3c0Q+MHVo9xjqnyH4w2VGFbGvYRezduUa6L
	Ika5CmRS89GbqGj+tBA4tGBEzRcxmXo01FmwMuHKyxzqjdL1/uRAh3cv7dOHq7KA
	Kj4CpNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=CjN
	/5t9tAN933u5JxQV8EHyFH2/SCXOVdaBIrNVIOtOPgKGLqHwOOT4UyTrcv9wt8zY
	VeHpzuAsmJwjPVGOi/TH+8v3QUfYgisH9wJ5Hr/pIbVd7FukYO2sGgnOZaJTA0B6
	BLGeMyPLCbIwRjIMhAREtGzwwyi7i5LCkgmzFD0Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 72FAB3DCD1;
	Mon, 31 Aug 2009 03:04:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 025523DCD0; Mon, 31 Aug 2009
 03:03:56 -0400 (EDT)
X-master-at: f324cb50be3d88c6fb6123c85da749695a749f60
X-next-at: 5fc6248250e68c3b723efb9b868d8fc27499065a
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 762708BA-95FC-11DE-987E-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127463>

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

* wl/insta-mongoose (2009-08-21) 1 commit
  (merged to 'next' on 2009-08-25 at da1d566)
 + Add support for the Mongoose web server.

* as/maint-graph-interesting-fix (2009-08-21) 2 commits.
  (merged to 'next' on 2009-08-25 at 9d5e215)
 + Add tests for rev-list --graph with options that simplify history
 + graph API: fix bug in graph_is_interesting()

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

* lt/block-sha1 (2009-08-17) 4 commits
  (merged to 'next' on 2009-08-18 at 67a1ce8)
 + remove ARM and Mozilla SHA1 implementations
 + block-sha1: guard gcc extensions with __GNUC__
 + make sure byte swapping is optimal for git
 + block-sha1: make the size member first in the context struct

* np/maint-1.6.3-deepen (2009-08-24) 1 commit.
  (merged to 'next' on 2009-08-25 at 8e383d4)
 + fix simple deepening of a repo

* jk/maint-1.6.3-checkout-unborn (2009-08-24) 1 commit.
  (merged to 'next' on 2009-08-25 at 5f29625)
 + checkout: do not imply "-f" on unborn branches

* mm/reset-report (2009-08-21) 2 commits
  (merged to 'next' on 2009-08-25 at f2a4424)
 + reset: make the reminder output consistent with "checkout"
 + Rename REFRESH_SAY_CHANGED to REFRESH_IN_PORCELAIN.

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

--------------------------------------------------
[New Topics]

* jc/upload-pack-hook (2009-08-28) 2 commits
 - upload-pack: feed "kind [clone|fetch]" to post-upload-pack hook
 - upload-pack: add a trigger for post-upload-pack hook

I do not know if the distinction between fetching some but not all refs
and fetching full set of refs into an empty repository is something worth
making, so in that sense the tip commit is somewhat iffy.

One reason this series makes me somewhat uneasy is that Tom, the original
starter of the discussion went dark after sending a proposed patch.  Maybe
he has been too busy, but I have been hoping that GitHub as a stakeholder
has somebody who monitors the list when he is not available.

Does anybody from GitHub have any input?  Is there something that needs to
be improved to fill GitHub's needs?  Does GitHub want to stick to its own
fork, and were all these discussions for improvements unwanted?

* jk/clone-b (2009-08-26) 1 commit
  (merged to 'next' on 2009-08-30 at 10a68d1)
 + clone: add --branch option to select a different HEAD

* pk/import-dirs (2009-08-24) 1 commit
 - Add script for importing bits-and-pieces to Git.

This version makes me suspect that the author might regret the choice of
the import format that does not allow escaping of paths, nor does not
allow leading blanks for readability without changing semantics, both of
which make it somewhat limiting and error prone.  These issues will be
hard to rectify without breaking the backward compatibility, for a tool
that could otherwise turn out to be useful.

As a contrib/ material, I probably shouldn't be too worried about these
issues, but I am keeping this out of 'next' for now, just in case the
author chooses to polish the usability of the tool for general audience.

It is a different story if the submission was just throwing out a one-time
hack in the open in the hope that some other people might find it useful,
but without any intention of maintaining it.  But then I do not have a
strong reason to keep this in my tree, either.  The mailing list archive
is a more suitable storage media for such a patch.

--------------------------------------------------
[Stalled]

* jh/notes (2009-08-27) 12 commits.
 - Add '%N'-format for pretty-printing commit notes
 - Add flags to get_commit_notes() to control the format of the note string
 - notes.c: Implement simple memory pooling of leaf nodes
 - Selftests verifying semantics when loading notes trees with various fanouts
 - Teach the notes lookup code to parse notes trees with various fanout schemes
 - t3302-notes-index-expensive: Speed up create_repo()
 - fast-import: Add support for importing commit notes
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

I heard the cvs-helper series depends on this one.  It seems that the
fan-out strategy is being rethought?

* js/stash-dwim (2009-07-27) 1 commit.
  (merged to 'next' on 2009-08-16 at 67896c4)
 + Make 'git stash -k' a short form for 'git stash save --keep-index'
 (this branch is used by tr/reset-checkout-patch.)

* tr/reset-checkout-patch (2009-08-27) 9 commits.
  (merged to 'next' on 2009-08-27 at d314281)
 + Make test case number unique
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

We had a few messages on what the list consensus was with this series.  My
impression, after going back to the archive, is that there wasn't.

* jn/gitweb-blame (2009-08-06) 3 commits
 - gitweb: Create links leading to 'blame_incremental' using JavaScript
 - gitweb: Incremental blame (WIP)
 - gitweb: Add optional "time to generate page" info in footer

Ajax-y blame WIP

--------------------------------------------------
[Cooking]

* je/send-email-no-subject (2009-08-05) 1 commit
  (merged to 'next' on 2009-08-30 at b6455c2)
 + send-email: confirm on empty mail subjects

The existing tests to covers the positive case (i.e. as long as the user
says "yes" to the "do you really want to send this message that lacks
subject", the message is sent) of this feature, but the feature itself
needs its own test to verify the negative case (i.e. does it correctly
stop if the user says "no"?)

* lt/approxidate (2009-08-30) 6 commits
  (merged to 'next' on 2009-08-30 at e016e3d)
 + fix approxidate parsing of relative months and years
 + tests: add date printing and parsing tests
 + refactor test-date interface
 + Add date formatting and parsing functions relative to a given time
  (merged to 'next' on 2009-08-26 at 62853f9)
 + Further 'approxidate' improvements
 + Improve on 'approxidate'

Fixes a few "reasonably formatted but thus-far misparsed" date strings.
With tests by Peff, this should be ready for -rc0.

* mr/gitweb-snapshot (2009-08-25) 3 commits
  (merged to 'next' on 2009-08-30 at e4edd0b)
 + gitweb: add t9501 tests for checking HTTP status codes
 + gitweb: split test suite into library and tests
 + gitweb: improve snapshot error handling

* jc/mailinfo-scissors (2009-08-26) 5 commits
  (merged to 'next' on 2009-08-30 at 5fc6248)
 + mailinfo.scissors: new configuration
 + am/mailinfo: Disable scissors processing by default
 + Documentation: describe the scissors mark support of "git am"
 + Teach mailinfo to ignore everything before -- >8 -- mark
 + builtin-mailinfo.c: fix confusing internal API to mailinfo()

I didn't pick up the patch to simplify the definition of scissors. I do
not have strong opinion on it either way, but the list would hopefully
decide it before too long.

* tf/diff-whitespace-incomplete-line (2009-08-23) 2 commits.
  (merged to 'next' on 2009-08-26 at 4fc7784)
 + xutils: Fix xdl_recmatch() on incomplete lines
 + xutils: Fix hashing an incomplete line with whitespaces at the end

Will merge.

* cc/sequencer-rebase-i (2009-08-28) 15 commits
 - rebase -i: use "git sequencer--helper --cherry-pick"
 - sequencer: add "--cherry-pick" option to "git sequencer--helper"
 - sequencer: add "do_commit()" and related functions working on "next_commit"
 - pick: libify "pick_help_msg()"
 - revert: libify cherry-pick and revert functionnality
 - rebase -i: use "git sequencer--helper --fast-forward"
 - sequencer: let "git sequencer--helper" callers set "allow_dirty"
 - sequencer: add "--fast-forward" option to "git sequencer--helper"
 - sequencer: add "do_fast_forward()" to perform a fast forward
 - rebase -i: use "git sequencer--helper --reset-hard"
 - sequencer: add "--reset-hard" option to "git sequencer--helper"
 - sequencer: add "reset_almost_hard()" and related functions
 - rebase -i: use "git sequencer--helper --make-patch"
 - sequencer: add "make_patch" function to save a patch
 - sequencer: add "builtin-sequencer--helper.c"

Migrating "rebase -i" bit by bit to C.

* jh/cvs-helper (2009-08-18) 7 commits
 - More fixes to the git-remote-cvs installation procedure
 - Fix the Makefile-generated path to the git_remote_cvs package in git-remote-cvs
 - Add simple selftests of git-remote-cvs functionality
 - git-remote-cvs: Remote helper program for CVS repositories
 - 2/2: Add Python support library for CVS remote helper
 - 1/2: Add Python support library for CVS remote helper
 - Basic build infrastructure for Python scripts
 (this branch uses db/vcs-helper.)

Builds on db/vcs-helper (which is stalled, so this cannot move further at
the moment).  There is a re-roll planned, so I did not pick up test fixes
from Brandon myself.

* sr/gfi-options (2009-08-27) 6 commits
 - fast-import: test the new option command
 - fast-import: add option command
 - fast-import: test the new feature command
 - fast-import: add feature command
 - fast-import: put marks reading in it's own function
 - fast-import: put option parsing code in separate functions

Re-rolled, based on an off-list discussion I was/am not aware of.
Looked ready for 'next'.

* nd/sparse (2009-08-20) 19 commits
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

--------------------------------------------------
[For 1.7.0]

* jc/1.7.0-status (2009-08-15) 3 commits
  (merged to 'next' on 2009-08-22 at b3507bb)
 + git status: not "commit --dry-run" anymore
 + git stat -s: short status output
 + git stat: the beginning of "status that is not a dry-run of commit"

With this, "git status" is no longer "git commit --preview".

* jc/1.7.0-send-email-no-thread-default (2009-08-22) 1 commit
  (merged to 'next' on 2009-08-22 at 5106de8)
 + send-email: make --no-chain-reply-to the default

* jc/1.7.0-diff-whitespace-only-status (2009-08-30) 4 commits.
  (merged to 'next' on 2009-08-30 at 0623572)
 + diff.c: fix typoes in comments
  (merged to 'next' on 2009-08-27 at 81fb2bd)
 + Make test case number unique
  (merged to 'next' on 2009-08-02 at 9c08420)
 + diff: Rename QUIET internal option to QUICK
 + diff: change semantics of "ignore whitespace" options

This changes exit code from "git diff --ignore-whitespace" and friends
when there is no actual output.  It is a backward incompatible change, but
we could argue that it is a bugfix.

* jc/1.7.0-push-safety (2009-02-09) 2 commits
  (merged to 'next' on 2009-08-02 at 38b82fe)
 + Refuse deleting the current branch via push
 + Refuse updating the current branch in a non-bare repository via push

--------------------------------------------------
[I have been too busy to purge these]

* jc/log-tz (2009-03-03) 1 commit.
 - Allow --date=local --date=other-format to work as expected

Maybe some people care about this.  I dunno.

* jc/mailinfo-remove-brackets (2009-07-15) 1 commit.
 - mailinfo: -b option keeps [bracketed] strings that is not a [PATCH] marker

Maybe some people care about this.  I dunno.

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

* ne/rev-cache (2009-08-21) 6 commits
 . support for path name caching in rev-cache
 . full integration of rev-cache into git, completed test suite
 . administrative functions for rev-cache, start of integration into git
 . support for non-commit object caching in rev-cache
 . basic revision cache system, no integration or features
 . man page and technical discussion for rev-cache

Updated but seems to break upload-pack tests when merged to 'pu'; given
what this series touches, breakages in that area are expected.
May discard if a working reroll comes, to give it a fresh start.
