From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: git-local-pull
Date: Mon, 27 Jun 2005 01:31:25 -0400
Message-ID: <42BF8F2D.1070808@pobox.com>
References: <20050626.200555.39157645.davem@davemloft.net> <Pine.LNX.4.58.0506262213220.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "David S. Miller" <davem@davemloft.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 27 07:24:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dmm6v-0002wx-RJ
	for gcvg-git@gmane.org; Mon, 27 Jun 2005 07:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVF0Fbc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 01:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVF0Fbc
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 01:31:32 -0400
Received: from mail.dvmed.net ([216.237.124.58]:27086 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261152AbVF0Fba (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 01:31:30 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DmmDQ-0007EV-8u; Mon, 27 Jun 2005 05:31:28 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506262213220.19755@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 26 Jun 2005, David S. Miller wrote:
> 
>>I tried to start using git-clone-script to clone repositories
>>locally.  It crunches on the disk for a couple of seconds,
>>that's fine, but then I notice the disk activity stop and
>>git-local-pull becomes cpu bound and grows to 80MB in size
>>over the course of 5 minutes.
> 
> 
> Try adding "-l" to the git-local-pull command line, to make it do 
> hardlinks by default (and fall back to a copy if that fails).
> 
> 
>>Is this a side effect of the new pack/unpack stuff?
> 
> 
> Nope, nothing uses that yet. 
> 
> I think the 80MB is just because it built up the object relationship for 
> the whole kernel db there. I don't know what the 5 minutes of CPU are, 
> though, it should just be copying stuff (and at 250MB in and 250MB out, 
> that's a lot of stuff to copy, but it shouldn't be five minutes worth, 
> especially if it's all cached and you see a pegged CPU).

FWIW, I notice that git-diff-tree uses >100MB of RAM, on a large 
git-pull-script run.  It's generating the diffstat output, AFAICS.

	Jeff
