Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601581F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 17:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKRRLT (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 12:11:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42997 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfKRRLS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 12:11:18 -0500
Received: by mail-ed1-f68.google.com with SMTP id m13so14243565edv.9
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 09:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SD8fPiSXnq6EjZbyJBDQcvQkqmm4jXBqFhwLiNqxdCs=;
        b=ceF/J+SWZ/g2IzeEq49tbV/jllRFDFsLviC2RP62WH9yrRzL9UipYGp12VZa6rNRRQ
         Eg04g10nVMXa/2O7RTjnf5XEW8mnCyQ4mvmxjcIvBwNI4wL46PoYN9lLb322fDbL991Y
         FKIcIcUX8rcnNjXbMjGEA2HiyXN/jlIGI90k4Lulzk9h3LC5AEmy83NB8UdXwuQ3PJ0H
         +DaFOMM5UZjNSdA6wjSKV2d+NKO91x4wr+wFjv5H0dazfGiLa222a/w7D7kuCmL0t0U5
         s90NOof12fuvV8h509ROyrR6q2cdGNAYaqghd2ijHcQXtZ46Keg3r7yNxAnwlBIcFhay
         ltPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SD8fPiSXnq6EjZbyJBDQcvQkqmm4jXBqFhwLiNqxdCs=;
        b=CF4OKyDtQG4eQFlsfL5MlWtZiRLNpZpATEGFCtOJNHqnaAY5KsqbpN1i2nimFnSXFU
         U/ze1W4+3BbN9lNpH2H3BJiSyvXra86fP2zxObQL7Qk/FXnjiL1jqORlU5fH1FhIv5SM
         /FE0CH3pdcukZ+jpxFFiTIxp8XM+uV+cmexHuycdpssqvN491EpCCbDZtK1BraTmmPdt
         c5mlwv9nqbOB3KCa3h0AAYP5VWyJ5rfgvW//KVQrOFqqtQZksEGGh5gDDftWskZQbASq
         6cI+2WCQB5EasptHqBGDldXFz9PZzGRTcyo79lY3Iva/7IlKh8smwehgGpY1mW1uEWK3
         y3gQ==
X-Gm-Message-State: APjAAAX+emg9e/vZc31oUk2gZt5VWDNtpTtugRmpN6zdP0wN6CW7sJuF
        00hAb6Fu8sAMt0rsm6GAFKNJVnz3NyckU/DCMNrY5zOF
X-Google-Smtp-Source: APXvYqz4HM1S8TXa4k5kQ3P/xm6HQpokpo6YRgdIfmmXjWpq2LsdnoSyr7PRAXfP4gwP2vt/N8HsIW2jbweLGLIfOQk=
X-Received: by 2002:a17:906:1611:: with SMTP id m17mr28407455ejd.281.1574097076764;
 Mon, 18 Nov 2019 09:11:16 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 18 Nov 2019 18:11:05 +0100
Message-ID: <CAP8UFD0Yqn7BGWx879oNC2niGM+9fECBe237R1Of4YM_0ZmosA@mail.gmail.com>
Subject: Draft of Git Rev News edition 57
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jon Simons <jon@jonsimons.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-57.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/404

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Wednesday
November 20th in the evening.

Thanks,
Christian.
