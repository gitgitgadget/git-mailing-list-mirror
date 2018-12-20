Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285381F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389500AbeLTTpS (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38162 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389495AbeLTTpP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so2979656wrw.5
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zIpjZfHhkkC3bAiUe4fvBhidMZv/DInGoWy6dimZZ94=;
        b=XCZsWNd8WORA9YYK8yuNmB7pPXlbW8WHgG0E1BpxtrLUo6MLyTlyFM56R0l+rFZia+
         C6jbX8NNdW3Yjez+7kWpfg7IFFf1Oz3RPXj0KXga9v2jPdY0sA1XLAlIZsAkhbqIsPrp
         lBvNk17ImXcxya9FAOr1ZmPjBoVgkEGP1rZqmPm7jXQl3wwsJn6tVf1iyjoWXRf4hoyb
         X9A6eJWJBmNuoym818FACrlsRGbynxD+fSFSwD+hvJHCGvzCiFfF1BtL9TuyvI8fvNDD
         jq1JR6kabZSX41Zq0d9EjD4OGIlqti5pDn9SQ8auOYxhd5ve1/lDLiICRDedf7GTTzYJ
         +FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zIpjZfHhkkC3bAiUe4fvBhidMZv/DInGoWy6dimZZ94=;
        b=q6IAx62SGCZ/Ien+SPXOgj86kUSBrVYYCg/LnRtgv4omnrMDg4zjI+9jV2bfaK/3EH
         iHImRfge1d/2CI+ta+CV0L3rbqQvjcGijNVVrWkxCvBPC+lYaqbymWWBBDFD/1yuBaEf
         zJmlvfayxTc7XvvS3L0wigIov3HWHGDOq5xvrxvxeSkStQ9blX2lT5NsNhz1s4JI99OM
         nP2O3/7bPXm9HpRMcD7nDDDZm5sAzJizljA7x/ICyZqY2IXErRkGZuiK5rwMy9SnIQ4t
         T9yTMLB+6oRq/E+Cd7sejokYlIow0R1AA9c/8Cbs+/O2ln+HyhBA1bnoF35v3orvAk2T
         BaIQ==
X-Gm-Message-State: AA+aEWazPhsop1nz0zV1erPuBEyrNIMNCsgYIlnBAyoq5vtq77zGe5zA
        +VpLUVyL19jwrpUGs89HFuWN/3pRI4A=
X-Google-Smtp-Source: AFSGD/VsXm7BNTBfxPNSa9Y5zgAaJ369GhljXzSmXao+K/T3fO0qTojXzqgZdCUXIIaEwYudeMrIZw==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr23087653wrp.242.1545335113808;
        Thu, 20 Dec 2018 11:45:13 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:45:13 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 26/26] tests: add a special setup where stash.useBuiltin is off
Date:   Thu, 20 Dec 2018 21:44:42 +0200
Message-Id: <764a526393ca8ae76394aecc8a87d66abb80c1b4.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Add a GIT_TEST_STASH_USE_BUILTIN=false test mode which is equivalent
to running with stash.useBuiltin=false. This is needed to spot that
we're not introducing any regressions in the legacy stash version
while we're carrying both it and the new built-in version.

This imitates the equivalent treatment for the built-in rebase in
62c23938fae5 (tests: add a special setup where rebase.useBuiltin is off,
2018-11-14).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/stash.c | 5 ++++-
 t/README        | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 346c9d2bb1..3ee8a41cda 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1518,7 +1518,10 @@ static int use_builtin_stash(void)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf out = STRBUF_INIT;
-	int ret;
+	int ret, env = git_env_bool("GIT_TEST_STASH_USE_BUILTIN", -1);
+
+	if (env != -1)
+		return env;
 
 	argv_array_pushl(&cp.args,
 			 "config", "--bool", "stash.usebuiltin", NULL);
diff --git a/t/README b/t/README
index 28711cc508..9187eeea8e 100644
--- a/t/README
+++ b/t/README
@@ -349,6 +349,10 @@ GIT_TEST_REBASE_USE_BUILTIN=<boolean>, when false, disables the
 builtin version of git-rebase. See 'rebase.useBuiltin' in
 git-config(1).
 
+GIT_TEST_STASH_USE_BUILTIN=<boolean>, when false, disables the
+built-in version of git-stash. See 'stash.useBuiltin' in
+git-config(1).
+
 GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
 of the index for the whole test suite by bypassing the default number of
 cache entries and thread minimums. Setting this to 1 will make the
-- 
2.20.1.441.g764a526393

