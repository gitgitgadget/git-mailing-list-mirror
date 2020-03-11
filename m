Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id 02EFB7D910
	for <lwn-git@archive.lwn.net>; Wed, 11 Mar 2020 15:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgCKPn2 (ORCPT <rfc822;lwn-git@archive.lwn.net>);
        Wed, 11 Mar 2020 11:43:28 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:41156 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbgCKPn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 11:43:28 -0400
Received: by mail-lf1-f51.google.com with SMTP id q10so2119214lfo.8
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 08:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to;
        bh=ioZn0VavISO584+xvoSQedNkp1MXy9rD01ghgLQeRhY=;
        b=fhi8ry3dn4dyhTgOp+PkTSqUXKDELLOjJ451K2v7Pct9tYW9udUkpA8TjC8GxZWqSr
         Zlf4UFoCYwcsV/FuOuD+UB1xHfvNDPj1c1KcW8NYNU6vWAxuOZim99CQdfmYkn/vl5ui
         Ve6TN//UQlLn7RooN2qVPdFT/JqOeRTUJbo+BbzU/LOaMq7GUQkha96eWiVaokk851FV
         F+BH2jHxtzyxS/pp+R8QoGIG4XEl43K3m1j2NxryiVpt7N+RGSVLUoi0YX/FVrHKBxuX
         brWrmtPd381b2efBg5FfNsNhd0Xp07/KgUAPR5i9M1rMrgI0IuwwaRqpgo0uxor0JCZa
         ew9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to;
        bh=ioZn0VavISO584+xvoSQedNkp1MXy9rD01ghgLQeRhY=;
        b=Cyfbdmo5PNkrusueFdWXYyC5yEYVh0VL+u6Y8u0XagByQPazE8q+FCxCvHKFhnfoe5
         tFnF2my6ZC4jZRfJ8GztXEavHDbtTrYN545plO46e5y8SUOygTR56zMq3p0Uk/44KWom
         ORr/VccmZTiWYqaRhFQOtkT0jZQkohjKb6tV3bzf+BPmSiBO5s5vVU0TiQfG2G3kH3L9
         /GRL4YWSuloZGYs8USZ/Vwv2wzN5WF5ShAyuTwL+eCM8kVgzr9FscHOYAsfRgh6+Y3R+
         iKkEqvj8UhDp9IgrD1UqB1sO+m+RaGU3SnP69MFPK+47uniXTaf9NnEGZ912yLYr3E4k
         9t2Q==
X-Gm-Message-State: ANhLgQ3SyHdrx57jCbsDJnV2rxH7HSUYM1WqmVjfZHYHcQKXjxK+pZhU
        DdOMvZ+FPk3PHPX9V4gCG0Nx42hUXAVSwJ89vUQ1youk
X-Google-Smtp-Source: ADFU+vu32UiNnickTGwJ2cpCj+YSI8lKGHJiN/PHZN3aE/fiLuiDAoiZ4ZZPWKdqOKOApjPnxD1CkzvKfZo/myvbse8=
X-Received: by 2002:ac2:52b1:: with SMTP id r17mr2537465lfm.205.1583941405096;
 Wed, 11 Mar 2020 08:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BhLe0xF_k2ASV=ZuM7LVvxui_cxzB9UrJ2MDCyyNUmtw@mail.gmail.com>
In-Reply-To: <CAHd499BhLe0xF_k2ASV=ZuM7LVvxui_cxzB9UrJ2MDCyyNUmtw@mail.gmail.com>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 11 Mar 2020 10:43:14 -0500
X-Google-Sender-Auth: kL1SsXXFO9t9pqizqdJsnA9xCLA
Message-ID: <CAHd499DcLsffD6RHK2x-k3JWk4BtR-NLx_WnAYesz9d+w_m8AQ@mail.gmail.com>
Subject: Re: Using push.default with push.remote.push
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/git/CAHd499DcLsffD6RHK2x-k3JWk4BtR-NLx_WnAYesz9d+w_m8AQ@mail.gmail.com/>
List-Archive: <http://archive.lwn.net:8080/git/>
List-Post: <mailto:git@vger.kernel.org>

On Wed, Mar 11, 2020 at 10:41 AM Robert Dailey <rcdailey.lists@gmail.com> wrote:
>
> With the specified configuration:
>
> ```
> [push]
>     default = current
> [remote "origin"]
>     url = git@mydomain:myrepo
>     fetch = +refs/heads/dev/john/*:refs/remotes/origin/*
>     fetch = +refs/heads/*:refs/remotes/origin/*
>     push = refs/heads/master:refs/heads/master
>     push = refs/heads/*:refs/heads/dev/john/*
> ```
>
> Given a currently checked out local branch named `my-feature`, how can
> I make this command:
>
>     git push -n origin
>
> Behave semantically identical to this command?
>
>     git push -n origin my-feature
>
> The current behavior seems to be working as designed, but not as
> desired. The first push command pushes *all* branches under
> `refs/heads/*`, instead of just the current branch as it normally
> would via `push.default` setting. It sort of feels like if a resolved,
> explicitly defined `push.<remote>.push` config is found *and* it
> includes wildcards, the `push.default` setting should still be
> respected.
>
> Are there any workarounds to getting the behavior I'm looking for?
>
> Note my ultimate goal here is to transparently map local branches to a
> branch with a prefix on the remote. But I do not want to explicitly
> work with or see those prefixes locally. Basically
> `dev/john/my-feature` on the remote should be `refs/heads/my-feature`
> locally, and `refs/remotes/origin/my-feature` for fetches. The
> push-without-explicit-refspec case is the only one I haven't gotten to
> work as desired yet.

Correction:

`push.<remote>.push` above should have been `remote.<remote>.push`.
