Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F0920248
	for <e@80x24.org>; Sun,  3 Mar 2019 02:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfCCCa6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 21:30:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43335 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfCCCa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 21:30:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id d17so1763168wre.10
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 18:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbH1RVOgEaiyrdsvXs2uem1oDMXVruKGKkg4O9kNOFU=;
        b=DC4RKUgNV5bDWJmJPWA6wjRzHxYWV/tT+GTks03EWTD7VXIhfswWShtcUhOyG5tyAV
         gnnUjjGCxM3AAkTgWvZlBmWb63Dlyk6luxbjAZSuPfeZd0BMtKocKXqwo9aEcEzxfcKZ
         GtWYotErC0zwTnSTeDtLhW1DfhCDwNn3jYwDjqnOXh7RNF76c6wvAbBFfgrqHiFM+74S
         rLSqb8f+KDAQgHy8XOzjntSXk0+COwSY2gplZTq5MeULeLI0+vQuGXsMacaVIqY+hQlQ
         DJisZucL2wdD6xu0vW8SG2nVVf872LJWFOTUU0U8DDGMuv/9jxt5IBQ6TBuzILX1Ckx7
         eeZg==
X-Gm-Message-State: APjAAAWN9ktNoTWGGeN75gB6yZQTFu4nwCvfMni1gRxan29DrxuNI4yb
        VvsYXWryuav+S4OfuR2SMKOPJOfnTUCaXpBsiUI=
X-Google-Smtp-Source: APXvYqxbz/Xep0AU5TQCDuRYYNbcpKe1yAMBKqdlK+5jpRLb5WCik2u34iDvLjmCbwiFD0lYbEpg2tm5Mx4pTrYON9E=
X-Received: by 2002:adf:c7c6:: with SMTP id y6mr7978798wrg.217.1551580256588;
 Sat, 02 Mar 2019 18:30:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.155.git.gitgitgadget@gmail.com> <281d3f1d19d1c93e8d1e66ae16fe3fb286554c0a.1551561582.git.gitgitgadget@gmail.com>
In-Reply-To: <281d3f1d19d1c93e8d1e66ae16fe3fb286554c0a.1551561582.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 2 Mar 2019 21:30:45 -0500
Message-ID: <CAPig+cTvj0BL1YjKhpmLVqADxRSb+17aO1+fPmOYPF7Bj_TppQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests: introduce --stress-jobs=<N>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 2, 2019 at 4:19 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The --stress option currently accepts an argument, but it is confusing
> to at least this user that the argument does not define the maximal
> number of stress iterations, but instead the number of jobs to run in
> parallel per stress iteration.
>
> Let's introduce a separate option for that, whose name makes it more
> obvious what it is about, and let --stress=<N> error out with a helpful
> suggestion about the two options tha could possibly have been meant.

This new option probably deserves documentation in t/README alongside
existing documentation for --stress and --stress-limit, and the
existing --stress= documentation ought be updated.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
