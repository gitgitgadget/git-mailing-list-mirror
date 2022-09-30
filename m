Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440CBC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 09:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiI3JJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 05:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiI3JJz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 05:09:55 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2942D1FC
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 02:09:53 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id b7so1474864uas.2
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=z/jx6yyXsnWQethcbXVThvEADOXwFvRlwemDwvRi2NI=;
        b=oycrvNibeh/H62CGc47cr/bD8ZajzCwq2h0nz8eg9+kPK8JLJ5GPL1ekr4fh985vbT
         iOLK9zusiVSJL7EZT9gd7LVf295w4Wyy7cjCneNsE8J/6X2zvJbiWFALbwXHHHMcGE7K
         PUWEywI+g142EYTpr4CSNT/otIzoNeE0rpgrIyFyIPhkBw0gL8JZ/OoUQaVEdegGFOWI
         eUZiIMhRajd0IjtgjTrvuNblyP6ir4qFEulWStOoP306hNCHrDjcU3A1u+eTNWPC2s6a
         vbl3g1z7BzoQQg6foHk9Xmz4CDVNn5pQk5MdDIda84R/MBk27CwXNyRCNye1v0gicAGe
         9c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=z/jx6yyXsnWQethcbXVThvEADOXwFvRlwemDwvRi2NI=;
        b=o7Au3mMoIe6z4rLEjuY2FSOQuHhLvprrgQ2+6l2SPrDz3X0vC0UgCzlDCjV+rRoQeA
         GhowyMvSlHOf6k6QjzLwdf6f7ti3db/2Lxvq8r2yHq5Z5v1XEoCYaw/4NHlvBbCzSQGP
         coREyeKQLRKgogLYTAPRxFtceG9Lm1D5TjzAs0YRsu3fHSx8rzGDjYuVMT9VmZDbSpBy
         o/Hv00907kpSZkDxDYi9MgLGSAV3eMm04Icht408vOB20XrQ/lt2nKpBI9DICHJLVp4e
         ojXBNgJkx7md84F1MLrDK57nOq0XJVq8ciTiETjZwLXviwg6PpcmH5Hu0Jlax6Yl3NxQ
         DViA==
X-Gm-Message-State: ACrzQf3czjcmDbTF9Do5RLBds1OtSfvWIDhMkQ3V06k+YWCR+4BeVk8Z
        maSQzQbCMWlyV2OAlmPFOzPvHe0Re60VOJ0ZOIc=
X-Google-Smtp-Source: AMsMyM4s9qKCeiND0HQZGjsgylbn8eGifdk3LZTy03QkiCsqPxuMeMhwcdtTZnIi/3Y5lKqk9Z64xBLUtjPHLUmFE3A=
X-Received: by 2002:ab0:802:0:b0:3d5:9cc8:3578 with SMTP id
 a2-20020ab00802000000b003d59cc83578mr1866004uaf.33.1664528992453; Fri, 30 Sep
 2022 02:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com> <07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com>
In-Reply-To: <07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 30 Sep 2022 17:09:40 +0800
Message-ID: <CAOLTT8SyszDCSsDbCMqsQLtXSyLOKMKNn9qRZRKSjAVVQB=jLQ@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout directions
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=882=
8=E6=97=A5=E5=91=A8=E4=B8=89 00:36=E5=86=99=E9=81=93=EF=BC=9A
>
> > +Some of these users also arrive at this usecase from wanting to use
> > +partial clones together with sparse checkouts and do disconnected
> > +development.  Not only do these users generally not care about other
> > +parts of the repository, but consider it a blocker for Git commands to
> > +try to operate on those.  If commands attempt to access paths in histo=
ry
> > +outside the sparsity specification, then the partial clone will attemp=
t
> > +to download additional blobs on demand, fail, and then fail the user's
> > +command.  (This may be unavoidable in some cases, e.g. when `git merge=
`
> > +has non-trivial changes to reconcile outside the sparsity path, but we
> > +should limit how often users are forced to connect to the network.)
>
> This idea pairs well with a feature I've been meaning to build:
> 'git sparse-checkout backfill' would download all historical blobs
> within the sparse-checkout definition. This is possible with rev-list,
> but I want to investigate grouping blobs by path and making requests in
> batches, hopefully allowing better deltification and ability to recover
> from network disconnections. That makes this idea of "staying within
> your sparse-checkout means no missing object downloads" even more likely.
>

I think this is very useful: if I use sparse-checkout + partial-clone,
plugins like
git blame in vscode (or other IDE) will be invalidated, or require a
lot of network
overhead to download the missing blobs, so this git sparse-checkout backfil=
l
looks like a promising solution to that problem.

> > +People might also end up wanting behavior B due to complex inter-proje=
ct
> > +dependencies.  The initial attempts to use sparse-checkouts usually
> > +involve the directories you are directly interested in plus what those
> > +directories depend upon within your repository.  But there's a monkey
> > +wrench here: if you have integration tests, they invert the hierarchy:
> > +to run integration tests, you need not only what you are interested in
> > +and its dependencies, you also need everything that depends upon what
> > +you are interested in or that depends upon one of your
> > +dependencies...AND you need all the dependencies of that expanded grou=
p.
> > +That can easily change your sparse-checkout into a nearly dense one.
>
> In my experience, the downstream dependencies are checked via builds in
> the cloud, though that doesn't help if they are source dependencies and
> you make a breaking change to an API interface. This kind of problem is
> absolutely one of system architecture and I don't know what Git can do
> other than to acknowledge it and recommend good patterns.
>
> In a properly-organized project, 95% of engineers in the project can have
> a small sparse-checkout, then 5% work on the common core that has these
> downstream dependencies and require a large sparse-checkout definition.
> There's nothing Git can do to help those engineers that do cross-tree
> work.
>

