Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A851F453
	for <e@80x24.org>; Wed, 23 Jan 2019 23:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfAWXew (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 18:34:52 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33350 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfAWXev (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 18:34:51 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so4564823qtp.0
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 15:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8Q3B1UY10zZxMA6CfV9E+uxNzrJrtBVesxz1ZLgR9w=;
        b=PjQX3PvA/T40DECtrXk/oDyxII/qBQGLuZKjBoJqzNHDyyaLCmIH/EY3RsE4pVaZeV
         6OrK9P2VuKZVAVlkeaRysrAz+Ks7YHZ+7MmvJieS1MoPVC0VEWwWVLbTtEKSUalQvx1k
         qFMGnUkvmo3TCeXTU5d7nEq4/t90XiTWbgmXBh8xdqeI2JJE4Gia3t96iFcfKvp1QqIu
         ADUMG7K49S1ZCNypDCZkd+DH6biKVPoC6P/DDjhRghl6g1tbxm0BNAcPiA8Y7G122gr+
         0lsT7qFvmhBPVNITxTB9FzDlePzyOGTErjY04YuVRs51PjhGSI7Lxe7/5BFexq6ptrXT
         4XuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8Q3B1UY10zZxMA6CfV9E+uxNzrJrtBVesxz1ZLgR9w=;
        b=UY4On4iTNoOGsR3PE0XX7rlIdJD6+11gE2dsuBfjn8WNq9ZRHRIeEfVOk0LUBUjVZU
         IXrzsByIjskIvm6o173XWLyzpHcKIagUXUdN1+Iyd/JRhqcGeIlqYIf1uM/Tc4yUB1SQ
         Nfmty7XXXKxhxiRWHryxRuoTNM3v0doI+mUIU8KeZPNsL+tXUq+yst5wDkEslFfe1gkI
         wrqabEZ0fzOk9XEUseolN1Za94n+ytTAp05gPNH3HeytG41MtecpdGj2F6mKlUBWsHEv
         0+rOe1WGTtp8lJpJw9C1l4oa9G9cvfn9E08tG7MrTm2m9VRv5cSW7WVgkoJWXZwTvgjo
         ygdA==
X-Gm-Message-State: AJcUukfHf5ICS/1whRBBp1mR4kX2Oc9pmxBMBoEAbHQfD7ENLH6CUa6T
        NTJreQ143JFlE70Qb3k1YvVjChzSnF2/ipnPUG4=
X-Google-Smtp-Source: ALg8bN6rrJ3EAfvr8eHl76r081qVIETytaQ89WpGwLjAHehb3AS9LTaB8YJW0xqRyokt3xbnm4gW8Fr05XJIspsaunQ=
X-Received: by 2002:a0c:b174:: with SMTP id r49mr3731362qvc.70.1548286490138;
 Wed, 23 Jan 2019 15:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20190122232301.95971-1-nbelakovski@gmail.com> <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190122232301.95971-2-nbelakovski@gmail.com> <xmqq36pjcicw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36pjcicw.fsf@gitster-ct.c.googlers.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Wed, 23 Jan 2019 15:34:22 -0800
Message-ID: <CAC05384+KjC=4_ZF9BrxweMUjwpkaGXNqRNSnwif6yci6TxMMw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] ref-filter: add worktreepath atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 23, 2019 at 10:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Missing sign-off?
>

My mistake, forgot -s on format-patch. Will remember to add it next go-around.

> > +static int ref_to_worktree_map_cmpfnc(const void *unused_lookupdata, const void *existing_hashmap_entry_to_test,
> > +                                const void *key, const void *keydata_aka_refname)
> > +{
> > +     const struct ref_to_worktree_entry *e = existing_hashmap_entry_to_test;
> > +     const struct ref_to_worktree_entry *k = key;
> > +     return strcmp(e->wt->head_ref, keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);
>
> Overlong line.
>
> > +}
>

OK, should I shorten the function signature as well? Is it too long
because it's 101 characters and you're trying to stick to 100?

>
> > +
> > +static struct hashmap ref_to_worktree_map;
> > +static struct worktree **worktrees = NULL;
>
> No need to initialize static vars to 0/NULL.

OK

>
> We do not need a strbuf to do the above, do we?
>
>         hashmap_entry_init(...);
>         lookup_result = hashmap_get(...);
>         if (lookup_result)
>                 return xstrdup(lookup_result->wt->path);
>         else
>                 return xstrdup("");
>
> or something like that, perhaps?
>

Sure.

> > @@ -1562,6 +1624,13 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
> >
> >               if (starts_with(name, "refname"))
> >                       refname = get_refname(atom, ref);
> > +             else if (starts_with(name, "worktreepath")) {
> > +                     if (ref->kind == FILTER_REFS_BRANCHES)
> > +                             v->s = get_worktree_path(atom, ref);
> > +                     else
> > +                             v->s = xstrdup("");
> > +                     continue;
> > +             }
>
> I am wondering if get_worktree_path() being called should be the
> triggering event for lazy initialization worktree_atom_parser() is
> doing in this patch, instead of verify_ref_format() seeing the
> "%(worktreepath)" atom.  Is there any codepath that wants to make
> sure the lazy initialization is done without/before populate_value()
> sees a use of the "%(worktreepath)" atom?  If so, such a plan would
> not work, but otherwise, we can do the following:
>
>  - rename worktree_atom_parser() to lazy_init_worktrees() or
>    something, and remove all of its unused parameters.
>
>  - remove parser callback for "worktreepath" from valid_atom[].
>
>  - call lazy_inti_worktrees() at the beginning of
>    get_worktree_path().
>
> Hmm?

Yes, the parser used the atom argument in an earlier version of this
patch, but we since moved the map out of the atom since it only needs
to exist once globally. Even though we have a caching mechanism for
atoms it still seemed like a logical move to explicitly keep one
instance of the map globally. Will make the change, thanks for taking
a look at it through fresh eyes.
