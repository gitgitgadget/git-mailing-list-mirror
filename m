From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Tue, 04 Dec 2007 00:43:26 -0800
Message-ID: <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org>
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
	<7v4pfakr4j.fsf@gitster.siamese.dyndns.org>
	<7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 04 09:44:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzTNu-0005YE-DT
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 09:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbXLDInd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 03:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbXLDInc
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 03:43:32 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37208 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbXLDInb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 03:43:31 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6DF8B2F9;
	Tue,  4 Dec 2007 03:43:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D69F9BB4B;
	Tue,  4 Dec 2007 03:43:49 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67023>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

----------------------------------------------------------------
[Graduated to 'master']

* cr/tag-options (Sun Nov 25 23:50:58 2007 -0500) 4 commits
* jc/branch-contains (Sun Nov 18 22:22:00 2007 -0800) 3 commits
* jc/move-gitk (Sat Nov 17 10:51:16 2007 -0800) 1 commit
* tt/help (Sun Nov 11 19:57:57 2007 -0500) 2 commits
* jc/color (Tue Nov 27 22:41:05 2007 -0800) 2 commits

----------------------------------------------------------------
[New Topics]

* cc/help (Tue Dec 4 06:44:29 2007 +0100) 2 commits
 + Documentation: describe -i/--info option to "git-help"
 + git-help: add -i|--info option to display info page.

There are two additional patches I didn't queue for -w (web) in this
series.

----------------------------------------------------------------
[Will cook further in 'next' and then merge to 'master' soon]

* jc/docmake-perl (Fri Nov 30 18:36:34 2007 -0800) 1 commit
 + Run the specified perl in Documentation/

Tired of waiting for Ack from Merlyn, I merged this to 'next'.

* sp/refspec-match (Sun Nov 11 15:01:48 2007 +0100) 4 commits
 + refactor fetch's ref matching to use refname_match()
 + push: use same rules as git-rev-parse to resolve refspecs
 + add refname_match()
 + push: support pushing HEAD to real branch name

The last one changes the semantics to somewhat less safe:

    * We did not allow fetching outside refs/ (except HEAD), but now we
      allow any random string.

    * We used to restrict fetching names that do not begin with refs/ to
      heads, tags and remotes, but now the code grabs anything underneath
      refs/.

which could invite mistakes by letting typos slip through, but I won't
be a good judge, as I probably "fetch" much less often than other people
do and these may be non issues in the real-world usecases.  It could be
that I am worried too much needlessly.  If anybody who is following
'next' has been bitten by the change, please speak up.  Otherwise this
will go in soon.

* kh/commit (Mon Dec 3 00:03:10 2007 -0800) 33 commits
 + git-commit --allow-empty
 + git-commit: Allow to amend a merge commit that does not change the
   tree
 + quote_path: fix collapsing of relative paths
 + Make git status usage say git status instead of git commit
 + Fix --signoff in builtin-commit differently.
 + git-commit: clean up die messages
 + Do not generate full commit log message if it is not going to be
   used
 + Remove git-status from list of scripts as it is builtin
 + Fix off-by-one error when truncating the diff out of the commit
   message.
 + builtin-commit.c: export GIT_INDEX_FILE for launch_editor as well.
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

This should be production ready, but commit is so central, so let's wait
a bit longer until the bugfixes completely stop flowing in.  The
earliest will be next Wednesday.

* wc/add-i (Mon Dec 3 09:09:43 2007 +0100) 34 commits
 + git-add -i: add help text for list-and-choose UI
 + add -i: allow prefix highlighting for "Add untracked" as well.
 + Highlight keyboard shortcuts in git-add--interactive
 + Document all help keys in "git add -i" patch mode.
 + Add "--patch" option to git-add--interactive
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
series near the tip (they interact with each other somewhat).  Will
merge to 'master' along with the "commit in C" series above.

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

* jc/api-doc (Sat Nov 24 23:48:04 2007 -0800) 1 commit
 - Start preparing the API documents.

The primary reason of this series is because I think we made the system
a lot less approachable by losing hackability.  Although we still have
sample scripts in contrib/example for use of plumbing in scripts, they
will not help aspiring git-hacker-wannabees when our primary attention
has already shifted to moving things to C.

This currently consists of mostly stubs, although I wrote about a few
topics as examples.

* nd/maint-work-tree-fix (Thu Nov 29 19:21:39 2007 +0700) 2 commits
 + Do check_repository_format() early
 + Add missing inside_work_tree setting in setup_git_directory_gently

The tip one needs test script.

* jk/builtin-alias (Fri Nov 30 11:22:58 2007 -0500) 1 commit
 + Support builtin aliases

Cute hack.  I'd like to have "git less" here.

----------------------------------------------------------------
[Stalled]

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, so these are not strictly necessary.

* mw/cvsserver (Fri Nov 23 04:12:54 2007 -0500) 1 commit
 - git-cvsserver runs hooks/post-receive

Queue in 'pu', but lacks a corresponding support for hooks/post-update,
which we haven't declared deprecation.

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

I think this is a sane thing to do in the longer term.  Will be in
'next' after v1.5.4.  I think "leave porcelain on PATH" might be also a
good thing as a transition measure.

Incidentally, if we do not install dashed form of built-ins anywhere
(which is not this series is about --- this is just moving them out of
user's PATH), "git help -a" will stop showing them.  I am not enthused
about removing the hardlinks to built-ins to begin with, but people who
want such a change need to first modify help.c:list_commands() to pick
up builtins without having git-foo hardlinks in gitexecdir.  This may
need to happen anyway as mingw fallouts, though ;-).

* js/reflog-delete (Wed Oct 17 02:50:45 2007 +0100) 1 commit
 + Teach "git reflog" a subcommand to delete single entries

* dz/color-addi (Sat Nov 10 18:03:44 2007 -0600) 3 commits
 . Added diff hunk coloring to git-add--interactive
 . Let git-add--interactive read colors from .gitconfig
 . Added basic color support to git add --interactive

There were many good suggestions by Jeff to the updated series;
hopefully we can have replacements of these three that incorporate
Jeff's suggestions, and build on the "git-config --get-color" series.

* jc/diff-pathspec (Sun Nov 25 10:03:48 2007 -0800) 1 commit
 - Making ce_path_match() more useful by accepting globs

This was to allow "git diff-files -- '*.h'" (currently diff family
knows only the leading directory match and not fileglobs), but was shot
down by Alex.  I tend to agree with him.

* jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
 . pathspec_can_match(): move it from builtin-ls-tree.c to tree.c
 . ls-tree.c: refactor show_recursive() and rename it.
 . tree-diff.c: split out a function to match a single pattern.

* jc/nu (Sun Oct 14 22:07:34 2007 -0700) 3 commits
 . merge-nu: a new merge backend without using unpack_trees()
 . read_tree: take an explicit index structure
 . gcc 4.2.1 -Werror -Wall -ansi -pedantic -std=c99: minimum fix

* jc/cherry-pick (Tue Nov 13 12:38:51 2007 -0800) 1 commit
 . revert/cherry-pick: start refactoring call to merge_recursive
