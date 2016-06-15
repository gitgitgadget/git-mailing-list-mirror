From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2009, #04; Sun, 15)
Date: Sun, 15 Feb 2009 02:40:19 -0800
Message-ID: <7v1vu0nfu4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 11:41:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYeRh-0006Ip-IU
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 11:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbZBOKk3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Feb 2009 05:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbZBOKk3
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 05:40:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbZBOKk0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Feb 2009 05:40:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CC6799D2D;
	Sun, 15 Feb 2009 05:40:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D8FA299D2C; Sun,
 15 Feb 2009 05:40:22 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0DE087B2-FB4D-11DD-80A0-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109989>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their nam=
es.

The master branch will be tagged as 1.6.2-rc1 by the end of the long
weekend.

Traditionally, rc freeze, especially post -rc1, meant that I stop payin=
g
attention to whatever topic that did not graduate to 'master', and not
queuing further updates to 'next' to encourage people to concentrate on
'master' bugfixes by discouraging them from tinkering the topics that
won't be in the next release.

I do not think that approach has worked well in practice, so let's try
something slightly different.

I'll try to leave 'next' open during this freeze, but the new topics an=
d
topics that hasn't cooked to maturity by -rc1 will not be in 1.6.2 (tha=
t
is what a freeze means).

----------------------------------------------------------------
[New Topics]

* jw/imap-preformatted-html (Thu Feb 12 08:58:12 2009 -0600) 1 commit
 - imap.preformattedHTML to tell Thunderbird to send non-flowed text

The patch text should be identical to Jeremy's "Virtual Patch", except
that the configuration variable was renamed per list discussion.

* jw/format-patch-attach (Thu Feb 12 09:51:55 2009 -0600) 1 commit
 - Enable setting attach as the default in .gitconfig for git-format-
   patch.

* sr/force-rebase (Fri Feb 13 23:48:01 2009 +0100) 1 commit
 - Teach rebase to rebase even if upstream is up to date

* fg/exclude-bq (Tue Feb 10 15:20:17 2009 +0100) 1 commit
 - Support "\" in non-wildcard exclusion entries

* fc/config-editor (Sat Feb 7 23:53:00 2009 +0200) 1 commit
 - config: Add new option to open an editor.

* dm/add-i-edit-abort (Thu Feb 12 00:19:41 2009 -0500) 1 commit
 - add -i: revisit hunk on editor failure

* tp/completion (Wed Feb 11 13:03:26 2009 -0500) 4 commits
 - completion: More fixes to prevent unbound variable errors
 - completion: Better __git_ps1 support when not in working directory
 - completion: Use consistent if [...] convention, not "test"
 - completion: For consistency, change "git rev-parse" to __gitdir
   calls

* js/branch-symref (Fri Feb 13 04:40:18 2009 -0500) 1 commit
 - builtin-branch: improve output when displaying remote branches

* js/send-email (Sat Feb 14 23:32:15 2009 -0500) 3 commits
 - send-email: --suppress-cc improvements
 - send-email: handle multiple Cc addresses when reading mbox message
 - send-email: allow send-email to run outside a repo

* al/ansi-color (Fri Feb 13 22:53:41 2009 +0100) 2 commits
 - builtin-branch.c: Rename branch category color names
 - Clean up use of ANSI color sequences

All of the above are probably ready for 'next'.

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

Builds on top of Jay Soffian's js/remote-set-head topic.

* sg/rerere-cleanup (Sat Feb 14 23:21:04 2009 +0100) 1 commit
 - rerere: remove duplicated functions

* ns/stash-keep (Thu Feb 12 06:25:14 2009 +0900) 1 commit
 - stash: --keep option just saves

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

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

Recent tig discussion may blow new life into it.  Let's see.

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
I'd like to keep this out of 1.6.2.

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

Design discussion between Jakub and Sebastien seems to have stalled.

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
[Actively cooking]

* kb/checkout-optim (Mon Feb 9 21:54:53 2009 +0100) 9 commits
 - lstat_cache(): print a warning if doing ping-pong between cache
   types
 - show_patch_diff(): remove a call to fstat()
 - write_entry(): use fstat() instead of lstat() when file is open
 - write_entry(): cleanup of some duplicated code
 - create_directories(): remove some memcpy() and strchr() calls
 - unlink_entry(): introduce schedule_dir_for_removal()
 - lstat_cache(): swap func(length, string) into func(string, length)
 - lstat_cache(): generalise longest_match_lstat_cache()
 - lstat_cache(): small cleanup and optimisation

Should be ready for 'next'.

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
[Graduated to "master"]

* jn/gitweb-committag (Fri Feb 6 10:12:41 2009 +0100) 1 commit
 + gitweb: Better regexp for SHA-1 committag match

* js/maint-1.6.0-path-normalize (Sat Feb 7 16:08:31 2009 +0100) 5 commi=
ts
 + Remove unused normalize_absolute_path()
 + Test and fix normalize_path_copy()
 + Fix GIT_CEILING_DIRECTORIES on Windows
 + Move sanitary_path_copy() to path.c and rename it to
   normalize_path_copy()
 + Make test-path-utils more robust against incorrect use

Replaces one from Ren=C3=A9 that was queued earlier.

* js/git-submodule-trailing-slash (Sat Feb 7 14:43:15 2009 +0100) 2 com=
mits
 + submodule: warn about non-submodules
 + Let ls-files strip trailing slashes in submodules' paths

* ms/mailmap (Thu Feb 8 15:34:31 2009 +0100) 5 commits
 + Move mailmap documentation into separate file
 + Change current mailmap usage to do matching on both name and email
   of author/committer.
 + Add map_user() and clear_mailmap() to mailmap
 + Add find_insert_index, insert_at_index and clear_func functions to
   string_list
 + Add log.mailmap as configurational option for mailmap location

* ff/submodule-no-fetch (Thu Feb 5 20:18:32 2009 -0200) 1 commit
 + submodule: add --no-fetch parameter to update command

* mc/setup-cd-p (Fri Feb 6 19:24:28 2009 -0800) 1 commit
 + git-sh-setup: Use "cd" option, not /bin/pwd, for symlinked work
   tree

----------------------------------------------------------------
[On Hold]

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

This is only meant as a weatherballoon to help facilitate discussion.

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

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 . diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 . git-am --forge: add Signed-off-by: line for the author
 . git-am: clean-up Signed-off-by: lines
 . stripspace: add --log-clean option to clean up signed-off-by:
   lines
 . stripspace: use parse_options()
 . Add "git am -s" test
 . git-am: refactor code to add signed-off-by line for the committer

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 2 commits
 . revision --simplify-merges: incremental simplification
 . revision --simplify-merges: prepare for incremental simplification
