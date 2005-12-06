From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH] Add compat/setenv.c, use in git.c.
Date: Tue, 06 Dec 2005 14:18:25 -0800
Message-ID: <20475.1133907505@lotus.CS.Berkeley.EDU>
References: <7vwtih299f.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 23:21:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejl8s-0002HX-Tn
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 23:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVLFWSc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 17:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbVLFWSc
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 17:18:32 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:52889 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932151AbVLFWSb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 17:18:31 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id jB6MIP6d020477;
	Tue, 6 Dec 2005 14:18:26 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id jB6MIPFL020476;
	Tue, 6 Dec 2005 14:18:25 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7vwtih299f.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13298>

And Morten Welinder writes:
 - The code looks wrong.  It assumes that pointers are no larger than ints.

The failure's in 32-bit mode, so they _are_ the same size.
The difference is no more than 0x80 in the tests.

But you're right; the result is implementation defined in
C99.

And Junio C Hamano writes:
 - Are you suggesting it to be done like this?

Your change fixed it.  Oddly enough, using arithmetic in
ptrdiff_t then testing against zero didn't...  I don't
have time to dig through assembly or try different gcc
versions to figure out the real problem.  ugh.

Jason
