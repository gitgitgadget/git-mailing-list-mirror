Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0984F1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 23:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfG3XkQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 19:40:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36261 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfG3XkP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 19:40:15 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so28608891iom.3
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 16:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGbXABbsWymqmO8FsCw3s2gIX/ruDHJKFH7hx+Dr2GY=;
        b=1IYn9/xxJ9b7RKQiyQ8k2lBhY0eehzlsS+9NXXBkIyb5vMUYvw5WSuWKb864afC/uL
         7KOhGUmxoQ6fceRWs+grkUrrlR/JsJbKdOK+uTmg3pIBg5O6Edh0+lIaDsW9f4KdK4yD
         yzBjBru0J2XP6oy51lPT7pxDBYDMEB48Xjuayt7P8xXfnLFFqCs4r6dy6WAtuwHbTUot
         pVMLFlUUe5Iyo3xDymF5zCyuR+pNsbRVcAib8k2XejDFX4GO6FEdJUm+dihzzho7tU05
         HAk5+nUeWMLGZ5S8gZsF6uAiBhwjllzxgpzw+Yb8ToCYJSXi66A6G1DKbB0kJarse2MG
         DU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGbXABbsWymqmO8FsCw3s2gIX/ruDHJKFH7hx+Dr2GY=;
        b=oTLky6njYWWYoO3vataYXHc9mbTmFhFirvN3txlWLG6qiTrr6kQJ2SBBkgHinH9WHz
         BN76RL664HKxN4Ovs9rRVj04XzHVI3ScqDb1NHlQPclMO2mmyEfb1hy6dOpoZ9pJbImb
         gudMPbmMY7iUZWddyITQlzxf7UYcf10GfMcpY4rKuOAq1ZBlJ4cn9A6/UKteVTQ/Djx5
         LKxg292/Bn4brf6l94K1yk+L0Bk6duNKMEO8muVWxEaMpGD3tGdQC3cjOC6vGv2rARD/
         Jgwh+4t37nov1lqUlDrBIF255qZrLSWCB98B9TmtyYdlK2LtP+sRrZsaggZHP2xdTrzo
         sALA==
X-Gm-Message-State: APjAAAXxl3XBjuNt7L/5e/1/1wpKWRYUQ1xs+Z1ubyCKoMWQeZipDyAb
        MSf3AD7lxGGC4pPi/+MzfErpTOA7yiXk3bP5TphEBQ==
X-Google-Smtp-Source: APXvYqxdYhxiA/FMe6+UrS0AH/w+9WeTFFHsawjl01Az9eo0Hu25AypiuSoFN3SrnrfXbey1Not0z0v4ghPbVvqpflY=
X-Received: by 2002:a5d:9a04:: with SMTP id s4mr112846170iol.19.1564530014736;
 Tue, 30 Jul 2019 16:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW61RFCySF+gUj8iYuV6afEoD0RD9oYE+N6rYd7rv3J2nA@mail.gmail.com>
 <ba3d8a953a2cc5b4ff03fefa434ffd7bd6a78f15.1564505605.git.matheus.bernardino@usp.br>
 <xmqqtvb3s2zi.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvb3s2zi.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 30 Jul 2019 20:40:03 -0300
Message-ID: <CAHd-oW48sa1Pc7AutxhKRQLry74wSYu_0xZmaz4XJnCjJdRH2A@mail.gmail.com>
Subject: Re: [GSoC][PATCH] grep: fix worktree case in submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Daniel Zaoui <jackdanielz@eyomi.org>,
        Antonio Ospite <ao2@ao2.it>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bwilliams.eng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 5:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > @@ -475,7 +475,7 @@ static int grep_submodule(struct grep_opt *opt,
> >               strbuf_release(&base);
> >               free(data);
> >       } else {
> > -             hit = grep_cache(&subopt, pathspec, 1);
> > +             hit = grep_cache(&subopt, pathspec, cached);
> >       }
>
> Interesting.  It appears to me that this has always searched in
> submodule index and never working tree.  I am not sure if there was
> any specific reason to avoid looking into the working tree files.

It seems that git-grep was taking the worktree into account before
f9ee2fc ("grep: recurse in-process using 'struct repository'",
02-08-2017). So maybe it was just a mistake during the in-process
conversion.

> Passing the 'cached' bit down from grep_cache() does look like a
> sensible way to go.
>
> > @@ -523,7 +523,8 @@ static int grep_cache(struct grep_opt *opt,
> >                       }
> >               } else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
> >                          submodule_path_match(repo->index, pathspec, name.buf, NULL)) {
> > -                     hit |= grep_submodule(opt, pathspec, NULL, ce->name, ce->name);
> > +                     hit |= grep_submodule(opt, pathspec, NULL, ce->name,
> > +                                           ce->name, cached);
> >               } else {
> >                       continue;
> >               }
> > @@ -598,7 +599,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> >                       free(data);
> >               } else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
> >                       hit |= grep_submodule(opt, pathspec, &entry.oid,
> > -                                           base->buf, base->buf + tn_len);
> > +                                           base->buf, base->buf + tn_len,
> > +                                           1); /* ignored */
>
> The trailing comment is misleading.  In the context of reviewing
> this patch, we can probably tell it applies only to that "1", but
> if you read only the postimage, the "ignored" comment looks as if
> the call itself is somehow ignored by somebody unspecified.  It is
> not clear at all that it is only about the final parameter.
>
> If you must...
>
>                 hit |= grep_submodule(opt, pathspec, &entry.oid,
>                                       base->buf, base->buf + tn_len,
>                                       1 /* ignored */);
>
> ... is a reasonable way to write it.

Right, thanks.

> > diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> > index a11366b4ce..946f91fa57 100755
> > --- a/t/t7814-grep-recurse-submodules.sh
> > +++ b/t/t7814-grep-recurse-submodules.sh
> > @@ -408,4 +408,25 @@ test_expect_success 'grep --recurse-submodules with submodules without .gitmodul
> >       test_cmp expect actual
> >  '
> >
> > +reset_and_clean () {
> > +     git reset --hard &&
> > +     git clean -fd &&
> > +     git submodule foreach --recursive 'git reset --hard' &&
> > +     git submodule foreach --recursive 'git clean -fd'
>
> Do we need two separate foreach, instread of a single one that does
> both reset and clean (i.e. "git reset --hard && git clean -f -d")?

Indeed! Thanks. I'll send a v2 addressing both comments.
