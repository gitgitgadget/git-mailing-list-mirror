Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF29C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 23:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbiCIXEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 18:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbiCIXE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 18:04:26 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADDD1066F6
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 15:03:25 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u10so5264364wra.9
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 15:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cjxUR2mJtVxsOIx6Eab4jEeqQQy3k4BYtli53r3TQcI=;
        b=AZ/hqiMCE+uXbu36kDZuJT2RDqAoFurcajdiHORehZ6PzT1WiFCt02hTf0p4ZlvrCg
         9OzjyAU3g0kk47fUmlItBFD1yK9vXIKlA8UFeWuZ1gdFAtgwk2sBSHKBldEOzVw4dxGh
         WjJu6Gm/Ws/pTIPQzGtLsPh9bVsRTCQ+GeB3qhK6BiLgLazLVzUe/rHodUeN8/ZyY0RI
         q11JAdZpM0b7OCP9XS+VT5zz1P7gAMw84ufO0lAaa/bAFZb2hv60o0Ww/8kR50B+GwUC
         xh4SePQ4zAakaEWaVeGNMwB38MtN+jcOZV1uLaRWN4pNYgY3n9dwh7ngiKelLFzXZ1p5
         bUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cjxUR2mJtVxsOIx6Eab4jEeqQQy3k4BYtli53r3TQcI=;
        b=zrUgdhHpgBuXi9/6YHArE/8oIrLYFfJYlkGi1ulC4btHbo2m7yVsm4g2RiFOSHObPF
         1rvQUhk2Pm2EulpYItnwEnX/wUqDC64USbe6qpWqXi19CTK+DuOQEhD1ybBipO5FK/HW
         ObZSXGD7DRQ7v1YurUg1SW2BiKbs7bD72gNtF0dXxFOKB6KGKaNnYg+ltznCaTySqpMT
         az9Kdo4jl8T85NH6KKVXPlsqgWEeG4+CtxM+ni7ELXZgtsoRIAodq1B0CSbxHYb1vSo0
         vRalzLXQrQ8ItdyPWiWx7YiFCbRkU5aEwSFRAP7n8BsruJLuiR7gw9fo+cNRRs3CowEP
         QQsw==
X-Gm-Message-State: AOAM530ns/4ouUODg8KGAiHya864hhdSwu/w6K5MxmW2N7X2VX3f7S05
        4012ajBrG29dd3hL3fvlsxKQpdkjLZ8=
X-Google-Smtp-Source: ABdhPJxde5NaqodUGHv0vshV0nsAVnV2XYgc2P6q+cJLTVDw4gy7/HGqz5kWaZlqg4rvx5d0jQcgNg==
X-Received: by 2002:a5d:64a6:0:b0:203:66a0:474d with SMTP id m6-20020a5d64a6000000b0020366a0474dmr1432236wrp.392.1646867004247;
        Wed, 09 Mar 2022 15:03:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d6707000000b001f067c7b47fsm4115599wru.27.2022.03.09.15.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 15:03:23 -0800 (PST)
Message-Id: <9da808ba743673bb0c40b127fed7dd34c87d232d.1646866998.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
        <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 23:03:17 +0000
Subject: [PATCH v5 4/5] core.fsync: new option to harden the index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
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
index a5eaa60a7a8..3fefe8f6f60 100644
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
index 51a35715642..bb44f6f506d 100644
--- a/config.c
+++ b/config.c
@@ -1331,6 +1331,7 @@ static const struct fsync_component_entry {
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

