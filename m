Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118001F461
	for <e@80x24.org>; Mon, 22 Jul 2019 22:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbfGVWFM (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 18:05:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45791 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfGVWFM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 18:05:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id x19so36053001eda.12
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nYuZQFDluY71e046aBU3Y/r/3li0i/1xCxqTZAhFGJI=;
        b=Xa8vvELQHaJ6vtiXczkiNA3EmEPWX2E9HXyakT47SyRshzt7ZJlKu959f7JuMJm9mt
         dldXn6EJqsae6a+9Q0LdyJByCj2gTTcab3ovoAdmBfWlw2EQrJaS4tRh2HMNCbYfDCpH
         dEun7aKUb38j9jyex1M826s8vW14JHftL6tFKiBTl9s0WXwyv7ThC9A7yjKPYhjsFkHM
         Q4a+iZ3u4n7J86DubdZAWBSEGZgbpdJDPUCa0WZI0LwAdJ6B6kyemkPWHsAspyT5yt/E
         EPVpEqchqTbUv0tJGUFHLTEJ2FeWe8Djdlo6pN0QTllJAqlTgEenZ80qEEWLly2Op+p8
         HLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nYuZQFDluY71e046aBU3Y/r/3li0i/1xCxqTZAhFGJI=;
        b=Qu7tz2dDRGBvVZ/Mm7BtdSIntqUqMSdUi6x3B0Z0EPfCfc5NFYDznkh1rAwUyDLWHN
         z83gFNMxitNfTHrKZe9LxInEGOS+jrRqNFky1Gmd4bIdR/LiH5VHBoFXHZjH1OxNBy6F
         qy5l/HEJguEOBveN1ABONiPhrjbLiLa0d/aVTVKzYqsyOR974+lWSl+aT2uIYpJm7wGe
         xWTwLQrDgx2LI3MYJsxgw94l9YZe3yZshMF9pD8nJ1EH1cLFTVg03V2j+1C/19Bwrhdk
         WAys6UUyY3aC9NsveDBQYFYpSRA0Qk1URvl7w0AL204c3ilEB2qvZWcfqkxLncCiYIhU
         NNwg==
X-Gm-Message-State: APjAAAVy4lRAx1uKieuSPSS18KeeUk8nEtUVYhULpX1Dn+r80e63VsmY
        zUbxujLX0XXV1W3sFYeQQZ1M8ixDnHonu3/MyDVoFjPDE9w=
X-Google-Smtp-Source: APXvYqzT9d6K6EFg/6P+ZpvZB8wXOwKsi4tQ5X7BKaT+awEZsGEMRbgJfEcR4fdMI8o11fR7F6G8CVGb894NcWWyu8g=
X-Received: by 2002:a17:906:6bd4:: with SMTP id t20mr52648082ejs.294.1563833110416;
 Mon, 22 Jul 2019 15:05:10 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 23 Jul 2019 00:04:59 +0200
Message-ID: <CAP8UFD2b1xj6GVaUCmGbKE8toQ5yG0x-umCHhZOH7Q2jyv_E8A@mail.gmail.com>
Subject: Draft of Git Rev News edition 53
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        jaime.rivas@synergy.page
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-53.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/384

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition late on Wednesday
July 24th.

Thanks,
Christian.
