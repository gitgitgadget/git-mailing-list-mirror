Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398B0C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 07:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbiBWHrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238754AbiBWHrc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 02:47:32 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA956A01B
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:47:03 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso2099555wmi.0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ap4ZqYlnkgb+ZsEVT3Um4/EicxMnYbd2hGinYTe7EAw=;
        b=dbHB8geF2tk0PvN/9CzbDsJ6qNFUJlyFIkUiSTJNQyPrpDSUOGSmACuXZ/CTY6GA6D
         oV8nCk2xWxs8KMxbFRazQPMg/xxQoFc5aagQHci+01ODa+RUgg4hbTShq/bzSckdAkmd
         2P7VsRMf0Tjtj4/vgM8/TIiiV8IAJOtYmh2wI3MMFwi7TQhEPHf803T8v8V7URQYWY6O
         FP0da1UtheWjuVFXCuo4bE5UzmgGOvHyu2Sa188vth/B8AwY54knGnYEJdMHBetB0m58
         sgiv0x3LbOxSOBfCSVp8yeMAsyKnnkwkMQc5KGkTsjSD0H5lh5YlvME7D7EMxhU8jiry
         y4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ap4ZqYlnkgb+ZsEVT3Um4/EicxMnYbd2hGinYTe7EAw=;
        b=wHHFagFS0IJaiQ1R3HTzgczWlU5YpS4Aq9MYB8f7e9ksI5LcnVDrxbBPjbGcW3Cq6G
         3ipRxxYIuUdngKjlxGlOr2A17qv3dxyD/BQz31rm2+FnHbCb1yTIX3/n4vnEh8XLq8/N
         hO0K4HChAfhVx5zxrWq862UbP1B+bB2WH7q/20pZoUimCD7CbC51SMZotr31ehImJNIT
         6/ezAsnPqunUW7lTAnH7hieTqj6zUayNK59fl9Jed2eW5AWwOyLuK/PuIDD+WhGa/Qux
         UzQ61LkIMv2Cf4J5eDIJinqERMS/V0wtDrHAg7R9eUKsauO0GK5pI4CpRCitYlShMDa0
         pycA==
X-Gm-Message-State: AOAM5311Q90X2S21EMnND1R7NlosN6hfOU1BWRuknwYiI+5kA8bhX4UK
        QyJfJUFvPda/H9MssYuflTxMwhsFOEw=
X-Google-Smtp-Source: ABdhPJyQbYkKq066U2w3y4wY7bBsbLrpzqTH/bLhLsFnM8UoBETszfSKUVrjInxY2llnb6sdgsKUPg==
X-Received: by 2002:a05:600c:3d88:b0:380:f6d9:9461 with SMTP id bi8-20020a05600c3d8800b00380f6d99461mr1010662wmb.137.1645602421617;
        Tue, 22 Feb 2022 23:47:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm35280326wrn.51.2022.02.22.23.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:47:01 -0800 (PST)
Message-Id: <4c8f42372dda68230563d5f4d12c3bb2878ae979.1645602413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
References: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
        <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 07:46:48 +0000
Subject: [PATCH v6 07/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

After a merge, this function allows the user to extract the same
information that would be printed by `ls-files -u`, which means
files with their mode, oid, and stage.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 31 +++++++++++++++++++++++++++++++
 merge-ort.h | 21 +++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index ebaed98d53a..e1b647b0a40 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4274,6 +4274,37 @@ void merge_display_update_messages(struct merge_options *opt,
 	trace2_region_leave("merge", "display messages", opt->repo);
 }
 
+void merge_get_conflicted_files(struct merge_result *result,
+				struct string_list *conflicted_files)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+	struct merge_options_internal *opti = result->priv;
+
+	strmap_for_each_entry(&opti->conflicted, &iter, e) {
+		const char *path = e->key;
+		struct conflict_info *ci = e->value;
+		int i;
+
+		VERIFY_CI(ci);
+
+		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
+			struct stage_info *si;
+
+			if (!(ci->filemask & (1ul << i)))
+				continue;
+
+			si = xmalloc(sizeof(*si));
+			si->stage = i+1;
+			si->mode = ci->stages[i].mode;
+			oidcpy(&si->oid, &ci->stages[i].oid);
+			string_list_append(conflicted_files, path)->util = si;
+		}
+	}
+	/* string_list_sort() uses a stable sort, so we're good */
+	string_list_sort(conflicted_files);
+}
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
diff --git a/merge-ort.h b/merge-ort.h
index e5aec45b18f..ddcc39d7270 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -2,6 +2,7 @@
 #define MERGE_ORT_H
 
 #include "merge-recursive.h"
+#include "hash.h"
 
 struct commit;
 struct tree;
@@ -88,6 +89,26 @@ void merge_switch_to_result(struct merge_options *opt,
 void merge_display_update_messages(struct merge_options *opt,
 				   struct merge_result *result);
 
+struct stage_info {
+	struct object_id oid;
+	int mode;
+	int stage;
+};
+
+/*
+ * Provide a list of path -> {struct stage_info*} mappings for
+ * all conflicted files.  Note that each path could appear up to three
+ * times in the list, corresponding to 3 different stage entries.  In short,
+ * this basically provides the info that would be printed by `ls-files -u`.
+ *
+ * result should have been populated by a call to
+ * one of the merge_incore_[non]recursive() functions.
+ *
+ * conflicted_files should be empty before calling this function.
+ */
+void merge_get_conflicted_files(struct merge_result *result,
+				struct string_list *conflicted_files);
+
 /* Do needed cleanup when not calling merge_switch_to_result() */
 void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result);
-- 
gitgitgadget

