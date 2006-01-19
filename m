From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Thu, 19 Jan 2006 23:13:46 +0100
Message-ID: <20060119221346.GC3601@steel.home>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com> <7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0601181233460.8678@wbgn013.biozentrum.uni-wuerzburg.de> <7v4q41zd1t.fsf@assigned-by-dhcp.cox.net> <20060118185229.GA3001@steel.home> <7vmzhtqakl.fsf@assigned-by-dhcp.cox.net> <81b0412b0601190701g2696b1a9l14f3d288875e11ab@mail.gmail.com> <7vr774dqjo.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Christopher Faylor <me@cgf.cx>
X-From: git-owner@vger.kernel.org Thu Jan 19 23:15:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezi41-0002ga-VS
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 23:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWASWN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 17:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbWASWN4
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 17:13:56 -0500
Received: from devrace.com ([198.63.210.113]:12804 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1422666AbWASWNy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 17:13:54 -0500
Received: from tigra.home (p54A05B54.dip.t-dialin.net [84.160.91.84])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k0JMDlAA018496;
	Thu, 19 Jan 2006 16:13:48 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1Ezi2M-00043A-00; Thu, 19 Jan 2006 23:13:46 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Ezi2M-0001jl-FB; Thu, 19 Jan 2006 23:13:46 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr774dqjo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=2.0 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14940>

Junio C Hamano, Thu, Jan 19, 2006 19:24:27 +0100:
> 
> > Works if sleep is for 2 secs (I completely forgot about that stupid
> > FAT granularity!)
> > st_ino is always the same (it is a hash of pathname).
> > Christopher, how is that supposed to work with hardlinks? (NTFS has
> > hardlinks, BTW)
> 
> So the verdict is to take your patch but wait for three seconds?
> I still have mild aversion about $SECONDS though...
> 

Maybe just wait for 3 (three) seconds? It should guarantee the change
in mtime.
