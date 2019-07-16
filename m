Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91BCE1F461
	for <e@80x24.org>; Tue, 16 Jul 2019 14:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbfGPO6k (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 10:58:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36731 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387892AbfGPO6k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 10:58:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so21358196wrs.3
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jUa58BvZN96ixvX41CYQgbkqauEdJj7m0AM6Rf1CJIM=;
        b=IplXiave8E7g7uqOF32z948SIpEop878rts5Grt6/9fRw9cywBezpz2MPXI/NJ2Rh0
         PF1yh0AgxZYqLujEheginvHabO6MeO58AXaHlHqwefV96egYTSGuthFkLnO/lAtHTZ/P
         hF2AfKRShtzu3B0jRRNvRuMoFQzmVEAzL0tQsS2fCUyC39kRfr0dUJiH4otzf4wgZ+kl
         k8kXoPiVBWDo+t1DJ8Zq0tvMscQlQvmpXn87sbt4ks5XYxhc7Hvc8uW2DcFYZ3sM0/RS
         bbhEWlpE52oHRPprKB/lq6CYj3lNiuAOkq2EQgR/5lJfCygDmdKPu3kuW5sa99slp5kC
         sSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jUa58BvZN96ixvX41CYQgbkqauEdJj7m0AM6Rf1CJIM=;
        b=FLIsvJ7vYf0ogNEQEXHi3qf58ac946ljMeJNm9S4WD9WzDGhQFbgTb1WWvUKfzxL7l
         JW031IOVcLNY/RMw5YHeSNNkjGBcLiZuKnHq0JOlEN3Qavx75AB2jR+USS5jwcyi9+cS
         OP2JrOJboYq4aFsrbkd2rj7f3ubepbvCk730eZcprYXd+X40Gv60kUOK9xuGjH9C/PSy
         GzS2amOZpuomGhkcMXM2N5sA+NAND+xL+zE3r4LCBpcLLBdbxnsEdC8oy/WTWWgHbXHX
         FhJvKAD7ZBP9z25SEc0nuYwBIkOIzSMZCpd4wzNzBH9tQ2xzwM0P5kBNAOM0nymbllwV
         XzJg==
X-Gm-Message-State: APjAAAVlJGPy9ZGAoDvycZ3EUcCawg8Ii6PSQapzAvrGCsgE7K8FQO+o
        pZmSAiNCHxnPMtTsaaJD51Pkg5Hc
X-Google-Smtp-Source: APXvYqw4EwMP1Lt+8wrwXMYGGgf5NUTv78yAHglUwnPZt9St1w6chV5va8n6O263uVDja4oGNL2WTQ==
X-Received: by 2002:a5d:6508:: with SMTP id x8mr7573475wru.310.1563289117126;
        Tue, 16 Jul 2019 07:58:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm19095247wmh.34.2019.07.16.07.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:58:36 -0700 (PDT)
Date:   Tue, 16 Jul 2019 07:58:36 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Jul 2019 14:58:24 GMT
Message-Id: <pull.170.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v2.git.gitgitgadget@gmail.com>
References: <pull.170.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 00/11] git add -i: add a rudimentary version in C (supporting only status and help 
 so far)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first leg on the long journey to a fully built-in git add -i 
