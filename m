From: Junio C Hamano <junkio@cox.net>
Subject: Re: More problems...
Date: Fri, 29 Apr 2005 14:07:29 -0700
Message-ID: <7vhdhp47hq.fsf@assigned-by-dhcp.cox.net>
References: <20050429170127.A30010@flint.arm.linux.org.uk>
	<20050429182708.GB14202@pasky.ji.cz>
	<20050429195055.GE1233@mythryan2.michonline.com>
	<Pine.LNX.4.58.0504291311320.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, Petr Baudis <pasky@ucw.cz>,
	Russell King <rmk@arm.linux.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 23:08:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRchk-0003SQ-Jx
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbVD2VMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 17:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbVD2VJZ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 17:09:25 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:21442 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262982AbVD2VHf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 17:07:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050429210731.WMTZ22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Apr 2005 17:07:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504291311320.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 29 Apr 2005 13:21:21 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Absolutely. I use the same "git-pull-script" between two local directories 
LT> on disk...
LT> Of course, I don't bother with the linking. But that's the trivial part.

Would it be useful if somebody wrote local-pull.c similar to
http-pull.c, which clones one local SHA_FILE_DIRECTORY to
another, with an option to (1) try hardlink and if it fails
fail; (2) try hardlink and if it fails try symlink and if it
fails fail; (3) try hardlink and if it fails try copy and if it
fails fail?

Then from a source repository that contains good stuff plus
throwaway experimental commits you can prepare pruned for-public
tree.  Of course you can do it today by copying and then running
git-prune in the destination, though.


