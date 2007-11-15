From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Wed, 14 Nov 2007 16:18:25 -0800
Message-ID: <7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 01:18:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsSRT-0005ez-Hb
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 01:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352AbXKOASd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 19:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755890AbXKOASc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 19:18:32 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:42287 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbXKOASb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 19:18:31 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7D2CF2F0;
	Wed, 14 Nov 2007 19:18:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E22595D8C;
	Wed, 14 Nov 2007 19:18:49 -0500 (EST)
In-Reply-To: <7vwsso3poo.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 11 Nov 2007 23:09:43 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65028>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

----------------------------------------------------------------
[Will cook further in 'next' and then merge to 'master' soon]

* lt/rev-list-interactive (Mon Nov 12 23:16:08 2007 -0800) 5 commits
 + Fix parent rewriting in --early-output
 + revision walker: mini clean-up
 + Enhance --early-output format
 + Add "--early-output" log flag for interactive GUI use
 + Simplify topo-sort logic

* lt/rev-list-gitlink (Sun Nov 11 23:35:23 2007 +0000) 1 commit
 + Fix rev-list when showing objects involving submodules

This fix from Dscho and Linus will need to be cherry-picked to
'maint' as well.

* ds/checkout-upper (Fri Nov 9 20:12:28 2007 +1100) 2 commits
 + git-checkout: Test for relative path use.
 + git-checkout: Support relative paths containing "..".

This will allow you to stay in a subdirectory and check out
paths in directories outside.  With Dscho's "git status" that
shows relatives paths (in kh/commit series), this would make
cutting and pasting paths you forgot to "git add" easier.

* ph/parseopt-sh (Mon Nov 12 12:07:40 2007 +0000) 17 commits
 + git-quiltimport.sh fix --patches handling
 + git-am: -i does not take a string parameter.
 + sh-setup: don't let eval output to be shell-expanded.
 + git-sh-setup: fix parseopt `eval` string underquoting
 + Give git-am back the ability to add Signed-off-by lines.
 + git-rev-parse --parseopt
 + scripts: Add placeholders for OPTIONS_SPEC
 + Migrate git-repack.sh to use git-rev-parse --parseopt
 + Migrate git-quiltimport.sh to use git-rev-parse --parseopt
 + Migrate git-checkout.sh to use git-rev-parse --parseopt --keep-
   dashdash
 + Migrate git-instaweb.sh to use git-rev-parse --parseopt
 + Migrate git-merge.sh to use git-rev-parse --parseopt
 + Migrate git-am.sh to use git-rev-parse --parseopt
 + Migrate git-clone to use git-rev-parse --parseopt
 + Migrate git-clean.sh to use git-rev-parse --parseopt.
 + Update git-sh-setup(1) to allow transparent use of git-rev-parse -
   -parseopt
 + Add a parseopt mode to git-rev-parse to bring parse-options to
   shell scripts.

The rate of incoming fix with this topic has slowed down, which
is a good indication that this is getting ready.

----------------------------------------------------------------
[Actively cooking]

* jk/send-pack (Tue Nov 13 06:37:10 2007 -0500) 24 commits
 - send-pack: assign remote errors to each ref
 - send-pack: check ref->status before updating tracking refs
 - send-pack: track errors for each ref
 - Merge branch 'aw/mirror-push' into jk/send-pack
 - Merge branch 'ar/send-pack-remote-track' into jk/send-pack
 - Merge branch 'db/remote-builtin' into jk/send-pack
 + git-push: add documentation for the newly added --mirror mode
 + Add tests for git push'es mirror mode
 + Update the tracking references only if they were succesfully
   updated on remote
 + Add a test checking if send-pack updated local tracking branches
   correctly
 + git-push: plumb in --mirror mode
 + Teach send-pack a mirror mode
 + Merge master into aw/mirror-push
 + Merge branch 'jk/terse-push' into aw/mirror-push
 + send-pack: segfault fix on forced push
 + Reteach builtin-ls-remote to understand remotes
 + send-pack: require --verbose to show update of tracking refs
 + receive-pack: don't mention successful updates
 + more terse push output
 + Build in ls-remote
 + Build-in send-pack, with an API for other programs to call.
 + Use built-in send-pack.
 + Build-in peek-remote, using transport infrastructure.
 + Miscellaneous const changes and utilities

