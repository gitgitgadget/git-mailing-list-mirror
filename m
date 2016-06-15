From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2009, #05; Tue, 17)
Date: Tue, 17 Mar 2009 22:30:37 -0700
Message-ID: <7vbprzo0si.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 06:32:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjoNy-0008DO-2x
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 06:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbZCRFar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 01:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbZCRFaq
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 01:30:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbZCRFap (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 01:30:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A0E237FBF;
	Wed, 18 Mar 2009 01:30:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A8D7E7FBB; Wed,
 18 Mar 2009 01:30:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EBDA3C50-137D-11DE-BE90-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113575>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* dm/maint-docco (Mon Mar 16 23:16:17 2009 -0700) 4 commits
 + Documentation: minor grammatical fixes in git-branch.txt.
 + Documentation: minor grammatical fixes in git-blame.txt.
 + Documentation: reword the "Description" section of git-bisect.txt.
 + Documentation: minor grammatical fixes in git-archive.txt.

* mg/test-installed (Mon Mar 16 18:03:12 2009 +0100) 2 commits
 + test-lib.sh: Allow running the test suite against installed git
 + test-lib.sh: Test for presence of git-init in the right path.

----------------------------------------------------------------
[Graduated to "master"]

* kb/checkout-optim (Tue Mar 17 19:20:29 2009 +0100) 20 commits
 + Revert "lstat_cache(): print a warning if doing ping-pong between
   cache types"
 + checkout bugfix: use stat.mtime instead of stat.ctime in two
   places
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

* rs/color-grep (Mon Mar 16 13:20:04 2009 +1100) 7 commits
 + grep: prefer builtin over external one when coloring results
 + grep: cast printf %.*s "precision" argument explicitly to int
 + grep: add support for coloring with external greps
 + grep: color patterns in output
 + grep: add pmatch and eflags arguments to match_one_pattern()
 + grep: remove grep_opt argument from match_expr_eval()
 + grep: micro-optimize hit collection for AND nodes

* js/rsync-local (Mon Mar 9 19:44:55 2009 +0100) 1 commit
 + rsync transport: allow local paths, and fix tests

* js/sideband-stderr (Tue Mar 10 22:58:09 2009 +0100) 2 commits
 + winansi: support ESC [ K (erase in line)
 + recv_sideband: Bands #2 and #3 always go to stderr

* db/maint-missing-origin (Mon Mar 16 00:35:09 2009 -0700) 2 commits
 + Remove total confusion from git-fetch and git-push
 + Give error when no remote is configured

* jc/maint-1.6.0-read-tree-overlay (Thu Mar 12 00:02:12 2009 -0700) 1 commit
 + read-tree A B C: do not create a bogus index and do not segfault

With new test.

----------------------------------------------------------------
[Will merge to 'master' soon]

* fc/parseopt-config (Tue Mar 17 10:46:37 2009 +0100) 10 commits
 + config: test for --replace-all with one argument and fix
   documentation.
 + config: set help text for --bool-or-int
 + git config: don't allow --get-color* and variable type
 + git config: don't allow extra arguments for -e or -l.
 + git config: don't allow multiple variable types
 + git config: don't allow multiple config file locations
 + git config: reorganize to use parseopt
 + git config: reorganize get_color*
 + git config: trivial rename in preparation for parseopt
 + git_config(): not having a per-repo config file is not an error

* js/rebase-i-opt (Tue Mar 3 10:55:31 2009 +0100) 1 commit
 + rebase -i: avoid 'git reset' when possible

* mh/cvsimport-tests (Mon Feb 23 06:08:14 2009 +0100) 5 commits
 + Add a test of "git cvsimport"'s handling of tags and branches
 + Add some tests of git-cvsimport's handling of vendor branches
 + Test contents of entire cvsimported "master" tree contents
 + Use CVS's -f option if available (ignore user's ~/.cvsrc file)
 + Start a library for cvsimport-related tests

* hv/cvsimport-tests (Mon Mar 2 18:59:36 2009 +0100) 1 commit
 + cvsimport: add test illustrating a bug in cvsps

* jc/clone-branch-rebase (Tue Mar 10 01:20:42 2009 -0700) 2 commits
 + Improve "git branch --tracking" output
 + Make git-clone respect branch.autosetuprebase

This is a rewrite of a patch from Pat Notz.

* xx/db-refspec-vs-js-remote (Sun Mar 8 00:12:33 2009 -0800) 1 commit
 + Adjust js/remote-improvements and db/refspec-wildcard-in-the-
   middle

* db/refspec-wildcard-in-the-middle (Sat Mar 7 01:11:39 2009 -0500) 5 commits
 + Support '*' in the middle of a refspec
 + Keep '*' in pattern refspecs
 + Use the matching function to generate the match results
 + Use a single function to match names against patterns
 + Make clone parse the default refspec with the normal code

* bw/autoconf (Thu Mar 12 15:20:12 2009 -0400) 7 commits
 + configure: rework pthread handling to allow for user defined flags
 + configure: make iconv tests aware of user arguments
 + configure: asciidoc version test cleanup
 + configure: wrap some library tests with GIT_STASH_FLAGS
 + configure: add macros to stash FLAG variables
 + configure: reorganize flow of argument checks
 + configure: ensure settings from user are also usable in the script

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* ps/blame (Thu Mar 12 21:30:03 2009 +1100) 1 commit
 - blame.c: start libifying the blame infrastructure

A few minor point remains in this initial one.

* jc/log-tz (Tue Mar 3 00:45:37 2009 -0800) 1 commit
 - Allow --date=local --date=other-format to work as expected

The one I posted had a few corner-case bugs that was caught with the test
suite; this one has them fixed.  People did not like the UI so it is kept
out of 'next'

* lh/submodule-tree-traversal (Sun Jan 25 01:52:06 2009 +0100) 1 commit
 - archive.c: add support for --submodules[=(all|checkedout)]

Discussion stalled on the submodule selection criteria.
Probably I should discard it and wait for a reroll if needed.

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

Daniel seems to have a plan for going forward with this series.

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

I know, I really have to drop everything else and re-read these, but I
haven't managed to.

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

----------------------------------------------------------------
[Actively cooking]

* jc/attributes-checkout (Fri Mar 13 21:24:08 2009 -0700) 1 commit
 - Read attributes from the index that is being checked out

* fg/push-default (Mon Mar 16 16:42:52 2009 +0100) 2 commits
 - Display warning for default git push with no push.default config
 + New config push.default to decide default behavior for push

Replaced the old series with the first step to allow a smooth transition.
Some might argue that this should not give any warning but just give users
this new configuration to play with first, and after we know we are going
to switch default some day, start the warning.

* mg/http-auth (Thu Mar 12 22:34:43 2009 -0700) 4 commits
 + http.c: CURLOPT_NETRC_OPTIONAL is not available in ancient
   versions of cURL
 + http authentication via prompts
 + http_init(): Fix config file parsing
 + http.c: style cleanups

This does only the fetch side but without any additional configuration
variables that looked like band-aid.  Support for push side seems to be in
the works somewhere.

* db/push-cleanup (Sun Mar 8 21:06:07 2009 -0400) 2 commits
 + Move push matching and reporting logic into transport.c
 + Use a common function to get the pretty name of refs

* kb/tracking-count-no-merges (Wed Mar 4 18:47:39 2009 +0100) 1 commit
 + stat_tracking_info(): only count real commits

This gives the merge commits zero weight when talking about how many
commits you have ahead (or behind) of the branch you are tracking.  Even
though I agree that they should carry much less weight than the "real"
commits, because your repeated merge from the other branch does not really
add any real value to the end result, giving them absolute zero weight
somehow feels wrong. At least it shows that your have been _active_ on the
branch.  But I do not feel very strongly about it.

* mv/parseopt-ls-files (Sat Mar 7 20:27:22 2009 -0500) 4 commits
 + ls-files: fix broken --no-empty-directory
 + t3000: use test_cmp instead of diff
 + parse-opt: migrate builtin-ls-files.
 + Turn the flags in struct dir_struct into a single variable

The tip one was a subject for further discussion, but nothing is queued
yet.

----------------------------------------------------------------
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

These are for 1.7.0, but the messages when they trigger together may need
to be rethought.
