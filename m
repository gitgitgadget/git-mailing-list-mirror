Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E4E1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeKJPdf (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40258 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbeKJPdX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:23 -0500
Received: by mail-lj1-f195.google.com with SMTP id t22-v6so3370053lji.7
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q8LTa/+mjiJVkni4vN/LIYtTn6rbH63G9WixP3ExJ84=;
        b=Va07PKfLkipelSJLq5V+ozk5c0/QShqd8txhsfWBv8GKWIyGDYRaNYvqsfEXlj3FDi
         1jX3YoMnALU7pur/2d0xX/GAzihyVlq/zUPwSsy7Al2QIJvObUpv+4mYDBjrBp92BHUY
         SIBQnLea75hpeVivi1DyvvaDMyU85Pep04S7S96IEvnXl47lLrbkDOiHAr3WPjMtccZt
         deRiwG1izRuI+xTnQAjlGIhq5VNZwo80I77oUvrFsbXw80eAtQdBtJIuZXrB8HWVP6Qu
         qXd94qLzWALH0GyxhVy26cBhziF6xtJ//1la33zVqb3CTIFT3nogCm8Lu1azeV4FR0Vm
         fU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q8LTa/+mjiJVkni4vN/LIYtTn6rbH63G9WixP3ExJ84=;
        b=Z1l99lF6nBRaEA4BtegDBvZp9lptArHpHtK50O9ffYMdE6ZY+3BUHqxHxGVA2T4icz
         7yNqToiHWGnMX0XzjbYeM6bjnQC2vF5RyC2sEmHy8Mgbhd0VTrScV5D0jH/L+RvBShW/
         9wyQSfNNM3Gf34M0wuxqmCRH+wjvFO60GM9nAcTKcTH6jfdZQtCF8zN2926gMDDoVF2p
         Rc7tNX2h/HMNx3voz7PwpG72nttRxtwfY0zUTJ/PC2BEq5r0xnOGNJwLBqBtRSTFAgwQ
         ALxrob/0/R4/PWY2lUi2AquDMyoCnaYq3YE9hQEB5j6W/LpEFCWultVVe/b4FIdaIfED
         kEjQ==
X-Gm-Message-State: AGRZ1gIlr1ykhcI2oHkEz/ORoYsgd+Hmws+w3jVdV3nD9ZtpgQK8/IOA
        jOo3ab1lAb/D6OwBxKlt1zAupoN8
X-Google-Smtp-Source: AJdET5eSwpOak+opTk8jhuqsNjOFqvril0VDCzUmVu6dCY6wYJQkmigxSv4d/WT5mPDd43U9rgDmBw==
X-Received: by 2002:a2e:478f:: with SMTP id u137-v6mr7282382lja.142.1541828976444;
        Fri, 09 Nov 2018 21:49:36 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:35 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 16/22] diff-lib.c: remove the_repository references
Date:   Sat, 10 Nov 2018 06:49:04 +0100
Message-Id: <20181110054910.10568-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/commit.c     | 3 ++-
 builtin/merge-ours.c | 2 +-
 diff-lib.c           | 7 ++++---
 diff.h               | 3 ++-
 sequencer.c          | 4 ++--
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e89bf35634..91b1920255 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -908,7 +908,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			if (ignore_submodule_arg &&
 			    !strcmp(ignore_submodule_arg, "all"))
 				flags.ignore_submodules = 1;
-			committable = index_differs_from(parent, &flags, 1);
+			committable = index_differs_from(the_repository,
+							 parent, &flags, 1);
 		}
 	}
 	strbuf_release(&committer_ident);
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index c84c6e05e9..0b07263415 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -26,7 +26,7 @@ int cmd_merge_ours(int argc, const char **argv, const char *prefix)
 	 */
 	if (read_cache() < 0)
 		die_errno("read_cache failed");
-	if (index_differs_from("HEAD", NULL, 0))
+	if (index_differs_from(the_repository, "HEAD", NULL, 0))
 		exit(2);
 	exit(0);
 }
diff --git a/diff-lib.c b/diff-lib.c
index 83fce51518..23c8d351b3 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -542,7 +542,7 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 {
 	struct rev_info revs;
 
-	repo_init_revisions(the_repository, &revs, NULL);
+	repo_init_revisions(opt->repo, &revs, NULL);
 	copy_pathspec(&revs.prune_data, &opt->pathspec);
 	revs.diffopt = *opt;
 
@@ -551,13 +551,14 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 	return 0;
 }
 
-int index_differs_from(const char *def, const struct diff_flags *flags,
+int index_differs_from(struct repository *r,
+		       const char *def, const struct diff_flags *flags,
 		       int ita_invisible_in_index)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	repo_init_revisions(the_repository, &rev, NULL);
+	repo_init_revisions(r, &rev, NULL);
 	memset(&opt, 0, sizeof(opt));
 	opt.def = def;
 	setup_revisions(0, NULL, &rev, &opt);
diff --git a/diff.h b/diff.h
index ce5e8a8183..3197a976a4 100644
--- a/diff.h
+++ b/diff.h
@@ -436,7 +436,8 @@ int diff_result_code(struct diff_options *, int);
 
 void diff_no_index(struct repository *, struct rev_info *, int, const char **);
 
-int index_differs_from(const char *def, const struct diff_flags *flags,
+int index_differs_from(struct repository *r, const char *def,
+		       const struct diff_flags *flags,
 		       int ita_invisible_in_index);
 
 /*
diff --git a/sequencer.c b/sequencer.c
index 726f727644..d726f77e11 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1713,7 +1713,7 @@ static int do_pick_commit(struct repository *r,
 			unborn = 1;
 		} else if (unborn)
 			oidcpy(&head, the_hash_algo->empty_tree);
-		if (index_differs_from(unborn ? empty_tree_oid_hex() : "HEAD",
+		if (index_differs_from(r, unborn ? empty_tree_oid_hex() : "HEAD",
 				       NULL, 0))
 			return error_dirty_index(r->index, opts);
 	}
@@ -3915,7 +3915,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			if (res)
 				goto release_todo_list;
 		}
-		if (index_differs_from("HEAD", NULL, 0)) {
+		if (index_differs_from(r, "HEAD", NULL, 0)) {
 			res = error_dirty_index(r->index, opts);
 			goto release_todo_list;
 		}
-- 
2.19.1.1231.g84aef82467

