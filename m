From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -B flag to diff-* brothers.
Date: Sun, 29 May 2005 16:51:17 -0700
Message-ID: <7vpsv9h9qi.fsf@assigned-by-dhcp.cox.net>
References: <7vbr6vrvqf.fsf@assigned-by-dhcp.cox.net>
	<20050529215617.GT1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 01:49:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcXWX-0001nh-6T
	for gcvg-git@gmane.org; Mon, 30 May 2005 01:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVE2XvU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVE2XvU
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:51:20 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:51363 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261465AbVE2XvT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 19:51:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529235116.RTVH550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 19:51:16 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050529215617.GT1036@pasky.ji.cz> (Petr Baudis's message of
 "Sun, 29 May 2005 23:56:17 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Actually, I like this one - contrary to -O I can see how this could be
PB> quite useful - I have wished for this many times when people would send
PB> me some "complete rewrite" patches which I actually wanted to review.

PB> Please don't give up on it. :-)

Well, although I do not do Porcelain ;-), I do want to have -O
to help my use pattern.  I envision that Porcelain noticing the
existence of ${GIT-.git}/patch-order file and adding -O to its
diff-* argument would make the world a better place.

And I am not giving up on -B yet, but as you can imagine, it has
interesting interaction with -M/-C, since rename detection code
must be prepared to deal with broken pairs (earlier it did not
have to worry about the same path that is a regular file
appearing twice in its input).  Since I have tested -B only in
the context of full set of patches I sent out, and have not
tested it with only the subset Linus decided to swallow, I would
recommend against applying it on top of the Linus tip as is.
I'll be rebasing it to his tip, test it again and then resubmit
later.  I'll do the same for -O changes.

