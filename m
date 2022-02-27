Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6641FC433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 19:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiB0T6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 14:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiB0T5y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 14:57:54 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F80344DB
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 11:57:17 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id n14so12319530wrq.7
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 11:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hkVVepIKXC6Z+YdGZUVKyaIwVP4fPHJi0RCeD6PLltU=;
        b=X1+99fV0x5KHAy3a1owIVd2Jx4JAJbWeANCI6/HeKLeQWtmC94dXWKXno85gtCj8a1
         aL3sWmNOy25Z6VPGaz5gtRvuXoUkQgkr5ecklBZReAHZ9GGIT9vkgh+Bqs7uqHAGBhlr
         L5mVTLC8Sy5TQbG6IrbW/b5m+0QazgkpUQwAFlGliqSsmtrPlCy5QHPpEuKHzha48qaf
         HoYWaryDw7skUCnVXN+laOhM79TNxmPDTJSALNOEcG9Qcs2wgR0unQz12kOJvLozSPL1
         HpJ+f8UnD2lR1BA1kXZ9QDTwcNtkVMoDsGgG5fX1AAXr1SKLPKH07rubcyWYaMb1nWVE
         jEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hkVVepIKXC6Z+YdGZUVKyaIwVP4fPHJi0RCeD6PLltU=;
        b=BzbqePAq+HSD4AW3upvefMEmrfAi3Z4mBLYbuApPzOaHf0U2TUXYi0ndfLWWcttVFm
         jpR5itvjmpN5GamX7bCo7UD77bAgo+Ap3O1pnIvox4oU4un286JaFV6D1Bt/xEV37TYJ
         dK/yA9pRQGBSJnPOI7nUKCHiwfvwvvD+pCsqcO+NN2lUyyGfyy6AJ1mfilNWhXiepvGi
         oelGUfhTF9rtKG7z8VnEmskmZq9eEKygjnwIwZGSUxIic5tmiU4Pzu9Z2dU4RjDx8FTt
         4T7iR/THiWgP41pLUErUnk0kob3wjnImxBvrBpIWaG+YZRuvQn+KTFyo8URErQbf4usG
         QCTw==
X-Gm-Message-State: AOAM531AMqr113i/7pYgTDOczEkOGAViqqBCBYnlzOwJ8jYm3yPWaocl
        tFBkW/luE7ENwi34bluwcI8O+tpHMQI=
X-Google-Smtp-Source: ABdhPJzT47p2+Kz6ZdIsfWBlXz5AphClhakZzd2hdgbc7vXVHmxG3sqKS6kEWAzeizAGAb4PgR/WwQ==
X-Received: by 2002:adf:ea86:0:b0:1ef:9141:112c with SMTP id s6-20020adfea86000000b001ef9141112cmr4780608wrm.490.1645991835854;
        Sun, 27 Feb 2022 11:57:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b00380ead5bc65sm10952246wmq.29.2022.02.27.11.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 11:57:15 -0800 (PST)
Message-Id: <0af083413b81eb393373b6fe02c5dd4c04d90bdd.1645991832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1162.v2.git.1645991832.gitgitgadget@gmail.com>
References: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
        <pull.1162.v2.git.1645991832.gitgitgadget@gmail.com>
From:   "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Feb 2022 19:57:11 +0000
Subject: [PATCH v2 3/4] git-prompt: make long upstream state indicator
 consistent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Justin Donnelly <justinrdonnelly@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Justin Donnelly <justinrdonnelly@gmail.com>

Use a pipe as a separator before long upstream state indicator. This is
consistent with long state indicators for sparse and in-progress
operations (e.g. merge).

For comparison, `__git_ps1` examples without upstream state indicator:
(main)
(main %)
(main *%)
(main|SPARSE)
(main %|SPARSE)
(main *%|SPARSE)
(main|SPARSE|REBASE 1/2)
(main %|SPARSE|REBASE 1/2)

Note that if there are long state indicators, they appear after short
state indicators if there are any, or after the branch name if there are
no short state indicators. Each long state indicator begins with a pipe
(`|`) as a separator.

Before/after examples with long upstream state indicator:
| Before                          | After                           |
| ------------------------------- | ------------------------------- |
| (main u=)                       | (main|u=)                       |
| (main u= origin/main)           | (main|u= origin/main)           |
| (main u+1)                      | (main|u+1)                      |
| (main u+1 origin/main)          | (main|u+1 origin/main)          |
| (main % u=)                     | (main %|u=)                     |
| (main % u= origin/main)         | (main %|u= origin/main)         |
| (main % u+1)                    | (main %|u+1)                    |
| (main % u+1 origin/main)        | (main %|u+1 origin/main)        |
| (main|SPARSE u=)                | (main|SPARSE|u=)                |
| (main|SPARSE u= origin/main)    | (main|SPARSE|u= origin/main)    |
| (main|SPARSE u+1)               | (main|SPARSE|u+1)               |
| (main|SPARSE u+1 origin/main)   | (main|SPARSE|u+1 origin/main)   |
| (main %|SPARSE u=)              | (main %|SPARSE|u=)              |
| (main %|SPARSE u= origin/main)  | (main %|SPARSE|u= origin/main)  |
| (main %|SPARSE u+1)             | (main %|SPARSE|u+1)             |
| (main %|SPARSE u+1 origin/main) | (main %|SPARSE|u+1 origin/main) |

Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
---
 contrib/completion/git-prompt.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 613389a53bc..2772f990888 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -109,7 +109,7 @@
 __git_printf_supports_v=
 printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
 
-# stores the divergence from upstream in $p (for short status) or $upstream (for verbose status)
+# stores the divergence from upstream in $p
 # used by GIT_PS1_SHOWUPSTREAM
 __git_ps1_show_upstream ()
 {
@@ -219,13 +219,13 @@ __git_ps1_show_upstream ()
 		"") # no upstream
 			upstream="" ;;
 		"0	0") # equal to upstream
-			upstream=" u=" ;;
+			upstream="|u=" ;;
 		"0	"*) # ahead of upstream
-			upstream=" u+${count#0	}" ;;
+			upstream="|u+${count#0	}" ;;
 		*"	0") # behind upstream
-			upstream=" u-${count%	0}" ;;
+			upstream="|u-${count%	0}" ;;
 		*)	    # diverged from upstream
-			upstream=" u+${count#*	}-${count%	*}" ;;
+			upstream="|u+${count#*	}-${count%	*}" ;;
 		esac
 		if [[ -n "$count" && -n "$name" ]]; then
 			__git_ps1_upstream_name=$(git rev-parse \
-- 
gitgitgadget

