From: Petr Baudis <pasky@ucw.cz>
Subject: [ANNOUNCE] Cogito-0.11.2
Date: Thu, 9 Jun 2005 01:07:25 +0200
Message-ID: <20050608230725.GR982@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 09 01:06:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg9bH-0002V3-Ce
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 01:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVFHXId (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 19:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVFHXId
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 19:08:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26596 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261379AbVFHXH2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 19:07:28 -0400
Received: (qmail 9635 invoked by uid 2001); 8 Jun 2005 23:07:25 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  I'm happy to announce Cogito-0.11.2, next version of my SCMish layer
over Linus' GIT tree history storage tool. You can get it as usual on

	kernel.org/pub/software/scm/cogito/

or by doing cg-update in your cogito.git repository.

  The changes include especially some bugfixes and portability and
performance enhancements, as well as all the sweet stuff from Linus.

  Note that I discovered a bug few minutes after releasing (as usual).
cg-log won't work correctly if ran with some files specified (the
"cg-log file" usage). I think it actually does not get used like this so
frequently, so I don't think it's worth another release by itself. But
expect new release as soon as some non-trivial amount of bugfixes piles
up (including core git bugfixes), quite soon hopefully.


  Here's git-rev-list --pretty HEAD ^cogito-0.11.1 | git-shortlog
(BTW, Dan, what about another cg-log option for git-shortlog output? ;-):


C. Cooke:
  Check whether the git repository is present before executing the command

Catalin Marinas:
  cg-commit: Fix the log file readin from stdin
  [PATCH Cogito] Add -f parameter also to cg-update

Chris Wedgwood:
  cogitio: sh != bash

Christian Meder:
  Miniscule correction of diff-format.txt

Dan Holmsand:
  Make cg-add use xargs -0

Daniel Barkalow:
  Document git-ssh-pull and git-ssh-push
  -w support for git-ssh-pull/push
  Generic support for pulling refs
  rsh.c environment variable
  Operations on refs
  ssh-protocol version, command types, response code

Eugene Surovegin:
  fix cg-commit new file handling

Jason McMullan:
  Anal retentive 'const unsigned char *sha1'
  Modify git-rev-list to linearise the commit history in merge order.

Jon Seymour:
  three --merge-order bug fixes

Jonas Fonseca:
  cg-commit: prefix pathspec argument with --
  git-diff-cache: handle pathspec beginning with a dash
  git-diff-cache: handle pathspec beginning with a dash
  cg-log: cleanup line wrapping by using bash internals
  Documentation improvements
  Misc cg-log documentation fixes
  Cleanup commit messages with git-stripspace
  [PATCH 10/10] Add -s option to show log summary
  [PATCH 9/10] Move file matching inside the loop.
  [PATCH 8/10] Move the username matching inside the loop
  [PATCH 7/10] Move log printing to separate function
  [PATCH 6/10] Remove the catch all rule
  [PATCH 5/10] Move printing of the commit info line inside the loop
  [PATCH 4/10] First parse all commit header entries then print them
  [PATCH 3/10] Separate handling of author and committer in commit headers
  [PATCH 2/10] Separate handling of tree and parent in commit headers
  [PATCH 1/10] Cleanup conversion to human readable date
  cg-Xnormid: support revision ids specified by date

Junio C Hamano:
  Tests: read-tree -m test updates.
  Documentation: describe diff tweaking (fix).
  Start cvs-migration documentation
  read-tree: update documentation for 3-way merge.
  read-tree: save more user hassles during fast-forward.
  index locking like everybody else
  3-way merge tests for new "git-read-tree -m"?
  rename git-rpush and git-rpull to git-ssh-push and git-ssh-pull
  Documentation: describe git extended diff headers.
  Documentation: describe diff tweaking.
  pull: gracefully recover from delta retrieval failure.
  diffcore-break.c: various fixes.
  diff.c: -B argument passing fix.
  diff.c: locate_size_cache() fix.
  diff: Update -B heuristics.
  diff: Clean up diff_scoreopt_parse().
  diff: Fix docs and add -O to diff-helper.
  Tweak count-delta interface
  Find size of SHA1 object without inflating everything.
  Handle deltified object correctly in git-*-pull family.

