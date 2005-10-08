From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Seeing various mode changes on cygwin
Date: Sat, 8 Oct 2005 23:36:12 +0200
Message-ID: <20051008213612.GA5794@steel.home>
References: <20051008180023.GC28875@diku.dk> <7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 23:36:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOMMl-0007xV-Bg
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 23:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVJHVgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 17:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVJHVgY
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 17:36:24 -0400
Received: from devrace.com ([198.63.210.113]:47364 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932139AbVJHVgY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2005 17:36:24 -0400
Received: from tigra.home (p54A0E160.dip.t-dialin.net [84.160.225.96])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j98Lmhn6093239;
	Sat, 8 Oct 2005 16:48:44 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EOMMW-0006Jb-00; Sat, 08 Oct 2005 23:36:12 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EOMMW-0001jI-2G; Sat, 08 Oct 2005 23:36:12 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.3 required=4.5 tests=AWL,BAYES_05,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9855>

Junio C Hamano, Sat, Oct 08, 2005 20:51:55 +0200:
> > ... It seems that cygwin overrides the previous modes and sets the
> > executable bit. git-reset doesn't fix it. Can this even be fixed
> > then?
> >
> > A few examples below ...
> >
> > jonas@cygwin /usr/local/dev/git/git
> > $ git reset
> > Documentation/sort_glossary.pl: needs update
> > t/lib-read-tree-m-3way.sh: needs update
> 
> I do not have an access to Cygwin environment so cannot be of
> help on this directly, but 'git reset' without flags defaults
> "--mixed" and leaves the modified files intact.  Maybe hard
> reset would help here, but the real solution is to figure out
> why these files acquired the extra executable bits in the first
> place.

These are not real attributes, cygwin emulates them from the names,
like .exe will always be 0755, for example.
