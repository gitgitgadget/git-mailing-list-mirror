Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5341C1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 14:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeIHSt6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 14:49:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42149 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeIHSt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 14:49:57 -0400
Received: by mail-qk1-f196.google.com with SMTP id g13-v6so11474262qki.9
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gdc5h0V86XY566DWAnZI/ct4ysM5Sj0dC39g69pAC9o=;
        b=oU2oEeWT5O3Enuzb9e0ipGMfNFurMehsOWrB74cH9JPCKzLw144hzN5eXwaTDP/4iK
         Jlvz8V3NMCmkoEfx3WhUp2O42Mxd2t3Vov5iLOckyifMUKxQOW8OXWxx2oqwWRKDrxY8
         nRHwwWz0a5MIqtCjYghgJ26flx3ofg4YeUpZpWBosSrq0t+y4kj8XpsXWjBAsXbLFKHb
         OxptI7h698bTVwCUSwUrZ2pcVynQA6I5C861F/g6rJBx9q++Ce/tefwnM/TC22Aoh1D/
         96UGEAaS0deXa9ZzBIA4Dv52LCwbfIUMLxVAV1WjXjG4UWr2bqqUphfg6435Oo9d72z+
         jiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gdc5h0V86XY566DWAnZI/ct4ysM5Sj0dC39g69pAC9o=;
        b=TTE3WDACcorq8L3HBc5AGRz5cTpgG/CRcNf1rXIOAdOxYivZZfgp7xfmfj9M5k1QEY
         B4aR5x90uPl2KZvLyNHkY2jYQcOJiDcyhi9dIv937UkwtWYZhyIys+CRHQcRDzaiaZIz
         f7XHibFWO618DJRwQF8a+ArupeDv+ld+P2Y7G8M/OZ76YwsaAyegOCYICLXvclGATSMB
         KS4MEd0r8JfUlcc3FwLGdX3afhKITwmeEB/JRpgmNOh+2NiCD1mVTztxj3yc5hxlGRQi
         QrkIhGYK6U7sub+vU/qKTDBrhc08XEPu4+UEX3Fg4GrUBaBCoFnXGVcIolLn1f0IUKek
         PlDg==
X-Gm-Message-State: APzg51CuSWl5ilRd7mowFyTncyZDTQhQ5ItSNXKolFm7WJ/h7cF/WMr/
        7n2aQYzEYe/1+EksMGFtpRQ=
X-Google-Smtp-Source: ANB0VdYWskl1L5Lcr/xV5wLQS0jMz11d2T2V5PfYiww0xzvwLnxrkKLbYz4Hth5ObhpFISxJJiE0vg==
X-Received: by 2002:a37:1584:: with SMTP id 4-v6mr8931250qkv.266.1536415442314;
        Sat, 08 Sep 2018 07:04:02 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id b18-v6sm6172103qtk.92.2018.09.08.07.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 07:04:01 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] eoie: add End of Index Entry (EOIE) extension
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180906210227.54368-1-benpeart@microsoft.com>
 <20180906210227.54368-3-benpeart@microsoft.com>
 <xmqqpnxpw5sn.fsf@gitster-ct.c.googlers.com>
 <fc531863-c46c-6d27-4749-c6b092a14a6f@gmail.com>
 <CAN0heSreAfMsseZcxR75CFDph-n1b8EUNsRhpFsVqxMLc0hvpA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <ba1c8611-5480-deae-2b45-75fc9943086c@gmail.com>
Date:   Sat, 8 Sep 2018 10:03:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAN0heSreAfMsseZcxR75CFDph-n1b8EUNsRhpFsVqxMLc0hvpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/8/2018 2:29 AM, Martin Ågren wrote:
> On Fri, 7 Sep 2018 at 22:24, Ben Peart <peartben@gmail.com> wrote:
>>> Ben Peart <benpeart@microsoft.com> writes:
> 
>>>> - 160-bit SHA-1 over the extension types and their sizes (but not
>>>> their contents).  E.g. if we have "TREE" extension that is N-bytes
>>>> long, "REUC" extension that is M-bytes long, followed by "EOIE",
>>>> then the hash would be:
> 
>> The purpose of the SHA isn't to detect disk corruption (we already have
>> a SHA for the entire index that can serve that purpose) but to help
>> ensure that this was actually a valid EOIE extension and not a lucky
>> random set of bytes. [...]
> 
>>>> +#define EOIE_SIZE 24 /* <4-byte offset> + <20-byte hash> */
> 
>>>> +    the_hash_algo->init_fn(&c);
>>>> +    while (src_offset < mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER) {
> [...]
>>>> +    the_hash_algo->final_fn(hash, &c);
>>>> +    if (hashcmp(hash, (unsigned char *)index))
>>>> +            return 0;
>>>> +
>>>> +    /* Validate that the extension offsets returned us back to the eoie extension. */
>>>> +    if (src_offset != mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER)
>>>> +            return 0;
> 
> Besides the issue you and Junio discussed with "should we document this
> as being SHA-1 or NewHash" (or "the hash algo"), it seems to me that
> this implementation is living somewhere between using SHA-1 and "the
> hash algo". The hashing uses `the_hash_algo`, but the hash size is
> hardcoded at 20 bytes.
> 
> Maybe it all works out, e.g., so that when someone (brian) merges a
> NewHash and runs the testsuite, this will fail consistently and in a
> safe way. But I wonder if it would be too hard to avoid the hardcoded 24
> already now.
> 
> Martin
> 

I can certainly change this to be:

#define EOIE_SIZE (4 + GIT_SHA1_RAWSZ)

which should (hopefully) make it easier to find this hard coded hash 
length in the sea of hard coded "20" and "160" (bits) littered through 
the codebase.
