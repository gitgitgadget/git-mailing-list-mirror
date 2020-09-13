Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA672C43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 21:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAD52098B
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 21:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgIMVKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 17:10:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46113 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgIMVKq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 17:10:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id a12so15612477eds.13
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 14:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMoHt4q5s1YaNk5ceOJJspTHPR5B6MPft9DC3QVRxrY=;
        b=qu8vbcIwH04WuMRHFGarzEV2LyRmDt+KDpg0E0W7K6b4P9LELhGyZehs5leDqRTPjm
         s7IEqBhaSsmlG23YTtCbS0sQgXjWjYu8u3doVsuoCXYP1LrTnh0yWhSnBtg89AKs2nEf
         GCZid3aZe5A3qxMETFY/GfY3oFAA5AjbzUtnjcvvNQZa3Fv0BDaPna6YVFtEEb99iXp7
         VNY8gQqZGJOi39HnEKz3dVud+eHSSyyj1ex6nF/okVW8JA81jU6m2fqHLTpKZ/FN+rdW
         jXsorS7lBnSI07NpDt1AXyBNaSXkFzuP0DuJRkttJhVo5u1Azk0x8nhz+gXpSCTKwpIC
         MO3Q==
X-Gm-Message-State: AOAM532eMa8QbVc6zYO+nHlW3tRCpOp68/2mse2axQITtVwaO1Rqjxhm
        MS1XbJJh+umdxWLHIvKUzkrFPjL/qOg7AcgMpOM=
X-Google-Smtp-Source: ABdhPJxZ16+8Y/AYitu+yJdRIkdRfUivqGbfhxWwz/7n1X+ubxwuRqAt9zalnpP4y6wxm3UkunTXYtKyd4O7j9dvaZk=
X-Received: by 2002:a05:6402:17da:: with SMTP id s26mr14277728edy.221.1600031443807;
 Sun, 13 Sep 2020 14:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200911185754.64173-3-alipman88@gmail.com> <20200913193140.66906-1-alipman88@gmail.com>
 <20200913193140.66906-3-alipman88@gmail.com>
In-Reply-To: <20200913193140.66906-3-alipman88@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 Sep 2020 17:10:33 -0400
Message-ID: <CAPig+cRaz+HPNW_WFX7UqcqtRwG_Td59LkXWF6HHoYOO1M6=bg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] Doc: cover multiple contains/no-contains filters
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 13, 2020 at 3:32 PM Aaron Lipman <alipman88@gmail.com> wrote:
> Update documentation for "git branch", "git for-each-ref" and "git tag"
> with notes explaining what happens when passed multiple --contains or
> --no-contains filters, e.g.:
>
>   When combining multiple `--contains` and `--no-contains` filters,
>   `git for-each-ref` shows refs containing at least one of the named
>   `--contains` commits and none of the named `--no-contains` commits.

We normally avoid repeating in the commit message what the patch
itself already says. The first paragraph alone (without the example
text) would be plenty sufficient. (Not itself worth a re-roll,
though.)

> This behavior is useful to document prior to enabling multiple
> merged/no-merged filters, in order to demonstrate consistent behavior
> between merged/no-merged and contains/no-contains filters.
> ---

Missing sign-off.

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> @@ -370,6 +370,10 @@ serve four related but different purposes:
> +When combining multiple `--contains` and `--no-contains` filters,
> +`git branch` shows branches containing at least one of the named
> +`--contains` commits and none of the named `--no-contains` commits.

This is repeated nearly verbatim in the other two documentation pages.
It makes one wonder if it can be generalized and placed in its own
file which is included in the other documents via
`include::contains.txt[]`. Perhaps like this:

    When combining multiple `--contains` and `--no-contains` filters,
    `git branch` shows references containing at least one of the named
    `--contains` commits and none of the named `--no-contains`
    commits.

But perhaps that's too generic?
