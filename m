Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B5AC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349342AbiEZVuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349290AbiEZVtg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703ABDFF57
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s28so3642357wrb.7
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bIorACD9MvGhf+EOOe9S7KEedrit1duOzRZ5v8bUeZQ=;
        b=lCpbkynuG9Q5qAELZWqCwyhMXZErKAvWRIOpfz9TeELwBuUlkVdranOCm85gVxwycU
         ctakQT0q8WtkFbv3kNQrEOkzRYNDotgIK9v7tjMitgAoxROUFzt1j2yadqpWRv3BXeNx
         SBVXfOhDCYhjajF3hw5IUn1awI6oO08Lzj60Rr5bdTvcwdWHewrfwghoMPJvcuzNHisQ
         3VEprIdYZfhSpNKG4/SPzoXDt3suIjX8fmV29KEndXEtRe5RTB3b1tKTI+py/80RXDG6
         VsFE58C342c93kvR886wYE3CA7AeOMw9dNHKgwB7fvCjCQEAQdWxR5PcfcOw2Tu3Iacg
         +MEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bIorACD9MvGhf+EOOe9S7KEedrit1duOzRZ5v8bUeZQ=;
        b=8BYZw8Il5kcfksq4NkSdOVNbIBDMWlc4HXuYQzopIbyWEHp0Hkf/hmydNyrgIKKHtF
         tbFQTIq2kglhYRzalVW5+c8UbSRTCXIhD52T2KDK8XBAWMpz0e6uSFE5H0p/xFgu4ygA
         21ZWtTVSV4bRzWIQuqdM3qeavKQjyZc/s/gakY4aomMTl0E8/Dq+15heJM7yKhAHpglX
         zfxXOPtB4lGHwPKuAmqLhCZAE4zNGnyXE2c+GO5TSVcOzmGrYnCp7IhpsKfUME/bi7Pi
         xYxCy19liC865BOwlf+rBhVYLvP2iOHXNxM8V6aU7JwX8zQ+nt/Okas4LDNo68JjMBGn
         EiPA==
X-Gm-Message-State: AOAM531SRpdpaGPndVaaaan1lkZ4BDUSmg1BoqfpnQtFpgKGxyD/4q/A
        +UdJHY+kWY9ElBjdMwElpzhmWni+75o=
X-Google-Smtp-Source: ABdhPJyD3VqMHX8XoUwHT7k7SsNH2OAZYOtrq+NzmE9DVJ+3qmkeG/8kW0SL3bna5f2n2xUZ/Ya2Pw==
X-Received: by 2002:a5d:6d8c:0:b0:20e:72ce:c9d9 with SMTP id l12-20020a5d6d8c000000b0020e72cec9d9mr28812603wrs.598.1653601771728;
        Thu, 26 May 2022 14:49:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe101000000b0020d110bc39esm213927wrz.64.2022.05.26.14.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:31 -0700 (PDT)
Message-Id: <c8c4c22360c306a0e94c7c6684f439a71bef0709.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:19 +0000
Subject: [PATCH v9 25/30] fsmonitor: on macOS also emit NFC spelling for NFD
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

