Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01DFD1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeB1Bh6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:37:58 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35891 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeB1Bh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:37:57 -0500
Received: by mail-pl0-f67.google.com with SMTP id 61-v6so555779plf.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l95AQdicy+mPRUvZaAal3XqlDHhsM5i7Isc+7MKmiHQ=;
        b=HXuRXWfhRQLbjcONZ1LuRovyynFfF60Kvgwc/yzw9x8loNoQYMrb3euersq42i+2sL
         xOfo5XIePNJEFYPjpZPm0f/lmHUkEOIz6OulgjxUx0kRJVnuh5S77Wqaek/y7sH/LjSO
         dG9u4OYGiSHFvvs+VIz+gcrlCRqd6RCRXI0VajPqKVu2mydsKRdhH5e6Np6M4kM/nU+W
         WZGSUrxwhnDU3E9cxYsvoOVUuq673ZuruCii/Y4jNHSt4OXpx9wK9z3GXoHPjfJXPJ4/
         62e844bkgsGLi/xbZ9QKZEGUVPQ+q0ZQAol9vwnDfW1/QrHRVT3eFvxi+KXBJdwj9rqv
         1Tkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l95AQdicy+mPRUvZaAal3XqlDHhsM5i7Isc+7MKmiHQ=;
        b=ZiOgyiukwj5Pkvztck7bhPe/tlRxbEX1Wl0ZGnZOG6knk606Iyad/8dOi8qpzVqfF3
         hfBXaaTvmRycW4QvSU/S/fDjnbrzWp9SexOyq51Iop7cedyndQjgK9+ipR8lVsnSKfpz
         H2KRmhlOksUc9OeypwlBSjpH0UKtRLS+R4+UP76jGkbVZ43d7PGLwBiwJppfLhpyZ4qQ
         11uo2xWyNeRxybxwtyrDxA7zRZ9DM1AaNWkifVED95vKZT6TPTZZJuS89aN2IsCoyBcQ
         RXvgzKoixd6htW0/NQd+usUtqGQE0PxC4jNxiHVqbaAaq54BeanDTt80J+fSgdp4UYp6
         FIuQ==
X-Gm-Message-State: APf1xPBuFSvknK9xitC9+K2AFSV9q6/2a0A22rW1kWhyNbHktyqdRTjx
        qg1yuh3Lr3hme/0bd/lrqe8=
X-Google-Smtp-Source: AG47ELve4weJc0nC8jwCeBHEqJ4RsVfkDlFJIwRgR29L0Sm5yMm9EJ9JaBltdV0gCHB2oUJS0PIRXw==
X-Received: by 2002:a17:902:887:: with SMTP id 7-v6mr8514022pll.89.1519781877134;
        Tue, 27 Feb 2018 17:37:57 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id n13sm573588pfg.45.2018.02.27.17.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 17:37:56 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sbeller@google.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 4/4] repository: delete ignore_env member
Date:   Wed, 28 Feb 2018 08:37:27 +0700
Message-Id: <20180228013727.13815-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180228013727.13815-1-pclouds@gmail.com>
References: <20180227095846.9238-1-pclouds@gmail.com>
 <20180228013727.13815-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable was added because the repo_set_gitdir() was created to
cover both submodule and main repos, but these two are initialized a
bit differently so ignore_env == 0 means main repo, while ignore_env
!= 0 is submodules.

Since the difference part (env variables) has been moved out of
repo_set_gitdir(), this function works the same way for both repo
types and ignore_env is not needed anymore.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 repository.c | 4 +---
 repository.h | 9 ---------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/repository.c b/repository.c
index b5306ddaa2..4f44384dde 100644
--- a/repository.c
+++ b/repository.c
@@ -12,7 +12,7 @@ static struct repository the_repo = {
 	NULL, NULL, NULL,
 	&the_index,
 	&hash_algos[GIT_HASH_SHA1],
-	0, 0
+	0
 };
 struct repository *the_repository = &the_repo;
 
@@ -139,8 +139,6 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
 	struct repository_format format;
 	memset(repo, 0, sizeof(*repo));
 
-	repo->ignore_env = 1;
-
 	INIT_LIST_HEAD(&repo->objects.packed_git_mru);
 
 	if (repo_init_gitdir(repo, gitdir))
diff --git a/repository.h b/repository.h
index 1b6afd0926..e05a77a099 100644
--- a/repository.h
+++ b/repository.h
@@ -73,15 +73,6 @@ struct repository {
 	const struct git_hash_algo *hash_algo;
 
 	/* Configurations */
-	/*
-	 * Bit used during initialization to indicate if repository state (like
-	 * the location of the 'objectdir') should be read from the
-	 * environment.  By default this bit will be set at the begining of
-	 * 'repo_init()' so that all repositories will ignore the environment.
-	 * The exception to this is 'the_repository', which doesn't go through
-	 * the normal 'repo_init()' process.
-	 */
-	unsigned ignore_env:1;
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
 	unsigned different_commondir:1;
-- 
2.16.1.399.g632f88eed1

