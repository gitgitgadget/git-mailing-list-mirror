Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5D421F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfBFRP4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:15:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43178 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfBFRP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:15:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so6513261eds.10
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I6Kb8SCZCith3W/sPnvNkYE6uVbAk6a1BxMaf570Y30=;
        b=kixPsWwyGMRNGoEgTuRZsoZHzRnbdogUnOKfovc6xvf21Ejk+GVAHDlSCW5Wd0znmG
         JPFJS0zzeC6FeN8vsg2qGnrm0GwgUZKbtCshLH7vtt2IpOsucox+V0XdHSKV6bcDsihq
         N6qU47UoGKm3sikIF6SoXDDWfwOqew5LTX9VkSUHt4Rzyt9tHnxrTvxDObNd1J51p62V
         QD8EhukKwWobxsPrykeM6tzmphMa6SV0HaRNpU0kdxZtCzpw75oyyMcrCf6CbePIsvwH
         5V2vJTZ948AoddRF/uw0E+mYnv/Tiz1fOKp/98eR9sMsdDvmnXCWGmfq2oJZy1gfJ8v2
         hDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I6Kb8SCZCith3W/sPnvNkYE6uVbAk6a1BxMaf570Y30=;
        b=hHupGmtDG/738oaGHPEARwEgn+sJZOG4CvqGbL75Mnkcpi5EyTwdVEmBXT/1M7EjYt
         iQKR7LbIK08g7NNX3EYrVO2PO63cajI8YKrlIvace4n7Vbcno5v9V42mxFVI8jUQ7A9b
         CNC0TynmFUuNRBRk47nSJBo5Nfom94cKFoIwnwapMfxOWuKeKGgSRhrIFno9uINnmYLA
         3uFggGulMBTDmg1PRSIGkz3jnguS8LxFYnuQlZAc/xQzA8PM5Mh945+2ABMRo9EtSVY4
         4vqDAyktHrEKzOXV1EtWe3AicY4TbMyxFY4tE7/109B5/qWfmaxReYCciz6PkYjAXNPF
         /maw==
X-Gm-Message-State: AHQUAuaUr3BfDj/7+CRPpjDFwZxdab0Fcwt7izNJGfY6YtKT2+ElHOT/
        RWrnXNliYFWDM28gBXVCE8DpxMrX
X-Google-Smtp-Source: AHgI3IbAXb86BOHZjY2NABIdi+1xazapCf+HbIBi3ug+9N4pW+Xv2G6yuo7P+XbxO7UQ7kO5TmH/jg==
X-Received: by 2002:a50:d6c5:: with SMTP id l5mr9019881edj.145.1549473352581;
        Wed, 06 Feb 2019 09:15:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r42sm6121552edd.23.2019.02.06.09.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:15:51 -0800 (PST)
Date:   Wed, 06 Feb 2019 09:15:51 -0800 (PST)
X-Google-Original-Date: Wed, 06 Feb 2019 17:15:35 GMT
Message-Id: <pull.108.v6.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v5.git.gitgitgadget@gmail.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 00/15] Trace2 tracing facility
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

V6 addresses: [] The remaining hdr-check warning in trace2/tr2_tls.h

There are no other outstanding comments that I'm aware of.

Thanks Jeff


----------------------------------------------------------------------------

V5 addresses: [] renames "verb" and "subverb" to "cmd_name" and "cmd_mode"
in code and documentation. [] updates clang-format config to not complain
about my for_each macros. [] update formatting around each use of my
for_each macros. [] update the platform-specific process info commit to
indicate it only handles Windows and leaves other platform for future
efforts. [] alters title of pack-objects commit to include "trace2:data:" to
match the other data-only commits.

I think this version addresses all of the feedback received do date.

Thanks Jeff


----------------------------------------------------------------------------

Sorry to spam the list, but here is V4. After building V3 on 3 platforms
without error and submitting, the compilers on platforms 4 and 5 complained
about a variable declaration. (sigh) [] fix declaration after first
statement [] add -DNO_UNIX_SOCKETS to BASIC_CFLAGS when NO_UNIX_SOCKETS is
defined in the Makefile.


----------------------------------------------------------------------------

V3 addresses: [] re-fix the trace2 tests using an inline environment
variable rather than exporting and unsetting. [] overhaul the design
document to include prototype declarations and more file format information.
[] incorporate most of the suggestions from clang-format. [] add ability to
trace to a unix domain socket. [] added forward declarations suggested by
Ramsay. [] rebased onto current master to fixup conflict with
sb/submodule-recursive-fetch-gets-the-tip that was merged yesterday.


----------------------------------------------------------------------------

V2 addresses: [] "jh/trace2" bad interaction with "js/vsts-ci" in "pu". []
coccinelle warnings in trace2/tr2_tgt_perf.c reported during CI testing.


----------------------------------------------------------------------------

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
  trace2:data: pack-objects: add trace2 regions

