Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF0C51F404
	for <e@80x24.org>; Tue, 23 Jan 2018 00:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751142AbeAWAAO (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 19:00:14 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:43904 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeAWAAN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 19:00:13 -0500
Received: by mail-wm0-f43.google.com with SMTP id g1so19463734wmg.2
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 16:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=sHdfMKYANecYGIawfPgjDy5zOv3hRhGnBEdLwnEq3jQ=;
        b=BieHNvSbengQVPQfn7f9yHcuQixT8lerNuhyDOwQPtPFJgCfhlJ7hQOnxldiShItal
         Kc4olPNIOdh2GJsxYpscH4ncAkiTTRSczAsP5Ceovxbv0JxdCdly1OK4ZT3opjhzpd9M
         Q7Pv2Z8sQzdf4uVeO7yJUu5rYBZtpVOd4Yazx0BtLtTDSi73bjp19FimtgFfqDa+ntzw
         akKZrzLCF2JiOmPiR1WpVx9YZw4FSM+3vyg/iBEqN3lWqFYlrbQC+5Eo6hKekuRqxpnk
         ipsV+wmsGrYFR0bb2hPxkdDWkJC8OFBcTl2bvNy6xHu7gPDDgJlnNzwkhp3JDh2rC/M5
         A0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=sHdfMKYANecYGIawfPgjDy5zOv3hRhGnBEdLwnEq3jQ=;
        b=LsFtJwebFOlI13+sXeUwOhj/n+oMrc/BesojKrTNrnFfzVHMUmXKs90N1JaHh525M2
         oeUfbd1wK2B8JS/97ktraaTwrrDirC39DuCXOKbysr4H91rZnXZfSPN5CaH3Wyb9hhqx
         abb1+Co8OfnzylOmtt1nn75eNT9Y7/kDxTU7pN/YlXEsjn/EVk171q67X8qdOLIG0JfC
         y67rBJj4tG+4VkstCOQ/cPhn49rQFoM5XgrFqEHUhKnGlVZ4qaYXKkFrJBHTpzC3R1CP
         XzsLZNsNAlGCYkbIZNYx9latc3R96AoufbiQ6BGWZfuPYljDD9OnAiQYbiLT4Ge+JqkT
         aUPA==
X-Gm-Message-State: AKwxytdmagX0ybKpP9/fEAYXaS9sHNk6IaQtQ4AcjTh1v5tXZmKwqLX/
        L++o0p9wEH1DI9CALwR49WZk+9wc
X-Google-Smtp-Source: AH8x224a/ThJrTJUMPOGfWCtqisRAGOHQWX1rL+x+dHMlp/UXlTlSUa5rFm66dgEQ4u9VUVtHf/GUw==
X-Received: by 10.80.241.89 with SMTP id z25mr16417891edl.104.1516665612663;
        Mon, 22 Jan 2018 16:00:12 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id o6sm11722067edj.24.2018.01.22.16.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 16:00:11 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lucas Werkmeister <mail@lucaswerkmeister.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] daemon: add --no-syslog to undo implicit --syslog
References: <20180122232304.4863-1-mail@lucaswerkmeister.de>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180122232304.4863-1-mail@lucaswerkmeister.de>
Date:   Tue, 23 Jan 2018 01:00:10 +0100
Message-ID: <87shaxh2b9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 22 2018, Lucas Werkmeister jotted:

> Several options imply --syslog, without there being a way to disable it
> again. This commit adds that option.

Just two options imply --syslog, --detach & --inetd, unless I've missed
something, anyway 2 != several, so maybe just say "The --detach and
--inetd options imply --syslog ...".

> This is useful, for instance, when running `git daemon` as a systemd
> service with --inetd. systemd connects stderr to the journal by default,
> so logging to stderr is useful. On the other hand, log messages sent via
> syslog also reach the journal eventually, but run the risk of being
> processed at a time when the `git daemon` process has already exited
> (especially if the process was very short-lived, e.g. due to client
> error), so that the journal can no longer read its cgroup and attach the
> message to the correct systemd unit. See systemd/systemd#2913 [1].
>
> [1]: https://github.com/systemd/systemd/issues/2913

This patch looks good, but I wonder if with the rise of systemd there's
a good reason to flip the default around to not having other stuff imply
--syslog, and have users specify this implictly, then we won't need a
--no-syslog option.

But maybe that'll break too much stuff.
