From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2010, #04; Wed, 13)
Date: Wed, 13 Jan 2010 15:11:14 -0800
Message-ID: <7vwrzlk3cd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 00:11:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVCN6-0006xA-0q
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 00:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab0AMXLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 18:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305Ab0AMXLX
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 18:11:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab0AMXLV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 18:11:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B48B190E54;
	Wed, 13 Jan 2010 18:11:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=9xQP
	PCy03mgNcCb4NuIYJH4F7gg=; b=JflaMnmSpJ/6kOWLmUuXAg371u9p27b/UM8m
	7KiDTVIojA9r8lNhm6g4uYMk+AIOM+BwUYqf/sbLz5/6hLqGQ4kKjezNf7FWFub0
	edoBiRSGsJFc4bwJFI/xhg/99o4YHMMgt0jABAj5uMqzWn/bDVKIvGogDYGJVzSA
	mux7Vqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=mJW
	BF2CZJ0zPmLnqFTg2PxuFMjqydYcfHQbYT2Wi7AlxQMrmqqWBHWQ8Gdz61qPuUP/
	B1v2Y61NKlYjTiOYJzfgmMyLcmx7jIQqSSUnbyHWr3nm+acxZCtDnbm7paVTFhdg
	6FUp0ETy/UP1f+y9W6JQE9OnYN2DT+at00WdlwkQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A260090E51;
	Wed, 13 Jan 2010 18:11:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CC8C90E4F; Wed, 13 Jan
 2010 18:11:16 -0500 (EST)
X-master-at: 1f73566af5bec28cd8489c6139a9ede95817349c
X-next-at: 20f8f4b285926bc486429e4b6b1d6fcf8a74804d
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F4CA92A2-0098-11DF-B99B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136894>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[Graduated to "master"]

* nd/sparse (2010-01-04) 25 commits
  (merged to 'next' on 2010-01-10 at fa73d6e)
 + t7002: test for not using external grep on skip-worktree paths
 + t7002: set test prerequisite "external-grep" if supported
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

With the removal of external grep near future, some codepaths will be
slightly simplified.

* cc/reset-more (2010-01-08) 8 commits
  (merged to 'next' on 2010-01-10 at 84730de)
 + t7111: check that reset options work as described in the tables
  (merged to 'next' on 2010-01-06 at 96639cb)
 + Documentation: reset: add some missing tables
  (merged to 'next' on 2010-01-04 at 8802c2c)
 + Fix bit assignment for CE_CONFLICTED
  (merged to 'next' on 2010-01-03 at f83d4c6)
 + "reset --merge": fix unmerged case
 + reset: use "unpack_trees()" directly instead of "git read-tree"
 + reset: add a few tests for "git reset --merge"
 + Documentation: reset: add some tables to describe the different options
 + reset: improve mixed reset error message when in a bare repo

* rs/maint-archive-match-pathspec (2009-12-12) 1 commit
  (merged to 'next' on 2010-01-03 at 92d7d15)
 + archive: complain about path specs that don't match anything

* il/vcs-helper (2010-01-09) 9 commits
  (merged to 'next' on 2010-01-10 at 11e448e)
 + Reset possible helper before reusing remote structure
  (merged to 'next' on 2010-01-06 at 7c79f42)
 + Remove special casing of http, https and ftp
 + Support remote archive from all smart transports
 + Support remote helpers implementing smart transports
 + Support taking over transports
 + Refactor git transport options parsing
 + Pass unknown protocols to external protocol handlers
 + Support mandatory capabilities
 + Add remote helper debug mode

* jc/checkout-merge-base (2010-01-07) 4 commits
  (merged to 'next' on 2010-01-07 at 5229608)
 + rebase -i: teach --onto A...B syntax
 + rebase: fix --onto A...B parsing and add tests
  (merged to 'next' on 2010-01-02 at 6a8f6fc)
 + "rebase --onto A...B" replays history on the merge base between A and B
 + "checkout A...B" switches to the merge base between A and B

--------------------------------------------------
[New Topics]

