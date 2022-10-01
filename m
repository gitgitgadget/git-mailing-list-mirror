Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C087FC433FE
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 20:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJAUaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 16:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiJAUad (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 16:30:33 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A52F248C7
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 13:30:29 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-35711e5a5ceso34638797b3.13
        for <git@vger.kernel.org>; Sat, 01 Oct 2022 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=Vfyz+31vE121kcN5/zVULJQ1tRjBUEY2KW4MnELlm44=;
        b=O6fDdNnVDj/X0KWC6HIX8fAziGUUUiYRcdUM8gvSfFz5m0VI851gyw7n1bboQelW+x
         0zWALeHcEOqQthS1NrZxiFMb0XENw0WDkWLC8HR26lW3CIzQt/a7Vy0m/ozxc8GfyWyg
         EyJnNcKvfv9aBWlodntmBd+HvJd2GhuljU0090SFEgxOv6JWDFW3UTm2OdLwgV3fhlpj
         rLjP6riki/orCrUaDaAA2CcPG4hKMgYUHJ0dh804K2W3NoBpotOowrVu1S/xkCYwCptH
         hbA15w9+42IkoyipmUDcTOHJ4W5LLuvxUt4nUaRGAQI8FAYsmxMMRq5lNKI0LeER7a5l
         3sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Vfyz+31vE121kcN5/zVULJQ1tRjBUEY2KW4MnELlm44=;
        b=UdWw08VcfMkUqDif1p+ZnIDHr3juM2pVILkCoZ5A5WHg0TTQkKys3ps7sq4x3AuvxW
         ykkwW7s9/PyslQJpwBgxb4maXWX8ldr3YeAywCBQtq+nAkOar/ZdvGGRboBFAa/OPi+K
         W3DUMkRYgRN989gTnx1iAPJHSPO6/dV9iK5cvLohM5PEmMM85J+V8NbBnwFgbaBXVAwQ
         iv/+8j6VAmSYiAfwsS0bZYm4ETVL1RQSaOvhzjFOyu2DIXleMSqAjTOHr+6FqC1wpGhJ
         ymQzP7AjEvCEqQulyXGYDxTYztArlvlFa7Y6cxKIlepashjNtqhP4nhoO8ukWNPfRrIc
         3I9Q==
X-Gm-Message-State: ACrzQf27H5DUi907fvU+KPZawIBT3lnjkYlrCnuO3O/IDi4h+6Glc1Zu
        EWzQYtbVVQsp7AOkkrC9/lDDnvYQAoOqdiLRRdBgQx/YlNPQNA==
X-Google-Smtp-Source: AMsMyM6KytmNtBMbFWxiBkI8WkpTvy6THG8s/bCmg5fsE6eix++ArnR8kCiRlpHLJCjqzFb/jVVgQQve0LVrg2JjZBY=
X-Received: by 2002:a0d:f886:0:b0:34d:3ea:1adc with SMTP id
 i128-20020a0df886000000b0034d03ea1adcmr14244367ywf.130.1664656228000; Sat, 01
 Oct 2022 13:30:28 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 1 Oct 2022 22:30:16 +0200
Message-ID: <CAP8UFD0_TLWTHpjwxgqAjBLpvBo5BntvpwRLqXrndYosEj7tHw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 91
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        lwn@lwn.net, Glen Choo <chooglen@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        Bruno Brito <bruno@git-tower.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tim Hockin <thockin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 91st edition of Git Rev News is now published:

  https://git.github.io/rev_news/2022/09/30/edition-91/

Thanks a lot to Peff (Jeff King), Bruno Brito and Luca Milanesio who
helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/602
