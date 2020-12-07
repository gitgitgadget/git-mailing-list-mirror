Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17C8C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 16:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D5B2388A
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 16:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgLGQsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGQsP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 11:48:15 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAF7C061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 08:47:29 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l11so19091430lfg.0
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 08:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6GSxXxoiia2wyjEhfBINr6xAy0dYvh6Kdn0pXozVcSg=;
        b=NlUUD2kkpaftcVmdGUY+qZy7lZspTRiij/VoO+aXHwY1cQt8PcOIADWPEeuNk20WND
         yAU1A9PJ4BpxIlMP67OUE7zgqQlhiV00Ep4dWTN2k/Ai6Op+zHFqAGA7BTg4Sxs9Z2xy
         H/ALkrIBtkUd5GB9v0bBuTkHjj6JPP4ruqFvA9HNTE0vl8vCmqOAdsFSclo1uo8EIgQM
         BwmE0yfDrpxUZ7pCBZrPOKYep+6IIPyI9WH1AMFKXTYx61tzolE9TjziRLTIW20tR/5d
         ZR8nSGM/JsRGZ6PvSNaOhulK1zfcgbLK7UV6KJgD8woaDMF+5C4IcAShDH2DssyQHMhw
         fqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6GSxXxoiia2wyjEhfBINr6xAy0dYvh6Kdn0pXozVcSg=;
        b=gD/rbcJ24Scxzo6xfIAOVtovVPKG1aSc/81/ZolbDGzDiBz4odIbfTErIYcz6Y4nB5
         znBwTsWgvRpYuUW7n4H3XFcv3AX+X9bSFLGkClOPgARhlQnjwK7B0MUD/Nss8hay9U8H
         Tqdh6cVcy85KQMB0H2YVuwIqZbJaN/2/IDERCVOe0dq1wcrtOu3ggDhfEywOnSid8sQF
         79PTBMJk82uGeLghmJjBTz2O73MZ/U4mf0xukrwdHFVoSZxFsp6w58FD5aznRLP7S/Do
         vccfpFiki0yDFFPq4M2zGskhjHduVgyaf0cpIgX6C1aFA3D0AdhtktN7Ic0t7/yEgs1u
         Sc4Q==
X-Gm-Message-State: AOAM530+Ogh7yJHEvNFuJlZsUhVPQgXawiygrYu+c8h4wZ2yXunkLxgV
        wt17SDcf5u6A57Luw6JyzZ/By86PzIoHr2fEcWB3+A==
X-Google-Smtp-Source: ABdhPJzWEopJxpPE1MDLbAm1gdABqQ/ZmVT27oVM3uvb/WkdMga3rcf0oPdWdaJC+VFrMQFhxWYoyzZp/BhSZK7JLKk=
X-Received: by 2002:a19:c3cb:: with SMTP id t194mr1466629lff.599.1607359647905;
 Mon, 07 Dec 2020 08:47:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br>
 <aa635bda21c43e0d82ce21e791df280ee6231d43.1604521275.git.matheus.bernardino@usp.br>
 <CAP8UFD3SpzGbkeBas+yDEjDgtDiTdztD=6fMfG=8rHKN5B6kCQ@mail.gmail.com>
In-Reply-To: <CAP8UFD3SpzGbkeBas+yDEjDgtDiTdztD=6fMfG=8rHKN5B6kCQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 7 Dec 2020 13:47:16 -0300
Message-ID: <CAHd-oW5beC6bM-0SabCAry93S8tDL6uXD8-C6MAWj67Ss20xbQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/19] entry: add checkout_entry_ca() which takes
 preloaded conv_attrs
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 6, 2020 at 7:03 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Nov 4, 2020 at 9:34 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
>
> The title might be a bit shorter with: s/which takes/taking/ or
> s/which takes/using/
>
> > @@ -530,12 +531,12 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
> >         if (nr_checkouts)
> >                 (*nr_checkouts)++;
> >
> > -       if (S_ISREG(ce->ce_mode)) {
> > +       if (S_ISREG(ce->ce_mode) && !ca) {
> >                 convert_attrs(state->istate, &ca_buf, ce->name);
> >                 ca = &ca_buf;
> >         }
>
> I wonder if it's possible to avoid repeating the above 4 lines twice
> in this function.

Yeah, I was thinking about that as well. But the only way I found to
avoid the repetition would be to place this block before check_path().
The problem is that we would end up calling convert_attrs() even for
the cases where we later decide not to checkout the entry (because,
for example, state->not_new is true or the file is already up to
date).

> > -       return write_entry(ce, path.buf, NULL, state, 0);
> > +       return write_entry(ce, path.buf, ca, state, 0);
>
> It's good that ca is eventually passed here, but it might belong to
> the previous patch.

Right, I'll fix the previous patch.

> > -int checkout_entry(struct cache_entry *ce, const struct checkout *state,
> > -                  char *topath, int *nr_checkouts);
> > +#define checkout_entry(ce, state, topath, nr_checkouts) \
> > +               checkout_entry_ca(ce, NULL, state, topath, nr_checkouts)
>
> I thought that we prefer inline functions over macros when possible.

Thanks, I didn't know about the preference. I'll change that.
