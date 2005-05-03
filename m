From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Tue, 03 May 2005 08:51:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505030847140.14033@localhost.localdomain>
References: <200505030657.38309.alonz@nolaviz.org>
 <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
 <Pine.LNX.4.62.0505030344170.14033@localhost.localdomain>
 <200505030724.57827.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, Alon Ziv <alonz@nolaviz.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:46:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSwmC-0006A7-Gm
	for gcvg-git@gmane.org; Tue, 03 May 2005 14:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVECMvd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 08:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVECMvc
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 08:51:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42815 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261509AbVECMvZ
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 08:51:25 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR010.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFW007R5ZP3BW@VL-MO-MR010.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 May 2005 08:51:03 -0400 (EDT)
In-reply-to: <200505030724.57827.mason@suse.com>
X-X-Sender: nico@localhost.localdomain
To: Chris Mason <mason@suse.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 3 May 2005, Chris Mason wrote:

> This looks much nicer than using zdelta, I'll try switching my packed item to 
> your delta generator later this week.  Some quick and dirty space numbers to 
> show why we need to pack the files together:
> 
> On the full import of all the bk->cvs changesets, the average file size 
> in .git is 4074 bytes.  73% of the files are 4096 bytes or smaller.
> 
> This means that of the 2.5GB the .git directory consumes, about 1GB is taken 
> up by files under 4k where deltas won't save space.  If the remaining files 
> could be delta compressed down to less than 4k, they would still take up 
> around 400MB on disk.

Sure.  However it helps for history backups and network transfer.

However if the delta compression and packed storage can remain as 
decoupled as possible from each other this is good for flexibility.


Nicolas
