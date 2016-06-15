From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2009, #02; Thu, 05)
Date: Thu, 05 Mar 2009 02:07:26 -0800
Message-ID: <7vbpsg2sgx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 11:09:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfAVk-00077A-Rd
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 11:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbZCEKHf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 05:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbZCEKHf
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 05:07:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbZCEKHd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 05:07:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0FCD29F32A;
	Thu,  5 Mar 2009 05:07:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C468B9F329; Thu,
  5 Mar 2009 05:07:28 -0500 (EST)
X-master-at: 836769e875ecf47e83137a39de5937652e0e861e
X-next-at: c65e767e015b0309eb047b5a4d2b20dcaceeab22
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7073C06E-096D-11DE-BFA5-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112283>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their nam=
es.

The master branch is slightly past 1.6.2, but embarrasingly enough we
already have a real commit on 'maint'.

----------------------------------------------------------------
[New Topics]

* hv/cvsimport-tests (Mon Mar 2 18:59:36 2009 +0100) 1 commit
 - cvsimport: add test illustrating a bug in cvsps

Yet more tests without fixing anything...

* jc/clone-branch-rebase (Tue Mar 3 22:29:55 2009 -0800) 1 commit
 - Make git-clone respect branch.autosetuprebase

This is rewrite of a patch from Pat Notz.

* mg/maint-submodule-normalize-path (Tue Mar 3 16:08:21 2009 +0100) 2 c=
ommits
 - git submodule: Fix adding of submodules at paths with ./, .. and //
 - git submodule: Add test cases for git submodule add

* kb/tracking-count-no-merges (Wed Mar 4 18:47:39 2009 +0100) 1 commit
 - stat_tracking_info(): only count real commits

This gives the merge commits zero weight when talking about how many
commits you have ahead (or behind) of the branch you are tracking.  Eve=
n
though I agree that they should carry much less weight than the "real"
commits, because your repeated merge from the other branch does not rea=
lly
add any real value to the end result, giving them absolute zero weight
somehow feels wrong. At least it shows that your have been _active_ on =
the
branch.  But I do not feel very strongly about it.

* js/rebase-i-opt (Tue Mar 3 10:55:31 2009 +0100) 1 commit
 - rebase -i: avoid 'git reset' when possible

----------------------------------------------------------------
[Will merge to 'master' soon]

* jk/sane-relative-time (Tue Feb 24 00:42:16 2009 -0500) 1 commit
 + never fallback relative times to absolute

I think I sent out a "here is how" patch for something related to
--date=3D<format> option that may be related to this topic; I seem to h=
ave
lost it.

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

The patch text should be identical to Jeremy's "Virtual Patch", except
that the configuration variable was renamed per list discussion.

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

Rerolled and looked sane.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

This gives Porcelains (like gitweb) the information on the commit _befo=
re_
the one that the final blame is laid on, which should save them one
rev-parse to dig further.  Jakub seems to want this for gitweb.

* ns/pretty-format (Tue Feb 24 15:33:29 2009 +0200) 5 commits
 + bash completion: add --format=3D and --oneline options for "git log"
 + Add tests for git log --pretty, --format and --oneline.
 + Add --oneline that is a synonym to "--pretty=3Doneline --abbrev-
   commit"
 + Give short-hands to --pretty=3Dtformat:%formatstring
 + Add --format that is a synonym to --pretty

----------------------------------------------------------------
[Discarded]

* js/clone-depth-local (Fri Feb 27 00:04:06 2009 -0800) 3 commits
 . parse_options(): do not "increment" boolean
 . clone: ignore --depth when cloning locally (implicitly --local)
 . clone: do not ignore --no-local option

Jeff had a good suggestion for this series but it was tripped by
a misfeature in parse_options().

* ns/stash-keep (Thu Feb 12 06:25:14 2009 +0900) 1 commit
 . stash: --keep option just saves

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* lh/submodule-tree-traversal (Sun Jan 25 01:52:06 2009 +0100) 1 commit
 - archive.c: add support for --submodules[=3D(all|checkedout)]

Discussion stalled on the submodule selection criteria.

* jc/merge-convert (Mon Jan 26 16:45:01 2009 -0800) 1 commit
 - git-merge-file: allow converting the results for the work tree

This is a feature waiting for a user.

We did not give scripted Porcelains a way to say "this temporary file I=
 am
using for merging is for this path, so use the core.autocrlf and attrib=
utes
rules for that final path".  Instead, merge-file simply wrote out the
data in the canonical repository representation.

rerere has the same issue, but it is a lot worse.  It reads the three
files (preimage, postimage and thisimage) from the work tree in the wor=
k
tree representation, merges them without converting them to the canonic=
al
representation first but inserts the conflict markers with the canonica=
l
representation and writes the resulting mess out.  It needs to be fixed=
 to
read with convert_to_git(), merge them while they are still in the
canonical representation and possibly add conflict markers, and then wr=
ite
the results out after convert_to_working_tree().  It also needs to writ=
e
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

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

Design discussion between Jakub and Sebastien seems to have stalled, bu=
t
Jakub seems to be taking this over, so I'll probably discard these thre=
e
shortly.

----------------------------------------------------------------
[Actively cooking]

* kb/checkout-optim (Wed Mar 4 18:47:40 2009 +0100) 15 commits
 - better introduction of GIT with USE_NSEC defined
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

* rs/memmem (Tue Mar 3 00:19:30 2009 +0100) 2 commits
 - optimize compat/ memmem()
 - diffcore-pickaxe: use memmem()

As always with patches from Ren=C3=A9, this is already next material.