* jc/maint-1.6.4-grep-lookahead (2010-01-10) 1 commit
  (merged to 'next' on 2010-01-13 at 20f8f4b)
 + grep: optimize built-in grep by skipping lines that do not hit
 (this branch is used by jc/grep-lookahead and jc/maint-grep-lookahead.)

Optimize the "line-by-line" internal grep by skiping en masse over lines
that cannot possibly match.

* jc/maint-grep-lookahead (2010-01-12) 0 commits
 (this branch uses jc/maint-1.6.4-grep-lookahead; is used by jc/grep-lookahead.)

Early conflict resolution for the above for recent git.

* jc/grep-lookahead (2010-01-12) 2 commits
  (merged to 'next' on 2010-01-13 at 20f8f4b)
 + grep: rip out pessimization to use fixmatch()
 + grep: rip out support for external grep
 (this branch uses jc/maint-1.6.4-grep-lookahead and jc/maint-grep-lookahead.)

This is for eventual inclusion for the next release.

* jc/symbol-static (2010-01-11) 17 commits
 - symlinks.c: remove unused functions
 - object.c: remove unused functions
 - blob.c: remove unused function
 - strbuf.c: remove unused function
 - sha1_file.c: remove unused function
 - mailmap.c: remove unused function
 - utf8.c: mark file-local function static
 - submodule.c: mark file-local function static
 - quote.c: mark file-local function static
 - remote-curl.c: mark file-local function static
 - read-cache.c: mark file-local functions static
 - parse-options.c: mark file-local function static
 - entry.c: mark file-local function static
 - http.c: mark file-local functions static
 - pretty.c: mark file-local function static
 - builtin-rev-list.c: mark file-local function static
 - bisect.c: mark file-local function static

Mark file-local symbols "static", and remove unused functions.  Daniel
suggests to leave some comment for blob.c and I agree in principle, but
I don't think of a good description myself.

* nd/include-termios-for-osol (2010-01-11) 1 commit
 - Add missing #include to support TIOCGWINSZ on Solaris

* pc/uninteresting-submodule-disappear-upon-switch-branches (2010-01-11) 1 commit
 - Remove empty directories when checking out a commit with fewer submodules

Instead of using unlink(2) that will never succeed, use rmdir(2) to remove
an empty directory, knowing that this won't harm a populated directory.

* sd/cd-p-show-toplevel (2010-01-12) 2 commits
 - Use $(git rev-parse --show-toplevel) in cd_to_toplevel().
 - Add 'git rev-parse --show-toplevel' option.

Avoid having to use "cd -P" that may not be available on some platforms'
shells.

* jk/warn-author-committer-after-commit (2010-01-13) 4 commits
 - commit: allow suppression of implicit identity advice
 - commit: show interesting ident information in summary
 - strbuf: add strbuf_addbuf_percentquote
 - strbuf_expand: convert "%%" to "%"

* js/refer-upstream (2009-09-10) 1 commit
 - Introduce <branch>@{upstream} notation

This does not teach the public interface about the new syntax; callers
that care about distinction between name vs SHA-1 might not work as well
as they should.

* mm/conflict-advice (2010-01-12) 1 commit
 - Be more user-friendly when refusing to do something because of conflict.

* jc/maint-strbuf-add-fix-doubling (2010-01-12) 1 commit
 - strbuf_addbuf(): allow passing the same buf to dst and src

* jl/submodule-diff (2010-01-13) 2 commits
 - Teach diff that modified submodule directory is dirty
 - Show submodules as modified when they contain a dirty work tree

--------------------------------------------------
[Stalled]

* ap/merge-backend-opts (2008-07-18) 6 commits
 - Document that merge strategies can now take their own options
 - Extend merge-subtree tests to test -Xsubtree=dir.
 - Make "subtree" part more orthogonal to the rest of merge-recursive.
 - Teach git-pull to pass -X<option> to git-merge
 - git merge -X<option>
 - git-merge-file --ours, --theirs

"git pull" patch needs sq-then-eval fix to protect it from $IFS
but otherwise seemed good.

