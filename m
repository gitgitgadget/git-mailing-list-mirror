Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED784C433FE
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 17:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242695AbiBSRK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 12:10:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242610AbiBSRK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 12:10:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10E4123421
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 09:10:06 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso8548869wme.1
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 09:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=CQsYWi4aLJZM6uPcO2DTded8zPxTtzHJS1afUrmnv18=;
        b=oW+FjT+OVfC3oNCWe9MO3s2IGjksDyiAQ6e5eQ21lyAq+150q4VMGMXFDnkk3ChYNX
         cAIYXCwxU9H06CJ5u9njS4nYNqzQMct3kT1CYzfwHrJQldgwaUnE/GVBxaNmqTZrkMkx
         SNNr00bMy4z58CPoUPspncwkSK/V1cgtj2BEB3VAqiSCWIXFW3nTawfj5opDsSdMaoDq
         wx5r+LpAgyEnTfjKJRiYvVsgXzHRizIrNOuVwD0+3G5qlAQMWJaXTk8Ks0gVJcaOOoY5
         oq2LevOkKRLpF7mPQYVSxUrden4n+sm604QDDXlkikLD1Z/dYKO8gX9PTKYj9QYiZUFd
         da3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=CQsYWi4aLJZM6uPcO2DTded8zPxTtzHJS1afUrmnv18=;
        b=cwBhYZ6Bih1Q/5LqR+0z7XACEduwh6KfLj2XxB+zNXSFLg4Pp4sF19hvrqufpBpg7P
         nno2RQH4cNEKmXGrWQoSoVanEGY5snU7z/PTVZ5Ik70cNLg79yRxVw3YFGHblyKvbnYF
         79Y3mNknklCi7/RSgBSMaZjrXkT7lYZn6dYFhxTUpWRX73DaMIryvUDw8aTCJuRO+wIp
         QtVibLK+RugP1t7/a4FM8m3w595Sfy3qATdBzEfxXVZErw7WUQ/QUxm7N/Ltp92Nlgxi
         a13uMgzrvEP42Bnditt+8arlsBZRnyojXkUaaYrXgWe78SWXEieUSzXyIGec2QIpEB8R
         8djg==
X-Gm-Message-State: AOAM530/MtUVx/SUUsBhrz6FM0FEZ0aCAmGEsLVnBT2dvpSfIHTMw86D
        g/D6H5I19AUZWKL8zoi5VJZJTJF854U=
X-Google-Smtp-Source: ABdhPJwBoEsyMnGmRQU+7PuEoKDR9vqlA3SoC+8E4JORgWPwNrdjCauV4owcjfkb2pvoRsuqC1CdFg==
X-Received: by 2002:a05:600c:414c:b0:37b:c80e:e3dc with SMTP id h12-20020a05600c414c00b0037bc80ee3dcmr15009325wmm.116.1645290604876;
        Sat, 19 Feb 2022 09:10:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c4f0c00b00352cf3078e6sm2938173wmq.22.2022.02.19.09.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 09:10:04 -0800 (PST)
Message-Id: <73bc1e5c5dffbe9c132ea786dd414ef2159967e3.1645290601.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
References: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Feb 2022 17:10:00 +0000
Subject: [PATCH 2/2] merge-ort: fix small memory leak in unique_path()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The struct strmap paths member of merge_options_internal is perhaps the
most central data structure to all of merge-ort.  Because all the paths
involved in the merge need to be kept until the merge is complete, this
"paths" data structure traditionally took responsibility for owning all
the allocated paths.  When the merge is over, those paths were free()d
as part of free()ing this strmap.

In commit 6697ee01b5d3 (merge-ort: switch our strmaps over to using
memory pools, 2021-07-30), we changed the allocations for pathnames to
come from a memory pool.  That meant the ownership changed slightly;
there were no individual free() calls to make, instead the memory pool
owned all those paths and they were free()d all at once.

Unfortunately unique_path() was written presuming the pre-memory-pool
model, and allocated a path on the heap and left it in the strmap for
later free()ing.  Modify it to return a path allocated from the memory
pool instead.

Note that there's one instance -- in record_conflicted_index_entries()
-- where the returned string from unique_path() was only used very
temporarily and thus had been immediately free()'d.  This codepath was
associated with an ugly skip-worktree workaround that has since been
better fixed by the in-flight en/present-despite-skipped topic.  This
workaround probably makes sense to excise once that topic merges down,
but for now, just remove the immediate free() and allow the returned
string to be free()d when the memory pool is released.

