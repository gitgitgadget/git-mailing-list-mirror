Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2B3C433FE
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 10:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242298AbiAYKQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 05:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242997AbiAYKL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 05:11:27 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4984BC061753
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 02:11:22 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id l196so9111713vki.5
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 02:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37A9DzdgaHErG3kyoCYZW87qvNsunZLXGAEwg2TowB4=;
        b=agwBFmQfGE70EjiK1fSNc4IOFSbGlwqkClJl3kDS/Ggtl942+TX5ExcquOBXxkXJYA
         GlLItg6sV8lTBOuRwwDx2hCmxcKt38OiMP+1IMksNeph+OxDjakYkDIGhxSvHZJFnERY
         laCfGvNfPF1OddVHYnQRDpUoBdpcgavoaza3Z9RZlMM0/eO9jPe713iqbS/2PGhCDLTj
         JibsA9vRGMDremgBfAjnYwqjGuV65Lj35peaaTAId3jVvuD9qO2r09JeHDVK5R0E83p+
         HKB0UK4rddP/EdS7/eOI2xM3B7LA0KbSUWH5znTOu+GD42ndF6yGHkV+QOS04AT3Hw02
         Ip2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37A9DzdgaHErG3kyoCYZW87qvNsunZLXGAEwg2TowB4=;
        b=TMFf3UwAhx/Kt2hPRoFcdNQKoVScnw2Aq/keL/HpH1LXDvATlbpiFXZOze0a0yaPey
         0Jopmt//H+Z+omHGudjCZDyaRnz5Wx+o9XeKslt+zM/MKQg36FddCy0jl5+36LhYwy55
         UzztQFaD+T8GVKC0adiKHnyI7PA9DOtHs5HCNV9xPgZzNFqLik1o3OIaPAmoJ0kx1Al5
         zBdRheMpaQkpEfB+NX9EdDPetnnSh2j4M4GEKEuh7emzx5bDWpae7qEXcyIqYdFXyKm+
         GBhiMrqJRKIJjQC4V6Ei+sTuFHz/kgbnMj9tw5KL2rh6QGGKQjQSmpY99UvXAOy4T5pV
         6EzQ==
X-Gm-Message-State: AOAM533sWV7OT6HkTImR6KVeoAfV7PsBC9lpdKftE8idmFh0AZURVbeO
        CwnU5gT531op1DmRNUb6DUezFOj4R30fzRr9f6w=
X-Google-Smtp-Source: ABdhPJzKM7bsWhRZhNjAXy9eHIejW5Bu2tKORRgsScKlgynl8mGyWe8pk93CGU6ievzmK4giaWr6xYrwlfQ6zwn2gC0=
X-Received: by 2002:a05:6122:50b:: with SMTP id x11mr685229vko.14.1643105481287;
 Tue, 25 Jan 2022 02:11:21 -0800 (PST)
MIME-Version: 1.0
References: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
 <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com>
 <xmqqr190ekrh.fsf@gitster.g> <74d35354-20a6-9cc1-3452-573460c694bd@drbeat.li>
 <xmqqtudu9s7k.fsf@gitster.g> <xmqqh79t7sj4.fsf_-_@gitster.g>
 <xmqqr18x3s5s.fsf@gitster.g> <220124.86r18xgcv4.gmgdl@evledraar.gmail.com> <xmqqlez43mx1.fsf@gitster.g>
In-Reply-To: <xmqqlez43mx1.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 25 Jan 2022 02:11:10 -0800
Message-ID: <CAPUEspheGc2kYkX-T8YUbW7z8v650L83===q29DWZrE823FktA@mail.gmail.com>
Subject: Re: [PATCH v5] compat: auto-detect if zlib has uncompress2()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
        David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 12:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> If the question is "name a compiler that breaks and is *still* in
> active use", then the answer would be fuzzy (it depends on the
> definition of "in active use"), but is useful to find out.

`gcc -pedantic -werror` will abort the build (ISO C forbids an empty
translation unit) because an empty translation unit is not
syntactically correct code per ISO, as well as clang (ISO C requires a
translation unit to contain at least one declaration
[-Wempty-translation-unit]).

Carlo
