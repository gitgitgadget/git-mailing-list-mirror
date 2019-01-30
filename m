Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9EA1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 20:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387889AbfA3U40 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 15:56:26 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35706 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbfA3U4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so822037edx.2
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 12:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x7sDyMtsp4ELNPktnYmOY8o+u9UT2++cO0ZZj+PHgE0=;
        b=OAWPB6DYTzUN6HMOXYvBzKqSd6pEXA/NrRZJvNcdMDdzqt/O4sSsgCp99C8/USBvst
         wWtSMGrRdOHKqdJRaf9ng9teuOtI/vs7COb6vHNSugsCUXz6xrpgCmL+2gDHN4tYG34T
         U8FDirzFn6r8N4hy3OkzCXXxHESmb4UkZBor9S0xpKZkfMIyOB2FgcJbKjqHaVWrXivG
         JtuIFpgVSQJkfW+3oqwtqoz4FRehPln2+LouRZZ8nPZIeF5uJ4vRnA2HJmAR4CO3dh1u
         nWP814y97xFgcq/gzPr4k1Y7QivggSswdoGjehMTTvM/ffmwwsmrNKRVjqkUek3hW1iJ
         t5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x7sDyMtsp4ELNPktnYmOY8o+u9UT2++cO0ZZj+PHgE0=;
        b=N8T6TjE1LwC+FqeRPnPcTpO+7Nmqr9kCqfl8SwU6xwd4EFcVwZqlb1bFoFP8miB98s
         vF6uVdMlx3OCODptWcQpOB3Cl205j97Mo1hI8og6DsGrcci69YDDQoAWIAhc7wIZ8M/7
         +v62mGowaZrkQmn8lFoDJCsB+biD+oC7tAPNQ7W7xdIi/4WjYY+M2U9lG/m21eRac767
         I/1bFTpcCNFZqsDs2skl5ErM60jqjihcMMR1k/Za9DYU3g9MPazJnzMQKCX1wRhWkRP5
         rCt9v2RMZ1YDFVk50EFJGtELkWAG6+LFRf93Vs5pjTuRqM1Zd6wVxAfO1oR0rtogn/+F
         zGtA==
X-Gm-Message-State: AJcUukcXiAyUlic6fKMcIO2G5cU/eDR3rLGfHRXnrk+X0Qmy6ZeiezBp
        yQir/E4bl3DF9Ge2jJ2BFbhSG/cD
X-Google-Smtp-Source: ALg8bN5fLwOFMC+Kz9bhakczVbCpgVQebn+mIgav7lBUMNjPTzra/uHspFHROVqXEgLI/T8NtzCpQg==
X-Received: by 2002:a17:906:1956:: with SMTP id b22mr26597637eje.216.1548881781198;
        Wed, 30 Jan 2019 12:56:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k32sm773126edb.42.2019.01.30.12.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 12:56:20 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:56:20 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 20:56:05 GMT
Message-Id: <pull.108.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v3.git.gitgitgadget@gmail.com>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 00/14] Trace2 tracing facility
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

 Documentation/technical/api-trace2.txt | 1347 ++++++++++++++++++++++++
 Makefile                               |   15 +-
 builtin/am.c                           |    1 +
 builtin/checkout.c                     |    7 +
 builtin/pack-objects.c                 |   16 +-
 builtin/rebase.c                       |   17 +
 builtin/receive-pack.c                 |    4 +
 builtin/reset.c                        |    6 +
 builtin/submodule--helper.c            |    9 +-
 builtin/worktree.c                     |    1 +
 cache.h                                |    1 +
 common-main.c                          |   13 +-
 compat/mingw.c                         |   11 +-
 compat/mingw.h                         |    3 +-
 compat/win32/ancestry.c                |  101 ++
 config.c                               |    2 +
 config.mak.uname                       |    2 +
 connect.c                              |    3 +
 editor.c                               |    1 +
 exec-cmd.c                             |    2 +
 git-compat-util.h                      |    7 +
 git.c                                  |   65 ++
 pager.c                                |    1 +
 read-cache.c                           |   51 +-
 remote-curl.c                          |    7 +
 repository.c                           |    2 +
 repository.h                           |    3 +
 run-command.c                          |   59 +-
 run-command.h                          |   13 +-
 sequencer.c                            |    2 +
 sh-i18n--envsubst.c                    |    3 +
 sub-process.c                          |    1 +
 submodule.c                            |   11 +-
 t/helper/test-parse-options.c          |    3 +
 t/helper/test-tool.c                   |    4 +
 t/helper/test-tool.h                   |    1 +
 t/helper/test-trace2.c                 |  274 +++++
 t/t0001-init.sh                        |    1 +
 t/t0210-trace2-normal.sh               |  135 +++
 t/t0210/scrub_normal.perl              |   48 +
 t/t0211-trace2-perf.sh                 |  153 +++
 t/t0211/scrub_perf.perl                |   76 ++
 t/t0212-trace2-event.sh                |  234 ++++
 t/t0212/parse_events.perl              |  251 +++++
 trace2.c                               |  807 ++++++++++++++
 trace2.h                               |  380 +++++++
 trace2/tr2_cfg.c                       |   90 ++
 trace2/tr2_cfg.h                       |   19 +
 trace2/tr2_dst.c                       |  197 ++++
 trace2/tr2_dst.h                       |   36 +
 trace2/tr2_sid.c                       |   67 ++
 trace2/tr2_sid.h                       |   18 +
 trace2/tr2_tbuf.c                      |   32 +
 trace2/tr2_tbuf.h                      |   23 +
 trace2/tr2_tgt.h                       |  131 +++
 trace2/tr2_tgt_event.c                 |  590 +++++++++++
 trace2/tr2_tgt_normal.c                |  325 ++++++
 trace2/tr2_tgt_perf.c                  |  536 ++++++++++
 trace2/tr2_tls.c                       |  164 +++
 trace2/tr2_tls.h                       |   97 ++
 trace2/tr2_verb.c                      |   30 +
 trace2/tr2_verb.h                      |   24 +
 transport-helper.c                     |    2 +
 transport.c                            |    1 +
 usage.c                                |   31 +
 wt-status.c                            |   24 +-
 66 files changed, 6569 insertions(+), 22 deletions(-)
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


