Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C151F461
	for <e@80x24.org>; Tue, 27 Aug 2019 23:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfH0XqX (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 19:46:23 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41512 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfH0XqX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 19:46:23 -0400
Received: by mail-vs1-f66.google.com with SMTP id m62so633724vsc.8
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 16:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRQG1qeL2TSoHWJ9LSmJmVJhBVv08TAYwRiz1fYlgxA=;
        b=0Zjnc6Vdx4AYFUyc0IGVz1pTdKkEM5k7dx1N2jpZE+1GVpGMiw7S8YeZNuVfzyOYRZ
         XssarFFIqX7eiWUzMjQVz1XklivVZnXSWnPxuN+/U0rA2FIHCJRR1O8qTi6/SV6ts8xQ
         br4sP5WNPENAfWGbyJK7hqFW+0xHR+ORHB/N8zH84Ib19WapsJgOvljyFkl3D46BwAPp
         r8WzbMwI1IOnChPf2lr99Ks5DozPsj7jFmel/rAPacbYcIyZJm05cBNyd0JDJBlo4afw
         txFZKdghlOp5MU05+cH8K1InJbGuStoOhJLTUioDaCIPI0fcKeU7Ml96TnFa/8T1uPm4
         U/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRQG1qeL2TSoHWJ9LSmJmVJhBVv08TAYwRiz1fYlgxA=;
        b=Wqbs90L8D3jEL1p+jB3qMx1Fzcl1Gb0UDI9kuB45N5+k88g6B6P52NouHdtoSjXCd+
         U0klx36D0shrqhFtaR1N3x2P6Lz748a09LFKBLm04CKeGGI3X+oLu8AOYtwTcz5KxhNo
         EjXJJ64uhZM1J51ubcTAU2PlRmJCkg0bMfgwr0/Ppgedadnn+zOV73heqTB7lxv2oYjk
         5OxJa3Iv5uMuYkqt07K9YUM1JJjwvXvdMX4fZX1peSU3IW9X2Wm9BIPdu6v11bNHWpua
         JplfPXLoTf9RO36j8L77WHASzGUZ/zZZZOHruhlifLnR5lPjrM2gF53n7sBVCD4tXjsz
         9Axg==
X-Gm-Message-State: APjAAAVjS7xm++/fXaQYRMH4qODqjFVkquW8XMMMp3itGK4rdOghtlzY
        4CKU5B1a8qKrFjJJB+zpKFNhzmcDvDo3wxnfzRru5A==
X-Google-Smtp-Source: APXvYqxqR5vKLB91lWP8Db5vKn5IVsHgSd0+uBja6gqHaD6JeD3kBAw/1TRhmaqdTvIXsF+GYNF6ML5DunAGB4mtjPw=
X-Received: by 2002:a67:ce83:: with SMTP id c3mr753296vse.98.1566949582285;
 Tue, 27 Aug 2019 16:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566863604.git.matheus.bernardino@usp.br>
 <4920d3c474375abb39ed163c5ed6138a5e5dccc6.1566863604.git.matheus.bernardino@usp.br>
 <CACsJy8Dry7MfKBi5EKw4Ka9r63QVmDjPv9nAozS0mC6Z7-sG=w@mail.gmail.com>
In-Reply-To: <CACsJy8Dry7MfKBi5EKw4Ka9r63QVmDjPv9nAozS0mC6Z7-sG=w@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 27 Aug 2019 20:46:10 -0300
Message-ID: <CAHd-oW4h80xrp6y65dqZbq_a67ncArC9rrNq7F7rAhBbrALOkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] config: allow config_with_options() to handle any repo
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Duy

On Tue, Aug 27, 2019 at 6:26 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Aug 27, 2019 at 6:57 AM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > Currently, config_with_options() relies on the global the_repository
> > when it has to configure from a blob.
>
> Not really reading the patch, but my last experience with moving
> config.c away from the_repo [1] shows that there are more hidden
> dependencies, in git_path() and particularly the git_config_clear()
> call in git_config_set_multivar_... Not really sure if those deps
> really affect your goals or not. Have a look at that branch, filtering
> on config.c for more info (and if you want to pick up some patches
> from that, you have my sign-off).

Thanks for the advice. Indeed, I see now that do_git_config_sequence()
may call git_pathdup(), which relies on the_repo. For my use in patch
2/2, repo_config_with_options() won't ever get to call
do_git_config_sequence(), so that's fine. But in other use cases it
may have to, so I'll need to check that.

> [1] https://gitlab.com/pclouds/git/commits/submodules-in-worktrees
>
> --
> Duy
