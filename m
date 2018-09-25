Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9371F453
	for <e@80x24.org>; Tue, 25 Sep 2018 15:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeIYV5i (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 17:57:38 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37082 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbeIYV5i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 17:57:38 -0400
Received: by mail-it1-f193.google.com with SMTP id m9-v6so2448936ita.2
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4upH6MdsY2EvjS6t24Szgb5PoVlgGyEke1qouY5MWw=;
        b=r4hZAIpnISIiKaIdEPZLh1ygagDFekqFv6t5CXCawT89FxiWh8grmDf8cixG18u2xC
         suU4QMoX9vzx6ENSRAT8tqKzDsAv1hsNoep//ag7BCGe1Q8gW6ThVuXSZFBG+1F7KW7p
         ApgyAvfPfsbySiiJ+jZ0gnssRoIsg+KJIXEy2owDt9zfUNKfJVE5ACfREQc8UkxavOzZ
         oBG3zjgGt6icT/FK1lgDFsr1uM0L8xxJpViAZMXm9ZP7vWqABJL+4Z8pMqN/gQeFJSgY
         SIUfL8G6nlqMq26n8SMxH1f5YfWl5lJz6XDe+t6vu6atCu8SC4N792nxIN42N1z792ZY
         fXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4upH6MdsY2EvjS6t24Szgb5PoVlgGyEke1qouY5MWw=;
        b=TTc0B6QmNX8tVjLvf2qdIYkAX/QcprCbCxec5eQVM8cuVAGmWmw1RNr9v9rfEf3xOM
         /JUWz60UWbJBSV1NBhcPDNVTn6gAy5Y0+DSAt1UbgEob4tzHCXRNdhhMaEnXxO5IZUzC
         LcXZEbs4BjrJ51lLFMXB+jPcC065kG1H7nJ+Nex/Up3t5o4DSSrpA1/uXFkcm8ZgAoNu
         I7JogBFhQG8RIjZRChbzaYdZG1oXSegwOSftSiG8Wu1KaV3Cj0tXhpQ25xf/rPBhE+G8
         2oB4KOyg5tDRGD8famx12oL3jjDbI1om6hEPClEPqRJeVV4CvqybV8xgQhljyiz6yE6O
         YSzA==
X-Gm-Message-State: ABuFfohEs3WpFay/Zsn+6wozO0tQjffFx1Jhb0gOI53ccwvpqPg6AQax
        iY+j7C4SP3vqW8GAgB/5q8HlYSQVbCbOkzUJMy8=
X-Google-Smtp-Source: ACcGV61zyLg3vSqCos1jckCE2nhPyydXeFmXUFoG+vJRnKI1g0sB+UPtTLTjWE6ZgicZVRQdBCDwmes3CCP/AwsIy6M=
X-Received: by 2002:a24:aa41:: with SMTP id y1-v6mr1320995iti.91.1537890571438;
 Tue, 25 Sep 2018 08:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-4-pclouds@gmail.com>
 <CAGZ79kYTzs=Xx-K-ghUa=as7Q0tiw-z1h7_D2=6zaO3fpWMrWg@mail.gmail.com>
In-Reply-To: <CAGZ79kYTzs=Xx-K-ghUa=as7Q0tiw-z1h7_D2=6zaO3fpWMrWg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Sep 2018 17:49:05 +0200
Message-ID: <CACsJy8DsykQzUzx7iTqPeuGBSJ9gcEHJRw_UCXJCrsXxf+hntQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] refs: new ref types to make per-worktree refs visible
 to all worktrees
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 4:48 AM Stefan Beller <sbeller@google.com> wrote:
> > This patch also makes it possible to specify refs from one worktree in
> > another one, e.g.
> >
> >     git log worktrees/foo/HEAD
>
> This has strong similarities to remote refs:
> Locally I may have a branch master, whose (stale local copy of its
> distributed) counterpart is named origin/master.

If you think of each worktree as independent clones (which is more or
less true, the fact that they share ODB is more like an implementation
detail) then yes it's almost like remotes.

> It is also possible to have a working tree named origin
> (just I like to name my worktree "git", when working on git.git),
> how do we differentiate between the neighbor-worktree
> "origin/master" and the remote-tracking branch "origin/master" ?

Hmm.. I think you're thinking that origin/master could either mean
refs/worktrees/origin/master or refs/remotes/origin/master. I do not
think we're going to support expanding origin/master to
refs/worktrees/origin/master. This part about ref resolution did cross
my mind but I didn't see a good reason to support it.

Even if we do support it, this is not even a new problem. If you have
refs/heads/origin/master and refs/remotes/origin/master now, we have
ref ambiguity anyway and a solution for this should handle
refs/worktrees/origin/master well if it comes into the picture.

> As the remote tracking branches are shared between all
> worktree there is no need to differentiate between a
> local-worktree remote tracking branch and a
> neighbor-worktree remote tracking branch.
>
> Now that you introduce the magic main working tree,
> we also need to disallow working trees to be named "main",
> i.e.
>     $ git worktree add main HEAD
>
> produces
>
>   $ ls .git/worktrees/
>   main
>
> How do we deal with that?

main is accessed via worktrees/main/HEAD while the main worktree's
HEAD is accessed via main/HEAD (which is _not_ automatically expanded
to refs/worktrees/main/HEAD). But if it is, yes we need to detect
ambiguity and tell the user to specify full ref name, either
refs/main/HEAD or refs/worktrees/main/HEAD.
-- 
Duy