base-commit: b5101f929789889c2e536d915698f58d5c5c6b7a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-108%2Fjeffhostetler%2Fcore-trace2-2019-v0-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-108/jeffhostetler/core-trace2-2019-v0-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/108

Range-diff vs v3:

  1:  60b56d6a8f =  1:  60b56d6a8f trace2: Documentation/technical/api-trace2.txt
  2:  bfe2fe0bbe !  2:  8c9687830e trace2: create new combined trace facility
     @@ -52,6 +52,17 @@
       LIB_OBJS += trailer.o
       LIB_OBJS += transport.o
       LIB_OBJS += transport-helper.o
     +@@
     + 	LIB_OBJS += compat/inet_pton.o
     + 	BASIC_CFLAGS += -DNO_INET_PTON
     + endif
     +-ifndef NO_UNIX_SOCKETS
     ++ifdef NO_UNIX_SOCKETS
     ++	BASIC_CFLAGS += -DNO_UNIX_SOCKETS
     ++else
     + 	LIB_OBJS += unix-socket.o
     + 	PROGRAM_OBJS += credential-cache.o
     + 	PROGRAM_OBJS += credential-cache--daemon.o
      
       diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
       --- a/builtin/submodule--helper.c
     @@ -2154,6 +2165,8 @@
      +
      +void tr2_dst_write_line(struct tr2_dst *dst, struct strbuf *buf_line)
      +{
     ++	int fd = tr2_dst_get_trace_fd(dst);
     ++
      +	strbuf_complete_line(buf_line); /* ensure final NL on buffer */
      +
      +	/*
     @@ -2171,9 +2184,6 @@
      +	 *
      +	 * If we get an IO error, just close the trace dst.
      +	 */
     -+
     -+	int fd = tr2_dst_get_trace_fd(dst);
     -+
      +	if (write(fd, buf_line->buf, buf_line->len) >= 0)
      +		return;
      +
  3:  e8b8226640 =  3:  6167aba76c trace2: collect platform-specific process information
  4:  0d59a6f2eb =  4:  3624c6cbd9 trace2:data: add trace2 regions to wt-status
  5:  2513091f77 =  5:  638fdb294f trace2:data: add editor/pager child classification
  6:  785f6f866e =  6:  f4f0453e6b trace2:data: add trace2 sub-process classification
  7:  b7e6644f4b =  7:  660b83c453 trace2:data: add trace2 transport child classification
  8:  52aace533b =  8:  ab26888126 trace2:data: add trace2 hook classification
  9:  a2bcc6fd28 =  9:  87a73af338 trace2:data: add trace2 instrumentation to index read/write
 10:  d508322638 = 10:  be707ea960 pack-objects: add trace2 regions
 11:  33e431be88 = 11:  b4c8ff53dd trace2:data: add subverb to checkout command
 12:  e46e92bc7c = 12:  ed1d612006 trace2:data: add subverb to reset command
 13:  0a05e15978 = 13:  4f55f33624 trace2:data: add subverb for rebase
 14:  aeaf990b1b = 14:  8d47cd71ed trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh

-- 
gitgitgadget
