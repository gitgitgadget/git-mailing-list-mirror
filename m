From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2009, #04; Wed, 09)
Date: Wed, 09 Dec 2009 23:11:35 -0800
Message-ID: <7v4onzl2vs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 10 08:11:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIdBn-00041e-2K
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 08:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683AbZLJHLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 02:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753874AbZLJHLi
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 02:11:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515AbZLJHLg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 02:11:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF764A5A69;
	Thu, 10 Dec 2009 02:11:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=C9lq
	1Ak4Bbl4OEP5QaP45EofLaU=; b=UNl4qHfULEp51Kl9x37cRHDayIKVMVl93PrM
	i9v2fsbLsrfUQwbP+YGSw82rkUv6Rc+aGWvQinsh8j405GifMP+LGSWHY+sJEyBr
	IZbcSni7mcgP6twcfPSr59/M/Mu/J+m2aOCe35FukVSCeHAQ4SchAx7QWQyfIzXJ
	Smii3CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=dC2
	24zU3REiv6r9TyWlEvxevejVDdH31OHzXjEYrsQWB1FuoQ8MwgakoOmI/JVBj2Tg
	LZe3PVhx+U6IdeyG0pO5YY/im8xm9CqQj6Q8y1CQ0nTWRfkj84ttFUSbunqkHArF
	JhwiBkUVJX9Wa95RShTuDye+92/rlo62TPWIrPc8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BC630A5A68;
	Thu, 10 Dec 2009 02:11:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 70FF6A5A67; Thu, 10 Dec 2009
 02:11:37 -0500 (EST)
X-master-at: 80d93611c55fec171e0d9aba98db079952f9d7aa
X-next-at: 245e2a65f71e0255a90a3c45ea82bcdd19f85eff
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 430A30E8-E55B-11DE-968F-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135012>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

As we are supposed to be in pre-release feature freeze, there is nothing
to see here ;-)

--------------------------------------------------
[Graduated to "master"]

* jk/maint-add-p-delete-fix (2009-12-08) 1 commit.
  (merged to 'next' on 2009-12-08 at 3c2c08a)
 + add-interactive: fix deletion of non-empty files

Fixes a regression in 1.6.5.3.

* jn/maint-pull-rebase-error-message (2009-11-27) 1 commit.
  (merged to 'next' on 2009-12-03 at 2ced03c)
 + pull: clarify advice for the unconfigured error case

Replaces old 'jn/rfc-pull-rebase-error-message' topic.

--------------------------------------------------
[New Topics]

* cc/reset-more (2009-12-08) 6 commits
 - Documentation: reset: add some tables to describe the different options
 - Documentation: reset: describe new "--keep-local-changes" option
 - reset: add test cases for "--keep-local-changes" option
 - reset: add option "--keep-local-changes" to "git reset"
 - reset: use "unpack_trees()" directly instead of "git read-tree"
 - reset: add a few tests for "git reset --merge"

The documentation is much clearer than the previous round in describing
what it does, but I find it a bit unclear in describing what it is _good_
for (iow, scenarios and use cases).

Breaks 'pu' and does not pass test on its own yet.

* tr/http-push-ref-status (2009-12-08) 3 commits
 - transport-helper.c::push_refs(): emit "no refs" error message
 - transport.c::transport_push(): make ref status affect return value
 - refactor ref status logic for pushing

--------------------------------------------------
[Stalled]

* je/send-email-no-subject (2009-08-05) 1 commit.
  (merged to 'next' on 2009-10-11 at 1b99c56)
 + send-email: confirm on empty mail subjects

The existing tests cover the positive case (i.e. as long as the user says
"yes" to the "do you really want to send this message that lacks subject",
the message is sent) of this feature, but the feature itself needs its own
test to verify the negative case (i.e. does it correctly stop if the user
says "no"?)

* jc/checkout-merge-base (2009-11-20) 2 commits
 - "rebase --onto A...B" replays history on the merge base between A and B
 - "checkout A...B" switches to the merge base between A and B

I've been using the first one for a while myself but do not see many users
want this (yet); the new feature is not urgent anyway.

* tr/maint-merge-ours-clarification (2009-11-15) 1 commit
  (merged to 'next' on 2009-11-21 at fadaf7b)
 + rebase: refuse to rebase with -s ours

I do not think we reached a concensus for solving conflicts between "give
them rope" and "protect users from clearly meaningless combinations".  The
author obviously is for the latter (and I am inclined to agree); Dscho
seems to think otherwise.

