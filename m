From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] embedded TAB and LF in pathnames
Date: Sat, 8 Oct 2005 08:45:55 +0200
Message-ID: <20051008064555.GA3831@steel.home>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home> <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Sat Oct 08 08:47:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO8TX-0006lj-IL
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 08:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVJHGqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 02:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVJHGqI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 02:46:08 -0400
Received: from devrace.com ([198.63.210.113]:38928 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1750783AbVJHGqH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2005 02:46:07 -0400
Received: from tigra.home (p54A0E160.dip.t-dialin.net [84.160.225.96])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j986wPQb083674;
	Sat, 8 Oct 2005 01:58:26 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EO8Sz-0000nR-00; Sat, 08 Oct 2005 08:45:57 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EO8Sy-0001KB-GB; Sat, 08 Oct 2005 08:45:56 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.5 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9835>

Junio C Hamano, Sat, Oct 08, 2005 01:44:48 +0200:
> > Junio C Hamano, Fri, Oct 07, 2005 21:35:19 +0200:
> >> I have not made up my mind on the exact choice of the quoting
> >> convention.  We could say '///' instead of '//', for example, or
> >> even '//{LF}//' instead of '//0A' proposed above.  One thing I
> >> am trying to avoid is "foo\nbar", which I suspect would be
> >> unfriendly to the Cygwin folks.
> >
> > Being unhappy one of them, I think I'd better manage (even if by
> > postprocessing the output).
> >
> > Please, don't make the common case ugly just because of that platform
> > (insanely broken anyway).
> 
> You really have to realize that having LF and TAB in filenames
> are *NOT* the common case, no matter which platform you are
> talking about.
> 

Yes, but "//" in a path is quite common. Even "///" is not uncommon.

How about copy ls' approach were possible?

   -b, --escape, --quoting-style=escape
          Quote  nongraphic  characters in file names using alphabetic and
          octal backslash sequences like those used in C. This  option  is
          the  same as -Q except that filenames are not surrounded by dou-
          ble-quotes.
