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
	by dcvr.yhbt.net (Postfix) with ESMTP id 232F51F461
	for <e@80x24.org>; Mon,  2 Sep 2019 19:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfIBTNk (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 15:13:40 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43027 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfIBTNj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 15:13:39 -0400
Received: by mail-vs1-f65.google.com with SMTP id u21so1468565vsl.10
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 12:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEhl6cfR14FtA3cSgVWWK73f6TIUWCckZD/Zb0nUU88=;
        b=nvaiAcUiVakWTKpw6kwobl7E4Uyz8ey9BvEmHn9/FLjmVdtXi/gqqm2QLrSbAnJoVp
         9XGyTQpuiRklqCuG+RTZePYLFtqC8xLmOSL39vilonArjL9mHElH69CRkDk0+MWmOy4Y
         wQWJNKHXFBzsvgJdgUShrH/2w0pynFfdoR6roLI7jR2oHEtJvTir6huDeGm15X0lWdUy
         e8FprLEyTBi8imcXRPTFM1W3mb/q5k2BQHGoKgRWKqkYcBcv/Ild/dO+PtM2ozgOw8xp
         KKbH6ARMVgBbyNQskg7D82tnzhu9WlehjKaEULg6cgfoNEdURhRCiIysVX9ifOXj+rTX
         nsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEhl6cfR14FtA3cSgVWWK73f6TIUWCckZD/Zb0nUU88=;
        b=eA4x2q4mxJqB6kXHzuhSDfm06j2zCdxs2+W0AyDq7ZAwbE+JTDaZYZDom7Jz2Enqt2
         ppo1uBbPRJzeD65O9fThtvFhY4yIHWd6KjLGfp/AqZApuPWwXYJ/5nom5NCug4GLfrps
         I8jF+q2dv754nJodtjw7tzv8CWwmjNDK+8I+jhfTMihD9v6IHbnGquuaCYukZdXv8Cum
         Kbf6SH5ZNqflgS96/5RcItHUbTZg17m2/r1i1+Qr7rokLdg/oTaczNKecvuc0C+B2Kvi
         IhZ1flY46me2vZ6OGUaRB0NxBAVkuG1sHfo0GR94QSE+HrepJduUAbn8RV75vnDtYua7
         7MVA==
X-Gm-Message-State: APjAAAXNmjiAJwPC0oCr3bGvjabmayb4Cd2US7LcGdtn3+F8yYRov08w
        ChPh9aMNLv2oTfMRDMFobc3inNEGlZKjbX2OMHahQnsFdyk=
X-Google-Smtp-Source: APXvYqzHSCHXOwpE3N1zJZsF21NqA72FJB8oyxjI2v/J/TwUHNfXdP5D8n1vNJ7RtG4KaqnV2Rk0sWGkmLvjdFf4KUk=
X-Received: by 2002:a67:fd11:: with SMTP id f17mr3608087vsr.31.1567451618881;
 Mon, 02 Sep 2019 12:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
 <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
 <CAGr--=+CEX-STDgT_ZwaA=n9UHSrsgcWnxCMY=9tGDA=9XLkew@mail.gmail.com>
 <20190902181213.7jqvoyctdm26g34z@yadavpratyush.com> <CAGr--=JgqjC8FskqVFJTqAnQ5aq8J4z-Wje8s22VwBgVtkBF-Q@mail.gmail.com>
 <20190902184405.bfb5572iia2v2uwi@yadavpratyush.com> <20190902185819.fzf3lop6riiq6zja@yadavpratyush.com>
 <CAKPyHN1GgXLy0+z=JbuyuSvVXsh6u5Po18OXizPNmfLE5AC00g@mail.gmail.com>
In-Reply-To: <CAKPyHN1GgXLy0+z=JbuyuSvVXsh6u5Po18OXizPNmfLE5AC00g@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon, 2 Sep 2019 21:13:27 +0200
Message-ID: <CAKPyHN3=QY4+XNhQPq09_PALFwfR5bWBs7q6m6LkfFoW-xeCug@mail.gmail.com>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar appears
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 2, 2019 at 9:03 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>
> On Mon, Sep 2, 2019 at 8:58 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> >
> > On 03/09/19 12:14AM, Pratyush Yadav wrote:
> > > On 02/09/19 08:22PM, Birger Skogeng Pedersen wrote:
> > > > On Mon, Sep 2, 2019 at 8:05 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> > > > > I cannot test windows easily, it looks good on Linux Tcl /Tk 8.6:
> > > > >
> > > > > https://kgab.selfhost.eu/s/f38GX4caCZBj4mZ
> > > >
> > > > On Mon, Sep 2, 2019 at 8:12 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > > > > Hmm, it looks fine for me. Which platform are you using? I am running it
> > > > > on Linux. Screenshot: https://imgur.com/sNp5Ktq
> > > >
> > > > Try resizing the bottom right pane of git gui, you should see that the
> > > > scrollbar remains at the bottom while the input area moves upwards.
> > >
> > > Yes, I can reproduce the problem when I do this. Interestingly, the
> > > vertical scrollbar does move, the horizontal one (which Bert just added)
> > > doesn't. So I think there is a slight difference in how the horizontal
> > > scrollbar is set up that is causing this.
> >
> > On second thought, wouldn't it make more sense to expand the commit
> > message buffer instead? The point of resizing that pane is to see more
> > of the commit message. So it makes more sense to make the commit message
> > buffer take up all the vertical space, rather than making the scrollbar
> > move.
>
> it is, I just broke that ;-)

is fixed in GitHub:

    wget https://github.com/bertwesarg/git-gui/commit/56163547604f44688e208393f8941efaf5247d40.patch

Thanks.

Bert

>
> Bert
>
> >
> > --
> > Regards,
> > Pratyush Yadav
