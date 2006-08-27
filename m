From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] dir: do all size checks before seeking back and fix file closing
Date: Sat, 26 Aug 2006 20:04:18 -0700
Message-ID: <7vy7tayj4d.fsf@assigned-by-dhcp.cox.net>
References: <20060826141709.GC11601@diku.dk>
	<Pine.LNX.4.64.0608261509290.11811@g5.osdl.org>
	<7v4pvz11o6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0608261931460.11811@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Aug 27 05:04:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHAwe-0000ev-UW
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 05:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWH0DEI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 23:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWH0DEI
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 23:04:08 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:27086 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750930AbWH0DEF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 23:04:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827030400.BGFZ27846.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sat, 26 Aug 2006 23:04:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id Er3x1V00K4Noztg0000000
	Sat, 26 Aug 2006 23:03:58 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0608261931460.11811@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 26 Aug 2006 19:37:57 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26082>

Linus Torvalds <torvalds@osdl.org> writes:

>> The comparison order is done in textual order.  You list smaller
>> things on the left and then larger things on the right (iow, you
>> almost never use >= or >).
>
> Ahh. A number of people do the "0 == x" thing, because they want to be 
> caught if they use "=" instead of "==" by mistake. I thought it was the 
> same thing.

The rest is repeating what you said 15 months ago, so I did not
quote that part, but interested parties can follow this thread:

http://thread.gmane.org/gmane.comp.version-control.git/3907/focus=4126
