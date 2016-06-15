From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2009, #02; Sun, 26)
Date: Sun, 26 Jul 2009 01:47:14 -0700
Message-ID: <7viqhfrfu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 26 10:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUzOD-0002LJ-0u
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 10:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbZGZIrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 04:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbZGZIrU
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 04:47:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbZGZIrS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 04:47:18 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F3B01406B;
	Sun, 26 Jul 2009 04:47:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4E5B91406A; Sun,
 26 Jul 2009 04:47:16 -0400 (EDT)
X-master-at: d8f7be2ebcb7e3ec40269080a9ab9a28bc06ba17
X-next-at: 2b05f9bd0a9944bbaab9f24d305932a57e4735d4
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ECE0075C-79C0-11DE-98CA-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124111>

These topics in 'next' (ones prefixed with '+') and 'pu' (ones prefixed
with '.') will not be in 1.6.4 final, and are subject to be rewound once
1.6.4 final happens.

We have quite a few solid topics in 'next', so hopefully the next cycle
would be shorter than usual.  I'd propose to call it 1.6.5, and then make
the one after that 1.7.0, which means that during the 1.6.5 cycle, 'next'
will have the two incompatible "push" (actually, receive-pack) changes
hitherto kept on hold in 'pu'.

----------------------------------------------------------------
[New Topics]

* jk/show-tag (Sat Jul 18 06:14:37 2009 -0400) 2 commits
 + show: add space between multiple items
 + show: suppress extra newline when showing annotated tag

Didn't look bad at all, but is not pressing either.

* sb/parse-options (Tue Jul 7 22:15:41 2009 -0700) 4 commits
 + prune-packed: migrate to parse-options
 + verify-pack: migrate to parse-options
 + verify-tag: migrate to parse-options
 + write-tree: migrate to parse-options

* mk/grep-max-depth (Wed Jul 22 19:52:15 2009 +0200) 1 commit
 + grep: Add --max-depth option.

* jn/gitweb-blame (Sat Jul 25 00:44:10 2009 +0200) 10 commits
 - gitweb: Create links leading to 'blame_incremental' using
   JavaScript
 - gitweb: Incremental blame (proof of concept)
 - gitweb: Add optional "time to generate page" info in footer
 - gitweb: Add -partial_query option to href() subroutine
 - gitweb: Use light/dark for class names also in 'blame' view
 - gitweb: Add author initials in 'blame' view, a la "git gui blame"
 - gitweb: Mark commits with no "previous" in 'blame' view
 - gitweb: Use "previous" header of git-blame -p in 'blame' view
 - gitweb: Mark boundary commits in 'blame' view
 - gitweb: Make .error style generic

Still in flux/rfc.

* ns/init-mkdir (Sat Jul 25 06:59:28 2009 +0900) 1 commit
 + git init: optionally allow a directory argument

Didn't look bad, but is not pressing either.

* jc/apply-epoch-patch (Fri Jul 10 18:38:08 2009 -0700) 1 commit
 + apply: notice creation/removal patches produced by GNU diff

* sb/pull-rebase (Sun Jul 19 09:45:16 2009 +0200) 2 commits
 + pull: support rebased upstream + fetch + pull --rebase
 + t5520-pull: Test for rebased upstream + fetch + pull --rebase

* db/transport-shim (Sat Jul 25 13:51:40 2009 -0400) 3 commits
 - git-http-fetch: not a builtin
 - Use an external program to implement fetching with curl
 - Add support for external programs for handling native fetches

Interesting as a concept.  I saw its ls-remote segfault on me, though.
Hopefully will mature by 1.6.5 final.

* pb/tracking (Thu Jul 16 16:26:15 2009 -0500) 7 commits
 + branch.c: if remote is not config'd for branch, don't try delete
   push config
 + branch, checkout: introduce autosetuppush
 + move deletion of merge configuration to branch.c
 + remote: add per-remote autosetupmerge and autosetuprebase
   configuration
 + introduce a struct tracking_config
 + branch: install_branch_config and struct tracking refactoring
 + config: allow false and true values for branch.autosetuprebase

After some discussion, I suspect we may want to rewind this out of 'next'
and start over with a fresh design.

* mk/init-db-parse-options (Sun Jul 12 12:24:32 2009 +0200) 1 commit
 + init-db: migrate to parse-options

* tr/reset-checkout-patch (Sat Jul 25 23:29:34 2009 +0200) 5 commits
 - Implement 'git stash save --patch'
 - Implement 'git checkout --patch'
 - Implement 'git reset --patch'
 - builtin-add: refactor the meat of interactive_add()
 - git-apply--interactive: Refactor patch mode code

Still in flux/rfc.

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* gp/maint-rebase-p-onto (Wed Jul 22 12:38:58 2009 -0400) 1 commit
 . Fix rebase -p --onto

I'd say we should take this even if it means Dscho needs his rebase -p
rewrite.  It is not very pressing, so perhaps do so immediately after
1.6.4 final.

