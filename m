Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF43C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 06:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiBTGzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 01:55:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiBTGzM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 01:55:12 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4322735878
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:49 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u1so21507385wrg.11
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hBf1L3DAgwM6lVnjfgVq6LC6AtXTGHUlM38V8n4wdp8=;
        b=qL1I1EFC/3BKfpCZ16znjxuhe0hb+kfiWjcoTLG2OZiEchWVfcfBj4B376Pp4M16SA
         chCXnUJajlgeVuX6dsn4t80qzfSq92CiSlIrzj+Opxl+X4ZLc9Y0EYsM5HsWrttqsbON
         h2G0el9wPfSo/S4H8r58iq1DcotChkhYRudCz/DarCdLeNQsVw6r2bwRfzIRR+5f+ZhJ
         ugP9Pg7YVcKAdQcOuOetIy1LmQgeTMhQaEoIDfGLJhfjRdKbY+blTKCQpZUhMWMKzpaf
         fx438Zx57W2K+rQUSJwUDD6WUkHs9ipOSky2WeweeloMBBErek5MpFtOe96ccMd6neLi
         WyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hBf1L3DAgwM6lVnjfgVq6LC6AtXTGHUlM38V8n4wdp8=;
        b=DeAevvociISP28rY+qhKr4yLJqPREvebup8flSBSS1M5oHL2T197M4K4dQSHKm6C53
         PtI32AuVcbw1rcG4U8hNE4M50HEi3jxKH5wlqjYrE0+3fYCIYPs9NvvuCrSHyc8oUDR0
         XfhRMJoYM9rnEV14flkIqilJu7NDAWXdfN5Z/GihBF5nH3l6fR2+Y/7JKNz6oR2kUBE4
         CXXpYEtqrMvVMoi6lbHgdGgLzd+vXgSo6HHd80YYduYtqSYRxWKNLTqwww3B6LFaSOiw
         dgDAHma62HjyDyDFsHyJqDvGgDMoVxPa7qunWnLvQZK2PM0GRM4W1F71DK/TA06fxMx7
         JyXQ==
X-Gm-Message-State: AOAM531qwHU6pi7n4yW0RR4T3q50tMmpLb6sKhanyHYj1eZesuMxc8Pz
        cKZiGPyZcv5xGCsCPLIRlWdo8tIxsjc=
X-Google-Smtp-Source: ABdhPJzWNq2xI/nFJLn2abW8UjrSCZRQjI6Lb69Zc1BrHwgD6D466+BZWJ27k+BI4C9lBRfTS6+tDw==
X-Received: by 2002:adf:d1ed:0:b0:1e9:e7ae:f505 with SMTP id g13-20020adfd1ed000000b001e9e7aef505mr1872650wrd.161.1645340087630;
        Sat, 19 Feb 2022 22:54:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d6sm45634092wrs.85.2022.02.19.22.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 22:54:47 -0800 (PST)
Message-Id: <e0f95e094cfa5b63c8a1da56156725fc560b29e2.1645340082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
        <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 06:54:35 +0000
Subject: [PATCH v5 05/12] merge-ort: split out a separate
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
index 9bf15a01db8..ebaed98d53a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4235,6 +4235,45 @@ static int record_conflicted_index_entries(struct merge_options *opt)
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
@@ -4272,43 +4311,8 @@ void merge_switch_to_result(struct merge_options *opt,
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

