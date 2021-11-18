Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E41C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 05:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CBC61AA9
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 05:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhKRFGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 00:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhKRFG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 00:06:28 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1E2C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 21:03:28 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u3so19788125lfl.2
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 21:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mDuL04b+08cciqX/E//D3ZLYQighNq1XDY5KvDqWI6c=;
        b=MNzWRKi294VVEMz+EzQaMxf/pXyIeBPuFJhd1LN1EaovfeRt9jF5afCyCKXtRhSMQn
         S8K1yElO1srzyNNW6MGoHI7zFxlvZ1xgCv9uO7dWEDMgYVN+f41bms5jqBnPJ1deXWnp
         K+ORn6ayhTs2jnMWUOjxE22DbEvXffA7my8Ci1wlH8YpbW4Yl7vpYzEvkS9U2Vc6Xw4c
         B7TDFrQcj3A0Xrqwu0SOveBFnioKuzjh4Gj0jDmIviXlqWo8oZ9OhSP7j2Vw8qd3Y9yF
         RBYxiCCp+bQkKliJjMDEFnb0G/GzyrB2ACOH5CNa9gszoJsweqG0Gcl+jND9mG4+xHeE
         AH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mDuL04b+08cciqX/E//D3ZLYQighNq1XDY5KvDqWI6c=;
        b=pwYYL9cSRCIy+Hvf+ZGUmN2c1AAdxOcFzYU43GBBje/fkfxXGLejncVltOwOjxv8UI
         TOoeFGOO9+FDdtK/+vHbAUC7NxHjvwh2KA/XKzh5G8HuVZhehPfUvvUyn4JWVKG0EgzK
         imlzjuIAxIkE25SY5IZGkIv2ae2GtniFmsdCk+j0SfqFfCuk2QCV/JZlul3aEvGrCtsg
         CDPbeDbHaj+12+6E8nXIOPM+gZG3LJ+TTZxe60756KYin4x2wjx9e6rtSJzHOS8gsaw7
         4nZVKGUh/iN9/g61Z+0whGTFbP5shk9DsX9qVMK00RR3eT3fr86Ft9MP2R37UZy+H+C+
         II1w==
X-Gm-Message-State: AOAM532DJdtUmWyWXmbzIpP53NW4bUYgl72sWKxDhJg0wWD91Q4nbmrv
        EZA0HFa+1ZEwY4SFAbFfDxyKAjNzM5YVpdOEXD4=
X-Google-Smtp-Source: ABdhPJzPF2/8V6cuombD/QKXzYQXhPA2V1SbURbIQHdmQvmQZXPMRhSp1JCZU6IvurOYhdxprvPq76yq7uNGngvxN6I=
X-Received: by 2002:a05:651c:2119:: with SMTP id a25mr13852405ljq.131.1637211807008;
 Wed, 17 Nov 2021 21:03:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
 <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com> <211116.8635nwr055.gmgdl@evledraar.gmail.com>
 <CANQDOdcEtOMMOLcHrnTKReRS23PvjOGp58VdpEkV_6iZuSPXaw@mail.gmail.com> <211117.86ee7f8cm4.gmgdl@evledraar.gmail.com>
In-Reply-To: <211117.86ee7f8cm4.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 17 Nov 2021 21:03:16 -0800
Message-ID: <CANQDOdcKzxM+M7wgxUz831SbpwGWR7gcUC8xLFM14BcCJ+60sA@mail.gmail.com>
Subject: Re: [PATCH v9 0/9] Implement a batched fsync option for core.fsyncObjectFiles
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Patrick Steinhardt <ps@pks.im>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 11:28 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Nov 16 2021, Neeraj Singh wrote:
>
> > On Tue, Nov 16, 2021 at 12:10 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >>
> >> On Mon, Nov 15 2021, Neeraj K. Singh via GitGitGadget wrote:
> >>
> >> >  * Per [2], I'm leaving the fsyncObjectFiles configuration as is wit=
h
> >> >    'true', 'false', and 'batch'. This makes using old and new versio=
ns of
> >> >    git with 'batch' mode a little trickier, but hopefully people wil=
l
> >> >    generally be moving forward in versions.
> >> >
> >> > [1] See
> >> > https://lore.kernel.org/git/pull.1067.git.1635287730.gitgitgadget@gm=
ail.com/
> >> > [2] https://lore.kernel.org/git/xmqqh7cimuxt.fsf@gitster.g/
> >>
> >> I really think leaving that in-place is just being unnecessarily
> >> cavalier. There's a lot of mixed-version environments where git is
> >> deployed in, and we almost never break the configuration in this way (=
I
> >> think in the past always by mistake).
> >
> >> In this case it's easy to avoid it, and coming up with a less narrow
> >> config model[1] seems like a good idea in any case to unify the variou=
s
> >> outstanding work in this area.
> >>
> >> More generally on this series, per the thread ending in [2] I really
> >
> > My primary goal in all of these changes is to move git-for-windows over=
 to
