Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C423E20248
	for <e@80x24.org>; Fri, 22 Feb 2019 22:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfBVWZP (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 17:25:15 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:46189 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfBVWZO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 17:25:14 -0500
Received: by mail-ed1-f53.google.com with SMTP id f2so3061864edy.13
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 14:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tvKTJiXAJRbFolLQ69BmhTNP+L5fZ0jkQWuYo1oYtd0=;
        b=nlK6dgi+DFQW/8g8V/6SoltlZ+8mJ/yiMzipiTSlEnJltkETSjRqoJBfmTOhukfrvl
         0cUN3tY+DjfRqAXM5Z4efIUYOFDj7O7a+ZfP+bjDUJ98iQ4xnMk408arSYWZKGoGbfeM
         pkfcr+7QvccmhC6mv7S1iXgy0fdtgGY05JRVVSVhn9mYPYWy6QEQ/vGmd4ffO3i1vhEq
         QF7lqVTAVmOwT35DTHH/m861DTtCjIJuHDfp8+fqvsuJtftGjsI6TBgE3Cek8erNYhCS
         aNxYrJU2n6sQZ1tcgxfMd2BM/KMcUPbYrxrtZ2eVqY6DXy3SBO/ddYauTBmkKR7RGS/C
         Fb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tvKTJiXAJRbFolLQ69BmhTNP+L5fZ0jkQWuYo1oYtd0=;
        b=JUgNV9GrTgBbLLyaLZIs5KHOmgU7IPppJHu6NITUIbN9Gv/XLDLJk2tYFW30PRD8OG
         DgTz4isRZ/rPNnzw270Apl07HLRsFaKMO9smc7ufgf0RBISjknxXGKynsCcyg5nijY0h
         qwOfPmnz0b8OfS/fTajMu9c4QMRPpXlWb1/CuGSQt3kDuAGPhkFmi9+YkmCBbmQYtYN4
         pVA2YfrczbdmN21ZV5s/9NGTldmOEARAJ0CyzEpXWgiSnG/jm+AR9chtd+m2hCtONphp
         sAAwAybdJyX2ASbVZ2nbUp7gyLtkdUF2ux9fYLkdlJ/C2GHS3havRc/VJTc6vpZssKew
         b31g==
X-Gm-Message-State: AHQUAuad70ucqzJyvTu5yZ3+vR1MmZpT3LxSyONWtUODsQPIydrBgDIX
        39VMrbT3/l/mKP6i2PNpIJmHXOXN
X-Google-Smtp-Source: AHgI3IaSDD8jd+jbSe8bgbq14xFBuA0bShltoF+Gx4u0RuEfycvcjnrJRT4Fu2Sr4HBUa6YvJ3cPhQ==
X-Received: by 2002:a05:6402:6d7:: with SMTP id n23mr4948151edy.233.1550874307693;
        Fri, 22 Feb 2019 14:25:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm683981edf.92.2019.02.22.14.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:25:07 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:25:07 -0800 (PST)
X-Google-Original-Date: Fri, 22 Feb 2019 22:24:52 GMT
Message-Id: <08be5aadbef7f6b404d2e1c47cf3657ced585ba1.1550874298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v7.git.gitgitgadget@gmail.com>
References: <pull.108.v6.git.gitgitgadget@gmail.com>
        <pull.108.v7.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v7 09/15] trace2:data: add trace2 instrumentation to index
 read/write
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2 events to measure reading and writing the index.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index bfff271a3d..240531d70d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2232,6 +2232,16 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		load_index_extensions(&p);
 	}
 	munmap((void *)mmap, mmap_size);
+
+	/*
+	 * TODO trace2: replace "the_repository" with the actual repo instance
+	 * that is associated with the given "istate".
+	 */
+	trace2_data_intmax("index", the_repository, "read/version",
+			   istate->version);
+	trace2_data_intmax("index", the_repository, "read/cache_nr",
+			   istate->cache_nr);
+
 	return istate->cache_nr;
 
 unmap:
@@ -2263,9 +2273,17 @@ int read_index_from(struct index_state *istate, const char *path,
 	if (istate->initialized)
 		return istate->cache_nr;
 
+	/*
+	 * TODO trace2: replace "the_repository" with the actual repo instance
+	 * that is associated with the given "istate".
+	 */
+	trace2_region_enter_printf("index", "do_read_index", the_repository,
+				   "%s", path);
 	trace_performance_enter();
 	ret = do_read_index(istate, path, 0);
 	trace_performance_leave("read cache %s", path);
+	trace2_region_leave_printf("index", "do_read_index", the_repository,
+				   "%s", path);
 
 	split_index = istate->split_index;
 	if (!split_index || is_null_oid(&split_index->base_oid)) {
@@ -2281,7 +2299,11 @@ int read_index_from(struct index_state *istate, const char *path,
 
 	base_oid_hex = oid_to_hex(&split_index->base_oid);
 	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
+	trace2_region_enter_printf("index", "shared/do_read_index",
+				   the_repository, "%s", base_path);
 	ret = do_read_index(split_index->base, base_path, 1);
+	trace2_region_leave_printf("index", "shared/do_read_index",
+				   the_repository, "%s", base_path);
 	if (!oideq(&split_index->base_oid, &split_index->base->oid))
 		die(_("broken index, expect %s in %s, got %s"),
 		    base_oid_hex, base_path,
@@ -2988,6 +3010,16 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 	trace_performance_since(start, "write index, changed mask = %x", istate->cache_changed);
+
+	/*
+	 * TODO trace2: replace "the_repository" with the actual repo instance
+	 * that is associated with the given "istate".
+	 */
+	trace2_data_intmax("index", the_repository, "write/version",
+			   istate->version);
+	trace2_data_intmax("index", the_repository, "write/cache_nr",
+			   istate->cache_nr);
+
 	return 0;
 }
 
@@ -3007,7 +3039,18 @@ static int commit_locked_index(struct lock_file *lk)
 static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
 				 unsigned flags)
 {
-	int ret = do_write_index(istate, lock->tempfile, 0);
+	int ret;
+
+	/*
+	 * TODO trace2: replace "the_repository" with the actual repo instance
+	 * that is associated with the given "istate".
+	 */
+	trace2_region_enter_printf("index", "do_write_index", the_repository,
+				   "%s", lock->tempfile->filename.buf);
+	ret = do_write_index(istate, lock->tempfile, 0);
+	trace2_region_leave_printf("index", "do_write_index", the_repository,
+				   "%s", lock->tempfile->filename.buf);
+
 	if (ret)
 		return ret;
 	if (flags & COMMIT_LOCK)
@@ -3092,7 +3135,13 @@ static int write_shared_index(struct index_state *istate,
 	int ret;
 
 	move_cache_to_base_index(istate);
+
+	trace2_region_enter_printf("index", "shared/do_write_index",
+				   the_repository, "%s", (*temp)->filename.buf);
 	ret = do_write_index(si->base, *temp, 1);
+	trace2_region_enter_printf("index", "shared/do_write_index",
+				   the_repository, "%s", (*temp)->filename.buf);
+
 	if (ret)
 		return ret;
 	ret = adjust_shared_perm(get_tempfile_path(*temp));
-- 
gitgitgadget

