From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] diff --stat: allow custom diffstat output width.
Date: Thu, 28 Sep 2006 23:11:06 -0700
Message-ID: <7vhcyrp5hh.fsf@assigned-by-dhcp.cox.net>
References: <7vr6xyjal0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609281349110.3952@g5.osdl.org>
	<7vac4ju1f1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609281458420.3952@g5.osdl.org>
	<7vr6xvp7jm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609282252430.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 08:11:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTBag-0003z5-GC
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 08:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161315AbWI2GLL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 02:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161300AbWI2GLL
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 02:11:11 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:36993 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932544AbWI2GLH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 02:11:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929061106.HMVA21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Sep 2006 02:11:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U6B21V00V1kojtg0000000
	Fri, 29 Sep 2006 02:11:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609282252430.3952@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 28 Sep 2006 22:58:10 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28092>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 28 Sep 2006, Junio C Hamano wrote:
>> 
>> This is simply too clever; -pedantic does not like assignment of
>> arg to end (constness -- and strtoul takes pointer to non-const
>> char *, so making the type of end const char * is not an answer
>> either).
>
> The _code_ really is right. The problem is "strtoul()" interfaces and a 
> C typing oddity.

Yes, the code is right (not only because you wrote it ;-) and
not just right but it is crystal clear to humans what is going
on and why the final "if (*end)" is all that is needed without
any "return 0" in the middle.

> At that point, the cast is probably simpler,...

... which I ended up doing anyway.

Thanks.
