From: Junio C Hamano <junkio@cox.net>
Subject: Summary of core GIT while you are away.
Date: Sat, 14 May 2005 03:51:14 -0700
Message-ID: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@ucw.cz, <braddr@puremagic.com>, <nico@cam.org>,
	<david@dgreaves.com>
X-From: git-owner@vger.kernel.org Sat May 14 12:51:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWuFB-0000Iu-FG
	for gcvg-git@gmane.org; Sat, 14 May 2005 12:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVENKvm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 06:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbVENKvm
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 06:51:42 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:15760 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262486AbVENKvg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 06:51:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514105115.FDOC1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 May 2005 06:51:15 -0400
To: torvalds@osdl.org
cc: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hoping that you had a good time during your vacation, and at the
same time also hoping to help you catch up with GIT traffic,
here is my version of the summary of things that happened in the
GIT community around core GIT [*1*].

 - Just when I was forced to discontinue git-jc tree because my
   ISP webspace was running out, Petr Baudis started git-pb tree
   hosted at kernel.org next to his cogito repository, promising
   to pick up and keep good bits from the mailing list traffic.

   He's been doing quite a good job at it and if you pull from
   his tree, you will not miss anything worth keeping.  I can
   personally vouch for the crap-free-ness of his tree up to
   commit 95649d6cf9ec68f05d1dc57ec1b989b8d263a7ae (not that I
   suspect Petr will put crap in the tree after that, but that
   is the head as of this writing).  They consist of half
   bugfixes and half enhancements; all of them help Porcelain
   layers and end users.  Old git-jc tree has all been sucked
   into git-pb before being shut down, so we did not lose
   anything from there either.

 - A notable change you need to adjust your scripts and .profile
   to is that GIT environment variable names have changed.  All
   of them now have GIT_ as prefix.  Old names continue to work
   for now, though.

 - Nicolas Pitre's deltification patch is still cooking and in
   its latest incarnation it looked quite promising to me (the
   impact to the core is kept reasonably small and cleanly
   isolated).  Once fsck is made aware of it in the next round,
   I expect it to be ready to merge.

 - Brad Roberts has been working on libification to remove the
   assumption of having a single active_cache array.  I have
   minor qualms about it (I think it should also be tied with
   the index.lock handling for updates), but other than that, it
   looked admirably cleanly done.  I expect it to be in a
   mergeable state in the next round if/when he catches up with
   the tip of git-pb tree.

 - David Greaves has done all the heavy lifting for core GIT
   documentation.  It now is hosted at kernel.org with a nice
   web interface.

 - I have sent out about a dozen patches Petr has not caught up,
   mostly because we work in different timezones.  Other than
   that I have not seen anything immediately mergeable to the
   core GIT in the mailing list traffic.

 - Also you see names of many people in the git-pb log who
   contributed bugfixes and enhancements.  I am not belittling
   their contributions, but just not going to repeat what you
   can get from the log yourself.

That's about it.  Now please start pulling from 

	rsync://rsync.kernel.org/pub/scm/cogito/git-pb.git/

[Footnote]

*1* Porcelain layer seems to have had many more interesting
discussions, but I am not qualified to comment on them (I was
not following most of them).

