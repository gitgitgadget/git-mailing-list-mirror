Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE997C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 00:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiC2Aol (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiC2Ao0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 20:44:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676A5239328
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i131-20020a1c3b89000000b0038ce25c870dso443387wma.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hg8plsugjefXxhMhSvzABM0c1aAu2C8TxytBC4+PwWI=;
        b=juBjBpLO1JtzKl86rik87aq2iGyOFk6fj4imeYiODfjvvqlqzULkMyk4qq+pTX8d9L
         06YmckYxGXrOeIChq7OJsOFGeGXMmmfDY0kHUVmOYJfO+WAf5La2h5nGd9eVr91oLL3D
         yUiBc436v8Dp5+RuzC32teb/CIDFIca2kxwd6eHr3gSZC1I2SnZPLm5MUUtA6ihx6Nk6
         4ctxDw72BSzBRIER+8t1n5+72Y2wkq0PSaKw3r803tutCJKQ2hh8nDsVH8UMm+dcNn7D
         RKtHKmw9+4lM3/wHuRr/J3a4aEcN2L1A0irgZyWsqGlrhIraV6Ru2fhynkSoEzMqUSco
         pF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hg8plsugjefXxhMhSvzABM0c1aAu2C8TxytBC4+PwWI=;
        b=x0tR4y1I4ikKkUj3VmTbyvFmnWaaXKmW7eVKfdsfj03JKhaTJHwOfktLa1ykUK3zpR
         5oenZLyfKElMJ+EE6aGXT3fYJn1DoXuBVJqvQXFi4hPQ3z4r1M17cE3n07Hg2aoIV9Jt
         olM4atzz3RIfu4/iirGD26KYP+jTqImn6XPz3Zig4m1u5pLZ8rGcnSsMxbD2AElf6SFP
         iboza3R49EWaY6rWRH+4Oi36IEQIGqlYcopsUxMIShk8bxya0n4uF2mX/04gxTAKIa2v
         GyJTj0CAeipbUfvvgiVL1pVYlDfeOAxraHTtfaIsY0rXCJvepRvIlvoa+sRokFbhX30i
         ANKw==
X-Gm-Message-State: AOAM532d8Sbe2x/vB76nEAh6pzetVdlp0anUZ13QE/SH6Op/pLiEjyYz
        g54/tv3ZcDN0XdJCtHSgwneSOySpUOA=
X-Google-Smtp-Source: ABdhPJxymHUknA7NTNT+g9QXt9tLwXcx7mPNjqLFRcWHzpEWFUsI2HZ5tXIt3gEXAy+X2iMRUyZarQ==
X-Received: by 2002:a7b:c30d:0:b0:381:4bb9:eede with SMTP id k13-20020a7bc30d000000b003814bb9eedemr2741631wmj.74.1648514561711;
        Mon, 28 Mar 2022 17:42:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d4a85000000b00205a8bb9c0dsm12811176wrq.90.2022.03.28.17.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:42:41 -0700 (PDT)
Message-Id: <73e54f94c204759b0cf77e7b75501adb43b14994.1648514553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 00:42:25 +0000
Subject: [PATCH v4 08/13] core.fsync: use batch mode and sync loose objects by
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

