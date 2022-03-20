Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCFBC433F5
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 07:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244956AbiCTHRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 03:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244928AbiCTHR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 03:17:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D3C3374
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r7so6935048wmq.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rPIqtYOuJZhaQkBUZUvmbTUDWfAzbOpHstVecEFt4eo=;
        b=G2MkLrFd/gpWpYAC7rLvZfvtJM07meJ8/u7DwkMsW+x+MpUwZ+gbVj0Cvfo4xadliY
         ZKk9AtzTk/3Yrd6dnadTTdocQ/d+ZsadxUPG5i/4pziRlbvC7hiW9C6P5iU/p2dVbW5D
         GnPPn/M2greqSqr2fl24Z5GXv4pEXI98DAlJgMF48rUz7NWoDA0uuIjaP+4TzEWVaMRL
         2v3X7oLQQDgBIH2cagnt7f9Etl9O9rsBAFsHsYpeIeP7PiRGgSllmsNfmydO4l4BoUpn
         d54xGH6zDvXDeRMQNVrnfzPPl90hFxDNxyAllt8SW+/wUj3u/UBXFxBAhsOXuYXJK6sn
         xfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rPIqtYOuJZhaQkBUZUvmbTUDWfAzbOpHstVecEFt4eo=;
        b=zjVxR6XvPaVSzGt1Zmcqw0cYQh7+crgIYA7AeieoIxzQljXbcrvaNJzuxkXKh1xqfM
         5PDn+ldBQd6omnzH5jvAPqH1o0O6C+xsi/oF9k2m+M+kOnyWdVCqtsMNeFaFb3WMFa5s
         A5qUPreT04aG6c3E6KRS3BhoYFLiCPs7BoiMxuMFOJmit6k+tBUM8AoC4pkSzOHt+D9c
         7kLF7OaEIKrX+qcAOxxXn2hgydBI8juLu32V+nGkwF/xWC6zgjyKNo7lvxj2F3XLdSh4
         jG/LlmX31A7k3JL3fmPOoOGyS+hlbeIiBUPJLg5sHD+rMZgcFlnOLSPrVN66Q35h2Thm
         3sTw==
X-Gm-Message-State: AOAM531L5aL6du4EYyxw9cD/yZ/Mj8VnPkLTati5lmfblr0rrqBEdm+N
        VnMcmrdeEARIsMYv583pushlS4NMZVc=
X-Google-Smtp-Source: ABdhPJw20CLzi2xJiJvkZ4tKvmAyPkMv4rw6fVFM6xWrnqi9uCkaiaLChYqe9TuUaCPi4iz4iA7XuA==
X-Received: by 2002:a05:600c:1c28:b0:389:b614:68f2 with SMTP id j40-20020a05600c1c2800b00389b61468f2mr22553951wms.142.1647760563679;
        Sun, 20 Mar 2022 00:16:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm2580304wrz.29.2022.03.20.00.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 00:16:03 -0700 (PDT)
Message-Id: <9c2abd12bbbd27261378ffb6478a3e5db8a5063c.1647760560.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 07:15:54 +0000
Subject: [PATCH v2 1/7] bulk-checkin: rename 'state' variable and separate
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
index e988a388b65..93b1dc5138a 100644
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

