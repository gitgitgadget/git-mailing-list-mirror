Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27F661F404
	for <e@80x24.org>; Fri, 14 Sep 2018 18:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeINXV0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 19:21:26 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37629 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeINXV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 19:21:26 -0400
Received: by mail-qt0-f194.google.com with SMTP id n6-v6so9556400qtl.4
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1kfGh6jG43uAezJLOPphhb3+ldxZuETeuFy4mRiOcqM=;
        b=ekBalvQGuoeD3gvIl1R/efAqN7AaUr5oIKNpgEr4PMogtRBHCpjTo1SBGdhywNqRGo
         iPqgaWf9orFzye2S4/FKJ3YpYR7luVqTfoF0pqq7krFrT4uxYu9bfzb3M0QKw/ytEOZj
         zyYvFYdBHpt21sL75Zmbk/yM5Fd0Y9cF8uQyALnSsfKl3c7cKGX/5fuQCh2r81qrkNvJ
         r/bSvCszV0CDTfMziEgi827lT0o8PohGKMgfkemJKZ4DLs6GKHP8S0ewVJcCgfk0J7Z9
         qsWS26mwwY6jueLaY89RpNi+4xIg7GDGRUQSc5MibzWgkirMpXcVEHJbIyzPHsgzrDI4
         2Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1kfGh6jG43uAezJLOPphhb3+ldxZuETeuFy4mRiOcqM=;
        b=AMYUMjXtZUqTcn3K/n+EFPgGrzLi+5nDbNmp+vUXR5HcEbPanIlSlVnS5o3QdMZgK/
         3xFTUqkjHB5pBGLF7pq1M6go6d3Bb6ONyspM2mDT7jwOxaTuzkHBa6IMIXeNj/veThO6
         q0/vgyztF2yD/47BzkDFJk/nARmjnR9rtDYDbbfeyiVVAb+wq/v3BMO35bFwrujpjmcJ
         QJgBDjkBEDVuFKg5ffttg6lGQcZqx7RhC2/Xe2S4n7/L9Zbbr5WOdnGoqjG8+jvXDZyP
         +wzgIQPmEP55DOPReCVepq9uXG5E86pNeK1juLfvaERW6fF7GDwbQQao2HVLEUJ3z4Ck
         +t/w==
X-Gm-Message-State: APzg51AaxyoWzClxb10i/Lxox6b+wfT3WWWg8syj8wvP6NDFElirL4ua
        mFAwzIS3z6G/osben5mVmAE=
X-Google-Smtp-Source: ANB0VdaEgTqaScTXAqKQ6iM1HPVL5F3UqLuhCIbHfBeYIRjYQj/vIhMH+v6pjjiQ1p0xrMnlHmqqgA==
X-Received: by 2002:a0c:d2d5:: with SMTP id x21-v6mr10072984qvh.214.1536948348260;
        Fri, 14 Sep 2018 11:05:48 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id v47-v6sm5407221qtj.59.2018.09.14.11.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 11:05:47 -0700 (PDT)
Subject: Re: [PATCH v1 2/4] fsmonitor: update GIT_TEST_FSMONITOR support
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "t.gummerer@gmail.com" <t.gummerer@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180914143708.63024-1-benpeart@microsoft.com>
 <20180914143708.63024-3-benpeart@microsoft.com>
 <xmqq5zz8c84y.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <80988727-085f-cdd9-e5bb-a90a55e97024@gmail.com>
Date:   Fri, 14 Sep 2018 14:05:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqq5zz8c84y.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/14/2018 1:15 PM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> diff --git a/config.c b/config.c
>> index 3461993f0a..3555c63f28 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -2278,7 +2278,7 @@ int git_config_get_max_percent_split_change(void)
>>   int git_config_get_fsmonitor(void)
>>   {
>>   	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
>> -		core_fsmonitor = getenv("GIT_FSMONITOR_TEST");
>> +		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
> 
> Sorry for not noticing earlier, but unlike 4/4 that changed
> getenv(VAR) to git_env_bool(VAR, 0) "while at it", this leaves it to
> getenv(VAR), meaning "if it is set to any non-empty string, it is
> true".  Is there a reason for this discrepancy?
> 

The difference here is that core.fsmonitor isn't a boolean value.  It is 
a string to a command that is executed so it can't be moved over to 
get_env_bool().

> I _think_ the renaming should be done without getting mixed with
> other changes like the git_env_bool() done in 4/4.  The idea to use
> git_env_bool() in stead of getenv() may be a good one, but then we
> should consistently do so when appropriate, and that would make a
> fine theme for another topic.
> 
