Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F8451F404
	for <e@80x24.org>; Mon, 15 Jan 2018 09:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933290AbeAOJ6i (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 04:58:38 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:43271 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932909AbeAOJ6a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 04:58:30 -0500
Received: by mail-qk0-f171.google.com with SMTP id a5so13294070qkg.10
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 01:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Dk/+xoHCl9iIcC6mGgZ+VZX92VG/ubbaFhvQd6OeHRc=;
        b=JLUjcNJ4xBLBTi7BxvfyLcMB7POarxBqgJCitEEtn4uIjaocVFstrTwIMbhXkNO+OV
         Nep5tgiL31QbNUMdaQuXWFTHl9fHqJhTzxz3tYZt6kLu1qJer27vr7MRAJlvVZMQZqcC
         muCybZi406BG2GuagHzCuuOE9lLFM6gfjsLcIbBAtlxPiUwnCKywj+shRMyzntmlT7JS
         EWHp+HFb0x31bccKnjGORPXTNe80pguHBJ653IhibfdicGPdkggZ9jzHLGHSPlFsGxoM
         dHOFHUhWcOJwkfMMp23gD8PdJq72KmIQIfQyF97zVgKA8nSjGZ/jhedLXxjYqFA2pzPI
         TBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Dk/+xoHCl9iIcC6mGgZ+VZX92VG/ubbaFhvQd6OeHRc=;
        b=ODif0UGsDtrSqjKTvEa6Sgk8PYnCYWlro3sp5+3KhIRZ2IYm6oIqyd9i4rJmwegX3d
         p4SpcNrjtxJjIsIfv7Y59OEmP9NszDN8JuZHyXWgicoBvnDzkYQ+E+QT5UlPMG5WwYMm
         Rb2f5GhyPTRF3vkhMMGX5D+gyFC6IHbIq4ZLPfipLMukySoCkK7G4o+F2xWal4y02SXV
         Vyhlh26egOZAIVjEAM18/zgvyQpQEUNQ+PORndmILxBG8ebVOu6Sx9APBsIFC5T0PRHt
         cgnfmt9x3rbMYVLKOew9blwHbihxMg3yEdWQBDMpN6KaPTqyxBlNC24cnIJapIVHPO3G
         ZYgg==
X-Gm-Message-State: AKwxyte1oH6Oj/R5z3gP3zdhqttG+vPaEKnyv+gbNJD5/slwvTqK/oQ4
        7pxARbIosKX8hbWGwf6vITHOwKw1pQUb6VXdcJk=
X-Google-Smtp-Source: ACJfBos4ubSstCh8DA8SRHKJx3lxoI55176NWf13tTo4h6uXFhLYnug6zJm7K7qBuuovUkZxgZLoPsYsakR/XKZavBg=
X-Received: by 10.55.6.19 with SMTP id 19mr35363662qkg.132.1516010309777; Mon,
 15 Jan 2018 01:58:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.143.2 with HTTP; Mon, 15 Jan 2018 01:58:29 -0800 (PST)
In-Reply-To: <20180115054419.4112-2-ash@kambanaria.org>
References: <20180115054419.4112-1-ash@kambanaria.org> <20180115054419.4112-2-ash@kambanaria.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Jan 2018 04:58:29 -0500
X-Google-Sender-Auth: _sLzAW7e2dCqnotucKMrRJnrdUw
Message-ID: <CAPig+cTm=bNqncS63DmN6Qi7GGkXcPv-wnKfNe=btgSM9YTPYg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Mark messages for translations
To:     Alexander Shopov <ash@kambanaria.org>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 15, 2018 at 12:44 AM, Alexander Shopov <ash@kambanaria.org> wrote:
> Reuse already translated messages if possible
> Do not translate messages aimed at developers of git

A couple comments beyond those from Hannes...

> Signed-off-by: Alexander Shopov <ash@kambanaria.org>
> ---
> diff --git a/git.c b/git.c
> @@ -5,11 +5,11 @@
>  const char git_usage_string[] =
> +       N_("git [--version] [--help] [-C <path>] [-c name=value]\n"

Since you're touching this, perhaps take the opportunity to fix `-c
name=value` to say `-c <name>=<value>`?

> +          "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
> +          "           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]\n"
> +          "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
> +          "           <command> [<args>]");
> diff --git a/setup.c b/setup.c
> @@ -525,19 +525,19 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
>         case READ_GITFILE_ERR_NOT_A_REPO:
> -               die("Not a git repository: %s", dir);
> +               die(_("Not a git repository: %s"), dir);
>         default:
> -               die("BUG: unknown error code");
> +               die(_("BUG: unknown error code"));

This last one is aimed at developers (indeed, "BUG" message should
never been seen by end-users). I'd leave it untranslated.

>         }
>  }
