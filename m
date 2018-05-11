Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 928301F406
	for <e@80x24.org>; Fri, 11 May 2018 12:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeEKMQr (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 08:16:47 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:35871 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeEKMQr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 08:16:47 -0400
Received: by mail-ot0-f177.google.com with SMTP id m11-v6so5974612otf.3
        for <git@vger.kernel.org>; Fri, 11 May 2018 05:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zif1cMtIkmKA2i409qGyPTl6duiHdQVyUyuxruwEQsk=;
        b=hXLAqNEr9yu6uV98uQZ2zSCtgxqDGv0kr93fT/YvL52Xe/kdUW5SUIgYH1kCsS5zKF
         Ldc6gsI/AU5dnCnNk4qHvsxiy4fngbf6PPMW6vKE3+YZoUzU9+qECNEQBPvDkaZaOCxb
         kCa707dADG3tXMGX3LO9MNF7ShS6FrussKDW51uQbrHbatkH9kaiA71FLUT1GwU1OA0i
         BdigYKw99Hl5c1114ZmlgWmXQo8Nfmx46jBhapp/iZKX6Y4P+DLFH5D4fidmZeWvCXYj
         bsSWAqZ8X08XOqPWjMqYqiJ66Kvs/nyIa7P1UAl1xG30SrA0ETbU1enNMuSB9/tmqQ7s
         safQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zif1cMtIkmKA2i409qGyPTl6duiHdQVyUyuxruwEQsk=;
        b=N5v5hd07ovxFlSU1xK8ISx638Pfdf72IdKUxnq+jGCgSZo/qXeF6Ftzbh8qGdUcWHc
         kMyEgpUnTTHQu3wuP8tBkYagkdeNcb+r2qdKyHJXMwlVCWM1x4YZbtRTZOiTZKysyREp
         wmwYtS7fIz9/S923MOv8WZcimAFUZbNykQre60IA45XH9CpPhDrnfs5mvUyO10sDCYX7
         w8M5qrqEHnelbgWTpsDFJ5mKass4VUIbOgVncd/kkWAMGvUt2RyRdVBfeTMR/oehxN+k
         yV4AkdniuAOEa2dpsW8BdMlIvnVjrCoslv6wk+3JUhkf/dvrqAjRns7Z7bFDrKO/wwKv
         rZsw==
X-Gm-Message-State: ALKqPweybSEdFbiRFoqymUh8uV4petqsEifzcVx2hd7Yph7nnN+Erics
        KIbpV84lJ2T5o+/+hYFPFpFnMTBQSJG5pil68S0=
X-Google-Smtp-Source: AB8JxZrAmrjyaPvJzU+GajS9S/iSY/fJKnzdGds1eD6tesbvQbB3/AzjuNQBLJNbuC7scgIzxQcu3D68UGbYMwrhKjM=
X-Received: by 2002:a9d:c61:: with SMTP id 88-v6mr3773138otr.173.1526041006576;
 Fri, 11 May 2018 05:16:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Fri, 11 May 2018 05:16:16 -0700 (PDT)
In-Reply-To: <20180511092515.GA9567@sigill.intra.peff.net>
References: <20180511075602.9182-1-pclouds@gmail.com> <20180511082840.GA22086@sigill.intra.peff.net>
 <CACsJy8CE2tnhH6eds6ZePyMxFXGnnyHDkWjSBbJz97BmYFr-gg@mail.gmail.com> <20180511092515.GA9567@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 11 May 2018 14:16:16 +0200
Message-ID: <CACsJy8CdnDYTd5mYe0R5z9cYRcezui-ViVSnvxO4xQLEWi_T5g@mail.gmail.com>
Subject: Re: [PATCH] pager: set COLUMNS to term_columns()
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 11:25 AM, Jeff King <peff@peff.net> wrote:
> --- a/pager.c
> +++ b/pager.c
> @@ -109,10 +109,15 @@ void setup_pager(void)
>                 return;
>
>         /*
> -        * force computing the width of the terminal before we redirect
> -        * the standard output to the pager.
> +        * After we redirect standard output, we won't be able to use an ioctl
> +        * to get the terminal size. Let's grab it now, and then set $COLUMNS
> +        * to communicate it to any sub-processes.
>          */
> -       (void) term_columns();
> +       {
> +               char buf[64];
> +               xsnprintf(buf, sizeof(buf), "%d", term_columns());
> +               setenv("COLUMNS", buf, 0);

I wonder if this affects bash being a subprocess. E.g. if COLUMNS is
exported will it still dynamically adjust COLUMNS? A quick test shows
that it adjusts $COLUMNS anyway, so even if we need to launch a shell
we should be good.

> +       }
>
>         setenv("GIT_PAGER_IN_USE", "true", 1);
>
> --
> 2.17.0.984.g9b00a423a4
>
-- 
Duy
