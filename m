From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 16:48:54 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602241647250.31162@localhost.localdomain>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
 <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
 <20060224192354.GC387@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
 <7vpslc8oni.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Carl Baldwin <cnb@fc.hp.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:49:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCkoD-0008Fs-Na
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 22:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbWBXVs4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 16:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWBXVs4
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 16:48:56 -0500
Received: from relais.videotron.ca ([24.201.245.36]:22425 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932578AbWBXVsz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 16:48:55 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV7004ECOLIEK60@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Feb 2006 16:48:54 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16742>

On Fri, 24 Feb 2006, Nicolas Pitre wrote:

> If blocks are hashed evenly the cost of  producing a delta is at most 
> O(n+m) where n and m are the size of the reference and target files 
> respectively.  In other words, with good data set the cost is linear.
> 
> But if many blocks from the reference buffer do hash to the same bucket 
> then for each block in the target file many blocks from the reference 
> buffer have to be tested against, making it tend towards O(n^m) which is 
> pretty highly exponential.

Well, actually this is rather O(n*m) not O(n^m), but bad nevertheless.


Nicolas
