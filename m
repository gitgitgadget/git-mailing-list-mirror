Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129A3C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbiDEVnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457517AbiDEQDT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:19 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43AB20E
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1649174272;
        bh=Rjimp8G7L2wz8jGHvK3EN4ikOVwvuSimNBQbj74px+E=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=syBuGaZEn+Pqzc+IieDtn2iyeU9Ch6PA5C0pXixFKi4WahxPYHhH/EFqxTQ8c0d6s
         t1RqzYnjzOlm7abL53+m16Cpj0EfZWXxh8anTkAGymeXTrvy5zDfRGDdocLZi2hAX5
         qta8+RU/ZIFQoonMmoM90X3BRrlXdc7LrtokKR30=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuVGA-1ntyyI2mfa-00rQVN; Tue, 05
 Apr 2022 17:57:52 +0200
Message-ID: <3dbc5e5c-19dd-eef0-7ce9-e5b639cfb133@web.de>
Date:   Tue, 5 Apr 2022 17:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: Git has two ways to count modified lines
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Laurent Lyaudet <laurent.lyaudet@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Eckhard_S=2e_Maa=c3=9f?= <eckhard.s.maass@googlemail.com>,
        Elijah Newren <newren@gmail.com>
References: <CAB1LBmvX4kv3yqSZ+X4Ozkb9esUem3U1JY48kWVi_Eef78Sk=Q@mail.gmail.com>
 <CAB1LBms3F1EGswxF9mO=JrmWmj4XFncv4ZrkAy-dvOHdVrkwLQ@mail.gmail.com>
 <d650bb90-df94-eeab-0684-ee447e080ad6@web.de> <xmqqh779u72a.fsf@gitster.g>
 <c35bd0aa-2e46-e710-2b39-89f18bad0097@web.de>
 <220405.865ynomgkg.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220405.865ynomgkg.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AR5WmhHVyM/zYcBQjzbhGmzeeO/2kaDhCQOa6/mVMFVs0oAjAaQ
 80/5l8jMj4qVtkT5u15blDD28IJVOti1mPBSeJqPJvXgzHpm1K4LTVRP/jvI4PqM2SwhvCA
 TuLiFrRQW6kTH7ErgzUHmfbjwVIn3i++aL6BQNDmYgz7L1ypkVfZkV9Lea9eBS8Bddh3dIg
 XkAAzAvPkdauilyKLaj2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oO5gnjnqB84=:NX4C0VKbXG57nSujJe8L4U
 s7zNFh34PsRc2LPKm4II5+6t5WcvYmtIORWYnhXFeYvBPzgX5K+hippvxemdLvKKnfRxNvJAf
 ZXY/2uq00FNeuFgQcNNwCbveCv3UoGKqEksF3ojNV0wlLkMsdxX3B68Kb7y2yxew+fnvr8LBj
 XAzKUsXjMnnyu851k+HSTxlvXKmxXsNgKln2CGnAuy535BrqcxTfPRNTmTpHmLo3xJ0QOaZ8t
 nwvVhizu/w+Vh62dd2hBDCv+9qfk0HEVW9KcW90tZjaRXI/yT6vqkdH6Any3hZ9R9AljO7DrL
 9LcwC/QiqaUidNkGy5O3av1SgkTJ2GaEg2aJpArQlEty5G6caS38sdM7zqo3tXkI3PnnqEJ5U
 F393evAUfuRH0nsVhHTA0lQiofWlOnB0aTrqm8cUSbIFDaMtguLxLRHUtcwAKVDzP3q+3nmLr
 6z65gsedsAH9HZRGJzBAP3r7RtcZJJ2j3z10z8QyIi6LNYIv6/zuSJxlfoEvW5Q0j/HL1SlVf
 c0V8Mnx4+UxIhGd6XItL728lOCXfS2HOqjay9wRIe6kyg21coTKGvSyA4fsgKEkCN4HZMA2hk
 WwTZRceFMEFdFL3hLYEDUfnRIwlQkZFzQ4PFqnIeRZcEWfYbugmmLh2Q16rtzD9M6fWPWmRmu
 rxMJyMtD5ErcHvSrn9UWeab+gXkTg58SRqPZLLMnXhQgqrTpLudY26n6p9r1E3TtGUCEUCXT0
 cP9g4xD4IsZKmaVNpIFyYo/8ouhG2IJeAz0uzkgu5CQNMZdWypRg9VBsJniLXniDRc3xvwOOZ
 kzXY5bPWEPzx2RuyTUU61W44s94uvRwyDbF7EaaG5noaX99N08pJt7ufb+PoImG8DIkvv1K1K
 xQEMuf2zk1Wodg6zfSsud7w9FDgU2Yzzj05EnlJNE5J8jbYRvv5w/GqqmMzZ8BDEX8B/R0ErT
 vBapc1ETmClbSNEnQKxZG2+3vGcSZvffPlQXzX1BjWn3T03gaJ89TxhfgrogAunG8M3RvqdcE
 o/Nm6pN3u0Mmi2sfNYdbfv+vZH8vEPbgLsaAxOOu4W65EZPQkWBtipMi73c90U7abMqSNzGkV
 5BiJr+m06a0bJc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.04.22 um 03:58 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Apr 04 2022, Ren=C3=A9 Scharfe wrote:
