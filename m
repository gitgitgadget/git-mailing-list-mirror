Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2446C433FE
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 11:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbiALLkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 06:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbiALLkB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 06:40:01 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40466C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 03:40:01 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id y4so4182501uad.1
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 03:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KSqWPBadiYwofZgHf47PsYzzDhBYuaV9LDe8geDRQOc=;
        b=aBUtE8B9RfMGfzxXjL5KmZDTAjn3GoGmvW1VNWB+/HJtnEeTyt+CZMLW1ALD9ncBmo
         EboKeCe6eXotknFIhBU1RvTF0UxayI3lGpwOOJqOzJZtZT7klS0AlAGvwvfwHbicC8dg
         vulqjbSlRZI5zHgars408p9sSKA1M0noRhJML+eUZ6itLI9trQrGoN8fDnexYrmxMSeX
         6ETqbwP72Fpu92ea5++T7CCGzHpuO+JsiG8i8wpHlPm0d0sh1Etd8t8L8JTaIXHz9vpn
         PetbIsWd0LH/s+v+yIEh1u3ZoU1jes8BYXED1dTEJWYMkddZBvm4J66BNlVeeCAdE98S
         tNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KSqWPBadiYwofZgHf47PsYzzDhBYuaV9LDe8geDRQOc=;
        b=xh1B4CIzs4N13U163GRdyoYA5Zp3MQngqZG+WY8Cw0LKJMPZZPxQOmpFLCg17FTJd2
         8KDR1fcCqUcn319LIOnfoQvRjuzD4w3q9zB9iKrS4t0Qrv9l/m/w70Omy73BwYZxc5bv
         PaM9mGZnM4riJO3dccXZlqHOpx7Y5W5DepTGla8xJkp9vwf2nzc3ntdEfq/HNgUQWW6o
         eLxBbGdBMYtDqn1zTx6QYJPzVibhzOAX0XaKPoJhza6LIFTU/iWpM22groSyc00jRWfm
         doysD9Qo+dykwpa3Y2MU9YcyaJfgg4GOoH80SO5ch7QTH24YS4gDvkZKfEmasJS0I+z8
         pfzw==
X-Gm-Message-State: AOAM532x4IVz3RDNZd6BBoPx2bMlbq+IUiY/I5sP0TqFSNXgNP9uyMw2
        4CSwqKXUMZ02R4whUHYE7HzfEoMzT5CJHLO3Uhi3MA==
X-Google-Smtp-Source: ABdhPJxNs+Jpn3PCadr/EW0zIwOml/yq1/MDrTo10gWiZA6lufIUqZM+uvTxFlduN/nllmYu7L2cnvz4BdV0irPKCwY=
X-Received: by 2002:a67:f497:: with SMTP id o23mr4582154vsn.70.1641987600338;
 Wed, 12 Jan 2022 03:40:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
 <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com> <e16bf0c5212ae85daa0d6aa2c78d551824b542bd.1640199396.git.gitgitgadget@gmail.com>
 <xmqq1r24gsph.fsf@gitster.g> <CAFQ2z_OXPw9-hLsaD+E1nGESS7eJH5o5sRrr_R_vW1Oa-vvZoA@mail.gmail.com>
 <xmqqy24a4oyq.fsf@gitster.g>
In-Reply-To: <xmqqy24a4oyq.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 12 Jan 2022 12:39:49 +0100
Message-ID: <CAFQ2z_PDfreeGttTbNTbnr7rRJQFHFfLVD_hJu21QQAR1njPpg@mail.gmail.com>
Subject: Re: [PATCH v5 16/16] reftable: be more paranoid about 0-length memcpy calls
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 24, 2021 at 5:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> But your safe_memcpy() should not be
>
>     safe_memcpy(dst, src, n)
>     {
>         if (n)
>                 memcpy(dst, src, n);
>         return dst;
>     }
>
> Using memcpy() with size=3D=3D0 is not a crime wrt the language.
> Passing an invalid pointer while doing so is.

It's not a crime, but what is the benefit of calling memcpy with n =3D=3D 0=
 ?

>     safe_memcpy(dst, src, n)
>     {
>         if (dst)
>                 memcpy(dst, src, n);
>         else if (n)
>                 BUG(...);

I think this is suboptimal. Sure, a segfault is uglier than "out of
memory" error, but both effectively crash the program, so the
difference isn't that big.

The nice way is if the reftable library grows an error-code
REFTABLE_OOM, which is propagated once a malloc or realloc returns
NULL.

We could test this exhaustively in the unittest by swapping in a
malloc that starts failing after N allocations, and then running a
transaction in a loop, increasing N.
I'll have to look more closely if this is possible throughout, so for
this series, I'll just take a closer look at the current call-sites to
see if NULL can really occur or not.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
