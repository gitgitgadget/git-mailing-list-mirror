Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D16C1F576
	for <e@80x24.org>; Fri, 23 Feb 2018 09:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeBWJ5K (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 04:57:10 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37732 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbeBWJ5I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 04:57:08 -0500
Received: by mail-pl0-f66.google.com with SMTP id ay8so4624287plb.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 01:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXXjiTAbOqbRH3kO0NuAu+GpmtLrVlIm0JWmiys56oA=;
        b=HWoOIJuoTui9WjjajMXkFII9BQ3dJcImAnmGRC/Yx4fX7mBEgYJTy1pC2QmD1GT2pl
         GnzqkDlNR60RzFEyLXn6uoqikwnWtDQ0QM1AXKNQB/fee/Wvs6+Rxp8qVGLxud/tGBCG
         G1/6XtEGPR3+PHg99snPOV9Ymwx3ES6XQV+fQyCaCtCDNMmTAYFLg2TUgq89CJkI1P68
         w40/vLq8oguYz5Bpt/efE6qFtrmlaJdFWiOpMCTd6CkYQkKEE+jxvLiE4VdnzsE1asdX
         gZaM28xRid0pRhVcKYkFq304vjINU5J8y3kVYbFncaGPyoMEAUoGfHqc5bu2tkcTta4G
         YAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXXjiTAbOqbRH3kO0NuAu+GpmtLrVlIm0JWmiys56oA=;
        b=uDwq+zeu5Ur9eAHiTLqZAuwWCKMVYwaRobvy4yS55KnwuqWW3pUyh1t17BQARPJ5Zp
         hSvcSHb+xWS64Fn2A62YUT+IRvRUwuA7uavc+Q7Gd5a2486K5tC9KD9/YQWkk2J3ZF6g
         eAOm31T/mX2Arpjx8lF5hfNL4fPrm9LdIyRIErPvHmb6Gsul0upk/Zovq4D8DfQxnNGh
         0x8eWxVL6JN6oH6CTN8JtrEGdGmst9yvTla1TO8nj7h3O2jRUbOCsuHWU3plFn7MdH9q
         dN4y9xNrLMys7bmnPLV7puIcKt9cdamoZfulzDtEKHvZ3x3E+clI6r8xzhP76dd8WNsj
         4xhg==
X-Gm-Message-State: APf1xPCycPtg4c7bJPEagOFYMRcGEz+A3H2ZzLPddymbav6NJD4/qVgw
        0WaseoOGkIjP0l33eULgzcd9dg==
X-Google-Smtp-Source: AH8x226oKUzk9bLkBxtQm9BPjpSj1AHD8CwilmBp9PHOxyWdUunSTZoX24BnoZRT5nvbkcz40XajIg==
X-Received: by 2002:a17:902:50e:: with SMTP id 14-v6mr1191224plf.360.1519379827662;
        Fri, 23 Feb 2018 01:57:07 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 63sm3045265pgi.71.2018.02.23.01.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 01:57:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 23 Feb 2018 16:57:02 +0700
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
Subject: [PATCH 1/2] setup.c: initialize the_repository correctly in all cases
Date:   Fri, 23 Feb 2018 16:56:39 +0700
Message-Id: <20180223095640.25876-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180223095640.25876-1-pclouds@gmail.com>
References: <20180214180814.GA139458@google.com>
 <20180223095640.25876-1-pclouds@gmail.com>
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

[3] the reason server side is still running ok with no hash algo
    before [2] is because the programs that use enter_repo() do very
    little then spawn a new program (like pack-objects or
    upload-archive) to do the heavy lifting. These programs already
    use setup_git_dir..()

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

