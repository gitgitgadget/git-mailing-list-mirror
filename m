From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2009, #01; Tue, 03)
Date: Tue, 03 Mar 2009 01:01:45 -0800
Message-ID: <7vprgzdlom.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 10:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeQX6-0000W5-8w
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 10:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbZCCJB5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 04:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbZCCJB4
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 04:01:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbZCCJBy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 04:01:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B3359E765;
	Tue,  3 Mar 2009 04:01:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B0B999E764; Tue,
  3 Mar 2009 04:01:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EF8B1B92-07D1-11DE-8D51-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112035>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their nam=
es.

The master branch is slightly past 1.6.2-rc2.  It's been a week and I
think I can declare the final on this Wednesday, *if* I am not too mire=
d
by the day job, but I do not know what would happen yet.

As an experiment, 'next' and 'pu' stayed open during this release freez=
e;
new topics have been accepted.  I have to say that the experiment was a
moderate success, and many topics in 'next' seem to be of fairly high
quality already, which would mean that we will have a shorter cycle bef=
ore
1.6.3.

----------------------------------------------------------------
[New Topics]

* jk/clone-post-checkout (Tue Mar 3 00:37:51 2009 -0500) 1 commit
 - clone: run post-checkout hook when checking out

* hv/cvsimport (Mon Mar 2 18:59:36 2009 +0100) 1 commit
 - cvsimport: add test illustrating a bug in cvsps

* jc/push-to-create (Mon Mar 2 22:36:16 2009 -0800) 1 commit
 - Push to create

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

* ns/pretty-format (Tue Feb 24 15:33:29 2009 +0200) 5 commits
 + bash completion: add --format=3D and --oneline options for "git log"
 + Add tests for git log --pretty, --format and --oneline.
 + Add --oneline that is a synonym to "--pretty=3Doneline --abbrev-
   commit"
 + Give short-hands to --pretty=3Dtformat:%formatstring
 + Add --format that is a synonym to --pretty

* mh/cvsimport-tests (Mon Feb 23 06:08:14 2009 +0100) 5 commits
 - Add a test of "git cvsimport"'s handling of tags and branches
 - Add some tests of git-cvsimport's handling of vendor branches
 - Test contents of entire cvsimported "master" tree contents
 - Use CVS's -f option if available (ignore user's ~/.cvsrc file)
 - Start a library for cvsimport-related tests

* tr/maint-1.6.0-send-email-irt (Sun Mar 1 23:45:41 2009 +0100) 1 commi=
t
 - send-email: respect in-reply-to regardless of threading

* jc/maint-1.6.0-keep-pack (Sat Feb 28 00:37:19 2009 -0800) 6 commits
 + is_kept_pack(): final clean-up
 + Simplify is_kept_pack()
 + Consolidate ignore_packed logic more
 + has_sha1_kept_pack(): take "struct rev_info"
 + has_sha1_pack(): refactor "pretend these packs do not exist"
   interface
 + git-repack: resist stray environment variable

* en/maint-hash-object (Sat Feb 28 12:56:49 2009 -0700) 1 commit
 + Ensure proper setup of git_dir for git-hash-object

* el/blame-date (Fri Feb 20 14:51:11 2009 -0800) 1 commit
 - Make git blame's date output format configurable, like git log

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

* js/clone-depth-local (Fri Feb 27 00:04:06 2009 -0800) 3 commits
 . parse_options(): do not "increment" boolean
 . clone: ignore --depth when cloning locally (implicitly --local)
 . clone: do not ignore --no-local option

Jeff had a good suggestion for this series but it was tripped by
a misfeature in parse_options().

* rs/memmem (Tue Mar 3 00:19:30 2009 +0100) 2 commits
 - optimize compat/ memmem()
 - diffcore-pickaxe: use memmem()

As always with patches from Ren=C3=A9, this is already next material.

* mv/parseopt-ls-files (Tue Feb 17 15:27:11 2009 +0100) 2 commits
 - parse-opt: migrate builtin-ls-files.
 - Turn the flags in struct dir_struct into a single variable

* jk/sane-relative-time (Tue Feb 24 00:42:16 2009 -0500) 1 commit
 + never fallback relative times to absolute

* tv/rebase-stat (Sun Mar 1 22:28:28 2009 +0100) 2 commits
 - git-pull: Allow --stat and --no-stat to be used with --rebase
 - git-rebase: Add --stat and --no-stat for producing diffstat on
   rebase

----------------------------------------------------------------
[Discarded]

* jc/fsck (Fri Jan 30 02:33:47 2009 -0800) 4 commits
 - fsck: three levels of validation
 - verify-pack: add --quick
 - verify_pack(): allow a quicker verification for a pack with
   version 2 idx
 - pack-check.c: minor formatting fix to match coding style

J6t has a good point that if this had any value then medium level shoul=
d
replace the default.  I am tempted to actually dropping this as a faile=
d
experiment.

* js/remote-set-head (Sat Feb 14 05:30:30 2009 -0500) 5 commits
 - builtin-remote: better handling of multiple remote HEADs
 - builtin-remote: add set-head subcommand
 - builtin-remote: teach show to display remote HEAD
 - builtin-remote: move duplicated cleanup code its own function
 - builtin-clone: move locate_head() to remote.c so it can be re-used

