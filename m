Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2CEB1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 17:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeDIRZ5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 13:25:57 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:46724 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeDIRZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 13:25:56 -0400
Received: by mail-yb0-f180.google.com with SMTP id e5-v6so3282824ybq.13
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L4GvA5EupQtz2PnQA4B0veLvGTiQ6YY9OPqkgD2paOw=;
        b=TFHDBQNF5jiSslqnl4g+/sWo2zzlHYzFoixEEUmw+fBFhjiOQ8KH9Vhw5S9Y2IwxJA
         ZQY82M6KrqOiEKk73q61bHcQqc0AcfnzTAX+8l3wOTEmA8Kz/xeNfsL4yACFvNsMdzss
         4hn6MmddguCZGmKZBL/xb8dZEGBH2C3+RppT9k1pIUhqwGKX+km0tuS+S/XFUp9M0scS
         QOHQJRylupUPQpMMO3UStAGGhL+EYxUbMdZOFm0DBGoPhX3Sniw7xpbXXoSQ5pnfUIun
         pIY05+pj/l4kblvJzutdaLuBguALX+g1Q4Qr9BlrPUJE90j94FCuKrH8UVF/OU6lS44O
         c1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L4GvA5EupQtz2PnQA4B0veLvGTiQ6YY9OPqkgD2paOw=;
        b=GYGJth2nm82qQ5wbKw+P3KOsZ5mvjZDEtL7R+1Cjiu6PsASg1Pg3jhgBvkpM3BCx1v
         wOiSJGXvZnzIUfwaBv9Yai3Pcq1wnLT7/LawoMGqJTks8m94fYI4s61UAL3rAyid0t3K
         vJBoKBPZUlVqXOq7kCLNDFfzJlAkJXt/Ul+TwOQU70m1ecg2Q3R72kqVOB4PudVByufY
         7AgLcb6TTWzuRnoKrYCnOkcTdvGYL8scG+umag7Ty7r99hztWDttnBjOhX9Q04QgWifa
         +c3SGs2FuLRleXeXfbl18LlyjywFiMkVLXNtY9272yfwFsEqAwdLMWdfLqkgR+sx41w3
         XuxA==
X-Gm-Message-State: ALQs6tAO/TNUySyc30YD8FGmAiqwJQJvq2C2E4JIIOQYTtmxxzfuV59H
        WLGZFD2EWqj4j6MKNfGSfLtlozUx/clVN9SaP8JhTA==
X-Google-Smtp-Source: AIpwx4/ekOgu60/L47uWOmPZUOCIyrnarLfVYjFaTw4IjcM8q8vFxc084v/QS05sF93k6ccoE59OoC4R5ILEcGZsF5E=
X-Received: by 2002:a25:2704:: with SMTP id n4-v6mr20152744ybn.167.1523294755613;
 Mon, 09 Apr 2018 10:25:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 9 Apr 2018 10:25:55 -0700 (PDT)
In-Reply-To: <7930c9bf-4f24-2e76-b522-331a2e9ed5d5@gmail.com>
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180406190919.167092-1-dstolee@microsoft.com> <20180406192146.GC921@sigill.intra.peff.net>
 <xmqqr2np70dl.fsf@gitster-ct.c.googlers.com> <7930c9bf-4f24-2e76-b522-331a2e9ed5d5@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Apr 2018 10:25:55 -0700
Message-ID: <CAGZ79kbV3uM0mkOdnoUF+isGEg_uM-9SKQix96hyQOH1Mg9YNQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Lazy-load trees when reading commit-graph
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 6:15 AM, Derrick Stolee <stolee@gmail.com> wrote:

> I don't understand how folding the patches makes the correctness clearer,
> since the rename (1/4) is checked by the compiler and the Coccinelle script
> (3/4) only works after that rename is complete.
>
> The only thing I can imagine is that it makes smaller patch emails, since
> there is only one large patch instead of two. In this case, I prefer to make
> changes that are easier to check by automation (compiler and coccinelle).
>

I prefer the offloading to automation, too.
So I would vouch for keeping it as-is.
