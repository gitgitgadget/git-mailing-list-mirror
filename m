From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Mon, 06 Jul 2009 11:32:47 -0700
Message-ID: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 20:32:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNszq-0003HK-Bu
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 20:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbZGFScr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 14:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbZGFScq
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 14:32:46 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58525 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbZGFScp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 14:32:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090706183247.MPTU17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 6 Jul 2009 14:32:47 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id CiYn1c00H4aMwMQ04iYnyQ; Mon, 06 Jul 2009 14:32:47 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=1QqTfA6OIucA:10 a=DVJC8n9COtcj36KGD9wA:9
 a=7Gex02inyplOEmwsKroA:7 a=hXEd1RD3WOZ9yhIAiQOudoFQYJ8A:4
 a=M1sY_wiqKDYwmoFu:21 a=EseqfVbt-ICc2aho:21
X-CM-Score: 0.00
X-master-at: f581de1b7b9d17c83b188bf8ffe536fb8a9dd2a4
X-next-at: 8586bb07b181c75e65a39d88128e40a1c3e88e2c
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122793>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

It has been relatively quiet for the past few weeks.  The 'next' branch is
getting quite thin, and it would be a good time to declare -rc0.  I'll do
so by my Wednesday.

----------------------------------------------------------------
[New Topics]

* ld/push-porcelain-output-format (Mon Jun 22 21:10:01 2009 -0400) 1 commit
 + add --porcelain option to git-push

* js/run-command-updates (Sat Jul 4 21:26:43 2009 +0200) 7 commits
 - receive-pack: remove unnecessary run_status report
 - run_command: report failure to execute the program, but optionally
   don't
 - run_command: encode deadly signal number in the return value
 - run_command: report system call errors instead of returning error
   codes
 - run_command: return exit code as positive value
 - MinGW: simplify waitpid() emulation macros
 - MinGW: truncate exit()'s argument to lowest 8 bits

A few replacement/squash updates came in before it hit 'pu'; this should
be the latest version.

* cc/sequencer-rebase-i (Fri Jun 26 23:08:46 2009 +0200) 4 commits
 - rebase -i: use "git sequencer--helper --make-patch"
 - sequencer: free memory used in "make_patch" function
 - sequencer: add "make_patch" function to save a patch
 - sequencer: add "builtin-sequencer--helper.c"

* ae/maint-mailinfo-rm-only-one-patch-marker (Mon Jun 29 11:55:51 2009 +0200) 1 commit
 - mailinfo: Remove only one set of square brackets

The change needed to the test vector shows the extent of the damage this
change may cause in the real world.  A handcrafted "Subject: [area] [PATCH] title"
will be turned into "[PATCH] title".

* rs/grep-p (Thu Jul 2 00:06:34 2009 +0200) 7 commits
 + grep: simplify -p output
 + grep -p: support user defined regular expressions
 + grep: add option -p/--show-function
 + grep: handle pre context lines on demand
 + grep: print context hunk marks between files
 + grep: move context hunk mark handling into show_line()
 + userdiff: add xdiff_clear_find_func()

----------------------------------------------------------------
[Graduated to "master"]

* cf/maint-remote-uploadpack-useconfig-fix (Thu Jun 25 17:21:35 2009 -0400) 1 commit
 + git-remote: fix missing .uploadpack usage for show command

* sb/show-ref-parse-options (Sat Jun 20 21:40:46 2009 -0700) 1 commit
 + show-ref: migrate to parse-options

* ne/maint-1.6.0-diff-tree-t-r-show-directory (Sat Jun 13 17:06:09 2009 -0700) 1 commit
 + diff-tree -r -t: include added/removed directories in the output

This changes the output from "diff-tree -r -t"; it brings more consistency
to it, but it is a change and could break scripts.

* uk/rev-parse-parse-opt (Sun Jun 14 01:58:43 2009 +0200) 2 commits
 + parse-opt: make PARSE_OPT_STOP_AT_NON_OPTION available to git rev-
   parse
 + more tests for git rev-parse --parse-opt

* js/daemon-log (Sun Jun 21 23:16:09 2009 +0200) 3 commits
 + receive-pack: do not send error details to the client
 + upload-pack: squelch progress indicator if client cannot see it
 + daemon: send stderr of service programs to the syslog

* sb/quiet-porcelains (Wed Jun 17 18:07:37 2009 -0700) 6 commits
 + stash: teach quiet option
 + am, rebase: teach quiet option
 + submodule, repack: migrate to git-sh-setup's say()
 + git-sh-setup: introduce say() for quiet options
 + am: suppress apply errors when using 3-way
 + t4150: test applying with a newline in subject

* jk/use-our-regexp (Fri Jun 19 10:10:39 2009 -0500) 3 commits
 + Makefile: Solaris needs HAVE_ALLOCA_H for alloca()
 + Makefile: use compat regex on Solaris
 + Makefile: refactor regex compat support

* cb/maint-fetch-refspec-wo-dst (Wed Jun 17 15:38:36 2009 +0200) 1 commit
 - fetch: do not create ref from empty name

* cc/bisect (Sat Jun 13 13:11:02 2009 +0200) 2 commits
 + Documentation: remove warning saying that "git bisect skip" may
   slow bisection
 + bisect: use a PRNG with a bias when skipping away from untestable
   commits

