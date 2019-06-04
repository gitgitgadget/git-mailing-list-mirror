Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27F4D1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 20:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFDUXD (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 16:23:03 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44826 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDUXD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 16:23:03 -0400
Received: by mail-ua1-f65.google.com with SMTP id p5so2569883uar.11
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 13:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ZOcI/OGRU7g2BcEenBzjDyEBYa5hqjTBo7efVD8kaM=;
        b=oPsAn/5l3wJ6wUdWeweebgWJ5D3fUUeH7aKyuYKD2w6hsK/4RmwvVg4nhDV7Xg3S1g
         McBRfW431z+6q2IS5IIUYI7wSxQlMI6hsS9Wv0TS04PaE3bSsovL4O7YfHo30DFOqyCU
         QnaVoORBqjm2+I2rkPZzowAbR9lfksZZLOvntO5xVuvVTcEGvtAe1aarr+0rX8X8iGX/
         t4JYyCoA3ozkiVotS/jj7kqFrMzDuvurCOpazfCsZo10xAhhYcAKLLsERqAp/3KjKoyz
         /DfHWAhHDGxNmHgt/dnDxl2ybDHAejKsO58Or8G0uS28KEgn88nFbRDC8oe3XBM2/XaD
         bZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ZOcI/OGRU7g2BcEenBzjDyEBYa5hqjTBo7efVD8kaM=;
        b=CYb3e5b2MCiWEKDkUBVciuRDZkkfHBc3W1WCHkNm65iwiIBIxq77EArs1RVu0d8Bbh
         M8XDMIy28Ze/VpyZZt7Zy1H8l9Xx19QCyu3Ms12sdDxtmwYPbj7yBvjHxU9B6xPGFl/0
         DAyNYIDDJPufTY8zs6bw+d49oUGvvoaNnMS2M+PNkh+Ggp8RtiUrTZojZUE5Frf/RPMa
         Xapt4eHOEsNNEwYiXf2Yn6rM1q1kolJTA6lp3PxHuPbticCjxtmyObS5zM4HyjnktZ23
         gm+OFnoMCAeoJIBSeRlUj+Q9pj34rE19gY9nalAG6zH33DtfWiCbeOTGpv6oOUPc2yLc
         GHgg==
X-Gm-Message-State: APjAAAWtd5P/SB0/a58o/OefyW6M6eDgJIsI/kRs8ieYqcm/d/pLKexa
        kN2b7eGS0eSyw68R6XtoJW9NZJD/Z9qkgyn+jp0=
X-Google-Smtp-Source: APXvYqz3VAnRQ/KCUFdaDTLs3lzeGv+gQqP6J0oN5IdNJA6rD0VAjn1c+7A+0O/SlPIOKRw4d8bdhQocp0PZa2lwUKE=
X-Received: by 2002:a9f:3045:: with SMTP id i5mr17585198uab.81.1559679781490;
 Tue, 04 Jun 2019 13:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190604023039.GR951@szeder.dev> <20190604072614.26885-1-newren@gmail.com>
In-Reply-To: <20190604072614.26885-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 4 Jun 2019 13:22:50 -0700
Message-ID: <CABPp-BFF4B+YoMyfxVDKPmob1wVarvz02BTiCEaPGH8FHJ9ATQ@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: restore accidentally dropped setting of path
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        ben.humphreys@atlassian.com,
        Ben Humphreys <behumphreys@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 4, 2019 at 12:26 AM Elijah Newren <newren@gmail.com> wrote:
> On Mon, Jun 3, 2019 at 7:30 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:

> > > -     filespec_from_entry(&tmp, ci->ren1->src_entry, other_stage);
> > > -     tmp.path =3D a->path;
> >
> > Note that 'tmp.path' used to be set ...
> >
> > > -
> > >       prev_path_desc =3D xstrfmt("version of %s from %s", path, a->pa=
th);
> > > -     if (merge_mode_and_contents(opt, a, c, &tmp,
> >
> > ... and that this 'tmp' used to become 'b' in
> > merge_mode_and_contents() and then in merge_3way().
> >
> > > +     if (merge_mode_and_contents(opt, a, c,
> > > +                                 &ci->ren1->src_entry->stages[other_=
stage],
> > >                                   prev_path_desc,
> > >                                   opt->branch1, opt->branch2,
> > >                                   1 + opt->call_depth * 2, &mfi))
> > >               return -1;
> > >       free(prev_path_desc);
> >
> >
> > This one-liner patch below the issue, the merge fails with conflicts
> > as expected, but, honestly, I have no idea what I am doing :)  At
> > least the test suite still passes, but that might not mean all that
> > much since it missed this issue in the first place...
> >
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index a7bcfcbeb4..d2e380b7ed 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -1660,6 +1660,7 @@ static int handle_rename_add(struct merge_options=
 *opt,
> >                c->path, add_branch);
> >
> >         prev_path_desc =3D xstrfmt("version of %s from %s", path, a->pa=
th);
> > +       ci->ren1->src_entry->stages[other_stage].path =3D a->path;
> >         if (merge_mode_and_contents(opt, a, c,
> >                                     &ci->ren1->src_entry->stages[other_=
stage],
> >                                     prev_path_desc,
> >
> >
>
> This analysis and patch are correct; I somehow deleted the setting of the
> path here in what should have been a straightforward conversion.
>
> I've tried to look through every other callsite to merge_3way to see
> if any others fail to set the paths; there's a dozen or two of them.
> I think this was the only one that was missed, but honestly I'm
> exhausted right now and not sure I'm thinking straight.  So I'll
> recheck tomorrow and do a bunch more testing.

I've rechecked pretty thoroughly and yeah this was the only one that
was missed.  If anyone wants to double check me, here's some notes:

merge_3way has the following callers:

merge_3way (1 caller)
  <- merge_mode_and_contents (7 callers, 2x from handle_rename_rename_2to1)
     <- merge_mode_and_contents (to flip args into canonical order)
     <- handle_rename_add (1 caller)
        <- process_entry
     <- handle_rename_rename_1to2 (1 caller)
        <- process_entry
     <- handle_rename_rename_2to1 (1 caller)
        <- process_entry
     <- handle_content_merge (2 caller)
        <- process_entry
        <- handle_rename_normal (1 caller)
          <- process_entry
     <- handle_file_collision (6 callers, 2x from handle_rename_rename_1to2=
)
        <- handle_file_collision (to flip args into canonical order)
        <- handle_rename_add (1 caller)
           <- process_entry
        <- handle_rename_rename_1to2 (1 caller)
           <- process_entry
        <- handle_rename_rename_2to1 (1 caller)
           <- process_entry
        <- process_entry

From this, it's clear that just about everything starts in
process_entry().  process_entry() is pretty meticulous about setting
[oab]->path; it does so near the beginning of the function and then
updates for each of the rename cases to make sure it has the basic
values right.  I've audited all those and they are clean.  So the big
question is which functions pass something other than the [oab]
diff_filespec that they were passed; checking into that the answer is:

  handle_rename_rename_2to1 (3 different places, but path set in all of the=
m)
  handle_rename_rename_1to2 (2 different places, but path set in all of the=
m)
  handle_rename_add         (2 different places; one missed setting a path)

So, this is indeed the one case that was missed, and as SZEDER showed,
it was in the original but the conversion just somehow dropped the
simple one liner.  So I'll send an updated patch making the small
tweaks suggested by SZEDER, add a Tested-by for Ben since he retested
with his extra testcases for us, and then we'll be good for 2.22.0.

While doing this I also found a couple other small cleanups and
improvements, but I'll submit those after 2.22.0 is out; let's keep
the regression fix as minimal as possible.
