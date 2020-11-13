Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6005AC55ABD
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 20:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB2F2223C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 20:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgKMUr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 15:47:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36589 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMUr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 15:47:28 -0500
Received: by mail-ed1-f67.google.com with SMTP id o20so12337320eds.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 12:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNDC3Hua8zbfHSBQKwsCKKvVO6gijXDxZNRCAE6S684=;
        b=GifN2Y1mS1tn22RpBrejQKxtrdli4vEw+YAKGKx2kmH+857ObtBf8LtB0hnUJvE1lF
         kLdZikr18ibVCc0pQxctuHd0i4X4QBAd5qKDIM0PtOJ0eVKmDMocLDr+i2Yr6z2zqpuP
         V2auzMECHo17xHqDrMycCcFXd67g7xVeoyGEBvHl8u71Nyc2J+BcXY8t5K2zhDheXK0+
         F10F3O5H7bLjLSkVRRUjQ0gNuiq2BLTKNGJ8MmNOX74R3h1XOD+8+B0B8HRjSqTeK2Tw
         JaWWUgwjCvxWMA3l/BR+CrA3hD2QjOd9K0Ro0aiGK8msyvNgq6KCY6e4GxFovsBOyw/h
         PjZw==
X-Gm-Message-State: AOAM531XUNH6xD5WhVgGcu6ikiZQ6sU7WnG/sZWVdoFrwXbhOP1DbHc/
        38ml6aFSfif1ow6O3GuOnFGdPsv/Ri/6zItVgH4=
X-Google-Smtp-Source: ABdhPJyIhSr7QqrqbYmxyrV1LlNqmPuBLVGwDFdaEbC6sSImCVBOibObieeN53bBiH3QKJ7BzdcyYLEr/RJl5ZmUOtA=
X-Received: by 2002:aa7:d84a:: with SMTP id f10mr4576123eds.163.1605300445859;
 Fri, 13 Nov 2020 12:47:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com> <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 13 Nov 2020 15:47:15 -0500
Message-ID: <CAPig+cRPKZGR0XKv4vwtP-xpzYDpB6PL-=Q7weeWtTbDG7o3vQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Maintenance IV: Platform-specific background maintenance
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 9:00 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>  * This actually includes the feedback responses I had intended for v2.
>    Sorry about that!

I forgot to mention a couple things when reviewing the patches
individually, so I'll point them out here...

>      +    at [2]. The current design does not preclude a future version that
>      +    detects the available fatures of 'launchctl' to use the older

s/fatures/features/

>      -+ test_cmp expect args
>      ++ test_line_count = 0 actual

These days, we usually say:

    test_must_be_empty actual
