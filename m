Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20033C433FE
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 00:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiC2AoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiC2AoU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 20:44:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C670238D1F
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u3so22631702wrg.3
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TOI+vuPMSYdUksjZQAWmkRtVe6MxK9DxmcwWwfN9fG4=;
        b=dDEret9qhIZ1PLqnYpJ53CaWZgpA8yXOtG6HyyKYbntiGl1nhG4FieTxaI9rEKtxYM
         ktG7t+dZ5NEi37c5ojYTo9FnQfdk2Uv5clIFA4kv8bdhxwMr0caq6tjCwxwq8ZSn7iFl
         BmJKcA1lynmxWze0zniEAtjZnIQSKldQPy79C0Ti9NZGM3r8Vk/oTs/U7xO4vpBI09cQ
         HFkV/kzAJGye3uV5EbVWWTYLIJnu0fkPq+y+Tlz9f+AkiEF+mN4TyhDQatUEo29nF/Jb
         Pxzj4EKKlrfFHV+/z7qu7DLWO5FZ3JcKZD/ctZ01z8erY30gLf9Oq27F4xQwfhxXFmAE
         GsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TOI+vuPMSYdUksjZQAWmkRtVe6MxK9DxmcwWwfN9fG4=;
        b=xVCNdJWZiFRvzF//taK9pXJhm4ig2Y0ozIumVfT5V/1v2Pq/wNOuntszLLV3kUrwuP
         m93ilpDOByrMBh+vEXdDTXJPsrrqxfGzIUsE1JBIVjG/gFk6Bpv1fRafvD+TvRdP5lpg
         8Q2ycCi6Dk3CKDLKOjsd702wY897eypgaklgp2uywTADNb+KMK1WvJCHmD1Q469vC61Y
         V5CqTTpWsbUxF/ApLIo+6GMjY1F7q5QNYWUXtHfsdD8ajWXFgzQwiMQjshJLvzEekCky
         kZw+1PcnrSSBDKvrR2pRptS4s6vToO2cqvNbntHGifyURigbD5aZXHUSPG7AQc6NVMur
         XXGA==
X-Gm-Message-State: AOAM532zIK40XFDMEWW27m2hQjFswuqWccKdNIJ1oXpr7mHSCU48mGTL
        uyWXwjCAlUNeEikrNARDZyMLxgWjmDI=
X-Google-Smtp-Source: ABdhPJzyd05jC/48y9Q934STxdxYYDtHNIy5TWpSZGyqgRLu8gD4JmYFMOLfJ7CP5f4ZHyO5gwBlew==
X-Received: by 2002:a5d:6b0d:0:b0:1f0:6497:b071 with SMTP id v13-20020a5d6b0d000000b001f06497b071mr27673079wrw.638.1648514556624;
        Mon, 28 Mar 2022 17:42:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0038c6ec42c38sm738834wmq.6.2022.03.28.17.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:42:36 -0700 (PDT)
Message-Id: <d045b13795b38caa27f8e25340212f736b66bb05.1648514552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 00:42:19 +0000
Subject: [PATCH v4 02/13] bulk-checkin: rebrand plug/unplug APIs as 'odb
 transactions'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Make it clearer in the naming and documentation of the plug_bulk_checkin
and unplug_bulk_checkin APIs that they can be thought of as
a "transaction" to optimize operations on the object database. These
transactions may be nested so that subsystems like the cache-tree
writing code can optimize their operations without caring whether the
top-level code has a transaction active.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/add.c  |  4 ++--
 bulk-checkin.c | 20 ++++++++++++--------
 bulk-checkin.h | 14 ++++++++++++--
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 3ffb86a4338..9bf37ceae8e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -670,7 +670,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
-	plug_bulk_checkin();
+	begin_odb_transaction();
 
 	if (add_renormalize)
 		exit_status |= renormalize_tracked_files(&pathspec, flags);
@@ -682,7 +682,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (chmod_arg && pathspec.nr)
 		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
-	unplug_bulk_checkin();
+	end_odb_transaction();
 
 finish:
 	if (write_locked_index(&the_index, &lock_file,
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 577b135e39c..8b0fd5c7723 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -10,7 +10,7 @@
 #include "packfile.h"
 #include "object-store.h"
 
-static int bulk_checkin_plugged;
+static int odb_transaction_nesting;
 
 static struct bulk_checkin_state {
 	char *pack_tmp_name;
@@ -280,21 +280,25 @@ int index_bulk_checkin(struct object_id *oid,
 {
 	int status = deflate_to_pack(&bulk_checkin_state, oid, fd, size, type,
 				     path, flags);
-	if (!bulk_checkin_plugged)
+	if (!odb_transaction_nesting)
 		finish_bulk_checkin(&bulk_checkin_state);
 	return status;
 }
 
-void plug_bulk_checkin(void)
+void begin_odb_transaction(void)
 {
-	assert(!bulk_checkin_plugged);
-	bulk_checkin_plugged = 1;
+	odb_transaction_nesting += 1;
 }
 
-void unplug_bulk_checkin(void)
+void end_odb_transaction(void)
 {
-	assert(bulk_checkin_plugged);
-	bulk_checkin_plugged = 0;
+	odb_transaction_nesting -= 1;
+	if (odb_transaction_nesting < 0)
+		BUG("Unbalanced ODB transaction nesting");
+
+	if (odb_transaction_nesting)
+		return;
+
 	if (bulk_checkin_state.f)
 		finish_bulk_checkin(&bulk_checkin_state);
 }
diff --git a/bulk-checkin.h b/bulk-checkin.h
index b26f3dc3b74..69a94422ac7 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -10,7 +10,17 @@ int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags);
 
-void plug_bulk_checkin(void);
-void unplug_bulk_checkin(void);
+/*
+ * Tell the object database to optimize for adding
+ * multiple objects. end_odb_transaction must be called
+ * to make new objects visible.
+ */
+void begin_odb_transaction(void);
+
+/*
+ * Tell the object database to make any objects from the
+ * current transaction visible.
+ */
+void end_odb_transaction(void);
 
 #endif
-- 
gitgitgadget

