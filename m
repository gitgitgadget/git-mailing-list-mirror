Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A41C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350684AbiCHWRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350647AbiCHWQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:57 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4D3574A3
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:43 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u10so234043wra.9
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MqGV7+a23hsjgWwJRoNvuI9BBxP97TPrXX3hxK6Gjec=;
        b=Kk7YOmdyh2PQA09KJleubyH3nMfPqHIOUCn3ZlqB0QQsxI6EsfBAYgo0qjG9vuZR8E
         BHFfUXU2FEYqIhBIeCttdDtVNiqm55fKQ9DvJqCGVnn2EUmJCXO9G9hiezU+44Xkkq6l
         EqCfLEeCT+Hcu2Mbt/MvUN9xjBQObehzKdR6bzBZVytqbnyAjvnEkpferkA0F0qlp/PT
         3aXpk1V0GTrYF+EuSO/ndb2Ay2Rl23HsAlnpJGjdjHNO60HiCWQPOmtlRYpQIi1CFWgU
         IOEZ4ojbSafQU/RBeAMqHuhCoV8IM48P22+eZYSm9AuPQZdyZ+1F3CcKE2euLJ1mG/zM
         2UZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MqGV7+a23hsjgWwJRoNvuI9BBxP97TPrXX3hxK6Gjec=;
        b=FSa4LR/Q8lmBimZEHdZxmUr5D09ec/STFa5wn6jIncODtraLCecZiyNAxEKQ3ooKbY
         8xM3tsUp+PACRLZepuaWwlikAek+sDy80uqaD+agucvut6CuklDwuJBjnAzJ2/BdwFWa
         aIwLJoQcnUkXQ9mBYm2sw9zp7oHJTpitAfNq5eoIQRtPvS36L6OHXpzYbT/waEJIoCzN
         mjweWeiF6sLrO4Uew642GeQTRuf/lba66Kvtk1e+WVg6VpBnv5M+zyS0QQqxCOMl/wQg
         70kWhRsoSuwo1BjKjFjeLkbPmLeJROFR0i+Wxg1qx4+3tp63hyiQlOW1DtsNET73Az+B
         SbqA==
X-Gm-Message-State: AOAM533btTjQgHNeYWLZLWCRWft0alid7BqI4lXlXpcks6MuU0fpwj6p
        KDv+11Tavm1aRsi2O+ppsfnI3LrpZ8c=
X-Google-Smtp-Source: ABdhPJwvC7WGyYGETV5aGsupJw3+3dRUoUsSpq9q54U0AMWQA8o0h3N8ZD69CyOCcnmq8yNoNNF7aA==
X-Received: by 2002:a5d:4dc4:0:b0:1ef:7aa9:5a8e with SMTP id f4-20020a5d4dc4000000b001ef7aa95a8emr13770221wru.168.1646777741694;
        Tue, 08 Mar 2022 14:15:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7-20020a1cf607000000b00389a5390180sm65009wmc.25.2022.03.08.14.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:41 -0800 (PST)
Message-Id: <fe305f5f287de09f01faa1c9e738d231cc7a62c9.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:11 +0000
Subject: [PATCH v2 11/27] fsm-listen-darwin: ignore FSEvents caused by xattr
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
index 5c5de1ae702..f9b61b7b1c0 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -172,7 +172,7 @@ static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
 	if (flag & kFSEventStreamEventFlagItemCloned)
 		strbuf_addstr(&msg, "ItemCloned|");
 
-	trace_printf_key(&trace_fsmonitor, "fsevent: '%s', flags=%u %s",
+	trace_printf_key(&trace_fsmonitor, "fsevent: '%s', flags=0x%x %s",
 			 path, flag, msg.buf);
 
 	strbuf_release(&msg);
@@ -197,6 +197,31 @@ static int ef_is_dropped(const FSEventStreamEventFlags ef)
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
@@ -262,6 +287,13 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
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

