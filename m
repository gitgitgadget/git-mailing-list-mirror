Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E17DC77B70
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 14:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjDQOF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 10:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjDQOFX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 10:05:23 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471876587
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 07:05:09 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-552ae3e2cbeso46524797b3.13
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 07:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681740308; x=1684332308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Iomr1BdFKW1GBpMEt86TKI3G83+1vghBEFzJuqE/5o=;
        b=gQpyfrsHxvFkvt3807pwhGeDOspzhMU3y1PLmbBbebJ2gAgm5PB1ykMUs0Su3NK+i1
         BV71D/ChHcVH2H6vtbIfojUivexbtmCcarSHfZFzVw9GitxVGKgpzzw5kqvOAJVRA70m
         5ERvzxWinbKQvB9GUMpBhltelM4sKVPOJaD653e4mrILyE9JP6R2+51S17eG6d3IgqF6
         dTtIUvM7yojU0NParS08OSBG836Ubx6NTzzQ3bmyIkU2czmYPKei/RDCyvZeuVFzkk+N
         iI+8QWDs9zd/cbn3vWQ6pmRKH/A1D5+x7Pqmu+c3464N9FvLFfiFgm7lVQkYsVUDbKH2
         Z49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681740308; x=1684332308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Iomr1BdFKW1GBpMEt86TKI3G83+1vghBEFzJuqE/5o=;
        b=VlryZAGjQZ8zJUk1CR4wfwW40NkO6fhtt1vIjvaaYuyPN/U6STQ9conuAwVzARA5PR
         BhwcRK3ZFWwFNLu/FrozbRfsqHC6grctFZfTYQ+bO3pIkTOu0RLX7DOyZEt1bJRIKCuw
         0qD1kjfkyt0uwqvkcxfmsYYSUVlGUTPtkXMSt4xucATBjXQaYqWDyb0XVpmnQv4DDk7d
         fJweAqbO5d4xUYB/10WT4Lqd20Li+obUNc/9AsA+fc+qZqDzHXwrIWsfSpWtBu77Qdyj
         zW1svN0WXtJuBjcOHC5ZMloOLmvSAajUSqprQNwomVyu4/QuoCoBu/WFo5zrVDdEf9Gz
         c5JA==
X-Gm-Message-State: AAQBX9eh+gG/gblONr931y7s7EwayFjKE63FxDhD7V9h5lw3ae/9YT35
        HDrlxARk3uVNVXn0M34wwJnr
X-Google-Smtp-Source: AKy350Ywyt1LUNgfJ2Iq4g+FSRf/WKrJF9AVxRPJz1d1pjwqVmx0yN+55QWm8AVkadhHdBToc/WYeA==
X-Received: by 2002:a81:4fd6:0:b0:54f:1185:b591 with SMTP id d205-20020a814fd6000000b0054f1185b591mr16416030ywb.44.1681740308336;
        Mon, 17 Apr 2023 07:05:08 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id by7-20020a05690c082700b00545ef25cec6sm3087710ywb.105.2023.04.17.07.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 07:05:07 -0700 (PDT)
Message-ID: <b9732826-5732-0f87-9527-f49c38514fd7@github.com>
Date:   Mon, 17 Apr 2023 10:05:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
To:     Elijah Newren <newren@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com>
 <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
 <89c78da5-388a-e52b-b20b-e376ac90de14@github.com>
 <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/15/2023 3:07 PM, Elijah Newren wrote:
> On Fri, Apr 14, 2023 at 7:23 AM Derrick Stolee <derrickstolee@github.com> wrote:

>> Sending arbitrary command-line arguments to setup_revisions()
>> creates an opportunity for behavior you are not expecting.
 
>> [unstated: and what about other similar options?]
> 
> I'd really rather not have an allowlist of which revision options
> should be allowed for use by git-replay.  A denylist might be okay, if
> also implemented for fast-export, but I'm more of the opinion that we
> just document that both commands only make sense with "contiguous"
> history.
> 
> Most importantly, though, at a minimum I do absolutely want to allow
> several negative revisions to be specified, several positive revisions
> to be specified, and special flags like --ancestry-path or
> --first-parent to be specified.  There may well be additional flags,
> both current and future, that should be allowed too.
> 
> In short, I don't want another limited rebase; I want a more generic tool.

The primary value of git-replay (to me) is that we can do "simple" rebases
without a worktree or user interaction. To me, simple rebases mean apply a
linear sequence of commits from a single branch onto another branch (and
specifying an "old base" is simple enough to include here). It also means
that we abort completely if there is a conflict (and handle conflict
resolution in later changes).

The sooner we can deliver that, the better we can deliver on its potential
(and expand its functionality to be more generic).

And this is generally my preference, but we shouldn't get functionality
"by accident" but instead do it with full intention and strong testing.

I will always think that certain shortcuts should not be used. This
includes passing arguments directly to setup_revisions() and using
pathspec parsing when a path string will work just fine.

If we have a need for a feature, then we should add it explicitly and
carefully. The surface area of setup_revisions() is far too large to have
confidence that we are not exposing bugs for users to trip on later.

Thanks,
-Stolee
