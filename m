Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF181F453
	for <e@80x24.org>; Fri, 25 Jan 2019 20:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfAYUDW (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 15:03:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33779 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYUDV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 15:03:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so4646310pgu.0
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 12:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dz8SqA/3WBv+psPcAhK2lNHelS3YN2xcO9Pk/BeZXkY=;
        b=CCLPojIX2xtPdlHU+uJh0GPoGOq/Rw45iy643pTmOPcxFjNiBQfG6KBa7TMOMAAQVa
         CdBM4/Ng8X+wZKI72DcO6wjkSCa9Ip7G2wpix3k6IVTg+pyXSmZyc35DSFhJcVOhw8rK
         f2dGYh35QxVNpSonNH6dp/XlHzPKhO/i6cTqxva1hIUe6zO0nmNuEe37CmrQjxFwCuyz
         9VjVqf/b1araQBGXrMP1/hsr7FmxvtOGhP3p2tYfJqiA/4JGfUegdJ4obxRaDTy6vLUI
         kLXmrwFwcgftHwn2XZPH78kwBnRcx42VW/tgvebILxEiD4mINKOZcHTxgb6u+78oLgq8
         E6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Dz8SqA/3WBv+psPcAhK2lNHelS3YN2xcO9Pk/BeZXkY=;
        b=YXK1zAbawxBbstoDBBjdMZ6Ik36egqtWrELWpe59tRUW9/WTSpKPbQG8+EmrioHmsK
         ZhusSjJZXAGDl18KFzlQrIj/l+Ul3Y/hec9pWFMkIYMQUv/YpwUCemeKtJERfqubPbYZ
         Myc7R/geOmo8dtGuy+8WWy+DEN5mTB3SmrEn5JEGfWfwwNmi6gtdzL5ozzAt0LLpARSZ
         EHei9gS3JIbIzsA2jeynBsN4uFF7fcAIVhuhN1HPGw6qBtu4iRFY2c5ficH0rY/LeNA1
         5zJRFklT8gpjKldyIVs78XuGcD74WZ4VPChxNVCwAQsvMiLJHxYgffeEBFuDBhV1K3qp
         rlRA==
X-Gm-Message-State: AJcUukdxICLQwe+oxBackzYYG6Mc65NvAgM+R8DwdvaofuBp6bWs0bJ4
        ALG6PAC7uAdRT1AD3MLfnGH0lABXTDj0iQ==
X-Google-Smtp-Source: ALg8bN7fI3rOA7DpKxegZWmpwfbVJ1/VX3n4Nt/hHqER8aiE84zPobfNvSTWrUnSEnABpgmt5es6Sw==
X-Received: by 2002:a63:cf02:: with SMTP id j2mr11340975pgg.113.1548446600139;
        Fri, 25 Jan 2019 12:03:20 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id x186sm32062229pfb.59.2019.01.25.12.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 12:03:19 -0800 (PST)
Date:   Fri, 25 Jan 2019 12:03:09 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] Trace2 tracing facility
Message-ID: <20190125200309.GB72177@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.108.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.01.22 13:22, Jeff Hostetler via GitGitGadget wrote:
> This patch series contains a greatly refactored version of my original
> Trace2 series [1] from August 2018.
> 
> A new design doc in Documentation/technical/api-trace2.txt (in the first
> commit) explains the relationship of Trace2 to the current tracing facility.
> Calls to the current tracing facility have not been changed, rather new
> trace2 calls have been added so that both continue to work in parallel for
> the time being.
> 
> [1] https://public-inbox.org/git/pull.29.git.gitgitgadget@gmail.com/
> 
> Cc: gitster@pobox.comCc: peff@peff.netCc: jrnieder@gmail.com
> 
> Derrick Stolee (1):
>   pack-objects: add trace2 regions
> 
> Jeff Hostetler (13):
>   trace2: Documentation/technical/api-trace2.txt
>   trace2: create new combined trace facility
>   trace2: collect platform-specific process information
>   trace2:data: add trace2 regions to wt-status
>   trace2:data: add editor/pager child classification
>   trace2:data: add trace2 sub-process classification
>   trace2:data: add trace2 transport child classification
>   trace2:data: add trace2 hook classification
>   trace2:data: add trace2 instrumentation to index read/write
>   trace2:data: add subverb to checkout command
>   trace2:data: add subverb to reset command
>   trace2:data: add subverb for rebase
>   trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
> 
>  Documentation/technical/api-trace2.txt | 1158 ++++++++++++++++++++++++
>  Makefile                               |   11 +
>  builtin/am.c                           |    1 +
>  builtin/checkout.c                     |    7 +
>  builtin/pack-objects.c                 |   12 +-
>  builtin/rebase.c                       |   19 +
>  builtin/receive-pack.c                 |    4 +
>  builtin/reset.c                        |    6 +
>  builtin/submodule--helper.c            |   11 +-
>  builtin/worktree.c                     |    1 +
>  cache.h                                |    1 +
>  common-main.c                          |   13 +-
>  compat/mingw.c                         |   11 +-
>  compat/mingw.h                         |    3 +-
>  compat/win32/ancestry.c                |  102 +++
>  config.c                               |    2 +
>  config.mak.uname                       |    2 +
>  connect.c                              |    3 +
>  editor.c                               |    1 +
>  exec-cmd.c                             |    2 +
>  git-compat-util.h                      |    7 +
>  git.c                                  |   65 ++
>  pager.c                                |    1 +
>  read-cache.c                           |   47 +-
>  remote-curl.c                          |    7 +
>  repository.c                           |    2 +
>  repository.h                           |    3 +
>  run-command.c                          |   63 +-
>  run-command.h                          |   17 +-
>  sequencer.c                            |    2 +
>  sh-i18n--envsubst.c                    |    3 +
>  sub-process.c                          |    1 +
>  submodule.c                            |   11 +-
>  t/helper/test-parse-options.c          |    3 +
>  t/helper/test-tool.c                   |    4 +
>  t/helper/test-tool.h                   |    1 +
>  t/helper/test-trace2.c                 |  273 ++++++
>  t/t0001-init.sh                        |    1 +
>  t/t0210-trace2-normal.sh               |  135 +++
>  t/t0210/scrub_normal.perl              |   48 +
>  t/t0211-trace2-perf.sh                 |  153 ++++
>  t/t0211/scrub_perf.perl                |   76 ++
>  t/t0212-trace2-event.sh                |  237 +++++
>  t/t0212/parse_events.perl              |  251 +++++
>  trace2.c                               |  809 +++++++++++++++++
>  trace2.h                               |  403 +++++++++
>  trace2/tr2_cfg.c                       |   92 ++
>  trace2/tr2_cfg.h                       |   19 +
>  trace2/tr2_dst.c                       |   90 ++
>  trace2/tr2_dst.h                       |   34 +
>  trace2/tr2_sid.c                       |   67 ++
>  trace2/tr2_sid.h                       |   18 +
>  trace2/tr2_tbuf.c                      |   32 +
>  trace2/tr2_tbuf.h                      |   23 +
>  trace2/tr2_tgt.h                       |  126 +++
>  trace2/tr2_tgt_event.c                 |  606 +++++++++++++
>  trace2/tr2_tgt_normal.c                |  331 +++++++
>  trace2/tr2_tgt_perf.c                  |  573 ++++++++++++
>  trace2/tr2_tls.c                       |  164 ++++
>  trace2/tr2_tls.h                       |   95 ++
>  trace2/tr2_verb.c                      |   30 +
>  trace2/tr2_verb.h                      |   24 +
>  transport-helper.c                     |    2 +
>  transport.c                            |    1 +
>  usage.c                                |   31 +
>  wt-status.c                            |   23 +-
>  66 files changed, 6353 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/technical/api-trace2.txt
>  create mode 100644 compat/win32/ancestry.c
>  create mode 100644 t/helper/test-trace2.c
>  create mode 100755 t/t0210-trace2-normal.sh
>  create mode 100644 t/t0210/scrub_normal.perl
>  create mode 100755 t/t0211-trace2-perf.sh
>  create mode 100644 t/t0211/scrub_perf.perl
>  create mode 100755 t/t0212-trace2-event.sh
>  create mode 100644 t/t0212/parse_events.perl
>  create mode 100644 trace2.c
>  create mode 100644 trace2.h
>  create mode 100644 trace2/tr2_cfg.c
>  create mode 100644 trace2/tr2_cfg.h
>  create mode 100644 trace2/tr2_dst.c
>  create mode 100644 trace2/tr2_dst.h
>  create mode 100644 trace2/tr2_sid.c
>  create mode 100644 trace2/tr2_sid.h
>  create mode 100644 trace2/tr2_tbuf.c
>  create mode 100644 trace2/tr2_tbuf.h
>  create mode 100644 trace2/tr2_tgt.h
>  create mode 100644 trace2/tr2_tgt_event.c
>  create mode 100644 trace2/tr2_tgt_normal.c
>  create mode 100644 trace2/tr2_tgt_perf.c
>  create mode 100644 trace2/tr2_tls.c
>  create mode 100644 trace2/tr2_tls.h
>  create mode 100644 trace2/tr2_verb.c
>  create mode 100644 trace2/tr2_verb.h
> 
> 
> base-commit: 77556354bb7ac50450e3b28999e3576969869068
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-108%2Fjeffhostetler%2Fcore-trace2-2019-v0-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-108/jeffhostetler/core-trace2-2019-v0-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/108
> -- 
> gitgitgadget

Several patches in this series have many style diffs as reported by
clang-format. Not all the diffs actually improve readability, but many
do. If you have clang-format installed, you can run:

git clang-format --style file --diff --extensions c,h ${commit}^ ${commit}

for each commit in the series to see what it thinks needs to be changed.


Other than that, I don't have any comments apart from what the other
reviewers have already mentioned.

Thanks for the series!
