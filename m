Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C091F45F
	for <e@80x24.org>; Tue,  7 May 2019 01:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfEGBlO (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 21:41:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34623 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGBlN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 21:41:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id p27so2222682eda.1
        for <git@vger.kernel.org>; Mon, 06 May 2019 18:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSLEQz9hIM9pP0SkPEYmgyvtgViTubGOZ36+9sLm+gs=;
        b=tG4rM8sg9J1dyf3HKNkMuYephla1Cv5W4cIePYilz7YlGnSV/UFbIDi4FrMxI+I6RE
         toF+hfgYvm1CvLkbyQF8BiaOvPI5EPE0DM0iZZzJ5eKdwTcCtCbJCfAPLVdLv147VUHe
         lll3ZF2XEvGb3T1THB1ny9GoLx24JfFd5kUlUPvkpBhoJ20biMaoKPUHpLjOPcc0EZo2
         PKfP/Mhy12IgTOsaOqXEU6dl6ewTIgPTyFDdqQBfUjLT8Hr383lLlmR+Jm10nkYl11pg
         PrUJcbmqi8a/i9OBBisWgXPX6tIyXTuwfSqAWdiGmO1CoZeAp/N63LAb2kPONtU8jwfA
         ZMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSLEQz9hIM9pP0SkPEYmgyvtgViTubGOZ36+9sLm+gs=;
        b=K1t/9KVAYPmEwE7C/fxSnh+GcGQfWBxVFA6BYOAKNkrw5fNFGRFEYyRYzx0GtqtBi9
         qG0ZTxBVxC04gz9x33F+ynM3OnO6SgohsKK0c/f6urKfOPkajOeTIjK0BMGoMYscX6zY
         o9V7+uXXTZTQd4lPbFQHkkFon58XT7nWVlz+/Dmqz9SwUfRxaSm0pPH3HhPTx7/v+Fmd
         +ozcoio3whRN+A33wnhU/QZf3eSyY76b36k2D+1eTbjpFG5I2ixkeoq+45X+3SxeKe21
         dpVZ32cLy5e92mvNmv9ZVnbLfrA+5xKQ7K8uPU5vAgRDTWTeOqswqmUqn0cvcYP8rPac
         WpWA==
X-Gm-Message-State: APjAAAWhI+Or+o0h/14/+P1b8xv/mAZ/K+A2nd2Mdq/3vTQNFiFf2ljM
        owiSK8liLtyQksJQ5/ihHG/SA+YD+kllh0yOLu0=
X-Google-Smtp-Source: APXvYqyV8sWMDokNoZ8jJiQJ70b4mMY9wRxTp9PjBjfErHcwFU0YIVe8/t8LcHKin5Fxuth+eCUZ9ptZ9xDlYEAKlWk=
X-Received: by 2002:a50:c31a:: with SMTP id a26mr30211323edb.289.1557193271483;
 Mon, 06 May 2019 18:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190425120758.GD8695@szeder.dev> <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
 <20190501100108.GA8954@archbookpro.localdomain> <20190502000422.GF14763@szeder.dev>
 <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet> <20190503144211.GH14763@szeder.dev>
 <20190503174503.GA8242@sigill.intra.peff.net> <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
 <20190506051148.GB30003@sigill.intra.peff.net> <CACsJy8CLjUdHCro8QJfTozMB0xVWppHuFRSLCvFSaeKO_PxAog@mail.gmail.com>
 <20190506234334.GA13296@sigill.intra.peff.net>
In-Reply-To: <20190506234334.GA13296@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 6 May 2019 18:41:03 -0700
Message-ID: <CA+P7+xofcS_dLFOSHmYiWwb55p2e+PtS+i_eURnU7KnnGYotcA@mail.gmail.com>
Subject: Re: [PATCH] coccicheck: optionally batch spatch invocations
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 6, 2019 at 4:43 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, May 06, 2019 at 04:34:09PM +0700, Duy Nguyen wrote:
>
> > > However, it comes at a cost. The RSS of each spatch process goes from
> > > ~50MB to ~1500MB (and peak memory usage may be even higher if make runs
> >
> > 1.5G should be fine. Trying...
> >
> > Even with no -j, my htop's RES column goes up 6GB and put my laptop in
> > "swap every bit of memory out, including the bits handling the screen"
> > mode :( I don't think it was even the peak.
>
> Interesting if you have a different version of spatch. I'm using 1.0.4
> from Debian unstable.
>
> I had just been eyeballing the values in "top" before, but I actually
> measured more carefully. My peak was actually ~1900MB.
>
> > It's probably a bit too much to ask, but is it possible to handle N
> > files at a time (instead of all files), which consumes less memory and
> > runs a bit slower, but still better than the default mode? I can see
> > it already gets tricky doing complicated stuff in Makefile so "no" is
> > perfectly ok.
>
> I almost did this initially but I feared that nobody would actually use
> it. :) So given at least one person who wants it, I took a look. If we
> rely on xargs, then it is really not too bad (and is in fact shorter
> than the current code). I also wrote up a pure-shell version, but it's
> rather verbose even after taking some shortcuts with whitespace
> splitting.
>
> So here's what I think we should apply:
>
> -- >8 --
> Subject: [PATCH] coccicheck: optionally batch spatch invocations
>
> In our "make coccicheck" rule, we currently feed each source file to its
> own individual invocation of spatch. This has a few downsides:
>
>   - it repeats any overhead spatch has for starting up and reading the
>     patch file
>
>   - any included header files may get processed from multiple
>     invocations. This is slow (we see the same header files multiple
>     times) and may produce a resulting patch with repeated hunks (which
>     cannot be applied without further cleanup)
>
> Ideally we'd just invoke a single instance of spatch per rule-file and
> feed it all source files. But spatch can be rather memory hungry when
> run in this way. I measured the peak RSS going from ~90MB for a single
> file to ~1900MB for all files. Multiplied by multiple rule files being
> processed at the same time (for "make -j"), this can make things slower
> or even cause them to fail (e.g., this is reported to happen on our
> Travis builds).
>
> Instead, let's provide a tunable knob. We'll leave the default at "1",
> but it can be cranked up to "999" for maximum CPU/memory tradeoff, or
> people can find points in between that serve their particular machines.
>
> Here are a few numbers running a single rule via:
>
>   SIZES='1 4 16 999'
>   RULE=contrib/coccinelle/object_id.cocci
>   for i in $SIZES; do
>     make clean
>     /usr/bin/time -o $i.out --format='%e | %U | %S | %M' \
>       make $RULE.patch SPATCH_BATCH_SIZE=$i
>   done
>   for i in $SIZES; do
>     printf '%4d | %s\n' $i "$(cat $i.out)"
>   done
>
> which yields:
>
>      1 | 97.73 | 93.38 | 4.33 | 100128
>      4 | 52.80 | 51.14 | 1.69 | 135204
>     16 | 35.82 | 35.09 | 0.76 | 284124
>    999 | 23.30 | 23.13 | 0.20 | 1903852
>
> The implementation is done with xargs, which should be widely available;
> it's in POSIX, we rely on it already in the test suite. And "coccicheck"
> is really a developer-only tool anyway, so it's not a big deal if
> obscure systems can't run it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I left the default at 1 for safety. Probably 4 or 16 would be an OK
> default, but I don't have any interest in figuring out exactly what
> Travis or some hypothetical average machine can handle. I'll be setting
> mine to 999. ;)
>
> Making "0" work as "unlimited" might be nice, but xargs doesn't support
> that and I didn't want to make the recipe any more unreadable than it
> already is.
>
>  Makefile | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9f1b6e8926..daba958b8f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1174,8 +1174,10 @@ PTHREAD_CFLAGS =
>  SPARSE_FLAGS ?=
>  SP_EXTRA_FLAGS =
>
> -# For the 'coccicheck' target
> +# For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
> +# usually result in less CPU usage at the cost of higher peak memory.
>  SPATCH_FLAGS = --all-includes --patch .
> +SPATCH_BATCH_SIZE = 1
>
>  include config.mak.uname
>  -include config.mak.autogen
> @@ -2790,12 +2792,9 @@ endif
>
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>         @echo '    ' SPATCH $<; \
> -       ret=0; \
> -       for f in $(COCCI_SOURCES); do \
> -               $(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
> -                       { ret=$$?; break; }; \
> -       done >$@+ 2>$@.log; \
> -       if test $$ret != 0; \
> +       if ! echo $(COCCI_SOURCES) | xargs -n $(SPATCH_BATCH_SIZE) \
> +               $(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
> +               >$@+ 2>$@.log; \
>         then \
>                 cat $@.log; \
>                 exit 1; \
> --
> 2.21.0.1314.g224b191707
>

This looks reasonable to me :)

Thanks,
Jake