* jc/push-to-create (Mon Mar 2 22:36:16 2009 -0800) 1 commit
 - Push to create

This was a failed weatherbaloon patch to allow creation of a new
repository from the remote side.  Will discard.

* mv/parseopt-ls-files (Tue Feb 17 15:27:11 2009 +0100) 2 commits
 - parse-opt: migrate builtin-ls-files.
 - Turn the flags in struct dir_struct into a single variable

* tv/rebase-stat (Sun Mar 1 22:28:28 2009 +0100) 2 commits
 - git-pull: Allow --stat and --no-stat to be used with --rebase
 - git-rebase: Add --stat and --no-stat for producing diffstat on
   rebase

* jk/clone-post-checkout (Tue Mar 3 00:37:51 2009 -0500) 1 commit
 - clone: run post-checkout hook when checking out

* js/remote-improvements (Wed Feb 25 03:32:28 2009 -0500) 22 commits
 - builtin-remote: new show output style for push refspecs
 - builtin-remote: new show output style
 - remote: make guess_remote_head() use exact HEAD lookup if it is
   available
 - builtin-remote: add set-head subcommand
 - builtin-remote: teach show to display remote HEAD
 - builtin-remote: fix two inconsistencies in the output of "show
   <remote>"
 - builtin-remote: make get_remote_ref_states() always populate
   states.tracked
 - builtin-remote: rename variables and eliminate redundant function
   call
 - builtin-remote: remove unused code in get_ref_states
 - builtin-remote: refactor duplicated cleanup code
 - string-list: new for_each_string_list() function
 - remote: make match_refs() not short-circuit
 - remote: make match_refs() copy src ref before assigning to
   peer_ref
 - remote: let guess_remote_head() optionally return all matches
 - remote: make copy_ref() perform a deep copy
 - remote: simplify guess_remote_head()
 - move locate_head() to remote.c
 - move duplicated ref_newer() to remote.c
 - move duplicated get_local_heads() to remote.c
 - refactor find_ref_by_name() to accept const list
 - add basic http clone/fetch tests
 - test scripts: refactor start_httpd helper

* fc/parseopt-config (Sat Feb 21 02:49:29 2009 +0200) 11 commits
 - git config: don't allow --get-color* and variable type
 - git config: don't allow extra arguments for -e or -l.
 - git config: don't allow multiple variable types
 - git config: don't allow multiple config file locations
 - git config: reorganize to use parseopt
 - git config: reorganize get_color*
 - git config: trivial rename in preparation for parseopt
 - git_config(): not having a per-repo config file is not an error
 + git config: trivial cleanup for editor action
 + git config: codestyle cleanups
 + config: Add new option to open an editor.

* tr/format-patch-thread (Thu Feb 19 22:26:33 2009 +0100) 4 commits
 - format-patch: support deep threading
 - format-patch: thread as reply to cover letter even with in-reply-
   to
 - format-patch: track several references
 - format-patch: threading test reactivation

* el/blame-date (Fri Feb 20 14:51:11 2009 -0800) 1 commit
 - Make git blame's date output format configurable, like git log

I think the above seven series were basically Ok; I'll hopefully have t=
ime
to re-read them and merge them to 'next'.

* mh/cvsimport-tests (Mon Feb 23 06:08:14 2009 +0100) 5 commits
 - Add a test of "git cvsimport"'s handling of tags and branches
 - Add some tests of git-cvsimport's handling of vendor branches
 - Test contents of entire cvsimported "master" tree contents
 - Use CVS's -f option if available (ignore user's ~/.cvsrc file)
 - Start a library for cvsimport-related tests

Tests without fixes are of dubious value.  Any takers?

* tr/maint-1.6.0-send-email-irt (Sun Mar 1 23:45:41 2009 +0100) 1 commi=
t
 - send-email: respect in-reply-to regardless of threading

Tests?

* jc/maint-1.6.0-keep-pack (Sat Feb 28 00:37:19 2009 -0800) 6 commits
 + is_kept_pack(): final clean-up
 + Simplify is_kept_pack()
 + Consolidate ignore_packed logic more
 + has_sha1_kept_pack(): take "struct rev_info"
 + has_sha1_pack(): refactor "pretend these packs do not exist"
   interface
 + git-repack: resist stray environment variable

This is in response to Linus's "Really slow 'git gc'" ($gmane/110743)

* en/maint-hash-object (Sat Feb 28 12:56:49 2009 -0700) 1 commit
 + Ensure proper setup of git_dir for git-hash-object

Obvious fix that can also go to 1.6.1.X

* tr/gcov (Thu Feb 19 12:13:42 2009 +0100) 8 commits
 - Test git-patch-id
 - Test rev-list --parents/--children
 - Test log --decorate
 - Test fsck a bit harder
 - Test log --graph
 - Test diff --dirstat functionality
 - Test that diff can read from stdin
 - Support coverage testing with GCC/gcov

* js/notes (Wed Feb 18 11:17:27 2009 -0800) 14 commits
 - tests: fix "export var=3Dval"
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
rearrange if necessary.  I might do some trivial squashing myself.

----------------------------------------------------------------
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 co=
mmit
 - Refuse updating the current branch in a non-bare repository via
   push

These are for 1.7.0, but the messages when they trigger together may ne=
ed
to be rethought.

* jc/commit-assume-also-during-merge (Thu Jan 22 22:21:49 2009 -0800) 3=
 commits
 - git commit: pathspec without -i/-o implies -i semantics during a
   merge
 - builtin-commit: shorten eye-sore overlong lines
 - Add "partial commit" tests during a conflicted merge

This was only meant as a weatherballoon to help facilitate discussion.
Will be discarded.
