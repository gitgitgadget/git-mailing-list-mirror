From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2009, #03; Mon, 25)
Date: Mon, 25 May 2009 01:33:48 -0700
Message-ID: <7vd49xy42b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 10:34:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8VdO-00058b-00
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 10:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbZEYIeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 04:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753787AbZEYIeA
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 04:34:00 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:47044 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbZEYId6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 04:33:58 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090525083348.FSXA2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Mon, 25 May 2009 04:33:48 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id vkZo1b0024aMwMQ04kZo8c; Mon, 25 May 2009 04:33:48 -0400
X-Authority-Analysis: v=1.0 c=1 a=-layfMjczJIA:10 a=9ttGZAtH5zYA:10
 a=b3uDMlK8r82H5qxy8HYA:9 a=sZ0K9swIQUZojM3eCxUA:7
 a=nIgQnWXqKgAPsDbhhORe9RCb4JsA:4 a=tCQDweabYMwUHqy2:21 a=j1H6v-0CbUFM56-6:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119900>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* sb/opt-filename (Sat May 23 11:53:13 2009 -0700) 5 commits
 - parse-opts: add OPT_FILENAME and transition builtins
 - parse-opts: prepare for OPT_FILENAME
 - Merge branch 'jc/mktree' into sb/opt-filename
 - Merge branch 'sb/format-patch-parseopt' into sb/opt-filename
 - Merge branch 'sb/show-branch-parse-options' into sb/opt-filename
 - Merge branch 'master' into sb/opt-filename
 + apply, fmt-merge-msg: use relative filenames
 + commit: -F overrides -t

There are quite a few new callers to parse_options() in 'next' and 'pu'
that are more likely to graduate before this series, so for now I merged a
few of them and adjusted the commit "prepare for OPT_FILENAME".  I tried
to be careful but extra sets of eyeballs would be helpful.

* da/araxis-mergetool (Sun May 24 00:24:41 2009 +0000) 1 commit
 + mergetool--lib: add support for araxis merge

I admit that I feel certain distaste in supporting a closed tool, but we
already make things bearable for people on Windows; Araxis is no worse,
right?

* rs/maint-grep-word-regexp-fix (Sat May 23 13:45:26 2009 +0200) 1 commit
 + grep: fix word-regexp at the beginning of lines

* mm/apply-double-slash (Thu May 21 14:25:11 2009 +0200) 1 commit
 + apply: handle filenames with double slashes better

* bc/old-iconv (Fri May 22 18:47:06 2009 -0500) 10 commits
 + t8005: convert CP1251 character set to ISO8859-5
 + t8005: use more portable character encoding names
 + t5100: use ancient encoding syntax for backwards compatibility
 + t9301: use ISO8859-1 rather than ISO-8859-1
 + t3901: Use ISO8859-1 instead of ISO-8859-1 for backward
   compatibility
 + t3901: avoid negation on right hand side of '|'
 + builtin-mailinfo.c: use "ISO8859-1" instead of "latin1" as
   fallback encoding
 + builtin-mailinfo.c: compare character encodings case insensitively
 + Use 'UTF-8' rather than 'utf-8' everywhere for backward
   compatibility
 + t3900: use ancient iconv names for backward compatibility

* sb/show-branch-parse-options (Thu May 21 00:33:18 2009 -0700) 3 commits
 + show-branch: migrate to parse-options API
 + Merge branch 'mh/show-branch-color' into sb/show-branch-parse-
   options
 + parse-options: add PARSE_OPT_LITERAL_ARGHELP for complicated
   argh's

* sb/maint-1.6.2-opt-filename-fix (Sat May 23 11:53:11 2009 -0700) 2 commits
 + apply, fmt-merge-msg: use relative filenames
 + commit: -F overrides -t

* jc/cache-tree (Fri May 22 23:14:25 2009 -0700) 5 commits
 - Avoid "diff-index --cached" optimization under --find-copies-
   harder
 - Optimize "diff-index --cached" using cache-tree
 - t4007: modernize the style
 - cache-tree.c::cache_tree_find(): simplify inernal API
 - write-tree --ignore-cache-tree

