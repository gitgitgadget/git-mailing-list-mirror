Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F3651F404
	for <e@80x24.org>; Mon, 26 Mar 2018 13:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeCZNAd (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 09:00:33 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:32848 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCZNAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 09:00:32 -0400
Received: by mail-oi0-f44.google.com with SMTP id 126-v6so9963092oig.0
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PV/bgDundrCeIFz1MDOqWGJKxmczzWVm6Br+0hXszw=;
        b=tb3y6k22U6/2L6EQN1gFceiTOfP5Wxoh40fdXICwNPRVuDGzlzwEAFD/00gvDqGDkw
         +ncf5xIf43bHyG0hFX8btOdR06C7pOhG0ZrtwOTAuWcGaUCpE9/wr3of36wG1hRLYykT
         RQNpNhM6+r02lqUkTvKmC36wWUW3VfRIQyBscm50sYpdGiHz8mh/xbtXGSmcE1lM6Ahv
         fqsgkYbO+7rEp3YXE9bTEMhbYb90EbDhVbaq965dIjEZ1ClBNRojg/9JaEaW11fP8Tx7
         3kq195QTAgVIV7VjVmSzRXYMo7JSrKCYhn+JfObuD2hN+X95Bbq4ASwAr4TRIjTDA3/q
         KVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PV/bgDundrCeIFz1MDOqWGJKxmczzWVm6Br+0hXszw=;
        b=kIBrbz/ss7NQlUjzBeMQRj351AunwM532N8zxXmc1l3sUzK6rIIMMlCh9EUrjp7nZr
         92/LbfiWVKgf7ZMZxeoCiYaLF0lTGGUpidN6sjwV67odh2ra7qRNfwwvYp7JFHRup6KX
         XQL291yJcpRZyNvmLeDLa+j9pW5V25BkqceafE8AuUXtnnHDozTSCpXavAc90Li6TBXA
         2vdHVVdobEvdkfR0mcp2DXF7zuAEkokMHxAg31Qvr06zsrRpbwnohfacvtjGRILF6AJs
         10l8/bchXrMpIW7QJxcsmgf5Sf83/s5IuEmRMdZ2eAx/lXP4ohnTWBRGSAbtQFSYawUm
         pCZg==
X-Gm-Message-State: AElRT7HJh+W29eOTet8Pljl8Ql47ePu0WacXMbARGvA6vP4uohI6bfSx
        BeWvC5GZ9wEw7Yj7YPeRiQcMlOSlc36pdFcZb6+wo8VA
X-Google-Smtp-Source: AG47ELu0zg2HPdLQi2HyFIIzqKwdNw/q65BlTh3lMtWpqXI0aOFX5aOaV5vBQQ6Lt4kko63rasw6D7uq5A7NZXowKOo=
X-Received: by 10.202.114.75 with SMTP id p72mr22881443oic.31.1522069231739;
 Mon, 26 Mar 2018 06:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180325205120.17730-1-dnj@google.com> <xmqq4ll3e5pb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4ll3e5pb.fsf@gitster-ct.c.googlers.com>
From:   Daniel Jacques <dnj@google.com>
Date:   Mon, 26 Mar 2018 13:00:21 +0000
Message-ID: <CAD1RUU-oUXx+mGUe6QuTawLhLz1nGFZiOWnF7=DVA1uf455zfw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] RUNTIME_PREFIX relocatable Git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 2:01 AM Junio C Hamano <gitster@pobox.com> wrote:

> When testing the non-relocatable (i.e. traditional) Git, we use
> GIT_EXEC_PATH and bin-wrappers/ trick to ensure that we test the
> version we just have built, not a random version that happen to be
> on the $PATH, without requiring the built product first to be
> installed before being tested.  From the diffstat for this patchset,
> I am guessing that you are using the same mechanism even when
> testing the relocatable one.

I am - the tests will run against a runtime-prefix-enabled binary, but the
overrides supplied by the test suite will still be respected, so it should
generally behave like non-runtime-prefix in the tests.

> I wonder if the relocatable Git would allow a simpler arrangement to
> test without installing.

> I am asking merely out of curiosity, not suggesting to make a trial
> install somewhere in the build area and run the built Git normally
> without GIT_EXEC_PATH trick.

RUNTIME_PREFIX resolves paths relative to the runtime path of the Git
binary. These path expectations are constructed around installation
directories, so I'd expect that installation is a prerequisite of testing.
It's also worth noting that the runtime path resolution is
platform-dependent, so some Git-supported platforms will not be able to be
built and/or tested in this manner (at the moment). I only implemented
support for platforms I / Chromium uses, both because of my ability to test
on them and my own familiarity with them.

That said, if the test suite dropped its overrides and did a local
(testing) installation, that would be expected to work on the
RUNTIME_PREFIX binary. I assumed that one of the reasons we don't test
against an installation is b/c Git hard-codes its paths, but this would not
be a problem with RUNTIME_PREFIX enabled.

-Dan
