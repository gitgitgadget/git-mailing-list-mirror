Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C23C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 02:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbiBUC0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 21:26:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiBUC0y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 21:26:54 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422010A5
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 18:26:31 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id j2so9419125oie.7
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 18:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6vHPNbaf38Wpn6/+mKQO9tKKWKBXHid52baNdvrZuxE=;
        b=EdfaUtC/fXnZvzlqXmG6TAXSCsxEIG9dcS57xxaMGKM99ZbS1uFGV9UnED698zEr+j
         N25DYxlk0QqWyJfQMHEiWIWVkx/vZ+HGaQgA7uKMYkzwfo2sY1AWMimY6tMM+r+CFDJT
         m/lDPZ4NcAYK0HEppw6z7eoxl47pm6gnre5+H5gQ/loVGN7iPKj3bS4tERsuIzFYPBTN
         j4l6EkYq/oetVy+t+oJx9HaY8CiC1gYuJKkdStDQ5NBjizGDGMNeFAA8PD3fwFrFveal
         uauiteAKtTbRi32i+657Xdtc5ZO7kEvE43wfbF6V9QYXqm4r/RZscN2OGVhsan7uUVab
         Kzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6vHPNbaf38Wpn6/+mKQO9tKKWKBXHid52baNdvrZuxE=;
        b=o91EUbX1ks3nBRVPM/QyOjg7NQP1Yh0izPRSRlLYb8egkzq33/FpMrRp8y5bgdnTYP
         wtR6DXvkxNvJEGi73xmMF2yRjjXd1h1MbMCSp6JyzmS8pVkPxEe+x8KpzrXVQRZyV9CX
         Ou1vwAOx0yvMvgWRVppnEbPCPhy8WE4N5RoxMHqfiB0czqglft6rf+7RlP3d8HUeS1h2
         6u1WyOTljd3Pk8suTqvpu0YobcrYxjRGj5uRauJAp0qqSg9R4VH0wNhCbla6Sm428LRp
         +6etXvlkVucl9ANq0ehpVNSTZoOMefs4eOTWEwZIROfnP66lASBIQ0XiaivnFnyynyh1
         l4Vw==
X-Gm-Message-State: AOAM533APRoTn6zAMtoN5a4VLkdSOQglA9ysRNuZbu7pXnyrd1K1GD4i
        44ZsGLmsPGx4cftIGYzvoIfY
X-Google-Smtp-Source: ABdhPJygJsx262zLOjqQKlbGFFrK9muGNaXtVN8faKmy+BxPmgeDwnfE+Jd3/d6f6TtmWy124BCkEw==
X-Received: by 2002:a05:6808:1693:b0:2d3:fe9d:504b with SMTP id bb19-20020a056808169300b002d3fe9d504bmr9688707oib.258.1645410390700;
        Sun, 20 Feb 2022 18:26:30 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s6sm24573840oap.32.2022.02.20.18.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 18:26:30 -0800 (PST)
Message-ID: <7e2b0963-708f-69a8-ffb1-a04762244612@github.com>
Date:   Sun, 20 Feb 2022 21:26:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 09/11] worktree: use 'worktree' over 'working tree'
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <23e74c87116175924bfc389eb07fa96b4040fa0d.1645379667.git.gitgitgadget@gmail.com>
 <YhLBVJ9guBF/9/A0@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YhLBVJ9guBF/9/A0@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/20/2022 5:31 PM, Taylor Blau wrote:
> On Sun, Feb 20, 2022 at 05:54:25PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
...
>> -In order to have configuration specific to working trees, you can turn
>> +In order to have configuration specific to worktrees, you can turn
> 
> Also not the fault of this patch, but I wonder if this would be more
> clearly worded as:
> 
>     In order to have worktree-specific configuration, you can [...].
> 

I like this change.

>>   - `core.worktree` should never be shared.
>>
>>   - `core.bare` should not be shared if the value is `core.bare=true`.
>>
>> - - `core.sparseCheckout` is recommended per working tree, unless you
>> -   are sure you always use sparse checkout for all working trees.
>> + - `core.sparseCheckout` is recommended per worktree, unless you are sure
>> +   you always use sparse checkout for all worktrees.
> 
> Another minor point, but perhaps the third bullet should share more
> language with the first two. Maybe instead:
> 
>     - `core.sparseCheckout` should not be shared, unless you are sure
>       you always use sparse checkout among all worktrees.

I thought I had a good reason to deviate here, but looking at it now I
agree with you.

Thanks,
-Stolee
