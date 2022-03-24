Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E7CC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352002AbiCXQyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351974AbiCXQxj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1FAB0D00
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n35so3089412wms.5
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bIorACD9MvGhf+EOOe9S7KEedrit1duOzRZ5v8bUeZQ=;
        b=HEC5cbAWKa9RNGVpfhiiJLjGxIMeAa+Kz5NwdOkknYX2q2AIwTMgnc/FrdcPtpOefB
         4du1fdu0984yYjgNETH9rTAQ1AeAgiDbI8Q9g8NyytEvx5XekuL7YZsP0AOtHaylj/ws
         j2nIL4ZL80+40RO4doqk1cUgIcwhvnRCIP+CNPNYW3xPWOpAWPpq54TIUTuyngORx7wB
         Ul8Qy8sx7MjyE4qu6l0/Gx6d69V3lyvvpIj2nWGf7B7+VABgNfPrssLgyRPhFMz0hFJG
         rmP5dkIXhQDd+HNYJt8GjTdRRgL+JfKL5mnQYCm5lrEKDBOfSbWvmN7964eAIBZOsqY7
         u9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bIorACD9MvGhf+EOOe9S7KEedrit1duOzRZ5v8bUeZQ=;
        b=7sS2zQfF/XbbK55uW8hjCItiIx6tQU01HtfSOu3HAyHrnKd4/fud1IY4LIu5U7O46o
         l/bFKV5PFqimeuuYSMS4WqQfYvX0cV0/U2O5bA8GiT9JXrt6SIxYok3OXkuT/KU3TbRC
         86Pl1GMzvIgKAub42KDMft6wWAmih6sR2surm/1lGPVJnpoZEi1y4jKnN5d2CKzm++HC
         dDTtSZLSPEVnO19Nwge+oKZieRf8/AVAJaxe2zNy7h4YQv0JokHTqME2bEyBIqYJ3uDA
         oj19m3puC/LIlwSSwyvQzft/FNSIzE/36Hy3t/cvHcoRuvL/eJw+uPvo0FvKYkQSjgrP
         PZCQ==
X-Gm-Message-State: AOAM533BXWBDOu0Gj6gmEuwRKDpKP8/n1ILNboNd1cw3HQjsiF607iK+
        X3P1bOBVGWQ7rNse5pbot6dQdJiTLX4=
X-Google-Smtp-Source: ABdhPJzjWBQAYo29Ls1dDy8mK74McR9uS0wLU5slDKzbTAXj8OLVVyIg9nMi8N/HsrMQQCufVqTEHg==
X-Received: by 2002:a05:600c:1994:b0:38c:48dd:23ba with SMTP id t20-20020a05600c199400b0038c48dd23bamr5522882wmq.206.1648140716112;
        Thu, 24 Mar 2022 09:51:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t4-20020a05600001c400b00203fb5dcf29sm2940605wrx.40.2022.03.24.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:55 -0700 (PDT)
Message-Id: <cef7dbbaf04b5fd2e4ac63888ec46ec0c6db26a6.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:18 +0000
Subject: [PATCH v4 25/27] fsmonitor: on macOS also emit NFC spelling for NFD
 pathname
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Emit NFC or NFC and NFD spellings of pathnames on macOS.

MacOS is Unicode composition insensitive, so NFC and NFD spellings are
treated as aliases and collide.  While the spelling of pathnames in
filesystem events depends upon the underlying filesystem, such as
APFS, HFS+ or FAT32, the OS enforces such collisions regardless of
filesystem.

Teach the daemon to always report the NFC spelling and to report
the NFD spelling when stored in that format on the disk.

This is slightly more general than "core.precomposeUnicode".

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 33 ++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 83d38e8ac6c..823cf63999e 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -155,6 +155,35 @@ static int ef_ignore_xattr(const FSEventStreamEventFlags ef)
 	return ((ef & mask) == kFSEventStreamEventFlagItemXattrMod);
 }
 
+/*
+ * On MacOS we have to adjust for Unicode composition insensitivity
+ * (where NFC and NFD spellings are not respected).  The different
+ * spellings are essentially aliases regardless of how the path is
+ * actually stored on the disk.
+ *
+ * This is related to "core.precomposeUnicode" (which wants to try
+ * to hide NFD completely and treat everything as NFC).  Here, we
+ * don't know what the value the client has (or will have) for this
+ * config setting when they make a query, so assume the worst and
+ * emit both when the OS gives us an NFD path.
+ */
+static void my_add_path(struct fsmonitor_batch *batch, const char *path)
+{
+	char *composed;
+
+	/* add the NFC or NFD path as received from the OS */
+	fsmonitor_batch__add_path(batch, path);
+
+	/* if NFD, also add the corresponding NFC spelling */
+	composed = (char *)precompose_string_if_needed(path);
+	if (!composed || composed == path)
+		return;
+
+	fsmonitor_batch__add_path(batch, composed);
+	free(composed);
+}
+
+
 static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			     void *ctx,
 			     size_t num_of_events,
@@ -305,7 +334,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 
 				if (!batch)
 					batch = fsmonitor_batch__new();
-				fsmonitor_batch__add_path(batch, rel);
+				my_add_path(batch, rel);
 			}
 
 			if (event_flags[k] & kFSEventStreamEventFlagItemIsDir) {
@@ -318,7 +347,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 
 				if (!batch)
 					batch = fsmonitor_batch__new();
-				fsmonitor_batch__add_path(batch, tmp.buf);
+				my_add_path(batch, tmp.buf);
 			}
 
 			break;
-- 
gitgitgadget

