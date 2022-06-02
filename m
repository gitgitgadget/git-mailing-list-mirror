Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC061C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 14:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiFBOar (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 10:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbiFBOan (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 10:30:43 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DC52A8918
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 07:30:29 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h137so1036009iof.8
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 07:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SB0N0s+XWIljfOSqhStqjEKXeEf0fxtzvo3ptmYkspg=;
        b=b/shwpAJTidRoz+Sf4Lmu5NHSnXLNVOMmN69f7rwBWQFuPMvB4EJ2CerAU3qJRc2ds
         04b99KzySlLWda1YsdRJ4GdjpSYuec4rPF6s2kpC2Oahh4Gsai3leHcEBf59coKi5Lxh
         NA03qHqij0Mhv+lWQI31ZNGlgyvhb6RtMl9ElQm/Zl+6w7CZsTtaEehvUKWavKTZqa7/
         fT6nE6PW2PV8s3VCGgJJ7Cimx5OkBufTjHbK3e2jGwaXk+aSkOemn9s9wssV+w/mjyld
         4Dpf3zI+7utWMnDM4P+v5EHmoNrsBchbPZiWh01AYx2pXBcX/e9nIKXnptf9sTk8lVbB
         +M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SB0N0s+XWIljfOSqhStqjEKXeEf0fxtzvo3ptmYkspg=;
        b=CbLD+7McAbmFHxcraN0/76PR+dEX7CD1O7W96gPE6hQ1ih+aQkU7X8vHIXSZJTxQeQ
         uhWIs/03AjyWIcke6d2sytEZuxnvBza4wwQNyPJQ6is4GPoUHRyo703BT5hjWD3F92+S
         1rQ0Zg/a6YdJ/MPEzvHHZRuHv/udfUZN9mRBw0L+H3LV4doJP3fsqsWauQP2uJaDQKmb
         9PFV1mSY49osN/7dRu4rqAeIrSxkjkgLI6m6+UxAh3yAnbp5wKLsFU9wbs2KyZN3z7AI
         YktbnuFCzPgo8PVPogENSmNeJv496TY2mKJ04KhMcO1qndklVOk6zSbMbaRY8TL3Pf4x
         2yGg==
X-Gm-Message-State: AOAM532kV3BnLJ96miK6nmFaKtrSFXmnSiAm8v1F0F/MUNWnX9bxK88Z
        0Nud7nPpoYRv552tPZJHBRZM
X-Google-Smtp-Source: ABdhPJwlELjV3B4nKxe91B5icGGyvh24b3WfLH7zfVZV1bLgEIe5IKiD0wOrEesAH/8YXSQBy/jHDQ==
X-Received: by 2002:a05:6638:1411:b0:32e:c01f:e93e with SMTP id k17-20020a056638141100b0032ec01fe93emr3325969jad.21.1654180228614;
        Thu, 02 Jun 2022 07:30:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9cc9:fda3:3ddf:6700? ([2600:1700:e72:80a0:9cc9:fda3:3ddf:6700])
        by smtp.gmail.com with ESMTPSA id k45-20020a02662d000000b0032b3a7817d3sm1252922jac.151.2022.06.02.07.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 07:30:27 -0700 (PDT)
Message-ID: <d59b51fb-029f-8232-9dd8-2f7f1b410aa7@github.com>
Date:   Thu, 2 Jun 2022 10:30:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] Integrate Scalar into the CI builds
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
 <d0448d28-b33c-3f42-901d-3cd7f4201c78@github.com>
 <220602.865yljywtf.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220602.865yljywtf.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/2022 10:13 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jun 02 2022, Derrick Stolee wrote:
> 
>> On 6/2/2022 5:05 AM, Johannes Schindelin via GitGitGadget wrote:
>>> Note that the changes to the GitHub workflow are somewhat transient in
>>> nature: Based on the feedback I received on the Git mailing list, I see some
>>> appetite for turning Scalar into a full-fledged top-level command in Git,
>>> similar to gitk. Therefore my current plan is to do exactly that in the end
>>> (and I already have patches lined up to that end). This will essentially
>>> revert the ci/run-build-and-tests.sh change in this patch series.
>>
>> I expect that this won't be a full remote, since we will still want to
>> exclude Scalar from the build without INCLUDE_SCALAR enabled.
> 
> "a full remote"?

Whoops. My brain is mixed up with the work I've been doing in remote.c.

I meant "a full revert".
 
> Scalar (well, scalar.o, not scalar the binary) has been included in the
> default build (including CI) for a while now.

I'm talking about scalar the binary being important. I'm glad that
scalar.o has been built already.
 
> What we haven't been doing until this series it to link it with libgit.a
> or running its tests.
> 
> So perhaps that's what you mean, but in an earlier series it wasn't
> building scalar.o, and I remember there being some confusion on this
> point in the past, seemingly based on a mental model of the scalar
> patches that pre-dated the re-roll that eventually got merged.

Yes, it is important that we revisit these patches with the previous
changes in mind. In particular, I don't see a single reference to
INCLUDE_SCALAR in the tree at the 'next' branch. This is different
from the build in the microsoft/git fork, which is where I've done
all of my own Scalar development.

Thanks,
-Stolee
