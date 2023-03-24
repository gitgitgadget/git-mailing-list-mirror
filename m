Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5641C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 03:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCXDsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 23:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCXDsi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 23:48:38 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E6610F7
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 20:48:36 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bo10so418223oib.11
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 20:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679629716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3m97328ksAfm/2qmzzac+yLLJb/TD5W9CvQ36DxXyU=;
        b=fj0RWOjUv502edovLO7oEz2BMp9AKGL6HyUYRqdtqHF05+MSPW7ag3UaF+PvnOyqKj
         UpQQNIsvoXRgRM1x3X4n19mfwTrWhkwtlk655phpDk+4qkE11vFNmofbYANhUfJlFJ+n
         8+AZx6JMC/Hs6oH7SKfLiVxanhH5NdmzuvLGdOdaJsNM5AhMmulKmJy2UgcDLxiUwEB6
         07JxuxBIM7ok4XsWsmMMaTQSgvi4nKxibmxOX9HrJuKdFOx7BKNa1Iai6LDX8OKY4OIq
         4Qyc+isRjmcoHvwxIwmPEzSsF91UIsAD+mysdL9eUUOZVeNKKM1mUcqTA3ePKOchY06i
         j5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679629716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3m97328ksAfm/2qmzzac+yLLJb/TD5W9CvQ36DxXyU=;
        b=ISR47bRsErbEJXlBaVw6oV+RdG+5TVXtAxJOINo0R0zXivOmP4RCBeSqMofhj8SCBW
         yokLrmXA+fPM/miwr3QCij1snBwAS/OFOjfWktdMonjvrpjWwKhyd98xEbswXqliIdVk
         BrJ9KjoW0xX5e+eYGugAgPyFF3DB8lWKI8RZrf9sNMAy0tn5csIim1mrscMXtI1pi2jF
         lHJDuP/fVqHbf2T9S07B1smb5M+vj+cRXL2jwUlKziNe9BIlvPNx/R4oCepfx86ckwk0
         Qmos8dGfyTQwpUwj5m2QcJrnRo6KUC8BfgBEMv+kEmn4y1wMvdKdUvmdrl9RNx2DLfOP
         Oc8A==
X-Gm-Message-State: AO0yUKX1KNk3v9DjkEv7p9fa/KeMJ0LbMFy4LK5FJcDZ6zavkPpxA2Hd
        G69k99IcbDacJd/NFKnWyiSAlZ8POXB3IQr30g4=
X-Google-Smtp-Source: AK7set9hKioRibjdTIKhOr59Beah24I3yok/GHcDB09Ay24dLN9bnz1zlXC5XTs8BXkbjK9NPBerPyYOoFH0zyStgK8=
X-Received: by 2002:a05:6808:2093:b0:36e:f6f5:604c with SMTP id
 s19-20020a056808209300b0036ef6f5604cmr244756oiw.9.1679629715767; Thu, 23 Mar
 2023 20:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <858rfnb770.fsf@gmail.com> <ZBy18EBE7WM/E4KF@nand.local> <851qlfazzp.fsf@gmail.com>
In-Reply-To: <851qlfazzp.fsf@gmail.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Fri, 24 Mar 2023 09:18:24 +0530
Message-ID: <CAPOJW5x+yQsPxdwCWMT9AkMQhJyxKp5BiPXp_1PT6WwF7yF4YQ@mail.gmail.com>
Subject: Re: What is the status of GSoC 2022 work on making Git use roaring bitmaps?
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 3:32=E2=80=AFAM Jakub Nar=C4=99bski <jnareb@gmail.c=
om> wrote:
>
> Hello Taylor,
>
> Thanks for a fast response.
>
> Taylor Blau <me@ttaylorr.com> writes:
> > On Thu, Mar 23, 2023 at 08:26:11PM +0100, Jakub Nar=C4=99bski wrote:
> >> Hello,
> >>
> >> Could you tell me what is the status of the Abhradeep Chakraborty work
> >> in integrating roaring bitmaps (using CRoaring) in addition to, or
> >> replacing current EWAH bitmaps (using ewok)? The last communication
> >> about this shows that the patches were on the road to being merged in,
> >> see e.g. https://medium.com/@abhra303/gsoc-final-report-feaaacfae737 ,
> >> but there is no mention of 'roaring' in Git's code or documentation.
> >
> > Abhradeep started working on a prototype to teach Git how to read and
> > write Roaring+Run bitmaps in this series:
> >
> >   https://lore.kernel.org/git/pull.1357.git.1663609659.gitgitgadget@gma=
il.com/
> >
> > Some folks gave it a review, but there wasn't any serious traction and =
I
> > don't think that Abhradeep has had a chance to come back to the series.
> >
> > For what it's worth, I would love if Abhradeep (or anybody else
> > interested in working on this area) picked it back up, either using tha=
t
> > series as a starting point or going from scratch.
>
> When I searched the mailing list archives, the thread was never continued=
.


