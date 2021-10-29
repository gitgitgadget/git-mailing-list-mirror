Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6637DC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 19:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408B660FE3
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 19:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ2TzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 15:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhJ2TzP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 15:55:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0053AC061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 12:52:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o14so18121971wra.12
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2qtxGzcD4aPpDe6e6PmhHSVNEQp1Qq5BGzQMnvompbw=;
        b=cDR5pGII9rSeoKjlfs/Iua5z5llqvwidEqOSpAo750blpC8pfkmr8Haa6+yrPr+e0m
         9jNVdTihjhRY1CVcG1ueQuKnwd4YGL6GbkjiRpotn6AdwpgtAjzYhHbkRd0xOcuOOMj3
         wDZ84/Jz1aaO/TCA5uN6fBj+gxPuV6UmxeFjMSofp9ADdaYAPwcrW1XDxufiQZYDUTFG
         6ZEQzHztg4wlzSV+LDLqLlTHHx2MCeTdqy9qEt/IBrzOqdNKHxJAE3VHVAusSmAnPrnH
         HurKFKsQ/d3y2c6jSLhj/g5msgGMSSszueMCrrLCFcTW7TxMfDb64YeBOhvMrG7JKGzk
         V99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2qtxGzcD4aPpDe6e6PmhHSVNEQp1Qq5BGzQMnvompbw=;
        b=Mk6oEKBrozR+I1gnNb0jbWr1otVLjH5gDISYvVWIFPQQhte6tvkkJW7tDXIr225t1n
         r+UlED5pxFe31+TqQLlPa6JhdHaaLREu5QWZobCHUsidiMCSJjb76geFNkiDJdbMou9i
         9/7yzDGNxEgQWJpevrV67J987HmH0ioGADeoc6Sui8NSvRiWzd9sYxHyjTdvqhfuXqbe
         nLnWdwBxmDreCqq7iWJqgJEFq1ay1KOzJCTv/d9HPeqJmW4KzxIrbK/XaMqTSO+9UDjb
         cKUuPudHckkwZk/qyc1b2jmY/daO60ZrdDP8a9u+6/ovBMA/EQpZWUCeK+h9cIpXwoHx
         KrDg==
X-Gm-Message-State: AOAM531qiJxq1nRXLifB6Xdc7U+JwUwKfnLGHH6p8rnPi41viR5Dw1lM
        9FlqIyNazpLMJnCGy9GaiqCvN2DcEf0=
X-Google-Smtp-Source: ABdhPJwgZvZCmxAyIN0IJBNKYQMSQAUglUxEKF/D+KLYu2tN+cO8LIC9LURBIlEvQSKZA67gi7ra1Q==
X-Received: by 2002:adf:aac5:: with SMTP id i5mr5236576wrc.67.1635537164613;
        Fri, 29 Oct 2021 12:52:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18sm4856645wmg.22.2021.10.29.12.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 12:52:44 -0700 (PDT)
Message-Id: <pull.1063.v3.git.1635537163.gitgitgadget@gmail.com>
In-Reply-To: <pull.1063.v2.git.1635530296.gitgitgadget@gmail.com>
References: <pull.1063.v2.git.1635530296.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 19:52:41 +0000
Subject: [PATCH v3 0/2] fix up example code in MyFirstObjectWalk tutorial
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MyFirstObjectWalk tutorial was missing directives to add some header files.
Also fixes some initialization code.

Changes since v1:

 * added back ticks to header file names
 * wrapped overly long lines

Changes since v2:

 * fixed commit organization

John Cai (2):
  docs: fix places that break compilation in MyFirstObjectWalk
  docs: add headers in MyFirstObjectWalk

 Documentation/MyFirstObjectWalk.txt | 31 ++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)


base-commit: e9e5ba39a78c8f5057262d49e261b42a8660d5b9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1063%2Fjohn-cai%2Fjc-fix-my-first-object-walk-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1063/john-cai/jc-fix-my-first-object-walk-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1063

