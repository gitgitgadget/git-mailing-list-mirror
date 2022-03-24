Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169BFC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351947AbiCXQx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351887AbiCXQxW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723759F386
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r13so7463096wrr.9
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aGhX76dz325gkGkIrL9UlyaHr3ziBUV0IbljHMDHg+g=;
        b=GRaRZFNS5ZX1aJ0cIVBduAlaXGBzMiTM7avPmftR1csivkgZnPjGQKjuXVa847bsin
         c1VZ+NsxGNUJ7K4VaXZLkuDppu/oyzMxV9hTH2LcQXyQnqgEz+SRPq2C6seLI/4kcSjV
         p9lLQgCh34SEj+XzYUwHayXKKUcwvpOJ8CgTZHtOhp9T27S5hcG3agIsdfEFbViodww8
         fQ+JMOI4DgU0gV5rfAKlZ8M3JiJkI0mW13HrTdODJ6rN66iGTYkMPqXBpwuj/vu05DX4
         aogpCKTYak6dGhMNRBdYmAJShfYoCh+t8D0ZzpfGPFanoRKCYmsSYUAf2kY/xrF9/cVd
         Z8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aGhX76dz325gkGkIrL9UlyaHr3ziBUV0IbljHMDHg+g=;
        b=rtQFAVw3UY/dh1rKobfQI7aFOp59AD0WOGzncBmi63X5M9q4w0W1bKtS7U6KcVzwe0
         /+BsV9TIX+e/1N2GNTnG4qICtmeh+S3mBOhEL3ESfa/gsJRPVJR5UeIt2Ri1YwSYeiGo
         mBUeER2sg/oWf7eLwXO2sov2kQgh9SkXUyExhpFzqxIQkp7cDFq389qFtPhx3PGozME5
         mT1Lso/uvYhVVjpUDo9hgSsDLO8dLRWV1byeVEJ0WX1awCfn+8OdEoks/KNvYMVcrZP/
         S0kyfJE6lA2Lcb0jkzTlfBiZtydwGzjsxW2vo1t7mI/rdArYRptfGeUKsqC8Gra3ptJT
         m3FA==
X-Gm-Message-State: AOAM530T0abxRivLO6Cv+aqAnFo7ZQuukFT/mr7tc1zktVQUX45i/saw
        F6eWE8uuoEX6DB809ZTlanPcFw0owro=
X-Google-Smtp-Source: ABdhPJy0WK/uy32pKNuUwmOZ0oHqj3JFZpQYKr4NjSncnh6aOeHbhVFuAcigA+drsI6WZKUJ/0v4pA==
X-Received: by 2002:a5d:64a2:0:b0:205:8ab3:4fdc with SMTP id m2-20020a5d64a2000000b002058ab34fdcmr5356823wrp.168.1648140708782;
        Thu, 24 Mar 2022 09:51:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d588e000000b00204064a3800sm3531182wrf.51.2022.03.24.09.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:48 -0700 (PDT)
Message-Id: <36ab239fd9a2ee98b0ccaaf4d12bdd8950ffafeb.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:13 +0000
Subject: [PATCH v4 20/27] fsmonitor: optimize processing of directory events
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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