* jc/fix-tree-walk (2009-10-22) 8 commits
  (merged to 'next' on 2009-10-22 at 10c0c8f)
 + Revert failed attempt since 353c5ee
 + read-tree --debug-unpack
  (merged to 'next' on 2009-10-11 at 0b058e2)
 + unpack-trees.c: look ahead in the index
 + unpack-trees.c: prepare for looking ahead in the index
 + Aggressive three-way merge: fix D/F case
 + traverse_trees(): handle D/F conflict case sanely
 + more D/F conflict tests
 + tests: move convenience regexp to match object names to test-lib.sh

This has some stupid bugs and reverted from 'next' until I can fix it, but
the "temporarily" turned out to be very loooong.  Sigh.  We won't have a
proper fix in 1.6.6.

--------------------------------------------------
[Cooking]

* bg/maint-add-all-doc (2009-12-07) 4 commits.
 - squash! rm documentation--also mention add-u where we mention commit-a
 - git-rm doc: Describe how to sync index & work tree
 - git-add/rm doc: Consistently back-quote
 - Documentation: 'git add -A' can remove files

I didn't like the existing documentation for "add -u" myself (especially
because I wrote the initial version) and this neatly fix it as well.

* il/vcs-helper (2009-12-09) 8 commits
 - Remove special casing of http, https and ftp
 - Support remote archive from all smart transports
 - Support remote helpers implementing smart transports
 - Support taking over transports
 - Refactor git transport options parsing
 - Pass unknown protocols to external protocol handlers
 - Support mandatory capabilities
 - Add remote helper debug mode
 (this branch uses early parts of sr/vcs-helper.)

Yet another round.

* jh/commit-status (2009-12-07) 1 commit
 - [test?] Add commit.status, --status, and --no-status

* mm/diag-path-in-treeish (2009-12-07) 1 commit
 - Detailed diagnosis when parsing an object name fails.

* ns/rebase-auto-squash (2009-12-08) 2 commits
 - fixup! rebase -i --autosquash
 - rebase -i --autosquash: auto-squash commits
 (this branch uses mh/rebase-fixup.)

* jh/notes (2009-12-07) 11 commits
 - Refactor notes concatenation into a flexible interface for combining notes
 - Notes API: Allow multiple concurrent notes trees with new struct notes_tree
 - Notes API: for_each_note(): Traverse the entire notes tree with a callback
 - Notes API: get_note(): Return the note annotating the given object
 - Notes API: add_note(): Add note objects to the internal notes tree structure
 - Notes API: init_notes(): Initialize the notes tree from the given notes ref
 - Notes API: get_commit_notes() -> format_note() + remove the commit restriction
 - Minor style fixes to notes.c
 - Add more testcases to test fast-import of notes
 - Rename t9301 to t9350, to make room for more fast-import tests
 - fast-import: Proper notes tree manipulation

Rerolled and under discussion.

* fc/opt-quiet-gc-reset (2009-12-02) 1 commit
 - General --quiet improvements

* mv/commit-date (2009-12-03) 2 commits
 - Document date formats accepted by parse_date()
 - builtin-commit: add --date option

* mh/rebase-fixup (2009-12-07) 2 commits
 - Add a command "fixup" to rebase --interactive
 - t3404: Use test_commit to set up test repository
 (this branch is used by ns/rebase-auto-squash.)

Initial round of "fixup" action that is similar to "squash" action in
"rebase -i" that excludes the commit log message from follow-up commits
when composing the log message for the updated one.  Expected is a further
improvement to skip opening the editor if a pick is followed only by
"fixup" and no "squash".

* sr/gfi-options (2009-12-04) 7 commits
 - fast-import: add (non-)relative-marks feature
 - fast-import: allow for multiple --import-marks= arguments
 - fast-import: test the new option command
 - fast-import: add option command
 - fast-import: add feature command
 - fast-import: put marks reading in its own function
 - fast-import: put option parsing code in separate functions

Rerolled.

* ap/merge-backend-opts (2008-07-18) 6 commits
 - Document that merge strategies can now take their own options
 - Extend merge-subtree tests to test -Xsubtree=dir.
 - Make "subtree" part more orthogonal to the rest of merge-recursive.
 - Teach git-pull to pass -X<option> to git-merge
 - git merge -X<option>
 - git-merge-file --ours, --theirs

"git pull" patch needs sq-then-eval fix to protect it from $IFS
but otherwise seemed good.

* mo/bin-wrappers (2009-12-02) 3 commits
 - INSTALL: document a simpler way to run uninstalled builds
 - run test suite without dashed git-commands in PATH
 - build dashless "bin-wrappers" directory similar to installed bindir

