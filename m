Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85ACA1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbfBAR72 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:59:28 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36752 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729911AbfBAR7F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:59:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so6173091edb.3
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n/Lrw2q0c1jWFikpESUACHbdlIuRSZd80jp8ky/79GM=;
        b=HfJI/GvHbhU7AjukFMpHo9Iq0hwJpbrFCZB5gzisHSXYjvCXoBb0fHP1VWB++vn7lX
         WeQbDM4USc58uVrTRMeUNBGF4ZJDkQ/ThC9PcLD3Lxf+YVlV0FnqVuAPW3q7U4WjTqcs
         q/nGFbFXU1gkEYOZjWcna67RooEjoJuUq8DgSGid8+rkbPgJIuff6fJpo7BzXWoNIl+x
         /oYsDetNkQ5fGVYd7q9k6uL2S0SJh4/3t/vEsrsKeU3z7C2Hhi/2+ZBpsYAA2cSpo9lF
         7euHeRKfM5Lm2MgrVm2gZj8m+5tqkdwdhCkmSayLutkb/ZY7RuHe/jKVyVLytO7HVPh7
         BXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n/Lrw2q0c1jWFikpESUACHbdlIuRSZd80jp8ky/79GM=;
        b=ZoYZJwb+mj/LbIVGWSCwS6GkBONwla6RV1yjJpyObLFsLy/ri3ZH42xP/64aswT+s3
         H241olIU4g+v52EePbQesY4FyhB6zdmeBaNvnHDWjXsbsW07PycpYWhpOSVGLyy5KEJc
         HVBpmgqoExLQ2deT3cyY6XmOtRqITa454XJyY4MPW8jDqq9v+E6HFnydUk/gU8fOgfSQ
         X9rbojWfihkhLR2r17nXhYv8trrki6mLbyfQKj0Kcf3/kgr4rZHazEtPOGvPFjSDqKIK
         qzBzUAA2Au6/TPTgEQbO6sYsF7JSY8CWtmnABbuC0U5eX2NqlrMWjQBWQ9kTA7o+bLQ2
         mqbg==
X-Gm-Message-State: AHQUAuYM8sXOW1H44VtNdMkPc9SKrZ66o5PlqrhZN6xrEt4xBne1B4lD
        sfT3EmkyDZyvNMqPQZumHudbWnop
X-Google-Smtp-Source: AHgI3IaC+d27gDNVoNcuQiLy+DDZdOdphVLRK7kRorDQkA3FjBFRkCsDt5kMvRoD/qB8nCrDpXCYsA==
X-Received: by 2002:a50:d753:: with SMTP id i19mr15795729edj.75.1549043938796;
        Fri, 01 Feb 2019 09:58:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r51sm2206360eda.64.2019.02.01.09.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:58:58 -0800 (PST)
Date:   Fri, 01 Feb 2019 09:58:58 -0800 (PST)
X-Google-Original-Date: Fri, 01 Feb 2019 17:58:41 GMT
Message-Id: <pull.108.v5.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v4.git.gitgitgadget@gmail.com>
References: <pull.108.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 00/15] Trace2 tracing facility
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-108%2Fjeffhostetler%2Fcore-trace2-2019-v0-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-108/jeffhostetler/core-trace2-2019-v0-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/108

