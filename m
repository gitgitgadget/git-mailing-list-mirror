Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF661F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 18:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbeGLSQx (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 14:16:53 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41241 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeGLSQx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 14:16:53 -0400
Received: by mail-qt0-f193.google.com with SMTP id e19-v6so10684493qtp.8
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=l5plZFTKDgCl/fkXeC0DwGo3m1GAZQJEo22Y7RxhqIM=;
        b=KXMiBKzlyhhLluS6CYYllzMieTJuDr4wDcPP1qy76/QavdvPIs+W4jVvds2zACaVt7
         0MScSHTdTsysKemfbpFDhCFfRoXERNxkfPGTguGhcSHzNYCTPR44GNAo4syh3ni432MX
         Su4RxAEosuT+JKNhYE9Z10OggxVVBt8Ixz0dTbWveTQrYTp0gaM5E3qDpczEv7x5ORFc
         CMk/oWdFyOlWn++nLDmpfsHnykDgdEN+rliXYxQ+erj5nnUM9IGNo1NNOcNAHjnu6FuM
         UvQ+iOzUMWwh8oh8wxIPEmj2MD11GG0PseE0VOyB/4g1yoOJ1Y9DtjdFTqIxXtgND0xo
         F+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=l5plZFTKDgCl/fkXeC0DwGo3m1GAZQJEo22Y7RxhqIM=;
        b=lGJp9b3w0ATZt2tWvnacCsWblKg4Q2ril+Aa5l7H6NZ/Ng48TDxOuXxPlI86EDMjyc
         VKFcEhhSkqE4AehTToyLCM6wO6MPA/JNv2b1mfb4gzsJYtZnO1UeycY3ex3qRWgvoQUb
         Qwp4RB9GSOKSXcSCJZKPBjWjJu24NZE3MDwT2K0ROflyRNdM/K65RDvjwSzHKf2RxGKs
         dCR8gg/dWIG1aePsL04WTy+iAvAVb9nKaDoNnJfDz3jy8aKSWt8GUiCAaiPlFY0HDWgt
         +Hn/3SsuhGvsXLS+K8+mHG25AyHUKtPe1LnE3ATiKvL/EoW6M9vKyayQmLyCUT4I0sng
         nyqg==
X-Gm-Message-State: AOUpUlFqslQhfs9KnOQGRKP2ukc9KeSR6qUeCGYSKt7bwR+VNuBauMsK
        stG5rwDvDzj+cKqGLiqDAr7E8JMk3xc=
X-Google-Smtp-Source: AAOMgpf6XGAYEryF3u7fiAA4UtS5L9Fkyu3XLXiTSNs/7WpTdTZ3AlyOMpRimtZHydSdBLFD06GXyg==
X-Received: by 2002:ac8:329c:: with SMTP id z28-v6mr2941549qta.330.1531418772526;
        Thu, 12 Jul 2018 11:06:12 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c9ad:de87:8422:b31b? ([2001:4898:8010:0:b2e3:de87:8422:b31b])
        by smtp.gmail.com with ESMTPSA id i24-v6sm20030989qti.28.2018.07.12.11.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 11:06:11 -0700 (PDT)
Subject: Re: [PATCH v3 07/24] multi-pack-index: expand test data
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-8-dstolee@microsoft.com>
 <CAPig+cTO=UPuCRUAAWfBwaNhRD+=dgSwpgEB2fQJuWyFEd7Aew@mail.gmail.com>
 <3e82dd51-2e30-291f-8753-c1d711459c1d@gmail.com>
 <CAPig+cTEcLtvrQ25KDmc4Cmi9C2yCUpLCTWsK9q8SAiZt+N-Jw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <59cbce97-66cf-8332-c901-8a75f375b670@gmail.com>
Date:   Thu, 12 Jul 2018 14:06:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTEcLtvrQ25KDmc4Cmi9C2yCUpLCTWsK9q8SAiZt+N-Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/2018 2:02 PM, Eric Sunshine wrote:
> On Thu, Jul 12, 2018 at 10:10 AM Derrick Stolee <stolee@gmail.com> wrote:
>> On 7/6/2018 12:36 AM, Eric Sunshine wrote:
>>> There seems to be a fair bit of duplication in these tests which
>>> create objects. Is it possible to factor out some of this code into a
>>> shell function?
>> In addition to the other small changes, this refactor in particular was
>> a big change (but a good one). I'm sending my current progress in this
>> direction, as I expect this can be improved.
> I like the amount of code reduction. A couple minor comments...
>
>> +generate_objects () {
>> +       i=$1
>> +       iii=$(printf '%03i' $i)
>> +       {
>> +               test-tool genrandom "bar" 200 &&
>> +               test-tool genrandom "baz $iii" 50
>> +       } >wide_delta_$iii &&
>> +       {
>> +               test-tool genrandom "foo"$i 100 &&
>> +               test-tool genrandom "foo"$(( $i + 1 )) 100 &&
>> +               test-tool genrandom "foo"$(( $i + 2 )) 100
>> +       } >>deep_delta_$iii &&
> I think this should be: s/>>/>/

It should!

>> +       echo $iii >file_$iii &&
>> +       test-tool genrandom "$iii" 8192 >>file_$iii &&
> And this: s/>>/>/

In addition, I should wrap these two commands in { } like the files above.

Thanks,

-Stolee

