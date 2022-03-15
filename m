Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5900C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351931AbiCOVcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351045AbiCOVcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:32:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE1F5BE45
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:31:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h15so371422wrc.6
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0MN4ba+hT0xX9b9hxT23sNJfmufB+b0cpHIN0fkaGEI=;
        b=Del9q4Yqm3k8qdb7gMWc4Ld67zqk/wT4DS4nM5uCwFQBwXTq+RP0olV9hVWGmrSNao
         kT9Sgu031wvhayaiDW+ayoUKsYHig51DLzRbX0Km+7XeVDHRBLKYGTbScWgFxkvdOLoY
         GaTx44lPZCK3djsAJeHPDofuh/no0xTXkpxirRBR16L8jzg3Ovzlzvq/LoIHyM10nqrb
         nSSHuljpAsgMFvEbZbGOw4X2yZ0p+Wq7d25PZ96Tm7g+Ezc8PhkNCmiySlwJVYr1dxP+
         ARYQDntCJ8e5+3No45i+ITRn25tCWTvUM7oVdZ2iqN5l5rZS83O+2SibxXpg/SPA8ND9
         BifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0MN4ba+hT0xX9b9hxT23sNJfmufB+b0cpHIN0fkaGEI=;
        b=I9O79OHbEjCzh3UYb9rMf9WXUUVkShDLLnjBTvz3ktrKSjJgYxfCj/wsmYd3Gw1+vD
         jgkKkA/eaK9RelZCs/Ispom9ETeZshYq4hCI7bkQTMvhDQo+u/L25iQHmazLdEvO4jo6
         ZHP/HMe5YAS2doK8D7OAAzArXSBGRhDFueRRcDiPkrRK/NKxslcMNqPal71r0trvO4EY
         ySNPY8tVB4R5CU10cyVst96i5jSZjERTcY12WrqUz+HQSIqcaUATs6sCr2OYo5OKUYkX
         3EZt5nmY3HJIRKyJbLQjMgXAQrPUigr6TanB0diogdKlQuzlfDJ82U/uvjlfhX9n97aq
         irVQ==
X-Gm-Message-State: AOAM5321TZtrTbb5OCednbKJuhnKD74OrjkDAbuhQMI6MkbaSNPTN/ka
        P+IJO9788a+NR7vn+VjDLLM1SdHOCoM=
X-Google-Smtp-Source: ABdhPJx4lkiLSspxWbRbhVUHixC1L2P6NWTe8ZmzwNFU+bRe2iN2wgzh4OHSeAGMusbCQQvdJOpCqQ==
X-Received: by 2002:adf:d1e2:0:b0:1f1:d702:72c1 with SMTP id g2-20020adfd1e2000000b001f1d70272c1mr21598610wrd.687.1647379861795;
        Tue, 15 Mar 2022 14:31:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d6707000000b001f067c7b47fsm142935wru.27.2022.03.15.14.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 14:31:01 -0700 (PDT)
Message-Id: <a77d02df626ed6dff485e1342ff7affd6999ec44.1647379859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 21:30:53 +0000
Subject: [PATCH 1/7] bulk-checkin: rename 'state' variable and separate
 'plugged' boolean
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Preparation for adding bulk-fsync to the bulk-checkin.c infrastructure.

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

