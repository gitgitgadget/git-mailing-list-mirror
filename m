Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5100ECCA479
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383815AbiFRAVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383753AbiFRAVa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCED694B0
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e25so3651025wrc.13
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FrwOd8OrO4nYNpu/ilYgrOx3eNO/WHAbShED3LrPe7s=;
        b=X0+vjKbP2nG9MqebFQr9+7vjSNnUnLP6wCbbqIcXiOuYsID44wg94mTu275eUFSj6e
         el46mZZOAAyd+O5RDM9SlQKdRmliDp98tjRWTpUo6+ynNjI2qPW0EjFsLQdVeWgzOvyX
         S9ANX7qf030swApNvhnhkF5yw+PaxKX1Z5nFEIKcP0tzCIt+cz17ucQBplvgyDgCAd3P
         /szRGt1V0M1l4+RmOkRaUGba+iB77bGsfdYZNaJjl5Dxl5iQouWUdJNqFTBmS0BGSv7E
         xiQ2HCa73tALAkNHBgOqqDqd5thq5q6CbVnSbsp279y7Lmg+Kl75Ip11GaAOKfNXIM9Q
         fPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FrwOd8OrO4nYNpu/ilYgrOx3eNO/WHAbShED3LrPe7s=;
        b=aoeZGjTPXIK76MrU36l73gM/1yysVlQOE0HVqfQvy3z0bzBMiWTzoabrvovEeoUcnu
         D2pNIFDji+4vI1GdfuH7KadsmGveJ3XrXeCUP/sEGi/uLsTpCGqGYWZt+k6x7A49RwfT
         JYnjDtBxSNCpJV0lRjED8Gv7YzbQH26tevofFkLKD7VOyEUezQ/Vs8Mexlq1oaVAtbB4
         LhtQ0XQTjf8jcb/81Fk8K5pxwFLOzWpR3iTZ2jbwt70bJrd9VQ9a4ptUDCBtyfd+mrLE
         O+y52Fl5EU676RDnbikv4dqH3WJSqlhHO1ywipGW/uI4YJJmX5DlLgAgOozDNliUO7Br
         7UGA==
X-Gm-Message-State: AJIora/o4UYZ7ssVbwxONznHVj+vb2vFQi+QJq/u5KALhRYkEdQAUXLi
        Tm5Yy29585eVAO+ha0p3OLDWS0HWMIY47w==
X-Google-Smtp-Source: AGRyM1uMwxdBjp6p3lj+D4gJGGypoF2VnF1rKj4y6HSbLDHLBvgBz6q6t8R5GONA2EZDtotSAvfZ/w==
X-Received: by 2002:a5d:5a86:0:b0:218:4929:3dad with SMTP id bp6-20020a5d5a86000000b0021849293dadmr11354314wrb.338.1655511679938;
        Fri, 17 Jun 2022 17:21:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t22-20020a05600c41d600b0039db7f1a3f5sm6702538wmh.45.2022.06.17.17.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:19 -0700 (PDT)
Message-Id: <662e97f2ed4b6a0698bb86493efc3650763600d3.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:57 +0000
Subject: [PATCH v7 14/17] merge-ort: optionally produce machine-readable
 output
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

With the new `detailed` parameter, a new mode can be triggered when
displaying the merge messages: The `detailed` mode prints NUL-delimited
fields of the following form:

	<path-count> NUL <path>... NUL <conflict-type> NUL <message>

The `<path-count>` field determines how many `<path>` fields there are.

The intention of this mode is to support server-side operations, where
worktree-less merges can lead to conflicts and depending on the type
and/or path count, the caller might know how to handle said conflict.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/merge-tree.c |  3 ++-
 merge-ort.c          | 22 ++++++++++++++++++++--
 merge-ort.h          |  1 +
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index c61b5b4a10d..b3c5692498e 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -468,7 +468,8 @@ static int real_merge(struct merge_tree_options *o,
 	}
 	if (o->show_messages) {
 		putchar(line_termination);
-		merge_display_update_messages(&opt, &result);
+		merge_display_update_messages(&opt, line_termination == '\0',
+					      &result);
 	}
 	merge_finalize(&opt, &result);
 	return !result.clean; /* result.clean < 0 handled above */
diff --git a/merge-ort.c b/merge-ort.c
index 432937255f6..4a56c189ddf 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4412,6 +4412,7 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 }
 
 void merge_display_update_messages(struct merge_options *opt,
+				   int detailed,
 				   struct merge_result *result)
 {
 	struct merge_options_internal *opti = result->priv;
@@ -4437,8 +4438,25 @@ void merge_display_update_messages(struct merge_options *opt,
 	/* Iterate over the items, printing them */
 	for (int path_nr = 0; path_nr < olist.nr; ++path_nr) {
 		struct string_list *conflicts = olist.items[path_nr].util;
-		for (int i = 0; i < conflicts->nr; i++)
+		for (int i = 0; i < conflicts->nr; i++) {
+			struct logical_conflict_info *info =
+				conflicts->items[i].util;
+
+			if (detailed) {
+				printf("%lu", (unsigned long)info->paths.nr);
+				putchar('\0');
+				for (int n = 0; n < info->paths.nr; n++) {
+					fputs(info->paths.v[n], stdout);
+					putchar('\0');
+				}
+				fputs(type_short_descriptions[info->type],
+				      stdout);
+				putchar('\0');
+			}
 			puts(conflicts->items[i].string);
+			if (detailed)
+				putchar('\0');
+		}
 	}
 	string_list_clear(&olist, 0);
 
@@ -4518,7 +4536,7 @@ void merge_switch_to_result(struct merge_options *opt,
 		trace2_region_leave("merge", "write_auto_merge", opt->repo);
 	}
 	if (display_update_msgs)
-		merge_display_update_messages(opt, result);
+		merge_display_update_messages(opt, /* detailed */ 0, result);
 
 	merge_finalize(opt, result);
 }
diff --git a/merge-ort.h b/merge-ort.h
index c4909bcbf96..a994c9a5fcd 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -87,6 +87,7 @@ void merge_switch_to_result(struct merge_options *opt,
  * so only call this when bypassing merge_switch_to_result().
  */
 void merge_display_update_messages(struct merge_options *opt,
+				   int detailed,
 				   struct merge_result *result);
 
 struct stage_info {
-- 
gitgitgadget

