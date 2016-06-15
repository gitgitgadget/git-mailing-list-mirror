From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2009, #03; Wed, 11)
Date: Wed, 11 Mar 2009 02:26:44 -0700
Message-ID: <7vvdqg5s17.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 10:28:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhKjf-00037Q-VZ
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 10:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbZCKJ04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 05:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbZCKJ0z
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 05:26:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbZCKJ0w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 05:26:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EDA38A1144;
	Wed, 11 Mar 2009 05:26:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3CB4DA1143; Wed,
 11 Mar 2009 05:26:46 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BFECE0AC-0E1E-11DE-A33F-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112898>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

Tonight's 'pu' does not pass its self-test and it is expected; I won't be
fixing it and I'm going to bed now.

----------------------------------------------------------------
[New Topics]

* db/maint-missing-origin (Wed Mar 11 01:47:20 2009 -0400) 1 commit
 - Give error when no remote is configured

* js/sideband-stderr (Tue Mar 10 22:58:09 2009 +0100) 2 commits
 - winansi: support ESC [ K (erase in line)
 - recv_sideband: Bands #2 and #3 always go to stderr

* js/rsync-local (Mon Mar 9 19:44:55 2009 +0100) 1 commit
 - rsync transport: allow local paths, and fix tests

* rs/color-grep (Sun Mar 8 18:22:44 2009 -0700) 6 commits
 + grep: cast printf %.*s "precision" argument explicitly to int
 + grep: add support for coloring with external greps
 + grep: color patterns in output
 + grep: add pmatch and eflags arguments to match_one_pattern()
 + grep: remove grep_opt argument from match_expr_eval()
 + grep: micro-optimize hit collection for AND nodes

* db/refspec-wildcard-in-the-middle (Sat Mar 7 01:11:39 2009 -0500) 5 commits
 + Support '*' in the middle of a refspec
 + Keep '*' in pattern refspecs
 + Use the matching function to generate the match results
 + Use a single function to match names against patterns
 + Make clone parse the default refspec with the normal code

* db/push-cleanup (Sun Mar 8 21:06:07 2009 -0400) 2 commits
 - Move push matching and reporting logic into transport.c
 - Use a common function to get the pretty name of refs

* xx/db-refspec-vs-js-remote (Sun Mar 8 00:12:33 2009 -0800) 1 commit
 + Adjust js/remote-improvements and db/refspec-wildcard-in-the-
   middle

* fg/push-default (Mon Mar 9 23:35:51 2009 +0100) 7 commits
 - git push: Remove warning for "git push" default change
 - git push: Change default for "git push" to nothing.
 - git push: Document that "nothing" is the future push default
 - git push: Display warning on unconfigured default push
 - git push: New options --matching and --current
 - New config option push.default
 - remote: Make "-" an alias for the current remote

With the topmost three patches, tonight's 'pu' does not pass the self test
as expected.  I am not sure there is a wide support for changing the
default, either.

* kg/http-auth (Mon Mar 9 23:34:25 2009 -0700) 3 commits
 - http authentication via prompts
 - http_init(): Fix config file parsing
 - http.c: style cleanups

This only deals with the fetch side.

* jc/log-tz (Tue Mar 3 00:45:37 2009 -0800) 1 commit
 - Allow --date=local --date=other-format to work as expected

The one I posted had a few corner-case bugs that was caught with the test
suite; this one has them fixed.

----------------------------------------------------------------
[Graduated to "master"]

* jk/sane-relative-time (Tue Feb 24 00:42:16 2009 -0500) 1 commit
 + never fallback relative times to absolute

* js/send-email (Mon Mar 2 23:52:18 2009 -0500) 5 commits
 + send-email: add --confirm option and configuration setting
 + send-email: don't create temporary compose file until it is needed
 + send-email: --suppress-cc improvements
 + send-email: handle multiple Cc addresses when reading mbox message
 + send-email: allow send-email to run outside a repo

* sg/rerere-cleanup (Sat Feb 14 23:21:04 2009 +0100) 1 commit
 + rerere: remove duplicated functions

* jc/add-p-unquote (Mon Feb 16 22:43:43 2009 -0800) 1 commit
 + git-add -i/-p: learn to unwrap C-quoted paths

* jw/imap-preformatted-html (Thu Feb 12 08:58:12 2009 -0600) 1 commit
 + imap.preformattedHTML to tell Thunderbird to send non-flowed text

* jw/format-patch-attach (Thu Feb 12 09:51:55 2009 -0600) 1 commit
 + Enable setting attach as the default in .gitconfig for git-format-
   patch.

* sr/force-rebase (Fri Feb 13 23:48:01 2009 +0100) 1 commit
 + Teach rebase to rebase even if upstream is up to date

* fg/exclude-bq (Tue Feb 10 15:20:17 2009 +0100) 1 commit
 + Support "\" in non-wildcard exclusion entries

* dm/add-i-edit-abort (Thu Feb 12 00:19:41 2009 -0500) 1 commit
 + add -i: revisit hunk on editor failure

* tp/completion (Sat Feb 21 15:48:43 2009 +0100) 6 commits
 + Fixup: Add bare repository indicator for __git_ps1
 + Add bare repository indicator for __git_ps1
 + completion: More fixes to prevent unbound variable errors
 + completion: Better __git_ps1 support when not in working directory
 + completion: Use consistent if [...] convention, not "test"
 + completion: For consistency, change "git rev-parse" to __gitdir
   calls

* js/branch-symref (Wed Feb 18 22:34:44 2009 -0500) 4 commits
 + add basic branch display tests
 + branch: clean up repeated strlen
 + Avoid segfault with 'git branch' when the HEAD is detached
 + builtin-branch: improve output when displaying remote branches

* al/ansi-color (Fri Feb 13 22:53:41 2009 +0100) 2 commits
 + builtin-branch.c: Rename branch category color names
 + Clean up use of ANSI color sequences

* js/valgrind (Thu Feb 5 22:03:00 2009 +0100) 9 commits
 + valgrind: do not require valgrind 3.4.0 or newer
 + test-lib: avoid assuming that templates/ are in the GIT_EXEC_PATH
 + Tests: let --valgrind imply --verbose and --tee
 + Add a script to coalesce the valgrind outputs
 + t/Makefile: provide a 'valgrind' target
 + test-lib.sh: optionally output to test-results/$TEST.out, too
 + Valgrind support: check for more than just programming errors
 + valgrind: ignore ldso and more libz errors
 + Add valgrind support in test scripts

* fc/config-editor (Sat Feb 21 02:48:54 2009 +0200) 3 commits
 + git config: trivial cleanup for editor action
 + git config: codestyle cleanups
 + config: Add new option to open an editor.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

* ns/pretty-format (Tue Feb 24 15:33:29 2009 +0200) 5 commits
 + bash completion: add --format= and --oneline options for "git log"
 + Add tests for git log --pretty, --format and --oneline.
 + Add --oneline that is a synonym to "--pretty=oneline --abbrev-
   commit"
 + Give short-hands to --pretty=tformat:%formatstring
 + Add --format that is a synonym to --pretty

* en/maint-hash-object (Sat Feb 28 12:56:49 2009 -0700) 1 commit
 + Ensure proper setup of git_dir for git-hash-object

----------------------------------------------------------------
[Will merge to 'master' soon]

* mg/maint-submodule-normalize-path (Tue Mar 3 16:08:21 2009 +0100) 2 commits
 + git submodule: Fix adding of submodules at paths with ./, .. and
   //
 + git submodule: Add test cases for git submodule add

* rs/memmem (Tue Mar 3 00:19:30 2009 +0100) 2 commits
 + optimize compat/ memmem()
 + diffcore-pickaxe: use memmem()

* tv/rebase-stat (Sun Mar 1 22:28:28 2009 +0100) 2 commits
 + git-pull: Allow --stat and --no-stat to be used with --rebase
 + git-rebase: Add --stat and --no-stat for producing diffstat on
   rebase

* jk/clone-post-checkout (Tue Mar 3 00:37:51 2009 -0500) 1 commit
 + clone: run post-checkout hook when checking out

* jc/maint-1.6.0-keep-pack (Sat Feb 28 00:37:19 2009 -0800) 6 commits
 + is_kept_pack(): final clean-up
 + Simplify is_kept_pack()
 + Consolidate ignore_packed logic more
 + has_sha1_kept_pack(): take "struct rev_info"
 + has_sha1_pack(): refactor "pretend these packs do not exist"
   interface
 + git-repack: resist stray environment variable

This is in response to Linus's "Really slow 'git gc'" ($gmane/110743)

* el/blame-date (Fri Feb 20 14:51:11 2009 -0800) 1 commit
 + Make git blame's date output format configurable, like git log

* tr/gcov (Thu Feb 19 12:13:42 2009 +0100) 8 commits
 + Test git-patch-id
 + Test rev-list --parents/--children
 + Test log --decorate
 + Test fsck a bit harder
 + Test log --graph
 + Test diff --dirstat functionality
 + Test that diff can read from stdin
 + Support coverage testing with GCC/gcov

* tr/format-patch-thread (Thu Feb 19 22:26:33 2009 +0100) 4 commits
 + format-patch: support deep threading
 + format-patch: thread as reply to cover letter even with in-reply-
   to
 + format-patch: track several references
 + format-patch: threading test reactivation

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* lh/submodule-tree-traversal (Sun Jan 25 01:52:06 2009 +0100) 1 commit
 - archive.c: add support for --submodules[=(all|checkedout)]

Discussion stalled on the submodule selection criteria.

* jc/merge-convert (Mon Jan 26 16:45:01 2009 -0800) 1 commit
 - git-merge-file: allow converting the results for the work tree

This is a feature waiting for a user.

We did not give scripted Porcelains a way to say "this temporary file I am
using for merging is for this path, so use the core.autocrlf and attributes
rules for that final path".  Instead, merge-file simply wrote out the
data in the canonical repository representation.

rerere has the same issue, but it is a lot worse.  It reads the three
files (preimage, postimage and thisimage) from the work tree in the work
tree representation, merges them without converting them to the canonical
representation first but inserts the conflict markers with the canonical
representation and writes the resulting mess out.  It needs to be fixed to
read with convert_to_git(), merge them while they are still in the
canonical representation and possibly add conflict markers, and then write
the results out after convert_to_working_tree().  It also needs to write
in binary mode as well.

* db/foreign-scm (Sun Jan 11 15:12:10 2009 -0500) 3 commits
 - Support fetching from foreign VCSes
 - Add specification of git-vcs helpers
 - Add "vcs" config option in remotes

The "spec" did not seem quite well cooked yet, but in the longer term I
think something like this to allow interoperating with other SCMs as if
the other end is a native git repository is a very worthy goal.

* cc/replace (Mon Feb 2 06:13:06 2009 +0100) 11 commits
 - builtin-replace: use "usage_msg_opt" to give better error messages
 - parse-options: add new function "usage_msg_opt"
 - builtin-replace: teach "git replace" to actually replace
 - Add new "git replace" command
 - environment: add global variable to disable replacement
 - mktag: call "check_sha1_signature" with the replacement sha1
 - replace_object: add a test case
 - object: call "check_sha1_signature" with the replacement sha1
 - sha1_file: add a "read_sha1_file_repl" function
 - replace_object: add mechanism to replace objects found in
   "refs/replace/"
 - refs: add a "for_each_replace_ref" function

I think the code is much cleaner than the first round, but I am not
convinced it is doing the right thing in the connectivity traverser.
Independent review sorely needed.

----------------------------------------------------------------
[Discarded]

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 . gitweb: Optional grouping of projects by category
 . gitweb: Split git_project_list_body in two functions
 . gitweb: Modularized git_get_project_description to be more generic

Design discussion between Jakub and Sebastien seems to have stalled, but
Jakub seems to be taking this over.

* jc/push-to-create (Mon Mar 2 22:36:16 2009 -0800) 1 commit
 . Push to create

This was a failed weatherbaloon patch to allow creation of a new
repository from the remote side.

----------------------------------------------------------------
[Actively cooking]

* hv/cvsimport-tests (Mon Mar 2 18:59:36 2009 +0100) 1 commit
 - cvsimport: add test illustrating a bug in cvsps

Yet more tests without fixing anything...

* jc/clone-branch-rebase (Tue Mar 10 01:20:42 2009 -0700) 2 commits
 + Improve "git branch --tracking" output
 + Make git-clone respect branch.autosetuprebase

This is a rewrite of a patch from Pat Notz.

* kb/tracking-count-no-merges (Wed Mar 4 18:47:39 2009 +0100) 1 commit
 + stat_tracking_info(): only count real commits

This gives the merge commits zero weight when talking about how many
commits you have ahead (or behind) of the branch you are tracking.  Even
though I agree that they should carry much less weight than the "real"
commits, because your repeated merge from the other branch does not really
add any real value to the end result, giving them absolute zero weight
somehow feels wrong. At least it shows that your have been _active_ on the
branch.  But I do not feel very strongly about it.

* js/rebase-i-opt (Tue Mar 3 10:55:31 2009 +0100) 1 commit
 + rebase -i: avoid 'git reset' when possible

* kb/checkout-optim (Sun Mar 8 17:22:51 2009 -0400) 18 commits
 + Makefile: Set compiler switch for USE_NSEC
 + Create USE_ST_TIMESPEC and turn it on for Darwin
 + Not all systems use st_[cm]tim field for ns resolution file
   timestamp
 + Record ns-timestamps if possible, but do not use it without
   USE_NSEC
 + write_index(): update index_state->timestamp after flushing to
   disk
 + verify_uptodate(): add ce_uptodate(ce) test
 + make USE_NSEC work as expected
 + fix compile error when USE_NSEC is defined
 + check_updates(): effective removal of cache entries marked
   CE_REMOVE
 + lstat_cache(): print a warning if doing ping-pong between cache
   types
 + show_patch_diff(): remove a call to fstat()
 + write_entry(): use fstat() instead of lstat() when file is open
 + write_entry(): cleanup of some duplicated code
 + create_directories(): remove some memcpy() and strchr() calls
 + unlink_entry(): introduce schedule_dir_for_removal()
 + lstat_cache(): swap func(length, string) into func(string, length)
 + lstat_cache(): generalise longest_match_lstat_cache()
 + lstat_cache(): small cleanup and optimisation

* mv/parseopt-ls-files (Sat Mar 7 20:27:22 2009 -0500) 4 commits
 + ls-files: fix broken --no-empty-directory
 + t3000: use test_cmp instead of diff
 + parse-opt: migrate builtin-ls-files.
 + Turn the flags in struct dir_struct into a single variable

The tip one was a subject for further discussion, but nothing is queued
yet.

* js/remote-improvements (Sun Mar 8 00:10:33 2009 -0800) 23 commits
 + builtin-remote.c: no "commented out" code, please
 + builtin-remote: new show output style for push refspecs
 + builtin-remote: new show output style
 + remote: make guess_remote_head() use exact HEAD lookup if it is
   available
 + builtin-remote: add set-head subcommand
 + builtin-remote: teach show to display remote HEAD
 + builtin-remote: fix two inconsistencies in the output of "show
   <remote>"
 + builtin-remote: make get_remote_ref_states() always populate
   states.tracked
 + builtin-remote: rename variables and eliminate redundant function
   call
 + builtin-remote: remove unused code in get_ref_states
 + builtin-remote: refactor duplicated cleanup code
 + string-list: new for_each_string_list() function
 + remote: make match_refs() not short-circuit
 + remote: make match_refs() copy src ref before assigning to
   peer_ref
 + remote: let guess_remote_head() optionally return all matches
 + remote: make copy_ref() perform a deep copy
 + remote: simplify guess_remote_head()
 + move locate_head() to remote.c
 + move duplicated ref_newer() to remote.c
 + move duplicated get_local_heads() to remote.c
 + refactor find_ref_by_name() to accept const list
 + add basic http clone/fetch tests
 + test scripts: refactor start_httpd helper

* fc/parseopt-config (Sat Mar 7 12:14:05 2009 -0500) 9 commits
 + config: set help text for --bool-or-int
 + git config: don't allow --get-color* and variable type
 + git config: don't allow extra arguments for -e or -l.
 + git config: don't allow multiple variable types
 + git config: don't allow multiple config file locations
 + git config: reorganize to use parseopt
 + git config: reorganize get_color*
 + git config: trivial rename in preparation for parseopt
 + git_config(): not having a per-repo config file is not an error

* mh/cvsimport-tests (Mon Feb 23 06:08:14 2009 +0100) 5 commits
 - Add a test of "git cvsimport"'s handling of tags and branches
 - Add some tests of git-cvsimport's handling of vendor branches
 - Test contents of entire cvsimported "master" tree contents
 - Use CVS's -f option if available (ignore user's ~/.cvsrc file)
 - Start a library for cvsimport-related tests

