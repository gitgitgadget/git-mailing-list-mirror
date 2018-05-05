Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 598D21F42E
	for <e@80x24.org>; Sat,  5 May 2018 07:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeEEHgO (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 03:36:14 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35470 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbeEEHgN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 03:36:13 -0400
Received: by mail-qk0-f194.google.com with SMTP id g4so669811qki.2
        for <git@vger.kernel.org>; Sat, 05 May 2018 00:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PBD5mqkI+XRW5g2jV5zIBET3cSQWyXQZvwTarAsyLmc=;
        b=bfq0Dxhwgfn97SllezkGMZfZLSspcrXLI7O4ja3uslanEbWOa1Y+37lYyJM2+ItGsk
         aXUXZJ/iCv1SGQOkOu3ET04mboD7XeBISzOpF8CgON70+GCmlpYUYxOWHcitEi7in/wT
         KrU5BPdkW3yhp/P97/G6mmpnwlDy5BTZgX4pMCtrIFhD31kZxElFiotjaSxGBDH87f/P
         K/DZ7ikyuNuUxd1Ws332wzQ1sBx01W0uD8eSSe2vO13eYTcqrRcPlxD3Q9dR8AinLVOy
         iKuI23UpsVdAF2J2jxSpKYd9Icd/uuK+ssnDAc6IAYzVdvyVnI4wvjOzKByjIxHxQyc8
         qEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PBD5mqkI+XRW5g2jV5zIBET3cSQWyXQZvwTarAsyLmc=;
        b=RoJTLOu6svhnBgKbqnIt+Ya6H33F12pItDuisl4xyzqg09UkX2NsfVebjbrQH8jxGU
         yPIz32RSY2dpqAfWygP6VpC+9cLfzU0vRrFhrMgMqU+zjEu+pq0sUNL/Qsk2oYMV+f83
         bVweRtmVKcrW14Zd9AnGyJaaXV5FEQfUVEsMPvTB0gLC4Uwtpe0YL58mnCzBlM2HU1ob
         fuS0Xb3A/umxxE3WWViaZmK30+Qo/0F/D3ztquNqG0oFZOaYQdVG6355o5WSa1RjDgF3
         8aJ1XKuW0Nqnc7UZ7uuKBLdYCrD3NdofGJuMejzqHiprDkC7iSeZzq8vfUUY8kT0dh5V
         r7gw==
X-Gm-Message-State: ALQs6tByRaIhNtj2qYIEOBr1Y0cwI5rULbpzFDMb24Q7PzF+lT/ftBhj
        NX5RXwPCrvxtp9cpSt0+vy3zl0MIHUQbmzs1XAo=
X-Google-Smtp-Source: AB8JxZpKHWM8vjjhbMqg6AHg9gD4/JY8p0swxEgaEvEfXy5aaY03VZ6j2yQ/biSzVGagHoifaQsFAu7MZNiwwlgcdkg=
X-Received: by 10.55.108.198 with SMTP id h189mr15093932qkc.2.1525505772518;
 Sat, 05 May 2018 00:36:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Sat, 5 May 2018 00:36:12 -0700 (PDT)
In-Reply-To: <c8b527c5de3b0e5422d2c1afb91d454d1e46fff4.1525492696.git.me@ttaylorr.com>
References: <cover.1525492696.git.me@ttaylorr.com> <c8b527c5de3b0e5422d2c1afb91d454d1e46fff4.1525492696.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 5 May 2018 03:36:12 -0400
X-Google-Sender-Auth: UfhX-r9AKaL1uXKdhaH39-hrtfc
Message-ID: <CAPig+cSRJWW4-7vj6wK8aOfNB20bqUCSOOySjdPci1r5Vb83Uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/grep.c: teach '-o', '--only-matching' to 'git-grep'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 5, 2018 at 12:03 AM, Taylor Blau <me@ttaylorr.com> wrote:
> Teach GNU grep(1)'s '-o' ('--only-matching') to 'git-grep'. This option
> prints only the matching components of each line. It writes multiple
> lines if more than one match exists on a given line.
>
> For example:
>
>   $ git grep -on --column --heading git -- README.md | head -3
>   README.md
>   15:56:git
>   18:20:git
>
> By using show_line_header(), 'git grep --only-matching' correctly
> respects the '--header' option:

What is the '--header' option? I don't see it used in any example.

>   $ git grep -on --column --heading git -- README.md | head -4
>   README.md
>   15:56:git
>   18:20:git
>   19:16:git

How does this example differ from the earlier example (other than
showing 4 lines of output rather than 3)?

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
