From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sun, 10 Feb 2008 02:48:23 -0800
Message-ID: <7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
	<7vodavd9qw.fsf@gitster.siamese.dyndns.org>
	<7vbq6tset4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 11:49:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO9ks-0001yJ-4L
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 11:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758355AbYBJKsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 05:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757951AbYBJKsl
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 05:48:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202AbYBJKsj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 05:48:39 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EAD491455;
	Sun, 10 Feb 2008 05:48:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D30931454;
	Sun, 10 Feb 2008 05:48:35 -0500 (EST)
In-Reply-To: <7vbq6tset4.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 06 Feb 2008 18:03:51 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73332>

Here are the topics that have been kept out of 'master'.
Commits prefixed with '-' are only in 'pu' while commits
prefixed with '+' are in 'next'.  Now I am pushing 1.5.4.1 out,
mature topics will start moving to 'master'.

The topics list the commits in reverse chronological order.

My wish is to have small but short release cycle for 1.5.5 and
leave bigger ones cooking for 1.6.0.

----------------------------------------------------------------
[New Topics]

* 00/config-null (Fri Feb 8 15:26:18 2008 +0100) 2 commits
 - builtin-gc.c: guard config parser from value=3DNULL
 - archive-tar.c: guard config parser from value=3DNULL

The "RFH from Janitors" topic.

* br/gitweb (Fri Feb 8 14:38:04 2008 -0200) 1 commit
 - gitweb: Use the config file to set repository owner's name.

Looked Ok.

* lt/revision-walker (Sat Feb 9 14:02:07 2008 -0800) 1 commit
 - Add "--show-all" revision walker flag for debugging

* mc/prefix (Sat Feb 9 15:40:19 2008 +0100) 1 commit
 - Avoid a useless prefix lookup in strbuf_expand()

* db/checkout (Sun Feb 10 01:27:00 2008 -0800) 21 commits
 - (PARK)
 - Build in checkout
 - Move code to clean up after a branch change to branch.c
 - Library function to check for unmerged index entries
 - Use diff -u instead of diff in t7201
 - Move create_branch into a library file
 - Build-in merge-recursive
 - Add "skip_unmerged" option to unpack_trees.
 - Discard "deleted" cache entries after using them to update the
   working tree
 - Send unpack-trees debugging output to stderr
 - Add flag to make unpack_trees() not print errors.
 - Allow callers of unpack_trees() to handle failure

This is building on top of Linus's change to in-core index
structure, which will be in 'master' soon.

----------------------------------------------------------------
[Will merge to 'master' soon]

* ph/describe-match (Mon Dec 24 12:18:22 2007 +0100) 2 commits
 + git-name-rev: add a --(no-)undefined option.
 + git-describe: Add a --match option to limit considered tags.

* lt/in-core-index (Tue Jan 22 23:01:13 2008 -0800) 9 commits
 + lazy index hashing
 + Create pathname-based hash-table lookup into index
 + read-cache.c: introduce is_racy_timestamp() helper
 + read-cache.c: fix a couple more CE_REMOVE conversion
 + Also use unpack_trees() in do_diff_cache()
 + Make run_diff_index() use unpack_trees(), not read_tree()
 + Avoid running lstat(2) on the same cache entry.
 + index: be careful when handling long names
 + Make on-disk index representation separate from in-core one

This is about reducing number of lstat(2) calls during complex
operations, and optimizing "do we have this in the index"
queries.  Most likely this will be the first series to be merged
to 'master'.

* jc/error-message-in-cherry-pick (Thu Jan 10 22:49:35 2008 -0800) 1 co=
mmit
 + Make error messages from cherry-pick/revert more sensible

Bj=C3=B6rn Steinbrink reported and then tested this.

* db/send-email-omit-cc (Tue Dec 25 19:56:29 2007 -0800) 1 commit
 + git-send-email: Generalize auto-cc recipient mechanism.

This came after 1.5.4-rc cycle started and was placed on hold.
I do not recall if there was any objection to it.

* mw/send-email (Sun Feb 3 19:53:58 2008 -0500) 3 commits
 + git-send-email: Better handling of EOF
 + git-send-email: SIG{TERM,INT} handlers
 + git-send-email: ssh/login style password requests

* db/no-separate-ls-remote-connection (Sun Feb 10 03:06:57 2008 +0000) =
2 commits
 + Fix "git clone" for git:// protocol
 + Reduce the number of connects when fetching

----------------------------------------------------------------
[Actively Cooking]

* jc/setup (Sun Feb 3 23:59:17 2008 -0800) 4 commits
 + builtin-mv: minimum fix to avoid losing files
 + git-add: adjust to the get_pathspec() changes.
 + Make blame accept absolute paths
 + setup: sanitize absolute and funny paths in get_pathspec()

* jc/submittingpatches (Sun Feb 3 17:02:28 2008 -0800) 3 commits
 + Documentation/SubmittingPatches: What's Acked-by and Tested-by?
 + Documentation/SubmittingPatches: discuss first then submit
 + Documentation/SubmittingPatches: Instruct how to use [PATCH]
   Subject header

These I think are sensible but they did not see much discussion,
so they are parked here for now.

