Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1A3C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 05:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbiC3FHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242746AbiC3FHp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 01:07:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFB96622D
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so27568858wru.4
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hg8plsugjefXxhMhSvzABM0c1aAu2C8TxytBC4+PwWI=;
        b=QizEu2+HroFKYp+23Jz5+0r/DIb/JSLKxwAgToyHL1YJcRuOwexmVweZrUqIEsa3aX
         I4Ou1CXWxLIZ44/73/idzKMjnzQo3jjKorOHThCfVpJlsBC0tTwv1W6VnDv/cfqY+3q2
         ELUgxtkksHjtNShpza7kjqtcwKVIBJHqXFQzDiVsBVzYgJde5VI5Q08aL4UnSTCbXOih
         qBefJY+qFwLSgK4L9Eh74lrwkK8yCKZQtGaXwwaZv1yPZiX3l7/2Jx8rXGv5Opdo+Jg+
         3OWGjFyQXro7lJDbxYe+AgRLhUjrCJ6KaoOL2kZIal7hdCo8mnD3Y058bLJT5i3JSH4O
         Qy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hg8plsugjefXxhMhSvzABM0c1aAu2C8TxytBC4+PwWI=;
        b=AjUwKEoAQ2k4Sw+Ec/IaJbA+O1/VAWjVbS8iFPTKf/jfRyQM7ftgU7KgCPudn1hxl2
         nkO4jyvzH6Jg1w37kp13j9/wAyzJwTl5smwZ+M2F276hNGJe4tAjASnWruFnvidbt24P
         EhEwJOPp3YM4/EF3nnlth3lmnoyVN/OwyHd1gLwp1OaHJHrVrZpK1wXpH+JTuX3Lw4n6
         BRr8EKV+BwITnqrJa++uZWIfm4idXDYwVKiOP7xikaDWrv32Yqg+1lXm7HJVpglbzmI+
         ql7V9X551Aww/nOa30St5udw3Q1gW3HV5Rv5PUwo5VSzFXeVhRtOZ0V6nzAJjJ3fZZrC
         uaow==
X-Gm-Message-State: AOAM532V8kMrCm1se7HbtySwo/O81XYf7COPzoD13RF8djYy3rpaJpCt
        cCiKyx9aFU6Fd2uU72Ji2KJPlH1hOLE=
X-Google-Smtp-Source: ABdhPJxGPGp28QmmEhC3/p8Iw7UoNzjvM0UA3pTFfd7HtZIPmY1lWWVw1MbMygjeSt5OEmGaESi/Ng==
X-Received: by 2002:adf:da50:0:b0:204:7d8:b654 with SMTP id r16-20020adfda50000000b0020407d8b654mr35044691wrl.607.1648616744824;
        Tue, 29 Mar 2022 22:05:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5-20020a1c4b05000000b0038cbf571334sm3578152wma.18.2022.03.29.22.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:05:44 -0700 (PDT)
Message-Id: <faacc19aab2ecde1eb4134d1514b65a1f8ea6791.1648616734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 05:05:27 +0000
Subject: [PATCH v5 09/14] core.fsync: use batch mode and sync loose objects by
 default on Windows
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

Git for Windows has defaulted to core.fsyncObjectFiles=true since
September 2017. We turn on syncing of loose object files with batch mode
in upstream Git so that we can get broad coverage of the new code
upstream.

We don't actually do fsyncs in the most of the test suite, since
GIT_TEST_FSYNC is set to 0. However, we do exercise all of the
surrounding batch mode code since GIT_TEST_FSYNC merely makes the
maybe_fsync wrapper always appear to succeed.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 cache.h           | 4 ++++
 compat/mingw.h    | 3 +++
 config.c          | 2 +-
 git-compat-util.h | 2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index a5bf15a5131..7f6cbb254b4 100644
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
index 511f4584eeb..e9cac5f4707 100644
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

