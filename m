Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FB231F576
	for <e@80x24.org>; Fri, 23 Feb 2018 09:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeBWJ5P (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 04:57:15 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33326 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbeBWJ5O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 04:57:14 -0500
Received: by mail-pl0-f66.google.com with SMTP id c11-v6so1220020plo.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 01:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SjApSL5wjMLmh35Z4U1C/ncr8mIdobCTxLUnF0/DL3Q=;
        b=FHDODRh3TQmV/i6ObP2VHOPopXqcdnxVOO8dJhx0swmhOwuUyHUQBJqzOJkEijWe02
         33XB0NbeMhforWdsVc7M2XpAKIX1b2sohfcxwC6TKiSd6heIf4JtWgP3PD6teYAyD3+a
         6aiKDeaj0IWZk/qkAy3jg+APB+qL0gCiFM4M8Yjys+YsKDyzx4ZGlr+H018In/fqGEhn
         k8WVhUVPqhrOnfT4hvNfrg8HO6BZmNM2QuIV9wgV8PGoQIXYtfytiB7uyYQlbXFSI6Qh
         p417Ytrz1mkszLOmySLub5z9nTJ83d4496xCSseL1J2iHZzkAq2R0YFM/B5RYmgaWX/Q
         SnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SjApSL5wjMLmh35Z4U1C/ncr8mIdobCTxLUnF0/DL3Q=;
        b=gsg2dzIKaaZLRt/+wQZQtiMBgbLMJzZ7Qf1n+KhMHzASF9xnQhMnVDMQf/gp/1L60s
         3aBniVJwaRBmGA2ATVHbPnZIWaFzl2TBGCS9ncT8fG2ZYnnrPuKINZJCxrdDfP0kWD91
         FfyQN58ZiZzBwnHMoVoO1BufhDtLhmVHaDqT3JMxmTrhX80kSCdShhwrBfWjHo4IN5u8
         9l9EOkB8Q7zT66fxcLihGYpArsaX5FSJjkpj/JW/UzdgHqW0aCJb8GKnP7qoH9NBuTD9
         qS+sR1b0lm630YvRFFQji+3Tm0bQ749hWYfWE5MEWBTApPD0CdXq82qKEFz4IvbFPPLO
         XXyA==
X-Gm-Message-State: APf1xPBUTk+fUX1ov1IwLDKTjvyiyoYF1t+78+R02FNSNQ5fckpHUF+q
        5NS2UC9EWceccCKX9r7TB5tOVA==
X-Google-Smtp-Source: AH8x2251VlnahZWuuGeUCFKfrw1qdMclhN53xaQwxVYOwPQNmL4Kze9PX5jTTIHrNnhyt1/WFSA6rw==
X-Received: by 2002:a17:902:3183:: with SMTP id x3-v6mr1164088plb.383.1519379833675;
        Fri, 23 Feb 2018 01:57:13 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id q66sm4150179pfi.95.2018.02.23.01.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 01:57:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 23 Feb 2018 16:57:07 +0700
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
Subject: [PATCH 2/2] Revert "repository: pre-initialize hash algo pointer"
Date:   Fri, 23 Feb 2018 16:56:40 +0700
Message-Id: <20180223095640.25876-3-pclouds@gmail.com>
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

This reverts commit e26f7f19b6c7485f04234946a59ab8f4fd21d6d1. The root
problem, git clone not setting up the_hash_algo, has been fixed in the
previous patch.

As a result of the revert, some code paths that use the_hash_algo
without initialization is revealed and fixed here. It's basically
commands that are allowed to run without a repository. The fix here is
not the best. We probably could figure out the hash algorithm from input
somehow.

Since this is a dangerous move and could potentially break stuff after
release (and leads to workaround like the reverted commit), the
workaround technically remains, but is hidden behind a new environment
variable GIT_HASH_FIXUP. This should let the users continue to use git
while we fix the problem.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/index-pack.c             | 5 +++++
 common-main.c                    | 4 ++++
 diff-no-index.c                  | 5 +++++
 repository.c                     | 2 +-
 t/helper/test-dump-split-index.c | 2 ++
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7e3e1a461c..8ee935504e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1673,6 +1673,11 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (prefix && chdir(prefix))
 		die(_("Cannot come back to cwd"));
 
+	if (!the_hash_algo) {
+		warning(_("Running without a repository, assuming SHA-1 hash"));
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+	}
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
diff --git a/common-main.c b/common-main.c
index 6a689007e7..12aec36794 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "attr.h"
+#include "repository.h"
 
 /*
  * Many parts of Git have subprograms communicate via pipe, expect the
@@ -40,5 +41,8 @@ int main(int argc, const char **argv)
 
 	restore_sigpipe_to_default();
 
+	if (getenv("GIT_HASH_FIXUP"))
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	return cmd_main(argc, argv);
 }
diff --git a/diff-no-index.c b/diff-no-index.c
index 0ed5f0f496..f038f665bc 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -241,6 +241,11 @@ void diff_no_index(struct rev_info *revs,
 	struct strbuf replacement = STRBUF_INIT;
 	const char *prefix = revs->prefix;
 
+	if (!the_hash_algo) {
+		warning(_("Running without a repository, assuming SHA-1 hash"));
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+	}
+
 	diff_setup(&revs->diffopt);
 	for (i = 1; i < argc - 2; ) {
 		int j;
diff --git a/repository.c b/repository.c
index 4ffbe9bc94..0d715f4fdb 100644
--- a/repository.c
+++ b/repository.c
@@ -5,7 +5,7 @@
 
 /* The main repository */
 static struct repository the_repo = {
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash_algos[GIT_HASH_SHA1], 0, 0
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL, 0, 0
 };
 struct repository *the_repository = &the_repo;
 
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index e44430b699..b759fe3fc1 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -12,6 +12,8 @@ int cmd_main(int ac, const char **av)
 	struct split_index *si;
 	int i;
 
+	setup_git_directory();
+
 	do_read_index(&the_index, av[1], 1);
 	printf("own %s\n", sha1_to_hex(the_index.sha1));
 	si = the_index.split_index;
-- 
2.16.1.435.g8f24da2e1a

