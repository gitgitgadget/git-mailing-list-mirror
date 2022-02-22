Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC46C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 20:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiBVUdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 15:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiBVUdK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 15:33:10 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2B966F8C
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 12:32:44 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u18so39813895edt.6
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 12:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05zFEqLYWMXb2qLoTHl89zVwEyGI7Dxy6DkM8N36hGM=;
        b=YUjbYVRLuZn8+VNske7Kw9AYU+6+wJ224Fs9bG2gpMTAF1N2PfN7i5JWdED69yCjcf
         hBtzMdnB0mwdBszFGM4STL5SsLlYaPensJk3W5zSCjnSYHD3Qng3mIGixqj0ulyArxjV
         jPxpYh9QuED8woV79fY4RkJACT2XT9IPVIih+/sxqij7l5/i7D/dL5yd00MAFZ+4Wox7
         l49MH1vGM5dolRZRL7mWJ8rKOurpzycpYfYVr0CW4GvM25c65OepoBFpvYcIQfMxWUaj
         OHKw7qD7RXO650Y9iQjs3+qHKtzM970f0uM5VTN0FdlTghfZ4lEkAuojZjeWqzc8pGe0
         UTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05zFEqLYWMXb2qLoTHl89zVwEyGI7Dxy6DkM8N36hGM=;
        b=zYWz472zCDBt1Kf3KbJj/IQgzfu2zZjnIK5kv/JDicYv/PgSmrh6aTkotGzhMLpHm2
         HK1m2IMl3lJNfN3SRizZYBbInSB8/VFcoHyer58sBV//VlYyU4MdoMwMPkhsTsW98IQx
         rDDcQTpuc7K5pWpxLQGwt9PG1mKeo9E84RgXhfO2imWpHkDIs+sSnrO15UgZuzKHuzN1
         MhDkq8mfdM0+bQmhcYItXzXeBQbO38cG5RGcJ0Ko3cHVnbttXXCu+J3F/gzyM7EK8QUF
         IOPCMHjb2oF2G1OK3n80GujqnTpuklm46qlLEFip/smNUeeK2qDCKzKTajj5YFT+I0T9
         Gwwg==
X-Gm-Message-State: AOAM5315OiXct6paMVnZK3WdC2C5it5jP+ZRo8hK+n2Et+BZq02hvfwP
        N333k4ZSotv9FIeO/C9BQKmaDn+WEoLpAQOe1W4=
X-Google-Smtp-Source: ABdhPJyX2lus2jOTVl3LQ97Yn/23pMhNXiYbjFzTvEI6e0s8jq/j+t8qYhsT901uCxGdbMtkIbFbdP5ef1QWGjyAx7k=
X-Received: by 2002:a05:6402:cac:b0:410:a920:4e90 with SMTP id
 cn12-20020a0564020cac00b00410a9204e90mr27719751edb.60.1645561962565; Tue, 22
 Feb 2022 12:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com> <20220222114313.14921-2-shivam828787@gmail.com>
In-Reply-To: <20220222114313.14921-2-shivam828787@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 22 Feb 2022 21:32:30 +0100
Message-ID: <CAP8UFD1FVuoe7V3JU+hExsbjWTkNZFCZFV4qc65YLd4ow-Da5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] t0001: remove pipes
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 3:08 PM Shubham Mishra <shivam828787@gmail.com> wrote:
>
> pipes doesn't care about error codes and ignore them thus we should not use them in tests.

Only the exit code of the command before the pipe is ignored.

Also it's ok to use pipes if the command before the pipe is not `git`.
We trust regular commands to just work and we test only `git`.

> As an easy alternative, I am using a tmp file to write from git command so we can test the exit code.

In general, when improving the code in a way that has already been
used by others, it's a good idea to take a look at previous commits
doing the same thing. See for example 66c0c44df6 (t0000: avoid masking
git exit value through pipes, 2021-09-16). I am not saying that you
should copy paste the commit message though.

> Signed-off-by: Shubham Mishra <shivam828787@gmail.com>
> ---
>  t/t0001-init.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 3235ab4d53..9a8f209648 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -489,11 +489,11 @@ test_expect_success 're-init from a linked worktree' '
>                 git worktree add ../linked-worktree &&
>                 mv .git/info/exclude expected-exclude &&
>                 cp .git/config expected-config &&
> -               find .git/worktrees -print | sort >expected &&
> +               find .git/worktrees -print >tmp && sort tmp >expected &&

Please put the `find` and `sort` commands on 2 different lines when
they are separated with &&.

>                 git -C ../linked-worktree init &&
>                 test_cmp expected-exclude .git/info/exclude &&
>                 test_cmp expected-config .git/config &&
> -               find .git/worktrees -print | sort >actual &&
> +               find .git/worktrees -print >tmp && sort tmp >actual &&

Idem.

>                 test_cmp expected actual
>         )
>  '
> --
> 2.25.1
>
