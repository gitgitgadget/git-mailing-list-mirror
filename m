From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Mon, 04 Jan 2010 00:39:03 -0800
Message-ID: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 04 09:39:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRiTB-0000qq-I5
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 09:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab0ADIjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 03:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266Ab0ADIjQ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 03:39:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab0ADIjN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 03:39:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14DCF8DE6F;
	Mon,  4 Jan 2010 03:39:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=/m8r
	cT77jOlLNGkHgriIt0CP0xk=; b=tl8PygyhZhlj8QS9W1tYFOatDx6fpNAcjKVb
	Ja1VY4JhOAflXnxJt/mra4mj7gzBtnojGSKZtvtmO0GLvTgf98HoKBKZ3Nn/mW5v
	Z89ZvlA4hN5Qn3YoQSbU/YdI2FtVJqz3NcdAYFejPXn08J7tk2hAoeaARDXwk5x3
	/Kh2Z2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=gaF
	mRr9Z7JLig/Y9REX5ejAxvMBfVvPwbmHKh8TFaHnaZ1Orgui7bKA5DoMXB679TEB
	mPFdnx5NdF8V5Puo7OCyTd9FmH3iVZPB+ElfC2BYvKG2/Dhd9XtKsDdxP6Kracz6
	1+P3+IrsyWFGpTLOrqv1j6QgFDkpudTWlRAfZNkk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 00C388DE6E;
	Mon,  4 Jan 2010 03:39:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F08108DE6D; Mon,  4 Jan
 2010 03:39:04 -0500 (EST)
X-master-at: bd757c18597789d4f01cbd2ffc7c1f55e90cfcd0
X-next-at: 8802c2c062c167ec9c81e811dd90791ed3fdc74b
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9EF90D42-F90C-11DE-A42D-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136103>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

The tip of 'next' has been rebuilt on top of the current 'master'.

--------------------------------------------------
[New Topics]

* da/difftool (2009-12-22) 2 commits
 - git-difftool: Add '--gui' for selecting a GUI tool
 - t7800-difftool: Set a bogus tool for use by tests

* jh/gitweb-cached (2010-01-03) 4 commits
 - gitweb: Makefile improvements
 - gitweb: Optionally add "git" links in project list page
 - gitweb: Add option to force version match
 - gitweb: Load checking

* tc/test-locate-httpd (2010-01-02) 1 commit
 - t/lib-http.sh: Restructure finding of default httpd location

* jc/fix-tree-walk (2009-09-14) 7 commits
 - read-tree --debug-unpack
 - unpack-trees.c: look ahead in the index
 - unpack-trees.c: prepare for looking ahead in the index
 - Aggressive three-way merge: fix D/F case
 - traverse_trees(): handle D/F conflict case sanely
 - more D/F conflict tests
 - tests: move convenience regexp to match object names to test-lib.sh

Resurrected from "Ejected" category.

--------------------------------------------------
[Cooking]

* cc/reset-more (2010-01-04) 6 commits
  (merged to 'next' on 2010-01-04 at 8802c2c)
 + Fix bit assignment for CE_CONFLICTED
  (merged to 'next' on 2010-01-03 at f83d4c6)
 + "reset --merge": fix unmerged case
 + reset: use "unpack_trees()" directly instead of "git read-tree"
 + reset: add a few tests for "git reset --merge"
 + Documentation: reset: add some tables to describe the different options
 + reset: improve mixed reset error message when in a bare repo

* bg/maint-remote-update-default (2009-12-31) 1 commit
  (merged to 'next' on 2010-01-03 at 113009e)
 + Fix "git remote update" with remotes.defalt set

* jc/branch-d (2009-12-29) 1 commit
 - branch -d: base the "already-merged" safety on the branch it merges with

* jc/rerere (2009-12-04) 1 commit
 - Teach --[no-]rerere-autoupdate option to merge, revert and friends

* jk/maint-1.6.5-reset-hard (2009-12-30) 1 commit
  (merged to 'next' on 2010-01-02 at 190d63b)
 + reset: unbreak hard resets with GIT_WORK_TREE

* jk/push-to-delete (2009-12-30) 1 commit
  (merged to 'next' on 2010-01-03 at 9ee293b)
 + builtin-push: add --delete as syntactic sugar for :foo

* jk/run-command-use-shell (2010-01-01) 8 commits
 - t4030, t4031: work around bogus MSYS bash path conversion
 - t0021: use $SHELL_PATH for the filter script
 - diff: run external diff helper with shell
 - textconv: use shell to run helper
 - editor: use run_command's shell feature
 - run-command: optimize out useless shell calls
 - run-command: convert simple callsites to use_shell
 - run-command: add "use shell" option

* mm/config-path (2009-12-30) 1 commit
  (merged to 'next' on 2010-01-03 at 9c0e81a)
 + builtin-config: add --path option doing ~ and ~user expansion.

* pm/cvs-environ (2009-12-30) 1 commit
  (merged to 'next' on 2010-01-03 at 4c22932)
 + CVS Server: Support reading base and roots from environment

* rs/maint-archive-match-pathspec (2009-12-12) 1 commit
  (merged to 'next' on 2010-01-03 at 92d7d15)
 + archive: complain about path specs that don't match anything

* so/cvsserver-update (2009-12-07) 1 commit
  (merged to 'next' on 2010-01-03 at 99959b6)
 + cvsserver: make the output of 'update' more compatible with cvs.

* tc/clone-v-progress (2009-12-26) 4 commits
 - clone: use --progress to force progress reporting
 - clone: set transport->verbose when -v/--verbose is used
 - git-clone.txt: reword description of progress behaviour
 - check stderr with isatty() instead of stdout when deciding to show progress

