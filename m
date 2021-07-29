Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFF8C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 07:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD67D60F00
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 07:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbhG2HAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 03:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbhG2HAN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 03:00:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E36C061757
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 00:00:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x14so6706249edr.12
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 00:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JwCygwv2q7zR+iYbnzJYN5ZNUw3FGjbeclgZYyM0jH4=;
        b=PYefZBqbSsbF1+Ubsv30EYMbVhHcBaNovafZBu25++Ch2IApT2MyXeHEWDmHYc2FGw
         MxvlbZynkIvbVUouE7Gbw2rH+Qhs13VFgHLpWdNJu50mTDFhwqhDVtIVlqwmctR+qCZ9
         jj/hOl4yHfaylQf8JQ1i7g29VcelGBs8vCG5QSGLADGRjn0IlGF7mI5cdLQMstTKn1kc
         OIrHhR1zrTY3RTlVVZk6ABliZ9OQQZOsxurFmVKdUxQBqtzYRddgpOyJcs0dfzhNYHRo
         c7nf4arWghTncxtjspgSf5LmTojkbgHtp6y02v4TuVx6SKE1wLsjuWzTffm3Tr5UldFL
         +SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JwCygwv2q7zR+iYbnzJYN5ZNUw3FGjbeclgZYyM0jH4=;
        b=uXFob4YulyR5VzQDU1PKLHlHjvVkfc/MlMLq+o+d0RSYEd1X3YFK2BL8mOh3CHcY5K
         bffmy4g7YnK7vUMyjUo7mgYqgI/T2GTr0PCKJOy15Zv/LUvsmF8G9oczr7U8/OE+ihkp
         boMEGDTO33836l0KlSsW2sYpUT+SwM/UKhOmaclOGccmWyKO7YTHyDvnlIpG+WwvBRYN
         sWpGXl/+pdnQjx70bhPbxFvdiep9w8DAVStCSoX/gF7m9qVTOQrh3Q1Nv8bTxNMsSroS
         rP0OyCAuY6KkQZjLgSI9iqIn/Sowyfy/OF6uRrhvqtlK8XZPuARA4Nynhs0DPV4oKDER
         bLrA==
X-Gm-Message-State: AOAM531oWsF+y0oDJe3D8yPs2Pw12+XutvhsqMyVQlxH+nDt6QE1zsRS
        GsZT+EXRvgHa10DZljWGzL9HNGB89IvHQqFTEK9a07Nua/DWqw==
X-Google-Smtp-Source: ABdhPJxPDfYlwjmxo8/gIDpiYqGfW6TX3gGeykHw5GRZF3ivuepJBcorC5RRFV1/CvEoXAcJ75iiGh3iiBTY+vFzNEc=
X-Received: by 2002:a05:6402:1289:: with SMTP id w9mr4319015edv.127.1627542006450;
 Thu, 29 Jul 2021 00:00:06 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 29 Jul 2021 08:59:55 +0200
Message-ID: <CAP8UFD38P_PYf3NzB2ULHbOTFNUCDXuZzasKKV5Cqgg7PrgQdg@mail.gmail.com>
Subject: Draft of Git Rev News edition 77
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-77.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/517

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Saturday July 31st.

Thanks,
Christian.
