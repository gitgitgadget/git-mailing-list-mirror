Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDCD61F428
	for <e@80x24.org>; Wed, 15 Aug 2018 22:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeHPBTP (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 21:19:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53411 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeHPBTO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 21:19:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so2658671wmh.3
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qiD1JTC6kdlV3ye9qk6iSI3Nqv2TMwF8bx2JhpUG+6o=;
        b=vKHYfxmr7eCEgSkfqUTKcvozhNGtVRIQOSuz/M0bXqESLYmAKWsnjG5YgZsBnqam8Y
         iJZDp8vyg86HGf48xr41xjYZXHTsKgmNTbGbC8Sfw64+egDsQFCl69JKqmDqqokJRdvW
         iNKKvhTWS2qIVlbImCAhw4Jr//fTqI8tsc/xf3vf1PORLs4L58snFRMYa/Va3tqFrglt
         9e9ZdI9vwTa39ssbxD80lxAe22RmNXWcTmvOsc9q87xAjpW0jIhaW5s16yCqWbtUtR9G
         n8GJP73t9ev0jTdmjPSP/28UpjCnz6EHXOL8xGm5wz5PRkQpzcklGf1q0YjGb3V+pRNg
         WCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qiD1JTC6kdlV3ye9qk6iSI3Nqv2TMwF8bx2JhpUG+6o=;
        b=jlzCLClpiz9Ne+pfkpMQiA0Jwtw0ChRniQkjtMf5FO5WqkG5qGUMDxx24O4t4wDVCz
         HkUQ03yGOXwqtC+KZtOeDHUs8SWH0x7uul7I6Fu2fIf97iD1D2+f/nTA1e2HWSDGX0nx
         nDfntUxL72Cip1bhfo/+428fp/k498ObgKJnxO3WvDyPc57xPaosMJ17YsGI064ZnWFe
         mHyMzY0wUVFIBCFFVKvxWFZEgKiSKDClEXmfy3iBP6IDC4rh2NakapPXFAUKAwe9g6gW
         0UqP15vH+T8CJaYWHbCJn45TpoZnlkOrV852xe0IzWJGDUsOG+IbWRC4fb7BxtzcEgvJ
         xc0g==
X-Gm-Message-State: AOUpUlH7R3t7QmzDO8XqpyzvQVuBSA55NXcAjcRhjGgXYul9o5yy/9XI
        bzLkcYLH+FJRrMgW+vssfoSGRXgX
X-Google-Smtp-Source: AA+uWPy/AGJCUekwzn21d6tTDNqBqVZCQYdPzVq6BdKzE0tQlDjtEwWPDqlXoi3qEuFEInZpqACdOg==
X-Received: by 2002:a1c:1510:: with SMTP id 16-v6mr13759169wmv.74.1534371905547;
        Wed, 15 Aug 2018 15:25:05 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id e5-v6sm1860027wmh.29.2018.08.15.15.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 15:25:04 -0700 (PDT)
Date:   Wed, 15 Aug 2018 23:25:03 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 00/26] Convert "git stash" to C builtin
Message-ID: <20180815222503.GR2734@hank.intra.tgummerer.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
 <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> Hello,
