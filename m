Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABBBE1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeCQHzp (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:55:45 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46697 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeCQHzn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:43 -0400
Received: by mail-lf0-f66.google.com with SMTP id w16-v6so18466935lfc.13
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ah9WsGVcNoKp3MQPkV9RsS1LWg5+8U1qN6q6D/dysU=;
        b=OepDOI8DY4w/X+P9pcv13UvzyxpUNAz4k+XRqmRjKFlriBuBP+sz+TbVMsBaSng6Wo
         JsowO9SARtThbWjQxxFskgPKb/jme9/A70j3nYNy5h+xkcjaL+F24jiRWxl3TLY1Xnqy
         A4Vi/cOqKTdayIFPr3Q/VR/3vD2yoHXAuAfIkIVBz4GkU+/xrjYfT7FuY4oT8ul2ckXt
         201NbfZiBRGtEttahspFokcktSggZKqxFlCeipXSvSj0pgXZCKtzoF1d1id1oE+ogbLb
         Z8C2mbGsu5rXGF94RjFrtG1i+OoY5/6wsy4pzQwHoKlpctwM0GGUd6gWEWrjZoqQ0tCy
         BuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ah9WsGVcNoKp3MQPkV9RsS1LWg5+8U1qN6q6D/dysU=;
        b=cTsO+VaLO/5zocNYe4QRKhuouvzFzFlJ0H8wI8yv6Bj5e4Q0q0Fdt+IWb8ySHr7UuG
         dDiLISOUnrZqsIE0+7KB9Ruhzbe31JvCegCmoJwdgPqarO9AtHzUyNjijLgr1WUoq1Ck
         HpZhfMtdnhhbJmbb2dKQfm3hJhXUsRYGn4DhrmNsl9CC+sZHPc+ih8dFpYdxVuUB7TRs
         Re7q4qnyr67tL7XNoIDqRxBDe/rfpVVEHu/vvAB9Q9i/Qi5PzSVN4FXEYbtC6DucJyVU
         BznoLD6j1O+khHUCRPM0crbGdidKiVySyxh6xW/5ioPguTup9Gka1wrcHvmKFg9fVcK+
         V/ZA==
X-Gm-Message-State: AElRT7H5PZjuXvsOhGcFA77x2dczbsDIJxu5376NKuyuWV4Goz0VcGPH
        RAZ05lGUKnqOjn7LOmXpA6FWCA==
X-Google-Smtp-Source: AG47ELviJbCtQrGl7PpdU74PqwK3imRyOyxGZeKQjbI9EBAu/s75ZLc3iz/LddknLkIBq9KjW6MirA==
X-Received: by 2002:a19:9a0a:: with SMTP id c10-v6mr3419997lfe.30.1521273341296;
        Sat, 17 Mar 2018 00:55:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/36] t/helper: merge test-dump-cache-tree into test-tool
Date:   Sat, 17 Mar 2018 08:53:55 +0100
Message-Id: <20180317075421.22032-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180317075421.22032-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                        | 2 +-
 t/helper/test-dump-cache-tree.c | 3 ++-
 t/helper/test-tool.c            | 1 +
 t/helper/test-tool.h            | 1 +
 t/t0090-cache-tree.sh           | 6 +++---
 t/t1700-split-index.sh          | 2 +-
 6 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index edd9c43982..991bafa6fb 100644
--- a/Makefile
+++ b/Makefile
@@ -658,10 +658,10 @@ TEST_BUILTINS_OBJS += test-ctype.o
 TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delta.o
 TEST_BUILTINS_OBJS += test-drop-caches.o
+TEST_BUILTINS_OBJS += test-dump-cache-tree.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
-TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-split-index
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index ebf3aab22d..2697152e50 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "tree.h"
 #include "cache-tree.h"
@@ -54,7 +55,7 @@ static int dump_cache_tree(struct cache_tree *it,
 	return errs;
 }
 
-int cmd_main(int ac, const char **av)
+int test_dump_cache_tree(int ac, const char **av)
 {
 	struct index_state istate;
 	struct cache_tree *another = cache_tree();
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 904e4103fd..9c56c169c2 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -13,6 +13,7 @@ static struct test_cmd cmds[] = {
 	{ "date", test_date },
 	{ "delta", test_delta },
 	{ "drop-caches", test_drop_caches },
+	{ "dump-cache-tree", test_dump_cache_tree },
 	{ "lazy-init-name-hash", test_lazy_init_name_hash },
 	{ "sha1", test_sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 1e96bf44a2..37e578b75e 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -7,6 +7,7 @@ int test_ctype(int argc, const char **argv);
 int test_date(int argc, const char **argv);
 int test_delta(int argc, const char **argv);
 int test_drop_caches(int argc, const char **argv);
+int test_dump_cache_tree(int argc, const char **argv);
 int test_lazy_init_name_hash(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index adfd4f0b5e..f81e3deead 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -8,13 +8,13 @@ cache-tree extension.
  . ./test-lib.sh
 
 cmp_cache_tree () {
-	test-dump-cache-tree | sed -e '/#(ref)/d' >actual &&
+	test-tool dump-cache-tree | sed -e '/#(ref)/d' >actual &&
 	sed "s/$_x40/SHA/" <actual >filtered &&
 	test_cmp "$1" filtered
 }
 
 # We don't bother with actually checking the SHA1:
-# test-dump-cache-tree already verifies that all existing data is
+# test-tool dump-cache-tree already verifies that all existing data is
 # correct.
 generate_expected_cache_tree_rec () {
 	dir="$1${1:+/}" &&
@@ -47,7 +47,7 @@ test_cache_tree () {
 
 test_invalid_cache_tree () {
 	printf "invalid                                  %s ()\n" "" "$@" >expect &&
-	test-dump-cache-tree |
+	test-tool dump-cache-tree |
 	sed -n -e "s/[0-9]* subtrees//" -e '/#(ref)/d' -e '/^invalid /p' >actual &&
 	test_cmp expect actual
 }
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 4b5d443280..b778975de8 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -435,7 +435,7 @@ test_expect_success 'writing split index with null sha1 does not write cache tre
 	commit=$(git commit-tree $tree -p HEAD <msg) &&
 	git update-ref HEAD "$commit" &&
 	GIT_ALLOW_NULL_SHA1=1 git reset --hard &&
-	(test-dump-cache-tree >cache-tree.out || true) &&
+	(test-tool dump-cache-tree >cache-tree.out || true) &&
 	test_line_count = 0 cache-tree.out
 '
 
-- 
2.16.2.903.gd04caf5039

