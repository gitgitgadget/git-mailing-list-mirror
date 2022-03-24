Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0185DC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 11:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347540AbiCXLZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 07:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242795AbiCXLZm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 07:25:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C959B5B3ED
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 04:24:10 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so2375769wmp.5
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 04:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aWvV3sERolfA8PhFkTh4nhIBqFFzbQ2F73/FRUONGs4=;
        b=Sip0Pt6i0rr+jI/xcANvtzNoswDMbwW/M4C85bD22WNt96y729nG639HFbCkP6WmcV
         ll+xbtFGB62PPhJfBfvbH1exkXGaqUPDeHqeYEGsCxTuDhtw604sA09W54abR9uilH84
         Um6W0V6843j3ymqIlrtBQWFWSFIuaYNIXtJhUoJFMYwuykx1zbfJVaL1WaZQLg9mluXU
         O7BW3eu63SSM6K4RCtksA9RNB3lquEW9AsrOBVOdGEUJ3zrhjn5b7LET38Rv0Q9sH5Y9
         kp15EFlwHIUvVlqMLpCoKoHz9rEbZXYkUzk5slqM7zKzT30cs6l88lYa3mGG+THMOWBy
         cyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aWvV3sERolfA8PhFkTh4nhIBqFFzbQ2F73/FRUONGs4=;
        b=U5GPzQyt2XmKvtnvv8mb516Y54wC3pOrK5DDStARTXqZ23xK4rHi8M6PeB46POTI7B
         Or5d0khoIloPj+VSXW5nRXosAAHy3wjZfMx95Aw1FeveIC4oqZXg7akbuEXOpBNgDKsO
         E5hwRWDXvSWLCdk7N0roQLK0wWYAJHPTtXikovZbJpZ1Rnc/PTQ25zoN7BxQwj/9RunS
         7SjnJ3ICWqROEqqZRlVZS+0iaYhpkTsetHxSpc/xDEOG4PC8kJOSpg0PwlX9Ebwf3BiM
         Mv/5uJxKWjLqxAKTGvCQM1gwgulQbS9+HUSqfXPGYQ7KQFO2sHRLgtTibk6TlnSJU3cm
         zrmw==
X-Gm-Message-State: AOAM530pRC8VTgUyyclSd2Nu9ef/BGVUNiT1ml08dqNKn1bG3KT3hfve
        m10zDOmCdu/HkW6nxTGkl5c=
X-Google-Smtp-Source: ABdhPJxEX+w0eTQwym6AHyIMJTvXJpPJOJBjvTAMyD7+78kBVy4nJX5XUuyJuZB041IQYwxR/gu9NQ==
X-Received: by 2002:a7b:cbc2:0:b0:388:faec:2036 with SMTP id n2-20020a7bcbc2000000b00388faec2036mr4427074wmi.190.1648121049290;
        Thu, 24 Mar 2022 04:24:09 -0700 (PDT)
Received: from [192.168.1.201] (203.2.7.51.dyn.plus.net. [51.7.2.203])
        by smtp.googlemail.com with ESMTPSA id b15-20020adfc74f000000b001e888b871a0sm2404488wrh.87.2022.03.24.04.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 04:24:08 -0700 (PDT)
Message-ID: <3ee3833a-af2b-90d9-d209-19cab8a8ae43@gmail.com>
Date:   Thu, 24 Mar 2022 11:24:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/7] test-lib: add a "test_expect_todo", similar to
 "test_expect_failure"
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
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
 <a9478c1b-4441-0c79-332d-a7c5592dbc70@github.com>
 <xmqqy210pbbh.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqy210pbbh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/03/2022 22:13, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> The thing I'm hoping to see from a final version is that a top-level
>> helper like test_expect_todo will expect at least one test_todo
>> helper to be executed inside of the test (perhaps communicated by
>> setting a special GIT_TEST_* environment variable?) and if any of
> 
> I was hoping that we can do without test_expect_todo.
> test_expect_success can turn itself into test_expect_todo when it
> sees test_todo is invoked even once in it.  And Phillip's outline
> actually implements the idea, if I am not mistaken.

You are correct, there is no test_expect_todo in the outline I posted, 
test_todo lives within test_expect_success and works like test_must_fail.
>> the test_todo lines change from fail to pass, then that is
>> communicated as a _failure_ from CI's perspective. Let us discover
>> if we have accidentally "fixed" any of these test cases and update
>> the tests accordingly.
> 
> In other words, we do not want to lose the "TODO fixed" we have been
> getting out of test_expect_failure, which I agree with. 

I read Stolee's comments the other way, that we want the test harness to 
see the test fail rather passing as it does with the "TODO fixed" 
feature. In one of my early contributions I inadvertently fixed a 
submodule test and did not realize until someone pointed it out because 
the CI passes rather than fails when a test_expect_failure is fixed.

> I am not
> sure if Phillip's outline had that feature.

In my outline the test fails if any command marked by test_todo is 
successful and test_todo prints a messaging saying the command was 
unexpectedly successful. Implementing the "TODO fixed" feature gets 
tricky when there is more than one test_todo within a single 
test_expect_success - what if one is test_todo command is successful and 
the others fail?


Best Wishes

Phillip

>> I can predict writing a test case with multiple test_todo lines
>> that need to be updated to drop the test_todo helpers one-by-one
>> as a change is being introduced.
> 
> Yes.

