Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A194020281
	for <e@80x24.org>; Sat, 23 Sep 2017 12:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdIWMwR (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 08:52:17 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:56000 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbdIWMwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 08:52:16 -0400
Received: by mail-pg0-f49.google.com with SMTP id b11so1858179pgn.12
        for <git@vger.kernel.org>; Sat, 23 Sep 2017 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+L/NNGdcqmk7M/Ky9Zg9Ho2cgRPR9vPYYv7zWoetuIc=;
        b=dhbi0XZ2A9jiuGCG0Fb3mU+kzb+FExt0H2GV/CerklHMXpBKrBWAoqqezNiQLy62nS
         IBhr6b/ibRCpuCQDdWfn/OKUg14ZWe/HL7lzN+I9gJq6UTlISNFq/Y28kzIKZJ2Y9qEh
         tnWeaPq7tSVCYRlHuFMdwD1Drv3nEJulSzO+Yaa7V4jFaqzUejG/AprtMIHfXZll2niK
         tfGIxz3sGts+4bo2yAovfh3IPPMGLVrWOmj6rAqiGhqnXuPpVlbTgYdGbVYU6DTRBgh+
         YxnEhzr6uzPHmEXAGIjZgMo6Zi90tL1ktaKhF3/TCa5d8A/t8OIIFtkHxfGeNjMhFHDY
         0KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+L/NNGdcqmk7M/Ky9Zg9Ho2cgRPR9vPYYv7zWoetuIc=;
        b=AYfd2WEuf4pBu7pzqwayzhyPzGQu6bNWCYvcIVmpHahdyOnDU1Gj6gh+BDAgeaYiJH
         g68OokO12GRAdc5ZiTWxGEH9QBckVB/gOErwKr1jupx4Qi/geRnXGPntjmWfHOz6CDgo
         NY8Vr2Wh9YLgePznwAFBPAGQLDN5oDaUzwQB27QMCN0sZjILVm9tdbWCHwrWUUmLc8B4
         kSyQ3R+BaToSmVE2BiA9w/vvUukAYuDmuiB8JQ9h++OAmfSOTtxKqlqFfpa+5DOew1M3
         AuzaRQdz9EcT5Cpawvsvmrz+bNB8D8qK4v71NXt6DOSmEYE0L471jSlani/pzlQN4Eau
         Jnqg==
X-Gm-Message-State: AHPjjUgDAlH76W7cVw/ltR0Nvj85YgtC+igSE/PcVsklaskoJiJ4SPgj
        Uy642P6ZnlEGJIyf+ZrRwpIKccM4
X-Google-Smtp-Source: AOwi7QCC4iwOz1DJPlLD8nsjjC0X9XNuhEuyCL4G0xOjkuWZlrzFHox9u+Z/zroUyKWE2NIN7T9M4Q==
X-Received: by 10.99.191.6 with SMTP id v6mr2180645pgf.284.1506171136325;
        Sat, 23 Sep 2017 05:52:16 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id c16sm4243709pfj.123.2017.09.23.05.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Sep 2017 05:52:15 -0700 (PDT)
Subject: Re: [RFC PATCH 3/5] branch: cleanup branch name validation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170919071525.9404-4-kaarticsivaraam91196@gmail.com>
 <xmqqzi9qngq9.fsf@gitster.mtv.corp.google.com>
 <1d620d52-5326-269a-8710-160b75fada81@gmail.com>
 <xmqqd16kn86t.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <811bc0ca-b503-2917-f985-e66538f7219c@gmail.com>
Date:   Sat, 23 Sep 2017 18:22:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqd16kn86t.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 21 September 2017 07:07 AM, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
>
>> Thanks for giving a better alternative. Sounds catchy. How about
>> `validate_branch_creation`?
> I do not know what you meant by "catchy",

I was intending that 'ok_to_create_branch' was a "nice alternative" when I
said catchy (I should better be more clear in the future).

> but "git grep ok_to_" will
> tell you that ok-to-$do-something is quite an establish phrasing (if
> I thought it was a bad way to name it, I would have explicitly said
> so).
>

Well, it might be an established phrase but I feel that the 'ok_to' part 
of the
name implies that it returns some sort of boolean value ('ok' or 'not ok')
rather than the status. This doesn't seem to be the case for the
`validate_new_branchname` which returns values only upon success
and dies in case of failure (Note: only the PATCH 4/5 in the series adds 
the
logic to return a value in case of failure; when requested). So, I find the
name "ok_to_create_branch" to be less communicative. Though I don't find
the name "validate_branch_creation" to be conveys this meaning any better;
I thought of using it as it doesn't seem to be implying a boolean return 
value.

---
Kaartic
