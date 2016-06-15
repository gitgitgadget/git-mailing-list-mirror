From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2009, #02; Sun, 12)
Date: Sun, 12 Apr 2009 19:50:34 -0700
Message-ID: <7vvdp9w9l1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 04:52:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtCHa-0002G5-3n
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 04:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542AbZDMCum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 22:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbZDMCul
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 22:50:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbZDMCuj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 22:50:39 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4BDB8A940B;
	Sun, 12 Apr 2009 22:50:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1EA5BA940A; Sun,
 12 Apr 2009 22:50:35 -0400 (EDT)
X-master-at: c965c029330b1f81cc107c5d829e7fd79c61d8ea
X-next-at: d07d5c8f15ddd1f2569e1778cb82501a201d2f22
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DE8B51DA-27D5-11DE-8226-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116405>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

We are at 1.6.3-rc0; the tip of 'master' might have some unexpected
minor regressions, and I'd appreciate people to test and report so that we
can keep this cycle short.

----------------------------------------------------------------
[New Topics]

* mm/add-p-quit (Fri Apr 10 16:57:01 2009 +0200) 1 commit
 - [NEEDS SIGN OFF, DOC, AND REVIEW] git add -p: new "quit" command
   at the prompt.

I think this is Ok for 1.6.3, but some duplicated hunks bothered me.  I
did not read the patch really seriously.

* lt/bool-on-off (Thu Apr 9 12:40:39 2009 -0700) 1 commit
 - Allow users to un-configure rename detection

The commit log message needs to be cleaned up, the patch needs to be
signed off, and there probably needs a documentation, but I think
otherwise this is a good idea.

* nd/archive-attribute (Thu Apr 9 17:01:30 2009 +1000) 2 commits
 - archive: do not read .gitattributes in working directory
 - attr: add GIT_ATTR_INDEX "direction"

I think this is Ok for 1.6.3 but it needs new tests to protect the new
feature from future breakages.

* js/add-edit (Wed Apr 8 23:30:24 2009 +0200) 1 commit
 - git-add: introduce --edit (to edit the diff vs. the index)

I am Ok with the general idea, but the error detection needs to be more
robust than merely relying on --recount.

* eb/upload-archive-from-git-shell (Thu Apr 9 21:58:52 2009 +0200) 1 commit
 - git-shell: Add 'git-upload-archive' to allowed commands.

I think this is Ok for 1.6.3.

* jc/shared-literally (Sun Apr 12 17:55:18 2009 -0700) 2 commits
 - Mark t1301 permission test to depend on POSIXPERM
 - t1301-shared-repo: fix forced modes test

J6t's updates to fix permission tests and make sure they won't run on
systems without permission bits on the filesystem.

I think this is Ok for 1.6.3.

* ns/am-to-empty (Fri Apr 10 09:34:42 2009 +0900) 1 commit
 - git-am: teach git-am to apply a patch to an unborn branch

I think this is Ok for 1.6.3.

* bw/short-ref-strict (Sat Apr 11 22:35:18 2009 +0200) 2 commits
 . for-each-ref: refname:short utilize core.warnAmbiguousRefs
 . get_short_ref(): add strict mode

This is an "obviously good thing to do" candidate for 1.6.3 but had
serious conflicts with other topics I didn't feel like resolving myself;
as the series is coming from TopGit, I'd ask the submitter to rebase it
for me ;-)

* lt/pack-object-memuse (Fri Apr 10 18:15:26 2009 -0700) 2 commits
 - show_object(): push path_name() call further down
 - process_{tree,blob}: show objects without buffering

This had some conflicts with Christian's bisect topic; I think I resolved
them correctly, but double-checking would be nice.

----------------------------------------------------------------
[Graduated to "master"]

* mh/html-path (Sun Apr 5 04:15:16 2009 +0200) 1 commit
 + add --html-path to get the location of installed HTML docs

* lt/reflog-expire (Mon Mar 30 21:34:14 2009 -0700) 2 commits
 + Speed up reflog pruning of unreachable commits
 + Clean up reflog unreachability pruning decision

* bs/maint-1.6.0-tree-walk-prefix (Wed Apr 1 19:34:03 2009 -0700) 2 commits
 + match_tree_entry(): a pathspec only matches at directory
   boundaries
 + tree_entry_interesting: a pathspec only matches at directory
   boundary

