Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0143DC54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 20:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiIMU1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 16:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiIMU1o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 16:27:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49266659C9
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:27:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bz13so22591669wrb.2
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=fon4TV/aWInSnIdeE9yS/MSfxyJMThj9u67iYXJxQS0=;
        b=EvLZH9flmSMIsw6fQ/MlWxW/xh0RWaZncDRNWGNPLWOQ4xMYHmBPT2fB+sB8KeD42u
         mh+eA1m/XeCNJt0LkoyOwMLW+gEwNJY3OSU+mzuEvlSlBkusvgZRmsb6xxdJU3mosL7x
         XIrd914dk9Y7qUmEM/PZB6/isvdDxgWi/hqLjoEcAXjaUnlVmh0GDpKuj/6NehwirADk
         micC8qbkdOnHQrJRCeQgr+a2G6wCFVArO/Z1m4ng1y6SLg6w2y5FSPpZeT98fo7oGhbo
         0wwp+NgUq3AIBUsxmLVQ3xu550O0tpuibG6SJkuFXEpAMv6UewLLR1xxWHofw/4sDKjk
         5fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fon4TV/aWInSnIdeE9yS/MSfxyJMThj9u67iYXJxQS0=;
        b=xOLfH+ujnjCctEwesgZ9XY8ILbjIUCq/KsdUp/b4LR2bP2JtL6NkxQdQpP4iLuZiMg
         33N3ElUE6V4CZFTrlEbbaNJI+d74Ki7904X102i3VmqVpIRdLq2V1HlsaNc5QgaqU7Fm
         hbSWrI2Squ66hgPhHmih/Zh8HDhrrGqX7eM2oAT6ctzSN2trlzgysr8F0nHI+cMl7Kyw
         CpZ4mjG0qs8xRLFPXzuDBPRpQki6QIzEss/JgKo3t5DCI6iFokLKZcf9cQeKDAjVdt/d
         kmPqcgWYwXiS7qUtI3sXBy292GePkzzCGEWOSnV7Pbu4saOhqKUPiUv3WLMpFqOFax+b
         /t0Q==
X-Gm-Message-State: ACgBeo3G14vUCXi1KRXI/5y4wN+FjhReRkzDgc2Q7i5l03aoRqD98Unz
        Mh3RaNcLGP9B8RHKQIw6+DSz1HnMsZs=
X-Google-Smtp-Source: AA6agR5tYJm6ZbOtK6gmyN32yCbaBXFSGQU4TqoPczkIgnZNet3Wfsv2Huug3GJf3NZEVnZVUCgr4A==
X-Received: by 2002:a05:6000:186f:b0:228:e1ab:673 with SMTP id d15-20020a056000186f00b00228e1ab0673mr19499183wri.324.1663100861570;
        Tue, 13 Sep 2022 13:27:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c28c900b003b33de17577sm14277531wmd.13.2022.09.13.13.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 13:27:40 -0700 (PDT)
Message-Id: <3233c908c4ab0521ff35df09f62adec25a49faa4.1663100859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
References: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
        <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 20:27:33 +0000
Subject: [PATCH v6 1/6] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
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

