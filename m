From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Fri, 13 May 2005 00:06:44 +0200
Organization: linutronix
Message-ID: <1115935604.11872.97.camel@tglx>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	 <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
	 <1115858022.22180.256.camel@tglx> <7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
	 <1115884637.22180.277.camel@tglx> <7vvf5ogxdu.fsf@assigned-by-dhcp.cox.net>
	  <1115930845.11872.79.camel@tglx>
	 <4776.10.10.10.24.1115932163.squirrel@linux1>
	 <1115932872.11872.86.camel@tglx>
	 <2477.10.10.10.24.1115933520.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 00:01:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWLhK-0003h7-O6
	for gcvg-git@gmane.org; Thu, 12 May 2005 23:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVELWGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 18:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVELWGF
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 18:06:05 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:25997
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262151AbVELWF7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 18:05:59 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id B38C565C003;
	Fri, 13 May 2005 00:05:49 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 5F594282B8;
	Fri, 13 May 2005 00:05:49 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <2477.10.10.10.24.1115933520.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-12 at 17:32 -0400, Sean wrote:
> > How do you enforce correct timestamps  ?
> 
> When an object is committed locally it is set to the local time.  You can
> only have this feature when you use private commit objects (shared blobs
> are okay).  It doesn't matter if the timestamps are correct in the global
> sense, just that they're correct for the local server, because they'll
> only ever be compared against each other.

That limits the usefulness to a local place, which makes no sense in a
distributed development scenario. 


> By the way, repoid doesn't work when all the branches are done in the same
> repository.  You'd need to use something like repoid-branch.

Right. That was my basic idea to collect the information either from an
environment variable or deduce it from the current wroking directory,
which is unlikely to be the same for different branches. hpa's arguments
against this approach are quite good but I think somethink like a per
branch repository id is not too hard to implement.

tglx


