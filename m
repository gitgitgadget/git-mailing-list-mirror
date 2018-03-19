Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157AB1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 19:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935836AbeCSTRq (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 15:17:46 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:37354 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935019AbeCSTRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 15:17:25 -0400
Received: by mail-ot0-f172.google.com with SMTP id t2-v6so9314651otj.4
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jFVZnPeMREQOrlO3HVtbuKOw7/dKX+gd4egk0s88SKs=;
        b=TNn+EzsMLBdH2u5DsCNlQX6gACpgZWhXS7dsH9fUGkzuPXNxL470x+WpcXPGaOJA+u
         QhnDGNlGV7Tea14Ur4LyydVoHgqcyOx1EcPBCrCBtCCA8j8wylS/FKEga6F2s8m+tp0c
         94tp7WxCwPqHhPbrog8VA/kx1wRRztYd0yrKUFY/ASPK8esMqfnv0BN0EMaMdVrf6YJf
         qi8rKzWWKhKSJf27CyLetOcR29NF77o9ihYYSB7mfuTvvwvscGUNFOYhofp5qq28g2bc
         q7IrFcC1cvVFgNrfh3mZMF8OUs8+HwDrwkBayqM+88mPyMYzh/Y9TB+hdtMRZ+oOTcrd
         NTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFVZnPeMREQOrlO3HVtbuKOw7/dKX+gd4egk0s88SKs=;
        b=oPR02dGEFCaRbnloPN+k07skv9/8ulL9BHnOF/uJap8NVOyXorwMy68d0NfH1Z+X3Q
         ghrJtVp5cCg7Qjx+37h7UM3w3QzkZzsE3CRysdshLrhY0l9hZeCTeQ/Ggyo1GQB9fwQS
         YnIrYX8amZ2KQOaxzLlA5w+ZdH3nhpREcQuJ7bvYEfX1AFMv+Hct901OkB52GS/tF4/r
         v0sYxSwmIGzGfxcG/fMc/3YzmSTdAYqCYKJu2XT9oRbXEr6WyNsi5QqgaUXc4quBbEv6
         E6ravWMynOsGh7rLt5gmsC3hz8EeDd21Rrh42SYB9qBaV6hgZ1qRb/C7uxTNWjaINEYw
         yTLg==
X-Gm-Message-State: AElRT7FfK3jxclYaxt798L8odO82nt+mYlVzB0+EWdQRKcZmBn5TDqA8
        jE1RMVIYY9iySkBgBR4HXdjBMu0C3Pmo1iNt8xp123R+qBs=
X-Google-Smtp-Source: AG47ELsW6nCh3mMEMUsM9pcVzKUhz8ztaw6k9GiIZ4HxwlbAaIgTTvK2RCtVq6HpERsGE6JzzbFkBRxs/TCw4azN4GY=
X-Received: by 2002:a9d:3364:: with SMTP id u33-v6mr9039779otd.26.1521487044823;
 Mon, 19 Mar 2018 12:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180319025046.58052-1-dnj@google.com> <20180319025046.58052-3-dnj@google.com>
 <87zi33c22l.fsf@evledraar.gmail.com> <CAD1RUU_MpCeXfCF9NqvD-CvsWtsJShfMyg9HFAXrN-ULCE67FA@mail.gmail.com>
In-Reply-To: <CAD1RUU_MpCeXfCF9NqvD-CvsWtsJShfMyg9HFAXrN-ULCE67FA@mail.gmail.com>
From:   Daniel Jacques <dnj@google.com>
Date:   Mon, 19 Mar 2018 19:17:14 +0000
Message-ID: <CAD1RUU-K1rFaOEVXE=XZ_gu4ktmaEBGr3wtJvGJd1fivNXa21A@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] Makefile: add Perl runtime prefix support
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > The merge conflict becomes a tad easier to deal with, also makes sense
> > to have gitexecdir after infodir since that's the order we're listing
> > these in just a few lines earlier, and this is otherwise (mostly)
> > consistent.

Actually as a quick follow-up question: for these patch sets, is it best
for me to have them based off of "master", "next", or a different branch?
