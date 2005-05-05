From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Kernel nightly snapshots..
Date: Wed, 04 May 2005 19:06:23 -0700
Message-ID: <42797F9F.9030002@zytor.com>
References: <Pine.LNX.4.58.0505041639130.2328@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Thu May 05 04:01:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTVfe-0005RJ-2L
	for gcvg-git@gmane.org; Thu, 05 May 2005 04:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVEECHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 22:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVEECHK
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 22:07:10 -0400
Received: from terminus.zytor.com ([209.128.68.124]:4276 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261790AbVEECHD
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 May 2005 22:07:03 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4526SRc009467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 May 2005 19:06:28 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505041639130.2328@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.7 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It used to be Jeff Garzik, but David Woodhouse volunteered to take this 
over a few days ago, so yesterday I chowned those directories to him.

	-hpa

Linus Torvalds wrote:
> I forget who it is that used to do the nightly snapshots for the BK
> kernels, but I _think_ it was David Woodhouse (every time I've blamed it
> on somebody, I've blamed the wrong person, so I'm probably off on this one
> too, but maybe I finally got it right).
> 
> I was wondering how to get that re-started.. It should be technically
> pretty easy, except I realized that my tree doesn't even have plain 2.6.11
> in it. But I just fixed that in the tree, since I need such a baseline 
> myself for my next release..
> 
> Anyway, I just pushed out a kernel tree that contains a tag of a _tree_ 
> that points to the tree at the point of 2.6.11. I also had to teach 
> fsck-cache about the fact that you can give it any kind of object to start 
> your references at, and to make fsck-cache happy, you need to
> 
> 	git-fsck-cache --unreachable HEAD v2.6.11
> 
> to tell it that the kernel tree now has an unconnected tree (described by
> the tag "v2.6.11-tree", and I made the appropriate entry for it in
> .git/refs/tags).
> 
> I also updated git-prune-script to not remove these kinds of things.
> 
> With this, it should be trivial to create snapshots with
> 
> 	git-diff-tree -p v2.6.11 HEAD
> 
> or similar.
> 
> 		Linus

