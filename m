Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B263C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349309AbiEZVtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349219AbiEZVtd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEB6E8BA3
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z15so3626172wrg.11
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5W2x8t68NoDAVIFeMr0BVtQdXxzEzVw8wanSKIA/+K4=;
        b=NlhGfGgBt+Zsx4tDDvjFoCxY1tFzoQ8eTMFgtdYKngFdmSg/HmSpH69Do44i/IlflV
         4v4kl4KV9nPqqkbIUmb5AfBLghTcqZEpZ/issU1akUIfDpHjF6/isWLau9UXbKQ3e5nU
         Fwvjf4wCXez4hRtjIXIXEBNFqcwf3oF3GUMLzDu4vANgP7hbkVzaBkx0ri2AHr+lz1kd
         emPHNrvHImpGpbK5D6E8nzjklbz5Ko8IFMU5V29bvg4ANMOyBfwE5TMkVmYgmAHKYSzt
         HMH2VmI5NCqny4kVocAzxAhvxu0+m/B+DAN4hsVvJRDv76tyvjQbI/+x92MbqhcFcDBB
         hCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5W2x8t68NoDAVIFeMr0BVtQdXxzEzVw8wanSKIA/+K4=;
        b=TU26MmmsKmg5rSshYzf356FAyskv4mOQp3PfA/j6E2DcHNjJoiwSEd4+6whnQm0Oh4
         MpHdxJQ73KERS9dUPQ814JFm8+wfjkms4Up8OvMIu+ASWDmg9NHlMa5PY3pEzGptIQ3H
         8w3GBDviiVC7EbdS4GsPj+1eJyf5SXLFFcJdrpVrkm2cIBOg/IbMqMHbIoSDet/fNTQk
         CLrvJMKuQFPJ+sS+dkyJouDf23lGrP204hFr70yGu1DTMNVtCYXremCh3QnQ7Da8HazA
         x5dD3IeiG0RWzoT2E6A6tgBA5/DciUeLU2RrR55w4nMpS6WnlwVwxWy8l6jIp4EbE4Gr
         U8SA==
X-Gm-Message-State: AOAM5308u5icHM0ujOXLcIm5DS6rg6fc46rCrdo76O8JHdbGbPHo17/M
        lc52Dh/giDUzmqlT0pXp25UQxkXZAuU=
X-Google-Smtp-Source: ABdhPJyyzB33LlYkFQ6BeRxYYEP/bILQiBp0Lo+rKhpnktwjfzVOt+9aO9cEvZEZtqNiCt/V3/1vog==
X-Received: by 2002:a5d:6d0b:0:b0:20d:681:d301 with SMTP id e11-20020a5d6d0b000000b0020d0681d301mr32548338wrq.364.1653601757570;
        Thu, 26 May 2022 14:49:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 128-20020a1c1986000000b003972c672859sm304053wmz.21.2022.05.26.14.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:17 -0700 (PDT)
Message-Id: <ad8f65efe0d773fa2f14423276a8aaef778df993.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:06 +0000
Subject: [PATCH v9 12/30] fsm-listen-darwin: ignore FSEvents caused by xattr
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

