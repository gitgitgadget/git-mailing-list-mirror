Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79708C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 00:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiCVARv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 20:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiCVARp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 20:17:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C7A2E2D5B
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 17:15:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p15so16468411lfk.8
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 17:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zKB/qohjvAUk71SpKxQLsmo+KZVHecdbxu8JUNwRnBo=;
        b=aeGW2F50zG1+TwffHQtuEXRWfwJ8kUTwuS+gzojlrpiwlMchZ/NjoYvEsvWQRxKx1X
         omJQ3S9X11XlNz5IwuMQe0s6KuI2Bwt7d0juFvecRnnk9N65fmfxzeKqFuJ1ZyHPmC04
         IUQCCwF0VIVuwvjxE8bABBx1oIPVlFoUVdgP6eKevDVdxjnCpg2Q6ZkpfmUUo/l5IhF8
         zltOb9JHNCLrwakxJu6uCDlWdwvqMcDn16ZZuiH1zL4MMa/Dreca6mq5pWXy5/trcSRo
         pryrki4vAaNbTQDyLlyB4J7LGAgME3S/XBpmnob3lR3fZMfajBkrOSFI1uMazHTBgGIb
         iHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zKB/qohjvAUk71SpKxQLsmo+KZVHecdbxu8JUNwRnBo=;
        b=S4DUh2b6q1DYE9D7toVKlwpe5Bu9cm1HRgVK8gCw3Thyt9WKbxUmLyCIeB9FgEKvQ3
         PgJ+Rm9mGxCjgoNHGmnF1PAQjZngPYmva1iFmMtV66lWLXqGi26rWTV/rS6FxD7/uhFS
         6j9LCbYOu6jB9/JcjrQ+ySVQUYzSDIytsiZFN5jVl6MyNxA6Plq/EgK02U8or6x7Mzfq
         w9FAu609GiwVb48+MIs77XVbr8eRh/P/+S2TIwjHFJP0lhS+K76TYQjholnlhd5NxdGF
         4LmBvFkNIxuOsuKrEOnv23HwBRP5/Qk42BStFH6oY6XjKeraUSBWuJ4ryDTfa29OLAjO
         xqHg==
X-Gm-Message-State: AOAM531rIDECNCnaT94sWDDzJK9f+R1W6HVlCuN/jhXCdLPSXiCyq0wL
        uJxbLm1igUe0I8pmxrrOThkm6TtzUaA86julvx4=
X-Google-Smtp-Source: ABdhPJwUTs32QJ7TFxSqwLiYHeEsFh2bpRrrs4ez+BA/78tfRieLOFJ2M3tC2yiJAL/S1bC3eWG4punr4665VXlvJEY=
X-Received: by 2002:a05:6512:1684:b0:448:a0e6:9fa6 with SMTP id
 bu4-20020a056512168400b00448a0e69fa6mr16566572lfb.592.1647908027957; Mon, 21
 Mar 2022 17:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com> <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
 <220321.861qyv9rjr.gmgdl@evledraar.gmail.com> <CANQDOdez2u4oTNeETM0zLQr7Xb6XXbEuoxXPhSqGuurwQWbkHA@mail.gmail.com>
 <220321.86zgljnite.gmgdl@evledraar.gmail.com>
