From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Sun, 15 May 2005 14:23:29 -0400
Message-ID: <428793A1.5070004@pobox.com>
References: <200505151122.j4FBMJa01073@adam.yggdrasil.com> <20050515173923.GK5914@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Adam J. Richter" <adam@yggdrasil.com>, pasky@ucw.cz,
	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	mercurial@selenic.com, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun May 15 20:24:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXNmP-00032l-RX
	for gcvg-git@gmane.org; Sun, 15 May 2005 20:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVEOSX4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 14:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVEOSX4
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 14:23:56 -0400
Received: from mail.dvmed.net ([216.237.124.58]:18583 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261189AbVEOSXw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 14:23:52 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DXNm4-0004Pj-AY; Sun, 15 May 2005 18:23:36 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20050515173923.GK5914@waste.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matt Mackall wrote:
> On Sun, May 15, 2005 at 04:22:19AM -0700, Adam J. Richter wrote:
> 
>>On Sun, 15 May 2005 10:54:05 +0200, Petr Baudis wrote:
>>
>>>Dear diary, on Thu, May 12, 2005 at 10:57:35PM CEST, I got a letter
>>>where Matt Mackall <mpm@selenic.com> told me that...
>>>
>>>>Does this need an HTTP request (and round trip) per object? It appears
>>>>to. That's 2200 requests/round trips for my 800 patch benchmark.
>>
>>>Yes it does. On the other side, it needs no server-side CGI. But I guess
>>>it should be pretty easy to write some kind of server-side CGI streamer,
>>>and it would then easily take just a single HTTP request (telling the
>>>server the commit ID and receiving back all the objects).
>>
>>	I don't understand what was wrong with Jeff Garzik's previous
>>suggestion of using http/1.1 pipelining to coalesce the round trips.
> 
> 
> You can't do pipelining if you can't look ahead far enough to fill the pipe.

Even if you cannot fill a pipeline, HTTP/1.1 is sufficiently useful 
simply by removing the per-request connection overhead.

	Jeff


