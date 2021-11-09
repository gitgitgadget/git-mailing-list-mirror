Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3716AC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 21:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100CD61156
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 21:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbhKIVST (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 16:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245052AbhKIVST (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 16:18:19 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F950C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 13:15:32 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id s186so812601yba.12
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 13:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rggx5gPP9ssDcbu9p6eSmyw6CuhUTTCyTHJItB/b0+0=;
        b=Exp8lhhbO6y6ITg9HAVqc+7apQ+1aKDm749dVEojfnQrstqvPtGxs2iSEBxjzNDVvo
         1XvV8djuC0tANwVmPWNexQcD05HrztivTkjVqMLXavsA6JcNtphSDAAwRoQ8Gf/vXtbo
         EHfnWKfbFLwac39M4IC24g20oVBvbEzfI/ks1rlcy1gC8QSyRs/b5qXWE25MT1kL4xuc
         zHzJBu8WoSSTSDNvgqVvxUgh5xoxp7FJs+gbPSyD2dsXH/Xus5uv4CULxQHRaZ5bMGTs
         d1H9yTAi/YCxhKK9NBaZPboOqEOznbmI+dYUM/VGmTrdOjNjZwnWt3HP76nYPoZ+O1bF
         0PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rggx5gPP9ssDcbu9p6eSmyw6CuhUTTCyTHJItB/b0+0=;
        b=CtxaERo9r7+z8LtgXZ96k4JUG5LlDuCcxr/6fCdkkFsERoxLP/SgUPED3AXnIUr5xW
         jVmtCwGWXuI97uNwp1wJy53HpPZ70E4iwRvRV4w8ycncHIXMw6dicnADLDRiwtiQzXB8
         D0975dX5eSiYWybqIJLl2oIN9C5dEoO+0/mcGmtaGb7fAkkhE3SPHe3hAIudx8pTbTex
         OCFFPRtC7lHU/jIeeM2B2CoJQ/1nZ+rh7BptfenXSpu9DBVeEJQgEqDwF5Ks5KD1gcvl
         ekdZuWcJXO69WBcnXQhf70Z9Ctrmn8As8gH9NWmvJq5eQM+buZdwUIzDwECqcyCpABZo
         wp5Q==
X-Gm-Message-State: AOAM5304owebZcuz183z0E9HoEeG/991uaQ5X/EFE2b8PqPHLrWC6T+z
        sbRshYgI+WaHgiKYmSIQ2VPE2EEWmgALDx34D9aq4hGF
X-Google-Smtp-Source: ABdhPJx2OGSVL9etwR7mw1F66Zw6r64t854zFVri0+hQFi+lUhfvlUil2FvYhT6R+w8ZMH/Wc+tYpcc18RKbP5GGh6s=
X-Received: by 2002:a25:cfcf:: with SMTP id f198mr11611032ybg.11.1636492531789;
 Tue, 09 Nov 2021 13:15:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
 <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com> <7214fa73fdd13418744903f6c769fdb77c9512ce.1609272328.git.gitgitgadget@gmail.com>
In-Reply-To: <7214fa73fdd13418744903f6c769fdb77c9512ce.1609272328.git.gitgitgadget@gmail.com>
From:   =?UTF-8?B?QmHFn2FyIFXEn3Vy?= <basarugur@gmail.com>
Date:   Tue, 9 Nov 2021 22:14:55 +0100
Message-ID: <CAPNYHkm5Qp8HQGU5_6DXc7xpCrdGgEin0WYAxbRNOkKW0j2ERQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] diffcore-rename: simplify limit check
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

First post on Git mailing list, to provide a comment on a patch. Hope
this works.

In cases where the `rename_limit` is already greater than 65535, the
`st_mult(rename_limit, rename_limit)` multiplication overflows and
process halts. But I don't think an 'overflow error' is very helpful
for the users in understanding what is wrong with their configuration;
i.e. `diff.renameLimit` documentation says nothing about a 'maximum
allowed value'. I would either clamp it to a reasonable range, or
inform the users about the limits, or maybe both.

Cheers,

-- 
Basar
