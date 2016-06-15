From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2009, #02; Sun, 17)
Date: Sun, 17 May 2009 01:05:18 -0700
Message-ID: <7vab5ci281.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 17 10:06:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5bNl-0007G3-Sb
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 10:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbZEQIFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 04:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbZEQIFa
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 04:05:30 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60991 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757279AbZEQIFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 04:05:20 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090517080523.PNVX17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Sun, 17 May 2009 04:05:23 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id sY5J1b0064aMwMQ04Y5JrJ; Sun, 17 May 2009 04:05:21 -0400
X-Authority-Analysis: v=1.0 c=1 a=eR2IkYA7BBMA:10 a=9ttGZAtH5zYA:10
 a=vGWpDiJ1zhHj3RxZt5oA:9 a=TrVLIDIBr0MHM5v0K1sA:7
 a=j0X7xScm0pwc6ghff-KguLxdzTAA:4 a=w6e6RnFUclG-9w9V:21 a=2hi2_nq7C8AmI5JB:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119387>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* jc/mktree (Thu May 14 15:49:10 2009 -0700) 9 commits
 - mktree: validate entry type in input
 - mktree --batch: build more than one tree object
 - mktree --missing: updated usage message and man page
 - mktree --missing: allow missing objects
 - t1010: add mktree test
 - mktree: do not barf on a submodule commit
 - builtin-mktree.c: use a helper function to handle one line of
   input
 - mktree: use parse-options
 - build-in git-mktree

* ar/maint-1.6.2-merge-recursive-d-f (Mon May 11 21:25:36 2009 +0200) 2 commits
 - Fix for a merge where a branch has an F->D transition
 - Add a reminder test case for a merge with F/D transition

Although the reported breakage is covered with the patch, Alex feels the
solution unsatisfactory. Cleaning up D/F conflict handling in merge-recursive
may be long overdue but seems to be a hard problem.

* jc/maint-add-p-coalesce-fix (Sat May 16 10:48:23 2009 -0700) 2 commits
 + Revert "git-add--interactive: remove hunk coalescing"
 + Splitting a hunk that adds a line at the top fails in "add -p"

* sb/format-patch-parseopt (Sat May 16 02:24:46 2009 -0700) 1 commit
 - format-patch: migrate to parse-options API

* fc/decorate-tag (Thu May 14 00:32:53 2009 +0300) 2 commits
 + Prettify log decorations even more
 + Change prettify_ref to prettify_refname

* mg/track (Mon May 11 16:42:54 2009 +0200) 2 commits
 + Fix behavior with non-commit upstream references
 + Test tracking of non-commit upstreams

* jn/gitweb-cleanup (Mon May 11 19:45:11 2009 +0200) 8 commits
 + gitweb: Remove unused $hash_base parameter from
   normalize_link_target
 + gitweb: Simplify snapshot format detection logic in
   evaluate_path_info
 + gitweb: Use capturing parentheses only when you intend to capture
 + gitweb: Replace wrongly added tabs with spaces
 + gitweb: Use block form of map/grep in a few cases more
 + gitweb: Always use three argument form of open
 + gitweb: Always use three argument form of open
 + gitweb: Do not use bareword filehandles

* js/maint-no-ln-across-libexec-and-bin (Mon May 11 13:02:18 2009 +0200) 1 commit
 + Add NO_CROSS_DIRECTORY_HARDLINKS support to the Makefile

* jh/notes (Sat May 16 13:44:17 2009 +0200) 5 commits
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

* tp/send-email-from-config (Tue May 12 15:48:56 2009 -0700) 1 commit
 + send-email: Add config option for sender address

* lt/read-directory (Fri May 15 12:01:29 2009 -0700) 3 commits
 - Add initial support for pathname conversion to UTF-8
 - read_directory(): infrastructure for pathname character set
   conversion
 - Add 'fill_directory()' helper function for directory traversal

----------------------------------------------------------------
[Will merge to "master" soon]

