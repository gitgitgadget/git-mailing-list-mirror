Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317D3C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 14:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiBVOHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiBVOHb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 09:07:31 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AAA541BC
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 06:06:58 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id h13so342772qvk.12
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 06:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vx4hz3H5e+faQ6IgS+QOxFmpKaZvFL7rKHwTD/eGSIs=;
        b=ITCgEQkBbPJrLasH04T69MJas+TA2Bg6y666mL7knuyxSJV8UnAUjAz9l6FVZYQIWG
         HLADX9VHM2qvFHsCVkqt4D0NIWBheGsnyo+SsLsafxa3fVieq5DmcOjQC0d8S58xyhD4
         BL9BhpeYEBcu6MPGI7KG5U/ewJxyc5WtusXQPh+g2L+2PbEb9wcijs9qv5rgDYNBP1qY
         dAAHM+7EdKxpmiLPVco7D/Mfmr18txnJbLVUPAxImkQir3JsD51PwXrSwDxoY2ls0Rz9
         DtvuuSRfdr1Rxhaa93XUr0YKZb0SivF1KB/An4CXW7xdZu5vin4waCScAPlDij9/vKUD
         Fq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vx4hz3H5e+faQ6IgS+QOxFmpKaZvFL7rKHwTD/eGSIs=;
        b=jarDAeeBf1LQX6qzQLUrKJOYpys0MsYlcFrpvZ/Di++YcGuihx5z9Dgv9MWoNtM7E3
         OSXvsuqIzqN2dqtMk++fu6LXnGK6YGasuoqVTxRuQ/kziMe0Y0E5RsmCG9XeNbTlJax+
         jXZ1OMUbTnwVvplUWkg1Z5zaBeQalaDW5mD6wmG0CpV8LfxOruXC44WlxpRF7NXBVjvv
         df/h45qbgwdzsFX/lwmSXt54IQzvu8FNVhP31rphig3VwWRdIrHBrOiLTdtBNMW2KzDV
         daIrdPEesde3MWpmmw710gn6e6bQkRsXWzhmjIJya2LUwEL54F6V7QYGC+Oc4+OCl5WK
         o0Ag==
X-Gm-Message-State: AOAM530TVVAh3r87YLGjZZp1RLR8r4hVNQC4OlTuWY7JfJlCj/3cxND9
        K9obbwd5iRjsWEm46QYZVoc9
X-Google-Smtp-Source: ABdhPJwVLu8So1WrAqoR1LLkyUvPBffQs218Kw0SIvoztD7CRBKsUn47KrcfGjYitrVfywZd5HlmPg==
X-Received: by 2002:a05:6214:c4d:b0:430:8d85:28f6 with SMTP id r13-20020a0562140c4d00b004308d8528f6mr19053101qvj.24.1645538817255;
        Tue, 22 Feb 2022 06:06:57 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e9sm33165899qtx.37.2022.02.22.06.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 06:06:57 -0800 (PST)
Message-ID: <c231018a-0c2f-b611-be46-47f3b68a599d@github.com>
Date:   Tue, 22 Feb 2022 09:06:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 06/11] worktree: use 'worktree' over 'working tree'
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
 <a375e4b6ff0e5f77fcfaac44945e5722b0f9ab9c.1645489080.git.gitgitgadget@gmail.com>
 <xmqq35kbwekb.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq35kbwekb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/22/2022 2:22 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +Similarly, if the working directory for a linked worktree is moved without
> 
> "the working tree for a linked worktree" is the phrase used in
> 05/11, which this part should also adopt, I think.

You're right. I appreciate both fixups you've provided.

Thanks,
-Stolee
