Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B151FAEA
	for <e@80x24.org>; Sat,  3 Mar 2018 11:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeCCLhH (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:37:07 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36043 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeCCLhG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:37:06 -0500
Received: by mail-pg0-f68.google.com with SMTP id i14so4871750pgv.3
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WL9euUVKw+Mx+8Fijl5o8F3u9B1NOzb9pDppfyMu3as=;
        b=oh4qCsZ9fHSbsE7f0+1CTWX/tgySGUg3e6d8uadE0UWtIjHhi4l1C8u8xrDIeNAGJL
         BGpEy78CibL7MehXm/BeKVl//9L3T5+4G/N57+HxXG1HS8OMZPygmEaS9Ry/ZWdR2kLi
         bZU6ahsTHoNzErIuL2Cm4KeAfqabSm0ZxsFIj8UNg1snn0aOqw4y3GQ1MMV3BU7wflMB
         Ak3UsDPQUadFpIXlH5UCAmF8QQY35gFQQJKogO0wg2LPpuQCKM0ReOU52sm1aBijSCSH
         Utqedbya+N32+CF130p66ZyklmL+t1pARgC7c/CsQiHPhxg6P2R3rqXN5XK0QIwU1SwA
         RyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WL9euUVKw+Mx+8Fijl5o8F3u9B1NOzb9pDppfyMu3as=;
        b=ey3kx12Iv87hR9+05jRZ/d2mMknUwE2OzoAs022zQgc8qB6MZWOOHeWIEH1nkd3GWg
         O2Tr5zWxLK0PAbNkEXWUt6T30zfsGWgKmNiwCEx+sj5TJODtcmg9uN/gY9GaDRHy/n8r
         Uo4rY7l/1huyHTT9Ef7eXpQYFisTZYzP4jIU+vvBHvRqzOhiB6wTpacSYkoWDf4YqQB0
         s86HDBccZsutOOClVBKWd+pXlfYa0yJN72RiI5xh9WQiIOvf2bto5HUp2ADPx8sWE3U6
         c09OahXwMDKzp3RPJk8mOXO3vyxHCoKNUup1iE6yVzRdGxBGjhWf7G5mOX9DYFgt109p
         7Izw==
X-Gm-Message-State: APf1xPCIV+mfkJoMQwU6rzLIVvY/vauXSGxgCxwSFeE5HXRebjZhcyXC
        S9nhjmdmrJLOuqCod1hVub9FSA==
X-Google-Smtp-Source: AG47ELu3GSehHCvAEhDTvbPnFJG0q8auwLLzoalz+p8mXCLnRfd8xuENBqaDN3wOm8VlwpSNFuwgcg==
X-Received: by 10.98.220.207 with SMTP id c76mr8701058pfl.159.1520077025352;
        Sat, 03 Mar 2018 03:37:05 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id d193sm14217036pgc.30.2018.03.03.03.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:37:04 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:37:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/44] sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
Date:   Sat,  3 Mar 2018 18:35:57 +0700
Message-Id: <20180303113637.26518-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

getenv() is supposed to work on the main repository only. This delayed
getenv() code in sha1_file.c makes it more difficult to convert
sha1_file.c to a generic object store that could be used by both
submodule and main repositories.

Move the getenv() back in setup_git_env() where other env vars are
also fetched.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 environment.c | 1 +
 repository.c  | 3 +++
 repository.h  | 4 ++++
 sha1_file.c   | 6 +-----
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index da3f7daa09..a5eaa97fb1 100644
--- a/environment.c
+++ b/environment.c
@@ -174,6 +174,7 @@ void setup_git_env(const char *git_dir)
 	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
 	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
 	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
+	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
 	repo_set_gitdir(the_repository, git_dir, &args);
 	argv_array_clear(&to_free);
 
diff --git a/repository.c b/repository.c
index e65f4138a7..04d85a2869 100644
--- a/repository.c
+++ b/repository.c
@@ -60,6 +60,8 @@ void repo_set_gitdir(struct repository *repo,
 	repo_set_commondir(repo, o->commondir);
 	expand_base_dir(&repo->objectdir, o->object_dir,
 			repo->commondir, "objects");
+	free(repo->alternate_db);
+	repo->alternate_db = xstrdup_or_null(o->alternate_db);
 	expand_base_dir(&repo->graft_file, o->graft_file,
 			repo->commondir, "info/grafts");
 	expand_base_dir(&repo->index_file, o->index_file,
@@ -215,6 +217,7 @@ void repo_clear(struct repository *repo)
 	FREE_AND_NULL(repo->gitdir);
 	FREE_AND_NULL(repo->commondir);
 	FREE_AND_NULL(repo->objectdir);
+	FREE_AND_NULL(repo->alternate_db);
 	FREE_AND_NULL(repo->graft_file);
 	FREE_AND_NULL(repo->index_file);
 	FREE_AND_NULL(repo->worktree);
diff --git a/repository.h b/repository.h
index 84aeac2825..2bfbf762f3 100644
--- a/repository.h
+++ b/repository.h
@@ -26,6 +26,9 @@ struct repository {
 	 */
 	char *objectdir;
 
+	/* Path to extra alternate object database if not NULL */
+	char *alternate_db;
+
 	/*
 	 * Path to the repository's graft file.
 	 * Cannot be NULL after initialization.
@@ -93,6 +96,7 @@ struct set_gitdir_args {
 	const char *object_dir;
 	const char *graft_file;
 	const char *index_file;
+	const char *alternate_db;
 };
 
 extern void repo_set_gitdir(struct repository *repo,
diff --git a/sha1_file.c b/sha1_file.c
index 831d9e7343..4af422e3cf 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -667,15 +667,11 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 
 void prepare_alt_odb(void)
 {
-	const char *alt;
-
 	if (alt_odb_tail)
 		return;
 
-	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
-
 	alt_odb_tail = &alt_odb_list;
-	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
+	link_alt_odb_entries(the_repository->alternate_db, PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
 }
-- 
2.16.1.435.g8f24da2e1a

