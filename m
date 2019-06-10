Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D8C1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 13:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390561AbfFJNzm (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 09:55:42 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:36600 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389373AbfFJNzl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 09:55:41 -0400
Received: by mail-oi1-f172.google.com with SMTP id w7so6286753oic.3
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=40fY7dFDSS7MMka0K3OjuoHLLvNZpIpeS42K3j/eXag=;
        b=IbaGWmA0SQ84DSkvqiXm6cZ1ADBVf7LpGOT38E8A9mWVVr2p6EEscmG/8suewTIz9t
         cTokt6dgT6cnIJPuft74gHBuyPfbFYlO1zVzWUB2yM2NVM3PgGIkeIzBwzHk0grGWNty
         w/UgF+Cq0iJwJ3GMu9oPzxT5KNFAGqWq8VA4mzU7pIYU6FVXijEMKzG9nqab8ER5Qb4p
         at8t2MZK9gPzFRLZt/kxO2suV5QunmlHaI2/UcB8GVqhXJK7dUYCe4NI0Fiuo8TziZih
         16YHJ1gwVsJ9WyIFw4wsIrWDpIQb4rL7jMncDm6/mNaHsNpIn6i9GkE59yusZ5LgwJmx
         RQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=40fY7dFDSS7MMka0K3OjuoHLLvNZpIpeS42K3j/eXag=;
        b=lfd0AdgAbE+E8cBzCB2onAUTZU1yTt6+vUcfJVeZOXk7JMJTYO3B/aSRY8fbI2Ot3K
         BJ/cFB6yFZvo5TO2L+pvQj2iHUkogFe8l885k6rSpB8A0GQJSFSyYHhKda1uRlSLZAwS
         MNBsPfSVDxVp6Io9HSy3HcrcwjQ8zuvJLE/CCnnYzLvdcnlG8Lcj0h/xyADJ9uW/oo9N
         Oj3oUeKuaJVgYVbeX5dJ2fEjnyjK7clWQGslNLwbvOU0UJ5RsqyESGH7q89zP6v+pmdi
         5IczoTnn5KHdmSIOJkqt8wpiYS1Gqz+nmwpMi19FIt6Cgw8/9Po9m1whxcsFOQFiJ51U
         /ndQ==
X-Gm-Message-State: APjAAAWMUoTzM//qoj7Ga1y+inY32o7CTDtJWZ9PzTV/HoqXcCFSCy6O
        bjjCTEwdjfhFeFcXKvGD3xBWJxNVdqQ9zh6x+pdMTr7w
X-Google-Smtp-Source: APXvYqwvP40QeBKwENdWOK3ODWjPXjCObwsynM/KZhLeVwi/JY8ZcxsDvN1OfO7nwvLaLTNQ9fUTyvwtsJQNSvRYMOw=
X-Received: by 2002:aca:a896:: with SMTP id r144mr11805826oie.105.1560174940921;
 Mon, 10 Jun 2019 06:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAGHpTBKSUJzFSWc=uznSu2zB33qCSmKXM-iAjxRCpqNK5bnhRg@mail.gmail.com>
In-Reply-To: <CAGHpTBKSUJzFSWc=uznSu2zB33qCSmKXM-iAjxRCpqNK5bnhRg@mail.gmail.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Mon, 10 Jun 2019 16:55:29 +0300
Message-ID: <CAGHpTBLvVLY4YTp6c1x66WvO-OsqqTQ_-DAvBi20LFz-BG0+uA@mail.gmail.com>
Subject: Re: Performance regression on git fetch in 2.21
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 12:14 PM Orgad Shaneh <orgads@gmail.com> wrote:
>
> Hi,
>
> git fetch in my repository *when nothing new is received* takes 2.5x
> the time when comparing 2.20 against 2.21 (on Windows it's 4x).
>
> I have 5 initialized submodules in this working directory.
>
> I reported this issue on git-for-windows github:
> https://github.com/git-for-windows/git/issues/2199 but there is also
> an upstream change related.
>
> I bisected and found this commit to blame:
>
> Building... Fetching... Failed [10.7949124]
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [a62387b3fc9f5aeeb04a2db278121d33a9caafa7] submodule.c: fetch in
> submodules git directory instead of in worktree
> running git-bisect.rb
> Building... Fetching... Success [4.303592]
> be76c2128234d94b47f7087152ee55d08bb65d88 is the first bad commit
> commit be76c2128234d94b47f7087152ee55d08bb65d88
> Author: Stefan Beller <sbeller@google.com>
> Date:   Thu Dec 6 13:26:55 2018 -0800
>
>     fetch: ensure submodule objects fetched
>
>     Currently when git-fetch is asked to recurse into submodules, it dispatches
>     a plain "git-fetch -C <submodule-dir>" (with some submodule related options
>     such as prefix and recusing strategy, but) without any information of the
>     remote or the tip that should be fetched.
>
>     But this default fetch is not sufficient, as a newly fetched commit in
>     the superproject could point to a commit in the submodule that is not
>     in the default refspec. This is common in workflows like Gerrit's.
>     When fetching a Gerrit change under review (from refs/changes/??), the
>     commits in that change likely point to submodule commits that have not
>     been merged to a branch yet.
>
>     Fetch a submodule object by id if the object that the superproject
>     points to, cannot be found. For now this object is fetched from the
>     'origin' remote as we defer getting the default remote to a later patch.
>
>     A list of new submodule commits are already generated in certain
>     conditions (by check_for_new_submodule_commits()); this new feature
>     invokes that function in more situations.
>
>     The submodule checks were done only when a ref in the superproject
>     changed, these checks were extended to also be performed when fetching
>     into FETCH_HEAD for completeness, and add a test for that too.
>
>     Signed-off-by: Stefan Beller <sbeller@google.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> :040000 040000 2bad86c248b79ef1e36ea5edaa423cd73445c9a2
> ad989a8f3e6f80d4f5a84ec3db0ff1ab00a7e210 M      builtin
> :100644 100644 d1b6646f42d5d12740a94f50a7d25aad4aa356bf
> b88343d977d78364b417e2015eaa352dec1501b9 M      submodule.c
> :040000 040000 a3c58919de0796b6467709a0f21fa21e28d4d13b
> cdf9514c9085efcbfcdba8efc765174f6455ce5d M      t
>
> Can you please suggest a fix? Is this the expected behavior?
>
> Thanks,
> - Orgad

ping

- Orgad
