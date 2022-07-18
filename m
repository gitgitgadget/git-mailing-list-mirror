Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A990CC433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 12:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbiGRMUJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 08:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiGRMUI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 08:20:08 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442E11A3A
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 05:20:06 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id r12so8582593qvm.3
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 05:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0PfBrSPRiHaKPiN5QoRxdWgxwccTIamGyxuWIc4nXHw=;
        b=I0qOBZlOXZ2412mNyUpRcgHHm5Ef8ofSBZcy+krntU7tINjt7f+zKGu5BD3KmHL1Jx
         FnP8nBnNirtbANUGuau0hZdF0W9xgnKzb4sgiR/tdXdFlPLUemycLXMDasWGrH8Sewop
         aNhizXmMXxFOS+apd1nwOiKmeKBNnajvfaczHGtn8ocLvtDMXSviYEA+mnkwaW5jUogm
         jJTIEujn3ia9HwXEtqTPF1a1RbWcfDZRE7vMKQQIANJYG+wfy/dV7bTnXJ62hGHuFC6v
         k6fSWUG6yH4LjtUrJRJrfBLuSHU28V6TXk4EBYdewcbbUCAbh1h0byKfRaRfUbRVkHGF
         Fgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0PfBrSPRiHaKPiN5QoRxdWgxwccTIamGyxuWIc4nXHw=;
        b=Xa/l5xfticj7iIixrjYeyGbxOVqlrFl98CitHlSH+O9ilYY/+H5m+3HWzjWeGm25GJ
         DcD6J3BZQD75uoREMAzuLuwBtIy7MPYSElQ10uQQkAC9vlEwrMjOGrYdRjU9p6LeDpSN
         e6M03zLkSK9VwmxEvjVkKx0BxilIhaUcd56r9hlzvE8PrVfbYA0Xp8MW4ezbBfz+oI1G
         q7NfAHi6PPlEppP89zXf8hdIna5LIijeMR9t4EgC3m9A0g+XUXeXb56etXU482PDpjFD
         FqXidu9Aocfu9dyoydebLp7znKFBHZh2/OPb4CeaZ/RKdp6PBxslSNPRZFq9BQzp3kk2
         jLNw==
X-Gm-Message-State: AJIora+kGnradUE7W+XCpkgmyPTuGFy+fGgDJOJVf4/Mat/yN7IF8jFz
        8RK7lcrx42ufrp2vt5xnGi2y
X-Google-Smtp-Source: AGRyM1uP/p4vXT18tUYKPd9QB7E6cvAJE2aDWJxZuKPihXw044kIDAzd4dDkLGWTR2nOqMu9kldPLg==
X-Received: by 2002:a05:6214:509c:b0:473:4d8b:1ffa with SMTP id kk28-20020a056214509c00b004734d8b1ffamr20467928qvb.125.1658146806083;
        Mon, 18 Jul 2022 05:20:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:841f:e099:cbef:4067? ([2600:1700:e72:80a0:841f:e099:cbef:4067])
        by smtp.gmail.com with ESMTPSA id n18-20020a05620a295200b006b5e45ff82csm4092665qkp.93.2022.07.18.05.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 05:20:05 -0700 (PDT)
Message-ID: <192ffe9b-0676-2143-9032-673bc597d45e@github.com>
Date:   Mon, 18 Jul 2022 08:20:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] config/core.txt: fix minor issues for
 `core.sparseCheckoutCone`
Content-Language: en-US
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <20220718100530.2068354-1-martin.agren@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220718100530.2068354-1-martin.agren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/18/22 6:05 AM, Martin Ågren wrote:
> The sparse checkout feature can be used in "cone mode" or "non-cone
> mode". In this one instance in the documentation, we refer to the latter
> as "non cone mode" with whitespace rather than a hyphen. Align this with
> the rest of our documentation.
> 
> A few words later in the same paragraph, there's mention of "a more
> flexible patterns". Drop that leading "a" to fix the grammar.

Thank you for your attention to detail. This is a good change.

Thanks,
-Stolee
