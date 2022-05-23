Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114BCC433FE
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiEWUPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiEWUNv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0481DAE273
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bd25-20020a05600c1f1900b0039485220e16so476088wmb.0
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bIorACD9MvGhf+EOOe9S7KEedrit1duOzRZ5v8bUeZQ=;
        b=jse6dc2WseK25TouwD8ZVpf5121LXFodXezunKzz8B/nh9gDf1hEPjNWd08u8BMPJE
         Tf0mYhtWhgRa/6NaPV0iRMAFdThBzi4+r9YYdQLeuysiiW8L5vJaJMq/nwF/eDpHYvGX
         KFQ3uWdSiQiF47xgsuMbaT+9lcn+xQNTafHUE3g0YKVXPT5tYyfpLcLzpR8JjsmXA5Ga
         AcP/v+97VdZHrN4cgH24vkAP2QOKsaaK8KsYL5L3WOfotP3prtGqrUDqDsWwBmZCKOnF
         xefsIFggXfy4eteGVUPDy540XDBaEvZ2DekWk52tFNwJNsmaBvWmlzEdSbmGSfHe0etQ
         VGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bIorACD9MvGhf+EOOe9S7KEedrit1duOzRZ5v8bUeZQ=;
        b=xMjqAymESfdaQhTi3+zDeZpk25yzV/rT9rmgFpMFSZllC4D4vsxUy92TDy3tet/Eos
         uj6NAE4Yxvhm8nWoDrCzbEnDccW/XjsQ8xNm7Ah2VsqUXnkqtZZdqcV3QvwCkNd1P4i/
         Vm9PUKhR1NKQJ8lZlMdEI5Ppb62SNJyiWZRePdixOX1adbzMv/tPCOO89QD2Dd4LxALh
         EcUNaB6FjRaei1sWAmmvB6mscQyPIfPV2CSkcW75cfmLpJL34WlbUpfuC2KQSu29YvcQ
         6WLSl8YHejZmHQ4yRt/6goKH9OfvEnxawTYLHDqUIonv7MsLRQOMnvE28cJiyK55klaX
         eTOw==
X-Gm-Message-State: AOAM5314pjqUg8PGgDI9a8OTnE9aq8Q7aGSrP5Yb1iz6SRladtDWemdn
        rovTn1VLepR6GNBKGmPkBi6ybq6833o=
X-Google-Smtp-Source: ABdhPJzSSK8/B+jutEpYTGb7ru6Nnf83aWpNUJMbJEi1TnalbAhc5qh9jbzgWojzKHy/DfSYk+YapA==
X-Received: by 2002:a05:600c:35ce:b0:394:8621:a1e7 with SMTP id r14-20020a05600c35ce00b003948621a1e7mr614147wmq.127.1653336799719;
        Mon, 23 May 2022 13:13:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg21-20020a05600c3c9500b003974d9d088fsm197523wmb.30.2022.05.23.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:19 -0700 (PDT)
Message-Id: <b93f0642699dcacd23334803dce023229a4228a5.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:40 +0000
Subject: [PATCH v7 25/30] fsmonitor: on macOS also emit NFC spelling for NFD
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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

