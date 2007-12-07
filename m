From: david@lang.hm
Subject: Re: RAM consumption when working with the gcc repo
Date: Fri, 7 Dec 2007 13:24:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0712071323260.12607@asgard.lang.hm>
References: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 21:16:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0jcq-0005U7-EF
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 21:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbXLGUQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 15:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753253AbXLGUQV
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 15:16:21 -0500
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:45421
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbXLGUQU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 15:16:20 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id lB7KGJDe021971;
	Fri, 7 Dec 2007 12:16:19 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67452>

On Fri, 7 Dec 2007, Jon Smirl wrote:

> I noticed two things when doing a repack of the gcc repo. First is
> that the git process is getting to be way too big. Turning off the
> delta caches had minimal impact. Why does the process still grow to
> 4.8GB?
>
> Putting this in perspective, this is a 4.8GB process constructing a
> 330MB file. Something isn't right. Memory leak or inefficient data
> structure?

keep in mind that that 330MB file is _very_ heavily compressed. the simple 
zlib compression is probably getting you 10:1 or 20:1 compression and the 
delta compression is a significant multiplier on top of that.

David Lang

> The second issue is that the repack process slows way down on the last
> 10% of the packing process. I don't believe this was caused by
> swapping since my disk light wasn't on. It takes a long to do the last
> 10% as it did for the first 70%. This seems to be correlated with the
> size of the process getting so large.
>
>
