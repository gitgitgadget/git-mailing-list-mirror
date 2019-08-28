Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CECB11F461
	for <e@80x24.org>; Wed, 28 Aug 2019 09:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfH1JLq (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 05:11:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46110 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1JLq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 05:11:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so1655210wru.13
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D5xumJlwdcilFo/njjbEzxFa6ctffy8d4uKpawHYNuU=;
        b=lAnnplg+Pe7Mb42Gb/TToeKoHFs5I7lpF+CBZDa7B3yRcnw0mseH6W5/BJ45onmTn5
         qRVuKk2PLrMbX0jbgfX65qMkwvSxeDNM39181wvdZ99IbLJuDpKuE6uqwaMKF70i/Eqo
         wNjqxO8nAkuECThVd+WQK2xjLP3z4pmFTLL2ZWm97SC5QO62hfcmRm3NioA8E012kPJc
         DzwxIyEFiTdXe+wLA+7b6MtMd/plnwdPhz2HE+7USUQAPAMqJ8GUqWG67/rEdwtlhOxu
         GeLk+v6AyJqsMI7xRDx8z16BZtYiZssLWlAunZaOHCI3+WK9f6FWSDVo7PxzB85unGB8
         z74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=D5xumJlwdcilFo/njjbEzxFa6ctffy8d4uKpawHYNuU=;
        b=PDhdlpvR9il0saEi8HGtKv6t2x9of+GdVIskiuT1NPxSpVenejuIyQecyHs0efh/jL
         abi/1/AWWToPhPxQK6/Zgeon4Y0tAE0TG8F4BdUYsKP3Hki8N6b/S8ptO2UA/LsNUVLl
         zaUR+Gae+Of2aR5Q7TRU7NqxMSz/WTGxAVfdAlVq5xe2C9231pSCPvDv0+sqRMey7PVQ
         wgGrvIBskMxszNV0qcErbMyr3kAZGQ/ITRHDUaOH6HV9lGGrx5lvAodx35yaawyjaQ1I
         Z5lKyANXaJ2zn9kUVjCzhsbGEpqpvObKR0ZG6yxDBXX/ST3nz5XPHH/6Gq4OE+GU04IP
         Vx2A==
X-Gm-Message-State: APjAAAXd/EB8xmUfgmr82OOkYxH/mpLFB4oANDxbSI7vr+de4DEahzAX
        UsqRWEvRZ/kvAcpTVdwCd3S1IWj2
X-Google-Smtp-Source: APXvYqxWZNzLCj99Kn1IlRcQkXPsYmjJ/X+ngcraSnQm6+FrJfYoC7MVWJbaE4K0+rC+Ytr8JRainw==
X-Received: by 2002:a5d:4250:: with SMTP id s16mr3284411wrr.318.1566983503774;
        Wed, 28 Aug 2019 02:11:43 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-2-29.as13285.net. [92.22.2.29])
        by smtp.gmail.com with ESMTPSA id c1sm1432152wmc.40.2019.08.28.02.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 02:11:43 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 10/11] introduce container_of macro
To:     Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20190826024332.3403-1-e@80x24.org>
 <20190826024332.3403-11-e@80x24.org>
 <381dd52f-f7d4-3e6c-24b8-22c8a0710f25@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a7b3b9f4-58aa-0d09-fe43-8094e3a255b8@gmail.com>
Date:   Wed, 28 Aug 2019 10:11:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <381dd52f-f7d4-3e6c-24b8-22c8a0710f25@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/08/2019 15:49, Derrick Stolee wrote:
> On 8/25/2019 10:43 PM, Eric Wong wrote:
>> This macro is popular within the Linux kernel for supporting
>> intrusive data structures such as linked lists, red-black trees,
>> and chained hash tables while allowing the compiler to do
>> type checking.
>>
>> I intend to use this to remove the limitation of "hashmap_entry"
>> being location-dependent and to allow more compile-time type
>> checking.
>>
>> This macro already exists in our source as "list_entry" in
>> list.h and making "list_entry" an alias to "container_of"
>> as the Linux kernel has done is a possibility.
> [snip]
>> +/*
>> + * container_of - Get the address of an object containing a field.
>> + *
>> + * @ptr: pointer to the field.
>> + * @type: type of the object.
>> + * @member: name of the field within the object.
>> + */
>> +#define container_of(ptr, type, member) \
>> +	((type *) ((char *)(ptr) - offsetof(type, member)))
>> +
>>   #endif
> 
> I think it would be good to include at least one use of this
> macro in this patch. As it stands, I need to look at the next
> patch to make sense of what this is doing.
> 
> It took me a little while to parse what is happening here.
> 'ptr' is a pointer to the generic struct (in our case,
> 'struct hashmap_entry *'), while 'type' is the parent type,
> and 'member' is the name of the member in 'type' that is
> of type typeof(*ptr).

It took me a couple of minutes to figure it out as well. The rest of 
this patch series adds some very welcome type safety changes, at first 
sight this patch threatens to undermine that as there is no check (and 
no compiler independent way to check) that type == typeof(*ptr). It 
would also be helpful if the commit message could explain how this can 
be used to improve type safety.

Best Wishes

Phillip

> Perhaps this is easier to grok for others than it was for me.
> 
> -Stolee
> 
