Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0EAC433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 09:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiI3Jyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 05:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiI3Jyo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 05:54:44 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39D713DFF
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 02:54:41 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id k6so4222705vsc.8
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 02:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ORklsJj9tbwydFg6fnM91UgcUO+BUiGwZr22IfP37yw=;
        b=oNTh71rvW4aQlIe4MDtE6pbBJgnfoajqT6IK1ySSTHxC0bH0wESi6HTIjgYbvTo+z1
         lD9AyXnuGZlaC3nTE82n4Az3I7dO06FHnhNUxubJkThv/ognxVClH2S0n8v1IBM1nomq
         Z+Hv6qBmhc8ExdW5JuAGIZ/PSExy+w/iSvHfNGKpA6HZJUAvKmVcFiEkt13wsEPIGsiT
         hoivRsvsZGpHIfObudsVIoYoIVV0TLZfhhJO46zBnv+KdUE/mwQvMlo6ZN9Y/3/UqsAz
         f+HdDhUbkY/M6onzBYUzv9XMHJuSfrG9z3UdlOjt4lbpfn0pb0ukVV7cvFd/dY3amA3b
         IGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ORklsJj9tbwydFg6fnM91UgcUO+BUiGwZr22IfP37yw=;
        b=AtDYNFYvAzS5Gi7cvf+XVfqrgghaWk7MW1aCOPV4yIGTSehrQiSMbVmy3SX8jSgKFR
         TF5OiP6/AZ9ZhA0ZFlJHbqOZGDx2zJTq7yEx4LWp3irXV9NZGws41FS56/yqd3iESRtK
         OAKGTr+obChESgfswE8dpE6BHcnDIcRrr5Gpx+gXvaeivWrpd3gaAwduiHviXlYNsUqb
         BonJqLOTGpeMfvw0kKJDlVZ+1xOKYrDEmOf6kUQYLPusMlM5cgsOL+pWF5kOy99Da4xt
         uQ1B1uQljUEWe4YRTFqF8i6IGoaX5HNjh9tQZIMGCYwMcbkWZsdg7wUnsZ7MRFN/BX89
         euCA==
X-Gm-Message-State: ACrzQf1xaTaIK5JVICCZJAXMrAigRIYP7rrIVqQJ2qY9aqbczyTZ9b6v
        yemtOhYYGaGRGZGPDXM3cLDDyoZeqrrW2czKkrc=
X-Google-Smtp-Source: AMsMyM6kwPqNZMt2m2fVza+V48sLdvgvcYs9lBejkQl9yrelffMzjQLHxuhu4OmHdwPleuylQ+XsxyhX1QGoIc2y9PI=
X-Received: by 2002:a05:6102:2144:b0:39a:c0c7:6a with SMTP id
 h4-20020a056102214400b0039ac0c7006amr3791128vsg.52.1664531680602; Fri, 30 Sep
 2022 02:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
 <07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com> <CABPp-BEjVv1ASdQhXGh6KuDfPt_nhZpRO_Q0i1pCqrV2wVQ9yQ@mail.gmail.com>
