Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65084C433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 18:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244406AbiDYSa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 14:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbiDYSaX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 14:30:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CE224F1F
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 11:27:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s21so7405182wrb.8
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 11:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+ol0+1Qc4bYwYytjRhghEShUA8gWYWE4SDrmV1uHNy4=;
        b=KUCKckpwVouBBn9xj36oDOP4zVW/rPyX6BWUYUkDrKfxb1BF3khNvtPrkILbNq1Xkm
         XvNskNYH1Acq5LK2ElNeMmDlqBXP93nl0YW8rW0kWUEc05Vdq9Qavn3h+cn2jiahgeF6
         Cm1/xZZoaCbxB3TcFpNwfYOKHKAkN6Mmx5tainb8K/ereKYQhbTrTsn8igyXmqbQV9JA
         j7H8HQbjp8UVOGOJs1mlMbKRfraK7zqyDLJO0ruOeIxSBkK/feoKLFtiAdeUg+J0+rqQ
         d+3zAnWMtH4qkTVQFK0wf+jXBQsVrOr8bQMFmDXZRIrzM5X2QTitUrDpxYBrT41XzlKI
         MXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+ol0+1Qc4bYwYytjRhghEShUA8gWYWE4SDrmV1uHNy4=;
        b=usrWbgTvvwdHamnWoqVodRTLzjr2fYVWdl4PLV39NwNuBPUNmGSIxV7QjMeySVX/JP
         5AnCmOPLx9WF/neRkGV4P9WWqDO7T45E7lBMN2Vt0kPsO+16KfPVZic49BMqgB+i0HV3
         F4mqlRp+trTaeQwQmHeOwcmFMdO1+YO1MX8H+v15hGvqMV96BfbQuw4PHiyD6aP29Mag
         gvJjNRf2w/FD+vCLllCqgcIMEz4/tEGXZCGsfJpT3CXo6XvQDyZ0xNdoMmblj1lH7267
         IzdBsnEMEcovZd1Ij1TQKiaw8Io9cSNLoxMBhAfaERqbmptb19XSbDyrc52omfPZ0mZn
         c7qQ==
X-Gm-Message-State: AOAM532d7LxC0Uz68XmJaqdjuXf5LYYXwDYHdon+Z3rQjW6+HmV4WQlT
        olY6/t6YcSMXA01Qp+I0+a0ImTt3xd4=
X-Google-Smtp-Source: ABdhPJzn7V4qkonrOLo0lQiKtK06oHsY2WUlelYjVkozYlapEBFx0Fj2Hd8afbPfQDQtTmF6lU8Wlg==
X-Received: by 2002:a5d:63ce:0:b0:20a:da1f:aac5 with SMTP id c14-20020a5d63ce000000b0020ada1faac5mr5500485wrw.589.1650911237062;
        Mon, 25 Apr 2022 11:27:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 62-20020a1c1941000000b00393a1a024desm11063203wmz.14.2022.04.25.11.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:27:16 -0700 (PDT)
Message-Id: <34785a0c7cc6c3547951fb29fc2b3c1cf8be6f54.1650911234.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1221.v2.git.1650911234.gitgitgadget@gmail.com>
References: <pull.1221.git.1650553069.gitgitgadget@gmail.com>
        <pull.1221.v2.git.1650911234.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 18:27:12 +0000
Subject: [PATCH v2 1/3] midx: use real paths in lookup_multi_pack_index()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This helper looks for a parsed multi-pack-index whose object directory
matches the given object_dir. Before going into the loop over the parsed
multi-pack-indexes, it calls find_odb() to ensure that the given
object_dir is actually a known object directory.

However, find_odb() uses real-path manipulations to compare the input to
the alternate directories. This same real-path comparison is not used in
the loop, leading to potential issues with the strcmp().

Update the method to use the real-path values instead.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 midx.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index 107365d2114..3db0e47735f 100644
--- a/midx.c
+++ b/midx.c
@@ -1132,17 +1132,26 @@ cleanup:
 static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 							const char *object_dir)
 {
+	struct multi_pack_index *result = NULL;
 	struct multi_pack_index *cur;
+	char *obj_dir_real = real_pathdup(object_dir, 1);
+	struct strbuf cur_path_real = STRBUF_INIT;
 
 	/* Ensure the given object_dir is local, or a known alternate. */
-	find_odb(r, object_dir);
+	find_odb(r, obj_dir_real);
 
 	for (cur = get_multi_pack_index(r); cur; cur = cur->next) {
-		if (!strcmp(object_dir, cur->object_dir))
-			return cur;
+		strbuf_realpath(&cur_path_real, cur->object_dir, 1);
+		if (!strcmp(obj_dir_real, cur_path_real.buf)) {
+			result = cur;
+			goto cleanup;
+		}
 	}
 
-	return NULL;
+cleanup:
+	free(obj_dir_real);
+	strbuf_release(&cur_path_real);
+	return result;
 }
 
 static int write_midx_internal(const char *object_dir,
-- 
gitgitgadget

