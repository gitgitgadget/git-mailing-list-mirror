Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B651C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 19:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349448AbiDKTZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 15:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiDKTZu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 15:25:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C031098
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 12:23:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso143277wmz.4
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 12:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=iqFEbUOC1QAQh4i/+d7Qygz7K4fFSZuIOjDGW6Di40s=;
        b=G2VeCU1q8PTLf3lbIf7kcNdFJ7bnJ+/kubLyR11crf840kTJpeT759saRYkm1lQFGr
         iNBoKhngcn5hHmVyAXw8rGpiom7CwnGR78iMpxWeCClg/cg8rgE4bTjBTC5K/+/ho+7n
         y182RK4A4kuNngUZSTZ1JWFfO3jTuBkGv7MslLa9nxUFY45qmLZA9PGAdxjXpk0XhWTs
         PHsjuh9x2v05gggNBhTOBGvTuFtcGTvquAdbVfB//bBuFqEwOKhv7FG8sQGt/PIDVIxT
         3hg4eGsdkJ8In6VS3OLMOg/yxc+UTsppxd+t5XCh2tTnDhIN8/etmm+8hO8bZO2adIFR
         jdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=iqFEbUOC1QAQh4i/+d7Qygz7K4fFSZuIOjDGW6Di40s=;
        b=alMvD8b0TuiGvwn+gKZG+KUGbZhwBLddLBUmRAEbU6msvsdu0lgoBKH7l1mcZP2f7b
         8Z1UxbGx65vJtxXPA4+U15qhi5XAFL93oLNi2sEloh8Gg3Hs5h2tFFm6YSA3l1/doog6
         48YADAShW2YP/ITrP1zRN0s/+eda9Juw1nYG6fleKRsfvKqBLcdTOh7b46MR/Ai4ekCF
         aUbN5ObiWxoOY8QRhuSAyE+roWU8t2s0wjGEMZvkkTsmT9FgaJTpR2mPygPLGsIHvd36
         Mx7vbwLjSMhyLI/EocaRWadAOkl6zF5/ev77YWVprIxytj7Dm8g9kCS3ekObea/ifkvt
         eBkQ==
X-Gm-Message-State: AOAM531wohnC1Z9Pa/08Jb5a4KJquWrnLTip14rrrQZq1y5lKrj60i26
        /Q9sfLCNaal3LmLnBVWQ2UjO4XKLTZA=
X-Google-Smtp-Source: ABdhPJySL6GfPJv4OVSe4wZlU99g7KqDGhfALUS5518KPCmhHsUgfpMjLAfztqbUWrITEE/JNS6P6A==
X-Received: by 2002:a1c:4408:0:b0:38e:aa45:db99 with SMTP id r8-20020a1c4408000000b0038eaa45db99mr625096wma.176.1649705012691;
        Mon, 11 Apr 2022 12:23:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0038cb8b38f9fsm358417wmq.21.2022.04.11.12.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 12:23:32 -0700 (PDT)
Message-Id: <pull.1212.git.1649705011178.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 11 Apr 2022 19:23:30 +0000
Subject: [PATCH] i18n: fix some badly formatted i18n strings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

String in submodule--helper is not correctly formatting
placeholders. The string in git-send-email is partial.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
    V2.36 i18n fixes
    
    While translating the latest version of the messages, I encountered a
    few errors of formatting or management.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1212%2Fjnavila%2Fv2.36_i18n_fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1212/jnavila/v2.36_i18n_fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1212

 builtin/submodule--helper.c | 2 +-
 git-send-email.perl         | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0b8b226c8ff..2c87ef9364f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3082,7 +3082,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const usage[] = {
-		N_("git submodule--helper create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start_oid> <start_name>"),
+		N_("git submodule--helper create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"),
 		NULL
 	};
 
diff --git a/git-send-email.perl b/git-send-email.perl
index a98460bdb96..5861e99a6eb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -2096,10 +2096,9 @@ sub validate_patch {
 			chdir($cwd_save) or die("chdir: $!");
 		}
 		if ($hook_error) {
-			$hook_error = sprintf(__("fatal: %s: rejected by %s hook\n" .
-						 $hook_error . "\n" .
-						 "warning: no patches were sent\n"),
-					      $fn, $hook_name);
+			$hook_error = sprintf(
+			    __("fatal: %s: rejected by %s hook\n%s\nwarning: no patches were sent\n"),
+			    $fn, $hook_name, $hook_error);
 			die $hook_error;
 		}
 	}

base-commit: ab1f2765f78e75ee51dface57e1071b3b7f42b09
-- 
gitgitgadget
