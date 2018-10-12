Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D89B1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 17:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJMBOm (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 21:14:42 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:40688 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMBOl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 21:14:41 -0400
Received: by mail-qt1-f173.google.com with SMTP id b4-v6so14680501qtc.7
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 10:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=39f6ASdbCwHimSvDNjlFyoDhzkHHFcTIXDaMhX+zZ6Q=;
        b=rCDxTStBEPLR/mFLCQwML+HaejqWEKaHNJ6ZM9VP6OzyXFiCmHqlFfdbsbwrH0tYRc
         JmMHsttYl2TJW+6GMi0GpNzwsWAgrPwCA2knQsETN2LsbgpvL9sPZhBNebgshz7KN+8B
         S0OXvFN+8CnE7AZ6WMAIJznF8M54dCNUGsJPXfcMFZAPHoy9UswpmVohTCdV/v/ZWuaw
         Yf+gdg4e+BaJQZftPgOAcdpCz8szBL+FLSVWOyxkUKAtAdD5NnsKbY3MDfHRR9lwqKU2
         c8QWz+zhyk+K7/K9sjySganMOaS9wEN4zyLOazywduEvs2trhvu8ZcgemGeHoNHuQvVB
         6LxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=39f6ASdbCwHimSvDNjlFyoDhzkHHFcTIXDaMhX+zZ6Q=;
        b=T12uVBqsGhz6R9CY2HOv9JVxCRUcyNizLx66uF2+YfD2lhI4zCCY7E2JkUWcm272BT
         6f9F+rVZNIN+WTfV6fXHxZzopQK53RG8i9dOnZNp0IAlGb7wzzWkE7I/YCjQRZRiwuf4
         NXGosSv3Xa2JQMXIdJAnsZxqZi4F5/R9N/15BgQDenyRgfrlUXKQoisqWH9ZASJXpgBN
         zvmvHY83G+4yVCrvgrDu6JvpljtL6HL3kQj2sD3mIkmb5Hp7iIoTMnVn29PZVGfJVyqJ
         Qhtgs19MbeL3uPtYWirNoP3rOUPhu1Op+BPWrdu2FbcogrAifbQ3y+sMUXmjglc2fKEI
         gO8w==
X-Gm-Message-State: ABuFfogMmcx4XNXgtH1I/vmIEUoD2FNd74OLgrzs6mU+qFZxgi6B8AX2
        2k8W52oDjTdNXdFEmonRQXk=
X-Google-Smtp-Source: ACcGV63h4UdCeY4X6DdcsPXX/Gq0G+ghwrUDhJgI+Thy7pG/vPt2YaUJUVIqwfqfSe3q0+3oQW7xJw==
X-Received: by 2002:a0c:f708:: with SMTP id w8mr154850qvn.187.1539366065325;
        Fri, 12 Oct 2018 10:41:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:e9ec:1ddb:856c:2858? ([2001:4898:8010:0:d322:1ddb:856c:2858])
        by smtp.gmail.com with ESMTPSA id y124-v6sm936239qke.22.2018.10.12.10.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 10:41:04 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Add GIT_TEST_MULTI_PACK_INDEX environment variable
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.27.git.gitgitgadget@gmail.com>
 <pull.27.v2.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <38aff549-9582-9879-9b3d-81cf5b1c3e24@gmail.com>
Date:   Fri, 12 Oct 2018 13:41:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <pull.27.v2.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2018 1:34 PM, Derrick Stolee via GitGitGadget wrote:
> To increase coverage of the multi-pack-index feature, add a
> GIT_TEST_MULTI_PACK_INDEX environment variable similar to other GIT_TEST_*
> variables.
>
> After creating the environment variable and running the test suite with it
> enabled, I found a few bugs in the multi-pack-index implementation. These
> are handled by the first two patches.
>
> I have set up a CI build on Azure Pipelines [1] that runs the test suite
> with a few optional features enabled, including GIT_TEST_MULTI_PACK_INDEX
> and GIT_TEST_COMMIT_GRAPH. I'll use this to watch the features and ensure
> they work well with the rest of the ongoing work. Eventually, we can add
> these variables to the Travis CI scripts.
>
> [1] https://git.visualstudio.com/git/_build?definitionId=4
>
> Derrick Stolee (3):
>    midx: fix broken free() in close_midx()
>    midx: close multi-pack-index on repack
>    multi-pack-index: define GIT_TEST_MULTI_PACK_INDEX
>
>   builtin/repack.c            |  7 +++++--
>   midx.c                      | 26 ++++++++++++++++++++------
>   midx.h                      |  6 +++++-
>   t/README                    |  4 ++++
>   t/t5310-pack-bitmaps.sh     |  1 +
>   t/t5319-multi-pack-index.sh |  2 +-
>   t/t9300-fast-import.sh      |  2 +-
>   7 files changed, 37 insertions(+), 11 deletions(-)
>
>
> base-commit: 5a0cc8aca797dbd7d2be3b67458ff880ed45cddf
I should explicitly mention that this base commit is different as 
otherwise I will conflict with ds/multi-pack-verify with the new 
prototype in midx.h.

Thanks,
-Stolee
