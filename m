Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2DDC19F2A
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 19:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiG3TIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 15:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiG3TIV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 15:08:21 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A0713F3A
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 12:08:18 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r14so8377233ljp.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=v32zb5GvX6Czg+nJHBEz3kGvEsCUSXLtZDyGtfJQnBk=;
        b=Y/eTmwCOQGoFFIX7xDNdPr0cXXjjiNo/OMI/50I0OKAB1inCzZdlSq2cYfq/MP+w9W
         dja1iuDXnBNNkhj/vx0NbmvsIXdbRn5yCg5xdsXASkCpVuPeRESvWLdgkokKhLod+CNf
         2mAwp685uuWeQX0BFiacGiPtfP6AYEKTBvRR8t6ioBU5ThplfnAy3mn9WtW9E5hCJ3Yu
         E9c9utW9eaqovlrjBukwmK/AldZ4uf2wO2fCAVQls63LDgaAzU+OlOh9wcMM95RobcJ1
         OSFTBy6iifKR28Tqci/hHMHTq4UNPMD9pkFiQ8TQ8tAZg0BxNNgEV7kweUPmKtn5yFJa
         YDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=v32zb5GvX6Czg+nJHBEz3kGvEsCUSXLtZDyGtfJQnBk=;
        b=0SbQdjfP3vNU0qQ5fjwaqiJwqfFpKzHv4x3kbkgryFpqB0zg8B1ArpzlRO69t0/LYa
         Gn8vjvm1Bf5dN/sr4/+87KFJ3wfj9BD5fHltLyviZWaNyWHxumbX3ea0ie+CZWj/njtL
         maSOeagkkthhe9HbcSHbb9TaTKREkFPLLWLunQuR6LHngGGa7PI7ccy1a3BF1/j3ZIyu
         3bjtsJs7VF5XXaKxDVLLnRQNuR4t22P5/eIKRbFpPvJrL+ZJWRxkYHODmh9d7lps4WDL
         d5i12AapQVt5bLA/RT6184xt2c37oGOb0BcHPA7jn4lDIzLLJITIsBkS0OjD6Ic1+mdf
         5mqg==
X-Gm-Message-State: AJIora+A0tFNKTzOqm6xfBNvmJ1dQP52GbBEhNuivtgY+ofzqnIj3WrU
        3/11uKjQxS5xu/3jwm816Lh0pJvOLYrRfaY3smMmsg==
X-Google-Smtp-Source: AGRyM1sReuDhXJCgwiVeEcl3ctf6h5rbSVI9y0N92P12g6OkzuynOylqrRN80Q4wiLONI8T9v+XKG42Jw43ZCbd8DeU=
X-Received: by 2002:a2e:8e2c:0:b0:25d:e021:ba8f with SMTP id
 r12-20020a2e8e2c000000b0025de021ba8fmr2787602ljk.491.1659208097129; Sat, 30
 Jul 2022 12:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657819649.git.matheus.bernardino@usp.br>
 <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <patch-v2-9.9-91689154926-20220729T081959Z-avarab@gmail.com>
In-Reply-To: <patch-v2-9.9-91689154926-20220729T081959Z-avarab@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Sat, 30 Jul 2022 16:08:05 -0300
Message-ID: <CAHd-oW7PV=sAmfonMDnCCEQ9NF-fmpqYAYGRS6+AJRxfyExUgQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] docs: add CONFIGURATION sections that fuzzy map to built-ins
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 5:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Add a CONFIGURATION section to the documentation of various built-ins,
> for those cases where the relevant config/NAME.txt doesn't map only to
> one git-NAME.txt. In particular:
>
>  * config/blame.txt: used by git-{blame,annotate}.txt. Since the
>    git-annotate(1) documentation refers to git-blame(1) don't add a
>    "CONFIGURATION" section to git-annotate(1), only to git-blame(1)>
>
>  * config/branch.txt: maps to both git-checkout.txt and
>    git-switch.txt (but nothing else).
>
>  * config/init.txt: should be included in git-init(1) and
>    git-clone(1).

I think the inclusion at git-init(1) is missing in the diff below.
