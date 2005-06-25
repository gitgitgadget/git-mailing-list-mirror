From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Sat, 25 Jun 2005 01:48:27 -0400
Message-ID: <42BCF02B.5090706@pobox.com>
References: <20050624.212009.92584730.davem@davemloft.net> <42BCE026.8050405@pobox.com> <Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "David S. Miller" <davem@davemloft.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 07:42:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm3Qq-0005yj-IF
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 07:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263347AbVFYFsk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 01:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbVFYFsk
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 01:48:40 -0400
Received: from mail.dvmed.net ([216.237.124.58]:18119 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S263347AbVFYFsc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jun 2005 01:48:32 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1Dm3Wo-0007JK-V6; Sat, 25 Jun 2005 05:48:31 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 25 Jun 2005, Jeff Garzik wrote:
> 
>>This is all due to the rsync sweeps, which have to scan metric tons of 
>>inodes and dentries.  Orders of magnitude over the pre-git days.
> 
> 
> Well, the real solution is to use a git-aware protocol, not rsync.
> 
> rsync is wonderful for prototyping, and I wanted to make the database 
> rsync'able for that reason, but it clearly doesn't scale.
> 
> I think I'll make a "pack"/"unpack" pair that just packs all the necessary
> objects between two commits. Then you can basically sync the object file 
> by doing
> 
> 	git-pack OLD..NEW | ssh other-end git-unpack
> 
> and you'd basically be done. It looks pretty easy to do, too..


The problem is kernel.org mirroring, not individual pushes and pulls, 
really.

Would git-pack be the best solution for mirroring a bunch of git trees?

	Jeff


