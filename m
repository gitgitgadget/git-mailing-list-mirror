Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761B2C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 13:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245284AbiA1Nh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245248AbiA1Nh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 08:37:57 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15F6C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 05:37:56 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id m6so18485938ybc.9
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 05:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdmCfmiA3B2WBv4/hxhKYS3vS1PRXmznEyAmWZ82n2M=;
        b=LjKGaCLFE3LuqitSqD3Qnv0Q7icbftp4B8/I0p8ukdYyngZPwAgBoDE7vxBfmt++hC
         VPT+RlYjIF+RIWIZYlC9c159sYhEeFLyKSFRvN43/L43hT1wAb8OYChv53eXOopg3RfK
         SHKYY2F7sJ5Ljd+haS1woTOU5N9CNbxy8tJQB9TlrIKdVXVoH3ha+rcXGffboF3OJIaZ
         8dxjwSqjtlvaH/i6m1fuBa73IPqF2p0WSSU4IRtBeYGixtuRzj+KzO6uIBC3D2gbMrBa
         pU444lOe+LYOcvfzGilfFFfuLPurIn4/5zWo2bsQP9xSuJzhl649Ow8nSFeIZJOB2222
         83Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdmCfmiA3B2WBv4/hxhKYS3vS1PRXmznEyAmWZ82n2M=;
        b=WWQf8UJQff7jk73kHGnbnOgcDIVW+sPBlHR6VYDYgtn9op1jMOiGmDyqGfJXOBH8b0
         gkbhCGSpNn8rVKYJukVkBfBeFHxRFu5mBHovSHqSDRgBcZXmZ75OLNyN64bxZNkht/az
         LJ0AlZB61Xk8sAHJoSGVgiY2WpRNcER3zTIC6Q5tces4T7kmLsfk9CDdh7GyWwraw6md
         KEAE4fUbR4hsB9Ca88YkyF3lRMUb2eAl97NUTdg0TjIjXdYwAoc01Uf9athXHv4NxqZn
         wMGrWHT9zGz07pVHupRR5dzQqSvTtQ+Y4yhiwmu/4y3P0Y+iebcW+x26Tc9kwSFURFWp
         7n/w==
X-Gm-Message-State: AOAM530bKv2IMv6SxdikyN37PZWQcaXHoR+j2ThCBVXcJ3PrPEnQsRlk
        sdUFK5acpLCN692Vcb9Ft6uwl2NyTJehuube7090/45f3vo=
X-Google-Smtp-Source: ABdhPJy8lITPWwJNz5sgGvwhMAvP0piTnpbo7NXu5Ky5TqYa7cHu6drQtzv4QxSLV225YlX1gcVw1ZDFIVATW2aMbjA=
X-Received: by 2002:a25:b296:: with SMTP id k22mr13019270ybj.50.1643377075928;
 Fri, 28 Jan 2022 05:37:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <CAP8UFD1-=RDx5=JpHEp=sFEOWr2MP-YovOPE7aTydrPLoVGa5w@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201261250380.6842@tvgsbejvaqbjf.bet> <CAP8UFD2qFmZ2Adk71SQw9xtq5keZ=d2hcMwF=fs9OtW4==0ZYg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201281343360.347@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201281343360.347@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 28 Jan 2022 14:37:44 +0100
Message-ID: <CAP8UFD1iJs0iGe430_Y=S6_nadS8AfBr_w0MuX-0H4ObcwDNdg@mail.gmail.com>
Subject: Re: [PATCH 00/12] RFC: In-core git merge-tree ("Server side merges")
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Fri, Jan 28, 2022 at 1:58 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Christian,
>
> On Wed, 26 Jan 2022, Christian Couder wrote:
>
> > On Wed, Jan 26, 2022 at 1:03 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Wed, 26 Jan 2022, Christian Couder wrote:
> > >
> > > > The reason is that I think in many cases when there are conflicts,
> > > > the conflicts will be small and the user will want to see them. So
> > > > it would be simpler to just have an option to show any conflict
> > > > right away, rather than have the user launch another command (a
> > > > diff-tree against which tree and with which options?).
> > >
> > > That assumes that server-side merge UIs will present merge conflicts in
> > > the form of diffs containing merge conflict markers. Which I don't think
> > > will happen, like, ever.
> >
> > Please take a look at:
> >
> > https://docs.gitlab.com/ee/user/project/merge_requests/conflicts.html#resolve-conflicts-in-the-inline-editor
> >
> > As you can see in the image there are conflict markers in the file
> > displayed by the server UI.
>
> Please note the difference between what I wrote above (present merge
> conflicts in the form of diffs containing merge conflict markers) and what
> is shown in the document you linked to (present a file annotated with
> merge conflict markers).
>
> There is no diff in that page.

The server UI could just get a diff with the conflicts inside instead
of the full files with conflict inside, as the diff would be smaller
to parse than the full files. So even if it's not shown, the diff
could still be useful.

Also just above the section of the link I sent, there is this section

https://docs.gitlab.com/ee/user/project/merge_requests/conflicts.html#resolve-conflicts-in-interactive-mode

where one can see diff markers in the image. There are no conflict
markers in those images, but it's possible that a future UI could
combine both a diff and conflict markers.

Also please note that I don't absolutely require diffs. At the
beginning of the paragraph from my original email that you quoted
above, there was:

"It's not a big issue for me to not include them right now as long as
it's possible to add cli options later that add them."

So I was just saying that the format and code should be flexible
enough to be able to easily accommodate sending further data like
diffs with additional options. I think it's a very reasonable request.
So please don't make it a huge issue. You can always NACK a patch
adding such an option later.

> What's more: there are not only conflict markers in the editor,

You don't see the ">>>>>>>"?

> there is
> clearly a visual marker next to the line number that indicates that the
> editor has a fundamental understanding where the conflict markers are.

Yeah, so this shows that those markers can be important for the editor.

> Which means that the conflict markers must have been generated
> independently of Git rather than parsed in some random diff that was
> produced by Git.

Why couldn't they be generated by Git and then just parsed from a diff
in the future, even if that was not the case here?

> In other words: you are making my case for me that `git merge-tree` should
> not generate diff output because it would not even be used.

The other link above in this email actually shows that diffs are used
right now to resolve conflicts.

> > > In short: I completely disagree that we should introduce a new command,
> > > and I also completely disagree that the `merge-tree` command should output
> > > any diffs.
> > >
> > > I do agree that we need to be mindful of what we actually need, and in
> > > that regard, I reiterate that we need to let concrete use cases guide us.
> > > As part of GitLab, you might be in an excellent position to look at
> > > GitLab's concrete server-side needs when it comes to use `git merge-tree`
> > > to perform merges.
> >
> > I hope I provided a concrete use case with the link above.
>
> Sorry, I apparently was a bit unclear.
>
> In the context of discussing `git merge-tree`, a low-level Git command,
> when I talk about a user, I do not mean a human being, but a program that
> calls that command and parses its output.

So it could very well parse diffs containing conflict markers and show
those conflict markers.

[...]

> Of course, I am still left guessing what the server-side needs concretely,
> because that is not at all obvious from the user-facing web site to which
> you sent me. What is needed is a good, hard look at the actual _code_, the
> code that calls into libgit2 to perform a merge, and that could instead
> spawn a `git merge-tree` process to accomplish the same thing.
>
> We need to get away from hypothetical scenarios. They're not helping.

I am not even asking for a feature, just to make it possible to extend
the output of a brand new command in an RFC with some possibly useful
things, and you are making such requests...

Please relax a bit on this.
