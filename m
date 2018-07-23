Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25CB51F597
	for <e@80x24.org>; Mon, 23 Jul 2018 19:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388096AbeGWUNE (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 16:13:04 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38732 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388077AbeGWUNE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 16:13:04 -0400
Received: by mail-wr1-f53.google.com with SMTP id v14-v6so1765069wro.5
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wNl6ii9cIYu4HxpQ4um9tXngwBA0Nq/WZqYHRIhGnzc=;
        b=qF5dmnwrQcyxNTpUy0nlDR/BZL1l2qNrtRGMFnpDn1vwEVzr99/+XAgmtB4Y9jchzD
         1fnUqUqqAwW/qFqrdBMqut7OmtB8Bh2GFJ98/Zz6ltfvxUPTsl4S/n5NnyRb/VZrSpMD
         xjtgsJdZg63Nq8xkqZP2cdwVQNQNuytZrV6cktNdZ6ML57lpoN9TIrsAD0f/bun2jz1r
         tnNPJOQT4Rzj/oiBiECYzoh9x9NRkD+PCc8Rfz4LNyY7Ra+5SUUgiIdNmMUKNgs0Tdpg
         TOeH7gZXqaYw6kG4AkV2PkHBDsXBKVdzprCJCvTpU+u8WFyKpc8vTlAsoHQZo1jL2Tbo
         NG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wNl6ii9cIYu4HxpQ4um9tXngwBA0Nq/WZqYHRIhGnzc=;
        b=Bxfr77cqfkakO4MGaFDIIJZPgLFWH3w41AEcUQnj/Nzt22Uti8vQpu9MGMTnyoFWAx
         v9FhIjXmY4AL38+RsEDwZmvgHSgyp30GfMpnYGMS4dBnbl6uI5WEXA0xFQiY9/NeSTFo
         8pXekWbvuLmylKePyMmUhaeBsExnAeZxwnsRdkRA5o0YAzw8/pKWINXao/gM8esN2iKO
         +Wb3tHTj2t0ptn76Qanj6TXh7ETaX4ZB+hVZqsQGY+g7lv81bmDlLElffvIyc8DSf44X
         1Y40X6ftCXl/8NxkoAnlaKrAuXmQCQF+a3sGpGwRJGoLW/EjXX+gar6FZ3C9mvGvEOUU
         9WZQ==
X-Gm-Message-State: AOUpUlEet5GFpkSl+FvkP7sYAUb2h3Hn0kKWW60AEWRWague93Pp22Y6
        1jEitOOF+2oPehynRNxMA3s3Cabq
X-Google-Smtp-Source: AAOMgpdq5dKbfLAlKIrL4WNVtNYV3861qIJMdkVZNZm0PDfMOQI67Wq+oRMaIsIprXbtoQG4FS+oiQ==
X-Received: by 2002:adf:9546:: with SMTP id 64-v6mr9114984wrs.257.1532373025887;
        Mon, 23 Jul 2018 12:10:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j8-v6sm9311661wru.41.2018.07.23.12.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 12:10:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org,
        "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/1] t7406: avoid failures solely due to timing issues
References: <pull.12.git.gitgitgadget@gmail.com>
Date:   Mon, 23 Jul 2018 12:10:24 -0700
In-Reply-To: <pull.12.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Mon, 23 Jul 2018 06:39:40 -0700 (PDT)")
Message-ID: <xmqqr2jt6a5b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This fixes a regression test that produces false positives occasionally: https://git-for-windows.visualstudio.com/git/_build/results?buildId=14035&view=logs
>

[jc: forwrding to Torsten for <208b2ede-4833-f062-16f2-f35b8a8ce099@web.de>]

> Johannes Schindelin (1):
>   t7406: avoid failures solely due to timing issues
>
>  t/t7406-submodule-update.sh | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
>
> base-commit: b7bd9486b055c3f967a870311e704e3bb0654e4f
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-12%2Fdscho%2Fmore-robust-t7406-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-12/dscho/more-robust-t7406-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/12
