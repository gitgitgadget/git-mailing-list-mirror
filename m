Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49484C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 16:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiBPQV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:21:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiBPQV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 11:21:58 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9563A24BD7
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:21:44 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y17so4769373edd.10
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3xpsphWzBiHjLVFrqUYg8uJ+kG/+O4TgZa0/+8m7W9I=;
        b=nwecZA+azZq9T+2v4NAE94ixUmCYZmAgDQfrxxgBWX79SqG4ukaeU+5XxjYcuKkU5p
         S6sZiuI0JiDHHLXZ+2uUiyrcJTfKDb98nbQykqkKrbZF36dM4dxMdgVM4LKIXceh2RJd
         H42vc8ug/Cd5DEGDKxSfNofSIunXbld7WatmXxV4m8KkApyiEwxTxVeqpo5gr3AywOqH
         XvgAY48wUMHL9Eh0jwXOZzS0ZS0rOXIL34PeGMIycqzj3lYJgJbZNLTSAuyz3LE6wuvg
         SXyxOvlxLbgOrYJudWWAS80mi+9EdRjdLl7MOvsuP40jbgRDAKs5/ooXGBk+bsbyJloC
         UBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3xpsphWzBiHjLVFrqUYg8uJ+kG/+O4TgZa0/+8m7W9I=;
        b=mrhfRjpvbuLuaNFm4UnjLCgSLiFLGBmB9vDQeKni+1kkEqN/XCb6xGWZwcDrbqOxuT
         OqR1fLpeFiUgDiiTqkaxsEcmxakiDYsll5gGsG6YIlmkNXEG/GWUXIXgdPjCIHpQHPT6
         wagE6FwqVWXMGOeFYX+KNnqXFalJ53DbWhkUgH9bM6JtmodzAHKsDXPOD1d2M48G1TRO
         dhJWsC+kkYPtbEf1rO+oSQeuiBq7DyEtXvwLDuCUxgR2CGpZKEfk5MY+nqYadfp8J7pY
         fXaYh7SYiNx5z2/+KXcWpMbQE3ZReKfIoeeQwt/E0qFJ3XFYHKfB+NM4GwtWbWG7qrcE
         EOeg==
X-Gm-Message-State: AOAM533nHs4krGwbq8btGBF8+ZzLmWOK+W5nsSU3g+IlhL/g9UCRwg9W
        fi/WBTcKLoJHlL3XOKCZMUqzyAmMLFIEjSArD9o=
X-Google-Smtp-Source: ABdhPJy36ceV6+1Z+vsWbKawxwD7PPeWK8a01BtEH6Ewf6KjixiuETYTPplMc5v65ZIv39HrRI6Q1OsNZa46Dtn/RN0=
X-Received: by 2002:aa7:cb0e:0:b0:410:ba25:79ee with SMTP id
 s14-20020aa7cb0e000000b00410ba2579eemr3872890edt.380.1645028503121; Wed, 16
 Feb 2022 08:21:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com> <0af00779128e594aff0ee4ec5378addeac8e88a2.1642175983.git.gitgitgadget@gmail.com>
 <220216.86k0dvupv7.gmgdl@evledraar.gmail.com>
