From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] Modified flag field type in rev_list_info struct in
 bisect.h. There is no need for flag field to be signed, as it is not supposed
 to be used as decimal.
Date: Thu, 24 Mar 2016 16:04:46 -0700
Message-ID: <CAGZ79kaF42yCFWdvqqDSAZbWmUo0UVJGbXCci1LF=ne+cixZ0A@mail.gmail.com>
References: <1458848469-12663-1-git-send-email-motroniii@gmail.com>
	<1458848469-12663-2-git-send-email-motroniii@gmail.com>
	<CAGZ79kZmzo+f9YF1K1oC2GfOrzdaojmrca7bUm3cBRoDreeA-g@mail.gmail.com>
	<56F44788.2050509@gmail.com>
	<CAPig+cQcviTXYAGBTATgYXoaPtvxxeOUtCGYkLyW5oTFvLjEUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: work <motroniii@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 00:04:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajEJA-0005j9-Uo
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 00:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbcCXXEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 19:04:49 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33115 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbcCXXEr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 19:04:47 -0400
Received: by mail-io0-f176.google.com with SMTP id c63so101935671iof.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 16:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=u8jHj/gejWi4C6KqKOmlkWSAj+Mb5+LiPhbPw/goCMI=;
        b=Tv3XIFoOdyIMOgVmKIqS5vFpFOMU8jEaUnE8VslHMI1RHYmkSd2MP9hYtrHC5YfPUk
         lLK2TcE9D+ZaLTLibVKXKZu4RgoYA92roFa8MESMBiyQzboRtIQPSwjj5J5yzsXaGcpK
         d0+TP1tFFO/e4IKro9gwunrSdDY8A8CdUZpA70phWjG+aADt+4jfEL73b02qcTnvj9LQ
         97IfTjMmK78mcprFgoUhJaeKlqfC6OzoLRk7hB9V0xQha1PDrsnbO3OtBlaDBn/ZEM+v
         0lf9W7Pv9ztEs/SYGi2InT1Q7iGxHRWdDptDsdggAH6fwXoSXzAue97LpbyaGZ4EcdT5
         yPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=u8jHj/gejWi4C6KqKOmlkWSAj+Mb5+LiPhbPw/goCMI=;
        b=d4nWybXA0uaL+KdcUPd3OOdxo/hLmLwYI1vpyj5Lc7NEhkYBwFk5gEVj0/1CN2cfXV
         QUXbrZDzy6/suu8YhkDcP5/AUbAFRvhdH4/kmRkL/5+ifKAcmOdmz+7aXOL+PLeefi/R
         MrTZHNR07F8orJLiIlgvVGawi8lrP6K1fxtiTz9n2pj/ruR9z62ln0dwDLh+V7z+aX2/
         2Zg0uLeEgE80T/XQZMETsdN5y2x/3NMyOSWKR9O8K6MlkmOxbgpH6mhddMJ1x6zkDHaF
         7hYFEQ3BfVWJim37lzljYWBAucz3gDj/oG9oKJD+abasSEsHkDOD3YgEu/k7EH7zZlXk
         Alkg==
X-Gm-Message-State: AD7BkJIijlhso78jvZP2pRdzkT6C4+PZnEPk6pdeKtCBQhe8/cPr1kcQ/xm2v2wUxIyRr2f2g4nPfjCll0hPBj3G
X-Received: by 10.107.131.163 with SMTP id n35mr12741316ioi.110.1458860686473;
 Thu, 24 Mar 2016 16:04:46 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Thu, 24 Mar 2016 16:04:46 -0700 (PDT)
In-Reply-To: <CAPig+cQcviTXYAGBTATgYXoaPtvxxeOUtCGYkLyW5oTFvLjEUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289820>

On Thu, Mar 24, 2016 at 3:56 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Mar 24, 2016 at 4:01 PM, work <motroniii@gmail.com> wrote:
>> On 03/24/2016 10:51 PM, Stefan Beller wrote:
>>> On Thu, Mar 24, 2016 at 12:41 PM, Motroni Igor <motroniii@gmail.com>
>>> wrote:
>>>> From: Pontifik <motroniii@gmail.com>
>>>
>>> Here is a good place to put reasoning for why this is a good idea.
>>> I see you have a long subject, so maybe we can shorten the first line
>>> (down to less than ~ 80 characters) and put the longer explanation
>>> here.
>>>
>>> How about:
>>>
>>>    bisect: use unsigned for flag field
>>>
>>>    The flags are usually used as a unsigned variable, because it makes
>>>    bit operations easier to follow.
>>
>> Yep, it's definitely a good idea to shorten subject in order to put more
>> explanations in body of a message.
>
> It is also very important is to explain that you audited all clients
> of this field and found that none of them treat the sign bit specially
> (for instance, by checking the value with '< 0' or some such),
> therefore such a change is safe, in addition to making the code
> clearer.
>
> As an example, a diligent reviewer may wonder why you changed this
> field to 'unsigned' but not the 'flags' variable in
> rev-list.c:show_bisect_vars() to which this field is assigned. This is
> something your re-roll of the patch should take into consideration.
>
>>>> diff --git a/bisect.h b/bisect.h
>>>> index acd12ef..a979a7f 100644
>>>> --- a/bisect.h
>>>> +++ b/bisect.h
>>>> @@ -16,7 +16,7 @@ extern struct commit_list *filter_skipped(struct
>>>> commit_list *list,
>>>>
>>>>   struct rev_list_info {
>>>>          struct rev_info *revs;
>>>> -       int flags;
>>>> +       unsigned int flags;
>>>
>>> You can also drop the int here and make it just
>>> unsigned.
>>
>> In fact, I just wanted to keep this code clear to understand (as I see
>> this). Unsigned short is also unsigned, but a reader should know that
>> "unsigned" type stands for "unsigned int". Anyway, I'll keep this in mind in
>> future, thanks a lot.
>
> While it's true that 'unsigned short' is indeed never negative, the
> clueful reader should never accidentally interpret bare 'unsigned' as
> anything other than the native word size. However, I think what Stefan
> really meant is that, in this code base, it is (somewhat) more common
> to declare these "flags" variables as 'unsigned' rather than 'unsigned
> int':
>
>     % git grep -E 'unsigned\s+flags' | wc -l
>     80
>     % git grep -E 'unsigned\s+int\s+flags' | wc -l
>     57

This is what I meant. (I did not give my grep terms as reasoning as they were
not as exactly as yours. Redoing the search using your more exact terms
however makes me wonder if my advice was the right thing.

% git grep -E 'unsigned\s+int\s+flags' ./*.h | wc -l
16
% git grep -E 'unsigned\s+flags' ./*.h | wc -l
17

So there is no pattern that the version without int is more common.
Maybe my exposure to the code was accidentally in a way such that
I ever only saw the version without int.
