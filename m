Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7231F453
	for <e@80x24.org>; Fri,  1 Feb 2019 23:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfBAXUV (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 18:20:21 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:36846 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfBAXUV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 18:20:21 -0500
Received: by mail-qk1-f174.google.com with SMTP id o125so5192423qkf.3
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 15:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4pvLaEnlJYSr0zxZH2IluBuF7pBGirwOHb7zzYR/6I=;
        b=QHP6sRg9K4phQtfpY7a1VWt3h4fQnqjWiIlyB4HTdJy3A1vCqtFeMlYEj31AFCorzr
         J877qaPdzgx/lCmxzuJexxA4C6Hl/COE0RFnUtRpuLXNApNPboRTqVZJAYr1YnmH3FUH
         fIffEebJcw+Rl/0pxOODkq2TM6+ddfaynzKLk4mc0r+sYurVjpYSzlQF/+dBQtAitgYg
         XYx7JX5U1AbW1y2Uk/2Oh6/NANA9BCiFKoB4qHpX2dOH5728lb/SIazAlUAdRx9Iu86s
         N1VuhzvxuEDOuULPlK5ENqmEjuXK/pnvzDKCEWgcVAnMVQML2MV9g4cR4ncymFc2BFTh
         PAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4pvLaEnlJYSr0zxZH2IluBuF7pBGirwOHb7zzYR/6I=;
        b=gPNno1mMfsAXs+Y7Si/KDAaPSVxAK4qTNrT5RNfjJdQCRH/GYppE2zVuc2EOJLvWR+
         tdgLMhYPs2qNzL3EoL88F7m9F1/GTqcZC2nDap7ShoKz6ekuKjKnhH8Cyz5PicGUCRwb
         WWCKZ7uElT3teelbLTFDS1AKmfGNP+v7lqR32BVYWIUELt3RcRf2vkC8EIcwT+dpVjwO
         Of6WEKhkxMfcZy6PBRMIsZ7O/Q93X1Nw2T6Z3FFiUZHh3umxr8UTlBfIwN4lrHE6rtBR
         LCySf2At9PXjnG5qOK5oOwkq3RvP1148tmE0LlacmJl6+UqTTnzDzG28FnatwUFdUyZ+
         lZLA==
X-Gm-Message-State: AJcUukdlwRQfXEMPpzGr3p0rKgFJ8i69uZAeWS8p2mXtByLeOENNStHS
        AEcpOBfNR3oNM3sCvvvkP8OHWv9BGDbom/FlvQA=
X-Google-Smtp-Source: ALg8bN5bYNQM3GoFZkwYNnidUgDaEUPTq/a3TX24JW1cqMnajovcVlIK2rqlj3Pz4uSwRwdR+Sl9IO6EjkR9hSCLifQ=
X-Received: by 2002:a05:620a:151a:: with SMTP id i26mr37565468qkk.281.1549062793169;
 Fri, 01 Feb 2019 15:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20190201220420.36216-1-nbelakovski@gmail.com> <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190201220420.36216-3-nbelakovski@gmail.com> <xmqqlg2zw25q.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg2zw25q.fsf@gitster-ct.c.googlers.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Fri, 1 Feb 2019 15:12:44 -0800
Message-ID: <CAC05385Tnn+2x7Xx-Cy43S5aqjjY2gVkwcEzy+2=vYR72tNekA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] branch: Mark and color a branch differently if it
 is checked out in a linked worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 2:54 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>
> I had to apply and then use --color-words to see what is going on.
> Please avoid unnecessary reflowing of the text that makes the patch
> harder than necessary to read.

I was trying to keep the line length consistent. How else can I accomplish that?
