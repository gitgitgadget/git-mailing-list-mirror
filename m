Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37C9A20248
	for <e@80x24.org>; Fri, 29 Mar 2019 15:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfC2P7C (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 11:59:02 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43425 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbfC2P7B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 11:59:01 -0400
Received: by mail-vs1-f67.google.com with SMTP id i207so1567829vsd.10
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=byyfw1z7m1sj4Pxd6LUh5uu+PpPbzcTzgDp/biJ4ewk=;
        b=cF42VgAE62DynK7Aw3Fxa68JiVJplekKmlucrkdrSbgDf8muQv5bOAhUP49WMZAh7x
         OfkGTWXyu6wMq0k0NdcyjDmjkqcfHksGYPxYBGk4Iwvmun211+r1zKnI03yHjiOne3of
         aljezvS7ihoxyDaRLdnU/HSGfR7QhY9K+7S2NpJ4wLFFdtve9KOUsCPNapW2YrL3uRR5
         f6xnT2r5TrHIp2Gexa4Zri6hH2RP1xiqK/FrdGogpV/lX9UCkhaSwKRbs3bd6T9b83a5
         Hr+s8k37P85QKmuk0Q1JOHPgiqXZ6ykev1th170v5oo6QoeJGYwFpgQpz+zq8VSpsSZ0
         Gixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=byyfw1z7m1sj4Pxd6LUh5uu+PpPbzcTzgDp/biJ4ewk=;
        b=H7yFGQkvPLmh7pR70WzYhGHk7HfvGVFSLnTswOvo6YodFcJCfgIuujI7j9rLBB0K0U
         ErdwHenfLkmrXvTETcou/wm1jl8RE+sEfE39mqYBsLYttbo0BY+UJ8bGl8VAC9x2kKaB
         dHK5zZjsxI6IDKR4hp7PrPRdOR0cZtmxs10vLZfm/9eIAi8alf48ywEij/tNuGaK5l4x
         H4zZKgZD/w4yD9mwmab2wEISaudD5nCwkTNNsd8eEZX7nmRgYNqmbkSo9YRPii+A7E/d
         9sEbEI/vaqaHINPUZi1IJjUhZahDBvbE4WMYqp9XqQs58AIuXQhAHfF8NG7gbGmsVJG/
         J/9A==
X-Gm-Message-State: APjAAAXiwL819oWsWdeYUkswSLFIUGMIT1Had3wgz4o573JZBAARo9NT
        fWl8YZwmv0PgmZd3NPJqESAXbtqQOhycuxmw3zhz0g==
X-Google-Smtp-Source: APXvYqy14VfQ9iWPw+uGNjGYJCbDud9OAbwp79SM2N1KYNlCeuvPjVLe9RhsiRyi/bXVPjtCUbYBWakotLkgiObN8XU=
X-Received: by 2002:a67:f416:: with SMTP id p22mr31537716vsn.175.1553875140589;
 Fri, 29 Mar 2019 08:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190321131655.15249-1-pclouds@gmail.com> <20190329103919.15642-1-pclouds@gmail.com>
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 29 Mar 2019 08:58:49 -0700
Message-ID: <CABPp-BGFNzroixaO1QN7Q_tepTzeFGjd5-=M3Rfv2CH+pHjaLw@mail.gmail.com>
Subject: Re: [PATCH v6 00/27] Add new command 'switch'
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 3:39 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> This adds a new command 'git-switch' as the half-replacement for
> 'git-checkout'. Jump to 13/27 as the starting point. The other half is
> git-restore, which is dealt with separately.
>
> The sixth time must be the charm, because the seventh time may be the
> curse!
>
> The last big change since v5 is from the discussion about
> remove_branch_state() and its relation with --ignore-in-progress. By
> popular demand, --ignore-in-progress is gone. The discussion is linked
> in 23/27, which is also improved to suggest a way out.
>
> That discussion also leads to a new patch, 07/27, which improves 'git
> checkout' and tells the user when merge/revert/cherry-pick is canceled.
>
> The rest is just minor updates here and there. And I made sure the
> sign-off is back this time :D

I looked through the range-diff and it looks good to me.  I think the
safety we added to switch could also be added to checkout, and I think
we're narrowing down on how to safely support --ignore-in-progress in
certain situations, but both of those things could go in after this
series lands...and both might generate more discussion that doesn't
need to derail the rest of this series.