Jeff Hostetler (14):
  trace2: Documentation/technical/api-trace2.txt
  trace2: create new combined trace facility
  trace2: collect Windows-specific process information
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
  trace2: add for_each macros to clang-format

 .clang-format                            |    2 +-
 Documentation/technical/api-trace2.txt   | 1347 ++++++++++++++++++++++
 Makefile                                 |   15 +-
 builtin/am.c                             |    1 +
 builtin/checkout.c                       |    7 +
 builtin/pack-objects.c                   |   16 +-
 builtin/rebase.c                         |   17 +
 builtin/receive-pack.c                   |    4 +
 builtin/reset.c                          |    6 +
 builtin/submodule--helper.c              |    9 +-
 builtin/worktree.c                       |    1 +
 cache.h                                  |    1 +
 common-main.c                            |   13 +-
 compat/mingw.c                           |   11 +-
 compat/mingw.h                           |    3 +-
 compat/win32/trace2_win32_process_info.c |  101 ++
 config.c                                 |    2 +
 config.mak.uname                         |    2 +
 connect.c                                |    3 +
 editor.c                                 |    1 +
 exec-cmd.c                               |    2 +
 git-compat-util.h                        |    7 +
 git.c                                    |   65 ++
 pager.c                                  |    1 +
 read-cache.c                             |   51 +-
 remote-curl.c                            |    7 +
 repository.c                             |    2 +
 repository.h                             |    3 +
 run-command.c                            |   59 +-
 run-command.h                            |   13 +-
 sequencer.c                              |    2 +
 sh-i18n--envsubst.c                      |    3 +
 sub-process.c                            |    1 +
 submodule.c                              |   11 +-
 t/helper/test-parse-options.c            |    3 +
 t/helper/test-tool.c                     |    4 +
 t/helper/test-tool.h                     |    1 +
 t/helper/test-trace2.c                   |  273 +++++
 t/t0001-init.sh                          |    1 +
 t/t0210-trace2-normal.sh                 |  135 +++
 t/t0210/scrub_normal.perl                |   48 +
 t/t0211-trace2-perf.sh                   |  153 +++
 t/t0211/scrub_perf.perl                  |   76 ++
 t/t0212-trace2-event.sh                  |  234 ++++
 t/t0212/parse_events.perl                |  251 ++++
 trace2.c                                 |  762 ++++++++++++
 trace2.h                                 |  385 +++++++
 trace2/tr2_cfg.c                         |   90 ++
 trace2/tr2_cfg.h                         |   19 +
 trace2/tr2_cmd_name.c                    |   30 +
 trace2/tr2_cmd_name.h                    |   24 +
 trace2/tr2_dst.c                         |  197 ++++
 trace2/tr2_dst.h                         |   36 +
 trace2/tr2_sid.c                         |   67 ++
 trace2/tr2_sid.h                         |   18 +
 trace2/tr2_tbuf.c                        |   32 +
 trace2/tr2_tbuf.h                        |   23 +
 trace2/tr2_tgt.h                         |  133 +++
 trace2/tr2_tgt_event.c                   |  589 ++++++++++
 trace2/tr2_tgt_normal.c                  |  324 ++++++
 trace2/tr2_tgt_perf.c                    |  535 +++++++++
 trace2/tr2_tls.c                         |  164 +++
 trace2/tr2_tls.h                         |   97 ++
 transport-helper.c                       |    2 +
 transport.c                              |    1 +
 usage.c                                  |   31 +
 wt-status.c                              |   24 +-
 67 files changed, 6528 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/technical/api-trace2.txt
 create mode 100644 compat/win32/trace2_win32_process_info.c
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
 create mode 100644 trace2/tr2_cmd_name.c
 create mode 100644 trace2/tr2_cmd_name.h
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


base-commit: b5101f929789889c2e536d915698f58d5c5c6b7a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-108%2Fjeffhostetler%2Fcore-trace2-2019-v0-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-108/jeffhostetler/core-trace2-2019-v0-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/108

Range-diff vs v5:

  1:  4c006f4995 =  1:  4c006f4995 trace2: Documentation/technical/api-trace2.txt
  2:  6120ce1bbe !  2:  6bad326bbd trace2: create new combined trace facility
     @@ -4208,7 +4208,7 @@
      +#ifndef TR2_TLS_H
      +#define TR2_TLS_H
      +
     -+struct strbuf;
     ++#include "strbuf.h"
      +
      +/*
      + * Arbitry limit for thread names for column alignment.
  3:  7c987cde86 =  3:  12de7e42de trace2: collect Windows-specific process information
  4:  cd860799f8 =  4:  5835edbd01 trace2:data: add trace2 regions to wt-status
  5:  30bcea9435 =  5:  99d13ef478 trace2:data: add editor/pager child classification
  6:  c869de8063 =  6:  d7ce85b702 trace2:data: add trace2 sub-process classification
  7:  3cd525b80e =  7:  b70c289903 trace2:data: add trace2 transport child classification
  8:  c2c1ea5ce3 =  8:  2a0da88579 trace2:data: add trace2 hook classification
  9:  57b23542b3 =  9:  bca6a7f0d6 trace2:data: add trace2 instrumentation to index read/write
 10:  ab74ef5f23 = 10:  68269ee060 trace2:data: pack-objects: add trace2 regions
 11:  6a82426a83 = 11:  0191283fff trace2:data: add subverb to checkout command
 12:  5c7f0de228 = 12:  24d8d8d768 trace2:data: add subverb to reset command
 13:  cc61201061 = 13:  90cec071cf trace2:data: add subverb for rebase
 14:  00b25da38b = 14:  b9f0c6fd66 trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
 15:  5f77c9b633 = 15:  93a25d09a1 trace2: add for_each macros to clang-format

-- 
gitgitgadget
