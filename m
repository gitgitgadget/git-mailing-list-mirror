Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACD02208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 19:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbeHFVcG (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 17:32:06 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44875 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732787AbeHFVcG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 17:32:06 -0400
Received: by mail-io0-f194.google.com with SMTP id q19-v6so11965446ioh.11
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ixogm5tRDFwEg56XTUtlaPFU/S9mdxsVXtj8s7mpq5c=;
        b=rI0jEerPTOaKuhF7k7w4CO/RJ8wbl/rOSxOJm5uZS9uqLSx9i+X3rmxG3oIuOpptZe
         XMc6uHY8Z3g7+QE2fMYZppxPrvS9PF/H9wB/OZLSVn1SqImA6eQ5ieKhQSMZjgEpbB5F
         hFLc7qscROwLXbtRvumhW0xXj1vub7dlKsCjsURAiZJCSONjsPD5MzUe+tsz4IRm0iOW
         0kg0WeMqKoY3onBId1iKc2d1R5yCi+wnsi52i+Jl4R92kakt607JnXPOZG18UlxlGIz1
         m2rqx5CT3EEq0F1i0SsLlROxURgriP/ElcZwMh/C92VY4u0vqE0WWqagdU1o0+KpSCUM
         goIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ixogm5tRDFwEg56XTUtlaPFU/S9mdxsVXtj8s7mpq5c=;
        b=oHASpwgDfPVxlfvW1m5qWxJnVpwaZAj5Y7xn1nvCfL+xQ7T0auoqKT0NFNlZvV7rE/
         0NCdhmKaugfZuT34AxXUlax5+bwX1/ygUBJNuy6OOyC0JsGiWlCpJyQBMBxTW6QbA1Cv
         dTcKG7MckaJ71ZTSabNdpV5EvHLDNad7OKtMVq2HMDoczZr2uRyGX1yRSiz1ydcrIQWm
         bklQCdWuH1t9VjDaHEBc5xkM/oiSJlcgbdPTJgi5aC43mKi9BEPCDJNw+CwVtH+8IO8t
         yeZLCKvLQ6ucAFp0o+zLJlLnEcssIjVQrBVYQsO8CL8cJImXGAZtAKi6l509Gjtqc2pO
         EDKw==
X-Gm-Message-State: AOUpUlFw8J/sd8snTs0Egor2Dd81mDt/WpFshkvEzGfyLGK7PuXSL4Fz
        2epErpKDa+V9DIjKAvajvLSMh3RSY7wvAUs+FE85nw==
X-Google-Smtp-Source: AA+uWPxWxGOR4TjZJUmD8abfim9EAIalLmJy0Z6f6zYka/JmT/JUb0qL5NfRDlMdgFABB82w+Q2wKepvj0eg5WI5ObE=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr14870984ioe.282.1533583294256;
 Mon, 06 Aug 2018 12:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-3-chriscool@tuxfamily.org> <CACsJy8AzksB=rfaX_dfboMXHjqj6gj+erdF6eRFAKmWA1-3PUg@mail.gmail.com>
 <CAP8UFD2frOjmZoOfWW-93xewA6LS5zTEisNr4QDz2FNQE2DY_A@mail.gmail.com>
 <CACsJy8Aa2xo+jVOPza_wt-EX8P4_M8XJD3jdLs=cr11M0ckUuA@mail.gmail.com> <CAP8UFD35j1KkO=hB58Qcs=PZTFW2=djGi07z5uyayDENXzanwA@mail.gmail.com>
In-Reply-To: <CAP8UFD35j1KkO=hB58Qcs=PZTFW2=djGi07z5uyayDENXzanwA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 6 Aug 2018 21:21:07 +0200
Message-ID: <CACsJy8D_V5d4y1cYhBveq8yxrwUPeuiqmgGyQJYTC2V0Zye-Tw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] Add delta-islands.{c,h}
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 8:54 PM Christian Couder
<christian.couder@gmail.com> wrote:
> > Is it worth it? The "pahole" comment in this file is up to date. We
> > use 80 bytes per object. This series makes the struct 88 bytes (I've
> > just rerun pahole).
>
> Did you run it on V1 or on V2? I guess on V2, but then what do you
> think about converting the 'layer' field into a bit field, which might
> be simpler and save space?

V2. I kinda ignored the layer field because Jeff was suggesting that
it may not be needed. It may be better to just move it out though
because it's not that complicated and even if we have enough bits
left, they may be spread out that it's hard to reorder so that they're
grouped together and use can use them.

> > On linux repo with 12M objects, "git pack-objects
> > --all" needs extra 96MB memory even if this feature is not used. So
> > yes I still think it's worth moving these fields out of struct
> > object_entry.
>
> And what about the fields already in struct object_entry? While I am
> at it, I think I could move some of them too if it is really so worth

Way ahead of you. In v2.17.0 this struct is 136 bytes so going down to
80 bytes now is a big memory saving. I think I  squeezed everything
possible and was a bit too aggressive that I created a new performance
regression in v2.18.0 ;-)
-- 
Duy
