From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Wed, 18 Jan 2006 19:52:29 +0100
Message-ID: <20060118185229.GA3001@steel.home>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com> <7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0601181233460.8678@wbgn013.biozentrum.uni-wuerzburg.de> <7v4q41zd1t.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 19:53:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzIQS-0002Ep-Un
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 19:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWARSwx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 13:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWARSwx
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 13:52:53 -0500
Received: from devrace.com ([198.63.210.113]:14862 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1030256AbWARSww (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 13:52:52 -0500
Received: from tigra.home (p54A06816.dip.t-dialin.net [84.160.104.22])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k0IIqWYO069620;
	Wed, 18 Jan 2006 12:52:33 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EzIQ3-0007UU-00; Wed, 18 Jan 2006 19:52:31 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EzIQ2-0000w1-Jn; Wed, 18 Jan 2006 19:52:30 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q41zd1t.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL,RCVD_IN_SORBS_WEB autolearn=no 
	version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14855>

Junio C Hamano, Wed, Jan 18, 2006 18:00:30 +0100:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > And where does the time lag (required for the test) come from now?
> 
> The point of the change is that it avoids to depend on the time
> lag.  The test is to make sure we catch dirty index; instead of
> timestamp difference it now uses i-num difference for that.
> 

this is probable unsafe too: not all systems export inodes
(the recent cygwin breakage comes to mind).
