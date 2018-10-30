Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40B111F453
	for <e@80x24.org>; Tue, 30 Oct 2018 13:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJ3V5k (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 17:57:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54934 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJ3V5k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 17:57:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so11699171wma.4
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=FCV53ymJms+s2d59tn7BWXOOFuvK2KH/vrccMMq6xMc=;
        b=b7/wFXZ37Hmnw1q75J+U2dFrPMHFEHlGpibGBCT6p2D1xrLV8i0zfy+BDGC8ndvg1Z
         znr9iReSI7tanmgfsFzZeqFweNQsnYY2PMOTYuPA0UMhhwDlADbyRZx2tXSW2k6J4HR3
         xZ5StvO2SpTjtDIHF/0kuJ4gilt6/xdt4m6tBGQg6IeBXYX/m0mhREKe+7lLOsub9OfW
         /4EL+uUXTtSOc6HNYR+ifjyL0gMTGYn54N07RaZiXtinH8CFLMjDAI8t0cOf6/VJ8y7V
         Hf4/UBsOi7wAGi27PrxVpfLFHjATquJkNATaIMEpGeoTJATJ/NfF/gNAiYXCh45eiwCY
         0FOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FCV53ymJms+s2d59tn7BWXOOFuvK2KH/vrccMMq6xMc=;
        b=EuuurK4wOy5KZO2ryMkYOezePLfQbH+qcL7YUar7sQ0xjMJ1Kny+UIMdR9vUrmwxTH
         +y17HPVdH4BC2n0d8l7bFwH5IvWHxl14Q5M0paPYy7eTmqhFuogIiDs5f0vAIZc9Ohmu
         bDA9iRSxzkWhYoFExdfuknkD6L1z2koSdANIMumJUmGzA7cPjnHKQJLAJ0KiJjMyAhn3
         sA6+PmcqDGwATEOI496AD5mPaq347WU44AgtvqJpoFXQUNnzgmmcBNsJ8B73FGBB03yc
         Ty50SYx6xvfSeNRIbmxp14mqeFt5FXj6BwgPLUOYgVzcZol/P6Wm/H9ZMJh1OuyV9YsN
         0kSA==
X-Gm-Message-State: AGRZ1gJfVcD4aL+ldB6aCDsjM6YSW1t/AZghsG5NTnqZrKGQalzMYx8D
        YMqoml5YK52KTPGrTvW+gsYiioUs
X-Google-Smtp-Source: AJdET5e+uo0pIupAVMxpa5aV37R7OMbXLoAgT07t3taORWW/b2i5mXryU5eepOHQ3RxzH7F5d0vcnA==
X-Received: by 2002:a1c:59c4:: with SMTP id n187-v6mr1605684wmb.98.1540904656819;
        Tue, 30 Oct 2018 06:04:16 -0700 (PDT)
Received: from [192.168.1.8] ([31.223.156.254])
        by smtp.gmail.com with ESMTPSA id 134-v6sm14800142wmp.6.2018.10.30.06.04.15
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 06:04:15 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] [Outreachy] t3903-stash: test without configured
 user name
To:     git@vger.kernel.org
References: <cover.1540494231.git.slawica92@hotmail.com>
 <9ea38cd8e98890b8264696dfd647c1f9e709ae9e.1540494231.git.slawica92@hotmail.com>
 <xmqqa7n1fr2c.fsf@gitster-ct.c.googlers.com>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <0e361938-29d7-6013-9632-a14d0cb02824@gmail.com>
Date:   Tue, 30 Oct 2018 14:04:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqa7n1fr2c.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 26-Oct-18 3:13 AM, Junio C Hamano wrote:
> Slavica Djukic <slavicadj.ip2018@gmail.com> writes:
>
>> From: Slavica <slawica92@hotmail.com>
> Please make sure this matches your sign-off below.
>
>> This is part of enhancement request that ask for 'git stash' to work
>> even if 'user.name' and 'user.email' are not configured.
>> Due to an implementation detail, git-stash undesirably requires
>> 'user.name' and 'user.email' to be set, but shouldn't.
>> The issue is discussed here:
>> https://public-inbox.org/git/87o9debty4.fsf@evledraar.gmail.com/T/#u.
> As the four lines above summarize the issue being highlighted by the
> expect-failure rather well, the last two lines are unnecessary.
> Please remove them.  Alternatively, you can place them after the
> three-dash lines we see below.
>
>> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>> ---
>>   t/t3903-stash.sh | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
>> index 9e06494ba0..ae2c905343 100755
>> --- a/t/t3903-stash.sh
>> +++ b/t/t3903-stash.sh
>> @@ -1156,4 +1156,18 @@ test_expect_success 'stash -- <subdir> works with binary files' '
>>   	test_path_is_file subdir/untracked
>>   '
>>   
>> +test_expect_failure 'stash works when user.name and user.email are not set' '
>> +    test_commit 1 &&
> Just being curious, but do we need a fresh commit created at this
> point in the test?  Many tests before this one begin with "git reset"
> and then run "git stash" without ever creating commit themselves,
> instead relying on the fact that there already is at least one
> commit created in the "setup" phase of the test that a "stash"
> created can be made relative to.  I do not think this test is all
> that special in that regard to require its own commit.

No, we don't need fresh commit here. Thank you for this and all other 
suggestions.

I've changed test according to them.

>
>> +    test_config user.useconfigonly true &&
>> +    test_config stash.usebuiltin true &&
>> +    sane_unset GIT_AUTHOR_NAME &&
>> +    sane_unset GIT_AUTHOR_EMAIL &&
>> +    sane_unset GIT_COMMITTER_NAME &&
>> +    sane_unset GIT_COMMITTER_EMAIL &&
>> +    test_unconfig user.email &&
> There are trailing whitespaces on the line above.  Please remove.
>
> Also, Don't be original in the form alone---all other tests in this
> file indent with a leading HT, not four SPs.  Please match the style
> of surrounding code.
>
>> +    test_unconfig user.name &&
>> +    echo changed >1.t &&
>> +    git stash
>> +'
>> +
>>   test_done
> Thanks.  Please do not reroll the next round at too rapid a pace.

I've taken my time for next round, I am working on 2/3 and 3/3 parts as 
well.
I wouldn't have sent this patch if I understood you well in previous reply.

Thank you,

Slavica.

>
>
>
