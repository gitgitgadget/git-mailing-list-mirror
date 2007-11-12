From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sun, 11 Nov 2007 23:09:43 -0800
Message-ID: <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 08:10:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrTQr-0000Dy-7S
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 08:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbXKLHJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 02:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752666AbXKLHJt
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 02:09:49 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:49718 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbXKLHJs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 02:09:48 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3E2772F9;
	Mon, 12 Nov 2007 02:10:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 01E8393BEC;
	Mon, 12 Nov 2007 02:10:06 -0500 (EST)
X-master-at: 40e2524da9f9fb2806a66a694b9aee722ea3ef0a
X-next-at: 5a987d8251565a5a8143d295be8bbb93ebd416f4
In-Reply-To: <7vir4d40sw.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 08 Nov 2007 00:08:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64567>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

----------------------------------------------------------------
[Will cook further in 'next' and then merge to 'master' soon]

* rs/pretty (Sat Nov 10 12:55:48 2007 +0100) 6 commits
 + Simplify strchrnul() compat code
 + --format=pretty: avoid calculating expensive expansions twice
 + add strbuf_adddup()
 + --pretty=format: parse commit message only once
 + --pretty=format: on-demand format expansion
 + Add strchrnul()

* np/progress (Thu Nov 8 15:45:41 2007 -0500) 7 commits
 + nicer display of thin pack completion
 + make display of total transferred fully accurate
 + remove dead code from the csum-file interface
 + git-fetch: be even quieter.
 + make display of total transferred more accurate
 + sideband.c: ESC is spelled '\033' not '\e' for portability.
 + fix display overlap between remote and local progress

* bg/format-patch-N (Tue Nov 6 10:04:24 2007 +1100) 3 commits
 + Rearrange git-format-patch synopsis to improve clarity.
 + format-patch: Test --[no-]numbered and format.numbered
 + format-patch: Add configuration and off switch for --numbered

* lt/rev-list-interactive (Mon Nov 5 13:22:34 2007 -0800) 4 commits
 + revision walker: mini clean-up
 + Enhance --early-output format
 + Add "--early-output" log flag for interactive GUI use
 + Simplify topo-sort logic

* db/remote-builtin (Tue Nov 6 20:29:20 2007 -0500) 6 commits
 + Reteach builtin-ls-remote to understand remotes
 + Build in ls-remote
 + Use built-in send-pack.
 + Build-in send-pack, with an API for other programs to call.
 + Build-in peek-remote, using transport infrastructure.
 + Miscellaneous const changes and utilities

With the "ls-remote origin" fix at its tip, this should be
ready.

* jk/terse-push (Thu Nov 8 01:38:12 2007 -0800) 7 commits
 + send-pack: segfault fix on forced push
 + send-pack: require --verbose to show update of tracking refs
 + receive-pack: don't mention successful updates
 + more terse push output

With the segfault fix at its tip, I think this is ready.  This
depends on the early parts of db/remote-builtin series.

* jc/stash-create (Wed Nov 7 15:10:27 2007 -0600) 5 commits
 + git-stash: Fix listing stashes
 + git-merge: no reason to use cpio anymore
 + Revert "rebase: allow starting from a dirty tree."
 + rebase: allow starting from a dirty tree.
 + stash: implement "stash create"

The end result of this series is just to remove one use of cpio
in our scripts; this should be ready.

* gh/cvsimport-user (Thu Nov 8 13:15:20 2007 -0700) 1 commit
 + git-cvsimport: fix handling of user name when it is not set in
   CVSROOT

* rr/cvsexportcommit-w (Wed Oct 31 23:12:20 2007 +0100) 1 commit
 + cvsexportcommit: Add switch to specify CVS workdir

* ds/checkout-upper (Fri Nov 9 20:12:28 2007 +1100) 2 commits
 + git-checkout: Test for relative path use.
 + git-checkout: Support relative paths containing "..".

This will allow you to stay in a subdirectory and checking out
paths in directories outside.  With Dscho's "git status" that
shows relatives paths (in kh/commit series), this would make
cutting and pasting easier.

