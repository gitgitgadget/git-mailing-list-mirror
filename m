Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12EE920248
	for <e@80x24.org>; Wed, 27 Feb 2019 22:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfB0WvC (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 17:51:02 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36972 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbfB0WvC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 17:51:02 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so15052001iop.4
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 14:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1+0ZLhx9/scyFZbdYtUNR4khccjjQmtLY2QtaXHn7c=;
        b=uAFFBcmT0cELzuGimmmEHtmxcrjyWUn1FlWsQiA2VefvmxqxQUNfFsTNE354G7QoQ/
         GjplzHB7TVIvq5iA7qQbeQYdHV09kQOa+OkajOXT0PCDiCZkjSmCzIRKgPhsOZrKTDab
         gLbpZ2Q1rWzBI5gYhx3z/iEOB739HtKft/qUmaP3nkjBsUna05ft526Ls+zH/tJTSvS8
         w5FylI07ax1HpE8+yVCu33Wfd0hg82Op2EVIA1z3jMyXsyVW69RsnUUjw0QbCNrtNV4c
         /3Sq2X6WHy/nUwHRWJQRNErf7O/foxKgJmzgeoeh1awGVMpR1vHjbtlsUwgLVbycP4Qx
         jexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1+0ZLhx9/scyFZbdYtUNR4khccjjQmtLY2QtaXHn7c=;
        b=MvD7ibl/I8l5b/EhXrJDcuIr78OUMOZ1e9MDW4fEtjcXlcxWCT06QzUQIItWNJZnEZ
         rHK/FcW9mBCTzmM6fx1GNZK6YZUxvyxNj4ZkqzeK8oLXFTjCbfSOH2/IYbZQxqFYeG6a
         vHteZbWMzlIvFp3PSI6w+nk2Vg50bHTPhf6fFww4CpVtlHmC3rfXJVTVhDXpsZhZDgH8
         6WWWpD42MPNEp87eEkfUZE3re6u2yRbM/7Yk9AT8kuVaJW8vdIku2PJr+aywhboMw54h
         MvB2V1HGX+hN0Eb4v2eBmM3r5lyXhNRspvUvcu7ybR0uZ2fWS9fLAH9TOomQZFY62ywn
         QU8w==
X-Gm-Message-State: APjAAAXZ/dxPev75uZc4GFBCDwP+jce6Y/I6ApMbp4tgCZZci7b+u9NS
        phxgF3kVgyaPZxLfp8FA3KxmrKfCB3yTZdyzmY1rGQ==
X-Google-Smtp-Source: APXvYqwtLQyXQKeJaUm14jZsFOyqbbwRn8zDAWBmHLxd0vH2YANcx70VBtCFv88dGSTVzLcU71vpdvi6m+UYJWwy88Y=
X-Received: by 2002:a6b:7941:: with SMTP id j1mr3521034iop.262.1551307861088;
 Wed, 27 Feb 2019 14:51:01 -0800 (PST)
MIME-Version: 1.0
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
 <20190226051804.10631-5-matheus.bernardino@usp.br> <CACsJy8BztC=GNuPU_CuLbPSmhsjrSk8MmkyeK6ahgjEOzY=yOQ@mail.gmail.com>
 <CAHd-oW5aOf+TE_AeA=VkaZUt7LTeSK_buojsEgb3NYMVVm1B_g@mail.gmail.com> <20190227224553.GS6085@hank.intra.tgummerer.com>
In-Reply-To: <20190227224553.GS6085@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 27 Feb 2019 19:50:49 -0300
Message-ID: <CAHd-oW70pZaMX80TarpMd2rOtR_ONOikwUOO8n6ZD_vfKhN5yQ@mail.gmail.com>
Subject: Re: [WIP RFC PATCH v2 4/5] clone: extract function from copy_or_link_directory
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 7:45 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 02/27, Matheus Tavares Bernardino wrote:
> > On Tue, Feb 26, 2019 at 9:18 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > >
> > > On Tue, Feb 26, 2019 at 12:18 PM Matheus Tavares
> > > <matheus.bernardino@usp.br> wrote:
> > > > +        */
> > > > +       struct stat st;
> > > > +
> > > > +       if (mkdir(pathname, mode)) {
> > >
> > > Good opportunity to unindent this by doing
> > >
> > >     if (!mkdir(...
> > >          return;
> > >
> > > but it's up to you.
> > >
> >
> > Ok. But being such a small snippet, is the indentation really a code
> > smell here? (sorry, I'm still getting used to git's coding guidelines)
>
> I don't think the indentation here is too bad here, but I think the
> code is slightly easier to read with less indentation, and it's easier
> to see what's happening in the success case as well without reading
> the whole method.
>
> And since this patch is already refactoring code we could do it here.
> I don't think it's a very big deal either way, which is why Duy left
> the decision on whether to use the suggestion or not up to you.

Ok, so I will do it for the next version! I just asked because it was
a good chance for me to learn a bit more about git's code style :)
