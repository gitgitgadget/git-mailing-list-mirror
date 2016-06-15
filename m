From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2009, #06; Sat, 24)
Date: Sat, 24 Jan 2009 21:00:31 -0800
Message-ID: <7v8wp0kmj4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 06:02:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQx8F-00056A-SA
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 06:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbZAYFAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 00:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbZAYFAj
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 00:00:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbZAYFAh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 00:00:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F78B9307E;
	Sun, 25 Jan 2009 00:00:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CADA09307D; Sun,
 25 Jan 2009 00:00:33 -0500 (EST)
X-master-at: 5dc1308562ab5991ecada68b06707709bea408c9
X-next-at: 7298c8d081d90e4a3c5161414c17908750ecf5a9
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1A45104C-EA9D-11DD-BE52-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107039>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

[jc: This message was actually prepared last night and reports the state
as of 23 hours ago, but then I got sick and I didn't manage to send it
out. I wasn't productive today, so it unfortunately reflects the current
status as well.]

----------------------------------------------------------------
[New Topics]

* jg/mergetool (Sat Jan 24 00:12:45 2009 +0100) 1 commit
 - [wait for an ack from ted] mergetool: Don't repeat merge tool
   candidates

* cb/mergetool (Wed Jan 21 22:57:48 2009 +0000) 1 commit
 - [wait for ack from ted] mergetool: respect autocrlf by using
   checkout-index

* jc/commit-assume-also-during-merge (Thu Jan 22 22:21:49 2009 -0800) 3 commits
 - git commit: pathspec without -i/-o implies -i semantics during a
   merge
 - builtin-commit: shorten eye-sore overlong lines
 - Add "partial commit" tests during a conflicted merge

This is only meant as a weatherballoon to help facilitate discussion.

* sr/clone-empty (Fri Jan 23 01:07:32 2009 +0100) 1 commit
 + Allow cloning an empty repository

At last ;-)  This is a reasonable thing to do, and should be fast tracked
to 'master'.

* cc/replace (Fri Jan 23 10:07:46 2009 +0100) 7 commits
 - environment: add global variable to disable replacement
 - mktag: call "check_sha1_signature" with the replacement sha1
 - replace_object: add a test case
 - object: call "check_sha1_signature" with the replacement sha1
 - sha1_file: add a "read_sha1_file_repl" function
 - replace_object: add mechanism to replace objects found in
   "refs/replace/"
 - refs: add a "for_each_replace_ref" function

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

This gives Porcelains (like gitweb) the information on the commit _before_
the one that the final blame is laid on, which should save them one
rev-parse to dig further.  The line number in the "previous" information
may need refining, and sanity checking code for reference counting may
need to be resurrected before this can move forward.

* db/foreign-scm (Sun Jan 11 15:12:10 2009 -0500) 3 commits
 - Support fetching from foreign VCSes
 - Add specification of git-vcs helpers
 - Add "vcs" config option in remotes

The "spec" did not seem quite well cooked yet, but in the longer term I
think something like this to allow interoperating with other SCMs as if
the other end is a native git repository is a very worthy goal.

----------------------------------------------------------------
[Reverted]

* mh/unify-color (Fri Jan 23 01:25:23 2009 -0800) 3 commits
 ? Revert previous two commits
 ? move the color variables to color.c
 ? handle color.ui at a central place

This broke git-format-patch badly.

----------------------------------------------------------------
[Actively cooking]

* js/valgrind (Wed Jan 21 02:36:40 2009 +0100) 2 commits
 - valgrind: ignore ldso errors
 - Add valgrind support in test scripts

Dscho seems to have some updates out of discussion with Peff, which is not
queued here.

* sp/runtime-prefix (Sun Jan 18 13:00:15 2009 +0100) 7 commits
 - Windows: Revert to default paths and convert them by
   RUNTIME_PREFIX
 - Compute prefix at runtime if RUNTIME_PREFIX is set
 - Modify setup_path() to only add git_exec_path() to PATH
 - Add calls to git_extract_argv0_path() in programs that call
   git_config_*
 - git_extract_argv0_path(): Move check for valid argv0 from caller
   to callee
 - Refactor git_set_argv0_path() to git_extract_argv0_path()
 - Move computation of absolute paths from Makefile to runtime (in
   preparation for RUNTIME_PREFIX)

We should move this to 'next' soon with J6t's blessing.

* lh/submodule-tree-traversal (Mon Jan 12 00:45:55 2009 +0100) 3 commits
 + builtin-ls-tree: enable traversal of submodules
 + archive.c: enable traversal of submodules
 + tree.c: add support for traversal of submodules

