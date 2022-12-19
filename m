Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C53C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 17:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiLSR0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 12:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSR0U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 12:26:20 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068A91056E
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 09:26:19 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r26so13856771edc.10
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 09:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cl14d/kmaDSM3SiuZzXuTP1bfh9R1lKq7HCYrQJ+VRU=;
        b=D4BEcCurIpV5S8bafUFgYvy8t6hfa8bZ5P3ibJucb2jfklbnvLhRpPfvoJZDjKDAy5
         yrKRQEsTGB/fTzkStlSVjZuOs12Ir17dYWnzChRFaIKmIpMQC4nPyz4mpGGoHr1ZhgAI
         /7r3z47XKOtO0gQFMngbedlpsUC3Xb9ufwVFD8cyepILU7d4Sesk+wC0rpAArIG8uqGq
         qD1V+hDmZPeu999RViIMmSqkzo5tL3uZjsBKwlMMun99GY+P/V3r4y1ygssDbRkLMwgj
         etNFwk1V7crpjez+OUfbL3ISN7ov1mY3uGhfXrr4DjSNUDrOzJqDlti0yHpx2bPp/fIk
         oliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cl14d/kmaDSM3SiuZzXuTP1bfh9R1lKq7HCYrQJ+VRU=;
        b=wUDefyTbieIDyRVIuWB3oEP2P1cQ8fSfDZ0OQIAaLBWCFxvYXBKK1nfh8UprUCXxFh
         OZyWPqFzcZZEPpx4x8/RLbMH4l+Xax/RJyeA7M7tT825h5Ozxr/B/V0NyFFfEqx+k5Ie
         L0jU92aV03feBSt0XFyS/9eSOGjuYRlrqhzYNBmvpbkP5L24qtg2zr7wNTdNkcv/SqqM
         ngMjc7I26Id8mjJr9uTQfti6ujugSZvN8J0bGucN47vAPqS6r3mxO1WgsQiqOt1k4AvA
         V3XN4M2yoHDVPE+51zYZmZMl1dND4NwY3tDuZ4qHFCJjX45PDJLl6s2AQPU4hidzJ3L+
         CNSA==
X-Gm-Message-State: ANoB5pmhV3k0jMZJhtpYEXdakZ/XAO4FR04Hd5VgD8QRC9a++gjzTbey
        eYVCUeNURsUOhSNetZvc1Z1pI9Xe8wTzAVH3nwW1STmishI=
X-Google-Smtp-Source: AA0mqf7TeBLaONgQbm+RQTQByqyyD48XVe/0Bt0iZbjvuCRy8kOVIxrjzZRQFO+rqtmiJ+pq1eO/4fCvWVef0vWjAQQ=
X-Received: by 2002:a05:6402:a52:b0:46b:d3b3:669f with SMTP id
 bt18-20020a0564020a5200b0046bd3b3669fmr33113360edb.414.1671470777467; Mon, 19
 Dec 2022 09:26:17 -0800 (PST)
MIME-Version: 1.0
References: <CAC5-4e-hViTA36gg=ui5=kUsSswVe+XhRmBz56H-4PkuhYLrrQ@mail.gmail.com>
 <xmqqtu1vkl38.fsf@gitster.g>
In-Reply-To: <xmqqtu1vkl38.fsf@gitster.g>
From:   Prajwal S N <prajwalnadig21@gmail.com>
Date:   Mon, 19 Dec 2022 22:56:06 +0530
Message-ID: <CAC5-4e_TeVon0MAHUk99Kci5XWfeY_mozvGoYk-WGja7A3XCTQ@mail.gmail.com>
Subject: Re: Add git config variable for signoff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think the latest round was the thread leading to this message:
>
>   https://lore.kernel.org/git/xmqqpnfw8gyn.fsf@gitster-ct.c.googlers.com/
>
> There was an earlier round:
>
>   https://lore.kernel.org/git/20161229084701.GA3643@starla/

I went through these threads as well as the other related ones, and I
understand some of the arguments. It definitely makes sense to have
this specifically as opt-in, since it is important for developers to
be aware that they are adding a DCO to their commits. This is exactly
what my patch suggestion proposes - let us not touch the defaults for
signing off, but simply provide a `commit.signoff` config flag
identical to the existing `format.signoff` flag that works with `git
format-patch`. This would mean that only the developers who regularly
signoff every commit can add this to their config, taking full
responsibility for choosing to do so :)

Cheers,
Prajwal S N