In-Reply-To: <220321.86zgljnite.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 21 Mar 2022 17:13:36 -0700
Message-ID: <CANQDOdc+ENfKLxpQ1HZJPgzgK26DRZi2-qNkkn7B6n9qV_B-gg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] core.fsyncmethod: batched disk flushes for loose-objects
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 21, 2022 at 1:37 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Mar 21 2022, Neeraj Singh wrote:
>
> [Don't have time for a full reply, sorry, just something quick]
>
> > On Mon, Mar 21, 2022 at 9:52 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > [...]
> >> So, my question is still why the temporary object dir migration part o=
f
> >> this is needed.
> >>
> >> We are writing N loose object files, and we write those to temporary
> >> names already.
> >>
> >> AFAIKT we could do all of this by doing the same
> >> tmp/rename/sync_file_range dance on the main object store.
> >>
> >
> > Why not the main object store? We want to maintain the invariant that a=
ny
> > name in the main object store refers to a file that durably has the
> > correct contents.
> > If we do sync_file_range and then rename, and then crash, we now have a=
 file
> > in the main object store with some SHA name, whose contents may or may =
not
> > match the SHA.  However, if we ensure an fsync happens before the renam=
e,
> > a crash at any point will leave us either with no file in the main
> > object store or
> > with a file that is durable on the disk.
>
> Ah, I see.
>
> Why does that matter? If the "bulk" mode works as advertised we might
> have such a corrupt loose or pack file, but we won't have anything
> referring to it as far as reachability goes.
>
> I'm aware that the various code paths that handle OID writing don't deal
> too well with it in practice to say the least, which one can try with
> say:
>
>     $ echo foo | git hash-object -w --stdin
>     45b983be36b73c0788dc9cbcb76cbb80fc7bb057
>     $ echo | sudo tee .git/objects/45/b983be36b73c0788dc9cbcb76cbb80fc7bb=
057
>
> I.e. "fsck", "show" etc. will all scream bloddy murder, and re-running
> that hash-object again even returns successful (we see it's there
> already, and think it's OK).
>

I was under the impression that in-practice a corrupt loose-object can crea=
te
persistent problems in the repo for future commands, since we might not
aggressively verify that an existing file with a certain OID really is
valid when
adding a new instance of the data with the same OID.

If you don't have an fsync barrier before producing the final
content-addressable
name, you can't reason about "this operation happened before that operation=
,"
so it wouldn't really be valid to say that "we won't have anything
referring to it as far
as reachability goes."

It's entirely possible that you'd have trees pointing to other trees
or blobs that aren't
valid, since data writes can be durable in any order. At this point,
future attempts add
the same blobs or trees might silently drop the updates.  I'm betting that'=
s why
core.fsyncObjectFiles was added in the first place, since someone
observed severe
persistent consequences for this form of corruption.

> But in any case, I think it would me much easier to both review and
> reason about this code if these concerns were split up.
>
> I.e. things that want no fsync at all (I'd think especially so) might
> want to have such updates serialized in this manner, and as Junio
> pointed out making these things inseparable as you've done creates API
> concerns & fallout that's got nothing to do with what we need for the
> performance gains of the bulk checkin fsyncing technique,
> e.g. concurrent "update-index" consumers not being able to assume
> reported objects exist as soon as they're reported.
>

I want to explicitly not respond to this concern. I don't believe this
100 line patch
can be usefully split.

> >> Then instead of the "bulk_fsync" cookie file don't close() the last fi=
le
> >> object file we write until we issue the fsync on it.
> >>
> >> But maybe this is all needed, I just can't understand from the commit
> >> message why the "bulk checkin" part is being done.
> >>
> >> I think since we've been over this a few times without any success it
> >> would really help to have some example of the smallest set of syscalls
> >> to write a file like this safely. I.e. this is doing (pseudocode):
> >>
> >>     /* first the bulk path */
> >>     open("bulk/x.tmp");
> >>     write("bulk/x.tmp");
> >>     sync_file_range("bulk/x.tmp");
> >>     close("bulk/x.tmp");
> >>     rename("bulk/x.tmp", "bulk/x");
> >>     open("bulk/y.tmp");
> >>     write("bulk/y.tmp");
> >>     sync_file_range("bulk/y.tmp");
> >>     close("bulk/y.tmp");
> >>     rename("bulk/y.tmp", "bulk/y");
> >>     /* Rename to "real" */
> >>     rename("bulk/x", x");
> >>     rename("bulk/y", y");
> >>     /* sync a cookie */
> >>     fsync("cookie");
> >>
> >
> > The '/* Rename to "real" */' and '/* sync a cookie */' steps are
> > reversed in your above sequence. It should be
>
> Sorry.
>
> > 1: (for each file)
> >     a) open
> >     b) write
> >     c) sync_file_range
> >     d) close
> >     e) rename in tmp_objdir  -- The rename step is not required for
> > bulk-fsync. An earlier version of this series didn't do it, but
> > Jeff King pointed out that it was required for concurrency:
> > https://lore.kernel.org/all/YVOrikAl%2Fu5%2FVi61@coredump.intra.peff.ne=
t/
>
> Yes we definitely need the rename, I was wondering about why we needed
> it 2x for each file, but that was answered above.
>
> >> And I'm asking why it's not:
> >>
> >>     /* Rename to "real" as we go */
> >>     open("x.tmp");
> >>     write("x.tmp");
> >>     sync_file_range("x.tmp");
> >>     close("x.tmp");
> >>     rename("x.tmp", "x");
> >>     last_fd =3D open("y.tmp"); /* don't close() the last one yet */
> >>     write("y.tmp");
> >>     sync_file_range("y.tmp");
> >>     rename("y.tmp", "y");
> >>     /* sync a cookie */
> >>     fsync(last_fd);
> >>
> >> Which I guess is two questions:
> >>
> >>  A. do we need the cookie, or can we re-use the fd of the last thing w=
e
> >>     write?
> >
> > We can re-use the FD of the last thing we write, but that results in a
> > tricker API which
> > is more intrusive on callers. I was originally using a lockfile, but
> > found a usage where
> > there was no lockfile in unpack-objects.
>
> Ok, so it's something we could do, but passing down 2-3 functions to
> object-file.c was a hassle.
>
> I tried to hack that up earlier and found that it wasn't *too
> bad*. I.e. we'd pass some "flags" about our intent, and amend various
> functions to take "don't close this one" and pass up the fd (or even do
> that as a global).
>
> In any case, having the commit message clearly document what's needed
> for what & what's essential & just shortcut taken for the convenience of
> the current implementation would be really useful.
>
> Then we can always e.g. change this later to just do the the fsync() on
> the last of N we write.
>

I left a comment in the (now very long) commit message that indicates the
dummy file is there to make the API simpler.

Thanks,
Neeraj
