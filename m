From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Fri, 30 Nov 2007 18:37:52 -0800
Message-ID: <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 03:38:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyIFO-00045l-N5
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758750AbXLACiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 21:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758740AbXLACiE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:38:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40409 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758695AbXLACiB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 21:38:01 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BF4A92EF;
	Fri, 30 Nov 2007 21:38:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E1BA9B972;
	Fri, 30 Nov 2007 21:38:20 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66690>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

----------------------------------------------------------------
[Graduated to 'master']

* jk/maint-cvsimport-fix (Wed Nov 28 13:56:28 2007 -0500)

----------------------------------------------------------------
[New Topics]

* jc/api-doc (Sat Nov 24 23:48:04 2007 -0800) 1 commit
 - Start preparing the API documents.

The primary reason of this series is because I think we made the system
a lot less approachable by losing hackability.  Although we still have
sample scripts in contrib/example for use of plumbing in scripts, they
will not help aspiring git-hacker-wannabees when our primary attention
has already shifted to moving things to C.

This currently consists of mostly stubs, although I wrote about a few
topics as examples.

* js/fast-export (Sun Nov 25 22:37:20 2007 +0100) 1 commit
 - Add 'git fast-export', the sister of 'git fast-import'

This needs something like 9e42d6a1c53dadd409fab11cc76e0eba9ec15365
(sha1_file.c: Fix size_t related printf format warnings) to compile, I
think, but I haven't tried to fix it (parked in pu)

* js/pull-rebase (Wed Nov 28 13:11:07 2007 +0000) 1 commit
 + Teach 'git pull' about --rebase

Resurrected from an old thread (thanks, Dscho and Nana for reminding).

* jk/builtin-alias (Fri Nov 30 11:22:58 2007 -0500) 1 commit
 + Support builtin aliases

Cute hack.  I'd like to have "git less" here.

* wc/rebase-insn (Sat Nov 24 00:38:50 2007 +1100) 2 commits
 + Mention that git-rm can be an appropriate resolution as well as
   git-add.
 + revert/cherry-pick: Allow overriding the help text by the calling
   Porcelain

Patches from Wincent and David Symonds.  They both improve the help
message upon conflicts.

* js/prune-expire (Thu Nov 29 20:59:55 2007 +0000) 1 commit
 + Add "--expire <time>" option to 'git prune'

This would help making unmonitored pruning jobs safer.  The expiration
does not kick in unless you explicitly ask, which is a suitable default
for interactive session where the users who run "git prune" knows what
they are doing.

* ew/svn (Thu Nov 22 13:44:42 2007 +0000) 4 commits
 - git-svn: add support for pulling author from From: and Signed-off-
   by:
 - git-svn: add a show-externals command.
 - git-svn now reads settings even if called in subdirectory
 - git-svn: Remove unnecessary Git::SVN::Util package

Picked up from the list with Eric's Acks, but haven't merged, as my next
pull from Eric would hopefully bring them in anyway.

* mw/cvsserver (Fri Nov 23 04:12:54 2007 -0500) 1 commit
 - git-cvsserver runs hooks/post-receive

Queue in 'pu', but lacks a corresponding support for hooks/post-update,
which we haven't declared deprecation.

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

I think this is a sane thing to do in the longer term.  Will be in
'next' after v1.5.4.  I think "leave porcelain on PATH" might be also a
good thing as a transition measure, but not strictly necessary.  If we
were to do so, I'd like to see a patch that consolidates the knowledge
of what's Porcelain and what's common in one place before that.
Currently:

 (1) generate-cmdlist.sh has its own built-in list for common command
     names to be used in "git help";

 (2) Documentation/cmd-list.perl has more comprehensive classification to
     generate git(7) manpage and git.html.  It needs to also know what's
     deprecated.

 (3) contrib/completion/git-completion.bash has a list of "uncommon
     commands", commands not to be shown to the user.

which is a mess.  I think a good approach would be to separate the
command list part from Documentation/cmd-list.perl script and move it to
the toplevel, and have these three read from it.  Maybe git-help command
can learn "--classify" option to show that command list with
classification, so that git-completion.bash and other scripts can use it
without hardcoding the command list in.

Incidentally, if we do not install dashed form of built-ins anywhere
(which is not this series is about --- this is just moving them out of
user's PATH), "git help -a" will stop showing them.  I am not enthused
about removing the hardlinks to built-ins to begin with, but people who
want such a change need to first modify help.c:list_commands() to pick
up builtins without having git-foo hardlinks in gitexecdir.  This may
need to happen anyway as mingw fallouts, though ;-).

