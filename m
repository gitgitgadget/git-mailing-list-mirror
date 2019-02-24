Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C36C720248
	for <e@80x24.org>; Sun, 24 Feb 2019 16:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfBXQfE (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 11:35:04 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33954 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfBXQfE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 11:35:04 -0500
Received: by mail-io1-f67.google.com with SMTP id e1so5669357iok.1
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 08:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FiwKaaQTvklw7TbF0cc4uo2LS10yzDYwnSWXYPbwpeg=;
        b=dz5u8GyiFudHZsVPo3saW+HEUkx45RaQl/K9esLa5oPTwNZ9oPF0LW9Fsog7OIf+/4
         4htc37RIWYNIPaoFO44AxYyELZZIE36H/1Etm0W1BkbHzmAKdN9P+/aUfzBxp2PcXR7L
         buUFKLKJNOVUcPWqaFD5aI6Qwj38RIY0PZn1jmRZJYdQBqKuuZdO8CdY5I5kXqM3TxnE
         4s7Myu264PNLDl12CQUg7/OMXPQSXOg+MTJQ1tUTea8pNG61XfyjPYuNIwybt6aZesP6
         XPgrqB2AuVinOSTi7BuTTMYh92Noojmq6OFF6a3DDd8iN61U+AiaKRMjc/ePwsXzURHH
         Egog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FiwKaaQTvklw7TbF0cc4uo2LS10yzDYwnSWXYPbwpeg=;
        b=avaTEG284UvS2CkrgNvnWMT7MF5S30jtWoKCx1XEnRZ1Co3+o0LYNEAfdk3QS/uDNK
         kyEF913Vv0chbOImjc/jpdROqHpb8GsBQtnwH6objRHlxECaFDYW9A/9AamzPZQmgdWe
         FirF/539d5e/kBpPnAq/C4aIMDl/2IxyZU4Fk1DwFn8aiWaZ6G6VtILuErzTlBnhGQGh
         thWzHBrV0O9NzCag9L7okFD5lR5f4wOo4x/Y6jDf51yoGCKSueWTKUelgBf/ZwaKQK1j
         19yeKk70PBcNL2cAqcaM8HVTzVEvQ2yWx+tF9c+vK/JDtG2ZNMg56MiK5tzTJHqDM/rk
         Y6ow==
X-Gm-Message-State: AHQUAuZp3wWlOv+x7K8OOSsJJxGEu05r5mD1ih318dALRZYOcmGZ05Td
        DmG/+DrGERudWIBob1Y/NsYZPBWg550vzN64HA0CPg==
X-Google-Smtp-Source: AHgI3Ib6HhbebXft1HQLksWLl3XlNySaUP/9ij0DyOK4mPDlvrVjg715sYzQWMyOfJkZ5HnJNqiXKigYRsoiR/ZIU34=
X-Received: by 2002:a6b:7941:: with SMTP id j1mr7549730iop.262.1551026102432;
 Sun, 24 Feb 2019 08:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20190223190309.6728-1-matheus.bernardino@usp.br> <20190223215906.GR6085@hank.intra.tgummerer.com>
In-Reply-To: <20190223215906.GR6085@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 24 Feb 2019 13:34:51 -0300
Message-ID: <CAHd-oW5zQQkJ7WCcKpz0V7btNAbwuwCn0fvkcvAmXE1U9BhMxA@mail.gmail.com>
Subject: Re: [GSoC][PATCH 0/3] clone: convert explicit dir traversal to dir-iterator
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 23, 2019 at 6:59 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 02/23, Matheus Tavares wrote:
> > Add pedantic option to dir_iterator_begin at dir-iterator.c and convert
> > explicit recursive directory traversal at copy_or_link_directory
> > (builtin/clone.c) to the dir-iterator API.
>
> Thanks for another iteration of this.
>
> To make life easier for reviewers, please include a link (or the
> message-ID) to all previous iteration of the series.  We often use
> links to the public-inbox mirror for this,
> e.g. https://public-inbox.org/git/20190215154913.18800-1-matheus.bernardino@usp.br/.
>
> This helps reviewers go back quickly to previous iterations of the
> series, and refresh their memory on the comments that were left
> there.
>
> You can also use the --in-reply-to option in 'git send-email' to chain
> the threads, which also makes life easier for reviewers.
>
> An additional way to help reviewers is to include a 'range-diff'
> between the previous iteration of the series, and the current
> iteration.  See the 'git range-diff' command or the '--range-diff'
> option to 'git format-patch' for that.  That helps reviewers to
> quickly see what changed between iterations, so that they don't have
> to re-review everything, if they can still remember the last round
> well enough.
>
> I also added Christian Couder back to the Cc list, as he commented on
> the RFC.  It's good to keep people that commented on the series in Cc,
> as they have shown some interest in the series, so keeping them in the
> Cc list helps highlight those emails for them, and makes it more
> likely that the patches get reviewed quickly.
>

Ok, thanks for all the tips, Thomas! Now I started to notice the
public-inbox references for previous iterations in other people's
patches, too.

I am part of a FLOSS group here at USP called FLUSP
(https://flusp.ime.usp.br/), and I plan to write some posts on our
website about what I am learning in the git community so that other
people in the group can have as a base if they decide to start
contributing to git too. So all this tips and explanations are of
great value, not only for me but for others here! Thanks a lot.

> > This is my microproject for GSoC 2019. Idea taken from
> > https://git.github.io/SoC-2019-Microprojects/#use-dir-iterator-to-avoid-explicit-recursive-directory-traversal
> >
> > Build: https://travis-ci.org/MatheusBernardino/git/builds/497512561
> >
> > Matheus Tavares (3):
> >   dir-iterator: add pedantic option to dir_iterator_begin
> >   clone: extract function from copy_or_link_directory
> >   clone: use dir-iterator to avoid explicit dir traversal
> >
> >  builtin/clone.c      | 72 ++++++++++++++++++++++++++++----------------
> >  dir-iterator.c       | 23 ++++++++++++--
> >  dir-iterator.h       | 16 ++++++++--
> >  refs/files-backend.c |  2 +-
> >  4 files changed, 81 insertions(+), 32 deletions(-)
> >
> > --
> > 2.20.1
> >