* mh/retag (Sun Nov 4 01:11:15 2007 +0100) 2 commits
 + Add tests for git tag
 + Reuse previous annotation when overwriting a tag

* jc/maint-add-sync-stat (Sun Nov 11 18:44:16 2007 -0800) 3 commits
 + t2200: test more cases of "add -u"
 + git-add: make the entry stat-clean after re-adding the same
   contents
 + ce_match_stat, run_diff_files: use symbolic constants for
   readability

Meant to eventually go to 'maint'.  I added tests so now this
series can go to 'next'.

* bs/maint-t7005 (Sun Nov 11 18:38:11 2007 +0100) 1 commit
 + t7005-editor.sh: Don't invoke real vi when it is in GIT_EXEC_PATH

Meant to eventually go to 'maint'.

* sp/maint-plug-traverse-commit-list-leak (Fri Nov 9 06:06:10 2007 -0500) 1 commit
 + Fix memory leak in traverse_commit_list

Meant to eventually go to 'maint'.

* rv/maint-index-commit (Sun Nov 11 13:28:08 2007 +0100) 1 commit
 + Make GIT_INDEX_FILE apply to git-commit

Meant to eventually go to 'maint'.  The test needs to be run
with Kristian's rewrite in C to catch any regression.


----------------------------------------------------------------
[Still actively cooking]

* ph/parseopt-sh (Thu Nov 8 23:04:31 2007 -0800) 16 commits
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

The rate of incoming changes to fix breakage with this topic has
slowed down, which is a good indication that this is getting
ready.

* sp/fetch-fix (Sun Nov 11 02:29:47 2007 -0500) 6 commits
 + git-fetch: avoid local fetching from alternate (again)
 + rev-list: Introduce --quiet to avoid /dev/null redirects
 + run-command: Support sending stderr to /dev/null
 + git-fetch: Always fetch tags if the object they reference exists
 + Merge branch 'sp/maint-plug-traverse-commit-list-leak' into
   sp/fetch-fix

This should restore the traditional behaviour of git-fetch in
the C rewrite series.

* js/rebase-detached (Thu Nov 8 18:19:08 2007 +0000) 1 commit
 + rebase: operate on a detached HEAD

----------------------------------------------------------------
[Approaching 'next']

* kh/commit (Sun Nov 11 17:36:52 2007 +0000) 12 commits
 - builtin-commit: Add newline when showing which commit was created
 - builtin-commit: resurrect behavior for multiple -m options
 - builtin-commit --s: add a newline if the last line was not a S-o-b
 - builtin-commit: fix --signoff
 - git status: show relative paths when run in a subdirectory
 - builtin-commit: fix author date with --amend --author=<author>
 - builtin-commit: Refresh cache after adding files.
 - builtin-commit: fix reflog message generation
 - launch_editor(): read the file, even when EDITOR=:
 - Port git commit to C.
 - Export launch_editor() and make it accept ':' as a no-op editor.
 - Add testcase for ammending and fixing author in git commit.

Dscho fixed a handful obvious glitches.  I am hoping that this
series should be in "testable" shape now.  Will merge to "next"
after giving it a final round of eyeballing.

* sp/refspec-match (Sun Nov 11 15:01:48 2007 +0100) 4 commits
 - refactor fetch's ref matching to use refname_match()
 - push: use same rules as git-rev-parse to resolve refspecs
 - add refname_match()
 - push: support pushing HEAD to real branch name

This changes the semantics slightly but I think it is a move in
the right direction.

* dz/color-addi (Sat Nov 10 18:03:44 2007 -0600) 3 commits
 - Added diff hunk coloring to git-add--interactive
 - Let git-add--interactive read colors from .gitconfig
 - Added basic color support to git add --interactive

* aw/mirror-push (Fri Nov 9 23:32:57 2007 +0000) 16 commits
 - git-push: add documentation for the newly added --mirror mode
 - Add tests for git push'es mirror mode
 - git-push: plumb in --mirror mode
 - Teach send-pack a mirror mode

Looking good.

This depends on Jeff's "even terser push output" series which in
turn depends on Daniel's "rewrite ls-remote and send-pack to
build them in" series, both of which should graduate to 'master'
hopefully shortly.

