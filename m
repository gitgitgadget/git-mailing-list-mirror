Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E5B20248
	for <e@80x24.org>; Tue, 26 Mar 2019 15:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCZPsg (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 11:48:36 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:38115 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZPsg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 11:48:36 -0400
Received: by mail-vk1-f193.google.com with SMTP id h71so2916752vkf.5
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2GyYh9HVj4hKMCesUnRwR/74+mDibs58ZY4P5YsVMiQ=;
        b=C4yEMS5nHOLa0blr+LEHTn9rG9dRoz9NV+BzuEogUdV1UkexlQnxFM/HEDX29HKS5+
         Y00f4CgHXbIbKMVQMaiYXj6IH3dpb9T1wkkv/0oVMGTshKHQn9XaM+x/Y6H8ulgj28r6
         2DiTJZiQPzuaeJGo+X4E5/qHSG5wk1QvoM9C2nr3efrNP6CESEEyITvgiYDlO4JlJs2x
         uDEZeo/r60sy100HJcQJDqP3SCczvYZlKVRwNTELoIRL45wfyvLINeKo3ByFG/JPFaBh
         1KOIBLfejE/t3jVSswErJROf10vCNXaSxHtq4stqMInYUzrIGufcxIqfUR/GQhWKyo+N
         fhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2GyYh9HVj4hKMCesUnRwR/74+mDibs58ZY4P5YsVMiQ=;
        b=n0yUP31som8TgtLDK2cGqaIqtaAL9MGkEVu7wIsw2w06bQsKxwSZW5se+2Z1yQUi1Y
         aRPf1uMGpwTOFyubJGqZtWG79MzoXozl+3GlKZgpNq1xfEGeZUs0fBsVx9s8OU2EzqYg
         mVzdLI7YufXSniNmGearxfmtL/0DW2dYdDV/Nbcg6OTlqtCV0jOJvdQhT7xznv4AJhbC
         f75GHRIvzBah8C96KIAz/ojaoKMKA8ObKJMbanlsP1HHExQCuuz9/biDlbtwTaNPMal2
         PCNJ9WKf+j3/a4eG1TuJGqutikXRsPnR0JUkLSThGYXZQkDNkBhz/AYufvEgRfWYbN0q
         8Dkw==
X-Gm-Message-State: APjAAAXFQlg9BWq4+gUuUXc/R3MKGt8iWhmsusDVfFUXpAAS3C2vYBCe
        bNBJDxy+vmd+Zdli6WiUVL+JtuEkximynHVzkW4=
X-Google-Smtp-Source: APXvYqzMOP5ZARIF6AbS22nvC7Uw+pV2+C/PqGle9CKj0oexeW7SgMZq8LP8Or+xzjLzxbKNoWIVPaDVhiy98icDli8=
X-Received: by 2002:a1f:d8c1:: with SMTP id p184mr18459868vkg.1.1553615315298;
 Tue, 26 Mar 2019 08:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com>
 <CABPp-BEksf4SuD57YsUO3YKhU12CAwFTy6pA1tETFrHB1DAz9w@mail.gmail.com> <CACsJy8DPDEvNDeE5MpqcGZk9jRmT9g=ix+MOhkv+50J3Egef7A@mail.gmail.com>
In-Reply-To: <CACsJy8DPDEvNDeE5MpqcGZk9jRmT9g=ix+MOhkv+50J3Egef7A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Mar 2019 08:48:23 -0700
Message-ID: <CABPp-BFTyALWmnJ=dT1xNivjcQhtKak15ydfkYjEsEC-j4BD9w@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 8:24 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Mar 26, 2019 at 10:01 PM Elijah Newren <newren@gmail.com> wrote:

> Yeah.. --ignore-in-process does not necessarily mean aborting
> something when you just want to get out to examine some other commit.
> And I agree doing nothing seems like the best (or least
> confusing/surprising) option.
>
> There will be some funny thing. Like if you commit after switching
> away and MERGE_HEAD is there, I think you will be creating a merge
> commit.

Yes, and in the middle of a cherry-pick with a range you've added some
commits to one branch and some to another.  In the middle of a revert
you're doing similar.  It sounds like crazytown to me (and maybe we
shouldn't provide the --ignore-in-process flag unless users clamor for
it -- or maybe we should print a big warning whenever people use it
much like we've traditionally done when people checkout a commit
rather than a branch), but it at least makes sense what is happening
and users had to explicitly state they wanted the in-progress state to
just be ignored and switch anyway.

> But I guess if you choose --ignore-in-progress, you're pretty much on
> your own. We could improve "git commit" and friends to realize that
> the current state is unlikely safe to resume whatever in-progress
> operations. But that's separate and I don't want to dig another hole
> to bury myself in while there's still 'git restore' to take care of.
>
> Or maybe I'll just suggest "git <verb> --quit" when the switch is
> successful with --ignore-in-progress.

Combining that with some kind of warning about weird effects of
applying a mid-operation process across branches seems like a good
idea to me if we're going to have that flag.

> > > PS. git-reset shares the same behavior, but it's in a different boat,
> > > I think. Or maybe I should scrap/replace that one as well.
> >
> > reset has traditionally been the home of
> > how-to-clear-in-progress-state.  e.g. aborting a merge or cherry-pick
> > or revert was 'reset --hard' (or later 'reset --merge'), skipping a
> > become-empty cherry-pick or rebase is still 'reset', etc.  So it's not
> > that surprising to me that it clears out state.
> > ...
>
> Yeah but it was surprising to me that this is not even mentioned
> anywhere in git-reset.txt. You learn by examples basically, or by
> experience. But I digress.

Yeah that is slightly odd -- but that at least provides a small silver
lining: it makes it easier to decide to change it and move all the
mid-operation-state-clearing to other commands.  :-)
