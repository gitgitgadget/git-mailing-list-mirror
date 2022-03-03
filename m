Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCD3C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 01:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiCCBaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 20:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiCCBaX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 20:30:23 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ADF1A06EA
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 17:29:39 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id iv12so1526714qvb.6
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 17:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xTFXJ20hggJsOaO8uXu3CkUeEclrsD8jQL5HKhk0hdk=;
        b=UYUJnyWgopZu56Qe8W7QuXFhEXmobvZZmo1oLq3Gr6KlWQnUitJIRTuOQj7C1BeUX6
         GMuJv2pG76AGI1C6EEqEEYENkP8XEf2WdlwOBcJq12bYdJPw77a5Fl9Lc3GX8OjuUj+I
         q+PBCNCPtIJ/q3ZzkLBzZ/XMpxmocV0/NX1RfvY2f4Ty9eMFGlcBy2UIt77vg9pmTBbH
         8TJ2WY5N2kTK63Otmk53L5mv6PizSdAveQ3WrZlVAuafIyBtgIRYLPLMIdfUso7m8vy1
         g5z4tmtgAWMAl197nDZaczDdEpJzM/jBdjKYJywz+yZsv1OwVA/tIIs0Ths7yCSCzVk4
         /4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xTFXJ20hggJsOaO8uXu3CkUeEclrsD8jQL5HKhk0hdk=;
        b=q2lpvchEy9PirsWdOVcOUuA0tP+WNC9bDOVrSnWR73sZaT76YKzhJm7/01TvRZ1a6q
         XSLG707qQRtTqbp2SshS81H3de4be3gjvW7pCahha/InI3Mmh3pdjrHmAtRsjsKzNdRT
         7Ksblzsrxl7Z7v4Uer+6r+MAN0qQM+Eb2rgE7qTDmV2c00in3rpOzx5KQkt0XPbpJ5N9
         7lEP87IfKoon48xQ9ACq5Jsvn7AMJ2UTtGns8WIn5gmlAYoN+i0UB6YHfZlyfvmCWLyM
         4274fj/aAc/RSPdcRKu9qIv/H09mozznh4t/JntUb0oh2MYht9F2Lb9Y6ZoBjJpbCb0O
         aL8w==
X-Gm-Message-State: AOAM530+n0X1GdP7KKjQBVcqhIHwSP45s9/IJWUDamd2FTDHVYWRMBqF
        jPRyv15gdFEhbeeWKEVpkR1IOlwFFMX6
X-Google-Smtp-Source: ABdhPJwALgtxy0pH2d71+hDCMmRJDwPGnP+Fzl52zykecTJiewvyCzXm+0ZI+AFoPPzJzUN1hMRuxQ==
X-Received: by 2002:ad4:4eae:0:b0:435:32f9:c034 with SMTP id ed14-20020ad44eae000000b0043532f9c034mr855662qvb.71.1646270978441;
        Wed, 02 Mar 2022 17:29:38 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t2-20020a05620a0b0200b0060dd6af48d1sm356332qkg.38.2022.03.02.17.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 17:29:38 -0800 (PST)
Message-ID: <5063be12-fb66-9936-9ec3-df02d4c9cfd9@github.com>
Date:   Wed, 2 Mar 2022 20:29:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 00/17] cruft packs
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     tytso@mit.edu, gitster@pobox.com, larsxschneider@gmail.com
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1646266835.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/2/2022 7:20 PM, Taylor Blau wrote:
> Here is a small reroll of my series to implement "cruft packs", based on
> Stolee's review.
> 
> The changes here are minor, and mostly are limited to removing a
> redundant "if" statement, avoiding an unnecessary header include, and
> moving the tests (again!) to t5329's territory.
> 
> As always, a range-diff is below. Thanks in advance for taking another
> look!

This range-diff satisfies my comments. Thanks!
-Stolee
