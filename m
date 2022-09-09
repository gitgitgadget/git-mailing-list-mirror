Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B15BECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 12:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiIIMY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 08:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiIIMYG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 08:24:06 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9774BA7F
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 05:23:31 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d68so1238110iof.11
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3HvpcShYMG3y4iC6k/UvI6yAvRr+cAMP48yovpPji4M=;
        b=eGvBXWyLZVtQujWiumYUDIlNrA6YhvBbTe9LQNfbyHGeT7cfXLN+s/BV++tBNbNzZI
         pt/R0SkdAFSwJ3LJ8k+CjxQLtMSrfLyAfsaAc9pTSNzfghidWVGgh1lPryIDKf/Ti0OZ
         19NYi5NbPzS29Cme1APCY0jAhFVRQ/CRocuDvmuSK7JXGVwLWpJl3oqCOZ6HgNOEeJjY
         0gKt2qC5vRGmKMeuKFOOPtGQ3LlCUn69PdEDcoDfrN8A/Jo4MUe6D2eE9G6bm5e6XKXi
         HcAv2tYzfDZZuloOwb2Jg5iS9tdOJIru8vu2HJLABpU3QWXQ0BBUCxt2KUG28yhjBQk+
         pRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3HvpcShYMG3y4iC6k/UvI6yAvRr+cAMP48yovpPji4M=;
        b=7QZMSKIJazoOpuBJuVtr0RNvNNH4jYF9vjvG6xbpZRY3/UTB2BzxBQur7ahIs/TxJQ
         skEP01Kwd/KOoyibmdGRyoRUGziVGp4mX+oywkDwygOsEqPx8rXrfNPbeh6Zt0Z5cJuZ
         9iVyMbKIStUx9zNAVyGNNf6UH/1/yBNIjKGZcoAPGad9P5OrRxWWlPcSAMugMBc6mrq6
         cKClNyZKTmmWFTbjhMs/YoIWMB0dvfyf9BhELmm91LqQZyrmAOJ7SlLzsHXzRn2EZ3K6
         jzuCzigbjWStxuUL1GooiVO3LSIaDaLDGzEF8XfoSvjFTE410I08aI7ax8Zkhkq1MO1F
         /gkg==
X-Gm-Message-State: ACgBeo08eaQIrG7QhtRPxESVQDlb9m4VCGK3pwfIBegYJb9P64BAV8oj
        D41ebpwnCWffhD6F3uGMT+eu
X-Google-Smtp-Source: AA6agR700Y3ee2wcAwU0Ijb5utY2QA+jySyPHjzXwrKkAVwiKbsVeAhUWK7EpiNxHhL6V8oF5HYuiw==
X-Received: by 2002:a02:3f20:0:b0:342:c96d:2f8 with SMTP id d32-20020a023f20000000b00342c96d02f8mr7482025jaa.74.1662726211275;
        Fri, 09 Sep 2022 05:23:31 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z9-20020a056602080900b006889ea7be7bsm186035iow.29.2022.09.09.05.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 05:23:30 -0700 (PDT)
Message-ID: <42db9da3-3f69-1bf0-6d88-692e18eb74c1@github.com>
Date:   Fri, 9 Sep 2022 08:23:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 07/11] log: add default decoration filter
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
 <c249bface2a6dcd0355620f92579b42a6fa4ea58.1659722324.git.gitgitgadget@gmail.com>
 <kl6lr10l8t7y.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <kl6lr10l8t7y.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/2022 5:13 PM, Glen Choo wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> When a user runs 'git log', they expect a certain set of helpful
>> decorations. This includes:
>>
>> * The HEAD ref
>> * Branches (refs/heads/)
>> * Stashes (refs/stash)
>> * Tags (refs/tags/)
>> * Remote branches (refs/remotes/)
>> * Replace refs (refs/replace/ or $GIT_REPLACE_REF_BASE)
>>
>> Each of these namespaces was selected due to existing test cases that
>> verify these namespaces appear in the decorations. In particular,
>> stashes and replace refs can have custom colors from the
>> color.decorate.<slot> config option.
> 
> I _just_ noticed that refs/bisect/* isn't part of this list, but I'd
> presume that users want to see those decorations (or I do, at least).
> Was that an intentional omission?

It was an intentional omission because the refs/bisect/* references
are not part of the color.decorate.<slot> category.

Looking into it further, the bisect refs look pretty ugly (especially
the ones like "refs/bisect/good-<hash>").

If you would like to include these in the default filter, then I
would recommend also adding a color.decorate.<slot> category for them
and possibly replace the "refs/bisect" with just "bisect". Alternatively,
you could take a hint from replace objects and just use an indicator
like "bisect good" or "bisect bad" instead of listing the full ref name.

Thanks,
-Stolee
