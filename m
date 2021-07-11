Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFFBC07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 04:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 239FB6127C
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 04:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhGKE5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 00:57:00 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:42844 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhGKE5A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 00:57:00 -0400
Received: by mail-ej1-f54.google.com with SMTP id bg14so25824452ejb.9
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 21:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVemYDgzh2Z0H7Rk/h1+DuiprWasndeZpuYhTwXan0g=;
        b=dTZu1TydO2tEngXEI/my2iUnrOqMObegl0SBK7gWqNszYXve2vjgqXldxWVkGTHe9w
         bLbYNjQpv6mMj65eAVLkjQ90spZW53b2F8QmljlhClsAykaYbW/mft9ux6FiWNgoX7Tx
         K+TnS1ZG6UpsqrxOFRR1JM2OLDiCmj9+NTLYP0zU9zkPBvJ7erUw2LHGZxw6/kORinfj
         RZ+YYyaxd9Xx5ginzpMbhJrtaCe43q2TCemylaktLSy93vaAW4m93lymc+EF+K92Dyl4
         ZFyaIDgNPNFRe47s++j+qJ0K07CWOlXgrzoDfoRE2gH/Mt7B5uZddEP4mpzlNwIm4mL2
         TLXA==
X-Gm-Message-State: AOAM533zzzl/yXYoyO2DyX4iLB496jsvwSJ6q3uP3+ruPy9zFKwR5Ntd
        fNfmm7MDMBLVYOcpZ63jyXOLSbZz4IM5huNZGk4=
X-Google-Smtp-Source: ABdhPJyIMbuG5I+cswfmP/OZa7K6THxH199hcI2ReIPML/tLoglkH+9aGFzlLGLjaDdTRPMWmstfWrlT7f/tf8tfP/w=
X-Received: by 2002:a17:906:4a0a:: with SMTP id w10mr5169717eju.371.1625979252374;
 Sat, 10 Jul 2021 21:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com> <ee0969429cba837ba6d79712706c899d5b231798.1625964399.git.gitgitgadget@gmail.com>
In-Reply-To: <ee0969429cba837ba6d79712706c899d5b231798.1625964399.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 11 Jul 2021 00:54:01 -0400
Message-ID: <CAPig+cTFoLaUd8+VRsaJuP24C7fnbTTFx0i7PizyasES7K2jdg@mail.gmail.com>
Subject: Re: [PATCH 2/3] doc: document the special handling of -l0
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 10, 2021 at 8:46 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> As noted in commit 89973554b52c (diffcore-rename: make diff-tree -l0
> mean -l<large>, 2017-11-29), -l0 has had a magical special "large"
> historical value associated with it.  Document this value, particularly
> since it is not large enough for some uses -- see commit 9f7e4bfa3b6d
> (diff: remove silent clamp of renameLimit, 2017-11-13).
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> @@ -595,6 +595,9 @@ of a delete/create pair.
>         specified number.  Defaults to diff.renameLimit, or if that is
>         also unspecified, to 400.
>
> +       Note that for backward compatibility reasons, a value of 0 is treated
> +       the same as if 32767 was passed.

To get this to format properly, you'll need to drop the indentation
from the new paragraph and replace the blank line preceding it with a
line containing just a plus (`+`).
