Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EC8C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbiCJWoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbiCJWof (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:44:35 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652A2D1087
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:43:33 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u10so10278389wra.9
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8LMEDrdKX+poM1jfU5csXLomxtL/nPjVddZz+EGfo5E=;
        b=pbsgh//60xtZ6tSNj+B60fOBMwjU56hamz+nz5thOl4xJbHR3M7lZviP1rwFt+5qMl
         rz8kt/1+6Jg6B2e1Ae5KzKXlV9SIu1FDWPbvizsGDNcpxr9AONOt7bTDxUrqrFYq7khg
         +a5GtGfN2UhzkfyCelslFwjY4ueRo4HMG14+MUsYv6x+OvGUXPGshptBIg4DkGtec16Z
         YGj3MlVQB4jHA0xnvL9bCE2ObGq0t8mPnHpeaMpJmFe7IxCC/0jkXazBTsQZyFelqtVC
         kCJoEmXfsmDPSdulkEv0srCOfpgmipoRLmhYctw3kqOteXCdhDaZDvgta6mES61Y28NX
         dyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8LMEDrdKX+poM1jfU5csXLomxtL/nPjVddZz+EGfo5E=;
        b=qZEQRpSv64DhFmDaI5ph+DjT9sJCfwMsUs++Umcbj6/yg6IFkrqEWnDICcq4Lc2Abe
         z08ezaBICYkR7mB54tCbGaOblm1xBO55f9H0EWbnlnYShRSkruKIKs/xInXNASSI65dC
         kcnpeqQg6yn7dWyUM/L/HxdN9mMUsFvwSM0BhJOzFIe6Opz3zxqSzGjcAlQtd5TALuj0
         QYDnIenTPSz6E0Z1V2fTb0kpqqRHasgfp2NwpaH/YPERqSyo7oJSqRpe87TraZT8tqPE
         /fYoX4nvZZfgUgJSjYgErb1VryA4EsnJABmqckzjQTSDYHPTIfdPCaT8PCzp8arH3v7M
         4O6g==
X-Gm-Message-State: AOAM531Pz1tslWEfKsKta3dczOVTbR20rYgEsU1WLRFL2Q4Xy2Y/XSyK
        ufyJERtakR/ORmp72inSneEm1Jc4Lxs=
X-Google-Smtp-Source: ABdhPJx6fxLFJ9pKIiSbDb9SNI3wjMzUbyZw99422GfEuKXlAj9XV7OZYYuGY9NZF4Fq4VZqGt1JpA==
X-Received: by 2002:adf:f1c1:0:b0:1e3:1381:7bd5 with SMTP id z1-20020adff1c1000000b001e313817bd5mr5210922wro.450.1646952211858;
        Thu, 10 Mar 2022 14:43:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14-20020adfd18e000000b0020373e5319asm5626360wrc.103.2022.03.10.14.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:43:31 -0800 (PST)
Message-Id: <757f6d0bbd21550a9e8f4783eb0b3c351b12f930.1646952205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 22:43:23 +0000
Subject: [PATCH v6 5/6] core.fsync: new option to harden the index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

This commit introduces the new ability for the user to harden
the index. In the event of a system crash, the index must be
durable for the user to actually find a file that has been added
to the repo and then deleted from the working tree.

We use the presence of the COMMIT_LOCK flag and absence of the
alternate_index_output as a proxy for determining whether we're
updating the persistent index of the repo or some temporary
index. We don't sync these temporary indexes.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 cache.h      |  1 +
 config.c     |  1 +
 read-cache.c | 19 +++++++++++++------
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 7ac1959258d..e08eeac6c15 100644
--- a/cache.h
+++ b/cache.h
@@ -1004,6 +1004,7 @@ enum fsync_component {
 	FSYNC_COMPONENT_PACK			= 1 << 1,
 	FSYNC_COMPONENT_PACK_METADATA		= 1 << 2,
 	FSYNC_COMPONENT_COMMIT_GRAPH		= 1 << 3,
+	FSYNC_COMPONENT_INDEX			= 1 << 4,
 };
 
 #define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
diff --git a/config.c b/config.c
index 94a4598b5fc..80f33c91982 100644
--- a/config.c
+++ b/config.c
@@ -1331,6 +1331,7 @@ static const struct fsync_component_name {
 	{ "pack", FSYNC_COMPONENT_PACK },
 	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
 	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
+	{ "index", FSYNC_COMPONENT_INDEX },
 };
 
 static enum fsync_component parse_fsync_components(const char *var, const char *string)
diff --git a/read-cache.c b/read-cache.c
index df869691fd4..7683b679258 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2842,7 +2842,7 @@ static int record_ieot(void)
  * rely on it.
  */
 static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
-			  int strip_extensions)
+			  int strip_extensions, unsigned flags)
 {
 	uint64_t start = getnanotime();
 	struct hashfile *f;
@@ -2856,6 +2856,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 	int drop_cache_tree = istate->drop_cache_tree;
 	off_t offset;
+	int csum_fsync_flag;
 	int ieot_entries = 1;
 	struct index_entry_offset_table *ieot = NULL;
 	int nr, nr_threads;
@@ -3089,7 +3090,13 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			return -1;
 	}
 
-	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_NONE, CSUM_HASH_IN_STREAM);
+	csum_fsync_flag = 0;
+	if (!alternate_index_output && (flags & COMMIT_LOCK))
+		csum_fsync_flag = CSUM_FSYNC;
+
+	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_INDEX,
+			  CSUM_HASH_IN_STREAM | csum_fsync_flag);
+
 	if (close_tempfile_gently(tempfile)) {
 		error(_("could not close '%s'"), get_tempfile_path(tempfile));
 		return -1;
@@ -3144,7 +3151,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	 */
 	trace2_region_enter_printf("index", "do_write_index", the_repository,
 				   "%s", get_lock_file_path(lock));
-	ret = do_write_index(istate, lock->tempfile, 0);
+	ret = do_write_index(istate, lock->tempfile, 0, flags);
 	trace2_region_leave_printf("index", "do_write_index", the_repository,
 				   "%s", get_lock_file_path(lock));
 
@@ -3238,7 +3245,7 @@ static int clean_shared_index_files(const char *current_hex)
 }
 
 static int write_shared_index(struct index_state *istate,
-			      struct tempfile **temp)
+			      struct tempfile **temp, unsigned flags)
 {
 	struct split_index *si = istate->split_index;
 	int ret, was_full = !istate->sparse_index;
@@ -3248,7 +3255,7 @@ static int write_shared_index(struct index_state *istate,
 
 	trace2_region_enter_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
-	ret = do_write_index(si->base, *temp, 1);
+	ret = do_write_index(si->base, *temp, 1, flags);
 	trace2_region_leave_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
 
@@ -3357,7 +3364,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 			ret = do_write_locked_index(istate, lock, flags);
 			goto out;
 		}
-		ret = write_shared_index(istate, &temp);
+		ret = write_shared_index(istate, &temp, flags);
 
 		saved_errno = errno;
 		if (is_tempfile_active(temp))
-- 
gitgitgadget

