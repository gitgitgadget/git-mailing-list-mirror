Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45CF920357
	for <e@80x24.org>; Mon, 10 Jul 2017 17:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754780AbdGJR5Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 13:57:25 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36551 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754594AbdGJR5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 13:57:24 -0400
Received: by mail-qk0-f193.google.com with SMTP id v143so13805321qkb.3
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xCzuQu8aAzOopvhsGt1kOWW9VtVoTiA0n6seacEanvM=;
        b=U1On+aCNKi0wDJl52Jx/cRqhstWXYCF98RAGBh0JPhnMV34xn1B6YzHRS79SoZPcWR
         5+vcjMHVFVC24+P99cuIs/LZPHQbsNAO504HFckG9DOS1QpJDBX+BM/uzzeUgTRbHHin
         GyP9t0F5dsD7PMKyoODYM77bzufBh7PdQCbGKvlQLXSyZwkX+iXS2p9O3YLqpbZh3BxU
         BglOXCHgWqupsDCnLZZHv2Gm5eyyavcTipokBDU9AZby9TT4oNe3/jdYA7XIg41hbfOD
         2yP6jIfFWUsiDOnNjpqxV8Z85AVPG2KXUV1xIKMU4eqYyJJPAbvLqAQEQEHkOdZAi8G3
         89RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xCzuQu8aAzOopvhsGt1kOWW9VtVoTiA0n6seacEanvM=;
        b=W9MnRqi0BtPteN03HoQ/Kg8RWzWfm2UMbbS/YscGeByA8HsPnBfUomwKGqcbSl9Dxw
         oyIddvQgBxXbApaYFX2HiWbqraoT+5g+D5KBBhSu3ZnodgMGmGJJD4cMni7yqevgWLZ7
         8gMWV9ju80t0Q51Jy+Mh5FaXN8B7z2AEZ73Y66PBMwvF5E6kNjllV5kMcFfAI03KFjZM
         bn2cHiJXe1Pbc6QInUS/bGcrl4deKsrPrl7ZsVHHKTeWbWjP+CbHvYUyf8KJ7qJ9Yknl
         ozTRVPAb3i2VsTURU5/I0a7/R4chkgUd9as2/BV7aAAmA6KFpfNU8oEO/wQcFE1L16DZ
         Xn6Q==
X-Gm-Message-State: AIVw111MyoeJK5FOGqULp7EKVv9wtX/dfrrbTpQ6bdNdpxWjJxegIUVr
        hx6UwcR0w21O8Ycxwxs=
X-Received: by 10.55.134.69 with SMTP id i66mr5811176qkd.33.1499709443364;
        Mon, 10 Jul 2017 10:57:23 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id u76sm8772908qka.26.2017.07.10.10.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2017 10:57:22 -0700 (PDT)
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <4d4f2af7-60b9-5866-50bc-ecf002f74cba@gmail.com>
 <20170710160432.4mmcoqh7yi5cqdhy@sigill.intra.peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <15867357-5b3f-b12e-8bc3-125b3f2f18f0@gmail.com>
Date:   Mon, 10 Jul 2017 13:57:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170710160432.4mmcoqh7yi5cqdhy@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/10/2017 12:04 PM, Jeff King wrote:
> On Mon, Jul 10, 2017 at 10:57:57AM -0400, Ben Peart wrote:
> 
>>> If this patch can survive a few releases without complaint,
>>> then we can feel more confident that designated initializers
>>> are widely supported by our user base.  It also is an
>>> indication that other C99 features may be supported, but not
>>> a guarantee (e.g., gcc had designated initializers before
>>> C99 existed).
>>
>> Correct.  MSVC also supports designated initializers but does not fully
>> support C99.
> 
> Out of curiosity, does MSVC define __STDC_VERSION__, and if so, to what?

It does not. While it does support a subset of C99's features, it 
doesn't support the entirety of that language so defining 
__STDC_VERSION__ would be inaccurate and misleading.

> 
>>> And obviously before releasing this or anything similar, it would be
>>> nice to see results from people building pu. I'm especially curious
>>> whether MSVC would work with this (or if people even still use it, since
>>> Git for Windows is pretty mature?).
>>
>> We do use MSVC internally as that gives us access to the great debuggers and
>> profilers on the Windows platform.  Fortunately, this particular C99
>> construct _is_ supported by MSVC.  I applied the patch below and complied it
>> with both MSVC and gcc for Windows and both builds succeeded.
> 
> Thanks. This kind of prompt testing and response is very appreciated. It
> is unfortunate if we have to pick and choose C99-isms rather than using
> the whole thing as a base. But that's probably just reality.
> 
> -Peff
> 