Range-diff vs v4:

  1:  60b56d6a8f !  1:  4c006f4995 trace2: Documentation/technical/api-trace2.txt
     @@ -54,7 +54,7 @@
      +$ cat ~/log.normal
      +12:28:42.620009 common-main.c:38                  version 2.20.1.155.g426c96fcdb
      +12:28:42.620989 common-main.c:39                  start git version
     -+12:28:42.621101 git.c:432                         cmd_verb version (version)
     ++12:28:42.621101 git.c:432                         cmd_name version (version)
      +12:28:42.621215 git.c:662                         exit elapsed:0.001227 code:0
      +12:28:42.621250 trace2/tr2_tgt_normal.c:124       atexit elapsed:0.001265 code:0
      +------------
     @@ -74,7 +74,7 @@
      +$ cat ~/log.perf
      +12:28:42.620675 common-main.c:38                  | d0 | main                     | version      |     |           |           |            | 2.20.1.155.g426c96fcdb
      +12:28:42.621001 common-main.c:39                  | d0 | main                     | start        |     |           |           |            | git version
     -+12:28:42.621111 git.c:432                         | d0 | main                     | cmd_verb     |     |           |           |            | version (version)
     ++12:28:42.621111 git.c:432                         | d0 | main                     | cmd_name     |     |           |           |            | version (version)
      +12:28:42.621225 git.c:662                         | d0 | main                     | exit         |     |  0.001227 |           |            | code:0
      +12:28:42.621259 trace2/tr2_tgt_perf.c:211         | d0 | main                     | atexit       |     |  0.001265 |           |            | code:0
      +------------
     @@ -93,7 +93,7 @@
      +$ cat ~/log.event
      +{"event":"version","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.620713","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
      +{"event":"start","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621027","file":"common-main.c","line":39,"argv":["git","version"]}
     -+{"event":"cmd_verb","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621122","file":"git.c","line":432,"name":"version","hierarchy":"version"}
     ++{"event":"cmd_name","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621122","file":"git.c","line":432,"name":"version","hierarchy":"version"}
      +{"event":"exit","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621236","file":"git.c","line":662,"t_abs":0.001227,"code":0}
      +{"event":"atexit","sid":"1547659722619736-11614","thread":"main","time":"2019-01-16 17:28:42.621268","file":"trace2/tr2_tgt_event.c","line":163,"t_abs":0.001265,"code":0}
      +------------
     @@ -213,20 +213,20 @@
      +These are concerned with describing the specific Git command
      +after the command line, config, and environment are inspected.
      +
     -+`void trace2_cmd_verb(const char *command_verb)`::
     ++`void trace2_cmd_name(const char *name)`::
      +
     -+	Emits a "cmd_verb" message with the canonical name of
     -+	(usually) builtin command, for example "status" or "checkout".
     ++	Emits a "cmd_name" message with the canonical name of the
     ++	command, for example "status" or "checkout".
      +
     -+`void trace2_cmd_subverb(const char *command_subverb)`::
     ++`void trace2_cmd_mode(const char *mode)`::
      +
     -+	Emits a "cmd_subverb" message with a qualifier name to further
     ++	Emits a "cmd_mode" message with a qualifier name to further
      +	describe the current git command.
      ++
      +This message is intended to be used with git commands having multiple
      +major modes.  For example, a "checkout" command can checkout a new
     -+branch or can checkout a single file, so the checkout code could
     -+emit a subverb message of "branch" or "file".
     ++branch or it can checkout a single file, so the checkout code could
     ++emit a cmd_mode message of "branch" or "file".
      +
      +`void trace2_cmd_alias(const char *alias, const char **argv_expansion)`::
      +
     @@ -682,13 +682,13 @@
      +}
      +------------
      +
     -+`"cmd_verb"`::
     -+	This event contains the primary verb for this git process
     -+	and the hierarchy of verbs from parent git processes.
     ++`"cmd_name"`::
     ++	This event contains the command name for this git process
     ++	and the hierarchy of commands from parent git processes.
      ++
      +------------
      +{
     -+	"event":"cmd_verb",
     ++	"event":"cmd_name",
      +	...
      +	"name":"pack-objects",
      +	"hierarchy":"push/pack-objects"
     @@ -696,7 +696,7 @@
      +------------
      ++
      +Normally, the "name" field contains the canonical name of the
     -+command.  When a canonical verb is not available, one of
     ++command.  When a canonical name is not available, one of
      +these special values are used:
      ++
      +------------
     @@ -707,22 +707,22 @@
      +"_usage_"            # usage error
      +------------
      +
     -+`"cmd_subverb"`::
     -+	This event, when present, describes the variant of the main
     -+	verb.  This event may be emitted more than once.
     ++`"cmd_mode"`::
     ++	This event, when present, describes the command variant This
     ++	event may be emitted more than once.
      ++
      +------------
      +{
     -+	"event":"cmd_subverb",
     ++	"event":"cmd_mode",
      +	...
      +	"name":"branch"
      +}
      +------------
      ++
     -+The "name" field is an arbitrary string that makes sense in the
     -+context of the primary verb. For example, checkout can checkout a
     -+branch or an individual file.  And these variations typically have
     -+different performance characteristics that are not comparable.
     ++The "name" field is an arbitrary string to describe the command mode.
     ++For example, checkout can checkout a branch or an individual file.
     ++And these variations typically have different performance
     ++characteristics that are not comparable.
      +
      +`"alias"`::
      +	This event is present when an alias is expanded.
     @@ -983,8 +983,8 @@
      +----------------
      +int cmd_checkout(int argc, const char **argv)
      +{
     -+	trace2_cmd_verb("checkout");
     -+	trace2_cmd_subverb("branch");
     ++	trace2_cmd_name("checkout");
     ++	trace2_cmd_mode("branch");
      +	trace2_def_repo(the_repository);
      +
      +	// emit "def_param" messages for "interesting" config settings.
     @@ -1031,7 +1031,7 @@
      +version 2.20.1.vfs.1.1.47.g534dbe1ad1
      +start git fetch origin
      +worktree /Users/jeffhost/work/gfw
     -+cmd_verb fetch (fetch)
     ++cmd_name fetch (fetch)
      +child_start[0] ssh git@github.com ...
      +child_start[1] git index-pack ...
      +... (Trace2 events from child processes omitted)
     @@ -1049,9 +1049,9 @@
      ++
      +When a git process is a (direct or indirect) child of another
      +git process, it inherits Trace2 context information.  This
     -+allows the child to print a verb hierarchy.  This example
     ++allows the child to print the command hierarchy.  This example
      +shows gc as child[3] of fetch.  When the gc process reports
     -+its verb as "gc", it also reports the hierarchy as "fetch/gc".
     ++its name as "gc", it also reports the hierarchy as "fetch/gc".
      +(In this example, trace2 messages from the child process is
      +indented for clarity.)
      ++
     @@ -1067,13 +1067,13 @@
      +version 2.20.1.160.g5676107ecd.dirty
      +start git fetch official
      +worktree /Users/jeffhost/work/gfw
     -+cmd_verb fetch (fetch)
     ++cmd_name fetch (fetch)
      +...
      +child_start[3] git gc --auto
      +    version 2.20.1.160.g5676107ecd.dirty
      +    start /Users/jeffhost/work/gfw/git gc --auto
      +    worktree /Users/jeffhost/work/gfw
     -+    cmd_verb gc (fetch/gc)
     ++    cmd_name gc (fetch/gc)
      +    exit elapsed:0.001959 code:0
      +    atexit elapsed:0.001997 code:0
      +child_exit[3] pid:20303 code:0 elapsed:0.007564
     @@ -1124,7 +1124,7 @@
      +d0 | main                     | version      |     |           |           |            | 2.20.1.160.g5676107ecd.dirty
      +d0 | main                     | start        |     |           |           |            | git status
      +d0 | main                     | def_repo     | r1  |           |           |            | worktree:/Users/jeffhost/work/gfw
     -+d0 | main                     | cmd_verb     |     |           |           |            | status (status)
     ++d0 | main                     | cmd_name     |     |           |           |            | status (status)
      +...
      +d0 | main                     | region_enter | r1  |  0.010988 |           | status     | label:worktrees
      +d0 | main                     | region_leave | r1  |  0.011236 |  0.000248 | status     | label:worktrees
     @@ -1169,7 +1169,7 @@
      +d0 | main                     | version      |     |           |           |            | 2.20.1.162.gb4ccea44db.dirty
      +d0 | main                     | start        |     |           |           |            | git status
      +d0 | main                     | def_repo     | r1  |           |           |            | worktree:/Users/jeffhost/work/gfw
     -+d0 | main                     | cmd_verb     |     |           |           |            | status (status)
     ++d0 | main                     | cmd_name     |     |           |           |            | status (status)
      +...
      +d0 | main                     | region_enter | r1  |  0.015047 |           | status     | label:untracked
      +d0 | main                     | region_enter |     |  0.015132 |           | dir        | ..label:read_recursive
     @@ -1225,7 +1225,7 @@
      +d0 | main                     | version      |     |           |           |            | 2.20.1.156.gf9916ae094.dirty
      +d0 | main                     | start        |     |           |           |            | git status
      +d0 | main                     | def_repo     | r1  |           |           |            | worktree:/Users/jeffhost/work/gfw
     -+d0 | main                     | cmd_verb     |     |           |           |            | status (status)
     ++d0 | main                     | cmd_name     |     |           |           |            | status (status)
      +d0 | main                     | region_enter | r1  |  0.001791 |           | index      | label:do_read_index .git/index
      +d0 | main                     | data         | r1  |  0.002494 |  0.000703 | index      | ..read/version:2
      +d0 | main                     | data         | r1  |  0.002520 |  0.000729 | index      | ..read/cache_nr:3552
  2:  8c9687830e !  2:  6120ce1bbe trace2: create new combined trace facility
     @@ -41,6 +41,7 @@
       LIB_OBJS += trace.o
      +LIB_OBJS += trace2.o
      +LIB_OBJS += trace2/tr2_cfg.o
     ++LIB_OBJS += trace2/tr2_cmd_name.o
      +LIB_OBJS += trace2/tr2_dst.o
      +LIB_OBJS += trace2/tr2_sid.o
      +LIB_OBJS += trace2/tr2_tbuf.o
     @@ -48,7 +49,6 @@
      +LIB_OBJS += trace2/tr2_tgt_normal.o
      +LIB_OBJS += trace2/tr2_tgt_perf.o
      +LIB_OBJS += trace2/tr2_tls.o
     -+LIB_OBJS += trace2/tr2_verb.o
       LIB_OBJS += trailer.o
       LIB_OBJS += transport.o
       LIB_OBJS += transport-helper.o
     @@ -243,20 +243,20 @@
       				git_set_exec_path(cmd + 1);
       			else {
       				puts(git_exec_path());
     -+				trace2_cmd_verb("_query_");
     ++				trace2_cmd_name("_query_");
       				exit(0);
       			}
       		} else if (!strcmp(cmd, "--html-path")) {
       			puts(system_path(GIT_HTML_PATH));
     -+			trace2_cmd_verb("_query_");
     ++			trace2_cmd_name("_query_");
       			exit(0);
       		} else if (!strcmp(cmd, "--man-path")) {
       			puts(system_path(GIT_MAN_PATH));
     -+			trace2_cmd_verb("_query_");
     ++			trace2_cmd_name("_query_");
       			exit(0);
       		} else if (!strcmp(cmd, "--info-path")) {
       			puts(system_path(GIT_INFO_PATH));
     -+			trace2_cmd_verb("_query_");
     ++			trace2_cmd_name("_query_");
       			exit(0);
       		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
       			use_pager = 1;
     @@ -264,7 +264,7 @@
       			(*argv)++;
       			(*argc)--;
       		} else if (skip_prefix(cmd, "--list-cmds=", &cmd)) {
     -+			trace2_cmd_verb("_query_");
     ++			trace2_cmd_name("_query_");
       			if (!strcmp(cmd, "parseopt")) {
       				struct string_list list = STRING_LIST_INIT_DUP;
       				int i;
     @@ -278,7 +278,7 @@
       
      +			trace2_cmd_alias(alias_command, child.args.argv);
      +			trace2_cmd_list_config();
     -+			trace2_cmd_verb("_run_shell_alias_");
     ++			trace2_cmd_name("_run_shell_alias_");
      +
       			ret = run_command(&child);
       			if (ret >= 0)   /* normal exit */
     @@ -297,7 +297,7 @@
       		setup_work_tree();
       
       	trace_argv_printf(argv, "trace: built-in: git");
     -+	trace2_cmd_verb(p->cmd);
     ++	trace2_cmd_name(p->cmd);
      +	trace2_cmd_list_config();
       
       	validate_cache_entries(&the_index);
     @@ -308,7 +308,7 @@
       	cmd.silent_exec_failure = 1;
      +	cmd.trace2_child_class = "dashed";
       
     -+	trace2_cmd_verb("_run_dashed_");
     ++	trace2_cmd_name("_run_dashed_");
      +
      +	/*
      +	 * The code in run_command() logs trace2 child_start/child_exit
     @@ -346,7 +346,7 @@
      +			 * command verb to indicate this.  Note that the child
      +			 * process will log the actual verb when it runs.
      +			 */
     -+			trace2_cmd_verb("_run_git_alias_");
     ++			trace2_cmd_name("_run_git_alias_");
      +
      +			if (get_super_prefix())
      +				die("%s doesn't support --super-prefix", **argv);
     @@ -387,7 +387,7 @@
      +	 * ("git-remote-http", "git-remote-https", and etc.) here since they
      +	 * are all just copies of the same actual executable.
      +	 */
     -+	trace2_cmd_verb("remote-curl");
     ++	trace2_cmd_name("remote-curl");
      +
       	remote = remote_get(argv[1]);
       
     @@ -603,7 +603,7 @@
         /* Default values for command line options.  */
         /* unsigned short int show_variables = 0; */
       
     -+  trace2_cmd_verb("sh-i18n--envsubst");
     ++  trace2_cmd_name("sh-i18n--envsubst");
      +
         switch (argc)
       	{
     @@ -646,7 +646,7 @@
       	int i;
       	int ret = 0;
       
     -+	trace2_cmd_verb("_parse_");
     ++	trace2_cmd_name("_parse_");
      +
       	argc = parse_options(argc, (const char **)argv, prefix, options, usage, 0);
       
     @@ -666,7 +666,7 @@
       		if (!strcmp(cmds[i].name, argv[1])) {
       			argv++;
       			argc--;
     -+			trace2_cmd_verb(cmds[i].name);
     ++			trace2_cmd_name(cmds[i].name);
      +			trace2_cmd_list_config();
       			return cmds[i].fn(argc, argv);
       		}
     @@ -698,11 +698,11 @@
      +#include "thread-utils.h"
      +#include "version.h"
      +#include "trace2/tr2_cfg.h"
     ++#include "trace2/tr2_cmd_name.h"
      +#include "trace2/tr2_dst.h"
      +#include "trace2/tr2_sid.h"
      +#include "trace2/tr2_tgt.h"
      +#include "trace2/tr2_tls.h"
     -+#include "trace2/tr2_verb.h"
      +
      +static int trace2_enabled;
      +
     @@ -715,6 +715,7 @@
      + * enabled or disabled.  Each TRACE2 API method will try to write an event to
      + * *each* of the enabled targets.
      + */
     ++/* clang-format off */
      +static struct tr2_tgt *tr2_tgt_builtins[] =
      +{
      +	&tr2_tgt_normal,
     @@ -722,14 +723,20 @@
      +	&tr2_tgt_event,
      +	NULL
      +};
     ++/* clang-format on */
      +
     ++/* clang-format off */
      +#define for_each_builtin(j, tgt_j)			\
      +	for (j = 0, tgt_j = tr2_tgt_builtins[j];	\
      +	     tgt_j;					\
      +	     j++, tgt_j = tr2_tgt_builtins[j])
     ++/* clang-format on */
      +
     -+#define for_each_wanted_builtin(j, tgt_j) \
     -+	for_each_builtin(j, tgt_j) if (tr2_dst_trace_want(tgt_j->pdst))
     ++/* clang-format off */
     ++#define for_each_wanted_builtin(j, tgt_j)            \
     ++	for_each_builtin(j, tgt_j)                   \
     ++		if (tr2_dst_trace_want(tgt_j->pdst))
     ++/* clang-format on */
      +
      +/*
      + * Force (rather than lazily) initialize any of the requested
     @@ -745,11 +752,9 @@
      +	int j;
      +	int sum = 0;
      +
     -+	for_each_builtin(j, tgt_j)
     -+	{
     ++	for_each_builtin (j, tgt_j)
      +		if (tgt_j->pfn_init())
      +			sum++;
     -+	}
      +
      +	return sum;
      +}
     @@ -764,10 +769,8 @@
      +	struct tr2_tgt *tgt_j;
      +	int j;
      +
     -+	for_each_builtin(j, tgt_j)
     -+	{
     ++	for_each_builtin (j, tgt_j)
      +		tgt_j->pfn_term();
     -+	}
      +}
      +
      +static int tr2main_exit_code;
     @@ -797,18 +800,16 @@
      +	 */
      +	tr2tls_pop_unwind_self();
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_atexit)
      +			tgt_j->pfn_atexit(us_elapsed_absolute,
      +					  tr2main_exit_code);
     -+	}
      +
      +	tr2_tgt_disable_builtins();
      +
      +	tr2tls_release();
      +	tr2_sid_release();
     -+	tr2_verb_release();
     ++	tr2_cmd_name_release();
      +	tr2_cfg_free_patterns();
      +
      +	trace2_enabled = 0;
     @@ -824,11 +825,9 @@
      +	us_now = getnanotime() / 1000;
      +	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_signal)
      +			tgt_j->pfn_signal(us_elapsed_absolute, signo);
     -+	}
      +
      +	sigchain_pop(signo);
      +	raise(signo);
     @@ -855,11 +854,9 @@
      +	/*
      +	 * Emit 'version' message on each active builtin target.
      +	 */
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_version_fl)
      +			tgt_j->pfn_version_fl(file, line);
     -+	}
      +}
      +
      +int trace2_is_enabled(void)
     @@ -875,11 +872,9 @@
      +	if (!trace2_enabled)
      +		return;
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_start_fl)
      +			tgt_j->pfn_start_fl(file, line, argv);
     -+	}
      +}
      +
      +int trace2_cmd_exit_fl(const char *file, int line, int code)
     @@ -899,12 +894,10 @@
      +	us_now = getnanotime() / 1000;
      +	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_exit_fl)
      +			tgt_j->pfn_exit_fl(file, line, us_elapsed_absolute,
      +					   code);
     -+	}
      +
      +	return code;
      +}
     @@ -922,11 +915,9 @@
      +	 * We expect each target function to treat 'ap' as constant
      +	 * and use va_copy (because an 'ap' can only be walked once).
      +	 */
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_error_va_fl)
      +			tgt_j->pfn_error_va_fl(file, line, fmt, ap);
     -+	}
      +}
      +
      +void trace2_cmd_path_fl(const char *file, int line, const char *pathname)
     @@ -937,14 +928,12 @@
      +	if (!trace2_enabled)
      +		return;
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_command_path_fl)
      +			tgt_j->pfn_command_path_fl(file, line, pathname);
     -+	}
      +}
      +
     -+void trace2_cmd_verb_fl(const char *file, int line, const char *command_verb)
     ++void trace2_cmd_name_fl(const char *file, int line, const char *name)
      +{
      +	struct tr2_tgt *tgt_j;
      +	const char *hierarchy;
     @@ -953,19 +942,16 @@
      +	if (!trace2_enabled)
      +		return;
      +
     -+	tr2_verb_append_hierarchy(command_verb);
     -+	hierarchy = tr2_verb_get_hierarchy();
     ++	tr2_cmd_name_append_hierarchy(name);
     ++	hierarchy = tr2_cmd_name_get_hierarchy();
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     -+		if (tgt_j->pfn_command_verb_fl)
     -+			tgt_j->pfn_command_verb_fl(file, line, command_verb,
     ++	for_each_wanted_builtin (j, tgt_j)
     ++		if (tgt_j->pfn_command_name_fl)
     ++			tgt_j->pfn_command_name_fl(file, line, name,
      +						   hierarchy);
     -+	}
      +}
      +
     -+void trace2_cmd_subverb_fl(const char *file, int line,
     -+			   const char *command_subverb)
     ++void trace2_cmd_mode_fl(const char *file, int line, const char *mode)
      +{
      +	struct tr2_tgt *tgt_j;
      +	int j;
     @@ -973,12 +959,9 @@
      +	if (!trace2_enabled)
      +		return;
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     -+		if (tgt_j->pfn_command_subverb_fl)
     -+			tgt_j->pfn_command_subverb_fl(file, line,
     -+						      command_subverb);
     -+	}
     ++	for_each_wanted_builtin (j, tgt_j)
     ++		if (tgt_j->pfn_command_mode_fl)
     ++			tgt_j->pfn_command_mode_fl(file, line, mode);
      +}
      +
      +void trace2_cmd_alias_fl(const char *file, int line, const char *alias,
     @@ -990,11 +973,9 @@
      +	if (!trace2_enabled)
      +		return;
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_alias_fl)
      +			tgt_j->pfn_alias_fl(file, line, alias, argv);
     -+	}
      +}
      +
      +void trace2_cmd_list_config_fl(const char *file, int line)
     @@ -1031,12 +1012,10 @@
      +	cmd->trace2_child_id = tr2tls_locked_increment(&tr2_next_child_id);
      +	cmd->trace2_child_us_start = us_now;
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_child_start_fl)
      +			tgt_j->pfn_child_start_fl(file, line,
      +						  us_elapsed_absolute, cmd);
     -+	}
      +}
      +
      +void trace2_child_exit_fl(const char *file, int line, struct child_process *cmd,
     @@ -1059,15 +1038,13 @@
      +	else
      +		us_elapsed_child = 0;
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_child_exit_fl)
      +			tgt_j->pfn_child_exit_fl(file, line,
      +						 us_elapsed_absolute,
      +						 cmd->trace2_child_id, cmd->pid,
      +						 child_exit_code,
      +						 us_elapsed_child);
     -+	}
      +}
      +
      +int trace2_exec_fl(const char *file, int line, const char *exe,
     @@ -1087,12 +1064,10 @@
      +
      +	exec_id = tr2tls_locked_increment(&tr2_next_exec_id);
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_exec_fl)
      +			tgt_j->pfn_exec_fl(file, line, us_elapsed_absolute,
      +					   exec_id, exe, argv);
     -+	}
      +
      +	return exec_id;
      +}
     @@ -1110,12 +1085,10 @@
      +	us_now = getnanotime() / 1000;
      +	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_exec_result_fl)
      +			tgt_j->pfn_exec_result_fl(
      +				file, line, us_elapsed_absolute, exec_id, code);
     -+	}
      +}
      +
      +void trace2_thread_start_fl(const char *file, int line, const char *thread_name)
     @@ -1149,12 +1122,10 @@
      +
      +	tr2tls_create_self(thread_name);
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_thread_start_fl)
      +			tgt_j->pfn_thread_start_fl(file, line,
      +						   us_elapsed_absolute);
     -+	}
      +}
      +
      +void trace2_thread_exit_fl(const char *file, int line)
     @@ -1195,13 +1166,11 @@
      +	tr2tls_pop_unwind_self();
      +	us_elapsed_thread = tr2tls_region_elasped_self(us_now);
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_thread_exit_fl)
      +			tgt_j->pfn_thread_exit_fl(file, line,
      +						  us_elapsed_absolute,
      +						  us_elapsed_thread);
     -+	}
      +
      +	tr2tls_unset_self();
      +}
     @@ -1215,11 +1184,9 @@
      +	if (!trace2_enabled)
      +		return;
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_param_fl)
      +			tgt_j->pfn_param_fl(file, line, param, value);
     -+	}
      +}
      +
      +void trace2_def_repo_fl(const char *file, int line, struct repository *repo)
     @@ -1235,11 +1202,9 @@
      +
      +	repo->trace2_repo_id = tr2tls_locked_increment(&tr2_next_repo_id);
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_repo_fl)
      +			tgt_j->pfn_repo_fl(file, line, repo);
     -+	}
      +}
      +
      +void trace2_region_enter_printf_va_fl(const char *file, int line,
     @@ -1265,13 +1230,11 @@
      +	 * We expect each target function to treat 'ap' as constant
      +	 * and use va_copy.
      +	 */
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_region_enter_printf_va_fl)
      +			tgt_j->pfn_region_enter_printf_va_fl(
      +				file, line, us_elapsed_absolute, category,
      +				label, repo, fmt, ap);
     -+	}
      +
      +	tr2tls_push_self(us_now);
      +}
     @@ -1341,14 +1304,12 @@
      +	 * We expect each target function to treat 'ap' as constant
      +	 * and use va_copy.
      +	 */
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_region_leave_printf_va_fl)
      +			tgt_j->pfn_region_leave_printf_va_fl(
      +				file, line, us_elapsed_absolute,
      +				us_elapsed_region, category, label, repo, fmt,
      +				ap);
     -+	}
      +}
      +
      +void trace2_region_leave_fl(const char *file, int line, const char *category,
     @@ -1402,13 +1363,11 @@
      +	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
      +	us_elapsed_region = tr2tls_region_elasped_self(us_now);
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_data_fl)
      +			tgt_j->pfn_data_fl(file, line, us_elapsed_absolute,
      +					   us_elapsed_region, category, repo,
      +					   key, value);
     -+	}
      +}
      +
      +void trace2_data_intmax_fl(const char *file, int line, const char *category,
     @@ -1442,13 +1401,11 @@
      +	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
      +	us_elapsed_region = tr2tls_region_elasped_self(us_now);
      +
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_data_fl)
      +			tgt_j->pfn_data_json_fl(file, line, us_elapsed_absolute,
      +						us_elapsed_region, category,
      +						repo, key, value);
     -+	}
      +}
      +
      +void trace2_printf_va_fl(const char *file, int line, const char *fmt,
     @@ -1469,12 +1426,10 @@
      +	 * We expect each target function to treat 'ap' as constant
      +	 * and use va_copy.
      +	 */
     -+	for_each_wanted_builtin(j, tgt_j)
     -+	{
     ++	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_printf_va_fl)
      +			tgt_j->pfn_printf_va_fl(file, line, us_elapsed_absolute,
      +						fmt, ap);
     -+	}
      +}
      +
      +void trace2_printf_fl(const char *file, int line, const char *fmt, ...)
     @@ -1581,24 +1536,23 @@
      +#define trace2_cmd_path(p) trace2_cmd_path_fl(__FILE__, __LINE__, (p))
      +
      +/*
     -+ * Emit a 'cmd_verb' event with the canonical name of the (usually)
     -+ * builtin command.  This gives post-processors a simple field
     -+ * to identify the command verb without having to parse the argv.
     ++ * Emit a 'cmd_name' event with the canonical name of the command.
     ++ * This gives post-processors a simple field to identify the command
     ++ * without having to parse the argv.
      + */
     -+void trace2_cmd_verb_fl(const char *file, int line, const char *command_verb);
     ++void trace2_cmd_name_fl(const char *file, int line, const char *name);
      +
     -+#define trace2_cmd_verb(v) trace2_cmd_verb_fl(__FILE__, __LINE__, (v))
     ++#define trace2_cmd_name(v) trace2_cmd_name_fl(__FILE__, __LINE__, (v))
      +
      +/*
     -+ * Emit a 'cmd_subverb' event to further describe the command being run.
     ++ * Emit a 'cmd_mode' event to further describe the command being run.
      + * For example, "checkout" can checkout a single file or can checkout a
      + * different branch.  This gives post-processors a simple field to compare
      + * equivalent commands without having to parse the argv.
      + */
     -+void trace2_cmd_subverb_fl(const char *file, int line,
     -+			   const char *command_subverb);
     ++void trace2_cmd_mode_fl(const char *file, int line, const char *mode);
      +
     -+#define trace2_cmd_subverb(sv) trace2_cmd_subverb_fl(__FILE__, __LINE__, (sv))
     ++#define trace2_cmd_mode(sv) trace2_cmd_mode_fl(__FILE__, __LINE__, (sv))
      +
      +/*
      + * Emit an 'alias' expansion event.
     @@ -1767,10 +1721,12 @@
      +	trace2_region_enter_printf_fl(__FILE__, __LINE__, (category), (label), \
      +				      (repo), __VA_ARGS__)
      +#else
     ++/* clang-format off */
      +__attribute__((format (region_enter_printf, 4, 5)))
      +void trace2_region_enter_printf(const char *category, const char *label,
      +				const struct repository *repo, const char *fmt,
      +				...);
     ++/* clang-format on */
      +#endif
      +
      +/*
     @@ -1805,10 +1761,12 @@
      +	trace2_region_leave_printf_fl(__FILE__, __LINE__, (category), (label), \
      +				      (repo), __VA_ARGS__)
      +#else
     ++/* clang-format off */
      +__attribute__((format (region_leave_printf, 4, 5)))
      +void trace2_region_leave_printf(const char *category, const char *label,
      +				const struct repository *repo, const char *fmt,
      +				...);
     ++/* clang-format on */
      +#endif
      +
      +/*
     @@ -1863,8 +1821,10 @@
      +#ifdef HAVE_VARIADIC_MACROS
      +#define trace2_printf(...) trace2_printf_fl(__FILE__, __LINE__, __VA_ARGS__)
      +#else
     ++/* clang-format off */
      +__attribute__((format (printf, 1, 2)))
      +void trace2_printf(const char *fmt, ...);
     ++/* clang-format on */
      +#endif
      +
      +#endif /* TRACE2_H */
     @@ -1990,6 +1950,72 @@
      +
      +#endif /* TR2_CFG_H */
      
     + diff --git a/trace2/tr2_cmd_name.c b/trace2/tr2_cmd_name.c
     + new file mode 100644
     + --- /dev/null
     + +++ b/trace2/tr2_cmd_name.c
     +@@
     ++#include "cache.h"
     ++#include "trace2/tr2_cmd_name.h"
     ++
     ++#define TR2_ENVVAR_PARENT_NAME "GIT_TR2_PARENT_NAME"
     ++
     ++static struct strbuf tr2cmdname_hierarchy = STRBUF_INIT;
     ++
     ++void tr2_cmd_name_append_hierarchy(const char *name)
     ++{
     ++	const char *parent_name = getenv(TR2_ENVVAR_PARENT_NAME);
     ++
     ++	strbuf_reset(&tr2cmdname_hierarchy);
     ++	if (parent_name && *parent_name) {
     ++		strbuf_addstr(&tr2cmdname_hierarchy, parent_name);
     ++		strbuf_addch(&tr2cmdname_hierarchy, '/');
     ++	}
     ++	strbuf_addstr(&tr2cmdname_hierarchy, name);
     ++
     ++	setenv(TR2_ENVVAR_PARENT_NAME, tr2cmdname_hierarchy.buf, 1);
     ++}
     ++
     ++const char *tr2_cmd_name_get_hierarchy(void)
     ++{
     ++	return tr2cmdname_hierarchy.buf;
     ++}
     ++
     ++void tr2_cmd_name_release(void)
     ++{
     ++	strbuf_release(&tr2cmdname_hierarchy);
     ++}
     +
     + diff --git a/trace2/tr2_cmd_name.h b/trace2/tr2_cmd_name.h
     + new file mode 100644
     + --- /dev/null
     + +++ b/trace2/tr2_cmd_name.h
     +@@
     ++#ifndef TR2_CMD_NAME_H
     ++#define TR2_CMD_NAME_H
     ++
     ++/*
     ++ * Append the current command name to the list being maintained
     ++ * in the environment.
     ++ *
     ++ * The hierarchy for a top-level git command is just the current
     ++ * command name.  For a child git process, the hierarchy includes the
     ++ * names of the parent processes.
     ++ *
     ++ * The hierarchy for the current process will be exported to the
     ++ * environment and inherited by child processes.
     ++ */
     ++void tr2_cmd_name_append_hierarchy(const char *name);
     ++
     ++/*
     ++ * Get the command name hierarchy for the current process.
     ++ */
     ++const char *tr2_cmd_name_get_hierarchy(void);
     ++
     ++void tr2_cmd_name_release(void);
     ++
     ++#endif /* TR2_CMD_NAME_H */
     +
       diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
       new file mode 100644
       --- /dev/null
     @@ -2432,11 +2458,11 @@
      +
      +typedef void(tr2_tgt_evt_command_path_fl_t)(const char *file, int line,
      +					    const char *command_path);
     -+typedef void(tr2_tgt_evt_command_verb_fl_t)(const char *file, int line,
     -+					    const char *command_verb,
     ++typedef void(tr2_tgt_evt_command_name_fl_t)(const char *file, int line,
     ++					    const char *name,
      +					    const char *hierarchy);
     -+typedef void(tr2_tgt_evt_command_subverb_fl_t)(const char *file, int line,
     -+					       const char *command_subverb);
     ++typedef void(tr2_tgt_evt_command_mode_fl_t)(const char *file, int line,
     ++					    const char *mode);
      +
      +typedef void(tr2_tgt_evt_alias_fl_t)(const char *file, int line,
      +				     const char *alias, const char **argv);
     @@ -2499,6 +2525,7 @@
      + * "vtable" for a TRACE2 target.  Use NULL if a target does not want
      + * to emit that message.
      + */
     ++/* clang-format off */
      +struct tr2_tgt {
      +	struct tr2_dst                          *pdst;
      +
     @@ -2512,8 +2539,8 @@
      +	tr2_tgt_evt_atexit_t                    *pfn_atexit;
      +	tr2_tgt_evt_error_va_fl_t               *pfn_error_va_fl;
      +	tr2_tgt_evt_command_path_fl_t           *pfn_command_path_fl;
     -+	tr2_tgt_evt_command_verb_fl_t           *pfn_command_verb_fl;
     -+	tr2_tgt_evt_command_subverb_fl_t        *pfn_command_subverb_fl;
     ++	tr2_tgt_evt_command_name_fl_t           *pfn_command_name_fl;
     ++	tr2_tgt_evt_command_mode_fl_t           *pfn_command_mode_fl;
      +	tr2_tgt_evt_alias_fl_t                  *pfn_alias_fl;
      +	tr2_tgt_evt_child_start_fl_t            *pfn_child_start_fl;
      +	tr2_tgt_evt_child_exit_fl_t             *pfn_child_exit_fl;
     @@ -2529,6 +2556,7 @@
      +	tr2_tgt_evt_data_json_fl_t              *pfn_data_json_fl;
      +	tr2_tgt_evt_printf_va_fl_t              *pfn_printf_va_fl;
      +};
     ++/* clang-format on */
      +
      +extern struct tr2_tgt tr2_tgt_event;
      +extern struct tr2_tgt tr2_tgt_normal;
     @@ -2789,33 +2817,32 @@
      +	jw_release(&jw);
      +}
      +
     -+static void fn_command_verb_fl(const char *file, int line,
     -+			       const char *command_verb,
     -+			       const char *verb_hierarchy)
     ++static void fn_command_name_fl(const char *file, int line,
     ++			       const char *name,
     ++			       const char *hierarchy)
      +{
     -+	const char *event_name = "cmd_verb";
     ++	const char *event_name = "cmd_name";
      +	struct json_writer jw = JSON_WRITER_INIT;
      +
      +	jw_object_begin(&jw, 0);
      +	event_fmt_prepare(event_name, file, line, NULL, &jw);
     -+	jw_object_string(&jw, "name", command_verb);
     -+	if (verb_hierarchy && *verb_hierarchy)
     -+		jw_object_string(&jw, "hierarchy", verb_hierarchy);
     ++	jw_object_string(&jw, "name", name);
     ++	if (hierarchy && *hierarchy)
     ++		jw_object_string(&jw, "hierarchy", hierarchy);
      +	jw_end(&jw);
      +
      +	tr2_dst_write_line(&tr2dst_event, &jw.json);
      +	jw_release(&jw);
      +}
      +
     -+static void fn_command_subverb_fl(const char *file, int line,
     -+				  const char *command_subverb)
     ++static void fn_command_mode_fl(const char *file, int line, const char *mode)
      +{
     -+	const char *event_name = "cmd_subverb";
     ++	const char *event_name = "cmd_mode";
      +	struct json_writer jw = JSON_WRITER_INIT;
      +
      +	jw_object_begin(&jw, 0);
      +	event_fmt_prepare(event_name, file, line, NULL, &jw);
     -+	jw_object_string(&jw, "name", command_subverb);
     ++	jw_object_string(&jw, "name", mode);
      +	jw_end(&jw);
      +
      +	tr2_dst_write_line(&tr2dst_event, &jw.json);
     @@ -3114,8 +3141,8 @@
      +	fn_atexit,
      +	fn_error_va_fl,
      +	fn_command_path_fl,
     -+	fn_command_verb_fl,
     -+	fn_command_subverb_fl,
     ++	fn_command_name_fl,
     ++	fn_command_mode_fl,
      +	fn_alias_fl,
      +	fn_child_start_fl,
      +	fn_child_exit_fl,
     @@ -3300,25 +3327,24 @@
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_command_verb_fl(const char *file, int line,
     -+			       const char *command_verb,
     -+			       const char *verb_hierarchy)
     ++static void fn_command_name_fl(const char *file, int line,
     ++			       const char *name,
     ++			       const char *hierarchy)
      +{
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
     -+	strbuf_addf(&buf_payload, "cmd_verb %s", command_verb);
     -+	if (verb_hierarchy && *verb_hierarchy)
     -+		strbuf_addf(&buf_payload, " (%s)", verb_hierarchy);
     ++	strbuf_addf(&buf_payload, "cmd_name %s", name);
     ++	if (hierarchy && *hierarchy)
     ++		strbuf_addf(&buf_payload, " (%s)", hierarchy);
      +	normal_io_write_fl(file, line, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_command_subverb_fl(const char *file, int line,
     -+				  const char *command_subverb)
     ++static void fn_command_mode_fl(const char *file, int line, const char *mode)
      +{
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
     -+	strbuf_addf(&buf_payload, "cmd_subverb %s", command_subverb);
     ++	strbuf_addf(&buf_payload, "cmd_mode %s", mode);
      +	normal_io_write_fl(file, line, &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
     @@ -3445,8 +3471,8 @@
      +	fn_atexit,
      +	fn_error_va_fl,
      +	fn_command_path_fl,
     -+	fn_command_verb_fl,
     -+	fn_command_subverb_fl,
     ++	fn_command_name_fl,
     ++	fn_command_mode_fl,
      +	fn_alias_fl,
      +	fn_child_start_fl,
      +	fn_child_exit_fl,
     @@ -3721,29 +3747,28 @@
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_command_verb_fl(const char *file, int line,
     -+			       const char *command_verb,
     -+			       const char *verb_hierarchy)
     ++static void fn_command_name_fl(const char *file, int line,
     ++			       const char *name,
     ++			       const char *hierarchy)
      +{
     -+	const char *event_name = "cmd_verb";
     ++	const char *event_name = "cmd_name";
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
     -+	strbuf_addstr(&buf_payload, command_verb);
     -+	if (verb_hierarchy && *verb_hierarchy)
     -+		strbuf_addf(&buf_payload, " (%s)", verb_hierarchy);
     ++	strbuf_addstr(&buf_payload, name);
     ++	if (hierarchy && *hierarchy)
     ++		strbuf_addf(&buf_payload, " (%s)", hierarchy);
      +
      +	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
      +			 &buf_payload);
      +	strbuf_release(&buf_payload);
      +}
      +
     -+static void fn_command_subverb_fl(const char *file, int line,
     -+				  const char *command_subverb)
     ++static void fn_command_mode_fl(const char *file, int line, const char *mode)
      +{
     -+	const char *event_name = "cmd_subverb";
     ++	const char *event_name = "cmd_mode";
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
     -+	strbuf_addstr(&buf_payload, command_subverb);
     ++	strbuf_addstr(&buf_payload, mode);
      +
      +	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
      +			 &buf_payload);
     @@ -3987,8 +4012,8 @@
      +	fn_atexit,
      +	fn_error_va_fl,
      +	fn_command_path_fl,
     -+	fn_command_verb_fl,
     -+	fn_command_subverb_fl,
     ++	fn_command_name_fl,
     ++	fn_command_mode_fl,
      +	fn_alias_fl,
      +	fn_child_start_fl,
      +	fn_child_exit_fl,
     @@ -4278,72 +4303,6 @@
      +
      +#endif /* TR2_TLS_H */
      
     - diff --git a/trace2/tr2_verb.c b/trace2/tr2_verb.c
     - new file mode 100644
     - --- /dev/null
     - +++ b/trace2/tr2_verb.c
     -@@
     -+#include "cache.h"
     -+#include "trace2/tr2_verb.h"
     -+
     -+#define TR2_ENVVAR_PARENT_VERB "GIT_TR2_PARENT_VERB"
     -+
     -+static struct strbuf tr2verb_hierarchy = STRBUF_INIT;
     -+
     -+void tr2_verb_append_hierarchy(const char *verb)
     -+{
     -+	const char *parent_verb = getenv(TR2_ENVVAR_PARENT_VERB);
     -+
     -+	strbuf_reset(&tr2verb_hierarchy);
     -+	if (parent_verb && *parent_verb) {
     -+		strbuf_addstr(&tr2verb_hierarchy, parent_verb);
     -+		strbuf_addch(&tr2verb_hierarchy, '/');
     -+	}
     -+	strbuf_addstr(&tr2verb_hierarchy, verb);
     -+
     -+	setenv(TR2_ENVVAR_PARENT_VERB, tr2verb_hierarchy.buf, 1);
     -+}
     -+
     -+const char *tr2_verb_get_hierarchy(void)
     -+{
     -+	return tr2verb_hierarchy.buf;
     -+}
     -+
     -+void tr2_verb_release(void)
     -+{
     -+	strbuf_release(&tr2verb_hierarchy);
     -+}
     -
     - diff --git a/trace2/tr2_verb.h b/trace2/tr2_verb.h
     - new file mode 100644
     - --- /dev/null
     - +++ b/trace2/tr2_verb.h
     -@@
     -+#ifndef TR2_VERB_H
     -+#define TR2_VERB_H
     -+
     -+/*
     -+ * Append the current git command's "verb" to the list being maintained
     -+ * in the environment.
     -+ *
     -+ * The hierarchy for a top-level git command is just the current verb.
     -+ * For a child git process, the hierarchy lists the verbs of the parent
     -+ * git processes (much like the SID).
     -+ *
     -+ * The hierarchy for the current process will be exported to the environment
     -+ * and inherited by child processes.
     -+ */
     -+void tr2_verb_append_hierarchy(const char *verb);
     -+
     -+/*
     -+ * Get the verb hierarchy for the current process.
     -+ */
     -+const char *tr2_verb_get_hierarchy(void);
     -+
     -+void tr2_verb_release(void);
     -+
     -+#endif /* TR2_VERB_H */
     -
       diff --git a/usage.c b/usage.c
       --- a/usage.c
       +++ b/usage.c
     @@ -4357,7 +4316,7 @@
      +	 * cmd_main(), we don't know what verb to report.  Force it to this
      +	 * to facilitate post-processing.
      +	 */
     -+	trace2_cmd_verb("_usage_");
     ++	trace2_cmd_name("_usage_");
      +
      +	/*
      +	 * Currently, the (err, params) are usually just the static usage
  3:  6167aba76c !  3:  7c987cde86 trace2: collect platform-specific process information
     @@ -1,16 +1,14 @@
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
     -    trace2: collect platform-specific process information
     +    trace2: collect Windows-specific process information
      
     -    Add optional platform-specific code to log information about
     -    the current process.
     +    Add platform-specific interface to log information about the current
     +    process.
      
     -    On Windows, this includes whether git.exe is running under a
     -    debugger and information about the ancestors of the process.
     +    On Windows, this interface is used to indicate whether the git process
     +    is running under a debugger and list names of the process ancestors.
      
     -    The purpose of this information is to help indicate if the
     -    process was launched interactively or in the background by
     -    an IDE, for example.
     +    Information for other platforms is left for a future effort.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ -26,10 +24,10 @@
       	git_resolve_executable_dir(argv[0]);
       
      
     - diff --git a/compat/win32/ancestry.c b/compat/win32/ancestry.c
     + diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
       new file mode 100644
       --- /dev/null
     - +++ b/compat/win32/ancestry.c
     + +++ b/compat/win32/trace2_win32_process_info.c
      @@
      +#include "../../cache.h"
      +#include "../../json-writer.h"
     @@ -140,7 +138,7 @@
       	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
       	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
       		compat/win32/pthread.o compat/win32/syslog.o \
     -+		compat/win32/ancestry.o \
     ++		compat/win32/trace2_win32_process_info.o \
       		compat/win32/dirent.o
       	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
       	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE
     @@ -148,7 +146,7 @@
       	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
       	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
       	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
     -+		compat/win32/ancestry.o \
     ++		compat/win32/trace2_win32_process_info.o \
       		compat/win32/path-utils.o \
       		compat/win32/pthread.o compat/win32/syslog.o \
       		compat/win32/dirent.o
     @@ -157,7 +155,7 @@
       --- a/trace2.h
       +++ b/trace2.h
      @@
     - void trace2_printf(const char *fmt, ...);
     + /* clang-format on */
       #endif
       
      +/*
  4:  3624c6cbd9 =  4:  cd860799f8 trace2:data: add trace2 regions to wt-status
  5:  638fdb294f =  5:  30bcea9435 trace2:data: add editor/pager child classification
  6:  f4f0453e6b =  6:  c869de8063 trace2:data: add trace2 sub-process classification
  7:  660b83c453 =  7:  3cd525b80e trace2:data: add trace2 transport child classification
  8:  ab26888126 =  8:  c2c1ea5ce3 trace2:data: add trace2 hook classification
  9:  87a73af338 =  9:  57b23542b3 trace2:data: add trace2 instrumentation to index read/write
 10:  be707ea960 ! 10:  ab74ef5f23 pack-objects: add trace2 regions
     @@ -1,6 +1,6 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    pack-objects: add trace2 regions
     +    trace2:data: pack-objects: add trace2 regions
      
          When studying the performance of 'git push' we would like to know
          how much time is spent at various parts of the command. One area
 11:  b4c8ff53dd ! 11:  6a82426a83 trace2:data: add subverb to checkout command
     @@ -11,7 +11,7 @@
       	struct lock_file lock_file = LOCK_INIT;
       	int nr_checkouts = 0;
       
     -+	trace2_cmd_subverb(opts->patch_mode ? "patch" : "path");
     ++	trace2_cmd_mode(opts->patch_mode ? "patch" : "path");
      +
       	if (opts->track != BRANCH_TRACK_UNSPECIFIED)
       		die(_("'%s' cannot be used with updating paths"), "--track");
     @@ -21,7 +21,7 @@
       	struct object_id rev;
       	int flag, writeout_error = 0;
      +
     -+	trace2_cmd_subverb("branch");
     ++	trace2_cmd_mode("branch");
      +
       	memset(&old_branch_info, 0, sizeof(old_branch_info));
       	old_branch_info.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
     @@ -30,7 +30,7 @@
       	int status;
       	struct strbuf branch_ref = STRBUF_INIT;
       
     -+	trace2_cmd_subverb("unborn");
     ++	trace2_cmd_mode("unborn");
      +
       	if (!opts->new_branch)
       		die(_("You are on a branch yet to be born"));
 12:  ed1d612006 ! 12:  5c7f0de228 trace2:data: add subverb to reset command
     @@ -11,7 +11,7 @@
       	if (patch_mode) {
       		if (reset_type != NONE)
       			die(_("--patch is incompatible with --{hard,mixed,soft}"));
     -+		trace2_cmd_subverb("patch-interactive");
     ++		trace2_cmd_mode("patch-interactive");
       		return run_add_interactive(rev, "--patch=reset", &pathspec);
       	}
       
     @@ -20,9 +20,9 @@
       		reset_type = MIXED; /* by default */
       
      +	if (pathspec.nr)
     -+		trace2_cmd_subverb("path");
     ++		trace2_cmd_mode("path");
      +	else
     -+		trace2_cmd_subverb(reset_type_names[reset_type]);
     ++		trace2_cmd_mode(reset_type_names[reset_type]);
      +
       	if (reset_type != SOFT && (reset_type != MIXED || get_git_work_tree()))
       		setup_work_tree();
 13:  4f55f33624 ! 13:  cc61201061 trace2:data: add subverb for rebase
     @@ -28,11 +28,11 @@
       
      +	if (trace2_is_enabled()) {
      +		if (is_interactive(&options))
     -+			trace2_cmd_subverb("interactive");
     ++			trace2_cmd_mode("interactive");
      +		else if (exec.nr)
     -+			trace2_cmd_subverb("interactive-exec");
     ++			trace2_cmd_mode("interactive-exec");
      +		else
     -+			trace2_cmd_subverb(action_names[action]);
     ++			trace2_cmd_mode(action_names[action]);
      +	}
      +
       	switch (action) {
 14:  8d47cd71ed ! 14:  00b25da38b trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
     @@ -89,7 +89,7 @@
      + * [] the process-exit value.
      + * [] the "code" field in the "exit" trace2 event.
      + * [] the "code" field in the "atexit" trace2 event.
     -+ * [] the "name" field in the "cmd_verb" trace2 event.
     ++ * [] the "name" field in the "cmd_name" trace2 event.
      + * [] "def_param" events for all of the "interesting" pre-defined
      + * config settings.
      + */
     @@ -109,7 +109,7 @@
      + * Test harness can confirm:
      + * [] the "code" field in the "exit" trace2 event.
      + * [] the "code" field in the "atexit" trace2 event.
     -+ * [] the "name" field in the "cmd_verb" trace2 event.
     ++ * [] the "name" field in the "cmd_name" trace2 event.
      + * [] "def_param" events for all of the "interesting" pre-defined
      + * config settings.
      + */
     @@ -130,7 +130,7 @@
      + *
      + * Test harness can confirm:
      + * [] a trace2 "error" event for each value in argv.
     -+ * [] the "name" field in the "cmd_verb" trace2 event.
     ++ * [] the "name" field in the "cmd_name" trace2 event.
      + * [] (optional) the file:line in the "exit" event refers to this function.
      + */
      +static int ut_003error(int argc, const char **argv)
     @@ -157,7 +157,7 @@
      + * test-tool trace2 004child git -c alias.xyz=version xyz
      + *
      + * Test harness can confirm:
     -+ * [] the "name" field in the "cmd_verb" trace2 event.
     ++ * [] the "name" field in the "cmd_name" trace2 event.
      + * [] that the outer process has a single component SID (or depth "d0" in
      + *    the PERF stream).
      + * [] that "child_start" and "child_exit" events are generated for the child.
     @@ -203,7 +203,7 @@
      + * test-tool trace2 005exec version
      + *
      + * Test harness can confirm (on Windows):
     -+ * [] the "name" field in the "cmd_verb" trace2 event.
     ++ * [] the "name" field in the "cmd_name" trace2 event.
      + * [] that the outer process has a single component SID (or depth "d0" in
      + *    the PERF stream).
      + * [] that "exec" and "exec_result" events are generated for the child
     @@ -255,6 +255,7 @@
      + */
      +#define USAGE_PREFIX "test-tool trace2"
      +
     ++/* clang-format off */
      +static struct unit_test ut_table[] = {
      +	{ ut_001return,   "001return", "<exit_code>" },
      +	{ ut_002exit,     "002exit",   "<exit_code>" },
     @@ -263,11 +264,14 @@
      +	{ ut_005exec,     "005exec",   "<git_command_args>" },
      +	{ ut_006data,     "006data",   "[<category> <key> <value>]+" },
      +};
     ++/* clang-format on */
      +
     ++/* clang-format off */
      +#define for_each_ut(k, ut_k)			\
      +	for (k = 0, ut_k = &ut_table[k];	\
      +	     k < ARRAY_SIZE(ut_table);		\
      +	     k++, ut_k = &ut_table[k])
     ++/* clang-format on */
      +
      +static int print_usage(void)
      +{
     @@ -275,11 +279,9 @@
      +	struct unit_test *ut_k;
      +
      +	fprintf(stderr, "usage:\n");
     -+	for_each_ut(k, ut_k)
     -+	{
     ++	for_each_ut (k, ut_k)
      +		fprintf(stderr, "\t%s %s %s\n", USAGE_PREFIX, ut_k->ut_name,
      +			ut_k->ut_usage);
     -+	}
      +
      +	return 129;
      +}
     @@ -290,14 +292,14 @@
      + * We assume that these trace2 routines has already been called:
      + *    [] trace2_initialize()      [common-main.c:main()]
      + *    [] trace2_cmd_start()       [common-main.c:main()]
     -+ *    [] trace2_cmd_verb()        [test-tool.c:cmd_main()]
     ++ *    [] trace2_cmd_name()        [test-tool.c:cmd_main()]
      + *    [] tracd2_cmd_list_config() [test-tool.c:cmd_main()]
      + * So that:
      + *    [] the various trace2 streams are open.
      + *    [] the process SID has been created.
      + *    [] the "version" event has been generated.
      + *    [] the "start" event has been generated.
     -+ *    [] the "verb" event has been generated.
     ++ *    [] the "cmd_name" event has been generated.
      + *    [] this writes various "def_param" events for interesting config values.
      + *
      + * We further assume that if we return (rather than exit()), trace2_cmd_exit()
     @@ -311,13 +313,10 @@
      +	argc--; /* skip over "trace2" arg */
      +	argv++;
      +
     -+	if (argc) {
     -+		for_each_ut(k, ut_k)
     -+		{
     ++	if (argc)
     ++		for_each_ut (k, ut_k)
      +			if (!strcmp(argv[0], ut_k->ut_name))
      +				return ut_k->ut_fn(argc - 1, argv + 1);
     -+		}
     -+	}
      +
      +	return print_usage();
      +}
     @@ -370,7 +369,7 @@
      +# We do confirm the following API features:
      +# [] the 'version <v>' event
      +# [] the 'start <argv>' event
     -+# [] the 'cmd_verb <verb>' event
     ++# [] the 'cmd_name <name>' event
      +# [] the 'exit <time> code:<code>' event
      +# [] the 'atexit <time> code:<code>' event
      +#
     @@ -388,7 +387,7 @@
      +	cat >expect <<-EOF &&
      +		version $V
      +		start _EXE_ trace2 001return 0
     -+		cmd_verb trace2 (trace2)
     ++		cmd_name trace2 (trace2)
      +		exit elapsed:_TIME_ code:0
      +		atexit elapsed:_TIME_ code:0
      +	EOF
     @@ -402,7 +401,7 @@
      +	cat >expect <<-EOF &&
      +		version $V
      +		start _EXE_ trace2 001return 1
     -+		cmd_verb trace2 (trace2)
     ++		cmd_name trace2 (trace2)
      +		exit elapsed:_TIME_ code:1
      +		atexit elapsed:_TIME_ code:1
      +	EOF
     @@ -420,7 +419,7 @@
      +	cat >expect <<-EOF &&
      +		version $V
      +		start _EXE_ trace2 002exit 0
     -+		cmd_verb trace2 (trace2)
     ++		cmd_name trace2 (trace2)
      +		exit elapsed:_TIME_ code:0
      +		atexit elapsed:_TIME_ code:0
      +	EOF
     @@ -434,7 +433,7 @@
      +	cat >expect <<-EOF &&
      +		version $V
      +		start _EXE_ trace2 002exit 1
     -+		cmd_verb trace2 (trace2)
     ++		cmd_name trace2 (trace2)
      +		exit elapsed:_TIME_ code:1
      +		atexit elapsed:_TIME_ code:1
      +	EOF
     @@ -452,7 +451,7 @@
      +	cat >expect <<-EOF &&
      +		version $V
      +		start _EXE_ trace2 003error '\''hello world'\'' '\''this is a test'\''
     -+		cmd_verb trace2 (trace2)
     ++		cmd_name trace2 (trace2)
      +		error hello world
      +		error this is a test
      +		exit elapsed:_TIME_ code:0
     @@ -575,7 +574,7 @@
      +	cat >expect <<-EOF &&
      +		d0|main|version|||||$V
      +		d0|main|start|||||_EXE_ trace2 001return 0
     -+		d0|main|cmd_verb|||||trace2 (trace2)
     ++		d0|main|cmd_name|||||trace2 (trace2)
      +		d0|main|exit||_T_ABS_|||code:0
      +		d0|main|atexit||_T_ABS_|||code:0
      +	EOF
     @@ -589,7 +588,7 @@
      +	cat >expect <<-EOF &&
      +		d0|main|version|||||$V
      +		d0|main|start|||||_EXE_ trace2 001return 1
     -+		d0|main|cmd_verb|||||trace2 (trace2)
     ++		d0|main|cmd_name|||||trace2 (trace2)
      +		d0|main|exit||_T_ABS_|||code:1
      +		d0|main|atexit||_T_ABS_|||code:1
      +	EOF
     @@ -607,7 +606,7 @@
      +	cat >expect <<-EOF &&
      +		d0|main|version|||||$V
      +		d0|main|start|||||_EXE_ trace2 003error '\''hello world'\'' '\''this is a test'\''
     -+		d0|main|cmd_verb|||||trace2 (trace2)
     ++		d0|main|cmd_name|||||trace2 (trace2)
      +		d0|main|error|||||hello world
      +		d0|main|error|||||this is a test
      +		d0|main|exit||_T_ABS_|||code:0
     @@ -628,15 +627,15 @@
      +# Which should generate events:
      +#    P1: version
      +#    P1: start
     -+#    P1: cmd_verb
     ++#    P1: cmd_name
      +#    P1: child_start
      +#        P2: version
      +#        P2: start
     -+#        P2: cmd_verb
     ++#        P2: cmd_name
      +#        P2: child_start
      +#            P3: version
      +#            P3: start
     -+#            P3: cmd_verb
     ++#            P3: cmd_name
      +#            P3: exit
      +#            P3: atexit
      +#        P2: child_exit
     @@ -653,15 +652,15 @@
      +	cat >expect <<-EOF &&
      +		d0|main|version|||||$V
      +		d0|main|start|||||_EXE_ trace2 004child test-tool trace2 004child test-tool trace2 001return 0
     -+		d0|main|cmd_verb|||||trace2 (trace2)
     ++		d0|main|cmd_name|||||trace2 (trace2)
      +		d0|main|child_start||_T_ABS_|||[ch0] class:? argv: test-tool trace2 004child test-tool trace2 001return 0
      +		d1|main|version|||||$V
      +		d1|main|start|||||_EXE_ trace2 004child test-tool trace2 001return 0
     -+		d1|main|cmd_verb|||||trace2 (trace2/trace2)
     ++		d1|main|cmd_name|||||trace2 (trace2/trace2)
      +		d1|main|child_start||_T_ABS_|||[ch0] class:? argv: test-tool trace2 001return 0
      +		d2|main|version|||||$V
      +		d2|main|start|||||_EXE_ trace2 001return 0
     -+		d2|main|cmd_verb|||||trace2 (trace2/trace2/trace2)
     ++		d2|main|cmd_name|||||trace2 (trace2/trace2/trace2)
      +		d2|main|exit||_T_ABS_|||code:0
      +		d2|main|atexit||_T_ABS_|||code:0
      +		d1|main|child_exit||_T_ABS_|_T_REL_||[ch0] pid:_PID_ code:0
     @@ -822,8 +821,8 @@
      +	|      "%s"
      +	|    ],
      +	|    "exit_code":0,
     -+	|    "verb":"trace2",
     -+	|    "verb_hierarchy":"trace2",
     ++	|    "hierarchy":"trace2",
     ++	|    "name":"trace2",
      +	|    "version":"$V"
      +	|  }
      +	|};
     @@ -876,8 +875,8 @@
      +	|      }
      +	|    },
      +	|    "exit_code":0,
     -+	|    "verb":"trace2",
     -+	|    "verb_hierarchy":"trace2",
     ++	|    "hierarchy":"trace2",
     ++	|    "name":"trace2",
      +	|    "version":"$V"
      +	|  },
      +	|  "_SID0_/_SID1_":{
     @@ -904,8 +903,8 @@
      +	|      }
      +	|    },
      +	|    "exit_code":0,
     -+	|    "verb":"trace2",
     -+	|    "verb_hierarchy":"trace2/trace2",
     ++	|    "hierarchy":"trace2/trace2",
     ++	|    "name":"trace2",
      +	|    "version":"$V"
      +	|  },
      +	|  "_SID0_/_SID1_/_SID2_":{
     @@ -916,8 +915,8 @@
      +	|      "0"
      +	|    ],
      +	|    "exit_code":0,
     -+	|    "verb":"trace2",
     -+	|    "verb_hierarchy":"trace2/trace2/trace2",
     ++	|    "hierarchy":"trace2/trace2/trace2",
     ++	|    "name":"trace2",
      +	|    "version":"$V"
      +	|  }
      +	|};
     @@ -943,6 +942,8 @@
      +	|      "0"
      +	|    ],
      +	|    "exit_code":0,
     ++	|    "hierarchy":"trace2",
     ++	|    "name":"trace2",
      +	|    "params":[
      +	|      {
      +	|        "param":"t0212.abc",
     @@ -953,8 +954,6 @@
      +	|        "value":"hello world"
      +	|      }
      +	|    ],
     -+	|    "verb":"trace2",
     -+	|    "verb_hierarchy":"trace2",
      +	|    "version":"$V"
      +	|  }
      +	|};
     @@ -987,8 +986,8 @@
      +	|      }
      +	|    },
      +	|    "exit_code":0,
     -+	|    "verb":"trace2",
     -+	|    "verb_hierarchy":"trace2",
     ++	|    "hierarchy":"trace2",
     ++	|    "name":"trace2",
      +	|    "version":"$V"
      +	|  }
      +	|};
     @@ -1138,9 +1137,9 @@
      +	# $processes->{$sid}->{'path'} = "_EXE_";
      +    }
      +    
     -+    elsif ($event eq 'cmd_verb') {
     -+	$processes->{$sid}->{'verb'} = $line->{'name'};
     -+	$processes->{$sid}->{'verb_hierarchy'} = $line->{'hierarchy'};
     ++    elsif ($event eq 'cmd_name') {
     ++	$processes->{$sid}->{'name'} = $line->{'name'};
     ++	$processes->{$sid}->{'hierarchy'} = $line->{'hierarchy'};
      +    }
      +
      +    elsif ($event eq 'alias') {
  -:  ---------- > 15:  5f77c9b633 trace2: add for_each macros to clang-format

-- 
gitgitgadget
