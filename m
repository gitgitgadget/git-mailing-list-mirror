From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 17:32:00 -0400 (EDT)
Message-ID: <2477.10.10.10.24.1115933520.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com> 
    <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com> 
    <1115858022.22180.256.camel@tglx>
    <7vekcdmd16.fsf@assigned-by-dhcp.cox.net> 
    <1115884637.22180.277.camel@tglx>
    <7vvf5ogxdu.fsf@assigned-by-dhcp.cox.net> 
    <1115930845.11872.79.camel@tglx> 
    <4776.10.10.10.24.1115932163.squirrel@linux1>
    <1115932872.11872.86.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 23:26:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWLBo-0007Xi-S9
	for gcvg-git@gmane.org; Thu, 12 May 2005 23:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVELVdF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 17:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVELVdE
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 17:33:04 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:11959 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262136AbVELVcB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 17:32:01 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050512213200.ZUDC26867.simmts8-srv.bellnexxia.net@linux1>;
          Thu, 12 May 2005 17:32:00 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4CLW0Pe019856;
	Thu, 12 May 2005 17:32:00 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 12 May 2005 17:32:00 -0400 (EDT)
In-Reply-To: <1115932872.11872.86.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 5:21 pm, Thomas Gleixner said:

>> And the time is recorded on the commit blob too.
>
> How do you enforce correct timestamps  ?

When an object is committed locally it is set to the local time.  You can
only have this feature when you use private commit objects (shared blobs
are okay).  It doesn't matter if the timestamps are correct in the global
sense, just that they're correct for the local server, because they'll
only ever be compared against each other.

By the way, repoid doesn't work when all the branches are done in the same
repository.  You'd need to use something like repoid-branch.

One area where your repoid is superior that i missed in my previous email
is that you can actually recover a corrupt blob from an unrelated
repository that happens to contain it, and you've lost no information. 
Which is what Linus was expounding as one of the benefits of the git
design.

Sean


