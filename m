Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A286C25B0C
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 13:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243176AbiHHN2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243340AbiHHN15 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 09:27:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91528A472
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 06:27:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso5161195wmc.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=v6BZradEP9tTafjbmqr4IwJDt5zRjEVeDjgv2G2Ibss=;
        b=BZbX/7BFvH4L6ItMfTcfliRxJFoypGd8EY3gUQ4f6I2Yyw+KeFY2KmKarF8xbqYvYz
         WqoQROjPyRuvGhEYl/Aiau0Knbh5Vdo0UdOoyXyFyyd8SZZIvyCRws+pSZIYbvTVkCUN
         Dk97My/AvKD2iovXbNn5oUggLPWuqt4LghQTdr4FGXGp7dWj2NMIgjoHj0hSa5TjTPUL
         D7bYwDWcEcswe1F5ZrTPtSEXSQBQYca4dsNe9G3Q+O9RvVSPoNQXyoSZ3d1ST3d0vLba
         MzwR1j7ecTgJK7HUlLj0Q0isKrAzckQtmuo0tY3Fz7b3QLB9FEgIBtmtLU5ZvATiuPjE
         KwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=v6BZradEP9tTafjbmqr4IwJDt5zRjEVeDjgv2G2Ibss=;
        b=tNpm5HlWzM6kbGZsDsnUVJh7qf2pBBzeAA1dua6J014vUrNglS8KIqpvBGQvAf10K5
         Ws9KX9DrmXMHZVIL0xYFAKV2IrFZEOaSGrK1ywamV2t1fIF3aVb6VW0+QZtS8+lOQC4F
         8W/iOzCIdM64TVtGqyi72b1y2xWLv9sWVIyg7GXzQTqGrjyvnHRDROA/UXc8ynAOb8n/
         KiY6q6glgGYkvqFnfWtd8aKhleLJ4ZUtgVnp2yKfCQ1jd5H3QNfgzh4HTISQqghC6HtK
         WiXIfwPiTpVcAT8geJgkWtZXjtk84cvduCej7wqNVFDg/hDOVZNtFte4fkk+tDDKLlIx
         521w==
X-Gm-Message-State: ACgBeo0GTTPz0c3O42mvFFs4NQI6tJUGg/FSc/p7SRfDJnz7zRV4XT8R
        9XvlNwhNk68GfbGT+nVPXUq3fwTsYcM=
X-Google-Smtp-Source: AA6agR5dIdOsdWCUpWZNjaUVJk1ZMin4FGc+7CTmj5qzYxfZBDf3FEihnuccYvsnBiX+S9MOo2kQQA==
X-Received: by 2002:a05:600c:348e:b0:3a3:5515:98b1 with SMTP id a14-20020a05600c348e00b003a3551598b1mr13019124wmq.110.1659965275817;
        Mon, 08 Aug 2022 06:27:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b003a31b79dc0esm41242583wmq.1.2022.08.08.06.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 06:27:55 -0700 (PDT)
Message-Id: <7aaa6248dfef7fb8436b5fbccf4689d0be3226a5.1659965270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1286.v2.git.1659965270.gitgitgadget@gmail.com>
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
        <pull.1286.v2.git.1659965270.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 13:27:49 +0000
Subject: [PATCH v2 4/5] mingw: be more informative when ownership check fails
 on FAT32
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The FAT file system has no concept of ACLs. Therefore, it cannot store
any ownership information anyway, and the `GetNamedSecurityInfoW()` call
pretends that everything is owned "by the world".

Let's special-case that scenario and tell the user what's going on.

This addresses https://github.com/git-for-windows/git/issues/3886

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 2c09c5bffee..22f960c7e34 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2674,6 +2674,21 @@ static PSID get_current_user_sid(void)
 	return result;
 }
 
+static int acls_supported(const char *path)
+{
+	size_t offset = offset_1st_component(path);
+	WCHAR wroot[MAX_PATH];
+	DWORD file_system_flags;
+
+	if (offset &&
+	    xutftowcsn(wroot, path, MAX_PATH, offset) > 0 &&
+	    GetVolumeInformationW(wroot, NULL, 0, NULL, NULL,
+				  &file_system_flags, NULL, 0))
+		return !!(file_system_flags & FILE_PERSISTENT_ACLS);
+
+	return 0;
+}
+
 int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 {
 	WCHAR wpath[MAX_PATH];
@@ -2721,7 +2736,15 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 		    IsValidSid(current_user_sid) &&
 		    EqualSid(sid, current_user_sid))
 			result = 1;
-		else if (report) {
+		else if (report &&
+			 IsWellKnownSid(sid, WinWorldSid) &&
+			 !acls_supported(path)) {
+			/*
+			 * On FAT32 volumes, ownership is not actually recorded.
+			 */
+			strbuf_addf(report, "'%s' is on a file system that does"
+				    "not record ownership\n", path);
+		} else if (report) {
 			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
 
 			if (ConvertSidToStringSidA(sid, &str1))
-- 
gitgitgadget

