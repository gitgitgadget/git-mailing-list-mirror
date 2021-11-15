Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1109CC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0F361B96
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbhKPD1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238438AbhKPDZq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 22:25:46 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB4C126D00
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:08 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i5so33939161wrb.2
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0YFH/7O9dujfKmmu6ZRk/KJCH7LOCPzTEaGTMr5K95k=;
        b=ECHcU8am5+RFG6dX4B+xmMUNphEDTu0KVXq/cF/QlMNtFrdu8DPwEH6jWdfr5Lnpc4
         rsL8szD5DSnXc9yzRXeYZPG82Hrpd3vAmmbS3kLyaN+OXrgl2TJy4ACTXycxsw9Fej5Z
         BE2b2ezAqVjjbYNL3Swk46QeNjPVpu32ftepzian+J9HC2+F2JBsopTd2rw4581dvMdJ
         sYcYjKzrCoDnFI8mHCY2M4mS8OnKxKBatDf8WkC/RUS08EnBdIUgusZcQysGpeIL6Vu5
         Sp3y6wvZDkHCEaDHw9ylpA0mc/LvlCZGD3KiXB85bsF3Z+gz343PErZqi8u3O4HlPRWG
         /Qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0YFH/7O9dujfKmmu6ZRk/KJCH7LOCPzTEaGTMr5K95k=;
        b=x1pnTKQqHArqhbFFnyJgm6Ax50tCpgfz0rblTvwdXNZ/WG/z6nYl5HkC5h16+ioUt5
         UJ9K9rIyPLfxIyqS/8esYpo6YjP+mw4EwSkRjzuK8reGrC2AuvqExFhTpTHggLqq6fpo
         mocc+VKKBO8a0Gg8mbZgSZU1HRv83vn49P7fBHpZ48lqp0/aXI5WTlJ0ua8a+7ToZFPz
         dFNfieYAB3IDC4ZH4MKb69EW+e+AMFLb69JJyZxl5xInLzp44Hl2u0eUmSKgNdo4JWzM
         mXvB1NN60MSzcHFFA42vRmzAu2tZ6aJ21nS14dvppeBPUDgjsZRqs6rSZTh6gHqMpAY/
         ClBg==
X-Gm-Message-State: AOAM530ssmSx2BaZhOS7j0JWOaQMpQYXoVp2b/7KqAV1IcPsdsLK7fqO
        ovOmwDbb+99NjDLQBPy+lHQxIRAKIyw=
X-Google-Smtp-Source: ABdhPJy+PDM0FNw1uQpHHxx90WyJ9HOn98kTUjSpiMpFUbWvLAO5dRZmFI7Fm8waIohmi2hSEaMyHA==
X-Received: by 2002:a5d:4b0e:: with SMTP id v14mr3912505wrq.196.1637020267084;
        Mon, 15 Nov 2021 15:51:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h1sm687041wmb.7.2021.11.15.15.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 15:51:06 -0800 (PST)
Message-Id: <8fd1ca4c00aa94dbb75a34359727bdbd3adccf60.1637020263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
        <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Nov 2021 23:50:57 +0000
Subject: [PATCH v9 3/9] bulk-checkin: rename 'state' variable and separate
 'plugged' boolean
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Preparation for adding bulk-fsync to the bulk-checkin.c infrastructure.

* Rename 'state' variable to 'bulk_checkin_state', since we will later
  be adding 'bulk_fsync_state'.  This also makes the variable easier to
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
index 8785b2ac806..6ae18401e04 100644
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
@@ -277,21 +277,23 @@ int index_bulk_checkin(struct object_id *oid,
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

