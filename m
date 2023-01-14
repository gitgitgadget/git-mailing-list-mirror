Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94839C46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 20:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjANU1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 15:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjANU1F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 15:27:05 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3D086A5
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 12:27:04 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id j17so37700618lfr.3
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 12:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BihUlL7pe9cQd4pInGPlO7SSnqHExG5lq8bSrv6/Gw=;
        b=UKv778hpwV/CVUpGtrpUzbzLR4P+wXtLPGv3cmznV9IyeUyvMLg9MkAaXWABmXCkpJ
         8Ndru7ACHwd3mZjSz4VkyyV3f1/QahU1LgYapdHMM3+QhCT0xRD/WdiIOluByN4CAXeC
         zJBufhDWzwiQ3qTpM9Zvk7m3zQyYrfDAiCiNBEhYRTTdljVlH4qo5pGzJV2v4631LdpF
         aHm8amcw2jFBjZxtlvM2NSCFRWHoS6kQlyFm2zvTMjJ4qdCNBKchaWCZw0vvdIeAJ7Ok
         OxaBw94pVYpa9o4oc23TziO/ZB3/XM7zgWb5E+xTcwnwudPpqvyDtjoAGZSYdpo1D2Pz
         +hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BihUlL7pe9cQd4pInGPlO7SSnqHExG5lq8bSrv6/Gw=;
        b=z8+nEP+nzYLfi2+dVuge28RHKUDTOPBJIRyJi1QZFvVOVgCBM/QAbl9zHcpgn2vifL
         Mon6Q2Ob2y6Lx1WHyaj/xY9jB6KzdXnGpofXad8kTgK/mQz8nkCdnmoqXG+61HuIeO2/
         nvJdjQQpBW6O57pTVV45JXOA0uWV7AFFiyBR8aC4Q20n3dedMuJBGTLm8XkVO8l9TuL0
         G+dPHaknzaz6aqKcms2/sXGa0aJv5oALgVhNgL/P5/FnXlLKV6mOJrn52YQggFg5dhop
         aw92WJ5A6k2XmdZNftpS9bOtf/ie8+rwNvW5fpi6zID2HoktejbDHonxJZ2wn+QNf6yr
         oOaA==
X-Gm-Message-State: AFqh2kpIWwOOmrPxCoKO9qtLEIDzA1mJep3qhZDhKrECPYJxThzaPSTt
        rmD6PPVUe/j58v3iR+qf2q/SpGSYI+BUZ2HjRTY=
X-Google-Smtp-Source: AMrXdXvzT1067kg9bEgLz+igkx8gTe9fQ9kycqgS5MPPCC4OO7hNdpVCO/BX0fBGW/SSrmxPUa8fwVmYysz/k4MEQR8=
X-Received: by 2002:a05:6512:241:b0:4cb:1fdb:ceb with SMTP id
 b1-20020a056512024100b004cb1fdb0cebmr2873573lfo.65.1673728022225; Sat, 14 Jan
 2023 12:27:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1463.git.1673584914.gitgitgadget@gmail.com>
 <26406a4d8797e68f0ba4fe097cf0973f60d67114.1673584914.git.gitgitgadget@gmail.com>
 <CAOLTT8RXgw0CC7TBUunCPnnk1=5gKkyYZcFQyWu29QM9bn9s9w@mail.gmail.com>
