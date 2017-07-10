Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED5C820357
	for <e@80x24.org>; Mon, 10 Jul 2017 14:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbdGJO6L (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 10:58:11 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34191 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753245AbdGJO6J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 10:58:09 -0400
Received: by mail-qk0-f196.google.com with SMTP id q66so1988354qki.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AEMOrtisEisJ23HzohQXZRouj5KpFqagNhEjl+T4Iv4=;
        b=ZJLNs0pUSbInH6jJc1c8YWAirV8qplcKomKj+zVOlxlt4KKiZTPlE/+vgNUQWoXLfR
         cxpi3AboPg4jpGNlyODnGbhTILTAFGcrLgjdehwbsDiX+SyFHN6SRWbg5PXha035h/Jv
         MFGbu+6LcTUKBbhTkspal3mkCmVhuYueYa/iwf0sXYZv4vG+ffaxJsy2m4phxDJrqXQ0
         m9ecdaPLNv/554xT2mNWIfi5LkdoQCyBLO4LOQ4qSKzReBQXRQnyz0i1r6jpOi+TPDEi
         SfnB5lWnkgsM0Jwbew9Dv1uJfA2cgKRTwVfrJDDBqTlz2I8q96ZeIzbmsfK1mS6kz4uD
         6q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AEMOrtisEisJ23HzohQXZRouj5KpFqagNhEjl+T4Iv4=;
        b=Q/NcO/2mk0jgh0y4S5KdUicT0ET0IpLnrZS9rbII5VS9lHsVmip6phKNkjPeXdevCS
         OsZD4nQ7uSmH//mAdlqdYtk3SfiDC6I1NyhYGtdahHxeNAzigtK+TmGLduAcYiq7/x4e
         jQwDGPgnpRlyEAAf0ccv16wdVKOGcKKR0onkXW4Be7dNEoR19oupJgnh4ZyBziEAe3BR
         L1kHsL0C5NPIP1bH0cZpmBCSA+oKFxUsdMUp4Rf2oj/pzSQoqxEdOVMpMucikn5JFhBW
         At3Y7apvB7Hi3lgLN6itS08xALtworJ+1xEEawnktxjEbuouQnxknRvBE23gqjR0dNi3
         ybQg==
X-Gm-Message-State: AIVw111NNSktDYoVweLlnXfBE0xqooln/mF3FnzDEL+7rjUApBx4puuV
        B37U0jvXqT52cYgenA0=
X-Received: by 10.55.47.193 with SMTP id v184mr4346797qkh.191.1499698678072;
        Mon, 10 Jul 2017 07:57:58 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id n69sm8409743qke.68.2017.07.10.07.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2017 07:57:57 -0700 (PDT)
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <4d4f2af7-60b9-5866-50bc-ecf002f74cba@gmail.com>
Date:   Mon, 10 Jul 2017 10:57:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/10/2017 3:03 AM, Jeff King wrote:
> On Sun, Jul 09, 2017 at 10:05:49AM -0700, Junio C Hamano wrote:
> 
>> René Scharfe <l.s.r@web.de> writes:
>>
>>> I wonder when we can begin to target C99 in git's source, though. :)
>>
>> Let's get the ball rolling by starting to use some of the useful
>> features like designated initializers, perhaps, in a small, critical
>> and reasonably stable part of the system that anybody must compile,
>> leave it in one full release cycle or two, and when we hear nobody
>> complains, introduce it en masse for the remainder of the system?
>>
>> That way, we will see if there are people who need pre-C99 soon
>> enough, and we won't have to scramble reverting too many changes
>> when it happens.
> 
> Neat idea. Something like this?
> 
> -- >8 --
> Subject: [PATCH] strbuf: use designated initializers in STRBUF_INIT
> 
> There are certain C99 features that might be nice to use in
> our code base, but we've hesitated to do so in order to
> avoid breaking compatibility with older compilers. But we
> don't actually know if people are even using pre-C99
> compilers these days.
> 
> One way to figure that out is to introduce a very small use
> of a feature, and see if anybody complains. The strbuf code
> is a good place to do this for a few reasons:
> 
>    - it always gets compiled, no matter which Makefile knobs
>      have been tweaked.
> 
>    - it's very stable; this definition hasn't changed in a
>      long time and is not likely to (so if we have to revert,
>      it's unlikely to cause headaches)
> 
> If this patch can survive a few releases without complaint,
> then we can feel more confident that designated initializers
> are widely supported by our user base.  It also is an
> indication that other C99 features may be supported, but not
> a guarantee (e.g., gcc had designated initializers before
> C99 existed).
> 

Correct.  MSVC also supports designated initializers but does not fully 
support C99.

> And if we do get complaints, then we'll have gained some
> data and we can easily revert this patch.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I suspected we could also do something with __STDC_VERSION__, though I
> wonder what compilers set it to when not in standards-compliant mode.
> gcc-6 claims C11 when no specific -std flag is given.
> 
> And obviously before releasing this or anything similar, it would be
> nice to see results from people building pu. I'm especially curious
> whether MSVC would work with this (or if people even still use it, since
> Git for Windows is pretty mature?).
> 

We do use MSVC internally as that gives us access to the great debuggers 
and profilers on the Windows platform.  Fortunately, this particular C99 
construct _is_ supported by MSVC.  I applied the patch below and 
complied it with both MSVC and gcc for Windows and both builds succeeded.

>   strbuf.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/strbuf.h b/strbuf.h
> index 2075384e0..e705b94db 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -68,7 +68,7 @@ struct strbuf {
>   };
>   
>   extern char strbuf_slopbuf[];
> -#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
> +#define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }
>   
>   /**
>    * Life Cycle Functions
> 
