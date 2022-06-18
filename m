Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19723C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383710AbiFRAVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383657AbiFRAVK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DA159940
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a10so3002933wmj.5
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CcJkWnEFnOZJo37/Id2fDAEn7q90VLqUiJDTNnkGQco=;
        b=nQP5p9+/ClATQJammKPduc7mnjIgg/mWhpLUEfN9G4UzQ5eg1sJtBRKMr04g+TgVh5
         CzHafSPWALN/Rn8LJQV7xS9ZWPb9A9o3FIIAW/q96NWBYWfja5MTm6EIj4H6wRQvLXBk
         nNPj7ESlV77RKFrjajWncMHetHuLpf/DgCsEGuIyaXaHU1T1wVCBELoa3VKZensh579o
         qpIkr++XatC7zidv4GFnGvTTxcWkOZjWWrrPD3JrDYNFIZmo7thxwTyYlpYW5w7BYkNy
         PyHlXkACB7HHpYo3H6SH/hYFTLvWC8MYMew2aELtngKrnGq3mdWjB6rsJ/Ud2iaX9rtH
         j2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CcJkWnEFnOZJo37/Id2fDAEn7q90VLqUiJDTNnkGQco=;
        b=Gtg3oX+eNa83qyd7V4GCAokPHF1CZzMpHNOM47GmfO1ek/77bLstY0odVnPf8hJrkh
         xkOAL4RRfAzutrlLJ474xhLrhKy0k5HIU6/vnOhogjloTty4nKS3AzbbjOuIFGIeG+6K
         L5QOylGdaKZIUkNSfx5QzfY1XYcR0i8G+y6d3hOq8G6heDtKMGQ/W9WtW46dGsLV6Wcn
         o4FFu2jCgwz2vbC8T9BAoiQveI8Udfu4wtYOqvpEyr2pYm6tgO4seg7bIJXOwNA4jWrb
         JbWvs5ZluqXIdhDDIJI15pS3YBrHemyVYl94XDtC2IjXdldurUbaCXCd28jGlaRgXzn6
         t8Vg==
X-Gm-Message-State: AJIora9FlZb0y0mrWC5MXbNxCS+OlKHVChLFCncrFgACkvmoqkDJZFFj
        rJ2agsFTpRmX0rR3P7+EXDskL/bZyEN5yg==
X-Google-Smtp-Source: AGRyM1tsEct64cZ1d5mObgpmynEDCCjaky0vvLGTac5pZBRWtaqa5xmzrh2TdKYTilve81ziZZe/OA==
X-Received: by 2002:a1c:f213:0:b0:39b:ad32:5e51 with SMTP id s19-20020a1cf213000000b0039bad325e51mr12518360wmc.72.1655511668580;
        Fri, 17 Jun 2022 17:21:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b0039c50d2d28csm10798190wmq.44.2022.06.17.17.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:08 -0700 (PDT)
Message-Id: <069af1ecc303b38b18f053c040416954097f2ee4.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:48 +0000
Subject: [PATCH v7 05/17] merge-ort: split out a separate
 display_update_messages() function
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

This patch includes no new code; it simply moves a bunch of lines into a
new function.  As such, there are no functional changes.  This is just a
preparatory step to allow the printed messages to be handled differently
by other callers, such as in `git merge-tree --write-tree`.

(Patch best viewed with
     --color-moved --color-moved-ws=allow-indentation-change
 to see that it is a simple code movement.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 78 ++++++++++++++++++++++++++++-------------------------
 merge-ort.h |  8 ++++++
 2 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 0d3f42592fb..b9c9e906e94 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4256,6 +4256,45 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 	return errs;
 }
 
+void merge_display_update_messages(struct merge_options *opt,
+				   struct merge_result *result)
+{
+	struct merge_options_internal *opti = result->priv;
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+	struct string_list olist = STRING_LIST_INIT_NODUP;
+	int i;
+
+	if (opt->record_conflict_msgs_as_headers)
+		BUG("Either display conflict messages or record them as headers, not both");
+
+	trace2_region_enter("merge", "display messages", opt->repo);
+
+	/* Hack to pre-allocate olist to the desired size */
+	ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
+		   olist.alloc);
+
+	/* Put every entry from output into olist, then sort */
+	strmap_for_each_entry(&opti->output, &iter, e) {
+		string_list_append(&olist, e->key)->util = e->value;
+	}
+	string_list_sort(&olist);
+
+	/* Iterate over the items, printing them */
+	for (i = 0; i < olist.nr; ++i) {
+		struct strbuf *sb = olist.items[i].util;
+
+		printf("%s", sb->buf);
+	}
+	string_list_clear(&olist, 0);
+
+	/* Also include needed rename limit adjustment now */
+	diff_warn_rename_limit("merge.renamelimit",
+			       opti->renames.needed_limit, 0);
+
+	trace2_region_leave("merge", "display messages", opt->repo);
+}
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
@@ -4293,43 +4332,8 @@ void merge_switch_to_result(struct merge_options *opt,
 		fclose(fp);
 		trace2_region_leave("merge", "write_auto_merge", opt->repo);
 	}
-
-	if (display_update_msgs) {
-		struct merge_options_internal *opti = result->priv;
-		struct hashmap_iter iter;
-		struct strmap_entry *e;
-		struct string_list olist = STRING_LIST_INIT_NODUP;
-		int i;
-
-		if (opt->record_conflict_msgs_as_headers)
-			BUG("Either display conflict messages or record them as headers, not both");
-
-		trace2_region_enter("merge", "display messages", opt->repo);
-
-		/* Hack to pre-allocate olist to the desired size */
-		ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
-			   olist.alloc);
-
-		/* Put every entry from output into olist, then sort */
-		strmap_for_each_entry(&opti->output, &iter, e) {
-			string_list_append(&olist, e->key)->util = e->value;
-		}
-		string_list_sort(&olist);
-
-		/* Iterate over the items, printing them */
-		for (i = 0; i < olist.nr; ++i) {
-			struct strbuf *sb = olist.items[i].util;
-
-			printf("%s", sb->buf);
-		}
-		string_list_clear(&olist, 0);
-
-		/* Also include needed rename limit adjustment now */
-		diff_warn_rename_limit("merge.renamelimit",
-				       opti->renames.needed_limit, 0);
-
-		trace2_region_leave("merge", "display messages", opt->repo);
-	}
+	if (display_update_msgs)
+		merge_display_update_messages(opt, result);
 
 	merge_finalize(opt, result);
 }
diff --git a/merge-ort.h b/merge-ort.h
index fe599b87868..e5aec45b18f 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -80,6 +80,14 @@ void merge_switch_to_result(struct merge_options *opt,
 			    int update_worktree_and_index,
 			    int display_update_msgs);
 
+/*
+ * Display messages about conflicts and which files were 3-way merged.
+ * Automatically called by merge_switch_to_result() with stream == stdout,
+ * so only call this when bypassing merge_switch_to_result().
+ */
+void merge_display_update_messages(struct merge_options *opt,
+				   struct merge_result *result);
+
 /* Do needed cleanup when not calling merge_switch_to_result() */
 void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result);
-- 
gitgitgadget

