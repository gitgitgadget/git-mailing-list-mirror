Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	URI_HEX shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5605120898
	for <e@80x24.org>; Wed, 19 Jul 2017 15:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbdGSPLo (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 11:11:44 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37527 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751967AbdGSPLn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 11:11:43 -0400
Received: by mail-wm0-f53.google.com with SMTP id g127so2021219wmd.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=6ZhBUEd04rVravaQleJfLr9A5s42Sxf/KVJu9kfZxGM=;
        b=EukRiSnOcJQ1ReYy/qcypc7cGWZJqyd21BemnsJASbGpDiyU9K4emj3wnKKicTX4DS
         mLw0qklsxKamyvNW31AE7j+PXELbeTVZ9ZuHd92Oi9zPodLC6K+lovOZKq+m2QUisanb
         yBNdrqcG8J+wB2fzR+Eep7sTWBnfEvkut83/ZVdegLHEgefFLn4wnnnvbmTvRcbelYR+
         g2UZnAlBJDklVDyCqKPxfePXZ/FDvTaXhzSDBYF0NgZdpTMA/GmdIdCWyODJIN/ggzY2
         CMZA0fNnaKETIFwbm8W+4EvJW0RtxUSe5pPTjrtCkz90FYLSB8Kk+wb+tgLEikhftrH3
         6HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=6ZhBUEd04rVravaQleJfLr9A5s42Sxf/KVJu9kfZxGM=;
        b=I9P85KRAZIOB/KlzLsX8CIwrw+R/e+Jy4L+n2yTFUB+LDLbQZajnFQwapGc5QU5Mod
         xjgDNg+kEl4z2kmfzSNftJ9DIfOox7QQILY6OrUMN6Z8H4Nv+qJpkZEGzmxRpshVyuAu
         pprPGE3J8k5TBMh9P7ysSXjo0Kf+2Ge7Ky5bzp5i/y/Pl/A47F0aUlzTxeRJUhbX7Hy7
         vFDfMKVbDLfOQ00skJAfMC5qwKZ4BwLEeSqhFeW2OMg3vnkzqnGGGiQCE55aVXD2+kvr
         IotarQWd+JOIea1JGSE9Xa7ze/TYs7IavQKG89abPCnS/UkXkGk+GkwfKOmzyhduUs7W
         aglA==
X-Gm-Message-State: AIVw110zU12X9H0OyuyDkJHxfGpE4aTgvBA6HyoX14Nx6mm0Rm3B/4xI
        aRM2OTZDjjtNKYuptLi8XrofIY63wEVBZ6A=
X-Received: by 10.28.95.137 with SMTP id t131mr235489wmb.102.1500477101715;
 Wed, 19 Jul 2017 08:11:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.174.83 with HTTP; Wed, 19 Jul 2017 08:11:41 -0700 (PDT)
In-Reply-To: <CAA6PgK74CTT09RZiQWGoih3x6B5G4tLa_Vz7e9BDNW4+TGdLXw@mail.gmail.com>
References: <CAA6PgK74CTT09RZiQWGoih3x6B5G4tLa_Vz7e9BDNW4+TGdLXw@mail.gmail.com>
From:   Jan Keromnes <janx@linux.com>
Date:   Wed, 19 Jul 2017 17:11:41 +0200
X-Google-Sender-Auth: _IP0IT_hLO6_VdmRTIAgk281b7E
Message-ID: <CAA6PgK7W7rCp92QbjRr01LmHa7Tf0Z+rm7L58tsZMNAA4LiaPg@mail.gmail.com>
Subject: Re: `make profile-fast` fails with "error: No $GIT_PERF_REPO defined,
 and your build directory is not a repo"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello again,

In git/Makefile, we can see that `$(MAKE) PROFILE=GEN -j1 perf` is
being skipped for the `profile` target when there is no
`$GIT_PERF_REPO`:

 https://github.com/git/git/blob/cac25fc330fc26050dcbc92c4bfff169a4848e93/Makefile#L1769-L1782

However, the same is not true for the `profile-fast` target, and it
wouldn't even make sense to skip `$(MAKE) PROFILE=GEN -j1 perf` there,
because it's the only command used to generate a profile.

What is the best way to have a `$GIT_PERF_REPO` (or a local `.git`) in
order for `make profile-fast` to work?

Can I simply run a `git init .` inside the extracted tarball, or maybe
`git clone <some-perf-repo> <somewhere-local>`?

Many thanks,
Jan Keromnes

On Wed, Jul 19, 2017 at 12:16 PM, Jan Keromnes <janx@linux.com> wrote:
> Hello,
>
> I'm trying to build a profile-optimized Git. I used to do this with
> the following commands:
>
>     mkdir /tmp/git
>     cd /tmp/git
>     curl https://www.kernel.org/pub/software/scm/git/git-2.13.3.tar.xz | tar xJ
>     cd git-2.13.3
>     make prefix=/usr profile man -j18
>     sudo make prefix=/usr PROFILE=BUILD install install-man -j18
>
> This worked fine. However, on some machines, the build takes more than
> 8 hours, so I'd like to use "profile-fast" instead of "profile":
>
>     [...]
>     make prefix=/usr profile-fast man -j18
>     [...]
>
> But this fails with the following error:
>
>     ./run
>     === Running 20 tests in this tree ===
>     error: No $GIT_PERF_REPO defined, and your build directory is not a repo
>     error: No $GIT_PERF_REPO defined, and your build directory is not a repo
>     [...]
>     error: No $GIT_PERF_REPO defined, and your build directory is not a repo
>     cannot open test-results/p0000-perf-lib-sanity.subtests: No such
> file or directory at ./aggregate.perl line 78.
>     make[2]: *** [perf] Error 2
>     Makefile:7: recipe for target 'perf' failed
>     make[2]: Leaving directory '/tmp/git/git-2.13.3/t/perf'
>     Makefile:2325: recipe for target 'perf' failed
>     make[1]: *** [perf] Error 2
>     make[1]: Leaving directory '/tmp/git/git-2.13.3'
>     Makefile:1719: recipe for target 'profile-fast' failed
>     make: *** [profile-fast] Error 2
>
> The following thread gives me the impression that a similar problem
> was already fixed for `make profile`:
>
> http://git.661346.n2.nabble.com/make-profile-issue-on-Git-2-1-0-td7616964.html
>
> Is it possible that the above commit fixed `make profile`, but not
> `make profile-fast`?
>
> Or, is there a good way for me to work around this issue?
>
> Many thanks,
> Jan Keromnes
