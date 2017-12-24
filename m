Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA501F406
	for <e@80x24.org>; Sun, 24 Dec 2017 10:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbdLXKzH (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 05:55:07 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34553 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbdLXKzE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 05:55:04 -0500
Received: by mail-wm0-f67.google.com with SMTP id y82so30137630wmg.1
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 02:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WhDEk3wGUe5m8TT9tUvcbP/pesBzXg+a029/hK5OINE=;
        b=LLGPfy3iWd/BVDHIM39LVH9qOiQqGmfPPbL8nACj3HhJVz1YHQdYH2Z4XR6ua+f4dX
         QIJuivg4ClUf0UF3iHSefpnb5auVKnpATH9oKc11wF93vT9Q2Dw9XK0AILvO8MvJiSMo
         QsgHI+xvQ4qMcf4dZtyCqCUfDYq7zZ2iEdrEsyfGjzfJadytOpfpldOTxT8y9Rx9CF1p
         ukfRSzimnkF5ucLvobkIwXAjzFUT8enx0wjsFxcorbapVkp2WD6ErpJPJ+vfhhtergOy
         uFGZtB7etuPXXoTmLA0jXBsVNNz1Bkc/HpwLN8CbdI58DQD8L064f2CAEzLbyyMYBrI3
         2k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WhDEk3wGUe5m8TT9tUvcbP/pesBzXg+a029/hK5OINE=;
        b=Zr0/9uUvCEGrLrREWc9TicZZAuniM2bO+aXr08G/4PeRBgWu8Ort5n3WUBRJWk6nhV
         moKCJ2KrRJS3zxKMC6N6CIoaJO1FYIP+Q01DxryLiT+Ecnx6M23Lg4A6Waiz9GJ7+lRF
         4AuAznsn3gp7Ab12ztomR27tzHZHFdxWdWgD3c+uw9bAVuIM6nbZ5ypZQs61mT8gcpl4
         H5EPKB3lr9z6MdeWsgikvL3/C2oBGEbNyR9nL8r2ytcB+xiClwvjET7cKOC/4QGt/cFU
         hSIY/l9FDHLVMCvzxgcHsetRgAL8h/nkL+hCkRNO65c0pvgJYx4Dn+/30100GSW+/9em
         BzZA==
X-Gm-Message-State: AKGB3mLS41rmxUq1a4jFK6xmUhOGKaZAVh4MAWX7u0do7ZHqWldZ9VPj
        hkZmFk+sngUiZfdR83pyvse3Lw==
X-Google-Smtp-Source: ACJfBosYvJt81rEzs+f79lSAZx763bts5v71k7nvhPh1iou9Nsgz5ON+LJtPAGhr9VZpTP85JvnY2g==
X-Received: by 10.80.179.39 with SMTP id q36mr22430818edd.85.1514112902437;
        Sun, 24 Dec 2017 02:55:02 -0800 (PST)
Received: from icid.telenet.be (d8D86700B.access.telenet.be. [141.134.112.11])
        by smtp.gmail.com with ESMTPSA id j27sm28560716eda.59.2017.12.24.02.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Dec 2017 02:55:01 -0800 (PST)
From:   Mark Nauwelaerts <mark.nauwelaerts@gmail.com>
To:     git@vger.kernel.org
Cc:     Mark Nauwelaerts <mnauw@users.sourceforge.net>
Subject: [PATCH 2/2] fast-export: remove now obsolete filtering of modified files
Date:   Sun, 24 Dec 2017 11:52:09 +0100
Message-Id: <1514112729-31647-3-git-send-email-mark.nauwelaerts@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1514112729-31647-1-git-send-email-mark.nauwelaerts@gmail.com>
References: <1514112729-31647-1-git-send-email-mark.nauwelaerts@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mark Nauwelaerts <mnauw@users.sourceforge.net>

Revert b3e8ca8 ("fast-export: do not copy from modified file", 2017-09-20)
partially, since it is not necessary to filter out 'C' commands if the 'M'
and 'C' commands are in correct order.

The unit test that was added is kept around though, and it still passes
with this new approach.

Signed-off-by: Mark Nauwelaerts <mnauw@users.sourceforge.net>
---
 builtin/fast-export.c  | 46 ++++++++++++++--------------------------------
 t/t9350-fast-export.sh |  2 +-
 2 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1b3e250..6aa4073 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -356,7 +356,6 @@ static void show_filemodify(struct diff_queue_struct *q,
 			    struct diff_options *options, void *data)
 {
 	int i;
-	struct string_list *changed = data;
 
 	/*
 	 * Handle files below a directory first, in case they are all deleted
@@ -372,31 +371,20 @@ static void show_filemodify(struct diff_queue_struct *q,
 		case DIFF_STATUS_DELETED:
 			printf("D ");
 			print_path(spec->path);
-			string_list_insert(changed, spec->path);
 			putchar('\n');
 			break;
 
 		case DIFF_STATUS_COPIED:
 		case DIFF_STATUS_RENAMED:
-			/*
-			 * If a change in the file corresponding to ospec->path
-			 * has been observed, we cannot trust its contents
-			 * because the diff is calculated based on the prior
-			 * contents, not the current contents.  So, declare a
-			 * copy or rename only if there was no change observed.
-			 */
-			if (!string_list_has_string(changed, ospec->path)) {
-				printf("%c ", q->queue[i]->status);
-				print_path(ospec->path);
-				putchar(' ');
-				print_path(spec->path);
-				string_list_insert(changed, spec->path);
-				putchar('\n');
-
-				if (!oidcmp(&ospec->oid, &spec->oid) &&
-				    ospec->mode == spec->mode)
-					break;
-			}
+			printf("%c ", q->queue[i]->status);
+			print_path(ospec->path);
+			putchar(' ');
+			print_path(spec->path);
+			putchar('\n');
+
+			if (!oidcmp(&ospec->oid, &spec->oid) &&
+			    ospec->mode == spec->mode)
+				break;
 			/* fallthrough */
 
 		case DIFF_STATUS_TYPE_CHANGED:
@@ -417,7 +405,6 @@ static void show_filemodify(struct diff_queue_struct *q,
 				       get_object_mark(object));
 			}
 			print_path(spec->path);
-			string_list_insert(changed, spec->path);
 			putchar('\n');
 			break;
 
@@ -553,8 +540,7 @@ static void anonymize_ident_line(const char **beg, const char **end)
 	*end = out->buf + out->len;
 }
 
