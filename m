Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C58AC433EF
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 07:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244977AbiCTHRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 03:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244958AbiCTHRb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 03:17:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DA4C3377
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j10so3823549wrb.13
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G+4+NgSz17xKe/Z6JOM/faGH+GUAQCBLgmXyIKbClWc=;
        b=XEt9gBkA/OeuHRU0PcKPbOICCRWV/wpVrBCAMob3AwyaqsR1QuDQBWGu0SxPUoionb
         ehCP7XZrB4cHuN3xoDqv56Hr7pt+SLRA5b7blkU/QuqIG1rTcxU6eEgJbyHO6poeuYCJ
         Wx+0l/dxewTUhae3WgZTeBs51skKolXIRek3iNlUF4UYm5kUyFWn+2P/kUtKsTivQJI0
         94OaaFNrzIcdps7If5LvyBHooVpG4pTrQjNl9n4wMamSC+5sa6N8lOiYtuk70K3Nj+vT
         yS79UoqturrrZWv+ZtuyUq0RIODBxAGUL+/nbZsI+Ke/U2vnQz1TT9cMVTSkI+Lzs6ve
         K4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G+4+NgSz17xKe/Z6JOM/faGH+GUAQCBLgmXyIKbClWc=;
        b=eFEVfW0xf0GCyNJsLTixrBJIOo9aCv5PFvdksPxGN5getQGmys8/lFuZO6p4AXG6kp
         eWryKI4K+t/l6OW9kyS1BOxy5fOR/6AICVgR1c5Zexj8TxVil2o1agAJMcdTMP0cWV1+
         NuH+sUCRFtybwrT6to823cU+UpxqX21caquzercuqlEOM7UmFHdpip2RK/duQRXUO4jK
         YeVygp0wPG6om0JKxmmraWyNUlnomn/NLUtij5YA48EN0cgFSsfAHgDUf9x8GsgT3j1p
         +qqVQTABMfpduS16sEUi0tWITN/nHsr14WhCJKt6e5K+0sCyCeak28WIaC5G75gSMMGx
         O27w==
X-Gm-Message-State: AOAM530varYc71SWxsvFNJEDKi+d0qza0+T8T4zGdhVCOCXZx/HV1Gwz
        nZZp0h5105FXx0ZcgSzM3cYoU1WdY4Q=
X-Google-Smtp-Source: ABdhPJzpGmhoBky/HMGX5ho5M5UG/Mf6H7FPhsa9ADFbbhO4/8jkWiJit5+M+s6X8I4lyHsQVkE1mw==
X-Received: by 2002:a5d:47a8:0:b0:204:72:7051 with SMTP id 8-20020a5d47a8000000b0020400727051mr4905908wrb.451.1647760567236;
        Sun, 20 Mar 2022 00:16:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d6da7000000b00203d9d1875bsm11213302wrs.73.2022.03.20.00.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 00:16:06 -0700 (PDT)
Message-Id: <03bf591742a48d750d6b8e6c54b5a8fd954561a5.1647760561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 07:15:58 +0000
Subject: [PATCH v2 5/7] core.fsync: use batch mode and sync loose objects by
 default on Windows
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

Git for Windows has defaulted to core.fsyncObjectFiles=true since
September 2017. We turn on syncing of loose object files with batch mode
in upstream Git so that we can get broad coverage of the new code
upstream.

We don't actually do fsyncs in the test suite, since GIT_TEST_FSYNC is
set to 0. However, we do exercise all of the surrounding batch mode code
since GIT_TEST_FSYNC merely makes the maybe_fsync wrapper always appear
to succeed.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 cache.h           | 4 ++++
 compat/mingw.h    | 3 +++
 config.c          | 2 +-
 git-compat-util.h | 2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index d1ae51388c9..4d2131e8f4f 100644
--- a/cache.h
+++ b/cache.h
@@ -1031,6 +1031,10 @@ enum fsync_component {
 			      FSYNC_COMPONENT_INDEX | \
 			      FSYNC_COMPONENT_REFERENCE)
 
+#ifndef FSYNC_COMPONENTS_PLATFORM_DEFAULT
+#define FSYNC_COMPONENTS_PLATFORM_DEFAULT FSYNC_COMPONENTS_DEFAULT
+#endif
+
 /*
  * A bitmask indicating which components of the repo should be fsynced.
  */
diff --git a/compat/mingw.h b/compat/mingw.h
index 6074a3d3ced..afe30868c04 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -332,6 +332,9 @@ int mingw_getpagesize(void);
 int win32_fsync_no_flush(int fd);
 #define fsync_no_flush win32_fsync_no_flush
 
+#define FSYNC_COMPONENTS_PLATFORM_DEFAULT (FSYNC_COMPONENTS_DEFAULT | FSYNC_COMPONENT_LOOSE_OBJECT)
+#define FSYNC_METHOD_DEFAULT (FSYNC_METHOD_BATCH)
+
 struct rlimit {
 	unsigned int rlim_cur;
 };
diff --git a/config.c b/config.c
index 0b28f90de8b..c76443dc556 100644
--- a/config.c
+++ b/config.c
@@ -1342,7 +1342,7 @@ static const struct fsync_component_name {
 
 static enum fsync_component parse_fsync_components(const char *var, const char *string)
 {
-	enum fsync_component current = FSYNC_COMPONENTS_DEFAULT;
+	enum fsync_component current = FSYNC_COMPONENTS_PLATFORM_DEFAULT;
 	enum fsync_component positive = 0, negative = 0;
 
 	while (string) {
diff --git a/git-compat-util.h b/git-compat-util.h
index 0892e209a2f..fffe42ce7c1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1257,11 +1257,13 @@ __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
 #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
 
+#ifndef FSYNC_METHOD_DEFAULT
 #ifdef __APPLE__
 #define FSYNC_METHOD_DEFAULT FSYNC_METHOD_WRITEOUT_ONLY
 #else
 #define FSYNC_METHOD_DEFAULT FSYNC_METHOD_FSYNC
 #endif
+#endif
 
 enum fsync_action {
 	FSYNC_WRITEOUT_ONLY,
-- 
gitgitgadget

