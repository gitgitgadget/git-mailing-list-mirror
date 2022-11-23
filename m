Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79ABC4167D
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 22:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKWWMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 17:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKWWLp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 17:11:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E785D12E206
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 14:11:31 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g12so31454363wrs.10
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 14:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZuYB3veB4LajEf/GxPb4W7X7h886I2+NXYjZxcWIP8=;
        b=Alrm2yDbExCjj3IJh93hGh1W5uWc5mFXd5Qo4XOKoCXU+Gki7lW8vQi7aMbrt907lC
         T9ANXOC7V+l9mAsTkHXCLNCFW09GGwhR+W+OJnZrHurKfbQaxYGjnesNJd4Ae3uwVU8w
         vz4us3iNl8p0Ttph+AeLt0TmfCQ1bI+yvNbbSu6aGubJGcT9lCRSYliwV8O4q2DFDn8P
         EC1qneqWig+IifqHSnw1lcQzYNPobNDpVbMJqNabvzErvE2ZmLUa+KGX2kS/KZozTiY6
         9dTZwcWX/aQJnCdapOzV+g/4T4imCCwM2hxvzwDNmhvpA131Ysy/a9AOcvKdPq5JdyoU
         dPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZuYB3veB4LajEf/GxPb4W7X7h886I2+NXYjZxcWIP8=;
        b=i89FWahoxwLc/Xzul2ts41ibFwFy2ierWBBS7TRZt2jE/pn+2neyQFVJSFnE98yehW
         V/+z7PddXFV1aa0i9qyXi0Yi/9i84y+2pDoo5YCK1wCOOGD+SZN0JCU9t8v1SQoG2+9I
         MxeGZ+v85fipTsWzmM+ePRmFf3ohqUlqa846Ay5+H9mRwPNU1rhti+mwO/fkoeHnGxmH
         P/uivUAzl6zOys9flSk257BrH5EHWTcsiso0ojjt1nMbjPTL4gFvXb2CEInABmYUgtY6
         N1B5oyPHSYiFGzeLT2TiPX8sIPuHpdfJy5Il+aRp95UVjYOW32KZrmEjZKBIUoBlaAEX
         my1A==
X-Gm-Message-State: ANoB5pmc05YIDkxKbX+0VZRuKoa5ytSJFK8uiOR79RwgSyZ3ZH5ow2t/
        SS+QiTU9oj4806VG3BIUCT4EfjPL638=
X-Google-Smtp-Source: AA0mqf63KdwgGKS80Nx78yhy6+kbPzjmVtCtX64/JTnlY21AuRTIffMo2ltD0jhPgVh75hcRKt1BvA==
X-Received: by 2002:a5d:4950:0:b0:236:aab2:4eb2 with SMTP id r16-20020a5d4950000000b00236aab24eb2mr18595175wrs.412.1669241490159;
        Wed, 23 Nov 2022 14:11:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c354100b003cf894c05e4sm3902357wmq.22.2022.11.23.14.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:11:29 -0800 (PST)
Message-Id: <pull.1386.git.git.1669241489179.gitgitgadget@gmail.com>
From:   "Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Nov 2022 22:11:29 +0000
Subject: [PATCH] revert: add angle bracket around argument 'parent-number' in
 usage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Fangyi Zhou <me@fangyi.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fangyi Zhou <me@fangyi.io>

8c9e292dc0 (doc txt & -h consistency: add missing options and labels,
2022-10-13) adds detailed usage line for revert and cherry-pick, which
both contain a flag `-m` for parent number.
Angle brackets shall be marked around parent-number, since it represents
an argument.

Signed-off-by: Fangyi Zhou <me@fangyi.io>
---
    revert: add angle bracket around argument 'parent-number' in usage
    
    8c9e292dc0 (doc txt & -h consistency: add missing options and labels,
    2022-10-13) adds detailed usage line for revert and cherry-pick, which
    both contain a flag -m for parent number. Angle brackets shall be marked
    around parent-number, since it represents an argument.
    
    Signed-off-by: Fangyi Zhou me@fangyi.io

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1386%2Ffangyi-zhou%2Frevert-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1386/fangyi-zhou/revert-fix-v1
Pull-Request: https://github.com/git/git/pull/1386

 Documentation/git-revert.txt | 2 +-
 builtin/revert.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 5016755efb6..d2e10d3dceb 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -8,7 +8,7 @@ git-revert - Revert some existing commits
 SYNOPSIS
 --------
 [verse]
-'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>...
+'git revert' [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] <commit>...
 'git revert' (--continue | --skip | --abort | --quit)
 
 DESCRIPTION
diff --git a/builtin/revert.c b/builtin/revert.c
index ee32c714a76..6a9b550a61f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -21,7 +21,7 @@
  */
 
 static const char * const revert_usage[] = {
-	N_("git revert [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>..."),
+	N_("git revert [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] <commit>..."),
 	N_("git revert (--continue | --skip | --abort | --quit)"),
 	NULL
 };

base-commit: c000d916380bb59db69c78546928eadd076b9c7d
-- 
gitgitgadget