In-Reply-To: <CABPp-BEjVv1ASdQhXGh6KuDfPt_nhZpRO_Q0i1pCqrV2wVQ9yQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 30 Sep 2022 17:54:28 +0800
Message-ID: <CAOLTT8T7V0oYpS5XMWbhRi75z7cSVTcWsK76BdwGXAYYh=skPQ@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout directions
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am not sure if these ideas are feasible.

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=B8=89 13:38=E5=86=99=E9=81=93=EF=BC=9A
>
> > > +People might also end up wanting behavior B due to complex inter-pro=
ject
> > > +dependencies.  The initial attempts to use sparse-checkouts usually
> > > +involve the directories you are directly interested in plus what tho=
se
> > > +directories depend upon within your repository.  But there's a monke=
y
> > > +wrench here: if you have integration tests, they invert the hierarch=
y:
> > > +to run integration tests, you need not only what you are interested =
in
> > > +and its dependencies, you also need everything that depends upon wha=
t
> > > +you are interested in or that depends upon one of your
> > > +dependencies...AND you need all the dependencies of that expanded gr=
oup.
> > > +That can easily change your sparse-checkout into a nearly dense one.
> >
> > In my experience, the downstream dependencies are checked via builds in
> > the cloud, though that doesn't help if they are source dependencies and
> > you make a breaking change to an API interface. This kind of problem is
> > absolutely one of system architecture and I don't know what Git can do
> > other than to acknowledge it and recommend good patterns.
>
> I was talking about (source) dependencies between
> modules/projects/whatever-you-want-to-call-the-subcomponents of your
> repository.  We have hundreds of modules, with various cross-module
> dependencies that evolve over time.
>
> I get the feeling from your description that your intra-repository
> dependencies between modules/projects/whatever are much more static
> for you than what we deal with.  (Which is a good thing; it'd be nice
> if ours were more static.)
>
> > In a properly-organized project, 95% of engineers in the project can ha=
ve
> > a small sparse-checkout, then 5% work on the common core that has these
> > downstream dependencies and require a large sparse-checkout definition.
>
> "In a properly-organized project"?  I'm unsure if this is an
> indictment of some of the repositories I deal with in reality (and to
> be fair, it might be a totally fair indictment), or if your statement
> is starting to cross into "No true scotsman" territory.  ;-)
>
> I would probably lean towards the former (we know it's more messy than
> it should be), but I'm a bit puzzled that you'd just brush aside my
> mention of integration tests.  We have people who want to run
> integration tests locally, even when only modifying a small area of
> the codebase.  These users are not doing cross-tree work, rather they
> are doing cross-tree testing in conjunction with their work.  Running
> such tests requires a build of the modules across the repository,
> which naively would push folks into a dense checkout...and really long
> local builds.  We want fast local builds, and sparse-checkouts help us
> achieve that...but it does mean we have to be clever about how we
> build in order to let these users run integration tests.  (And we have
> to make it easy for users to discover the relevant integration tests,
> and sometimes associated code components that depend on what they are
> changing, which is where behavior B comes in).
>
> > There's nothing Git can do to help those engineers that do cross-tree
> > work.
>
> I'm going to partially disagree with this, in part because of our
> experience with many inter-module dependencies that evolve over time.
> Folks can start on a certain module and begin refactoring.  Being
> aware that their changes will affect other areas of the code, the can
> do a search (e.g. "git grep --cached ..." to find cases outside their
> current sparse checkout), and then selectively unsparsify to get the
> relevant few dozen (or maybe even few hundred) modules added.  They
> aren't switching to a dense checkout, just a less sparse one.  When
> they are done, they may narrow their sparse specification again.  We
> have a number of users doing cross-tree work who are using
> sparse-checkouts, and who find it productive and say it still speeds
> up their local build/test cycles.
>
> So, I'd say that ensuring Git supports behavior B well in
> sparse-checkouts, is something Git can do to help out both some of the
> engineers doing cross-tree work, and some of the engineers that are
> doing cross-tree testing.
>
> (For full disclosure, we also have users doing cross-tree work using
> regular dense checkouts and I agree there's not a lot we can do to
> help them.)
>

Let me guess where the cross tree users using sparse-checkout are
getting their revenue from:

1. they don't have to download the entire repository of blobs at once
2. their working tree can be easily resized.
3. they could have something like sparse-index to optimize the performance
of git commands.

But it's still worth worrying about the size of the git repository blobs,
even if it's just only blobs in mono-repo's HEAD, that may also be too big
for the user's local area to handle.

Perhaps it would make more sense to place this integration testing work on
a remote server.

I am not sure if these ideas are feasible:

1. mount the large git repo on the server to local.
2. just ssh to a remote server to run integration tests.
3. use an external tool to run integration tests on the remote server.

>
> Anyway, we do not want the behavior of `--restrict` for these
> commands.  That would imply not providing conflicts to users for them
> to resolve unless they are contained within the sparse specification,
> which would clearly be broken.  We instead chose to write out files
> with conflicts regardless of whether they are outside the sparse
> specification.  This modified behavior I gave the name of
> `--restrict-unless-conflict`, but we don't need or want an actual
> command line flag for that.  I think the behavior should just remain
> hardcoded into these commands.
>
> (Note: these commands are among those that make me think
> --[no-]restrict or --[un]focus or whatever might not make sense as a
> git global option: `--restrict-unless-conflict` behavior is the
> default for these and in fact that only sensible option, I think.  If
> there's only one sensible option, no actual flag names are needed.)
>
> > The only thing I can think about is that the diffstat might want to sho=
w
> > the stats for the conflicted files, in which case that's an important
> > perspective on the distinction from --restrict.
>
> We only show the diffstat on a successful merge, so there's no
> diffstat to show if there are any conflicted files.
>

Sorry, I have some questions here: how does git merge know there are
no conflicts without downloading the blobs?

> > Perhaps something like "scope" would describe the set of things we care
> > about, but use a text mode:
> >
> >         --scope=3Dsparse  (--restrict)
> >         --scope=3Dall     (--no-restrict)
> >
> > But I'm notoriously bad at naming things.
>
> Yeah, me too.  Naming things is one of the two hard problems in
> computer science, right?  (The others being cache invalidation, and
> off-by-one errors.)
>
> However, in this case, your suggestion sounds pretty decent to me.
> I'll add it to the list for us to consider.
>

Agree.

Thanks,
--
ZheNing Hu
