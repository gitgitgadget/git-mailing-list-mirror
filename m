Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2E501F403
	for <e@80x24.org>; Fri, 15 Jun 2018 14:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756134AbeFOOPy (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 10:15:54 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36599 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755645AbeFOOPx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 10:15:53 -0400
Received: by mail-qk0-f196.google.com with SMTP id a195-v6so5674401qkg.3
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XgOcxZqKE9N01aCqBmxBBwlZJYuXxzHIFT2NG5MvSFI=;
        b=nxX0z4chv8EJbWODA6d8C10mZtd5OhY4Jr4jxkqt60RkqIlSFqryv779G3WOvMVkVq
         cnINmFUWB7O+FPJLNHBEuaSTH3uEjhboZ1sonkj/xVmGtAJGxxrij/T+3Ny5y5ryctzk
         TRSM1ovXWxeC2zB5n9bxBFn48HMjgueWA49TsVqub0kHY8h5LPwj9jbh3AHqEccTStvp
         AqIVkhUbOpyOyEg4uSkW5UW86HRudWA/cHGSvMUhPz+RQk11t/+qqOsP48DTQfUFgRXH
         W6z8lFIzzerGWxNEAfpFez7watUH3URnt5UMdTmJOtrDsTgOhz553VvpABkg5ZwgJQmo
         6EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XgOcxZqKE9N01aCqBmxBBwlZJYuXxzHIFT2NG5MvSFI=;
        b=rHs5/4LO6sD/5NFXL3b/h4zvnC34zcH8ymFZfp5Mfrz3WLxH76iexMehj/RwWaWboq
         Pdm9BM67M7TFZjDJ5cC4BVPhEFxnbrTIbO+KG4bxuHqjjnTy+kZEQbz8LIupRYpP/FS2
         hxilnr68Wum8Uoq0eo9VIliN+9+Thx4MqILKEmdVOVcZSHCok1jFh2xC7PS1jZZZsGCz
         5Dd6mJwh6095L5k4zEUrybjJscj4Gj7NbGgl43PNFpJrUX9C1Pqo6OCQsZ5pHLF40RZQ
         I5C4LDrEeannp9ZYuAO3Fc4IzllFL/6fq6bI5H7UMLKJ6RmBJoIJZl8wBuV8dPRrXsvJ
         PNYg==
X-Gm-Message-State: APt69E1L0Qs1OoSnpwMYPjfKRWp4/EUgTgJY3fBtv2ZmjcsPgbVakass
        jWaiQVcmqiwu0+z9h3znyWXNpO2C
X-Google-Smtp-Source: ADUXVKI4gBxTOqVQF9cnPgBRpIJ8RLj+85+ycWdHjhm8TCa1JhZWK/0ZbgXIvTHjCqaST0EI5/z3pA==
X-Received: by 2002:a37:5bc6:: with SMTP id p189-v6mr1477191qkb.212.1529072152146;
        Fri, 15 Jun 2018 07:15:52 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:936:68f2:e294:88e9? ([2001:4898:8010:0:f26b:68f2:e294:88e9])
        by smtp.gmail.com with ESMTPSA id g57-v6sm5602609qte.52.2018.06.15.07.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 07:15:51 -0700 (PDT)
Subject: Re: [PATCH 3/3] ewah: drop ewah_serialize_native function
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, Luat Nguyen <root@l4w.io>
Cc:     git@vger.kernel.org
References: <20180615032850.GA23241@sigill.intra.peff.net>
 <20180615033228.GC20390@sigill.intra.peff.net>
 <afbd5335-ef0d-5ca5-84ab-bdfa8bdc50bb@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ab6378a8-3728-7fa8-da08-b58ec768dbfe@gmail.com>
Date:   Fri, 15 Jun 2018 10:15:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <afbd5335-ef0d-5ca5-84ab-bdfa8bdc50bb@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/2018 9:56 AM, Ramsay Jones wrote:
>
> On 15/06/18 04:32, Jeff King wrote:
>> We don't call this function, and never have. The on-disk
>> bitmap format uses network-byte-order integers, meaning that
>> we cannot use the native-byte-order format written here.
>>
>> Let's drop it in the name of simplicity.
> Hmm, if you are in the mood to drop ewah dead code, how about:
>
>    ewah/bitmap.o   - bitmap_clear
>    ewah/bitmap.o   - bitmap_each_bit
>    ewah/ewah_bitmap.o      - ewah_and
>    ewah/ewah_bitmap.o      - ewah_and_not
>    ewah/ewah_bitmap.o      - ewah_not
>    ewah/ewah_bitmap.o      - ewah_or
>
> ... in addition to these *(de)serialize* functions. ;-)
>

Normally, I would say we should keep this folder as close to the 
"original" [1] as possible, so we could more easily take improvements to 
that library. However, it appears that code is not being updated. 
Perhaps this is in favor of other EWAH libraries [2] or other compressed 
bitmap formats [3].

For that reason, I agree we should clean this up. We shouldn't block 
Peff's patch for that reason. I'll send a patch that deletes these methods.

Thanks,
-Stolee:

[1] https://github.com/vmg/libewok

[2] https://github.com/lemire/EWAHBoolArray

[3] https://github.com/RoaringBitmap/CRoaring
