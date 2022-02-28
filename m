Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66115C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 13:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiB1N5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 08:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiB1N53 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 08:57:29 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A6F7D000
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:56:51 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 12so13194841oix.12
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=NTMWSlzoaNbOa1Iy0p1ciMiaySWnwEMZyNGuuBppsuU=;
        b=drsSPVP5pi5QHnHmDWrqt4wKjqdsBH1tLPsIh8p+fZO1weNJahxRI+P89dhaMOdBHB
         LVAzelrABcsmG3UFGbDvWQ3XvuZCj72eN26e8Pd9ECz4QKZO8qocjTdFn6GpKSTUJCuk
         cNWc8kjC2GS2Sm9ZRJAmJd8jv870E8tvuJyjA94XmoPbGM4BqqyvMDaWG9hJuhLghBHt
         N9QOXk7kKutXzWn50349cgHFmjrNFriNyWNzhUSMtimiJVDnmLdeMZXI9JJp8Ua7k06m
         He6KiPp3etVxaWZAAcO4PLQmu/o+fzi9C7MF/X0sSa8Ouj1UesuM/bm4TaR4GDD52try
         NS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NTMWSlzoaNbOa1Iy0p1ciMiaySWnwEMZyNGuuBppsuU=;
        b=QRUvqJgP4QrwA38t7XuOsom+zxTUUDAIvQz8WEcXf0u4y6MMuxurO/gZZOFnzfWfyX
         sQ+INQ5lItelGRMDzfY+X1ZUMlKsUzNmH/mVgastnDNJJWk7YgKz+r0mbK0dUjbOvn0t
         3F1GogjmyMlW/drNMckOVwfK1Ogy6+kPBAClt5qrIP7m71rCg8fFPSvNrMCQgI9sm9R8
         wsS+w8KUGtjsCb2oGSs+ItWNrOCiXs15p8wxvY+o+rblhyAkk3wQ2VYU3J0LqItjfXYI
         HEDKECa01Pbiewvg0qYkb6Ib3WQGOf68u2DoSclhnbpzUkcZXyj8lU6Lb2g8ievPJSK3
         JmmQ==
X-Gm-Message-State: AOAM533oYmcvW8upfl1p6rwmXcLRC9bXjLYFNFa4NIA2Dri7ehfKOY1J
        gZCV1Ipf1fLJRhGm0F1imN6DpTzV5yzn
X-Google-Smtp-Source: ABdhPJwMO8p1immmykj1HNWkbWRZ2EcTe1Q23RnOFKL/rEXTA8A9/DWPD20BOH8ZsuU+BtHWS6Yi3A==
X-Received: by 2002:aca:4102:0:b0:2ce:24c9:5cbb with SMTP id o2-20020aca4102000000b002ce24c95cbbmr8794887oia.70.1646056610612;
        Mon, 28 Feb 2022 05:56:50 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e25-20020a544f19000000b002d53ce2f979sm6025206oiy.38.2022.02.28.05.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 05:56:50 -0800 (PST)
Message-ID: <e84c6370-d41a-8c79-8b4a-c50610f3f240@github.com>
Date:   Mon, 28 Feb 2022 08:56:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: ds/commit-graph-gen-v2-fixes (was Re: What's cooking in git.git (Feb
 2022, #07; Fri, 25))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqee3q73e1.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqee3q73e1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/25/2022 9:44 PM, Junio C Hamano wrote:

> * ds/commit-graph-gen-v2-fixes (2022-02-24) 7 commits
>  - commit-graph: write file format v2
>  - commit-graph: parse file format v2
>  - commit-graph: document file format v2
>  - commit-graph: fix generation number v2 overflow values
>  - commit-graph: start parsing generation v2 (again)
>  - commit-graph: fix ordering bug in generation numbers
>  - test-read-graph: include extra post-parse info
> 
>  Fixes to the way generation number v2 in the commit-graph files are
>  (not) handled, and introduce a newer file format to store the same
>  information in a way that is more efficient to access.
> 
>  Expecting a reroll.
>  source: <pull.1163.git.1645735117.gitgitgadget@gmail.com>

I just sent v2 [1] which drops the generation number v3 patches
and does some light updates to the first four patches.

The description should then be modified to remove the new format:

>  Fixes to the way generation number v2 in the commit-graph files are
>  (not) handled.

I'll delay generation number v3 until these are finalized.

[1] https://lore.kernel.org/git/pull.1163.v2.git.1646056423.gitgitgadget@gmail.com/

Thanks,
-Stolee
