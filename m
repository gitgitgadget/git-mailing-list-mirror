Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298D2C433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 05:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF0560E0B
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 05:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhD1F7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 01:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbhD1F67 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 01:58:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3600EC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 22:58:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r12so92787680ejr.5
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 22:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9zl6YtPRNuJq9VNvXH8CQRo+yAKiQ66q6k80TziDo2c=;
        b=GHWTz5QkJiliWC2DZAZcu2IXL0vObvg7dgahWueNYcp0WXrl6bzlruDnihbmubrUM/
         HXsnUDCNlFvPvYzI4dGkLcKqikCpHSVUpu2IIw9jjfSr1D46jKHNE8epOxnTBtoAZc1z
         ePtdoAOpKuQrrWUy7xDr9YBq/JF0fLbZ6dtprLPNcv4mvWBniCgI3IgratSg63MYz0XN
         9GI/YKkKtObak45PZX6E8e012+vwO/6V86uocY58qeAULlW+IwJPuW9eFP1IergGSpiw
         tdAyRTmqBjmTaixvYVflo9YkqgEtt90AkwkOol4vapy7hJmnAGqWQUGKblet+BFYZA0C
         +rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9zl6YtPRNuJq9VNvXH8CQRo+yAKiQ66q6k80TziDo2c=;
        b=ID/rPXol7oSsQnuhV43rBPqOdxMqdeklcsvAYrQbzIBhVwl2QSgxkT7UAN/RhzTZTn
         3xQIZ54kwqLwVf/yc8V59kFURIRcaUDMI5q+Lbm4t0syG/pmKWqrfuBkzxnrGccmlzWz
         8g1LJn8w8eOOmrkjZihqLaMqUg4Lvk9MMUqdWL6Kq1eezvVuv4wMl4J9Nrf/gszQ8llL
         bm74b5m8scQ8AzXQGcm6PNoAJk24iCNmnRozWIkI4CUlhrr3YgnAR6IQCUIK7nhlFjix
         Fnpaq+hvgCw3V3sHdYQlAyKQccKRxKARAbdPHH22nfsBFxim/7Ot/z98nWKdgAYNDNLn
         uGGw==
X-Gm-Message-State: AOAM533D1C3HnA3XLI8aVjHJm1qKvNDrF/xk2iV4TEnQj+aP45or0RTC
        xE8eSQJyT93Ktycdw4ggWG6Rrmi4ENGwxjKOdTNSlL9yejfNSQ==
X-Google-Smtp-Source: ABdhPJzg9neSlO4rZXIIIQdv9+vU2BNPwyquTGXBg2C0DkGk1Hchw+BXgwX5BYifgqDvB1vb6UW2r1Ctlo9nH9KDuUc=
X-Received: by 2002:a17:906:a295:: with SMTP id i21mr521666ejz.160.1619589493738;
 Tue, 27 Apr 2021 22:58:13 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 28 Apr 2021 07:58:02 +0200
Message-ID: <CAP8UFD1RfJcKQMtVqOZX0eTrmu_Oua-vaDKygDu_d3bR3DE+iw@mail.gmail.com>
Subject: Draft of Git Rev News edition 74
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sven Strickroth <email@cs-ware.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-74.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/484

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Friday
April 30th.

Thanks,
Christian.