>
>> diff --git a/sequencer.c b/sequencer.c
>> index a1bb39383d..85a17d45bd 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -1327,7 +1327,6 @@ void print_commit_summary(struct repository *r,
>>  	get_commit_format(format.buf, &rev);
>>  	rev.always_show_header =3D 0;
>>  	rev.diffopt.detect_rename =3D DIFF_DETECT_RENAME;
>> -	rev.diffopt.break_opt =3D 0;
>>  	diff_setup_done(&rev.diffopt);
>>
>>  	refs =3D get_main_ref_store(the_repository);
>> diff --git a/t/t7524-commit-summary.sh b/t/t7524-commit-summary.sh
>> new file mode 100755
>> index 0000000000..47b2f1dc22
>> --- /dev/null
>> +++ b/t/t7524-commit-summary.sh
>> @@ -0,0 +1,31 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'git commit summary'
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup' '
>> +	test_seq 101 200 >file &&
>> +	git add file &&
>> +	git commit -m initial &&
>> +	git tag initial
>> +'
>> +
>> +test_expect_success 'commit summary ignores rewrites' '
>> +	git reset --hard initial &&
>
> A leftover debugging aid?

No, I expect all tests in that file will need to reset the state and
didn't want to make an exception just for the first one.  It might be a
case of YAGNI, but I put the reset in intentionally.

> You can also use test_commit earlier:
>
> 	diff --git a/t/t7524-commit-summary.sh b/t/t7524-commit-summary.sh
> 	index 47b2f1dc22a..60027e86ccd 100755
> 	--- a/t/t7524-commit-summary.sh
> 	+++ b/t/t7524-commit-summary.sh
> 	@@ -4,14 +4,10 @@ test_description=3D'git commit summary'
> 	 . ./test-lib.sh
>
> 	 test_expect_success 'setup' '
> 	-	test_seq 101 200 >file &&
> 	-	git add file &&
> 	-	git commit -m initial &&
> 	-	git tag initial
> 	+	test_commit initial file "$(test_seq 101 200)"

Nice.  Would ignore test_seq errors, though.  Probably not worth
worrying too much about.

> 	 '
>
> 	 test_expect_success 'commit summary ignores rewrites' '
> 	-	git reset --hard initial &&
> 	 	test_seq 200 300 >file &&
>
> 	 	git diff --stat >diffstat &&
>
>
>> +	test_seq 200 300 >file &&
>> +
>> +	git diff --stat >diffstat &&
>> +	git diff --stat --break-rewrites >diffstatrewrite &&
>> +
>> +	# make sure this scenario is a detectable rewrite
>> +	! test_cmp_bin diffstat diffstatrewrite &&
>
> Is this really binary? I removed the ! and tried test_cmp, and it's just
> a diffstat.
>
> Elsewhere in the test suite we test_cmp this output, would be
> clearer/easier to read to do the same here if possible.

The required result is one bit (same content or not?).  That sanity
check should not waste cycles calculating and printing a diff of the
diffstats.  I only want to make sure they are different.

>
>> +
>> +	git add file &&
>> +	git commit -m second >actual &&
>> +
>> +	grep "1 file" <actual >actual.total &&
>> +	grep "1 file" <diffstat >diffstat.total &&
>> +	test_cmp diffstat.total actual.total
>> +'
>> +
>> +test_done
>
