Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C045E1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 13:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754522AbeGINMG (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 09:12:06 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36625 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754519AbeGINMF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 09:12:05 -0400
Received: by mail-qt0-f195.google.com with SMTP id f1-v6so15289261qti.3
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=evYHtsNn9mJq1dgLVZrgqR4Vo2W7xhtRzw2JB44RphM=;
        b=OLTJKRQhtEOzDTDKNHDsYueD2Li6k/DqGqe/mV54xbqQDg1VIiexgAFkfqB7A7ZN+/
         lkPoACSZaECK2fZb2VYLAjgE2N7tFbLcqSrZcfPGUtzYdSjBfvvoAssQggo1hvuaQHv2
         sT9htqOYJ/+zCWErc1P0n5DMgRW65juaN1yGIAFQo5JizYZThPor3GPtZPbqiP/Kt7Qg
         2BDXrcUHEVSFhKjtoCRMViegbeOaTbVgTtI0fiZ3dcz6wZU6mszOiPqcBvB8vyYizYKu
         e5uyNPWyQp3C7PZ8isFcNfm+wDLDqHPNuUv+WDEYgZo8op29VWrW8JCcF7G3U2xopQGl
         HRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=evYHtsNn9mJq1dgLVZrgqR4Vo2W7xhtRzw2JB44RphM=;
        b=G/60PmJOFz/DBNhd+XF/s0cHnOxKLnQVNOoHaZ8KEoqePJ0wA9EJKM6cbKOOuwLM5o
         38/L9taymhWr8Buh1va4mwcRp+yzmfcQFW9CIsuncI3HJgP2fzAaj0UYVWmlUb4qs9U/
         vlQT+1xtlgXdMC6Q8BB2vFycI0l9xT2xhAR2DP+8HqY6MjScIYbQ6mt7SmVE96p1tkdh
         X6Xblw1JRngUB1UL1uYwiKnC4SLHFIUVHfbvx0bIctRopMoX0pTJ5o/8cx8otDvkauCY
         GdN2R01UMSAAEbVwnuLRrRTss422ak3qPnWglrMo0NolL+zSTuOtmfuGUiVOIz92mfqO
         fcnA==
X-Gm-Message-State: APt69E1BTdviFWMFlS/KOedH7IcIGGGJjMhEEOxOdXOZsRXzI26mC+3q
        0b7l4cb1/9C1mrgmE8dq56g=
X-Google-Smtp-Source: AAOMgpdesaWhCuv7esuia0635WF3LhGGT5ZPuloOg6PSgF6SoPCSHB+kWjFQkX4Fsyg1ydFzKMs11Q==
X-Received: by 2002:ac8:710f:: with SMTP id z15-v6mr18373143qto.387.1531141925282;
        Mon, 09 Jul 2018 06:12:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4d64:6d41:6305:74de? ([2001:4898:8010:0:369a:6d41:6305:74de])
        by smtp.gmail.com with ESMTPSA id e1-v6sm3118354qkd.15.2018.07.09.06.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 06:12:04 -0700 (PDT)
Subject: Re: [PATCH 00/17] object_id part 14
To:     Jacob Keller <jacob.keller@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
 <CA+P7+xq9SeoZjYYWhM14-u4kGgwmNVPs6c+wFR2EbwK+_hVetg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1438bdfd-cb13-8da4-2dd2-16362b242ff3@gmail.com>
Date:   Mon, 9 Jul 2018 09:12:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xq9SeoZjYYWhM14-u4kGgwmNVPs6c+wFR2EbwK+_hVetg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/8/2018 11:12 PM, Jacob Keller wrote:
> On Sun, Jul 8, 2018 at 4:39 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> This is the fourteenth series of patches to switch to using struct
>> object_id and the_hash_algo.  This series converts several core pieces
>> to use struct object_id, including the oid* and hex functions.
>>
>> All of these patches have been tested with both SHA-1 and a 256-bit
>> hash.
>>
> I read through the series, and didn't spot anything odd, except for
> the question about reasoning for why we use memcmp directly over using
> hashcmp. I don't think that's any sort of blocker, it just seemed an
> odd decision to me.

I also read through the series and only found the 100/200 constants 
confusing. Not worth blocking on, but I'm CC'ing Michael Haggerty to 
comment if he knows how the magic 100 was computed.

Thanks,
-Stolee
