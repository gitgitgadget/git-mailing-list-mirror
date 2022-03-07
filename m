Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785DEC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 15:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbiCGP4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiCGPz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 10:55:59 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A48C76E0B
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 07:55:05 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so3212090otk.8
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 07:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B6a0uGK/rWXwqCaWjTjOPA/NyCBO9mnnnYPgfEU4btU=;
        b=b4g8e2Z+5oKDoxY/N2/MsVWkc7y3qpVIjaQ6dzOxV3Ci3mRLhwsSaZ8CykLig7XmTW
         fJ9vInz5Qcp7ooHIhFv6gVbOMF6Yn5MQwuSaVqIGTiSm7qzP4dKbmfAdXuH4C16lTQaf
         fDWeF5q0xHfnlB9X9xj75EgeXYZpc77YlYO63P/QC2R5c0vLcYACJNb55VilFzOK6E6p
         XhEkCxRmJYj8iZV4chf422VWDgMOQKX4KsUQVQbcQHetpAxZ/VMofcAreh394KXOc80H
         VSB4lUTfCUlt1NynoP9z3MaChb15jRGndmDVxvOfaIwPtsdZS34bZKQhWblBJZ5cxGly
         v2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B6a0uGK/rWXwqCaWjTjOPA/NyCBO9mnnnYPgfEU4btU=;
        b=BLY8RsK/EghIiPiZQRdLq8OKOeojTNtbHf7Js/86BCfsxcbodhT/bKg0b6s95kHSJf
         L98IPezNz6XQURsNbzedQ8nMrwJAAVCkobm02DqLhsSo0jk9YOSL5E/NlbIbze2AtLQm
         It6a/5NRqrCy3R64VS8v0yG4x3jxefmLLJ/cZVTqYrt1WYVyoqZ9ot9vFyfRonJwx8Gx
         4SHhZ7nImdHQm1JkimyUnnny7QxcJmpRUWft3ty6K2aRmhghcIqquRw4SWYmzNYKJUOi
         RhZ1YdWDZo0ug4oL/r6pfJ+KWACM/7qx2vhppMFnakklVV7mxjzqjwMJAuLk3AEMUZpk
         wMGg==
X-Gm-Message-State: AOAM533tI8kRj7gBwBI+hVGbKPemA/opwdG/dRkOo3lUUfbW8DJ2qCgp
        fxlgfYLrCKTT+v1+2tP8y2tO
X-Google-Smtp-Source: ABdhPJyv3KxcBHHKjJhy2X9DIjEkUVgyNwlo+4b4pGSBeNQJ8aaP5lLU835vXYa8q+ghZTJ4PZuj+A==
X-Received: by 2002:a05:6830:4112:b0:5b2:38e4:8ed with SMTP id w18-20020a056830411200b005b238e408edmr1456013ott.143.1646668504393;
        Mon, 07 Mar 2022 07:55:04 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 6-20020aca0d06000000b002d9c27d3218sm2247356oin.6.2022.03.07.07.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 07:55:03 -0800 (PST)
Message-ID: <0b0802fb-c977-d8ab-092a-b8a576daf3c6@github.com>
Date:   Mon, 7 Mar 2022 10:55:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 0/2] string-list.h: make "nr" and "alloc" a "size_t"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
References: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20220307T152316Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover-v2-0.2-00000000000-20220307T152316Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 10:27 AM, Ævar Arnfjörð Bjarmason wrote:
> Change the "struct string_list" to have a "size_t" for "nr" and
> "alloc", ensuring we won't overflow on platforms where size_t is 64
> bit, but "unsigned int" is 32 bit.
> 
> This replaces the v1 1/2 to get rid of the casts we use for Q_(), and
> the 2/2's addition of casts is then consistent with those.

This version looks a lot better, localizing the need for understanding
cast implications into the implementation of Q_() instead of every
caller.

Thanks,
-Stolee
