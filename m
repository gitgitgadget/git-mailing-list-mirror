Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30BA1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 12:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934390AbeF1MtH (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 08:49:07 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:40014 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932653AbeF1MtE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 08:49:04 -0400
Received: by mail-qt0-f182.google.com with SMTP id s47-v6so4546602qth.7
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 05:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=DGckHzRWRjnRnRI5UWF4W0sFwCgIgVLFRJ0unwqo/Qk=;
        b=qEqIsgbb+ngaPlyEceKgHEi5mEvU513dOP8PpuubbAz0m38Y/SXiV3DcYh4dZG4o3h
         x41moZsiA3TPW7oLZcLggFM6oH70vDJMcsTWihjPxCYXrh30XZKZjvhU7PHUZ8U6IXjf
         A5jBOPeD/gSUSDdk7CRdRc43qnuyZt//Z5yhnFEGDr6esIQnFCUDOzSHYOL1UVAePPiM
         LhGs+O4pc8/+NlJHC859ow1i8cLYepcbkYbklQR5cg2tUwIUsX+Qr6kPEIlSU3kL1Xco
         eeCFdyrhDDV+wulyBSoTbWxZNSZpC4Vvnh1/rj8u1kYbTrTkMqP1l3QX1iPffcscfwBM
         q7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DGckHzRWRjnRnRI5UWF4W0sFwCgIgVLFRJ0unwqo/Qk=;
        b=FDWSqpEVNKs61i1xYAA0BTVyW5HzhE2fsbbtYCgBvj4B5EHcNEEePM3E6LpevooEon
         Jjn/Y8+g8HupyJ494TKFbSrwKHTLGzb56MogjrAwETXIOekk+MCe9zG+PNAe8gysCMdc
         9SxDrwjaM7dDFhvEgvC/zvSo6mKZhUaxETEUl7Vkz9GGgRWJUc+U24/uo8qQ/X0Ht3j7
         fl0aTE2wC2eBrC0ZCL6sGfmRYaBZjDbTjvFYjNiLzooEouOZqFW/iHeFpLQnqNrp/MXK
         do3/myJxbRkJSS8XnIrLrtKrXtxtyMZMDjV4a+hn0qPItllX/Hv1LcRIIGD0Xa3sKVxA
         Hjfg==
X-Gm-Message-State: APt69E31RGWWzvQrZEn1ndL7D/CctDSqFKZihdY5LJ33ODFupi5V+83g
        hJgd5Gk8GJ/kOWgHRcbkjBbwuqxE
X-Google-Smtp-Source: AAOMgpepp500s9AiCd1xctpIgXxik+8+d+on8VZK4O4046RWubjq9fYh86MjlRnRA1ikJ4ZTq1SV1g==
X-Received: by 2002:ac8:3134:: with SMTP id g49-v6mr5967584qtb.55.1530190143158;
        Thu, 28 Jun 2018 05:49:03 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:fd7e:6eb7:d52f:5988? ([2001:4898:8010:0:e6b4:6eb7:d52f:5988])
        by smtp.gmail.com with ESMTPSA id u41-v6sm5212209qte.93.2018.06.28.05.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 05:49:02 -0700 (PDT)
Subject: Re: Inconsistencies in commit-graph technical docs.
To:     Grant Welch <gwelch925@gmail.com>, git@vger.kernel.org
References: <CAMYKhtUi3nCmTjZ8pXbNCxaKa6h9+1OSD7YitTeip+807w7dJA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c48629f1-7b41-d516-84f5-c07ef7881e03@gmail.com>
Date:   Thu, 28 Jun 2018 08:49:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMYKhtUi3nCmTjZ8pXbNCxaKa6h9+1OSD7YitTeip+807w7dJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2018 1:11 AM, Grant Welch wrote:
> I recently read the "Supercharging the Git Commit Graph blog by
> Derrick Stolee. I found the article interesting and wanted to verify
> the performance numbers for myself. Then that led me to want to know
> more about the implementation, so I read the technical design notes in
> commit-graph.txt, and then I jumped into the format documentation in
> commit-graph-format.txt.
>
> Along the way, I noticed a few issues. They might just be errors in
> the documentation, but I figured it was worth documenting my entire
> process just to be sure.
>
> "Supercharging the Git Commit Graph", by Derrick Stolee:
>    https://blogs.msdn.microsoft.com/devops/2018/06/25/supercharging-the-git-commit-graph/
>
> # TL;DR
>
> I found a few discrepencies between the documentation in
> commit-graph-format.txt and the results that I observed for myself.
>
> 1. The "Commit Data" chunk signature is documented to be 'CGET', but
> it should be 'CDAT'.
>
> commit-graph.c:18
>    #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */

Thanks for catching this! Thankfully, this is an easy fix, as we only 
need to update the documentation.

> 2. The "no parent" value is documented to be 0xffffffff, but is
> actually 0x70000000.
>
> commit-graph.c:34
>    #define GRAPH_PARENT_NONE 0x70000000

This is a more important mistake, as it affects the data that was 
written in the commit-graph file.

Part of the problem is that leading hex digit of 0x7 which in binary is 
0b0111. We already designed a limit of at most 2^{31}-1 (~2.1 billion) 
commits in the commit-graph because of the way we track octopus edges, 
but this mistake has cost us more: we cannot store more than ~1.8 
billion commits.

I'm sorry for this mixup, mostly because it is aesthetically unpleasant. 
Those extra 300 million commits mean less to me than having a clean file 
format.

> 3. The "generation" field isn't set on any of the commits. (I don't
> know what to make of this.)

This is a difference between 2.18 and current 'master', which merged 
ds/generation-numbers. Commit-graphs written with Git 2.18 have all 
generation numbers listed as GENERATION_NUMBER_ZERO (0), which lets 
future versions know that the generation number is not computed yet, so 
the next commit-graph write will compute the correct generation number.

I'll send a patch soon fixing these doc issues.

Thanks,
-Stolee
