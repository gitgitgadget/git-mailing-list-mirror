Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AE261F461
	for <e@80x24.org>; Wed,  4 Sep 2019 19:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbfIDTjR (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 15:39:17 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33013 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbfIDTjR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 15:39:17 -0400
Received: by mail-ua1-f68.google.com with SMTP id g11so7143419uak.0
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLs3slu/F507nXJL3qYN7bKsP3yhBtom87BYeRPYFww=;
        b=dL1cRWxLPI2nX9yQ0110UaArw94+B3O6xxqVqnGSnX4AhIC512rbku14HbThrX2pD3
         gfQuXlwSsuQpDJZgPpZQ9tVNAWcxQYRBl41IPAyifSwhzG3sUqCfeqLecjMAgUuNJTtX
         JL5TQz6XAdIX3cdKXcn83HGtW2usd3Hxo6pgVEywX3VQrzRXgYlTvDVSGTG+Vgl8hZPS
         cfPWt4LJgVsvIxx4jqdCJdwp590t7VbCMsJ5wu+RToHRzv2cAQsD3ea3JUXUzNkf/i5r
         aJNkADIJC/Zfi3ak0cgH8PZfyZT5SO1h8OGE5vY4FuzmRBUPMD2TjTTIu3mkdQIkqL6e
         Xuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLs3slu/F507nXJL3qYN7bKsP3yhBtom87BYeRPYFww=;
        b=IYRoOmzYW38xfqtagxRtvymoZASF/D6rMV+Xgai0FWsBMIxNz2AJAGVxfbIIhucAag
         w59Bl4AZOJwzWG7kV1hnxoJ5ZTa+dJKpkczWffbCFYF+xwLbUI3rnengMdl+p97886CE
         rVFxAfh06ZxZvvuRma+vGPYGgtnyWV5119JJJKMJnuL8xmbMEVaLQ0vkZu0xcb+P0mKs
         Mz3w1nKA4NZmeiibDtMmMGE7irlEp07g90BSDYOzCxvpu3yCZ8BsNhQAWYRvPd1eqJDj
         4jYLyIrLY2Ykv03m7wKzj1bxsqwAdBLlyjCR93SEMGaD4JJ6gCziwQM7hHt5z/eIhLWC
         w5LQ==
X-Gm-Message-State: APjAAAVxhbrZOP4/jNVIDYHXbbUIhLqzq//zd8W84P+W3fz48FB5gp2S
        /TlNgBvfoKEmSlyZUPq8INoorHbXslYf2hurnU4=
X-Google-Smtp-Source: APXvYqxgcK3PMKUI9nDEUYkfxhrxIZ/nHorzIZK3kxns+TqyNwn+4uNPNY99tRn5dTI4c+w3OB1KjeK2aQG8Jeoa9Ig=
X-Received: by 2002:a9f:3110:: with SMTP id m16mr20731348uab.10.1567625953990;
 Wed, 04 Sep 2019 12:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
 <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
 <CAGr--=+CEX-STDgT_ZwaA=n9UHSrsgcWnxCMY=9tGDA=9XLkew@mail.gmail.com>
 <20190902181213.7jqvoyctdm26g34z@yadavpratyush.com> <CAGr--=JgqjC8FskqVFJTqAnQ5aq8J4z-Wje8s22VwBgVtkBF-Q@mail.gmail.com>
 <20190902184405.bfb5572iia2v2uwi@yadavpratyush.com> <20190902185819.fzf3lop6riiq6zja@yadavpratyush.com>
 <CAKPyHN1GgXLy0+z=JbuyuSvVXsh6u5Po18OXizPNmfLE5AC00g@mail.gmail.com>
 <CAKPyHN3=QY4+XNhQPq09_PALFwfR5bWBs7q6m6LkfFoW-xeCug@mail.gmail.com> <20190903171511.cd6vwn4kz7bdpose@yadavpratyush.com>
In-Reply-To: <20190903171511.cd6vwn4kz7bdpose@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 4 Sep 2019 21:39:02 +0200
Message-ID: <CAKPyHN39AXJBtuDepb-TgGSGrvqs4a5+yp74L5im3Svmw5S8aA@mail.gmail.com>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar appears
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 3, 2019 at 7:15 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> On 02/09/19 09:13PM, Bert Wesarg wrote:
> > On Mon, Sep 2, 2019 at 9:03 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> > >
> [snip]
> > > > On second thought, wouldn't it make more sense to expand the
> > > > commit
> > > > message buffer instead? The point of resizing that pane is to see more
> > > > of the commit message. So it makes more sense to make the commit message
> > > > buffer take up all the vertical space, rather than making the scrollbar
> > > > move.
> > >
> > > it is, I just broke that ;-)
> >
> > is fixed in GitHub:
> >
> >     wget https://github.com/bertwesarg/git-gui/commit/56163547604f44688e208393f8941efaf5247d40.patch
>
> I tried the patch out. Works fine on Linux. Thanks.
>
> There is a minor typo in your commit message.
>
> > Sugestted-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
>
> s/Sugestted/Suggested/
>
> > Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> One more observation:
>
> If I write a particularly long line (and consequently the scrollbar
> becomes active), and then hit Ctrl+A to select all text, and then
> backspace to delete it all, the scrollbar does not get updated. It still
> shows the old position where is is "scrolled" halfway through. As soon
> as I type in any other character, it takes the correct state, and
> becomes disabled.
>
> The vertical scrollbar behaves correctly in this scenario, and does take
> the correct state and position as soon as I delete all text, so I
> suspect it should be a small fix. Maybe a missed option or something
> like that?

While I can reproduce this, I don't figured out what is wrong here. I
tried a minimal example and this also fails. The yScrollCommand is
issued, but the xScrollCommand not. I have tcl/tk 8.6.8 on Linux.

Bert

>
> --
> Regards,
> Pratyush Yadav
