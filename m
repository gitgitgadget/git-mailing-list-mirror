Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B478C20286
	for <e@80x24.org>; Thu,  7 Sep 2017 19:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755741AbdIGTfS (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 15:35:18 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35902 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755649AbdIGTfR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 15:35:17 -0400
Received: by mail-yw0-f175.google.com with SMTP id w204so1994985ywg.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tb3F6eFUOWuSR3R2nw2+tEjWuNW++MjUNpkHUMAsd6k=;
        b=DM5k/xx6NtG9tmYdPx2mqU9pZVNQch5UMwn7E1kHOv0R9Yu40hOm1pstTPSLK2+AUQ
         PWud+DL2vpiicdjeFt51m2JBA3Xj51E2bFsCcFOkiDQzioucT5CWaSW2U7I6W+m3JjiC
         WLQ3hzEnfWVTLFtJeSwKqUHyjcu52iIzc1ni8sDX4Q/hVLR86lT6Vejp70SsMXyVziSH
         C1kmVSSDFKTw9xhX6NV8ysul9veIVOHY1jPYd2IkaNVDtvzr1sjqtZpyfqFQw2ln9zH7
         Dl+6MC9/qPW1JeUi9HIU0c61FkIzvbLqEyb7KHJZfQwSrmCWnrkKt1RE5fzrYK57j1Ho
         Y83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tb3F6eFUOWuSR3R2nw2+tEjWuNW++MjUNpkHUMAsd6k=;
        b=s7eEh4Rg8NVaJHgBSk0GPIhCXd5koqj3Q2E8bF6jLcO0zrnLDIutRzmlUpZBeX62ps
         YOSj4HT/tQdGXs9HCm3kBxiVZ7HQRxbpob80EKvZx6ueSi8xLWkURz8Uz3rH1Sg3SgW6
         6fpEBD8fMS2A4+wHLCbSdvXLo5aGu6i9tUoST7oAVOCvY3AcMD4xpO6a7LQg2d/bLsSo
         zGnHic6y97ntxFxCsOlxeM7DuV+nuZsbn6TC/dP8gQkmIavYAygPUI8KFDEpeIOF64yS
         L7uQb4POL+mGZqjj7ray+5IwajIzv9Dl2Not1vW4jl0Fztd/3PNikJXcVG+OLulsSKoQ
         yQLA==
X-Gm-Message-State: AHPjjUiinGX3boiO3Yzsu9xDea6QvqGjaBwlcl+k1vZqSjbDCQEeXOeA
        Wj85BT0jq7pNAJuX0LrcLhPUnYppnkPE0RxRnQ==
X-Google-Smtp-Source: ADKCNb76+PgYUXW6AwE+a1M+LzZR1F5lPfFIQ17z9gkNLEUOR2tOrLFTIAEj1dOLUuPcUzcuEIIZjAFvtRSkBn9Uy3U=
X-Received: by 10.13.251.132 with SMTP id l126mr371300ywf.175.1504812916679;
 Thu, 07 Sep 2017 12:35:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.7 with HTTP; Thu, 7 Sep 2017 12:35:16 -0700 (PDT)
In-Reply-To: <CABjWGHx5VQaLubeWsqWJzufDU3vt9BSS0=LpwgOtMDYhje=qMA@mail.gmail.com>
References: <CABjWGHx5VQaLubeWsqWJzufDU3vt9BSS0=LpwgOtMDYhje=qMA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 7 Sep 2017 12:35:16 -0700
Message-ID: <CAGZ79kYaOKPRGXE8sc74uXQ__iGY1wZqFhyQeXBRAiGH=ujYLQ@mail.gmail.com>
Subject: Re: clone repo & history to disconnected server
To:     Kermit Short <heraldstorm@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 7, 2017 at 9:50 AM, Kermit Short <heraldstorm@gmail.com> wrote:
> Greetings!
> I have to set up a workflow where I'll be developing and testing on
> one network, and then deploying to production on a disconnected
> network. I'd like to be able to have the full commit history for all
> branches, tags, etc. on the disconnected side, in case I need to
> perform a roll-back, create a hot-fix, etc.
>
>
> Most of the solutions I see involve creating a mirror clone that is
> then merged with a different repository. My problem is that my servers
> are on two separate networks and I am unable to talk to both repos
> from the same computer. I'd need to be able to transport the files
> using sneaker net prior to importing on the second repo. I need to
> keep the production repo in full working sanity...i.e. import only new
> changes or completely overwrite the repository such that the full
> project history is intact and working.
>
>
> Does anyone have any suggestions? I've been looking at the archive
> command but I'm not sure it would bring out the full project history.
> Thanks in advance for your help!!

Checkout https://git-scm.com/docs/git-bundle
