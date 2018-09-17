Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 905401F404
	for <e@80x24.org>; Mon, 17 Sep 2018 17:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeIQXHd (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 19:07:33 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39451 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIQXHc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 19:07:32 -0400
Received: by mail-it0-f67.google.com with SMTP id h1-v6so12032619itj.4
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 10:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9S5L8TQXWpn4oTgct+wr/4lwaN9uAhfu5gh4uCsGI+s=;
        b=dyyL8Yog7xX8ZgG+4y8Cn0rCnAY54KkyaNbqTDkZFZOLereOpk9qSGiil9Z9qRHH0O
         0dwNOhYDydvkNlSTuCyo2PuyE7MLW3hNbeubKIt6lsKZNV7SkEwF1LAmt6RP0Y8luSD9
         uEik2asImlATD75HAL+zCqacPNsupZrel/i0FRcYvfjppGk51SSrQM4dS4gbxr3EbmJN
         4dK9G4Bec6MqwaQBSQAZ4UYRoxNLahCSugEYDnzC4FNPtGQ4TnjH00WMtbOwxMhyW4yo
         tb8hj4QFyq1bEL4/5Jql21WMKNPyQACVRKroTxbDBIl0+R/0UXevLTrAjviFFsOSJqcF
         nQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9S5L8TQXWpn4oTgct+wr/4lwaN9uAhfu5gh4uCsGI+s=;
        b=n/KfyL86L0++QLUdM6jaopZzm45hKYsnqph6M+iUZWRCjbNfSOTRDYKEB/J6fXjuUS
         jYgV127doxCoykaCVdlnN3hE2FQR7z1GtRgDkIADzGHjcneEfPgIGkIyOQUIvPC/jVY7
         0nR3z8gk6Y3DvkjLJoTQXiZ7SqSR2nt/7lhSOY/QIC+MF9oCRGu3el/Y8V+bAjfZidnl
         bN9PaDDifOqubgQPhvFaS6OqM8HxOjF3uYvgVndCgfAHWhDNhsOHNde/f9+S5NvItyxl
         5D7tsQsMMVITqwwarFsSMZhYs1j9/bmwsh0xQ86+WDMOEmkcypnEdEBagxxtDj7fImIa
         M4fw==
X-Gm-Message-State: APzg51ADGrzoYm4bjvVSpmQ3iP6zc4ehMa/t2fnu5WAG9tQQ5HEAMflK
        q703bEEOi3OHPLG7R/JzfkTWTEToPLY93to/x3o=
X-Google-Smtp-Source: ANB0Vda21lGzRPLNxJ9yteieX489RPAoYAg8HXyZhwWIiG0ZN8wURECmpcr/DGWXMVdrp9ZVPHNjgoqT8nfI6O2w55A=
X-Received: by 2002:a24:7605:: with SMTP id z5-v6mr2364034itb.62.1537205950392;
 Mon, 17 Sep 2018 10:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com> <20180912161832.55324-2-benpeart@microsoft.com>
 <CACsJy8B51s2j0aR69UdwtpSbRN6qdLy--am_tyP5Xqo=5Zm_7g@mail.gmail.com>
 <f7250999-71a3-0113-2858-e66bad283db3@gmail.com> <CACsJy8DEvLJYBm0P1VtvKFD-CAo6_4Z13dBHWkuuAavghbGBag@mail.gmail.com>
 <xmqqsh286nfs.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsh286nfs.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Sep 2018 19:38:43 +0200
Message-ID: <CACsJy8CqaEGDaEAgp1EspR+BwyHB6YSPoppZ2t5M+qxg77hULg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] eoie: add End of Index Entry (EOIE) extension
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 7:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > But it _is_ available now. If you need it, you write the extension
> > out.
>
> Are you arguing for making it omitted when it is not needed (e.g.
> small enough index file)?  IOW, did you mean "If you do not need it,
> you do not write it out" by the above?

Yes I did.

> I do not think overhead of writing (or preparing to write) the
> extension for a small index file is by definition small enough ;-).

Good point.

I get annoyed by the "ignoring unknown extension xxx" messages while
testing though (not just this extension) and I think it will be the
same for other git implementations. But perhaps other implementations
just silently drop the extension. Most of the extensions we have added
so far (except the ancient 'TREE') are optional and are probably not
present 99% of time when a different git impl reads an index created
by C Git. This 'EIOE' may be a good test then to see if they follow
the "ignore optional extensions" rule since it will always appear in
new C Git releases.
-- 
Duy