* tr/die_errno (Sat Jun 27 17:58:47 2009 +0200) 4 commits
 - Use die_errno() instead of die() when checking syscalls
 - Convert existing die(..., strerror(errno)) to die_errno()
 - die_errno(): double % in strerror() output just in case
 - Introduce die_errno() that appends strerror(errno) to die()

I didn't check the individual conversion from die() to die_errno()
in this latest round; comments?

* gb/am-foreign (Wed May 27 11:25:19 2009 +0200) 4 commits
 - git-am: refactor 'cleaning up and aborting'
 - git-am foreign patch support: StGIT support
 - git-am foreign patch support: autodetect some patch formats
 - git-am foreign patch support: introduce patch_format

Will be in 'next' shortly.

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* ml/http (Wed May 27 23:16:03 2009 -0400) 2 commits
 - http.c: add http.sslCertPasswordProtected option
 - http.c: prompt for SSL client certificate password

I've rewritten these two to (1) move the #ifdef out of the main codepath,
and (2) use configuration/environment to make the misfeature of always
asking for a passphrase even a key/cert is unencrypted optional.  I tried
to be careful but extra sets of eyeballs would be nice to check the result.

Nobody seems to be jumping up-and-down asking for this or helping to push
this forward.  Perhaps it's time to drop it?

* jh/notes (Sat May 16 13:44:17 2009 +0200) 5 commits
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

Dscho asked about the performance implications of this; I do not think I
saw any progress on that yet...

* lt/read-directory (Fri May 15 12:01:29 2009 -0700) 3 commits
 - Add initial support for pathname conversion to UTF-8
 - read_directory(): infrastructure for pathname character set
   conversion
 - Add 'fill_directory()' helper function for directory traversal

Before adding the real "conversion", this needs a few real fixups, I
think.  For example there is one hardcoded array that is used without
bounds check.

* ar/maint-1.6.2-merge-recursive-d-f (Mon May 11 21:25:36 2009 +0200) 2 commits
 - Fix for a merge where a branch has an F->D transition
 - Add a reminder test case for a merge with F/D transition

Although the reported breakage is covered with the patch, Alex feels the
solution unsatisfactory. Cleaning up D/F conflict handling in merge-recursive
may be long overdue but seems to be a hard problem.

* ps/blame (Thu Mar 12 21:30:03 2009 +1100) 1 commit
 - blame.c: start libifying the blame infrastructure

A few minor point remains in this initial one.

* jc/log-tz (Tue Mar 3 00:45:37 2009 -0800) 1 commit
 - Allow --date=local --date=other-format to work as expected

The one I posted had a few corner-case bugs that was caught with the test
suite; this one has them fixed.  People did not like the UI so it is kept
out of 'next'

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

* db/foreign-scm (Tue Mar 24 23:04:12 2009 -0400) 3 commits
 - Add option for using a foreign VCS
 - Document details of transport function APIs
 - Allow late reporting of fetched hashes

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
[Actively cooking]

* gb/gitweb-avatar (Tue Jun 30 00:00:54 2009 +0200) 7 commits
 - gitweb: add empty alt text to avatar img
 - gitweb: picon avatar provider
 - gitweb: gravatar url cache
 - gitweb: (gr)avatar support
 - gitweb: use git_print_authorship_rows in 'tag' view too
 - gitweb: uniform author info for commit and commitdiff
 - gitweb: refactor author name insertion

This should be the latest one posted to the list, and I think it is
reasonable, and Jakub seemed to concur.  Will be in 'next'

* en/fast-export (Thu Jun 25 22:48:33 2009 -0600) 7 commits
 - fast-export: Document the fact that git-rev-list arguments are
   accepted
 - Add new fast-export testcases
 - fast-export: Add a --tag-of-filtered-object option for newly
   dangling tags
 - fast-export: Do parent rewriting to avoid dropping relevant
   commits
 - fast-export: Make sure we show actual ref names instead of
   "(null)"
 - fast-export: Omit tags that tag trees
 - fast-export: Set revs.topo_order before calling setup_revisions

Shawn?  Dscho?

* jc/diff-whitespace-only-status (Sat May 23 01:15:35 2009 -0700) 2 commits
 - diff: Rename QUIET internal option to QUICK
 - diff: change semantics of "ignore whitespace" options

I am not sure if it should wait for a major version bump but this is a
good semantics change.  Perhaps merge to 'next' soonish, but I am
undecided.  Comments?

For the following three series, I have not managed to convince myself if
these changes have real-world needs.

* sb/read-tree (Thu Jun 25 22:14:10 2009 -0700) 2 commits
 - read-tree: migrate to parse-options
 - read-tree: convert unhelpful usage()'s to helpful die()'s

* ne/futz-upload-pack (Wed Jun 10 01:50:18 2009 +0200) 1 commit
 - Shift object enumeration out of upload-pack

* cc/replace (Wed May 27 07:14:09 2009 +0200) 14 commits
 - t6050: check pushing something based on a replaced commit
 - Documentation: add documentation for "git replace"
 - Add git-replace to .gitignore
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
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

These are for 1.7.0, but the messages when they trigger together may need
to be rethought.
