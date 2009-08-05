From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2009, #01; Wed, 05)
Date: Wed, 05 Aug 2009 15:04:46 -0700
Message-ID: <7v8whxx6gx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 00:05:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYoc8-0006RY-1l
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 00:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbZHEWE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 18:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761AbZHEWE5
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 18:04:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53327 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbZHEWE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 18:04:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B1FE22CBF;
	Wed,  5 Aug 2009 18:04:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 380C222CBC; Wed, 
 5 Aug 2009 18:04:48 -0400 (EDT)
X-master-at: 3f55e4107f7906134df029f9a5c44864f9258110
X-next-at: 2981fa5b8f20e8ff086aceb252c0e693fa2d0c75
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 02D20954-820C-11DE-8CA2-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125005>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

After the 1.6.5 cycle, the next release will be 1.7.0, and we will push
out the planned "push safety" change.  1.7.0 would be a good time to
introduce "justifiable" changes that are not strictly backward compatible.

During 1.6.5 cycle, 'next' will hold topics meant for 1.6.5 and 1.7.0.

----------------------------------------------------------------
[New Topics]

* gb/apply-ignore-whitespace (Tue Aug 4 13:16:49 2009 +0200) 1 commit
 - git apply: option to ignore whitespace differences

* db/vcs-helper (Wed Aug 5 01:02:25 2009 -0400) 13 commits
 - Changes for new vcs-helper series
 - Add simple test cases of git-vcs-cvs functionality
 - First draft of CVS importer using the foreign-scm machinery
 - Allow helpers to request marks for fast-import
 - Allow helpers to report in "list" command that the ref is
   unchanged
 - Add support for "import" helper command
 - Add a config option for remotes to specify a foreign vcs
 - Allow programs to not depend on remotes having urls
 - Allow fetch to modify refs
 - Use a function to determine whether a remote is valid
 - git-http-fetch: not a builtin
 - Use an external program to implement fetching with curl
 - Add support for external programs for handling native fetches

This consolidates various previous rounds from Daniel and Johan.

* je/send-email-no-subject (Wed Aug 5 18:49:54 2009 +0200) 1 commit
 - send-email: confirm on empty mail subjects

* zf/maint-gitweb-acname (Sun Aug 2 09:42:24 2009 +0200) 1 commit
 - gitweb: parse_commit_text encoding fix

* jc/maint-clean-nested-dir-safety (Tue Jun 30 15:33:45 2009 -0700) 1 commit
 - clean: require double -f options to nuke nested git repository and
   work tree

* jc/shortstatus (Tue Aug 4 23:55:22 2009 -0700) 5 commits
 - shortstatus: a new command
 - status: show worktree status of conflicted paths separately
 - wt-status.c: rework the way changes to the index and work tree are
   summarized
 - diff-index: keep the original index intact
 - diff-index: report unmerged new entries

* bc/mailsplit-cr-at-eol (Tue Aug 4 22:31:59 2009 -0500) 4 commits
 - Allow mailsplit (and hence git-am) to handle mails with CRLF line-
   endings
 - builtin-mailsplit.c: remove read_line_with_nul() since it is no
   longer used
 - builtin-mailinfo,builtin-mailsplit: use strbufs
 - strbuf: add new function strbuf_getwholeline()

* jc/maint-merge-recursive-fix (Thu Jul 30 17:38:15 2009 -0700) 1 commit
 - merge-recursive: don't segfault while handling rename clashes

----------------------------------------------------------------
[Graduated to "master"]

* ne/futz-upload-pack (Wed Jun 10 01:50:18 2009 +0200) 1 commit
 + Shift object enumeration out of upload-pack

* sb/maint-pull-rebase (Sun Jul 19 09:45:16 2009 +0200) 2 commits
 + pull: support rebased upstream + fetch + pull --rebase
 + t5520-pull: Test for rebased upstream + fetch + pull --rebase

* sb/read-tree (Thu Jun 25 22:14:10 2009 -0700) 2 commits
 + read-tree: migrate to parse-options
 + read-tree: convert unhelpful usage()'s to helpful die()'s

* sb/parse-options (Tue Jul 7 22:15:41 2009 -0700) 4 commits
 + prune-packed: migrate to parse-options
 + verify-pack: migrate to parse-options
 + verify-tag: migrate to parse-options
 + write-tree: migrate to parse-options

* ns/init-mkdir (Sat Jul 25 06:59:28 2009 +0900) 1 commit
 + git init: optionally allow a directory argument

Straightforward usability change.

* mk/init-db-parse-options (Sun Jul 12 12:24:32 2009 +0200) 1 commit
 + init-db: migrate to parse-options

* jk/maint-show-tag (Sat Jul 18 06:14:37 2009 -0400) 2 commits
 + show: add space between multiple items
 + show: suppress extra newline when showing annotated tag

* jc/apply-epoch-patch (Fri Jul 10 18:38:08 2009 -0700) 1 commit
 + apply: notice creation/removal patches produced by GNU diff

----------------------------------------------------------------
[In 'next']