Rerolled.

* tr/http-updates (2009-12-01) 3 commits
  (merged to 'next' on 2009-12-07 at f08d447)
 + Allow curl to rewind the RPC read buffer
 + Add an option for using any HTTP authentication scheme, not only basic
 + http: maintain curl sessions

* jc/diff-whitespace-prepare (2009-11-28) 2 commits
 - diff: flip the default diff.bwoutputonly to true
 - diff: optionally allow traditional "-b/-w affects only output" semantics
 (this branch uses gb/1.7.0-diff-whitespace-only-output and jc/1.7.0-diff-whitespace-only-status; is used by jc/1.7.0-diff-whitespace-prepare.)

This was to redo the two -b/-w semantic changes to prepare the migration of
existing users before 1.7.0 happens, but I think we should drop it.

Comments?

* sr/vcs-helper (2009-12-07) 14 commits
  (merged to 'next' on 2009-12-07 at 8f041bc)
 + tests: handle NO_PYTHON setting
  (merged to 'next' on 2009-12-03 at e45b562)
 + builtin-push: don't access freed transport->url
  (merged to 'next' on 2009-11-27 at 83268ab)
 + Add Python support library for remote helpers
 + Basic build infrastructure for Python scripts
 + Allow helpers to report in "list" command that the ref is unchanged
 + Fix various memory leaks in transport-helper.c
 + Allow helper to map private ref names into normal names
 + Add support for "import" helper command
 + Allow specifying the remote helper in the url
 + Add a config option for remotes to specify a foreign vcs
 + Allow fetch to modify refs
 + Use a function to determine whether a remote is valid
 + Allow programs to not depend on remotes having urls
 + Fix memory leak in helper method for disconnect
 (this branch shares commits with il/vcs-helper.)

Should be among the first to graduate after 1.6.6 final.

* tr/reset-checkout-patch (2009-11-19) 1 commit.
  (merged to 'next' on 2009-11-22 at b224950)
 + {checkout,reset} -p: make patch direction configurable

I do not particularly like a configuration like this that changes the
behaviour of a command in a drastic way---it will make helping others
much harder.

Comments?

* nd/sparse (2009-11-25) 20 commits.
  (merged to 'next' on 2009-11-25 at 71380f5)
 + tests: rename duplicate t1009
  (merged to 'next' on 2009-11-23 at f712a41)
 + sparse checkout: inhibit empty worktree
 + Add tests for sparse checkout
 + read-tree: add --no-sparse-checkout to disable sparse checkout support
 + unpack-trees(): ignore worktree check outside checkout area
 + unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final index
 + unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/sparse-checkout
 + unpack-trees.c: generalize verify_* functions
 + unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
 + Introduce "sparse checkout"
 + dir.c: export excluded_1() and add_excludes_from_file_1()
 + excluded_1(): support exclude files in index
 + unpack-trees(): carry skip-worktree bit over in merged_entry()
 + Read .gitignore from index if it is skip-worktree
 + Avoid writing to buffer in add_excludes_from_file_1()
 + Teach Git to respect skip-worktree bit (writing part)
 + Teach Git to respect skip-worktree bit (reading part)
 + Introduce "skip-worktree" bit in index, teach Git to get/set this bit
 + Add test-index-version
 + update-index: refactor mark_valid() in preparation for new options

There were some test glitches reported and at least one test seems to 
be broken in the sense that it is not testing what it is trying to.
Fix-up expected.

--------------------------------------------------
[For 1.7.0]

* jk/1.7.0-status (2009-12-08) 13 commits.
  (merged to 'next' on 2009-12-08 at 9b57d84)
 + t7508-status: test all modes with color
 + t7508-status: status --porcelain ignores relative paths setting
  (merged to 'next' on 2009-12-07 at 7723acf)
 + status: reduce duplicated setup code
 + status: disable color for porcelain format
  (merged to 'next' on 2009-12-05 at 44dcefd)
 + status -s: obey color.status
 + builtin-commit: refactor short-status code into wt-status.c
  (merged to 'next' on 2009-11-27 at 91691ec)
 + t7508-status.sh: Add tests for status -s
 + status -s: respect the status.relativePaths option
  (merged to 'next' on 2009-11-21 at 884bb56)
 + docs: note that status configuration affects only long format
  (merged to 'next' on 2009-10-11 at 65c8513)
 + commit: support alternate status formats
 + status: add --porcelain output format
 + status: refactor format option parsing
 + status: refactor short-mode printing to its own function
 (this branch uses jc/1.7.0-status.)