(next up: parts 2 [https://github.com/gitgitgadget/git/pull/171], 3
[https://github.com/gitgitgadget/git/pull/172], 4
[https://github.com/gitgitgadget/git/pull/173], 5
[https://github.com/gitgitgadget/git/pull/174], and 6
[https://github.com/gitgitgadget/git/pull/175]). Note: the latter PRs are
not necessarily up to date, and will be re-targeted to the appropriate
branches in https://github.com/gitster/git as soon as Junio picks them up.

This here patch series reflects the part that was submitted a couple of
times (see https://github.com/gitgitgadget/git/pull/103) during the
Outreachy project by Slavica Ðukic that continued the journey based on an
initial patch series by Daniel Ferreira.

It only implements the status and the help part, in the interest of making
the review remotely more reviewable.

As I am a heavy user of git add -p myself and use a patched version for
weeks already (it is so nice to not suffer over one second startup until the
MSYS2 Perl finally shows me anything, instead it feels instantaneous), I
integrated these patch series into Git for Windows' master already, as an
opt-in feature guarded by the config variable add.interactive.useBuiltin 
(and Git for Windows' installer is prepared to detect this version and offer
the option in the graphical user interface).

I had planned on submitting this before v2.22.0-rc0, but there was such a
backlog of builds from a big pushout that I had to wait ;-)

Changes since v2:

 * Rebased to master to avoid merge conflicts.
 * Renumbered the prefix-map test to avoid conflicts with two patch series
   that are currently in-flight in pu.

Changes since v1:

 * The config machinery was reworked completely, to not use a callback to 
   git_config(), but instead to query the config via the repo_config_get_*() 
   functions. This also prevents a future "Huh???" moment: the internal add
   --interactive API accepts a parameter of type struct repository *r, but
   the previous configuration did not use that to query the config (and
   could in the future be a repository other than the_repository).
   
   
 * As a consequence, the color sequences are no longer stored in file-local
   variables, but passed around via a struct.
   
   
 * Instead of using the magical constant -2 to quit the main loop, it is now
   defined as LIST_AND_CHOOSE_QUIT (and likewise, LIST_AND_CHOOSE_ERROR is
   defined as -1 and used where appropriate).
   
   
 * Improved the add_prefix_item() function by avoiding buffer overruns, not
   reusing the struct that is used for lookup also for adding the new item,
   and by strengthening the bug check.

Daniel Ferreira (2):
  diff: export diffstat interface
  built-in add -i: implement the `status` command

Johannes Schindelin (6):
  Start to implement a built-in version of `git add --interactive`
  built-in add -i: refresh the index before running `status`
  built-in add -i: color the header in the `status` command
  built-in add -i: implement the main loop
  built-in add -i: support `?` (prompt help)
  built-in add -i: implement the `help` command

Slavica Djukic (3):
  Add a function to determine unique prefixes for a list of strings
  built-in add -i: show unique prefixes of the commands
  built-in add -i: use color in the main loop

 Documentation/config/add.txt |   5 +
 Makefile                     |   3 +
 add-interactive.c            | 558 +++++++++++++++++++++++++++++++++++
 add-interactive.h            |   8 +
 builtin/add.c                |  10 +
 diff.c                       |  37 +--
 diff.h                       |  19 ++
 prefix-map.c                 | 109 +++++++
 prefix-map.h                 |  40 +++
 repository.c                 |  19 ++
 repository.h                 |   7 +
 t/README                     |   4 +
 t/helper/test-prefix-map.c   |  58 ++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t0018-prefix-map.sh        |  10 +
 t/t3701-add-interactive.sh   |  25 ++
 17 files changed, 892 insertions(+), 22 deletions(-)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h
 create mode 100644 prefix-map.c
 create mode 100644 prefix-map.h
 create mode 100644 t/helper/test-prefix-map.c
 create mode 100755 t/t0018-prefix-map.sh


base-commit: 9d418600f4d10dcbbfb0b5fdbc71d509e03ba719
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-170%2Fdscho%2Fadd-i-in-c-status-and-help-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-170/dscho/add-i-in-c-status-and-help-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/170

Range-diff vs v2:

  1:  ed53346b92 !  1:  0a5ec9345d Start to implement a built-in version of `git add --interactive`
     @@ -47,7 +47,7 @@
       --- a/Makefile
       +++ b/Makefile
      @@
     - 	-name '*.h' -print)
     + 	-name '*.h' -print))
       
       LIB_OBJS += abspath.o
      +LIB_OBJS += add-interactive.o
     @@ -121,7 +121,7 @@
       --- a/t/README
       +++ b/t/README
      @@
     - builtin version of git-rebase. See 'rebase.useBuiltin' in
     + built-in version of git-stash. See 'stash.useBuiltin' in
       git-config(1).
       
      +GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when true, enables the
  2:  bc99009fbf =  2:  c7a377890d diff: export diffstat interface
  3:  5e23c0756b =  3:  b93b055ebe built-in add -i: implement the `status` command
  4:  8cafc6ae8d =  4:  daff24074a built-in add -i: refresh the index before running `status`
  5:  83d92a9762 =  5:  15f18f5b3e built-in add -i: color the header in the `status` command
  6:  3eec219124 =  6:  175409aaae built-in add -i: implement the main loop
  7:  e02a52c3ac !  7:  3000d7d08d Add a function to determine unique prefixes for a list of strings
     @@ -299,10 +299,10 @@
       int cmd__reach(int argc, const char **argv);
       int cmd__read_cache(int argc, const char **argv);
      
     - diff --git a/t/t0016-prefix-map.sh b/t/t0016-prefix-map.sh
     + diff --git a/t/t0018-prefix-map.sh b/t/t0018-prefix-map.sh
       new file mode 100755
       --- /dev/null
     - +++ b/t/t0016-prefix-map.sh
     + +++ b/t/t0018-prefix-map.sh
      @@
      +#!/bin/sh
      +
  8:  ced9b6aced =  8:  e23ddebfbf built-in add -i: show unique prefixes of the commands
  9:  7378af60ad =  9:  d8c012fce8 built-in add -i: support `?` (prompt help)
 10:  36edef85e6 = 10:  8121a3ca1b built-in add -i: use color in the main loop
 11:  266dbf2a6b ! 11:  db70c6475d built-in add -i: implement the `help` command
     @@ -61,9 +61,10 @@
       --- a/t/t3701-add-interactive.sh
       +++ b/t/t3701-add-interactive.sh
      @@
     - 	test_cmp expected-2 actual
     + 	test_write_lines a b a b a a b a b a >expect &&
     + 	test_cmp expect a
       '
     - 
     ++
      +test_expect_success 'show help from add--helper' '
      +	git reset --hard &&
      +	cat >expect <<-EOF &&

-- 
gitgitgadget
