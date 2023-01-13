Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE59AC54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 04:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbjAMEa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 23:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbjAME3N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 23:29:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AC443D80
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:28:07 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so247353wmc.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dyOyi9Gu77FiU4d/+HuT864tIe6eZrmfjxmKAF6lF4o=;
        b=nFK9FNT0huBaEB7QtMdHy9ZT0Aw1GgHFw0jH2LD36NRRvdUYi1iX2ZotI+lyMOZG1K
         xVIzyq5Psmla61EokGzjr7rN4W+7SLFCN5k/u9/1lkz20zwO7ndAT3V8GlGlaiIN6fd4
         wQ/Bet8kcb0ZXVZcl8gmJMKx/DnCt0AWhm5mTv18QNVzLnucNn7oSV1odB7EJNo8C2+j
         Pd8t8tK1K1cg6ESrIucODxzF5UG/nA67uz5AUtgrGgqgFdGDRQ89/YcKhYV8HK/5sZUx
         4/cqBXiNT2TIKzaHomyOd07qhS8PNKdqfhuS1CAdUqSFnqdiIq/wH21tecQgK6WH4Gw0
         GixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyOyi9Gu77FiU4d/+HuT864tIe6eZrmfjxmKAF6lF4o=;
        b=t0DTOQERto0Y48ndMQWLqzqtkJofBZ9AamDMa1qY5yc+oj75rYR177yuXl0Ja1/jz8
         qqRGPskoial5baaOsT5j/n0Ss68hObGrVgBy4X+RKWDTw0PGT31JVy+o0CE5T++hsLC+
         evTm3520RgirgtcehkMFwJioDx8yzoLs6jhNF9ODerEa0FyKN6snsCmPE6GuceSmvNDS
         Tt/bAncgkOuI4GVLKcFLXxfeOI+HFr3aBUv64Ua6kFAGbv9vIeXlil8f+pTX2tRHwVgI
         WvvKo8adi0YeWta3xeXHAXmexegaQKj4O+NFqlfk1/49+3Z4IcZnG5C9r7IXYMuVCmxd
         eJKg==
X-Gm-Message-State: AFqh2kqDXb1wLBxMKPHqOUqllwS5aYTaAhs5qEcGzU5i7KyIyRUcBXUf
        qQQl6TjQJmRQQhuFZmuk7nr8tUXCw9U=
X-Google-Smtp-Source: AMrXdXuncXaucN1lESpF5MWQQwqgaMGXYlNLqfL2iG45cA/g8EQKf/J6rGan67pLIkz2xRZzQeX+oA==
X-Received: by 2002:a05:600c:1d0e:b0:3cf:7c8b:a7c7 with SMTP id l14-20020a05600c1d0e00b003cf7c8ba7c7mr56925264wms.39.1673584085926;
        Thu, 12 Jan 2023 20:28:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003c6f8d30e40sm31958886wms.31.2023.01.12.20.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:28:05 -0800 (PST)
Message-Id: <pull.1462.git.1673584084761.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jan 2023 04:28:04 +0000
Subject: [PATCH] t6426: fix TODO about making test more comprehensive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrei Rybak <rybak.a.v@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

t6426.7 (a rename/add testcase) long had a TODO/FIXME comment about
how the test could be improved (with some commented out sample code
that had a few small errors), but those improvements were blocked on
other changes still in progress.  The necessary changes were put in
place years ago but the comment was forgotten.  Remove and fix the
commented out code section and finally remove the big TODO/FIXME
comment.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    t6426: fix TODO about making test more comprehensive
    
    See
    https://lore.kernel.org/git/CABPp-BFxK7SGs3wsOfozSw_Uvr-ynr+x8ciPV2Rmfx6Nr4si6g@mail.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1462%2Fnewren%2Ft6426-fix-todo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1462/newren/t6426-fix-todo-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1462

 t/t6426-merge-skip-unneeded-updates.sh | 56 ++++++++++----------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-unneeded-updates.sh
index 2bb8e7f09bb..1fcf5d034ed 100755
--- a/t/t6426-merge-skip-unneeded-updates.sh
+++ b/t/t6426-merge-skip-unneeded-updates.sh
@@ -380,40 +380,28 @@ test_expect_success '2c: Modify b & add c VS rename b->c' '
 
 		# Make sure c WAS updated
 		test-tool chmtime --get c >new-mtime &&
-		test $(cat old-mtime) -lt $(cat new-mtime)
-
-		# FIXME: rename/add conflicts are horribly broken right now;
-		# when I get back to my patch series fixing it and
-		# rename/rename(2to1) conflicts to bring them in line with
-		# how add/add conflicts behave, then checks like the below
-		# could be added.  But that patch series is waiting until
-		# the rename-directory-detection series lands, which this
-		# is part of.  And in the mean time, I do not want to further
-		# enforce broken behavior.  So for now, the main test is the
-		# one above that err is an empty file.
-
-		#git ls-files -s >index_files &&
-		#test_line_count = 2 index_files &&
-
-		#git rev-parse >actual :2:c :3:c &&
-		#git rev-parse >expect A:b  A:c  &&
-		#test_cmp expect actual &&
-
-		#git cat-file -p A:b >>merged &&
-		#git cat-file -p A:c >>merge-me &&
-		#>empty &&
-		#test_must_fail git merge-file \
-		#	-L "Temporary merge branch 1" \
-		#	-L "" \
-		#	-L "Temporary merge branch 2" \
-		#	merged empty merge-me &&
-		#sed -e "s/^\([<=>]\)/\1\1\1/" merged >merged-internal &&
-
-		#git hash-object c               >actual &&
-		#git hash-object merged-internal >expect &&
-		#test_cmp expect actual &&
-
-		#test_path_is_missing b
+		test $(cat old-mtime) -lt $(cat new-mtime) &&
+
+		git ls-files -s >index_files &&
+		test_line_count = 2 index_files &&
+
+		git rev-parse >actual :2:c :3:c &&
+		git rev-parse >expect A:c  A:b  &&
+		test_cmp expect actual &&
+
+		git cat-file -p A:b >>merge-me &&
+		git cat-file -p A:c >>merged &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "B^0" \
+			merged empty merge-me &&
+		sed -e "s/^\([<=>]\)/\1\1\1/" merged >merged-internal &&
+
+		test_cmp merged c &&
+
+		test_path_is_missing b
 	)
 '
 

base-commit: 2b4f5a4e4bb102ac8d967cea653ed753b608193c
-- 
gitgitgadget
