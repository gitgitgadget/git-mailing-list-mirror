Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA891FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 13:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbdJTNRR (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 09:17:17 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:51949 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdJTNRP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 09:17:15 -0400
Received: by mail-qt0-f177.google.com with SMTP id h4so18354662qtk.8
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 06:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VQ6AuAnQwL2FUWFjF2Kha9mse2gTazbKH8cL1yqusbs=;
        b=B6tJL6CSepXOsAPGBZoaQqZEUaf9ItZoFwfFN291Uybn0JHSYfrt3NVEr0mqc0HtY/
         rQyWHPrSLXwMZgEHSYVvXpO/xs29Rfa4UYieH1eoJOZaaFpJj5TbhUyVrcJFmUQCRhOE
         87cl2zfqf0eugbsMQO7yd6JeW6Nf/y448OgFP1qXnVWM+E4sPbNSRLO/r4uHR12iz0gu
         14/kSwZXzcCsMtoA71jG0c3Pk6lL30ZODVXoR3p0BOGvnpgB60XkSmky8IJFGQ7iAvJf
         9Ozdzjmkqp+77FDOBOMvTapktTkDobf/TTwAE/4OPTLLxP8D5/uwiuB2B2ceJQ40gAQk
         Q0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VQ6AuAnQwL2FUWFjF2Kha9mse2gTazbKH8cL1yqusbs=;
        b=m/TntKBlJaHvrH8qAzmHXet8sgfLnDON3A1uCTkVJ2gPI4UEMUOaNASzWj/M83gW3R
         Skyf7Pv1SynbkWnqdbo1dixzJz4cGA2PFPIlQ98MtfN9Mf1Ewea6dOqKEzPAfTu4wuQK
         jG6eBA9g4GUcYRfvYeCq2hw7NwOcr2K9HUnCwMxjCV87vjXXYooRO6qTD7kFm1HyKEz2
         BXazxCWdCbhqwC4IAQI8OX5eqfw/eeYz731V1CC+DH0wA7qDtMD30eqFHzYa3YQru6cx
         qXubSIyBirlBzXK/OkNBL+GEkdwB06urhy9pmnjHZWcr5hxhgfG70zkN+j/RZpfbi+Pa
         cwog==
X-Gm-Message-State: AMCzsaWZCeDP84sQGRst3P6oyMDuiq3cWGvu7y1g7v7tiS8w92hcanKi
        +7kmpY8F8FnmZl98+hetcwXk2y3p
X-Google-Smtp-Source: ABhQp+TN+rZ0Y316Rjb/6wpJM/dtX9ptZkNR8cgTQYKqIKwKI7RFX11bNlafAouRhcquz+uciVEYag==
X-Received: by 10.200.1.72 with SMTP id f8mr1948579qtg.146.1508505434766;
        Fri, 20 Oct 2017 06:17:14 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id c10sm574059qtj.29.2017.10.20.06.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2017 06:17:14 -0700 (PDT)
Subject: Re: [PATCH 2/4] fsmonitor: Don't bother pretty-printing JSON from
 watchman
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org
References: <20171020011136.14170-1-alexmv@dropbox.com>
 <6887851348e177728849964cc95ae783b0feb971.1508461850.git.alexmv@dropbox.com>
 <alpine.DEB.2.21.1.1710201459020.40514@virtualbox>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <c43315f3-4155-6b07-bde2-5855dceacf80@gmail.com>
Date:   Fri, 20 Oct 2017 09:17:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1710201459020.40514@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/20/2017 9:00 AM, Johannes Schindelin wrote:
> Hi Alex,
> 
> On Thu, 19 Oct 2017, Alex Vandiver wrote:
> 
>> This provides small performance savings.
>>
>> diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
>> index 377edc7be..eba46c78b 100755
>> --- a/t/t7519/fsmonitor-watchman
>> +++ b/t/t7519/fsmonitor-watchman
>> @@ -51,7 +51,7 @@ launch_watchman();
>>   
>>   sub launch_watchman {
>>   
>> -	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
>> +	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j --no-pretty')
> 
> While I am very much infavor of this change (I was not aware of the
> --no-pretty option), I would like to see some statistics on that. Could
> you measure the impact, please, and include the results in the commit
> message?
> 
> Ciao,
> Johannes
> 

I was also unaware of the --no-pretty option. I've tested this on 
Windows running version 4.9.0 of Watchman and verified that it does work 
correctly.  I'm also curious if it produces any measurable difference in 
performance.
