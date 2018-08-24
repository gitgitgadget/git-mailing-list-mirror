Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F15C1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 16:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbeHXUUk (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 16:20:40 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35334 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHXUUk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 16:20:40 -0400
Received: by mail-qt0-f169.google.com with SMTP id f19-v6so9391531qtf.2
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5PAVJXkLwF1vsQcxvsZisGwCYQ8Y6+jpFVwa2xgujIM=;
        b=r9sJYTkN7OtY6fKx0SWoValrhjVU2h2jqNrEuA4Ftt60SDmJrwH4PQjX+IPekQD7wW
         1CXaknN974yIByZ7qkXB6iGHtW1+uXdKFTx3PrW7buTX2EC9wLn/6A27rAC9gsAaqImA
         7O1NN/YgZzxx6NnfbTFdjBcLhxFMPOHJw4fUGF3kLknxJ0EveODjImMF6wnMTeFN3bEE
         JJmKxVKs0GDbl3pnMMz/6s03DurwLbzs5fliAnualEG4CLKbNtYeQqeNOHi5u+CzJ4/3
         hzVUERpwvtsfbjffbWE/SQVLAw0hrbVXCcWI3rVdF979eml9OLO/xRk5w5FZBcMBqBae
         5kNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5PAVJXkLwF1vsQcxvsZisGwCYQ8Y6+jpFVwa2xgujIM=;
        b=cnakOTYhlEpcV15U6/EQ/O8IBfbO/8cz0Ya7rMeA9+fXDaOT/syIuGo/w/JJrt9x48
         9k8ex0nc3JnW+LE+MtNvIWErMEMc6RSAWnGxl1liTzANQHL/Fp/8zd9q6B7HZD8MLRUo
         u5e6uVs02mYTECGzX4KpWgUJ8LvMhtVTOC6sRRAw9hfeT9tmUojJUALkolZYr0oWdlD/
         KSxKhhq0EYRhIIoL0MM9QtQTbpZ6jUA6CSBCMywwmcjDDb3mxwlxJVa8ASn7Kpcx9OPm
         rl/9LxFeqLMVDwp1E6CnLjUYu6bgwdLJCvoDHHWntbqdKAEjUbaQ99aPzVNIsvvxo6pf
         9suQ==
X-Gm-Message-State: APzg51C6u9brjm4naqZKAzvegTyaZ5gevGWyY+l74YQS3m32kW8wdgOs
        xVGwkhz5u76Sg81aodwOslo=
X-Google-Smtp-Source: ANB0VdbJ2iY5MnM9j6SKMKE4jRvvER8Yk6KnZRwvvQeX25SwM+qZKQ0azKNwNGnWwl+uKhEkKybtqg==
X-Received: by 2002:ac8:dca:: with SMTP id t10-v6mr2585952qti.284.1535129112334;
        Fri, 24 Aug 2018 09:45:12 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7cdf:e697:e8f8:d87a? ([2001:4898:8010:0:6615:e697:e8f8:d87a])
        by smtp.gmail.com with ESMTPSA id w70-v6sm4778614qkb.58.2018.08.24.09.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 09:45:11 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823034707.GD535143@genre.crustytoothpaste.net>
 <20180823050418.GB318@sigill.intra.peff.net>
 <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
 <20180823185317.GA12534@sigill.intra.peff.net>
 <4b0168ee-4826-1f14-fc83-04c4cec18687@gmail.com>
Message-ID: <719d5e65-553c-47a1-0b79-41c9af356f3a@gmail.com>
Date:   Fri, 24 Aug 2018 12:45:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <4b0168ee-4826-1f14-fc83-04c4cec18687@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2018 4:59 PM, Derrick Stolee wrote:
>
> When I choose my own metrics for performance tests, I like to run at 
> least 10 runs, remove the largest AND smallest runs from the samples, 
> and then take the average. I did this manually for 'git rev-list --all 
> --objects' on git/git and got the following results:
>
> v2.18.0    v2.19.0-rc0   HEAD
> --------------------------------
> 3.126 s    3.308 s       3.170 s
>
> For full disclosure, here is a full table including all samples:
>
> |      | v2.18.0 | v2.19.0-rc0 | HEAD    |
> |------|---------|-------------|---------|
> |      | 4.58    | 3.302       | 3.239   |
> |      | 3.13    | 3.337       | 3.133   |
> |      | 3.213   | 3.291       | 3.159   |
> |      | 3.219   | 3.318       | 3.131   |
> |      | 3.077   | 3.302       | 3.163   |
> |      | 3.074   | 3.328       | 3.119   |
> |      | 3.022   | 3.277       | 3.125   |
> |      | 3.083   | 3.259       | 3.203   |
> |      | 3.057   | 3.311       | 3.223   |
> |      | 3.155   | 3.413       | 3.225   |
> | Max  | 4.58    | 3.413       | 3.239   |
> | Min  | 3.022   | 3.259       | 3.119   |
> | Avg* | 3.126   | 3.30825     | 3.17025 |
>
> (Note that the largest one was the first run, on v2.18.0, which is due 
> to a cold disk.)
>
> I just kicked off a script that will run this test on the Linux repo 
> while I drive home. I'll be able to report a similar table of data 
> easily.

Here are the numbers for Linux:

|      | v2.18.0  | v2.19.0-rc0 | HEAD   |
|------|----------|-------------|--------|
|      | 86.5     | 70.739      | 57.266 |
|      | 60.582   | 101.928     | 56.641 |
|      | 58.964   | 60.139      | 60.258 |
|      | 59.47    | 61.141      | 58.213 |
|      | 62.554   | 60.73       | 84.54  |
|      | 59.139   | 85.424      | 57.745 |
|      | 58.487   | 59.31       | 59.979 |
|      | 58.653   | 69.845      | 60.181 |
|      | 58.085   | 102.777     | 61.455 |
|      | 58.304   | 60.459      | 62.551 |
| Max  | 86.5     | 102.777     | 84.54  |
| Min  | 58.085   | 59.31       | 56.641 |
| Avg* | 59.51913 | 71.30063    | 59.706 |
| Med  | 59.0515  | 65.493      | 60.08  |

Thanks,

-Stolee

