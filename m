From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sat, 03 Nov 2007 21:14:19 -0700
Message-ID: <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 05:14:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoWsl-0005CM-OO
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 05:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXKDEOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 00:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbXKDEOZ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 00:14:25 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:35228 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbXKDEOY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 00:14:24 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BE8092F0;
	Sun,  4 Nov 2007 00:14:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E10578E030;
	Sun,  4 Nov 2007 00:14:42 -0400 (EDT)
X-master-at: e3d6d56f1c2097f13a427e158638e5e0918e5705
X-next-at: 06ea6ba9cf46ef51981db89c4cd9fe1d7fdf100c
In-Reply-To: <7vmytycykt.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 31 Oct 2007 22:41:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63341>

(Note.  I haven't dealt with the patch queue from today yet)

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* cp/p4 (Thu Nov 1 20:43:14 2007 -0700) 2 commits
 + git-p4: Detect changes to executable bit and include them in p4
   submit.
 + git-p4: Add a helper function to parse the full git diff-tree
   output.

I would like to get success stories from p4 users before pushing
this out.

* rr/cvsexportcommit-w (Wed Oct 31 23:12:20 2007 +0100) 1 commit
 + cvsexportcommit: Add switch to specify CVS workdir

I would like to get success stories from CVS users before
pushing this out.

* db/remote-builtin (Mon Oct 29 22:03:42 2007 -0400) 4 commits
 + Use built-in send-pack.
 + Build-in send-pack, with an API for other programs to call.
 + Build-in peek-remote, using transport infrastructure.
 + Miscellaneous const changes and utilities

Looked Ok.  Hopefully will be in 'master' shortly.

* np/fetch (Sat Nov 3 01:32:48 2007 -0400) 1 commit
 + git-fetch: more terse fetch output

Will merge to 'master'.

* jn/gitweb (Sat Nov 3 00:41:20 2007 +0100) 9 commits
 + gitweb: Use config file for repository description and URLs
 + gitweb: Read repo config using 'git config -z -l'
 + gitweb: Add tests for overriding gitweb config with repo config
 + gitweb: Use href(-replay=>1, action=>...) to generate alternate
   views
 + gitweb: Use href(-replay=>1, page=>...) to generate pagination
   links
 + gitweb: Easier adding/changing parameters to current URL
 + gitweb: Remove CGI::Carp::set_programname() call from t9500 gitweb
   test
 + gitweb: Add 'status_str' to parse_difftree_raw_line output
 + gitweb: Always set 'from_file' and 'to_file' in
   parse_difftree_raw_line

Will push these out to 'master' over the weekend.

* jc/format-patch-encoding (Fri Nov 2 17:55:31 2007 -0700) 2 commits
 + test format-patch -s: make sure MIME content type is shown as
   needed
 + format-patch -s: add MIME encoding header if signer's name
   requires so

This hopefully fixes a real issue we had at vger recently.

	http://article.gmane.org/gmane.comp.version-control.git/62689

Will merge to 'master' shortly, and then cherry-pick to 'maint'.

* np/pack (Thu Nov 1 23:43:24 2007 -0400) 2 commits
 + pack-objects: get rid of an ugly cast
 + make the pack index version configurable

Will merge to 'master'.

* ss/mailsplit (Thu Nov 1 23:57:45 2007 +0100) 1 commit
 + Make mailsplit and mailinfo strip whitespace from the start of the
   input

Will merge to 'master'.

* lt/rev-list-replay (Fri Nov 2 13:35:17 2007 -0700) 2 commits
 - Support "history replay" for git log commands
 - Simplify topo-sort logic

Need to drop the second one and replace it with today's "Final
output" patch.  The first one should be mergeable to 'master'
immediately and independently.

* dz/color-addi (Mon Oct 22 16:08:01 2007 -0500) 2 commits
 - Let git-add--interactive read colors from .gitconfig
 - Added basic color support to git add --interactive

Further comments on minor issues sent back to the author.

* jc/revert-merge (Fri Nov 2 17:25:24 2007 -0700) 2 commits
 + cherry-pick/revert -m: add tests
 + revert/cherry-pick: work on merge commits as well

Will merge to 'master'.

* jc/stash-create (Thu Nov 1 14:30:30 2007 -0700) 4 commits
 + git-merge: no reason to use cpio anymore
 + Revert "rebase: allow starting from a dirty tree."
 + rebase: allow starting from a dirty tree.
 + stash: implement "stash create"

Dropped the unconditional auto-stash-unstash, but "stash create"
turns out to be a useful alternative to cpio in the git-merge
implementation.

* jc/spht (Fri Nov 2 17:46:55 2007 -0700) 3 commits
 + core.whitespace: add test for diff whitespace error highlighting
 + git-diff: complain about >=8 consecutive spaces in initial indent
 + War on whitespace: first, a bit of retreat.

I actually like the idea of tying this to gitattributes by J
Bruce Fields.  We would want to have such an update before
pushing this out to 'master'.  "diff" alone would not do any
harm but "apply" can reject and/or munge the user input, and we
really would want to get the semantics right with the first
version that appears on 'master'.

* kh/commit (Fri Nov 2 11:33:09 2007 -0400) 3 commits
 - Implement git commit and status as a builtin commands.
 - Export launch_editor() and make it accept ':' as a no-op editor.
 - Add testcase for ammending and fixing author in git commit.

There may be still some glitches left, but it is hopefully
gettng into a "testable without breaking things too much" shape
(which is the definition of 'next').

* ph/parseopt-sh (Fri Nov 2 23:39:52 2007 +0100) 5 commits
 - Migrate git-am.sh to use git-rev-parse --parseopt
 - Migrate git-clone to use git-rev-parse --parseopt
 - Migrate git-clean.sh to use git-rev-parse --parseopt.
 - Update git-sh-setup(1) to allow transparent use of git-rev-parse -
   -parseopt
 - Add a parseopt mode to git-rev-parse to bring parse-options to
   shell scripts.

Together with today's batch which is missing from the above
list, hopefully merge to 'next' over the weekend.

* ss/dirty-rebase (Thu Nov 1 22:30:24 2007 +0100) 3 commits
 - Make git-svn rebase --dirty pass along --dirty to git-rebase.
 - Implement --dirty for git-rebase--interactive.
 - Introduce --dirty option to git-rebase, allowing you to start from
   a dirty state.

This needs tests to primarily make sure that it does not regress
non --dirty case.

* sp/push-refspec (Sun Oct 28 18:46:20 2007 +0100) 6 commits
 - push: teach push to pass --verbose option to transport layer
 - push: teach push to accept --verbose option
 - push: use same rules as git-rev-parse to resolve refspecs
 - add ref_abbrev_matches_full_with_rev_parse_rules() comparing
   abbrev with full ref name
 - rename ref_matches_abbrev() to
   ref_abbrev_matches_full_with_fetch_rules()
 - push: support pushing HEAD to real branch name

Will need to review first.

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

Unchanged.
