Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E8C31F597
	for <e@80x24.org>; Fri,  3 Aug 2018 22:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbeHDAWP (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 20:22:15 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:33213 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbeHDAWO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 20:22:14 -0400
Received: by mail-qk0-f202.google.com with SMTP id l11-v6so6721428qkk.0
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 15:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=9bQZPkaWbSriHjtKIa70XjyDuUrLe7iRdl4fCmcdDe8=;
        b=jxfG54WFCZ1ZqiIlwdl65XlrprGRsiZVbKPIfjJctrS+Zm91mdeM92z7HBckpN/2wS
         2UHc4BPag0NOeflksPXWU9kB4tvEVwhF63QPB/p3nQ6yeZUtkr3cAk5HebpiX1wz+omG
         HTwxSCkQ19EyxciJJbE7y8cJVClE+uqYADVrQ14f4E1J6CkTInVxlnArEhxvyWgzJqo8
         6FTlpa8IwmHQkqioy1PJmfpXzRrcefmipTmuGFscYFvXhXSFf1JrPQWA+4JvWivnAnEy
         smZ3aVZ6c+GPDY/VFq+zalsS6iPqTeOoTmDeCLd+HM+QKbrfgEFRpHM8mQFPq9cMR50Q
         V3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=9bQZPkaWbSriHjtKIa70XjyDuUrLe7iRdl4fCmcdDe8=;
        b=XOoUFE0qh745z7VG/3QAWFBeSk4nPBiwc21EWNjoMhr1ljELCQ3STIYNi9ksOw6A5d
         O37m/zFu2MN6+qPWUhkdzkN7s2sjirVZlln3uErLNl87Yc35I/8Mk30oWPASZQsKe5Mf
         8CdeuaXWbYYbHtqhIGxi+DhE93fXrRRkKChPO3ZFTP+EUDoipwrA1IXWr5o+ywebAmWX
         ruSIn3wScqWgN5bDtJrD2U9FG1qGruyS9190VRP8Dc9PzSMaCjaPKTQcB2I6l42cMvMY
         svvJOs4v4mKa1FkTKFPqWtEvL7WI6nzvF/zdh7w56GxAzO3WMQoi9w6z4Y0qhpyuXKAN
         dMNA==
X-Gm-Message-State: AOUpUlHjoYyCGcT/v5uYdSNaPWXs3XrWG0N3XLdVVnOe6j6Kwtzdvfxj
        1PGC4/X9OKFyQArJLLwYw47bOEO4Jd+k3s5nROOHl4sRZNDfIpXlpS12aPDe/E9X1diurOKW/ga
        bbC/kyz8G8cYBNRP91AP3dwO12jwcxzW6pou821lkwcY6RyyWv6hq4vwMuUdq
X-Google-Smtp-Source: AAOMgpc5Anm42CPP4rouyi9Vw7cBSyouBb0YlaZV8JHMHISjHjGVzd+pOUHMvcm+rm1IocsbuOV2wbcitkf1
MIME-Version: 1.0
X-Received: by 2002:a0c:9dc1:: with SMTP id p1-v6mr4651484qvf.27.1533335041271;
 Fri, 03 Aug 2018 15:24:01 -0700 (PDT)
Date:   Fri,  3 Aug 2018 15:23:15 -0700
Message-Id: <20180803222322.261813-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 0/7] Resend of sb/submodule-update-in-c
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Introduce new patch
  "submodule--helper: replace connect-gitdir-workingtree by ensure-core-worktree"
  that resolves the conflict with earlier versions of this series with
  sb/submodule-core-worktree
* This series is based on master, which already contains 
  sb/submodule-core-worktree
  
Thanks,
Stefan

Stefan Beller (7):
  git-submodule.sh: align error reporting for update mode to use path
  git-submodule.sh: rename unused variables
  builtin/submodule--helper: factor out submodule updating
  builtin/submodule--helper: store update_clone information in a struct
  builtin/submodule--helper: factor out method to update a single
    submodule
  submodule--helper: replace connect-gitdir-workingtree by
    ensure-core-worktree
  submodule--helper: introduce new update-module-mode helper

 builtin/submodule--helper.c | 216 ++++++++++++++++++++++++++----------
 git-submodule.sh            |  29 +----
 2 files changed, 164 insertions(+), 81 deletions(-)

  ./git-range-diff origin/sb/submodule-update-in-c...HEAD
      [...]
  -:  ----------- > 338:  1d89318c48d Fifth batch for 2.19 cycle
  1:  c1cb423b249 = 339:  3090cbcb46e git-submodule.sh: align error reporting for update mode to use path
  2:  f188b30a9b9 = 340:  850a16e9085 git-submodule.sh: rename unused variables
  3:  70d84fa6a09 ! 341:  88af0cdcba6 builtin/submodule--helper: factor out submodule updating
    @@ -73,10 +73,10 @@
      	};
      	suc.prefix = prefix;
      
    --	config_from_gitmodules(gitmodules_update_clone_config, &max_jobs);
    --	git_config(gitmodules_update_clone_config, &max_jobs);
    -+	config_from_gitmodules(gitmodules_update_clone_config, &suc.max_jobs);
    -+	git_config(gitmodules_update_clone_config, &suc.max_jobs);
    +-	update_clone_config_from_gitmodules(&max_jobs);
    +-	git_config(git_update_clone_config, &max_jobs);
    ++	update_clone_config_from_gitmodules(&suc.max_jobs);
    ++	git_config(git_update_clone_config, &suc.max_jobs);
      
      	argc = parse_options(argc, argv, prefix, module_update_clone_options,
      			     git_submodule_helper_usage, 0);
  4:  511e8a139c9 = 342:  2fdd479a6d5 builtin/submodule--helper: store update_clone information in a struct
  5:  65b2a720b90 = 343:  34589e724b3 builtin/submodule--helper: factor out method to update a single submodule
  -:  ----------- > 344:  ee2bb4f23d8 submodule--helper: replace connect-gitdir-workingtree by ensure-core-worktree
  6:  e5803d07f9b ! 345:  03300626ba7 submodule--helper: introduce new update-module-mode helper
    @@ -88,15 +88,15 @@
      	{"clone", module_clone, 0},
     +	{"update-module-mode", module_update_module_mode, 0},
      	{"update-clone", update_clone, 0},
    + 	{"ensure-core-worktree", ensure_core_worktree, 0},
      	{"relative-path", resolve_relative_path, 0},
    - 	{"resolve-relative-url", resolve_relative_url, 0},
     
     diff --git a/git-submodule.sh b/git-submodule.sh
     --- a/git-submodule.sh
     +++ b/git-submodule.sh
     @@
    - 	do
    - 		die_if_unmatched "$quickabort" "$sha1"
    + 
    + 		git submodule--helper ensure-core-worktree "$sm_path"
      
     -		name=$(git submodule--helper name "$sm_path") || exit
     -		if ! test -z "$update"
