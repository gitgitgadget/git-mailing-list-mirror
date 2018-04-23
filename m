Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32CFB1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 18:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932256AbeDWSLI (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 14:11:08 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:38558 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932164AbeDWSLH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 14:11:07 -0400
Received: by mail-yb0-f175.google.com with SMTP id w14-v6so4274197ybm.5
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RwsdBpuAO8jkrDfWIi6wuJqmd2dMZDg2GdWIQHqYjac=;
        b=ppxJ1WMvWbJHADMPHFwOD+AVroWnUlgRCbe1mGnf7uaMdYmpKUP0+cGyxVjbMp7HUu
         pMAqkwBcFXSi4dcpbMmSSRavvtivAnH4KmFoouUcMDAbths39iBLZjf9kMMjvwSgyNj0
         7+dvqM9/iaV9JPVxsi0tqPKTw+tok3JLydNhg5zdmBGPMvgYR59fXGz5ewW6QaSw9pn5
         bRS1ahfba7GWgizqun6XJEs68mkIBWIBEp4fXkf2yNW7dj5b1//ZalGZOHBJtXdbBx8x
         42eIXCk7VeHmwfkS+kEz7qGb4JOVAlem4JLcjEyfBJO4SL1hbYhJXnllYCOgnpVFJgXQ
         yERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RwsdBpuAO8jkrDfWIi6wuJqmd2dMZDg2GdWIQHqYjac=;
        b=QCUbVAyvNZUbATWHryb9tVx/IbGe4YSZvg87gSvcO6Jc7B36zjyfBDoIXQeieAo32N
         w+lrf4BwqwaxcDz8FTz/0TyTPZboTyVHjmRos1Q9WHieqeptyMvP7LquLVx+kx1e0W/D
         rhMBG+wGKhNK1yJ+TUCK5Uz2ZymcRo6YhNj5Y7SaAKlXkhUF2P49N+2aCJxeEv6W4M9K
         17PozIA2yi+SUQzx4fa9tcsBUSs1DXXh3vMLRzgZ5NfLFwU9cKn2ybnYLDFTISjwkfFb
         l9ICvFwbxAa0QcxmMjSGp1mHtU5q91PjNnefPcSy7JJvmeSjKcX3m9BZcbhyB/M6ZET/
         +mSA==
X-Gm-Message-State: ALQs6tAnvTLdg8sRMNIoXsRfOoKKhvcyh6MsVDH8YGhRxjArPYc7TVtj
        tHXEc8FzeZKvjiNeIAULtbLI2cT/Um9RezFwi1uhoQ==
X-Google-Smtp-Source: AIpwx4/DS/h58uoO64gK81Z4x1bY+htPl/CiE3rygmJlzjHe0/g8gXcwv/55AyvcQJJdKKaeVWDdCAqTA6ksLBLlZF8=
X-Received: by 2002:a25:8e09:: with SMTP id p9-v6mr12315242ybl.352.1524507066684;
 Mon, 23 Apr 2018 11:11:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 23 Apr 2018 11:11:05
 -0700 (PDT)
In-Reply-To: <cover.1524296064.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
 <cover.1524296064.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Apr 2018 11:11:05 -0700
Message-ID: <CAGZ79kbK7j0njrZ8-d_Da6+XyH_RVRhBu=hcpzr7EFsOCSFJVQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] rebase -i: avoid stale "# This is a combination
 of" in commit messages
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 21, 2018 at 12:34 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Eric Sunshine pointed out that I had such a commit message in
> https://public-inbox.org/git/CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com/
> and I went on a hunt to figure out how the heck this happened.
>
> Turns out that if there is a fixup/squash chain where the *last* command
> fails with merge conflicts, and we either --skip ahead or resolve the
> conflict to a clean tree and then --continue, our code does not do a
> final cleanup.
>
> Contrary to my initial gut feeling, this bug was not introduced by my
> rewrite in C of the core parts of rebase -i, but it looks to me as if
> that bug was with us for a very long time (at least the --skip part).
>
> The developer (read: user of rebase -i) in me says that we would want to
> fast-track this, but the author of rebase -i in me says that we should
> be cautious and cook this in `next` for a while.

I looked through the patches again and think this series is good to go.

Thanks,
Stefan