There were a few updates posted, which I haven't picked up.

* jk/signal-cleanup (Thu Jan 22 01:03:28 2009 -0500) 5 commits
 - pager: do wait_for_pager on signal death
 - refactor signal handling for cleanup functions
 - chain kill signals for cleanup functions
 - diff: refactor tempfile cleanup handling
 - Windows: Fix signal numbers

Ready for 'next', but not tonight (yet).

* ks/maint-mailinfo-folded (Tue Jan 13 01:21:04 2009 +0300) 5 commits
 - mailinfo: tests for RFC2047 examples
 - mailinfo: add explicit test for mails like '<a.u.thor@example.com>
   (A U Thor)'
 - mailinfo: more smarter removal of rfc822 comments from 'From'
 + mailinfo: 'From:' header should be unfold as well
 + mailinfo: correctly handle multiline 'Subject:' header

As far as I can see, the only remaining thing is a minor fix-up in the
"comment removal" one before we can move this fully to 'next'.

* js/notes (Tue Jan 13 20:57:16 2009 +0100) 6 commits
 + git-notes: fix printing of multi-line notes
 + notes: fix core.notesRef documentation
 + Add an expensive test for git-notes
 + Speed up git notes lookup
 + Add a script to edit/inspect notes
 + Introduce commit notes

It would be nice to hear a real world success story using the notes
mechanism; Dscho says he also wants to make sure the current choice
of the structure scales well before casting it in stone.

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

Design discussion between Jakub and Sebastien continues.

----------------------------------------------------------------
[Graduated to "master"]

* js/patience-diff (Thu Jan 1 17:39:37 2009 +0100) 3 commits
 + bash completions: Add the --patience option
 + Introduce the diff option '--patience'
 + Implement the patience diff algorithm

----------------------------------------------------------------
[Will merge to "master" soon]

* kb/lstat-cache (Sun Jan 18 16:14:54 2009 +0100) 5 commits
 + lstat_cache(): introduce clear_lstat_cache() function
 + lstat_cache(): introduce invalidate_lstat_cache() function
 + lstat_cache(): introduce has_dirs_only_path() function
 + lstat_cache(): introduce has_symlink_or_noent_leading_path()
   function
 + lstat_cache(): more cache effective symlink/directory detection

* tr/previous-branch (Wed Jan 21 00:37:38 2009 -0800) 10 commits
 + Simplify parsing branch switching events in reflog
 + Introduce for_each_recent_reflog_ent().
 + interpret_nth_last_branch(): plug small memleak
 + Fix reflog parsing for a malformed branch switching entry
 + Fix parsing of @{-1}@{1}
 + interpret_nth_last_branch(): avoid traversing the reflog twice
 + checkout: implement "-" abbreviation, add docs and tests
 + sha1_name: support @{-N} syntax in get_sha1()
 + sha1_name: tweak @{-N} lookup
 + checkout: implement "@{-N}" shortcut name for N-th last branch

* js/maint-all-implies-HEAD (Sat Jan 17 22:27:08 2009 -0800) 2 commits
 + bundle: allow the same ref to be given more than once
 + revision walker: include a detached HEAD in --all

* cb/add-pathspec (Wed Jan 14 15:54:35 2009 +0100) 2 commits
 + remove pathspec_match, use match_pathspec instead
 + clean up pathspec matching

* js/diff-color-words (Tue Jan 20 22:59:54 2009 -0600) 9 commits
 + Change the spelling of "wordregex".
 + color-words: Support diff.wordregex config option
 + color-words: make regex configurable via attributes
 + color-words: expand docs with precise semantics
 + color-words: enable REG_NEWLINE to help user
 + color-words: take an optional regular expression describing words
 + color-words: change algorithm to allow for 0-character word
   boundaries
 + color-words: refactor word splitting and use ALLOC_GROW()
 + Add color_fwrite_lines(), a function coloring each line
   individually

----------------------------------------------------------------
[On Hold]

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

* jk/valgrind (Thu Oct 23 04:30:45 2008 +0000) 2 commits
 . valgrind: ignore ldso errors
 . add valgrind support in test scripts

* wp/add-patch-find (Thu Nov 27 04:08:03 2008 +0000) 3 commits
 . In add --patch, Handle K,k,J,j slightly more gracefully.
 . Add / command in add --patch
 . git-add -i/-p: Change prompt separater from slash to comma