* mh/rebase-fixup (2010-01-12) 5 commits
  (merged to 'next' on 2010-01-12 at e84eab0)
 + rebase-i: Ignore comments and blank lines in peek_next_command
 + lib-rebase: Allow comments and blank lines to be added to the rebase script
 + lib-rebase: Provide clearer debugging info about what the editor did
  (merged to 'next' on 2010-01-06 at c4779a7)
 + Add a command "fixup" to rebase --interactive
 + t3404: Use test_commit to set up test repository
 (this branch is used by ns/rebase-auto-squash.)

Expecting further improvements to skip opening the editor if a pick is
followed only by "fixup" and no "squash".

* ns/rebase-auto-squash (2009-12-08) 1 commit
  (merged to 'next' on 2010-01-06 at da4e2f5)
 + rebase -i --autosquash: auto-squash commits
 (this branch uses mh/rebase-fixup.)

Blocked by the above.

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

http://thread.gmane.org/gmane.comp.version-control.git/134738

What's the status of the fourth and later patches on this topic?  Overall
it looked reasonable, if I recall correctly what I thought when I reviewed
it last time, and I am tempted to merge it to 'next' soonish.  Please
file complaints before I do so if people have objections.

Hold: JH on 2010-01-05, http://article.gmane.org/gmane.comp.version-control.git/136183

* jh/gitweb-cached (2010-01-13) 7 commits
 - (sign-off?) gitweb: File based caching layer (from git.kernel.org)
 - (sign-off?) gitweb: add a get function to compliment print_local_time
 - (sign-off?) gitweb: Convert output to using indirect file handle
 - gitweb: Optionally add "git" links in project list page
 - gitweb: Makefile improvements
 - gitweb: Add option to force version match
 - gitweb: Load checking

Replaced with a re-roll.  Update to t9500 is probably needed.

--------------------------------------------------
[Cooking]

* jh/commit-status (2010-01-13) 2 commits
  (merged to 'next' on 2010-01-13 at 0905d59)
 + t7502: test commit.status, --status and --no-status
 + commit: support commit.status, --status, and --no-status

I have already given ample time for people to react, but ended up getting
tired of waiting for tests to materialize and doing it myself, as I want
to close merge window for 1.7.0-rc0 by the end of next week to have the
final release early next month.

* bk/fix-relative-gitdir-file (2010-01-08) 2 commits
 - Handle relative paths in submodule .git files
 - Test update-index for a gitlink to a .git file

* jc/ident (2010-01-08) 3 commits
 - ident.c: treat $EMAIL as giving user.email identity explicitly
  (merged to 'next' on 2010-01-10 at f1f9ded)
 + ident.c: check explicit identity for name and email separately
 + ident.c: remove unused variables

Opinions on the topmost one?

* jc/ls-files-ignored-pathspec (2010-01-08) 4 commits
 - ls-files: fix overeager pathspec optimization
 - read_directory(): further split treat_path()
 - read_directory_recursive(): refactor handling of a single path into a separate function
 - t3001: test ls-files -o ignored/dir

* js/exec-error-report (2010-01-12) 4 commits
 - Improve error message when a transport helper was not found
 - start_command: detect execvp failures early
 - run-command: move wait_or_whine earlier
 - start_command: report child process setup errors to the parent's stderr

* jc/maint-1.6.1-checkout-m-custom-merge (2010-01-06) 1 commit
  (merged to 'next' on 2010-01-10 at df14116)
 + checkout -m path: fix recreating conflicts

* jn/makefile (2010-01-06) 4 commits
  (merged to 'next' on 2010-01-10 at f5a5d42)
 + Makefile: consolidate .FORCE-* targets
 + Makefile: learn to generate listings for targets requiring special flags
 + Makefile: use target-specific variable to pass flags to cc
 + Makefile: regenerate assembler listings when asked

* da/difftool (2010-01-09) 6 commits
  (merged to 'next' on 2010-01-10 at 749c870)
 + git-diff.txt: Link to git-difftool
 + difftool: Allow specifying unconfigured commands with --extcmd
 + difftool--helper: Remove use of the GIT_MERGE_TOOL variable
 + difftool--helper: Update copyright and remove distracting comments
  (merged to 'next' on 2010-01-06 at e957395)
 + git-difftool: Add '--gui' for selecting a GUI tool
 + t7800-difftool: Set a bogus tool for use by tests