This three-patch series is built on top of four other topics and
is meant to fix issues in built-in send-pack.  I dropped
individial topics from Alex, Daniel, Andy and another from Jeff
that this series depends on.  IOW, they all will graduate to
"master" at the same time when this series proves to be stable.

Will wait for a few days to hear opinions from the list, and
then merge to "next" and start cooking.

* js/mingw-fallouts (Tue Nov 13 21:05:06 2007 +0100) 11 commits
 + Allow ETC_GITCONFIG to be a relative path.
 + Introduce git_etc_gitconfig() that encapsulates access of
   ETC_GITCONFIG.
 + Allow a relative builtin template directory.
 + Close files opened by lock_file() before unlinking.
 + builtin run_command: do not exit with -1.
 + Move #include <sys/select.h> and <sys/ioctl.h> to git-compat-
   util.h.
 + Use is_absolute_path() in sha1_file.c.
 + Skip t3902-quoted.sh if the file system does not support funny
   names.
 + t5302-pack-index: Skip tests of 64-bit offsets if necessary.
 + t7501-commit.sh: Not all seds understand option -i
 + t5300-pack-object.sh: Split the big verify-pack test into smaller
   parts.

A set of good general clean-up patches.

* jc/spht (Fri Nov 2 17:46:55 2007 -0700) 3 commits
 + core.whitespace: add test for diff whitespace error highlighting
 + git-diff: complain about >=8 consecutive spaces in initial indent
 + War on whitespace: first, a bit of retreat.

Teaching "git apply --whitespace=[warn|strip]" to honor the same
configuration would be a good addition, but this could go to
'master' as is.

* js/reflog-delete (Wed Oct 17 02:50:45 2007 +0100) 1 commit
 + Teach "git reflog" a subcommand to delete single entries

* tt/help (Sun Nov 11 19:57:57 2007 -0500) 2 commits
 + Remove hint to use "git help -a"
 + Make the list of common commands more exclusive

Some people on the list may find the exact list of commands
somewhat debatable.  We can fine-tune that in-tree ('pu' does
not count as "in-tree").

* ph/diffopts (Wed Nov 7 11:20:32 2007 +0100) 6 commits
 + Reorder diff_opt_parse options more logically per topics.
 + Make the diff_options bitfields be an unsigned with explicit
   masks.
 + Use OPT_BIT in builtin-pack-refs
 + Use OPT_BIT in builtin-for-each-ref
 + Use OPT_SET_INT and OPT_BIT in builtin-branch
 + parse-options new features.

Further code clean-ups.

----------------------------------------------------------------
[Approaching 'next']

* kh/commit (Wed Nov 14 10:31:53 2007 -0500) 13 commits
 - builtin-commit: Clean up an unused variable and a debug fprintf().
 - Call refresh_cache() when updating the user index for --only
   commits.
 - builtin-commit: Add newline when showing which commit was created
 - builtin-commit: resurrect behavior for multiple -m options
 - builtin-commit --s: add a newline if the last line was not a S-o-b
 - builtin-commit: fix --signoff
 - git status: show relative paths when run in a subdirectory
 - builtin-commit: Refresh cache after adding files.
 - builtin-commit: fix reflog message generation
 - launch_editor(): read the file, even when EDITOR=:
 - Port git commit to C.
 - Export launch_editor() and make it accept ':' as a no-op editor.
 - Add testcase for amending and fixing author in git commit.

Dscho fixed a few obvious glitches, but indicated he has a
handful more issues with the series.  I have been hoping that
this series should be in "testable" shape now.  Will need to
look at it again.

