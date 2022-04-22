Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD89C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiDVWji (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbiDVWiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DB72C3357
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w4so12716621wrg.12
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bIorACD9MvGhf+EOOe9S7KEedrit1duOzRZ5v8bUeZQ=;
        b=aL6ZAfAaTXgv64o2kNKOT/OGG2kb20CXTqJEAivJ46XHyjY1Q+ZEhIXaxOxRO7yucR
         LyInli56voROWB1YZP4wBp/ssHOb/MBBLFwgoBuagETb0P8ioCgdUKI/d7sb+9BMfYff
         jp1IClQvd75JH+OOOfsvw8IT1yOgwTcoVEWga+nIAyzJtE7V+d6M2RG7zFgoNS1/uEFi
         u3fbpo+2fG/ZiZnW8au+KGnJryt40/UJVopeh207fDBLaMFHSfKG157NWdAYzuofX+hh
         4E63+utxE/6pVschqExiBN2OibZIPd1n74U3XOjhT99YK11KE7rsmgdfQIRI55+v7tv/
         gGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bIorACD9MvGhf+EOOe9S7KEedrit1duOzRZ5v8bUeZQ=;
        b=hs1WkwjqKNf1lR2fA46z7xC7CDYHYtIvbdkurgJ+ItWxF7AMoQ1a2502BpF4/VOW1s
         /xVTWRvvpRxEoEI834Fvv/VQen5+XtTXohoqtYpMjHFz7oVPSGoAwis5uyN+D93U+49k
         2R1VijAgJSXTnqAevQkVCE5YKjYHVqIux6Rch6Nv6CubXJ+BdF5McFkbZ8jmLll+uFxq
         29ynnPJV5L6VwljMeoVfQcmBDJ5Kge+rJNE0+VN7lBZ6vlQUmyCcFmT59bhnbJ1rujLy
         5w4l7DC1x+wkNTalxtbc0RL5KF4QPhu0Urvd9Pl1ybl6TbzX30hYK1S+VNrpDMpDkdyx
         IhGQ==
X-Gm-Message-State: AOAM531SAJEoHOQd83/gSHR4hp8cGg4m4To4QRb1cJ+d2IFSomF7a7P3
        yN/KzzbECah6Dwhgs0UTaucGZtrPlnU=
X-Google-Smtp-Source: ABdhPJw1ZYOf/1crC9T5iP+7eynC6OLqzSCW1yDTQZwf1bJEbPJ9CMFyhYy44iDbzx5Lbr02lhYLVw==
X-Received: by 2002:a05:6000:156c:b0:20a:8397:6d28 with SMTP id 12-20020a056000156c00b0020a83976d28mr5101460wrz.363.1650663022881;
        Fri, 22 Apr 2022 14:30:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 7-20020a056000156700b0020aa549d399sm3429350wrz.11.2022.04.22.14.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:22 -0700 (PDT)
Message-Id: <cd7c55b0d389932535ab1a6843bfba0a0440cda5.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:51 +0000
Subject: [PATCH v6 25/28] fsmonitor: on macOS also emit NFC spelling for NFD
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

