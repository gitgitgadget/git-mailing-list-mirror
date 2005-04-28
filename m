From: David Lang <david.lang@digitalinsight.com>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 17:46:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504271743580.4990@qynat.qvtvafvgr.pbz>
References: <426F2671.1080105@zytor.com> <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org>
 <426FD3EE.5000404@zytor.com> <Pine.LNX.4.58.0504271154470.18901@ppc970.osdl.org>
 <426FF8C4.8080809@zytor.com> <Pine.LNX.4.58.0504271352110.18901@ppc970.osdl.org>
 <4270320D.5090708@dwheeler.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 02:42:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQx6Y-00014y-FA
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 02:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVD1Ard (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 20:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVD1Ard
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 20:47:33 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:39560 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S262131AbVD1Ar1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 20:47:27 -0400
Received: from sacims01.digitalinsight.com by warden3.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Wed, 27 Apr 2005 17:47:26 -0700
Received: by sacexc01.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <JR4RGLDQ>; Wed, 27 Apr 2005 17:47:04 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id JR4T4Z13; Wed, 27 Apr 2005 17:46:13 -0700
To: "David A. Wheeler" <dwheeler@dwheeler.com>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <4270320D.5090708@dwheeler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Apr 2005, David A. Wheeler wrote:

> Linus Torvalds wrote:
>> 
>> On Wed, 27 Apr 2005, H. Peter Anvin wrote:
>> 
>>> I know that.  However, is that going to be true for all versions of the 
>>> repository format over all time?  If so, the repository format is brittle.
<<SNIP>> 
>> HOWEVER, that's where "convert-cache" comes in. Any one particular format 
>> may be brittle, but if we accept that, and just say "we can upgrade by 
>> converting the cache", then we should be ok. IOW, we can change from one 
>> brittle format with 160-bit SHA1 names to _another_ brittle format with 
>> 256-bit SHA1 (or other) names.
>
> There's a disadvantage to that, unfortunately: invalidating signatures.
> Yes, you can get people to re-sign their stuff... assuming you can
> find them & convince them to do it (ha!).  More than likely,
> you'll lose signatures that way.  Probably not your TOP priority,
> but there are advantages to being able to go back & years later
> SHOW that someone really did sign something.

all you have to do is to make sure that convert-cache doesn't loose any 
data and you can always convert back (through as many steps as needed) to 
check signatures.

no matter what you do, if you change the thing that's being signed the 
signature is worthless, it doesn't matter if you change it in a flexible 
or a brittle way, it's different. the brittle approach actually makes it 
easier to go backwards as you KNOW exactly what it needs to be, there's no 
possiblity that a later tag was there, but being ignored (except for the 
signature)

> In the long run, I'd really like to see (at least) signed commits,
> and that those signatures would "stick around" cleanly into the future.
> "Breaks" can be handled other ways, but it is DEFINITELY a pain,
> and an avoidable one.
>
> --- David A. Wheeler
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
