From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 02 May 2005 12:10:15 -0400
Message-ID: <427650E7.2000802@tmr.com>
References: <118833cc05042908181d09bdfd@mail.gmail.com><118833cc05042908181d09bdfd@mail.gmail.com> <20050429165232.GV21897@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Morten Welinder <mwelinder@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 20:32:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSfhs-00011D-TD
	for gcvg-git@gmane.org; Mon, 02 May 2005 20:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVEBSht (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 14:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVEBSht
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 14:37:49 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:41866 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261598AbVEBShi
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 May 2005 14:37:38 -0400
Received: from [127.0.0.1] (oddball.prodigy.com [127.0.0.1])
	by oddball.prodigy.com (8.11.6/8.11.6) with ESMTP id j42IbWp30232;
	Mon, 2 May 2005 14:37:37 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20050429165232.GV21897@waste.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matt Mackall wrote:
> On Fri, Apr 29, 2005 at 11:18:20AM -0400, Morten Welinder wrote:
> 
>>>I had three design goals. "disk space" wasn't one of them
>>
>>And, if at some point it should become an issue, it's fixable. Since
>>access to objects is fairly centralized and since they are
>>immutable, it would be quite simple to move an arbitrary selection
>>of the objects into some other storage form which could take
>>similarities between objects into account.
> 
> 
> This is not a fix, this is a band-aid. A fix is fitting all the data
> in 10 times less space without sacrificing too much performance.
> 
> 
>>So disk space and its cousin number-of-files are both when-and-if
>>problems. And not scary ones at that.
> 
> 
> But its sibling bandwidth _is_ a problem. The delta between 2.6.10 and
> 2.6.11 in git terms will be much larger than a _full kernel tarball_.
> Simply checking in patch-2.6.11 on top of 2.6.10 as a single changeset
> takes 41M. Break that into a thousand overlapping deltas (ie the way
> it is actually done) and it will be much larger.
> 
At this level of performance I would say it doesn't matter. If a full 
checkin take two minutes or three minutes doesn't concern me, because 
I'm not going to sit and watch it, I'm going to read LKML or write my 
beer blog in another window. I would care about two vs. three hours, but 
minutes are too long to wait and too short to care.

Now look at pulling 41MB over a T1 link. All of a sudden I care bigtime! 
I want very much to use my bandwidth for other things, I don't want 41MB 
added to my backup, etc. Disk space is cheap, but unless you ignore 
backups and have an OC3 or so, these numbers are large enough to be 
irritating. Not a huge issue, just one of those "piss me off every time 
I do it" things.

If there is a functional reason to use git, something Mercurial doesn't 
do, then developers will and should use git. But the associated hassles 
with large change size, rather than the absolute size, are worth 
considering.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