Tests without fixes are of dubious value.  Any takers?

* tr/maint-1.6.0-send-email-irt (Sun Mar 1 23:45:41 2009 +0100) 1 commit
 + send-email: respect in-reply-to regardless of threading

Tests?

* js/notes (Wed Feb 18 11:17:27 2009 -0800) 14 commits
 - tests: fix "export var=val"
 - notes: refuse to edit notes outside refs/notes/
 - t3301: use test_must_fail instead of !
 - t3301: fix confusing quoting in test for valid notes ref
 - notes: use GIT_EDITOR and core.editor over VISUAL/EDITOR
 - notes: only clean up message file when editing
 - handle empty notes gracefully
 - git notes show: test empty notes
 - git-notes: fix printing of multi-line notes
 - notes: fix core.notesRef documentation
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

Rebased and then kicked back to 'pu' to give the author a chance to
rearrange if necessary.

----------------------------------------------------------------
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

These are for 1.7.0, but the messages when they trigger together may need
to be rethought.

* jc/commit-assume-also-during-merge (Thu Jan 22 22:21:49 2009 -0800) 3 commits
 - git commit: pathspec without -i/-o implies -i semantics during a
   merge
 - builtin-commit: shorten eye-sore overlong lines
 - Add "partial commit" tests during a conflicted merge

This was only meant as a weatherballoon to help facilitate discussion.
Will be discarded.