* ms/http-auth (Wed Apr 1 19:48:24 2009 +0300) 1 commit
 + Allow curl to rewind the read buffers

* js/maint-submodule-checkout (Thu Apr 2 15:30:25 2009 +0200) 1 commit
 + Fix 'git checkout <submodule>' to update the index

* cb/maint-merge-recursive-submodule-fix (Sun Apr 5 02:47:00 2009 +0200) 3 commits
 + simplify output of conflicting merge
 + update cache for conflicting submodule entries
 + add tests for merging with submodules

* fg/remote-prune (Fri Apr 3 11:03:44 2009 +0200) 2 commits
 + git remote update: New option --prune
 + builtin-remote.c: Split out prune_remote as a separate function.

These should go to 'master' soonish.

* cc/sha1-bsearch (Mon Apr 6 00:48:49 2009 -0700) 3 commits
 + sha1-lookup: fix up the assertion message
 + patch-ids: use the new generic "sha1_pos" function to lookup sha1
 + sha1-lookup: add new "sha1_pos" function to efficiently lookup
   sha1

* jc/name-branch-iffy (Sat Mar 21 14:30:21 2009 -0700) 1 commit
 + checkout -: make "-" to mean "previous branch" everywhere

* cc/bisect-filter (Mon Mar 30 06:59:59 2009 +0200) 19 commits
 + bisect--helper: string output variables together with "&&"
 + rev-list: pass "int flags" as last argument of "show_bisect_vars"
 + t6030: test bisecting with paths
 + bisect: use "bisect--helper" and remove "filter_skipped" function
 + bisect: implement "read_bisect_paths" to read paths in
   "$GIT_DIR/BISECT_NAMES"
 + bisect--helper: implement "git bisect--helper"
 + bisect: use the new generic "sha1_pos" function to lookup sha1
 + rev-list: call new "filter_skip" function
 + Merge branch 'cc/sha1-bsearch' into HEAD
 + patch-ids: use the new generic "sha1_pos" function to lookup sha1
 + sha1-lookup: add new "sha1_pos" function to efficiently lookup
   sha1
 + rev-list: pass "revs" to "show_bisect_vars"
 + rev-list: make "show_bisect_vars" non static
 + rev-list: move code to show bisect vars into its own function
 + rev-list: move bisect related code into its own file
 + rev-list: make "bisect_list" variable local to "cmd_rev_list"
 + refs: add "for_each_ref_in" function to refactor "for_each_*_ref"
   functions
 + quote: add "sq_dequote_to_argv" to put unwrapped args in an argv
   array
 + quote: implement "sq_dequote_many" to unwrap many args in one
   string

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

* hv/cvsps-tests (Sun Apr 5 01:40:50 2009 -0700) 8 commits
 - t/t9600: remove exit after test_done
 - cvsimport: extend testcase about patchset order to contain
   branches
 - cvsimport: add test illustrating a bug in cvsps
 + Add a test of "git cvsimport"'s handling of tags and branches
 + Add some tests of git-cvsimport's handling of vendor branches
 + Test contents of entire cvsimported "master" tree contents
 + Use CVS's -f option if available (ignore user's ~/.cvsrc file)
 + Start a library for cvsimport-related tests

Two cvsimport test topics were rewound from 'next' and merged into this
one.  I'll keep this in 'pu' so that people can polish their cvsps skilz
to resolve issues these tests identify.

----------------------------------------------------------------
[Actively cooking]

* da/difftool (Sat Apr 11 20:41:56 2009 -0700) 16 commits
 - mergetool--lib: simplify API usage by removing more global
   variables
 - Fix misspelled mergetool.keepBackup
 - difftool/mergetool: refactor commands to use git-mergetool--lib
 - mergetool: use $( ... ) instead of `backticks`
 - bash completion: add git-difftool
 - difftool: add support for a difftool.prompt config variable
 - difftool: add various git-difftool tests
 - difftool: move 'git-difftool' out of contrib
 - difftool/mergetool: add diffuse as merge and diff tool
 - difftool: add a -y shortcut for --no-prompt
 - difftool: use perl built-ins when testing for msys
 - difftool: remove the backup file feature
 - difftool: remove merge options for opendiff, tkdiff, kdiff3 and
   xxdiff
 - git-mergetool: add new merge tool TortoiseMerge
 - git-mergetool/difftool: make (g)vimdiff workable under Windows
 - doc/merge-config: list ecmerge as a built-in merge tool

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
