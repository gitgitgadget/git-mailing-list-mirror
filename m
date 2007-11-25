From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sun, 25 Nov 2007 12:27:24 -0800
Message-ID: <7v4pfakr4j.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>
	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>
	<7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
	<7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 21:27:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwO50-0004u5-Ge
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071AbXKYU1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 15:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755912AbXKYU1b
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:27:31 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40537 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916AbXKYU1a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:27:30 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C87262EF;
	Sun, 25 Nov 2007 15:27:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CF1CF99AA7;
	Sun, 25 Nov 2007 15:27:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65985>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

----------------------------------------------------------------
[Graduated to 'master']

* cc/bisect (Tue Nov 20 06:39:53 2007 +0100) 7 commits
* mh/rebase-skip-hard (Thu Nov 8 08:03:06 2007 +0100) 1 commit
* js/mingw-fallouts (Sat Nov 17 23:09:28 2007 +0100) 13 commits
* sb/clean (Wed Nov 14 23:00:54 2007 -0600) 3 commits
* jk/send-pack (Tue Nov 20 06:18:01 2007 -0500) 29 commits

----------------------------------------------------------------
[Graduated to 'maint']

* jc/maint-format-patch-encoding (Fri Nov 2 17:55:31 2007 -0700) 2 commits
* lt/maint-rev-list-gitlink (Sun Nov 11 23:35:23 2007 +0000) 1 commit

----------------------------------------------------------------
[New Topics]

* jc/api-doc (Sat Nov 24 23:48:04 2007 -0800) 1 commit
 - Start preparing the API documents.

This currently consists of mostly stubs, although I wrote about a few
topics as examples.

* jc/diff-pathspec (Sun Nov 25 10:03:48 2007 -0800) 1 commit
 - Making ce_path_match() more useful by accepting globs

----------------------------------------------------------------
[Will cook further in 'next' and then merge to 'master' soon]

* jc/move-gitk (Sat Nov 17 10:51:16 2007 -0800) 1 commit
 + Move gitk to its own subdirectory

I have a phoney Makefile under the subdirectory for gitk, but
hopefully with the next pull from Paulus I can replace it with
the real thing, along with the i18n stuff.

* tt/help (Sun Nov 11 19:57:57 2007 -0500) 2 commits
 + Remove hint to use "git help -a"
 + Make the list of common commands more exclusive

Some people on the list may find the exact list of commands
somewhat debatable.  We can fine-tune that in-tree ('pu' does
not count as "in-tree").

* kh/commit (Thu Nov 22 16:21:49 2007 -0800) 23 commits
 + Add a few more tests for git-commit
 + builtin-commit: Include the diff in the commit message when
   verbose.
 + builtin-commit: fix partial-commit support
 + Fix add_files_to_cache() to take pathspec, not user specified list
   of files
 + Export three helper functions from ls-files
 + builtin-commit: run commit-msg hook with correct message file
 + builtin-commit: do not color status output shown in the message
   template
 + file_exists(): dangling symlinks do exist
 + Replace "runstatus" with "status" in the tests
 + t7501-commit: Add test for git commit <file> with dirty index.
 + builtin-commit: Clean up an unused variable and a debug fprintf().
 + Call refresh_cache() when updating the user index for --only
   commits.
 + builtin-commit: Add newline when showing which commit was created
 + builtin-commit: resurrect behavior for multiple -m options
 + builtin-commit --s: add a newline if the last line was not a S-o-b
 + builtin-commit: fix --signoff
 + git status: show relative paths when run in a subdirectory
 + builtin-commit: Refresh cache after adding files.
 + builtin-commit: fix reflog message generation
 + launch_editor(): read the file, even when EDITOR=:
 + Port git commit to C.
 + Export launch_editor() and make it accept ':' as a no-op editor.
 + Add testcase for amending and fixing author in git commit.

I've been running with this, and so are people following 'next', for a
few days.  The series seems to be in a good shape.

* cr/tag-options (Thu Nov 22 23:16:51 2007 -0800) 2 commits
 + builtin-tag: accept and process multiple -m just like git-commit
 + Make builtin-tag.c use parse_options.

The handling of multiple -m options are made consistent with
what git-commit does; i.e. they are concatenated as separate
paragraphs.

* jc/branch-contains (Sun Nov 18 22:22:00 2007 -0800) 3 commits
 + git-branch --contains: doc and test
 + git-branch --contains=commit
 + parse-options: Allow to hide options from the default usage.

Contains Pierre's "hidable options with --help-all" patch.

----------------------------------------------------------------
[Actively cooking]

* jc/spht (Sat Nov 24 11:57:41 2007 -0800) 6 commits
 + core.whitespace: documentation updates.
 + builtin-apply: teach whitespace_rules
 + builtin-apply: rename "whitespace" variables and fix styles
 + core.whitespace: add test for diff whitespace error highlighting
 + git-diff: complain about >=8 consecutive spaces in initial indent
 + War on whitespace: first, a bit of retreat.

Now apply also knows about the customizable definition of what
whitespace breakages are, and I was reasonably happy. But Bruce kicked
it back from "scheduled to merge" to "still cooking" status, reminding
that we would want to have this not a tree-wide configuration but
per-path attribute.  And I agree with him.

