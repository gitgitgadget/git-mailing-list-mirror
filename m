Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F413F1F457
	for <e@80x24.org>; Thu,  1 Nov 2018 01:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeKAK63 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 06:58:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34181 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeKAK62 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 06:58:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id f1-v6so799850wmg.1
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 18:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qdtdcv9IZ2olcAUoeUY0pqY+cQQNbKy+62gljzwAPVM=;
        b=UXDyKoNuN6/8zgekHf5iBpUnFcIs8m/nwB8bHeYrXLBUysvMF5Mjpozx6wjPE8gK9m
         Ek0Jm8kMlhGa+FrpuNpQ1e0uSqMcRd7Q/jeD3XBPKu+N5D6daJrtOOxS2gkb3zmKNT2F
         V9+fA1QPGpdHE51BZ3BFrlMUuyWQF6Z6pqkeivC225AsxpKHG2ByiW3zb5v7mww3U2U/
         EpB5Fcla5ml5ozwOViArmv57e/tjnJxlMr5R9JCFuHHx/1D2jCIuUF6JF6CiWdh3qDfr
         3igA1tYs0CaEwBBLY3bDe5+N5wlxU/0UyXl3srdXtZW42TizPJWQakagVgZPiYruU/7q
         Y4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qdtdcv9IZ2olcAUoeUY0pqY+cQQNbKy+62gljzwAPVM=;
        b=aV2ZOJgb/E64CkyP2OSj1eHO9dE+KQ6XPnVINtm1l8sVG989uUGtQH89a36vqOcNqj
         d7ojKuXAvc0glphLuVwIsy13dCAkBDph/HZNQrH87ng78Hnz4voUlJx0Get1J1LbaUc3
         jl4jGYU0UEzohdT5CLa8OGQaHAi/yxID/d/PyT9d0mc4auxNKgHMyZXdEbyWGgOag/jt
         d5LkDBGoJfnOMsUDKB1XHTQaS4tYeB42ofHAlZU21QyG5pSsAYaVxf/3dlnmha1HrqGt
         ZXfLGs/Jtlz0UHQag03nj/uh3tk0b3G8j5WFVuWvG9HoZ4g8gH0/S9oySXzW5BKA1zRW
         tf8w==
X-Gm-Message-State: AGRZ1gLpyi5+wYx+sOg4KaGQx6YlzMMpP2/81HZAI076EFAvfvRoSHpo
        +93wHb/WsgugkaCpMxKHUmw=
X-Google-Smtp-Source: AJdET5f72VIAB3ZuCer19+UCrrXs8TxBJRAzcIOoYzPE6IdGn66D4aPz37PY1rbRpPlnvICSUEKHpA==
X-Received: by 2002:a1c:1a48:: with SMTP id a69-v6mr4283312wma.9.1541037456818;
        Wed, 31 Oct 2018 18:57:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v184-v6sm13628972wme.3.2018.10.31.18.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 18:57:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Chris Webster <chris@webstech.net>, gitgitgadget@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Use correct /dev/null for UNIX and Windows
References: <pull.59.git.gitgitgadget@gmail.com>
        <8159cbd1b8025f33fb9d0e254db1a3c2a066f853.1540923993.git.gitgitgadget@gmail.com>
        <xmqqsh0mwwah.fsf@gitster-ct.c.googlers.com>
        <CAGT1KpWoGD0xgTrC-+X1WqY_M=2arYbs4ZX6Nnj-zHK6mgu+nw@mail.gmail.com>
        <CAGT1KpWC_+=u7fCzQJsU8d_gSQzE5rsx46cTXogvaRPHZ1iiHw@mail.gmail.com>
        <xmqqbm7awsvr.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810311206230.4546@tvgsbejvaqbjf.bet>
Date:   Thu, 01 Nov 2018 10:57:34 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810311206230.4546@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 31 Oct 2018 12:10:17 +0100
        (STD)")
Message-ID: <xmqqftwlv9td.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Indeed, the patch in question regards something I consider outside Git for
> Windows' realm. As Chris said, you can run this script from a PowerShell
> prompt, without any Git Bash (and without Git's Perl) involved.
>
> I am fine with this patch, as long as the author name is fixed to match
> the name in the Signed-off-by: footer ;-) [*1*]

Thanks, I'll find a corrected patch on the list (or manufacture it
out of the original) and queue, then.

