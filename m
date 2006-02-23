From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 22:43:53 +0100
Message-ID: <20060223214353.GC5827@steel.home>
References: <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com> <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com> <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com> <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com> <Pine.LNX.4.64.0602230911410.3771@g5.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 22:44:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCOFu-0003SG-O4
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 22:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWBWVoH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 16:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbWBWVoH
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 16:44:07 -0500
Received: from devrace.com ([198.63.210.113]:7437 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751304AbWBWVoF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2006 16:44:05 -0500
Received: from tigra.home (p54A06B17.dip.t-dialin.net [84.160.107.23])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k1NLhtU4034180;
	Thu, 23 Feb 2006 15:43:56 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FCOFd-0000tp-00; Thu, 23 Feb 2006 22:43:54 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FCOFd-0002DM-U1; Thu, 23 Feb 2006 22:43:53 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602230911410.3771@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16669>

Linus Torvalds, Thu, Feb 23, 2006 18:13:43 +0100:
> > Someday we'll have to start dropping features on Windows or restrict them
> > beyond their usefullness.
> 
> One thing that would help a bit would be to avoid shell.
> 
> There are many portable interpreters out there, and I don't mean perl. And 
> writing a small "specialized for git" one isn't even that hard. In fact, 
> most of the shell (and bash) hackery we do now would be unnecessary if we 
> just made a small "git interpreter" that ran "git scripts".
> 
> The fact that it would also help portability is just an added advantage.
> 

I actually was dreaming about taking a vacation and rewrite at least
the most important scripts in C, but without cygwin. Implement the
needed subset of POSIX in compat/, workaround fork.

That'd help me to present git to my collegues without requiring them
to install cygwin, perl and python first. It is a real problem to
explain why a new tool is better than the old one if the problem start
right from installation, and it probably wont matter how bad the old
tool is (it is, they know that too, but it has windows, doors and a
mostly running man for busy-waiting cursor).

A gits own interpreter would be more than, of course.