* sp/safecrlf (Wed Feb 6 12:25:58 2008 +0100) 1 commit
 + safecrlf: Add mechanism to warn about irreversible crlf
   conversions

* jk/noetcconfig (Wed Feb 6 05:11:53 2008 -0500) 2 commits
 + fix config reading in tests
 + allow suppressing of global and system config

* pb/prepare-commit-msg (Tue Feb 5 08:04:18 2008 +0100) 4 commits
 + git-commit: add a prepare-commit-msg hook
 + git-commit: Refactor creation of log message.
 + git-commit: set GIT_EDITOR=3D: if editor will not be launched
 + git-commit: support variable number of hook arguments

* jc/gitignore-ends-with-slash (Thu Jan 31 20:23:25 2008 -0800) 2 commi=
ts
 + gitignore: lazily find dtype
 + gitignore(5): Allow "foo/" in ignore list to match directory "foo"

This is redone after we had discussion on the list to properly
make "foo/" match only with directories and "foo" with both
files and directories without unnecessary lstat(2) calls.

* jc/apply-whitespace (Tue Jan 15 00:59:05 2008 -0800) 13 commits
 + core.whitespace: cr-at-eol
 + git-apply --whitespace=3Dfix: fix whitespace fuzz introduced by
   previous run
 + builtin-apply.c: pass ws_rule down to match_fragment()
 + builtin-apply.c: move copy_wsfix() function a bit higher.
 + builtin-apply.c: do not feed copy_wsfix() leading '+'
 + builtin-apply.c: simplify calling site to apply_line()
 + builtin-apply.c: clean-up apply_one_fragment()
 + builtin-apply.c: mark common context lines in lineinfo structure.
 + builtin-apply.c: optimize match_beginning/end processing a bit.
 + builtin-apply.c: make it more line oriented
 + builtin-apply.c: push match-beginning/end logic down
 + builtin-apply.c: restructure "offset" matching
 + builtin-apply.c: refactor small part that matches context

* cc/browser (Sat Feb 9 07:11:01 2008 +0100) 8 commits
 + web--browse: Add a few quotes in 'init_browser_path'.
 + Documentation: instaweb: add 'git-web--browse' information.
 + Adjust .gitignore for 5884f1(Rename 'git-help--browse.sh'...)
 + git-web--browse: do not start the browser with nohup
 + instaweb: use 'git-web--browse' to launch browser.
 + Rename 'git-help--browse.sh' to 'git-web--browse.sh'.
 + help--browse: add '--config' option to check a config option for a
   browser.
 + help: make 'git-help--browse' usable outside 'git-help'.

Christian Couder consolidated the logic to pick user's favorite
browser between instaweb and help.

* bd/qsort (Tue Feb 5 15:10:44 2008 -0600) 1 commit
 + compat: Add simplified merge sort implementation from glibc

More reasonable qsort(3) than Microsoft by Brian Downing.

----------------------------------------------------------------
[On Hold]

* js/reflog-delete (Fri Jan 4 19:11:37 2008 -0600) 2 commits
 + builtin-reflog.c: fix typo that accesses an unset variable
 + Teach "git reflog" a subcommand to delete single entries

There was a patch that uses this to implement "git-stash drop",
which I didn't queue, as the command name and the UI was
undecided yet.

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.  I am not sure if we should merge this to
'next' before 1.5.5.  Most active people will be on 'next' and
if we have this there, the resulting 1.5.5 release might end up
having issues that come from differences this one introduces.

* bf/remote-head (Sun Dec 23 20:52:32 2007 -0500) 1 commit
 - git-remote: make add -f guess HEAD, as clone does

I might have carefully looked at this in the past but I do not
recall if there were issues.  Need re-reviewing and help from
the list is appreciated.

* ab/pserver (Fri Dec 14 04:08:51 2007 +0000) 1 commit
 - Authentication support for pserver

This needs careful security audit and a fix to its password
database format.  Plaintext in .git/config is not acceptable.

* jc/cherry-pick (Mon Dec 24 00:51:01 2007 -0800) 4 commits
 - PARK: Start using replay-tree merge in cherry-pick
 - revert/cherry-pick: start refactoring call to merge_recursive
 - expose a helper function peel_to_type().
 - merge-recursive: split low-level merge functions out.

Meant to avoid merge_recursive() during cherry-pick and revert,
so that D/F conflicts can be redone right, but I got busy and
this has unfortunately stalled.

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, but git-shell may need to be updated.

* jc/diff-relative (Thu Dec 6 09:48:32 2007 -0800) 1 commit
 - Make "diff" Porcelain output paths as relative to subdirectory.

* jc/git-symref (Tue Dec 11 16:42:46 2007 -0800) 1 commit
 - PARK: show-symref protocol extension.

* jc/sha1-lookup (Sun Dec 30 03:13:27 2007 -0800) 2 commits
 - sha1-lookup: make selection of 'middle' less aggressive
 - sha1-lookup: more memory efficient search in sorted list of SHA-1

Micro-optimization whose real world benefit is not proven.

* jc/rename (Tue Jan 29 20:54:56 2008 -0800) 1 commit
 - Optimize rename detection for a huge diff

Micro-optimization whose real world benefit is not proven.
