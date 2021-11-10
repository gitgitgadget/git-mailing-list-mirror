Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B33C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 18:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C566113E
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 18:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhKJSYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 13:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhKJSX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 13:23:59 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FBBC061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 10:21:11 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x25-20020aa79199000000b0044caf0d1ba8so2459696pfa.1
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 10:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :content-transfer-encoding;
        bh=1GrcciWH+bOcHe9GqSz7t4TZ0BMU47k0UVf1e4u58HU=;
        b=TaQunplxoor+1I8NMyjRKJqDxpHu/JGwKTFiSYkoD4/uPSSGq03hnL4voNJ74s1xnF
         BvQ0TUftBqbI5BAkaUxesCoj59Y088VNvWkoRrf+ywo2qc2lvZryQ4fDsuKb8QsvQCxr
         OxVw+/Sgghq96sjYjJBdXUYdQzc8dAB1jUfKrn77Bwlzfdj1PvrSUZO7jRoq91w/JDL/
         ouVOJfTC/imft4SXPmqtTxTOfsgrg2yXnJD8owjny8/+v5rvvi4kCptdsfegiTp/IoCG
         khsA3S/Y0zS/WtVfhCopM36CrsZwE71l+8Pm3NKBcbLt/TJKqdeCjU5E4ZE8OZs8CtcK
         RGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:content-transfer-encoding;
        bh=1GrcciWH+bOcHe9GqSz7t4TZ0BMU47k0UVf1e4u58HU=;
        b=imDOYfgwS4w1EW71QTCMv7Q2SIvf4ZXG9vZMASjQV4rnHjwJUAw0IOa0m8dSDTXYm6
         uqhRgP7/mrlhgwdUUEIXI969EbncGKjNF4JWW6Z9cUNWxTr8vSuI3YJmabWep6/sRm6o
         F1JnDSg3C9sjeJA9jM9bNZaJrZkb9Wc8xhP4ScgjU5tMhjsc7zNOQoTsurK8rbt4qAxY
         jG8CXKJDqRa24uVItGixCn2xysNrjJB1oM/9pfxtVR0vB0d2a0/QXUaTIn3l75kQD6E0
         JatRM403r3fc+yz/ezLwHOpOoy8t7aBRHkizMOzvBQtK1Ovy7FW4cjlNuUhM7btSRbgT
         3Usg==
X-Gm-Message-State: AOAM533Ut4jgCGNOF4pK7oCnIFOhgcHDEV3AaE8uFrr8kK2VeAwMd0Vp
        9I1E6NdadKoIw7NnybS29dzRxyQxjjotWVXn9DfnSLxBJPBWs8T7n/ls0/sC5WZNJ4SVLYniMib
        bAPPtTiSg0zdzGjY3b8bTwjXOQQjdSY39ZwKOIzCiA6D6NYsQ3hrOaaB+jcFSQtQ=
X-Google-Smtp-Source: ABdhPJylcL7mxdnUf/voxeXwbDeP9bHlgUQcVRfCzazkZRjZHjv1TvLiwLy1MSJqWZzL2q0aB5S7vfV1C+GVrw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:e406:0:b0:49f:dc1c:f3e1 with SMTP id
 r6-20020a62e406000000b0049fdc1cf3e1mr1168753pfh.21.1636568470698; Wed, 10 Nov
 2021 10:21:10 -0800 (PST)
Date:   Wed, 10 Nov 2021 10:21:08 -0800
In-Reply-To: <kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lh7cjvpm3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC] Branches with --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I found some points that I should have given more attention to in the
RFC. I'd appreciate any and all feedback :)

Glen Choo <chooglen@google.com> writes:

> In a superproject-submodule relationship there is some ambiguity in what
> =E2=80=98checkout the branch `topic`=E2=80=99 should mean (does the submo=
dule use its
> topic branch, or the version recorded in the superproject=E2=80=99s gitli=
nk?).
> Our approach is to preserve existing semantics where reasonable - the
> ref name refers to the superproject=E2=80=99s ref, just as it does withou=
t
> --recurse-submodules.

Because a gitlink only contains a commit id, the submodule branch will
use a plain commit id as the branch point. This gives the correct ref,
but it gives no hints as to what the submodule branch should track.

The current thought process is to set up tracking using the ref name and
the submodule's config. Thus, a more complete description of

  git branch --recurse-submodules topic origin/main

is something like:

* for each repository, create the 'topic' branch where each 'topic'
  branch points to the version recorded in the superproject's
  'origin/main'
* for each repository, setup tracking for the 'topic' branch using the
  repository's own 'origin/main' as the branch point

Note that there is no guarantee that a submodule's 'origin/main' points
to the same commit as the superproject's 'origin/main', or if the
submodule's 'origin/main' even exists.=20

If tracking information cannot be setup, we will still create the
branch; we will only warn users when they run a command that requires
tracking information e.g. fetch or push.

> =3D=3D=3D Switching _from_ a branch `topic`, i.e. `git {switch,checkout}`
>
> Check `topic` if each submodule=E2=80=99s worktree is clean (except for
> gitlinks), and has one of the following checked out:
>
> * `topic`
> * the commit id in the superproject gitlink
>
> This allows the user to switch with a dirty worktree (with respect to
> the superproject). We consider this acceptable because the submodule
> commits are tracked by the submodule branch. This is helpful when a user
> needs to switch branches before they are ready to commit to the
> superproject.

Note that this is how git switch with submodules already works - users
can switch away from a dirty superproject worktree as long as the
submodule worktrees are not dirty. However, without branches, this is
perilous because a user could unintentionally switch away from their
submodule WIP and have no easy way of recovering their work.

The proposed UX solves this by making the WIP tracked by a branch by
default. If a user switches _away_ from their WIP 'topic' branch...

> =3D=3D=3D Switching _to_ a branch `topic`, i.e. `git {switch,checkout} to=
pic`
>
> Switch to `topic` in the superproject. Then in each submodule, switch to:
>
> * `topic`, if it exists
> * Otherwise, the commit id in the superproject gitlink (and warn the
>   user that HEAD is detached)
>
> If the submodule `topic` points to a different commit from the
> superproject gitlink, this will leave the superproject with a dirty
> worktree with respect to the gitlinks. This allows a user to recover
> work if they had previously switched _away from_ "topic".

they can still recover their WIP state by switching _back_ to their WIP
'topic' branch.