Gives the --short output format to post 1.7.0 "git commit --dry-run" that
is similar to that of post 1.7.0 "git status".

Immediately after 1.6.6 while rebuilding 'next', we may want to reorder a
few commits at the tip, as "docs: affects only long format" describes a
limitation that has disappeared.

* jc/1.7.0-status (2009-09-05) 4 commits.
  (merged to 'next' on 2009-10-11 at 9558627)
 + status: typo fix in usage
 + git status: not "commit --dry-run" anymore
 + git stat -s: short status output
 + git stat: the beginning of "status that is not a dry-run of commit"
 (this branch is used by jk/1.7.0-status.)

With this, "git status" is no longer "git commit --dry-run".

* jc/1.7.0-send-email-no-thread-default (2009-08-22) 1 commit.
  (merged to 'next' on 2009-10-11 at 043acdf)
 + send-email: make --no-chain-reply-to the default

As the title says.

* jc/1.7.0-push-safety (2009-02-09) 2 commits.
  (merged to 'next' on 2009-10-11 at 81b8128)
 + Refuse deleting the current branch via push
 + Refuse updating the current branch in a non-bare repository via push

* jc/1.7.0-diff-whitespace-only-status (2009-08-30) 4 commits.
  (merged to 'next' on 2009-10-11 at 546c74d)
 + diff.c: fix typoes in comments
 + Make test case number unique
 + diff: Rename QUIET internal option to QUICK
 + diff: change semantics of "ignore whitespace" options
 (this branch is used by jc/1.7.0-diff-whitespace-prepare and jc/diff-whitespace-prepare.)

This changes exit code from "git diff --ignore-whitespace" and friends
when there is no actual output.  It is a backward incompatible change,
and jc/diff-whitespace-prepare topic is meant to ease the transition.

* gb/1.7.0-diff-whitespace-only-output (2009-11-19) 1 commit
  (merged to 'next' on 2009-11-21 at 3375bf4)
 + No diff -b/-w output for all-whitespace changes
 (this branch is used by jc/1.7.0-diff-whitespace-prepare and jc/diff-whitespace-prepare.)

Likewise but for the output of "diff --git" headers.

* jc/1.7.0-diff-whitespace-prepare (2009-11-28) 2 commits
 - diff: disable diff.bwoutputonly warning
 - diff: flip the diff.bwoutputonly default to false
 (this branch uses gb/1.7.0-diff-whitespace-only-output, jc/1.7.0-diff-whitespace-only-status and jc/diff-whitespace-prepare.)

And this is to actually flip the default and eventually remove the warning.
As I am contemplating of dropping jc/diff-whitespace-prepare, this should
also be dropped as well.

* ns/1.7.0-send-email-no-chain-reply-to (2009-08-22) 1 commit
 - send-email: make --no-chain-reply-to the default

And this is to actually flip the default in 1.7.0.

--------------------------------------------------
[Reverted from 'next']

* jc/botched-maint-cygwin-count-objects (2009-11-24) 2 commits.
  (merged to 'next' on 2009-11-25 at 8aa62a0)
 + Revert "ST_BLOCKS_COUNTS_IN_BLKSIZE to say on-disk size is (st_blksize * st_blocks)"
  (merged to 'next' on 2009-11-22 at 4ba5880)
 + ST_BLOCKS_COUNTS_IN_BLKSIZE to say on-disk size is (st_blksize * st_blocks)

This is a revert of the tip one I merged prematurely to 'next'.  The real
fix from Ramsay is already in 'master'.

* ks/precompute-completion (2009-11-15) 4 commits.
  (merged to 'next' on 2009-11-15 at 23cdb96)
 + Revert ks/precompute-completion series
  (merged to 'next' on 2009-10-28 at cd5177f)
 + completion: ignore custom merge strategies when pre-generating
  (merged to 'next' on 2009-10-22 at f46a28a)
 + bug: precomputed completion includes scripts sources
  (merged to 'next' on 2009-10-14 at adf722a)
 + Speedup bash completion loading

Reverted out of 'next', to be replaced with jn/faster-completion-startup
topic.

--------------------------------------------------
[Haven't been purged from 'pu' yet]

* jc/grep-full-tree (2009-11-24) 1 commit.
 - grep: --full-tree

The interaction with this option and pathspecs need to be worked out
better.  I _think_ "grep --full-tree -e pattern -- '*.h'" should find from
all the header files in the tree, for example.
