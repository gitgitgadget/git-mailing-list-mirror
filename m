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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB041F462
	for <e@80x24.org>; Fri, 31 May 2019 17:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfEaRvv (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 13:51:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35427 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfEaRvu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 13:51:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so1939764qto.2
        for <git@vger.kernel.org>; Fri, 31 May 2019 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w9wwBVodmf09kQXZA6fnwtoLXkeOlNxabxSqn6a+H8g=;
        b=Hpx3hYT4uisARAQ/mCSaHb5lme1pxcooYODI5eyjcEOMWfKWWcvQUp9PRLJ7eLpYxb
         xlK1xu+vMZ6XpTxjGE8r/XfPhOCEwWQAVn7fnNkBfuVuan9rNo3Qb7OJvysKgtZ1E7Ao
         oaOS9D+JdoLGsKi2fdBISD8QnTe3StIFqabeDq73932DqzJU/Nh5M7+CYV5BS4h/uTaB
         1X+SHi+S+hFDRKR2JKTkdolxtsAJPQzV6qQwBZqmWZznkgBjGHdurr1m7Vx/IWmCFiL0
         5+KDG6lpn9R5nzITf1owgpu7g6rM7Qx17i7jZv0fdxzxaWMIAyZWEK3ucIeRrddSo10I
         2LoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w9wwBVodmf09kQXZA6fnwtoLXkeOlNxabxSqn6a+H8g=;
        b=Xh7rPC5ZzcjNkHvwhw9RJI1fnlSoPK4FujRfHTJ9RwdApJ1xOKMTO6xWsxw8OySV1f
         2nMO0Q7tSMSHdVIQzXRJRHCjPek+VrbwwLyxtzlDm8Y3bXyGP50hx1WSgj4omqIadurF
         gN7NXm2U/1Xvh9uCc0ZXWcC3sFE2dRmH5L8UthdPzwlpgYGglP4YfYkBoCfZ0ZMjsDIj
         J1pvk0cSs4+hFC+2zF0VEhv9Wg0vImj71fwdWj4HTu2gvOy8eM9N9cUgln0LIoBiQ3fP
         uuXzjHxkN9hH0v4vnuKhlAQa83gSykvgBY/P4iiBAeWb62+KFJKd24/0UPfkH4jwvaMd
         Rg7g==
X-Gm-Message-State: APjAAAWMz72wKT/nucMaRW6XiCb7PqzhoKJDHVNJ4WT3hWs1XIjGRUtm
        N/jCrJViY5ZmDHfN9i7FhR0=
X-Google-Smtp-Source: APXvYqyY/wrzRpAE6IYSAdUNaxhpZ6rSTppISBYD8be1fbgSie9Bja0+xyacRbPHrvFlK8feQwgrdQ==
X-Received: by 2002:aed:3a45:: with SMTP id n63mr10229261qte.109.1559325109718;
        Fri, 31 May 2019 10:51:49 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id n10sm1070604qke.72.2019.05.31.10.51.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 10:51:48 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Thursday, May 30th)
From:   Derrick Stolee <stolee@gmail.com>
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Barret Rhoden <brho@google.com>, michael@platin.gs,
        Jonathan Tan <jonathantanmy@google.com>
References: <2fb43bd3-71a7-fd92-e9b8-43e4eeed34cd@gmail.com>
 <e18e4391-a574-1f4b-88c7-890ada116f51@gmail.com>
Message-ID: <0d7dbfe6-53df-1df8-ac94-4dfab85bbc9f@gmail.com>
Date:   Fri, 31 May 2019 13:51:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <e18e4391-a574-1f4b-88c7-890ada116f51@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/30/2019 2:24 PM, Derrick Stolee wrote:
> Further, these tests failed
>
> t3400-rebase.sh                           (Wstat: 256 Tests: 28 Failed: 2)
>   Failed tests:  20, 28
>   Non-zero exit status: 1
> t3420-rebase-autostash.sh                 (Wstat: 256 Tests: 38 Failed: 6)
>   Failed tests:  6, 13, 16, 23, 26, 33
>   Non-zero exit status: 1
> t3404-rebase-interactive.sh               (Wstat: 256 Tests: 110 Failed: 5)
>   Failed tests:  3, 9-10, 100-101
>   Non-zero exit status: 1
> t5521-pull-options.sh                     (Wstat: 256 Tests: 19 Failed: 1)
>   Failed test:  3
>   Non-zero exit status: 1
> t5551-http-fetch-smart.sh                 (Wstat: 256 Tests: 37 Failed: 1)
>   Failed test:  26
>   Non-zero exit status: 1
> 
> They don't fail locally, so perhaps we shouldn't blindly trust the coverage data
> until I work out why these errors occurred. (Many of the cases I called out
> above I couldn't hit locally with a die() statement.)

These tests all failed during the second run that set optional GIT_TEST
environment variables. Specifically, GIT_TEST_REBASE_USE_BUILTIN=false
caused these tests to break. We now output this message:

	warning: the rebase.useBuiltin support has been removed!
	See its entry in 'git help config' for details.

I'm removing that variable from the build definition.

Thanks,
-Stolee
