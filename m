Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC7DC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 16:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C362078A
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 16:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FfScZYmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbgFWQnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:43:06 -0400
Received: from mout.web.de ([212.227.17.12]:56509 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732416AbgFWQnF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 12:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592930569;
        bh=zGKnrFMjbgqyrAmlzlTafgOxTpUIO7I4oJcW5561v6w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=FfScZYmIBotShpZYfCUuMrTd3H/wmdqXROCXZ/QX1P/GirUKmxKzs3wyVtbUMdehG
         pVKZXfvsMY2GTasGz8/ZbgP/P6Us501i31z/bYDyQ7ZXVQivERQTaxN/Z6pfjZLRmL
         CDykqZ5jozuSzGGUbiXrvJhZqXsGR/kk8zRXaEDQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4sXt-1jobUM2CWd-001z6Z; Tue, 23
 Jun 2020 18:42:49 +0200
Subject: Re: Git 2 force commits but Git 1 doesn't
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Ward <mward@smartsoftwareinc.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <dea24348-770c-1228-115d-23153fbecebd@smartsoftwareinc.com>
 <20200622202122.GO6531@camp.crustytoothpaste.net>
 <a42d038f-bf14-8f1a-927e-7488796e7710@smartsoftwareinc.com>
 <20200622204346.GP6531@camp.crustytoothpaste.net>
 <8ad16219-2426-6127-b41d-bb3007a9b993@smartsoftwareinc.com>
 <20200622210953.GQ6531@camp.crustytoothpaste.net>
 <2e43580c-9952-9ccf-6b35-27a4333fb83e@smartsoftwareinc.com>
 <20200623010519.GR6531@camp.crustytoothpaste.net>
 <09a7fa54-d7ae-772c-fb36-29dbd27bc626@web.de>
 <20200623151951.GS6531@camp.crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>
Message-ID: <83e99359-2c24-d8cd-bd4a-6ba90ed54b7f@web.de>
Date:   Tue, 23 Jun 2020 18:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623151951.GS6531@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+m1SwOSfwIkjgmPJuzw9RnEOzPNxmTIW5+nXLyfwmqZurPujZDE
 idg4x2a9FlucsVeI1+rU4VpmcHDHXbUV+5A/KBfsKX7DXEeUW+wu+gyY18ZrT9o6/Kf5sOk
 JyLHIaMIzqHfJKbhRiUo7rINRz/wktYjcqeTi3Nus4v1XjVNS//9gVZlByZuxJfpl9dohjo
 TUhur6cXJTc9SloJVOVQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MZP1vyIe/L4=:A6HKCHNEuBcU52xatDuEto
 u5s5HpIeLYWa2D12k5DwfSOQ1LJ1XrR3EdgEzSbNnMlQHmpAaIswjCvRgPXlrH0BpmOn5zMJ2
 AwcHl9O6ZEKHRg6l980Oa99pUgVNZ1+l11oQmKyD1T5kIodrlVCI9fC22YMxKYGXRFcbY0Iui
 uskdF/u30DqQibAJfGREbaTxKnl6zZZcY6xyJLhDVkEBN7Y4IFSVXzs85V/owCNzjDauJZKOI
 a6wDVcoXloruBWBgSz0wdKzUu2QAMx7SW+5fTzIMrsIuM/GyiUTBi4cYY9ruUkC13USq0gRBc
 Ki7o5wGWTYirEyTihqLiJd6A2itu/DCbcSWjff1/YdfP5ztIHhWbQKAZUJ8jjG43ZEF1IDfa2
 MJKJx8ObP+WRtqm4vkNmPrYJbiJ5+WK4WYgcR5U5f+7MzpxEVPHJMAyg7e6v2cYuPsO52mKXB
 +VSQd1I4tkBw6EHmXd26KTSp/3tv+bZYHojrgKEhx7LnLQ7oL+oVvPJuQAqCvIl1V3l/wmdXu
 Q4d5Hs5g0ybV1QI8xo0XGLVr8saDRHnxanCCvTfwwIj/NE3PeKHat75tMGyrCvvZC82BV/EMw
 KW3NpEoqEp1vLKLtiv6ktyVHTvSsF8GWPrrSPwS2FpV5GVvZKkXUi43cTmCvQUtqlsu2YFsu6
 oyJ2UYKKsr8fg3cDMaHFrO8Guob0FFBRy+FIG4xdpwvkY+yBVnpHQuihPXHCmpALW6hJrGw83
 VGYdOzpAluESZ7q/H6kaAnmLbgRbwcTDgxMI6EoXW5nUsP2TOrx/KWklKbenZN71i3DY6GEwf
 M6Mo4FLIX7UfTsv/kJSM5S0PsZoeoroDMscaSNq5oCAliLBFztMQv3kPMbRtWue4XG2xVrUD6
 q9vsDsTbc72Bxr9im+1pUIQxmrz4uAayeRFQt/FYoB2TepNRh5wNd843pk6nCqVwdsG5KWjN/
 IscICbekM2jfaGq6tiCdwp3Miz7KRLh/lovIQLX+0DZDyBMsj2RuzipQF9pZ/6dWBQbKGwgdy
 m3A8nypQSlwxCdQOO1Rl1NKVUBPyoV+bSFRJSr1ipu6PYcUxErftP7g4n486D6wtoHZRpTjyJ
 WC5F93naWDxCBIauKowrMS+sVemw/EHntLTJ/uEMnratpliHTtA4UP32an0fGcu626rnm0ELQ
 oOTpdqNeoCgoHxX6S2Ffqq6AG6JP3feDxK8Lb/csmFBsmtiwRu/W6EuTqhYLWcONsGeWI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.20 um 17:30 schrieb brian m. carlson:
> On 2020-06-23 at 08:59:28, Ren=C3=A9 Scharfe wrote:
>> How could we possibly check that?  Perhaps by having a commit flag
>> register (a global unsigned int) and having functions announce their
>> bits in it.  Colliding announcements would BUG().
>
> By my count, we have only 88 individual bits used.  If we moved all of
> the builtin functions plus upload-pack (which shouldn't overlap) to a
> single range, that would account for 53 bits, which would leave us 35
> bits for all the rest of the code.  Since we need at most 27 bits for a
> builtin command, if we used a 64-bit integer, we'd have space for all
> the remaining bits not to overlap, plus bits for the type and flags
> bits.
>
> Since we'd be doing only bit operations on the flags variable, the
> performance impact on 32-bit systems would be very minimal, although
> we'd allocate an extra 4 bytes for struct object.  I don't know if
> that's a problem.

How many objects would we load into memory?  4 bytes would be OK if
multiplied by a million or so (like in the Linux repo), but billions
might cause problems.

The switch from SHA1 to SHA256 is going to add 12 bytes per object, so
that might be a way to find out what happens if we add 4 bytes on top.

We could save 4 bytes on x64 by reducing FLAG_BITS from 29 to 28, by the
way.  Increasing it to 32 would be free.  That's because parsed (1),
type (3) and flags (29) currently occupy 33 bits, which are padded to 8
bytes.  And bits 22-24 are only used by builtin/show-branch.c, so it
should be easy to tighten the flags range just a bit.  Weird.

Why do we have object flags and not commit flags anyway?  (I may have
asked that before, but can't find the answer..)

> Assuming we don't want to do that right now, may I have your sign-off
> for the following code, Ren=C3=A9, so I can add it to a patch along with=
 my
> test?
>
>> diff --git a/http-push.c b/http-push.c
>> index 822f326599..99adbebdcf 100644
>> --- a/http-push.c
>> +++ b/http-push.c
>> @@ -70,10 +70,10 @@ enum XML_Status {
>>  #define LOCK_REFRESH 30
>>
>>  /* Remember to update object flag allocation in object.h */
>> -#define LOCAL    (1u<<16)
>> -#define REMOTE   (1u<<17)
>> -#define FETCHING (1u<<18)
>> -#define PUSHING  (1u<<19)
>> +#define LOCAL    (1u<<11)
>> +#define REMOTE   (1u<<12)
>> +#define FETCHING (1u<<13)
>> +#define PUSHING  (1u<<14)
>>
>>  /* We allow "recursive" symbolic refs. Only within reason, though */
>>  #define MAXDEPTH 5
>> diff --git a/object.h b/object.h
>> index b22328b838..a496d2e4e1 100644
>> --- a/object.h
>> +++ b/object.h
>> @@ -67,7 +67,7 @@ struct object_array {
>>   * builtin/blame.c:                        12-13
>>   * bisect.c:                                        16
>>   * bundle.c:                                        16
>> - * http-push.c:                                     16-----19
>> + * http-push.c:                          11-----14
>>   * commit-graph.c:                                15
>>   * commit-reach.c:                                  16-----19
>>   * sha1-name.c:                                              20
>>

You're welcome to use it.  Not sure if a sign-off is necessary, but
here you have it:

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

