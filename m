Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B47C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiEWUN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiEWUNq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E233A5004
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i82-20020a1c3b55000000b00397391910d5so234052wma.1
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5W2x8t68NoDAVIFeMr0BVtQdXxzEzVw8wanSKIA/+K4=;
        b=f+DpqLqR20G0BPrZcjZtmeYhb5ACbhFO0pfg5+zAh4RI99MHow15TK3jDS99OEtNfA
         qyWtuqQwjQ4GlFvScJqV3Eq53eXqJES7hPK8+RZuMvuWgJUqKDpBA3F/eBxW3XMipL8I
         /fnwX7yMmG+xQJx1TvSCWG/xOTFEYIVd9FfLCOUVPJ4mj1GKoufwVyBmsuKQ3sSUwmgw
         LDQqgea+EiJQ7f/zz5Q0zjQjhQrhykMqeQPuOMJcuaW8rFZ20dEypz5kpzWMumvssixa
         H/YnaV8keaH8yjQ27SVNrjLA8IAhbDm2xMo4AbkNn2lhc7h2HPl8eNqtC+NjenAOA+/u
         J2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5W2x8t68NoDAVIFeMr0BVtQdXxzEzVw8wanSKIA/+K4=;
        b=MPsQA1pGrARz55V8SsXi9rkTK6naC6OIpf9t/vW1P1SFOxKlHiMUFWhx+RKYV08kl6
         2Lmm1Ye3J0NZDN+PR7YuurJbfSbQANiJl5wo549LDzqxRUNK/ANvT/xAqmYw27a77SnF
         RrhMnp488Xk9sdb/EzmTFLclzYCGk4h+wAYBIJ/PGCMupE4E/nEN2tYon9T44j+83CKF
         qsLXoHj+96vuVwkoBRiz7b9iDfu3tIqqtPV1Mw4OMYrOzhE441nClWdd+OS4Z21iCeFS
         lADIzhhiGUmHVq1E67KaUR1N7W+Ffq1/y/pggL5iwcXas9wPqwFY7Kr004/R7DK+Y6ij
         hNpA==
X-Gm-Message-State: AOAM5328SvVkJcowGxjFTExe7xdvQfDL1H6ivn+uT1sa0qwc5brx8dEQ
        +WZAqD6JcqIfKjn0yK5fwddc7OwAWaU=
X-Google-Smtp-Source: ABdhPJxUE0eJ+VvQ1P9FigDTgYQA/1nucdWfPDWgdRPoJqOaDRSZZy6l78rJP7DSrrJcM0gb2Tqrgg==
X-Received: by 2002:a05:600c:26d2:b0:397:49cd:2cda with SMTP id 18-20020a05600c26d200b0039749cd2cdamr621480wmv.141.1653336784563;
        Mon, 23 May 2022 13:13:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c358200b003974ba5cacdsm180770wmq.35.2022.05.23.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:04 -0700 (PDT)
Message-Id: <4f2b15d3d1f10eaec8e485b84281eb4cca207a69.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:27 +0000
Subject: [PATCH v7 12/30] fsm-listen-darwin: ignore FSEvents caused by xattr
 changes on macOS
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

Ignore FSEvents resulting from `xattr` changes.  Git does not care about
xattr's or changes to xattr's, so don't waste time collecting these
events in the daemon nor transmitting them to clients.

Various security tools add xattrs to files and/or directories, such as
to mark them as having been downloaded.  We should ignore these events
since it doesn't affect the content of the file/directory or the normal
meta-data that Git cares about.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 34 +++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 0741fe834c3..14105f45c18 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -100,7 +100,7 @@ static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
 	if (flag & kFSEventStreamEventFlagItemCloned)
 		strbuf_addstr(&msg, "ItemCloned|");
 
-	trace_printf_key(&trace_fsmonitor, "fsevent: '%s', flags=%u %s",
+	trace_printf_key(&trace_fsmonitor, "fsevent: '%s', flags=0x%x %s",
 			 path, flag, msg.buf);
 
 	strbuf_release(&msg);
@@ -125,6 +125,31 @@ static int ef_is_dropped(const FSEventStreamEventFlags ef)
 		ef & kFSEventStreamEventFlagUserDropped);
 }
 
+/*
+ * If an `xattr` change is the only reason we received this event,
+ * then silently ignore it.  Git doesn't care about xattr's.  We
+ * have to be careful here because the kernel can combine multiple
+ * events for a single path.  And because events always have certain
+ * bits set, such as `ItemIsFile` or `ItemIsDir`.
+ *
+ * Return 1 if we should ignore it.
+ */
+static int ef_ignore_xattr(const FSEventStreamEventFlags ef)
+{
+	static const FSEventStreamEventFlags mask =
+		kFSEventStreamEventFlagItemChangeOwner |
+		kFSEventStreamEventFlagItemCreated |
+		kFSEventStreamEventFlagItemFinderInfoMod |
+		kFSEventStreamEventFlagItemInodeMetaMod |
+		kFSEventStreamEventFlagItemModified |
+		kFSEventStreamEventFlagItemRemoved |
+		kFSEventStreamEventFlagItemRenamed |
+		kFSEventStreamEventFlagItemXattrMod |
+		kFSEventStreamEventFlagItemCloned;
+
+	return ((ef & mask) == kFSEventStreamEventFlagItemXattrMod);
+}
+
 static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			     void *ctx,
 			     size_t num_of_events,
@@ -190,6 +215,13 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			continue;
 		}
 
+		if (ef_ignore_xattr(event_flags[k])) {
+			trace_printf_key(&trace_fsmonitor,
+					 "ignore-xattr: '%s', flags=0x%x",
+					 path_k, event_flags[k]);
+			continue;
+		}
+
 		switch (fsmonitor_classify_path_absolute(state, path_k)) {
 
 		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
-- 
gitgitgadget

