Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E141F803
	for <e@80x24.org>; Mon,  7 Jan 2019 12:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfAGMxk (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 07:53:40 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46986 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfAGMxj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 07:53:39 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so157021ios.13
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 04:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7iKhcnq4cTP1aEJ6NPTlvEAXOyKM2badWoiMKY6rXA=;
        b=EdfOXEhxs/YEzIUYYExpC0Wm4t0RtSCTtKepVCSF/bY4eOPa9SlyLsnoHqGUZt8PEU
         X//bDFmKD+3jkVRiEUG9kF3Ww6k19QovLUV3NM1IMYcHCrSa6F/TCjFlVPxcgq7GSPzO
         2w6SLiNPAPAwlfJyigxBqhbyDUJxM4BiF8TL4hzXWO5V5Hdc7ZItQx8Zze41YghmWyQ2
         Y9h3BKQ/DaGcrI+AflTDSCmaX0lTz0CjoDusrgGtxOOrm/a9o392r/ZHA07ppAjaKrNe
         zd4LHqFrft2rk/EEUO7jlH5lh3brKNogBmqLQLCb4iWeXU+baBcTpnWGSPvkq3WNSIhf
         fp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7iKhcnq4cTP1aEJ6NPTlvEAXOyKM2badWoiMKY6rXA=;
        b=T4SOpWJLOlEbO+cv+hvNqW3taS1JDKFAoQKSOh8aYgTZxtvdz8FjJB8F9rpjMgLtrO
         b6g+gRM/S6hd6gASo3OsRIyMR7kUlfW0G3q9fq67yafYjXb7aNBesMrYmpmFjUyoHFxU
         0Uj32SRQD2rHqcpFzz1Gg6WcLLO0zDfaAYsi2lg3qsib0mL/8hw3Q64Up5b3X5ZG6URb
         sAW8H+6LiR3KxCo0uTkMRrbUjN1LGt0XAdVc1//nfh+2zOSHeWZaUQRzY3GJgZoRge00
         taGw+IVCV9zPrHyizJGIMYi7fC5TaG1jPkU2myJNxGh9rXP53oKa06z1DloryWcaMgGx
         oktw==
X-Gm-Message-State: AJcUukcLc3kTybCZz7Epuvtcf+bbaOr31OuWF0/tIrIUha7Xyt9NkTG2
        syFOhYIDb3TxL9g4FiuDwhIGmV2CU7AVhvZbTk0=
X-Google-Smtp-Source: ALg8bN5DPcXwsACXNo0KMLBaFMMbLHRImAljK1pXsNu5qdD3w0/j3GZDqGKAm3vrxXRxbbQJy8B7Sf+ggjOsPXn9eFY=
X-Received: by 2002:a6b:c544:: with SMTP id v65mr43161489iof.118.1546865617810;
 Mon, 07 Jan 2019 04:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20190106154637.10815-1-chriscool@tuxfamily.org>
In-Reply-To: <20190106154637.10815-1-chriscool@tuxfamily.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 7 Jan 2019 19:53:11 +0700
Message-ID: <CACsJy8B7ogYEzwDAT7v1z4T-YsTa-e3VPbCfNBmc4v5R=06meA@mail.gmail.com>
Subject: Re: [PATCH] helper/test-ref-store: fix "new-sha1" vs "old-sha1" typo
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 6, 2019 at 10:46 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> It looks like it is a copy-paste error  made in 80f2a6097c
> (t/helper: add test-ref-store to test ref-store functions,
> 2017-03-26) to pass "old-sha1" instead of "new-sha1" to
> notnull() when we get the new sha1 argument from
> const char **argv.

Ack. Definitely copy-paste error.

>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/helper/test-ref-store.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index e9e0541276..799fc00aa1 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -233,7 +233,7 @@ static int cmd_update_ref(struct ref_store *refs, const char **argv)
>  {
>         const char *msg = notnull(*argv++, "msg");
>         const char *refname = notnull(*argv++, "refname");
> -       const char *new_sha1_buf = notnull(*argv++, "old-sha1");
> +       const char *new_sha1_buf = notnull(*argv++, "new-sha1");
>         const char *old_sha1_buf = notnull(*argv++, "old-sha1");
>         unsigned int flags = arg_flags(*argv++, "flags");
>         struct object_id old_oid;
> --
> 2.20.1.26.gc246996f60
>


-- 
Duy
