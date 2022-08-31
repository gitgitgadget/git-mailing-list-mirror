Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD21ECAAD3
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiHaQJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiHaQJO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:09:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED14AFAC7
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:09:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m16so18883022wru.9
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=LpOHQYd/OqaxsJSFz0fEed2hnZFuxw4EuQJ1lFaj3ag=;
        b=d8lgbWuBA8M2AbIGhPaKbDhij4VyDk6xsDL7N72m/37Fl2R4tps7J/k1ztWcQyrR3V
         8mCTVBplyYOP4w4ghsBKm1hBm+gD71fo81dzZij867iAfrOwMTBjV1UbCgxAiOO1e3Oz
         NLGjUAXNwRoXhrZoFpix5YSjF7UkH4PTVWp+1Vd9Z5blZ6zEPRRuZsrsxBcT/VKM4V+0
         i8SAEuhvvBAjD4/bIC6iH1qNBgjUuJpp38oM+gK/hd+9Zw7iPqrk4OmkO6SIfHxxc/tS
         LTBSIKwpe07Pek+vzP+IV40DWNnmFy4AAPcpH+Ac7uLDMQYGMBvlMLQu5NkOtFWq3MJ+
         dmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=LpOHQYd/OqaxsJSFz0fEed2hnZFuxw4EuQJ1lFaj3ag=;
        b=CMQaZ2OBisE58DychwCbKcd6UBn+FoTRrybZGZtpl76zV2SYBXvDzNunkKeKEIJ+0w
         f9HRFPUA9K2mv5j4WcmubzMW4ZbRXuzJ1HUzWKoNnRbGxMalrebojGn/RI0pUIJc9kIo
         KV36tRetsHvPffWtghwDpMiq5Xppq5cFKUfnUXtch3T9mYW9ec3KYZ0iXYOrkBbsmbYD
         DD9aUppKhpqSkxykhhy6Rjblo0aa7EFmC23bjSohXCiBS3rrP0gpS6aMtkuurZFBqgwC
         NFzQuc0OafafzYku3vq53/XSMPA7XmcrY1lrziCJRqS5xh3W+07oco8fbqotXjPHZQPz
         nypA==
X-Gm-Message-State: ACgBeo3QAT332ObNeLgtKnboo376gYuHphBV79/doXnDNJ/1g3s721Wi
        3awq9NBE23y49Ut31EsPjXeSCbWBjic=
X-Google-Smtp-Source: AA6agR7fofupf6IWxYiKBBgjo0ngxX74BunpDqp87CuY6H6Dad3xGia/uBFFqJEE2RhpdS80X9TcAg==
X-Received: by 2002:a5d:46d0:0:b0:226:d133:3a4a with SMTP id g16-20020a5d46d0000000b00226d1333a4amr11714330wrs.400.1661962150758;
        Wed, 31 Aug 2022 09:09:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b0021e8d205705sm12077965wru.51.2022.08.31.09.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:09:09 -0700 (PDT)
Message-Id: <2cb026a631704b004b06e4a944c79a434df08440.1661962145.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
        <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 16:09:02 +0000
Subject: [PATCH v4 2/4] fsmonitor: generate unique Unix socket file name in
 the desired location
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Based on the values of fsmonitor.allowRemote and fsmonitor.socketDir
locate the Unix domain socket file in the desired location (either
the .git directory, $HOME, or fsmonitor.socketDir). If the location
is other than the .git directory, generate a unique file name based
on the SHA1 has of the path to the .git directory.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 fsmonitor-ipc.c | 40 +++++++++++++++++++++++++++++++++++++---
 fsmonitor-ipc.h |  6 ++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 789e7397baa..1e3f0a6cf48 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -1,7 +1,6 @@
 #include "cache.h"
-#include "fsmonitor.h"
-#include "simple-ipc.h"
 #include "fsmonitor-ipc.h"
+#include "fsmonitor-settings.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "trace2.h"
@@ -47,7 +46,42 @@ int fsmonitor_ipc__is_supported(void)
 	return 1;
 }
 
-GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
+GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
+
+const char *fsmonitor_ipc__get_path(void)
+{
+#ifdef WIN32
+	return fsmonitor_ipc__get_default_path();
+#else
+	char *retval;
+	SHA_CTX sha1ctx;
+	const char *git_dir;
+	const char *sock_dir;
+	struct strbuf ipc_file = STRBUF_INIT;
+	unsigned char hash[SHA_DIGEST_LENGTH];
+
+	if (fsm_settings__get_allow_remote(the_repository) < 1)
+		return fsmonitor_ipc__get_default_path();
+
+	git_dir = get_git_dir();
+	sock_dir = fsm_settings__get_socket_dir(the_repository);
+
+	SHA1_Init(&sha1ctx);
+	SHA1_Update(&sha1ctx, git_dir, strlen(git_dir));
+	SHA1_Final(hash, &sha1ctx);
+
+	if (sock_dir && *sock_dir)
+		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
+					sock_dir, hash_to_hex(hash));
+	else
+		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
+	retval = interpolate_path(ipc_file.buf, 1);
+	if (!retval)
+		die(_("Invalid path: %s"), ipc_file.buf);
+	strbuf_release(&ipc_file);
+	return retval;
+#endif
+}
 
 enum ipc_active_state fsmonitor_ipc__get_state(void)
 {
diff --git a/fsmonitor-ipc.h b/fsmonitor-ipc.h
index b6a7067c3af..4d27223c2a6 100644
--- a/fsmonitor-ipc.h
+++ b/fsmonitor-ipc.h
@@ -18,6 +18,12 @@ int fsmonitor_ipc__is_supported(void);
  */
 const char *fsmonitor_ipc__get_path(void);
 
+/*
+ * Returns the pathname to the default IPC named pipe or Unix domain
+ * socket.
+ */
+const char *fsmonitor_ipc__get_default_path(void);
+
 /*
  * Try to determine whether there is a `git-fsmonitor--daemon` process
  * listening on the IPC pipe/socket.
-- 
gitgitgadget

