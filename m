Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 894CD1F454
	for <e@80x24.org>; Fri, 21 Sep 2018 14:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389835AbeIUUmq (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 16:42:46 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:40951 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389657AbeIUUmq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 16:42:46 -0400
Received: by mail-qt1-f175.google.com with SMTP id e9-v6so1559613qtp.7
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Baxb6N0tfSuqnEeOtUwUbgf1TrnRJvemwcLx2WDT2Q8=;
        b=YQ4R+1quULa4uPKakiKXRqnXHSPzmHNJjr03D3VTWg2b5BCL1GTMdmJ3r5OihBTdGf
         mELFNCPaJGt2PlNlAJdVXMNPlr0KQFxruHBiC22/rxPUjLn7p9Ey6qduKgs30spVSSsa
         llm6XY9BVLcg15e8dXWJWDmKwuErFErH84il2hQNv5aVKSobSsbTkAzcVE16lj3WkFRh
         nYuiTLVbBAdSms61ZjYFFanp29W/yGHJ+0EkANxnbxK3imokk9Ud2gvLGc2dWzFisIcC
         tW95IabCQLgA1+3My/ekfsbmrEdHGu74r4RWR7ub32TGeS9jEDzcL9hYaloVF41+v6de
         cSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Baxb6N0tfSuqnEeOtUwUbgf1TrnRJvemwcLx2WDT2Q8=;
        b=gxpVCqwLWD+WKZrsl2xDPH7W5kWbC8McIKi5c+RhWIk3NRQ8gUmSmicpdyc1HZZ9Q0
         2TFi5ZfeIqRrrMj/oLpC8j+W4Ul/yTCL3+Ia6xC6mrQzTob+XqkxYZKDikY6Eq+5joHn
         DcR7rHRANzKiX15hbH4JL3ZJpQpbIt9Zu9jhxfsRS5hnrfk3S/nwkdmU4FdZbl+DN5U6
         NJR2v3PTOrlejx9rmt0LXNJVL5BNHfVn+z7X189pKRgkGyZCC23h4yLw3EXi2Y/F9Bsh
         EZL6gS9IMvJ2ep1oUvGBZVb/vifir0cEBuiQ0gROGG4bzdFYb+gQSuqMlBT5C2NzIZKp
         d+Tg==
X-Gm-Message-State: APzg51CEnfujq1fe+tT7PaqLfu+kyt0RZphz/sHcyPCQfscDg2Xmo88C
        yA5E7g/9lgjueoZNezZoclhv/c1H
X-Google-Smtp-Source: ANB0Vdbp0NUxOeR4fVecLDGtZgMj9KzBZ6D/kNEb36doGdgbeuPim7yF76boR5uIdf/WUcrTtt9BwA==
X-Received: by 2002:ac8:c9:: with SMTP id d9-v6mr31989289qtg.213.1537541611664;
        Fri, 21 Sep 2018 07:53:31 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f452:f7ab:45dd:bf7c? ([2001:4898:8010:0:dd88:f7ab:45dd:bf7c])
        by smtp.gmail.com with ESMTPSA id x76-v6sm19209197qkx.25.2018.09.21.07.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 07:53:30 -0700 (PDT)
Subject: Re: Segfault in master due to 4fbcca4eff
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
 <87pnx6kjn8.fsf@evledraar.gmail.com>
 <62a46e49-e539-cbb8-4aaf-6f9b5ae6be57@gmail.com>
 <87o9cqkj6p.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5e7e6519-21c1-daff-65a5-7d2ca5e1dbd4@gmail.com>
Date:   Fri, 21 Sep 2018 10:53:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87o9cqkj6p.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2018 10:40 AM, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Sep 21 2018, Derrick Stolee wrote:
>
>>
>> This error was reported by Peff [1] and fixed in [2], but as stated
>> [3] I was waiting for more review before sending a v3. I'll send that
>> v3 shortly, responding to the feedback so far.
>>
>> -Stolee
>>
>> [1]
>> https://public-inbox.org/git/0bf9103c-9377-506b-7ad7-e5273d8e94fc@gmail.com/T/#u
>>
>> [2] https://public-inbox.org/git/pull.39.git.gitgitgadget@gmail.com/
>>
>> [3]
>> https://public-inbox.org/git/8d6061de-1654-577c-40c6-211dbd03aa36@gmail.com/
> Thanks and sorry for the duplicate report. I can confirm that applying
> the v2 of that fixes the segfault for the test case I posted.

Thanks for the report! You are a good dogfooder.

Thanks,

-Stolee

