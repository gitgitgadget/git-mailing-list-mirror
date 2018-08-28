Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEFF51F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeH2B3k (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:29:40 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:41792 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeH2B3k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:29:40 -0400
Received: by mail-qk0-f194.google.com with SMTP id h138-v6so2052263qke.8
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=GUDWwk+3aDtOpfa2ONMQz6BdF53uDAwLTdYH5HLlLxI=;
        b=NyYzxiBOZkMQTzqm6i6TqI8mXHkwD31q6UIP/Dn4uFNaNTVRDKldxzLNtTProXmosQ
         16nxAXFRXlv2wZbOXN5anFOZ5JDc0pDsYikp4F7YtpLVJPZiw2gXw1LfkV/lmbjLQXod
         Ggv1VjkktKZnMzrN0MLpJgjLdVrQc3IdbVsmHG38KWTcZbsTsbhximwcosW+Dt+xzqmf
         DVdkCjQDrjKvsOzqrsJvXJPWNLM6OkKbIWZs0SQbEcdQ6QX9ba7BLM1hkjyvfIjG4ar+
         OBhpNKp5Rz0xXj05zdSIyDJzU0OvYKfMwIPnjZ2g078qM0uq98NpiSvIPHbGM3mtEZAu
         bTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GUDWwk+3aDtOpfa2ONMQz6BdF53uDAwLTdYH5HLlLxI=;
        b=P3Sc38nxoF1YOVzJKEmzVDn7/BjG6iwTo8vmPzamUSApGABcJ3JdIWPTFiJYQGQIX9
         7m7OJ4r8MPpbAUtyZnasMk+Tcss5AoTgF9AZNthKMyYD+IQPqorK7dowCIThC5BgfjMk
         ByMSeVKeAcL0V0sarPcLYfOx0PGOsewZ7RAoQZ9EBiE5iJUZ9guHDdOXSbJkvuIDwAoJ
         SxVeU0l7ywUyWQh2GcnFdp/curjpxJnnA0xx3OBv+NChmcz8bAKadUnwm/qFsH0N6dOW
         PDFonzt0sp9qyWQMlYjrv2ZzdFqDX/RfeS00DN3qzggp4ppAQaPj56/1FE0xLgJ+LWcq
         JPmA==
X-Gm-Message-State: APzg51DCpZc3xXfpdCDQmdLyKF+Vii5qfdfg0tCYoWEkz/roJT5c1MNy
        8alMoWCcbaCpUwrYWx+je2w=
X-Google-Smtp-Source: ANB0VdbxvbpGa9kE0FQPaBYUZ3n6Iskl3NVOr7zNT+aVkF7L052gwbwqhvc5BSauirQEnEcmnLFLLg==
X-Received: by 2002:ae9:eb8d:: with SMTP id b135-v6mr3649372qkg.123.1535492165982;
        Tue, 28 Aug 2018 14:36:05 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id b16-v6sm1354158qkj.76.2018.08.28.14.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 14:36:05 -0700 (PDT)
Subject: Re: [PATCH 0/9] introducing oideq()
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
References: <20180825080031.GA32139@sigill.intra.peff.net>
 <20180826205620.GC873448@genre.crustytoothpaste.net>
 <20180828212126.GA7039@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4a35886d-b1f5-6d5a-554e-508d838e542e@gmail.com>
Date:   Tue, 28 Aug 2018 17:36:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180828212126.GA7039@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2018 5:21 PM, Jeff King wrote:
> On Sun, Aug 26, 2018 at 08:56:21PM +0000, brian m. carlson wrote:
>
>>> Due to the simplicity of the current code and our inlining, the compiler
>>> can usually figure this out for now. So I wouldn't expect this patch to
>>> actually improve performance right away. But as that discussion shows,
>>> we are likely to take a performance hit as we move to more runtime
>>> determination of the_hash_algo parameters. Having these callers use the
>>> more strict form will potentially help us recover that.
>>>
>>> So in that sense we _could_ simply punt on this series until then (and
>>> it's certainly post-v2.19 material). But I think it's worth doing now,
>>> simply from a readability/annotation standpoint. IMHO the resulting code
>>> is more clear (though I've long since taught myself to read !foocmp() as
>>> equality).
>> I would quite like to see this series picked up for v2.20.  If we want
>> to minimize performance regressions with the SHA-256 work, I think it's
>> important.
> Thanks. One of the things I was worried about was causing unnecessary
> conflicts with existing topics, including your work. But if everybody is
> on board, I'd be happy to see this go in early in the next release cycle
> (the longer we wait, the more annoying conflicts Junio has to resolve).

I'm happy to take this change whenever. In my opinion, right after 
v2.19.0 is cut would be a great time to merge it into master.

This v2 is good.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

