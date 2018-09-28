Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 186071F453
	for <e@80x24.org>; Fri, 28 Sep 2018 20:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeI2Csy (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 22:48:54 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46647 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeI2Csx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 22:48:53 -0400
Received: by mail-yb1-f195.google.com with SMTP id o8-v6so3174505ybk.13
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QvRagAZvA10DBg+UK+zGjYCvdzqhSq08OOIlUucYuw0=;
        b=RC3dS+Wh51iiVJQT2Y1QOEPX+dQlJ9qyCIkLq0pD/8AeL/Zm0nsmkIavbmsFCPtlfB
         0CO5sG8Erga1lmqkPz5tavti8+2cSwkLdL/ldqlWxzVORdfS5dv09aSWIselTuO6VHf8
         re5OXysiquqkeGxC+TdqnhqhA8GkLZGrG9n63y6x55BDel1mVYk2ZR8AYKScaBH/M4K9
         W0ejNhLzoPvZvec1eUqdXhUZw0Rw6nMEmTP1M8tYntY8+KsmgYPBScQTAOlBTb/yBQuV
         0jHuDpDfae9raEaDsfOHqDQuyBpLA6zYbwQTqX3skZxCfsoK59KeldKWkgU8vcP8BbQu
         be1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QvRagAZvA10DBg+UK+zGjYCvdzqhSq08OOIlUucYuw0=;
        b=QcVe0+IiQvVCTBIyzFyn9tpMCI2jidUPHjCvJyT+/x6r417BHqv2HoRrUoZhyzImov
         SFze54kFPRwBjAfghPp4T4du3vhwv8Nb5FzcyN0pECM4CyVPDcrXIPW6ARfEEcH8Q/Q1
         jEL/phFA/44ZLq/cMspzwo1QZ0uAc1AcsjZCVr3sinbH8JvUtJpnTO0npk31GMRMxduT
         ErPM+mCb5Be7N3cXckzgAGEnKWxnSKzcLE3aOCfE4ZF9pD9LqfEDV5r7KpkghQdQH0ml
         Jj/x0JAUghsifPb3Z0xtg05HekKH5wGTGYg39D54sJAej48YvVv5t9oM3qNBY5d0OwjF
         Jq1Q==
X-Gm-Message-State: ABuFfoheCkv/Gp4QjPcWzsu6KOMbeTQ3NnJQoPUGuEs5wf1ddAW84h/C
        nue5c2f1gclGCI++4HDecCkcXU+ouR1pRKh9c5mo9Q==
X-Google-Smtp-Source: ACcGV6186rjj9EarCOM2dpLjzMUtPwwi4WTLttFz7YYF/TVYe4RlSosEhGoq07BqVpK/rDffyRA4WVu/iIvYT01mPv0=
X-Received: by 2002:a25:8892:: with SMTP id d18-v6mr131324ybl.521.1538166210184;
 Fri, 28 Sep 2018 13:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180927221603.148025-1-sbeller@google.com> <87h8i9ift4.fsf@evledraar.gmail.com>
In-Reply-To: <87h8i9ift4.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 28 Sep 2018 13:23:18 -0700
Message-ID: <CAGZ79kbe=AabtXjVbzAa=HpEZwO=TjGLj6rrmE+-ng4JgQVWeA@mail.gmail.com>
Subject: Re: [PATCH] FYI / RFC: submodules: introduce repo-like workflow
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 12:26 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Sep 27 2018, Stefan Beller wrote:
>
> > Internally we have rolled out this as an experiment for
> > "submodules replacing the repo tool[1]". The repo tool is described as:
> >
> >     Repo unifies Git repositories when necessary, performs uploads to t=
he
> >     Gerrit revision control system, and automates parts of the Android
> >     development workflow. Repo is not meant to replace Git, only to mak=
e
> >     it easier to work with Git in the context of Android. The repo comm=
and
> >     is an executable Python script that you can put anywhere in your pa=
th.
> >
> >     In working with the Android source files, you use Repo for
> >     across-network operations. For example, with a single Repo command =
you
> >     can download files from multiple repositories into your local worki=
ng
> >     directory.
> >
> >     In most situations, you can use Git instead of Repo, or mix Repo an=
d
> >     Git commands to form complex commands.
> >
> > [1] https://source.android.com/setup/develop/
>
> Some questions just out of curiosity, not for this patch in particular:
>
> Those docs seem to describe the situation without this patch, with this
> patch is the repo tool fully replaced?

Yeah I started by describing the status quo. Some points to add:

* The repo UX looks very similar to perforce, as that was used internally
   at Google at the time a lot. Git wasn't around for long in the days of
   early Android. Now that Git is well known, new grads joining are more li=
kely
   to know Git than perforce.
* repo has no tests because it started as a small script
* maintenance/releases of repo are not ideal.

So yes, one of our long term goals is to replace repo with Git-only
(on the client side) workflow.

> How are you planning to migrate from repo to this on a repository-data
> basis

We don't plan to migrate the existing clients. You'd have to re-clone.

>, does gerrit also populate .gitmodules files appropriately, which
> your clone --recurse-submodules will pick up, but repo will just ignore,
> so you can use the two in parallel?

Gerrit has native support to update submodules in a superproject.
So if you submit code to a project that is a submodule of a superproject
the superproject updates its gitlink. (and if you use a topic based workflo=
w
to submit to two projects, it will show up as an atomic update in the
superproject by having just one commit updating two gitlinks)

Also Gerrit has a plugin "supermanifest" [1], which tracks repo
manifests and mirrors changes from the manifest into the
superproject, e.g. adding a new project to the manifest will
add a new submodule to the superproject.

[1] https://gerrit.googlesource.com/plugins/supermanifest/

With both Gerrits internal superproject subscription and that plugin
it should be possible to use repo or git-submodule in parallel (on an
organisational level, i.e. you choose one of them, and your coworker
chooses the other one)

> Now "repo init -u" takes a URL to a manifest of repositories to stitch
> together, I've understood from past conversations (but am not sure) that
> this is used e.g. by downstream Android vendors so they can use what
> Google's using + whatever they have in-house, i.e. make the manifest the
> set of open source repos plus some (e.g. drivers specific to their
> device). How is that sort of workflow going to work where you
> (presumably) have do that via .gitmodules + commit entries in trees?

The manifest is tracked in its own manifest repo, so today they fork
that project, with the superproject you'd fork the superproject and modify
the .gitmodules file as needed.

> They run their own Gerrit install with some magic to sync back & forth?
>
> I assume that now the recursive "checkout" relies on all the origin/HEAD
> symbolic refs pointing to "master", but how is this going to deal with
> incorporating a repo whose main branch has a different name?

Change the name? Or pin it via sha1.

> E.g. "trunk" or "blead"? Perhaps some interaction with
> checkout.defaultRemote + submodule.<name>.branch=3D<NAME> could make "git
> checkout :mainbranch" DWYM.
>
> > * Fetching changes ("repo sync") needs to fetch all repositories, as th=
ere
> >   is no central place that tracks what has changed. In a superproject
> >   git fetch can determine which submodules need fetching.  In Androids
> >   case the daily change is only in a few repositories (think 10s), so
> >   migrating to a superproject would save an order of magnitude in fetch
> >   traffic for daily updates of developers.
>
> Interesting that in all this time with the reliance on a central server
> repo wasn't already asking some custom API "what repos changed since xyz
> time" to narrow that down, but hey, .gitmodules + commit entries in
> trees will do it for you.

It's complicated. Shawn really grew to dislike the repo tool and wanted
to have it gone as quickly as possible, so no hacks that extend its life. ;=
-)
I would prefer to keep that stance as any hack in there would grow into
a nightmare down the road.

> > * Sometimes when the dependencies are not on a clear repository boundar=
y
> >   one would like to have git-bisect available across the different
> >   repositories, which repo cannot provide due to its design.
>
> I assume that you're not upgrading independently to e.g. every single
> linux commit, just stable releases, so does bisecting deal with knowing
> that e.g. a breakage occurred when linux.git was updated from v4.10 to
> v4.12, and then to go within the repo itself and bisect from there, or
> is that done manually?

We currently have no submodule support in bisect, but that is open to
future contribution. But with relations between submodules via the
superproject it is at least possible to bisect precisely, whereas in repo
the projects are unrelated to each other and it becomes a political
issue if A broke B or B broke A.

Thanks for taking time to read and think through the concept here,

Stefan
