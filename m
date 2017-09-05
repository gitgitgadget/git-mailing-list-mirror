Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCDE6208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 17:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753178AbdIERuM (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 13:50:12 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36148 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752058AbdIERuL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 13:50:11 -0400
Received: by mail-pg0-f41.google.com with SMTP id m9so10734467pgd.3
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 10:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a8kdZ5aczTMFkLv8u2PTcJesvYo5cTaD+oJDTsH3J2Q=;
        b=q677MkFWNgAVkDBNf2f6YOm4p8Di4A1yWMft2PfqmxYulWtqCyQgPBJ15sVJdD8rqr
         m/iJRq5p+RbrEGiIdep5YlX6nN/k40t/yngtGErasKTYWsd7AJNGHoD8FJvgnGfBDqFW
         lcEkRJoEq8TdGhmTN/lBuXz5f5yXbMlhIcRSTRYM60hNYB5qKkdiedbCQMzZNvLWAnhL
         iaekdW2xqYlMxr8dYco6ZjNA7/WgceimsXOVgQli/G6yMSbTrzcg6JlkZqDKex7cQ4ZW
         /6SDq86JixF6Z5+5UemNTEeAS/zuw0naAi7KcBEUFhzD0fe9DHxYAAt/6pwlhJXcFjWG
         HhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a8kdZ5aczTMFkLv8u2PTcJesvYo5cTaD+oJDTsH3J2Q=;
        b=RkWUp3a4xySvF6nhtbuVv2qSYDL87so77T5DHFTu6WwQJNkl/8zvA3QEb4kCszioGK
         NLUU4E7gcl9AoF8npMz5fqJn+TFX9EiTa2zUeyZui2UpY+IXgmpK5Puj1sqHKlbYUk5K
         eFsjRiMSmGBHypEVmgXQVsQyDdwTQ3st0z9s1o6KOBFGDEUsitn9YlpZgXvudMXVq1cU
         pqzq4Z6J4qVinCegkjNr6KowlIgTEVHyDolZl+e+KuGz45V+mgUEhG77IJwF01QgXDl9
         2kgdHASZIVmO4sn0Cr17lnheAJndWTTK6mVKSPxtT+DjZZfhQS+HFmC4jqf+XgmawrY6
         44nA==
X-Gm-Message-State: AHPjjUjvbk12YF1mNoSs6QC274yhMr6bLciux9aSw3Ux0i8dYKHHOPjf
        ySYszbIps2iI1TBHPrBmL6j4EsOIoA==
X-Google-Smtp-Source: ADKCNb4peuYw+gIJvBUP+cSa5uLT+9NV+nvS9vXED+ud5RciYZGsBbcyA0JHFYp94CvqgfAL0BR9pRqmG0l7SLorjtw=
X-Received: by 10.101.80.140 with SMTP id r12mr4702106pgp.267.1504633810555;
 Tue, 05 Sep 2017 10:50:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.73 with HTTP; Tue, 5 Sep 2017 10:50:10 -0700 (PDT)
In-Reply-To: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 5 Sep 2017 19:50:10 +0200
Message-ID: <CAN0heSrVzRPc+iVqU02qzk=DB0WT6Fscn6X-hZPFkM1TikMPVQ@mail.gmail.com>
Subject: Re: [PATCH 0/10] towards clean leak-checker output
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 September 2017 at 15:01, Jeff King <peff@peff.net> wrote:
> Using leak-checking tools like valgrind or LSAN is usually not all that
> productive with Git, because the output is far from clean. And _most_ of
> these are just not interesting, as they're either:
>
>   1. Real leaks, but ones that only be triggered a small, set number of
>      times per program.
>
>   2. Intentional leaks of variables as the main cmd_* functions go out
>      of scope (as opposed to manually cleaning).
>
> I focused here on getting t0000 and t0001 to run clean against a
> leak-checking tool. That's a fraction of the total test suite, but my
> goal was have a tractable sample which could let us see if the path
> seems sane.
>
> I feel positive overall about the approach this series takes. The
> suppressions aren't too terrible to write, and I found some real (albeit
> minor) leaks in these few tests. I hope it can serve as a base for an
> ongoing effort to get the whole test suite clean.
>
> A few things to note:
>
>   - I switched from valgrind to ASAN/LSAN early on. It's just way
>     faster, which makes the compile-test-fix cycle a lot more pleasant.
>     With these patches, you should be able to do:
>
>       make SANITIZE=leak && (cd t && ./t1234-* -v -i)
>
>     and get a leak report for a single script dumped to stderr.
>
>     If you want to try it with t0000, you'll need the lock-file series I
>     just posted at:
>
>       https://public-inbox.org/git/20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net/
>
>     and the fix from Martin at:
>
>       https://public-inbox.org/git/CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com/
>
>     to get a clean run.
>
>   - I'm using LSAN instead of the full-on ASAN because it's faster. The
>     docs warn that it's a bit experimental, and I did notice a few funny
>     behaviors (like truncated backtraces), but overall it seems fine.
>     You can also do:
>
>       make SANITIZE=address &&
>         (cd t && ASAN_OPTIONS=abort_on_error=1 ./t1234-* -v -i)
>
>     to do a full ASAN run (the extra environment setting is necessary to
>     override test-lib's defaults).
>
>   - gcc's leak-checker doesn't seem to handle reachability correctly (or
>     maybe I'm holding it wrong). As a simple case, building with ASAN
>     and running git-init complains:
>
>       $ make SANITIZE=address && ./git init foo
>       ...
>       Direct leak of 2 byte(s) in 1 object(s) allocated from:
>           #0 0x7f011dc699e0 in malloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xd99e0)
>           #1 0x558eeedbdab5 in do_xmalloc /home/peff/compile/git/wrapper.c:60
>           #2 0x558eeedbdbab in do_xmallocz /home/peff/compile/git/wrapper.c:100
>           #3 0x558eeedbdd0d in xmallocz /home/peff/compile/git/wrapper.c:108
>           #4 0x558eeedbdd0d in xmemdupz /home/peff/compile/git/wrapper.c:124
>           #5 0x558eeedbdd0d in xstrndup /home/peff/compile/git/wrapper.c:130
>           #6 0x558eeea0507a in main /home/peff/compile/git/common-main.c:39
>           #7 0x7f011cf612e0 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x202e0)
>
>     That line is the setting of argv0_path, which is a global (and thus
>     shouldn't be marked as leaking). Interestingly, it only happens with
>     -O2. Compiling with -O0 works fine. I'm not sure if it's a bug or
>     what.
>
>     I did most of my testing with clang-6.0, which gets this case right.

Hmmm, I got the same wrong results (IMHO) from Valgrind, which
classified this as "definitely lost". Like you I found that -O0 helped.
And yes, that was with gcc. Maybe gcc with optimization somehow manages
to hide the pointers from these tools. I know too little about the
technical details to have any real ideas, though. My searches did not
bring up anything useful. (gcc 5.4.0)

I guess clang will be my next attempt. And asan/lsan. Valgrind is slow..

I'll look through this series and get back if I have any input.

>   - I have no idea who close or far this is to covering the whole suite.
>     Only 98 test scripts complete with no leaks. But many of those
>     failures will be hitting the same leaks over and over. It looks like
>     running "git show' hits a few, which is going to affect a lot of
>     scripts. But bear in mind when reading the patches that this might
>     be the first step on a successful road, or it could be a dead end. :)
>
> Most of this is actual leak fixes. The interesting part, I think, is the
> UNLEAK annotation in patch 10.
>
>   [01/10]: test-lib: --valgrind should not override --verbose-log
>   [02/10]: test-lib: set LSAN_OPTIONS to abort by default
>   [03/10]: add: free leaked pathspec after add_files_to_cache()
>   [04/10]: update-index: fix cache entry leak in add_one_file()
>   [05/10]: config: plug user_config leak
>   [06/10]: reset: make tree counting less confusing
>   [07/10]: reset: free allocated tree buffers
>   [08/10]: repository: free fields before overwriting them
>   [09/10]: set_git_dir: handle feeding gitdir to itself
>   [10/10]: add UNLEAK annotation for reducing leak false positives
>
>  Makefile               |  3 +++
>  builtin/add.c          |  3 +++
>  builtin/commit.c       |  1 +
>  builtin/config.c       | 11 +++++++++--
>  builtin/init-db.c      |  2 ++
>  builtin/ls-files.c     |  1 +
>  builtin/reset.c        | 24 +++++++++++++++++-------
>  builtin/update-index.c |  4 +++-
>  builtin/worktree.c     |  2 ++
>  environment.c          |  4 +++-
>  git-compat-util.h      |  7 +++++++
>  repository.c           | 14 +++++++-------
>  setup.c                |  5 -----
>  t/test-lib.sh          |  7 ++++++-
>  usage.c                | 13 +++++++++++++
>  15 files changed, 77 insertions(+), 24 deletions(-)
>
> -Peff
