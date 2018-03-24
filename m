Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4141E1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeCXHre (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:47:34 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33394 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeCXHpo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:44 -0400
Received: by mail-lf0-f65.google.com with SMTP id x205-v6so21414133lfa.0
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNZj8AC3nKs6beAqOWV4ijKv4vmh/cSd0MdOm0eBQvU=;
        b=Py1ppWwgvxHaQCKbtK9a75yrw8VFNGVaKisdyN60u3MdZRWc0P/Q4623htiLm4SiRr
         rkPp0ySspTotMemZmF2pZ/n/O7R/eltTRsG2+a55ogWCe12lSYJuI+KZFVtjQ/vNgF4g
         BOg63Jfu2YEMzz3KOOwLfKyHhezWjGW1Q+jbQROlNeTPOsFt9rmWll6T/pQ4/QPV0NK+
         zdmKaJ6VxS0qY/r5L3WCLECskoqbjaxK+uI0T5FmGyVVoe2/3p1sBlgfu1yMFgjK3PvI
         r9B72vVvI7UtMZxGGF553lGdgvGwk66AGA/7M96Wqs3PpJzm36xGyEfxHBeG3BCQPexx
         x7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNZj8AC3nKs6beAqOWV4ijKv4vmh/cSd0MdOm0eBQvU=;
        b=Z6ePuSvUQAV/ThqXjgK6bNQeTHN3lXVvp35ZpEnXlJ4xueUpvvudWaPa7qwJto+fs6
         xdTymb+3VU6n8jrarBYLLjvaNv4yWnDTIB5Y+Vek9gwLWG0rHmadXN6vPXT2SqsgVeyE
         0S12w32bx+ABvttlXR9P2KQKsGtydpgqnkjTo6KUNQ6MIz+9+4DBXlFfkN42A2C7XmDo
         G9to4FjZIXZ4d4Zh6RlIeUIbDc/j9aWRHIC9a+6AgCXThf0uInCelAc8bVsu1PmUq46i
         Uhctrg8ixVPRz3z1LEdw8+8sr0hj5r5qS4t63pd+QB5VzI8BemwLYLEsvchWvT1lVgdf
         udXQ==
X-Gm-Message-State: AElRT7HoKIkTwGBM0l468pb3HiY2jUiMNKtDz2nUew14PRHq3bTyItbq
        OS5SQa7AzD4dXogTzGx6PSk=
X-Google-Smtp-Source: AG47ELtwo6BTAbNs9hcdTefd8FfjZxFDAOVME6nF2YqY+12cgjMpPWPNJ4GTrvDs82tb3EEDz+bYjg==
X-Received: by 2002:a19:a387:: with SMTP id m129-v6mr10636710lfe.31.1521877542672;
        Sat, 24 Mar 2018 00:45:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/36] t/helper: merge test-dump-cache-tree into test-tool
Date:   Sat, 24 Mar 2018 08:44:39 +0100
Message-Id: <20180324074505.19100-11-pclouds@gmail.com>
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
index ebf3aab22d..98a4891f1d 100644
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
+int cmd__dump_cache_tree(int ac, const char **av)
 {
 	struct index_state istate;
 	struct cache_tree *another = cache_tree();
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b6f648d387..3d8d9ed1ce 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -13,6 +13,7 @@ static struct test_cmd cmds[] = {
 	{ "date", cmd__date },
 	{ "delta", cmd__delta },
 	{ "drop-caches", cmd__drop_caches },
+	{ "dump-cache-tree", cmd__dump_cache_tree },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "sha1", cmd__sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f585b7776e..2a0d034adf 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -7,6 +7,7 @@ int cmd__ctype(int argc, const char **argv);
 int cmd__date(int argc, const char **argv);
 int cmd__delta(int argc, const char **argv);
 int cmd__drop_caches(int argc, const char **argv);
+int cmd__dump_cache_tree(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
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
2.17.0.rc0.348.gd5a49e0b6f

