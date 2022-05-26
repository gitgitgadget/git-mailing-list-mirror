Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CD1C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 16:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbiEZQCd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 12:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiEZQCb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 12:02:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB995FA3
        for <git@vger.kernel.org>; Thu, 26 May 2022 09:02:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso2052324pjb.3
        for <git@vger.kernel.org>; Thu, 26 May 2022 09:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=omEq7OMbl6CKshq7RIeHmLBGO7PLf3JRaj++vyGlgSw=;
        b=OToQ/lbhpZ4lovstWflFba/GmKQukd57Ehj0lqkpPa3zGukhdZefOWhWlTuNvEnYsy
         NtmqfryWcHFzdtwnyLssANAdJxFsx87eFVNWV9uSd8qw2frSn1x50hxMP1cyxH9FeoOu
         7BN17er4A9ByLUG3aVZme9mmB+gC0hWmxD1ubKfq6fn4q34McjbleJhHnUyri821J3Ao
         74sPUaHOzj6fr9qKH2EcQ8kiygP26ZAYLLmgPkgMs3U1pL8049SUVErxkyEoFbAIVu26
         4j5jXyYs1eJ4/JVpTS9yeeWgyvrxVnlDxxVGpnQrvgo7vjVukiVShsn+BIDgSWYejyVN
         zERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=omEq7OMbl6CKshq7RIeHmLBGO7PLf3JRaj++vyGlgSw=;
        b=1y84OYHxKnssqBovM2hKmy8r2KG813FnSGbicUqWII/3HBbNKBlwdcDkWmY6USxZ2x
         gJBcTzONahHYzZT7OMAuCtzrNkCFwYdSasNgC7uc8MMdW847JO/vPAobEzwiat2OeXMc
         aroChFCoeSntZKNQ6tib8xCsepljP1vtrJkqf68puQO8IZt7ssSNxUUmFDTlC3sFESod
         rJySVOixhH3cFdg2VGUqdtRKpUE+3AKoa+sqApZO1ehIQXoo2EYMPgq15LCG6c7W1QFg
         Rm5QCjIzUtWzng3/7lBe9Om8FzUTBO+MNM0jhl8WM4vUA9I/HWkvQHKVkJ1t7uwC/bIO
         k7kw==
X-Gm-Message-State: AOAM532kfkD/h0W13SiJaQuveLaDIxalOOUlnSCGiA8a1R6vy8cFy5jd
        08lMDm9e6uKZjMI+fwqkRzIe
X-Google-Smtp-Source: ABdhPJz7wYnDZR/9GfMNFj0omb5Gakb6VGl3foDQ2i7Yac4lrgCw6OzEvhTShN27v1HxPoLKcD0r2Q==
X-Received: by 2002:a17:90b:4f8e:b0:1e0:2916:daae with SMTP id qe14-20020a17090b4f8e00b001e02916daaemr3371171pjb.140.1653580949598;
        Thu, 26 May 2022 09:02:29 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id o13-20020a170903210d00b0015e8d4eb213sm1724233ple.93.2022.05.26.09.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 09:02:29 -0700 (PDT)
Message-ID: <df44b0cd-bba7-19f0-4e45-c0988239cc4d@github.com>
Date:   Thu, 26 May 2022 09:02:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: What's cooking in git.git (May 2022, #07; Wed, 25)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqqzgj41ya2.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqzgj41ya2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * js/ci-github-workflow-markup (2022-05-21) 12 commits
>  - ci: call `finalize_test_case_output` a little later
>  - ci(github): mention where the full logs can be found
>  - ci: use `--github-workflow-markup` in the GitHub workflow
>  - ci(github): avoid printing test case preamble twice
>  - ci(github): skip the logs of the successful test cases
>  - ci: optionally mark up output in the GitHub workflow
>  - ci/run-build-and-tests: add some structure to the GitHub workflow output
>  - ci: make it easier to find failed tests' logs in the GitHub workflow
>  - ci/run-build-and-tests: take a more high-level view
>  - test(junit): avoid line feeds in XML attributes
>  - tests: refactor --write-junit-xml code
>  - ci: fix code style
> 
>  Update the GitHub workflow support to make it quicker to get to the
>  failing test.
> 
>  Will merge to 'next'?
>  source: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
> 

The latest version of this nicely addressed the feedback I originally had,
particularly in improving page loading time. It's still slower than before
this series, but IMO it's manageable (especially taking into account the
improved information accessibility). 

I don't see (or have) any other unaddressed concerns, so I'm in favor of
moving it to 'next'.

> * ds/sparse-sparse-checkout (2022-05-23) 10 commits
>  - sparse-checkout: integrate with sparse index
>  - p2000: add test for 'git sparse-checkout [add|set]'
>  - sparse-index: complete partial expansion
>  - sparse-index: partially expand directories
>  - sparse-checkout: --no-sparse-index needs a full index
>  - cache-tree: implement cache_tree_find_path()
>  - sparse-index: introduce partially-sparse indexes
>  - sparse-index: create expand_index()
>  - t1092: stress test 'git sparse-checkout set'
>  - t1092: refactor 'sparse-index contents' test
> 
>  "sparse-checkout" learns to work well with the sparse-index
>  feature.
> 
>  Will merge to 'next'?
>  source: <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
> 

Likewise here - V2 handled all of my nits, and V3 made some helpful
improvements to variable naming & documentation. There's nothing else I'm
waiting for on this, so I'd be happy to see it merge to 'next'.
