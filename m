Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 834F8202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 19:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbdKSTP7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 14:15:59 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38612 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbdKSTP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 14:15:58 -0500
Received: by mail-qk0-f196.google.com with SMTP id a142so5101504qkb.5
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 11:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6Vzq5Q1DptHo5nCWlhBqesaSNla+OIptIi9SpLB8Lfc=;
        b=vZIJVXmHZoWy2ZnLAE4CtWIAFT991RCG5y8brUrQfmn6EQdZ5MmM/NCIL9FkiJwaFP
         a8u1buEh3UHs7CTEvCU9nrqdOQug3UJQj7GGh6NEENOyCbzvIcjgk0F1lkIYIzro1koh
         IMBf5vVxnaSe87zv3xKmYvRj7EJ/4rZlEwrFy8a5DUnscsviK+Io2YenLqrHyB5VylXz
         StR53ylzETy0wzyC1d48HcQYXEBtCraZr/ULX0vpn7B+vfBSCXydtS5GIcWPkRZEww4O
         x2uJa2BDuuEzlbiY/dm4bnmc9lH4/2UXnGCTBYZuBPlHnPLOQ9B9cYl8PLJxbpw9YHCV
         evrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6Vzq5Q1DptHo5nCWlhBqesaSNla+OIptIi9SpLB8Lfc=;
        b=JyNnhkrlvg7cmISybtt5gIB3/qrBb9i5Og/JObrxiUYBO4ocBBs0YsgtbSOv/+nnje
         1zvZkgSR7cGIK6l0nEf1YCZJQLRPRLZJeWkURSaV56yFbErMjNnc7qCnbM8YmmLrS3NJ
         67ZgaXy/6ka1s0D1rV+HcxUwAyS1qBnKTP8rk6MjgTBivKMqWm9MjDghQ4/p5P4wDy7/
         FWVgvzk5ZShxyTcypqwhdobLCvfIdh4aKlOFm8RSz6LslkevQ2Xv0Bfb0k41sxZehp7C
         y3y55Ay/Kama5o9c6+GWmqDtafZvPIb7+bGhr6OenL8XkOjhgR2tIE1zpX1J88+tIxOA
         oHpw==
X-Gm-Message-State: AJaThX6vudPupd8tAWjctNMXs6/I3BYMFu1UObaCdoRNAcIDW12o9jaz
        86P8mx2n/1Nb6zszdmlgUHXNJ2xjzuZegnmEKss=
X-Google-Smtp-Source: AGs4zMZG8irPm560qiH8ImP0dwaIKuyNGex0DOnF98DZ5WC4edf2hJHxipGI5nFWIbKRstUrnNanWHGyhHXIkSlgIyY=
X-Received: by 10.55.130.194 with SMTP id e185mr17233972qkd.357.1511118957777;
 Sun, 19 Nov 2017 11:15:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sun, 19 Nov 2017 11:15:57 -0800 (PST)
In-Reply-To: <20171119184113.16630-3-bedhanger@gmx.de>
References: <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley>
 <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de>
 <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-1-bedhanger@gmx.de>
 <20171119184113.16630-3-bedhanger@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Nov 2017 14:15:57 -0500
X-Google-Sender-Auth: 3PR7-xRnZWQWHkbqpGtGwMdMkjg
Message-ID: <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Documentation: user-manual: limit usage of ellipsis
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 19, 2017 at 1:41 PM, Ann T Ropea <bedhanger@gmx.de> wrote:
> Confusing the ellipsis with the three-dot operator should be made as
> difficult as possible.
>
> Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
> ---
> v2: rename patch series & focus on removal of ellipses
> v3: env var instead of config option, use one-line comments where appropriate, preserve indent level

I dont' see the  new PRINT_SHA1_ELLIPSIS environment variable
documented anywhere in this series. Did I overlook it? Without
documentation, it's not very discoverable (aside from reading the
source code).
