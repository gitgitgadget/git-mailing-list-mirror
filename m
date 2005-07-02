From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "git-send-pack"
Date: Fri, 01 Jul 2005 21:08:49 -0700
Message-ID: <42C61351.10306@zytor.com>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org> <42C46A3C.1070104@zytor.com> <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org> <42C482ED.1010306@zytor.com> <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org> <42C5D553.80905@timesys.com> <Pine.LNX.4.58.0507011831060.2977@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike Taht <mike.taht@timesys.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 06:02:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoZCX-0003KM-5M
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 06:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263443AbVGBEJb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 00:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbVGBEJb
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 00:09:31 -0400
Received: from terminus.zytor.com ([209.128.68.124]:43477 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263443AbVGBEJ1
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 00:09:27 -0400
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j6248oLe003427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Jul 2005 21:08:51 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507011831060.2977@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> Also, the number of people involved isn't _that_ big. We're talking a few
> thousand people who actively would update their trees for a big project,
> and many smaller projects have anything from a couple to maybe a hundred. 
> A few mirrors, and you don't have any problem.
> 
> So I think that the problem is actually not that big, and we just need to
> find an acceptable format. Quite frankly, it might be perfectly acceptable
> for kernel.org to run a simple packing script once a week which packs
> everything into one single file, and even if that means that the mirrors
> will have to re-get everything once a week, that actually sounds 
> acceptable.
> 
> It's obviously a _stupid_ way to handle the rsync problem, so there's 
> bound to be some cleaner solution, but the point is that we can probably 
> make mirroring acceptable even with a really really stupid approach. I'd 
> be a bit ashamed of just how ugly it is, but it would likely _work_ fine.
> You'd create 52 pack-files in a year, but each pack-file is likely just
> ten megabytes each. 
> 

Any reason not to simply append objects to an existing packfile?  It 
really seems like an easy solutions, and should have relatively good I/O 
patterns to boot simply because it naturally creates a topological sort 
of the objects.

	-hpa
