From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Hash collision count
Date: Sat, 23 Apr 2005 16:33:19 -0400
Message-ID: <426AB10F.9050300@pobox.com>
References: <426AAFC3.800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 23 22:29:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPRFB-0005p9-HE
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 22:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVDWUd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 16:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVDWUd0
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 16:33:26 -0400
Received: from 216-237-124-58.infortech.net ([216.237.124.58]:53404 "EHLO
	mail.dvmed.net") by vger.kernel.org with ESMTP id S261776AbVDWUdW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 16:33:22 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.50 #1 (Red Hat Linux))
	id 1DPRJY-0002c6-W6; Sat, 23 Apr 2005 20:33:22 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <426AAFC3.800@pobox.com>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jeff Garzik wrote:
> 
> Ideally a hash + collision-count pair would make the best key, rather 
> than just hash alone.
> 
> A collision -will- occur eventually, and it is trivial to avoid this 
> problem:
> 
>     $n = 0
>     attempt to store as $hash-$n
>     if $hash-$n exists (unlikely)
>         $n++
>         goto restart
>     key = $hash-$n


This of course presumes that you know that your new data does not exist 
in the cache.

Otherwise, you would need to hash the on-disk $hash-0 to determine if 
its a collision or a reference.

	Jeff


