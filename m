Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D730C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiDVWik (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiDVWiF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:05 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6F01F9E0A
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:10 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso8775162wml.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5W2x8t68NoDAVIFeMr0BVtQdXxzEzVw8wanSKIA/+K4=;
        b=XeEfAa4Zuyq5j4G+lUAMgPUdzUY0H2GZvZYuivfVnlVbuggnpAxEhEOvJlsAUVqeKN
         iJ403QKFJK0vpBsr6h/2PZg2qzhKmnIrwsdONzm7k1h5XrzPetVISOIM40UwbS/1FIcC
         crfHWqAqf6qmDAppTeZMDeWwpZ1hRGycKM3cE9okUl/Us3rDbBfh7PoROPrvYuJVE1j7
         z8x6mW9DIip13bXxgKKaAqzH/W2XyfmmuR/EZB4FXQEd+2t1RphyOXH7hXlpVv+MDxPY
         EOoFyww04M5+q5/BBA7JSjlAyaxDLFV3xSsJ4f5sYo4gtA0XgW+l3OulCjDe6Z3OAvj9
         GieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5W2x8t68NoDAVIFeMr0BVtQdXxzEzVw8wanSKIA/+K4=;
        b=cNefq6WjodIEFGCus0KkSNbqC1t60wmeKGWtIUav3bvJbYgNG0FkhM5YIEHI1+z409
         REjDX56XKOY2OKKfe37x7FUqd6i7gVmjk7tU4MEGr3VGwdymXLRO7sKbt3RhQYIGJqOo
         KO/Hdzug10rNLPhad9bUUt0tZgUDFXk+Jpgd9xVJ/LdkuWoTn+uYzA4JXNurbi+aEZ/O
         Nq36hyU7GltYEWStYao5ENHd1T+45qt5b0jMZ7FW7+suJPoxDYYz8LRvtgTzIJS6uSOO
         PIRBXRXg1woXTpKFN3AoJ9Zv9YBhHlJSU2z/LoinOdAwdIEfnnA0Nvkk1a/NQL6lnMDn
         z21A==
X-Gm-Message-State: AOAM532xFL1ImT/DKUzWaE5C0Lee5v0BVBS8V11GTaP6+a4mLgzU5S/N
        qhAB3CA+Okfed+e8OQjU0fnDUGfIg0U=
X-Google-Smtp-Source: ABdhPJxllx/7SnJ8WJkplu+gzttdW1AYFxZKbi7bXwy/uCuZl/PXKClTFdlfmSberlxXaXZHsrmGVA==
X-Received: by 2002:a7b:cbc2:0:b0:388:faec:2036 with SMTP id n2-20020a7bcbc2000000b00388faec2036mr5886978wmi.190.1650663008761;
        Fri, 22 Apr 2022 14:30:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q16-20020a1ce910000000b0038eabd31749sm2986741wmc.32.2022.04.22.14.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:08 -0700 (PDT)
Message-Id: <f4feb00ec2b9d6f80e5b57275eb8e141f013e253.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:38 +0000
Subject: [PATCH v6 12/28] fsm-listen-darwin: ignore FSEvents caused by xattr
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

