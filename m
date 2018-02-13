Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F30B1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 03:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933416AbeBMDzp (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 22:55:45 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:45156 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933025AbeBMDzo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 22:55:44 -0500
Received: by mail-qt0-f182.google.com with SMTP id x27so2178627qtm.12
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 19:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZczFAo3J3K3HjqgO48qlgX9S+Vsz+nbFhRdi46JxO5g=;
        b=C9JugHOOM1x2kL/v1/czJ6NgeqRPgGWgCnTEQJBzL/5q4kANoGhOwrAhbZ4hc4F6VM
         T6ESYNscdfgNkelkoGxUvMyuHFHTlSQXgvSIof5v3OhHCvHygvhRnpvzEJ2y8JMb3oh5
         QM3CHd6yxbi7hP+kmYstX4C5TUh0nXrbvlBgMhJcTtYo5m++J9UlYqLf3QlZKbj1XtxN
         1yZEl8DGKLgybCAXu24Uf5U7jlO2ZewOAs7fAWUAQ8XFKGR3S4wglTxJIVUAULC8eLBL
         fEwvarV6asq0+U07RMSFhWA8BO1OIFh8JrZzDlbJgGidjBpGH0p1SRybhQIfHKOEMgB6
         MLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZczFAo3J3K3HjqgO48qlgX9S+Vsz+nbFhRdi46JxO5g=;
        b=SvxxPdlSAgF51gnE+1/YAmpPYQEdDeQhvhN8WZvbRZrrdfehJrd+yuHQCyMikuq3SZ
         2pIH1xqwRWw5OzHjub2xg2NyWx7imTzLpV+0LcwsPOq+j6f76r5lodnvI0CqJiTgZo6J
         +fNgNvoWP66nh81lAw/DjcNu7s9K5D0kU9wPX3RSTK+rsElkGuA8o1IZ83cTvs3SldTv
         lAQXkuzBRQfvMqqZV8iLZlqq2DCdvc6wdOLO921naSMrPeURSv+VVaFAKeb6GDJZnYlt
         eLyPXimfhHsY3tG+zNR7pM8ctmGZz1mleZbPBLIBHl9ZGMsivoJU49dIQxMTfuuXg7t9
         SgDQ==
X-Gm-Message-State: APf1xPBMegveDftWLWQ2jZsVcKwfBXskZYli+39dwVt1oFNn4CG7v3IW
        Tlx6jjYS70sxECyrRxcTmPfhqhfxzNT3+G0CoTA=
X-Google-Smtp-Source: AH8x224ZKbCAngPS/Et8zA2+l5lQ6X6zeVBtWTJDmTYzDDT/NEqGtkZr4YuqLKyP/k/IvVxKe1JCKCJfGOsKmdwmSAg=
X-Received: by 10.200.51.100 with SMTP id u33mr16936502qta.127.1518494143716;
 Mon, 12 Feb 2018 19:55:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Mon, 12 Feb 2018 19:55:42 -0800 (PST)
In-Reply-To: <20180213014130.190374-1-sbeller@google.com>
References: <CAPig+cRUr=dJgaG2-aRArswQXXZEExQah4k17+HkiB+sZHORYQ@mail.gmail.com>
 <20180213014130.190374-1-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Feb 2018 22:55:42 -0500
X-Google-Sender-Auth: 5IGM0Or1DCJpduwVPbQnlJdaHls
Message-ID: <CAPig+cSQecUr5+QkSWNHbzUeViTA7KjLdcjLZmfhK5hT-fuKfA@mail.gmail.com>
Subject: Re: [PATCH] color.h: document and modernize header
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 8:41 PM, Stefan Beller <sbeller@google.com> wrote:
> Add documentation explaining the functions in color.h.
> While at it, migrate the function `color_set` into grep.c,
> where the only callers are.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/color.h b/color.h
> @@ -76,22 +76,46 @@ int git_color_config(const char *var, const char *value, void *cb);
> +/*
> + * Output the formatted string in the specified color (and then reset to normal
> + * color so subsequent output is uncolored). Omits the color encapsulation if
> + * `color` is NULL. The `color_fprintf_ln` prints a new line after resetting
> + * the color.  BUG: The `color_print_strbuf` prints the given pre-formatted
> + * strbuf instead, up to its first NUL character.
> + */

"`color_print_strbuf` prints the given pre-formatted strbuf (BUG: but
only up to the first NUL character)."

Probably not worth a re-roll is Junio can amend it locally.
