Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1525C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA21523A7C
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgLJCSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgLJCSU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 21:18:20 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC9DC0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 18:17:39 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id w124so967600oia.6
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 18:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=syNlwCcIl7dNj+X/p36moHBj57ash/oqHMu4tplxN8I=;
        b=uEwt/mI47V08KACwa2m62qRmJboMCq0q3unTEL+MB6z+2F/h0YnR52oGBgkvI2rUMo
         uewj12vh9KBET58Gbe4WeDqz4JW2n3L9HKEpEwYjPkqOycJiGznhc+KolkeaMsPzfi0Q
         12P0iPie7OqtCZVoRIAmJZEoNQf/wK9pc1iYmPuASnRsX1j0jpzWnQ0dgTUL8ZwrywWh
         DvHadNpg2ohMhDyqQdj1GdVyTuo6oNagUc0kkSir8DvapSSahufzRZTQZZqoanoHgtRY
         wq6cuyJIgX2UciqWtu9bGpWHH0pdqclp5Gsc3SPCEgq1DKom7flw7TC5xuPRFuTFmw2a
         kzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=syNlwCcIl7dNj+X/p36moHBj57ash/oqHMu4tplxN8I=;
        b=iMekvGrL7H6yYAZe2M/0USMdh8ufvlgu+jztugbBSQ23EVyXK95tfmKixZ76o5QZp6
         +tHn/HcHewME1mx3XaXyyWLtWaQfomKEN1joesTR+k53jZdAbpmsxUCBzSu/Bu9+aBd7
         n8QJAGT7NxEKVZVmEi2pCOfyAx6b2Zvf681MTgdbWlL7nwrPMBEQXqS/qpr4V3or7S7R
         1B2Zn4QKKHGlUHn+qYaFWDnkLimTKg64WijYiEz5ZXc/HOkileqP0ovPvOiM7GZPcxnN
         2mULSeq/4Ecuw/9rKGnUNHScfLgryChVE6maJRK1IPJ+89RYfSxrlWC19hF/oLnKdodI
         QnLA==
X-Gm-Message-State: AOAM533WR1A8jp5ABnf6NGaWUjYV/mAOa/itdMBw1OUOwKGR/xrhuMlU
        kqEEA5AQtk5hAKYHCLjXyhUaFzumZ5t/yLpPK4Y=
X-Google-Smtp-Source: ABdhPJxzkKeM8kST7PZYws6wAYM1L7JmCrCC+YiVjG8NY1TBumzPrNKL1pqCllMJa9UhAO2jTN6B3m3zbdqr2CEOLAY=
X-Received: by 2002:a54:4704:: with SMTP id k4mr4004304oik.39.1607566658410;
 Wed, 09 Dec 2020 18:17:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <f96bb36930a6e5e42f0d3b9c5dfa3b2cc27c1f9d.1607223276.git.gitgitgadget@gmail.com>
 <X9FLaiuWpYely6es@nand.local> <xmqqtusuxvr8.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtusuxvr8.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 Dec 2020 18:17:27 -0800
Message-ID: <CABPp-BFcSV_LPy-_AW+c-1OgzAyHfEM7D+YL+fFwxYKDheqxEg@mail.gmail.com>
Subject: Re: [PATCH 2/7] diffcore-rename: remove unnecessary if-clause
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 6:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Sun, Dec 06, 2020 at 02:54:31AM +0000, Elijah Newren via GitGitGadget wrote:
> >> From: Elijah Newren <newren@gmail.com>
> >>
> >> diffcore-rename had two different checks of the form
> >>
> >>     if ((a < limit || b < limit) &&
> >>         a * b <= limit * limit)
> >>
> >> Since these are all non-negative integers, this can be simplified to
> >>
> >>     if (a * b <= limit * limit)
> >
> > Makes sense.
>
> I've always assumed that the original was for correctness (if a and
> b are both larger than limit, a*b could end up being smaller than
> limit*limit when the result of multiplication of the former wraps
> around but not the latter) ...
>
> >> The only advantage of the former would be in avoiding a couple
> >> multiplications in the rare case that both a and b are BOTH very large.
> >> I see no reason for such an optimization given that this code is not in
> >> any kind of loop.  Prefer code simplicity here and change to the latter
> >> form.
> >
> > If you were really paranoid, you could perform these checks with
> > unsigned_mult_overflows(), but I don't think that it's worth doing so
> > here.
>
> ... and in no way as an optimization.
>
> So, I dunno.

Ah, so would you be okay replacing these with

   if (st_mult(num_targets, limited_sources) <= st_mult(rename_limit,
rename_limit))

?

That'd make the correctness intent far clearer, and allow us to drop
the casting as well since st_mult converts to size_t.  (If, on the off
chance you're on a platform where size_t is 32-bits and the
multiplications don't fit in that size, then the requested matrices
for computing rename detection won't fit in memory for you.)
