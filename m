Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989CD1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 20:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbfJPUHc (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 16:07:32 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33469 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387601AbfJPUHc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 16:07:32 -0400
Received: by mail-vs1-f67.google.com with SMTP id p13so27632vso.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+33cFGycmFgNDXAfrzF+UFmeSO2HSktxhPG11b6yVw=;
        b=Y/mL4SS5Hswm1GxDKRRebwN6ICRSsPxgOjF8eTQfvJLDgDGbmE01uA8CpKLRpPYE8Q
         HxllLP8gWbStOhM+ZNZAmsQGYhQLBNtNyl6y3C5u9IIurwzDLeAt4ri4/DAcQLxg/GQL
         T7yVMqv6E5bX2wt9ELW/ws9iZIRzzWOjpkOxiKIEbJ/RSnsIGLwYz1LorNaH+q/A9ux7
         S+BthNckZEh1kSgoidUWuZIm7S563r/G+/KU393ZpKHUCf5GvBlMjHPEAxEI4b/jr4UZ
         L7jxJYQibCVP8HsBcaSCpvt73G1HEhJXlMe+1y2ugPgnC+fuNGtL7JqOvbWRnwynn7Pd
         S3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+33cFGycmFgNDXAfrzF+UFmeSO2HSktxhPG11b6yVw=;
        b=bxMV825CGb63sakfHAWZzfjlJ5aFu5rTidqMat9Lx0Mq8fYpZq3OXySmY1dqcVK52c
         Y32Sz/JD+BYSZUI8KRqHRssL+qpyGNialdHBAPQ7oTCTvUieGl7daWoct6lQhcmhCn89
         nM+kGxXN1le0kOjWi1OVqIYgZVfpFXpyaavdYvTBR+gZJNecD1w/NYuSTszc3N03X86b
         Qm+bQJPnHbUeXfzUc+/sOjMGi/ZpJhPRg9lkm0UvtKSEEcQynpe4rXhpwgG0IVS0KyH/
         hVeAmZimE4hNFhytvWnztpWLqt182PrFx/DBa8sl8QkBAW2bbeJ+j4DWHn7MqlmUFQz0
         wUvg==
X-Gm-Message-State: APjAAAU5cMYGKwSNk42YRb1NcrddwepQfNiVR+fnShOwgpiWUbsPS5Oa
        NQ6pIRVWTGnR2Oqd6zTVlE0yIKi7pVRQzZJJUrzKAA==
X-Google-Smtp-Source: APXvYqyw/jZ85o721+XbYCr22r3WakQx5/cqkpHXxOXbq2sZ4Q0mwY/WXcMFHql63B0jtJ5Kp5M/YmFR4NVsADMcBDQ=
X-Received: by 2002:a67:f84d:: with SMTP id b13mr24185876vsp.136.1571256451298;
 Wed, 16 Oct 2019 13:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.v3.git.gitgitgadget@gmail.com> <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Oct 2019 13:07:20 -0700
Message-ID: <CABPp-BHkjx-qVNXAF4eiwa2Uer0_=epqhfOTMyigU_MpJ8xk4w@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] New sparse-checkout builtin and "cone" mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 6:56 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Updates in V4:
>
>  * Updated hashmap API usage to respond to ew/hashmap
>
>
>  * Responded to detailed review by Elijah. Thanks!
>
>
>  * Marked the feature as experimental in git-sparse-checkout.txt the same
>    way that git-switch.txt does.

I read through the range-diff, and it all looks good to me other than
one issue I flagged on patch 1.

Nice work!
