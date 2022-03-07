Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EF3C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 17:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiCGRNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244451AbiCGRM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 12:12:59 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B4E85650
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 09:12:04 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r10so24424298wrp.3
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 09:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w6qCRlQxBLTI/CWac1A1t499c+5Aa/rVDLJavyTnhzU=;
        b=CU6+G/5Y51cigni5Vch0SCL1hfSDoo4sEK1IkLnC8LbbRmK6U9eTA7i1aRbEocdZjl
         3L3MXIpFL+lYTIPTG3PGc2zFwUnA0d6+FB8RvAOap44jvl2fUxp+8uQ1ySjhcCsBitgL
         zzGUwf4cXQZpxJwII5krhuD0YpBNqQsY1xLa/4vcB2Ud1i5XPRwBuAULfU+IJvpIr9RJ
         rpvdCS6vBdw45dYMO3mcNkoaZSUr69TCFBGgWDXFJmXV8HPzdcy8Co+eZL0fNDNvJEx7
         YWEWVOQm6NJP05Hlflh8P/4MxMNxYPvSEUY2/rddHE6WKKGxu3pcT0lUKYeFXpTlcAZz
         3dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w6qCRlQxBLTI/CWac1A1t499c+5Aa/rVDLJavyTnhzU=;
        b=GxwCQ2+HY7yr5Ub4rrvkP9YQc2Xu1q1Py3PZnmWZ1ZSZSFuI2D0sjH2PFuj8VYa1pO
         Nrozm13WvswgcmwPQPAt5WQk7yz/yYnzt5ICcoRqp4Ie3wJATk0ysgCpz3vbY/Oia9U2
         MQJY43iAyNJyebuPcjsXRebWOFmnyaFRrDDJM6lllXuItin5C+VqW7WD3KFsvepcfhUb
         ZoXQbuUJmVIhmKJOjb882INg2U/I1YFVTEVMcpaGlMjPPd425dq7M7jQr5Wh+jjK89Qc
         Cmm7IwjpWpc6XzKfNINQwBVPylYO3zWZVFVGJOSknBkLcNiBNwG75ogGnf9v+BUGTm0j
         B1Eg==
X-Gm-Message-State: AOAM533qfHK48e/96HLyrkf6JI/UJKr0BHCqmPiWCvyUjSby0DXleikD
        iQ1+VWomsYq550azCJFgvsM=
X-Google-Smtp-Source: ABdhPJwilKp0HkM8MZ1TJ/UFy1OBIl6DaBC8pNyfCK+PRrhns1ILq5KW9ZyeIG0L0TU19UD95ql2KA==
X-Received: by 2002:a5d:648f:0:b0:1f0:567b:5619 with SMTP id o15-20020a5d648f000000b001f0567b5619mr8818956wri.66.1646673123309;
        Mon, 07 Mar 2022 09:12:03 -0800 (PST)
Received: from [192.168.1.201] (206.2.7.51.dyn.plus.net. [51.7.2.206])
        by smtp.googlemail.com with ESMTPSA id a8-20020a05600c068800b00389bdc8c8c2sm516171wmn.12.2022.03.07.09.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 09:12:02 -0800 (PST)
Message-ID: <dd45f032-9b42-c3f3-b3ae-78e3528d20aa@gmail.com>
Date:   Mon, 7 Mar 2022 17:12:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
 <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
 <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
 <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
 <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
 <30dbc8fb-a1db-05bc-3dcb-070e11cf4715@gmail.com>
 <nycvar.QRO.7.76.6.2203071657180.11118@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <nycvar.QRO.7.76.6.2203071657180.11118@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho
On 07/03/2022 16:07, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Wed, 2 Mar 2022, Phillip Wood wrote:
> 
>> On 25/02/2022 14:10, Johannes Schindelin wrote:
>>
>>> On Wed, 23 Feb 2022, Phillip Wood wrote:
>>>
>>>> With the first link above the initial page load is faster but to get
>>>> to the output of the failing test case I have click on "Run
>>>> ci/print_test_failures.sh" then wait for that to load and then
>>>> search for "not ok" to actually get to the information I'm after.
>>>
>>> And that's only because you are familiar with what you have to do.
>>>
>>> Any new contributor would be stuck with the information presented on the
>>> initial load, without any indication that more information _is_ available,
>>> just hidden away in the next step's log (which is marked as "succeeding",
>>> therefore misleading the inclined reader into thinking that this cannot
>>> potentially contain any information pertinent to the _failure_ that needs
>>> to be investigated).
>>
>> Yes it took we a while to realize how to get to the test output when I first
>> started looking at the CI results.
> 
> Thank you for saying that. Since nobody else said it as clearly as you, I
> really started to doubt myself here.
> 
>> One thing I forgot to mention was that when you expand a failing test it shows
>> the test script twice before the output e.g.
>>
>> Error: failed: t7527.35 Matrix[uc:false][fsm:true] enable fsmonitor
>> failure: t7527.35 Matrix[uc:false][fsm:true] enable fsmonitor
>>    				git config core.fsmonitor true &&
>>    				git fsmonitor--daemon start &&
>>    				git update-index --fsmonitor
>>
>>    expecting success of 7527.35 'Matrix[uc:false][fsm:true] enable fsmonitor':
>>    				git config core.fsmonitor true &&
>>    				git fsmonitor--daemon start &&
>>    				git update-index --fsmonitor
>>
>>   ++ git config core.fsmonitor true
>>   ++ git fsmonitor--daemon start
>>   ...
>>
>> I don't know how easy it would be to fix that so that we only show "expecting
>> success of ..." without the test being printed first
> 
> It's not _super_ easy: right now, the patch series does not touch the code
> that prints the latter message. In fact, that latter message is generated
> _before_ the test fails, and redirected via `tee` into
> `GIT_TEST_TEE_OUTPUT_FILE`. Then, once the verdict is clear that this test
> case failed, the first message is printed (the one that is colored in the
> output via `::error::`), and the output from the
> `GIT_TEST_TEE_OUTPUT_FILE` file is pasted, starting at the offset marking
> the start of the test case.
> 
> The easiest workaround would probably to add a flag that suppresses the
> header `expecting success` in case we're running with the
> `--github-workflow-markup` option.
> 
> I'll put it on my ever-growing TODO list, but maybe in the interest of
> heeding the mantra "the perfect is the enemy of the good", this can be
> done on top of this series rather than blocking it?

Sure, I mentioned it in case it was easy to fix but I don't think it 
should stop these patches moving forward

Best Wishes

Phillip

> Thanks,
> Dscho