* tc/test-locate-httpd (2010-01-02) 1 commit
  (merged to 'next' on 2010-01-06 at 9d913e5)
 + t/lib-http.sh: Restructure finding of default httpd location

* jc/fix-tree-walk (2009-09-14) 7 commits
  (merged to 'next' on 2010-01-13 at 1c01b87)
 + read-tree --debug-unpack
 + unpack-trees.c: look ahead in the index
 + unpack-trees.c: prepare for looking ahead in the index
 + Aggressive three-way merge: fix D/F case
 + traverse_trees(): handle D/F conflict case sanely
 + more D/F conflict tests
 + tests: move convenience regexp to match object names to test-lib.sh

Resurrected from "Ejected" category.  This is fix for a tricky codepath
and testing and improving before it hits 'master' is greatly appreciated.
(I have been using this in my private build for some time).

* jc/branch-d (2009-12-29) 1 commit
  (merged to 'next' on 2010-01-10 at 61a14b7)
 + branch -d: base the "already-merged" safety on the branch it merges with

* jc/rerere (2009-12-04) 1 commit
  (merged to 'next' on 2010-01-10 at e295b7f)
 + Teach --[no-]rerere-autoupdate option to merge, revert and friends

* jk/run-command-use-shell (2010-01-01) 8 commits
  (merged to 'next' on 2010-01-10 at 7479e2a)
 + t4030, t4031: work around bogus MSYS bash path conversion
 + diff: run external diff helper with shell
 + textconv: use shell to run helper
 + editor: use run_command's shell feature
 + run-command: optimize out useless shell calls
 + run-command: convert simple callsites to use_shell
 + t0021: use $SHELL_PATH for the filter script
 + run-command: add "use shell" option

Shuffled the commits in the topic, following J6t's suggestion in
http://thread.gmane.org/gmane.comp.version-control.git/136128

* tc/clone-v-progress (2009-12-26) 4 commits
  (merged to 'next' on 2010-01-10 at ec2bfd7)
 + clone: use --progress to force progress reporting
 + clone: set transport->verbose when -v/--verbose is used
 + git-clone.txt: reword description of progress behaviour
 + check stderr with isatty() instead of stdout when deciding to show progress

Perhaps needs an entry in the Release Notes, but otherwise looked Ok.

* tc/smart-http-restrict (2010-01-02) 4 commits
  (merged to 'next' on 2010-01-06 at 82736cb)
 + Smart-http tests: Test http-backend without curl or a webserver
 + Smart-http tests: Break test t5560-http-backend into pieces
 + Smart-http tests: Improve coverage in test t5560
 + Smart-http: check if repository is OK to export before serving it

* jc/cache-unmerge (2009-12-25) 9 commits
  (merged to 'next' on 2010-01-13 at 2290c44)
 + rerere forget path: forget recorded resolution
 + rerere: refactor rerere logic to make it independent from I/O
 + rerere: remove silly 1024-byte line limit
 + resolve-undo: teach "update-index --unresolve" to use resolve-undo info
 + resolve-undo: "checkout -m path" uses resolve-undo information
 + resolve-undo: allow plumbing to clear the information
 + resolve-undo: basic tests
 + resolve-undo: record resolved conflicts in a new index extension section
 + builtin-merge.c: use standard active_cache macros

* tr/http-push-ref-status (2010-01-08) 6 commits
 - transport-helper.c::push_refs(): emit "no refs" error message
 - transport-helper.c::push_refs(): ignore helper-reported status if ref is not to be pushed
 - transport.c::transport_push(): make ref status affect return value
 - refactor ref status logic for pushing
 - t5541-http-push.sh: add test for unmatched, non-fast-forwarded refs
 - t5541-http-push.sh: add tests for non-fast-forward pushes

Rerolled.

* sr/gfi-options (2009-12-04) 7 commits
  (merged to 'next' on 2010-01-10 at 8b305fb)
 + fast-import: add (non-)relative-marks feature
 + fast-import: allow for multiple --import-marks= arguments
 + fast-import: test the new option command
 + fast-import: add option command
 + fast-import: add feature command
 + fast-import: put marks reading in its own function
 + fast-import: put option parsing code in separate functions
