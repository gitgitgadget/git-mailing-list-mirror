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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8971F462
	for <e@80x24.org>; Wed, 29 May 2019 00:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfE2A3k (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 20:29:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37250 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE2A3k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 20:29:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id y57so500565qtk.4
        for <git@vger.kernel.org>; Tue, 28 May 2019 17:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2vpwBF2yQItxE5uDn2Icq3iK2m63ilLmjN2FZv6YJP8=;
        b=hv/lrKJazZCShXcRLw+AZQV1dlrhb8gUXErsROYXeZ9iRIZ3FF2B0MITQEkfrufWub
         uBpfCihbgMN2PiYio3SmwZL1AfmMq/PK+g1sSu6+UwjZg+OASRtqF+p13ttL+rLPN20B
         M+FtFWjNCrATRY/nJD2Uko5/F7soUqOM/9F24iqOuZaGvNeqpLxndBUkO/TEPyIA7NxO
         npCZLN0NA2AC/DZWJzAWOvxCDY8QIs95L84lhdw5vu9ZRckKZEgHK59nMTaivirG33ND
         G7b/ey4eQ/fZcloWtjpNQ5N9n7wuNinBvc/G7Q75XI4zCZ6tuF4b22vWZ80sw4nLerVL
         pPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2vpwBF2yQItxE5uDn2Icq3iK2m63ilLmjN2FZv6YJP8=;
        b=liDf3LUIad4by7VNv7vHbZeIgYt7FmKdG06RqPs8BbnarBXKPnjNQHp2B0U1/p05eP
         ljDc6nIOAQ51TfxPdcXhO7Srkn45ttyfAOvdkMOIWzsNjeVQeyYmnA9/GH/351Km2EaW
         RB5GMCSHgVmvf7XZopPwUpFf8TxCxkrTwFlrgrOdYgb/O2hxiRUPV8flN7KCW17hk2XW
         eF7vmWQTrog+Mj0hw4LHdoNHGWJrY25hHwuTl2PQjk+WKMmChSYA3gVcfQbUAH3Y05df
         ayyptf4V13+NnHgrmIWzqVrBCn27k+stuSxL0Ew2ZuaI459eCkmT0absECMIeFAU8oJM
         bZ9Q==
X-Gm-Message-State: APjAAAUOxf6G7dJ6EsdC0ixF+akBliEo8NQKsDMuRKJ8B2vHu3LWTwfy
        rE8rHnGmK00WNEXTu+vQ/RY=
X-Google-Smtp-Source: APXvYqwGGQfEAzqWxMOE4dHsDT0vfCA93st+zzsNdF9/VIkxTsk41Il3zEREjHsz1Zyo3EkhdLxFgw==
X-Received: by 2002:ac8:6941:: with SMTP id n1mr72620210qtr.122.1559089779169;
        Tue, 28 May 2019 17:29:39 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id h63sm2635440qkf.4.2019.05.28.17.29.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 17:29:38 -0700 (PDT)
Subject: Re: [PATCH 1/1] sha1-file: split OBJECT_INFO_FOR_PREFETCH
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.228.git.gitgitgadget@gmail.com>
 <2737e62966cae2f00d75a93446bad76e5816d07e.1559056745.git.gitgitgadget@gmail.com>
 <20190528205441.GB24650@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f30f82f9-b07e-d6c3-5ccb-9b08b8424f7c@gmail.com>
Date:   Tue, 28 May 2019 20:29:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190528205441.GB24650@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/28/2019 4:54 PM, Jeff King wrote:
> On Tue, May 28, 2019 at 08:19:07AM -0700, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The OBJECT_INFO_FOR_PREFETCH bitflag was added to sha1-file.c in 0f4a4fb1
>> (sha1-file: support OBJECT_INFO_FOR_PREFETCH, 2019-03-29) and is used to
>> prevent the fetch_objects() method when enabled.
>>
>> However, there is a problem with the current use. The definition of
>> OBJECT_INFO_FOR_PREFETCH is given by adding 32 to OBJECT_INFO_QUICK. This is
>> clearly stated above the definition (in a comment) that this is so
>> OBJECT_INFO_FOR_PREFETCH implies OBJECT_INFO_QUICK. The problem is that using
>> "flag & OBJECT_INFO_FOR_PREFETCH" means that OBJECT_INFO_QUICK also implies
>> OBJECT_INFO_FOR_PREFETCH.
>>
>> Split out the single bit from OBJECT_INFO_FOR_PREFETCH into a new
>> OBJECT_INFO_SKIP_FETCH_OBJECT as the single bit and keep
>> OBJECT_INFO_FOR_PREFETCH as the union of two flags. This allows a clearer use
>> of flag checking while also keeping the implication of OBJECT_INFO_QUICK.
> 
> Oof. I actually suggested splitting these up for review, but thought it
> was only a clarity/flexibility issue, and completely missed the
> correctness aspect of checking when the bit is set.
> 
> I agree with Junio's other response that using "==" would be the right
> way for a multi-bit check, in general. But I like the split here,
> because I think the result is more clear to read and harder to get
> wrong for future checks.

Thanks, for the feedback, both of you.

> I'd even go so far as to say...
> 
>> + * This is meant for bulk prefetching of missing blobs in a partial
>> + * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
>> + */
>> +#define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
> 
> we could dump this, and callers should just say what they mean (i.e.,
> specify both flags).

Dropping the _PREFETCH flag also makes oid_object_info_extended() slightly
less "coupled" to the prefetch feature, and instead describes more explicitly
the way the flag is changing the behavior of the method.
 
> There are only two of them, and I think both would be more readable with
> a helper more like:
> 
>   int should_prefetch_object(struct repository *r,
>                              const struct object_id *oid) {
> 	return !oid_object_info_extended(r, oid, NULL,
> 	                                 OBJECT_INFO_SKIP_FETCH_OBJECT |
> 					 OBJECT_INFO_QUICK);
>   }
> 
> but unless everybody is immediately on-board with "yes, that is much
> nicer", I don't want bikeshedding to hold up your important and
> obviously-correct fix.

I'll come back with another series to drop the _PREFETCH flag after the
release calms down. It can give more time for others to chime in here.

Thanks, Junio for the quick turnaround in taking the patch.

Thanks,
-Stolee
