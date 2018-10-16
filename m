Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29A91F453
	for <e@80x24.org>; Tue, 16 Oct 2018 04:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeJPMQG (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 08:16:06 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:45333 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbeJPMQF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 08:16:05 -0400
Received: by mail-wr1-f50.google.com with SMTP id q5-v6so23727583wrw.12
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 21:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zlU6QlLA29Z25/UbBB5WJ0NIK/H5KC30D/p0Cumr83I=;
        b=dmPc0djY1KFL9vka7eIDM/aiUnEkjmAmxVRnp/ElEZhhMS8ZdR1JR9UXgOtmC+T0Uq
         TDsFY/mPTYBzd0ijDtURv9bFEObb6RXAjVVjjSjNAh/4X0uyyO9W5N8S72gpSaO2Se6p
         jJuL3yFi48kgzMiLbZLHWWDoyxh+sAuMQl60kfCb3ba5WUVtxvFKMpXuXBy5pxbZhH+r
         3yrkcSCwpgE1OBvpIPuQeDxHsMiNMfM3zqfDYtvP+zQMrvfpdFPNzhAZhduIznNPexPk
         R4fdy6x+n9jrwB7GvGedcEUr3MF5yxNe+sGMmTwe/jqYMGbprn043/FBjEhLKBU1oZRb
         qkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zlU6QlLA29Z25/UbBB5WJ0NIK/H5KC30D/p0Cumr83I=;
        b=Z8HvjSKAwIJUSvModYpOTX+Wku1NHmrLDvP8uGvvPc+/cPTgmHTBjYLzqr9f/6HPRB
         P0NE9gI/9PItsD4cqkl4V/poO80IPy72d10bhap3hg7Kp4RPBBCQ7X0MRvNGHcPkzhEi
         3yW0OAM/R2RYNtRJlqQLw/DkxSeYhI4ex4ZIWpYoZMDiNBbcLs3jejNcoypBueoD6KIQ
         WXfEyT1OytmqMzb0KjZpl7vnK32TLh0qW4hlIQ+k1zCiQuQxw3Hcv/kifGCFiPSna+cF
         bA9J/Blvq9eVDhUVoEWVYzzHamKU+Wyh4xXCTX9RXTnAhOHx5RjvIE48H0W2jh24qP/a
         iMSA==
X-Gm-Message-State: ABuFfogMglWzmb0AmjL1taTRAiXAYKAqCLsWjNQ7wuGTtWHvdjnYcajJ
        xulJesH6BSBiwLC7BCN+xwi4+8ENVww=
X-Google-Smtp-Source: ACcGV62WNGAScRvFHft5X5Bf7/qP29CJQb01wxgOCSc+dMqRhLMhcdXjvd7VkIOfn9rcXVuvxlaqyg==
X-Received: by 2002:adf:f785:: with SMTP id q5-v6mr15851736wrp.86.1539664058345;
        Mon, 15 Oct 2018 21:27:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d16-v6sm9558163wrw.78.2018.10.15.21.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 21:27:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chen Bin <chenbin.sh@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Merland Romain <merlorom@yahoo.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com, Lex Spoon <lex@lexspoon.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCHv2 0/3] git-p4: improved unshelving - small fixes
References: <20181015111408.17618-1-luke@diamand.org>
Date:   Tue, 16 Oct 2018 13:27:36 +0900
In-Reply-To: <20181015111408.17618-1-luke@diamand.org> (Luke Diamand's message
        of "Mon, 15 Oct 2018 12:14:05 +0100")
Message-ID: <xmqqtvlm1pon.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> This is the same as my earlier patch other than fixing the
> documentation to reflect the change to the destination branch,
> as noticed by Junio.

Also you set up when-finished driver for clean-up before running
clone, which I think is a good change, too.

Will replace.  Thanks.

>
> Luke Diamand (3):
>   git-p4: do not fail in verbose mode for missing 'fileSize' key
>   git-p4: unshelve into refs/remotes/p4-unshelved, not
>     refs/remotes/p4/unshelved
>   git-p4: fully support unshelving changelists
>
>  Documentation/git-p4.txt | 10 ++---
>  git-p4.py                | 90 +++++++++++++++++++++++-----------------
>  t/t9832-unshelve.sh      | 75 ++++++++++++++++++++++++++-------
>  3 files changed, 117 insertions(+), 58 deletions(-)
