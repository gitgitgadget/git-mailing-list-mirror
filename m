From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Mon, 06 Aug 2007 21:37:17 -0700
Message-ID: <7v4pjc9czm.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
	<vpqbqdq45ua.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021147110.14781@racer.site>
	<AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
	<Pine.LNX.4.64.0708021541520.14781@racer.site>
	<46B1F3F4.5030504@midwinter.com>
	<Pine.LNX.4.64.0708021614420.14781@racer.site>
	<20070803053717.GA16379@midwinter.com>
	<alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 06:37:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIGp1-0000Sy-U3
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 06:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbXHGEhV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 00:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752715AbXHGEhU
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 00:37:20 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:35384 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbXHGEhT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 00:37:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070807043719.EQVY26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 7 Aug 2007 00:37:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YsdH1X00a1kojtg0000000; Tue, 07 Aug 2007 00:37:18 -0400
In-Reply-To: <alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 6 Aug 2007 21:22:26 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55216>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It's not that the old output is "useful" in itself, but it's important for 
> people to know that the index is clean. So I'd suggest just setting a flag 
> when the header isn't printed, and then printing out a single line at the 
> end about "git index not up-to-date" or something.

That's essentially the patch I sent out in another thread allows
you to do, and some of these people even Acked them, but there
is one minor issue.  "git diff" output is paged, and that "not
up to date" warning, if it is given to stderr, would not be
usually seen.

> Doing a "git diff" cannot actually update the index (since it very much 
> has to work on a read-only setup too), which is why the index _stays_ 
> stale unless something is done (eg "git status") to refresh it. And it's 
> that stale index that continues to make for bad performance without any 
> indication of why that is a problem.

Indeed.

At least, I am now glad to know that somebody else is of the
same opinion as I am.