This fixes the following memory leak as reported by valgrind:

==PID== 65 bytes in 1 blocks are definitely lost in loss record 79 of 134
==PID==    at 0xADDRESS: malloc
==PID==    by 0xADDRESS: realloc
==PID==    by 0xADDRESS: xrealloc (wrapper.c:126)
==PID==    by 0xADDRESS: strbuf_grow (strbuf.c:98)
==PID==    by 0xADDRESS: strbuf_vaddf (strbuf.c:394)
==PID==    by 0xADDRESS: strbuf_addf (strbuf.c:335)
==PID==    by 0xADDRESS: unique_path (merge-ort.c:733)
==PID==    by 0xADDRESS: process_entry (merge-ort.c:3678)
==PID==    by 0xADDRESS: process_entries (merge-ort.c:4037)
==PID==    by 0xADDRESS: merge_ort_nonrecursive_internal (merge-ort.c:4621)
==PID==    by 0xADDRESS: merge_ort_internal (merge-ort.c:4709)
==PID==    by 0xADDRESS: merge_incore_recursive (merge-ort.c:4760)
==PID==    by 0xADDRESS: merge_ort_recursive (merge-ort-wrappers.c:57)
==PID==    by 0xADDRESS: try_merge_strategy (merge.c:753)

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 4f5abc558c5..40ae4dc4e92 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -722,13 +722,15 @@ static void add_flattened_path(struct strbuf *out, const char *s)
 			out->buf[i] = '_';
 }
 
-static char *unique_path(struct strmap *existing_paths,
+static char *unique_path(struct merge_options *opt,
 			 const char *path,
 			 const char *branch)
 {
+	char *ret = NULL;
 	struct strbuf newpath = STRBUF_INIT;
 	int suffix = 0;
 	size_t base_len;
+	struct strmap *existing_paths = &opt->priv->paths;
 
 	strbuf_addf(&newpath, "%s~", path);
 	add_flattened_path(&newpath, branch);
@@ -739,7 +741,11 @@ static char *unique_path(struct strmap *existing_paths,
 		strbuf_addf(&newpath, "_%d", suffix++);
 	}
 
-	return strbuf_detach(&newpath, NULL);
+	/* Track the new path in our memory pool */
+	ret = mem_pool_alloc(&opt->priv->pool, newpath.len + 1);
+	memcpy(ret, newpath.buf, newpath.len + 1);
+	strbuf_release(&newpath);
+	return ret;
 }
 
 /*** Function Grouping: functions related to collect_merge_info() ***/
@@ -3679,7 +3685,7 @@ static void process_entry(struct merge_options *opt,
 		 */
 		df_file_index = (ci->dirmask & (1 << 1)) ? 2 : 1;
 		branch = (df_file_index == 1) ? opt->branch1 : opt->branch2;
-		path = unique_path(&opt->priv->paths, path, branch);
+		path = unique_path(opt, path, branch);
 		strmap_put(&opt->priv->paths, path, new_ci);
 
 		path_msg(opt, path, 0,
@@ -3804,14 +3810,12 @@ static void process_entry(struct merge_options *opt,
 			/* Insert entries into opt->priv_paths */
 			assert(rename_a || rename_b);
 			if (rename_a) {
-				a_path = unique_path(&opt->priv->paths,
-						     path, opt->branch1);
+				a_path = unique_path(opt, path, opt->branch1);
 				strmap_put(&opt->priv->paths, a_path, ci);
 			}
 
 			if (rename_b)
-				b_path = unique_path(&opt->priv->paths,
-						     path, opt->branch2);
+				b_path = unique_path(opt, path, opt->branch2);
 			else
 				b_path = path;
 			strmap_put(&opt->priv->paths, b_path, new_ci);
@@ -4199,7 +4203,7 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 				struct stat st;
 
 				if (!lstat(path, &st)) {
-					char *new_name = unique_path(&opt->priv->paths,
+					char *new_name = unique_path(opt,
 								     path,
 								     "cruft");
 
@@ -4207,7 +4211,6 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 						 _("Note: %s not up to date and in way of checking out conflicted version; old copy renamed to %s"),
 						 path, new_name);
 					errs |= rename(path, new_name);
-					free(new_name);
 				}
 				errs |= checkout_entry(ce, &state, NULL, NULL);
 			}
-- 
gitgitgadget
