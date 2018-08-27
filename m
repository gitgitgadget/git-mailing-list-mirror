Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79BC81F404
	for <e@80x24.org>; Mon, 27 Aug 2018 12:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeH0QSP (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 12:18:15 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36617 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeH0QSP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 12:18:15 -0400
Received: by mail-qt0-f193.google.com with SMTP id t5-v6so17718975qtn.3
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sC+c9vRR/Q+I2QWMK1fEF/hvTTt3lHz5g2XxpEvnHhw=;
        b=j9HvvVd0hBObFnDTTT9vUss/+ku0UC1XAdaFem4oPyZQnZKOAEVk/Mq8LclYv8Jm//
         M7BPFFqIAcLSqaBizLFBuz89GsBhldklcmRbPgP6MbiqhrbFcl00janXoSo6Il+eD2uA
         w4YZXeBiyIVcsfM0OBIQoDzyZTlqAZH4TZuQNaT1tr2OYEy7w/LhDkBWh5de5kG7drMF
         TwhhkoZZ8TME+wnZJsmJG076idqjeKj0umTiBx3CQCQcavKmt7O0mLldUxxwVQYzCIQ0
         5iNFLCjG+YLhhMJCyKE1tDboemJVsroc1jo6mtN2qM3kPRSi9yiszmki1Pm59BwlCDCe
         P2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sC+c9vRR/Q+I2QWMK1fEF/hvTTt3lHz5g2XxpEvnHhw=;
        b=LyHy+zphXMWr1XLnpIryFPVHNh/aS72YRqy/U9jwimHv6Z9Bu616c+bfTHXHvty9BM
         B8SCf1lDHXRHvAQgim1DifOhFVSvIPAGPNYGtLWLD+5/6YefBv7Igx7NHxw0GYZ+au7j
         F+8E0YnT8ZgV147GsyihDAA7Op+JLBkxuOKio4iQ2JPlONf4Qf6wkdeY9/fb4CfDI1rn
         1FBqcOS7E1V5ziAy8NFhVIEkM7cawB3prRSS3+KDfgP844BfwlABEv0Ccn8r2OLKjjaQ
         eDTm+ZVYm4uqRyArJCgj8llBWTLGbpFY7X89eXyy0jGbl370zQtXp9VEzxIik7P9Jwr6
         18NA==
X-Gm-Message-State: APzg51CjNTLxz76nEE9ELLPINv26F/Ef8UiXagygP6ym9s6xvlcWu9/r
        WkWqh66Ke084l/2kEYgqA6o=
X-Google-Smtp-Source: ANB0VdZEE0b0CVTXdpQsWhPjXAUiiwUFdeL720635Sq+bMP/FTNCXAnIxmDdJPW35svMqnE1f8sY/A==
X-Received: by 2002:aed:38a9:: with SMTP id k38-v6mr13753711qte.170.1535373106879;
        Mon, 27 Aug 2018 05:31:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:10b0:d7ed:482d:ab9b? ([2001:4898:8010:0:f9e5:d7ed:482d:ab9b])
        by smtp.gmail.com with ESMTPSA id v129-v6sm8096594qkd.86.2018.08.27.05.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 05:31:45 -0700 (PDT)
Subject: Re: [PATCH 3/9] convert "oidcmp() == 0" to oideq()
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jacob Keller <jacob.keller@gmail.com>
References: <20180825080031.GA32139@sigill.intra.peff.net>
 <20180825080715.GC737@sigill.intra.peff.net>
 <20180825083602.GA2251@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <62172db4-15b2-eac3-8591-246300db3948@gmail.com>
Date:   Mon, 27 Aug 2018 08:31:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180825083602.GA2251@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/2018 4:36 AM, Jeff King wrote:
> On Sat, Aug 25, 2018 at 04:07:15AM -0400, Jeff King wrote:
>
>> diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
>> index 5869979be7..548c02336d 100644
>> --- a/contrib/coccinelle/object_id.cocci
>> +++ b/contrib/coccinelle/object_id.cocci
>> @@ -108,3 +108,9 @@ expression E1, E2;
>>   @@
>>   - hashcpy(E1.hash, E2->hash)
>>   + oidcpy(&E1, E2)

Is this change intended? It doesn't seem to match the intention of the 
rest of the patch.

>> +
>> +@@
>> +expression E1, E2;
>> +@@
>> +- oidcmp(E1, E2) == 0
>> ++ oideq(E1, E2)
>>
>> [...]
>>
>> diff --git a/cache.h b/cache.h
>> index f6d227fac7..d090f71706 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1100,7 +1100,7 @@ static inline int is_empty_blob_sha1(const unsigned char *sha1)
>>   
>>   static inline int is_empty_blob_oid(const struct object_id *oid)
>>   {
>> -	return !oidcmp(oid, the_hash_algo->empty_blob);
>> +	return oideq(oid, the_hash_algo->empty_blob);
>>   }
> By the way, one interesting thing I noticed is that coccinelle generates
> the hunk for cache.h for _every_ file that includes it, and the
> resulting patch is annoying to apply. I think this is related to the
> discussion we were having in:
>
>    https://public-inbox.org/git/20180802115522.16107-1-szeder.dev@gmail.com/
>
> Namely that we might do better to invoke one big spatch (and let it
> parallelize internally) instead of one perfile. Presumably that would
> also avoid looking at the headers repeatedly (which would be both faster
> and produce better output).
>
> I'm not planning to pursue that immediately, so just food for thought at
> this point.

The more we use Coccinelle, the more we will learn how to improve the 
workflow.

Thanks,

-Stolee

