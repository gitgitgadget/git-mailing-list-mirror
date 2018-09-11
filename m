Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5152E1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 18:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeIKXk7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 19:40:59 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33116 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbeIKXk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 19:40:59 -0400
Received: by mail-yb1-f196.google.com with SMTP id m123-v6so9740191ybm.0
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVqGx4a8y+Eqx1S0oGa/jaexw8lHSXblTRF/5A8KrMM=;
        b=kucDAf9oIuv5ufbFfJkE96ar1Vx26VU+1FcieLdA9/H1MupxhFVZgOrJW3d5kAYXpv
         kW3JlmSDxo3ua6URn7xE3KAE6o46v6QBM0C8nrQ6AAaAYxKZ3SCrWuiR6bIfooJVHXEZ
         Y2lbXsOiLoLTY17y1j5yHM50GXjuiVfReLZDa5CJSxEvBS6ddOuLQTQqXASerrZIVl/y
         AWY34W641HSzzhboMtGVQAujJ79494sTaNG606fMGz2DO6ln1xX9Rc+ixq0RAmoBEqEd
         SIwzA7w+ZWr5yMd4/OvODE5L1qRhwvpNPXuJ4mEs+OZ83+YjRUo89hwNnOpCpBBfTKd+
         snIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVqGx4a8y+Eqx1S0oGa/jaexw8lHSXblTRF/5A8KrMM=;
        b=k8tm2nwG5585aflAlbuX13wAJTxkxvgsIO0oViTRj2mhLZ+lid4TSZ8zgwzWZvxDYG
         0tP+ULA5i7Cs8yFILZK8buNM94OmzvKpJXlP0fjxUNuK2IwfqUjhn+tZJnzkASB7FFPS
         kuUzZDLISXS55Hjw6+N2WgMm8QXBVHBkC/aAtV3uRYp6bB86ZparrVMzpuGG0IUF5TNv
         esmIjt0leB9kJIIT52DCVeOIvOVpQ6saNKckf3Abdre0xiATk6+eXT7XpQF/PkRdowLk
         16tNseh5pexjrtvJlmqNVEWpSWwB+Vt/+/lbixtispB2mp+cHd/l+O0fTM5EuT9Tg4BB
         /bLA==
X-Gm-Message-State: APzg51CQZnGfOtw9SV4ITh5wlkTeA383lu0dR5WoTVIbV5hObpQrv9/I
        h0YV0TXM28IVY/2+ZDt3EdDRSX51lr2FMfNa6PDgww==
X-Google-Smtp-Source: ANB0VdZaATk/Ntqa+JQLXvo4+SufR053cLKXhiZHtUnsY7747zq2wF9wGjNRQsapbIuxz26meW3Vk64Mqg/Kg9I4N5s=
X-Received: by 2002:a25:8892:: with SMTP id d18-v6mr3751557ybl.521.1536691223545;
 Tue, 11 Sep 2018 11:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180904135258.31300-1-phillip.wood@talktalk.net>
 <CAGZ79kaBBzG6-QKruCeybN_do735h9tAXHZ7Rjx_YXeh85ax6A@mail.gmail.com>
 <b78b467c-6cae-2e2e-533c-48a4552539f5@talktalk.net> <5cff63d6-d9ec-d28f-d34a-e610ac19dbcb@talktalk.net>
 <CAGZ79kb53jNAJagQ+nG0hoJiozKkR6Aw=oRLZj5xvjFY5Hx=Sg@mail.gmail.com> <xmqqftyfq4qw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftyfq4qw.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Sep 2018 11:40:12 -0700
Message-ID: <CAGZ79kacqst9PVCzit_XpKYTHDC7VaKG_7OGoZyd3CtUxw74Cg@mail.gmail.com>
Subject: Re: [PATCH] diff: fix --color-moved-ws=allow-indentation-change
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 11:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> >>  [...] So this should be sufficient.
> >
> > Yup.
> > Thanks for keeping track of this patch, as I lost track of it.
> >
> > thanks,
> > Stefan
>
> So does the above exchange mean that
> <20180904135258.31300-1-phillip.wood@talktalk.net> is ready to go
> with your Acked-by?

Acked-by: Stefan Beller <sbeller@google.com

I thought this was implicit, would you be interested in a more formal
communication for this, c.f.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n513
sections 12 and 13.

thanks.
