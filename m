Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9D8F1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeCXHqB (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:01 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34464 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbeCXHpx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:53 -0400
Received: by mail-lf0-f68.google.com with SMTP id c78-v6so16716808lfh.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RgPqe2GGe9EhZuSnAG/SrOsddVPqLIWz6PP4n53DADY=;
        b=Lq7mCE+0Mc60B7HtAhy8Hov+SVV0tXQjaXEEGEymzK4e20jArBg6AIKANj48hd2cde
         y54VF9+NnWv+AxmTvVB9DfdtXR2i4PSZ0TU2TKvhyQ88araqnoPKpxAqOwGolSh14agq
         6ZHTXUpWp07DOwrng1qgh7lD1f95/O06Dzroftcxf+zPLrv65v3tvVneWLFnD7l4MGZX
         9J78lgqSAnm8P5yP0+Fvgbn779bYtyJPERAW9lwufan6i+xRnnSWj3otrPVIfjDcWPyJ
         TE19YrnpMqbJQ4SrNIqBorfCyoK/vbpIaQ9FGaVDfoXe/7tdcGaocwijIML2iNZemFi+
         dcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RgPqe2GGe9EhZuSnAG/SrOsddVPqLIWz6PP4n53DADY=;
        b=Betki9gozamKw0P0x38v4I3FrumpKBkwBqZ3ZbUylrGIMLZ0m985sOQR0nHI5qbp/u
         oulbQcT9oD5Dhyg1yfZxlgOWDC6D7+TndOTSbW7WQZ+T8Iwa+EtAY++9ST//0evCkBGa
         pk1qTZ1N4k/hVSN+R9XL43vZimDXSQg/KcmasqgIZDKbR1q+D8TORNgzX4xT7YJRLYdc
         XFpOs4lQeA6GgPWenPQ0lLWqBsAnO9DaUs2FYujt60XxKiLxgF36O/fsS/G6C9Jlwmxz
         k51pivL8OMP19DrLi3CcWjMPpq7seWE8yo69/TRCkrGN/O1qH7EkvdbLIH1KH5j1eUgz
         V0Jw==
X-Gm-Message-State: AElRT7Hqex1UOiIq9nocSbkpqJEdypjLTFWU/xXnjeT674Pn1tLGvn8r
        KZ3HE95mcbR4LSZ6mLfJYXk=
X-Google-Smtp-Source: AG47ELtbKygWDEB3O/DMx3F4+EMBsYaUyVvpMfJxANNkBKZndPu6JJLkGB3PDEh09wp8ObuuNEMIJg==
X-Received: by 2002:a19:4402:: with SMTP id r2-v6mr21783898lfa.105.1521877552352;
        Sat, 24 Mar 2018 00:45:52 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 18/36] t/helper: merge test-mktemp into test-tool
Date:   Sat, 24 Mar 2018 08:44:47 +0100
Message-Id: <20180324074505.19100-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324074505.19100-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
 <20180324074505.19100-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile               | 2 +-
 t/helper/test-mktemp.c | 3 ++-
 t/helper/test-tool.c   | 1 +
 t/helper/test-tool.h   | 1 +
 t/t0070-fundamental.sh | 4 ++--
 5 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 67f37b849e..3145a9b1b2 100644
--- a/Makefile
+++ b/Makefile
@@ -667,13 +667,13 @@ TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
+TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
-TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-online-cpus
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
diff --git a/t/helper/test-mktemp.c b/t/helper/test-mktemp.c
index 89d9b2f7be..2290688940 100644
--- a/t/helper/test-mktemp.c
+++ b/t/helper/test-mktemp.c
@@ -1,9 +1,10 @@
 /*
  * test-mktemp.c: code to exercise the creation of temporary files
  */
+#include "test-tool.h"
 #include "git-compat-util.h"
 
-int cmd_main(int argc, const char **argv)
+int cmd__mktemp(int argc, const char **argv)
 {
 	if (argc != 2)
 		usage("Expected 1 parameter defining the temporary file template");
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 7ec0e8efe5..fd3bf560d4 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -22,6 +22,7 @@ static struct test_cmd cmds[] = {
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "match-trees", cmd__match_trees },
 	{ "mergesort", cmd__mergesort },
+	{ "mktemp", cmd__mktemp },
 	{ "sha1", cmd__sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 6c9437ff5e..cf2598798a 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -16,6 +16,7 @@ int cmd__index_version(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
+int cmd__mktemp(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 70d4d98a2e..ac007938ee 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -13,7 +13,7 @@ test_expect_success 'character classes (isspace, isalpha etc.)' '
 '
 
 test_expect_success 'mktemp to nonexistent directory prints filename' '
-	test_must_fail test-mktemp doesnotexist/testXXXXXX 2>err &&
+	test_must_fail test-tool mktemp doesnotexist/testXXXXXX 2>err &&
 	grep "doesnotexist/test" err
 '
 
@@ -21,7 +21,7 @@ test_expect_success POSIXPERM,SANITY 'mktemp to unwritable directory prints file
 	mkdir cannotwrite &&
 	chmod -w cannotwrite &&
 	test_when_finished "chmod +w cannotwrite" &&
-	test_must_fail test-mktemp cannotwrite/testXXXXXX 2>err &&
+	test_must_fail test-tool mktemp cannotwrite/testXXXXXX 2>err &&
 	grep "cannotwrite/test" err
 '
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

