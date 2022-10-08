Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C082BC433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 16:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJHQVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 12:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHQVl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 12:21:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BA426545
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 09:21:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a10so11246974wrm.12
        for <git@vger.kernel.org>; Sat, 08 Oct 2022 09:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pAGqhzFfM99zXS1E6hr/wOQJhiVjZXGMAC++Oq9mGE=;
        b=DpaddbP1F1FG/GMBN3ceUzvgsEwvh8LUIy8/afi0D1SwX5wrel7kXGKPPU06sFKhrn
         SXuo08uzn4/HqoSliGl54c94mBGIfivfHO0EOYfLVtX6iYBSOutEKJoWxslLnozNBou1
         Kg8eyq342mqYVpXGD5+C8vt5G9101/xwnOh1nCR3tFSuU0TF9AQzmztwcmncWsPuLtob
         WRK/dGZ4LB1sRaDl26OX8xhLdJEumaDyXnn8yf9QPsbdfe2p5LlsJIQlXaSdgfC+JMkP
         M3l4OxUNkNtZ9tg8iYvJDTjGwmfJd1WfJ4R3DpFFo2vgf2KeyIAlGVqSL/lTiCPanwSt
         Pm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pAGqhzFfM99zXS1E6hr/wOQJhiVjZXGMAC++Oq9mGE=;
        b=crhn8sVFZ74X0sXQ/wLf8wW+Kppso3cpoQVu7O7LQm78qCCO6R80z5yg/a/a1MN95Y
         TbCXdvqjJ9b3ScOP9zf0RZ3c9eGZarNrVqs2L0565A1syamHXAGG/u36Z5oWdB2aSD0L
         VgPREOYgojHKDbam8RCHSgpEJ6Prvepui6NM8G2Ni726tj2FAMbtl67MAew9cma5H4xX
         H807pse4LDD0ZK/SUh1Ky8F0/v04Yc903YNozfvxoDtlTbGABhPVdgCCKWwmXUyB2GFs
         pptBGctZRPqH195slYjryBSjKAC7S6IvA6beMd1lzLcOlCc8OgbbHbk11BLaGzzlCXEK
         MemQ==
X-Gm-Message-State: ACrzQf3aCdDTzhBLQGD8T314wHZcCTz13ISxnJ7bgGMDigr8fveRBOhc
        EAmiLZN1f0J68b2V/YNvOqaVMoz5j6k=
X-Google-Smtp-Source: AMsMyM7o1rkNN3v0CqOrsQhUSQgcABl3TEw1foxJ+cEndGMk8Km4G8cTYSVnb+BLi0uKe4VEfoRVgA==
X-Received: by 2002:a05:6000:1882:b0:22a:f7a2:736a with SMTP id a2-20020a056000188200b0022af7a2736amr6584686wri.691.1665246098966;
        Sat, 08 Oct 2022 09:21:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4-20020a05600c1c0400b003c5490ed8a6sm796735wms.8.2022.10.08.09.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 09:21:38 -0700 (PDT)
Message-Id: <pull.1355.v3.git.git.1665246097190.gitgitgadget@gmail.com>
In-Reply-To: <pull.1355.v2.git.git.1665153486.gitgitgadget@gmail.com>
References: <pull.1355.v2.git.git.1665153486.gitgitgadget@gmail.com>
From:   "Daniel Sonbolian via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Oct 2022 16:21:37 +0000
Subject: [PATCH v3] git.c: improve code readability in cmd_main
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Daniel Sonbolian <dsal3389@gmail.com>,
        Daniel Sonbolian <dsal3389@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Sonbolian <dsal3389@gmail.com>

Checking for an error condition whose body unconditionally exists first,
and then the special casing of "version" and "help" as part of the
preparation for the "normal codepath", making the code simpler to read.

Signed-off-by: Daniel Sonbolian <dsal3389@gmail.com>
---
    git.c: improve readability in cmd_main
    
    made the code more readable in cmd_main by moving the spacial casing for
    "version" and "help" as part of the regular code path

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1355%2Fdsal3389%2Frm-useless-else-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1355/dsal3389/rm-useless-else-v3
Pull-Request: https://github.com/git/git/pull/1355

Range-diff vs v2:

 1:  dd81a2cadec < -:  ----------- git-p4: minor optimization in read_pip_lines
 2:  7fe59688018 ! 1:  664974f71d4 git.c: improve code readability in cmd_main
     @@ Metadata
       ## Commit message ##
          git.c: improve code readability in cmd_main
      
     -    checking for an error condition whose body unconditionally exists first,
     +    Checking for an error condition whose body unconditionally exists first,
          and then the special casing of "version" and "help" as part of the
     -    preparation for the "normal codepath", making the code simpler to read
     +    preparation for the "normal codepath", making the code simpler to read.
      
          Signed-off-by: Daniel Sonbolian <dsal3389@gmail.com>
      
     @@ git.c: int cmd_main(int argc, const char **argv)
      -			argv[0] = "help";
      -	} else {
      +
     -+	if (argc <= 0) {
     ++	if (!argc) {
       		/* The user didn't specify a command; give them help */
       		commit_pager_choice();
       		printf(_("usage: %s\n\n"), git_usage_string);


 git.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index da411c53822..ee7758dcb0e 100644
--- a/git.c
+++ b/git.c
@@ -894,12 +894,8 @@ int cmd_main(int argc, const char **argv)
 	argv++;
 	argc--;
 	handle_options(&argv, &argc, NULL);
-	if (argc > 0) {
-		if (!strcmp("--version", argv[0]) || !strcmp("-v", argv[0]))
-			argv[0] = "version";
-		else if (!strcmp("--help", argv[0]) || !strcmp("-h", argv[0]))
-			argv[0] = "help";
-	} else {
+
+	if (!argc) {
 		/* The user didn't specify a command; give them help */
 		commit_pager_choice();
 		printf(_("usage: %s\n\n"), git_usage_string);
@@ -907,6 +903,12 @@ int cmd_main(int argc, const char **argv)
 		printf("\n%s\n", _(git_more_info_string));
 		exit(1);
 	}
+
+	if (!strcmp("--version", argv[0]) || !strcmp("-v", argv[0]))
+		argv[0] = "version";
+	else if (!strcmp("--help", argv[0]) || !strcmp("-h", argv[0]))
+		argv[0] = "help";
+
 	cmd = argv[0];
 
 	/*

base-commit: bcd6bc478adc4951d57ec597c44b12ee74bc88fb
-- 
gitgitgadget
