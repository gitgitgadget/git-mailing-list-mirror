Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2DD1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 20:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeI1Cgq (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 22:36:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37754 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeI1Cgq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 22:36:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id c13-v6so2464578qkm.4
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 13:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GHjcypIVh6yiPNaOdVZR7LC7CZwgS92R8+FS2DHBXtI=;
        b=pNh1vb2TpNZVfrLxtM8xkCeFVs2KK6ynSLJzxqYyaJRdAAfq9pYdo0AHxoowh4ow0f
         Wsp690oGtgYjhlEdmgBqGCRwbwRN6WXG3fESXlpzusxNls68TevQfwemtZKmEFMb7Cqf
         fSKC1w/i4b+22fd8Wk7J/TSAdPbogKINeTOW3D8b1RzhYDw4mbsBKIdituxgeXnIzfAq
         /lOvEki6cn5sc3xON1Y9G6PMx9cvXOTpMOaFGwt10v0o9FA+jjU0KdppMb9AD3PWSGZx
         0mopqc4FINpkTR1yzd4xQtHOk3lP6YG6bOi3atfEzR8T5sJ0giWE2gVzKzt+62zauJ/W
         RQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GHjcypIVh6yiPNaOdVZR7LC7CZwgS92R8+FS2DHBXtI=;
        b=ZnzQ9PTctti2TgykKV5EUNcRWB0X1vmyVId2/j7ujK5EtdH0mdJdPWJe5tvfHIVoCn
         EHCQJ/BfMivyLvjnn65F+Dv3XW9Ds6ejrOBcB27nhkH3tlSpdrIkyfNtuJz4JtDs8qTZ
         sphgyA3sd2eMce6ojeMYlvAGuQfabjwhQZm8UjwP0TVHSQNvj2WhzmI1iY/9Fdm0KWT6
         Om9x7f9TIfKDsOQ6pnu89aJZmNuYuV4EvnEXug836jIV8g4UQnxc1amav7GYeqiYpD01
         LsxJycoYzsu1MjdgSPynmLE5qxCb9MkpMlhKQG4w8PMICn7l0FT/Gud8R5+ME+HgIrtr
         qzfA==
X-Gm-Message-State: ABuFfog6O4tftI5VLlkKmG6z++0KJ627xixqh3i7/Z51UfVUnoxybab1
        hDmX4j4mSrxeti2+YGySKJQu1USH62/WYuAJeX0=
X-Google-Smtp-Source: ACcGV624sbNVdVUgz5BP0+m8aghXTGvJCxf50aYkSNVjE9hJsFIMZcBROIDOUvbgQN/GzmIgh3U/O156jNr8K4LVi/8=
X-Received: by 2002:ae9:df81:: with SMTP id t123-v6mr9488311qkf.55.1538079405679;
 Thu, 27 Sep 2018 13:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20180927181708.GA2468@sigill.intra.peff.net> <20180927192804.GA27163@rigel> <87pnwyiu8k.fsf@evledraar.gmail.com>
In-Reply-To: <87pnwyiu8k.fsf@evledraar.gmail.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Thu, 27 Sep 2018 13:16:19 -0700
Message-ID: <CAC05385d=1s_qidC4uLdRAqUNaP7jwYTjfxHtGrmBDJ54F8pRA@mail.gmail.com>
Subject: Re: [PATCH] branch: colorize branches checked out in a linked working
 tree the same way as the current branch is colorized
To:     avarab@gmail.com
Cc:     rafa.almas@gmail.com, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not to hijack my own thread, but FWIW git branch -r shows remote
branches in red, but old/new status of a remote branch is ambiguous
(could have new stuff, could be out of date). Also, git branch -vv
shows remote tracking branches in blue. One could argue it should be
red since git branch -r is in red.

But yea, probably best to take this topic to its own thread.
On Thu, Sep 27, 2018 at 1:02 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Sep 27 2018, Rafael Ascens=C3=A3o wrote:
>
> > On Thu, Sep 27, 2018 at 02:17:08PM -0400, Jeff King wrote:
> >> Do we want to limit this to git-branch, though? Ideally any output you
> >> get from git-branch could be replicated with for-each-ref (or with
> >> a custom "branch --format").
> >>
> >> I.e., could we have a format in ref-filter that matches HEAD, but
> >> returns a distinct symbol for a worktree HEAD? That would allow a few
> >> things:
> >
> > I was going to suggest using dim green and green for elsewhere and here
> > respectively, in a similar way how range-diff uses it to show different
> > versions of the same diff.
>
> It would be really useful to (just via E-Mail to start) itemize the
> colors we use in various places and what they mean.
>
> E.g. I thought green here made sense because in "diff" we show the
> old/new as red/green, so the branch you're on is "new" in the same
> sense, i.e. it's what your current state is.
>
> But maybe there's cases where that doesn't "rhyme" as it were.
