Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89875C433FE
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349357AbiEZVt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349265AbiEZVtf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F309EAD1F
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k30so3653572wrd.5
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aGhX76dz325gkGkIrL9UlyaHr3ziBUV0IbljHMDHg+g=;
        b=XIyYTTV5rFevoXjWo62Ew0QAn2l2rfJAX55b+0iWf3fZkP8KKyYccbx0M9V1IxUDlY
         NBeSKVrncnW942RB4S9y3vUtHDL2t4ol6P5BVFPo5umYFGwgAM636qHgD3iZhO4pqT2w
         ioeDw3sk/mHIzpllEgmQsAGctUm6KYcHwZetXvgz5+elrMjX2kpMnuF5vBLtMhjtzUJQ
         EVKMqYEYj8lbldLc97ZQWD1yyticYD/vfQqd8sA4XPwipF0W43rkeLtTH9ihYuK8ksB2
         0FHQpKXhP6DIz17lSObHKFst/noCzbwt0+cLrGxS25990ubJUS5Ye5FLRWwCes4SiyCX
         +dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aGhX76dz325gkGkIrL9UlyaHr3ziBUV0IbljHMDHg+g=;
        b=Pi4VvLVeP644BLWLvialvZB9HDQg+fBXtkUxC9l/b6botuK6/heTwlD56+ogA1TlJL
         BlPyh0dxU9l7ZzCGXSwhSWU8iauVfnZHYqFrEmS9Q8StFPu8UtzCqdC6q6uu6stZBKuV
         WnPpYv7R9Hu4zcARcXFusK5hwyGe5PxTG6jV/zY7NzIMT/6edm4PARRk0Z+AXTIMXycG
         wB5L/mq7wsdQ3N2n+n22BkWrprRbxO43F3JsPUMJQ76b1b3ZX2Qtci/CTOxOydLctlAP
         G9GObNSdmpYyeESjkGUWf7N/IpSO2CiksuWJDRcbnJnaqwdewBqwHajtXyUX8UTB+Z3i
         pcsA==
X-Gm-Message-State: AOAM531BEol4qdxBDh0jn4eVG0P7I+e3C5pq7KHguUWrLcU1nxdmv8Nl
        6pJ0JVjpQ/S2tx7KsfecFs0cQx9ajgU=
X-Google-Smtp-Source: ABdhPJzQQtk/Fdz/y0B3HcFmDYeJQxDpbHBApz49z4qVFohRKl6sNbWXCUlU58DYZKvPoxeb1hKfKw==
X-Received: by 2002:a5d:47c1:0:b0:20f:ff8e:1bc4 with SMTP id o1-20020a5d47c1000000b0020fff8e1bc4mr7829400wrc.225.1653601766242;
        Thu, 26 May 2022 14:49:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2-20020a7bc082000000b00397402ae674sm317415wmh.11.2022.05.26.14.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:25 -0700 (PDT)
Message-Id: <8fa7f4fa9bebc7cfb8c26f54ed8076ade4015326.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:14 +0000
Subject: [PATCH v9 20/30] fsmonitor: optimize processing of directory events
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

