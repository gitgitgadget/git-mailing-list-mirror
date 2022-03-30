Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2205C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 05:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242723AbiC3FH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbiC3FHX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 01:07:23 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE21265D32
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p189so11514776wmp.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VcBruSMhra7Hu3xR7auyp+juizXtAATaYi6To93RDbY=;
        b=D6PK0v7wWm7l2Oy6scqAXta0jJDYPpR7rvBXueypZCYXitZNTf+/XbS1OVRal0wu9Q
         dDPC/vym99c97wQlHGfSOXAu76RibZH8wGVO7fD7TJrnFXoNv3foHCBBxvz4v6kHy79W
         ZMkf9Kg2QCuGeCHe8RmjaRICvsczZTyXlWzJoVuMgTF1rFt2hQEdjlHrZ4+hWL6Qyi58
         ct4JURoCdArTtAWjLEUaNlVCAi/F+JYeUeuEznioVMJGa/ReGJ5v4fhRGSc5YyCYHHpV
         A+ZnsOn1kps9FjDDMow4dRKqYqyykdZ0pAwoK9zfYXvL3moGGRu/sMds3MpgI/RDKUGY
         4wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VcBruSMhra7Hu3xR7auyp+juizXtAATaYi6To93RDbY=;
        b=W4gMkh8QotOb4eV5Uq8EdJ9ju9G5oU5VIs4FPAV/ZiZWAMNWmMwJVq+l2vzjg/WMjQ
         ceVQPVtYHulyMr8hkHM0XCnWPi6c6BwGkXqcFGVeKdIgEnaTFKVhGTzuB4/ntot/fSdn
         eqLyztsIndvdzbQctaMOOI3BNS7jjlNEaQ1jnagUNdHcUfxjP8RaiFqy4wVL44+za5o9
         ihDkNEMhj5wB0GFLtRPbpsCxfb7fWPQVMbI5t0xlSUr4/r1ngIHsgyVlZwpdfbkJdhAn
         K27HxCUOMDG2ofUTpdzc1eiFX+dxX4ik9ZHuDpDk0DPnxF4PMR4cHwjQBk09Dpk3A3Tk
         hb6A==
X-Gm-Message-State: AOAM533sBDRUJetEfxjgdWMZIk+/VHafW8DHpBvMjG2ARTYaY6nufwpA
        NpFHOTdvMBMckfjbfG6efhYUlbqUbm4=
X-Google-Smtp-Source: ABdhPJy/r4tVODtKs4tTaLiR9hooasSjV6Dlt6d8Oe4BJs4TuzMpKAQc9bpt+pWg4zwusx/yy116ng==
X-Received: by 2002:a1c:f415:0:b0:37f:ab4d:1df2 with SMTP id z21-20020a1cf415000000b0037fab4d1df2mr2553562wma.75.1648616736830;
        Tue, 29 Mar 2022 22:05:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b0038cb84f4218sm3869791wmq.27.2022.03.29.22.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:05:36 -0700 (PDT)
Message-Id: <c7a2a7efe6d532fc7fce1352b1dfce640cc9f2f6.1648616734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 05:05:19 +0000
Subject: [PATCH v5 01/14] bulk-checkin: rename 'state' variable and separate
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

