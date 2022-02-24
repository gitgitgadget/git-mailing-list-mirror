Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9388AC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiBXQIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiBXQIp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:08:45 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F55190C0E
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:07:54 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id v18so4305634qvh.11
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Rt9ZaX9VrExQHqPPLViKBktCt/4M1lIlCY7ROi5FgHU=;
        b=CVltGTE2zelmWrzkni0LUh9hke3MWynVuAdpNsOE91YoeQqV8F9FQ2nXoK3i4p8eBw
         dPGwWCzv6BCl5fdxdFfRvdyq20DyV6BuC19J3+TqdBU4qTY5rFqfvccFEyjDFRwjvjZx
         ZUp+pVgGocxNPEGEeo0NCVgxpZlAgF5b18dwCb9xmNsPP6nECTPyP7MQ7EcdvIEZ6XlS
         zPbduyaSMBWXb24hqir6R/odwG1UtNaOZMWYWqiHSFGvNmz9dznX21Xq/lWrxHWnexFV
         E32Nr+bLJo38UTtCutcGYZCX1gip1C4nUjuIo3jt48qj81DtmB8yTzhF7ObsZdGdwFyO
         0aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rt9ZaX9VrExQHqPPLViKBktCt/4M1lIlCY7ROi5FgHU=;
        b=YA7HLTj4MfCz8lPHJoqsmOX+cu2m6UyKpPTtLf/u7hOM8UdXGIJjgs5mxdj6s8q9sY
         csNitbgcvbLm/SoQmkxQBbvmvuWc2XAsb0yUUxMBovhJ4CaeUPlMWIls7StPVLIl/W1T
         GniJsVQ/oN8mm7cVIQ3ZmVU6/bf8N0WIXDhrSaU0Wn2sjF1hhRkMC/GUsT4sUv02pyRs
         huBelCFItXoOlQDtBkwPT4VwqwaRfCbTGvlWXf7zAUnfrz9sdST6ZFZ3x5amYHl/CgQ/
         09Ha0lWhheq0TCRwXUFezfBAB4dC6S2avg1t+fpkBs7ZL9DO0VR00aYu2bjMcGubn4aa
         jk2w==
X-Gm-Message-State: AOAM532RQ6KcBJGGrmAIBMYZXdy+Oyl5vLMNhS9kJa/izly0Bka+Cpl4
        JMA7BP6tIdgAoGU3X4BxbAGngpqe3oFr
X-Google-Smtp-Source: ABdhPJx/yNsf4Dps0KgWKRxWoIGp3TmnipKdBYLzeiURSKCr2w6TNxBdCweAIBxNcB6C1GcItIXgQQ==
X-Received: by 2002:a05:6214:2b0d:b0:431:dde8:af12 with SMTP id jx13-20020a0562142b0d00b00431dde8af12mr2505610qvb.123.1645718761253;
        Thu, 24 Feb 2022 08:06:01 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i20sm1710123qtr.38.2022.02.24.08.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 08:06:00 -0800 (PST)
Message-ID: <0367bce8-3744-5835-aa26-6c1f9f359fdb@github.com>
Date:   Thu, 24 Feb 2022 11:05:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 18/23] fsm-health-win32: add framework to monitor daemon
 health
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <a398cdb8a04228ff94e2f5467c010f4917b27042.1644940774.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <a398cdb8a04228ff94e2f5467c010f4917b27042.1644940774.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create framework in Win32 version of the "health" thread to
> periodically inspect the system and shutdown if warranted.

This specific step makes sense to not be included in the
previous step.

> +/*
> + * Every minute wake up and test our health.
> + */
> +#define WAIT_FREQ_MS (60 * 1000)
> +
> +enum interval_fn_ctx { CTX_INIT = 0, CTX_TERM, CTX_TIMER };

Please split out the values into their own lines.

Thanks,
-Stolee
