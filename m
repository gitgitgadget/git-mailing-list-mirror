Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A25C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355124AbiDTUre (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382184AbiDTUqr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BDC44772
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s29so777171wrb.8
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aGhX76dz325gkGkIrL9UlyaHr3ziBUV0IbljHMDHg+g=;
        b=XvgPKeUchtTZBF1tUwNmvMTJvMUZsAj3qQMssKjnUYZyxHGfLIKk0JV8HIAgWY69Gf
         oOxQ1p9T5f/UKQmDPaxBOtj2/OA80hO+wsu4yRm1Gl7eZYWd8yinWq4COlCQFdIFM4ix
         8MX48HK/j/YB8o3P2opNT3iuOpX9r+bCDXVzblfPhZl1/8e0QUEwVj6ztJF3AnPs5gST
         D3h3SSTb34Dx3gFwkSb2TDrdPbRofVK8bkxRTtKf6bQEqO3dgNqjL1Xh3Inkzy8tuHNZ
         dT/pzqY8LD9toCLpfZllb0pAp3zd1EvZCXu/bXlXqzGxP43flT+tVjJgqTPjkzXJe7Yw
         wrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aGhX76dz325gkGkIrL9UlyaHr3ziBUV0IbljHMDHg+g=;
        b=i0GvIocbPEwlIBgNI6NGDUxbm2uWXrSc8SugnYPqR/fEDfsqT7IHGRFh7ppDcJER3k
         k72HNkvWW+1X9cN6axq23txIYBs4t1tOLNppUiQt2Nn1M41O4XaWFYzzjrDEOK23BRqV
         KSFGqAPA5Sxz7VjdRGQozxY23p1oXy1rydYEbwPQ9R+7xFBvSn2AaIsCcDDnZAyOZTvC
         5SSdfc40h5FHsFBWcdL0Y88J9YX25sc02ezw1uExZ5tWpIFPoVawYKs/MfuuxJE2ATPL
         8N+2KL6C3Rz9+udRsyMHWFKU98JcVj9aQJiW7HBmEmb0wwGaNStXCoLEpeoit8HnXCDa
         7/og==
X-Gm-Message-State: AOAM531JT/GjO4XJeoDCX3S+HsrqE++9Jjxwm9roTniwxKtJVi37xnFd
        yI9BjXDajS5p37TxCAW4t5iPacoefcA=
X-Google-Smtp-Source: ABdhPJwUahu4BfFqB/FIxb+tWDDfQ3uAf/i07+UBhCbx5Y1VAMQh5mGkbhTGGPQ+RPg69V0jR+9CFg==
X-Received: by 2002:a5d:4842:0:b0:207:c6ad:4a48 with SMTP id n2-20020a5d4842000000b00207c6ad4a48mr16533050wrs.149.1650487426639;
        Wed, 20 Apr 2022 13:43:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c4fcb00b00391447f7fd4sm345198wmq.24.2022.04.20.13.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:46 -0700 (PDT)
Message-Id: <15698d64edd0e65e5486a97024818a55c9e4295c.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:43:10 +0000
Subject: [PATCH v5 20/28] fsmonitor: optimize processing of directory events
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

Teach Git to perform binary search over the cache-entries for a directory
notification and then linearly scan forward to find the immediate children.

Previously, when the FSMonitor reported a modified directory Git would
perform a linear search on the entire cache-entry array for all
entries matching that directory prefix and invalidate them.  Since the
cache-entry array is already sorted, we can use a binary search to
find the first matching entry and then only linearly walk forward and
invalidate entries until the prefix changes.

Also, the original code would invalidate anything having the same
directory prefix.  Since a directory event should only be received for
items that are immediately within the directory (and not within
sub-directories of it), only invalidate those entries and not the
whole subtree.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 71 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 17 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 292a6742b4f..e1229c289cf 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -184,30 +184,68 @@ static int query_fsmonitor_hook(struct repository *r,
 static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 {
 	int i, len = strlen(name);
-	if (name[len - 1] == '/') {
+	int pos = index_name_pos(istate, name, len);
+
+	trace_printf_key(&trace_fsmonitor,
+			 "fsmonitor_refresh_callback '%s' (pos %d)",
+			 name, pos);
 
+	if (name[len - 1] == '/') {
 		/*
-		 * TODO We should binary search to find the first path with
-		 * TODO this directory prefix.  Then linearly update entries
-		 * TODO while the prefix matches.  Taking care to search without
-		 * TODO the trailing slash -- because '/' sorts after a few
-		 * TODO interesting special chars, like '.' and ' '.
+		 * The daemon can decorate directory events, such as
+		 * moves or renames, with a trailing slash if the OS
+		 * FS Event contains sufficient information, such as
+		 * MacOS.
+		 *
+		 * Use this to invalidate the entire cone under that
+		 * directory.
+		 *
+		 * We do not expect an exact match because the index
+		 * does not normally contain directory entries, so we
+		 * start at the insertion point and scan.
 		 */
+		if (pos < 0)
+			pos = -pos - 1;
 
 		/* Mark all entries for the folder invalid */
-		for (i = 0; i < istate->cache_nr; i++) {
-			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID &&
-			    starts_with(istate->cache[i]->name, name))
-				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+		for (i = pos; i < istate->cache_nr; i++) {
+			if (!starts_with(istate->cache[i]->name, name))
+				break;
+			istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
 		}
-		/* Need to remove the / from the path for the untracked cache */
+
+		/*
+		 * We need to remove the traling "/" from the path
+		 * for the untracked cache.
+		 */
 		name[len - 1] = '\0';
+	} else if (pos >= 0) {
+		/*
+		 * We have an exact match for this path and can just
+		 * invalidate it.
+		 */
+		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
 	} else {
-		int pos = index_name_pos(istate, name, strlen(name));
-
-		if (pos >= 0) {
-			struct cache_entry *ce = istate->cache[pos];
-			ce->ce_flags &= ~CE_FSMONITOR_VALID;
+		/*
+		 * The path is not a tracked file -or- it is a
+		 * directory event on a platform that cannot
+		 * distinguish between file and directory events in
+		 * the event handler, such as Windows.
+		 *
+		 * Scan as if it is a directory and invalidate the
+		 * cone under it.  (But remember to ignore items
+		 * between "name" and "name/", such as "name-" and
+		 * "name.".
+		 */
+		pos = -pos - 1;
+
+		for (i = pos; i < istate->cache_nr; i++) {
+			if (!starts_with(istate->cache[i]->name, name))
+				break;
+			if ((unsigned char)istate->cache[i]->name[len] > '/')
+				break;
+			if (istate->cache[i]->name[len] == '/')
+				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
 		}
 	}
 
@@ -215,7 +253,6 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 	 * Mark the untracked cache dirty even if it wasn't found in the index
 	 * as it could be a new untracked file.
 	 */
-	trace_printf_key(&trace_fsmonitor, "fsmonitor_refresh_callback '%s'", name);
 	untracked_cache_invalidate_path(istate, name, 0);
 }
 
-- 
gitgitgadget

