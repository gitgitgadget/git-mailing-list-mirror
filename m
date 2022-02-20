Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04521C433FE
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 01:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbiBTBaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 20:30:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239727AbiBTBaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 20:30:16 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53827527EF
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 17:29:56 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i14so20769467wrc.10
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 17:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=/EVLPcv3gwb87HclP8Pvre6fSdaEvHpNqTmJXCy3Dow=;
        b=QgNj6KEdqvIVre0cYV6Iv9EWCjoYQsmubaRpbo7jkUN7GDfe3kDu1yu8TJeGIWjP18
         C+MtBV612sd6fVTW+DjXPGWpZk2y8ATrHVv1aDAACiSFV0XlQ5MVL34QmCuKY1lFCKO+
         YokyR7kuDOFThyPWvlINmeG0YqJtqPcsoAQinOTZRAKaR4wNi2niCdNI3g+nJKfM3/Ji
         JnTj1Ria1LyG+HIeywm1NEo7Qt14UbJ58ki1FSWRwdDW55zop2xBr1slrwil0sDTuP4I
         rUn6fT5fRHWPL2CQkcvSMALZ32DaJ8Wi7vF15CdRyYfwyTRZJwW233jZtNLLu0IJnfoN
         DFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=/EVLPcv3gwb87HclP8Pvre6fSdaEvHpNqTmJXCy3Dow=;
        b=RUxshnEmivW/vXWrfNC0XVQa//khAxVx+DPlOOKVivWuf3tFzEM3rXTvPKFTZ6CHEy
         6pdkdEhbq7DXiMXAdUQFLJMoNMMcN2lrviTSU6olul4R0yUN2oARsg1khmqqaQvoZMfA
         i5V3ZkLrEVFZvJd4SMN/9rI3GFsDtCS937KonrVoHSEpKqUZBbLTMXnPkzJbrA5XHfxC
         7GdvcXjhzsRp0azlToMad2WvYIZCKu/FTZ6A5rXeOIkw5XGtiphMJWPs8KMUBjalMDcU
         w0+F6u6rIJ+CWngfyLByZFdSIQEOoKz3dZkpQu3CTLzqoZKRSN/esBbEpenvB6IG1C+K
         ApoA==
X-Gm-Message-State: AOAM530xHcNagdUChAdkOafU/e2PUNWMhz6SC1EDN3Nmgr8/Wtr5Isd1
        njcBw8+S6qbQu+c7lc7ukf1hDXg+b3o=
X-Google-Smtp-Source: ABdhPJzgWZu8zQHRWNRyNw1qOHQWNAOr8lvpWs7f2Se8M6RnZ6nHK0Cmt8hd1n3H+mxO5zVO0pSJ1g==
X-Received: by 2002:a05:6000:1c5:b0:1e4:a915:9e5d with SMTP id t5-20020a05600001c500b001e4a9159e5dmr10735295wrx.106.1645320594300;
        Sat, 19 Feb 2022 17:29:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9sm26408345wrx.76.2022.02.19.17.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 17:29:53 -0800 (PST)
Message-Id: <f1f7fc97fe2fe5079365bb91c71fb7033378995d.1645320592.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v2.git.1645320591.gitgitgadget@gmail.com>
References: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
        <pull.1152.v2.git.1645320591.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 01:29:50 +0000
Subject: [PATCH v2 1/2] merge-ort: fix small memory leak in
 detect_and_process_renames()
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

detect_and_process_renames() detects renames on both sides of history
and then combines these into a single diff_queue_struct.  The combined
diff_queue_struct needs to be able to hold the renames found on either
side, and since it knows the (maximum) size it needs, it pre-emptively
grows the array to the appropriate size:

	ALLOC_GROW(combined.queue,
		   renames->pairs[1].nr + renames->pairs[2].nr,
		   combined.alloc);

It then collects the items from each side:

	collect_renames(opt, &combined, MERGE_SIDE1, ...)
	collect_renames(opt, &combined, MERGE_SIDE2, ...)

Note, though, that collect_renames() sometimes determines that some
pairs are unnecessary and does not include them in the combined array.
When it is done, detect_and_process_renames() frees this memory:

	if (combined.nr) {
                ...
		free(combined.queue);
        }

The problem is that sometimes even when there are pairs, none of them
are necessary.  Instead of checking combined.nr, just remove the
if-check; free() knows to skip NULL pointers.  This change fixes the
following memory leak, as reported by valgrind:

==PID== 192 bytes in 1 blocks are definitely lost in loss record 107 of 134
==PID==    at 0xADDRESS: malloc
==PID==    by 0xADDRESS: realloc
==PID==    by 0xADDRESS: xrealloc (wrapper.c:126)
==PID==    by 0xADDRESS: detect_and_process_renames (merge-ort.c:3134)
==PID==    by 0xADDRESS: merge_ort_nonrecursive_internal (merge-ort.c:4610)
==PID==    by 0xADDRESS: merge_ort_internal (merge-ort.c:4709)
==PID==    by 0xADDRESS: merge_incore_recursive (merge-ort.c:4760)
==PID==    by 0xADDRESS: merge_ort_recursive (merge-ort-wrappers.c:57)
==PID==    by 0xADDRESS: try_merge_strategy (merge.c:753)
==PID==    by 0xADDRESS: cmd_merge (merge.c:1676)
==PID==    by 0xADDRESS: run_builtin (git.c:461)
==PID==    by 0xADDRESS: handle_builtin (git.c:713)
==PID==    by 0xADDRESS: run_argv (git.c:780)
==PID==    by 0xADDRESS: cmd_main (git.c:911)
==PID==    by 0xADDRESS: main (common-main.c:52)

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index d85b1cd99e9..3d7f9feb6f7 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3086,12 +3086,11 @@ static int detect_and_process_renames(struct merge_options *opt,
 				      struct tree *side1,
 				      struct tree *side2)
 {
-	struct diff_queue_struct combined;
+	struct diff_queue_struct combined = { 0 };
 	struct rename_info *renames = &opt->priv->renames;
-	int need_dir_renames, s, clean = 1;
+	int need_dir_renames, s, i, clean = 1;
 	unsigned detection_run = 0;
 
-	memset(&combined, 0, sizeof(combined));
 	if (!possible_renames(renames))
 		goto cleanup;
 
@@ -3175,13 +3174,9 @@ simple_cleanup:
 		free(renames->pairs[s].queue);
 		DIFF_QUEUE_CLEAR(&renames->pairs[s]);
 	}
-	if (combined.nr) {
-		int i;
-		for (i = 0; i < combined.nr; i++)
-			pool_diff_free_filepair(&opt->priv->pool,
-						combined.queue[i]);
-		free(combined.queue);
-	}
+	for (i = 0; i < combined.nr; i++)
+		pool_diff_free_filepair(&opt->priv->pool, combined.queue[i]);
+	free(combined.queue);
 
 	return clean;
 }
-- 
gitgitgadget

