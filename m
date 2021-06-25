Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FED9C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 20:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D694F6194F
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 20:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFYUtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 16:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFYUtb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 16:49:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C49C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 13:47:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id yy20so9307174ejb.6
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 13:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gNQ7PQMeWKlXtoUaKI5uNpTz7aS6R3hSJ12yS2MubYk=;
        b=qlYZrXH1Wu2a3QtNAo7tFtAfLOYTEEAvjJgDSv+CtVexYmpWMfzpHniFQtgVNH6ShY
         P/q1ZtfnIh2qc4cQYgREcF6a+RY7ZIU5e/MsMV2Cf7RWDiZLWK3eyaDiEcgN4ohDycxP
         XvmJKKCDaC63l5p2OxLztRI52uqNm3l0EUUoGoHGtgc6c1rK9Um0Q7bAsDC9lmq3J2Wi
         LZqT5AY+Mw+KmQk8sh+jylWdLFhiDB+i9ytqCSF0eOqROxY1okrAU3tI020d40clkX7r
         3jfBubF02nsjUS8x5xHLNVCaETkuB+iDyrHneZoL6h+c0w9K8lQTWsfZ2Tb3VXtqzDnB
         J0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gNQ7PQMeWKlXtoUaKI5uNpTz7aS6R3hSJ12yS2MubYk=;
        b=KpXYFY3Da9Qs0m3gXuSN4RViYpVLZ5aeV9V5Z1GN5nxYmUqszcdhIxNKW+0FWdsEP8
         d3ZVOsZHE3PzNbYygFTF6s6Mw39Akul6UED095Ekeat1iDfNdUOQKNDHB+JKPEyGaIsQ
         +WnOeTCLz3VIOplxupamGCWKz6PlfF9pOPDXRimJYhz+kjdBqTlXTsn/BGg/7qxd5dHJ
         NA0e5/MkWqfERjPUoCskWLZaKVeOne75VfKVWWa84a8PRsKz+f2FX7ZXCiZDCp+deltD
         kAQ08MJNKcAng5BSAmTYP8picS2Nm8csmK8BJXGhyAaA1mcfEkpXTKsPwBaS5W/3IZHz
         bw4w==
X-Gm-Message-State: AOAM533qt3oIhBKGqwjD18pErluvq8tdGWuwkC21HkkqStx7X38/JGdO
        EhWhKG1Wvny3z6IXA1hMGTE2dMmDUOhY7Ip459+SHUGvZ4KFBw==
X-Google-Smtp-Source: ABdhPJwfzda/iIKdB4qvaDMZTVAGs72JDlsPb+Lcy1inxiuL0LMldlr0nzHhxNLmovmUelyJAIgYhHWRAnveczFNVhU=
X-Received: by 2002:a17:906:26c7:: with SMTP id u7mr12831701ejc.211.1624654027295;
 Fri, 25 Jun 2021 13:47:07 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 25 Jun 2021 22:46:56 +0200
Message-ID: <CAP8UFD3PLzvymUPMh2Pd7q=_ERd+36WDMiRnXZUXZOKSC5Kttw@mail.gmail.com>
Subject: Draft of Git Rev News edition 76
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jeff Palmer <jeff@jeffandjackie.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-76.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/505

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Sunday June 27th.

Thanks,
Christian.
