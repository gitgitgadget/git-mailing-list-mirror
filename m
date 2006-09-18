From: Junio C Hamano <junkio@cox.net>
Subject: git log --author='Jeff King'
Date: Sun, 17 Sep 2006 17:40:56 -0700
Message-ID: <7vlkoiypk7.fsf@assigned-by-dhcp.cox.net>
References: <200608281459.26643.kai.blin@gmail.com>
	<20060828181626.GB2950@coredump.intra.peff.net>
	<Pine.LNX.4.64.0608281147420.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kai Blin <kai.blin@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 18 02:41:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP7C4-0000KH-Pb
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 02:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWIRAk6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 20:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbWIRAk6
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 20:40:58 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:48096 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965171AbWIRAk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 20:40:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918004057.MMHV12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 20:40:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Pcgk1V00E1kojtg0000000
	Sun, 17 Sep 2006 20:40:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27214>

I have three patch series that makes a part of git-grep
available and use it for log filtering:

 [PATCH] builtin-grep: make pieces of it available as library.
 [PATCH] revision traversal: prepare for commit log match.
 [PATCH] revision traversal: --author, --committer, and --grep.

I didn't implement the boolean combination of patterns like
git-grep does, but it should be pretty straightforward to do so
in setup_revisions().  The syntax probably would be something
like:

    git log --grep-( rev-list gitweb --and --not --author=Jakub --grep-)

to find logs that:

 * talk about rev-list, or
 * talk about gitweb but not by Jakub
