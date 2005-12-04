From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 0.99.9l aka 1.0rc4
Date: Sun, 04 Dec 2005 01:21:13 -0800
Message-ID: <7vy831p69i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 04 10:21:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eiq3l-0006so-Su
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 10:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVLDJVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 04:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVLDJVP
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 04:21:15 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:26579 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751332AbVLDJVP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2005 04:21:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051204092039.JUSY15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Dec 2005 04:20:39 -0500
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13185>

GIT 0.99.9l aka 1.0rc4 is found at a new location.

RPM
	http://kernel.org:/pub/software/git/RPMS/

Debian [*1*]
	http://kernel.org:/pub/software/git/debian/

This is mostly fixes, with some improvements.  As I said on the
git list earlier, no more major feature/semantics changes after
this is expected until 1.0.

Highlights are:

 - After a conflicting merge, the index file is left unmerged.
   As before, after such conflicting merge, "git diff" can be
   used to view the differences between the half-merged file and
   "our" branch version by default, but now you can say "git
   diff --base" and "git diff --theirs" to view the differences
   since the merge-base version and the other branch's version,
   respectively.

 - git-daemon and other git native protocols allow user-relative
   paths (e.g. git://host/~user/repo).  git-daemon's path
   whitelist check used to be done with the realpath (i.e. what
   getcwd() returns) in 0.99.9k and later "master" branch
   versions, but it was changed back to check against what the
   requester asked.

 - The commands have been future-proofed so that they refuse to
   operate on repositories from future unknown versions, to
   avoid corrupting them by mistake.

 - Bisect can take pathspec to cut down the number of revisions
   that need to be tested.

 - Many low-level commands have been updated to work better from
   subdirectories (much of the barebone porcelain wrappers that
   deal with the whole repository or the whole tree still need
   to be run from the top level, though).

 - Merge used to fail when it removed a file (fixed).

 - When only GIT_OBJECT_DIRECTORY was exported things broke
   since 0.99.9k (fixed).

 - Comes with updated gitk.

[Footnote]

*1* It appears Debian finally has an official maintainer, so I
am inclined to stop building and supplying the debs starting
from the next version --- one less thing to worry about for me.
I hope the Debian side splits the packages along the same line
as we do RPMs.
