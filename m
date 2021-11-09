Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54FCC433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 00:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01696109F
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 00:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbhKIAFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 19:05:51 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:44998 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKIAFv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 19:05:51 -0500
Received: by mail-ed1-f50.google.com with SMTP id j21so69171394edt.11
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 16:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lUGReOXl/dUJbRx2MdYnKC83NVBj3zY/j0Pd8Mivo4o=;
        b=V3b8qR6HlsBQ9d5J5MSqbzPyV7zECzC8p3X1v5IFFQs1SpyrQB/U2mCnlMePVi1uqW
         PUHowUKscM5esVO+vA4OnWOIrHbIinBG9803q3wf9LYHOx6jzHCIN2w3fvDYQy1C4b4w
         LEB3T4r5mZd0P6brHILiwzTYz4Dn7WaXKqVxcpr0XjUbWvZvqAgMMeiQHxAQt3FTJOgq
         crTcs1qxYe3hteVoJ9eBkgpGSwKNuqB6vYv2oycLUKaT2Xf5/VQLl/fR1KqsASK/AC8R
         4HO5LETb+Ir3mu/QS1+n/tHmjq6z3fTrNLJnfMUZRPgEgbGlEkFe9PGxnJf2g1+kLclq
         DmHg==
X-Gm-Message-State: AOAM530hj9enzwgDGNq5BTWPLfKBAR5B6AdQzz9pCxWKYgo+tOBud4s3
        ma9UHwNgfWq9oPqFGYnsY4T6jtS/emSfCC0FQcc=
X-Google-Smtp-Source: ABdhPJyiQcKbXy/jl7NViCeVkeLuwFZg7eezeJIl8W78up9GwXaNRZ9gy3LbWFzHB2GS2opEfJh08844A12Lo45U5js=
X-Received: by 2002:a17:907:7f18:: with SMTP id qf24mr3952472ejc.568.1636416185116;
 Mon, 08 Nov 2021 16:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20211107225525.431138-1-sandals@crustytoothpaste.net>
 <20211107225525.431138-4-sandals@crustytoothpaste.net> <CAPig+cRtOpaPd_HCQAW=33-vxhP4Knijo3g0dUA9HVb4_=JH4w@mail.gmail.com>
 <YYmmBMkwy6bpVpzI@camp.crustytoothpaste.net>
In-Reply-To: <YYmmBMkwy6bpVpzI@camp.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 8 Nov 2021 19:02:54 -0500
Message-ID: <CAPig+cTN+ktteGYv6dm_Qr=FejiwRMGwRW9p--7s46H7sxa3JQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gitfaq: add entry about syncing working trees
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 8, 2021 at 5:34 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2021-11-08 at 00:12:14, Eric Sunshine wrote:
> > Taking into consideration that people who are experiencing such
> > corruption will likely include the name of the syncing service in
> > their search query, would it make sense to mention some well-known
> > services here in order to make it more likely that people will
> > actually find this entry? Something like this, perhaps:
> >
> >     It is important not to use a cloud syncing service (such as DropBox,
> >     FooBar, CowMoo, BuzzingBee, etc.) to sync any portion of a Git
> >     repository...
>
> There are a lot of these services.  My preference is to not name
> specific ones here, just like we don't name specific ones when we state
> that you shouldn't use an antivirus or firewall other than the Windows
> default, mostly because I'm not interested in angering corporate
> lawyers.  My advice on this topic is always general: XYZ is a cloud
> syncing service, and you should not use any cloud syncing services for Git.

My "would it make sense" question arose from taking into consideration
how people are likely to use a search engine for a particular problem:

    BuzzingBee syncing corrupted git repository

Without naming specific services or tools, it seems much less likely
that people will find this FAQ entry, thus will end up posting to
StackOverflow (or wherever) anyhow -- despite your intention and
effort behind the FAQ in the first place. I'm thinking about
discoverability -- which is the same reason I suggested in my review
of the other patch that it might be a good idea to add actual error
messages a person might encounter with a CRLF shell script or an LF
batch file.

> Additionally, the popular options differ by region.  For example, there
> are some services which are probably popular in China which are not
> popular elsewhere, and I don't think it's a good idea to try to guess
> which ones happen to be most popular around the world.

The other way to look at it is that listing many popular services
(wherever they happen to be) makes it more likely that search engines
will lead them to this FAQ entry and alleviate the need to post a
question somewhere.

Anyhow, it was just a thought. I think I've said all I have to say on
this subject. As I mentioned in response to the cover letter, all of
my comments were of the bikeshedding variety, and I didn't see any
show-stoppers in the series as posted.

> > > +* There are no additional worktrees enabled for your repository.
> >
> > I don't fully understand this restriction. Can you explain it (at
> > least here in the email discussion)?
>
> If you sync the main repository and working tree, but not the worktrees
> themselves, then you end up with incorrect data in the .git directory,
> which contains information about the worktree.

I still don't follow. What incorrect data will be in the .git
directory? Do you mean the absolute path pointing from the .git
directory to the worktree?

> More importantly, it can
> contain absolute path information, which would be undesirable even if
> you did sync the worktrees, say, if you used two different usernames
> (and hence two different home directories) on the two systems.

Okay, I figured that that was probably one of your concerns, but it
was difficult to tell from the raw "no additional worktrees". On the
other hand, I can easily see people syncing between machines in which
they have the same username and same directory structure, so this
bullet point seems overly restrictive.

> > > +* You are not using a separate Git directory outside of your repository root.
> >
> > Same question about this restriction.
>
> Again, if you sync the root of the working tree but don't sync the
> separate Git directory, you won't have copied the index or any of the
> other data.

Okay, again, this is indeed what I thought you might have in mind, but
it was difficult to be sure. And, again, this seems overly restrictive
since there may be plenty of scenarios in which this works well.

I suppose both of these points would feel more reasonable if they
didn't sound like hard requirements, perhaps by explaining that the
simple case of no worktrees and no separate repository has the least
restrictions and is easiest to get up and running; more complex cases
can work too with the caveat that worktree and separate repository
directories ought to be synced too, and that pathnames need to be
identical on all machines.
