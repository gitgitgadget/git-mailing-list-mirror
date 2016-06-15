From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2009, #04; Sat, 14)
Date: Sat, 14 Mar 2009 23:28:58 -0700
Message-ID: <7vr60z8fkl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 15 07:30:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lijrq-0000PY-2H
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 07:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbZCOG3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 02:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZCOG3H
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 02:29:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbZCOG3F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 02:29:05 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 209C36CA2;
	Sun, 15 Mar 2009 02:29:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 141746CA0; Sun,
 15 Mar 2009 02:28:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 930F3512-112A-11DE-98B5-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113276>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* bw/autoconf (Thu Mar 12 15:20:12 2009 -0400) 7 commits
 - configure: rework pthread handling to allow for user defined flags
 - configure: make iconv tests aware of user arguments
 - configure: asciidoc version test cleanup
 - configure: wrap some library tests with GIT_STASH_FLAGS
 - configure: add macros to stash FLAG variables
 - configure: reorganize flow of argument checks
 - configure: ensure settings from user are also usable in the script

Looked quite expertly done but I do not use autoconf myself, so I'd merge
this to 'next' soon and see anybody screams.

* jc/maint-1.6.0-read-tree-overlay (Thu Mar 12 00:02:12 2009 -0700) 1 commit
 - read-tree A B C: do not create a bogus index and do not segfault

* fg/push-default (Wed Mar 11 23:01:45 2009 +0100) 1 commit
 - New config push.default to decide default behavior for push

Replaced the old series with the first step to allow a smooth transition.
Some might argue that this should not give any warning but just give users
this new configuration to play with first, and after we know we are going
to switch default some day, start the warning.

* ps/blame (Thu Mar 12 21:30:03 2009 +1100) 1 commit
 - blame.c: start libifying the blame infrastructure

* jc/attributes-checkout (Fri Mar 13 21:24:08 2009 -0700) 1 commit
 - Read attributes from the index that is being checked out

----------------------------------------------------------------
[Graduated to "master"]

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
[Will merge to 'master' soon]

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

Kjetil has another fix-up patch for ctime/mtime gotcha that is not on this
list but after that is applied this series can go to 'master'.

* tr/maint-1.6.0-send-email-irt (Wed Mar 11 23:40:13 2009 +0100) 2 commits
 + send-email: test --no-thread --in-reply-to combination
 + send-email: respect in-reply-to regardless of threading

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

----------------------------------------------------------------
[Discarded]

* jc/commit-assume-also-during-merge (Thu Jan 22 22:21:49 2009 -0800) 3 commits
 . git commit: pathspec without -i/-o implies -i semantics during a
   merge
 . builtin-commit: shorten eye-sore overlong lines
 . Add "partial commit" tests during a conflicted merge

This was only meant as a weatherballoon to help facilitate discussion.

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* jc/log-tz (Tue Mar 3 00:45:37 2009 -0800) 1 commit
 - Allow --date=local --date=other-format to work as expected

The one I posted had a few corner-case bugs that was caught with the test
suite; this one has them fixed.  People did not like the UI so it is kept
out of 'next'

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

----------------------------------------------------------------
[Actively cooking]

* mg/http-auth (Thu Mar 12 22:34:43 2009 -0700) 4 commits
 + http.c: CURLOPT_NETRC_OPTIONAL is not available in ancient
   versions of cURL
 + http authentication via prompts
 + http_init(): Fix config file parsing
 + http.c: style cleanups

This does only the fetch side but without any additional configuration
variables that looked like band-aid.

* db/maint-missing-origin (Wed Mar 11 01:47:20 2009 -0400) 1 commit
 + Give error when no remote is configured

* js/sideband-stderr (Tue Mar 10 22:58:09 2009 +0100) 2 commits
 + winansi: support ESC [ K (erase in line)
 + recv_sideband: Bands #2 and #3 always go to stderr

* js/rsync-local (Mon Mar 9 19:44:55 2009 +0100) 1 commit
 + rsync transport: allow local paths, and fix tests

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

* hv/cvsimport-tests (Mon Mar 2 18:59:36 2009 +0100) 1 commit
 + cvsimport: add test illustrating a bug in cvsps

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

* mv/parseopt-ls-files (Sat Mar 7 20:27:22 2009 -0500) 4 commits
 + ls-files: fix broken --no-empty-directory
 + t3000: use test_cmp instead of diff
 + parse-opt: migrate builtin-ls-files.
 + Turn the flags in struct dir_struct into a single variable

The tip one was a subject for further discussion, but nothing is queued
yet.

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
 + Add a test of "git cvsimport"'s handling of tags and branches
 + Add some tests of git-cvsimport's handling of vendor branches
 + Test contents of entire cvsimported "master" tree contents
 + Use CVS's -f option if available (ignore user's ~/.cvsrc file)
 + Start a library for cvsimport-related tests

Tests without fixes are of dubious value.  Any takers?

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
rearrange if necessary.  Nothing happened yet, but I see Dscho has been
busy on msysgit side of the world, so it is understandable.

----------------------------------------------------------------
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

These are for 1.7.0, but the messages when they trigger together may need
to be rethought.
