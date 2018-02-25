Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1BC61F576
	for <e@80x24.org>; Sun, 25 Feb 2018 11:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeBYLTZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 06:19:25 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43543 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbeBYLTX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 06:19:23 -0500
Received: by mail-pl0-f68.google.com with SMTP id f23so7624503plr.10
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 03:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2SJahbPTegu1VghNg2kWWEi6o4h7cdzf4E3vhjYKz8=;
        b=G6f6Bd5XWZyuyQx3YpK0yrgFcsMxPRtzQOfDVNEtTBGm1k0h+5BpfnRgnb8eqmnQlS
         RCA6JzSO4tuQimQGS3lKIlIzbeid/aocGmNJ2IVCKtN8ssGZuujCnvRSYS0CRIQGOuhr
         qxp6teGrz5XFxKuE2nLibuyLTvho8c2Y8IOBLuVYAo5U5+UZWK2n9IxhQbo2Cil2yOOQ
         9G5+RVJhMFtbTjjAINJmgaaN6A4X2o/Hy3uh/gr0EUiNNXgHNYzITUu9fKlBf10AeM0M
         Xe42GJK+Z1uM+3ybutIOQydnl6p7fgV02ZB02MGN4f3LXHgMzeZwfYslemEKtZslmihm
         Fovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2SJahbPTegu1VghNg2kWWEi6o4h7cdzf4E3vhjYKz8=;
        b=OZHLx4FnMp46VPt0Resi+Rs3xzvB9fB9KqUEbkZ8/jHS86W7TGTd70A8BHRIrdrgVE
         5ZApS/eqpblv5pr4Uut2b1HGKOBUSju1YJZnN/GqSOjygAliK+H1TayvxPKQnKDxLxVs
         ZchvI5O3OFiHD1c+glf8dDVxIG0UxjwY07sj/BWhsQHV5itToHZWuGUBY79y0Py+pL7n
         1XFnkOHHwEa/yaBV1RHnkFkY5q0FRrAoWYM6QHiYXhd8IEsNFAe0tTLHiKLFZkDy90jO
         I5ADKoLI/TLi0xQgMJrAZFR7poiwOZobVGW8EbJqwBu84FMCk7Tw8WcHPXauga1Rgl3v
         zn6Q==
X-Gm-Message-State: APf1xPDCZE2NXxCKFxGDn8WwLIJd/fEfNwBqaneTlIT6KXR9/F/xCY9m
        WzDHrTCj59gjlJcqcesWBaxiIQ==
X-Google-Smtp-Source: AH8x224CLSfmmoDYIOTDKkJw3/FEA4l/+gjlpUXmTUq6dmYIlmR1Ll1mSJT7Gm3xwfhZ1E417p07WA==
X-Received: by 2002:a17:902:64d7:: with SMTP id y23-v6mr7282872pli.258.1519557562835;
        Sun, 25 Feb 2018 03:19:22 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 76sm14288427pfp.53.2018.02.25.03.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 03:19:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 25 Feb 2018 18:19:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH v3 6/6] Revert "repository: pre-initialize hash algo pointer"
Date:   Sun, 25 Feb 2018 18:18:40 +0700
Message-Id: <20180225111840.16421-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180225111840.16421-1-pclouds@gmail.com>
References: <20180224033429.9656-1-pclouds@gmail.com>
 <20180225111840.16421-1-pclouds@gmail.com>
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

Since this is a dangerous move and could potentially break stuff after
release (and leads to workaround like the reverted commit), the
workaround technically remains, but is hidden behind a new environment
variable GIT_HASH_FIXUP. This should let the users continue to use git
while we fix the problem. This variable can be deleted after one or two
releases.

test-dump-split-index.c needs to call setup_git_directory() after this
to configure hash algorithm before parsing the index file. It's not the
best way (i.e. check index file version) but it's a test tool, this is
good enough.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 common-main.c                    | 10 ++++++++++
 repository.c                     |  2 +-
 repository.h                     |  5 +++++
 t/helper/test-dump-split-index.c |  2 ++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/common-main.c b/common-main.c
index 6a689007e7..fbfa98c3b8 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "attr.h"
+#include "repository.h"
 
 /*
  * Many parts of Git have subprograms communicate via pipe, expect the
@@ -40,5 +41,14 @@ int main(int argc, const char **argv)
 
 	restore_sigpipe_to_default();
 
+	/*
+	 * Temporary recovery measure while hashing code is being
+	 * refactored. This variable should be gone after everybody
+	 * has used the_hash_algo in one or two releases and nobody
+	 * complains anything.
+	 */
+	if (getenv("GIT_HASH_FIXUP"))
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	return cmd_main(argc, argv);
 }
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
 
diff --git a/repository.h b/repository.h
index 02c695bc74..40bd49611f 100644
--- a/repository.h
+++ b/repository.h
@@ -110,6 +110,11 @@ extern int repo_read_index(struct repository *repo);
 static inline const struct git_hash_algo *repo_get_hash_algo(
 	const struct repository *repo)
 {
+	if (!repo->hash_algo)
+		die("BUG: hash_algo is not initialized!\n%s",
+		    _("You can work around this by setting environment"
+		      " variable GIT_HASH_FIXUP=1.\n"
+		      "Please report this to git@vger.kernel.org"));
 	return repo->hash_algo;
 }
 
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

