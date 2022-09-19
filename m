Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA28ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 18:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiISSSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 14:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiISSSU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 14:18:20 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7AB46201
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 11:18:19 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id ay9so144116qtb.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 11:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pSrVMgAekOHikBaugh5rSTC1wopWr70yo5xx1rQmjbs=;
        b=fSifonRZe9SPC1ZiTUHmhVJFj5ezeD+dklgZcFl6O5hgM1GAOGcAWbkxW4an7XcFxJ
         GPvkorl/MOTTYZHVue5RjoTPEBq0j4j0efjvea81gFtMK+TEikhBXWAIE82ONhTmQ6c5
         TJGHUDF+HJbH58Ouzz5PxF7QJ6r4hwpKXLAzjv73TuutRcYG9ij5X387UYs0f7z13ck5
         hryAkvOY6qEJ/mtqNB2+1N3+0LP3rhJUMj0oSOqWQTk98OQ4XeHeiOSHd9WPbD5tALMc
         Q1LmxcLhN+ApbG94zBQnchTqCeNURS89moIbz+qTcLnYifo8Ov1aKKHwmcpN5JIYNWF4
         ID6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pSrVMgAekOHikBaugh5rSTC1wopWr70yo5xx1rQmjbs=;
        b=xRvr9BrsDrXvQHRf1NeowgkTl/XBFRmJhCY2tnSZrS+anFrlDWdQVHO80DTkQa1PZ0
         BzeXo4TCMEMVeDShcPjy7Z8psw5OvipR9II6k+CXU7F1SVwlSYywYafUeso4lpWvrQwq
         WaCwe5yK1QCrCSv9Q4WGyTG6MApFU4Z3a4/KFOJVccXDqXFRfMh4NPebacUhgubpkEYv
         tNipln9s1SeYobFhblKcakMdFfqE6C5bDIBKPu38XlakaL+XxWzJov6WQwL9ifvVi47k
         S38RC2l5rKwgHhDJCRYk7mwM2qCmDAmacMpmBTodWgIR5DYAgmApMNzmbDv/glgFE7P0
         G1pg==
X-Gm-Message-State: ACrzQf2Qmr1Iu10AKFPoKlMz/tO32TYdaKleUvj2NEfU/amXf67U14WO
        DdFJk94NV0DvcauvWBI/wXHN
X-Google-Smtp-Source: AMsMyM68Mj6ZPBtkxGoD2LDAMlxXE4ijEBMrwKl4PGNQ8YDxt9F2HbCTThhfurd3oHRqgeosPcplHA==
X-Received: by 2002:a05:622a:1909:b0:344:9f41:9477 with SMTP id w9-20020a05622a190900b003449f419477mr15994021qtc.619.1663611498654;
        Mon, 19 Sep 2022 11:18:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fd97:43ff:6c00:2cf8? ([2600:1700:e72:80a0:fd97:43ff:6c00:2cf8])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a0c5000b006bbe7ded98csm13123565qki.112.2022.09.19.11.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 11:18:18 -0700 (PDT)
Message-ID: <97a8eb90-06c2-f79e-fc9b-940ae89b88af@github.com>
Date:   Mon, 19 Sep 2022 14:18:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/5] [RFC] introduce Roaring bitmaps to Git
Content-Language: en-US
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2022 1:47 PM, Abhradeep Chakraborty via GitGitGadget wrote:
> Git currently uses ewah bitmaps ( which are based on run-length encoding) to
> compress bitmaps. Ewah bitmaps stores bitmaps in the form of run-length
> words i.e. instead of storing each and every bit, it tries to find
> consecutive bits (having same value) and replace them with the value bit and
> the range upto which the bit is present. It is simple and efficient. But one
> downside of this approach is that we have to decompress the whole bitmap in
> order to find the bit of a certain position.
> 
> For small (or medium sized) bitmaps, this is not an issue. But it can be an
> issue for large (or extra large) bitmaps. In that case roaring bitmaps are
> generally more efficient[1] than ewah itself. Some benchmarks suggests that
> roaring bitmaps give more performance benefits than ewah or any other
> similar compression technique.
> 
> This patch series is currently in RFC state and it aims to let Git use
> roaring bitmaps. As this is an RFC patch series (for now), the code are not
> fully accurate (i.e. some tests are failing). But it is backward-compatible
> (tests related to ewah bitmaps are passing). Some commit messages might need
> more explanation and some commits may need a split (specially the one that
> implement writing roaring bitmaps). Overall, the structure and code are near
> to ready to make the series a formal patch series.
> 
> I am submitting it as an RFC (after discussions with mentors) because the
> GSoC coding period is about to end. I will continue to work on the patch
> series.

I look forward to your next version. I hope to see some information about
the performance characteristics across the two versions. Specifically:

1. How do various test in t/perf/ change between the two formats?
2. For certain test repos (git/git, torvalds/linux, etc.) how much does
   the .bitmap file change in size across the formats?
 
>  Makefile                   |     3 +
>  bitmap.c                   |   225 +
>  bitmap.h                   |    33 +
...
>  ewah/bitmap.c              |    61 +-
>  ewah/ewok.h                |    37 +-
...
>  roaring/roaring.c          | 20047 +++++++++++++++++++++++++++++++++++
>  roaring/roaring.h          |  1028 ++

I wonder if there is value in modifying the structure of these files
into a bitmap/ directory and then perhaps ewah/ and roaring/ within
each? Just a thought.

Thanks,
-Stolee

