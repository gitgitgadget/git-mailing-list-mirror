Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3797D1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 13:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeGLNLV (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 09:11:21 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39134 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeGLNLV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 09:11:21 -0400
Received: by mail-qt0-f194.google.com with SMTP id q12-v6so23938471qtp.6
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 06:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MUHOAP66VlNY/UkumLe2uRbhNVZx3QB1Q4/WvPPbwGc=;
        b=eiJ+izl9phy/Cw1d8YcdU8PneNRpnaafZVaGb8wmmssAjwmu3EpPYR7MhlQ2N9VlCb
         0dNw2u3E3zQ9EfpXn5nBpDsZKI3Ns43OQjpf6Q8HJ9epsAG3sQJ7KkD+dz7REvryySgH
         M1JSZoYi0939k4yaTnk1LigHsWja66uGtiXZJvcnFiLuUeTCXZtp7Lx7ekb6kCnEOJfr
         U7brAZeiGvq6sHSxkTaOr9ZBrkOc6DABAk2NhRqIsSt5D7T0XebiOvqfG4E/xaSsHhyr
         RCODhklp+zgNKIwFf8a8ub/jpkrnsqs2+vAqnqd0gHRtNk6DcuVLvr6Ukik6Ezg8PrxO
         GtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MUHOAP66VlNY/UkumLe2uRbhNVZx3QB1Q4/WvPPbwGc=;
        b=X9zVEnZjHqt4eRfNNg9Vc5KIJ3IWc7o4k0CRUbGn/wavvlWToA8AM/EsP63GGd2DnX
         lIW1j4iRNio4J7szpXNUSI+P3jsq4xCHI2pVy9j/fw6t+R/GTljPvgqcI8swRxk6WBlZ
         T97M8GkXisp1Dj+Psb3AxD2z1BUOoqFBfAT85MwkDCExAd/8bh5YHWBeeL5COsk8vkkk
         Agv7K1pnZ9josZprzTfNhjlBwGmI++ZA2HvoL+33JaE6lVsoG3NOFmu4RlkwmVh9CnbR
         P1hJcrwujSzKluEQu5J8VMz2O8TEWwC25bV65//2Y6Z4IHSnUlUSs5s+kWC0TmcfoF0m
         1DBA==
X-Gm-Message-State: AOUpUlHaznycw5pE6Ie26794/3wTjUaW8H65LyUhccqzEdxSAvWC4kkj
        9Xw18pmW8hVtzYBXS5Ffh3U=
X-Google-Smtp-Source: AAOMgpclZlWDJRvpmjr/huYQmShDK35IFkWkfNup4n5nXBB8ng/44+k+GOduk3HZvIZ+2K43zZM8NQ==
X-Received: by 2002:a0c:bc8a:: with SMTP id l10-v6mr2212475qvg.130.1531400511440;
        Thu, 12 Jul 2018 06:01:51 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d4d2:4c73:ca82:12f0? ([2001:4898:8010:0:be08:4c73:ca82:12f0])
        by smtp.gmail.com with ESMTPSA id y49-v6sm20009287qty.91.2018.07.12.06.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 06:01:50 -0700 (PDT)
Subject: Re: [PATCH v3 16/24] config: create core.multiPackIndex setting
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        pclouds@gmail.com, avarab@gmail.com, dstolee@microsoft.com
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-17-dstolee@microsoft.com>
 <20180711094858.3230-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dd2f774d-a217-0273-efbe-d133ae23c5bc@gmail.com>
Date:   Thu, 12 Jul 2018 09:01:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180711094858.3230-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/11/2018 5:48 AM, SZEDER Gábor wrote:
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index ab641bf5a9..ab895ebb32 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -908,6 +908,10 @@ core.commitGraph::
>>   	Enable git commit graph feature. Allows reading from the
>>   	commit-graph file.
>>   
>> +core.multiPackIndex::
>> +	Use the multi-pack-index file to track multiple packfiles using a
>> +	single index. See linkgit:technical/multi-pack-index[1].
> The 'linkgit' macro should be used to create links to other man pages,
> but 'technical/multi-pack-index' is not a man page and this causes
> 'make check-docs' to complain:
>
>        LINT lint-docs
>    ./config.txt:929: nongit link: technical/multi-pack-index[1]
>    Makefile:456: recipe for target 'lint-docs' failed
>    make[1]: *** [lint-docs] Error 1
>
Thanks for this point. It seems to work using 
"link:technical/multi-pack-index[1]", which is what I'll use in the next 
version.

-Stolee

