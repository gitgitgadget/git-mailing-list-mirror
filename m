From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Hash collision count
Date: Sat, 23 Apr 2005 20:35:57 -0400
Message-ID: <426AE9ED.4060005@pobox.com>
References: <426AAFC3.800@pobox.com> <1114297231.10264.12.camel@maze.mythral.org> <426AD835.5070404@pobox.com> <20050423234637.GS13222@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ray Heasman <lists@mythral.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 02:31:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPV2C-00005C-0d
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVDXAgP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVDXAgP
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:36:15 -0400
Received: from 216-237-124-58.infortech.net ([216.237.124.58]:63105 "EHLO
	mail.dvmed.net") by vger.kernel.org with ESMTP id S262203AbVDXAgK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 20:36:10 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.50 #1 (Red Hat Linux))
	id 1DPV6Q-0002dK-If; Sun, 24 Apr 2005 00:36:05 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050423234637.GS13222@pasky.ji.cz>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Sun, Apr 24, 2005 at 01:20:21AM CEST, I got a letter
> where Jeff Garzik <jgarzik@pobox.com> told me that...
> 
>>Second, in your scenario, it's highly unlikely you would get 4 billion 
>>sha1 hash collisions, even if you had the disk space to store such a git 
>>database.
> 
> 
> It's highly unlikely you would get a _single_ collision.

Agreed.


>>First, the hash is NOT unique.
>>
>>Second, you lose data if you pretend it is unique.  I don't like losing 
>>data.
> 
> 
> *sigh*
> 
> We've been through this before, haven't we?

<shrug>

In messing around with archive servers, people get nervous using 
(hash,value) based storage if there isn't even a simple test for collisions.

Someone just told me that one implementation of the Venti archive 
server[1] simply fails the write, if a data item exists with a duplicate 
hash value.  As long as git fails or does something -predictable- in the 
face of the hash collision, I'm satisfied.

	Jeff


[1] http://www.cs.bell-labs.com/sys/doc/venti/venti.html
