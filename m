Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DDAC43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 07:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiFFHX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 03:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiFFHXS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 03:23:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697B410FA
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 00:23:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h1so11446828plf.11
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 00:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+jdVT+rosLTj2ZzypZKc/bknvYdKv6xPkPMyvhRylrA=;
        b=cY1+48KIMHkJveNHrBs44oD7UaSBK3kKbfqECAxmFfT0agh8+tWVzOpSMi/tODZUf7
         E6dvkFiKOyGQH3HSDYr1gLgvzSc8dkvFDfogmoSXUCgpgYpxMAw1mreaxH3QIZn2tJFN
         kMSlX0OM0FuyYs4Y502llyGoTrzBFfcR+AYZ9h97ydekqgn7QAGiLF35pwqlvG7C/MSD
         GfF5bqp1fbGvd4wv1XhRH8yAy5D+7U5+g+4tAbCMxW9aE0DLpGVnYk2k+ynVctucdFGf
         zJoqeT3/DpJUOcBiDPID+kbvAZNrlkAqS1jx354RxaIk2mcbuG6N+11zW1Y34Ahb05dL
         dfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+jdVT+rosLTj2ZzypZKc/bknvYdKv6xPkPMyvhRylrA=;
        b=cqX60VaIAeRYj2HxMGO65srTSz2w22Vdsgr7Z4KaRUoTSn20iL4+xC+q8Wisu+nVdt
         owPOL9yvZtos3SebiLJ3hwifZLyj919BBNh6UGnEiHfx0ZmYfDbRPMqT4moQq68VlVpB
         8YL1zevdYVULQNWQvcIKKTMXiLtrVdlA4iAyU/AHNoiX/JmwkqPHs5TzUBp3em5497eh
         O97gOd+rDGwvKxruuB6Zt9/FED81umsC2q5uBnIGdmg+vm19bq9XIeYRxQb7yBsKK4UU
         /2LOlqq9WVAthLAH7jld3xVfqSddkA7YAQCo7Nkap4ZI6+9MczRo1yWwxVMWKoJzrtMn
         r5ng==
X-Gm-Message-State: AOAM530/ewCCzvKnscI0EYeU+zUPZKtLBIR6vuZ0KbNKDIrw0Q4rHlbr
        3p5WXqBIMZVgAEWI9aV/zAc=
X-Google-Smtp-Source: ABdhPJxOwBDuTsLQLQ52D8jUYS+ExF+U2YVn0cZPPJTFdEVGIHREwy1PkbfiPYuJeB/Mv5zg3pi8cA==
X-Received: by 2002:a17:902:b692:b0:14c:935b:2b03 with SMTP id c18-20020a170902b69200b0014c935b2b03mr22833266pls.81.1654500196677;
        Mon, 06 Jun 2022 00:23:16 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-76.three.co.id. [180.214.233.76])
        by smtp.gmail.com with ESMTPSA id w6-20020a1709029a8600b0016760c06b76sm4003469plp.194.2022.06.06.00.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 00:23:15 -0700 (PDT)
Message-ID: <466ec54a-825b-c3e6-e9f2-a7007af71b6d@gmail.com>
Date:   Mon, 6 Jun 2022 14:23:11 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] git-prompt: make colourization consistent
Content-Language: en-US
To:     Joakim Petersen <joak-pet@online.no>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
References: <20220604161333.54627-1-joak-pet@online.no>
 <20220604192606.176023-1-joak-pet@online.no>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220604192606.176023-1-joak-pet@online.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/5/22 02:26, Joakim Petersen wrote:
> If the user is in a sparse checkout, the sparsity state indicator
> follows a similar pattern to the short upstream state indicator.
> However, clearing colour of the colourized indicators changes how the
> sparsity state indicator is colourized , as it currently inherits (and
> before the change referenced also inherited) the colour of the last
> short state indicator before it. Reading the commit message of the
> change that introduced the sparsity state indicator, afda36dbf3b
> (git-prompt: include sparsity state as well, 2020-06-21), it appears
> this colourization also was unintended, so clearing the colour for said
> indicator further increases consistency.
> 

colourization? I have never heared that. Did you mean "colorization" (en-US)
or "colourisation" (en-UK)? I assumed the former.

-- 
An old man doll... just what I always wanted! - Clara
