Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D96C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 01:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbiBTBaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 20:30:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241636AbiBTBaR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 20:30:17 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C55527F3
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 17:29:56 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so20772970wrg.11
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 17:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=lCRN3h6sS8T8NWNpkBpryka+UnPXafmbLgwNUU0D9gs=;
        b=ANlnR1DEtCyEEVJJZ2YGpwfzHkG5GP2KZ+umeE00IzwZWWtFf5Q0cZErQjoDZpIA+n
         KJtkuB2xvsU8jN35sFk+GwfmHYBpozc9EzatrAFuPvW+jJbeLjl6UX7AW89JAIN4NOIy
         4zx+UICN3l9gBg5CSLDTt0bU4Ip4YuU7+LW3ir5T5vUTQzQyLymmzxNmAslVorjWYBrK
         Q00WvfgJbvuG0sHhmslglXQKwjQ1PUH2ujYQmYUYEhqBYMWIrxCuikKjks6CHodTmr8d
         B2XIAB14R10+wSU3s81/anZLFg2iRcDzAHZbQ81nfGjKCwxK+NudCYMjm8kkyryb7cr9
         3Rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=lCRN3h6sS8T8NWNpkBpryka+UnPXafmbLgwNUU0D9gs=;
        b=Kv/tPJshrK4ykK2yDCQlXjtr5zwL3Hs+tBnP3wlmd/6gvaHdfSV86t9SdMvLwuXDQo
         C59zHk/KZj7dajZFI3VIDupTUzOs0EzY6nuYddOcGu5n6vsTlTwfRI5BV8kNraMXY/WC
         TqJsTPqbgEPCmpmtXXJdazKUHRZ6P5s+vptbWr9E4cWpepD8qEIe6/fAgWgYmRsLhtgw
         /qfQDC9RHFgKdo8eUuGXymtrwRHYzw2AKgUQO0mSyfCoxhTUg3V8YpB1M/4HdFwqoHFq
         PVKdE8vNqfMz4fyxJS0J0Whp9LgiciYHtmO2jekN3NQJobRA4zkldtNLbLWrlMcTWvuf
         PJIw==
X-Gm-Message-State: AOAM532lHWhxmHYpSG8jzY86hAKrj5axdKLzPWHB/dw2zRXOYR2uCzrD
        1h2fS7e1rukmMkRAI0/t8LAD2SdCOxg=
X-Google-Smtp-Source: ABdhPJyWMf95hMvDAv+U+YFWDO8H8ZNFVJd49qMwQuMXXhjt78YQMOh1cufQuXUbJIdMINCSh6f3ig==
X-Received: by 2002:adf:ea4c:0:b0:1e4:b3a2:2159 with SMTP id j12-20020adfea4c000000b001e4b3a22159mr11211890wrn.347.1645320595130;
        Sat, 19 Feb 2022 17:29:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm3549022wmb.19.2022.02.19.17.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 17:29:54 -0800 (PST)
Message-Id: <69fb932c21dc88f6522e9ca98ef283e714496039.1645320592.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v2.git.1645320591.gitgitgadget@gmail.com>
References: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
        <pull.1152.v2.git.1645320591.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 01:29:51 +0000
Subject: [PATCH v2 2/2] merge-ort: fix small memory leak in unique_path()
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
index 3d7f9feb6f7..71134d51502 100644
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
@@ -3674,7 +3680,7 @@ static void process_entry(struct merge_options *opt,
 		 */
 		df_file_index = (ci->dirmask & (1 << 1)) ? 2 : 1;
 		branch = (df_file_index == 1) ? opt->branch1 : opt->branch2;
-		path = unique_path(&opt->priv->paths, path, branch);
+		path = unique_path(opt, path, branch);
 		strmap_put(&opt->priv->paths, path, new_ci);
 
 		path_msg(opt, path, 0,
@@ -3799,14 +3805,12 @@ static void process_entry(struct merge_options *opt,
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
@@ -4194,7 +4198,7 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 				struct stat st;
 
 				if (!lstat(path, &st)) {
-					char *new_name = unique_path(&opt->priv->paths,
+					char *new_name = unique_path(opt,
 								     path,
 								     "cruft");
 
@@ -4202,7 +4206,6 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 						 _("Note: %s not up to date and in way of checking out conflicted version; old copy renamed to %s"),
 						 path, new_name);
 					errs |= rename(path, new_name);
-					free(new_name);
 				}
 				errs |= checkout_entry(ce, &state, NULL, NULL);
 			}
-- 
gitgitgadget
