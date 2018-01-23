Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DCA21F404
	for <e@80x24.org>; Tue, 23 Jan 2018 00:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeAWAIe (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 19:08:34 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:41036 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbeAWAId (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 19:08:33 -0500
Received: by mail-wm0-f66.google.com with SMTP id f71so19509545wmf.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 16:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=p2G2D7boeX5+QIucognQsDoK1VB7CaFZSR0tQJJh+lk=;
        b=MxjhcGbNQ6zCqHbAV4ZjdO4t63OASkVAyOFBjEGVxhXTHoIiNhDIfVyHlkM2sEvm1A
         cCeHrMOZ0MIuhmqaKDr3dlWiro8xsm6vSak7QTX5Y2MGWzBYT1ExOpqHQm5aQqQznJQr
         Eto/pf/JJWyNo1EfWGUUbhJlCtATmBx8eKJvfzvruNwwzl7MRwrsJYVsAjqTk3K6YTF+
         MqlVNmygDEhPKGo/2xSiv7zAm1Df6A+LQpTlEH7fRXp7jxkH4xkKxlEe0X4qNkghRpk7
         n+EjEhpNSMfkGknvu27wnxCwiNHEIK/x7eDgzJxCOcK4Jt+mXf1CbmVjooiEulZOasSI
         2ARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=p2G2D7boeX5+QIucognQsDoK1VB7CaFZSR0tQJJh+lk=;
        b=Z20WalJnchhKbRfbx+WMi1cPXnOhcC1sK3J1D93yZGv3Cm32T2OFE9EUTA9+JP7qfn
         5k4AwTdqBycYDUqql8PBVHlcQuWF+UGbz2Ig9FzuA+p003ctSYjoQ9Yc6Ao5lKko+70e
         dA4MBOl2oUs6pFNwa9G1j5g1XMU+ChxDTQoZdzMwaDyMModIwN7++qkCuk4JrzM5OXxz
         4pQ8z6alfJg1Z8HdJOZ6Y6fe7QLN4nFB0lLnQ4aQQ4sq9lUgYHjK8tBfcqCfVrIvsLnF
         jK+tJSiB6kCRpCLWjwTj5z3dlMwoqw+cxuQufELxRHBQxqvflAq/4CrBTOrP6LEl9v8n
         hgDw==
X-Gm-Message-State: AKwxyteecL6+NHPweBOc01Ag99YreM7IeI2UjjzTL1ixh71aERXpo4Rg
        Bui/9HcSX0HcVpTXXD4W5MDU2j0Z
X-Google-Smtp-Source: AH8x2246Jne9ZpI6JYfZQGA4BF4tOTq92KzoT3O1gHGgZtyYBEgLESauvbk5gvilaEOyf9trIkho7A==
X-Received: by 10.80.246.133 with SMTP id d5mr15608508edn.93.1516666112396;
        Mon, 22 Jan 2018 16:08:32 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id d92sm10975262edd.21.2018.01.22.16.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 16:08:31 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: set diffstat width to 70 instead of default 80
References: <20180122123154.8301-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180122123154.8301-1-pclouds@gmail.com>
Date:   Tue, 23 Jan 2018 01:08:30 +0100
Message-ID: <87r2qhh1xd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 22 2018, Nguyễn Thái Ngọc Duy jotted:

> diff --git a/builtin/log.c b/builtin/log.c
> index 14fdf39165..6be79656c5 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1061,6 +1061,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  
>  	memcpy(&opts, &rev->diffopt, sizeof(opts));
>  	opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
> +	opts.diffopt.stat_width = 70;
>  
>  	diff_setup_done(&opts);

There's no opts.diffopt. Presumably this should be squashed on top:

    -       opts.diffopt.stat_width = 70;
    +       rev->diffopt.stat_width = 70;
