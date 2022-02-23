Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5380AC4332F
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 07:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbiBWHrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbiBWHr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 02:47:28 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A46060CDD
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:47:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q23so3407292wra.2
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hBf1L3DAgwM6lVnjfgVq6LC6AtXTGHUlM38V8n4wdp8=;
        b=eeq/Xsne6vv3a4csdBMEWBY+SR9An3H7PeoBcegztBoW+FotPanx9TewqZmNo238Wk
         RfaJnLlCJSxmJLZK5aqIqqU2RFJCSwKPpYqTfnarNi9fLXmpEbzWMD6Vfp1JQAXkyqAW
         VfddOFqUxXxon+7dH3UeUqZxcmfHZlOZVWsbjAqpsmQbooUud++OgRbjxU2yvpBp0Rbb
         JSJdM5lmOd6Nu6Wn1cxKxwxrJK3UQV9cU0sGay3XerHeHo6jNmiPs9FqFy9el04ubsVU
         4TmYcSD0Wg8SCzEQSDn7EKvJshl/+i5lQ92Usb6f0a8fAKML4JIoiqoD6rkxOGNl89Cs
         nQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hBf1L3DAgwM6lVnjfgVq6LC6AtXTGHUlM38V8n4wdp8=;
        b=DgNwDtFyqatghvH+XeVg1jYbpvMH7B6aDdTs6FWeYea1osPm3Rv6n59h8Z9+ONLlqF
         BPTR5NpU0fvPaIMmS4krDGEGg4e8t006m+r/k278DWHDMBH/zS632N1VklsSYzQXUlNC
         yYeKxfHT10XiKkjEDWFa7XfRLKnEeYUud9VWlXk+ke4iM8cVkSdfbJo7zGtV88HWwRKm
         Ff/i1H7zZdOhFjBNE3ijZCbfskNKnWBxu5CHbEPt+nhT4LJThA5TqdGMOv7wmJm0jB5y
         YdR8V701fZVBHU5NlGLji8DfIZ85dFRiH0EKa14l1bhEXbhA23qxN9N77h7bbK0AQrxO
         sJHw==
X-Gm-Message-State: AOAM533tfsamDohpUeIHN8lh7Ik3+vB5GkPUIJsjn9awtKdI/tpwNA1B
        InMnhXjBtkmAUC5v9Tx3De09QS+CGgg=
X-Google-Smtp-Source: ABdhPJyvd8ZUJPsS9zwd5/ukKOCuSk/P7vXxTWB6Ec42SclTas3AkNhWgebu+QI7Pv4LLH7goR1ogg==
X-Received: by 2002:a5d:53cb:0:b0:1e7:5e87:9c6c with SMTP id a11-20020a5d53cb000000b001e75e879c6cmr22982233wrw.696.1645602419647;
        Tue, 22 Feb 2022 23:46:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm49073967wro.106.2022.02.22.23.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:46:59 -0800 (PST)
Message-Id: <6629af14919a5133c656a0592a18e2adb8925dc4.1645602413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
References: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
        <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 07:46:46 +0000
Subject: [PATCH v6 05/12] merge-ort: split out a separate
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

