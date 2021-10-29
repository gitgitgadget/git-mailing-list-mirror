Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB1DC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 17:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6AD60FC1
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 17:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhJ2SAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhJ2SAs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:00:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179CFC061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 10:58:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d5so2278562wrc.1
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yW6K+YGQObCZe86VlwvnZU9jfUyTcVXmwz9phVNoqXk=;
        b=LPlSy+iyN0pcDSm75yswgw5poHOD4/E1cZT+rhgtURnyAL9flucpaC7OMgJmfyknXs
         Oh1HrW72zwk2qHlvwAWpWvSxNWKN4jDAq238qpOJKJUIikXqBAwUEbFJwnmIbU8qFjjI
         g0kOD4amhEq0xmDesq12jhqhz9owc91qvmtHwYgpVAqtrfkZJGFMXMI7bh2DiHTGDj2v
         e9YRFxCm9BfHYNT/YYKepY6C+j7CN7DLJ03WElsCPJuLTdGcex7FlLV+14jbSS0SWBae
         KscGqIH7GWpSU5NuhVlUkriOm83jNC3xm42LSqU8v7Fjp1LKKlgba6G1EYfaJVYPbmfL
         cc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yW6K+YGQObCZe86VlwvnZU9jfUyTcVXmwz9phVNoqXk=;
        b=1qBt/bnFZ+hzR6jIM8Q/RUjbdRvIDJwiGRIYITZnJPr7JL+cjLor7O3Ubb8gSV8h6C
         mpUrookrH75sl2c7hggsmOWOOJ+Hl69ZRAhDui9VIbtvKxbZAkFFLnP23p8osoFKOHc8
         CxWeOy75k+ZCAFrexk0icYwSbBDvb5BrKxrqHgptUlKly9Wr6FMfHDU2uERrU7j6FNYq
         5vQJwM1cUbHEEqgOC0ar4l9uAvowVWxxu4RgD37HzLoi3F+M+kQcOw76pVs8ZyG7AWTa
         pA2wB2GowrMBnwCcjnfWaC6GJJr6d0BImf6hoaZ/YRN19qHV8+mwNvUQHpTcT9lK5DvP
         I98g==
X-Gm-Message-State: AOAM532gasNp7pGQxzANXb2JEZgM4/cdqgfq6KLU1C9Hj0iWLYb1mqwW
        jqy7l1KVEAuPghypfg2vRM2Q4te2Whs=
X-Google-Smtp-Source: ABdhPJzrUdNtfXWjV0ll1brNLCAkDLKhKzCRT6o0T86nPE6vuWsO2Uep2smsPx3gszYIdWbOUYELZA==
X-Received: by 2002:a1c:2781:: with SMTP id n123mr21063559wmn.132.1635530297634;
        Fri, 29 Oct 2021 10:58:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm5603329wmj.20.2021.10.29.10.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 10:58:17 -0700 (PDT)
Message-Id: <pull.1063.v2.git.1635530296.gitgitgadget@gmail.com>
In-Reply-To: <pull.1063.git.1635343531.gitgitgadget@gmail.com>
References: <pull.1063.git.1635343531.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 17:58:14 +0000
Subject: [PATCH v2 0/2] fix up example code in MyFirstObjectWalk tutorial
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

John Cai (2):
  docs: fix places that break compilation in MyFirstObjectWalk
  docs: add headers in MyFirstObjectWalk

 Documentation/MyFirstObjectWalk.txt | 31 ++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)


base-commit: e9e5ba39a78c8f5057262d49e261b42a8660d5b9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1063%2Fjohn-cai%2Fjc-fix-my-first-object-walk-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1063/john-cai/jc-fix-my-first-object-walk-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1063

