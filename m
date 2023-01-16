Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595C1C46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 15:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjAPPUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 10:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjAPPUE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 10:20:04 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DD8222D5
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 07:13:34 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id kt14so9912156ejc.3
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 07:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Po8spVwc4BW6GXFAGGf/sJ/NHVD7xfiFkZoZP9nQ3N0=;
        b=rQVRO9wgksHl1sLULQtpzpqI9WnhWfYUzGVCiY66hatPGPTPMbzizCzhv88wFZHlO1
         uaLMVAW30gF3mGzsdkUEpGfA389P0t0WGQ4Whuvqs/BJWNPhAUMQ9PXbiXh/JsXjQ2IX
         L5/yIyEOvuT9sd+971CuM+2JVzwWN74ySe/H6Ca5QNE1/f7/7+krd/Fu1E6+cJUx/IYx
         Ms+EE3nrBUliH57gKnMJIpKLzTe2SKBqVfubzpubnr4FjuwYhR1QZER1pH9exge9vP1W
         0Tv+RHXVJ56hVOMP+p272LW3tfqZeahIaXKCvIYIqQgXLAOPBmdBgLbyx0GFMMyhbWT6
         ASSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Po8spVwc4BW6GXFAGGf/sJ/NHVD7xfiFkZoZP9nQ3N0=;
        b=x7AehBE6f3p+Ekurz7RL+gjqb7R3516h/BGkV263FPe+7fpsGJFBIU3yZSI3Hjhs+3
         auKFY4qAkPKwfmRa3VNa1ZEnC1gPTmHRdo6bb7uqj7jooQjolZ34WZb+zojpv3k0We6Q
         jssvNI+mEM0KzjxStW3JhFSCfmmV9x2WzuX00FXd4rD+lf25tkxiiK7Tkt13mZgNNVZ8
         6FgPaBPop1m+NOl5Ja66L+r5AWXOoDX1HjPNbdiM7srRSijEh3qTcUdsT3plflPdp/Ux
         evmLWogLoxAm1XKPbtmfDjF6XxlOgZxajVx3TzZL+v/LvqMVL/uwK2SCjKePNcBFDIKq
         Bbig==
X-Gm-Message-State: AFqh2kqAGa1L3fEuX+5nr6yIgIrCOcDxkz6WS1I44WMx0pwPxu/VyD3/
        XMCbhWtZVgk5BE0hS2XoaqZO4ymPVOsdnfCBq14=
X-Google-Smtp-Source: AMrXdXudhQ6ycVZKv4OQzGVka1kHu9VOVZzqKoVnbluqLdpc+WbJHqhHHMHR5nqYYtg8IHeBjKJqLQ==
X-Received: by 2002:a17:907:a508:b0:7c1:539b:d028 with SMTP id vr8-20020a170907a50800b007c1539bd028mr81693138ejc.48.1673882012620;
        Mon, 16 Jan 2023 07:13:32 -0800 (PST)
Received: from [10.45.33.169] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709063d3200b0084d4a60b3d6sm9102904ejf.117.2023.01.16.07.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 07:13:32 -0800 (PST)
Message-ID: <d085144f-aa98-a79b-d176-2ab6cc7a7289@unity3d.com>
Date:   Mon, 16 Jan 2023 16:13:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] ls-tree: add --sparse-filter-oid argument
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
 <CAPig+cRgZ0CrkqY7mufuWmhf6BC8yXjXXuOTEQjuz+Y0NA+N7Q@mail.gmail.com>
 <xmqq8ri62ohd.fsf@gitster.g>
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <xmqq8ri62ohd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/01/2023 21.01, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>>>      Note that one of the tests only pass when run on top of commit
>>>      5842710dc2 (dir: check for single file cone patterns, 2023-01-03), which
>>>      was submitted separately and is currently is merged to 'next'.
>>
>> Thanks for mentioning this. It's exactly the sort of information the
>> maintainer needs when applying your patch to his tree. And it can be
>> helpful for reviewers too.
> 
> Indeed it is.  Thanks for pointing it out---I just wish other
> contributors see and follow such a wise piece of advice buried in
> review of a patch by others.

Apropos where to apply the patch: This patch conflicts with the topic
'ls-tree.c: clean-up works'[1], which refactors parts of 'ls-tree.c'.
It has recently been merged to 'next' in [2].

Should I go ahead and rebase my changes on top of 'tl/ls-tree-code-clean-up'
and then resubmit a new patch, or does it make sure sense to wait?

1: https://public-inbox.org/git/20230112091135.20050-1-tenglong.tl@alibaba-inc.com
2: Commit f7238037fd (Merge branch 'tl/ls-tree-code-clean-up' into next, 2023-01-14)