Hello community,

I have to apologize for the fact that I didn't continue the patch
series. I wasn't
involved in the community either. I am currently too busy to enhance my ski=
lls
to get into a company of "my dream engineering environment". The problem is
that it needs much effort and time to achieve that.

I have always had a love for the Git project and the community. But
unfortunately
I can't contribute to it right now and I don't think I can contribute
to it prior to
my course ends (i.e. June, 2023). I would be happy if anybody else pick the
issue and continue the work where I left off. I am even ready to
guide/mentor/help.

There are certain things in my mind (other than roaring bitmaps) that
I previously
shared with Kaartik and Taylor. I will continue to be a part of this
community and
will make contributions after my college ends.

> >> Moreover, there is no proposal to finish this on the GSoC 2023 ideas
> >> page: https://git.github.io/SoC-2023-Ideas/ .  Is it because it would =
be
> >> too small of a project?  Or maybe it turned out that roaring bitmaps
> >> were not a good idea - though I haven't found mentions of any benchmar=
ks
> >> of roaring vs EWAH in the mailing list archives?  Or perhaps there is =
no
> >> one to mentor this proposal?
> >
> > I don't have the capacity to mentor a student this cycle, and I am
> > probably the most interested among potential mentors in seeing this
> > project through ;-).
>
> Ah, so it is mostly the last issue - lack of a potential mentor for
> conntinuing this project.
>
> > I don't think that it's too small (in fact, it was probably an error on
> > my part to include this as a potential stretch goal in Abhradeep's
> > project). We don't have any evidence that it's a good or bad idea.

Yeah, It is big enough to take an extra 3 months of code and discussions.

> > Abhradeep promised[1] that he'd include some performance work in his
> > next version of that series. I think the main things we'd be interested
> > in are:
> >
> >   - Does using Roaring provide a file-size advantage over
> >     EWAH-compressed bitmaps?
> >   - Does Roaring make it faster to inflate bitmaps? To deflate them?
>
> As far as I understand it, after reading articles about EWAH[2] and
> about Roaring Bitmaps[3][4], the Roaring have the advantage that you
> don't need to decompress (inflate) bitmaps to perform bitwise operations
> on them.
>
> Run-Length-Encoding (RLE) formats like EWAH can be made to perform
> operations without decompressing, but only if operations are symmetric.
> The AND and OR operations are symmetrical, but AND NOT is not.  The last
> is used by Git to find "want"-ed that are not present (not "have") is
> not.  That is why Git needs to decompress bitmap and perform operation.
>
> If I understand it correctly, for both cases (EWAH and Roaring) you can
> do membership check without decompressing bitmap.
>
>
> [2] Daniel Lemire et al. "Sorting improves word-aligned bitmap indexes",
>     arXiv:0901.3751
>
> [3] Samy Chambi, Daniel Lemire et al. "Optimizing Druid with Roaring
>     bitmaps", https://dl.acm.org/doi/10.1145/2938503.2938515
> [4] Daniel Lemire et al. "Roaring Bitmaps: Implementation of an
>     Optimized Software Library", arXiv:1709.07821v3
>
> >
> > Deflating bitmaps doesn't matter as much, IMHO, since that is a cost
> > that we pay only when we first have to compress bitmaps before writing
> > them. But if we could significantly reduce the inflation cost, that
> > would be an advantage to using Roaring+Run bitmaps over EWAH ones since
> > they would be faster to decompress at read-time.
>
> Well, if Roaring were to be significantly slower when deflating, but
> only slightly faster when using / inflating, that would affect their
> evaluation.

IMHO, I don't think Roaring bitmaps would make any significant performance
improvements. It may be faster to decompress, but I believe it takes more
in memory computation than the EWAH. My biggest concern is its dynamic
nature. It can dynamically change its underlying data structure into an arr=
ay,
bitmap or RLE. I didn't test the performance though and I shouldn't draw an=
y
conclusions about it.

> >
> > [1]: https://lore.kernel.org/git/CAPOJW5wkXrV8eOysz6aJ5jN2u_u-iTX_3om3t=
SDKw+EmfCJBEw@mail.gmail.com/
>
> Regards,
> --
> Jakub Nar=C4=99bski

I am extremely sorry for the inconvenience and I hope you'll understand the
situation.

Thanks :)

Regards,
Abhradeep Chakraborty
