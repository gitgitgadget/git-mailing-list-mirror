Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74356C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB716198E
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhC2VZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhC2VZO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 17:25:14 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66684C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 14:25:14 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w70so14512027oie.0
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 14:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Jckh65ghZpvIeb9wV+9i1uiO1BKQ67M/Y9HTFlj1CU=;
        b=KE2MsTj+iLX0u/gTlI4t2rUNgiuvUJH/yq1cnftSnZNp1A224c5xU9ADM2faJsGsmZ
         GFZkvBN31BJaCgJpizNNS/XGxKnoGV4z7jQImBRJFXONJRV4JlDov312nBRYBJrKnxwT
         nZTXy+89GLXb4l9pFWeS+VJ55dEyRqajDXxBMs9UiUrF1kzM9NDT5rHcu2RoEPnmx6Ej
         K5F3zTTcCygFyvHV9npkRCiLWrPzQ4iTf/J77TXbIreyKU4JBIAODkoNPCz1RcRSSxPD
         k9sOaMGXNbT2Ib2GNeUolY1oOY9koIqqZ5JctUpoVPqXixa7wsv/Qbn8t6bINhzvWCay
         rLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Jckh65ghZpvIeb9wV+9i1uiO1BKQ67M/Y9HTFlj1CU=;
        b=OIDduiHf1KurboySsajO2xJNu7aj3lJSyOTUBZBCTiILFf4qFnJROHWq83myu59lIS
         Ub4vYmL/ude7YIhTbMbvNb5voUFGIkPeEfZ47nA/ydiizZlPRsunEIiGUO0C9mlPgbBZ
         kurOAiauScHkH3swEtKEwqj01YxukEB/3LOTTCG5YI4bKDHFT3o+FTwGpWGtH6K4Npa+
         T5nQeIv018ar6IxaerLZSO3MZ2H8mvz5Vv58AOus4pj+FdtAJI57+/dtdti/7GSVRWi5
         3NRcQakANN2YEUucCV8IHASe1cflYQUzrfmHmC7LKMX7DxCMGNOlFJH3X26/xdpVA9x9
         kH9Q==
X-Gm-Message-State: AOAM530A70roxOY9MoYM2zqcIuaw8PPwXkjhIBQBaGx77GweV/d8bssd
        TZkw4KtyM3HvJw21pgLEOjTEHH10VwofxNrd4o0=
X-Google-Smtp-Source: ABdhPJziSWu4z92fTEv2Yqk0BQyY8BISfoRZenoUdR/4f3ldoFyWtu63B0DNOo5wL036GacYa7y1Z+QoASG3bTfkDqY=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr749986oij.167.1617053113619;
 Mon, 29 Mar 2021 14:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com> <440980f5-81c9-4201-61a4-29acb0346c65@gmail.com>
In-Reply-To: <440980f5-81c9-4201-61a4-29acb0346c65@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Mar 2021 14:25:02 -0700
Message-ID: <CABPp-BF5fWanFcgOc1Dq0uT8cYCFjiaSO6i4PF9a4Xpg3vEf7Q@mail.gmail.com>
Subject: Re: [PATCH] sequencer: fix edit handling for cherry-pick and revert messages
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 2:23 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 26/03/2021 07:16, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > save_opts() should save any non-default values.  It was intended to do
> > this, but since most options in struct replay_opts default to 0, it only
> > saved non-zero values.  Unfortunatley,
>
> s/Unfortunatley/Unfortunately/

Thanks, will fix.

> also s/iff/if/ in a few places below.

I want behavior for both isatty(0) and !isatty(0) to be specified by
the table, so iff is correct; see
https://www.lexico.com/definition/iff

[...]
> > Make continue_single_pick() (which is the function responsible for
> > resuming after conflict cases)
>
> It might be worth emphasizing that despite its name
> continue_single_pick() is used to commit conflict resolutions regardless
> of the number of picks - I had to check the code to see what it was
> doing in the multi-pick case.

I'll edit the description to make this more clear.

[...]
> These tests check that the options are saved but do not check what we do
> with them. It would be good to have a test that checked we actually open
> the editor when we should to test the new code in
> continue_single_pick(), however as that code calls isatty() that may be
> tricky
>
>
> I was surprised how big a change was required to the existing code but
> it seems this is surprising tricky to get right - I cannot think of any
> simplifications.

Thanks for taking a look.  :-)
