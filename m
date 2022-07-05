Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95571C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 01:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiGEBd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 21:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiGEBdy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 21:33:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1436DEA3
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 18:33:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z12so5821251wrq.7
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 18:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AxzoeF7yxKuO2ENG2h5ng4XglA2GKbSgkHokpO7INQk=;
        b=HmSgaSx167jEqkQo4qG9uebPUABWIPwM+Obvjwon0vfntVgWbSm6ZGDR8OVz7IJg18
         RIOa2rg6Jsq2dlBwKRXzaukm1XURKaIrX9CWE8cm2zX8cAu8R5dWnB5e2b3iLTqigLoV
         X4CSLhTFoc5knVhru+FgieXFcHXa/OA2Qo1G90//9T6JUsWcdxKaFn/cWR+Ke5bQwEuU
         OADZh8EZp4SeA8c3+8zl4Ktw7inJtRdEaQN+X2QNcjegwwGOb1pKeNQnbETHvG6jwaHT
         8egmR/1Jd4bjYkVr8q/+QS+/Cf77Ammn5gHnb8DVVgU37nMB8Zm1tHgf/Qj8Bp6EeWDU
         8Spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AxzoeF7yxKuO2ENG2h5ng4XglA2GKbSgkHokpO7INQk=;
        b=y4vVFF+am/mSoJdhB5tAlC4LjESYvTmVAPGJupIxnNqtaZLRKy64ReC2nKoYE3vqP0
         MYi/q1N2seNCG8yGfvF++E6JEOkr5vYSXgVlpB6jBYycD0+kVaQikIvTLIwkWf1+MojE
         EdMriLjPjDKmfQi7jhHeFaxO/RC48XoTuQR6Zdju+iVpvWWdpyquIn29pTefM4n5DDak
         NYY+tVjwwPL4HVccu/BrBaSY7rzpyguOm3RhjKRSYgBvUMElouuCLv++SxCP0jAM+UBS
         6V6Hic0KKHx2D5UsXI2U2mXzD3MqLDGlMYHlJjLwCTuQ4FAUTPpgGp6OflSXiqT5azQa
         nOfg==
X-Gm-Message-State: AJIora/97p7+pTnxgWi6mCPFpXfTztAzLX2Ojq5Vd+s9IL7u+HL+vOX7
        QB7XC4BzATSIyBNF9afBSgaaik4O610=
X-Google-Smtp-Source: AGRyM1uc0noc836dNGRGRJoo4CPSx0gVHe1vLGhL8k3LsbfXlIN0FH1hrDE0j9H3keOQ+8dCIwfMQg==
X-Received: by 2002:a5d:6e8d:0:b0:21d:7223:1e1b with SMTP id k13-20020a5d6e8d000000b0021d72231e1bmr758328wrz.713.1656984830935;
        Mon, 04 Jul 2022 18:33:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8-20020a7bc3c8000000b003a050a391e8sm21189904wmj.38.2022.07.04.18.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 18:33:50 -0700 (PDT)
Message-Id: <f5f87acbbd281966288968288ed78fe053933786.1656984823.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v4.git.1656984823.gitgitgadget@gmail.com>
References: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
        <pull.1268.v4.git.1656984823.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jul 2022 01:33:41 +0000
Subject: [PATCH v4 3/5] merge-ort: make a separate function for freeing struct
 collisions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@palantir.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@palantir.com>

This commit makes no functional changes, it's just some code movement in
preparation for later changes.

Signed-off-by: Elijah Newren <newren@palantir.com>
---
 merge-ort.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index ff037cca8d2..1514dd173c0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2259,6 +2259,27 @@ static void compute_collisions(struct strmap *collisions,
 	}
 }
 
+static void free_collisions(struct strmap *collisions)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	/* Free each value in the collisions map */
+	strmap_for_each_entry(collisions, &iter, entry) {
+		struct collision_info *info = entry->value;
+		string_list_clear(&info->source_files, 0);
+	}
+	/*
+	 * In compute_collisions(), we set collisions.strdup_strings to 0
+	 * so that we wouldn't have to make another copy of the new_path
+	 * allocated by apply_dir_rename().  But now that we've used them
+	 * and have no other references to these strings, it is time to
+	 * deallocate them.
+	 */
+	free_strmap_strings(collisions);
+	strmap_clear(collisions, 1);
+}
+
 static char *check_for_directory_rename(struct merge_options *opt,
 					const char *path,
 					unsigned side_index,
@@ -3029,8 +3050,6 @@ static int collect_renames(struct merge_options *opt,
 	int i, clean = 1;
 	struct strmap collisions;
 	struct diff_queue_struct *side_pairs;
-	struct hashmap_iter iter;
-	struct strmap_entry *entry;
 	struct rename_info *renames = &opt->priv->renames;
 
 	side_pairs = &renames->pairs[side_index];
@@ -3076,20 +3095,7 @@ static int collect_renames(struct merge_options *opt,
 		result->queue[result->nr++] = p;
 	}
 
-	/* Free each value in the collisions map */
-	strmap_for_each_entry(&collisions, &iter, entry) {
-		struct collision_info *info = entry->value;
-		string_list_clear(&info->source_files, 0);
-	}
-	/*
-	 * In compute_collisions(), we set collisions.strdup_strings to 0
-	 * so that we wouldn't have to make another copy of the new_path
-	 * allocated by apply_dir_rename().  But now that we've used them
-	 * and have no other references to these strings, it is time to
-	 * deallocate them.
-	 */
-	free_strmap_strings(&collisions);
-	strmap_clear(&collisions, 1);
+	free_collisions(&collisions);
 	return clean;
 }
 
-- 
gitgitgadget

