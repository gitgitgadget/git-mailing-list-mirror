Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F57C25B06
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 16:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbiHKQMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 12:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiHKQMG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 12:12:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B79998D0F
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 08:57:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q30so21793053wra.11
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 08:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=ZNHXUNzcMJ+lNGdC37+KOI5dcd+RgeqZu+mtnGa0jfw=;
        b=MxdTFSf2NlX6L9H39p/ZHqlTA2Kstsdt5z85FxKO5EXlN/70ulr8XrjjsvzPkuBZek
         NMRTHrvKG3ghkI2KL1+801O5yWKpNHcTljFxAuQyz4cjUUNt9vg+Rvp4uSYadOf1AYeb
         lXNOxKR+AIlWgRoaho4UtqOALwfJNtbQXSrLqXd5e9dTVfAPME756XQ7TnlTWjmsaAAE
         E5KajxLUkNxi+YEUdqMAvAmd3aepHFgPgrkesUVwbxdHODY0ng1Nxgq3MRUmyPVglbo7
         4nUF5jR0sqkzrHSC0VtQMSsNUL7UGWhSHl+s+NQTdfX6EaXjgY12wX2DLyaDcPWmYKA1
         rmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=ZNHXUNzcMJ+lNGdC37+KOI5dcd+RgeqZu+mtnGa0jfw=;
        b=LShp9mlk/iaQTMP7ceFcmQ7XYcJ2GzHNiqG832NcfsRes+0ELJkM6jc8jB9SUwbwNI
         owYv6xxJ5l99z2gN9mp81nmhlQUtXM4VHPTWAItq3pGWG+zlq2K5whjgtFatcaUZshUS
         Xhqt+769Bilvt9Wu4tqr6STOJQvLa+F4uNCxgNAqxHIYUIkQMUdPE/nDgff/ucPx3PMd
         OAJyIz1J+lMt57RJF5l4f4jh/XlWJ7Cu1BRXSCVWx1tN2h6449uWdki+fZ1TVin60dod
         Zz8eG9n7L8VjggHbd+V2DgHBOSRDUMpTzpR48MKwTWB8i/wTcbqc5swul0qKwJkXBsjn
         4zBg==
X-Gm-Message-State: ACgBeo0Vp/oLAcLdMUhDYsbky51U1jkKkIk0muv5cvnFmOk12IZGOSKo
        8GgtlANNwcNILmuvYA7DBl2B4Cs8KQY=
X-Google-Smtp-Source: AA6agR75efgAj5Y7XSXMi2krR5T9uKTMXetRYPV0yg/mpnBWj/McIJVaTiBMtUQiTI41eNiK92lVlQ==
X-Received: by 2002:a5d:5964:0:b0:222:ed7f:4418 with SMTP id e36-20020a5d5964000000b00222ed7f4418mr10724781wri.133.1660233435816;
        Thu, 11 Aug 2022 08:57:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13-20020adfe50d000000b00222d512d96asm9858192wrm.75.2022.08.11.08.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:57:15 -0700 (PDT)
Message-Id: <7a071c9e6be68b58306582dbac5952a5b1bcbc6a.1660233432.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1317.v2.git.1660233432.gitgitgadget@gmail.com>
References: <pull.1317.git.1660067049965.gitgitgadget@gmail.com>
        <pull.1317.v2.git.1660233432.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Aug 2022 15:57:12 +0000
Subject: [PATCH v2 2/2] fsmonitor.allowRemote now overrides default behavior
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

Reworked the logic around fsmonitor.allowRemote such that if
allowRemote is set it will determine if monitoring the remote
worktree is allowed.

Get remote protocoal information; if this fails report an error else
print it if tracing is enabled.

Fixed fomratting issues.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-settings-win32.c | 57 ++++++++++++++++-----------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index d120e4710cf..32c0695c6c1 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -27,53 +27,55 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
 /*
  * Check if monitoring remote working directories is allowed.
  *
- * By default monitoring remote working directories is not allowed,
- * but users may override this behavior in enviroments where they
- * have proper support.
-*/
-static enum fsmonitor_reason check_allow_remote(struct repository *r)
+ * By default, monitoring remote working directories is
+ * disabled unless on a network filesystem that is known to
+ * behave well.  Users may override this behavior in enviroments where
+ * they have proper support.
+ */
+static int check_config_allowremote(struct repository *r)
 {
 	int allow;
 
-	if (repo_config_get_bool(r, "fsmonitor.allowremote", &allow) || !allow)
-		return FSMONITOR_REASON_REMOTE;
+	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
+		return allow;
 
-	return FSMONITOR_REASON_OK;
+	return -1; /* fsmonitor.allowremote not set */
 }
 
 /*
- * Check if the remote working directory is mounted via SMB
+ * Check remote working directory protocol.
  *
- * For now, remote working directories are only supported via SMB mounts
-*/
-static enum fsmonitor_reason check_smb(wchar_t *wpath)
+ * Error if client machine cannot get remote protocol information.
+ */
+static void check_remote_protocol(wchar_t *wpath)
 {
 	HANDLE h;
 	FILE_REMOTE_PROTOCOL_INFO proto_info;
 
 	h = CreateFileW(wpath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING,
-					FILE_FLAG_BACKUP_SEMANTICS, NULL);
+			FILE_FLAG_BACKUP_SEMANTICS, NULL);
 
 	if (h == INVALID_HANDLE_VALUE) {
 		error(_("[GLE %ld] unable to open for read '%ls'"),
 		      GetLastError(), wpath);
-		return FSMONITOR_REASON_ERROR;
+		return;
 	}
 
 	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
-									&proto_info, sizeof(proto_info))) {
+		&proto_info, sizeof(proto_info))) {
 		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
 		      GetLastError(), wpath);
 		CloseHandle(h);
-		return FSMONITOR_REASON_ERROR;
+		return;
 	}
 
 	CloseHandle(h);
 
-	if (proto_info.Protocol == WNNC_NET_SMB)
-		return FSMONITOR_REASON_OK;
+	trace_printf_key(&trace_fsmonitor,
+				"check_remote_protocol('%ls') remote protocol %#8.8lx",
+				wpath, proto_info.Protocol);
 
-	return FSMONITOR_REASON_ERROR;
+	return;
 }
 
 /*
@@ -128,7 +130,6 @@ static enum fsmonitor_reason check_smb(wchar_t *wpath)
  */
 static enum fsmonitor_reason check_remote(struct repository *r)
 {
-	enum fsmonitor_reason reason;
 	wchar_t wpath[MAX_PATH];
 	wchar_t wfullpath[MAX_PATH];
 	size_t wlen;
@@ -169,10 +170,18 @@ static enum fsmonitor_reason check_remote(struct repository *r)
 				 "check_remote('%s') true",
 				 r->worktree);
 
-		reason = check_smb(wfullpath);
-		if (reason != FSMONITOR_REASON_OK)
-			return reason;
-		return check_allow_remote(r);
+		check_remote_protocol(wfullpath);
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
+		return FSMONITOR_REASON_REMOTE;
 	}
 
 	return FSMONITOR_REASON_OK;
-- 
gitgitgadget
