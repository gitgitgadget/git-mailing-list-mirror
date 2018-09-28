Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DF71F453
	for <e@80x24.org>; Fri, 28 Sep 2018 13:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeI1UDH (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 16:03:07 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35703 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeI1UDH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 16:03:07 -0400
Received: by mail-qt1-f193.google.com with SMTP id z14-v6so6658930qtn.2
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OMMCpW0cl9iX6tIdcV5rvEtROBKlYKGbgeatYIqFygI=;
        b=PWeX9wWUhmBgbB7nChCySII1kmpnb0TnfQkDqYmUcQACfsitSDKWNBTGpYcebHFRVO
         LWtX8VpGvNQfryNHC3F1o3TWKvIWp+XcS9Xe8KT/AfLecSvRYhLXIV0MPwD+PBWO6Am+
         frMtyssLb/OiS8g8T+F1F1981lC0WaK2p3AHHco/4RaYCvnZ+MFwOKNRRsDSQk26e+3D
         IEvt9ArYBgsOB1PQ5QtRzgqjuAkHsczLAektstXc3v70mTiVCX7hmAc4mxyXmfPu6J8s
         aBsSnLQqVi6fYeZJx2bKIsCpDtEcjYPEcwHl9G+HC+hd1FYYMHHsN4wYdUSdezIdykE9
         Xh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OMMCpW0cl9iX6tIdcV5rvEtROBKlYKGbgeatYIqFygI=;
        b=pImucowYG2Lb26YDaLsF9m/QwbGBQ8JveH0k7lxBjXOnXCSzMzs19IARjaj0Immj+l
         lahFf1Nv26X6ESinOglxcT4HtZZ8qr34A+yMyDLItHTOzAjZcH/qsdqLpQjS9zWKWxfo
         itvikc2i9t52A9CaptxAicJ5m7fjVb0qiMQna0oKcRqKKmKFEoVrrgq9PI/58F49CQHh
         qhLsF0fHbjjg7pdKKLEES0c82OQ7Fr5xOxhO84KpjzolOemyuGRqto1t8yGmFlFxAgHz
         uV7rtRpg4Gf3r7gL1JUyAeh2HKG0Zo71O8TgFmH5L97xCF01fxifPZffP/KYuz5whIuV
         guTw==
X-Gm-Message-State: ABuFfoiKuIExkFbw3ks6UQ5rKY/ezvI+QEKidf8XcY+A5yXIUgg2vZFt
        l07XUw1waBRmexCYPEmjUuY=
X-Google-Smtp-Source: ACcGV60aNPW6kc8dE6z6Km/79OpWT81L/shvPJHvEGOibzX+OEr+QWHhj36GQ2IBJmYPiXOOkMbtog==
X-Received: by 2002:aed:3848:: with SMTP id j66-v6mr12200970qte.218.1538141955365;
        Fri, 28 Sep 2018 06:39:15 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n41-v6sm3352901qtn.73.2018.09.28.06.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 06:39:14 -0700 (PDT)
Subject: Re: [PATCH v6 4/7] config: add new index.threads config setting
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180926195442.1380-1-benpeart@microsoft.com>
 <20180926195442.1380-5-benpeart@microsoft.com>
 <20180928002627.GO27036@localhost>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <cbc48a95-62f5-a098-fb70-97b6cf241920@gmail.com>
Date:   Fri, 28 Sep 2018 09:39:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928002627.GO27036@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/27/2018 8:26 PM, SZEDER Gábor wrote:
> On Wed, Sep 26, 2018 at 03:54:39PM -0400, Ben Peart wrote:
>> Add support for a new index.threads config setting which will be used to
>> control the threading code in do_read_index().  A value of 0 will tell the
>> index code to automatically determine the correct number of threads to use.
>> A value of 1 will make the code single threaded.  A value greater than 1
>> will set the maximum number of threads to use.
>>
>> For testing purposes, this setting can be overwritten by setting the
>> GIT_TEST_INDEX_THREADS=<n> environment variable to a value greater than 0.
>>
>> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
>> ---
> 
>> diff --git a/t/README b/t/README
>> index aa33ac4f26..0fcecf4500 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -332,6 +332,11 @@ This is used to allow tests 1, 4-9 in t1700-split-index.sh to succeed
>>   as they currently hard code SHA values for the index which are no longer
>>   valid due to the addition of the EOIE extension.
>>   
>> +GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
>> +of the index for the whole test suite by bypassing the default number of
>> +cache entries and thread minimums. Settting this to 1 will make the
> 
> s/ttt/tt/
> 
>> +index loading single threaded.
>> +
>>   Naming Tests
>>   ------------
>>   
>> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
>> index 1f168378c8..ab205954cf 100755
>> --- a/t/t1700-split-index.sh
>> +++ b/t/t1700-split-index.sh
>> @@ -8,6 +8,7 @@ test_description='split index mode tests'
>>   sane_unset GIT_TEST_SPLIT_INDEX
>>   sane_unset GIT_FSMONITOR_TEST
>>   GIT_TEST_DISABLE_EOIE=true; export GIT_TEST_DISABLE_EOIE
>> +GIT_TEST_INDEX_THREADS=1; export GIT_TEST_INDEX_THREADS
> 
> Why does multithreading have to be disabled in this test?
> 

If multi-threading is enabled, it will write out the IEOT extension 
which changes the SHA and causes the test to fail.  I will update the 
logic in this case to not write out the IEOT extension as it isn't needed.

>>   test_expect_success 'enable split index' '
>>   	git config splitIndex.maxPercentChange 100 &&
>> -- 
>> 2.18.0.windows.1
>>
