Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5D341F453
	for <e@80x24.org>; Mon, 29 Apr 2019 11:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfD2Lf1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 07:35:27 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:41294 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbfD2Lf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 07:35:27 -0400
Received: by mail-io1-f49.google.com with SMTP id r10so8598648ioc.8
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 04:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T1pSud11FuFkTYJfeJkdDQn1ru6NwRrw4Qk2mQiAWXI=;
        b=s/xf07GvnL6Vmi2TIuJxO7uLb4qufDCxtxqhiEsSpBdrFzrDNsWsvsVMhCYhfLCYXG
         Zg5/7fxLqj0pNHk5yKXP5bZWOmtSzngN2i78WS2wFvmaaZlsdZpfsa97lRJhDF7vY+Nl
         vJop6ieJVzMzm7xfEtiveQJ6SD0qwr2M0QtTvQEqz4MVlz38cq3C49xg4xFyci/Ldezo
         6U/RAg7I0asOgqbieckhg5gQ7+b9YCH9FbA8CUE9GTlK/C3p+v9Rd7jRorLsj/daSs+h
         xsXT9IxIlzsPLGncwaE5dGEPkBewuPSgat+KIX+5kDb2scHWHxowKnBw/aJx3cPWRZCk
         8dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1pSud11FuFkTYJfeJkdDQn1ru6NwRrw4Qk2mQiAWXI=;
        b=V1/jyKdK4Dp5/GoTD06LQV8TlTtVqdE8mYQnOcN+JfsT4HRGfrp225lGYFgWX+YA68
         7SX2D3keKk2MhVvYuCpVGzMh+a9rNFbUAJ7ZHJERCRMEEaUxMAccgoEtcmkq5gO+7RpB
         a4j08HbEYYGMXoiiXFVyVCFpRg86csS/2XG+sBkFWS+XL/1mYswTV4ZUxxqrD1DjYtef
         CbnOCuoZ02sMK9bg/2VJG6JgB9MJqGRJ2vh5GZ6gRtW8WTwQ0x+UCW2yI+3LdDjPkAXJ
         4+fYrvr10zsWB58NgurzpGzV31W0vuus92Y3jfNnzsC4SDdGjLPMOOpGNO+jLfKiSykQ
         kF9Q==
X-Gm-Message-State: APjAAAUJmi2vm60E5i6xyGH2WkNRlGfMcgP7agDnxcqyzFGnwut2YhVO
        lOJ2Cm/N3evFH14bEZ2OtfjxuA34ajKb2Q3L+bY=
X-Google-Smtp-Source: APXvYqztwgNd5tUjs4/06FMcUqTFmEMKHiEoSQ9DKAqJ3pUn85ktm2sam584idx2ULnSv7WLiqPA+Wqb2Jxu6O9/N0M=
X-Received: by 2002:a05:6602:58:: with SMTP id z24mr31114989ioz.118.1556537726121;
 Mon, 29 Apr 2019 04:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com>
 <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com>
In-Reply-To: <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 Apr 2019 18:34:59 +0700
Message-ID: <CACsJy8DSW2f3v1KpU-QrAz-EeLwG4mVm9ToDdA2=kXSmtsEAYw@mail.gmail.com>
Subject: Re: Bug: fatal: Unable to create '.../.git/index.lock': File exists.
To:     Aleksey Midenkov <midenok@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 29, 2019 at 6:03 PM Aleksey Midenkov <midenok@gmail.com> wrote:
>
> Reproduce:
> ```
> cat << EOF >> /tmp/check.sh
> #!/bin/sh
> git log HEAD~..HEAD | cat
> # sleep 1
> EOF
> chmod +x /tmp/check.sh
> git rebase -p -x /tmp/check.sh base
> ```
> If the `base` is far away enough it fails with "fatal: Unable to
> create '.../.git/index.lock': File exists." at an arbitrary commit.

I gave it about 2000 commits (from v2.20.1 to master on git.git) to
rebase. No luck.

This --preserve-merges is being completely replaced in latest git
version though. Is it possible for you to try master branch of git.git
and see if the problem is still there?

>
> Abort current rebase, uncomment 'sleep 1' and repeat rebase. Now it
> doesn't fail.
>
> Version:
> git version 2.20.1
>
> uname --all
> Linux lian 4.18.0-15-generic #16-Ubuntu SMP Thu Feb 7 10:56:39 UTC
> 2019 x86_64 x86_64 x86_64 GNU/Linux
>
>
> --
> All the best,
>
> Aleksey Midenkov
> @midenok



-- 
Duy
