Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4C0C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF5861216
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbhJDQs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhJDQs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:48:59 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4B1C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 09:47:09 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id z22so18664529vsp.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/3aTRSS2e90XYXQXXi1NSgbtbxnDZQHRODDpFDGcp04=;
        b=lPZXz6pYGYr5d2Sfml95iGvwMOyZU7yOqKeWUifRj/IkQ+IDZ516IB4vv8/OtiNo/m
         fSZU+KIP23yAMvh+1xaAExQLn4OzVS6SzJPaod/bFiiSU28oZWt5SS07sjTArsOGSU+5
         k0g/2+3m3O0y80aDHbhvmv35yzSGcZ5sbp8HxUdVA30rWn/AHOdTnd3uHWj7qub/zBh9
         W1YxVYjhwEF5uCjOMPO4fPerxtL7WRHbO/URFFlsTMmH7jT4M4zupNm2pkT4G8DlhjmU
         JKXVkqbyJ9aUk2KZxJkY5gWUvj+f514eiPEU5j08ubx+UJJfjTaCa3JyBqPtLZmangyM
         GXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/3aTRSS2e90XYXQXXi1NSgbtbxnDZQHRODDpFDGcp04=;
        b=Ip36AxRwfjV5K+IY4zXgbpsgyz2e7t/Rbbin/pAwUpgVth7sCLD9Rew/pg77ZGbNbe
         iV208flO++yzE+S05Wy6R+AXF4alJKWxVmhbJzED5fuyYs3tPZiKFfvK5Guiwg0lmDQt
         EcQ/Ll4y3GijjQrquM8eQTShiLCZ3d56JjRXBwxi5IfYx6/Nkn7j5DdgE4J9+f0K1BWn
         U4hW6r2WrrHiwl74fS9u1yEwxJb5LkBJj+h1ZLyqeD5CfvQL4WLef/zrSt20ZEO0tvme
         /DP1Sda2gFrCeLoMeh8oWngya29zkJyvjISi4Jrddt5KV3DSpQMtZFCouFYZu71RhdM1
         1dlQ==
X-Gm-Message-State: AOAM531bS5Xi6Q7NhDymPDDGrU/HWHl0hDlrEDoZTecSnNubweU2uB2o
        sfl0DDbdijdegAf+qAdVw2jsSUdzbf/aUk8ujhLTNQ==
X-Google-Smtp-Source: ABdhPJx9inLDIPmTOV3iexaq48JJ2LGAat39UkWIYohUnz4/Rg0ILXnTPO3CNCyAmF3qVGe/vEq8a+9YgTLTapD2Oco=
X-Received: by 2002:a67:cb04:: with SMTP id b4mr3948840vsl.17.1633366028698;
 Mon, 04 Oct 2021 09:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com> <patch-1.5-8a4ca06bce0-20211002T091212Z-avarab@gmail.com>
In-Reply-To: <patch-1.5-8a4ca06bce0-20211002T091212Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 4 Oct 2021 18:46:57 +0200
Message-ID: <CAFQ2z_NwrpMuYmtB1caokup9SCr=od97ONG86c4PWmfEJ5vZCg@mail.gmail.com>
Subject: Re: [PATCH 1/5] "lib-diff" tests: make "README" and "COPYING" test
 data smaller
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 2, 2021 at 11:19 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Follow-up the change in 459b8d22e54 (tests: do not borrow from COPYING
> and README from the real source, 2015-02-15) by not shipping a full
> copy of older versions of the top-level "COPYING" and "README" files.
>
> The tests that use them just need the small blurb at the top of
> "COPYING" as test data, or mock data that's dissimilar. Let's provide
> that with a "COPYING_test_data" function instead.

I had to read this patch a couple of times before I understood what
was going on.

Your change is a definite improvement, but if the actual contents
don't matter that much, maybe something like "lorum ipsum" would be
even better.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
