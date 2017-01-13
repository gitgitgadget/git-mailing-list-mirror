Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC061FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 01:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbdAMBjJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 20:39:09 -0500
Received: from mout02.posteo.de ([185.67.36.66]:54500 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750890AbdAMBjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 20:39:09 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 530F320C55
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 02:39:06 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 3v04zY4vpszyrx;
        Fri, 13 Jan 2017 02:39:05 +0100 (CET)
From:   Manuel Ullmann <ullman.alias@posteo.de>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: Bug report: Documentation error in git-bisect man description
References: <87r347swz1.fsf@sonnengebleicht.fritz.box>
        <xmqqd1frj1lt.fsf@gitster.mtv.corp.google.com>
        <xmqq8tqfj15z.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD3JDWVVTWsSQcnh+dOHoZDcipVUFwkfQYNOAyV4431C2w@mail.gmail.com>
Date:   Fri, 13 Jan 2017 02:39:05 +0100
In-Reply-To: <CAP8UFD3JDWVVTWsSQcnh+dOHoZDcipVUFwkfQYNOAyV4431C2w@mail.gmail.com>
        (Christian Couder's message of "Fri, 13 Jan 2017 02:13:15 +0100")
Message-ID: <871sw7u4au.fsf@sonnengebleicht.fritz.box>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Fri, Jan 13, 2017 at 12:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Manuel Ullmann <ullman.alias@posteo.de> writes:
>>>
>>> Hmmm, I tend to agree, modulo a minor fix.
>>>
>>> If the description were in a context inside a paragraph like this:
>>>
>>>       When you want to tell 'git bisect' that a <rev> belongs to
>>>       the newer half of the history, you say
>>>
>>>               git bisect (bad|new) [<rev>]
>>>
>>>       On the other hand, when you want to tell 'git bisect' that a
>>>       <rev> belongs to the older half of the history, you can say
>>>
>>>               git bisect (good|old) [<rev>]
>>>
>>> then the pairing we see in the current text makes quite a lot of
>>> sense.
>>
>> Actually, the above is _exactly_ what was intended.  I misread the
>> current documentation when I made the comment, and I think that the
>> current one _IS_ correct.  The latter half of the above is not about
>> a single rev.  You can paint multiple commits with the "older half"
>> color, i.e.
>>
>>         On the other hand, when you want to tell 'git bisect' that
>>         one or more <rev>s  belong to the older half of the history,
>>         you can say
>>
>>                 git bisect (good|old) [<rev>...]
>>
>> In contrast, you can mark only one <rev> as newer (or "already
>> bad").  So pairing (bad|good) and (new|old) like you suggested
>> breaks the correctness of the command line description.
>
> Yeah, I agree.
>
>> If (bad|new) and (good|old) bothers you because they may mislead the
>> readers to think bad is an opposite of new (and good is an opposite
>> of old), the only solution I can think of to that problem is to
>> expand these two lines into four and list them like this:
>>
>>         git bisect bad [<rev>]
>>         git bisect good [<rev>...]
>>         git bisect new [<rev>]
>>         git bisect old [<rev>...]
>
> Maybe it would be more complete and a bit clearer if it was:
>
>            git bisect (bad|new|<term-new>) [<rev>]
>            git bisect (good|old|<term-old>) [<rev>...]

That would clarify the intention quite a bit (at least for me).

Best regards,
Manuel
