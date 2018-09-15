Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3A81F42B
	for <e@80x24.org>; Sat, 15 Sep 2018 10:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeIOPnp (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 11:43:45 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34540 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbeIOPnp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 11:43:45 -0400
Received: by mail-it0-f65.google.com with SMTP id x79-v6so6811784ita.1
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gY/hSiSsZixXssa4U3nYL9a632jTgEXAbjqnQUw/YTc=;
        b=k9GwRHBuDJHb3Dw2JJpDno21XGGaIlL3eqJeOWvqGi0OrS4uQS92juiTDblqHAIvej
         4SU35BKIYhfOPGboEKtF72cYWTgT+EWJvnOc+31GVdCN6GwQ1KX/Xl+H9ozyHnbDr/EC
         Z6z0nXDixMkkM+npyXnwvIGOujR/cuEuXo00Q5z86lqfb7Qh4LoUTWsk6MFKljt2xJg6
         MAN8MNFegwMuN7/UnQE5Oyy/F+4uWADxoOsQkD9AELoRg9Ddvp2WM6KFh4/7Tf3N7y3Z
         AhkRLKDKgzSbTxJJu+GIwI5VSLH6ZAFpKySv6PLy87kgzP7iYaeY0Uj0HvYzQ7IsNlU5
         CwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gY/hSiSsZixXssa4U3nYL9a632jTgEXAbjqnQUw/YTc=;
        b=k+hWwkne9VWkF7Q8gZlnmNLWwbuOfdYlHEglc3YvMSwWXyg2zHzCmpjFfnwezuQr0B
         aQ8DIynaGr2CROeYhoM5babHTwt/+JJaXZrlhIvLh1dTZQUmsZumUFTX0qlatUWnjCHi
         uBFG+VPao55jzWlNJFhD37ePNJ8TfcOH6sWZWAGEywlf0pdWmaVQ5wMCjAssbOkwHUZR
         iZL18DaI8O+4bWMyqAexmAov1VRFbyJz8QNu8THtvYctevWy0bTn2VdZISqJYS11ERmc
         vfo2tOPPSfuGnTLu+LX86nWIocyJq5Fmwh8G9bdIRHDfx4wPUupazoT/UPAjIpu36bFQ
         Vb0A==
X-Gm-Message-State: APzg51BTGBlyfzDPckowBtxi+89XvVbR6YkmRPGqJZSW+xNxvcZ3NBvC
        Ji5gnIFEQsOiiODFYBVU6xzopkGWs+66JxFJs3o=
X-Google-Smtp-Source: ANB0VdZbskZOSuwKFqxyM06i4Rj/5gQobtMyWohgQPiH0qCh/Bzeqt/iSuBqpGxIx3hCO8YadpzlKr4yccmQcEo/9Y0=
X-Received: by 2002:a24:7044:: with SMTP id f65-v6mr4492482itc.62.1537007115116;
 Sat, 15 Sep 2018 03:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com> <20180912161832.55324-3-benpeart@microsoft.com>
 <CACsJy8ATsS6S5zib2FqJf1stPcGwSTO1qYBSz514Xu2GfJ4Apw@mail.gmail.com>
In-Reply-To: <CACsJy8ATsS6S5zib2FqJf1stPcGwSTO1qYBSz514Xu2GfJ4Apw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 15 Sep 2018 12:24:48 +0200
Message-ID: <CACsJy8D-sM2SSfTMmsR0uKnP0FM9fGrN0Z-pH5irMsH1=-jrmQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] read-cache: load cache extensions on a worker thread
To:     Ben Peart <benpeart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 15, 2018 at 12:22 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > @@ -1944,6 +1993,26 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
> >         istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
> >         istate->initialized = 1;
> >
> > +       p.istate = istate;
> > +       p.mmap = mmap;
> > +       p.mmap_size = mmap_size;
> > +
> > +#ifndef NO_PTHREADS
> > +       nr_threads = git_config_get_index_threads();
> > +       if (!nr_threads)
> > +               nr_threads = online_cpus();
> > +
> > +       if (nr_threads >= 2) {
> > +               extension_offset = read_eoie_extension(mmap, mmap_size);
> > +               if (extension_offset) {

One more thing I forgot. If the extension area is small enough, then
we should not need to create a thread to parse extensions in parallel.
We should know roughly how much work we need because we know the total
size of all extensions.

> > +                       /* create a thread to load the index extensions */
>
> Pointless comment. It's pretty clear from the pthread_create() below
> thanks to good function naming. Please remove.
>
> > +                       p.src_offset = extension_offset;
> > +                       if (pthread_create(&p.pthread, NULL, load_index_extensions, &p))
> > +                               die(_("unable to create load_index_extensions_thread"));
> > +               }
> > +       }
> > +#endif
> > +
> >         if (istate->version == 4) {
> >                 previous_name = &previous_name_buf;
> >                 mem_pool_init(&istate->ce_mem_pool,
-- 
Duy
