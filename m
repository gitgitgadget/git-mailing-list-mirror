Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF9920A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 18:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbeLXSwr (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 13:52:47 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:38325 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLXSwr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 13:52:47 -0500
Received: by mail-oi1-f174.google.com with SMTP id a77so10435864oii.5
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 10:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M+eRQfU/p6k87l2O3fdrcyVg8swWrN5yO1t9gsGH6xk=;
        b=SRClFGcIvlZNfA8tBbGUwe2juFt0+212jKTlaaLCAX7kJh+ikHWJZGLEUapuLbhiuc
         vHeWNEUg0HZoUjIJ5eh5PYxRZ3m5FfYq/+Cb626AKaBU187D7laZRhH8ezeXD/PwlQhT
         zfJ5PmCAnrI3X31wzd1tlUppkbHdf7MA4lZaoWxvH8qctBm9lKKQBfcphve8BaLb/izQ
         miMRXPhzBkkFqzikORLELR9wCHCD8GTHm9UR7/EXcwhsrclZT2zu8Y8kCxQjYXNFtjP9
         zgMX3own99ggp3hGanuGSRoIdyLT+P15JvnABxtF9np+gOtuSzBtxIYYLrDrKl0R85SD
         U0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M+eRQfU/p6k87l2O3fdrcyVg8swWrN5yO1t9gsGH6xk=;
        b=CbP1pnYZFR96bUZZuT7QBx3X4frg2frLrz7B1zMySrfXrECf3cGs1TbEJq3PwjV+kN
         /0vjBXp7SDGdLpoSSgjiloIMRS6JJQKWaDNUaV2c5YrHDN6X579V1YeE5l50cNSmXWk4
         EsMiXGe+6ST1vNWbIfx9qJYjrFh2s1V0ZlCLXea53oGUrjBMEAwV6+ajBMsUhuB/GsFg
         oWqMpDNnbLC/vbbcPflO8HJTi/skkDLLmxApp79xcyUqFyCZVpY5R2yohfMlyuGQ4MrL
         cKqYDMhejD0u53XdskZfVDBcWDFc3hLksvV8h+lLcivn53NQwx0IpUI7LFR6OQETxbmG
         YsTw==
X-Gm-Message-State: AA+aEWZlkPxptc23agXMkD+G3byepXHM2+T0zAZfIRSniEqI4P4qBKFa
        k6ktT00XoW2AdSenqqvFATqAVvigZWpaCcn8VYg=
X-Google-Smtp-Source: ALg8bN70swucS0uP2Pg0wCrXUpC6bkxEPDzTKTfkO34uZf5tZcGJsw/wsIwTSrQPcKlClhjJvlT7S8HV4G2qcXNeQvc=
X-Received: by 2002:aca:3092:: with SMTP id w140mr8982567oiw.237.1545677565729;
 Mon, 24 Dec 2018 10:52:45 -0800 (PST)
MIME-Version: 1.0
References: <CAFW+GMDazFSDzBrvzMqaPGwew=+CP7tw7G5FfDqcAUYd3qjPuQ@mail.gmail.com>
 <CAP8UFD1ErRo7NQmCrAJLaELzV-1rKowyPsNCi3ecTqGN1qWxKQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1ErRo7NQmCrAJLaELzV-1rKowyPsNCi3ecTqGN1qWxKQ@mail.gmail.com>
From:   William Chargin <wchargin@gmail.com>
Date:   Mon, 24 Dec 2018 10:52:29 -0800
Message-ID: <CAFW+GMB4KW34qaOWNwShWM_ERSJtnvp86V_mFAse1biO=T-srw@mail.gmail.com>
Subject: Re: Parsing trailers
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian: thanks for your reply.

> Changing the default separator as shown above, should make it easier
> to parse the result.

But this actually also changes which lines are considered trailers,
right? If the commit message ends with

    Signed-off-by: one
    Signed-off-by| two

and the user=E2=80=99s `trailer.separators` is set to `:`, then the correct
result should be only `Signed-off-by: one`. But when adding `|` as a
separator, we also see `Signed-off-by: two` in the result.

    $ printf '.\n\nSigned-off-by: one\nSigned-off-by| two\n' |
    > git interpret-trailers --parse
    Signed-off-by: one

    $ printf '.\n\nSigned-off-by: one\nSigned-off-by| two\n' |
    > git -c trailer.separators=3D'|:' interpret-trailers --parse
    Signed-off-by| one
    Signed-off-by| two

Best,
WC
