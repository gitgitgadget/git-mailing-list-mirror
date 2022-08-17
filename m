Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ACDC32772
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 06:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbiHQGd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238530AbiHQGdy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 02:33:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400245722C
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:33:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so1324569wmk.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=AYuywWNAHcQXkupiS7Llbsz+hOb5QF+T6kmpf2oK2wU=;
        b=fjUACtk4Ur+pqwHE6H7KMR+okij9IDCnCXxWZjHgCA+Bj3jMz22NZKC86kQbyaq5eJ
         CZ48tKiqG/zBajsnjaYCsXNFySikKFYTUKdFMK1uzAyIZUQNfPpD32VZIdYWSEI5wq0x
         9hLvekhM8bKlRwlzfOCDYDb0MsEco5V53Np/jlFFBgTiBhPXW8IZW78kF3MLzeaqUDQo
         SIOFdqJs1oO/PV1iIvwI3VJRM5fbzR9dNYPqlZR8kgS5XWrfKqe2RMN4aKVStbEAx6ur
         lUeJ/6ydyy7LMhtnE5ribVj7N54A7StkHoPN48P2kDCkhzveAOrklgikI4Y1RdDq4+1Y
         RlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=AYuywWNAHcQXkupiS7Llbsz+hOb5QF+T6kmpf2oK2wU=;
        b=ltnAANxN2j8KDHUGeJewpEUI0hBDanwxfHitiGXTLosLUY0n6nGkLbqKrhQBym01PJ
         mzYIUYtI4miglsauWO1weBlHFsbv/UPuaNlOAe+MQ1wnvvvNDfe3m+le5cDT/YmTdP3q
         PHnk6kvaQjYxztpfrosWcsWCcGApxgByIACtP53I7MADA9A4VR/67ebRMb/yDzF041q7
         cISdofZQ3XUFgCcGwMGjRAmNeV1kQpuCnhgcF5ioOHfmdX30kcpPI/W8g6TZ7WIQW37W
         XHVl0BsXqJtw3WzVIeDSjF/EAEut+cGrv6AD8PCOfOrrseh6jYn3axZQwUo5TlaeoKoK
         +GoA==
X-Gm-Message-State: ACgBeo0frG7rIYe1Wa0QYTS5Fd0PhlSOqvJKHS8/TyHWaCFbS7budagS
        psKZ8KCLydSTelAU4vENN0PuWWswEUc=
X-Google-Smtp-Source: AA6agR6B5XTG4sUG3XaB7JiszueCHRl4fbCBwMYiWdv74kpopv34Tcel6MgG2HmWQgiiueYSNZ7h7Q==
X-Received: by 2002:a05:600c:2256:b0:3a5:c27d:bfb2 with SMTP id a22-20020a05600c225600b003a5c27dbfb2mr1060996wmm.102.1660718031465;
        Tue, 16 Aug 2022 23:33:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c12c700b003a53e6c5425sm1063877wmd.8.2022.08.16.23.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 23:33:51 -0700 (PDT)
Message-Id: <340c0f46f74acd641945fceba5ab5feac011ae60.1660718028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>
References: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
        <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 06:33:47 +0000
Subject: [PATCH v2 2/3] merge-ort: add comment to avoid surprise with new
 sub_flag variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 4057523a40 ("submodule merge: update conflict error message",
2022-08-04) added a sub_flag variable that is used to store a value from
enum conflict_and_info_types, but initializes it with an invalid value
of -1.  The code may never set it to a valid value, and use the invalid
one.  This can be surprising when reading over the code at first, but it
was intentional.  Add a comment making it clear that it is okay to be
using an invalid value, due to how it is used later.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 67159fc6ef9..0a935a8135f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1886,7 +1886,7 @@ cleanup:
 		const char *abbrev;
 
 		util = xmalloc(sizeof(*util));
-		util->flag = sub_flag;
+		util->flag = sub_flag; /* May still be -1 */
 		util->abbrev = NULL;
 		if (!sub_not_initialized) {
 			abbrev = repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV);
-- 
gitgitgadget

