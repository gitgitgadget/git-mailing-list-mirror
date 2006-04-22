From: Nicolas Pitre <nico@cam.org>
Subject: Re: RFC: New diff-delta.c implementation
Date: Fri, 21 Apr 2006 23:19:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604212308080.2215@localhost.localdomain>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 22 22:59:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXPC9-0006T8-9a
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 22:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWDVU7F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 16:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWDVU7F
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 16:59:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:11735 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751194AbWDVU7E (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 16:59:04 -0400
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3M3N9CJ006008
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 03:23:10 GMT
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IY300MMMT8C0830@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 21 Apr 2006 23:19:24 -0400 (EDT)
In-reply-to: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
X-X-Sender: nico@localhost.localdomain
To: Geert Bosch <bosch@adacore.com>
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19060>

On Fri, 21 Apr 2006, Geert Bosch wrote:

> I wrote a new binary differencing algorithm that is both faster
> and generates smaller deltas than the current implementation.
> The format is compatible with that used by patch-delta, so
> it should be easy to integrate.

It looks really interesting.

It ignores the max_size argument but that is trivially fixed.

Then it triggers some assertions in the code when running the test 
suite.

> Originally, I wrote this for the GDIFF format, see
> http://www.w3.org/TR/NOTE-gdiff-19970901.
> The adaptation for GIT format was relatively simple, but is not thoroughly
> tested.

Some trivial tests look fine but it fail on some others.

> The code is not derived from libxdiff, but uses the rabin_slide function
> written
> by David Mazieres (dm@uun.org). Also the tables are generated using his code.
> Finally, this was developed on Darwin, and not a Linux system, so some changes
> may be needed.

It does compile out of the box on Linux.

> Please feel free to play around with this code, and give feedback.
> Keep in mind this wasn't originally written for GIT, and C is not
> my native language, so don't mind my formatting etc.

I did reformat it a bit to be more inline with the rest of GIT's coding 
style (and to help me read it).  I'll look at fixing the issues I can 
fix and post it back.


Nicolas