* ph/diffopts (Wed Nov 7 11:20:32 2007 +0100) 6 commits
 - Reorder diff_opt_parse options more logically per topics.
 - Make the diff_options bitfields be an unsigned with explicit
   masks.
 + Use OPT_BIT in builtin-pack-refs
 + Use OPT_BIT in builtin-for-each-ref
 + Use OPT_SET_INT and OPT_BIT in builtin-branch
 + parse-options new features.

Although I found the whole series reasonable, I parked the later
parts of the series in 'pu' because diff is one of the more
important parts of the system.

* cr/tag-options (Fri Nov 9 14:42:56 2007 +0100) 1 commit
 - Make builtin-tag.c use parse_options.

This changes the handling of multiple -m option without much
good reason.  It should be a simple fix, once we know what we
want.  I think the existing behaviour of refusing multiple -m
is probably the most sane at this point.

* sb/clean (Tue Nov 6 23:18:51 2007 -0600) 1 commit
 - Make git-clean a builtin

----------------------------------------------------------------
[Stalled]

* bs/maint-commit-options (Mon Nov 5 20:36:33 2007 +0100) 1 commit
 - git-commit.sh: Fix usage checks regarding paths given when they do
   not make sense

This is meant to go to 'maint' but needs test script to exhibit
the existing breakage and demonstrate the fix.

The test will help catching future regression even after we
replace git-commit with Kristian's rewrite in C.

* nd/maint-work-tree-fix (Sat Nov 3 20:18:06 2007 +0700) 1 commit
 + Add missing inside_work_tree setting in setup_git_directory_gently

This is meant to go to 'maint' but needs test script to exhibit
the existing breakage and demonstrate the fix.

* jc/spht (Fri Nov 2 17:46:55 2007 -0700) 3 commits
 + core.whitespace: add test for diff whitespace error highlighting
 + git-diff: complain about >=8 consecutive spaces in initial indent
 + War on whitespace: first, a bit of retreat.

Teaching "git apply --whitespace=[warn|strip]" to honor the same
configuration would be a good addition, but this could go to
'master' as is.

----------------------------------------------------------------
[Others]

* mh/rebase-skip-hard (Thu Nov 8 08:03:06 2007 +0100) 1 commit
 - Do git reset --hard HEAD when using git rebase --skip

Some people on the list may find this debatable.

* jc/branch-contains (Wed Nov 7 14:58:09 2007 -0800) 1 commit
 - git-branch --with=commit

I did this just for my own fun.

* jc/maint-format-patch-encoding (Fri Nov 2 17:55:31 2007 -0700) 2 commits
 - test format-patch -s: make sure MIME content type is shown as
   needed
 - format-patch -s: add MIME encoding header if signer's name
   requires so

This is to apply to 'maint' later; the equivalent fix is already
in 'master'.

* ss/dirty-rebase (Thu Nov 1 22:30:24 2007 +0100) 3 commits
 - Make git-svn rebase --dirty pass along --dirty to git-rebase.
 - Implement --dirty for git-rebase--interactive.
 - Introduce --dirty option to git-rebase, allowing you to start from
   a dirty state.

This seems to be optimized for the --dirty case too much.  I'd
prefer an implementation that make rebases without --dirty to
pay no penalty (if that is possible, otherwise "as little as
possible").

* js/reflog-delete (Wed Oct 17 02:50:45 2007 +0100) 1 commit
 + Teach "git reflog" a subcommand to delete single entries

* jc/nu (Sun Oct 14 22:07:34 2007 -0700) 3 commits
 - merge-nu: a new merge backend without using unpack_trees()
 - read_tree: take an explicit index structure
 - gcc 4.2.1 -Werror -Wall -ansi -pedantic -std=c99: minimum fix

* jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
 - pathspec_can_match(): move it from builtin-ls-tree.c to tree.c
 - ls-tree.c: refactor show_recursive() and rename it.
 - tree-diff.c: split out a function to match a single pattern.

* jk/rename (Tue Oct 30 00:24:42 2007 -0400) 3 commits
 - handle renames using similarity engine
 - introduce generic similarity library
 - change hash table calling conventions