* js/run-command-updates (Tue Aug 4 11:28:40 2009 +0200) 7 commits
 + run-command.c: squelch a "use before assignment" warning
 + receive-pack: remove unnecessary run_status report
 + run_command: report failure to execute the program, but optionally
   don't
 + run_command: encode deadly signal number in the return value
 + run_command: report system call errors instead of returning error
   codes
 + run_command: return exit code as positive value
 + MinGW: simplify waitpid() emulation macros

Will merge soon.

* mk/grep-max-depth (Wed Jul 22 19:52:15 2009 +0200) 1 commit
 + grep: Add --max-depth option.

Will merge soon.

* cc/replace (Wed May 27 07:14:09 2009 +0200) 14 commits
 + t6050: check pushing something based on a replaced commit
 + Documentation: add documentation for "git replace"
 + Add git-replace to .gitignore
 + builtin-replace: use "usage_msg_opt" to give better error messages
 + parse-options: add new function "usage_msg_opt"
 + builtin-replace: teach "git replace" to actually replace
 + Add new "git replace" command
 + environment: add global variable to disable replacement
 + mktag: call "check_sha1_signature" with the replacement sha1
 + replace_object: add a test case
 + object: call "check_sha1_signature" with the replacement sha1
 + sha1_file: add a "read_sha1_file_repl" function
 + replace_object: add mechanism to replace objects found in
   "refs/replace/"
 + refs: add a "for_each_replace_ref" function

Does not seem to hurt normal operation without "replace".  The basic idea
should be easier and safer to use than the graft mechanism.  I haven't
tried the replacement myself, though.

* jp/symlink-dirs (Wed Jul 29 20:22:25 2009 -0700) 3 commits
 + git-checkout: be careful about untracked symlinks
 + lstat_cache: guard against full match of length of 'name'
   parameter
 + Demonstrate bugs when a directory is replaced with a symlink

James's test scripts to expose corner case bugs in the merge and branch
switching machinery, and a few fix-ups.

* jn/gitweb-blame (Sat Jul 25 00:44:10 2009 +0200) 10 commits
 + gitweb: Create links leading to 'blame_incremental' using
   JavaScript
 + gitweb: Incremental blame (proof of concept)
 + gitweb: Add optional "time to generate page" info in footer
 + gitweb: Add -partial_query option to href() subroutine
 + gitweb: Use light/dark for class names also in 'blame' view
 + gitweb: Add author initials in 'blame' view, a la "git gui blame"
 + gitweb: Mark commits with no "previous" in 'blame' view
 + gitweb: Use "previous" header of git-blame -p in 'blame' view
 + gitweb: Mark boundary commits in 'blame' view
 + gitweb: Make .error style generic

Will merge soon.

* jc/1.7.0-diff-whitespace-only-status (Sat May 23 01:15:35 2009 -0700) 2 commits
 + diff: Rename QUIET internal option to QUICK
 + diff: change semantics of "ignore whitespace" options

This changes exit code from "git diff --ignore-whitespace" and friends
when there is no actual output.  It is a backward incompatible change, but
we could argue that it is a bugfix.

* jc/1.7.0-push-safety (Mon Feb 9 00:19:46 2009 -0800) 2 commits
 + Refuse deleting the current branch via push
 + Refuse updating the current branch in a non-bare repository via
   push

----------------------------------------------------------------
[In 'pu']

* jh/notes (Wed Jul 29 04:25:26 2009 +0200) 8 commits
 - t3302-notes-index-expensive: Speed up create_repo()
 - fast-import: Add support for importing commit notes
 - First draft of notes tree parser with support for fanout subtrees
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

* cc/sequencer-rebase-i (Fri Jun 26 23:08:46 2009 +0200) 4 commits
 - rebase -i: use "git sequencer--helper --make-patch"
 - sequencer: free memory used in "make_patch" function
 - sequencer: add "make_patch" function to save a patch
 - sequencer: add "builtin-sequencer--helper.c"

* jc/mailinfo-remove-brackets (Wed Jul 15 15:31:12 2009 -0700) 1 commit
 - mailinfo: -b option keeps [bracketed] strings that is not a
   [PATCH] marker

* tr/reset-checkout-patch (Tue Jul 28 23:20:12 2009 +0200) 8 commits
 - DWIM 'git stash save -p' for 'git stash -p'
 - Merge branch 'js/stash-dwim' into tr/reset-checkout-patch
 - Make 'git stash -k' a short form for 'git stash save --keep-index'
 - Implement 'git stash save --patch'
 - Implement 'git checkout --patch'
 - Implement 'git reset --patch'
 - builtin-add: refactor the meat of interactive_add()
 - git-apply--interactive: Refactor patch mode code

* js/stash-dwim (Mon Jul 27 20:37:10 2009 +0200) 1 commit
 - Make 'git stash -k' a short form for 'git stash save --keep-index'

* jc/log-tz (Tue Mar 3 00:45:37 2009 -0800) 1 commit
 - Allow --date=local --date=other-format to work as expected
