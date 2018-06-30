Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A151F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934931AbeF3JVE (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:21:04 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:44382 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934383AbeF3JUv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:20:51 -0400
Received: by mail-lf0-f44.google.com with SMTP id h7-v6so413292lfc.11
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRbcvmZoSTVRBOXGJoylLs5O/gMVc1m9l3ZO/TdNM78=;
        b=vGD5BOVxmSCzjSNzjPda5UMNYrA0IGq7GAChf4f0KMzeefOlkmG/63uwA5zXgR+gIx
         koJRBYA92bncGkCO2BB40bgmY7wMUrrZPSvJtOBlcVcU14UiwxzFv71jlqS9Ny44IBtR
         DfXFW9WgYCAFwadWm77Wc79yQUPPTiEs6fbesSraBY4pj2dfmT2psfmr8P5x0sfnDRYz
         3MeSr2mSdi4oj78Dp6OqCynKRXFLiBjmeM4XsKDC0ly/TU2WD3Kpc47vOCp6RNPQrLOS
         Mh53iql3anmaY+0jBWLzsAjhwnjTQfV+hdMkfj1FOZry/9k0cNYx6zUw9Vfvc+SvsSjd
         QvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRbcvmZoSTVRBOXGJoylLs5O/gMVc1m9l3ZO/TdNM78=;
        b=SVxglOHcQKGxLNrM9uhBFgKiPczEss0Qsjf3Ha7PSg9Q1lYUcTHDc2Hy58T9na/vB2
         M7Omgxo6W4Fpgzrcib5eoum5CeAOkqKFX7sh0azO2311y+K6khA0F5KzSR9/TxVm7tUp
         QMiHRDJC6bpflDswW5UgZE6VQXlVfFp00UnR/et+2bUazm4iZMtZ/lAuQr558MHpGZ1J
         ILyCjkaAZq27BaS0+eqvqSFwVHHG0eH1ONQWqB0rojA0acl3puIkhCXEmtlv3yYX2Mj/
         E2MRYGt0u1uVO/2ir7xngBMeljXLZ72y2qfIYM+TdkBobEIOu08d877lqlJKrI5Y5lYE
         4OUg==
X-Gm-Message-State: APt69E1si+NM8ncaNgNDvK9z8BvpyOGAwgqMO2XEl3fM0DfHXGFfdXcN
        +8wj1JR/OG/zcAgxRgCkBu88xA==
X-Google-Smtp-Source: AAOMgpd1qwbXj0hvN9XJCUAxdRaZw+Osa+8zlo5ZURU+wqvQlzZPkaWuakxS+2J0GvKv5P9CmecJ+w==
X-Received: by 2002:a19:238d:: with SMTP id j135-v6mr12402846lfj.58.1530350449496;
        Sat, 30 Jun 2018 02:20:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c20-v6sm1854650lji.82.2018.06.30.02.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:20:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/12] repository.h: drop extern from function declaration
Date:   Sat, 30 Jun 2018 11:20:29 +0200
Message-Id: <20180630092031.29910-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630092031.29910-1-pclouds@gmail.com>
References: <20180630092031.29910-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 repository.h | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/repository.h b/repository.h
index f2646f0c52..f60d1cafbd 100644
--- a/repository.h
+++ b/repository.h
@@ -94,19 +94,16 @@ struct set_gitdir_args {
 	const char *alternate_db;
 };
 
-extern void repo_set_gitdir(struct repository *repo,
-			    const char *root,
-			    const struct set_gitdir_args *extra_args);
-extern void repo_set_worktree(struct repository *repo, const char *path);
-extern void repo_set_hash_algo(struct repository *repo, int algo);
-extern void initialize_the_repository(void);
-extern int repo_init(struct repository *r,
-		     const char *gitdir,
-		     const char *worktree);
-extern int repo_submodule_init(struct repository *submodule,
-			       struct repository *superproject,
-			       const char *path);
-extern void repo_clear(struct repository *repo);
+void repo_set_gitdir(struct repository *repo, const char *root,
+		     const struct set_gitdir_args *extra_args);
+void repo_set_worktree(struct repository *repo, const char *path);
+void repo_set_hash_algo(struct repository *repo, int algo);
+void initialize_the_repository(void);
+int repo_init(struct repository *r, const char *gitdir, const char *worktree);
+int repo_submodule_init(struct repository *submodule,
+			struct repository *superproject,
+			const char *path);
+void repo_clear(struct repository *repo);
 
 /*
  * Populates the repository's index from its index_file, an index struct will
@@ -116,6 +113,6 @@ extern void repo_clear(struct repository *repo);
  * than zero if an error occured.  If the repository's index has already been
  * populated then the number of entries will simply be returned.
  */
-extern int repo_read_index(struct repository *repo);
+int repo_read_index(struct repository *repo);
 
 #endif /* REPOSITORY_H */
-- 
2.18.0.rc2.476.g39500d3211

