From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git cherry improvements suggestions
Date: Thu, 24 Mar 2011 08:47:11 +0100
Message-ID: <4D8AF6FF.4080209@drmicha.warpmail.net>
References: <AANLkTimk0bkOGVy2W+XddHRuf-1xw+d0RwzPhnk40vi8@mail.gmail.com>	<4D89CF8E.4070100@drmicha.warpmail.net>	<AANLkTinXh_Y9ft5Pd5SxOEXvKNm3HLmsiut8WrvFZrdQ@mail.gmail.com>	<4D89F6BC.2040902@drmicha.warpmail.net>	<AANLkTin7Du5RYt946hNjP-y53puNykebCjiKk5Ju_igr@mail.gmail.com>	<4D8A0741.9000506@drmicha.warpmail.net>	<AANLkTi=7=QDh0Pe9W4bRcGY5Krg7sBqRcZ2C1YonJSRN@mail.gmail.com> <AANLkTi=7NKn4FrCqFaGH+XTHRw3oLCv=aKPWAJfNsgD_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 08:50:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2fJl-0001uC-I4
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 08:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802Ab1CXHus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 03:50:48 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:59124 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754946Ab1CXHus (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 03:50:48 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6C6BB20C2F;
	Thu, 24 Mar 2011 03:50:47 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 24 Mar 2011 03:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=mCnZ6AE/V/7+E+gdWYrixTRCd1Q=; b=JWuqhI35T51B0Q2z5+v8yxku6WViq6YGUxBN1musUWn+Yb8qRDvfRENjxnPNptUfYgji06wbVXH5OgUObVjgfTcp4K49gcHPGg4s5+jcLr2ztl3QDw9e1XHgFiGGmI/xbFbe3CBcgCkHAEeRguaTshXQACxgX+1U9/I89esCBlw=
X-Sasl-enc: 54sy+jIIgyRjeW6WcAjFMMK+JwSj9hvtEia8anSRPBjB 1300953046
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B038A444378;
	Thu, 24 Mar 2011 03:50:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTi=7NKn4FrCqFaGH+XTHRw3oLCv=aKPWAJfNsgD_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169903>

Piotr Krukowiecki venit, vidit, dixit 24.03.2011 08:40:
> On Wed, Mar 23, 2011 at 8:28 PM, Piotr Krukowiecki
> <piotr.krukowiecki@gmail.com> wrote:
>> On Wed, Mar 23, 2011 at 3:44 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Piotr Krukowiecki venit, vidit, dixit 23.03.2011 15:43:
>>>> On Wed, Mar 23, 2011 at 2:33 PM, Michael J Gruber
>>>> <git@drmicha.warpmail.net> wrote:
>>>>> Piotr Krukowiecki venit, vidit, dixit 23.03.2011 14:23:
>>>>>> Just some stats:
>>>>>>
>>>>>>    git log --cherry-mark --left-right --oneline --date-order branch...trunk
>>>>>>
>>>>>> lists 1004 commits, takes about 20s and memory peaks to about 670MB
>>>>>> twice during the run (I'm on linux with AMD Phenom II X4 945)
>>>>>>
>>>>>> With limit it prints X last commits (the limiting seems to take place after all
>>>>>> work, on the output list only).
>>>>>>
>>>>>> branch..trunk is 551 commits, the other way is 453 commits.
>>>>>> 710 commits are found to be "=", 98 "<", 196 ">".
>>>>>>
>>>>>> Note, I'm not saying it's too slow, or that it's working incorrectly, I'm just
>>>>>> giving real-life stats if anyone was interested.
>>>>>> I suspect such checks won't be done frequently.
>>>>>
>>>>> You don't need to say it's slow - I've said so already :(
>>>>>
>>>>> http://permalink.gmane.org/gmane.comp.version-control.git/169725
>>>>
>>>> In the link above:
>>>>   git cherry A B: 0.4s
>>>>   git rev-list --cherry A...B: 1.7s
>>>>
>>>> So rev-list is 4.25x slower.
>>>>
>>>> In my case it's only 1.23x slower:
>>>>
>>>>    $ time git rev-list --cherry branch...trunk  > /tmp/rev-list
>>>>    real       0m18.627s
>>>>    user       0m17.710s
>>>>    sys        0m0.900s
>>>>
>>>>    $ time git cherry  branch trunk  > /tmp/cherry
>>>>    real       0m15.345s
>>>>    user       0m14.310s
>>>>    sys        0m1.020s
>>>>
>>>>
>>>
>>> How's that with > /dev/null (or with --count for rev-list)? Also, how
>>> many merge bases do you have:
>>>
>>> git merge-base --all branch trunk | wc -l
>>
>> I expect only one - there should be no merges between those two
>> branches.
>>
>> I will do measurements tomorrow.
> 
> 
> Branches might change a bit since yesterday so the exact numbers
> might be a bit different.
> 
> 
> $ time git cherry  branch trunk  > /dev/null
> 
> real	0m15.246s
> user	0m14.260s
> sys	0m0.970s
> 
> 
> $ time git rev-list --cherry branch...trunk  > /dev/null
> 
> real	0m18.801s
> user	0m17.980s
> sys	0m0.800s
> 
> 
> $ time git rev-list --cherry --count branch...trunk
> 556
> 
> real	0m18.825s
> user	0m18.010s
> sys	0m0.770s
> 
> 
> $ time git merge-base --all branch trunk  | wc -l
> 2
> 
> real	0m0.538s
> user	0m0.490s
> sys	0m0.040s
> 
> 
> I expected one merge base, but it appears our history is
> seriously fscked, either by past svn operations or by
> git-svn clone :)
> 
> (I'm not saying there's an error somewhere, just that the
> history is ... complicated)
> 
> 

Thanks for the timings. In your case with only 2 merge bases, the merge
base calculation (or rather: simplification) does not make much of a
difference, at most 0.5s as we see. I'm still wondering where the rest
of the 3.5s difference (between cherry and --cherry) is spent, but at
least the ratio 18.8/15.2 is more bearable than in my case.
Unfortunately, this confirms my suspicion that there is more than 1 area
which would need improvement to match cherry's speed.

Michael
