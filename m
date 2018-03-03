Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E9AB1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeCCLgw (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:36:52 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44961 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeCCLgu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:36:50 -0500
Received: by mail-pf0-f193.google.com with SMTP id 17so5134485pfw.11
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IrxrYxCjWjY0BoQ/p/8y51OScOXtQzkn5Xp8IiOn6Us=;
        b=qR60HIalg2UkDjCK6X99V4JhlJ9sq5eLmdCuH3FwCSfxIPeguhiGfqruXgxPU21f+Q
         qTGB2tr6MkTLhtRzCGjd2OPRqizgbLV2UZMUvwHtRGLm+pD1BuPuEDzTnM2RHWG/ERKy
         yA/HFzF4xImFSdXgzLfN20CdsfjGzp+x4Li82x7GnrdZ0KGyk9GQD2kJ9xsLfQYyS2pQ
         n5OxJQQui/M94HIS32JLg+IfO5VgxT7zboWQEn5SSGWTQxBkh/Z53sK81AlNUgkWTRYg
         V9kwYxyfNnvgPbFiBKRZS7v/RKzJCHtIv5OJ8lYsdP2ayxDlcvkuqFLrxwYcVWqmG2NQ
         A4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrxrYxCjWjY0BoQ/p/8y51OScOXtQzkn5Xp8IiOn6Us=;
        b=ov4N2EGy3v/Bo5Hh4vrGSIy1EP3thueOVRuD33Wt2KDqYO5P2/5B5cv0R8Z20qMOpJ
         6ZBgZzkR/wJ5cxQQRuMtZwSCE+gsKmE2vT2Skk9W4X6AApWU/798bYAqZo3rBUAdsF4g
         +vwCwp4SY2EN3QGSyPuW7MWZE71yi/Qx0GhzXBDFUmPFdfnl2nMcHiloc2HNgyr0sXhT
         R7qj8DivNfPAEqhmJCEtvhn1tgdFwTfkiVN6HPElsnzhtXyIg00LZEuHLWNDaYTY+7G0
         YalckF2NCZCjLvIInd9sbiVhu48lsxXiKK58DIiJdjcMh7bSE9vWy7A1z01ayx4nS/X0
         2arQ==
X-Gm-Message-State: APf1xPAuFhc69YUpfoZwXyrDV+RKEnpyTtr0EyqTP9NToE88DzwSkoLr
        taUHzxTyCFUWNIKj+WGfNYe1cA==
X-Google-Smtp-Source: AG47ELtiO0HlJpt5Lrd4xeHJT8J9jkqPm7S8PPDLFTAm4QXnVm8vskdwDG3t41wQb5TTg+VQTfXtLA==
X-Received: by 10.99.112.20 with SMTP id l20mr7192912pgc.412.1520077010165;
        Sat, 03 Mar 2018 03:36:50 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id t87sm18147653pfi.37.2018.03.03.03.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:36:49 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:36:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/44] repository: initialize the_repository in main()
Date:   Sat,  3 Mar 2018 18:35:54 +0700
Message-Id: <20180303113637.26518-2-pclouds@gmail.com>
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

This simplifies initialization of struct repository and anything
inside. Easier to read. Easier to add/remove fields.

Everything will go through main() common-main.c so this should cover all
programs, including t/helper.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 common-main.c |  2 ++
 repository.c  | 18 +++++++++++++-----
 repository.h  |  2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/common-main.c b/common-main.c
index 6a689007e7..7d716d5a54 100644
--- a/common-main.c
+++ b/common-main.c
@@ -34,6 +34,8 @@ int main(int argc, const char **argv)
 
 	git_setup_gettext();
 
+	initialize_the_repository();
+
 	attr_start();
 
 	git_extract_argv0_path(argv[0]);
diff --git a/repository.c b/repository.c
index 4ffbe9bc94..0eddf28fcd 100644
--- a/repository.c
+++ b/repository.c
@@ -4,10 +4,16 @@
 #include "submodule-config.h"
 
 /* The main repository */
-static struct repository the_repo = {
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash_algos[GIT_HASH_SHA1], 0, 0
-};
-struct repository *the_repository = &the_repo;
+static struct repository the_repo;
+struct repository *the_repository;
+
+void initialize_the_repository(void)
+{
+	the_repository = &the_repo;
+
+	the_repo.index = &the_index;
+	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
+}
 
 static char *git_path_from_env(const char *envvar, const char *git_dir,
 			       const char *path, int fromenv)
@@ -128,7 +134,9 @@ static int read_and_verify_repository_format(struct repository_format *format,
  * Initialize 'repo' based on the provided 'gitdir'.
  * Return 0 upon success and a non-zero value upon failure.
  */
-int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
+static int repo_init(struct repository *repo,
+		     const char *gitdir,
+		     const char *worktree)
 {
 	struct repository_format format;
 	memset(repo, 0, sizeof(*repo));
diff --git a/repository.h b/repository.h
index 0329e40c7f..40c1c81bdc 100644
--- a/repository.h
+++ b/repository.h
@@ -91,7 +91,7 @@ extern struct repository *the_repository;
 extern void repo_set_gitdir(struct repository *repo, const char *path);
 extern void repo_set_worktree(struct repository *repo, const char *path);
 extern void repo_set_hash_algo(struct repository *repo, int algo);
-extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
+extern void initialize_the_repository(void);
 extern int repo_submodule_init(struct repository *submodule,
 			       struct repository *superproject,
 			       const char *path);
-- 
2.16.1.435.g8f24da2e1a