In-Reply-To: <CAOLTT8RXgw0CC7TBUunCPnnk1=5gKkyYZcFQyWu29QM9bn9s9w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 14 Jan 2023 12:26:50 -0800
Message-ID: <CABPp-BFFfDPT1x9E4bucuQnyVrWacego2agzyqjT7h+wQ=xpUg@mail.gmail.com>
Subject: Re: [PATCH 3/4] ls-files: clarify descriptions of status tags for -t
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 14, 2023 at 12:27 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2023=E5=
=B9=B41=E6=9C=8813=E6=97=A5=E5=91=A8=E4=BA=94 12:41=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > From: Elijah Newren <newren@gmail.com>
> >
> > Much like the file selection options we tweaked in the last commit, the
> > status tags printed with -t had descriptions that were easy to
> > misunderstand, and for many of the same reasons.  Clarify them.
> >
> > Also, while at it, remove the "semi-deprecated" comment for "git
> > ls-files -t".  The -t option was marked as semi-deprecated in 5bc0e247c=
4
> > ("Document ls-files -t as semi-obsolete.", 2010-07-28) because:
> >
> >     "git ls-files -t" is [...] badly documented, hence we point the
> >     users to superior alternatives.
> >     The feature is marked as "semi-obsolete" but not "scheduled for rem=
oval"
> >     since it's a plumbing command, scripts might use it, and Git testsu=
ite
> >     already uses it to test the state of the index.
> >
> > Marking it as obsolete because it was easily misunderstood, which I
> > think was primarily due to documentation problems, is one strategy, but
> > I think fixing the documentation is a better option.  Especially since
> > in the intervening time, "git ls-files -t" has become heavily used by
> > sparse-checkout users where the same confusion just doesn't apply.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/git-ls-files.txt | 28 +++++++++++++++-------------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> >
> > diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
> > index f89ab1bfc98..3886d58d178 100644
> > --- a/Documentation/git-ls-files.txt
> > +++ b/Documentation/git-ls-files.txt
> > @@ -137,25 +137,27 @@ OPTIONS
> >         with `-s` or `-u` options does not make any sense.
> >
> >  -t::
> > -       This feature is semi-deprecated. For scripting purpose,
> > -       linkgit:git-status[1] `--porcelain` and
> > +       Show status tags together with filenames.  Note that for
> > +       scripting purposes, linkgit:git-status[1] `--porcelain` and
> >         linkgit:git-diff-files[1] `--name-status` are almost always
> >         superior alternatives, and users should look at
> >         linkgit:git-status[1] `--short` or linkgit:git-diff[1]
> >         `--name-status` for more user-friendly alternatives.
> >  +
> >  --
> > -This option identifies the file status with the following tags (follow=
ed by
> > -a space) at the start of each line:
> > -
> > -       H::     cached
> > -       S::     skip-worktree
> > -       M::     unmerged
> > -       R::     removed/deleted
> > -       C::     modified/changed
> > -       K::     to be killed
> > -       ?::     other
> > -       U::     resolve-undo
> > +This option provides a reason for showing each filename, in the form
> > +of a status tag (which is followed by a space and then the filename).
> > +The status tags are all single characters from the following list:
> > +
> > +       H::     tracked file that is not either unmerged or skip-worktr=
ee
> > +       S::     tracked file that is skip-worktree
> > +       M::     tracked file that is unmerged
> > +       R::     tracked file with unstaged removal/deletion
> > +       C::     tracked file with unstaged modification/change
> > +       K::     untracked paths which are part of file/directory confli=
cts
> > +               which prevent checking out tracked files
> > +       ?::     untracked file
> > +       U::     file with resolve-undo information
> >  --
> >
>
> Good to see these tags describe are changed, especially "K" (reader
> don't know what is "to be killed")
>
> Maybe we should mention which option will output these tags?
> e.g. default -> "H"/"S" ,`--other` -> "?", `--modified` -> "C",
> `--killed` -> "K"...

We could, but...

  * It's H/S/M, not just H/S that is shown by default.
  * It gets weird because other options aren't added to the default,
so if someone specifies "-m" then suddenly H/S/M go away...unless they
also specify "-c".

Trying to explain all that feels like we're getting close to repeating
the documentation of the individual options.  But maybe we could just
ignore everything around default behavior and find a way to be brief
such as with:

    Note that H, S, and M entries are shown with --cached; R entries
    are shown with --deleted, C entries are shown with --modified, K
    entries are shown with --killed, ? entries are shown with
    --others, and U entries are shown with --resolve-undo.

I'm not sure if I like the documentation better with or without this
added paragraph.  What do others think?
