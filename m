Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B95B31F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 07:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfJBHfs (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 03:35:48 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38878 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfJBHfr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 03:35:47 -0400
Received: by mail-vk1-f196.google.com with SMTP id s72so4116661vkh.5
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxiopv2PFfH1IiblTuFp1YHVbdTGZVgC8ID+JUfNuCA=;
        b=C1RLxniu4vycNAL2TT5iN8pnLI1sVz9eakQ2iHNrxfbE2KfC8WKdvSs/5xoZO9g6q0
         I0ed3r2T5fiL+K/ozlQXg5bQtRDoxu+OAqvDYETMI6EiXXu+B3zUDAFqv+M9aSJB+6ec
         dhoTbue2XyV2SYtuioHqX1FmFLxuB/4ER87rHho8ecFrkIKfv2tCFB3Z5aMKEoWR4bgp
         Kq3p4jOGfFgKkXIQhCoNMvPyyh8ZmFZg0mtBNMkq3XSUBFqXEK2pwh5EoM0hFuYhVMNI
         BNe71vpJB79V1WgOs6ZhQ6vo3JF2sS84xItv2wr9flPf0rGYXoQNT4dZ9WDM+12F9JPn
         iJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxiopv2PFfH1IiblTuFp1YHVbdTGZVgC8ID+JUfNuCA=;
        b=OURwmdEHq8+ppB8jPMzwTP/CmvqNMgyCW4ewnnqe0fCRfCvqG/bOO3jM5KZfcXq9qV
         xS01ihUGh30Hibjc6a7bJarWtHnaKnxVk00Vq5JzifIILCV4XN455YD0hz5bL+dbGvsV
         quqiAN1WvTVj0LlQ7gtcNokB2DdUuJWu30a3jRFroLm9YphOqtPSXTxXknDq0lgG1N/O
         mUln1hW4rZxfzrD0BIhJeN/itcPe1ThgeFjW/pb8oMN/RIs21gaRUalLG57eQcPJtcBq
         n8tWJY7Xr2jFqbfSYjGa/WQ4fTq9hwb1POja+LT6RAK01DyWYXT2QNfZuVtm5prvClwa
         4vqQ==
X-Gm-Message-State: APjAAAW2Yw0HpJfpcA7DTuKqMOCXso4K5PczlJaOMsBZPeB8UxMWrwH/
        U/ls1ME5KawgHSzCvlyzhihnPUNCc/IDQyzC94g=
X-Google-Smtp-Source: APXvYqwulPzlhcvRXgX3CHHCraArdnUsXfETKaaapcrk209LjoTNpuk5scO9M/8XQ8fsCTjf+pV08YW1nYW0NwX0Y6I=
X-Received: by 2002:a1f:53c5:: with SMTP id h188mr1286687vkb.33.1570001746345;
 Wed, 02 Oct 2019 00:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <97013a71289857767100d6a4adcb39ca99b2b21b.1569873171.git.bert.wesarg@googlemail.com>
 <20191001142401.hhg5dtefj6qg66dd@yadavpratyush.com> <CAKPyHN2qSudnEMfokp5-BXBDU6_kcVv3aokNUYdqZOnMXYVzYw@mail.gmail.com>
 <20191001173100.n5dipyhjk4uxcnnj@yadavpratyush.com>
In-Reply-To: <20191001173100.n5dipyhjk4uxcnnj@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 2 Oct 2019 09:35:34 +0200
Message-ID: <CAKPyHN31qQwL=x0hwk2TjOkyC8iRtcLY0v6NgwA81N2i8P6aBg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] git-gui: use existing interface to query a path's attribute
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush,

On Tue, Oct 1, 2019 at 7:31 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> On 01/10/19 05:22PM, Bert Wesarg wrote:
> > On Tue, Oct 1, 2019 at 4:24 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > >
> > > Hi,
> > >
> > > I don't see any difference between v3 and v2 of this patch. What changed
> > > in this version?
> >
> > nothing, but 2/2 changed.
>
> I don't see a v3 of 2/2 in my inbox. A search on public-inbox yields
> nothing either. Can you please check if the patch was sent properly? Or
> if you _can_ find it on public-inbox.org, a link to that would do just
> fine.
>
> I _do_ have v2 of both patches, but the v3 of the second patch is the
> one missing.

I noticed this already, while in contact with Johannes on GitHub and I
found my error. While pasting messages ids for References into the v3
patch, I missed to renamed Message-Id to References for the v2 patch,
thus the v3 has the same Message-Id than the v2 patch. Will resend
now.

Bert

>
> --
> Regards,
> Pratyush Yadav
