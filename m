Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8C61F453
	for <e@80x24.org>; Mon,  1 Oct 2018 13:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbeJAT4A (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 15:56:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37374 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbeJAT4A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 15:56:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id x8-v6so365629qka.4
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0mixLzTO2rArrgms4Ks+W5DdkAR+MMTXQHXTGNE+wC8=;
        b=lgcDEW9Y1Y5mz4br5r3tTI65FgAoTNmAtaER5+dW8YgJUtHsXSSe6FOD3PCRP4w4l5
         TWc4NX3mcAczfKxyS7UMEAx28MKX+cweXW54sZDGEGnCPtzwVA26MKH/JS9+3U9/rS8q
         qRuacR1JqbYBJGs6dEQAE81G81McHBwlXWNocfiw4U8QpCac6KCK0xNnHeI6LJVq9tRO
         W0jvubKreKWieGtFmVgLjzkKVYSoQz7hdq4o2e/g0Ei6AeJGD4PY5Gv7fpUTFz6wxBtd
         Z+JEhW5X2DZq+RUK2dvOfeDojJf3bDlZwKyFEkeiZI4KI9pexUzW5yMT9ipCmVVeDjsP
         BmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0mixLzTO2rArrgms4Ks+W5DdkAR+MMTXQHXTGNE+wC8=;
        b=TOY0BRLIfdeT5rs0rJj3C1S3tRndvFDjsLFQ3FCnTKYfV/++FrrzxkTzAxX7SIuaKy
         oYudv+a7SnrpQ/wsbU36P9HzZa/1ekC1v/Pp8rZgu/IBGPMzjTAvrX4lIIPHxW0MNcHt
         kN+VdSZWg4E3hUmmL/sjivGQoM9/qXAfrKnppXifktQvzsUPIQT7ZnQ6z3a3EOu5j3j8
         pqK6IgrtSowrKJgwSrYcw0FopF8AmKUUuby8iy2IeKg8UIheYNlRTTManyYgfS5uVtY9
         X2rYEF9HN86lGzTTqvsmz+crXR+MhHZMNn9+3zdf6C6GYCrd3YvRgjlfo3DSHknfuF6I
         JpVQ==
X-Gm-Message-State: ABuFfohcvW1jdHTNiBEcGyGUheqR3aBCBFxjg7V/L/JPN2P0G4hsg6CV
        KkNV242YoSvtfkG7ILL589I=
X-Google-Smtp-Source: ACcGV6186hsVGMuy36KcZ31h+yxvwUi8NNcaa6G10JjnxjEJyJM5gwkFaJtYDJZ2s5zKy73urVIQYQ==
X-Received: by 2002:a37:8406:: with SMTP id g6-v6mr7979781qkd.148.1538399892260;
        Mon, 01 Oct 2018 06:18:12 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id o55-v6sm4517624qtk.58.2018.10.01.06.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 06:18:11 -0700 (PDT)
Subject: Re: [PATCH v6 4/7] config: add new index.threads config setting
To:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180926195442.1380-1-benpeart@microsoft.com>
 <20180926195442.1380-5-benpeart@microsoft.com>
 <20180928002627.GO27036@localhost>
 <cbc48a95-62f5-a098-fb70-97b6cf241920@gmail.com>
 <xmqqsh1tczyz.fsf@gitster-ct.c.googlers.com>
 <a58a5cce-b3c2-62a2-598b-6b7dbe1a86fc@gmail.com>
 <bf0c24ac-6e2a-9a3e-835f-f21e763ab2c7@ramsayjones.plus.com>
 <xmqqo9ch9slw.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <48d6e62f-bf44-ffa1-befb-fef33ad00411@gmail.com>
Date:   Mon, 1 Oct 2018 09:17:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqo9ch9slw.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/28/2018 6:15 PM, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>>>                  if (!nr) {
>>>                          ieot_blocks = istate->cache_nr / THREAD_COST;
>>> -                       if (ieot_blocks < 1)
>>> -                               ieot_blocks = 1;
>>>                          cpus = online_cpus();
>>>                          if (ieot_blocks > cpus - 1)
>>>                                  ieot_blocks = cpus - 1;
>>
>> So, am I reading this correctly - you need cpus > 2 before an
>> IEOT extension block is written out?
>>
>> OK.
> 
> Why should we be even calling online_cpus() in this codepath to
> write the index in a single thread to begin with?
> 
> The number of cpus that readers would use to read this index file
> has nothing to do with the number of cpus available to this
> particular writer process.
> 

As I mentioned in my other reply, this is optimizing for the most common 
case where the index is read from the same machine that wrote it and the 
user is taking the default settings (ie index.threads=true).

Aligning the number of blocks to the number of threads that will be 
processing them avoids situations where one thread may have up to double 
the work to do as the other threads (for example, if there were 3 blocks 
to be processed by 2 threads).
