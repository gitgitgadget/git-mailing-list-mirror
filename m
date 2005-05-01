From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sat, 30 Apr 2005 23:22:49 -0700
Message-ID: <7vr7grzcqu.fsf@assigned-by-dhcp.cox.net>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
	<7vis231y7y.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504302224510.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 08:17:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS7lE-0005uk-Ug
	for gcvg-git@gmane.org; Sun, 01 May 2005 08:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVEAGWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 02:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVEAGWx
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 02:22:53 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:42159 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261544AbVEAGWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 02:22:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501062250.LVQQ26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 02:22:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504302224510.2296@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 30 Apr 2005 22:27:50 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I actually do end up looking at diffs, and I'd hate it. I'd much rather
LT> have as little extra fluff as possible, and putting shell scipt fragments
LT> in it definitely counts as distraction.

Well I was half joking when I suggested that and I am glad to
see that you have a good aesthetics ;-).  How about:

 - Stop attempting to be compatible with cg-patch, and drop
   (mode:XXXXXX) bits from the diff.

 - Do keep the /dev/null change for created and deleted case.

 - No "Index:" line, no "Mode change:" line, anywhere in the
   output.  Anything that wants the mode bits and sha1 hash can
   do things from GIT_EXTERNAL_DIFF mechanism.  Maybe document
   suggested usage mechanism better.

I'll whip something up along the above lines and submit it.

