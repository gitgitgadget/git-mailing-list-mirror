Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B122C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 09:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiBCJWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 04:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiBCJWX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 04:22:23 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87106C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 01:22:22 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w25so4491236edt.7
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 01:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LkP0rTXRsebkCs+S0wofnF9erSGQOEz9oNIvCViA7DM=;
        b=ALO26mzbDdsmn4jituP+Ld2jTbJg50Bzu4iTXpdEmUgFqStOoW8CpnnE94vaPHrRpT
         B/tBLpEivfzIK319/HGnLYCPBqMK6jykxqUOqKONelTxpQzzC2+2JiP0ZvqxqaFKBr0/
         YkR/qirKUFaf72qqy0HxhUxlWUGb2ey8Eik6z+9BgVZ6eihK1M4FIKxLyJjekBG683JR
         lp+ic68+oN4LQAYZ46HsFAXIHiCtfoGm5UCLNDWF424FSFBvoMh47CuqrDE88a7FeiHX
         YRBH6za9vOUFfpdZGl2ZnQsVyZ3WgokvcNS2DN2iUsqfTklMPQqZQ4Erd3Cpup5WR2gP
         snSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LkP0rTXRsebkCs+S0wofnF9erSGQOEz9oNIvCViA7DM=;
        b=rfC/U4pzqjh3Y8PrMziPZdcjrKOAetXUV8GpPrY3LdR1Ny2lr2YBfN/w5722D2wPXk
         yM87tyaVca2Nz4KoAlY1p2zQ4ugn602uK8WXZ4W4hR+Bp+LUvTiNcB19H/qdx9PtBzY/
         dzy+rC7hA1/FsqeMb3HzMOLerlsJ9PE45YVh2L/Cda4GqyyKfzjK1FWD/0cVh99M0KjQ
         YUFaIUT/9HIFo1imltTLSGWNCnFcVjTMiOAwiRZQE4sC9BPp3mzI0bfTs8GQZj73zvJh
         MQOQoOiSzlDkWCQwFFd0G5Fj8k1edw5Fn1SKR1lFc4qzlqLBIk8FE5npbybcil+sJ3fr
         w5vQ==
X-Gm-Message-State: AOAM530aIdiORTGzwJPw5zKz/KetpjTmTevpTnJ8uCfvwkhz8/8PO/hC
        7pJShaXdmxUj5hyC0iBas8LCJHMnCjl/zMGmdd8=
X-Google-Smtp-Source: ABdhPJx1q3fgOAjUP5rZSl43LJhL4ScKa4OfXHbtn3lSC0Twe6limPQ8KqISfodYudLXJY/jLTuRfPQmCP84idTGvwU=
X-Received: by 2002:aa7:d313:: with SMTP id p19mr35146008edq.380.1643880141124;
 Thu, 03 Feb 2022 01:22:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <63f42df21aec5bda50e4414493eb59dcb64e5558.1643787281.git.gitgitgadget@gmail.com>
 <220203.86a6f87lbl.gmgdl@evledraar.gmail.com> <CABPp-BHKZnmaq3NM5_D6pwkw2+91EsdJ-uqjfFPBYiUSE28k1g@mail.gmail.com>
In-Reply-To: <CABPp-BHKZnmaq3NM5_D6pwkw2+91EsdJ-uqjfFPBYiUSE28k1g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Feb 2022 01:22:09 -0800
Message-ID: <CABPp-BHZYUmWBvzgFkRYddnUJQWrtah=JJ-yaW9Km8+qWcCfUw@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] merge-tree: add option parsing and initial shell
 for real merge function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 3, 2022 at 1:04 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Feb 2, 2022 at 6:09 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
