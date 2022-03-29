Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA9FC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 00:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiC2AoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiC2AoT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 20:44:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EDF237FFF
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r64so9339658wmr.4
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VcBruSMhra7Hu3xR7auyp+juizXtAATaYi6To93RDbY=;
        b=HUN/1PLCB+NTYhba6DF8/dIt3AVKPZPwuSSMxBeB1rBA3m1d3EI5XdjEaPOh6JF7RE
         8JKe8xaF4M/FGV7BPH8afYFp0+hF8RLWU8UdMSm7Z1K7HG+19Q5IyCiUKD+0x1pJk6xZ
         o6rW0f6An+cxqgYYVD0Ic8fURHdXQmD4do8tY8h5GvE0d9h7PJTBirkai7ilr9GfpIy+
         B/vecmSeL1sxlJol1+hpk/I0CskRqoK2VxAn+F8VxVhHpfcUZn7G1AoDfMWNFqvnt1Zf
         W+EyzLaM3xXAy1lzExIioBR0scZmqSW7QyrDwm362M4p42STmF37vo6qotqD7rHUl0iz
         c5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VcBruSMhra7Hu3xR7auyp+juizXtAATaYi6To93RDbY=;
        b=2F9M3l4rlO4fnd+ApJ3rSma+EnMOy0ugo8OOBr6gxz9Yll0XJSU6IGmSdLGt4MNuNB
         Tr6RQfJEOsu5kcodofnCcgxwXjaxncm5u1h+NkDBzzc3aE20fOLinPJBK8i9HbOXyqxa
         7x0XH9elsS9GeFIBqEom58zQ7MCH6nVonknqpmE7tVb/ObOHc0CPhKzhHGFts+KgekT2
         AJomemfoj1uFcwYaK9ukgDXPaC0vJPYSnX/Q+W7oiAFqmt0Sm1IpCcqCM+Kk3O3QIheG
         ZcDgWDtinkIs8TvHloE9JwUtNJJ4fKefW3goHTMI9GPGZwHVz7b07tUtDd2vgZ+mJqjd
         3uMQ==
X-Gm-Message-State: AOAM531bmZTzcNfiRQNW0AzKa9M2ozMvm2/gfCamNZ18SgU7GWwmigy1
        4HJMur/cxv84tHpjyd+dpL6saOQTo7g=
X-Google-Smtp-Source: ABdhPJxqmbKV2weoWsteyljCxCbuXyvgzKzly3XZQebC7SHOR+pSIWHrJWbIXbYDIyBlGfYMmMbK8A==
X-Received: by 2002:a05:600c:3505:b0:38c:a3a8:8479 with SMTP id h5-20020a05600c350500b0038ca3a88479mr2907207wmq.4.1648514555666;
        Mon, 28 Mar 2022 17:42:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b0038cafe3d47dsm768053wmq.42.2022.03.28.17.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:42:35 -0700 (PDT)
Message-Id: <c7a2a7efe6d532fc7fce1352b1dfce640cc9f2f6.1648514552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 00:42:18 +0000
Subject: [PATCH v4 01/13] bulk-checkin: rename 'state' variable and separate
 'plugged' boolean
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
index 6d6c37171c9..577b135e39c 100644
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
 
 void plug_bulk_checkin(void)
 {
-	state.plugged = 1;
+	assert(!bulk_checkin_plugged);
+	bulk_checkin_plugged = 1;
 }
 
 void unplug_bulk_checkin(void)
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

