From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: use result of open(2) to check for presence
Date: Thu, 5 Jan 2006 19:07:15 +0100
Message-ID: <20060105180715.GA6112@steel.home>
References: <81b0412b0601050343w4c00ac86y30569c3babbf6728@mail.gmail.com> <118833cc0601050648t17f68bcch8fd7c541585e965c@mail.gmail.com> <81b0412b0601050712q4c2123f7i8e9190c3b75b6fda@mail.gmail.com> <118833cc0601050845i40f93bbajdd70e77953d07014@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 19:08:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuZWb-0001ZS-78
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 19:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWAESHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 13:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWAESHm
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 13:07:42 -0500
Received: from devrace.com ([198.63.210.113]:59908 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932132AbWAESHl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 13:07:41 -0500
Received: from tigra.home (p54A06131.dip.t-dialin.net [84.160.97.49])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k05I7OTf019726;
	Thu, 5 Jan 2006 12:07:28 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EuZW8-0002uH-00; Thu, 05 Jan 2006 19:07:16 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EuZW7-0001tI-Pu; Thu, 05 Jan 2006 19:07:15 +0100
To: Morten Welinder <mwelinder@gmail.com>
Content-Disposition: inline
In-Reply-To: <118833cc0601050845i40f93bbajdd70e77953d07014@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14210>

Morten Welinder, Thu, Jan 05, 2006 17:45:27 +0100:
> Config files always tend to grow, but I do agree that 4GB config files stretches
> credibility a bit.
> 
> However, empty ones are not unlikely and then mmap will fail.
> 

Shouldn't be a problem: the code in question does not seem to do
anything for empty files and wont even touch the result of mmap.
