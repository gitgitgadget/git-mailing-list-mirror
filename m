From: Junio C Hamano <junkio@cox.net>
Subject: Re: git /objects directory created 755 by default?
Date: Tue, 20 Dec 2005 20:53:36 -0800
Message-ID: <7vr787dp9r.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	<7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
	<7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
	<46a038f90512201828w618a64dexc22a64b8b6bc2b70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 05:54:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EovzE-0003g3-ST
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 05:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVLUExk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 23:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVLUExk
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 23:53:40 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:65532 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751079AbVLUExj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 23:53:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221045259.MMWY3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Dec 2005 23:52:59 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90512201828w618a64dexc22a64b8b6bc2b70@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 21 Dec 2005 15:28:46 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13863>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> I think I owe you an apology and a couple of beers...

Nah, you do not owe me anything.  Does something like this look
good?

-- >8 --
[PATCH] A shared repository should be writable by members.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 1683f0b..1b85cab 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -1625,7 +1625,9 @@ cooperation you are probably more famili
 For this, set up a public repository on a machine that is
 reachable via SSH by people with "commit privileges".  Put the
 committers in the same user group and make the repository
-writable by that group.
+writable by that group.  Make sure their umasks are set up to
+allow group members to write into directories other members
+have created.
 
 You, as an individual committer, then:
 
