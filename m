From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Current state of GIT fetch/pull clients
Date: Thu, 15 Sep 2005 21:03:50 -0400
Message-ID: <432A19F6.8050605@pobox.com>
References: <Pine.LNX.4.63.0509142319330.23242@iabervon.org> <7vbr2tx51n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 03:05:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG4eF-00077Q-LT
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 03:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbVIPBEL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 21:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbVIPBEL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 21:04:11 -0400
Received: from mail.dvmed.net ([216.237.124.58]:49626 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161008AbVIPBEK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 21:04:10 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EG4dx-00065k-3V; Fri, 16 Sep 2005 01:04:00 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr2tx51n.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8657>

Junio C Hamano wrote:
> Neither http nor rsync transports know about the 'alternates'
> mechanism yet, so if a downloader does:
> 
>     $ git pull http://kernel.org/pub/scm/linux/kernel/git/$u/$tree
>     $ git pull rsync://kernel.org/pub/scm/linux/kernel/git/$u/$tree
> 
> unless the downloader has already fetched from Linus'
> repository, this will not work.
> 
>   * In the case of rsync transport, it would slurp all objects
>     your repository has, but does not get objects from Linus'
>     repository.  Also, rsync will overwrite the
>     objects/info/alternates file the downloader has in his
>     repository with what you have in your repository, which is
>     not what we want.

Yes, this is why I don't bother with alternates at the present time. 
Users of my repos, at least, have been trained to use rsync://... and 
currently expect to get a working tree that way.

	Jeff