* wc/add-i (Sun Nov 25 14:15:42 2007 +0100) 30 commits
 - Add "--patch" option to git-add--interactive
 + add -i: Fix running from a subdirectory
 + builtin-add: fix command line building to call interactive
 + Merge branch 'kh/commit' into wc/add-i
 + Add a few more tests for git-commit
 + git-add -i: allow multiple selection in patch subcommand
 + builtin-commit: Include the diff in the commit message when
   verbose.
 + builtin-commit: fix partial-commit support
 + Fix add_files_to_cache() to take pathspec, not user specified list
   of files
 + Export three helper functions from ls-files
 + builtin-commit: run commit-msg hook with correct message file
 + builtin-commit: do not color status output shown in the message
   template
 + file_exists(): dangling symlinks do exist
 + Replace "runstatus" with "status" in the tests
 + t7501-commit: Add test for git commit <file> with dirty index.
 + builtin-commit: Clean up an unused variable and a debug fprintf().
 + Call refresh_cache() when updating the user index for --only
   commits.
 + builtin-commit: Add newline when showing which commit was created
 + builtin-commit: resurrect behavior for multiple -m options
 + builtin-commit --s: add a newline if the last line was not a S-o-b
 + builtin-commit: fix --signoff
 + git status: show relative paths when run in a subdirectory
 + builtin-commit: Refresh cache after adding files.
 + builtin-commit: fix reflog message generation
 + launch_editor(): read the file, even when EDITOR=:
 + Port git commit to C.
 + Export launch_editor() and make it accept ':' as a no-op editor.
 + Add testcase for amending and fixing author in git commit.
 + Add path-limiting to git-add--interactive
 + Teach builtin-add to pass multiple paths to git-add--interactive

This looks larger than it really is, as I merged in the builtin commit
series near the tip (they interact with each other somewhat, and it is
very likely that builtin commit series will graduate to 'master' before
this series).

I also adjusted the "git add -p" patch from Wincent and have it at the
tip.  It is parked in 'pu' for now.

* sp/refspec-match (Sun Nov 11 15:01:48 2007 +0100) 4 commits
 + refactor fetch's ref matching to use refname_match()
 + push: use same rules as git-rev-parse to resolve refspecs
 + add refname_match()
 + push: support pushing HEAD to real branch name

I think the "git push HEAD" is a good change, and also using the same
short refname resolving as rev-parse does for matching the destination
of push.  I am having second thoughts on the last one.  The changed
semantics is somewhat less safe:

    * We did not allow fetching outside refs/ (except HEAD), but now we
      allow any random string.

    * We used to restrict fetching names that do not begin with refs/ to
      heads, tags and remotes, but now the code grabs anything underneath
      refs/.

which could invite mistakes by letting typos slip through.

Having said that, I probably "fetch" much less often than other people
do and these are non issues in the real-world usecases.  It could be
that I am worried too much needlessly.  If anybody who is following
'next' has been bitten by the change, please speak up.

----------------------------------------------------------------
[Stalled]

* jc/cherry-pick (Tue Nov 13 12:38:51 2007 -0800) 1 commit
 - revert/cherry-pick: start refactoring call to merge_recursive

* jc/nu (Sun Oct 14 22:07:34 2007 -0700) 3 commits
 - merge-nu: a new merge backend without using unpack_trees()
 - read_tree: take an explicit index structure
 - gcc 4.2.1 -Werror -Wall -ansi -pedantic -std=c99: minimum fix

The second one could probably be used to replace the use of
path-list in the tip commit on the kh/commit series.

* dz/color-addi (Sat Nov 10 18:03:44 2007 -0600) 3 commits
 - Added diff hunk coloring to git-add--interactive
 - Let git-add--interactive read colors from .gitconfig
 - Added basic color support to git add --interactive

There were many good suggestions by Jeff to the updated series;
hopefully we can replace these three with it.

* nd/maint-work-tree-fix (Sat Nov 3 20:18:06 2007 +0700) 1 commit
 + Add missing inside_work_tree setting in setup_git_directory_gently

There was an additional patch, which still had issues Dscho
pointed out.  Waiting for refinements.

* js/reflog-delete (Wed Oct 17 02:50:45 2007 +0100) 1 commit
 + Teach "git reflog" a subcommand to delete single entries

* jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
 - pathspec_can_match(): move it from builtin-ls-tree.c to tree.c
 - ls-tree.c: refactor show_recursive() and rename it.
 - tree-diff.c: split out a function to match a single pattern.

* ss/dirty-rebase (Thu Nov 1 22:30:24 2007 +0100) 3 commits
 . Make git-svn rebase --dirty pass along --dirty to git-rebase.
 . Implement --dirty for git-rebase--interactive.
 . Introduce --dirty option to git-rebase, allowing you to start from
   a dirty state.

This seems to be optimized for the --dirty case too much.  I'd
prefer an implementation that make rebases without --dirty to
pay no penalty (if that is possible, otherwise "as little as
possible").

* jk/rename (Tue Oct 30 00:24:42 2007 -0400) 3 commits
 . handle renames using similarity engine
 . introduce generic similarity library
 . change hash table calling conventions

This was an attempt to use different strategy to speed up
similarity computation, but does not work quite well as is.
