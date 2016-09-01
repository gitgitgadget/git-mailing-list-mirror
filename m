Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B95641F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 20:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbcIAU4l (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 16:56:41 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35002 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752104AbcIAU4k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 16:56:40 -0400
Received: by mail-wm0-f43.google.com with SMTP id w2so2252107wmd.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 13:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=UEQwpseBGrPEsM2ikvQvb/92gPtL0tBcdLG83e+7ZYk=;
        b=jSaP8tQCsAuMkd/lP0U8ZjT0ZHpqo0WS0VLNp5U/lWtcv99L8AbBvaH3eRjDU/DW36
         qMh9zr986VRVpPt9SxhtSrMkOZZe1Tsd4OhN3ZXPe5EamcNGOFbyPfku/9bKhitN8TFn
         /kvYoWmd3yQtsYdJgPIpIHB+0ZaY6bPwGFZMHUXJbWz6nRb1+XpCO1qoLmF9unwkI4fZ
         O+gVE6ly6KW6L+Y875YN1Dofjepv7zOHxXKToiRnaLmF8cw4SvvZ+au6ivOD0kcEKOET
         IS6kOvXekf+OiYcDk3R0mLbU/mdQHqMD68Xw3mf7tZC04Uuc1S+TVDeh0QFXfxZe8TYz
         EH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=UEQwpseBGrPEsM2ikvQvb/92gPtL0tBcdLG83e+7ZYk=;
        b=GAPxidBiZ7wU4XqHgYkkZOvK/yQcaYQnEXRluXvXx7YSm1dB8o0raMnEJB+p63MOgd
         N3f0D5dEF5sBfUN4Kw2uglZfgc7KgOAhny3Hx4rD70yb1PKEv7JYQEKebwD6dQj5awOh
         P2yrEufcZzAMh9hIA5b0MuW4vTJHnE0dI93iO1oJM9ltK0RUa4jZkba2qq7fBqFFzLph
         k2xbksmlQql5av+JJ3qIbsvHI1Fcos++O+Nl1vmaGCeIrv1reY9NUq1YRW44XMNyxJ/e
         xMrIArgU0BnzdaSfFz8IhpHmKpFgw+7jsGG/MTuSD/BOyPghgINpP+vJx6zUC4pP5zfb
         JcLw==
X-Gm-Message-State: AE9vXwMpxfFwv0urKHGrgfo0UB+amcmWEUiNw/ZnqBg3+Jbsz+U6T4ahzhFWEEz1GEs//Q==
X-Received: by 10.28.22.6 with SMTP id 6mr17095531wmw.55.1472760047231;
        Thu, 01 Sep 2016 13:00:47 -0700 (PDT)
Received: from [192.168.1.26] (abrf30.neoplus.adsl.tpnet.pl. [83.8.99.30])
        by smtp.googlemail.com with ESMTPSA id 3sm35656wms.1.2016.09.01.13.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 13:00:46 -0700 (PDT)
Subject: Re: [PATCH 08/22] sequencer: remove overzealous assumption
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <3c8c60e0799fdf176c72e7e17c257d33b2a362bc.1472457609.git.johannes.schindelin@gmx.de>
 <09fd1436-301a-b0e1-c32a-81a47e4eb351@gmail.com>
 <alpine.DEB.2.20.1608311706400.129229@virtualbox>
 <18293d15-0a83-d7aa-78fb-14891efd6ea4@gmail.com>
 <alpine.DEB.2.20.1609010957300.129229@virtualbox>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <486c22a4-9334-4c83-746e-7ff6663ce4ab@gmail.com>
Date:   Thu, 1 Sep 2016 22:00:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609010957300.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 01.09.2016 o 10:01, Johannes Schindelin pisze:
> On Wed, 31 Aug 2016, Jakub Narębski wrote:
>> W dniu 31.08.2016 o 20:36, Johannes Schindelin pisze:
>>
>> I wonder: would 'git cherry-pick --continue' be able to finish
>> 'git revert', and vice versa, then?  Or 'git sequencer --continue'?
> 
> I just tested this, via
> 
> 	diff --git a/t/t3510-cherry-pick-sequence.sh
> 	b/t/t3510-cherry-pick-sequence.sh
> 	index 96c7640..085d8bc 100755
> 	--- a/t/t3510-cherry-pick-sequence.sh
> 	+++ b/t/t3510-cherry-pick-sequence.sh
> 	@@ -55,7 +55,7 @@ test_expect_success 'cherry-pick
> 	mid-cherry-pick-sequence' '
> 		git checkout HEAD foo &&
> 		git cherry-pick base &&
> 		git cherry-pick picked &&
> 	-       git cherry-pick --continue &&
> 	+       git revert --continue &&
> 		git diff --exit-code anotherpick
> 
> (Danger! Whitespace corrupted!!!)
> 
> It appears that this passes now.

I'm now not sure if it is such a great idea.  As was said somewhere else
in this thread, different sequencer-based commands sports different
options, and you can add options to the "git <command> --continue".
For example you can say "git cherry-pick --continue -x", but you
cannot say "git revert --continue -x", as '-x' is a cherry-pick only
option.  Or you can, theoretically, use "git am --continue --no-3way".

One option is to temporarily relax the test (test_expect_failure),
then fix it at the end.


BTW. how git-am uses sequencer?  I have seen "revert" etc., and "pick"
etc., but no git-am related constants or strings...

> Probably `git sequencer --continue` would work, too, if there was a `git
> sequencer`. :0)

Right.

> 
>>> On Wed, 31 Aug 2016, Jakub Narębski wrote: 
>>>> W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:
>>  
>>>>> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
>>>>> index 7b7a89d..6465edf 100755
>>>>> --- a/t/t3510-cherry-pick-sequence.sh
>>>>> +++ b/t/t3510-cherry-pick-sequence.sh
>>>>> @@ -459,17 +459,6 @@ test_expect_success 'malformed instruction sheet 1' '
>>>>>  	test_expect_code 128 git cherry-pick --continue
>>>>>  '
>>>>>  
>>>>> -test_expect_success 'malformed instruction sheet 2' '
>>>>
>>>> Hmmm... the description is somewhat lacking (especially compared to
>>>> the rest of test), anyway.
>>>>
>>>> BTW. we should probably rename 'malformed instruction sheet 2'
>>>> to 'malformed instruction sheet' if there are no further such
>>>> tests after this removal, isn't it?
>>>
>>> No, we cannot rename it after this patch because the patch removes it ;-)
>>> (It is not a file name but really a label for a test case.)
>>
>> Ooops.  What I wanted to say that after removing the test case named
>> 'malformed instruction sheet 2' we should also rename *earlier* test
>> case from 'malformed instruction sheet 1' to 'malformed instruction sheet',
>> as it is now the only 'malformed instruction sheet *' test case.
> 
> Actually, you know, I completely missed the fact that there was a
> "malformed instruction sheet 3". I renumbered it.

Ooops.  I have missed it too, having looked only at the test after the
one removed (which is not about malformed instruction sheet).

Best,
-- 
Jakub Narębski

