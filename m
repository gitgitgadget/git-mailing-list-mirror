From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] add a diff-files command
Date: Thu, 28 Apr 2005 12:56:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504281238130.14033@localhost.localdomain>
References: <Pine.LNX.4.62.0504271701080.14033@localhost.localdomain>
 <7vr7gvevpv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.62.0504272031330.14033@localhost.localdomain>
 <7vr7gu97xq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 18:52:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRCEj-00016Y-Uo
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 18:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVD1Q5A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 12:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVD1Q47
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 12:56:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:5805 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262160AbVD1Q46
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 12:56:58 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFO00DZ91QJXA@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Apr 2005 12:56:43 -0400 (EDT)
In-reply-to: <7vr7gu97xq.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 28 Apr 2005, Junio C Hamano wrote:

> If you want to see if working tree has some junk other than
> those listed in dontdiff, wouldn't this be sufficient?
> 
>   $ show-files --others | grep -f dontdiff

Well, it would work if the dontdiff file other people are maintaining 
was made up of regexps.  But it is made of shell wildcard patterns meant 
to be used with the -X switch of the diff command.

> Again, "checking for potentially uncommitted" files is what
> you use show-files --others for, not show-diff.

Indeed.  And yesterday I realized that the (currently unimplemented) 
--ignore switch to show-files, combined with the exclusion pattern list, 
whould be more logical than teaching show-diff (which I still think is a 
misnamer in the context of the other diff tools) about files unknown to 
the cache.  The patch to show-files is also much smaller and logical.

BTW, I don't do this out of pure entousiasm but rather trying to make my 
own workflow with the Linux kernel source tree more efficient in the 
context of git usage.  My pure coding entousiasm lies somewhere else.  


Nicolas
