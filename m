Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3701F403
	for <e@80x24.org>; Mon, 18 Jun 2018 09:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935998AbeFRJls (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 05:41:48 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:38306 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935924AbeFRJll (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 05:41:41 -0400
Received: by mail-io0-f172.google.com with SMTP id l19-v6so16247073ioj.5
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UbFc0Ao7dkmaLy7ZhVArVJ6L7OZXGpJNVCBhaCpNwXY=;
        b=CxncnoyRnYfTIIo905H0CGUIZ3SLPwdcAWny4DNDufsxFxNfcxWSQIBHS0o9anrEmj
         vP6Vuh9JRpDWSTyNn1VTkugeH53Vs8heHuYjKS1NkRrJgvUerx9TbRQ1jeY6x51Ox34V
         eXb+/T8U2k95nUnjS34LWrG5NI3y02FeEe5VSKTr1cfTjrdkOPvd3ziXGOqz3cnr5AFT
         EIalFKM5UBcf8dK4xVEYl62rEJIjIiFRDaJE5GkRBdE6Dd32Ss2WeqK8Azveg+Wx/wsW
         7Xa5Ox4/+rvL5mvyOV83D+Pxk0gDQ8HlMJKlhP7b9Lr7kFf3hgJAJcWmpDhf8VXw6CVn
         /wWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UbFc0Ao7dkmaLy7ZhVArVJ6L7OZXGpJNVCBhaCpNwXY=;
        b=WrYC8Pk+viyEhNv+1d+akzzrw4yraNJAbbINfHX1/RrNQaGiUq3z1YBWrJPW6hqqJx
         CovBMl2zIONYgEaEJxDhiBhXLJtlwDJPzWtT2Qa19PjD7Sn3pbcdmthWp0JEtScnup3L
         7K3LSKR/DugN4pjxvwBF2W2XhMY0ubDsHPuYv48Y/cc4pqdTakCUvjV+r3xD1gy7ceDm
         VW0l3BFcteMRMhQFFtRazxPEwzLz8MkFhBArSm7SC9f3MSkI8ZyWiXJcDHq8seYn4xMh
         xT/txss83q2tXD4byVKqlxgpT+gE3kupGJ7+55fT1TUo9RwqO0t/Du53ud9NWFRIY6Mj
         2E8g==
X-Gm-Message-State: APt69E0a+2lSdVZ1H/faPNBWSLSq25n49bW2Y1vm/058mZJP/VAYad7R
        1qXVtB38H/EGl8yzQNJWVjt4vcjcp7/mo/Aw/l6S09Gs
X-Google-Smtp-Source: ADUXVKJ+kTveijU0gdPRriDZoeIg3O9aysye+Vi5Ka8S4rT/2AT/YLRYtuOQlXnBOfVqIzSwP3w4LmONaCmbM+THzgY=
X-Received: by 2002:a6b:ac85:: with SMTP id v127-v6mr9312591ioe.53.1529314900413;
 Mon, 18 Jun 2018 02:41:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22d0:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 02:41:39
 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 18 Jun 2018 11:41:39 +0200
Message-ID: <CAP8UFD1iDZbEN+UUbVgFgjwpvVrwSTQ2f=D8UDcdPx_agcLZFg@mail.gmail.com>
Subject: Draft of Git Rev News edition 40
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Adam Spiers <git@adamspiers.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-40.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/295

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

This month it would be nice to have a small summary, or maybe just a
number of links, related to the security release on May 29th, and the
same related to the GitHub acquisition by Microsoft. Thanks in
advance!

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday June 20th.

Thanks,
Christian.
