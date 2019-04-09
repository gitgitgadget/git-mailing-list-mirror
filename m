Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95C2A20248
	for <e@80x24.org>; Tue,  9 Apr 2019 12:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfDIMSs (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 08:18:48 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34218 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIMSs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 08:18:48 -0400
Received: by mail-it1-f193.google.com with SMTP id z17so2635601itc.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 05:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1P7a4tI9YHXcKgV+bggH3khgQw92UK9CF2oOEAr16o=;
        b=ZxsF15JG/TX0WU2mPGYAqrouJNhes5OB+zi7BtP2W/dAPze/kj6Z5Z8FCwHIXbAIAM
         AogRi417uiIS07pyxB2iF0ZsV501pHWHO3pMxgEHPxgJ30vuCOp7/j7oO5HbwbYAvwG1
         9iKASbKZLEQsMRDQ0Jkjav4cslWPPAZzEc6XnJNEMTyFNYCZCiVg6cFqY1s2NTZWfq2i
         hKkq/XRjMEsYAkYvqMNLuhy8plsP/wG+8EXpEM/CgNXflQOBl3H1SCEq1I5bUg9/GRN6
         PCUq+C4t9NjD716cvymoNjGyT5+vyN+peyZMhP/a2qRIBrYhJlOKccAU+P3Wz0lRgGva
         LYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1P7a4tI9YHXcKgV+bggH3khgQw92UK9CF2oOEAr16o=;
        b=FzLsh4uHjk3bRZdIG1Whyd+rvnkNC8+W0+wSeHIZ6E6CWsxcAuaUdb7LyVi2rH/7BP
         Hore0ymHg7dw3/9Y3+gVYB8ENRvj2nicmUAOfzuQlzDGALKGjSJdx9l0O9/WASXyP8nZ
         OxEi8dgznYKNC35ieCAGSy1xzBZwnaxvXRj6/bNFkS4r4gw1pCGgjkx059ihls/xSHeS
         y34pB1mnE4OUTg4ps/R6TXvyJLqQk5u3H3U9PJ63FfLUKzrswbShrzD4OEVu+5RzjPuH
         qxCt0O/ZcM6e7gXQ2hARLHuT1pK8rMD1mgkiPGkQyaZCQBv4nZdDUeLu3Alr1pznEMoU
         thOQ==
X-Gm-Message-State: APjAAAV7HfDSlraMTmqJ6q47sKhFG4UpodtfuB7BzbXMhIeEYaqBLUJ0
        e2Vrff5Oms8sPlSQyEmhD3NftijWXoaWgx8o7Jg=
X-Google-Smtp-Source: APXvYqyu1UiL3K9STajURzoV8xV137xr4xoZCpQvX+dIrI2qR1Ae4VaxZptfBRtf/M8bzXCP3/Dh0SH7YUt8nfxBwGU=
X-Received: by 2002:a02:c50b:: with SMTP id s11mr26239789jam.84.1554812327164;
 Tue, 09 Apr 2019 05:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-2-pclouds@gmail.com>
 <CABPp-BFXZMorrHph3hGFnqfceHs68byWNgffNKGp1ov6X5-o5A@mail.gmail.com>
 <CACsJy8D4tvm_zLo0DcnjmcBeKDRDR+HGAxd1PsUMSBcgR59DPg@mail.gmail.com> <CABPp-BENtDUOpKYHZu=4rKFrQMaCE=fEtAWRqHvePjZYm1jTtg@mail.gmail.com>
In-Reply-To: <CABPp-BENtDUOpKYHZu=4rKFrQMaCE=fEtAWRqHvePjZYm1jTtg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 9 Apr 2019 19:18:20 +0700
Message-ID: <CACsJy8DSyLttWr=QSg+enkTm4EKADmL99zZ0fiZRjCpXo9=5YA@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] checkout: split part of it to new command 'restore'
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(since 'git switch' is basically done, let's get back to 'git restore')

On Sun, Mar 10, 2019 at 1:27 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Sat, Mar 9, 2019 at 4:16 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > On Sat, Mar 9, 2019 at 1:01 AM Elijah Newren <newren@gmail.com> wrote:
>
> > > > +-q::
> > > > +--quiet::
> > > > +       Quiet, suppress feedback messages.
> > > > +
> > > > +--progress::
> > > > +--no-progress::
> > > > +       Progress status is reported on the standard error stream
> > > > +       by default when it is attached to a terminal, unless `--quiet`
> > > > +       is specified. This flag enables progress reporting even if not
> > > > +       attached to a terminal, regardless of `--quiet`.
> > >
> > > I'm assuming this means there are feedback messages other than
> > > progress feedback?
> >
> > There could be. This is carried over from git-checkout. I suspect this
> > is about warnings that we print from time to time.
>
> Why would --quiet squelch warnings?  I figured it'd only squelch
> feedback, informational, or progress messages.

I'm wrong. Warnings are not suppressed by --quiet. It looks like
--quiet is not really used by 'git restore'. Based on code inspection,
--quiet implies --no-progress if --[no-]progress is not specified.
Otherwise progress bar is enabled only when we have tty.

> I understand you just carried it over from git-checkout, but as worded
> it makes me wonder if checkout has suboptimal behavior or perhaps just
> a suboptimal explanation of its flags ... and if it does, we probably
> don't want to carry that over.

But there is something we don't show now, but I don't know if we should show.

The commit that started all this is 0f086e6dca (checkout: print
something when checking out paths, 2018-11-13) where I tried to make
'git checkout' mistakes easier to see by printing

    Updated <n> paths from <some-checkout-source>

Because the reason is to help spot mistakes, this is only printed when
you do "git checkout <paths>" _without_ the double dashes to
disambiguate.

Since git-restore has no ambiguation (between restoring paths and
switching branches) these messages are never printed. I'm just
wondering if we should print them anyway. It gives some feedback
instead of the silent output in the successful case. Some might like
it, some don't.

> > > > +-f::
> > > > +--force::
> > > > +       If `--source` is not specified, unmerged entries are left alone
> > > > +       and will not fail the operation. Unmerged entries are always
> > > > +       replaced if `--source` is specified, regardless of `--force`.
> > >
> > > This may be slightly confusing, in particular it suggests that --index
> > > (or --worktree and --index) are the default.  Is --force only useful
> > > when --index is specified?  If it has utility with --worktree only,
> > > what does it do?
> >
> > Well, this is 'git checkout -f' behavior which only concerns the
> > index. So yeah it only matters with --index.
>
> Okay, good to know that this only matters with --index. However, new
> problem: This makes the explanation feel contradictory, though,
> because elsewhere you stated that --source=HEAD is implied when
> --index is given without a source.  So, the combination of this
> description and that fact suggests that -f is either useless (--index
> is not specified) or ignored (because --source will either default to
> HEAD or be specified by the user).  Maybe that's true and -f should be
> removed from this new document.  If it has actual utility in some
> cases, then this description needs to be reworked to explain what
> those circiumstances are somehow.

Actually my description of this option is not clear. This is about
--worktree, not --index.

When we do "git restore <path>" (which by default implies --worktree),
we take the entry from the index and overwrite the worktree with it.
But if the entry is unmerged (and --ours or --theirs are not
specified), there is no good way we can handle it automatically.

So the default behavior in this case is abort the operation. -f goes
with a gentler option: ignore unmerged entries and go restore normal
ones. And to keep people informed that there _are_ unmerged entries,
warning is displayed for each one.

So, maybe I'll rename --force to --ignore-unmerged? This option will
only matter in the "git restore [--worktree]" form. In other words,
restoring worktree from the index. If --ignored-unmerged is specified
in other modes, die().
-- 
Duy
