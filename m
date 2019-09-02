Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7200B1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 19:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfIBTDz (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 15:03:55 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37159 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfIBTDx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 15:03:53 -0400
Received: by mail-vs1-f67.google.com with SMTP id q9so3671303vsl.4
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQnGpWxKgfyKDeqbgvhh60fB6P56rARaKHv0q2+NaDY=;
        b=T69PYVBpZRkHlifHHYqNetiQK/KH56Zh7VmuMjJ6t2Ki8ra13nSp2RxYirPWNFLylD
         kCn8f1U3SzguBzwva6k1kbOTmWSAIXJbiWNbEiHqaMWhzDDjErhXfqG4eXopNmd2s/1b
         tNPnuXV/Gpkss0eIqpRAPFnpVxN22cyX3YepZqGRWcxHhXQ7XaXhjaoCPaZaRThPHQ/7
         Y8zbQfgXslE0q8vxKVeSZWCMCWxSWc0Z6vosrtNhs1X2J8fFJXRuS2RM5kukEzpVVDJd
         wD/VuxhGz5cx+G+f+v0Pc/eU5d8rrIR1i+BEkpbFa/8w1GsUsH8cjZTHfBJgkD+Nx6N+
         7S2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQnGpWxKgfyKDeqbgvhh60fB6P56rARaKHv0q2+NaDY=;
        b=noBn7KyxZBQjFwghuqSqUA4tuXln3zRaaWuoDVTt9cRCg5iWFFDcScmjZztzsmpohv
         mQpflJQeDxOnKcO83uKdk8kH9gmFCY1uCe1VI1Xwy6cobLTYQvKUwr9O7+wKIB6FPIV6
         8Msf1R0s87RA+j1y3+BSB8ZZsQAcf7NHd3SDGAzsav2O1539KkrMJNWxGiTXMf7/a+J8
         iYT0fgv1oRoEHh6GyS6PfSHRw6qnPB1fV0jbkqfEkaJbR3QX4GBYVz1z3XKmwK8AVuth
         dBy/LEXVg11+G6XvL3Dp3zc6fxdmltLgSyEO5s4EHCOdwLMLyIjIokO5bcdfPVF28zbi
         XpAw==
X-Gm-Message-State: APjAAAXDRVxj08kSfCKCEWYn85F+wM88bzYmKi2drchqS8ypzoG4E01H
        F50dCRmS8lwWVtCIVU+Y/RxPH1a+Xdsm2C5ku3w=
X-Google-Smtp-Source: APXvYqzWKwDvSNbfq4q/aDqYY6rObRaUKPpxbXSr82hEbqhFNEtCxhTYXdwBOvsQkiVL5g/QortE43O8AxGW4S7iJUg=
X-Received: by 2002:a67:2241:: with SMTP id i62mr8902746vsi.85.1567451032831;
 Mon, 02 Sep 2019 12:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
 <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
 <CAGr--=+CEX-STDgT_ZwaA=n9UHSrsgcWnxCMY=9tGDA=9XLkew@mail.gmail.com>
 <20190902181213.7jqvoyctdm26g34z@yadavpratyush.com> <CAGr--=JgqjC8FskqVFJTqAnQ5aq8J4z-Wje8s22VwBgVtkBF-Q@mail.gmail.com>
 <20190902184405.bfb5572iia2v2uwi@yadavpratyush.com> <20190902185819.fzf3lop6riiq6zja@yadavpratyush.com>
In-Reply-To: <20190902185819.fzf3lop6riiq6zja@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon, 2 Sep 2019 21:03:40 +0200
Message-ID: <CAKPyHN1GgXLy0+z=JbuyuSvVXsh6u5Po18OXizPNmfLE5AC00g@mail.gmail.com>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar appears
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 2, 2019 at 8:58 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> On 03/09/19 12:14AM, Pratyush Yadav wrote:
> > On 02/09/19 08:22PM, Birger Skogeng Pedersen wrote:
> > > On Mon, Sep 2, 2019 at 8:05 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> > > > I cannot test windows easily, it looks good on Linux Tcl /Tk 8.6:
> > > >
> > > > https://kgab.selfhost.eu/s/f38GX4caCZBj4mZ
> > >
> > > On Mon, Sep 2, 2019 at 8:12 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > > > Hmm, it looks fine for me. Which platform are you using? I am running it
> > > > on Linux. Screenshot: https://imgur.com/sNp5Ktq
> > >
> > > Try resizing the bottom right pane of git gui, you should see that the
> > > scrollbar remains at the bottom while the input area moves upwards.
> >
> > Yes, I can reproduce the problem when I do this. Interestingly, the
> > vertical scrollbar does move, the horizontal one (which Bert just added)
> > doesn't. So I think there is a slight difference in how the horizontal
> > scrollbar is set up that is causing this.
>
> On second thought, wouldn't it make more sense to expand the commit
> message buffer instead? The point of resizing that pane is to see more
> of the commit message. So it makes more sense to make the commit message
> buffer take up all the vertical space, rather than making the scrollbar
> move.

it is, I just broke that ;-)

Bert

>
> --
> Regards,
> Pratyush Yadav
