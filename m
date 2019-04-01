Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4734A20248
	for <e@80x24.org>; Mon,  1 Apr 2019 21:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfDAVCd (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 17:02:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41364 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfDAVCd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 17:02:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so5371284pgs.8
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 14:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5i/Hhj/k5ToZJ23N8Q82ANofhocLAYLtABnep6cSy3Q=;
        b=Vxx275V8qo20g/+xJOe7+/GBh2H+FjklSB1/KRlZIuVg4jOjzUL4SBzjoMeNNBMQmR
         VLdpPXaJRN8xnLhD2j/6LrThCQIFllhsGWZeKAUQ9OeIbXxLXZb1NDCYgq4NHZGeklDV
         LRoA5VGaz8Ob7qTOlJfTI1oYw2qYNB+9YFaz98mNWdtikibAa6ZlU+CbFvMenmUrtQci
         xITE9jNptXghtVHcdALWGSaR5DaEVfBUDBzWOnKKRdiN0UICkMFIQDaclk+9YkqN5/mV
         8tUq2XKvxqnRQGra8DRZOGBTrCM9Aw/EnmKBn+2RqF0aolVhEtXgyzvtVewo1+oXxeXP
         sxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5i/Hhj/k5ToZJ23N8Q82ANofhocLAYLtABnep6cSy3Q=;
        b=GKrt2rHcRzvtDyLVXrCXbs+zQCvvrgn0y7eNuneYrOSWfN5WHvNWVUij5hs0AllQKa
         53WgEtdLtOXloWq5RTsr7egxu/d1n6rEHlUbX6CbPSfQAFUURKlSyWMqmHcFrVMdDpae
         c1BXviIOciQaT/XyK5VtplLkZ1KUGK2yYPQuvFuBR76eoUsOcpDNtBeXZnU6JgCEiGo0
         i0ubRmAq/PozNvcEwjo0OE4JH8dGkSAM+QZQ2fydY2XsHL9xCh+x/ZZNMM4GaNEYmUPm
         ee3T0HcMc+SYjJ/vvlv2MGPdnAl4K+QqYDbfBB1kfKJm1l10f3tLHbC4AWRn5M5mdTdd
         muVQ==
X-Gm-Message-State: APjAAAWtSu75mEXqDjeHVRhjEeg6zIYJ8zdLslU/j6IxeACpaMotsMvl
        yXwgMufRh2k5w46ngbsCNXxCeQ==
X-Google-Smtp-Source: APXvYqymwKKohz+Na+oyhABo8FoGDWyfJCwJsYcDyPcqwNXRQfUfy2w/FntWjrImNl+mGMoA4iuOhA==
X-Received: by 2002:aa7:8719:: with SMTP id b25mr64847373pfo.90.1554152552238;
        Mon, 01 Apr 2019 14:02:32 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id x16sm11582758pge.27.2019.04.01.14.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 14:02:31 -0700 (PDT)
Date:   Mon, 1 Apr 2019 14:02:26 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 0/7] trace2: load trace2 settings from system config
Message-ID: <20190401210226.GE60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com
References: <pull.169.git.gitgitgadget@gmail.com>
 <pull.169.v2.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.169.v2.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.03.29 10:04, Jeff Hostetler via GitGitGadget wrote:
> Here is version 2. It addresses most the V1 comments WRT the system config
> changes.
> 
> It also addresses the format and uniqueness of the SID as discussed in [1].
> The SID now containes: the UTC date/time, part of SHA1 of the hostname, and
> the PID and is formatted to make it safe for filenames.
> 
> It also contains (a somewhat unrelated platform-specific) commit to report
> total process memory usage at exit. This is helpful when looking for
> problematic commands that might have scaling problems.
> 
> [1] 
> https://public-inbox.org/git/51e88650-8667-df1f-13ef-4537f2e70346@jeffhostetler.com/T/#m6b4e6f2b0374d5ba88de8d0350ce6bf51b28d7da
> 
> 
> ----------------------------------------------------------------------------
> 
> Teach git to load default Trace2 settings from the system config (usually
> "/etc/gitconfig"). The existing GIT_TR2_* environment variables can be used
> to override the new system defaults. It also includes a little startup
> refactoring.
> 
> Note: I found interactive testing of this feature to be awkward on some
> platforms because of the use of prefix- or runtime-prefix-relative locations
> for the system configuration. It was easy to accidentally use an officially
> installed version of git to set a system config variable in the official
> system config directory; and then when testing with the test version of git,
> that value would not be seen because it was looking for the system config
> file in a different directory.
> 
> Jeff Hostetler (7):
>   trace2: refactor setting process starting time
>   trace2: add absolute elapsed time to start event
>   trace2: find exec-dir before trace2 initialization
>   trace2: use system config for default trace2 settings
>   trace2: report peak memory usage of the process
>   trace2: clarify UTC datetime formatting
>   trace2: make SIDs more unique
> 
>  Documentation/technical/api-trace2.txt   |  66 +++++++++---
>  Makefile                                 |   1 +
>  common-main.c                            |   8 +-
>  compat/mingw.c                           |   2 +
>  compat/win32/trace2_win32_process_info.c |  50 ++++++++-
>  t/t0210-trace2-normal.sh                 |  41 +++++++-
>  t/t0211-trace2-perf.sh                   |  53 ++++++++--
>  t/t0212-trace2-event.sh                  |  52 ++++++++-
>  trace2.c                                 |  21 +++-
>  trace2.h                                 |  43 ++++++--
>  trace2/tr2_cfg.c                         |   7 +-
>  trace2/tr2_dst.c                         |  24 ++---
>  trace2/tr2_dst.h                         |   3 +-
>  trace2/tr2_sid.c                         |  39 ++++++-
>  trace2/tr2_sysenv.c                      | 128 +++++++++++++++++++++++
>  trace2/tr2_sysenv.h                      |  36 +++++++
>  trace2/tr2_tbuf.c                        |  20 +++-
>  trace2/tr2_tbuf.h                        |   5 +-
>  trace2/tr2_tgt.h                         |   1 +
>  trace2/tr2_tgt_event.c                   |  53 +++++-----
>  trace2/tr2_tgt_normal.c                  |  19 ++--
>  trace2/tr2_tgt_perf.c                    |  23 ++--
>  trace2/tr2_tls.c                         |  38 ++++---
>  trace2/tr2_tls.h                         |   8 +-
>  24 files changed, 604 insertions(+), 137 deletions(-)
>  create mode 100644 trace2/tr2_sysenv.c
>  create mode 100644 trace2/tr2_sysenv.h
> 
> 
> base-commit: 041f5ea1cf987a4068ef5f39ba0a09be85952064
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-169%2Fjeffhostetler%2Fcore-tr2-startup-and-sysenv-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-169/jeffhostetler/core-tr2-startup-and-sysenv-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/169

This series looks good to me, apart from the open question about
documentation. Thanks!

Reviewed-by: Josh Steadmon <steadmon@google.com>