* jc/color (Tue Nov 27 22:41:05 2007 -0800) 2 commits
 + git-config --get-color: get configured color
 + "color.diff = true" is not "always" anymore.

Hopefully Dan's colored "git add -i" can rebuild on top of these.

* js/dashless (Fri Nov 30 12:08:20 2007 +0000) 1 commit
 - transport.c: call dash-less form of receive-pack and upload-pack
   on remote

Not field tested by anybody nor came with any tests, but this is an
important component to move git-foo commands out of user's PATH.

* dc/gitweb (Mon Nov 26 20:42:06 2007 +0800) 1 commit
 - gitweb: the commitdiff is very commonly used, it's needed on
   search page, too

Queue in 'pu', waiting for Acks from gitweb guys.

* jc/docmake-perl (Fri Nov 30 15:48:17 2007 -0800) 1 commit
 - Run the specified perl in Documentation/

Queue in 'pu', waiting for Ack from Merlyn.

----------------------------------------------------------------
[Will cook further in 'next' and then merge to 'master' soon]

* cr/tag-options (Sun Nov 25 23:50:58 2007 -0500) 4 commits
 + git-tag: test that -s implies an annotated tag
 + "git-tag -s" should create a signed annotated tag
 + builtin-tag: accept and process multiple -m just like git-commit
 + Make builtin-tag.c use parse_options.

Will merge to 'master' over the weekend.

* jc/branch-contains (Sun Nov 18 22:22:00 2007 -0800) 3 commits
 + git-branch --contains: doc and test
 + git-branch --contains=commit
 + parse-options: Allow to hide options from the default usage.

Contains Pierre's "hidable options with --help-all" patch.
Will merge to 'master' over the weekend.

* jc/move-gitk (Sat Nov 17 10:51:16 2007 -0800) 1 commit
 + Move gitk to its own subdirectory

I have a phoney Makefile under the subdirectory for gitk, but
hopefully with the next pull from Paulus I can replace it with
the real thing, along with the i18n stuff.
Will merge to 'master' over the weekend.

* js/rebase-i-rerere (Thu Nov 22 11:18:10 2007 +0000) 1 commit
 + rebase -i: give rerere a chance

I haven't seen rerere kick in since I merged this to 'next' (which I
almost always run).  Success stories?

* tt/help (Sun Nov 11 19:57:57 2007 -0500) 2 commits
 + Remove hint to use "git help -a"
 + Make the list of common commands more exclusive

Some people on the list may find the exact list of commands
somewhat debatable.

* kh/commit (Wed Nov 28 22:13:08 2007 +0100) 27 commits
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

Now comes with a few more fixes since the last issue of "What's in".
This should be production ready, but commit is so central, so let's wait
a bit longer until the bugfixes completely stop flowing in.  The
earliest will be next Wednesday.

* js/export-with-assignment (Wed Nov 28 15:56:11 2007 +0000) 1 commit
 + Replace instances of export VAR=VAL with VAR=VAL; export VAR

This will make scripts easier to read for traditionalists (that's me), at
the same time working around a bug in BSD ash where VAL is word split if
you write "export VAR=VAL".

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

* wc/add-i (Thu Nov 29 13:00:38 2007 +0100) 32 commits
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
series near the tip (they interact with each other somewhat, and it is
very likely that builtin commit series will graduate to 'master' before
this series).

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
do and these may be non issues in the real-world usecases.  It could be
that I am worried too much needlessly.  If anybody who is following
'next' has been bitten by the change, please speak up.

* nd/maint-work-tree-fix (Thu Nov 29 19:21:39 2007 +0700) 2 commits
 + Do check_repository_format() early
 + Add missing inside_work_tree setting in setup_git_directory_gently

The tip one needs test script.

----------------------------------------------------------------
[Stalled]

I've dropped a few topics that did not see actions recently.

* js/reflog-delete (Wed Oct 17 02:50:45 2007 +0100) 1 commit
 + Teach "git reflog" a subcommand to delete single entries

* dz/color-addi (Sat Nov 10 18:03:44 2007 -0600) 3 commits
 - Added diff hunk coloring to git-add--interactive
 - Let git-add--interactive read colors from .gitconfig
 - Added basic color support to git add --interactive

There were many good suggestions by Jeff to the updated series;
hopefully we can have replacements of these three that incorporate
Jeff's suggestions, and build on the "git-config --get-color" series.

* jc/diff-pathspec (Sun Nov 25 10:03:48 2007 -0800) 1 commit
 - Making ce_path_match() more useful by accepting globs

This was to allow "git diff-files -- '*.h'" (currently diff family
knows only the leading directory match and not fileglobs), but was shot
down by Alex.  I tend to agree with him.
