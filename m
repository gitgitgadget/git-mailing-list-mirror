From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-imap-send.
Date: Thu, 09 Mar 2006 10:49:49 -0800
Message-ID: <7v4q275u7m.fsf@assigned-by-dhcp.cox.net>
References: <440C3499.9080000@codeweavers.com>
	<7vacbz7vod.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0603091227560.20277@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0603090836030.18022@g5.osdl.org>
	<7vmzfz5w2k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603091017530.18022@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 19:50:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHQCw-0002NF-O3
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 19:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWCIStv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 13:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWCIStv
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 13:49:51 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:21440 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750780AbWCIStu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 13:49:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309184756.VTHU20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Mar 2006 13:47:56 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603091017530.18022@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 9 Mar 2006 10:21:50 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17433>

Linus Torvalds <torvalds@osdl.org> writes:

>> > ... They won't be used in the eventual result, but 
>> > just the fact that they are loaded from memory can mean that your program 
>> > takes a SIGSEGV, for example, becaue it turns out "string" was just a 
>> > single NUL byte at the end of a page, and there's nothing after it.
>> 
>> Funny.  I've seen this exact bug in memcmp and strcmp in earlier
>> SunOS (pre Solaris) libc when I was working on something like
>> Valgrind in my previous life.
>
> Well, Valgrind actually can complain for no good reason.

To clarify, it was _not_ Valgrind I was mucking with.  And the
optimization used in the system library was wrong -- it stepped
over the page boundary without checking.  I found that it was
fixed in later releases (that was all before Sun started
calling their system Solaris).
