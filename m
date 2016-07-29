Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4761FF40
	for <e@80x24.org>; Fri, 29 Jul 2016 16:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbcG2QU3 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 12:20:29 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35414 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbcG2QUY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 12:20:24 -0400
Received: by mail-pa0-f67.google.com with SMTP id cf3so5429746pad.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 09:20:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L3o9iJ7SGm9c4PGrYfUQLi9n0WpL+9s7L4S4Jy3Ud4I=;
        b=k3Do4a4Pf+1Cjk2gygm2iS0gP8adiX5kn4rvU4UDtGZSJOH8R5bjULKLXl17W1It/A
         w/ec/ahzInUBxuGQHG/A3naNOTLrAEdNboR2Hnvn4R3LVi2slTyl52/Rtif1lJa7VjSK
         ySkfekcs4QCVoQzey/PM5tngMYYVzsbrTuz7K1QYAzDx3x/c2f1KTeaaFfjvDoD7XRTo
         ovnRQRdZBiUsAdbtHhYduq++28/cQk3eOJetONsVV1PfjP/mBqNkabcyxo5XVW3SXdRq
         z6J+iqkDdjYXWUfJt8GOgvyolJRMGxekCxlWw9amUa+F55GRb/PXwalkoWSWxE+Ngzn0
         wSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L3o9iJ7SGm9c4PGrYfUQLi9n0WpL+9s7L4S4Jy3Ud4I=;
        b=R4Zectfyu94RZi/biT4iNy6w33f+Gb56EC4T+rwNnpua7FUAyN/2uj4w3OOa0Eh+2V
         5ucaW+deQZ+ydQVlTDPBR71H5spZ+Vdv3iZze1ON5pB7RDJxvXJUxgEabuH0+ki6px1u
         CAaditjs+3XVAc00+wpJbhnz5Ypcw53Ofz++IiJatt8ewLN7jJiywyIpeS6FCJD9TeJn
         0T+1Fzlmp1yzkfUF0yjv/ZhSNPovklggd1WfLaW4QImSLf6u+gB+f/5LJTiPlzZ9f1j4
         0yJkdLmUrb80VjS3sCTDFSWHfxqx9wnJvQops5+0dqwX5GSiXJ6kBwzfUQ41VDMnPpLI
         n5cQ==
X-Gm-Message-State: AEkoousV3hwVXjQxtAI8gNa7jCBwHvuvY67QM+WWRpo1efILDCsY5Gp738Ynh/Ane4haOw==
X-Received: by 10.66.154.232 with SMTP id vr8mr70052860pab.104.1469809223593;
        Fri, 29 Jul 2016 09:20:23 -0700 (PDT)
Received: from DESKTOP-SLJ7FNG.northamerica.corp.microsoft.com ([2001:4898:8010:1::5b0])
        by smtp.gmail.com with ESMTPSA id i69sm26193282pfk.30.2016.07.29.09.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 09:20:23 -0700 (PDT)
From:	Kevin Willford <kcwillford@gmail.com>
To:	git@vger.kernel.org
Cc:	Kevin Willford <kewillf@microsoft.com>,
	Kevin Willford <kcwillford@gmail.com>
Subject: [[PATCH v2] 3/4] patch-ids: add flag to create the diff patch id using header only data
Date:	Fri, 29 Jul 2016 12:19:19 -0400
Message-Id: <20160729161920.3792-4-kcwillford@gmail.com>
X-Mailer: git-send-email 2.9.2.gvfs.2.42.gb7633a3
In-Reply-To: <20160729161920.3792-1-kcwillford@gmail.com>
References: <20160729161920.3792-1-kcwillford@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Kevin Willford <kewillf@microsoft.com>

This will allow a diff patch id to be created using only the header data
so that the contents of the file will not have to be loaded.

Signed-off-by: Kevin Willford <kcwillford@gmail.com>
---
 diff.c      | 16 ++++++++++------
 diff.h      |  2 +-
 patch-ids.c |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 7d03419..28a4190 100644
--- a/diff.c
+++ b/diff.c
@@ -4455,7 +4455,7 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
 }
 
 /* returns 0 upon success, and writes result into sha1 */
-static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
+static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1, int diff_header_only)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
@@ -4490,9 +4490,6 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 
 		diff_fill_sha1_info(p->one);
 		diff_fill_sha1_info(p->two);
-		if (fill_mmfile(&mf1, p->one) < 0 ||
-				fill_mmfile(&mf2, p->two) < 0)
-			return error("unable to read files to diff");
 
 		len1 = remove_space(p->one->path, strlen(p->one->path));
 		len2 = remove_space(p->two->path, strlen(p->two->path));
@@ -4527,6 +4524,13 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 					len2, p->two->path);
 		git_SHA1_Update(&ctx, buffer, len1);
 
+		if (diff_header_only)
+			continue;
+
+		if (fill_mmfile(&mf1, p->one) < 0 ||
+			fill_mmfile(&mf2, p->two) < 0)
+			return error("unable to read files to diff");
+
 		if (diff_filespec_is_binary(p->one) ||
 		    diff_filespec_is_binary(p->two)) {
 			git_SHA1_Update(&ctx, oid_to_hex(&p->one->oid),
@@ -4549,11 +4553,11 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 	return 0;
 }
 
-int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1)
+int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1, int diff_header_only)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
-	int result = diff_get_patch_id(options, sha1);
+	int result = diff_get_patch_id(options, sha1, diff_header_only);
 
 	for (i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
diff --git a/diff.h b/diff.h
index 125447b..7883729 100644
--- a/diff.h
+++ b/diff.h
@@ -342,7 +342,7 @@ extern int run_diff_files(struct rev_info *revs, unsigned int option);
 extern int run_diff_index(struct rev_info *revs, int cached);
 
 extern int do_diff_cache(const unsigned char *, struct diff_options *);
-extern int diff_flush_patch_id(struct diff_options *, unsigned char *);
+extern int diff_flush_patch_id(struct diff_options *, unsigned char *, int);
 
 extern int diff_result_code(struct diff_options *, int);
 
diff --git a/patch-ids.c b/patch-ids.c
index bafaae2..69a14a3 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -13,7 +13,7 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 	else
 		diff_root_tree_sha1(commit->object.oid.hash, "", options);
 	diffcore_std(options);
-	return diff_flush_patch_id(options, sha1);
+	return diff_flush_patch_id(options, sha1, 0);
 }
 
 static int patch_id_cmp(struct patch_id *a,
-- 
2.9.2.gvfs.2.42.gb7633a3

