Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91C41F404
	for <e@80x24.org>; Sun, 22 Apr 2018 03:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753367AbeDVDa4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 23:30:56 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44452 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbeDVDaz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 23:30:55 -0400
Received: by mail-qk0-f195.google.com with SMTP id h200so12118551qke.11
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 20:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Bf5tN7yNdiB13oo43OWTxS5Cd/Tfr9jFKbKjGRtWoc4=;
        b=ZEBQMteNVTPOwGEQszV0/EUO0EQ2clfBvYcfc7Y9/KAa+dGOT3Nmxgj5VNK6Ocku8j
         OUZoSR8JIu2B/ShADTE3xEmvoTrBSxM8U4dL9wPGoa4/K9KLri1EYuqAlsw2QFxF52Yz
         oMUae0l1Z4Gok/JKoL6OSn8z+fhTr+uPUd+XIi/1f8hhajDYOO8Ej4iXR3cclS9oMnrv
         E9Sax28VY3Em/VHcLB3qAHehoxHVPSI5b0h+8bAA8f9uTAESOpXoXfTMkamISwZqG9y0
         Yoo8qzn1C5mHqKa1oFYzZfXJGXDXW9qudMQmXDYHSZNtVUQmhw/gyUjiXcmLDBrTR/HC
         NBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Bf5tN7yNdiB13oo43OWTxS5Cd/Tfr9jFKbKjGRtWoc4=;
        b=ZbP2M3W534j3pcIkzyrhWbIt+FqL4skroF624h0+RkFXnd7fkYbkf/MVhkIY+FWSlS
         3R1CumwPaLwh44n+s02VFDtYmDa4wzoGn+p6lotnqhpZ4OwL5K/UVnZLnPJ7EbCuNZJ4
         3ITyjRfDUfLJvbUcRpSCYTqex2DHU/eka3YPIPkzLnMNgSrSlg+GSYMXHJ6EjmEzk/gs
         wNlAEiShtSO0vEMns1uIpuL+f9+Uo6jH73IzAlGadbYVEvULlrkcdy4YMBNloTsJyGpq
         H6Q+A/6KXi3YlSgcikVmbuaO3T27yZpOOQBAThsZOaAc/tl1z16HWYsHJMV12T+4Zekm
         l7qQ==
X-Gm-Message-State: ALQs6tBeV9wE0GN9DeIOXalFrYb3zvww8/VG+usr7lBkOnq9BYKhlsyn
        A0toXWiMfGd5zZeOeCG4cGNqGHYO/VDOoezqQxOmiA==
X-Google-Smtp-Source: AB8JxZodvh7fPlYM8vM+32I6JqnUGJzj/0dmMTJXcVc5AQjqOaVhNDaKrO9XMbYVZy66qfHOFwMYyS/eaCrfLf2r+qA=
X-Received: by 10.233.220.1 with SMTP id q1mr16221423qkf.361.1524367854449;
 Sat, 21 Apr 2018 20:30:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 21 Apr 2018 20:30:53 -0700 (PDT)
In-Reply-To: <fd4ea54ad8da5e4e93fafd558e104b0a19f6268c.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524262793.git.johannes.schindelin@gmx.de>
 <cover.1524303776.git.johannes.schindelin@gmx.de> <fd4ea54ad8da5e4e93fafd558e104b0a19f6268c.1524303776.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 21 Apr 2018 23:30:53 -0400
X-Google-Sender-Auth: VO8vXiuOi-WqlAisIJXYAMirKLo
Message-ID: <CAPig+cTDbTtUeFYmkNtM773EBgE14Tpic4g4XEFuSVwSypdMjw@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] replace: introduce --convert-graft-file
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 21, 2018 at 5:48 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This option is intended to help with the transition away from the
> now-deprecated graft file.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/builtin/replace.c b/builtin/replace.c
> @@ -454,6 +455,38 @@ static int create_graft(int argc, const char **argv, int force)
> +static int convert_graft_file(int force)
> +{
> +       const char *graft_file = get_graft_file();
> +       FILE *fp = fopen_or_warn(graft_file, "r");
> +       struct strbuf buf = STRBUF_INIT, err = STRBUF_INIT;
> +       struct argv_array args = ARGV_ARRAY_INIT;
> +
> +       if (!fp)
> +               return -1;
> +
> +       while (strbuf_getline(&buf, fp) != EOF) {
> +               if (*buf.buf == '#')
> +                       continue;
> +
> +               argv_array_split(&args, buf.buf);
> +               if (args.argc && create_graft(args.argc, args.argv, force))
> +                       strbuf_addf(&err, "\n\t%s", buf.buf);
> +               argv_array_clear(&args);
> +       }
> +
> +       strbuf_release(&buf);
> +       argv_array_clear(&args);

This argv_array_clear() is redundant, isn't it?

> +       if (!err.len)
> +               return unlink_or_warn(graft_file);
> +
> +       warning(_("could not convert the following graft(s):\n%s"), err.buf);
> +       strbuf_release(&err);
> +
> +       return -1;
> +}
