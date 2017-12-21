Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14D451F424
	for <e@80x24.org>; Thu, 21 Dec 2017 23:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754695AbdLUXIM (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 18:08:12 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34562 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754544AbdLUXII (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 18:08:08 -0500
Received: by mail-qt0-f178.google.com with SMTP id 33so34412807qtv.1
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 15:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lt9QAfRfsKqUoylEc0sbkkwAUvw9SCwILwCPZX4KZ0M=;
        b=uBKttTLNirO6Iq03uI3MJkoVxYic85/SHy6G81QpQWi1T/oo4/l2JePJqY+MILRQWG
         qiuoGwvbsFZkiSjaHL0odjCKWEJXi5IX0NX3ASiF71er0gm6dxBW04eJgNGlnFIzZHdQ
         r9iGKvq7ywDD8/m2lkkX35nH+iMbiO8KpCywQ9GpaTyQKYCvvX7yxbfj/4Qm0MJiL8pn
         DYAhx/EloKZzitEBm/RqLu2q9w4VSfnqpa/4RD6uWVZ9o1uzcZBjZ0TuU4Fxot2WeXp6
         mYSRrxBBslaoIMDLosR0xG6OVSGgBanYSzlkCF1yJb1tE7sL++jTBGbBfzpgpNa18O8k
         m/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lt9QAfRfsKqUoylEc0sbkkwAUvw9SCwILwCPZX4KZ0M=;
        b=ubjnDijIkGFUeBiVUjFXRzv0VXdDftbTMImzMPTDgsPvL69lp811oR1dDNpm9qiEMs
         1P5Qv36NaxAvgg8Ojwh2boIxdp0VPrqAKeOzRJNLpikVXS11XEv8j0OdKhj7CZQtuTek
         EOCEhuK9kW4HBB3/6zK00D53y0Bnj/ZdXm/Xg044r/2NSah1FX9ZAHcImJsCKVGUEKx1
         Gsyy2oDqEz4BheDF5+VNub4w1bz19MtxDureCc0McwJavQFTQ+y1kKJgAt2yEcbxTGGC
         OveA9PhRp0aq05PBWupyvz0ZGyEArPdGiKlq6NSKVSLuarK/HSZJ3nekFVWdaIpqJUns
         M0xA==
X-Gm-Message-State: AKGB3mJlj0vxCk2XeQIOto70syP+VTyUOHazwQCrrUk1+HVW2bQ1duaR
        J93n9XAPEp8YyqXsJ+8ouyKv3WmRpQSuR2h0VTkpGcW0O94=
X-Google-Smtp-Source: ACJfBouDQWv7s83zT5sSn2PTErT2AL+cM+5+Q0KscGSmFacb2xY3Ngg3mYPq/P2hl+B2f9+k+nAqTk6Pa/5d8JfIfz8=
X-Received: by 10.200.36.22 with SMTP id c22mr17587126qtc.207.1513897687706;
 Thu, 21 Dec 2017 15:08:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 21 Dec 2017 15:08:07 -0800 (PST)
In-Reply-To: <CAFBGMVOjCK_XnqJpTvPs=joXgfOH9SDWe0pJwmgYx-5-+FL+uA@mail.gmail.com>
References: <CAFBGMVPBwxeSXCTcoBdxDbYtJo-38w=tf4T6-rNWuys=3drP+A@mail.gmail.com>
 <20171219180230.254881-1-sbeller@google.com> <xmqqk1xitl6l.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbqntXuYuLGF7zjXfQ5X998QdEba20yy8A0cqS=DaRxFA@mail.gmail.com>
 <CAFBGMVO+P99hJ_nKgCJ4OqhMEdRdc3m8KHNS1pPrrhU_0wS6=A@mail.gmail.com>
 <CAGZ79kZf8GL1DY6Vmc-byEOOy+hrKF8X8qRPM6jNO-La+rD4uw@mail.gmail.com>
 <CAFBGMVMmLX4BjkQ8Xd4bQBCgoYYxWTU-p2pNF=b8JNsUsKXwUA@mail.gmail.com>
 <CAGZ79kauYRLaPKsUKxvsc-T+KzMt2UsyoDLzdyZON_vjp6y28w@mail.gmail.com> <CAFBGMVOjCK_XnqJpTvPs=joXgfOH9SDWe0pJwmgYx-5-+FL+uA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 21 Dec 2017 15:08:07 -0800
Message-ID: <CAGZ79kY1=TysCagomHaqzV4w+3DMpdTQ2ki9tVHbL4pYRecXMw@mail.gmail.com>
Subject: Re: [PATCH] Re: Bug with "git submodule update" + subrepo with
 differing path/name?
To:     Andreas Urke <arurke@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 21, 2017 at 2:17 PM, Andreas Urke <arurke@gmail.com> wrote:
> Thanks for the detailed explanation. Although I am not too git savvy,
> I believe I got the gist of it.
>
> Regarding your question,
> I would say the term "name" in an IT context makes me primarily think
> of something that is specified by a user (as opposed to e.g. an "id"),

ID sounds great.

> and can be altered by a user. Also, the manual mention it as a
> "logical name", which would further strengthen my belief that it is an
> abstraction which can be changed (as opposed to something "physical").
> I would be much more reluctant to change the id of something than its
> name.

If you changed the name in all places, it would have been no problem. ;)
So once you did the "git config -f .gitmodules --rename-section ...",
you'd also have to "mv .git/modules/<old-name> .git/modules/<new-name>"
and then it would work fine for you. (You would also need to instruct
any collaborators to run the move command when they pull your changes.
So it is more of a "in theory it works", rather than practical advice here)

> In terms of the commands...In an ideal world I would obviously ask for
> a --rename or mv command which would achieve what I wanted to do.
> Other than that, maybe a word about this in the man for "git mv"? Or

git-mv moves the path, not the name of the submodule, though.

> perhaps "git submodule sync" could give me some kind of warning that I
> did something strange/illegal.

That is harder than thought, because it is normal that a submodule
worktree doesn't exist at the given path (not initialized).
Also it is totally valid to have outdated entries in the .gitmodules file. :/

> Can I ask you, now that I have made this mess, do you have any
> suggestion on how to rectify it or some other way to achieve my goal?

Looking at the script you had above, I would think you need to init
the renamed submodule again, not sure if anything else needs
to be done, as now you'd have essentially two repositories inside
the superprojects .git/modules/ for just one logical submodule.

So I would assume if you were to re-clone the superproject
everything works out fine again (except for bisection/checkout
before that rename. ;) But for that you can symlink the
oldname to the newname inside the .git/modules/ of the superproject
I would assume.

Stefan
