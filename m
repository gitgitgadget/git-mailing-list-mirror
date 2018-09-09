Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155CC1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 17:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeIIW1E (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 18:27:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42655 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbeIIW1D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 18:27:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id z11-v6so15630805lff.9
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMiWs7niUsz9wqiIH675JT4TbW7ELu/v+RLxLzOQCoM=;
        b=Hk3tnbjKc7RkzakUNPP4XL7nIpzQ9gGLxk8sNhIZxa5SGOUOUxEx7q8MRflZkVYEG6
         gUIbgv3pxg3I7aP51Zt3X7GCtgvNua0TGHf9LbfWkJEVP4fQf5xTBAFhzbyJokr60d/P
         UHrID13VIeQr1kiexb+iLpOzJvV75dFpb0iBwxzDCrw+pWUtJIl8M4nimGJE1UerCSHD
         wnmuEGtTdUzteSXFxIcf4ouGbhKno5kcRcnkrSaaWOG4sFcHokKmmnFuxiDDaTxwDazg
         3RkyBHX4CId4rRIs2rLi3rsbjxwj5F0XRLwJ5K1jJ7obbqV/i8+lPQtBC2PLQpZcflff
         NEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMiWs7niUsz9wqiIH675JT4TbW7ELu/v+RLxLzOQCoM=;
        b=QfHBP/g2ucg2zT/wnwmMixGblosfmjn5DJbs20x+KM365qCOAqwZ2JRqvjwpydIrBQ
         BxET8hwcGZpRg6gR0NC1Y5gh5HrOH0mFkCAUNElfYwLiKDLBQ7N7qE5eWouTp6pvFwJJ
         QTaIuOi5eDAvgRyDkcN3H+Lpm2NRtvOJmPpNOLxMSuU3t43UM4dHxyNeXIiu3Nk5sz5Z
         zg4qbzJ9beu5TMa+3BMLEbT0lpjadOvOYz0s5rlU/rmYaUKy6a4+mGJqKkgwKZG2ErGs
         9KuhSR2epuDyK4MWvObFWGpsEU6VvTmxAasueuyDoHU8CNiqVhbk6HINkdkZMFeF33O5
         p8zg==
X-Gm-Message-State: APzg51Bk0HCnRD5z9XR8deJnUWzmimZKGo8wUvbYL9rMPgm0mrGyShHb
        MY9ArGSOzVHmUZyaEEqNR2+rWwgn
X-Google-Smtp-Source: ANB0Vda51rsh1NdCOjHRwezWoSC3XDR/I7hRB46dUSX0JCSs1KsWLI6GgXlS39Vurw1LrrQMwnTgMg==
X-Received: by 2002:a19:124d:: with SMTP id h74-v6mr10158107lfi.107.1536514598962;
        Sun, 09 Sep 2018 10:36:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u19-v6sm2317793lje.51.2018.09.09.10.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 10:36:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/6] t/helper: merge test-dump-untracked-cache into test-tool
Date:   Sun,  9 Sep 2018 19:36:27 +0200
Message-Id: <20180909173631.1446-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909173631.1446-1-pclouds@gmail.com>
References: <20180909173631.1446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                             |  2 +-
 t/helper/test-dump-untracked-cache.c |  3 +-
 t/helper/test-tool.c                 |  1 +
 t/helper/test-tool.h                 |  1 +
 t/t7063-status-untracked-cache.sh    | 68 ++++++++++++++--------------
 t/t7519-status-fsmonitor.sh          |  4 +-
 6 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/Makefile b/Makefile
index 1208584fa1..fa67d76780 100644
--- a/Makefile
+++ b/Makefile
@@ -710,6 +710,7 @@ TEST_BUILTINS_OBJS += test-delta.o
 TEST_BUILTINS_OBJS += test-drop-caches.o
 TEST_BUILTINS_OBJS += test-dump-cache-tree.o
 TEST_BUILTINS_OBJS += test-dump-split-index.o
+TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-hashmap.o
@@ -741,7 +742,6 @@ TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-write-cache.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
-TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index bd92fb305a..52870ebbb3 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "dir.h"
 
@@ -38,7 +39,7 @@ static void dump(struct untracked_cache_dir *ucd, struct strbuf *base)
 	strbuf_setlen(base, len);
 }
 
-int cmd_main(int ac, const char **av)
+int cmd__dump_untracked_cache(int ac, const char **av)
 {
 	struct untracked_cache *uc;
 	struct strbuf base = STRBUF_INIT;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 79e03eecb5..820335704a 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -15,6 +15,7 @@ static struct test_cmd cmds[] = {
 	{ "drop-caches", cmd__drop_caches },
 	{ "dump-cache-tree", cmd__dump_cache_tree },
 	{ "dump-split-index", cmd__dump_split_index },
+	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "example-decorate", cmd__example_decorate },
 	{ "genrandom", cmd__genrandom },
 	{ "hashmap", cmd__hashmap },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 4b7212827a..118c700c7a 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -11,6 +11,7 @@ int cmd__delta(int argc, const char **argv);
 int cmd__drop_caches(int argc, const char **argv);
 int cmd__dump_cache_tree(int argc, const char **argv);
 int cmd__dump_split_index(int argc, const char **argv);
+int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 2da57fce7b..190ae149cf 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -55,7 +55,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'untracked cache is empty' '
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	cat >../expect-empty <<EOF &&
 info/exclude 0000000000000000000000000000000000000000
 core.excludesfile 0000000000000000000000000000000000000000
@@ -106,7 +106,7 @@ EOF
 '
 
 test_expect_success 'untracked cache after first status' '
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../dump.expect ../actual
 '
 
@@ -126,7 +126,7 @@ EOF
 '
 
 test_expect_success 'untracked cache after second status' '
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../dump.expect ../actual
 '
 
@@ -157,7 +157,7 @@ EOF
 '
 
 test_expect_success 'verify untracked cache dump' '
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude $EMPTY_BLOB
 core.excludesfile 0000000000000000000000000000000000000000
@@ -204,7 +204,7 @@ EOF
 '
 
 test_expect_success 'verify untracked cache dump' '
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude $EMPTY_BLOB
 core.excludesfile 0000000000000000000000000000000000000000
@@ -248,7 +248,7 @@ EOF
 '
 
 test_expect_success 'verify untracked cache dump' '
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
 core.excludesfile 0000000000000000000000000000000000000000
@@ -267,7 +267,7 @@ EOF
 
 test_expect_success 'move two from tracked to untracked' '
 	git rm --cached two &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
 core.excludesfile 0000000000000000000000000000000000000000
@@ -304,7 +304,7 @@ EOF
 '
 
 test_expect_success 'verify untracked cache dump' '
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
 core.excludesfile 0000000000000000000000000000000000000000
@@ -324,7 +324,7 @@ EOF
 
 test_expect_success 'move two from untracked to tracked' '
 	git add two &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
 core.excludesfile 0000000000000000000000000000000000000000
@@ -361,7 +361,7 @@ EOF
 '
 
 test_expect_success 'verify untracked cache dump' '
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
 core.excludesfile 0000000000000000000000000000000000000000
@@ -405,7 +405,7 @@ EOF
 '
 
 test_expect_success 'untracked cache correct after commit' '
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
 core.excludesfile 0000000000000000000000000000000000000000
@@ -464,7 +464,7 @@ EOF
 '
 
 test_expect_success 'untracked cache correct after status' '
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
 core.excludesfile 0000000000000000000000000000000000000000
@@ -532,7 +532,7 @@ EOF
 '
 
 test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	cat >../expect-from-test-dump <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
 core.excludesfile 0000000000000000000000000000000000000000
@@ -598,66 +598,66 @@ EOF
 
 test_expect_success '--no-untracked-cache removes the cache' '
 	git update-index --no-untracked-cache &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	echo "no untracked cache" >../expect-no-uc &&
 	test_cmp ../expect-no-uc ../actual
 '
 
 test_expect_success 'git status does not change anything' '
 	git status &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-no-uc ../actual
 '
 
 test_expect_success 'setting core.untrackedCache to true and using git status creates the cache' '
 	git config core.untrackedCache true &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-no-uc ../actual &&
 	git status &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-from-test-dump ../actual
 '
 
 test_expect_success 'using --no-untracked-cache does not fail when core.untrackedCache is true' '
 	git update-index --no-untracked-cache &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-no-uc ../actual &&
 	git update-index --untracked-cache &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-empty ../actual
 '
 
 test_expect_success 'setting core.untrackedCache to false and using git status removes the cache' '
 	git config core.untrackedCache false &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-empty ../actual &&
 	git status &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-no-uc ../actual
 '
 
 test_expect_success 'using --untracked-cache does not fail when core.untrackedCache is false' '
 	git update-index --untracked-cache &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-empty ../actual
 '
 
 test_expect_success 'setting core.untrackedCache to keep' '
 	git config core.untrackedCache keep &&
 	git update-index --untracked-cache &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-empty ../actual &&
 	git status &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-from-test-dump ../actual &&
 	git update-index --no-untracked-cache &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-no-uc ../actual &&
 	git update-index --force-untracked-cache &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-empty ../actual &&
 	git status &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-from-test-dump ../actual
 '
 
@@ -671,23 +671,23 @@ test_expect_success 'test ident field is working' '
 
 test_expect_success 'untracked cache survives a checkout' '
 	git commit --allow-empty -m empty &&
-	test-dump-untracked-cache >../before &&
+	test-tool dump-untracked-cache >../before &&
 	test_when_finished  "git checkout master" &&
 	git checkout -b other_branch &&
-	test-dump-untracked-cache >../after &&
+	test-tool dump-untracked-cache >../after &&
 	test_cmp ../before ../after &&
 	test_commit test &&
-	test-dump-untracked-cache >../before &&
+	test-tool dump-untracked-cache >../before &&
 	git checkout master &&
-	test-dump-untracked-cache >../after &&
+	test-tool dump-untracked-cache >../after &&
 	test_cmp ../before ../after
 '
 
 test_expect_success 'untracked cache survives a commit' '
-	test-dump-untracked-cache >../before &&
+	test-tool dump-untracked-cache >../before &&
 	git add done/two &&
 	git commit -m commit &&
-	test-dump-untracked-cache >../after &&
+	test-tool dump-untracked-cache >../after &&
 	test_cmp ../before ../after
 '
 
@@ -751,7 +751,7 @@ test_expect_success '"status" after file replacement should be clean with UC=tru
 	git checkout master &&
 	avoid_racy &&
 	status_is_clean &&
-	test-dump-untracked-cache >../actual &&
+	test-tool dump-untracked-cache >../actual &&
 	grep -F "recurse valid" ../actual >../actual.grep &&
 	cat >../expect.grep <<EOF &&
 / 0000000000000000000000000000000000000000 recurse valid
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 756beb0d8e..603d27789b 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -333,7 +333,7 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 		git update-index --fsmonitor &&
 		GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace-before" \
 		git status &&
-		test-dump-untracked-cache >../before
+		test-tool dump-untracked-cache >../before
 	) &&
 	cat >>dot-git/.git/hooks/fsmonitor-test <<-\EOF &&
 	printf ".git\0"
@@ -345,7 +345,7 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 		cd dot-git &&
 		GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace-after" \
 		git status &&
-		test-dump-untracked-cache >../after
+		test-tool dump-untracked-cache >../after
 	) &&
 	grep "directory invalidation" trace-before >>before &&
 	grep "directory invalidation" trace-after >>after &&
-- 
2.19.0.rc0.337.ge906d732e7

