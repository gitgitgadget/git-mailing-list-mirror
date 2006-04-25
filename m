From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.3.1
Date: Tue, 25 Apr 2006 01:04:55 -0700
Message-ID: <7v1wvm13o8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 10:05:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYIXf-0007Vk-Sf
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 10:05:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWDYIE6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 25 Apr 2006 04:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWDYIE6
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 04:04:58 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:21220 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751416AbWDYIE5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 04:04:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060425080456.RBKH27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Apr 2006 04:04:56 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19135>

The latest maintenance release GIT 1.3.1 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.3.1.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.3.1-1.$arch.rpm	(RPM)

Just to let people who are new to the game know, 1.3.X (1<=3DX)
series is purely bugfix maintenance on top of 1.3.0 release, and
no new features will be added unless there is a compelling
reason (think of them like 2.6.16.X releases of the kernel,
slightly looser updates criteria).

There are four primary branches in git.git repository.

 * Releases in the 1.3.X series come from the "maint" branch, which
   was forked at 1.3.0.

 * All the new features and improvements start their life as
   topic branches that are merged to the "pu" (proposed updates)
   branch.  They are often incomplete and/or unstable.  You can
   think of "pu" as the -mm.

 * When these topic branches become stable enough, they are
   merged into "next" branch.  I personally run "next" branch
   for my work to trust my data to it, until very close to the
   next feature release.

 * After being cooked for a few days to a week in "next", these
   good changes graduate to the "master" branch.  Some of them
   die while being cooked there, but that does not happen very
   often (bad apples are culled while in "pu").

I make feature release out of "master" branch periodically,
which are tagged as X.Y.0 releases.  At that point, "maint"
branch is forked to prepare X.Y.1 and onward.

If you are an end user, the "maint" releases are the recommended
stale releases, but you could miss out new features quickly.
Please do send in bug reports for them, but do not expect new
cool features to appear there.

If you want to stay current and stable, I would recommend to
track "master".

If you are a git developer, being aware of what is happening in
"next" would often be very helpful.  The infrastructure you plan
to base your change on may be in the process of being updated
and your changes to "master" can become useless when that
happens.

If you are a truly devoted git hacker, picking what is in "pu"
can be exciting and useful from time to time.

Post 1.3.0 "master" branch development currently contains major
rewrite of log/show/whatchanged infrastructure, and will be
getting updated pack-objects, faster write-tree, consolidated
"git diff" that is not a shell script, and hopefully many
others.  To reiterate, they will be part of 1.4.0 and no 1.3.X
series release will have them.

----------------------------------------------------------------

Changes since v1.3.0 are as follows:

Jonas Fonseca:
      Fix filename scaling for binary files

Junio C Hamano:
      git-merge: a bit more readable user guidance.
      pre-commit hook: complain about conflict markers.
      git-commit --amend: two fixes.
      pack-objects: do not stop at object that is "too small"
      mailinfo: decode underscore used in "Q" encoding properly.

Linus Torvalds:
      git-log produces no output

Nicolas Pitre:
      fix pack-object buffer size

Paul Mackerras:
      rev-parse: better error message for ambiguous arguments

Petr Baudis:
      Document git-var -l listing also configuration variables
      Document the configuration file

Santi B=E9jar:
      Reintroduce svn pools to solve the memory leak.

Serge E. Hallyn:
      socksetup: don't return on set_reuse_addr() error

Shawn Pearce:
      Document git-clone --reference
