Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FBFD1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfAVVWP (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:22:15 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:37990 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfAVVWO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:22:14 -0500
Received: by mail-ed1-f44.google.com with SMTP id h50so6726ede.5
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TTFLUeRSe5vbYIWx+HnYZoJIQkMBBOqXwZMhEGo9UHc=;
        b=qQQYZn+ttwN1ObLkuTWmWTp1+5wRrQlSBXoy6rpV5hF/+j4pV0epMjovRnSlmT4g7m
         cb10xx5W3JCGZ8TCcm8p7TPTVvUJFchZKUo9Zerqe7Nc5Q0GmYoV+utShuSPsStl0aMX
         d0WXJOxHjFuYtRXh11G3S9BwDvmWWte4KvRhocPmPAnjxqcG5jW/4TSQTeI362cR+UnK
         OMK+OnTTZay3zaw7duG5iyImp7a9R28tXntHhWg9wLJKFZVQ+L331wkhXHC3wNNjXpF3
         OT1wp6Y7tGBU7EArklrvJkh/ZPv5+S7bcyU+pJuh65Q/ECgQZyZldD5FTlWJRtcdZyb9
         lEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TTFLUeRSe5vbYIWx+HnYZoJIQkMBBOqXwZMhEGo9UHc=;
        b=A/jU7LjO0vw8FNsQrdyxynbJEUSfkgX+1plNrTlPHFAOYRFXqVo7ioYtt21eMaNdSV
         pt+aWmt71FQkzMPvMlFk9M3Obpa+VCZHeY6YvQsMq32PdVceKn1A+69uqYVAnDqdcd+1
         XGImOr0QmBSfqvQ9tOIUB+35JlkffFz4IWO7IO6346dwOh1Z9jocNAbx57efjK+ntgOL
         JlB/TAw/gVGpjx+KG7y7sxb3U8iDwPov6U9Jm1X+e0zVAeNqqOm1qEH5BzzPvcLhiVgl
         5jlj0W9mfWVQ5mOBC/syPc3WnMPiZyf5AifCXdaxsf3wEvtBvnW3LZAjrZtvnXifuHwR
         PF3Q==
X-Gm-Message-State: AJcUukdZOoNtKIQHjqXdK1+GUUZiG0rcaVR122o056Z3DiNgeWpZHjHq
        4nwP3jTS0843350YAou8Vam5EGRg
X-Google-Smtp-Source: ALg8bN4+6d6PR+78GR6KBFACj93wq3Wb5m7Y/IbAxvYTtHgfTmBJChqW5G507hH5h3JTjpWg7vrqoQ==
X-Received: by 2002:a50:b964:: with SMTP id m91mr137682ede.184.1548192132530;
        Tue, 22 Jan 2019 13:22:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm236371eju.72.2019.01.22.13.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:22:12 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:22:12 -0800 (PST)
X-Google-Original-Date: Tue, 22 Jan 2019 21:21:57 GMT
Message-Id: <pull.108.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 00/14] Trace2 tracing facility
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series contains a greatly refactored version of my original
Trace2 series [1] from August 2018.

A new design doc in Documentation/technical/api-trace2.txt (in the first
commit) explains the relationship of Trace2 to the current tracing facility.
Calls to the current tracing facility have not been changed, rather new
trace2 calls have been added so that both continue to work in parallel for
the time being.

[1] https://public-inbox.org/git/pull.29.git.gitgitgadget@gmail.com/

Cc: gitster@pobox.comCc: peff@peff.netCc: jrnieder@gmail.com

Derrick Stolee (1):
  pack-objects: add trace2 regions

