Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F31D20966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754023AbdDENqZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:46:25 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:36374 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbdDENqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 09:46:16 -0400
Received: by mail-io0-f175.google.com with SMTP id l7so9698629ioe.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7WUS2ZY6zW6rjtwqka6bseKCk4t4GBrcjJNORTydOqU=;
        b=eFU+sREeq275vfSbVTc/I5fXmeXmq3H4wEGXKI3XyY2SLkY7uREPmtLzoEz5tNmZqq
         IltCaa4txr2/rKEInck1EGla7I5EpJsnLcsk09LNZcNdhr/nkc7fGCfa21gxER3R4lKH
         SC2jqjRtvUVyxhdqWjEHpdXMdO7UXi88fIfDmHF7e0t/5OTqvh39TOQ+p+IrW6h2QS1Z
         sJHT045gy+vMFtIR/mnyd/SKiAcZ6YMLQirZ4h8TAZ2b0UFVGiOUFnl/ZeV9488LkUos
         fKmIjADCkaKKGJdE7/9SZ2yLgRSXoKO9sMYQFSpjSwYGsA50tSBXD8+UYULg/m4X+UBG
         BShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7WUS2ZY6zW6rjtwqka6bseKCk4t4GBrcjJNORTydOqU=;
        b=eNv4dNtAt6TKJoFnHf1UiD7a1majq1yKBZeDmePOH0+rnNkE3Iw2zzPRZ8YAiQ78Jo
         302/MtMEXCv+mwkNKxR5zD41oaDyxWy0DsgXjDDq5Gg2s5Zg9jFbmgh4G2FVz1N7th3o
         fjNua048mFsFH10fNi/N+wTDTqe5KUBpVdMtNGnr7j9GdBsW8qIyo6stPiAnArLO8FGh
         0oe8GPkHVMtveH1LVtgJPPJzDBNQIY8RejBXEYbwQupiHHh+tK0dLn8GxMra0GW9LfyB
         +F8ZVQwdVQ8JfmctjQQfOvHjDcX7dUIKmh92yvJoR3ADcP/wR6a8+V+pE8q/g/2JRk3g
         IIbg==
X-Gm-Message-State: AFeK/H28BO3/qIgLxJK16BDtYqQ8CvV5C3zxngbjGHwRX/BkZsT7kY3enNC1e9tyt/fpqQfcIiRTuAUbfwawpA==
X-Received: by 10.107.150.201 with SMTP id y192mr30930082iod.33.1491399975545;
 Wed, 05 Apr 2017 06:46:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Wed, 5 Apr 2017 06:45:54 -0700 (PDT)
In-Reply-To: <20170405130424.13803-6-tgc@jupiterrise.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com> <20170405130424.13803-6-tgc@jupiterrise.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 5 Apr 2017 15:45:54 +0200
Message-ID: <CACBZZX6bYLRSUAy2GUYhBVet3tjzrBQ40L49KxetAvBdgx_x+w@mail.gmail.com>
Subject: Re: [PATCH 5/7] Add support for gnupg < 1.4
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2017 at 3:04 PM, Tom G. Christensen <tgc@jupiterrise.com> wrote:
> This adds an OLD_GNUPG define to the Makefile which when activated will
> ensure git does not use the --keyid-format argument when calling the
> 'gpg' program.
> This is consistent with how 'gpg' was used in git < 2.10.0 and slightly
> decreases security.

This changes the code Linus Torvalds added in b624a3e67f to mitigate
the evil32 project generating keys which looked the same for 32 bit
signatures.

I think this change makes sense, but the Makefile should have a
slightly scarier warning, something like:

"Define OLD_GNUPG if you need support for gnupg <1.4. Note that this
will cause git to only show the first 32 bits of PGP keys instead of
64, and there's a wide variety of brute-forced 32 bit keys in the wild
thanks to the evil32 project (https://evil32.com). Enabling this will
make GPG work old versions, but you might be fooled into accepting
malicious keys as a result".

> Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
> ---
>  Makefile        | 6 ++++++
>  gpg-interface.c | 2 ++
>  2 files changed, 8 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index ca9f16d19..f8f585d21 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -386,6 +386,8 @@ all::
>  #
>  # to say "export LESS=FRX (and LV=-c) if the environment variable
>  # LESS (and LV) is not set, respectively".
> +#
> +# Define OLD_GNUPG if you need support for gnupg < 1.4.
>
>  GIT-VERSION-FILE: FORCE
>         @$(SHELL_PATH) ./GIT-VERSION-GEN
> @@ -1529,6 +1531,10 @@ ifndef PAGER_ENV
>  PAGER_ENV = LESS=FRX LV=-c
>  endif
>
> +ifdef OLD_GNUPG
> +       BASIC_CFLAGS += -DOLD_GNUPG
> +endif
> +
>  QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
>  QUIET_SUBDIR1  =
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index e44cc27da..57f1ea792 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -224,7 +224,9 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>         argv_array_pushl(&gpg.args,
>                          gpg_program,
>                          "--status-fd=1",
> +#ifndef OLD_GNUPG
>                          "--keyid-format=long",
> +#endif
>                          "--verify", temp.filename.buf, "-",
>                          NULL);
>
> --
> 2.12.2
>
