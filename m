Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5241F461
	for <e@80x24.org>; Mon,  2 Sep 2019 18:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfIBSvg (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 14:51:36 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:33254 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfIBSvg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 14:51:36 -0400
Received: by mail-lj1-f182.google.com with SMTP id z17so13729651ljz.0
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ap1r1bN8xNae4HnkAHL/zqV9du2vakEXjzhIXkapSH4=;
        b=H/5YoAYf52a03d966t8bVfl0gNvv7aDSUWblgSVvn0NNTgs1s3A9awFEofUzoeTDGK
         Jg00TIVwsMAPgkkwnro30p7P8QNhYu0H0eBrMPUxpDbVfoS8xg85fCOv5gIj2k2tVZOe
         v8AUJ9l7lVRhOCw1oNVP5V9U+GeYpJ4QRtgGnmGGx17a8lcQf2D7PzCzBQyvul53jnjn
         3UhNU659rIvWAkceIuGbrwa8vpottuszK3Co1knOusg8IH7yIIrDN0wUMmGWAxuZCOJW
         OZOEtTVbmMPWYi9Ohw9tICav99kb67k0DV36pEGt+LeBLbVaHQtilVyavmf7ohkxC5zl
         E1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ap1r1bN8xNae4HnkAHL/zqV9du2vakEXjzhIXkapSH4=;
        b=Vc/Kse5O8kNCpiQqd4BHFAiREgRW7DktI9RfN+x5Dl3A5w+VveOU95VxZ60lI7N2LE
         Ated77A8XcsIV75/noeYo6Jug7NTPE+REYZboWSwiz2uNvq5+IPEc7JAX6Uszbep4X+P
         NuliW+P6aFm2atpcpqx5ktspLjqFIYw4oPQ5/k78YKK3PIPBJCHYfocJBssRWsFJhunK
         wD4GFOoFDa40LDC09M9ds51cANpdcdttFcxtHGz238+ybqngYfAqFn+GMgwC0WeO6+9H
         qTtrGNCeP4WygLARWjO4HuCDolbUHB7lRvb6/TzTXxbucV/5COip7cmudI6EOcQtr024
         +Dow==
X-Gm-Message-State: APjAAAWHUAt0uIbI3GL2jjwhAOcgbri6lxQF8u2zKlDvvFWrhKOvpqZM
        MtZug1I0KIrDTOOY/QQx5RJE1hrygWydx8FK/KQ=
X-Google-Smtp-Source: APXvYqy90nCowq+KfDQZNf4Vyp5Q7uZ6k/ZW6p9pS/I1XUPmqBppSzR+K1d5H1Izm6r3qsZEb36DHQV1Q70SwoC1vs8=
X-Received: by 2002:a05:651c:1023:: with SMTP id w3mr16280006ljm.94.1567450294446;
 Mon, 02 Sep 2019 11:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
 <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
 <xmqqa7bmvbwz.fsf@gitster-ct.c.googlers.com> <CAKPyHN3FYR0FbDxnE4ru7OoK4w3OEE0g8tpoOqH-e+e1iTmcuA@mail.gmail.com>
In-Reply-To: <CAKPyHN3FYR0FbDxnE4ru7OoK4w3OEE0g8tpoOqH-e+e1iTmcuA@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Mon, 2 Sep 2019 20:51:23 +0200
Message-ID: <CAGr--=JUGkYVLbEBd7tesa4K7R3pa3QLWQGAN5-vpjaKUBkr+w@mail.gmail.com>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar appears
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 2, 2019 at 7:58 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> up to now, git-gui does not hide any scrollbars, if they are not
> needed. IMHO, I would keep it that way, as I don't like the flicker
> when it appears and disappears. Imagine you are typing in the bottom
> line and than you typed too much. The scrollbar appears, your input
> line jumps one up line (or is hidden behind the scrollbar), than you
> remove the too long line, the scrollbar disappears again and your
> input line jumps down again.
>
> Bert
FWIW I strongly agree with this. Invisible scrollbars that pop up
(like you describe) are often quite annoying. I much prefer to just
keep them visible all the time, and disabled when there is nothing to
scroll.

Birger