> > a default of batch fsync so that it can get closer to other platforms
> > in performance
> > of 'git add' while still retaining the same level of data integrity.
> > I'm hoping that
> > most end-users are just sticking to defaults here.
> >
> > I'm happy to change the configuration schema again if there's a
> > consensus from the Git
> > community that backwards-compatibility of the configuration is
> > actually important to someone.
> >
> > Also, if we're doing a deeper rethink of the fsync configuration (as
> > prompted by this work and
> > Eric Wong's and Patrick Steinhardts work), do we want to retain a mode
> > where we fsync some
> > parts of the persistent repo data but not others?  If we add fsyncing
> > of the index in addition to the refs,
> > I believe we would have covered all of the critical data structures
> > that would be needed to find the
> > data that a user has added to the repo if they complete a series of
> > git commands and then experience
> > a system crash.
>
> Just talking about it is how we'll find consensus, maybe you & Junio
> would like to keep it as-is. I don't see why we'd expose this bad edge
> case in configuration handling to users when it's entirely avoidable,
> and we're still in the design phase.

After trying to figure out an implementation, I have a new proposal,
which I've shared on the other thread [1].

[1] https://lore.kernel.org/git/CANQDOdcdhfGtPg0PxpXQA5gQ4x9VknKDKCCi4HEB0Z=
1xgnjKzg@mail.gmail.com/

>
> >> don't get why we have code like this:
> >>
> >>         @@ -503,10 +504,12 @@ static void unpack_all(void)
> >>                 if (!quiet)
> >>                         progress =3D start_progress(_("Unpacking objec=
ts"), nr_objects);
> >>                 CALLOC_ARRAY(obj_list, nr_objects);
> >>         +       plug_bulk_checkin();
> >>                 for (i =3D 0; i < nr_objects; i++) {
> >>                         unpack_one(i);
> >>                         display_progress(progress, i + 1);
> >>                 }
> >>         +       unplug_bulk_checkin();
> >>                 stop_progress(&progress);
> >>
> >>                 if (delta_list)
> >>
> >> As opposed to doing an fsync on the last object we're
> >> processing. I.e. why do we need the step of intentionally making the
> >> objects unavailable in the tmp-objdir, and creating a "cookie" file to
> >> sync at the start/end, as opposed to fsyncing on the last file (which
> >> we're writing out anyway).
> >>
> >> 1. https://lore.kernel.org/git/211110.86r1bogg27.gmgdl@evledraar.gmail=
.com/
> >> 2. https://lore.kernel.org/git/20211111000349.GA703@neerajsi-x1.locald=
omain/
> >
> > It's important to not expose an object's final name until its contents
> > have been fsynced
> > to disk. We want to ensure that wherever we crash, we won't have a
> > loose object that
> > Git may later try to open where the filename doesn't match the content
> > hash. I believe it's
> > okay for a given OID to be missing, since a later command could
> > recreate it, but an object
> > with a wrong hash looks like it would persist until we do a git-fsck.
>
> Yes, we handle that rather badly, as I mentioned in some other threads,
> but not doing the fsync on the last object v.s. a "cookie" file right
> afterwards seems like a hail-mary at best, no?
>

I'm not quite grasping what you're saying here. Are you saying that
using a dummy
file instead of one of the actual objects is less likely to produce
the desired outcome
on actual filesystem implementations?

> > I thought about figuring out how to sync the last object rather than so=
me random
> > "cookie" file, but it wasn't clear to me how I'd figure out which
> > object is actually last
> > from library code in a way that doesn't burden each command with
> > somehow figuring
> > out its last object and communicating that. The 'cookie' approach
> > seems to lead to a cleaner
> > interface for callers.
>
> The above quoted code is looping through nr_objects isn't it? Can't a
> "do fsync" be passed down to unpack_one() when we process the last loose
> object?

Are you proposing that we do something different for unpack_objects
versus update_index
and git-add?  I was hoping to keep all of the users of the batch fsync
functionality equivalent.
For the git-add workflow and update-index, we'd need to track the most
recent file so that we
can go back and fsync it.  I don't believe that syncing the last
object composes well with the existing
implementation of those commands.

Thanks,
Neeraj
