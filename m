Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B501F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753467AbeA3V4R (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:56:17 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:44100 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753436AbeA3V4P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:56:15 -0500
Received: by mail-yw0-f174.google.com with SMTP id x62so5948623ywg.11
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=od430Ie3UVKmb7p/NKKQl0TN1oX09GHdI7EgHmqufls=;
        b=XC6XS3ndljLLfEG9MtGYFlfXFuCmEfJ4z477Mve6ixYjWQcdQ4SxvjJ5bpoj3ZeU9l
         XqqvygG367kIfECiijx3rI2qGKK8MXLBVTC6XCKYmW3x35FuKxliD6UxYw1szd6CYraN
         +bvghawdtgm89rJ2A8nFuY0D/uy6+sRYbmdcFacgVlOogLNP5YG96pfWwPncDwMwe/QE
         sV37H2QCn0FR4kVZ5ZBS1s51FZfG8v9szNLzCx9ENQ7ARwwmMwQPhll4zZei5z7D8yka
         tqG5dkTjyzjQRe8qt/MH7ckJo7WpXs3oWo9joPSO/nizRiiC5TBe729FknXekvZuLeon
         3MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=od430Ie3UVKmb7p/NKKQl0TN1oX09GHdI7EgHmqufls=;
        b=b8mSPIpZrTnqchTHOCBS8scz9Uf8P+77XxMwVemXcE3XsWNqXuvKowYf6X3HDv4vua
         OrWe79bjykfLfETPjY2Pg+cn/JWLin7zbAVhfYEOJjJHrlYNCDxU8F+bwhDjqkRLWfVv
         +FmatvzRHk/7m3dkU0dmr+IdMHzP68ShdLpYH8EMdAYg+j5DoEZO0ao803pIQPo1Hnou
         s6LrNywSYIB/7mUAZdu72K1b1UV0OGi7nRVSeD3aFvjDrZRXSE3T4d2aO4QcYqHU1zIq
         WZM0C61iuBJSljw8lT07Ho77qgqup2g7giqcZ1wolA1qo7do+rjy59lArTCblfDetOwI
         4iPA==
X-Gm-Message-State: AKwxyteMCF/oMMQuTHw8pPgmkpvDuGfskUNxjHaHuJh0L0snmPgoVSwe
        FMGSrD829rtPP86tH7Bd21C0C5okANm92WqItj6g7w==
X-Google-Smtp-Source: AH8x224/8eYiKUDKXqbdQFMK+cUguTWOkEnbvK4XWZa4IOKziGrE4P8UiC53G84Itesaku4Dv+NOJfk0HYUlRjZpW0Q=
X-Received: by 10.37.34.8 with SMTP id i8mr21120156ybi.114.1517349374414; Tue,
 30 Jan 2018 13:56:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 30 Jan 2018 13:56:13 -0800 (PST)
In-Reply-To: <CAMZgS+GT8pSx8rDy1KmzFV3LObA_bAkw25LMz5Oodb88QOXY5A@mail.gmail.com>
References: <CAMZgS+GT8pSx8rDy1KmzFV3LObA_bAkw25LMz5Oodb88QOXY5A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Jan 2018 13:56:13 -0800
Message-ID: <CAGZ79kYBhBbn3vs2pHGuVzBo79EjUVmUR4r2z5GexNFOVxfv7g@mail.gmail.com>
Subject: Re: git add --all does not respect submodule.<name>.ignore
To:     Michael Scott-Nelson <mscottnelson@gmail.com>,
        Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 12:25 PM, Michael Scott-Nelson
<mscottnelson@gmail.com> wrote:
> Giving a submodule "ignore=all" or "ignore=dirty" in .gitmodule
> successfully removes that module from `git status` queries. However,
> these same diffs are automatically added by git-add, eg `git add .` or
> `git add --all` adds the submodules that we want ignored. This seems
> inconsistent and confusing.

My prime suspect for this change would be
https://github.com/git/git/commit/5556808690ea245708fb80383be5c1afee2fb3eb

> Workflow reason:
> We want to be able to have supers and subs checked-out, make changes
> to both, but only update the SHA-1 pointer from super to sub when
> explicitly forced to do so, eg `git add -f subName`. This workflow
> prevents continuous merge conflicts from clashing SHA-1 pointers while
> still allowing `git add --all`, allowing a sort of middle ground
> between submodules and an untracked library.

For that you want to set the ignore flag locally in .git/config instead of
.gitmodules. The .gitmodules seems like a convenient place to "share
submodule config", but that is a slippery slope and I think that was a
mistake by the project.

(If you control the environment, you could also put the ignore flags into
the system wide config)

> Teaching git-add about submodule.ignore and/or teaching .gitignore
> about submodules would be awesome.

I wonder if we can address this issue with even more config options.
(sounds bad, but is the first thought I have)

> Also experimented with `git update-index --assume-unchanged subName`,
> but I believe that it does not get committed and besides also does not
> seem to have a way to `git add -f`.

The assume-unchanged bit is a performance optimisation for powerusers,
but its documentation words it in a less dangerous way, such that it sounds
as if it is a UX feature instead of a performance thing. I'd stay away from
that know.

Stefan
