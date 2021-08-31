Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81801C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A2C360241
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbhHaNvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbhHaNvv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:51:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6D9C061796
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:50:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n27so38929805eja.5
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tbhRvibzBSBznf/LuibQb5PWQK+K8tP/PIY4K7ZWTMA=;
        b=oRmujT1oOw6j08IVXDJU2wcRhYaSx634S8R+EYEWEYCstWPCPD4uAlq8mZyZxitO/m
         8c099Sygj7q/CZg+9sOWYRKwA2TudCKuEXvaK2mqTuykGxJWy2O0qLraTi2TmiXL7Kij
         1VLvpKm7XNl7gUEi/gP8ouhz8xz29rZo31CLgEU750X6t92LmFaxZ9WP9oURIwbfV98P
         S8K2xPdVzVRUwD2QcgPuRux/YrmVi0GT+5EFPh+FEXfOLS7KRMpbEf7vlz/2BPC7BOxg
         p6ONMgEk2AqLeCXPPJ4kdvMKyFonPUuv0RLIH04r/JgyY5soyRwo8vsmugtXuPDFeC5o
         D41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tbhRvibzBSBznf/LuibQb5PWQK+K8tP/PIY4K7ZWTMA=;
        b=eTWpY3dqWWLeQT2yUXWaU/XFwB+TELYJc06Z0bP43c06meBiKIMOZvB25MYDQ4+Tuh
         s/GNSg4ZnUaM75/zPL8cnrdAuloagv5mEyHzLS+vw5WV1OPi5JsfVA3bMRxSX7ucdhcB
         L7SCx9lxgcqYfy/GrrCLCc3eFTJK8vc4rXQ98YpCszK5TW3Yf0hRr4aFSC6KN0BQj7nJ
         tv+lG7mldqCuZDve756quevhqx64bOwotRjlCc18i+mDGXl97DKgTbtI24VmNm9OJBch
         OZlHkJA9EelX/lIXjoROrBqXsTE/IhWFLqNOmyTfoRCbZ5EHWS6tbLmMuFNnqIKik2MA
         uFrw==
X-Gm-Message-State: AOAM532HHx5uCfcPcWq22wpuwH0A7rVYQZAbHhmJop0ZwYPGyyotZtMs
        pcVw30Ruu2dtIiXoMQU47ybseZFBIDqfW1DujZFc8ZBrZ7Q=
X-Google-Smtp-Source: ABdhPJz+vPG9dDV7QYwhIZWZ32kYd+S8Qwg0/BqciIsHQdvV38WFmqIB0wD0ktLy5JhvZrQhKQJL/19K8T04GWQy/bo=
X-Received: by 2002:a17:907:7f29:: with SMTP id qf41mr29130337ejc.211.1630417854032;
 Tue, 31 Aug 2021 06:50:54 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 31 Aug 2021 15:50:43 +0200
Message-ID: <CAP8UFD1Vp8GMwHJtF-6Uen8ye1g4YJEN_p8c-HTr6VURDwR7Xg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 78
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        German Lashevich <german.lashevich@gmail.com>,
        Philip Oakley <philipoakley@iee.email>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 78th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2021/08/31/edition-78/

Thanks a lot to Elijah Newren and Philip Oakley who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

https://github.com/git/git.github.io/issues/520
