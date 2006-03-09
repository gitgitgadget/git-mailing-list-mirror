From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-imap-send.
Date: Thu, 09 Mar 2006 10:09:39 -0800
Message-ID: <7vmzfz5w2k.fsf@assigned-by-dhcp.cox.net>
References: <440C3499.9080000@codeweavers.com>
	<7vacbz7vod.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0603091227560.20277@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0603090836030.18022@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike McCormack <mike@codeweavers.com>
X-From: git-owner@vger.kernel.org Thu Mar 09 19:10:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHPaC-0006Kp-R7
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 19:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWCISJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 13:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWCISJm
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 13:09:42 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:29110 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751188AbWCISJl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 13:09:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309180818.WOCJ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Mar 2006 13:08:18 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603090836030.18022@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 9 Mar 2006 08:41:16 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17430>

Linus Torvalds <torvalds@osdl.org> writes:

> it's entirely possible that it will load bytes from "string" _past_ the 
> end of the string because of an unrolled inner loop that does things 
> multiple bytes at a time. They won't be used in the eventual result, but 
> just the fact that they are loaded from memory can mean that your program 
> takes a SIGSEGV, for example, becaue it turns out "string" was just a 
> single NUL byte at the end of a page, and there's nothing after it.

Funny.  I've seen this exact bug in memcmp and strcmp in earlier
SunOS (pre Solaris) libc when I was working on something like
Valgrind in my previous life.