Range-diff vs v1:

 1:  6c95f11f110 ! 1:  5c9deaf0bcc docs: fix places that break compliation in MyFirstObjectWalk
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    docs: fix places that break compliation in MyFirstObjectWalk
     +    docs: fix places that break compilation in MyFirstObjectWalk
      
          Two errors in the example code caused compilation failures due to
     -    a missing semi-colon as well as initialization with an empty struct.
     +    a missing semicolon as well as initialization with an empty struct.
          This commit fixes that to make the MyFirstObjectWalk tutorial easier to
          follow.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## Documentation/MyFirstObjectWalk.txt ##
     +@@ Documentation/MyFirstObjectWalk.txt: running, enable trace output by setting the environment variable `GIT_TRACE`.
     + 
     + Add usage text and `-h` handling, like all subcommands should consistently do
     + (our test suite will notice and complain if you fail to do so).
     ++We'll need to include the `parse-options.h` header.
     + 
     + ----
     + int cmd_walken(int argc, const char **argv, const char *prefix)
      @@ Documentation/MyFirstObjectWalk.txt: int cmd_walken(int argc, const char **argv, const char *prefix)
       	const char * const walken_usage[] = {
       		N_("git walken"),
     @@ Documentation/MyFirstObjectWalk.txt: int cmd_walken(int argc, const char **argv,
       	struct option options[] = {
       		OPT_END()
       	};
     +@@ Documentation/MyFirstObjectWalk.txt: Similarly to the default values, we don't have anything to do here yet
     + ourselves; however, we should call `git_default_config()` if we aren't calling
     + any other existing config callbacks.
     + 
     +-Add a new function to `builtin/walken.c`:
     ++Add a new function to `builtin/walken.c`.
     ++We'll also need to include the `config.h` header:
     + 
     + ----
     + static int git_walken_config(const char *var, const char *value, void *cb)
     +@@ Documentation/MyFirstObjectWalk.txt: typically done by calling `repo_init_revisions()` with the repository you intend
     + to target, as well as the `prefix` argument of `cmd_walken` and your `rev_info`
     + struct.
     + 
     +-Add the `struct rev_info` and the `repo_init_revisions()` call:
     ++Add the `struct rev_info` and the `repo_init_revisions()` call.
     ++We'll also need to include the `revision.h` header:
     ++
     + ----
     + int cmd_walken(int argc, const char **argv, const char *prefix)
     + {
     +@@ Documentation/MyFirstObjectWalk.txt: static void walken_object_walk(struct rev_info *rev)
     + ----
     + 
     + Let's start by calling just the unfiltered walk and reporting our counts.
     +-Complete your implementation of `walken_object_walk()`:
     ++Complete your implementation of `walken_object_walk()`.
     ++We'll also need to include the `list-objects.h` header.
     + 
     + ----
     + 	traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
      @@ Documentation/MyFirstObjectWalk.txt: First, we'll need to `#include "list-objects-filter-options.h"` and set up the
       ----
       static void walken_object_walk(struct rev_info *rev)
 2:  33cd9b2e8a6 ! 2:  7268f00c11f docs: add headers in MyFirstObjectWalk
     @@ Commit message
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## Documentation/MyFirstObjectWalk.txt ##
     -@@ Documentation/MyFirstObjectWalk.txt: command). So we will send our debug output to `trace_printf()` instead. When
     - running, enable trace output by setting the environment variable `GIT_TRACE`.
     - 
     - Add usage text and `-h` handling, like all subcommands should consistently do
     --(our test suite will notice and complain if you fail to do so).
     -+(our test suite will notice and complain if you fail to do so). We'll need to include
     -+the "parse-options.h" header.
     +@@ Documentation/MyFirstObjectWalk.txt: Add usage text and `-h` handling, like all subcommands should consistently do
     + We'll need to include the `parse-options.h` header.
       
       ----
      +#include "parse-options.h"
     @@ Documentation/MyFirstObjectWalk.txt: command). So we will send our debug output
       int cmd_walken(int argc, const char **argv, const char *prefix)
       {
       	const char * const walken_usage[] = {
     -@@ Documentation/MyFirstObjectWalk.txt: Similarly to the default values, we don't have anything to do here yet
     - ourselves; however, we should call `git_default_config()` if we aren't calling
     - any other existing config callbacks.
     - 
     --Add a new function to `builtin/walken.c`:
     -+Add a new function to `builtin/walken.c`. We'll also need to include the "config.h" header:
     +@@ Documentation/MyFirstObjectWalk.txt: Add a new function to `builtin/walken.c`.
     + We'll also need to include the `config.h` header:
       
       ----
      +#include "config.h"
     @@ Documentation/MyFirstObjectWalk.txt: Similarly to the default values, we don't h
       static int git_walken_config(const char *var, const char *value, void *cb)
       {
       	/*
     -@@ Documentation/MyFirstObjectWalk.txt: typically done by calling `repo_init_revisions()` with the repository you intend
     - to target, as well as the `prefix` argument of `cmd_walken` and your `rev_info`
     - struct.
     +@@ Documentation/MyFirstObjectWalk.txt: Add the `struct rev_info` and the `repo_init_revisions()` call.
     + We'll also need to include the `revision.h` header:
       
     --Add the `struct rev_info` and the `repo_init_revisions()` call:
     -+Add the `struct rev_info` and the `repo_init_revisions()` call. We'll also need to include
     -+the "revision.h" header:
     -+
       ----
      +#include "revision.h"
      +
     @@ Documentation/MyFirstObjectWalk.txt: typically done by calling `repo_init_revisi
       int cmd_walken(int argc, const char **argv, const char *prefix)
       {
       	/* This can go wherever you like in your declarations.*/
     -@@ Documentation/MyFirstObjectWalk.txt: static void walken_object_walk(struct rev_info *rev)
     - ----
     - 
     - Let's start by calling just the unfiltered walk and reporting our counts.
     --Complete your implementation of `walken_object_walk()`:
     -+Complete your implementation of `walken_object_walk()`. We'll also need to
     -+include the "list-objects.h" header.
     +@@ Documentation/MyFirstObjectWalk.txt: Complete your implementation of `walken_object_walk()`.
     + We'll also need to include the `list-objects.h` header.
       
       ----
      +#include "list-objects.h"

-- 
gitgitgadget
