Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F26200B9
	for <e@80x24.org>; Mon,  7 May 2018 17:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeEGRuX (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 13:50:23 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:41243 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeEGRuW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 13:50:22 -0400
Received: by mail-wr0-f172.google.com with SMTP id g21-v6so29608289wrb.8
        for <git@vger.kernel.org>; Mon, 07 May 2018 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VvfTT7qeC+r8SSTlmJ4OFvMFjQrO9vWDdHn9euSqqJk=;
        b=Nw7KljWy7ahjVZ3Kxf/OfWrlTkCr53eMP709jiaSI3M+fxJG46N4lW9/iHeP5Gormn
         5vqaL/ri83y4OEzHaVhydMhjI5p5k4IUPOkM5nNKGD0rqgsGr1gt8vd/laBy0bI/o/8t
         lFQvEyhFvUIa/UvFN1rmcembiZ6RJLU6242WA5Np2mOrqrIKtKtWq1EidIlnRd6G4AN+
         SuwtkZ6A9QnKMzZZwid28cZ90siP7i3x98+62vgJe2ER8i4c3WIQ0k9YNSVP1TrDQbhM
         JSewQ0WaRhETOP/LUAYDE5svRgk22J7BgakJJYY583FwsgBsFgIYfN9vbLJfFgGRcfEM
         gfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VvfTT7qeC+r8SSTlmJ4OFvMFjQrO9vWDdHn9euSqqJk=;
        b=RnSN+v0Ww7+xan22d8Ba2QnTLiYn8Jv5damYMIdVpnB8/m4VaFDbL9Vmb7Byi92ia/
         f+IJhecHK2FqUp/dGzfgZYz7SiVWb10IYnhcUosOf7HCmVZ8ei5ZAcprqt43E6GXnCXY
         mNwjLYMFidO4zMfq886Eyu3vkG/9Orvy0dQ4z4dxJrjRoVsohokIArG6TFssVoK1Y+oq
         jDpaDtDrwV/OKdrcPSnGNVC2+zfcaHumKHsW9xL4M/FSJNdlgXgpAXk+IJFDjQS3r1hU
         CvPDx4yxH5ed47owBQ5lljOJ+QHfhr9fF25c175TCgWcoK0+BqVvDRHHu8RvKpAw9YUJ
         a96g==
X-Gm-Message-State: ALQs6tCHmuJEaVXhMwyDpGyoIyNbaxJsoIeL6LXxuANHQnFNX7t09jGe
        JEf4Y7+I1f8gNDdj75d0OQA=
X-Google-Smtp-Source: AB8JxZqY4JBHk/7lE3QoK2MOjM0EH8tkhj5YKopFzviW22KWNTYVjE2rzxeUEj9WjK6vQtjG/pLVfg==
X-Received: by 2002:adf:b067:: with SMTP id g36-v6mr30047398wra.128.1525715421696;
        Mon, 07 May 2018 10:50:21 -0700 (PDT)
Received: from localhost.localdomain (x590c55ee.dyn.telefonica.de. [89.12.85.238])
        by smtp.gmail.com with ESMTPSA id b85sm8849670wme.46.2018.05.07.10.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 May 2018 10:50:21 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/18] Add `branch-diff`, a `tbdiff` lookalike
Date:   Mon,  7 May 2018 19:50:07 +0200
Message-Id: <20180507175007.30381-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.583.gcecc8b8e24
In-Reply-To: <CABPp-BFQ2y1-FuA1wwnvFefjTFxunM4qeFke6icc5vAPs7k8GQ@mail.gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <CABPp-BEEgeo=5hkaTe8LrOMONSv3VdPi_cP4ADMC69oG3htC1g@mail.gmail.com> <nycvar.QRO.7.76.6.1805052141550.77@tvgsbejvaqbjf.bet> <CABPp-BFQ2y1-FuA1wwnvFefjTFxunM4qeFke6icc5vAPs7k8GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 2) Your completion commands for branch-diff will only complete one
> revision range, not two.  e.g.
>     git branch-diff origin/master..my-topic@{2} origin/master..my-top<tab>
> won't complete "my-topic" as I'd expect.

It does complete two revision ranges, but if you want to look at
reflogs, then you must escape the opening curly brace.  I'm not sure
why, but apparently after the unescaped '{' Bash thinks that it's a
new command, and doesn't even call our completion functions anymore.
It's not specific to the completion of 'branch-diff', or even to our
completion script.  I don't think we can do anything about it.

