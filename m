Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F97CC433F5
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 06:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3C760F9B
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 06:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhIZGhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 02:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhIZGhE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 02:37:04 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7E2C061570
        for <git@vger.kernel.org>; Sat, 25 Sep 2021 23:35:28 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so19622574otj.2
        for <git@vger.kernel.org>; Sat, 25 Sep 2021 23:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDj3BxoPoa59ZBj7AXTwrqLHUAWnibACzPejxtl1Vuk=;
        b=pQJN/JH9+X+iDhUK0OgAecr+KOYroqTm21neQiC3ACZNusXDQXlNmw2XHcYH29iAv0
         gTvZe9ayaWQwtoR5KYTfYf7MoyFitGfnbQMtBJwEAY+dXr1BYMz6/ecXB2QfXrbZbhPH
         OtlkyGiPQC0TxHKDmVLN8hsOOw0tCJx8f6iM/yXx+JUF0Z+W7cg1Rsmz4gFQfsMHyxfV
         gWJn10sgb7Yb98i85CTg/4HZieMFq3Z2aLU2joATf/zdFA5VE78KztlzzuwJjhHkss9k
         0l2eRE7q2rq+bjtyUOF/B2RRku7Oi5y1pnEQudum/4aDRjbk8/opzKniSDAM4JsoHDQs
         UBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDj3BxoPoa59ZBj7AXTwrqLHUAWnibACzPejxtl1Vuk=;
        b=UW4N8wKUd3apxBrUng3KHf45HxAPEwSMnHfRO/267f/xLGjhn6DepsaEFldVbbS+xr
         ZjZ4A6q6gPMiwWM/KQtMoMc4BnNfSveMlQc3tEnP7Gp6NL6exbnGZOjphrD2POx0ztXX
         Gw86x65/bRDCrbYUfsxQBu4iWJ1jVgeYeM5wUbpWj1ZrBzpHySX6+W80m2rI1rQzXIuK
         v/tiHyfcjNskd/7U26j4opkt9Pa5Q0pdw4m8UAfikeW5XuUEG4upjZt7cdnKrLoKkl6b
         5dJ43t9B14JPj6Jf7mNvQtIEtk6tOWQ8oatKI1/NQ8l/6VXbLkRHZLMffmba//wxdbat
         5dWg==
X-Gm-Message-State: AOAM53304QDvEU+GGVQm/ukEF6FIgwFkYftJFBa9nPyIPiHSPA9dqlKb
        jeC4D5a9BVXcJAm9GuGP4qY1ECgtRGeSW1GAxXc=
X-Google-Smtp-Source: ABdhPJykizenCXv4vov04CzSCyVqNC4rpYOgXirUrBiYvemNIBklUVLtaNXFiEJMMREkonKuTIyQStLkz5/4lnqJoPA=
X-Received: by 2002:a05:6830:24ac:: with SMTP id v12mr11665113ots.174.1632638128105;
 Sat, 25 Sep 2021 23:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com> <4b78a526d2acfbcd85d6e4cb94894725ea0350aa.1632465429.git.gitgitgadget@gmail.com>
 <CAPig+cRCtuPtXesh8494W=HOQJishCY+vSX1Fr_mF86qvnEP9g@mail.gmail.com>
In-Reply-To: <CAPig+cRCtuPtXesh8494W=HOQJishCY+vSX1Fr_mF86qvnEP9g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 25 Sep 2021 23:35:16 -0700
Message-ID: <CABPp-BFMjQK+14A90agS5wUG8Tpug68dUSPcz0RRZNkiaMzCug@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] Comment important codepaths regarding nuking
 untracked files/dirs
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 10:50 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Sep 24, 2021 at 2:37 AM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > In the last few commits we focused on code in unpack-trees.c that
> > mistakenly removed untracked files or directories.  There may be more of
> > those, but in this commit we change our focus: callers of toplevel
> > commands that are expected to remove untracked files or directories.
> >
> > As noted previously, we have toplevel commands that are expected to
> > delete untracked files such as 'read-tree --reset', 'reset --hard', and
> > 'checkout --force'.  However, that does not mean that other highlevel
> > commands that happen to call these other commands thought about or
> > conveyed to users the possibility that untracked files could be removed.
> > Audit the code for such callsites, and add comments near existing
> > callsites to mention whether these are safe or not.
> > [...]
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > @@ -356,6 +356,11 @@ static int add_worktree(const char *path, const char *refname,
> > +               /*
> > +                * NOTE: reset --hard is okay here, because 'worktree add'
> > +                * refuses to work in an extant non-empty directory, so there
> > +                * is no risk of deleting untracked files.
> > +                */
> >                 strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
>
> I understand that this comment helps you or some other person auditing
> similar cases in the future, however, as a standalone comment for a
> reader who isn't aware of the intention, it seems more confusing than
> illuminating. It also detracts from the important purpose of `--hard`
> here, which is that it is necessary in order to get `git reset` to
> actually "checkout" the files into the empty directory, so use of
> `--hard` is not an accident or carelessness.

Fair enough; I'll strike it.

> These days, we'd probably just use:
>
>     git restore --no-recurse-submodules .
>
> instead (including the final `.`) to achieve the same, and that
> wouldn't need any sort of cuationary comment like the one being added
> by this patch. So, perhaps that's a better way to go, or maybe it's
> outside the scope of this series...

Yeah, that'd make sense.  Though it'd make even more sense to get rid
of the subprocess forking.  Definitely something for a different
series, though.
