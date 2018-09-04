Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409041F404
	for <e@80x24.org>; Tue,  4 Sep 2018 19:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeIEAUx (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:20:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42531 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbeIEAUw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:20:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id l5so4231360edw.9
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 12:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0oSMRPxpJNZNWo8NPxdAglV8Ba+cZaEbMgMMN/Eg4Y=;
        b=CqIXPtrhO4aCfAAKy3LvZhY7xa+opcYLVURkIQhbjhJrcpkdb+qoNapm5FEEHYZuPb
         aAqkW0tfrVlLptssasJiYcERjxa0+je2Go9zGPF/Ziadq6OVjZ2kT2KilVwBxo76OwmZ
         nNMEAEFl2Z3L+qsDdKhYTmtnKhK0XyE1jNMMcKANNnWa7RAXy4w0R42shx4ggfYI1B5g
         V0DMOoXzYXXPrj60+Lj17LU/vtX57ta74sg1uSiVOlQ6ZPO0glwEj/ZbkgYgYVTlR9LY
         N3I0wEp4w3tXerAygo750nKl8bV3c6RFKeLKauETBn5Pbg8UhrZ5OGIekOnzGWVWBxb0
         xZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0oSMRPxpJNZNWo8NPxdAglV8Ba+cZaEbMgMMN/Eg4Y=;
        b=gESosTrYH8jjS7w22opWl+JeabJ83TRlmT0O0/jI2N+HGFkTR+aAmK6pG5YGci8Yyg
         np2qWi3yII3mnaxHJuhV5+5z6rMYdBcN1wpUle204Iz6ccS8IH1s+TUbmq5SWaWcUfva
         P0ZXWt4YMyHLmEaFwYx12o21O/WYFsVaxI1tmqh5nFyJBryMzWwM41CG6v8BYK6S//ar
         ZiBXBnFaEAm0jOUTmdL1/VOvq9ZjCfDXvaiBL9MhTV6Ej+L9kdQD729t8DR2zGlTjNJm
         yLFkuBTh3+DNF9LKMRl0EYPjCW8DAjQB1VCNkr0w3AvyM3+rLLzKiE+86S1hoGxaX/r/
         0hDQ==
X-Gm-Message-State: APzg51CWvLvCF6KQUDzbjSKHZzjT/hdPi96WoTW3/RzypDweQ3Nuu8Fg
        +EbHm2CQzL5TZ0/Sz8YyZt1XzXRYPQT3BYuzvPZOaw==
X-Google-Smtp-Source: ANB0VdZeuPbZOFfbKRqr468pB6y1DEmd2JahUvmYXbBOcnuu05q2Zn/BkY1/AliG1deuROJU4ETsq1RaAYfNYfrT4JU=
X-Received: by 2002:a50:aba3:: with SMTP id u32-v6mr38517888edc.257.1536090853681;
 Tue, 04 Sep 2018 12:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180826100314.5137-13-pclouds@gmail.com>
 <CAGZ79kb=gcmEDGmTS-j-veFj8BgKup0g96i0Gm1P+j8eyX8_mQ@mail.gmail.com> <CACsJy8D9ZMGA8FDmgcNMbWH7VP5O8bfn7tLnXda2TcQKmLM5NA@mail.gmail.com>
In-Reply-To: <CACsJy8D9ZMGA8FDmgcNMbWH7VP5O8bfn7tLnXda2TcQKmLM5NA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Sep 2018 12:54:02 -0700
Message-ID: <CAGZ79kYBg62votOkFmpWjFoR_s2WZq-cSvXa==EP1q22WNEKpQ@mail.gmail.com>
Subject: Re: [PATCH 12/21] patch-ids.c: remove implicit dependency on the_index
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 3, 2018 at 11:03 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Aug 27, 2018 at 9:13 PM Stefan Beller <sbeller@google.com> wrote:
> >
> > > -int init_patch_ids(struct patch_ids *ids)
> > > +int init_patch_ids(struct patch_ids *ids, struct repository *repo)
> > >  {
> > >         memset(ids, 0, sizeof(*ids));
> > > -       diff_setup(&ids->diffopts, the_repository);
> > > +       diff_setup(&ids->diffopts, repo);
> >
> > Just realized when looking at this diff, though it applies to
> > other patches as well. (and reading Documentation/technical/api-diff.txt
> > confirms my thinking IMHO)
> >
> > What makes the repository argument any special compared
> > to the rest of the diff options?
> >
> > So I would expect the setup to look like
> >
> >     memset(ids, 0, sizeof(*ids));
> >     ids->diffopts->repo = the_repository;
> >     diff_setup(&ids->diffopts);
> >
> > here and in diff_setup, we'd have
> >
> >   if (!options->repo)
> >     options->repo = the_repository;
> >
> > or even put the_repository into default_diff_options,
> > but then I wonder how this deals with no-repo invocations
> > (git diff --no-index examples for bug reports)
>
> That makes "repo" field optional and I'm very much against falling
> back to the_repository. revisions.c in the end does not have any
> the_repository reference, and it's actually undefined for most files.
> This makes accidentally adding the_repository back much more
> difficult.

Thanks for the clear explanation. I agree that this is a good approach
with these reasons given. So in case a resend is needed, maybe add
these to the commit message, as it explains why we deviate from
the pattern here.

> Yes the --no-index stuff will have to be taken care of at some point,
> but I think for now we could just put "struct repository *" in place
> first to see what it looks like, then go from there.

I would think repo = NULL would do? But we can defer this
discussion to later.

Thanks,
Stefan
