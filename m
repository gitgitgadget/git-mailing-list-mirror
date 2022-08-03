Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A347C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 14:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiHCOfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 10:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbiHCOfe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 10:35:34 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1C415719
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 07:35:33 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id ey23so3051681qtb.11
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sRJW8DF2lydeEaklz+IweiJhoTh/aUCBHxrQFi4gnJA=;
        b=K3xDf4SxARtgDAUEOo4uQ6shqCrZOwnuF0TQIUF0wlZIx/DXaGglAoRC99zfDEyjds
         YHP/ltxujKLHiON83Bl0EWtIXqnGgQ5tYQnwxwy3mnvQtPEjmhyNFKo36igPufjrS25F
         afgNb/mzfQrYM0StLQz8CzsM6ENBBje/uUdvUNbdJzSIVo+iER8AbbU87/vmejXKWLVT
         WhHprQHAjGY0JIoB3CA1YHxUBYCRxhrLEGRSJEwBywmK+FQHt2gH9ZS1RVWLapTmvuvb
         Z2+mzNi5jOCDhoDtUew8koq27gjo/Iac7Y2iAJQ5grouEr/1+i2KBH/XDhw3pcxWywaP
         Gf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sRJW8DF2lydeEaklz+IweiJhoTh/aUCBHxrQFi4gnJA=;
        b=Gxu6Fd1AXOaWoyStI/5pkTerCDLG9mPCftUOO3MUgo6cMtJnE96HQpvK2yhzkOLgeQ
         pKXyJSWtq03NMGsPUpyvLD3m+rBaZdEctzc8SUOnUNlTxFMu4/qfFVhHaz/drBQWrFqB
         z1IxrgrIYm7L2qL4OOgK5lXqXu5kDMnOZ6UNN0BvzpUP+sQ2gZu1wl61WWN7tiM8ePe8
         gcCF3ChBXaw/7zE/Q2RsYGuG5hWaEUsaytk5PrZD3hshSgetrX/rqT0KS+AMS6uLhwlI
         9NGSucw1hsDAho3qc+H+mX80F6C3LJ+acXVwe0/1GjWD6k2c24ttYKX1wVDoE8bmdZLz
         ZL1Q==
X-Gm-Message-State: ACgBeo3YJNysV447IupIzozkbMlX88lM8ueYQnnLtv/4AIHaExbEIBIp
        kC0oApFnVIUBNA6X5l8a4MYFSYbz0jgO
X-Google-Smtp-Source: AA6agR6H0px6c6mghIiqeFuaHt3ei/+FeihlOVpD/gAxqz3GVsIl8WeqmiWhC4Je+O5O+pOvbPY45A==
X-Received: by 2002:ac8:5b53:0:b0:340:19e6:38eb with SMTP id n19-20020ac85b53000000b0034019e638ebmr654094qtw.1.1659537332405;
        Wed, 03 Aug 2022 07:35:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d582:a76b:8dd3:e924? ([2600:1700:e72:80a0:d582:a76b:8dd3:e924])
        by smtp.gmail.com with ESMTPSA id u4-20020a05620a0c4400b006b5c5987ff2sm12621661qki.96.2022.08.03.07.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 07:35:31 -0700 (PDT)
Message-ID: <90f817f1-340d-48e0-22b1-c6644d62f19f@github.com>
Date:   Wed, 3 Aug 2022 10:35:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/4] pathspec.h: move pathspec_needs_expanded_index()
 from reset.c to here
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220803045118.1243087-3-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220803045118.1243087-3-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 12:51 AM, Shaoxuan Yuan wrote:
> Method pathspec_needs_expanded_index() in reset.c from 4d1cfc1351
> (reset: make --mixed sparse-aware, 2021-11-29) is reusable when we
> need to verify if the index needs to be expanded when the command
> is utilizing a pathspec rather than a literal path.
> 
> Move it to pathspec.h for reusability.
> 
> Add a few items to the function so it can better serve its purpose as
> a standalone public function:
> 
> * Add a check in front so if the index is not sparse, return early since
>   no expansion is needed.
> 
> * Add documentation to the function.

I took a look at this diff on my machine with --color-moved, which
highlighted the other valuable thing about this move: it takes an
arbitrary 'struct index_state' pointer instead of using the_index and
active_cache. These are good things that might be worth mentioning in
the commit message.

Thanks,
-Stolee