* sp/refspec-match (Sun Nov 11 15:01:48 2007 +0100) 4 commits
 - refactor fetch's ref matching to use refname_match()
 - push: use same rules as git-rev-parse to resolve refspecs
 - add refname_match()
 - push: support pushing HEAD to real branch name

This changes the semantics slightly but I think it is a move in
the right direction.

* sb/clean (Mon Nov 12 21:13:05 2007 -0800) 2 commits
 - git-clean: Fix error message if clean.requireForce is not set.
 - Make git-clean a builtin

It has a subtle change in behaviour but it does not quite
qualify as a regression.  Will merge to "next" shortly.  We can
fix the corner case semantics in-tree.  I also adjusted the
error message to match the fix from Hannes on 'master'.

----------------------------------------------------------------
[Stalled]

* mh/rebase-skip-hard (Thu Nov 8 08:03:06 2007 +0100) 1 commit
 - Do git reset --hard HEAD when using git rebase --skip

Some people on the list may find this debatable.  Opinions?

* cr/tag-options (Fri Nov 9 14:42:56 2007 +0100) 1 commit
 - Make builtin-tag.c use parse_options.

This changes the handling of multiple -m options without much
good reason.  It should be a simple fix, once we know what we
want.  I think the existing behaviour of refusing multiple -m
is probably the most sane at this point.

* dz/color-addi (Sat Nov 10 18:03:44 2007 -0600) 3 commits
 - Added diff hunk coloring to git-add--interactive
 - Let git-add--interactive read colors from .gitconfig
 - Added basic color support to git add --interactive

This series has improved quite a bit since the last round, but
another round was requested from the list.  Waiting for
refinements.

* nd/maint-work-tree-fix (Sat Nov 3 20:18:06 2007 +0700) 1 commit
 + Add missing inside_work_tree setting in setup_git_directory_gently

There was an additional patch, which still had issues Dscho
pointed out.  Waiting for refinements.

* ss/dirty-rebase (Thu Nov 1 22:30:24 2007 +0100) 3 commits
 - Make git-svn rebase --dirty pass along --dirty to git-rebase.
 - Implement --dirty for git-rebase--interactive.
 - Introduce --dirty option to git-rebase, allowing you to start from
   a dirty state.

This seems to be optimized for the --dirty case too much.  I'd
prefer an implementation that make rebases without --dirty to
pay no penalty (if that is possible, otherwise "as little as
possible").

----------------------------------------------------------------
[Others]

* jc/branch-contains (Wed Nov 7 14:58:09 2007 -0800) 1 commit
 - git-branch --with=commit

I did this just for my own fun.  --contains might be more
consistent with git-describe but --with is shorter to type ;-)

Besides, it needs documentation and tests.

* jc/maint-format-patch-encoding (Fri Nov 2 17:55:31 2007 -0700) 2 commits
 - test format-patch -s: make sure MIME content type is shown as
   needed
 - format-patch -s: add MIME encoding header if signer's name
   requires so

This is to apply to 'maint' later; the equivalent fix is already
in 'master'.

* jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
 - pathspec_can_match(): move it from builtin-ls-tree.c to tree.c
 - ls-tree.c: refactor show_recursive() and rename it.
 - tree-diff.c: split out a function to match a single pattern.

* jk/rename (Tue Oct 30 00:24:42 2007 -0400) 3 commits
 - handle renames using similarity engine
 - introduce generic similarity library
 - change hash table calling conventions

* jc/cherry-pick (Tue Nov 13 12:38:51 2007 -0800) 1 commit
 - revert/cherry-pick: start refactoring call to merge_recursive

* jc/nu (Sun Oct 14 22:07:34 2007 -0700) 3 commits
 - merge-nu: a new merge backend without using unpack_trees()
 - read_tree: take an explicit index structure
 - gcc 4.2.1 -Werror -Wall -ansi -pedantic -std=c99: minimum fix
