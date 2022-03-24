Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FDCC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344656AbiCXFAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 01:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344514AbiCXFAF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 01:00:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB74289A7
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m26-20020a05600c3b1a00b0038c8b999f58so6546031wms.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A0izl3DXxNO8poqc20QhPK4C1b+CBCwBTxzGAAuXuC4=;
        b=AEgZLtbuiE0CJYPThTjPkeHAk1AuqcKeiRJeiKWmLWZ+LUMKvQuAw8LVoRipQluPZ3
         7hWcgNdiOID3lcDUp6N7GYgIDwP/XlEpv0ZVJpBPLcu1K5YNNaKyGN4Q8sPczxiJQz8o
         OnkU2zfOiaMH2s8X18pYTOHgOHqzbA4TCK11ge9gRfKJC+1URSJPURZ5Iv0yoMbMGIQ7
         Hu40x8bJeysS9xSmZ/dvYxJLNiK8q4cJtBoET30dAcTJfSHl6s4PnZxW7qWkGJrzMiEi
         Xc8mpSaNcj+qJt3yG9KQ3A+hQRX0YH0kDGGAvsAdOn5xwLGxJUEOx6XXWPx2YpDvelpP
         NFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A0izl3DXxNO8poqc20QhPK4C1b+CBCwBTxzGAAuXuC4=;
        b=fzBn5Ooq5mWHXecBDvTWQy56XUpeY4w6G90+LuPdRJQ7ycAWGjqvX41bGKXO+nwPap
         N0pLNyIshneAvOrNMcXP2WMSB69htlCFf6Jxk0YWu+SLHZ8z5TAiNAiPBEVV7h6K+Ux4
         hVq1Wi0B1ZJcq3NfxK2GjOilHKVSzJRJRciNoMXdFN9bI4N9RIuDR9GqdM7ZnZJ+Q3/x
         HhUeMA1gInDz7bp1Rj8twrI4waexNeh1anV77MhXLh/eakYgUI3eEv8FXCFF5z2t/X4N
         MAKMYKt9LYqXPH3YwjcK00jqKiO36k5qjpZnhE9Ik8TN/62+4LnmK8ylY14PD1BjqaL4
         lGug==
X-Gm-Message-State: AOAM531gJAxVVCAdAw3oIp/3U85wfQdMzXQhz6giQQkKEjGibcHA4hFS
        Eu4OEVdZxDooj+r/mlO767o2e+FqtNw=
X-Google-Smtp-Source: ABdhPJx/b55Z2XaEo/V29e7YE9kofSWt851oolQUi32KNYwq0i8IMG4wLPJLHyA9n4UG4CO8RCSMCg==
X-Received: by 2002:a05:600c:1c11:b0:38b:4924:9a77 with SMTP id j17-20020a05600c1c1100b0038b49249a77mr421814wms.0.1648097912282;
        Wed, 23 Mar 2022 21:58:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm1576905wri.105.2022.03.23.21.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 21:58:31 -0700 (PDT)
Message-Id: <b2d9766a662894d177fa5b7f2a5de2a45351f47e.1648097906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 04:58:17 +0000
Subject: [PATCH v3 02/11] bulk-checkin: rename 'state' variable and separate
 'plugged' boolean
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

This commit prepares for adding batch-fsync to the bulk-checkin
infrastructure.

The bulk-checkin infrastructure is currently used to batch up addition
of large blobs to a packfile. When a blob is larger than
big_file_threshold, we unconditionally add it to a pack. If bulk
checkins are 'plugged', we allow multiple large blobs to be added to a
single pack until we reach the packfile size limit; otherwise, we simply
make a new packfile for each large blob. The 'unplug' call tells us when
the series of blob additions is done so that we can finish the packfiles
and make their objects available to subsequent operations.

Stated another way, bulk-checkin allows callers to define a transaction
that adds multiple objects to the object database, where the object
database can optimize its internal operations within the transaction
boundary.

Batched fsync will fit into bulk-checkin by taking advantage of the
plug/unplug functionality to determine the appropriate time to fsync
and make newly-added objects available in the primary object database.

* Rename 'state' variable to 'bulk_checkin_state', since we will later
  be adding 'bulk_fsync_objdir'.  This also makes the variable easier to
  find in the debugger, since the name is more unique.

* Move the 'plugged' data member of 'bulk_checkin_state' into a separate
  static variable. Doing this avoids resetting the variable in
  finish_bulk_checkin when zeroing the 'bulk_checkin_state'. As-is, we
  seem to unintentionally disable the plugging functionality the first
  time a new packfile must be created due to packfile size limits. While
  disabling the plugging state only results in suboptimal behavior for
  the current code, it would be fatal for the bulk-fsync functionality
  later in this patch series.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 bulk-checkin.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index a16ae3c629d..ffe142841b2 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -10,9 +10,9 @@
 #include "packfile.h"
 #include "object-store.h"
 
-static struct bulk_checkin_state {
-	unsigned plugged:1;
+static int bulk_checkin_plugged;
 
+static struct bulk_checkin_state {
 	char *pack_tmp_name;
 	struct hashfile *f;
 	off_t offset;
@@ -21,7 +21,7 @@ static struct bulk_checkin_state {
 	struct pack_idx_entry **written;
 	uint32_t alloc_written;
 	uint32_t nr_written;
-} state;
+} bulk_checkin_state;
 
 static void finish_tmp_packfile(struct strbuf *basename,
 				const char *pack_tmp_name,
@@ -278,21 +278,23 @@ int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags)
 {
-	int status = deflate_to_pack(&state, oid, fd, size, type,
+	int status = deflate_to_pack(&bulk_checkin_state, oid, fd, size, type,
 				     path, flags);
-	if (!state.plugged)
-		finish_bulk_checkin(&state);
+	if (!bulk_checkin_plugged)
+		finish_bulk_checkin(&bulk_checkin_state);
 	return status;
 }
 
 void begin_odb_transaction(void)
 {
-	state.plugged = 1;
+	assert(!bulk_checkin_plugged);
+	bulk_checkin_plugged = 1;
 }
 
 void end_odb_transaction(void)
 {
-	state.plugged = 0;
-	if (state.f)
-		finish_bulk_checkin(&state);
+	assert(bulk_checkin_plugged);
+	bulk_checkin_plugged = 0;
+	if (bulk_checkin_state.f)
+		finish_bulk_checkin(&bulk_checkin_state);
 }
-- 
gitgitgadget