* tc/smart-http-restrict (2010-01-02) 4 commits
 - Smart-http tests: Test http-backend without curl or a webserver
 - Smart-http tests: Break test t5560-http-backend into pieces
 - Smart-http tests: Improve coverage in test t5560
 - Smart-http: check if repository is OK to export before serving it

* tr/maint-1.6.5-bash-prompt-show-submodule-changes (2009-12-31) 1 commit
  (merged to 'next' on 2010-01-03 at b785974)
 + bash completion: factor submodules into dirty state

* jc/cache-unmerge (2009-12-25) 9 commits
 - rerere forget path: forget recorded resolution
 - rerere: refactor rerere logic to make it independent from I/O
 - rerere: remove silly 1024-byte line limit
 - resolve-undo: teach "update-index --unresolve" to use resolve-undo info
 - resolve-undo: "checkout -m path" uses resolve-undo information
 - resolve-undo: allow plumbing to clear the information
 - resolve-undo: basic tests
 - resolve-undo: record resolved conflicts in a new index extension section
 - builtin-merge.c: use standard active_cache macros

* js/filter-branch-prime (2009-12-15) 1 commit
  (merged to 'next' on 2010-01-03 at 7c90319)
 + filter-branch: remove an unnecessary use of 'git read-tree'

* mg/tag-d-show (2009-12-10) 1 commit
  (merged to 'next' on 2010-01-03 at 87657d2)
 + tag -d: print sha1 of deleted tag

* sb/maint-octopus (2009-12-11) 3 commits
  (merged to 'next' on 2010-01-03 at ffe77d6)
 + octopus: remove dead code
 + octopus: reenable fast-forward merges
 + octopus: make merge process simpler to follow

* jh/commit-status (2009-12-07) 1 commit
 - [test?] Add commit.status, --status, and --no-status

* jc/checkout-merge-base (2009-11-20) 2 commits
  (merged to 'next' on 2010-01-02 at 6a8f6fc)
 + "rebase --onto A...B" replays history on the merge base between A and B
 + "checkout A...B" switches to the merge base between A and B

* tr/http-push-ref-status (2009-12-24) 6 commits
 - transport-helper.c::push_refs(): emit "no refs" error message
 - transport-helper.c::push_refs(): ignore helper-reported status if ref is not to be pushed
 - transport.c::transport_push(): make ref status affect return value
 - refactor ref status logic for pushing
 - t5541-http-push.sh: add test for unmatched, non-fast-forwarded refs
 - t5541-http-push.sh: add tests for non-fast-forward pushes

* bg/maint-add-all-doc (2009-12-07) 4 commits
  (merged to 'next' on 2010-01-03 at b19a323)
 + squash! rm documentation--also mention add-u where we mention commit-a
 + git-rm doc: Describe how to sync index & work tree
 + git-add/rm doc: Consistently back-quote
 + Documentation: 'git add -A' can remove files

* il/vcs-helper (2009-12-09) 8 commits
 - Remove special casing of http, https and ftp
 - Support remote archive from all smart transports
 - Support remote helpers implementing smart transports
 - Support taking over transports
 - Refactor git transport options parsing
 - Pass unknown protocols to external protocol handlers
 - Support mandatory capabilities
 - Add remote helper debug mode

* mm/diag-path-in-treeish (2009-12-07) 1 commit
 - Detailed diagnosis when parsing an object name fails.

* mh/rebase-fixup (2009-12-07) 2 commits
 - Add a command "fixup" to rebase --interactive
 - t3404: Use test_commit to set up test repository
 (this branch is used by ns/rebase-auto-squash.)

Initial round of "fixup" action that is similar to "squash" action in
"rebase -i" that excludes the commit log message from follow-up commits
when composing the log message for the updated one.  Expected is a further
improvement to skip opening the editor if a pick is followed only by
"fixup" and no "squash".

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
  (merged to 'next' on 2010-01-02 at ae42130)
 + Add more testcases to test fast-import of notes
 + Rename t9301 to t9350, to make room for more fast-import tests
 + fast-import: Proper notes tree manipulation

* fc/opt-quiet-gc-reset (2009-12-02) 1 commit
 - General --quiet improvements

* mv/commit-date (2009-12-03) 2 commits
  (merged to 'next' on 2010-01-03 at 1c45fdf)
 + Document date formats accepted by parse_date()
 + builtin-commit: add --date option

* sr/gfi-options (2009-12-04) 7 commits
 - fast-import: add (non-)relative-marks feature
 - fast-import: allow for multiple --import-marks= arguments
 - fast-import: test the new option command
 - fast-import: add option command
 - fast-import: add feature command
 - fast-import: put marks reading in its own function
 - fast-import: put option parsing code in separate functions

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
  (merged to 'next' on 2010-01-03 at 8c5fa27)
 + INSTALL: document a simpler way to run uninstalled builds
 + run test suite without dashed git-commands in PATH
 + build dashless "bin-wrappers" directory similar to installed bindir

* tr/http-updates (2009-12-28) 4 commits
  (merged to 'next' on 2010-01-02 at cf25698)
 + Remove http.authAny
 + Allow curl to rewind the RPC read buffer
 + Add an option for using any HTTP authentication scheme, not only basic
 + http: maintain curl sessions

* nd/sparse (2009-12-30) 23 commits
  (merged to 'next' on 2010-01-02 at 5499bbe)
 + grep: do not do external grep on skip-worktree entries
 + commit: correctly respect skip-worktree bit
 + ie_match_stat(): do not ignore skip-worktree bit with CE_MATCH_IGNORE_VALID
 + tests: rename duplicate t1009
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
