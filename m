Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11921C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiKGShp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiKGShF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:37:05 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B227FF7
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:29 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p16so7428387wmc.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hmF6hnASy8Y3vGNvwDfIvoW1XYePf4jAtVdIcEfgOU=;
        b=p9f+Pmw7P0a/rl0cfkThUq0KYqU5fEqMzDi7T4ymnG98fuVMTlphq6fy/DluYqrqUz
         lqdVSRucvKRrAZRvZwWb0ztQv4FRcsOoBLPb2NwrKlvMtYWBXWMuIbw9Nph0TNY6Lbj2
         Uut01J84OGsHjeE1nguUTEWAOA+qsvPCdA0fswr7vQVbFxKdG64QVkHCK3I3HSMuySL2
         prR2eCl0Oh4cysyTnblc29eq5oxmBUBVoYqO3Xs/8tnjPCiOOV2zr026EaON7bfxU5L7
         sTqSk4B5CuX1LGyq+NjZY476On6Uztjj2yAvt6ZdUW9FngQvwub4eW+cBGR1yaF6kGiS
         W/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hmF6hnASy8Y3vGNvwDfIvoW1XYePf4jAtVdIcEfgOU=;
        b=xrEJbL0L2dBEc95TVxJUWw0rq7gpnjI2MHHHR6xQZFYt82/4yqY/bX99yyfOfcJ3SW
         7JaX/7Noe24AaKoyg/JIwzD2mhUdYqIxbRcx3y74v/wdYUIvqWg23Kptldg80eyETZjj
         iDhFOelioqjU36GyeiC7STVZHUxpGgGViW7AF23lNM10IShfB3BMlsVgtdNwSShjEzaw
         FCPJtXTgI3d+Z+dAgD7hmryqWSd0HXttDDUnyNKBwy+ijh114yBI6cxWBtABqEKWL8QS
         p5Zyfb1NPd3JzvoYUEG3IYnWgV/QlbGTn8rLQEg5j/eBAKnUB4kVIZWXcsL1IEi5nW0k
         J7Og==
X-Gm-Message-State: ACrzQf00gkW6HUq7HfBSD71aHVXc64ohGuVdSD3xTjjAWn2nDJDso872
        ZH1Xdt/6PWPZDYT7WBs3VXGQ/xktXKM=
X-Google-Smtp-Source: AMsMyM6BzCpfR+t7sI3ROJlSSOY6di44hHeQ3UOhgCanx9T9GJc9KmZS5d0AUxFIsP03d+u2Rpppww==
X-Received: by 2002:a1c:a107:0:b0:3cf:a25f:eef2 with SMTP id k7-20020a1ca107000000b003cfa25feef2mr8459445wme.195.1667846188534;
        Mon, 07 Nov 2022 10:36:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c354200b003c71358a42dsm16405875wmq.18.2022.11.07.10.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:28 -0800 (PST)
Message-Id: <6fe60ef2f53e680b047581eefc629144048b2224.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:56 +0000
Subject: [PATCH 22/30] packed-backend: create GIT_TEST_PACKED_REFS_VERSION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When set, this will create a default value for the packed-refs file
version on writes. When set to "2", it will automatically add the
"packed-v2" value to extensions.refFormat.

Not all tests pass with GIT_TEST_PACKED_REFS_VERSION=2 because they care
specifically about the content of the packed-refs file. These tests will
be updated in following changes.

To start, though, disable the GIT_TEST_PACKED_REFS_VERSION environment
variable in t3212-ref-formats.sh, since that script already tests both
versions, including upgrade scenarios.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 refs/packed-backend.c  | 3 ++-
 setup.c                | 5 ++++-
 t/t3212-ref-formats.sh | 3 +++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index ae904de9014..e84f669c42e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -807,7 +807,8 @@ static int write_with_updates(struct packed_ref_store *refs,
 	}
 	strbuf_release(&sb);
 
-	if (git_config_get_int("refs.packedrefsversion", &version)) {
+	if (!(version = git_env_ulong("GIT_TEST_PACKED_REFS_VERSION", 0)) &&
+	    git_config_get_int("refs.packedrefsversion", &version)) {
 		/*
 		 * Set the default depending on the current extension
 		 * list. Default to version 1 if available, but allow a
diff --git a/setup.c b/setup.c
index 72bfa289ade..a4525732fe9 100644
--- a/setup.c
+++ b/setup.c
@@ -732,8 +732,11 @@ int read_repository_format(struct repository_format *format, const char *path)
 		clear_repository_format(format);
 
 	/* Set default ref_format if no extensions.refFormat exists. */
-	if (!format->ref_format_count)
+	if (!format->ref_format_count) {
 		format->ref_format = REF_FORMAT_FILES | REF_FORMAT_PACKED;
+		if (git_env_ulong("GIT_TEST_PACKED_REFS_VERSION", 0) == 2)
+			format->ref_format |= REF_FORMAT_PACKED_V2;
+	}
 
 	return format->version;
 }
diff --git a/t/t3212-ref-formats.sh b/t/t3212-ref-formats.sh
index 571ba518ef1..5583f16db41 100755
--- a/t/t3212-ref-formats.sh
+++ b/t/t3212-ref-formats.sh
@@ -2,6 +2,9 @@
 
 test_description='test across ref formats'
 
+GIT_TEST_PACKED_REFS_VERSION=0
+export GIT_TEST_PACKED_REFS_VERSION
+
 . ./test-lib.sh
 
 test_expect_success 'extensions.refFormat requires core.repositoryFormatVersion=1' '
-- 
gitgitgadget