> 
> Here is the whole `git stash` C version. Some of the previous
> patches were already reviewed (up to and including "stash: convert
> store to builtin"), but there are some which were not
> (starting with "stash: convert create to builtin").

Thanks for this new iteration, and sorry I took a while to find some
time to review this.  I had another read through the patches up until
patch 15, and left some comments, before running out of time again.  I
hope to find some time in the next few days to go through the rest of
the series as well.

One more comment in terms of the structure of the series.  The
patches doing the actual conversion from shell to C seem to be
interleaved with cleanup patches and patches that make the C version
use more internal APIs.  I'd suggest putting all the cleanup patches
(e.g. "stash: change `git stash show` usage text and documentation")
to the front of the series, as that's more likely to be
uncontroversial, and could maybe even be merged by itself.

Then I'd put all the conversion from shell to C patches, and only once
everything is converted I'd put the patches to use more of the
internal APIs rather than using run_command everywhere.  A possible
alternative would be to squash the patches to replace the run_command
calls with patches that use the internal API directly, to save the
reviewers some time by reading through less churn.  Though I'm kind of
on the fence with that, as a faithful conversion using 'run_command'
may be easier to review as a first step.

Hope this helps!

> In order to see the difference between the shell version and
> the C version, I ran `time` on:
> 
> * git test suite (t3903-stash.sh, t3904-stash-patch.sh,
> t3905-stash-include-untracked.sh and t3906-stash-submodule.sh)
> 
>         t3903-stash.sh:
>         ** SHELL: 12,69s user 9,95s system 109% cpu 20,730 total
>         **     C:  2,67s user 2,84s system 105% cpu  5,206 total
> 
>         t3904-stash-patch.sh:
>         ** SHELL: 1,43s user 0,94s system 106% cpu 2,242 total
>         **     C: 1,01s user 0,58s system 104% cpu 1,530 total
> 
>         t3905-stash-include-untracked.sh
>         ** SHELL: 2,22s user 1,73s system 110% cpu 3,569 total
>         **     C: 0,59s user 0,57s system 106% cpu 1,085 total
> 
>         t3906-stash-submodule.sh
>         ** SHELL: 2,89s user 2,99s system 106% cpu 5,527 total
>         **     C: 2,21s user 2,61s system 105% cpu 4,568 total
> 
>         TOTAL:
>         ** SHELL: 19.23s user 15.61s system
>         **     C:  6.48s user  6.60s system

Awesome!

> * a git repository with 4000 files: 1000 not changed,
> 1000 staged files, 1000 unstaged files, 1000 untracked.
> In this case I ran some of the most used commands:
> 
>         git stash push:
> 
>         ** SHELL: 0,12s user 0,21s system 101% cpu 0,329 total
>         **     C: 0,06s user 0,13s system 105% cpu 0,185 total
> 
>         git stash push -u:
> 
>         ** SHELL: 0,18s user 0,27s system  108% cpu 0,401 total
>         **     C: 0,09s user 0,19s system  103% cpu 0,267 total
> 
>         git stash pop:
> 
>         ** SHELL: 0,16s user 0,26s system 103% cpu 0,399 total
>         **     C: 0,13s user 0,19s system 102% cpu 0,308 total
> 
> Best regards,
> Paul Ungureanu
> 
> 
> Joel Teichroeb (5):
>   stash: improve option parsing test coverage
>   stash: convert apply to builtin
>   stash: convert drop and clear to builtin
>   stash: convert branch to builtin
>   stash: convert pop to builtin
> 
> Paul-Sebastian Ungureanu (21):
>   sha1-name.c: added 'get_oidf', which acts like 'get_oid'
>   stash: update test cases conform to coding guidelines
>   stash: renamed test cases to be more descriptive
>   stash: implement the "list" command in the builtin
>   stash: convert show to builtin
>   stash: change `git stash show` usage text and documentation
>   stash: refactor `show_stash()` to use the diff API
>   stash: update `git stash show` documentation
>   stash: convert store to builtin
>   stash: convert create to builtin
>   stash: replace spawning a "read-tree" process
>   stash: avoid spawning a "diff-index" process
>   stash: convert push to builtin
>   stash: make push to be quiet
>   stash: add tests for `git stash push -q`
>   stash: replace spawning `git ls-files` child process
>   stash: convert save to builtin
>   stash: convert `stash--helper.c` into `stash.c`
>   stash: optimize `get_untracked_files()` and `check_changes()`
>   stash: replace all `write-tree` child processes with API calls
>   stash: replace all "git apply" child processes with API calls
> 
>  Documentation/git-stash.txt |    7 +-
>  Makefile                    |    2 +-
>  builtin.h                   |    1 +
>  builtin/stash.c             | 1562 +++++++++++++++++++++++++++++++++++
>  cache.h                     |    1 +
>  git-stash.sh                |  752 -----------------
>  git.c                       |    1 +
>  sha1-name.c                 |   19 +
>  t/t3903-stash.sh            |  190 +++--
>  9 files changed, 1714 insertions(+), 821 deletions(-)
>  create mode 100644 builtin/stash.c
>  delete mode 100755 git-stash.sh
> 
> -- 
> 2.18.0.573.g56500d98f
> 
