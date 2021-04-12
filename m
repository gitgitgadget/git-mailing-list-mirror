Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A62C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 15:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD6E61206
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 15:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbhDLPaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 11:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbhDLPaO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 11:30:14 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D9DC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 08:29:56 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so13145086otb.7
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZCVXx2wkRkv7apYx6BqZ5LLCMuxY0jcNM6msGAB0g9w=;
        b=fdYhqBKt/9B1cFU6DzBdwZf6GQ3r2Hv9D19VhlwIB1zJPelPCSeo0ra5LFFtoZWr0K
         Zr1XqASHKEWXufM/092CBO2RIMKLtn4JJ8zXihY4sQ+iYTmANSgaOmkKCQ0WcUKIw6OY
         3/rBnYG4CIM0l/YjsoAvdAHvN1RY8b6uYufrTiq2qqIfDxkVvmmh2Bc3iREZKR2wrPeg
         0KPN6QNYaJPu2E6doThxgduSfxHOkLQp43EF8BPlVjiAWy9lGRHkFIfMIKKpzEx5N6ml
         Ha2lstMJ/+iA43n5bvDHh8DxQUu9dSmHt5uXdetVv8mZRywHYKTUtkAOkAKIkS6Sfiub
         Gv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZCVXx2wkRkv7apYx6BqZ5LLCMuxY0jcNM6msGAB0g9w=;
        b=N3jj/4G5pK+AqPAA7UVbCjknuRA9HK3Jxrz28abW6JoRAjYfFmVIWAI08BuHI5PNyV
         OqMqI3RZW5Hb8pAVzqMD9I2NLJnU/gO1Et+dgKr8bBpjXP/sfBNa9hsvHoa+OmMm6gbc
         +HulOFLpuM+hVkdW1yLZuvprnmh8mjkdsOrAX3ekQY8IyWh+9GW9vh12bqMy87mQ5Qwg
         4fqMB9rgVEhetxSwq9syNIRXDJzbderiydLbUM8MKHoRmPaluFksZqWUoUW6TCWeQkb6
         Mlr8ZODYHe3aXI9XfiPDavzPX97hzGqp3Ukc8V5pPNN2b52ONzM4J+qVw1FYazDAqPO3
         nwcA==
X-Gm-Message-State: AOAM533YJyIKdHnsPY2i3VjWwkKQtxamu8VKK+MGytswN0IjIoMaufLU
        bNThd2/WxnDJ/zVzVZ9cI85fDlD9hHw9Li61D5neRxmGS9FIPw==
X-Google-Smtp-Source: ABdhPJw74LVUHchXuq2kvS8MU/ePR4vV/jr+nKjsLe+GokPW6R5wSY+Bz2zIz4fwyhsaiWpBJ9k+KNNAiPCtMnfDzSY=
X-Received: by 2002:a9d:8a6:: with SMTP id 35mr5241588otf.316.1618241395297;
 Mon, 12 Apr 2021 08:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAKJ37DfivxL-2Sy0qa+M_1Pw0c9-CWsCJO5=VqP1UOB5zTSP_Q@mail.gmail.com>
In-Reply-To: <CAKJ37DfivxL-2Sy0qa+M_1Pw0c9-CWsCJO5=VqP1UOB5zTSP_Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Apr 2021 08:29:44 -0700
Message-ID: <CABPp-BEOnrnQKov1YDdHXkb6CCNxudE9bUdntOeq3k0wOODc1A@mail.gmail.com>
Subject: Re: Unexpected conflict during cherry-pick after moving submodule
To:     Tamas Peregi <tamas.peregi@formlabs.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Apr 12, 2021 at 7:59 AM Tamas Peregi <tamas.peregi@formlabs.com> wr=
ote:
>
> Hi all,
>
> I ran into something that seems like a bug to me. I'm fairly new to
> git, especially git submodules, so it's possible this is expected
> behaviour, but if it is, please explain where I went wrong.
>
> Thanks in advance: Tam=C3=A1s
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - I modified a file on one branch
> - Then switched to another
> - Moved a submodule to another directory
> - Tried to cherry-pick my modification from the other branch
>
> This script can be used to reproduce my steps (any submodule works, I
> chose gsl-lite because I like it):
>     git init
>
>     echo hello > hello.txt
>     git add hello.txt
>     git commit -m "Add hello.txt"
>
>     git submodule add https://github.com/gsl-lite/gsl-lite/ vendor/gsl
>     git commit -a -m "Add submodule"
>
>     git branch world
>     git branch move
>
>     git checkout world
>     echo world >> hello.txt
>     git commit -a -m "Expand hello.txt"
>
>     git checkout move
>     mkdir thirdparty
>     git mv vendor/gsl thirdparty/gsl
>     git commit -a -m "Move submodule"
>
>     git cherry-pick world
>
>
> What did you expect to happen? (Expected behavior)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> I expected the cherry-pick to happen without conflicts.
>
>
> What happened instead? (Actual behavior)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I ran into a conflict during the cherry-pick:
>     Adding as thirdparty/gsl~HEAD instead
>     error: could not apply 516d94f... Expand hello.txt
>     hint: after resolving the conflicts, mark the corrected paths
>     hint: with 'git add <paths>' or 'git rm <paths>'
>     hint: and commit the result with 'git commit'
>
>
> What's different between what you expected and what actually happened?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> As hello.txt has nothing to do with the submodule, I assumed the
> cherry-pick would go through smoothly.
>
>
> Anything else you want to add:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> - "git add thirdparty/gsl && git cherry-pick --continue" resolves the
> issue as expected.
> - If I change which commit in the submodule the superproject points
> to, the problem disappears, but I don't necessarily want to do that.
> - I'm using "Git for Windows", but the issue was reproduced by my
> Mac-based colleagues too with the exact same results.
>
> [System Info]
> git version:
> git version 2.31.1.windows.1
> cpu: x86_64
> built from commit: c5f0be26a7e3846e3b6268d1c6c4800d838c6bbb
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19042
> compiler info: gnuc: 10.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.=
exe

Thanks for the report.

We can change the final command to
    git cherry-pick --strategy recursive world

to be more explicit, though that doesn't change things and still
triggers the bug.  However, if we change the above to
    git cherry-pick --strategy ort world

then that fixes the bug, including even in git-2.31.1.  The version of
the 'ort' merge backend in 2.31.1 isn't ready for general usage (it
can't handle file renormalization, or subtree merges, or
sparse-checkouts with conflicts in files outside of the requested
sparsity paths, and also has a platform specific bug where it'll die
on corner case rename/rename conflicts due to assumptions about libc
qsort() stability), but the version in 2.32 will be.  And 'ort' is
going to replace 'recursive' once the project is comfortable enough
with the new backend.

All this is to say that the fix is on the way, even if it doesn't help
you quite yet.
