Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7792F1F405
	for <e@80x24.org>; Mon, 17 Dec 2018 14:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732833AbeLQOdZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 09:33:25 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43471 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeLQOdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 09:33:25 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so10894713eds.10
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 06:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3eBq4eEpD4RZ6/SoNfQsq+2pOI4C+PI0WzjIBeo1zI8=;
        b=mkDuaD4De4j82Dw9ugil3Tv9FoGU+OMwh1RdyXxO7Nr6fub4XpavqkCGCWPzrZsPvb
         s7ASnDfizHpve/UudjBa+x6xF8iTnIC0Os3MlXp0ZszfHxg/Yh79IF8IaPS+PbdWNHun
         2ph58muMDW0xI43QK6mRHkHcm6PUp7AD2/d3NeimIX5AW//xyNTuDdzF5Tn9LIv107GO
         r4mSxroXURg0X+YK9kXcs5Geg7scM1eh8ApCbRjYQapeocr7N2SSlqu/GpSdm5AiKL8t
         39FPlY5tEkqZ7sIxYhKQ7ycOY5f9BL/eHlSDnTJI3kgkmoWI9KL8uqyWH7NdvVyTMFNG
         G+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3eBq4eEpD4RZ6/SoNfQsq+2pOI4C+PI0WzjIBeo1zI8=;
        b=RKOAtGZtLLf6qCn8a5wZk1/mRfGxnVUnCJt/XCEeBuoRWNyvNZGmoShzG91X5tMAVN
         idMKFbvliKhmJ/5tS9e1pMX0pci7SxYh2co50Iu3yUsee7fqbUEqPVFjKoeDnkXlr9Sy
         OU8N6xpjMkYiH/mGRT/bbUlH/EiZBEDEVW59ALbmCDsB1J+Cdwsin0rGK+NPcg9bAxUA
         ELAnJj2Yx2RjMrACl/CkGEP8IHzDxO+bY06wV4kX7zELrq+xgFeZ19m8RLcWy6o7f+lR
         v0Lr2wC57qtnw1zzSBdUuvmp9xnWVS3nd+NXJtkOeJ28vRCOWdo6WWcd2FxdF242c1jz
         5Teg==
X-Gm-Message-State: AA+aEWaDB590ZnyZVeB2GTS/EmefR42l2TszKfZQV4IlMO5clcf71tsj
        ELol7UfKYAnDDItSGYLPdYVX31Ff8+3xm4avXDx1HbIA
X-Google-Smtp-Source: AFSGD/W4J8h6opw10bb8D5ONbdsFhqjOI0YNzX8WnOal8uc561OmyvSCtJAm9zXelTsYz/M3FTQHaxy+Kd9Wwvv57QI=
X-Received: by 2002:a50:e712:: with SMTP id a18mr13081609edn.163.1545057203251;
 Mon, 17 Dec 2018 06:33:23 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 17 Dec 2018 15:33:11 +0100
Message-ID: <CAP8UFD35iwsykababZ_dHbg7=VuZw9oGa4FsabjAa8uKN+93oA@mail.gmail.com>
Subject: Draft of Git Rev News edition 46
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Stefan Xenos <sxenos@google.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Dan Fabulich <dan@fabulich.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Drew DeVault <sir@cmpwn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-46.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/321

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday December 19th.

Thanks,
Christian.
