Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2571C1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 03:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752912AbeBXDes (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 22:34:48 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42894 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbeBXDer (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 22:34:47 -0500
Received: by mail-pg0-f68.google.com with SMTP id y8so4085948pgr.9
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 19:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YS83EE6u6f2ry0pCITC0ZqASXHTfzxM1ckbmLF4doI4=;
        b=hwi8OTLIvNKjtowOqUImZohZV6Kb5dLZuwKS7qaN7M+IbuRi6EHtrJNu3ERpMcQ66/
         nFAh5L0CL9FwtSUnmY2N8WhTalOCncOASEdzpRu7910BISzwAavJ3Xi/OOI1JpdW+cgY
         V/9zkGR3geiwjm3nE0fWSeWfpU4nm8fVqIGgiycsrFtqnAp857qPmLpMVB1cIx+UumJy
         xDD5ZSQwZTV7M2b1O1bAmfQ0XCpeD/3r8aj8XZXoMvsTJ8OY8an2Zn9ral9frlie9ufs
         /D2cWHrQ/zbp0mOghuVpwWT/qS3T2Ak8ZUQgPsh2/mPOQ4+lh+HHBCeTcTfxQ4Hirx83
         o48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YS83EE6u6f2ry0pCITC0ZqASXHTfzxM1ckbmLF4doI4=;
        b=ZleEyeAx6/y0T2J8Azy4tn4v2s95ngRnPRhZXNIB4K4urR1KBLmY+N++RCwqvuUTIZ
         6ME7ZqEEqXYGuSCBN7/spUeeoRnUCJ9X4VeqHWLpg/rl5tsf0V+k5iydW2wWyyPZlGp7
         ywwneeL6EMsoNApr8ZAGxWnVBlS2DKCNoOcWIfxS2sqoPWWoXTYk9hdgFpHt+2JHltdh
         In1jyOIed82IUbBFvwv351PdKh0wNQ5GU7AU5infagPGb1H1sbrbDhelqZAFanFUCxnt
         K35JPzNyP9l0isqSuiccWV7kenf7lzZFs8AkbRqwvjuI2E6dagkt7HJqrBDiO8Ha1dpJ
         /JCg==
X-Gm-Message-State: APf1xPCkR6Sj5kDk+MFxdf9vJschP8qyzzqHmF5KkpXKX/E/aJEvD+xa
        KxbkKTFWlP7JDkJ6YDHdOBduFw==
X-Google-Smtp-Source: AH8x226UmFr8T/oR7pkXArOCBdYNKkJf1H+TA42dyr/XCnkxrT5fn5Pu9HjV+jDYLmObl+9wAyS/3w==
X-Received: by 10.98.185.24 with SMTP id z24mr3786069pfe.185.1519443286471;
        Fri, 23 Feb 2018 19:34:46 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 83sm7031966pfj.151.2018.02.23.19.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 19:34:45 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 24 Feb 2018 10:34:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 1/5] setup.c: initialize the_repository correctly in all cases
Date:   Sat, 24 Feb 2018 10:34:25 +0700
Message-Id: <20180224033429.9656-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180224033429.9656-1-pclouds@gmail.com>
References: <20180223095640.25876-1-pclouds@gmail.com>
 <20180224033429.9656-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are many ways for any command to access a git repository:

- most of them will try to discover the .git dir via
  setup_git_directory() and friends

- the server side programs already know where the repo is and prepare
  with enter_repo()

- special commands that deal with repo creation (init/clone) use
  init_db() once the new repo is ready for access.

- somebody accesses $GIT_DIR before any of above functions are called
  and accidentally sets up a git repository by set_git_dir() alone

"the_repository" is partially set up via set_git_dir() at some point
in all four cases. The hash algorithm though is configured later after
.git/config is read.

So far proper repo initialization is done only for the first case [1].
The second case is not covered (but that's fine [3]). The third case
was found and worked around in [2]. The fourth case is a buggy one,
which should be fixed already by jk/no-looking-at-dotgit-outside-repo
and never happens again.

This patch makes sure all cases initialize the hash algorithm in
the_repository correctly. Both second and third cases must run
check_repo_format() before "entering" it. Eventually we probably just
rename this function to init_repo() or something.

[1] 78a6766802 (Integrate hash algorithm support with repo setup -
    2017-11-12)

[2] e26f7f19b6 (repository: pre-initialize hash algo pointer -
    2018-01-19)

[3] the reason server side is still running ok with no hash algo before
    [2] is because the programs that use enter_repo() do very
    little (and unlikely to hash anything) then spawn a new
    program (like pack-objects or upload-archive) to do the heavy
    lifting. These programs already use setup_git_directory() or the
    gently version

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/init-db.c | 3 ++-
 cache.h           | 3 ++-
 path.c            | 2 +-
 setup.c           | 5 ++++-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index c9b7946bad..d119d9906b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -9,6 +9,7 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
+#include "repository.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -369,7 +370,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_repository_format();
+	check_repository_format(the_repository);
 
 	reinit = create_default_files(template_dir, original_git_dir);
 
diff --git a/cache.h b/cache.h
index 21fbcc2414..6b97138264 100644
--- a/cache.h
+++ b/cache.h
@@ -894,6 +894,7 @@ extern int repository_format_precious_objects;
 extern char *repository_format_partial_clone;
 extern const char *core_partial_clone_filter_default;
 
+struct repository;
 struct repository_format {
 	int version;
 	int precious_objects;
@@ -926,7 +927,7 @@ int verify_repository_format(const struct repository_format *format,
  * set_git_dir() before calling this, and use it only for "are we in a valid
  * repo?".
  */
-extern void check_repository_format(void);
+extern void check_repository_format(struct repository *);
 
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
diff --git a/path.c b/path.c
index da8b655730..a544252198 100644
--- a/path.c
+++ b/path.c
@@ -827,7 +827,7 @@ const char *enter_repo(const char *path, int strict)
 
 	if (is_git_directory(".")) {
 		set_git_dir(".");
-		check_repository_format();
+		check_repository_format(the_repository);
 		return path;
 	}
 
diff --git a/setup.c b/setup.c
index c5d55dcee4..a82103832e 100644
--- a/setup.c
+++ b/setup.c
@@ -1180,11 +1180,14 @@ int git_config_perm(const char *var, const char *value)
 	return -(i & 0666);
 }
 
-void check_repository_format(void)
+/* optionally configure "repo" to the correct format */
+void check_repository_format(struct repository *repo)
 {
 	struct repository_format repo_fmt;
 	check_repository_format_gently(get_git_dir(), &repo_fmt, NULL);
 	startup_info->have_repository = 1;
+	if (repo)
+		repo_set_hash_algo(repo, repo_fmt.hash_algo);
 }
 
 /*
-- 
2.16.1.435.g8f24da2e1a