In-Reply-To: <220216.86k0dvupv7.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 08:21:31 -0800
Message-ID: <CABPp-BF2d81f0va7x7fpEAFqJtjBgEr-UBY4QCAxrnjoFmdZ3g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] Update documentation related to sparsity and the
 skip-worktree bit
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 1:23 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Jan 14 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Make several small updates, to address a few documentation issues
> > I spotted:
> >   * sparse-checkout focused on "patterns" even though the inputs (and
> >     outputs in the case of `list`) are directories in cone-mode
> >   * The description section of the sparse-checkout documentation
> >     was a bit sparse (no pun intended), and focused more on internal
> >     mechanics rather than end user usage.  This made sense in the
> >     early days when the command was even more experimental, but let's
> >     adjust a bit to try to make it more approachable to end users who
> >     may want to consider using it.  Keep the scary backward
> >     compatibility warning, though; we're still hard at work trying to
> >     fix up commands to behave reasonably in sparse checkouts.
> >   * both read-tree and update-index tried to describe how to use the
> >     skip-worktree bit, but both predated the sparse-checkout command.
> >     The sparse-checkout command is a far easier mechanism to use and
> >     for users trying to reduce the size of their working tree, we
> >     should recommend users to look at it instead.
> >   * The update-index documentation pointed out that assume-unchanged
> >     and skip-worktree sounded similar but had different purposes.
> >     However, it made no attempt to explain the differences, only to
> >     point out that they were different.  Explain the differences.
> >   * The update-index documentation focused much more on (internal?)
> >     implementation details than on end-user usage.  Try to explain
> >     its purpose better for users of update-index, rather than
> >     fellow developers trying to work with the SKIP_WORKTREE bit.
> >   * Clarify that when core.sparseCheckout=3Dtrue, we treat a file's
> >     presence in the working tree as being an override to the
> >     SKIP_WORKTREE bit (i.e. in sparse checkouts when the file is
> >     present we ignore the SKIP_WORKTREE bit).
> >
> > Note that this commit, like many touching documentation, is best viewed
> > with the `--color-words` option to diff/log.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/git-read-tree.txt       | 12 +++--
> >  Documentation/git-sparse-checkout.txt | 76 ++++++++++++++++-----------
> >  Documentation/git-update-index.txt    | 57 +++++++++++++++-----
> >  3 files changed, 98 insertions(+), 47 deletions(-)
> >
> > diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-t=
ree.txt
> > index 8c3aceb8324..99bb387134d 100644
> > --- a/Documentation/git-read-tree.txt
> > +++ b/Documentation/git-read-tree.txt
> > @@ -375,9 +375,14 @@ have finished your work-in-progress), attempt the =
merge again.
> >  SPARSE CHECKOUT
> >  ---------------
> >
> > +Note: The `update-index` and `read-tree` primitives for supporting the
> > +skip-worktree bit predated the introduction of
> > +linkgit:git-sparse-checkout[1].  Users are encouraged to use
> > +`sparse-checkout` in preference to these low-level primitives.
>
> I was honestly a bit confused about whether we were really referring to
> the git-update-index and git-read-tree commands here, or some
> sparse-checkout (re-)usage of the same as "primitives"

Neither, really.

>, but reading it
> again & the commit message we're just talking about the commands here.

I was trying to talk about just the small building blocks found in
git-update-index and git-read-tree commands that relate to sparse
checkouts (i.e. the --[no-]skip-worktree and
--[no-]ignore-skip-worktree-entries options to git-update-index, and
the ability to update the working tree according to
$GITDIR/info/sprse-checkout buried in `git read-tree -mu HEAD`).

> So this really just wants to assure readers that they're advised to use
> the shiny porcelain command instead of the plumbing.
>
> I think we should refer to these as e.g. "linkgit:git-update-index[1]"
> not "`update-index`" here, and call them e.g. "plumbing commands"
> instead of "primitives" here, which will address that (the reader
> wonders "what's a primitive?").

Perhaps:

Note: The skip-worktree capabilities in linkgit:git-update-index[1]
and `read-tree` predated the introduction of
linkgit:git-sparse-checkout[1].  Users are encouraged to use the
`sparse-checkout` command in preference to these plumbing commands for
sparse-checkout/skip-worktree related needs.

?

>
> > -Initialize and modify the sparse-checkout configuration, which reduces
> > -the checkout to a set of paths given by a list of patterns.
> > +This command is used to create sparse checkouts, which means that it
> > +changes the working tree from having all tracked files present, to onl=
y
> > +have a subset of them.  It can also switch which subset of files are
> > +present, or undo and go back to having all tracked files present in th=
e
> > +working copy.
>
> In terms of prose I think it's preferred to keep matter-of-fact "Slices
> and dices apples, making them easier to eat" instead of "This command
> slices and dices apples, which means that it's easier to eat them".
>
> I've forgotten what the linguisting term for that is, but it's more
> consistent with our docs, and makes for easier reading.

So, s/means that it changes/change/ ?

> > +The subset of files is chosen by providing a list of directories in
> > +cone mode (which is recommended), or by providing a list of patterns
> > +in non-cone mode.
>
> As someone with light familiarity with sparse-checkout:
>
> I'm still not sure if this is telling me that it's preferred to list
> directories v.s. patterns, or if it's telling me it's better to operate
> in "cone mode" v.s. "non-cone mode", or some combination of the two.
>
> IOW I think peeling out that "(which is recommended)" and making it
> clearly refer to which (or both?) of the two we're talking about would
> be much better.

Much easier to fix when I resubmit the patch to change the default for
sparse-checkout to cone mode (i.e. when I resubmit
https://lore.kernel.org/git/e30119b96dfaf9fdb82039cab84f8b81caacc1de.164471=
2798.git.gitgitgadget@gmail.com/).
I can include the above changes too.

> > +When in a sparse-checkout, other Git commands behave a bit differently=
.
> > +For example, switching branches will not update paths outside the
> > +sparse-checkout directories/patterns, and `git commit -a` will not rec=
ord
> > +paths outside the sparse-checkout directories/patterns as deleted.
>
> (I didn't read through the rest in any detail)
