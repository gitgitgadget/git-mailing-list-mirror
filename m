Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E91211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 18:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLFS3m (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 13:29:42 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:41269 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeLFS3m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 13:29:42 -0500
Received: by mail-ed1-f45.google.com with SMTP id z28so1582872edi.8
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 10:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocpaztFdhS+5cYfAxdgBG4xvYWcSxiHUe/nSQPTfxWk=;
        b=NeDE3B/9PZx4NJ2lvjmkCeRkEMKyz2XoC0pN7Fv9Txe21NP5PKFJg+hx4e7dzRdJJr
         ftX5PvLo9XrtEBgC18AQCzKsXfDUPV5sa0UkcaO1LR4Wbc+ZHdxYqxTcjXKMEAt5yjkw
         lekqekZWcJgJzLXOFi1xQ+H/XdQtzse3D6mWfFbTk1tM46NdP2olxG0q5zpHKc7JAeZf
         C+vcBlxZRJGYHlucXOIhkBh7A5r6KWzq8WAn4ghMHXMxTfm7ooNdFw2AqTuKD8m716zd
         WS//kWOyUx/rmmBrSciRsbTMAFE3bddrrz2lYoqJYl74wXN5ztkmNHCuFWk+56TrxfHQ
         injA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocpaztFdhS+5cYfAxdgBG4xvYWcSxiHUe/nSQPTfxWk=;
        b=srMGkcaWkfelgxIQ8jCHDKcv9ka8ulyGj62tL/sWaVVrq0MWIj7m1YmlrvQ0Yhh4h1
         BQu/JqZ1QEvTE2G13471nHi/zllPcm67ljGtqHt+g0IQVly5dcvEToFyIzPUjTTuoT2r
         SctW4zGuY4KlH6IMHdyWPfKv8Q9XrCbAm72nY4nRXmkVTTa6wXgS13GpB5LOgzb4VCAM
         ogNhGMoS23SmBVPsAlOrBeXlIdGHgnduzh6rcgOAVwsehJbPXbCpgcpu9YcyLrC6m9UH
         6xcAeTzem+MlKLeBIyrapccnVZhMZCpE/XkCWnVd2HPsiJMC4gWxkh0rkVtTp3pGKaNk
         EP2A==
X-Gm-Message-State: AA+aEWZZUYqcpYgAQ8jK4x8cpO7RY5goIoEJe44bn/LT8VaVMstT3BKA
        AzOSm3R57KRSYrXCWuTG0v5DEWjSVOMiU5WPgpR0Dw==
X-Google-Smtp-Source: AFSGD/UfUwYLwCbtytloDNlFBukgRvWQgXva+GpTKCTRo1BINAD6DJYCJ2W/txSd+vlmFp1HS2A+x1qsp6WW5Hc0EjU=
X-Received: by 2002:a17:906:45d8:: with SMTP id z24-v6mr22312349ejq.19.1544120980238;
 Thu, 06 Dec 2018 10:29:40 -0800 (PST)
MIME-Version: 1.0
References: <20181206173554.GH4633@hopa.kiewit.dartmouth.edu>
In-Reply-To: <20181206173554.GH4633@hopa.kiewit.dartmouth.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Dec 2018 10:29:28 -0800
Message-ID: <CAGZ79kY8uv8zDm3f8Jb6aC-nit7OZduixyOekGYWa_xnqFqw-w@mail.gmail.com>
Subject: Re: [wishlist] git submodule update --reset-hard
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 6, 2018 at 10:02 AM Yaroslav Halchenko <yoh@onerussian.com> wrote:
>
> Dear Git Gurus,
>
> I wondered what would be your take on my wishlist request to add
> --reset-hard option, which would be very similar to regular "update" which
> checks out necessary commit, but I want it to remain in the branch.

What if the branch differs from the sha1 recorded in the superproject?

> Rationale: In DataLad we heavily rely on submodules, and we have established
> easy ways to do some manipulations across full hierarchies of them. E.g. a
> single command could introduce a good number of commits across deep hierarchy
> of submodules, e.g. while committing changes within deep submodule, while also
> doing all necessary commits in the repositories leading to that submodule so
> the entire tree of them stays in a "clean" state. The difficulty comes when
> there is a need to just "forget" some changes.  The obvious way is to e.g.
>
>    git reset --hard PREVIOUS_STATE

  git reset --hard --recurse-submodules HEAD

would do the trick

> in the top level repository.  But that leaves all the submodules now in
> the undesired state.  If I do

undesirable in the sense of still having local changes (that is what
the above reset with `--recurse` would fix) or changed the branch
state? (i.e. is detached but was on a branch before?)

>   git submodule update --recursive
>
> I would end up in the detached HEADs within submodules.
>
> What I want is to retain current branch they are at (or may be possible
> "were in"? reflog records might have that information)

So something like

  git submodule foreach --recursive git reset --hard

?

You may be interested in
https://public-inbox.org/git/20180927221603.148025-1-sbeller@google.com/
which introduces a switch `submodule.repoLike [ = true]`, which
when set would not detach HEAD in submodules.

Can you say more about the first question above:
Would you typically have situations where the
submodule branch is out of sync with the superproject
and how do you deal with that?

Adding another mode to `git submodule update` sounds
reasonable to me, too.

Stefan