Linus Torvalds:
  Remove MERGE_HEAD after committing merge
  Make "git commit" work correctly in the presense of a manual merge
  cvs-migration: add more of a header to the "annotate" discussion
  Leave merge failures in the filesystem
  Fix SIGSEGV on unmerged files in git-diff-files -p
  Make default merge messages denser.
  git-apply: creatign empty files is nonfatal
  Talk about "git cvsimport" in the cvs migration docs
  git-read-tree: -u without -m is meaningless. Don't allow it.
  git-read-tree: make one-way merge also honor the "update" flag
  Add CVS import scripts and programs
  git-ssh-push/pull: usability improvements
  git-resolve-script: stop when the automated merge fails
  Make fetch/pull scripts terminate cleanly on errors
  git-resolve-script: don't wait for three seconds any more
  git-read-tree: some "final" cleanups
  git-read-tree: simplify merge loops enormously
  Add "__noreturn__" attribute to die() and usage()
  git-rev-list: make sure to link with ssl libraries
  Fix off-by-one in new three-way-merge updates
  Three-way merge: fix silly bug that made trivial merges not work
  Fix entry.c dependency and compile problem
  git-read-tree: fix up two-way merge
  More work on merging with git-read-tree..
  Make fiel checkout function available to the git library
  git-read-tree: fix up three-way merge tests
  git-read-tree: be a lot more careful about merging dirty trees
  diff 'rename' format change.
  git-apply: consider it an error to apply no changes
  git-apply: fix rename header parsing
  git-apply: actually apply patches and update the index
  git-apply: fix apply of a new file
  git-apply: find offset fragments, and really apply them
  git-apply: first cut at actually checking fragment data
  git-fsck-cache: complain if no default references found
  pretty_print_commit: add different formats
  git-shortlog: add name translations for 'sparse' repo
  Add git-shortlog perl script
  git-rev-list: allow arbitrary head selections, use git-rev-tree syntax
  Clarify git-diff-cache semantics in the tutorial.

Mark Allen:
  Modify cg-Xlib for non-GNU date.

Michal Rokos:
  [cogito] Sync objects only when needed
  [cogito] paged output for cg-diff
  Abstracted out $PAGER invocation to a pager() function

Petr Baudis:
  Fix cg-log called on specified files
  cogito-0.11.2
  Added trivial cg wrapper
  Use portable sed stuff in cg-log Signed-off-by highlighting
  showdate() now uses $(()) instead of $(expr)
  Fixed cg-log -u
  cg-merge now sometimes allows tree merge + local changes
  Add the t6001 testcase which got missed out at the last merge.
  Move commit line processing to process_commit_line
  Improved cg-Xmergefile
  Fix git-merge-one-file permissions auto-merging
  Fix cg-patch reverting file removal
  Reindent print_commit_log() body
  cg-log is now pure git-rev-list --pretty=raw frontend
  Fix cg-commit doing shell expansion on -m arguments
  Fix mismerged git-r* -> git-ssh-* rename in Makefile
  Move print_commit_log() in cg-log
  Fix an errorneous cg-clone example in the README
  Make git-update-cache --force-remove regular
  Portability sed fix in cg-commit
  Improve git-rev-list --header output
  Implement cg-rm -n for untracking files
  Fixed cg-Xnormid " " call
  cg-commit now updates cache separately for different change types
  Pass revisions to commit-id, parent-id, tree-id and cg-Xnormid quoted
  Do rm -f in make uninstall
  make dist will now produce tarball with sensible name

Rene Scharfe:
  git-tar-tree: do only basic tests in t/t5000-git-tar-tree.sh
  git-tar-tree: fix write_trailer
  git-tar-tree: add a test case
  git-tar-tree: small doc update
  git-tar-tree: cleanup write_trailer()

Sven Verdoolaege:
  git-cvs2git: create tags

Timo Hirvonen:
  Use ntohs instead of htons to convert ce_flags to host byte order


  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
