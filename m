Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046971F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJSW7V (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34057 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbeJSW7U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id j17-v6so31124323lja.1
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5xBzOc+UuKpyYiZR4gxoNITKg2OIZpnjfUAj1CdhcM=;
        b=cfo0KeGInEzazXt01Qc7tWhK0kCbw0+t1OiRyj0ftWLMtU7BV2TvTMEzIa6JOECm8W
         dHTlqLyTgIxQgMxxaInF7YqtzNh8vTpNHtYC3GLIcoOspMsdk7XFZvxi9em/FZMsRsOV
         VA+DlmALdZdnCOV2IFq8uOn2CkWC48miCPO43EF1uNTwv/edeuze082FsXYt30BFgNhS
         0GiTjcyn8uASUQLxxHDeM6AFBcUV0Rp4QUTFr2B3hp8V0wgDo/ncyDTEGvTTmBvCD+9X
         e/aP6JoueWHOp4B7Z34rX2gMRFgZV0M8zOVeyhSBtc4j6SQjARBAYTvmEaKnvz0LdsTd
         brjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5xBzOc+UuKpyYiZR4gxoNITKg2OIZpnjfUAj1CdhcM=;
        b=hkSnD4snZMiRJ6INwUH26Wi8kyc+TrwDX0zKkvnPE+8BLC919I+5R2fNvjGBauH5lL
         bNp5a/IDwOz6OvefcLZ4IPfy5x/izVGB2bs3Yd0cvoMN1KIlZmudneTf33krjWU+OonM
         avnAI6df5lfM6XfVTYyxIZ5uCB7kv7vKeI7ji30d6yTVN/z3Rj7YsVm3hwSIqx9+FQzy
         XriZelWmV7PhlCRsm2Cu+NtXsrorRkD24xq9tKsp01JuOt6ncxN2hdVDm6L5O+ab+l2P
         tQSScDprhdFWnL2OgLOxTcLdwLfqR7MPvNj0owc8jbPhAA88uU81CKz284gg70xDTsk8
         +zOg==
X-Gm-Message-State: ABuFfoiQn/84n9dIqKz6vOKg737DkK7+RpG71JMwbCM1P1/33qK34rsr
        lPBs5tR+eZ9fvZEwhWnGbGw93AoB
X-Google-Smtp-Source: ACcGV61PKtEIi+b7X86W9VYOaT56PZAMSc4ChmMut5jq4mZ0/Qs/VHP7bJtUPQtgVowcBK1t+PbGBA==
X-Received: by 2002:a2e:9e88:: with SMTP id f8-v6mr22758361ljk.142.1539960770904;
        Fri, 19 Oct 2018 07:52:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:50 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/19] notes-merge.c: remove implicit dependency on the_index
Date:   Fri, 19 Oct 2018 16:52:25 +0200
Message-Id: <20181019145237.16079-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/notes.c |  2 +-
 notes-merge.c   | 12 +++++++-----
 notes-merge.h   |  6 +++++-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index c05cd004ab..d8bd01656a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -808,7 +808,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_merge_usage, options);
 	}
 
-	init_notes_merge_options(&o);
+	init_notes_merge_options(&o, the_repository);
 	o.verbosity = verbosity + NOTES_MERGE_VERBOSITY_DEFAULT;
 
 	if (do_abort)
diff --git a/notes-merge.c b/notes-merge.c
index bd05d50b05..c3bee1a87d 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -18,11 +18,13 @@ struct notes_merge_pair {
 	struct object_id obj, base, local, remote;
 };
 
-void init_notes_merge_options(struct notes_merge_options *o)
+void init_notes_merge_options(struct notes_merge_options *o,
+			      struct repository *repo)
 {
 	memset(o, 0, sizeof(struct notes_merge_options));
 	strbuf_init(&(o->commit_msg), 0);
 	o->verbosity = NOTES_MERGE_VERBOSITY_DEFAULT;
+	o->repo = repo;
 }
 
 static int path_to_oid(const char *path, struct object_id *oid)
@@ -127,7 +129,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 	trace_printf("\tdiff_tree_remote(base = %.7s, remote = %.7s)\n",
 	       oid_to_hex(base), oid_to_hex(remote));
 
-	repo_diff_setup(the_repository, &opt);
+	repo_diff_setup(o->repo, &opt);
 	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
@@ -190,7 +192,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 	trace_printf("\tdiff_tree_local(len = %i, base = %.7s, local = %.7s)\n",
 	       len, oid_to_hex(base), oid_to_hex(local));
 
-	repo_diff_setup(the_repository, &opt);
+	repo_diff_setup(o->repo, &opt);
 	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
@@ -350,7 +352,7 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
 
 	status = ll_merge(&result_buf, oid_to_hex(&p->obj), &base, NULL,
 			  &local, o->local_ref, &remote, o->remote_ref,
-			  &the_index, NULL);
+			  o->repo->index, NULL);
 
 	free(base.ptr);
 	free(local.ptr);
@@ -711,7 +713,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 		/* write file as blob, and add to partial_tree */
 		if (stat(path.buf, &st))
 			die_errno("Failed to stat '%s'", path.buf);
-		if (index_path(&the_index, &blob_oid, path.buf, &st, HASH_WRITE_OBJECT))
+		if (index_path(o->repo->index, &blob_oid, path.buf, &st, HASH_WRITE_OBJECT))
 			die("Failed to write blob object from '%s'", path.buf);
 		if (add_note(partial_tree, &obj_oid, &blob_oid, NULL))
 			die("Failed to add resolved note '%s' to notes tree",
diff --git a/notes-merge.h b/notes-merge.h
index 6c74e9385b..fe70cbd5e8 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -7,6 +7,8 @@
 struct commit;
 struct object_id;
 
+struct repository;
+
 #define NOTES_MERGE_WORKTREE "NOTES_MERGE_WORKTREE"
 
 enum notes_merge_verbosity {
@@ -15,6 +17,7 @@ enum notes_merge_verbosity {
 };
 
 struct notes_merge_options {
+	struct repository *repo;
 	const char *local_ref;
 	const char *remote_ref;
 	struct strbuf commit_msg;
@@ -23,7 +26,8 @@ struct notes_merge_options {
 	unsigned has_worktree:1;
 };
 
-void init_notes_merge_options(struct notes_merge_options *o);
+void init_notes_merge_options(struct notes_merge_options *o,
+			      struct repository *repo);
 
 /*
  * Merge notes from o->remote_ref into o->local_ref
-- 
2.19.1.647.g708186aaf9

