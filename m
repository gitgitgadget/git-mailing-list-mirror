Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0910C54EBC
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 02:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjAICyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 21:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjAICyW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 21:54:22 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A9E1114F
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 18:54:20 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4c24993965eso90653347b3.12
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 18:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z28iaOPqIDSYd4owsnVj6i4FEuYNTm3pXvrp/sfEWHQ=;
        b=FNuiWM0uulzU10h2aXk0UubjL5q4KYNfDY7w0lvE8yWwZGy+u2cNdywgX+x70Xxefb
         UX8N2O9jy3jIC3Dhc5/Jux5KYg9SDBF0y3GdYdWeziWT5xxngA/PZmX8PkV5Z+McWrpj
         cjJpH1+/7dtTUkxK4haMYYbr69b+mgl0rL6BCVoaEUA8dz7Nz1oTMhmL/i7x69FuxJJH
         O0eOXbqOu46znT9KqG+gTbBnuwBKAXZbdGd6fdDY4OdyIO571YN/U3H7JEAYdjGd9E4A
         Z3/h5MfYk0nL3JF4kOfvBcOApsTAEcoxu+zNF4Y0zD+twFQPEqRyxyoe8EQbABZWhuz1
         P23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z28iaOPqIDSYd4owsnVj6i4FEuYNTm3pXvrp/sfEWHQ=;
        b=gOEM8Tim2p7Lh+QSPLxy1anzGois/MkmoWY/mZda/mKsQ8e0h1/FUqhlMBm04Z1t3r
         D0LKMV3pxLz9scpNNaNpKVjDIqleIndXUN+wiWMaVxSbPHgrs/w+t6/ZhgTBS21ERvrF
         wU0lqFB7dNAA87RWc9mEJyYCMt++3X1gi0zvFXySmmEu+wrvGg2pSxuvfXlxvF8kgsiX
         nYFjXYmjoGnDP5cGi0mLSMl6ncLTmz19jqLWkIEd4nEPIBqeNdjcQ5XcKiz21gGQCjZb
         GRPFrajW2SVwNMIJHIRrA0/ArIGqxfYwOHkQR6zWmbZUIHHgrF8heWsa+360gRHemEOS
         JjAg==
X-Gm-Message-State: AFqh2kof0XhX2SX7op4Iro8VM0QWj6nFsHnr3vZ/w2ZstSOmK/1sGJkT
        LduGjhQweX1D3SLG2O6eyBEpSKeqzeaKQnu6gAE=
X-Google-Smtp-Source: AMrXdXuyc0xlfHVuZhD/3EgL5B8KbrgyIVOYp6pLQlsp0ubHLKw5Ap0LGrOxbbJlNB8S2eIqWX0BAYfxRxXtIGQZIc4=
X-Received: by 2002:a05:690c:847:b0:391:7188:7454 with SMTP id
 bz7-20020a05690c084700b0039171887454mr523725ywb.212.1673232859922; Sun, 08
 Jan 2023 18:54:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1457.git.1673171924727.gitgitgadget@gmail.com>
 <CAC-j02O6z4sG85LpRNzEZ52Y-McurYDa_VnVXtqFVPBFu9kbug@mail.gmail.com> <CAPig+cS_dXL-Q6NZtUJxDOL4-Q=MJv8fPEPAnEPuONaNF8-sCA@mail.gmail.com>
In-Reply-To: <CAPig+cS_dXL-Q6NZtUJxDOL4-Q=MJv8fPEPAnEPuONaNF8-sCA@mail.gmail.com>
From:   Preston Tunnell Wilson <prestontunnellwilson@gmail.com>
Date:   Sun, 8 Jan 2023 20:54:09 -0600
Message-ID: <CAC-j02MV+Gv0D8-fpCOu7JGUimxPLF+OP1dy7bxfs7ArX05BYg@mail.gmail.com>
Subject: Re: [PATCH] githooks: discuss Git operations in foreign repositories
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> "Best-practice" is context
> sensitive. It may be best-practice when a hook needs to invoke Git
> commands in some other repository (or worktree), but clearing those
> variables automatically would, in some situations, break the much more
> common case of the hook invoking Git commands in the local repository
> (or worktree). The fact that those environment variables may have been
> set manually by the user or automatically by Git further complicates
> the situation.

