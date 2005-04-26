From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 16:30:15 -0400
Message-ID: <426EA4D7.9080008@tmr.com>
References: <Pine.LNX.4.58.0504252032500.18901@ppc970.osdl.org><Pine.LNX.4.58.0504252032500.18901@ppc970.osdl.org> <426E852A.40904@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Mike Taht <mike.taht@timesys.com>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 22:28:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQWdR-0001fo-Ly
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 22:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVDZUbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 16:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVDZUbS
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 16:31:18 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:22156 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261616AbVDZUa7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 16:30:59 -0400
Received: from [127.0.0.1] (oddball.prodigy.com [127.0.0.1])
	by oddball.prodigy.com (8.11.6/8.11.6) with ESMTP id j3QKUGV08676;
	Tue, 26 Apr 2005 16:30:25 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <426E852A.40904@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

H. Peter Anvin wrote:
> Linus Torvalds wrote:
> 
>>
>> And don't try to make me explain why the patchbomb has any IO time at 
>> all,
>> it should all have fit in the cache, but I think the writeback logic
>> kicked in.
> 
> 
> The default log size on ext3 is quite small.  Making the log larger 
> probably would have helped.

Experience tells me that making the log larger does very good things for 
performance in many load types. However, that fsync issue forcing the 
write of the whole log may get worse if there's a lot pending.

I suspect this would be helped by noatime.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