> >
> > On Wed, Feb 02 2022, Elijah Newren via GitGitGadget wrote:
> >
> > > From: Elijah Newren <newren@gmail.com>
> > >
> > > Let merge-tree accept a `--write-tree` parameter for choosing real
> > > merges instead of trivial merges, and accept an optional
> > > `--trivial-merge` option to get the traditional behavior.  Note that
> > > these accept different numbers of arguments, though, so these names
> > > need not actually be used.
> >
> > Maybe that ship has sailed, but just my 0.02: I thought this whole thin=
g
> > was much less confusing with your initial merge-tree-ort proposal at
> > https://lore.kernel.org/git/CABPp-BEeBpJoU4yXdfA6vRAYVAUbd2gRhEV6j4VEqo=
qcu=3DFGSw@mail.gmail.com/;
> > I.e. the end-state of merge-tree.c is that you end up reading largely
> > unrelated code (various static functions only used by one side or
> > another).
>
> Christian's merge-tree-ort proposal?
>
> > But maybe that's all water under the bridge etc, however...
> >
> > >  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> > >  {
> > > -     if (argc !=3D 4)
> > > -             usage(merge_tree_usage);
> > > -     return trivial_merge(argc, argv);
> > > +     struct merge_tree_options o =3D { 0 };
> > > +     int expected_remaining_argc;
> > > +
> > > +     const char * const merge_tree_usage[] =3D {
> > > +             N_("git merge-tree [--write-tree] <branch1> <branch2>")=
,
> > > +             N_("git merge-tree [--trivial-merge] <base-tree> <branc=
h1> <branch2>"),
> > > +             NULL
> > > +     };
> > > +     struct option mt_options[] =3D {
> > > +             OPT_CMDMODE(0, "write-tree", &o.mode,
> > > +                         N_("do a real merge instead of a trivial me=
rge"),
> > > +                         'w'),
> > > +             OPT_CMDMODE(0, "trivial-merge", &o.mode,
> > > +                         N_("do a trivial merge only"), 't'),
> > > +             OPT_END()
> > > +     };
> > > +
> > > +     /* Parse arguments */
> > > +     argc =3D parse_options(argc, argv, prefix, mt_options,
> > > +                          merge_tree_usage, PARSE_OPT_STOP_AT_NON_OP=
TION);
> > > +     if (o.mode) {
> > > +             expected_remaining_argc =3D (o.mode =3D=3D 'w' ? 2 : 3)=
;
> > > +             if (argc !=3D expected_remaining_argc)
> > > +                     usage_with_options(merge_tree_usage, mt_options=
);
> > > +     } else {
> > > +             if (argc < 2 || argc > 3)
> > > +                     usage_with_options(merge_tree_usage, mt_options=
);
> > > +             o.mode =3D (argc =3D=3D 2 ? 'w' : 't');
> > > +     }
> >
> > Do we really need to make this interface more special-casey by
> > auto-guessing based on argc what argument you want? I.e. instead of
> > usage like:
> >
> >         N_("git merge-tree [--write-tree] <branch1> <branch2>"),
> >         N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <bra=
nch2>"),
> >
> > Wouldn't it be simpler to just have the equivalent of:
> >
> >         # old
> >         git merge-tree ...
> >         # new
> >         git merge-tree --new-thing ...
> >
> > And not have to look at ... to figure out if we're dispatching to the
> > new or old thing.
>
> You seem to be focusing on code simplicity?  Sure, that'd be simpler
> code, it'd just be a less useful feature.
>
> I think passing --write-tree all the time would be an annoyance.  I
> don't see why anyone would ever use the other mode.  However, for as
> long as both exist in the manual, it makes the manual easier to
> explain to users, and example testcases more self-documenting by
> having the flag there.  That's the sole purpose of the flag.
>
> I'm never going to actually use it when I invoke it from the command
> line.  And I suspect most would leave it off.

...also, even if we did require the `--write-tree` flag, we'd still
have to look at argc.  Since the option parsing handles both modes,
someone could leave off --write-tree, but include a bunch of other
options that only make sense with --write-tree.  Individually checking
the setting of every extra flag along with write_tree is a royal pain
and I don't want to repeat that for each new option added.  Simply
checking argc allows you to provide an error message if the user does
that.

(And I think it's sad that in Git we often forgot to warn and notify
users of options that are only functional with certain other
arguments; it makes it harder for users to figure out, and has in the
past even made it harder for other developers to figure out what was
meant and how things are to be used.  I think I've seen multiple Git
devs be confused over ls-files --directory and --no-empty-directory
options, assuming they'd do something sensible for tracked files, when
in fact those arguments are simply ignored because they are only
modifiers for how untracked files are treated.)