* mw/send-email (Mon Apr 13 13:23:52 2009 -0500) 6 commits
 + send-email: Remove superfluous `my $editor = ...'
 + send-email: 'References:' should only reference what is sent
 + send-email: Handle "GIT:" rather than "GIT: " during --compose
 + Docs: send-email: --smtp-server-port can take symbolic ports
 + Docs: send-email: Refer to CONFIGURATION section for
   sendemail.multiedit
 + Docs: send-email: Put options back into alphabetical order

* ae/anon-fetch-info (Fri Apr 17 10:20:11 2009 +0200) 1 commit
 + fetch: Strip usernames from url's before storing them

* ac/graph-horizontal-line (Tue Apr 21 08:47:01 2009 -0400) 1 commit
 + graph API: Use horizontal lines for more compact graphs

* ph/submodule-rebase (Fri Apr 24 09:06:38 2009 +1000) 1 commit
 + git-submodule: add support for --rebase.

* mh/show-branch-color (Sat Apr 25 13:46:14 2009 +0200) 2 commits
 + bash completion: show-branch color support
 + show-branch: color the commit status signs

* mh/diff-stat-color (Sat Apr 25 00:06:47 2009 +0200) 1 commit
 + diff: do not color --stat output like patch context

* js/add-edit (Mon Apr 27 19:51:42 2009 +0200) 2 commits
 + t3702: fix reliance on SHELL_PATH being '/bin/sh'
 + git-add: introduce --edit (to edit the diff vs. the index)

* jk/maint-add-empty (Tue Apr 28 23:21:01 2009 -0400) 1 commit
 + add: don't complain when adding empty project root

When you say "git add ." in an empty directory, you get "No path matches
''", instead of "No path matches '.'", and this "fixes" it by hiding the
error and making the command silently succeed.  Strictly speaking it
introduces inconsistency, but I think an empty directory is so
uninteresting special case that not signalling it as an error is Ok.

* ar/unlink-err (Wed Apr 29 23:24:52 2009 +0200) 3 commits
 + print unlink(2) errno in copy_or_link_directory
 + replace direct calls to unlink(2) with unlink_or_warn
 + Introduce an unlink(2) wrapper which gives warning if unlink
   failed

* ar/merge-one-file-diag (Wed Apr 29 23:40:50 2009 +0200) 1 commit
 + Clarify kind of conflict in merge-one-file helper

* np/push-delta (Fri May 1 16:56:47 2009 -0400) 1 commit
 + allow OFS_DELTA objects during a push

* mt/submodule-reference (Mon May 4 22:30:01 2009 +0300) 1 commit
 + Add --reference option to git submodule.

* fl/git-pm (Thu May 7 15:41:28 2009 +0200) 2 commits
 + Git.pm: Always set Repository to absolute path if autodetecting
 + Git.pm: Set GIT_WORK_TREE if we set GIT_DIR

* rs/grep-parseopt (Thu May 7 21:46:48 2009 +0200) 5 commits
 + grep: use parseopt
 + grep: remove global variable builtin_grep
 + parseopt: add PARSE_OPT_NODASH
 + parseopt: add OPT_NUMBER_CALLBACK
 + parseopt: add OPT_NEGBIT

* jk/no-no-no-empty-directory (Fri May 8 01:01:17 2009 -0400) 2 commits
 + parseopt: add OPT_NEGBIT
 + parseopt: add OPT_NEGBIT

I somehow botched the commit log message of the top one; it is about
fixing "ls-files --no-empty-directory".

* jk/maint-1.6.0-trace-argv (Fri May 8 05:06:15 2009 -0400) 1 commit
 + fix GIT_TRACE segfault with shell-quoted aliases

* hv/sample-update (Fri May 8 17:22:30 2009 +0200) 1 commit
 + Extend sample update hook, disable modifying of existing tags

* rr/forbid-bs-in-ref (Fri May 8 07:32:37 2009 +0200) 1 commit
 + Disallow '\' in ref names

This retroactively forbids use of what people could have been using
happily, which, strictly speaking, is a no-no, but makes sense in the
longer term.

* do/maint-merge-recursive-fix (Sat May 9 14:49:59 2009 -0700) 1 commit
 + merge-recursive: never leave index unmerged while recursing

* jm/format-patch-no-auto-n-when-k-is-given (Sat May 9 10:12:01 2009 +0200) 1 commit
 + format-patch let -k override a config-specified format.numbered

* lt/maint-diff-reduce-lstat (Sat May 9 15:11:17 2009 -0700) 2 commits
 + Teach 'git checkout' to preload the index contents
 + Avoid unnecessary 'lstat()' calls in 'get_stat_data()'

* cc/bisect (Sat May 9 17:55:47 2009 +0200) 20 commits
 + bisect: make "git bisect" use new "--next-all" bisect-helper
   function
 + bisect: add "check_good_are_ancestors_of_bad" function
 + bisect: implement the "check_merge_bases" function
 + bisect: automatically sort sha1_array if needed when looking it up
 + bisect: make skipped array functions more generic
 + bisect: remove too much function nesting
 + bisect: use new "struct argv_array" to prepare argv for
   "setup_revisions"
 + bisect: store good revisions in a "sha1_array"
 + bisect: implement "rev_argv_push" to fill an argv with revs
 + bisect: use "sha1_array" to store skipped revisions
 + am: simplify "sq" function by using "git rev-parse --sq-quote"
 + bisect: use "git rev-parse --sq-quote" instead of a custom "sq"
   function
 + rev-parse: add --sq-quote to shell quote arguments
 + rev-list: remove stringed output flag from "show_bisect_vars"
 + bisect--helper: remove "--next-vars" option as it is now useless
 + bisect: use "git bisect--helper --next-exit" in "git-bisect.sh"
 + bisect--helper: add "--next-exit" to output bisect results
 + bisect: move common bisect functionality to "bisect_common"
 + rev-list: refactor printing bisect vars
 + rev-list: make "estimate_bisect_steps" non static

Rewriting major part of "git-bisect" shell script continues.  The patches
seem to be reasonably clean.

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* ps/blame (Thu Mar 12 21:30:03 2009 +1100) 1 commit
 - blame.c: start libifying the blame infrastructure

A few minor point remains in this initial one.  I hate to do these minor
fix-ups myself, but I may end up doing so...

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

* da/mergetool-lib (Sat May 2 01:57:21 2009 -0700) 1 commit
 - mergetool--lib: specialize diff options for emerge and ecmerge

Can somebody tell me what the current status of this is?  I thought there
was some objection, but I lost track...

* rc/http-push (Sat May 16 11:51:52 2009 +0800) 12 commits
 - http*: add fetch_http_pack_index
 - http: create function end_url_with_slash
 - http*: move common variables and macros to http.[ch]
 - http-push: do not SEGV after fetching a bad pack idx file
 - http*: copy string returned by sha1_to_hex
 - http-walker: verify remote packs
 - http-push, http-walker: style fixes
 - t5550-http-fetch: test fetching of packed objects
 - http-push: fix missing "#ifdef USE_CURL_MULTI" around
   "is_running_queue"
 - http-push: send out fetch requests on queue
 - t5540-http-push: test fetching of packed objects
 - t5540-http-push: test fetching of loose objects

There was an 11-patch updates but in the middle there were some
compilation breakage issues; only early part of that series is queued.

* cc/replace (Tue Apr 14 00:36:59 2009 +0200) 13 commits
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

I suspect an attempt to replace an object that is directly listed on the
command line would not work very well with this series.

----------------------------------------------------------------
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

These are for 1.7.0, but the messages when they trigger together may need
to be rethought.

----------------------------------------------------------------
[Discarded]

* js/notes (Tue Apr 14 00:03:36 2009 +0200) 15 commits
 . Documentation: fix 'linkgit' macro in "git-notes.txt"
 . tests: fix "export var=val"
 . notes: refuse to edit notes outside refs/notes/
 . t3301: use test_must_fail instead of !
 . t3301: fix confusing quoting in test for valid notes ref
 . notes: use GIT_EDITOR and core.editor over VISUAL/EDITOR
 . notes: only clean up message file when editing
 . handle empty notes gracefully
 . git notes show: test empty notes
 . git-notes: fix printing of multi-line notes
 . notes: fix core.notesRef documentation
 . Add an expensive test for git-notes
 . Speed up git notes lookup
 . Add a script to edit/inspect notes
 . Introduce commit notes

This has been replaced by jh/notes series.