This feels like it's because your project code is stable enough, but at oth=
er
companies I think many of the project dependencies are subject to frequent
changes.

> > +      * `git mv` has similar surprises when moving into or out of the =
cone, so
> > +     best to restrict and throw warnings if restriction might affect t=
he result.
> > +
> > +    There may be a difference in here between behavior A and behavior =
B.
> > +    For behavior A, we probably only want to warn if there were no
> > +    suitable matches for files in the sparsity specification, whereas
> > +    for behavior B, we may want to warn even if there are valid files =
to
> > +    operate on if the result would have been different under
> > +    `--no-restrict`.
>
> I think in behavior B, users who actually want to modify things tree-wide=
 will
> actually increase their sparse-checkout definition to include those files=
 so
> they can validate what they are doing.
>

Agree.

> > +=3D=3D=3D Implementation Questions =3D=3D=3D
> > +
> > +  * Does the name --[no-]restrict sound good to others?  Are there bet=
ter options?
> > +    * Names in use, or appearing in patches, or previously suggested:
> > +      * --sparse/--dense
> > +      * --ignore-skip-worktree-bits
> > +      * --ignore-skip-worktree-entries
> > +      * --ignore-sparsity
> > +      * --[no-]restrict-to-sparse-paths
> > +      * --full-tree/--sparse-tree
> > +      * --[no-]restrict
>
> I like the simplicity of --[no-]restrict, and my only worry is that it
> doesn't immediately link to what it is restricting.
>
> Perhaps something like "scope" would describe the set of things we care
> about, but use a text mode:
>
>         --scope=3Dsparse  (--restrict)
>         --scope=3Dall     (--no-restrict)
>
> But I'm notoriously bad at naming things.
>
> > +  * Should --[no-]restrict be a git global option, or added as options=
 to each
> > +    relevant command?  (Does that make sense given the multitude of di=
fferent
> > +    default behaviors we have for different options?)
>
> If we can make it a global option, that would be great, then update
> the commands to behave under that mode as we go.
>
> If that doesn't work, then adding the consistent option across commands
> would be helpful. It might be good to make a OPT_RESTRICT macro (much
> like OPT__VERBOSE, OPT__QUIET, and similar macros.
>
> > +  * Should --sparse in ls-files be made an alias for --restrict?
> > +    `--restrict` is certainly a near synonym in cone-mode, but even th=
en
> > +    it's not quite the same.  In non-cone mode, ls-files' `--sparse`
> > +    option has no effect, and in cone-mode it still shows the sparse
> > +    directory entries which are technically outside the sparsity
> > +    specification.
>
> We should definitely replace the --sparse option(s) with whatever we
> choose here. For ls-files, we have the issue that we are reporting
> what is in the index, and in non-cone-mode the index cannot be sparse.
>
> Now, maybe we change what the ls-files mode does under --restrict and
> only have it report the paths within the sparse-checkout and not even
> show the results for sparse directory entries. The --no-restrict would
> then expand a sparse-index to show only paths again.
>

> > +    Namely, if folks are not already in a sparse checkout, then requir=
e
> > +    `sparse-checkout init/set` to take a `--[no-]restrict` flag (which
> > +    would set core.restrictToSparse according to the setting given), a=
nd
> > +    throw an error if the flag is not provided?  That error would be a
> > +    great place to warn folks that the default may change in the futur=
e,
> > +    and get them used to specifying what they want so that the eventua=
l
> > +    default switch is seamless for them.
>
> I don't like using the same option name (--[no-]restrict) for something
> that sets a config option to keep that behavior permanently. Different
> names that make it clearer could be:
>
>         --enable-restrict-mode
>         --set-scope=3D(sparse|all)
>

The name sounds clear enough. I had a idea that add some configuration like=
:

scope.<cmd>.mode=3Dsparse|all

and then let scalar help users set some default configs...

> > +  * clone: should we provide some mechanism for tying partial clones a=
nd
> > +    sparse checkouts together better.  Maybe an option
> > +     --sparse=3Ddir1,dir2,...,dirN
> > +    which:
> > +       * Does initial fetch with `--filter=3Dblob:none`
> > +       * Does the `sparse-checkout set --cone dir1 dir2 ... dirN` thin=
g
> > +       * Runs a `git rev-list --objects --all -- dir1 dir2 ... dirN` t=
o
> > +      fault in the missing blobs within the sparse
> > +      specification...except that rev-list needs some kind of options
> > +      to also get files from leading directories too.
> > +       * Sets --restrict mode to allow focusing on the cone of interes=
t
> > +      (and to permit disconnected development)
>
> As mentioned, I think we should have the option to backfill the blobs in
> the sparse-checkout definition, but 'git clone' should not do this by
> default. It's something that can be launched in the background, maybe, bu=
t
> not a blocking operation on being able to use the repository.
>
> 'scalar clone' is an excellent testing bed for these kinds of things,
> like setting the --restrict mode by default.
>

This sounds interesting and would like to see scalar support them!

> Hopefully my responses aren't too far off-base. I'll go read the rest of
> the discussion now that I've contributed my thoughts on the doc.
>
> Thanks,
> -Stolee

Thanks,
--
ZheNing Hu
