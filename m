Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10906C25B0E
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 16:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbiHKQMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 12:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiHKQMG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 12:12:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B4498D0D
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 08:57:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay12so6853047wmb.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=ia/5+hP68dypHpmbjsNsBZ4krf0MCrw0sWRJJnvzDNU=;
        b=UlhOMK5iIGutiwZk7v4x8h04H6OiOEowkVPqM2g3wg4CHfnD3IDBMSbjuX1ennI15D
         G22tf4MDOEwsJTprF1Z6yicF8a1KCbQYxPyXy0tDKaj/oMh8lN7wx9gdqEl6LRdZSIdV
         vhV9Mj8oe3J0gjfGRaxIb9WzeSjruo1tsIUcZrSAhoBCI0wdCzwaqQCu92goni3a3949
         uZbJY6MRM58pu/jN9awePTZjgi8uU3FNR3ZzGj01pCG7PnLBN0EsXXMET6Hozk0dYdyU
         9+jt7px7kZX3FB/uQlzKwyXBacafRlWvvhOfz/3K0JFo5F0A/YgTfB5dLi1VtiLeU84C
         RIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=ia/5+hP68dypHpmbjsNsBZ4krf0MCrw0sWRJJnvzDNU=;
        b=CUDErsCbrjm9LSy13OzjzUiVRMUvHtTRRgdDkEJzapYQ627x+UoyXebQya4XfXwl8D
         ctGCPeh3zQ7MedGk+QVefYKMvhbr9DV7lHoeSqKew2s73f4zdP5rv2sJIVNjnVW4UaPT
         iHe5pDIMjjy5GCGkKfweoKJKxqll6CvpFC8VPd81XGUfTtX/WHORy4JeMfd+WEZNVgzj
         zdiXduB6dMmnx8U9uF3XPICDS5CnR40GOJmEKqijgwH6QD7IczV4xw2JYc4b5N8iWr1H
         1V3/iWHcy9Nzp3xJbNP5guw8lJyaomCVNl6hYbNkjGNypA3dJQ74MNVUC9yBWLZZwHzx
         UuOQ==
X-Gm-Message-State: ACgBeo0sE9QIXi23WSdhwkzLhoSZX2hi/ACMK9Y561xmJprOoNpratot
        zbU44uVJqru58d6n+8hgCsHM5pzBD2U=
X-Google-Smtp-Source: AA6agR5Y3+LuNEaWwg6NR5C9hnbgW7u/JwhaNW/M0Hp1vqdF0kPScyBQCTt28WQPFpxM9XrnyvVafQ==
X-Received: by 2002:a05:600c:3556:b0:3a3:2a9c:f26 with SMTP id i22-20020a05600c355600b003a32a9c0f26mr6080314wmq.58.1660233434919;
        Thu, 11 Aug 2022 08:57:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15-20020adfcf0f000000b0021d6a520ce9sm19318588wrj.47.2022.08.11.08.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:57:14 -0700 (PDT)
Message-Id: <7e67ce8c9449a2b5997cfe36e662898e3e00dbf0.1660233432.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1317.v2.git.1660233432.gitgitgadget@gmail.com>
References: <pull.1317.git.1660067049965.gitgitgadget@gmail.com>
        <pull.1317.v2.git.1660233432.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Aug 2022 15:57:11 +0000
Subject: [PATCH v2 1/2] fsmonitor: option to allow fsmonitor to run against
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

Though perhaps not common, there are uses cases where users have large,
network-mounted repos. Having the ability to run fsmonitor against
network paths would benefit those users.

Most modern Samba-based filers have the necessary support to enable
fsmonitor on network-mounted repos. As a first step towards enabling
fsmonitor to work against network-mounted repos, introduce a
configuration option, 'fsmonitor.allowRemote'. Setting this option to
true will override the default behavior (erroring-out) when a
network-mounted repo is detected by fsmonitor.

Additionally, as part of this first step, monitoring of network-mounted
repos will be restricted to those mounted over SMB regardless of the
value of 'fsmonitor.allowRemote' until more extensive testing can be
performed.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-settings-win32.c | 59 ++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index 907655720bb..d120e4710cf 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -24,6 +24,58 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
+/*
+ * Check if monitoring remote working directories is allowed.
+ *
+ * By default monitoring remote working directories is not allowed,
+ * but users may override this behavior in enviroments where they
+ * have proper support.
+*/
+static enum fsmonitor_reason check_allow_remote(struct repository *r)
+{
+	int allow;
+
+	if (repo_config_get_bool(r, "fsmonitor.allowremote", &allow) || !allow)
+		return FSMONITOR_REASON_REMOTE;
+
+	return FSMONITOR_REASON_OK;
+}
+
+/*
+ * Check if the remote working directory is mounted via SMB
+ *
+ * For now, remote working directories are only supported via SMB mounts
+*/
+static enum fsmonitor_reason check_smb(wchar_t *wpath)
+{
+	HANDLE h;
+	FILE_REMOTE_PROTOCOL_INFO proto_info;
+
+	h = CreateFileW(wpath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING,
+					FILE_FLAG_BACKUP_SEMANTICS, NULL);
+
+	if (h == INVALID_HANDLE_VALUE) {
+		error(_("[GLE %ld] unable to open for read '%ls'"),
+		      GetLastError(), wpath);
+		return FSMONITOR_REASON_ERROR;
+	}
+
+	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
+									&proto_info, sizeof(proto_info))) {
+		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
+		      GetLastError(), wpath);
+		CloseHandle(h);
+		return FSMONITOR_REASON_ERROR;
+	}
+
+	CloseHandle(h);
+
+	if (proto_info.Protocol == WNNC_NET_SMB)
+		return FSMONITOR_REASON_OK;
+
+	return FSMONITOR_REASON_ERROR;
+}
+
 /*
  * Remote working directories are problematic for FSMonitor.
  *
@@ -76,6 +128,7 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
  */
 static enum fsmonitor_reason check_remote(struct repository *r)
 {
+	enum fsmonitor_reason reason;
 	wchar_t wpath[MAX_PATH];
 	wchar_t wfullpath[MAX_PATH];
 	size_t wlen;
@@ -115,7 +168,11 @@ static enum fsmonitor_reason check_remote(struct repository *r)
 		trace_printf_key(&trace_fsmonitor,
 				 "check_remote('%s') true",
 				 r->worktree);
-		return FSMONITOR_REASON_REMOTE;
+
+		reason = check_smb(wfullpath);
+		if (reason != FSMONITOR_REASON_OK)
+			return reason;
+		return check_allow_remote(r);
 	}
 
 	return FSMONITOR_REASON_OK;
-- 
gitgitgadget

