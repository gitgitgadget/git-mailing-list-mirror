Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A81BC25B0E
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 07:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbiHRHPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 03:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbiHRHPd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 03:15:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9FF883C3
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:15:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ba1so674045wrb.5
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=iB5hqtnXFh6I2+tUXupwGfQPDSsfwJKVvCFHqS1BbaE=;
        b=JmpZq9KMq6lHl7unICVOTBp2p2+yKZ02ncuznLXL0wJSy6wHL79t+3cFWN5jO8a4SQ
         Oz1NAnusQXfzfTqszUT1RAWPdrGnpHXxdVm+Ys+o2ndem6VuPGSphLeOKnlk0xokBl/G
         Zjhh6KUUD6lKs90tOeCX06sJ2j9b19ICXROX9qr/6QEG4jKtS7UpgMj7J3IeW3/j52LJ
         W0Lwxg/y/Oz/Peu7YvC+kJ1tO0aXYl/u/GJu2PWEl3XosH7q3lFLVTmhp7BpPn0QHZ6p
         IRy2akzoU0LnM0CgSxZ8VATP+Q4pTa/TbI9hltxaDmIjBWFKxEFeCefAHI7miHUk+Amq
         wu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=iB5hqtnXFh6I2+tUXupwGfQPDSsfwJKVvCFHqS1BbaE=;
        b=dP3BiEg3DaeQPuCq4tuGprPuM0rvlF9X6ev+GQ7xx6nEq2egMDL+bdIRWl7o8r8d3M
         lbK1iC7TBhuMmvxqJ86KPbacPytKJgQCNrZtVBbrQXW6JJIWZ+8J9RuvKrfsPRizb75w
         8LBg1rMhKKG01jayGiyKsM7v9PHXpD2tdh9wx3O1X4OdV1P7ULcj/sTkxA3w8JhtX+IK
         LZGGBsic5IKBknURx2OBgLeuFC0hsi8uN3bYwblru+OfaERClFiQYbhGYovEUr7+jDLN
         NehfERi9cbpDN6CK31yxEnRjSRZB+fRcNfLPH9SzYAlmhsyXeW73Gpokp3k/jv+vpKHc
         iwIA==
X-Gm-Message-State: ACgBeo23CGQMXefDXP9pvi9+K2kww7aZc6IR6lqem/rZ6T0EuobDtw3l
        5ZxHO9d/WXsXfPbPPoqGGlkT2KXRW1I=
X-Google-Smtp-Source: AA6agR5uNr1WUaZ6nfAIFUvieikoHB8k/KU79ccelFS9T/VGVR/YKDjA5cc9qwJJdqWTA/iUMS797w==
X-Received: by 2002:a5d:5c04:0:b0:220:6d80:60ce with SMTP id cc4-20020a5d5c04000000b002206d8060cemr787920wrb.499.1660806931305;
        Thu, 18 Aug 2022 00:15:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c350500b003a6125562e1sm1050917wmq.46.2022.08.18.00.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 00:15:30 -0700 (PDT)
Message-Id: <48200773a1bbe8467e37db637c99c85be2c809ec.1660806927.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1325.v3.git.1660806927.gitgitgadget@gmail.com>
References: <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>
        <pull.1325.v3.git.1660806927.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 07:15:26 +0000
Subject: [PATCH v3 2/3] merge-ort: avoid surprise with new sub_flag variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 4057523a40 ("submodule merge: update conflict error message",
2022-08-04) added a sub_flag variable that is used to store a value from
enum conflict_and_info_types, but initializes it with a value of -1 that
does not correspond to any of the conflict_and_info_types.  The code may
never set it to a valid value and yet still use it, which can be
surprising when reading over the code at first.  Initialize it instead
to the generic CONFLICT_SUBMODULE_FAILED_TO_MERGE value, which is still
distinct from the two values we need to special case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 67159fc6ef9..8f14f1ad0b2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1767,7 +1767,7 @@ static int merge_submodule(struct merge_options *opt,
 	int i;
 	int search = !opt->priv->call_depth;
 	int sub_not_initialized = 1;
-	int sub_flag = -1;
+	int sub_flag = CONFLICT_SUBMODULE_FAILED_TO_MERGE;
 
 	/* store fallback answer in result in case we fail */
 	oidcpy(result, opt->priv->call_depth ? o : a);
-- 
gitgitgadget

