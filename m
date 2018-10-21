Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A19671F453
	for <e@80x24.org>; Sun, 21 Oct 2018 10:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeJUSOp (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 14:14:45 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55527 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeJUSOo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 14:14:44 -0400
Received: by mail-it1-f195.google.com with SMTP id c23-v6so8812491itd.5
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 03:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uEco2cTfiunoWsABbdgb0sOD/QDTpPW1D+42GSDU+7U=;
        b=seUbj6SzU/XIrcLZKFKkqMvGCAaxyqGmUYAKlGcZ0quil3j1Tzu7FFzLRPOVbFMSan
         xPGC2Hnnq6muQFTmhAkWuzV3s9mh/Z74Nl9nWuwXcIZHK2nBbHXW6sxnJI29w7f8+su2
         zxvEjLt++ttargOsrQbbtuEiUHhHHCCUdGtvkmQTaIR5vAXOMfUPPmHIWiiTXEDEIGWC
         jGsAejVUXTwsOeIobdaQXMwP3QYKCpxNaK0fIEB9aeVcaWyMyLesmxylyEDCcnXFAUCI
         n62yH5kqLd1yKaZ5yHGK4RpM/XwwSac6kAnKatUQuvnHnkWs0HokXM2W3XTBC6B/tYY4
         12HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uEco2cTfiunoWsABbdgb0sOD/QDTpPW1D+42GSDU+7U=;
        b=R2hQU1Ov8Dn+ljG2waAduB7GnHVgjj0cNRuxLD7+0oeaTGlp6pdnAX0/Myx0ZK7WJd
         w4pYf9c/fjB1xANq1aKjPJQiKPp+9Q56YrslCDfhYrz4Gw/bQ5tOAKRBdSO7uEPpA/J4
         KddH+KUzkXYUdcqslmaS1Xi5/6wBFraUDldrzN4c8k33jQ15i+7H4mDH/PzhHOCAevce
         VhOWPhINovutCOI9lhG5H7nHxPsMPNJCLK4hGoG8ZsW8X6EOMAnZHkYZfg6nqXLRGVAf
         2IZUAkoNdJcwctbA/OUapJpMvQ7w45AQsPAUAxMptwrKkpPfRxzYkAW7Um48VxWSCM7w
         fnIA==
X-Gm-Message-State: ABuFfoj+jeKkc6a3ndZY9/jYllUPaOR30hzQxN9SIEpJHE++/WHRQ4ck
        KpVvI+M3soHMn6rRphBI/crzpeaxh/iyEA6WDFM=
X-Google-Smtp-Source: ACcGV61E8a81ubw/SnCsFtSbnZZSbU5TJv48vsOusb4ZBn2D9mnoMxA3o4iQT913jukmUZzItZcg6OzJii678svIMV8=
X-Received: by 2002:a02:4009:: with SMTP id n9-v6mr33098833jaa.52.1540116058206;
 Sun, 21 Oct 2018 03:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181020070859.48172-1-carenas@gmail.com> <20181020164526.GA1077@tor.lan>
In-Reply-To: <20181020164526.GA1077@tor.lan>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 21 Oct 2018 03:00:43 -0700
Message-ID: <CAPUEspjprhMSCz+tJEUhV8PbmGSuBEi71OCeq8aF=dh23_Zs-g@mail.gmail.com>
Subject: Re: [PATCH] builtin/receive-pack: dead initializer for retval in check_nonce
To:     tboegi@web.de
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 20, 2018 at 9:45 AM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> The motivation feels a little bit weak, at least to me.

I have to admit, I was sitting on this patch for a while for the same reaso=
n
but I should had made a more compelling commit message either way and
will definitely fix that with v2.

the point was that setting the variable to BAD originally seemed to be lega=
cy
from the original version of the code, specially considering that the newer
version was setting it to SLOB at the last "else".

the code was written in a way that would make all those assignments to BAD
explicit (even if it wasn't needed, since it was initialized to that
value) and so
it would seem better IMHO to use the compiler to remind us that this variab=
le
MUST be set to the right value than setting the most likely value by defaul=
t.

> Initializing a variable to "BAD" in the beginning can be a good thing
> for two reasons:
> - There is a complex if-elseif chain, which should set retval
>   in any case, this is at least what I expect taking a very quick look at=
 the
>   code:
>         const char *retval =3D NONCE_BAD;
>
>         if (!nonce) {
>                 retval =3D NONCE_MISSING;
>                 goto leave;
>         } else if (!push_cert_nonce) {
>                 retval =3D NONCE_UNSOLICITED;
>                 goto leave;
>         } else if (!strcmp(push_cert_nonce, nonce)) {
>                 retval =3D NONCE_OK;
>                 goto leave;
>         }
>         # And here I started to wonder if we should have an else or not.
>         # Having retval NONCE_BAD set to NONCE:BAD in the beginning makes
>         # it clear, that we are save without the else.
>         # As an alternative, we could have coded like this:
>
>         const char *retval;
>
>         if (!nonce) {
>                 retval =3D NONCE_MISSING;
>                 goto leave;
>         } else if (!push_cert_nonce) {
>                 retval =3D NONCE_UNSOLICITED;
>                 goto leave;
>         } else if (!strcmp(push_cert_nonce, nonce)) {
>                 retval =3D NONCE_OK;
>                 goto leave;
>         } else {
>                 /* Set to BAD, until we know better further down */
>                 retval =3D NONCE_BAD;
>         }
>
> # The second reason is that some compilers don't understand this complex
> # stuff either, and through out a warning, like
> # "retval may be uninitialized" or something in that style.
> # This is very compiler dependent.

FWIW I did test with gcc (from 4.9 to 8) and clang 7 (linux) and 10
(macos) and didn't
trigger any warning.

> So yes, the current code may seem to be over-eager and ask for optimizati=
on,
> but we don't gain more that a couple of nano-seconds or so.
> The good thing is that  we have the code a little bit more robust, when c=
hanges are done
> in the future.

on the other hand was able to trigger a warning if the code was changed so =
some
path will leave retval uninitialized (after adding
-Wmaybe-uninitialized to gcc and -Wsometimes-uninitialized to clang)
since there was no longer a default of BAD (probably incorrectly) that
would be returned in case setting retval to the
right value was forgotten.

Carlo
