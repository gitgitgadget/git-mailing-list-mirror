Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A62220248
	for <e@80x24.org>; Mon, 25 Feb 2019 13:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfBYNA5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 08:00:57 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44343 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfBYNA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 08:00:57 -0500
Received: by mail-ed1-f68.google.com with SMTP id b20so7445773edw.11
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 05:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Y3Benw9LnYbLzleNz7SITxod6UmqC3I/0a5JROm4rws=;
        b=RABsZ92zJz3eXYaJiEkUP3L49SSj0sp/9Jp/nxYnvEKanmF7p7cRCidE+Wu53RDa+s
         2Kw5ls+w9RFtKYm+wKv6NldKlmvKOT+XeK8p42aYnGf07uPUXFdc4xNgA1IQ8/jcPiUt
         U5yKN+S8WifVF6RHT6GIodPD8O11J6NxiGS2MqgRZtlb1f3IkkBkkNNoplmevW+u4DJ1
         WukwD47/AYyg/gTp4S4Q+WZ3vDb0xJIkcEMSrpg76ucB/lOTwfpMW1GK824eE/TJ08Et
         VnOkm3T2Ni8arcifG+lQc8DjTTimmrL0/+IBbbkRAn4PxgwvseYRC8rbQ+wjEX16gHux
         mVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Y3Benw9LnYbLzleNz7SITxod6UmqC3I/0a5JROm4rws=;
        b=QF0UBydF9N5kHBoIfsuIsZ6GhqjY82g1ITOtcfXO831dVlkcKk240ZB5yidnRzaGO5
         YlR1Fg7HRon4MG80DCL4HiGJyWXTVnAT/QFwKkIBtO73xxatgdJQB0qxDAkQZ7qJBzvi
         DBrsv+w7JKKC63RSFz8k5yf7tGT1WFrdsIBgfln2n2AAleI29DEEVudNKqmr3E2ZL7Ny
         AONTgLBCpkEVymunQWEETKdzh0hISu098igZceCb5Bc+k0V46T+sGMI7O1FuoXBAInc6
         2hs43aTrk8Pl//iZbozlrDv8FWinFIJwHyYFxhUOtS1UDJRiC0y7SJBYYXKoNrUVGCNv
         AgCA==
X-Gm-Message-State: AHQUAublN1LB5eFuRtu6M6busSwUU5/zcNDBqykRKePOheIQ2gSNYaIT
        7N9ZZZoDPyiTfeETOiXmH5AqGjZpz1HM4x8SBbktU5o9qUU=
X-Google-Smtp-Source: AHgI3IbUOllAgkNgY3JF+4ApIFrt27GSpUrHcbTyZ3IB+3r7tOFRUegA4a0anP2sKA1LwbfXyvAudxwNYPCaGtoKFFQ=
X-Received: by 2002:a50:b0e5:: with SMTP id j92mr13796263edd.188.1551099656019;
 Mon, 25 Feb 2019 05:00:56 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 25 Feb 2019 14:00:44 +0100
Message-ID: <CAP8UFD0mpeGe+ef0kvoet_8nDUtSihr7L6EQgTBP3hijmM9-KQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 48
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        David Pursehouse <dpursehouse@collab.net>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-48.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/352

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday February 27th.

Thanks,
Christian.
