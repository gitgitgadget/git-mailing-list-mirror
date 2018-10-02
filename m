Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F90C1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 20:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJCCpg (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 22:45:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40110 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeJCCpg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 22:45:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id j62-v6so3224704edd.7
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PfLCplxOcWVbz0/9x9k/GOM/ROIi8srTICKyMQzU0jM=;
        b=iMUGLKWv4pbf2rVpg4mO8scqwOCT3KJPey8sy9eXWPcuixNznaQWMi2Pshva9tqn0B
         /dZ91zSOcyfzphgp3e8XU4Dx3ejJNqXvKIcVVmXkUGoQ/kmcHlRODtOmhcnpjx96FF8U
         vhXMUwdrR7lss1n2FrOhqQPDXHqZGsgC3C0lAYK13PWUtNzbA4VpqMa317RgPjrqNuHP
         J7AzaGSndKcSVuyOWWVilM4LeMj/W4PyYQqUjjAfABz7eSZChAlBM0wWN3seYfDY69J4
         hlmpIqEWj6cHXZlJlGJqkOx6ZVMO+Dflkcfe+dkbiGgZOyeKrICt+svTlg27JoVb4dg0
         Wraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PfLCplxOcWVbz0/9x9k/GOM/ROIi8srTICKyMQzU0jM=;
        b=lSAP148pB5AV88gZHnqdpk6Qw/xon7YjUhqBa8FChF2qdqtDc5g4ZTEyZLPx6fMX9g
         zuACkD6W0NBw66nOGjta8WjhRWf0mFZPh6n+LOfLYbYPZ3r0hOPthYX18Y8po6Yml02t
         pjyf8GbkK7Ntmi5n7Lb1wQ6hetaJqGosn8UKeD6O5OYeGAyhYmTfoIqlxpenf3JaLkMl
         PNmEVQ+/U+Y9YP3s69ursTPOko6zwN7wuncj8Zlo00VqqOaLGzabv1LUzLdpdiGvxx2I
         8QXXoPvxeyz6psdAC4Vw0qlhJ2UZLFCuHkFd456mOlo2bWWb4ngC+h3uG+t78qSnqiX1
         38+w==
X-Gm-Message-State: ABuFfoiVFue9hDtdAp96ZIECUcH+TVsOkv07EUFwNuNgSoKU5BO7TO34
        JpkJlArpcgP23j6dTt1fog/cWPRahunYAiwLNNg=
X-Google-Smtp-Source: ACcGV636Lg+G6ZHLG/C9xe4sfdbyFcLqzhKsWYsLMMThF5heNAic0sgVYh8FM5gfqDIiH6h3PHPYz2hhEiNHugQJ1n0=
X-Received: by 2002:aa7:c746:: with SMTP id c6-v6mr8616091eds.231.1538510432931;
 Tue, 02 Oct 2018 13:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181002191642.21504-1-jacob.e.keller@intel.com> <20181002195519.GB2014@sigill.intra.peff.net>
In-Reply-To: <20181002195519.GB2014@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 2 Oct 2018 13:00:21 -0700
Message-ID: <CA+P7+xrjpEe_3_mAwZ73O2JP2Pd518OFnSf+gfmbTJW7A3Q=Nw@mail.gmail.com>
Subject: Re: [PATCH] coccicheck: process every source file at once
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 12:55 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 02, 2018 at 12:16:42PM -0700, Jacob Keller wrote:
>
> > make coccicheck is used in order to apply coccinelle semantic patches,
> > and see if any of the transformations found within contrib/coccinelle/
> > can be applied to the current code base.
> >
> > Pass every file to a single invocation of spatch, instead of running
> > spatch once per source file.
> >
> > This reduces the time required to run make coccicheck by a significant
> > amount of time:
> >
> > Prior timing of make coccicheck
> >   real    6m14.090s
> >   user    25m2.606s
> >   sys     1m22.919s
> >
> > New timing of make coccicheck
> >   real    1m36.580s
> >   user    7m55.933s
> >   sys     0m18.219s
>
> Yay! This is a nice result.
>
> It's also one of the things that Julia suggested in an earlier thread.
> One thing I wasn't quite sure about after digging into the various
> versions (1.0.4 on Debian stable/unstable, 1.0.6 in experimental, and
> pre-1.0.7 at the bleeding edge) was whether the old versions would be
> similarly helped (or work at all).
>
> I just replicated your results with 1.0.4.deb-3+b2 from Debian stable.
> It's possible there are older versions floating around, but for
> something developer-only like this, I think "in Debian stable" is a
> reasonable enough cutoff.
>

Good. I hadn't checked back too far, but I know support for multiple
files has existed since quite a while.

> > This is nearly a 4x decrease in the time required to run make
> > coccicheck. This is due to the overhead of restarting spatch for every
> > file. By processing all files at once, we can amortize this startup cost
> > across the total number of files, rather than paying it once per file.
>
> One minor side effect is that we lose the opportunity to parallelize
> quite as much. However, I think the reduction in total CPU makes it well
> worth that (and we still have 8 cocci files and growing, which should
> keep at least 8 cores busy).
>

I don't think we do any less than previously, because we are doing
each file in a for-loop, so those would all be serial anyways.

> I think recent versions of Coccinelle will actually parallelize
> internally, too, but my 1.0.4 doesn't seem to. That's probably what I
> was thinking of earlier (but this is still a win even without that).
>
> It looks like this also fixes a problem I ran into when doing the oideq
> work, which is that the patch for a header file would get shown multiple
> times (once for each file that includes it). So this is faster _and_
> more correct. Double-yay.
>

Woot :D

> > diff --git a/Makefile b/Makefile
> > index df1df9db78da..b9947f3f51ec 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2715,10 +2715,8 @@ endif
> >  %.cocci.patch: %.cocci $(COCCI_SOURCES)
> >       @echo '    ' SPATCH $<; \
> >       ret=0; \
> > -     for f in $(COCCI_SOURCES); do \
> > -             $(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
> > -                     { ret=$$?; break; }; \
> > -     done >$@+ 2>$@.log; \
> > +     ( $(SPATCH) --sp-file $< $(COCCI_SOURCES) $(SPATCH_FLAGS) || \
> > +             { ret=$$?; }; ) >$@+ 2>$@.log; \
>
> This looks pretty straight-forward. I wondered if we could get rid of
> the "ret" handling, since we don't need to pass the error back out of
> the loop. But it's also used for the "show the log only on error" logic
> below:
>

We could probably get rid of it by doing the spatch without an ||, and
then just save $?.

> >       if test $$ret != 0; \
> >       then \
> >               cat $@.log; \
>
> The subshell could be a {}, though, I think, but it's not that big a
> deal either way.
>
> -Peff
