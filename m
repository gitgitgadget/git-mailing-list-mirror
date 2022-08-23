Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9255AC3F6B0
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 16:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244719AbiHWQcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244225AbiHWQb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 12:31:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93261FE352
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 06:03:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s23so7165619wmj.4
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 06:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=fon4TV/aWInSnIdeE9yS/MSfxyJMThj9u67iYXJxQS0=;
        b=ItmXgfPoKYC0fLdFtM2X/ifpG20S9P5J21a8ebxHAke0aIlaU70rDfeiDF4PKoJ7U1
         ZuJ70TsD0ao7aL6KGX4d6eCVC1nTXaxZAjzFVCAH7VdRafESg8uwoV2WOrRMtqmiVjpD
         J9DIQYGCvq/7K86CJT8xYoiI40+bBaA+7xJh9+nurDKO0E0YUuNK5m5xKznzXj1z0GZ1
         akQ1eWf/8Q6PDegt6BjOAXS4slq27nOExm9xWgTPAJJokQIUU7T0qIyF7H+AAZ79onVx
         KJHCb/4HA6GTHH4M9IhE0BBjkbtp4eX0nMWAqGrr9pYX7/v8kpoLfKbrVQs/Zdt1xq5O
         JRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=fon4TV/aWInSnIdeE9yS/MSfxyJMThj9u67iYXJxQS0=;
        b=4z4P7vC1ra8tWqDbZjSCCDso5ALGJ55t7sUEhxz/JcnKpL5uhvXrBT3HCUSnCEI0YL
         SHWN4mdkIJqAXvrsOIDu8KP/Rr1bY8C2fipzNibCAn7Zb2zZdSNyD7fYqlzSwUr/+vGP
         8VEYGvIiLC1eqCNDbTw8ntoWvSiFP5ZxcOy7ARum8+jtQhkwaI9X8RvpPK59pLBAYI9n
         eEHAbrn4uIManGfbyVIgUczcM5yrBx0kBivpaxjHNtr71IO/JZIBY/0RimU2pxEKlvwA
         REyAnzevey8/fjxf65LCBhO8hMM/x0Sl4A4DpdvUQTx4N/Zqt6b6sW9T4uKOnIaTddR5
         7i9A==
X-Gm-Message-State: ACgBeo3uCiF4INnF6rW5Qux0z/UZShaK61CuNheG205sHXCKI0yjHPTd
        Qpg3LzH70eo8OKnZBjUzCmZKExR2ip0=
X-Google-Smtp-Source: AA6agR4dMUtMrQCe1+g4O93IqHGuAAWcoXQIuLWtdzn+7IRnW7vUwo24OWz9mdAXig7+z5l22W8Ptg==
X-Received: by 2002:a05:600c:384f:b0:3a6:603c:4338 with SMTP id s15-20020a05600c384f00b003a6603c4338mr2147016wmr.192.1661259823506;
        Tue, 23 Aug 2022 06:03:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003a4f08495b7sm22652850wmq.34.2022.08.23.06.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:03:43 -0700 (PDT)
Message-Id: <40ce21e85c970953d57e16f70073fbc2d7aa918d.1661259820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
        <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 13:03:37 +0000
Subject: [PATCH v2 1/4] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
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

Though perhaps not common, there are use cases where users have large,
network-mounted repos. Having the ability to run fsmonitor against
network paths would benefit those users.

Most modern Samba-based filers have the necessary support to enable
fsmonitor on network-mounted repos. As a first step towards enabling
fsmonitor to work against network-mounted repos, introduce a
configuration option, 'fsmonitor.allowRemote'. Setting this option to
true will override the default behavior (erroring-out) when a
network-mounted repo is detected by fsmonitor.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-settings-win32.c | 68 +++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index 907655720bb..e5ec5b0a9f7 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -24,6 +24,59 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
+/*
+ * Check if monitoring remote working directories is allowed.
+ *
+ * By default, monitoring remote working directories is
+ * disabled.  Users may override this behavior in enviroments where
+ * they have proper support.
+ */
+static int check_config_allowremote(struct repository *r)
+{
+	int allow;
+
+	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
+		return allow;
+
+	return -1; /* fsmonitor.allowremote not set */
+}
+
+/*
+ * Check remote working directory protocol.
+ *
+ * Error if client machine cannot get remote protocol information.
+ */
+static int check_remote_protocol(wchar_t *wpath)
+{
+	HANDLE h;
+	FILE_REMOTE_PROTOCOL_INFO proto_info;
+
+	h = CreateFileW(wpath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING,
+			FILE_FLAG_BACKUP_SEMANTICS, NULL);
+
+	if (h == INVALID_HANDLE_VALUE) {
+		error(_("[GLE %ld] unable to open for read '%ls'"),
+		      GetLastError(), wpath);
+		return -1;
+	}
+
+	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
+		&proto_info, sizeof(proto_info))) {
+		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
+		      GetLastError(), wpath);
+		CloseHandle(h);
+		return -1;
+	}
+
+	CloseHandle(h);
+
+	trace_printf_key(&trace_fsmonitor,
+				"check_remote_protocol('%ls') remote protocol %#8.8lx",
+				wpath, proto_info.Protocol);
+
+	return 0;
+}
+
 /*
  * Remote working directories are problematic for FSMonitor.
  *
@@ -76,6 +129,7 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
  */
 static enum fsmonitor_reason check_remote(struct repository *r)
 {
+	int ret;
 	wchar_t wpath[MAX_PATH];
 	wchar_t wfullpath[MAX_PATH];
 	size_t wlen;
@@ -115,6 +169,20 @@ static enum fsmonitor_reason check_remote(struct repository *r)
 		trace_printf_key(&trace_fsmonitor,
 				 "check_remote('%s') true",
 				 r->worktree);
+
+		ret = check_remote_protocol(wfullpath);
+		if (ret < 0)
+			return FSMONITOR_REASON_ERROR;
+
+		switch (check_config_allowremote(r)) {
+		case 0: /* config overrides and disables */
+			return FSMONITOR_REASON_REMOTE;
+		case 1: /* config overrides and enables */
+			return FSMONITOR_REASON_OK;
+		default:
+			break; /* config has no opinion */
+		}
+
 		return FSMONITOR_REASON_REMOTE;
 	}
 
-- 
gitgitgadget

