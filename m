From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: Repo with only one file
Date: Fri, 9 Aug 2013 06:03:07 -0400
Message-ID: <CAH_OBifYFyVVo_OEfniWJE=0peX+UPLkRznqyQzvO4gGGLu_tQ@mail.gmail.com>
References: <CAH_OBid8SO3ydpjhRHa68s+54CScLh=jactxTQhwQPo-jcnAvA@mail.gmail.com>
 <520224E0.5060206@viscovery.net> <CAH_OBicysTTu9YdHsHz0H6x3umU5va68J3nT1qHA9-CJY9+E=A@mail.gmail.com>
 <CABURp0o_07HdB2o0knPABtAiiuHQ6-fYgemvdCYOsdSghO7v1w@mail.gmail.com>
 <52048B5B.5060009@viscovery.net> <CAH_OBicF3xn8+MsKH0nTg-HnPg58T-TWHW20r7GqXOm3Nbutfg@mail.gmail.com>
 <52049121.2080604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Aug 09 12:03:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7jXi-0001kC-GS
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 12:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107Ab3HIKD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 06:03:29 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:57411 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab3HIKD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 06:03:28 -0400
Received: by mail-vc0-f171.google.com with SMTP id ij15so886577vcb.2
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 03:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bK0PuRfJnljA0DV+ayce2P3qeEsVwz//tVEzG5F54nY=;
        b=DBnoDLqjCqbfgQIdFndjpkEAK63ty36dkeuafgSa10O1cHWJkkwqNPtIcH5YNaDqqP
         sx6+sr6HL4CwXKmXqmDX51DVvR1g3opAlzLhH7GfEeVcH9cpoA7M+r7ycY8B3OP7zwou
         u3gAysW33vWjXMZzGhKvefs0xGfL/EgrCPE49ZNOHB+UA2imiD4H+6co2vFgMGvFnqB9
         lhlYRvogVxFvA/zapJRpg30GPKV9+HtbtUSqCztdoPg8IOGZt36j/5F/Q04rH7KOhihk
         ixUg8/Wk9knxBFEk9Rt77LxZ1GdOQOx3mxBZe39/NvvwOhUV0dupmeCA7t+X/XbD/Kvp
         5QZw==
X-Received: by 10.220.238.81 with SMTP id kr17mr5159277vcb.61.1376042607086;
 Fri, 09 Aug 2013 03:03:27 -0700 (PDT)
Received: by 10.52.186.37 with HTTP; Fri, 9 Aug 2013 03:03:07 -0700 (PDT)
In-Reply-To: <52049121.2080604@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231967>

On Fri, Aug 9, 2013 at 2:50 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 8/9/2013 8:33, schrieb shawn wilson:
>> On Fri, Aug 9, 2013 at 2:25 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Am 8/8/2013 23:11, schrieb Phil Hord:
>>>> On Wed, Aug 7, 2013 at 5:07 PM, shawn wilson <ag4ve.us@gmail.com> wrote:
>>>>> On Wed, Aug 7, 2013 at 6:43 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>>>>> Am 8/7/2013 8:24, schrieb shawn wilson:> ... create a repo for one of
>>>>>>> these scripts and I'd like to keep the commit history.
>>>>>>>
>>>>>>> Ok, so:
>>>>>>> % find -type f ! -iname "webban.pl" | while read f; do git
>>>>>>> filter-branch -f --index-filter "git rm --cached --ignore-unmatch $f"
>>>>>>> HEAD ; done
>>>>>>>
>>
>>> I'm not sure. On second thought, my suggested command is not sufficient.
>>> It does remove the empty commits, but it does not remove the other files.
>>> So, Shawn's original filter-branch invocations are still needed.
>>>
>>
>> Yeah, I have tried this and haven't gotten any closer. I can either
>> remove all of the history or that one commit that has nothing to do
>> with my file is there. This is also reproducable in a new repo.
>>
>> Is this a bug with filter-branch or git? This doesn't seem like a
>> feature (or how things should act).
>
> Let's check: After running your command above to remove other files, does
> the command
>
>    git filter-branch -f HEAD webban.pl
>

Ahha, no but:
git filter-branch -f HEAD -- webban.pl
did

Thanks.

The question still stands though - why is that unassociated commit left there?
