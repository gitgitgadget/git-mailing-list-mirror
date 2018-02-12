Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2292E1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933025AbeBLIsp (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:48:45 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37154 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932985AbeBLIsd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 03:48:33 -0500
Received: by mail-qt0-f193.google.com with SMTP id w1so2811874qti.4
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 00:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xqv7PlsceJCv9rsjSTC3e5PuuOFW7xctk7fyqqCN84s=;
        b=SGZLv0TW4OiAsOpMrF8E6fBPc8XrGxK6hSa5gSMeiSPaPSuRzMYjHyi42gcfQ0qplj
         JJ2ZO2r6dOS07FVLBQ9nqpio9L/6xJrMeJQp1gpdC8mlRAjs+nbT3WOB0Nbjrv9lVi3o
         NaTkuOuxLQUei75jivPeykmrztK+lm7zLfT2Q3blLT7trVT6L93D80aYw1/g8c3B2M7v
         yg6m5EBVgYHabhqiniBMVfw/O0gk6cNC1Y4CbbbcgRy7hHPpUACc9waW3aFTXJrYm9un
         gTJwNjNcaQ/jCsx0U86kJWzG9d18h2L92XADIlKTN0QvkSW2ZNnPPO26CAJBV2IHyHw1
         V0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xqv7PlsceJCv9rsjSTC3e5PuuOFW7xctk7fyqqCN84s=;
        b=fRuMZZGFWaA4Mvx6HFRPX8ojeCnvMwENgUSKF7SThHzYvovsW3bIxS0p8t/b/FkDVa
         9ddvsFozm85rcjpR3erEBmElNfZ7900yArvHWLBB4wl96rhKSBeBI5XP3L62TOcJpqvQ
         hHXDGwvQ2NgUO7x68iQLpj2NEoPM6ygXM6RX/OnOmOYS9WuWzOFBlIMtgJD2OIhE0IJr
         Wc2FOwAem0DaAfB1sw7XRKWGaXXk89uDIbdNBfiBymllmVx0fD8QLjQ+HpMrOrtlmqHx
         kUrYkwM1FKFn/sr+Dxyig0Wl3FxoXUEncJRRxvXIu4fLVFb1J/JecTjZ5z2VQs9GHPsv
         6XPQ==
X-Gm-Message-State: APf1xPBjLhzsNrCMj/XQPJBJKJF/FTg8oajgucJxZLYFtOWMvJo43Jwy
        LsHThtbgFlY5XP0gfznMWDMnN6iQLFZdT+QQal8=
X-Google-Smtp-Source: AH8x225NZAHUttJnC/fGzksIUFWh2qCQLMdBr79n00q1qf3DIDCTbyyLRBBLe1bBOrK+rHZ+h0hfBYAJk3pYy8nMMtA=
X-Received: by 10.237.37.161 with SMTP id x30mr2267553qtc.78.1518425312443;
 Mon, 12 Feb 2018 00:48:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Mon, 12 Feb 2018 00:48:31 -0800 (PST)
In-Reply-To: <852814d99f39281224c8f75668b18adae57864b9.1518307771.git.johannes.schindelin@gmx.de>
References: <cover.1517266437.git.johannes.schindelin@gmx.de>
 <cover.1518307771.git.johannes.schindelin@gmx.de> <852814d99f39281224c8f75668b18adae57864b9.1518307771.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Feb 2018 03:48:31 -0500
X-Google-Sender-Auth: RgpMoMNIckur6izVUA4fkXJ0Nww
Message-ID: <CAPig+cRc079RsC9i2S9PisE7pZjVfM8i7rUhbT-t6vupFZUaKQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] sequencer: introduce the `merge` command
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 10, 2018 at 7:10 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This patch is part of the effort to reimplement `--preserve-merges` with
> a substantially improved design, a design that has been developed in the
> Git for Windows project to maintain the dozens of Windows-specific patch
> series on top of upstream Git.
>
> The previous patch implemented the `label` and `reset` commands to label
> commits and to reset to a labeled commits. This patch adds the `merge`

s/to a/to/

> command, with the following syntax:
>
>         merge [-C <commit>] <rev> # <oneline>
>
> The <commit> parameter in this instance is the *original* merge commit,
> whose author and message will be used for the merge commit that is about
> to be created.
>
> The <rev> parameter refers to the (possibly rewritten) revision to
> merge. Let's see an example of a todo list:
>
>         label onto
>
>         # Branch abc
>         reset onto
>         pick deadbeef Hello, world!
>         label abc
>
>         reset onto
>         pick cafecafe And now for something completely different
>         merge -C baaabaaa abc # Merge the branch 'abc' into master
>
> To edit the merge commit's message (a "reword" for merges, if you will),
> use `-c` (lower-case) instead of `-C`; this convention was borrowed from
> `git commit` that also supports `-c` and `-C` with similar meanings.
>
> To create *new* merges, i.e. without copying the commit message from an
> existing commit, simply omit the `-C <commit>` parameter (which will
> open an editor for the merge message):
>
>         merge abc
>
> This comes in handy when splitting a branch into two or more branches.
>
> Note: this patch only adds support for recursive merges, to keep things
> simple. Support for octopus merges will be added later in a separate
> patch series, support for merges using strategies other than the
> recursive merge is left for the future.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
