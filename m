Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814F7C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 08:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E49E619D5
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 08:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhCXIbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 04:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhCXIbL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 04:31:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C940FC061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 01:31:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b16so26647882eds.7
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 01:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=W7DvJQ3FhyVp1QjusjD2Rv+BB96ELBe3vF/LYC+LPFA=;
        b=CjTaf3dxzEapjaC26Fn0n6QaDOzwhFVuyYci52Z9d2rWzFaFum7tKyAKuHToIF+k4c
         C7QmJlvrXrYJdMn3doKRwOUtVUU4ZxzquYNjv5zdLEco3NMsO/JTe9//6DCaq5H6IviQ
         rGNTaCIga/wHrM7kb7NFV4QgUtcGBY1SFSHWysDu1vqT/tfldO2cJhyOxYApCk/xMxaS
         HtdtzW1aLL6YU/2RBwJoGYlZp+cOYoUlUWop0tJytkoG65hO3GLq4Qtq7awQF3AADMKM
         AfZfIrIOTXmeRs5r2f9qmfOHLIhJZrsqDdlEYbZCvEsRv0hNH7m/Dq3RyTqMSFrTIq/F
         XJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=W7DvJQ3FhyVp1QjusjD2Rv+BB96ELBe3vF/LYC+LPFA=;
        b=jSn/19F1YLqOYkTSMMxXMirAKBa0JOzmZMOZIlW6UWjebjWgIA7LXJPXlboHDWZ/DJ
         3tDxTkNvKbuzkppp9ftAJ+JauKa85wm/cr8DS7pdOiAjvlS8Z0lF0UhjcxQZtW747xg8
         MZu8LCXMVH+zcKtmkojS2jliuFD1pbRBa22ipGn6fGP9lqLlYbafCnjxnR+OYUHEKfw9
         gWt3MoiA1ICRwmGbdwsFvgj523V67t1f60409VBI7qZQUr7L7xJUG0+8gDvb8F/D9iMP
         AhgPg0jxcFsI7y37Ay3PcBcEtaCiahHgN3X88rggsz3WdLv2RGlESQu0rT2fbSyFkKo4
         /81Q==
X-Gm-Message-State: AOAM531LoIHyFv3JHtyQoYDbTLayBSpcnA2AyzvgMuGyeOImbJ2F6KI4
        r+BOnQFOaFZfzcMjMaN4cBcswcMCik1/yX/M7m+ER2aIs8sgKQ==
X-Google-Smtp-Source: ABdhPJz5HBXDuzhRO9zxFJcj8v8Jc9FXu4b2XxguoFQVVIXVQjvcYak6vgNzQsKhQIhat4J+XOJwhTgqgkePQkdYpfc=
X-Received: by 2002:a05:6402:48c:: with SMTP id k12mr2162098edv.237.1616574669406;
 Wed, 24 Mar 2021 01:31:09 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 24 Mar 2021 09:30:58 +0100
Message-ID: <CAP8UFD1qwDmaGqbJrfKznt33aG4u94RkJdQy3AdjJfObc=rLLw@mail.gmail.com>
Subject: Draft of Git Rev News edition 73
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        Yaron Wittenstein <yaron.wittenstein@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-73.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/481

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Saturday
March 27th.

Thanks,
Christian.
