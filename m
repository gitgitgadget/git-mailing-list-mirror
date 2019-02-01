Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2F91F453
	for <e@80x24.org>; Fri,  1 Feb 2019 22:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBAWmB (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 17:42:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44819 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfBAWmA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 17:42:00 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so9482165qte.11
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 14:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRCMwEZ/BSdQxSNlyt4KtJQyRCq/jrPHd5WNtukrHFY=;
        b=AlieEFV0aS5OYR7NBFGwar1FClgcMRUMVMxLkM1BpA/QMbm4WRggn9oqub6hxYGG+n
         wFzNRvI0CuWDG9M7g0qNJZGwIs0nSs+KOjibFl/ignd84Twz0c5HFeLt4eRu9IIyU6Hh
         L9qHBgsVVPSy7LzglaIvQOcZusWR/6frsrMRforXInmM6MgwVPvUpk62EkRVPthUqnLt
         VqnId+b9velQ2IoAloZJ4ecnkNYv38EAWZU4A8WMQQY1uyIApcg00y5gkldQB/TSJPyZ
         7cgAjUU2vvGxwEQn/4ns/uBbXTvPlEkrqcvll0v/FcbPrT9eTFyyrXFHGIstMwG2GT9Z
         GJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRCMwEZ/BSdQxSNlyt4KtJQyRCq/jrPHd5WNtukrHFY=;
        b=DzJleJhIas2vxyhLa6y+tsA/Py1nMjJwLybENEScH6zAQzGBW/V5tSqJqoK21hwew5
         MvSarmRnoLdl3wzotKrntij1d375BRSYvn3Ptf8RFl9t6EeTUnI4CChXtGIbHBue8bpR
         h0Kv8Hs/wnwybrhASMbhrVRGqp7moBwnoRQ59F5RjrrdnNdJV2YyRkcy/mahActQVzX1
         a48hREIPFm5fTNqfOhmQCN8pWbhbFD2O5ZuDRkgpikOhaisZV6M+rRQHJNfOCkbeI21T
         gLxPfQScw2vp2IRARIMo8Jpm3zebnurPtLOk4HkfOMxRD6aRqvIRQ8HssOUsyRq6Qg6H
         suug==
X-Gm-Message-State: AHQUAuayWdhZkcV6WB+GrdfNp+WJQY/58nwvDER6ywqQV35TCT2GPqaC
        fqN7QeEigiSgCeDvgsrz7mL0lZFlbWnWQ18xLsw=
X-Google-Smtp-Source: AHgI3IYnUttp2MVsXsP+/hAPOEXA+FzctEkDfF7xosbD4xMpU8H7RQwLbyApRqXzoBIPveXXzKLgCv6nwayGkCZmJt0=
X-Received: by 2002:ac8:3399:: with SMTP id c25mr140500qtb.365.1549060919470;
 Fri, 01 Feb 2019 14:41:59 -0800 (PST)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190201220420.36216-1-nbelakovski@gmail.com> <20190201220420.36216-2-nbelakovski@gmail.com>
 <CAPig+cSfw=dun__contMMiHrdsZPPN68U4UzfBGz4Yt8DwO7mQ@mail.gmail.com>
In-Reply-To: <CAPig+cSfw=dun__contMMiHrdsZPPN68U4UzfBGz4Yt8DwO7mQ@mail.gmail.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Fri, 1 Feb 2019 14:41:30 -0800
Message-ID: <CAC05386a+FZP8hGawYsfZrmA--JuZBqi_aop7202JQnJEfKyJg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] ref-filter: add worktreepath atom
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 2:20 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Feb 1, 2019 at 5:04 PM <nbelakovski@gmail.com> wrote:
> > Add an atom providing the path of the linked worktree where this ref is
> > checked out, if it is checked out in any linked worktrees, and empty
> > string otherwise.
> >
> > Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
> > ---
> > diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> > @@ -214,6 +214,11 @@ symref::
> > +worktreepath::
> > +       The absolute path to the worktree in which the ref is checked
> > +       out, if it is checked out in any linked worktree. Empty string
> > +       otherwise.
>
> This may have been asked previously, but is there a reason this name
> was chosen over the more extensible "worktree:" with "path" as a
> modifier (i.e. "worktree:path")? I scanned the thread a couple weeks
> ago and did see mention of "worktree:path" but did not find any
> followup. I ask because it's conceivable that someone in the future
> might want to retrieve other information about the worktree beyond its
> path (such as whether it's bare or detached, etc.). By using the form
> "worktree:<foo>", we leave that door open. (I'm not suggesting that
> this patch series needs to implement fetching of any of the other
> worktree properties, but just asking if "worktree:<foo>" should be
> considered.)
>

There's been a little back and forth on it, but my understanding is
that using the colon separator bypasses the caching mechanism in the
atoms, so every instance of "worktree:path" in a format string would
require a lookup. Future atoms should be along the lines of
"worktreeisdetached", "worktreeisbare", etc. This is consistent with
several of the other atoms, like objecttype/size/name,
comitter/name/email/date.

> > diff --git a/ref-filter.c b/ref-filter.c
> > @@ -1562,6 +1628,13 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
> >                 if (starts_with(name, "refname"))
> >                         refname = get_refname(atom, ref);
> > +               else if (starts_with(name, "worktreepath")) {
>
> I think this was brought up previously, but shouldn't this be strcmp()
> rather than starts_with()?
>
> (starts_with() would be appropriate, if you went with the suggested
> "worktree:<foo>".)

Not sure about it being brought up previously. starts_with seemed
consistent with other uses but now I see there's several other
instance of strcmp in populate value. Seems like a reasonable thing to
change. I had previously implemented "worktree:<foo>" and must've left
it alone after we went with worktreepath.

>
> > diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> > @@ -441,4 +441,19 @@ test_expect_success '--merged is incompatible with --no-merged' '
> > +test_expect_success '"add" a worktree' '
> > +       mkdir worktree_dir &&
> > +       git worktree add -b master_worktree worktree_dir master
> > +'
>
> I don't think 'mkdir' is needed since "git worktree add" should create
> the directory itself.
>
> > +test_expect_success 'validate worktree atom' '
> > +       cat >expect <<-EOF &&
> > +       master: $(pwd)
> > +       master_worktree: $(pwd)/worktree_dir
> > +       side: not checked out
> > +       EOF
> > +       git for-each-ref --format="%(refname:short): %(if)%(worktreepath)%(then)%(worktreepath)%(else)not checked out%(end)" refs/heads/ >actual &&
> > +       test_cmp expect actual
> > +'
>
> If this is the only test using that newly-created worktree, it might
> make sense to squash the two tests together.

Sure, can do, on both points.
