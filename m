Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC8B31F404
	for <e@80x24.org>; Mon, 10 Sep 2018 18:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeIJXo4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 19:44:56 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44741 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJXo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 19:44:56 -0400
Received: by mail-yw1-f68.google.com with SMTP id l9-v6so8233634ywc.11
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R62oHO9uJEJBiGDF2bIMfmeyuJwvSYC8VlchkQ6VYl0=;
        b=HUmyttdNOJJ0CUjUEUXTaAjataHSGr1mZa6jlNye0OwYeQijAIpnaDK3vewaM0/66w
         n+XfG879hO8Z2nVu5G56FBQSihKpQoi6RqB5Y9JFyNwYh2VvHnx2HCa522Dg3jByZhTL
         QqiN8D5+XYT66hjFX48bdv/1JbmlHyQfUG50CIC1uFEW2d3i/hsr2prhPwKNnIsgq55Q
         hQxQ6xgAun1DaAjAsJxwK1NSFcrziVCTyeb1+nBj6tHim+RKU5eQtwSHreZNIgOXd6q3
         4+QlEAyTC+CYqQH224R0bRO/U/2VRcNOEmD1u2PBK9CxK99qu2UKC1/+rxgp7AM6uF4W
         k0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R62oHO9uJEJBiGDF2bIMfmeyuJwvSYC8VlchkQ6VYl0=;
        b=naM++98mOM8YpEjpTOe6qmFydO7EQ5nhpj4bTgxk1dsGtgOs1EVaj22lNraGEWN62D
         PON0wTuEzltXydT/4syQJj9RY6K+b73/5d+CaTTKl7Vm5HdaDYkq6P1JsNAqeaSA4PnY
         BmKNTrGcZOXnoPvc6FcxRbe2je1Pk4e0AlV5DWrgdRFdSGZ0REBjIfdtUeT9bDIpouM5
         HoXLSFFncboaWmQLXH8psDNKZ3VyrkPfixKcFCBNl7Ou4ntxX8zUhHI97PwoGEX116t6
         8Zpn++bSp0RcTf6a4fNhE+S7iEdOGuy3xVgdQy0bgmpvQnWmE0CsjJRycIrTCXBHYL07
         NgNQ==
X-Gm-Message-State: APzg51BdXuabtAs8e8+ziRm2d4zzfLzsxUYRBPwR81iblyafkKaidxJ4
        8ycoQyqZB//N5r5+0qHMLDoOK4VTlEWhJVHPX405Vw==
X-Google-Smtp-Source: ANB0Vda8hxEh3xY7f/m2fhhDEka7vfrZjygX/yc8jM3vKwphRWRs2D2MvqiRsoauIVPo0O2BGiE1QDVh4I15jLpuHvM=
X-Received: by 2002:a81:5710:: with SMTP id l16-v6mr10828770ywb.3.1536605368075;
 Mon, 10 Sep 2018 11:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180826100314.5137-13-pclouds@gmail.com>
 <CAGZ79kb=gcmEDGmTS-j-veFj8BgKup0g96i0Gm1P+j8eyX8_mQ@mail.gmail.com>
 <CACsJy8D9ZMGA8FDmgcNMbWH7VP5O8bfn7tLnXda2TcQKmLM5NA@mail.gmail.com>
 <CAGZ79kYBg62votOkFmpWjFoR_s2WZq-cSvXa==EP1q22WNEKpQ@mail.gmail.com> <CACsJy8AqV63N9Xiu=ha+rqjriStNFdR3NyLZ_yoRqFNChKTHaQ@mail.gmail.com>
In-Reply-To: <CACsJy8AqV63N9Xiu=ha+rqjriStNFdR3NyLZ_yoRqFNChKTHaQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Sep 2018 11:49:17 -0700
Message-ID: <CAGZ79kbsFWnLryqDJwih9Cmax6egAknL+jQ3E7Q9URqTyvJvXg@mail.gmail.com>
Subject: Re: [PATCH 12/21] patch-ids.c: remove implicit dependency on the_index
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 9, 2018 at 1:02 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Sep 4, 2018 at 9:54 PM Stefan Beller <sbeller@google.com> wrote:
> >
> > On Mon, Sep 3, 2018 at 11:03 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > >
> > > On Mon, Aug 27, 2018 at 9:13 PM Stefan Beller <sbeller@google.com> wrote:
> > > >
> > > > > -int init_patch_ids(struct patch_ids *ids)
> > > > > +int init_patch_ids(struct patch_ids *ids, struct repository *repo)
> > > > >  {
> > > > >         memset(ids, 0, sizeof(*ids));
> > > > > -       diff_setup(&ids->diffopts, the_repository);
> > > > > +       diff_setup(&ids->diffopts, repo);
> > > >
> > > > Just realized when looking at this diff, though it applies to
> > > > other patches as well. (and reading Documentation/technical/api-diff.txt
> > > > confirms my thinking IMHO)
> > > >
> > > > What makes the repository argument any special compared
> > > > to the rest of the diff options?
> > > >
> > > > So I would expect the setup to look like
> > > >
> > > >     memset(ids, 0, sizeof(*ids));
> > > >     ids->diffopts->repo = the_repository;
> > > >     diff_setup(&ids->diffopts);
> > > >
> > > > here and in diff_setup, we'd have
> > > >
> > > >   if (!options->repo)
> > > >     options->repo = the_repository;
> > > >
> > > > or even put the_repository into default_diff_options,
> > > > but then I wonder how this deals with no-repo invocations
> > > > (git diff --no-index examples for bug reports)
> > >
> > > That makes "repo" field optional and I'm very much against falling
> > > back to the_repository. revisions.c in the end does not have any
> > > the_repository reference, and it's actually undefined for most files.
> > > This makes accidentally adding the_repository back much more
> > > difficult.
> >
> > Thanks for the clear explanation. I agree that this is a good approach
> > with these reasons given. So in case a resend is needed, maybe add
> > these to the commit message, as it explains why we deviate from
> > the pattern here.
>
> Actually I looked at it again and diff_setup() clears diffopts as the
> first step, so any assignments prior to the diff_setup() call has no
> effect.

Eh, I botched that code in email, I meant to put it between

    diff_setup(&diffopts);
    diffopts.repo = <a repo>
    diff_setup_done(&diffopts);

but I still agree with you that we want to have the repository as a
non-optional field.

>
> > > Yes the --no-index stuff will have to be taken care of at some point,
> > > but I think for now we could just put "struct repository *" in place
> > > first to see what it looks like, then go from there.
> >
> > I would think repo = NULL would do? But we can defer this
> > discussion to later.
>
> Yes. But the the_hash_algo currently points to
> the_repository->hash_algo. We need to at least make the_hash_algo
> independent from 'struct repository *', then figure out how to set
> the_hash_algo without $GIT_DIR/config file...

That sounds as if it is unwise to rely on the_hash_algo and
rather prefer the repositories configured hash algorithm instead;
only falling back to the_hash_algo when we have no repository
handle available.

Stefan
