From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Thu, 19 Jan 2006 23:12:27 +0100
Message-ID: <20060119221227.GB3601@steel.home>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com> <7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0601181233460.8678@wbgn013.biozentrum.uni-wuerzburg.de> <7v4q41zd1t.fsf@assigned-by-dhcp.cox.net> <20060118185229.GA3001@steel.home> <7vmzhtqakl.fsf@assigned-by-dhcp.cox.net> <81b0412b0601190701g2696b1a9l14f3d288875e11ab@mail.gmail.com> <20060119182822.GA32022@trixie.casa.cgf.cx>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 23:14:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezi1h-00029x-8j
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 23:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWASWMh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 17:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbWASWMh
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 17:12:37 -0500
Received: from devrace.com ([198.63.210.113]:13063 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1422660AbWASWMf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 17:12:35 -0500
Received: from tigra.home (p54A05B54.dip.t-dialin.net [84.160.91.84])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k0JMCTrg018490;
	Thu, 19 Jan 2006 16:12:30 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1Ezi15-00042c-00; Thu, 19 Jan 2006 23:12:27 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Ezi15-0001je-Tz; Thu, 19 Jan 2006 23:12:27 +0100
To: Christopher Faylor <me@cgf.cx>
Content-Disposition: inline
In-Reply-To: <20060119182822.GA32022@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14939>

Christopher Faylor, Thu, Jan 19, 2006 19:28:22 +0100:
> >> By the way, if you have an access to git on cygwin with FAT,
> >> could you test your patch ($SECONDS) and then i-num patch (the
> >> machine with cygwin I can borrow has only NTFS) please?
> >
> >Works if sleep is for 2 secs (I completely forgot about that stupid
> >FAT granularity!)
> >st_ino is always the same (it is a hash of pathname).
> >Christopher, how is that supposed to work with hardlinks? (NTFS has
> >hardlinks, BTW)
> 
> There is OS support hardlinks work on NTFS/NT but not on FAT*
> "filesystems" or Windows 9x variants.  Hardlink support on Cygwin
> mirrors this.
> 

No, I rephrase the question: how does the method of calculating
.st_ino from pathname handles hardlinked files on NTFS?
By briefly looking at the code it does not seem to be possible.