Jeff Hostetler (13):
  trace2: Documentation/technical/api-trace2.txt
  trace2: create new combined trace facility
  trace2: collect platform-specific process information
  trace2:data: add trace2 regions to wt-status
  trace2:data: add editor/pager child classification
  trace2:data: add trace2 sub-process classification
  trace2:data: add trace2 transport child classification
  trace2:data: add trace2 hook classification
  trace2:data: add trace2 instrumentation to index read/write
  trace2:data: add subverb to checkout command
  trace2:data: add subverb to reset command
  trace2:data: add subverb for rebase
  trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh

 Documentation/technical/api-trace2.txt | 1158 ++++++++++++++++++++++++
 Makefile                               |   11 +
 builtin/am.c                           |    1 +
 builtin/checkout.c                     |    7 +
 builtin/pack-objects.c                 |   12 +-
 builtin/rebase.c                       |   19 +
 builtin/receive-pack.c                 |    4 +
 builtin/reset.c                        |    6 +
 builtin/submodule--helper.c            |   11 +-
 builtin/worktree.c                     |    1 +
 cache.h                                |    1 +
 common-main.c                          |   13 +-
 compat/mingw.c                         |   11 +-
 compat/mingw.h                         |    3 +-
 compat/win32/ancestry.c                |  102 +++
 config.c                               |    2 +
 config.mak.uname                       |    2 +
 connect.c                              |    3 +
 editor.c                               |    1 +
 exec-cmd.c                             |    2 +
 git-compat-util.h                      |    7 +
 git.c                                  |   65 ++
 pager.c                                |    1 +
 read-cache.c                           |   47 +-
 remote-curl.c                          |    7 +
 repository.c                           |    2 +
 repository.h                           |    3 +
 run-command.c                          |   63 +-
 run-command.h                          |   17 +-
 sequencer.c                            |    2 +
 sh-i18n--envsubst.c                    |    3 +
 sub-process.c                          |    1 +
 submodule.c                            |   11 +-
 t/helper/test-parse-options.c          |    3 +
 t/helper/test-tool.c                   |    4 +
 t/helper/test-tool.h                   |    1 +
 t/helper/test-trace2.c                 |  273 ++++++
 t/t0001-init.sh                        |    1 +
 t/t0210-trace2-normal.sh               |  135 +++
 t/t0210/scrub_normal.perl              |   48 +
 t/t0211-trace2-perf.sh                 |  153 ++++
 t/t0211/scrub_perf.perl                |   76 ++
 t/t0212-trace2-event.sh                |  237 +++++
 t/t0212/parse_events.perl              |  251 +++++
 trace2.c                               |  809 +++++++++++++++++
 trace2.h                               |  403 +++++++++
 trace2/tr2_cfg.c                       |   92 ++
 trace2/tr2_cfg.h                       |   19 +
 trace2/tr2_dst.c                       |   90 ++
 trace2/tr2_dst.h                       |   34 +
 trace2/tr2_sid.c                       |   67 ++
 trace2/tr2_sid.h                       |   18 +
 trace2/tr2_tbuf.c                      |   32 +
 trace2/tr2_tbuf.h                      |   23 +
 trace2/tr2_tgt.h                       |  126 +++
 trace2/tr2_tgt_event.c                 |  606 +++++++++++++
 trace2/tr2_tgt_normal.c                |  331 +++++++
 trace2/tr2_tgt_perf.c                  |  573 ++++++++++++
 trace2/tr2_tls.c                       |  164 ++++
 trace2/tr2_tls.h                       |   95 ++
 trace2/tr2_verb.c                      |   30 +
 trace2/tr2_verb.h                      |   24 +
 transport-helper.c                     |    2 +
 transport.c                            |    1 +
 usage.c                                |   31 +
 wt-status.c                            |   23 +-
 66 files changed, 6353 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/technical/api-trace2.txt
 create mode 100644 compat/win32/ancestry.c
 create mode 100644 t/helper/test-trace2.c
 create mode 100755 t/t0210-trace2-normal.sh
 create mode 100644 t/t0210/scrub_normal.perl
 create mode 100755 t/t0211-trace2-perf.sh
 create mode 100644 t/t0211/scrub_perf.perl
 create mode 100755 t/t0212-trace2-event.sh
 create mode 100644 t/t0212/parse_events.perl
 create mode 100644 trace2.c
 create mode 100644 trace2.h
 create mode 100644 trace2/tr2_cfg.c
 create mode 100644 trace2/tr2_cfg.h
 create mode 100644 trace2/tr2_dst.c
 create mode 100644 trace2/tr2_dst.h
 create mode 100644 trace2/tr2_sid.c
 create mode 100644 trace2/tr2_sid.h
 create mode 100644 trace2/tr2_tbuf.c
 create mode 100644 trace2/tr2_tbuf.h
 create mode 100644 trace2/tr2_tgt.h
 create mode 100644 trace2/tr2_tgt_event.c
 create mode 100644 trace2/tr2_tgt_normal.c
 create mode 100644 trace2/tr2_tgt_perf.c
 create mode 100644 trace2/tr2_tls.c
 create mode 100644 trace2/tr2_tls.h
 create mode 100644 trace2/tr2_verb.c
 create mode 100644 trace2/tr2_verb.h


base-commit: 77556354bb7ac50450e3b28999e3576969869068
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-108%2Fjeffhostetler%2Fcore-trace2-2019-v0-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-108/jeffhostetler/core-trace2-2019-v0-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/108
-- 
gitgitgadget
