Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B20B1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 15:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeK0CuN (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 21:50:13 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38098 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeK0CuM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 21:50:12 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so28414326ith.3
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 07:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F86zNrJvN3cEu2HBJWZ4tZRdhCjLg29ptnXjgWa6xew=;
        b=L/UFLZQD2jUlKQcjuiHtVIjIgiRz2yccocCYXDKwFmxEwe0spCHsDKqGWOz0EwRrYS
         xdgXzJ8A1thDdPa2JUGtioDt2LGqI2U/9BkwxM/EIJS0VEbPzDFMuiXB/0f5CiUzIyEI
         Vqi7D9wlhNC4gZm5jeTrFTtPxJ3J7oM8i/zAuitb62lzNYIqKJ4Gd8+Xszm2+BGfdt/k
         1OdF9wrJQveRcZb66JQI/dRFd+HZkYVmGAuvHAOo+AocxojBr5I/XarOAszZwty54lJF
         YbnEK9qRsRxOA4CDhKT0nkyUq/MC7okWO45RekQm2ZcxYengdV8rabnfHjfxBz9b68R/
         oWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F86zNrJvN3cEu2HBJWZ4tZRdhCjLg29ptnXjgWa6xew=;
        b=dLdwsIPFTvI8IdXDc/0IxsTUrjiQaAhMx3EodA8ZWqgjLLZZ0K2SFdxw2YO/hxTcUk
         d2USdYVioXeFTunGE+F6OSQyJZqcLOFiSML/vc1K3M8TmEqQ0rbRQe3uINrw6Qa8v8dc
         qrXrdai0p3KZJRfTQj9iYvN3z15igAqjBBTuXzskjNWDVa/IDQykJBQADR66sDHfekHZ
         F2Zi1FIGCsTupqR9Mjxbhi83gfmyde4oLJ6YEhiPa9Wqc+1hWfWuefQByur6200M5hOS
         tFEIjVY23Tw/qqA5ao/GuC+lQnHl+VeskT5nnGPrH2VxjI2Bnf9qwYyrP0QMOLFq5GI7
         6elg==
X-Gm-Message-State: AA+aEWYr3rxUgJIwJDEi9atyXBvg6SYapoN6LmP6T07eKeBQMXPHrP9o
        Rp1iaSmg8dSafrhMICHBh6J/i61thLeAsyb1n/8=
X-Google-Smtp-Source: AFSGD/UlyMj5C7gHZm1ZHBcBdABKllmIpfrAXkhIHGg0JcTUMaYSIwwiaUQQaM3iBoiZGoPtvTiGrNXtG25Ef/FwvKI=
X-Received: by 2002:a02:8943:: with SMTP id u3mr24001268jaj.92.1543247741254;
 Mon, 26 Nov 2018 07:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20181111095254.30473-1-pclouds@gmail.com> <875zxa6xzp.fsf@evledraar.gmail.com>
 <871s7r4wuv.fsf@evledraar.gmail.com> <20181112232209.GK890086@genre.crustytoothpaste.net>
 <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv> <CACsJy8AzmgkCm=_pJpcXY4xwujnfx9vFKJgbJ_BB__4UybACTQ@mail.gmail.com>
 <87sgznzwcp.fsf@evledraar.gmail.com> <CACsJy8C4deg=M+sjmTBM-qs_=zZ9KarND3MNaR6-MqxukBJoSA@mail.gmail.com>
 <87pnurzvr6.fsf@evledraar.gmail.com>
In-Reply-To: <87pnurzvr6.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 26 Nov 2018 16:55:13 +0100
Message-ID: <CACsJy8Ck7CZ7JWaN6ark=wrAngywJJh76y-FvJ87gE2ckVS8pg@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     per.lundberg@hibox.tv,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>, git@matthieu-moy.fr,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 26, 2018 at 4:47 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> >> >> How about something like this:
> >> >>
> >> >> 1. Introduce a concept with "garbage" files, which git is "permitte=
d to
> >> >> delete" without prompting.
> >> >>
> >> >> 2. Retain the current default, i.e. "ignored files are garbage" for=
 now,
> >> >> making the new behavior _opt in_ to avoid breaking automated
> >> >> systems/existing scripts for anyone. Put the setting for this behin=
d a
> >> >> new core.* config flag.
> >> >>
> >> >> 3. In the plan for version 3.0 (a new major version where some brea=
kage
> >> >> can be tolerable, according to Semantic Versioning), change the def=
ault
> >> >> so that "only explicit garbage is garbage". Include very clear noti=
ces
> >> >> of this in the release notes. The config flag is retained, but its
> >> >> default changes from true->false or vice versa. People who dislike =
the
> >> >> new behavior can easily change back to the 2.x semantics.
> >> >
> >> > How does this garbage thing interact with "git clean -x"? My
> >> > interpretation of this flag/attribute is that at version 3.0 by
> >> > default all ignored files are _not_ garbage, so "git clean -x" shoul=
d
> >> > not remove any of them. Which is weird because most of ignored files
> >> > are like *.o that should be removed.
> >> >
> >> > I also need to mark "precious" on untracked or even tracked files (*=
).
> >> > Not sure how this "garbage" attribute interacts with that.
> >> >
> >> > (*) I was hoping I could get the idea [1] implemented in somewhat go=
od
> >> > shape before presenting here. But I'm a bit slow on that front. So
> >> > yeah this "precious" on untracked/tracked thingy may be even
> >> > irrelevant if the patch series will be rejected.
> >>
> >> I think a garbage (or trashable) flag, if implemented, wouldn't need a=
ny
> >> special case in git-clean, i.e. -x would remove all untracked files,
> >> whether ignored or garbage/trashable. That's what my patch to implemen=
t
> >> it does:
> >> https://public-inbox.org/git/87zhuf3gs0.fsf@evledraar.gmail.com/
> >>
> >> I think that makes sense. Users running "git clean" have "--dry-run" a=
nd
> >> unlike "checkout a branch" or "merge this commit" where we'll now shre=
d
> >> data implicitly it's obvious that git-clean is going to shred your dat=
a.
> >
> > Then that't not what I want. If I'm going to mark to keep "config.mak"
> > around, I'm not going to carefully move it away before doing "git
> > clean -fdx" then move it back. No "git clean --dry-run" telling me to
> > make a backup of config.mak is no good.
>
> Understood. I mean this in the context of solving the problem users have
> with running otherwise non-data-destroying commands like "checkout" and
> "merge" and getting their data destroyed, which is overwhelmingly why
> this topic gets resurrected.
>
> Some of the solutions overlap with this thing you want, but I think it's
> worth keeping the distinction between the two in mind.

On the other hand all use cases should be considered. It's going to be
a mess to have "trashable" attribute that applies to some commands
while "precious" to some others (and even worse when they overlap,
imagine having to define both in .gitattributes)

> I.e. I can
> imagine us finding some acceptable solution to the data shredding
> problem that doesn't implement this mode for "git-clean", or the other
> way around.
--=20
Duy