* jc/solaris-0811 (Fri May 22 22:55:31 2009 -0700) 2 commits
 - OpenSolaris 200811 (SunOS 5.11) does not want OLD_ICONV
 - Teach Solaris that _XOPEN_SOURCE=600 really menas XPG6

* cb/maint-1.6.0-xdl-merge-fix (Mon May 25 01:21:14 2009 +0100) 2 commits
 - Change xdl_merge to generate output even for null merges
 - t6023: merge-file fails to output anything for a degenerate merge

* jc/diff-whitespace-only-status (Sat May 23 01:15:35 2009 -0700) 2 commits
 - diff: Rename QUIET internal option to QUICK
 - diff: change semantics of "ignore whitespace" options

----------------------------------------------------------------
[Graduated to "master"]

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

* tp/send-email-from-config (Tue May 12 15:48:56 2009 -0700) 1 commit
 + send-email: Add config option for sender address

* ae/anon-fetch-info (Fri Apr 17 10:20:11 2009 +0200) 1 commit
 + fetch: Strip usernames from url's before storing them

* ac/graph-horizontal-line (Tue Apr 21 08:47:01 2009 -0400) 1 commit
 + graph API: Use horizontal lines for more compact graphs

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

* jk/maint-1.6.0-trace-argv (Fri May 8 05:06:15 2009 -0400) 1 commit
 + fix GIT_TRACE segfault with shell-quoted aliases

* hv/sample-update (Fri May 8 17:22:30 2009 +0200) 1 commit
 + Extend sample update hook, disable modifying of existing tags

* rr/forbid-bs-in-ref (Fri May 8 07:32:37 2009 +0200) 1 commit
 + Disallow '\' in ref names

* do/maint-merge-recursive-fix (Sat May 9 14:49:59 2009 -0700) 1 commit
 + merge-recursive: never leave index unmerged while recursing

* jm/format-patch-no-auto-n-when-k-is-given (Sat May 9 10:12:01 2009 +0200) 1 commit
 + format-patch let -k override a config-specified format.numbered

* lt/maint-diff-reduce-lstat (Sat May 9 15:11:17 2009 -0700) 2 commits
 + Teach 'git checkout' to preload the index contents
 + Avoid unnecessary 'lstat()' calls in 'get_stat_data()'

* da/mergetool-lib (Sat May 2 01:57:21 2009 -0700) 1 commit
 + mergetool--lib: specialize diff options for emerge and ecmerge

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

* ph/submodule-rebase (Fri Apr 24 09:06:38 2009 +1000) 1 commit
 + git-submodule: add support for --rebase.

* cc/bisect (Sun May 17 17:36:46 2009 +0200) 3 commits
 + bisect: check ancestors without forking a "git rev-list" process
 + commit: add function to unparse a commit and its parents
 + bisect: rework some rev related functions to make them more
   reusable

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

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

* jc/mktree (Thu May 14 15:49:10 2009 -0700) 9 commits
 + mktree: validate entry type in input
 + mktree --batch: build more than one tree object
 + mktree --missing: updated usage message and man page
 + mktree --missing: allow missing objects
 + t1010: add mktree test
 + mktree: do not barf on a submodule commit
 + builtin-mktree.c: use a helper function to handle one line of
   input
 + mktree: use parse-options
 + build-in git-mktree

* jc/maint-add-p-coalesce-fix (Sat May 16 10:48:23 2009 -0700) 2 commits
 + Revert "git-add--interactive: remove hunk coalescing"
 + Splitting a hunk that adds a line at the top fails in "add -p"

* sb/format-patch-parseopt (Sat May 16 02:24:46 2009 -0700) 1 commit
 + format-patch: migrate to parse-options API

* jh/notes (Sat May 16 13:44:17 2009 +0200) 5 commits
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

* rc/http-push (Mon May 18 16:14:24 2009 +0800) 15 commits
 - http*: add helper methods for fetching objects (loose)
 - http*: add helper methods for fetching objects/info/packs
 - http*: add helper methods for fetching packs
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

This is not the re-rolled 18-patch series we discussed yesterday.

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
