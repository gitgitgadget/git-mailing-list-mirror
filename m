Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CCDA1F4B7
	for <e@80x24.org>; Wed, 28 Aug 2019 21:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfH1VsO (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 17:48:14 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44918 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfH1VsO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 17:48:14 -0400
Received: by mail-vs1-f68.google.com with SMTP id c7so999115vse.11
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Rj4SmXk4YC/znrskuE29SZrRhfIit0286QJpIazdV4=;
        b=rjiK4Br5AeFm0rMOSFkJ4CRfrzC8o47C1PlvGk0732JFxcYRBI1lz/bcud6r5vfOG5
         C3CcA82hP2R5GalWUXK+QvUaYH6hdPdbxMFue70pzlYF+Mv+DYP5HYrqg6dnbx32g3Jf
         h0Ajl4IpsOJ6kYwc48xbGUCDszP+t8TA3iwLRgGckeEP8Lhf8idjP6hwBbCvtd10Fz9N
         IEO/K79Z3Ha1vI7e5S0M34nBwtBVuaZ+b0MRBUIGMBumvwg33j+/zrZqjfIY4uWbqu1z
         2OTGB3/x3q6Pq6runaHRrXdemGp3W3YRUWlkM/HEaNgse2A140rWBwu+n8zgqpuFpw0V
         uKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Rj4SmXk4YC/znrskuE29SZrRhfIit0286QJpIazdV4=;
        b=auHSJhTTsk2hgaj94tnUlW7Hcma/ZvAO9RQZbv1FRQXw30rBXYoB0C3X7YrZ84iA4t
         ka3v8cm3bG0FF3mKc3+XYuPVSFFA2W9ktNJkFQAfEolUj5/SKC/5z0TvrVj0VHbbUmmc
         h5FZoUdWl79rWmaQMBv4xoOt8r8THU5YTyvJaVKi4gRQCJD3SkQL0HDw2LLBJXic1ZGr
         apULycgblK/HYtzC/HuIX3zS5SgHV+GSMTxsiejurVcJ6U+mqKH9yJbfekYFv9JHt2Fb
         54BteKutF7g9IYHpudUJJHvZSOL/PY1jPsMi8joQwvPsmbv8ydUoWxdBLWmM7hR1r5nj
         /Krg==
X-Gm-Message-State: APjAAAWgypAsASoMIGaX7WZGZsuJkR0Vn0KUL5qwGGZ3Q/V2zxGjzvBl
        /pcVKEkYgBv6JOTiIgzciibB5cmCUcE7XZTFh0Q=
X-Google-Smtp-Source: APXvYqwxLKoop1iBcy2rYssLV/ExcOiSq49daPtvcI5sVaRVU+rjkj7TcSMz1/OeHQohpDsq4xOTYeYofmtLL+8F3rY=
X-Received: by 2002:a67:d099:: with SMTP id s25mr3924465vsi.175.1567028892595;
 Wed, 28 Aug 2019 14:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190826235226.15386-1-newren@gmail.com> <20190828002210.8862-1-newren@gmail.com>
 <20190828002210.8862-4-newren@gmail.com> <CAPig+cSydZnie3CSwPgfSaNcGxr1jj94YBXAL47vEXrtxaQXUw@mail.gmail.com>
In-Reply-To: <CAPig+cSydZnie3CSwPgfSaNcGxr1jj94YBXAL47vEXrtxaQXUw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 28 Aug 2019 14:48:01 -0700
Message-ID: <CABPp-BHzHy9D7e7VbN6689-mu2AqqN-Y+inhAFjSHFi+HFSxrg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Recommend git-filter-repo instead of git-filter-branch
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 11:17 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Aug 27, 2019 at 8:22 PM Elijah Newren <newren@gmail.com> wrote:
> > filter-branch suffers from a deluge of disguised dangers that disfigure
> > history rewrites (i.e. deviate from the deliberate changes). [...]
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> > diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> > @@ -16,6 +16,20 @@ SYNOPSIS
> > +WARNING
> > +-------
> > +'git filter-branch' has a plethora of pitfalls that can produce non-obvious
> > +manglings of the intended history rewrite (and can leave you with little
> > +time to investigate such problems since it has such abysmal performance).
> > +These safety and performance issues cannot be backward compatibly fixed and
> > +as such, its use is not recommended.  Please use an alternative history
> > +filtering tool such as https://github.com/newren/git-filter-repo/[git
> > +filter-repo].  If you still need to use 'git filter-branch', please
> > +carefully read the "Safety" section of the message on the Git mailing list
> > +https://public-inbox.org/git/CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com/[detailing
> > +the land mines of filter-branch] and vigilantly avoid as many of the
> > +hazards listed there as reasonably possible.
>
> Is there a good reason to not simply copy the "Safety" section from
> that email directly into this document so that readers don't have to
> go chasing down the link (especially those who are reading
> documentation offline)?

Makes sense, I can include it.  However, saying e.g. "the
git-filter-branch manpage is missing..." or "the git-filter-branch
manpage actually documents <crazy buggy behavior> as expected" feels
really weird to include on the git-filter-branch manpage.  I'll try to
touch it up.

> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > @@ -832,7 +832,7 @@ Hard case: The changes are not the same.::
> >         This happens if the 'subsystem' rebase had conflicts, or used
> >         `--interactive` to omit, edit, squash, or fixup commits; or
> >         if the upstream used one of `commit --amend`, `reset`, or
> > -       `filter-branch`.
> > +       a full history rewriting command like `filter-repo`.
>
> Do we want a clickable link to `filter-repo` here?

I guess it can't hurt.

> > diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
> > @@ -123,10 +123,10 @@ The following format are available:
> > +linkgit:git-hash-object[1], linkgit:git-rebase[1], and
> > +linkgit:git-filter-repo[1], among other git commands, can be used to
> > [...]
> > @@ -148,8 +148,8 @@ pending objects.
> >  linkgit:git-hash-object[1]
> >  linkgit:git-rebase[1]
> > +linkgit:git-filter-repo[1]
>
> Are these 'linkgit:' references to `filter-repo` going to be
> meaningful if that tool is not incorporated into the Git project
> proper? Perhaps use a generic clickable link instead.
>
> Same comment applies to other 'linkgit:' invocations in the remainder
> of the patch.

I'm fixing them up.

> > diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> > old mode 100755
> > new mode 100644
>
> Why lose the executable bit?

Whoops.  Did some rebasing and fixups, then continued editing my
buffer of the file after one of the rebases, realized the file was
deleted (because of the final patch in the series), moved the file out
of the way and rebased again and copied the file back into place, and
forgot to check the filemode.

> > @@ -83,6 +83,19 @@ set_ident () {
> > +if [ -z "$FILTER_BRANCH_SQUELCH_WARNING" -a \
> > +     -z "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" ]; then
>
> If this script didn't already have a mix of styles, I'd say something
> about modern style being:
>
>     if test -z "$FILTER_BRANCH_SQUELCH_WARNING" &&
>         test -z "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS"
>     then
>         ...
>     fi
>
> > +       cat <<EOF
> > +WARNING: git-filter-branch has a glut of gotchas generating mangled history
> > +         rewrites.  Please use an alternative filtering tool such as 'git
> > +         filter-repo' (https://github.com/newren/git-filter-repo/) instead.
> > +         See the filter-branch manual page for more details; to squelch
> > +         this warning and pause, set FILTER_BRANCH_SQUELCH_WARNING=1.
>
> The "and pause" threw me. There's more than a bit of ambiguity
> surrounding it. Perhaps drop it?

Sure, will do.
