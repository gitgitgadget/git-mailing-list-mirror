Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDAEC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346463AbiCXFAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 01:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345915AbiCXFAI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 01:00:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D052A241
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t11so4942892wrm.5
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dGhuKNFF6d1Xb8n8Bmr/hlaiPKd4B21RTCn9HBUk55Y=;
        b=m2ahk5Ce6u7wJFWNzjBlZtPfP+5B7JEXWI6php1qxe9TYrwsj5c3VDOnUd67QBjdru
         A/CtWzW+5OyPNr78ZW7zf7ogox3KZV6bXwYwwqwNlwE8RqRq0dApohPfZozPo960lMSo
         uxH0VV9aguS+upJ179YnaRMrQ1RLQBTzDFt8vTIj3dMSFSp9TQJA1oj6eyIQYS/6WGqe
         favT32CwV5FXCAdiqzTivslaShFQHNVtC6Ipuw5vNtC80HDV9mQ20d8QegZgq2df4D7F
         TAy+c/Md9ifYMPzdgkYS/m3YfLrtxu6X0aiZvc61E41LRKkofFUQlDRJU0o7fxz8aYUz
         MdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dGhuKNFF6d1Xb8n8Bmr/hlaiPKd4B21RTCn9HBUk55Y=;
        b=Vu0IqaXaR81R5buKq8BK8R7vn9iB/CFMAChNe/silsA+WZys4G97YBKB000VEuZBMp
         mvWd5BOajJNO4NtzrSf+DWHVVmwH1bHFz/51B3XmMZ2GtBXUFyVcNmJxvqDZx+U6a21l
         gj1eFKkL54XoBkIWtsbMu20jGEE60fp8KipLiV/4a/tHHMoELIlwrtqowvt/qcZ3PjmA
         b6ZE+b+HbRcz51doHKnZKMthZm8fePHAgZpkh7J7MJM4KSPiAgWepoPrdtAlsRFT9OGn
         iLHbSlh8HuJ3huCboXL1gLYhS1HkTECTGk35tReZ/1sEmoyDVfdkoaDhtnVO92nZRp9h
         PZIQ==
X-Gm-Message-State: AOAM533kuSricNi4b75yprg+0e+g5DRTHhXHCY4cw+38Aq+7hmVztSeb
        7zLt0nKe4yBwHWzjgvQhXMriKKlECos=
X-Google-Smtp-Source: ABdhPJxGNDR1GqF5DgBhaPberFxCs/Evii/BzH+7YIctUytgQbpe7D6ZFJQuHApR7epbfFI1KVcaxw==
X-Received: by 2002:a5d:6292:0:b0:203:d745:5a94 with SMTP id k18-20020a5d6292000000b00203d7455a94mr2903958wru.286.1648097915639;
        Wed, 23 Mar 2022 21:58:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m23-20020a05600c3b1700b0038bbd24f401sm4868557wms.2.2022.03.23.21.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 21:58:35 -0700 (PDT)
Message-Id: <913ce1b3df9cf273f1572c256dffad1cacc192a6.1648097906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 04:58:20 +0000
Subject: [PATCH v3 05/11] update-index: use the bulk-checkin infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The update-index functionality is used internally by 'git stash push' to
setup the internal stashed commit.

This change enables odb-transactions for update-index infrastructure to
speed up adding new objects to the object database by leveraging the
batch fsync functionality.

There is some risk with this change, since under batch fsync, the object
files will be in a tmp-objdir until update-index is complete, so callers
using the --stdin option will not see them until update-index is done.
This risk is mitigated by unplugging the batch when reporting verbose
output, which is the only way a --stdin caller might synchronize with
the addition of an object.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/update-index.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index aafe7eeac2a..ae7887cfe37 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "lockfile.h"
 #include "quote.h"
@@ -32,6 +33,7 @@ static int allow_replace;
 static int info_only;
 static int force_remove;
 static int verbose;
+static int odb_transaction_active;
 static int mark_valid_only;
 static int mark_skip_worktree_only;
 static int mark_fsmonitor_only;
@@ -49,6 +51,15 @@ enum uc_mode {
 	UC_FORCE
 };
 
+static void end_odb_transaction_if_active(void)
+{
+	if (!odb_transaction_active)
+		return;
+
+	end_odb_transaction();
+	odb_transaction_active = 0;
+}
+
 __attribute__((format (printf, 1, 2)))
 static void report(const char *fmt, ...)
 {
@@ -57,6 +68,16 @@ static void report(const char *fmt, ...)
 	if (!verbose)
 		return;
 
+	/*
+	 * It is possible, though unlikely, that a caller
+	 * could use the verbose output to synchronize with
+	 * addition of objects to the object database, so
+	 * unplug bulk checkin to make sure that future objects
+	 * are immediately visible.
+	 */
+
+	end_odb_transaction_if_active();
+
 	va_start(vp, fmt);
 	vprintf(fmt, vp);
 	putchar('\n');
@@ -1116,6 +1137,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	 */
 	parse_options_start(&ctx, argc, argv, prefix,
 			    options, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	/*
+	 * Allow the object layer to optimize adding multiple objects in
+	 * a batch.
+	 */
+	begin_odb_transaction();
+	odb_transaction_active = 1;
 	while (ctx.argc) {
 		if (parseopt_state != PARSE_OPT_DONE)
 			parseopt_state = parse_options_step(&ctx, options,
@@ -1190,6 +1218,11 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
+	/*
+	 * By now we have added all of the new objects
+	 */
+	end_odb_transaction_if_active();
+
 	if (split_index > 0) {
 		if (git_config_get_split_index() == 0)
 			warning(_("core.splitIndex is set to false; "
-- 
gitgitgadget

