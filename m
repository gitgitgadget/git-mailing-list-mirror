From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sat, 11 Feb 2006 18:24:03 +0100
Message-ID: <20060211172403.GA10099@steel.home>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org> <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net> <20060211133340.GS31278@pasky.or.cz>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 11 18:24:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7yUG-00078K-0w
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 18:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWBKRYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 12:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWBKRYc
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 12:24:32 -0500
Received: from devrace.com ([198.63.210.113]:22290 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932232AbWBKRYc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 12:24:32 -0500
Received: from tigra.home (p54A05B96.dip.t-dialin.net [84.160.91.150])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k1BHOANn055324;
	Sat, 11 Feb 2006 11:24:15 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1F7yTd-0003Ux-00; Sat, 11 Feb 2006 18:24:05 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1F7yTc-0007gZ-7G; Sat, 11 Feb 2006 18:24:04 +0100
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060211133340.GS31278@pasky.or.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15951>

Petr Baudis, Sat, Feb 11, 2006 14:33:40 +0100:
> > It probably should default to quiet if (!isatty(1)).
> 
> isatty(2) or something, 1 is in practice always a ref generator. Perhaps
> it would be better not to clutter stderr, though; what about directly
> opening /dev/tty? Does Cygwin support that?

It can't. Windows has no terminals (as in "none at all"). It has a
Console, which is a special kind of window attached to an application
and where the unbuffered stdout and stderr are magically redirected.

A test for is stdout/err is a tty can only check if the process has
the console attached, and an attempt to open it for writing will
probably just create the thing.
