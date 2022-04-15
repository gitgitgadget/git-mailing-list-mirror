Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186B5C4332F
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 19:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347875AbiDOTGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 15:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347938AbiDOTGk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 15:06:40 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECE4DA0B9
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 12:04:08 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id c7so4835146vsq.13
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GDjmC1thUmvy0V3hUbkDNI/dAO9FbckjJHSwF4/JUzY=;
        b=blzq3/ta894b7Sklwabs40ClKX3qCDuYGujptrw5cLmSWq2V0TD60uA1pOnLckJ3Da
         rtOAGX3l33JSa5OH2yR0MB5q+uiFSDaOQV4NOOMAGGfoRcIF6pDVEstel2WiLhXStIal
         AFfd/kte37F5kQpBPoLFlOsHqSAPNiqyVfN61bQpsk9MXW2FNZOaGmnyZrXUZXz61hMF
         xJtC1n6QEwLY22LwM3PsYcBnfvcN1OhrVitkwjvpS42vPZ8mkIQxNmTYeR4AIYYjP+BC
         hICfS2D6NxhC71QHejCNJ+FhgeLZO4pp7FCjyXfgZl7yZkT4lAYTzZ+sipdXmhjKmoDD
         XqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GDjmC1thUmvy0V3hUbkDNI/dAO9FbckjJHSwF4/JUzY=;
        b=QexB6659jBpZ8slPwxTiDgFEMihm+0hhavOYxrUyhdVYpsTct3Nykqbhv+ZTh5GWys
         TxnTRcCr5MawoAmB1GtsY09hSpl6ccY0pKbWT0vHnAVaJM8H5OTPsTSn55Hr9a7xYSW4
         DF6GJKD7NlqO5dgXcDL8evBssmGp+5mnm65LVNIGd9/SMk1LXTZMUUFfanqGvp6jlOVx
         6+J/9g23Lj6JPsF/Zf4pLXB6vND8JCI8sSbioFFGCA1g03zsPrQvSOH5fbbV+/852FW5
         ZpHCK77LhUv0FkY/xFZLfOPmla1Bc5ni3VZWhV9wPM12gPv6fVpUMAt3JPlpAs9COX3T
         ul1Q==
X-Gm-Message-State: AOAM532kHwIJz5ig26+c+BzGuzy+OqL9+FkEVtbhCHcuCb9AYSLvUFuo
        WhrrcPiV/X88/vOnAEyXvouok8j8/gznrNXzci0=
X-Google-Smtp-Source: ABdhPJxOKFd6PaRaYzpc6ANUibbMXAJ2jHHSw25SpOkyCcAVc2zLtPA6/9KeCkoo3T9OUzKJlM/ZbcAURS4b57Av1p4=
X-Received: by 2002:a05:6102:a4c:b0:325:a8cd:f2a5 with SMTP id
 i12-20020a0561020a4c00b00325a8cdf2a5mr120682vss.76.1650049447969; Fri, 15 Apr
 2022 12:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
 <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
 <patch-v3-25.29-1268792233f-20220413T194847Z-avarab@gmail.com>
 <CAPUEspjT23rqBwkgARf90me1n0dd4pjS4i+ya=Vo=xCBCTjp4g@mail.gmail.com> <220415.86k0bqbgin.gmgdl@evledraar.gmail.com>
In-Reply-To: <220415.86k0bqbgin.gmgdl@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 15 Apr 2022 12:03:57 -0700
Message-ID: <CAPUEspiE3HBkkBzNgz8Gb6=fc2NPnfbGzzn2SEiGGG+zVo9DLA@mail.gmail.com>
Subject: Re: [PATCH v3 25/29] CI: set CC in MAKEFLAGS directly, don't add it
 to the environment
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 6:52 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> But unless I'm missing something that's already been the case on
> "master" for a while, i.e. this is the master run showing that we'll
> invoke "gcc":
> https://github.com/git/git/runs/6031562726?check_suite_focus=3Dtrue#step:=
3:6

That would be unfortunate, considering the code in next (and all other
not yet affected) branches still has the definition added in
176441bfb58 (ci: build Git with GCC 9 in the 'osx-gcc' build job,
2019-11-27) and which survived your travis-ci removal series.

Note that the value of CC is only relevant when the code is built, and
GitHub actions provides its own for all tasks and at least this "mock"
run (which adds `$CC --version` before make) with next seems to
indicate the right compiler is still being used there and hopefully
also in all other unaffected runs from all stable branches:

  https://github.com/carenas/git/runs/6041742809

Eitherway, making sure that we really use gcc in the jobs that are
tagged as such will make these extra runs (and their additional CPU
time) less wasteful and should be corrected ASAP.

Carlo
