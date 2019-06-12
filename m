Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A6E1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 13:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbfFLN3s (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 09:29:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42045 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732428AbfFLN3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 09:29:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id z25so25768366edq.9
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PIRhuoJTy0/w601HkwDluzOg8WVAxwRIE2vIGgN0LV4=;
        b=WAG81qoj3k/8eevt/QlgHODkBIyFWtnTzy6hwktljeh6PZStIxiqPurJr2kux9qI2g
         ngVFKAQAOH+WzpxdbwCineQRK2LjdzFYHLx4VX+HxdR7t5e5BNUbeGGn1pelg9RvukkJ
         JY38gonDigp1JzX7cUU02G4F6cDVO9k8OD3hd0HxpdmaT7NCv2G9eICrKXv8Vdbyhiwd
         MK801nR1VrhsNeJMfL3Zwx5+znstdwzCCg9kgN3FkOID3QtyZzm9+cWO3tomRDT1o66n
         QR4GjnmiWDER7sT9W4qMS0AF9l+OrCXb+cq8BZ+GwVbqickXPNGeqy84P6XEaxPC/Tep
         0Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PIRhuoJTy0/w601HkwDluzOg8WVAxwRIE2vIGgN0LV4=;
        b=qI+3vSdfPB+XBvpZCZ1Obs/Hg5qSwsp5KvnNIzesK75c/iLeFHGcWKO5JW37128XUx
         J7VtF317Mb3mmji2eEH7QtlNqNiL8D0KqhmBwudUXwHuZY++3M8oEVUWal0w/g8ACiSV
         8sLBLk4SqrfguRUQiyzqQ1FDTCDzHSoZvHafrBUKA3AzOj1MbXnZTMBweKbX8s4bk69b
         c4OzomEJq9JnRSZ02XZmYOQFPdMDINYVgOEF0vFPJhaGdhn6GZAwdaZai+VAL+kdi0Pl
         Ng5kR/yFvjuNyKs6qGD4Wry3kvlPCIf79d0q6bcdsY/rTGhCDGtFnSHbNyC4ATizJawS
         J3/A==
X-Gm-Message-State: APjAAAX2vHDIgOpRaGBAZT2QeorLg0IJFJGqR5xgi7Q6RwVswNLlQ4cd
        WPmjOts9EzDO4JbGqt4kCfbl2byM
X-Google-Smtp-Source: APXvYqzVnoxK148pb6CV+7d1fa0slkJDld6qIk4NxcDb2iumt0ucTYSxqd67ALX/v9W4iRawqdS9wg==
X-Received: by 2002:a17:906:1813:: with SMTP id v19mr56928957eje.109.1560346183358;
        Wed, 12 Jun 2019 06:29:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s57sm4564024edd.54.2019.06.12.06.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:29:42 -0700 (PDT)
Date:   Wed, 12 Jun 2019 06:29:42 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 13:29:30 GMT
Message-Id: <b8dfb663f3675098bd1e8bef56478ea315dc9fb3.1560346174.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v5.git.gitgitgadget@gmail.com>
References: <pull.112.v4.git.gitgitgadget@gmail.com>
        <pull.112.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 08/11] commit-graph: extract fill_oids_from_all_packs()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() method is too complex, so we are
extracting helper functions one by one.

Extract fill_oids_from_all_packs() that reads all pack-files
for commits and fills the oid list in the context.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 4fae1fcdb2..61cb43ddf8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -950,6 +950,19 @@ static void fill_oids_from_commit_hex(struct write_commit_graph_context *ctx,
 	strbuf_release(&progress_title);
 }
 
+static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
+{
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
+			_("Finding commits for commit graph among packed objects"),
+			ctx->approx_nr_objects);
+	for_each_packed_object(add_packed_commits, ctx,
+			       FOR_EACH_OBJECT_PACK_ORDER);
+	if (ctx->progress_done < ctx->approx_nr_objects)
+		display_progress(ctx->progress, ctx->approx_nr_objects);
+	stop_progress(&ctx->progress);
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -1006,17 +1019,8 @@ int write_commit_graph(const char *obj_dir,
 	if (commit_hex)
 		fill_oids_from_commit_hex(ctx, commit_hex);
 
-	if (!pack_indexes && !commit_hex) {
-		if (ctx->report_progress)
-			ctx->progress = start_delayed_progress(
-				_("Finding commits for commit graph among packed objects"),
-				ctx->approx_nr_objects);
-		for_each_packed_object(add_packed_commits, ctx,
-				       FOR_EACH_OBJECT_PACK_ORDER);
-		if (ctx->progress_done < ctx->approx_nr_objects)
-			display_progress(ctx->progress, ctx->approx_nr_objects);
-		stop_progress(&ctx->progress);
-	}
+	if (!pack_indexes && !commit_hex)
+		fill_oids_from_all_packs(ctx);
 
 	close_reachable(ctx);
 
-- 
gitgitgadget

