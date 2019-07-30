Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3851F462
	for <e@80x24.org>; Tue, 30 Jul 2019 00:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbfG3Atr (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 20:49:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41289 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfG3Atr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 20:49:47 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so120125653ioj.8
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 17:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mde7Pbf/dkwin9kMMxSxo8fm63SBHmNtG6QfGXkZLFw=;
        b=XC3vQgEyrQ7Yx2f17T1rLhbfjpWD2UkekIPiWsmIKpy7qHKznGwub3PJIprZlJ0kTh
         oPnF/Uxuc4+up1HJVJ4oIV1D1FualzpWciWdXuiDU7pNM0cHy/rJ25jzrL3lHF9C3HGT
         u1hFQstwAsgTc/WfZ8rGDJwqkT6FHXzjvDsVpICz1ParQkfzFZLUL2/OS37gJlqGarb+
         fOWEl8l5Ym+Do8iG6hVlSCK3mkTH3X2+cNZtmX7hoTHOBtwvbLPks2se1lUL0rp1S8b8
         D4vW+KDWRg18B7OYpBn9uFf/py6F0A1z+fBoLeWrz5nbiX5OQxplslEnT7KdcSHOmagK
         FOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mde7Pbf/dkwin9kMMxSxo8fm63SBHmNtG6QfGXkZLFw=;
        b=iA/cKvwIN8gqxpD8zdNIMPxj/B4OazRy28PMZmgKXaKqqBMRZYsmoJJbpAlPwf2MqC
         aFPqM75udaJtzqt88+98UAxuGdSTq4cGP2bVuRb1qKd+Lc20EuJBt86BZOX04euVi3K4
         m5ThpU3XDUF/im0PGoWqBIvGG1TvIrc1eLlyKyK+BhuP46ZeldZZigff4qtzZPmcc5MK
         GRU7J9DwlKbeiTPCJY+hu1Jyc4ZIUnqrzRf/dq2yflHyQKMZexeD/VD8Qr+LU0d2L2yg
         pNtXLFim8gUQlNSYLiv0NHlIQQfqBL+KDEBO+5Re6q2Zrr1Ge3HMs3WcH16KVUlxDnre
         sFNw==
X-Gm-Message-State: APjAAAUYZH/l806VTCMX0zJdWhbXIsBMe6xx+kODJjg+F4oIanoij7Y/
        MwksvxlvyHm8ZRGC4rr7Hgpxza9wvOdwaQHt+Jw=
X-Google-Smtp-Source: APXvYqzmo2WLkaaajbKqlPmTSwJVoHJKZsz6qVBhovWtmoD1HWfqRJN0Vu2FuKeKwovnwpsaniOx7sOc39rUWs7U9SE=
X-Received: by 2002:a6b:ef06:: with SMTP id k6mr32545264ioh.70.1564447786652;
 Mon, 29 Jul 2019 17:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190728235427.41425-1-carenas@gmail.com> <20190729105955.44390-1-carenas@gmail.com>
 <2f9cc063-96fc-dc99-0e29-230f1e12c1d3@web.de> <xmqqh874vikk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh874vikk.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 29 Jul 2019 17:49:35 -0700
Message-ID: <CAPUEspjo3Uo8KtSYQ=uh+_gPEjb+dBdSPgsEVE1j1bOMPF=0DA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] grep: allow for run time disabling of JIT in PCRE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org,
        avarab@gmail.com, sandals@crustytoothpaste.net, dev+git@drbeat.li,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 29, 2019 at 10:47 AM Junio C Hamano <gitster@pobox.com> wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
> >> +pcre.jit::
> >> +    If set to false, disable JIT when using PCRE.  Defaults to
> >> +    true.
> >> +    if set to -1 will try first to use JIT and fallback to the
> >> +    interpreter instead of returning an error.
> >
> > Why not implement only -1, without adding this config setting?
>
> ... nor command line option.  If we have an auto-fallback, I would
> think that makes the most sense.  IIRC the first iteration with only
> the configuration was really about working around the (non-working)
> pcre-jit---if we can self-detect and skip a non-working case, that
> would allow us to drop end-user facing knobs, which is ideal.

because that was proposed earlier[1] and wasn't accepted ;)

the main pushback though I got was that doing the fallback would degrade
performance and so it was suggested[2] that keeping the error should be
possible somehow (with the implication it will add yet another macro)

since living without grep -P was a reasonable tradeoff at that time got
punted, but the need to find a solution for this become more urgent once
it was announced[3] PCRE2 would be used also used outside -P

> Thanks for a doze of sanity.

Obviously I am biased, but I kind of like the knob as it allows the user
more flexibility to tweak the internals of grep and because we had
made those internals already visible (ex: not handling any library
errors ourselves and just aborting with a pcre error), but without any
flexibility to fix those problems themselves (unless they open the code
and rebuild, in most cases)

the comment from the user that reported[4] a regression with GNU grep
because of JIT stack size and that I quote below is representative of how
that layering violation affect users, and while git users are more likely
than grep users to do the code tweaking needed, they could use some
help.

"As using the JIT can not be turned off at runtime, nor can the stacksize
be controlled without patching + recompiling, this breaks previously
working expressions for me, so I consider this a new regression,
introduced with b06f7a29a58bbdd5866afc1e92dba3fdc9e2ed59 .

I tested that increasing the stack-size to 1 M fixes the problem for me.
A better fix could maybe consist of a better error message, allowing
stack-size control at runtime and / or making JIT optional at runtime."

making JIT optional at runtime is therefore the title of this patch and as
I mentioned in some other thread it might be even useful to us for our
own tests.

Carlo

[1] https://public-inbox.org/git/20181209230024.43444-3-carenas@gmail.com/
[2] https://public-inbox.org/git/87zhtbn5xb.fsf@evledraar.gmail.com/
[3] https://public-inbox.org/git/CAPUEspjKxQFiRgmfb2SuR_xpVu4=3DMN66kGEeBK1=
pHdBgXQbv7Q@mail.gmail.com/
[4] https://www.mail-archive.com/bug-grep@gnu.org/msg05762.html
