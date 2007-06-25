From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Mon, 25 Jun 2007 02:43:57 -0700
Message-ID: <7v645cz7vm.fsf@assigned-by-dhcp.pobox.com>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	<7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
	<7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
	<7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
	<7virac547s.fsf@assigned-by-dhcp.cox.net>
	<7v6466oygl.fsf@assigned-by-dhcp.cox.net>
	<7vfy54tt3l.fsf@assigned-by-dhcp.cox.net>
	<7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com>
	<7v4pl1zsd7.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 11:44:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2l79-0008Pp-Cp
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 11:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbXFYJoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 05:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbXFYJoA
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 05:44:00 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:65489 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbXFYJn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 05:43:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070625094359.UOCU3339.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Jun 2007 05:43:59 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fljx1X0051kojtg0000000; Mon, 25 Jun 2007 05:43:58 -0400
X-master-at: aeb59328453cd4f438345ea79ff04c96bccbbbb8
X-next-at: bf4a0928eea77de890ab1ac908d56057f361b429
In-Reply-To: <7v4pl1zsd7.fsf@assigned-by-dhcp.pobox.com> (Junio C. Hamano's
	message of "Thu, 21 Jun 2007 00:20:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50885>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* js/rebase (Mon Jun 25 01:11:14 2007 +0100) 2 commits
 + Teach rebase an interactive mode
 + Move the pick_author code to git-sh-setup

Will merge.

* rs/diff (Mon Jun 25 00:23:34 2007 +0200) 2 commits
 + diff: round down similarity index
 + diffcore-rename: don't change similarity index based on basename
   equality

Will merge.

* lt/run (Sun Jun 24 10:29:33 2007 -0700) 2 commits
 + Check for IO errors after running a command
 + Clean up internal command handling

Will merge.

* ew/svn (Wed Jun 13 02:23:28 2007 -0700) 1 commit
 + git-svn: allow dcommit to retain local merge information

Haven't heard major breakage report, so hopefully can merge by
the end of the month.

* mk/svn (Fri Jun 22 11:15:03 2007 +0200) 1 commit
 - git-svn: honor ~/.subversion/ client cert file settings.

Waiting for ACK from git-svn people.

* ml/worktree (Fri Jun 8 22:57:55 2007 +0200) 9 commits
 + make git barf when an alias changes environment variables
 + setup_git_directory: fix segfault if repository is found in cwd
 + test GIT_WORK_TREE
 + extend rev-parse test for --is-inside-work-tree
 + Use new semantics of is_bare/inside_git_dir/inside_work_tree
 + introduce GIT_WORK_TREE to specify the work tree
 + test git rev-parse
 + rev-parse: introduce --is-bare-repository
 + rev-parse: document --is-inside-git-dir
* ei/worktree+filter (Wed Jun 6 09:16:56 2007 +0200) 9 commits
 + filter-branch: always export GIT_DIR if it is set

I've been resisting these due to the size of the series, but I
think the definition of is-bare is a bit saner than what we have
in 'master', and I think it is the right direction in the longer
term.  HOWEVER, I am not sure about the implementation and
corner cases, e.g. what should it do in receive-pack?  You
cannot rely on user setting GIT_WORK_TREE environment -- rather,
receive-pack is responsible for setting up a sane environment
for other commands to work in.

* jc/quote (Sun Jun 24 15:11:24 2007 -0700) 1 commit
 + Add core.quotepath configuration variable.

This will get rid of "Why is my UTF-8 pathnames are munged"
complaints.  Will wait for a while, maybe merge after 1.5.3.  I
believe the output from this is still readable by an unpatched
git-apply, but I would want to be absolutely sure.

* jo/init (Thu Jun 7 07:50:30 2007 -0500) 2 commits
 - Quiet the output from git-init when cloning, if requested.
 - Add an option to quiet git-init.

I am not very much interested in this but I do not have any
strong or otherwise feeling against it either.

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

Backburnered.
