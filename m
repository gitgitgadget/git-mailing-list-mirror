Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5090C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 11:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352996AbiALL7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 06:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbiALL7J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 06:59:09 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27127C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 03:59:09 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id c36so4161181uae.13
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 03:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RZsp3G3hMwKtST6Od6ZXjAyAM3rtKeua25sWJ9G3x30=;
        b=mRGdiKlhNIAtBD0MpO1Cib1lPCmWlN0+C4CdtQVSm6bODX10F7YBbs4c1sdZZNqFh/
         al8jIZNSJdJEtFDnNWk5RKZ4/Beha1POufiOskZ9s1/ffRQjqZEnwpwK7yjCrT57H48I
         Ct4hyo2PJiEPwBX7sw4qj1fzbyRWfk5Rvaf4413DaoTscMIrokJmuNwUgjWnnMpOXG9Q
         GN6X55Aio2FePD9nVxvsPAdjcRHyX3HkrFejEBvaswKAlWuJNGY5ToEeRBwwg9L4413l
         bzne4ofuVLiEXwn8M2rOf2GpKNQC2pnFjB6owOVBAYba19pW30xvy89lNRJ+UuHaxjb0
         qM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RZsp3G3hMwKtST6Od6ZXjAyAM3rtKeua25sWJ9G3x30=;
        b=PYubnW9Jvzrh4OIz12rqgrxTxbxTPde8aBIV9kzTx0Y/MuJwSCk6SQrFov5Jd8owgM
         3l+ZAA0r/39Nfba0oTBBRl4pbVy4JmKYGmLg6Uz7NSPtrEo2gxfJ849G0G8dmbVRqFge
         Z6uAiLf7RP/yhlAsOuzypxakPS1yzcaqvLAyaOG0uy/LoAR3GmmVSXlOQCot0B0deDsS
         TOqJ7p/c+W1C7KThM+aqC5kO7oMFx24+OZxgrBi1/0HBR1BGGbyK3Pes4MzkLSclTv0w
         x8SY5JXmm5KBlqJwUTKuIlCXwbKzPqlpvGjcKgDWNAQZlBpEDVsuhT0ajiMiOsRZAVoc
         jcBQ==
X-Gm-Message-State: AOAM532jxIuJkl2eD+JSnEuEMYZtarzAjGcPtIqa6ihB76WHX6DWw1cu
        DJ1gqg88rQpiSKOBpyt+QLmYR683ivQyn1+UKF3BoQ==
X-Google-Smtp-Source: ABdhPJxSC18JnDIGSI5dJsNAJzlDuR3JCZeEe/wAG+k9KELpc6NLjRXnRCDfrXttEuuP6R9nMXbLqTIirF1+cSu3++A=
X-Received: by 2002:a05:6102:2451:: with SMTP id g17mr3840743vss.8.1641988748166;
 Wed, 12 Jan 2022 03:59:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
 <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com> <9ab631a3b29addaa54415139e7f60a79a19a6edb.1640199396.git.gitgitgadget@gmail.com>
 <xmqqtuf0fe3r.fsf@gitster.g> <CAFQ2z_OLCzOYXgXCTXyLOwwk7EBkPzwH=KASDmuJbur=q7L1Jg@mail.gmail.com>
 <xmqq4k6y63j7.fsf@gitster.g>
In-Reply-To: <xmqq4k6y63j7.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 12 Jan 2022 12:58:57 +0100
Message-ID: <CAFQ2z_OFK77TC605GqM2Lw1Lf21fyF2cVKkGVrXO6TP6zcp+mw@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] reftable: fix resource leak in block.c error path
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
> Once you
> initialize at the declaration with "less meaningful" value (like
> zero initialization), the tools won't be able to tell when the code
> uses that variable "uninitialized" (because the assignment was
> skipped by a bug), since it appears to always be initialied to them.

Which tools are these? When I add

static void test_memcpy(void)
{
 uint32_t dest;
 char not_init[200];
 int i;
 memcpy(&dest, not_init, sizeof(dest));

 for (i =3D 0 ; i < 10; i++)
  not_init[i] =3D rand() % 255 + 1;
 printf("%d", (int) strlen(not_init));
}

to the C code, it compiles cleanly if I do "make DEVELOPER=3D1".


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
