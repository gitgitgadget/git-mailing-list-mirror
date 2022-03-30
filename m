Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B52C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 05:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242715AbiC3FHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242708AbiC3FHX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 01:07:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A938266213
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d7so27561665wrb.7
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TOI+vuPMSYdUksjZQAWmkRtVe6MxK9DxmcwWwfN9fG4=;
        b=PM2ZfgfmgkRYnWj9rXgXbluxCMIRlegPv604c/Icn9VHL44pgSPp9Ks+9Q/hBdv3TU
         yXSaTeyRj+pThKOC+y9R1SeJxWYt2j+13KQMYP7mlvdm3q35hgRsp1hxsJCpQ5xtb5rv
         Hj/+Npmsg51+DRAqDaoszRi2uVKqjMZLce/WdlvYEqt6esVuCe0ECpe0bQirXO9Xrhg+
         EuWmJeNdemGfMIwg9UR/Y1DqWAB5CyJHzXMhnxP2eN3H8663QfUPbR3lAM0Noz4MvxD8
         aKaxCwuP/kPCq6yFsOoqDA59We5T0bkoSw6o9s5FCZbyo5a2BrQeG5QLehMZFeHcvhOG
         G2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TOI+vuPMSYdUksjZQAWmkRtVe6MxK9DxmcwWwfN9fG4=;
        b=ahi56Nil8GaWM4W5PYiPxst/v+0e31L2VupEvl5G6h98DFBh4VBSvKOJr6C/J/L1pw
         1HPL0kZisNl+f6poQBra3DiQ7hkqT5CP2bbQulkPTebpLC1PUX6W5mx65JS3uoZx9Pfz
         nUDrzaOpwvt6JYvP9NKVyl6bijZDWOexHDc+h/ks7I9ZbcpUfNmTuZvzRYnydHNgIRdn
         B6b2/AO2jxK45cO9pGuB8AUbGxI3LNUxJaVFs6iaqxAAFsiH+wbCnWEXPsdz+IREdGtt
         3Y21+J2nYkrpPZygtgTe2+JG3R8+ktR1z/ELDYOIPgINIAtcMtQYEAzUyFKMt1WQ7tUK
         Vv8A==
X-Gm-Message-State: AOAM531IH/+v/+UedIaV2O+CvpO2IIClGrzBsrpPig1V/ifQzF4M24Pe
        kzfkD3+LrB5ywKeEEU7G54Z3VoCBwIk=
X-Google-Smtp-Source: ABdhPJzPuw7+QtulELCsaEiT07sI59usQ85YEMOaoHyEWZIB4nMhq0NZmz7OvVpgCseNzq52ULm5zA==
X-Received: by 2002:a5d:4a0f:0:b0:1ed:d377:288a with SMTP id m15-20020a5d4a0f000000b001edd377288amr33213129wrq.3.1648616737942;
        Tue, 29 Mar 2022 22:05:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c5457000000b0038c98c12ea9sm3721386wmi.1.2022.03.29.22.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:05:37 -0700 (PDT)
Message-Id: <d045b13795b38caa27f8e25340212f736b66bb05.1648616734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 05:05:20 +0000
Subject: [PATCH v5 02/14] bulk-checkin: rebrand plug/unplug APIs as 'odb
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