Range-diff vs v2:

 1:  5c9deaf0bcc ! 1:  f9481c77e2d docs: fix places that break compilation in MyFirstObjectWalk
     @@ Commit message
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## Documentation/MyFirstObjectWalk.txt ##
     -@@ Documentation/MyFirstObjectWalk.txt: running, enable trace output by setting the environment variable `GIT_TRACE`.
     - 
     - Add usage text and `-h` handling, like all subcommands should consistently do
     - (our test suite will notice and complain if you fail to do so).
     -+We'll need to include the `parse-options.h` header.
     - 
     - ----
     - int cmd_walken(int argc, const char **argv, const char *prefix)
      @@ Documentation/MyFirstObjectWalk.txt: int cmd_walken(int argc, const char **argv, const char *prefix)
       	const char * const walken_usage[] = {
       		N_("git walken"),
     @@ Documentation/MyFirstObjectWalk.txt: int cmd_walken(int argc, const char **argv,
       	struct option options[] = {
       		OPT_END()
       	};
     -@@ Documentation/MyFirstObjectWalk.txt: Similarly to the default values, we don't have anything to do here yet
     - ourselves; however, we should call `git_default_config()` if we aren't calling
     - any other existing config callbacks.
     - 
     --Add a new function to `builtin/walken.c`:
     -+Add a new function to `builtin/walken.c`.
     -+We'll also need to include the `config.h` header:
     - 
     - ----
     - static int git_walken_config(const char *var, const char *value, void *cb)
     -@@ Documentation/MyFirstObjectWalk.txt: typically done by calling `repo_init_revisions()` with the repository you intend
     - to target, as well as the `prefix` argument of `cmd_walken` and your `rev_info`
     - struct.
     - 
     --Add the `struct rev_info` and the `repo_init_revisions()` call:
     -+Add the `struct rev_info` and the `repo_init_revisions()` call.
     -+We'll also need to include the `revision.h` header:
     -+
     - ----
     - int cmd_walken(int argc, const char **argv, const char *prefix)
     - {
     -@@ Documentation/MyFirstObjectWalk.txt: static void walken_object_walk(struct rev_info *rev)
     - ----
     - 
     - Let's start by calling just the unfiltered walk and reporting our counts.
     --Complete your implementation of `walken_object_walk()`:
     -+Complete your implementation of `walken_object_walk()`.
     -+We'll also need to include the `list-objects.h` header.
     - 
     - ----
     - 	traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
      @@ Documentation/MyFirstObjectWalk.txt: First, we'll need to `#include "list-objects-filter-options.h"` and set up the
       ----
       static void walken_object_walk(struct rev_info *rev)
 2:  7268f00c11f ! 2:  1535671dd6a docs: add headers in MyFirstObjectWalk
     @@ Commit message
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## Documentation/MyFirstObjectWalk.txt ##
     -@@ Documentation/MyFirstObjectWalk.txt: Add usage text and `-h` handling, like all subcommands should consistently do
     - We'll need to include the `parse-options.h` header.
     +@@ Documentation/MyFirstObjectWalk.txt: running, enable trace output by setting the environment variable `GIT_TRACE`.
     + 
     + Add usage text and `-h` handling, like all subcommands should consistently do
     + (our test suite will notice and complain if you fail to do so).
     ++We'll need to include the `parse-options.h` header.
       
       ----
      +#include "parse-options.h"
     @@ Documentation/MyFirstObjectWalk.txt: Add usage text and `-h` handling, like all
       int cmd_walken(int argc, const char **argv, const char *prefix)
       {
       	const char * const walken_usage[] = {
     -@@ Documentation/MyFirstObjectWalk.txt: Add a new function to `builtin/walken.c`.
     - We'll also need to include the `config.h` header:
     +@@ Documentation/MyFirstObjectWalk.txt: Similarly to the default values, we don't have anything to do here yet
     + ourselves; however, we should call `git_default_config()` if we aren't calling
     + any other existing config callbacks.
     + 
     +-Add a new function to `builtin/walken.c`:
     ++Add a new function to `builtin/walken.c`.
     ++We'll also need to include the `config.h` header:
       
       ----
      +#include "config.h"
     @@ Documentation/MyFirstObjectWalk.txt: Add a new function to `builtin/walken.c`.
       static int git_walken_config(const char *var, const char *value, void *cb)
       {
       	/*
     -@@ Documentation/MyFirstObjectWalk.txt: Add the `struct rev_info` and the `repo_init_revisions()` call.
     - We'll also need to include the `revision.h` header:
     +@@ Documentation/MyFirstObjectWalk.txt: typically done by calling `repo_init_revisions()` with the repository you intend
     + to target, as well as the `prefix` argument of `cmd_walken` and your `rev_info`
     + struct.
       
     +-Add the `struct rev_info` and the `repo_init_revisions()` call:
     ++Add the `struct rev_info` and the `repo_init_revisions()` call.
     ++We'll also need to include the `revision.h` header:
     ++
       ----
      +#include "revision.h"
      +
     @@ Documentation/MyFirstObjectWalk.txt: Add the `struct rev_info` and the `repo_ini
       int cmd_walken(int argc, const char **argv, const char *prefix)
       {
       	/* This can go wherever you like in your declarations.*/
     -@@ Documentation/MyFirstObjectWalk.txt: Complete your implementation of `walken_object_walk()`.
     - We'll also need to include the `list-objects.h` header.
     +@@ Documentation/MyFirstObjectWalk.txt: static void walken_object_walk(struct rev_info *rev)
     + ----
     + 
     + Let's start by calling just the unfiltered walk and reporting our counts.
     +-Complete your implementation of `walken_object_walk()`:
     ++Complete your implementation of `walken_object_walk()`.
     ++We'll also need to include the `list-objects.h` header.
       
       ----
      +#include "list-objects.h"

-- 
gitgitgadget
