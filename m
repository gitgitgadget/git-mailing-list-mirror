From: Junio C Hamano <junkio@cox.net>
Subject: What's new in git.git
Date: Sun, 05 Feb 2006 23:52:01 -0800
Message-ID: <7vbqxkapr2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 06 08:52:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F61AO-0007fb-EF
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 08:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWBFHwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 02:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWBFHwE
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 02:52:04 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:49141 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750708AbWBFHwD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2006 02:52:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060206075045.QDDP20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Feb 2006 02:50:45 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15652>

I was planning to do a 1.2.0 this weekend, but things slipped.
But in a good way.  We've had quite a long but good discussion
on how people expect "git commit paths..." to behave, and along
the way the command learned a couple of new tricks.

In 1.2.0, there will be three major changes that might surprise
people who are still using 1.1.0 based releases (e.g. 1.1.6).
People who followed the list traffic and/or the master branch
are familiar with them already:

 * Checkout -m option.  This allows you to switch branches when
   you have local changes to paths that are different in the
   current branch and new branch.

 * Add -c and --cc to diff-tree and diff-files.  They give the
   "combined diff" output that shows merges more human readably.

 * git-commit updates.

   - Allow git-commit from a subdirecotry.

   - Aborted "git-commit -a" leaves the index as it was.

   - "git commit --only paths..." checks in changes to only
     named paths.  We may later make this default for "git
     commit" with explicit paths.

   - Add --author='A U Thor <author@example.com>' command
     line option.

These are still in "pu" but I am expecting all of them would
graduate to "master" before 1.2.0:

 - git-show (Linus)
 - git-daemon updates (Mark Wooding)
 - git-http-fetch various fixes (Mark Wooding)
 - git-commit updates
 - git-read-tree --aggressive to speed up resolve merger
 - git-fmt-merge-msg to optionally put shortlog in merge commit log
 - fix git-rev-list --parents | git-diff-tree --stdin
 - git-rerere