* jk/head-lookup (Sun Feb 15 01:18:18 2009 -0500) 5 commits
 - remote: use exact HEAD lookup if it is available
 - remote: refactor guess_remote_head
 - refactor find_refs_by_name to accept const list
 - add basic http clone/fetch tests
 - test scripts: refactor start_httpd helper

These two are now consolidated into Jay's remove-improvements series
listed above.

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* gb/gitweb-base (Sun Feb 15 10:18:36 2009 +0100) 1 commit
 - gitweb: fix wrong base URL when non-root DirectoryIndex

* ns/stash-keep (Thu Feb 12 06:25:14 2009 +0900) 1 commit
 - stash: --keep option just saves

Do we want to keep this one?

* lh/submodule-tree-traversal (Sun Jan 25 01:52:06 2009 +0100) 1 commit
 - archive.c: add support for --submodules[=3D(all|checkedout)]

Discussion stalled on the submodule selection criteria.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

This gives Porcelains (like gitweb) the information on the commit _befo=
re_
the one that the final blame is laid on, which should save them one
rev-parse to dig further.  The line number in the "previous" informatio=
n
may need refining, and sanity checking code for reference counting may
need to be resurrected before this can move forward.

I thought recent tig discussion may blow new life into it, but is this
unneeded?  If so I'd rather revert it (or discard after 1.6.2).

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
convinced it is doing the right thing in the connectivity traverser. =20
Independent review sorely needed.

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

Design discussion between Jakub and Sebastien seems to have stalled, bu=
t
Jakub seems to be taking this over.

----------------------------------------------------------------
[Reverted]

* mh/unify-color (Fri Jan 23 01:25:23 2009 -0800) 3 commits
 ? Revert previous two commits
 ? move the color variables to color.c
 ? handle color.ui at a central place

This broke git-format-patch badly.

* js/rebase-error-a-bit-more-verbose (Sun Feb 8 21:22:18 2009 -0800) 2 =
commits
 ? Revert "rebase: explain why when the HEAD could not be detached"
 ? rebase: explain why when the HEAD could not be detached

This turned out to be unnecessary.

* rs/maint-1.6.0-windows-ceiling (Sat Feb 7 12:40:40 2009 -0800) 2 comm=
its
 ? Revert "fix t1504 on Windows"
 ? fix t1504 on Windows

I'm giving a fresh start to J6t's series which contains this.

* lh/reverted-submodule-tree-traversal (Sun Jan 25 18:39:55 2009 -0800)=
 4 commits
 ? Revert round #1 of the series
 ? builtin-ls-tree: enable traversal of submodules
 ? archive.c: enable traversal of submodules
 ? tree.c: add support for traversal of submodules

I'm giving a fresh start to Lars's second iteration.

----------------------------------------------------------------
[Will merge to 'next' soon]

* js/send-email (Mon Mar 2 23:52:18 2009 -0500) 5 commits
 - send-email: add --confirm option and configuration setting
 + send-email: don't create temporary compose file until it is needed
 + send-email: --suppress-cc improvements
 + send-email: handle multiple Cc addresses when reading mbox message
 + send-email: allow send-email to run outside a repo

----------------------------------------------------------------
[Ready for 'master' after 1.6.2]

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

* kb/checkout-optim (Mon Feb 23 19:02:57 2009 +0100) 14 commits
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

----------------------------------------------------------------
[Actively cooking]

* tr/gcov (Thu Feb 19 12:13:42 2009 +0100) 8 commits
 - Test git-patch-id
 - Test rev-list --parents/--children
 - Test log --decorate
 - Test fsck a bit harder
 - Test log --graph
 - Test diff --dirstat functionality
 - Test that diff can read from stdin
 - Support coverage testing with GCC/gcov

* js/notes (Sat Feb 14 21:23:25 2009 +0100) 13 commits
 - notes: refuse to edit notes outside refs/notes/
 - t3301: use test_must_fail instead of !
 - t3301: fix confusing quoting in test for valid notes ref
 - notes: use GIT_EDITOR and core.editor over VISUAL/EDITOR
 - notes: only clean up message file when editing
 - handle empty notes gracefully
 + git notes show: test empty notes
 + git-notes: fix printing of multi-line notes
 + notes: fix core.notesRef documentation
 + Add an expensive test for git-notes
 + Speed up git notes lookup
 + Add a script to edit/inspect notes
 + Introduce commit notes

Earlier part was merged to master and then reverted there.  Will be
rebased 1.6.2 to keep my sanity.

* fc/config-editor (Sat Feb 21 02:48:54 2009 +0200) 3 commits
 + git config: trivial cleanup for editor action
 + git config: codestyle cleanups
 + config: Add new option to open an editor.

Rerolled and looked sane.

----------------------------------------------------------------
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 co=
mmit
 - Refuse updating the current branch in a non-bare repository via
   push

This is for 1.7.0.

* jc/commit-assume-also-during-merge (Thu Jan 22 22:21:49 2009 -0800) 3=
 commits
 - git commit: pathspec without -i/-o implies -i semantics during a
   merge
 - builtin-commit: shorten eye-sore overlong lines
 - Add "partial commit" tests during a conflicted merge

This was only meant as a weatherballoon to help facilitate discussion.

* jc/merge-convert (Mon Jan 26 16:45:01 2009 -0800) 1 commit
 - git-merge-file: allow converting the results for the work tree

This is a feature waiting for a user.  I do not need it in 1.6.2

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