That makes sense, thank you for your answer!

> So, no, I don't think this qualifies for the BUGS section of
> git-wortkree, and mentioning this potential gotcha only in
> git-worktree but not in any other hook-running command doesn't seem
> ideal either. At present, the best place to discuss it seems to be
> Documentation/githooks.txt, as this patch does.

I agree the best place to put it is in Documentation/githooks.txt. I
also agree the BUGS section doesn't make sense, but I'm still
wondering if we should call it out in git-worktree.txt in addition to
githooks.txt. When I ran into this issue, I tried to compare my setup
to that of my coworkers. The difference was that I was using
git-worktree, they were not. git-worktree's documentation lists:

Within a linked worktree, $GIT_DIR is set to point to this private
directory (e.g. /path/main/.git/worktrees/test-next in the example)
and $GIT_COMMON_DIR is set to point back to the main worktree=E2=80=99s
$GIT_DIR (e.g. /path/main/.git). These settings are made in a .git
file located at the top directory of the linked worktree.

To me, this is the "other side of the coin" of your patch. (Or maybe
one of the many other sides of the coin for commands that can run
git-hooks.) Mentioning a potential collision between git-hooks and
these variables being set could maybe go in the above snippet, maybe
in parentheses. It took a lot of working backwards to narrow the issue
to the interaction between git-worktree and git-hooks rather than the
package manager I was using or the tool the hook was calling. Putting
a note in the git-worktree documentation (in addition to the note in
git-hooks) might help out someone in the future, but I defer to your
judgement. If it doesn't make sense, doesn't fit, or adding it here
would detract and make the documentation more confusing, I am happy to
leave it out.

And thank you for the administrivia!

On Sun, Jan 8, 2023 at 5:25 PM Eric Sunshine <sunshine@sunshineco.com> wrot=
e:
>
> [administrivia: please reply inline rather than top-posting]
>
> On Sun, Jan 8, 2023 at 2:45 PM Preston Tunnell Wilson
> <prestontunnellwilson@gmail.com> wrote:
> > Thank you for this wonderful remedy, Eric! I really appreciate the
> > background context and how you framed the problem that I ran into.
> >
> > I have two questions:
> > 1. Documentation is a great first step in addressing this, but I'm
> > wondering if this should be automatic? If this is a best practice for
> > hook authors, could `git` do this for them automatically when running
> > hooks?
>
> For the general case, probably not. "Best-practice" is context
> sensitive. It may be best-practice when a hook needs to invoke Git
> commands in some other repository (or worktree), but clearing those
> variables automatically would, in some situations, break the much more
> common case of the hook invoking Git commands in the local repository
> (or worktree). The fact that those environment variables may have been
> set manually by the user or automatically by Git further complicates
> the situation.
>
> > 2. Should we add something in the `git-worktree` documentation? In
> > `Documentation/git-worktree.txt`, it mentions:
> >
> > > BUGS
> > > ----
> > > Multiple checkout in general is still experimental, and the support
> > > for submodules is incomplete. ...
> >
> > Would it be helpful to plant a flag in the above documentation to
> > point to this potential issue?
>
> As noted above, we can't really call this a bug. Git is behaving as
> intended. Whether the user set the variables manually or whether some
> parent Git process set them automatically, the child Git respects the
> variables as it should rather than second-guessing about the user's
> intentions, and possibly guessing incorrectly.
>
> So, no, I don't think this qualifies for the BUGS section of
> git-wortkree, and mentioning this potential gotcha only in
> git-worktree but not in any other hook-running command doesn't seem
> ideal either. At present, the best place to discuss it seems to be
> Documentation/githooks.txt, as this patch does. It may be possible to
> argue that gitfaq.txt could talk about it, but considering that this
> issue can manifest in many different ways (various error messages or
> misbehaviors), it's difficult to come up with any text for the "Q"
> which people would be likely to find when Googling. That's not to say
> it shouldn't be mentioned elsewhere in the documentation, but rather
> that I haven't come up with any better places than githooks.txt
> itself.
