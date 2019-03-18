Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 226FB20248
	for <e@80x24.org>; Mon, 18 Mar 2019 01:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCRB4T (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 21:56:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45302 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCRB4S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 21:56:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id m16so5558376edd.12
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 18:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TL1EVIW0RbCiOLOmzgRBadusxA6Ii5QhM2Tbtu4cCes=;
        b=f54FiFKKpCkAZfLadnXmEM1QqkJcspbOF+TdYRurEm1aN0+ylRwxc56Gz77YubFX+U
         Dha9IEib3o78cJg3HqGlsReSFQatKAPcNQQSValHAClYvEsAxQpAiO5LkiUoPpgKMEDp
         iqVt5z5GrnkHIl13O2LQYnf+sSbJU0Sp5zzmLQtcPMXwO+RKkoTYLdAQmuDYQ/eRUyJq
         CS/VCnGjUnjrV2u1O+TmmrRGGc07VDC1pRk/BLA9xtQbObZXqCBwIMLXbLTELNGSKlNK
         M771bnKEChFtCUuWYK1T0l+yVN1q2r9RcDHZZktitQdU9jB+jI6RSsXiDwvg2vb+M3Lx
         Y9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TL1EVIW0RbCiOLOmzgRBadusxA6Ii5QhM2Tbtu4cCes=;
        b=hqCKQ6QXBHXYq9Ojyubv6ejqm9BXUmuYYjtE8PrrVGN4HayaXtbF430pB/QTcFEAth
         vSI6esI2381ElKknRzyvoya0qRAiKjUpqmsI+MrlDocHqoc8jgJiAo6LVsir3CzB40Oe
         6D4/XokppgluQl4j03MOmGCRGK5YjOkojATv8ZwJaghRMfIBMK1HRgcrQwzZyaTpG53s
         rOmutr8FHtwXrnsDiYbkxjd+/rtgFX3QMbUQMQIa/Rd/8I0KdQwjTYAoV0qEWnmnhnqK
         WEI/8dnUdfrVSssRcj79tzXA5YtC6yVBN31FPAeigKo77oPJRY1A3ufSGS1ABDykT058
         Rc2g==
X-Gm-Message-State: APjAAAXygmEybE6AdR/6gzsTgXJrr6Khi7qNncmcmde0jE8NF47EN9Ub
        ZOYKpVZJpdIO2iwcGxDXpvU8OdSAX5Q+lE9ZIk+6Qu+Y
X-Google-Smtp-Source: APXvYqwvSbBC+EoGw05LDaCGbb5NIyKafDbutmaUjRsWlRLxwf8G8ZDN2zwnT1CLqJ+J2d3VA7jwEvt2qzPmKVbsFbk=
X-Received: by 2002:a17:906:6014:: with SMTP id o20mr9452287ejj.7.1552874176665;
 Sun, 17 Mar 2019 18:56:16 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 18 Mar 2019 02:56:05 +0100
Message-ID: <CAP8UFD24Y1PCPWOkqi-Z9OM6Q3BOu1aj5xXj1SMHjTu1t-65Tw@mail.gmail.com>
Subject: Draft of Git Rev News edition 49
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-49.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/361

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday March 20th.

Thanks,
Christian.
