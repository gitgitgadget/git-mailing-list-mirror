Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D14E1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 18:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754678AbcHaSrR (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 14:47:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36846 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754031AbcHaSrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 14:47:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so8873651wmf.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=o4BArky+V5DRSPo5YqSfP2ZP7zf48AwqOCsuesIvx0s=;
        b=cMk0VEcj9Zhh1/eESkeaoAjae5/rJnNajBG5wJPO0cnkla6696ZRrC/UbAK3DvqttR
         BLpVBrLFpJizgOL+9OfTugyPJd7V5vFh7RnKc/NSInCj1RRkHnUed/NsDtp5S0cp2jVI
         z5VpkDGKCnHx2/rq6iS42E62PS1VVYzOUy4in/30pFFTtaVwYswcvCwV+UYr0zYjzSac
         FdGvnLnU4RBRno1zyXHZQy/ECpSGI/nFabYQ8Io71Yih7PlZXg213Gwqv+U7GyEWe75G
         N/YLGLdaLK7NfDstaDAXMHvRgw0UswWpV9PEj+Svo2KZ8Q/WdVxjGfk7AsP0VxUwd5sg
         YulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=o4BArky+V5DRSPo5YqSfP2ZP7zf48AwqOCsuesIvx0s=;
        b=MjcwMBXGB3Xj7Eqy9fFqgPbHD058ScAWFNOy7UMW5fBcGyha2XxZr3p0D2XMSIyCMY
         tRi2/drevsUgvuvDxtfDPz8TF6GL68vbusnnAbeBKKiBYmr9aQvndBWUFt030w8k2zY6
         1TkRZLKfIT6/Nbod324BzREvVVRXICTuUgbhZZ6/ezi/01W3cRDc7XnTiT9Ex1MJUBZ4
         4unB+j0ZzeyMvlV4xKhZ6DrAJQlc22AK1vfpZh2bXH7cvH4R/kNJx/jLaP96OEfk3m1C
         rpujZf1Y8scwMe6lt4iuSQSPEiyWyiXEz6dDgGj6lRfWxSornT+XT+VAOGB9pzqNHbaB
         weaQ==
X-Gm-Message-State: AE9vXwOyvuBCc+/Vx8V/u5KKdamiCTz+AvVYDGBQf7PAExOpsMQNWyo5zE96uOpqZuiARw==
X-Received: by 10.194.190.232 with SMTP id gt8mr11141587wjc.141.1472669199863;
        Wed, 31 Aug 2016 11:46:39 -0700 (PDT)
Received: from [192.168.1.26] (enu134.neoplus.adsl.tpnet.pl. [83.20.10.134])
        by smtp.googlemail.com with ESMTPSA id t202sm24926413wmt.22.2016.08.31.11.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 11:46:39 -0700 (PDT)
Subject: Re: [PATCH 08/22] sequencer: remove overzealous assumption
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <3c8c60e0799fdf176c72e7e17c257d33b2a362bc.1472457609.git.johannes.schindelin@gmx.de>
 <09fd1436-301a-b0e1-c32a-81a47e4eb351@gmail.com>
 <alpine.DEB.2.20.1608311706400.129229@virtualbox>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <18293d15-0a83-d7aa-78fb-14891efd6ea4@gmail.com>
Date:   Wed, 31 Aug 2016 20:46:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608311706400.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 31.08.2016 o 20:36, Johannes Schindelin pisze:
> On Wed, 31 Aug 2016, Jakub Narębski wrote: 
>> W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:
 
> I am of the opinion that overzealous checking of certain implementation
> details is something to be avoided.

I agree.

>>> Therefore let's just get rid of the test that wants to verify that this
>>> limitation is still in place, in preparation for the upcoming work to
>>> teach the sequencer to do rebase -i's work.
>>
>> Is it "upcoming work" as in one of the patches in this series?
>> If so, which patch?
> 
> I left this a little vague, didn't I? ;-)
> 
> The problem is that the `git-rebase-todo` most definitely does *not* want
> to be restricted to a single command.
> 
> So if you must have a patch that disagrees with this overzealous check,
> the "revamp todo parsing" one is probably the first. But it is better to
> think of this at a higher level than just patches: it is wrong to limit
> the todo script to contain only identical commands.

I see.  Right.

I wonder: would 'git cherry-pick --continue' be able to finish
'git revert', and vice versa, then?  Or 'git sequencer --continue'?

>>> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
>>> index 7b7a89d..6465edf 100755
>>> --- a/t/t3510-cherry-pick-sequence.sh
>>> +++ b/t/t3510-cherry-pick-sequence.sh
>>> @@ -459,17 +459,6 @@ test_expect_success 'malformed instruction sheet 1' '
>>>  	test_expect_code 128 git cherry-pick --continue
>>>  '
>>>  
>>> -test_expect_success 'malformed instruction sheet 2' '
>>
>> Hmmm... the description is somewhat lacking (especially compared to
>> the rest of test), anyway.
>>
>> BTW. we should probably rename 'malformed instruction sheet 2'
>> to 'malformed instruction sheet' if there are no further such
>> tests after this removal, isn't it?
> 
> No, we cannot rename it after this patch because the patch removes it ;-)
> (It is not a file name but really a label for a test case.)

Ooops.  What I wanted to say that after removing the test case named
'malformed instruction sheet 2' we should also rename *earlier* test
case from 'malformed instruction sheet 1' to 'malformed instruction sheet',
as it is now the only 'malformed instruction sheet *' test case.

