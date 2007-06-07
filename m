From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Wed, 06 Jun 2007 19:07:42 -0700
Message-ID: <7vfy54tt3l.fsf@assigned-by-dhcp.cox.net>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	<7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
	<7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
	<7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
	<7virac547s.fsf@assigned-by-dhcp.cox.net>
	<7v6466oygl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 04:08:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw7Pt-00080x-GO
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 04:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758455AbXFGCHu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 22:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935352AbXFGCHu
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 22:07:50 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:48646 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758455AbXFGCHt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 22:07:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070607020750.SAZQ7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 22:07:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8S7j1X00G1kojtg0000000; Wed, 06 Jun 2007 22:07:48 -0400
X-master-at: d44c782bbd6b0e806e056f9e8ff8cd8e426e67a3
X-next-at: d9fa4a82f42e4043c4946207a083bcb4169fc383
In-Reply-To: <7v6466oygl.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 02 Jun 2007 14:09:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49337>

Probably a few topics from the following will graduate to
'master' this weekend, but otherwise I expect that I'll be
extremely slow and won't be doing much git next week.

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

"pu" also contains "pu" from git-gui as of tonight.

* ar/clone (Wed Jun 6 16:39:05 2007 -0700) 1 commit
 - Fix clone to setup the origin if its name ends with .git

This is meant to be merged to 'maint' as part of 1.5.2.2, but I
am taking things slowly.

* js/merge (Tue Jun 5 03:37:13 2007 +0100) 1 commit
 + git-merge-file: refuse to merge binary files

This series needs to be cherry-picked to 'maint' at some point.

* js/filter (Wed Jun 6 20:38:35 2007 +0200) 8 commits
 + filter-branch: also don't fail in map() if a commit cannot be
   mapped
 + filter-branch: Use rev-list arguments to specify revision ranges.
 + filter-branch: fix behaviour of '-k'
 + filter-branch: use $(($i+1)) instead of $((i+1))
 + chmod +x git-filter-branch.sh
 + filter-branch: prevent filters from reading from stdin
 + t7003: make test repeatable
 + Add git-filter-branch

Johannes & Johannes work well together ;-).  Will push out to
'master' shortly.

* lh/submodule (Wed Jun 6 11:13:02 2007 +0200) 2 commits
 + git-submodule: clone during update, not during init
 + git-submodule: move cloning into a separate function

Will push out to 'master' shortly.

* aj/pack (Sun Jun 3 20:21:41 2007 +0200) 1 commit
 + pack-check: Sort entries by pack offset before unpacking them.

Makes "git fsck --full" go a lot faster.  Will push out to
'master' shortly.

* aw/cvs (Mon Jun 4 10:01:49 2007 +0100) 3 commits
 + cvsimport: add <remote>/HEAD reference in separate remotes more
 + cvsimport: update documentation to include separate remotes option
 + cvsimport: add support for new style remote layout

Makes the ref layout consistent with git managed branches;
git-svn already does this, I think.

* ep/cvstag (Sun Jun 3 02:56:36 2007 -0400) 1 commit
 + Use git-tag in git-cvsimport

Instead of handrolling a tag using lower-level mktag, this uses
git-tag.

* jh/tag (Mon Jun 4 02:54:56 2007 +0200) 6 commits
 + Add fsck_verify_ref_to_tag_object() to verify that refname matches
   name stored in tag object
 + git-mktag tests: Fix and expand the mktag tests according to the
   new tag object structure
 + Documentation/git-mktag: Document the changes in tag object
   structure
 + git-fsck: Do thorough verification of tag objects.
 + git-show: When showing tag objects with no tag name, show tag
   object's SHA1 instead of an empty string
 + Refactor git tag objects; make "tag" header optional; introduce
   new optional "keywords" header

Tag refactoring.  Looking good.

* ml/worktree (Wed Jun 6 23:29:59 2007 +0200) 8 commits
 - setup_git_directory: fix segfault if repository is found in cwd
 - test GIT_WORK_TREE
 - extend rev-parse test for --is-inside-work-tree
 - Use new semantics of is_bare/inside_git_dir/inside_work_tree
 - introduce GIT_WORK_TREE to specify the work tree
 - test git rev-parse
 - rev-parse: introduce --is-bare-repository
 - rev-parse: document --is-inside-git-dir

Allows you to have GIT_DIR environment that points at a
repository at an unrelated location, and still lets you work in
a working tree subdirectory by pointing its root with another
environment variable.  It is an intrusive set of changes.

* ei/worktree+filter (Wed Jun 6 09:16:56 2007 +0200) 1 commit
 - filter-branch: always export GIT_DIR if it is set

This is "early integration" that depends on two other topics
(GIT_WORK_TREE and filter-branch).  This needs to be merged when
both topics graduate to 'master'.

* dh/repack (Fri May 25 14:40:24 2007 -0700) 1 commit
 - Enhance unpack-objects for live repo and large objects

* jc/blame (Fri Apr 20 16:25:50 2007 -0700) 4 commits
 - blame: show log as it goes
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel
