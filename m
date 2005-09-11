From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Sun, 11 Sep 2005 16:43:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509111642110.3242@g5.osdl.org>
References: <deofnh$jl0$1@sea.gmane.org> <7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vvf17tsoa.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509111100260.3242@g5.osdl.org>
 <Pine.LNX.4.63.0509120119120.10594@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509111631500.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	John Ellson <ellson@research.att.com>, git@vger.kernel.org,
	Patrick Mauritz <oxygene@studentenbude.ath.cx>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Mon Sep 12 01:44:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEbUk-00065f-4l
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 01:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVIKXoT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 19:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVIKXoT
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 19:44:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30375 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751083AbVIKXoS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 19:44:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8BNhwBo001338
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Sep 2005 16:43:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8BNhu63027657;
	Sun, 11 Sep 2005 16:43:57 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.58.0509111631500.3242@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8344>



On Sun, 11 Sep 2005, Linus Torvalds wrote:
> 
> And the really sad part is that before the standards bodies started
> messing around with it, things really _did_ "just work". There was no 
> question at all about what kind of type to use.

Btw, here's the result of the "documentation":

	dnl check for Unix98 socklen_t
	AC_MSG_CHECKING(for socklen_t)
	AC_TRY_COMPILE([#include <sys/socket.h>
	socklen_t x;
	],[],[AC_MSG_RESULT(yes)],[
	AC_TRY_COMPILE([#include <sys/socket.h>
	int accept (int, struct sockaddr *, size_t *);
	],[],[
	AC_MSG_RESULT(size_t)
	AC_DEFINE(socklen_t,size_t)], [
	AC_MSG_RESULT(int)
	AC_DEFINE(socklen_t,int)])])

isn't that nice? Before the "documentation", you could just use

	int accept(int, struct sockaddr *, int *);

and it would work. EVERYWHERE. No autoconf crap required.

So don't talk to me about documentation. It's pure and unadulterated crap.

		Linus
