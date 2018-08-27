Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A76E1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 12:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeH0Q2E (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 12:28:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42239 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0Q2D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 12:28:03 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so17726104qto.9
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 05:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=jHdEEsQ8l/s+5Oja9xcUzOQCeYhIiw4mDHYOomI/eBw=;
        b=Kk9vU0r9ahp6e5coyoRI1uXjW1miLWfTIpJzdp1rGYLGmlHhlNvVi1YLUrsl/JEZE1
         PrpccbmlgfDjeZ8HvEseLW+uDT5RvFJiuezrYz9Z5hAwFY9K+YSDn+AVcWSjFByDy1EG
         BxkqSFKs1MkUUkz+YmPlnAU0vE8lVzTiT54Y0PicBvOkxcl38EfK1QcHj4wE6KCHn8XN
         +3YpYPVSDvSYNqoPudxaLNAjUR5PTEZTSb65ZnBh8TqL0QhpU81hrf/WPDrvTErNq4Bc
         HcReiaPDpU59kyyxUSLOTlG2GFtyAjy6zRTrWipAA8l55ffOkWl6BwTLk/Q3CHfgsJ3E
         0S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jHdEEsQ8l/s+5Oja9xcUzOQCeYhIiw4mDHYOomI/eBw=;
        b=W/9O6P/+T9rOYOaXw1yIaoZJX2gUCg0cA3H4CV0rj/Ap0eo4JRjCnRYDg/JPwW6Np6
         /X+BIL26OkIuKwkMzUnR3ZN8Nln/o72YfUIQAB4Xkaqx3kUVAXQV650JVURp7d28SCQQ
         I0PeK/phEVztOs0UMRFriR+IXOZH5s+maNZ3LOW0cYsAykLMJiRn+1NVFOC+7X5YG7Ia
         caU+fhNmrtufucrSfUkmFyFIthwrOSnRZ9QZ4qXQ7X85OtoZXlnDzmLHElRJ2Xni4hMD
         rPIjBHxcA+Fsc/pjVeqdhLqI+siMhC8+OhgPsetQHoZryH5IU2VEnNRkk1pGnw6fBWgW
         Hf5w==
X-Gm-Message-State: APzg51An/Ij2A7DkUC62g1ny4P9syI4EDFmmeUeZNn43gr6cCZoWPCXD
        ClBMfFLFtoriZxKgXdbddJ0=
X-Google-Smtp-Source: ANB0Vda59+nreS+C6gqSPQ5HGLJx/wHkqSqrGD5eIC0DQcSuDoaE7X+DjkRF6fDhxpGKJMBMaU24SA==
X-Received: by 2002:ac8:4283:: with SMTP id o3-v6mr14111099qtl.28.1535373692931;
        Mon, 27 Aug 2018 05:41:32 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:10b0:d7ed:482d:ab9b? ([2001:4898:8010:0:f9e5:d7ed:482d:ab9b])
        by smtp.gmail.com with ESMTPSA id r7-v6sm10973245qkh.83.2018.08.27.05.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 05:41:32 -0700 (PDT)
Subject: Re: [PATCH 0/9] introducing oideq()
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>
References: <20180825080031.GA32139@sigill.intra.peff.net>
 <20180826205620.GC873448@genre.crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dd26d177-7e37-83ac-7275-03db962a282c@gmail.com>
Date:   Mon, 27 Aug 2018 08:41:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180826205620.GC873448@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/26/2018 4:56 PM, brian m. carlson wrote:
> On Sat, Aug 25, 2018 at 04:00:31AM -0400, Jeff King wrote:
>> This is a follow-up to the discussion in:
>>
>>    https://public-inbox.org/git/20180822030344.GA14684@sigill.intra.peff.net/
>>
>> The general idea is that the majority of callers don't care about actual
>> plus/minus ordering from oidcmp() and hashcmp(); they just want to know
>> if two oids are equal. The stricter equality check can be optimized
>> better by the compiler.
>>
>> Due to the simplicity of the current code and our inlining, the compiler
>> can usually figure this out for now. So I wouldn't expect this patch to
>> actually improve performance right away. But as that discussion shows,
>> we are likely to take a performance hit as we move to more runtime
>> determination of the_hash_algo parameters. Having these callers use the
>> more strict form will potentially help us recover that.
>>
>> So in that sense we _could_ simply punt on this series until then (and
>> it's certainly post-v2.19 material). But I think it's worth doing now,
>> simply from a readability/annotation standpoint. IMHO the resulting code
>> is more clear (though I've long since taught myself to read !foocmp() as
>> equality).
> I would quite like to see this series picked up for v2.20.  If we want
> to minimize performance regressions with the SHA-256 work, I think it's
> important.

Seconded.

> Applying the following patch on top of this series causes gcc to inline
> both branches, which is pretty much the best we can expect.  I haven't
> benchmarked it, though, so I can't say what the actual performance
> consequence is.

We should definitely measure the cost here, but when we have the option 
to move to newhash, that cost should be acceptable.

Thanks,

-Stolee

