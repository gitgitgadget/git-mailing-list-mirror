Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF8041F45F
	for <e@80x24.org>; Tue,  7 May 2019 03:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfEGDET (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 23:04:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46816 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfEGDET (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 23:04:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id f37so17223851edb.13
        for <git@vger.kernel.org>; Mon, 06 May 2019 20:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hw6dmg3vska6kFrtuKqb/JP5IHZ8dKR80kFvSEB/z80=;
        b=RTB71Ao15kzRScThZOtDp+io7SulMueav1Wikjfk9MmnavG2XRO40/z2i4c3K4YdDn
         yINt+qhHowXHMXBG7VdYlQDYHvKuQFRcvfmyAUtfhU6QifXJWaitXsAspLzTO782ASJQ
         +mtcl2n+IUZDbmsyovf2z5boB/6lH04edzkqQuGXRolWKHmqh5f3sf7WVSNuJIPDp1ZG
         n70RIfdCewL4Qd1wvQqK8ZHZ+dhs1Om00mz7hyufb+9ffvnR+vzqfX7/GfPOEsN1SnOv
         RJGYfSkW1Z5npE+y2/rp/Ki+x7ngBlVHCHkVaTOcC+DNI4f+DHFN6+oByYmhI8W7tEPY
         D72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hw6dmg3vska6kFrtuKqb/JP5IHZ8dKR80kFvSEB/z80=;
        b=AAMYGKQbLMQR1T4F1UTY6rhNbpEbYjiH5Agf3McNuNkQ3TOywjaay1pWodM7S3Kc5J
         wJstJn+9+il201ODxGNXv+K7nZZNkRm4My8bBU33bYT2j6WqKUwd2IKiXNsf4kakJZeD
         0MnEqe/7rRRA0P2JTBl9fxt5LpyPOoBHC+o3PR0Dr1AVl47ZTGfcBYRGFyVsCniThXFN
         p3Vvv+vvn57+7IB+TcSTbCd0Na6nAXn9gEVT6ILil32WoAmLFTjQRa7wV2ur5HBzM3zh
         4zUwKQ8igQim4vADRypuinwSbKLHkERBnGDeCKlLR5D/rtel6drbNxp5ajnjOV+Jof3+
         dbNg==
X-Gm-Message-State: APjAAAUARAgNdXni/QkK/ntdlrHGD6/UOnaFn5gYdD04OlxZ6rtue5qk
        0WvYf6loN80tvlukN1uXbRO0JUAFthoxEC0w9XQ=
X-Google-Smtp-Source: APXvYqx7OScSDsbXow024T8YU4lnlh/ufWk7qAHru24HivnYR7b3nzrOI+tKvRDcwh/TaolK9WAp/k4mRpWZvJ6jMs0=
X-Received: by 2002:a17:906:899:: with SMTP id n25mr22383265eje.131.1557198257618;
 Mon, 06 May 2019 20:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190501100108.GA8954@archbookpro.localdomain>
 <20190502000422.GF14763@szeder.dev> <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
 <20190503144211.GH14763@szeder.dev> <20190503174503.GA8242@sigill.intra.peff.net>
 <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
 <20190506051148.GB30003@sigill.intra.peff.net> <CACsJy8CLjUdHCro8QJfTozMB0xVWppHuFRSLCvFSaeKO_PxAog@mail.gmail.com>
 <20190506234334.GA13296@sigill.intra.peff.net> <xmqq7eb3nfxn.fsf@gitster-ct.c.googlers.com>
 <20190507025501.GA3417@sigill.intra.peff.net>
In-Reply-To: <20190507025501.GA3417@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 6 May 2019 20:04:09 -0700
Message-ID: <CA+P7+xoX78tp4fiT5aJf6i6HxWj5SCNFK5ODEMJ8JHCdTZwWXA@mail.gmail.com>
Subject: Re: [PATCH] coccicheck: optionally batch spatch invocations
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 6, 2019 at 7:55 PM Jeff King <peff@peff.net> wrote:
> Here's what a patch might look like to implement "0". By still using
> xargs in the unlimited code path, it's not too bad. I dunno.
>
> ---
> diff --git a/Makefile b/Makefile
> index daba958b8f..0765a59b7a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2792,7 +2792,12 @@ endif
>
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>         @echo '    ' SPATCH $<; \
> -       if ! echo $(COCCI_SOURCES) | xargs -n $(SPATCH_BATCH_SIZE) \
> +       if test $(SPATCH_BATCH_SIZE) = 0; then \
> +               limit=; \
> +       else \
> +               limit='-n $(SPATCH_BATCH_SIZE)'; \
> +       fi; \
> +       if ! echo $(COCCI_SOURCES) | xargs $$limit \
>                 $(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
>                 >$@+ 2>$@.log; \
>         then \
>
> -Peff

This doesn't seem too complicated to me..
