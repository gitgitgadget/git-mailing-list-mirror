Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C30B1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 19:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbeGMT4p (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 15:56:45 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:45366 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbeGMT4p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 15:56:45 -0400
Received: by mail-oi0-f48.google.com with SMTP id q11-v6so38713657oic.12
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 12:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P5Et7ZkZddRI9fBV56RLDe1MSF1lHRl75icOPlBUD1U=;
        b=U7mMjw6Mi+U1YrzHFyXSX7iRVHkgsLj5vCB2vtFoNkC/FT7bf4CP4J1t8FMd/deamW
         NpZWM+cDG2m1graKgoTljFbxpNeshCqwcqLQlfCHCZ5DiELaQ9dgGRXJA1nAinGnghkt
         k/n5sCO9Q33HuuiBoLudZnS3+xnzOhCUe6sx/+FRnY7Ow2ZLPUPAhkUDljs1qMDvcs4t
         xS8kCkqM/qW85a5+y4Wxh7RzLnHbz85r8IvfwGoBj+zDCuG5oi27PBYPeE5ON/ZOJkdj
         p12EjWcfltqbkV0o4yjKs81Rnt8xot4qGtK4tB6pdmBX8VHTkxnkXOua93Xes2cO5y4Q
         klgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P5Et7ZkZddRI9fBV56RLDe1MSF1lHRl75icOPlBUD1U=;
        b=tUYjRlcbc17iRogAKb0bW9wbNIvE/SjVgINLj8mKSjChchrlVrOT7hEdoiuTG+7ZUZ
         VlIinKvlZ37fvcfFz1RTOgJxR+LIo09j7sdzZYrxBEe7Dr2Kp3/I92NOX3R3oCzJAiZx
         +prFzmVgeI0UWTW2lfgxYxmpb57UNQFYLMhz3W9MOyefiByb5yqhs4oKUKDe+2VYBjX3
         cDCCzu/2/bounaIdjfQ92M3pP7gMwDieYw+MTVmKnZbdvHtNu+AXcHu9BSIQk3v5hNKp
         Ugwex+Adbzl9aMPQC5Am43ZuONN0i96Q9k6e9qiy1kQdW5POq9QIN677KYhVmPgTBKgH
         kG4Q==
X-Gm-Message-State: AOUpUlFkZ+9w/V2ksyEr4lMaL9sTCxnGu4XlVM9FjTP/lZ0HQpHCCqOB
        E7P6l/jRBlH2zDesN1rSWfyrnOh35NaH/sPXc8E=
X-Google-Smtp-Source: AAOMgpeFBP6CDvpC92VA2AU6jb9GZ3+pvtdXk+ULhef9d4+yBn4tGz0+3rloAYMdIc75294NPE17XAhuqbi5ypwwQeI=
X-Received: by 2002:aca:bc54:: with SMTP id m81-v6mr8797255oif.308.1531510844089;
 Fri, 13 Jul 2018 12:40:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:74c3:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 12:40:23
 -0700 (PDT)
In-Reply-To: <20180713192441.GA10354@sigill.intra.peff.net>
References: <CAFW+GMD62V=o4hoEYKVteBZHzqBtquzLzTv2WXiSPZf3ZhOpeg@mail.gmail.com>
 <20180712054909.29077-1-wchargin@gmail.com> <xmqqva9kzbhi.fsf@gitster-ct.c.googlers.com>
 <CAFW+GMAp2bA2=_BZ2S0HLO2x2aLE01zXigHrY3QtCmWxRuyAtA@mail.gmail.com>
 <xmqqva9kw9ru.fsf@gitster-ct.c.googlers.com> <CAFW+GMByLBbj6oDu-ERhN-bFO__Tj_M752-OYLYa7=z5DF0Ckg@mail.gmail.com>
 <20180713192441.GA10354@sigill.intra.peff.net>
From:   William Chargin <wchargin@gmail.com>
Date:   Fri, 13 Jul 2018 12:40:23 -0700
Message-ID: <CAFW+GMDtA=u1y4ncLUf25CSTymv-DAM3n5a+JSkT-XxNeH9PBA@mail.gmail.com>
Subject: Re: [PATCH v2] sha1-name.c: for ":/", find detached HEAD commits
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio typically applies bugfixes as close to the bug-source as possible,
> which allows them to be merged-up into various releases (rather than
> cherry-picked, which would be required if built on top of 'master').
>
> Ideally this is directly on top of the commit that introduced the bug,
> though for an ancient bug like this, it's not worth the effort. It looks
> like he applied it on the 2.16 maint branch, which predates e5e5e0883.
> When it's merged up, the resolution will handle the rename (probably
> even automatically due to Git's rename detection).

That makes sense. Thanks for the explanation.

> Great. Please come back anytime. :)

Will do!

Best,
WC
