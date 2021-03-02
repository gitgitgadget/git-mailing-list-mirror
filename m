Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05312C433E6
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1D964ECF
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347028AbhCCGbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:31:43 -0500
Received: from mout.web.de ([212.227.15.3]:37609 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1446277AbhCBQDK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 11:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1614700814;
        bh=DDGqQj0Ma13AG/z/QSrwrf0wjwuBnWeHsC2VcdUiPu8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Q648cQ9r8cHDdBXPTOfKMmSHDFdz2rzp9UoJF/bSe/NfjTpfdEKd/X4CXHK/tLh5f
         +ZPmqIr+b/UTx83j0yFFsQkwshbSNSgw+OGaYMHAuP20agWVckvz87wQWHz/NPf5I4
         SGx1ZpQObbtMSQ1aaTiHBZ+Fxzaf+G99ncTmCaNY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MIyeU-1lVuVA2huU-00KmpD; Tue, 02 Mar 2021 17:00:14 +0100
Subject: Re: [PATCH 1/2] pretty: add %(describe)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
 <87pn109nhr.fsf@evledraar.gmail.com>
 <xmqqft1vrgxa.fsf@gitster.c.googlers.com>
 <87mtw3a5af.fsf@evledraar.gmail.com>
 <c65039f2-46d3-bbb4-1aa1-e0ce89f69b64@web.de>
 <xmqq35xesqzk.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <be83e397-f1c1-3483-1ad4-b71067779f6e@web.de>
Date:   Tue, 2 Mar 2021 17:00:14 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <xmqq35xesqzk.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UhywDWeYaZbheSXdxiUh8FAJohZvL+mnleP/xirB8Bhr/hk2BRp
 W1HdJGe3yU3tBJFUA1cDbMHbX17jloH/7JeUKt5H0Wd4DJzHOYWmb7IgKivsxzDIQMCdb0B
 d2EFeH/0X410dPU3sZ9SXx6zkt630IjZ9A6WrEF7/L5wTWPhM7uymdKbXp0OqT9Pqyo5DJ/
 hFKvv9WzLcK8RZ4v52xZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2taYWojngRM=:3/MzcC1liwK7P0QlANuAKA
 zehVZr5Ao+0f418c+HN0hxU2axc0o44UHGOEJ8K0xZTeOtPCO0S31iJMaiLibW9oi/15/2Oj1
 jmow/4f7Pm7tfE+sdPwWOMU7iUtXbvvV6PL2FaVqbLKm1hAwehJVy9asobeJC/cFdEXH7yPu9
 Vd0Zms3JGwf0xJCztVkSc23EeQtcybaqaS2EHSl4t1mq38HS+zPg5XIDADPOOrHsSpUojO8aW
 WWhIRVqW9WhW8yLLpaAQijJLnZcjvTxreQKiYTvztX1ncDlloCiLonCl26bHJ3zCbXxZxpjje
 e+0I9jPdaHWl4T72GA+PQPoqhEcCrGAsMsn7yXJjvmmewnAzzgfldMRXyPjQeGhPBES2z5TEJ
 rNl7qAUFeuLVRqqZ9+7YGikNl/kxWRN1UMIZLuYjx4G2wE7KchhNdg9qdGV7CYwo6fy4LxIYh
 kpu57G3l/wBYy6RM2ZiuTirtTeoqShqmhqJ5pkeQzONjRn8EKjarT17MRHyb9/3qlvxkhvLcx
 PR8f7NFIjPrp0lCuAooPHziivyaW+0/N1xKppQ6kPgDqctfpNRlCYuA6ePoa/DuggayQhpkQR
 qshHlv2AYJFNrY/DpxI06AJvsotRDEGDuWqzJH20RFJFpk02vu/7Gw0whDucUgAohvEmOkkcG
 n8RMDR9tp9igl9s6NbhwFTNTg60t5qYT8ovJbSSvXG6cNTNL41n2rAoVeeZnny1FwZPGP4Qj3
 IEdGrzEv086rSREBhBUdBELtWlW57xO3lderw9UBb/cm8Q7WgeMIPbYPbz4IQaoi/vYBA6KqP
 nqRrhH7VjABvPaAL0KxGMLz4f2/bDxCtLgB0JHkk+UElrW/59qhG+aHPWUsyIc/2juaRP/7a9
 mrmcBDg9myzZcJ09Y/AQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.03.21 um 18:50 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe. <l.s.r@web.de> writes:
>
>> Am 17.02.21 um 01:47 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>> Usually something shelling out has going for it is that even if it's
>>> slow it's at least known to be bug-free, after all we use the command
>>> like that already.
>>>
>>> I just wanted to point out this edge case, for "git describe <commits>=
"
>>> we do the ref list once at the beginning so our N list will be
>>> consistent within itself.
>>>
>>> Whereas one might expect "git log" to also format such a list, but due
>>> to the internal implementation the semantics are different.
>>
>> It shouldn't matter for the intended use case (git archive containing a
>> spec file with a single "$Format:%(describe)$") and I cannot imagine ho=
w
>> consistency in the face of tag changes would be useful (what applicatio=
n
>> would be OK with consistently outdated output, but break with partly
>> outdated descriptions).  But it makes sense to mention it in the docs.
>
> Does it?
>
> As long as the reader understands "git describe" is about measuring
> the "location" of given commits relative to the annotated tags (or
> whatever anchor points the invocation chooses to use), I would say
> that it is unlikely that the reader does not to realize the
> ramifications of changing tags in the middle.

I actually agree, but I'm biased.  The thing is: The question came up
and needed answering, so there is a chance that it might help someone
else as well.

> While it may not be incorrect per-se (hence it may "not hurt"),
> making the description longer does hurt the readers' experience.

The added sentence would look better in a smaller font, or in a
footnote. :-|

> So, I am a bit skeptical if this is a good change, but will queue
> for now anyway.
>
> Thanks.
>
>
>
>> -- >8 --
>> Subject: [PATCH] pretty: document multiple %(describe) being inconsiste=
nt
>>
>> Each %(describe) placeholder is expanded using a separate git describe
>> call.  Their outputs depend on the tags present at the time, so there's
>> no consistency guarantee.  Document that fact.
>>
>> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  Documentation/pretty-formats.txt | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
>> index 231010e6ef..45133066e4 100644
>> --- a/Documentation/pretty-formats.txt
>> +++ b/Documentation/pretty-formats.txt
>> @@ -212,7 +212,9 @@ The placeholders are:
>>  			  linkgit:git-describe[1]; empty string for
>>  			  undescribable commits.  The `describe` string
>>  			  may be followed by a colon and zero or more
>> -			  comma-separated options.
>> +			  comma-separated options.  Descriptions can be
>> +			  inconsistent when tags are added or removed at
>> +			  the same time.
>>  +
>>  ** 'match=3D<pattern>': Only consider tags matching the given
>>     `glob(7)` pattern, excluding the "refs/tags/" prefix.
>> --
>> 2.30.1