* jh/notes (Sat May 16 13:44:17 2009 +0200) 5 commits
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

Dscho asked about the performance implications of this; I do not think I
saw any progress on that yet...

Will drop after 1.6.4 unless any further progress is seen.

* ar/maint-1.6.2-merge-recursive-d-f (Mon May 11 21:25:36 2009 +0200) 2 commits
 - Fix for a merge where a branch has an F->D transition
 - Add a reminder test case for a merge with F/D transition

Although the reported breakage is covered with the patch, Alex feels the
solution unsatisfactory. Cleaning up D/F conflict handling in merge-recursive
may be long overdue but seems to be a hard problem.

* ps/blame (Thu Mar 12 21:30:03 2009 +1100) 1 commit
 - blame.c: start libifying the blame infrastructure

A few minor point remains in this initial one.

Will drop after 1.6.4 unless any further progress is seen.

* jc/log-tz (Tue Mar 3 00:45:37 2009 -0800) 1 commit
 - Allow --date=local --date=other-format to work as expected

The one I posted had a few corner-case bugs that was caught with the test
suite; this one has them fixed.  People did not like the UI so it is kept
out of 'next'

Will drop after 1.6.4 unless any further progress is seen.

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

Will drop after 1.6.4 unless any further progress is seen.

* db/foreign-scm (Tue Mar 24 23:04:12 2009 -0400) 3 commits
 - Add option for using a foreign VCS
 - Document details of transport function APIs
 - Allow late reporting of fetched hashes

I have a feeling that the recent transport-shim series from the same
author could supersede this one.

* hv/cvsps-tests (Sun Apr 5 01:40:50 2009 -0700) 8 commits
 - t/t9600: remove exit after test_done
 - cvsimport: extend testcase about patchset order to contain
   branches
 - cvsimport: add test illustrating a bug in cvsps
 - Add a test of "git cvsimport"'s handling of tags and branches
 - Add some tests of git-cvsimport's handling of vendor branches
 - Test contents of entire cvsimported "master" tree contents
 - Use CVS's -f option if available (ignore user's ~/.cvsrc file)
 - Start a library for cvsimport-related tests

----------------------------------------------------------------
[Not actively cooking]

* js/run-command-updates (Sat Jul 4 21:26:43 2009 +0200) 6 commits
 + receive-pack: remove unnecessary run_status report
 + run_command: report failure to execute the program, but optionally
   don't
 + run_command: encode deadly signal number in the return value
 + run_command: report system call errors instead of returning error
   codes
 + run_command: return exit code as positive value
 + MinGW: simplify waitpid() emulation macros

Will merge after 1.6.4

* cc/sequencer-rebase-i (Fri Jun 26 23:08:46 2009 +0200) 4 commits
 - rebase -i: use "git sequencer--helper --make-patch"
 - sequencer: free memory used in "make_patch" function
 - sequencer: add "make_patch" function to save a patch
 - sequencer: add "builtin-sequencer--helper.c"

* en/fast-export (Thu Jun 25 22:48:33 2009 -0600) 7 commits
 + fast-export: Document the fact that git-rev-list arguments are
   accepted
 + Add new fast-export testcases
 + fast-export: Add a --tag-of-filtered-object option for newly
   dangling tags
 + fast-export: Do parent rewriting to avoid dropping relevant
   commits
 + fast-export: Make sure we show actual ref names instead of
   "(null)"
 + fast-export: Omit tags that tag trees
 + fast-export: Set revs.topo_order before calling setup_revisions

Shawn?  Dscho?

* jc/diff-whitespace-only-status (Sat May 23 01:15:35 2009 -0700) 2 commits
 + diff: Rename QUIET internal option to QUICK
 + diff: change semantics of "ignore whitespace" options

Possibly merge during 1.6.5, or 1.7.0 since this is a semantics change.

* sb/read-tree (Thu Jun 25 22:14:10 2009 -0700) 2 commits
 + read-tree: migrate to parse-options
 + read-tree: convert unhelpful usage()'s to helpful die()'s

Will merge after 1.6.4

* ne/futz-upload-pack (Wed Jun 10 01:50:18 2009 +0200) 1 commit
 + Shift object enumeration out of upload-pack

Will merge after 1.6.4

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

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

These are for 1.7.0, but the messages when they trigger together may need
to be rethought.  Will be kept in 'next' during 1.6.5 cycle.

----------------------------------------------------------------
[Dropped]

* ae/maint-mailinfo-rm-only-one-patch-marker (Mon Jun 29 11:55:51 2009 +0200) 1 commit
 - mailinfo: Remove only one set of square brackets

* lt/read-directory (Fri May 15 12:01:29 2009 -0700) 3 commits
 . Add initial support for pathname conversion to UTF-8
 . read_directory(): infrastructure for pathname character set
   conversion
 . Add 'fill_directory()' helper function for directory traversal

It appears that we may want to settle with a MacOS X specific conversion,
if somebody really cares enough.
