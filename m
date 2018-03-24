Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CB01F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeCXHqI (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:08 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34487 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeCXHqG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:46:06 -0400
Received: by mail-lf0-f66.google.com with SMTP id c78-v6so16717270lfh.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8YTCrUSEw0SDlW0R89UlrlYYlWbZRLDASIVNFzs7rT4=;
        b=TPOtC4e1DR8lIXO0bTrysJGSIvoR+o2tMR0UdALBKAhs6HbiZJGrD9DTOYbrWZgr9F
         zCqcbk98L/CF8Lqck4w+G99O8dKUIKh8wcleCH6QuAbZc6gVuEfIlaVXR1lMytDydDmc
         qtSM014TBIXXEWSfsxFZ2FOYlsrO1gMjmrcX1dVTrLeyV/LtGFyzFJlIhMEtisRkznHN
         p5LgllKvJDOs8SI0LmhSA0Dkp8/B6503dF2IVBM6kZYhv6Im2AMPPvFvT1sG6oj2Kayx
         ogibmHx1Hc2ocKkuOoMsJB0McCiFWYA2ewgMBFbjBuNxiJaAFox+Ko8dy78JK9UfLenQ
         Mmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8YTCrUSEw0SDlW0R89UlrlYYlWbZRLDASIVNFzs7rT4=;
        b=r92R8yJE5JQ6Nf8Vi/2IFqbyfzYQsJUXBFGQQqFht6EA+b+mtOlYFBdY4S0ljt1Cmt
         JdCkW+gqYF8n0grxSe6QfwXN8Rhabg4r64fCMTTFeXmfHn1K2fsgYDx9G655YxmqEj00
         7u3+c8xHDRsaUPDfI+HnaNsoEC+XOJCa7lP3cfHApks2GQQ0PFFplCe1za19gY1wiJcn
         c2tvWUbvf2cz7Ej8P1gQyw33g9OhhfMyeG7d9zG50JGKsdry4mu1oP9lRVrdQA0aC2gV
         4FdAmzRx/zvNkTIx12Eo502vP8shcP31KoRpGK7Ou7JfC2zS/HlcUELQSN9TEKH+BMxG
         ++SA==
X-Gm-Message-State: AElRT7HQ3jipLIz0Wofj5zLYxfrTUzEfCh2y/kzW6pxporQn60r81fYx
        c4MpT4jBek7tJRsVhgX2RlZd4w==
X-Google-Smtp-Source: AG47ELt+ADQxYVVibFLDbeJRLajYPeNc7X+PS6nYr8/QgoGRtzFi5Wi/areg8yNyFkeLSx506z/dag==
X-Received: by 10.46.129.9 with SMTP id d9mr19657657ljg.96.1521877564952;
        Sat, 24 Mar 2018 00:46:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:46:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 27/36] t/helper: merge test-scrap-cache-tree into test-tool
Date:   Sat, 24 Mar 2018 08:44:56 +0100
Message-Id: <20180324074505.19100-28-pclouds@gmail.com>
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
 Makefile                         | 2 +-
 t/helper/test-scrap-cache-tree.c | 3 ++-
 t/helper/test-tool.c             | 1 +
 t/helper/test-tool.h             | 1 +
 t/t0090-cache-tree.sh            | 8 ++++----
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index adece67b8e..ba7c7d8a79 100644
--- a/Makefile
+++ b/Makefile
@@ -676,6 +676,7 @@ TEST_BUILTINS_OBJS += test-ref-store.o
 TEST_BUILTINS_OBJS += test-regex.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
 TEST_BUILTINS_OBJS += test-run-command.o
+TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -684,7 +685,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1-array
 TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-strcmp-offset
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index d2a63bea43..d26d3e7c8b 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "lockfile.h"
 #include "tree.h"
@@ -5,7 +6,7 @@
 
 static struct lock_file index_lock;
 
-int cmd_main(int ac, const char **av)
+int cmd__scrap_cache_tree(int ac, const char **av)
 {
 	setup_git_directory();
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 94ceda66e7..96d8df69d4 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -31,6 +31,7 @@ static struct test_cmd cmds[] = {
 	{ "regex", cmd__regex },
 	{ "revision-walking", cmd__revision_walking },
 	{ "run-command", cmd__run_command },
+	{ "scrap-cache-tree", cmd__scrap_cache_tree },
 	{ "sha1", cmd__sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 0fe2dd640b..448119a44a 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -25,6 +25,7 @@ int cmd__ref_store(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
 int cmd__run_command(int argc, const char **argv);
+int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 3266209e41..4ae0995cd9 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -115,14 +115,14 @@ test_expect_success 'update-index invalidates cache-tree' '
 '
 
 test_expect_success 'write-tree establishes cache-tree' '
-	test-scrap-cache-tree &&
+	test-tool scrap-cache-tree &&
 	git write-tree &&
 	test_cache_tree
 '
 
-test_expect_success 'test-scrap-cache-tree works' '
+test_expect_success 'test-tool scrap-cache-tree works' '
 	git read-tree HEAD &&
-	test-scrap-cache-tree &&
+	test-tool scrap-cache-tree &&
 	test_no_cache_tree
 '
 
@@ -170,7 +170,7 @@ test_expect_success 'commit in child dir has cache-tree' '
 '
 
 test_expect_success 'reset --hard gives cache-tree' '
-	test-scrap-cache-tree &&
+	test-tool scrap-cache-tree &&
 	git reset --hard &&
 	test_cache_tree
 '
-- 
2.17.0.rc0.348.gd5a49e0b6f

