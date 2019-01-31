Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B12E1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 23:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfAaXgZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 18:36:25 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:39085 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfAaXgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 18:36:25 -0500
Received: by mail-oi1-f179.google.com with SMTP id i6so4321688oia.6
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 15:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ssQv5sJAOcwsWK2/agMh0QHBHXk3RFX10/vSNgbn1I=;
        b=N8P9pepTLqjp1kGIvnrE0wmMkdb9A7gqvDfD/Qlyg3PKfMeZLhtYjtZhhuuSCagIHV
         L760OntsUj69w4RrM1ybjh61/WnJqTfYTIDZMlOMuVImnSrYho8TZd//rLDI58B/LPdB
         AQV8EMwBgmAbBLFAXQjBQ08mCxmuxju/xCQpZgYg7EzmItO3n9cVYxcghNDn9cY/zaEg
         /AlS5F90YQeerJRyZ/TEMMImIPGeZUDx+hbpi19pU76/Ps4uv2VutB5IOQ0GmSuFd+tu
         2vZFv3ulbpg5q11xMOuf7q+n2y53fzyGvEXJuQrO/Zaj8Ur6sy2hqgPgRh5825wumM2N
         EItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ssQv5sJAOcwsWK2/agMh0QHBHXk3RFX10/vSNgbn1I=;
        b=rrJ0v0kog/GpebBdQTkMiUmmTSG2w+WB73ffibWDCLS03xBMuhqWplo4Iy3b78zJS0
         cHWKAxThmDz8CE0nCjYwypNfZkyGvdDfwb7uWZsgM8eBxgy54f6WekSiqPxGuqHVgRUm
         Dp7RFZmHcA6OfjkSVZ6jVDm39uEgZDWslz5VrFN9QXGHpyNnAfwQPFoAeuSySwxLrZ66
         F7d5+76iJw0eFwJ40Damoi/fQcmlhHJUaX3oQn5W10oTcMnK9Xs9SAopc4t8zRo/dLmt
         myuwh95cjrcHvbb688aDQs8hXXRDzxCcrZHfhkkc38klTlZUC2Eaa/9lwEwdn5Bey7XD
         N3+g==
X-Gm-Message-State: AJcUukcuvY9i9VjxdiLy4qLvQjM88A4uPeGw8QBJ2YO7rrdz9GUo8k6s
        L/K/rGtecr6iwfq2/7rzgNCeo/YtGEqCKZokt/qqi7Lb
X-Google-Smtp-Source: ALg8bN61rYROXxmvaoJB3VtR8VDxDx3L5fyhIvzoIHh700Pd/7xfMSGXP/9OeYMEnX4qeXDrJYwM69BoIl13NqqKm3g=
X-Received: by 2002:aca:ef87:: with SMTP id n129mr15794183oih.118.1548977784072;
 Thu, 31 Jan 2019 15:36:24 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
 <xmqq36p83aq4.fsf@gitster-ct.c.googlers.com> <CABPp-BH==w5APkz9cvUYq7m4qieJ3LWCsYySevgJuZ8bi2RzjQ@mail.gmail.com>
In-Reply-To: <CABPp-BH==w5APkz9cvUYq7m4qieJ3LWCsYySevgJuZ8bi2RzjQ@mail.gmail.com>
From:   Roberto Tyley <roberto.tyley@gmail.com>
Date:   Thu, 31 Jan 2019 23:36:12 +0000
Message-ID: <CAFY1edZ6hS5Dz9z5ZAhU59he9SjxetvfTN+ndzUZkjxhsuwEZA@mail.gmail.com>
Subject: Re: New command/tool: git filter-repo
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 31 Jan 2019 at 22:37, Elijah Newren <newren@gmail.com> wrote:
> On Thu, Jan 31, 2019 at 8:09 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > git-filter-repo[1], a filter-branch-like tool for rewriting repository
> > > history, is ready for more widespread testing and feedback.  The rough
> > > edges I previously mentioned have been fixed, and it has several useful
> > > features already, though more development work is ongoing (docs are a
> > > bit sparse right now, though -h provides some help).
> > >
> > > Why filter-repo vs. filter-branch?

I like the name! I think a lot of users are interested in filtering
their entire repo, rather than rewriting a single branch.

> > How does it compare with bfg-repo-cleaner?  Somehow I was led to
> > believe that all serious users of filter-branch like functionality
> > are using bfg-repo-cleaner instead.
>
> No, bfg-repo-cleaner only covers an important subset of the usecases.

That's true - the focus with BFG Repo-Cleaner is on removing unwanted
data - completely eradicating it from a repo's history. There are some
mistakes in history that repo owners just really *do not* want to
share (ie large files, private data/credentials), and they can be a
critical blocker to sharing or working with a Git repo. In terms of
rewriting history, my internal criterion for what I features I really
want to be in the BFG is: is this unwanted data completely stopping
many users from sharing their code or doing their work?

I understand that when it comes to rewriting history, there are loads
of other operations that people sometimes want to perform, beyond
removing unwanted data - merging/splitting of history,
anonymization/renaming of committers, etc. Some of those might be nice
to add to the BFG - but as with many OSS-maintainers, I have limited
time, and a life to balance outside of software...!

> bfg-repo-cleaner does a really good job if your goal is to remove a
> few big files and/or to remove some sensitive text (matched via
> regexes) from all blobs.  It was designed for that specific role and
> has more options in this area than filter-repo currently has.  But
> even within this design space it was optimized for, it is missing two
> things that I really want:
>
>   * pruning of commits which become empty due to filtering

There certainly have been several users asking for this feature on the
BFG, and even a kindly contributed PR for the functionality which I've
yet to merge. As it doesn't actually stop users from doing work - so
far as I can see - it's something that I've done a poor job of
following up.

>   * providing a way for the user to know what needs to be cleaned up.
> It has options like --strip-blobs-bigger-than <size> or
> --strip-biggest-blobs <NUM>, but no way for the user to figure out
> what <size> or <NUM> should be.

For users of GitHub, It's normally 100MB with
--strip-blobs-bigger-than <size> :-)

> Also, since it just focuses on really
> big blobs, it misses cases like someone checking in directories with a
> huge number of small-to-moderately sized files (e.g. bower_components/
> or node_modules/, though these could also contain a few big blobs

For those use-cases, it might be that BFG's --delete-folders flag is
useful, especially given the protected-head-commit feature of the BFG.


It's getting late for me, must be even later in Brussels - I wish I
could have made it there to join in! Merry Git Merge to you all, and
good luck to you Elijah with git-filter-repo.

Roberto