-static void handle_commit(struct commit *commit, struct rev_info *rev,
-			  struct string_list *paths_of_changed_objects)
+static void handle_commit(struct commit *commit, struct rev_info *rev)
 {
 	int saved_output_format = rev->diffopt.output_format;
 	const char *commit_buffer;
@@ -641,7 +627,6 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	if (full_tree)
 		printf("deleteall\n");
 	log_tree_diff_flush(rev);
-	string_list_clear(paths_of_changed_objects, 0);
 	rev->diffopt.output_format = saved_output_format;
 
 	printf("\n");
@@ -657,15 +642,14 @@ static void *anonymize_tag(const void *old, size_t *len)
 	return strbuf_detach(&out, len);
 }
 
-static void handle_tail(struct object_array *commits, struct rev_info *revs,
-			struct string_list *paths_of_changed_objects)
+static void handle_tail(struct object_array *commits, struct rev_info *revs)
 {
 	struct commit *commit;
 	while (commits->nr) {
 		commit = (struct commit *)object_array_pop(commits);
 		if (has_unshown_parent(commit))
 			return;
-		handle_commit(commit, revs, paths_of_changed_objects);
+		handle_commit(commit, revs);
 	}
 }
 
@@ -1004,7 +988,6 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	char *export_filename = NULL, *import_filename = NULL;
 	uint32_t lastimportid;
 	struct string_list refspecs_list = STRING_LIST_INIT_NODUP;
-	struct string_list paths_of_changed_objects = STRING_LIST_INIT_DUP;
 	struct option options[] = {
 		OPT_INTEGER(0, "progress", &progress,
 			    N_("show progress after <n> objects")),
@@ -1077,15 +1060,14 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	revs.diffopt.format_callback = show_filemodify;
-	revs.diffopt.format_callback_data = &paths_of_changed_objects;
 	DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
 	while ((commit = get_revision(&revs))) {
 		if (has_unshown_parent(commit)) {
 			add_object_array(&commit->object, NULL, &commits);
 		}
 		else {
-			handle_commit(commit, &revs, &paths_of_changed_objects);
-			handle_tail(&commits, &revs, &paths_of_changed_objects);
+			handle_commit(commit, &revs);
+			handle_tail(&commits, &revs);
 		}
 	}
 
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 866ddf6..06c66a1 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -522,7 +522,7 @@ test_expect_success 'delete refspec' '
 	test_cmp expected actual
 '
 
-test_expect_success 'when using -C, do not declare copy when source of copy is also modified' '
+test_expect_success 'when using -C, correctly order copy and modify of source of copy' '
 	test_create_repo src &&
 	echo a_line >src/file.txt &&
 	git -C src add file.txt &&
-- 
2.7.4

