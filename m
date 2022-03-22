Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5060C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 14:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiCVOqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 10:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiCVOqM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 10:46:12 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319161EC62
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 07:43:26 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id a5so1216013qvx.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 07:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KOQbrsg39c3k6v2MmZptAbP2vIztsV6wer7NEZQ9vgk=;
        b=j3iQ62XSFbLZPhTsCt9IVECHxjFScXMxFaX+gfa34Uf3DLb4itCABqmIliC6AaarBP
         YTJAZjDM5G1YqygCsvb7ERLFAZa+ZNTyp9M3vkdb9Jk3ikQZIL2aVNAbpTy07oQqrQX1
         o/Y4NGlhujq2uRxrALV70TSTPqEXNICeZQu99922oJs4McaXog4ggusiBVZr2xNR+nyZ
         e8wNBTiZQrON/wuWZA701O86bfeMJbbQruS6XLrNSB4dsVr0ft+8mOS7Zozt5r8ulfCO
         tJrl5ED7hxvKlKYoxXbtkPtG3NP1CJZrBnw9AF/NEE9u/VW2qTfkB8KbuiYW/cpoFmRH
         S5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KOQbrsg39c3k6v2MmZptAbP2vIztsV6wer7NEZQ9vgk=;
        b=72vbdVkbuhI0RC67OlA4U0sN3EbGmhYGw6BF/GZNXbEXPZuHNHVk1qEGPKHF/f6djm
         xgsu4KE/2W7BVt6kGPZGs0IvV6R0B4p4RC/82bQ6bYFunN+7//4/43nfphSntBvCl5zV
         Lgvg+ObFYw+LpzDDPQAvURSci30q9pQ82UTB8oWwP8usMPH7O05Gp913/TPoFpJc283O
         h3hLCJk93RLCKGddl6F7BOkkhSz1EYnG+XVOAT/fg934q3rlg/XsQeYJSbuhM2Oaf8rY
         XfdFXiA9zIEPWHATivSCT/Hbr/akxPIVUy5qDBtk5lBrYhhXh5UD6TlmlUPn7WzYLr6w
         hciw==
X-Gm-Message-State: AOAM533C70o3fC3Db7AFDdfbul+Sp8qwkTV4yEuQ0xY0b7K9LkgMfyWP
        lrpE0n5AcnX71gvOLQjYSukb
X-Google-Smtp-Source: ABdhPJz125kKRR2XigupD9ad9SKp+e9gHMNDtfBBG+SqCVORHC3ZhSpTJKGIi2AwSVyd6aGJpTESIw==
X-Received: by 2002:a05:6214:e69:b0:440:fa87:a7af with SMTP id jz9-20020a0562140e6900b00440fa87a7afmr15719386qvb.89.1647960205001;
        Tue, 22 Mar 2022 07:43:25 -0700 (PDT)
Received: from [192.168.20.184] (GITHUB-INC.bear2.Charlotte1.Level3.net. [4.4.99.78])
        by smtp.gmail.com with ESMTPSA id 84-20020a370957000000b0067e4c1c8889sm7151611qkj.80.2022.03.22.07.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 07:43:24 -0700 (PDT)
Message-ID: <a9478c1b-4441-0c79-332d-a7c5592dbc70@github.com>
Date:   Tue, 22 Mar 2022 10:43:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 1/7] test-lib: add a "test_expect_todo", similar to
 "test_expect_failure"
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
 <patch-1.7-4624abc2591-20220318T002951Z-avarab@gmail.com>
 <xmqqczij9jeg.fsf@gitster.g> <xmqq8rt77zp7.fsf@gitster.g>
 <220319.86v8waetae.gmgdl@evledraar.gmail.com> <xmqqilsa76ve.fsf@gitster.g>
 <220319.86ilsadw69.gmgdl@evledraar.gmail.com>
 <db558292-2783-3270-4824-43757822a389@gmail.com> <xmqqy2144hwa.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqy2144hwa.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/20/22 2:07 PM, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> .... I had a look
>> at some of the conversions with your test_todo --want/--expect/--reset
>> and found the result really hard to follow. Junio's suggestions chimed
>> with some things I've been thinking about so I had a go at
>> implementing it and doing some sample conversions (see below). Marking
>> the individual commands that should fail is a big step forward and the
>> failing commands are checked to make sure they don't segfault etc.
> 
> ;-)
> 
> Another small detail in my suggestion that will make a huge
> difference in the end is not to introduce test_expect_todo as a
> separate top-level construct, and instead teach test_expect_success
> to pay attention to the use of test_todo "unfortunately this does
> not work yet" mark in it.  It allows us to use test_todo in a shared
> test helper function and call them in test_expect_success, and when
> the step the test helper has trouble with gets fixed, the "unmark"
> step will be an isolated change.
> 
> Your sample change seems to already have it, which is good.

After reading this thread, I agree with many of the ideas that were
generated in response to this topic.

The thing I'm hoping to see from a final version is that a top-level
helper like test_expect_todo will expect at least one test_todo
helper to be executed inside of the test (perhaps communicated by
setting a special GIT_TEST_* environment variable?) and if any of
the test_todo lines change from fail to pass, then that is
communicated as a _failure_ from CI's perspective. Let us discover
if we have accidentally "fixed" any of these test cases and update
the tests accordingly.

I can predict writing a test case with multiple test_todo lines
that need to be updated to drop the test_todo helpers one-by-one
as a change is being introduced.

Thanks,
-Stolee
