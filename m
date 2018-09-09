Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39BE11F404
	for <e@80x24.org>; Sun,  9 Sep 2018 17:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeIIW1G (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 18:27:06 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:32796 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeIIW1F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 18:27:05 -0400
Received: by mail-lf1-f49.google.com with SMTP id m26-v6so15665301lfb.0
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQB0taE16QpLEoO5Yr6fIeRXzSzGnikChpyQhF4iqxA=;
        b=I9jVVzmXJYWZbSHgSaYcSOjrrm0CXr4OXGlL0Ss3JuDBseQS6w84p2OjWAn5F04JzG
         z6naijP4PBDgSWEmIndsRTZNRNU+XcvByE2MNWn6Q/Xqd1nF2qDLTpWbO1+fz933KSN1
         +uuGNlSS0OSVApXHe/09TAhG8KNdHDqWIxLD6A755X9u0zfeELSBH7FZPsJUrx0c2D/A
         Llwzg9aKB0HTCU0YdnuDa2tGqhksZjFRq/UpQ4t+YUo2fcsklfHaWxGbDd2qoz3iQLQW
         lEwpnZ1DPSxD65ynWT7gpvewAlmNEQdDspoWOgXfcDkHfohTNDStGNsTe6LRcbTClBik
         i5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQB0taE16QpLEoO5Yr6fIeRXzSzGnikChpyQhF4iqxA=;
        b=TEChJqYuG5X0EUl7ixw5aa55OOkeaRCskqKaAR8znztLEOKvsTMzoFZMIpofZwsixe
         k6PcplwSaqoMQ6DtHW548Im1WuFtcUIKyjzuVtwnThzguwgP3HdDQdbwqOGr0lRmGlF7
         2TaZgoNISZLGwOWIyvv4ifWcnwozeG3gN1OL5GzjKH6tz9qFOz8kfipFNirRjPbGGR7C
         LIhYsYWaO9t8uqqM+AK5oeYWvaMJk/lt2twi+msz8S+KwFGWgayadIPwcw3zMkYCUh30
         qIo4GSWrS0MumUH6feTxAkadwQILwmdEK1ILU2hw6rLlqdVC9rtvgVCJ+NUjy9HaF119
         B3VA==
X-Gm-Message-State: APzg51BNom/uT7MANVVyVO7ByzG91IC1Id6OWvC6rkyxax5YT/rJYUbs
        7+zZf3Zdgnyy0Y0IxI3VGCmIcPrP
X-Google-Smtp-Source: ANB0VdbVqZ8H39XQ6eO1hBhlK8ThhYbiZ1/5GQJQhXtRHeUdJsyEyUXsUFvVpAjVA2Tv/hac3x+smQ==
X-Received: by 2002:a19:f802:: with SMTP id a2-v6mr9972898lff.33.1536514600440;
        Sun, 09 Sep 2018 10:36:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u19-v6sm2317793lje.51.2018.09.09.10.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 10:36:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/6] t/helper: merge test-pkt-line into test-tool
Date:   Sun,  9 Sep 2018 19:36:28 +0200
Message-Id: <20180909173631.1446-4-pclouds@gmail.com>
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
 Makefile                           |  2 +-
 t/helper/test-pkt-line.c           |  3 ++-
 t/helper/test-tool.c               |  1 +
 t/helper/test-tool.h               |  1 +
 t/t5701-git-serve.sh               | 36 +++++++++++++++---------------
 t/t5702-protocol-v2.sh             |  2 +-
 t/t5703-upload-pack-ref-in-want.sh | 14 ++++++------
 7 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/Makefile b/Makefile
index fa67d76780..d9a4029895 100644
--- a/Makefile
+++ b/Makefile
@@ -722,6 +722,7 @@ TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-path-utils.o
+TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-ref-store.o
@@ -745,7 +746,6 @@ TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
-TEST_PROGRAMS_NEED_X += test-pkt-line
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-tool
 
diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 30775f986f..282d536384 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "test-tool.h"
 #include "pkt-line.h"
 
 static void pack_line(const char *line)
@@ -79,7 +80,7 @@ static void unpack_sideband(void)
 	}
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd__pkt_line(int argc, const char **argv)
 {
 	if (argc < 2)
 		die("too few arguments");
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 820335704a..0ef53152c4 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -27,6 +27,7 @@ static struct test_cmd cmds[] = {
 	{ "mktemp", cmd__mktemp },
 	{ "online-cpus", cmd__online_cpus },
 	{ "path-utils", cmd__path_utils },
+	{ "pkt-line", cmd__pkt_line },
 	{ "prio-queue", cmd__prio_queue },
 	{ "read-cache", cmd__read_cache },
 	{ "ref-store", cmd__ref_store },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 118c700c7a..7a0ac22ef7 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -23,6 +23,7 @@ int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
+int cmd__pkt_line(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 75ec79e6cb..29a54fbfff 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -15,13 +15,13 @@ test_expect_success 'test capability advertisement' '
 	EOF
 
 	git serve --advertise-capabilities >out &&
-	test-pkt-line unpack <out >actual &&
+	test-tool pkt-line unpack <out >actual &&
 	test_cmp actual expect
 '
 
 test_expect_success 'stateless-rpc flag does not list capabilities' '
 	# Empty request
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	0000
 	EOF
 	git serve --stateless-rpc >out <in &&
@@ -33,7 +33,7 @@ test_expect_success 'stateless-rpc flag does not list capabilities' '
 '
 
 test_expect_success 'request invalid capability' '
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	foobar
 	0000
 	EOF
@@ -42,7 +42,7 @@ test_expect_success 'request invalid capability' '
 '
 
 test_expect_success 'request with no command' '
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	agent=git/test
 	0000
 	EOF
@@ -51,7 +51,7 @@ test_expect_success 'request with no command' '
 '
 
 test_expect_success 'request invalid command' '
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	command=foo
 	agent=git/test
 	0000
@@ -71,7 +71,7 @@ test_expect_success 'setup some refs and tags' '
 '
 
 test_expect_success 'basics of ls-refs' '
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
 	0000
 	EOF
@@ -88,12 +88,12 @@ test_expect_success 'basics of ls-refs' '
 	EOF
 
 	git serve --stateless-rpc <in >out &&
-	test-pkt-line unpack <out >actual &&
+	test-tool pkt-line unpack <out >actual &&
 	test_cmp actual expect
 '
 
 test_expect_success 'basic ref-prefixes' '
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
 	0001
 	ref-prefix refs/heads/master
@@ -108,12 +108,12 @@ test_expect_success 'basic ref-prefixes' '
 	EOF
 
 	git serve --stateless-rpc <in >out &&
-	test-pkt-line unpack <out >actual &&
+	test-tool pkt-line unpack <out >actual &&
 	test_cmp actual expect
 '
 
 test_expect_success 'refs/heads prefix' '
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
 	0001
 	ref-prefix refs/heads/
@@ -128,12 +128,12 @@ test_expect_success 'refs/heads prefix' '
 	EOF
 
 	git serve --stateless-rpc <in >out &&
-	test-pkt-line unpack <out >actual &&
+	test-tool pkt-line unpack <out >actual &&
 	test_cmp actual expect
 '
 
 test_expect_success 'peel parameter' '
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
 	0001
 	peel
@@ -149,12 +149,12 @@ test_expect_success 'peel parameter' '
 	EOF
 
 	git serve --stateless-rpc <in >out &&
-	test-pkt-line unpack <out >actual &&
+	test-tool pkt-line unpack <out >actual &&
 	test_cmp actual expect
 '
 
 test_expect_success 'symrefs parameter' '
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
 	0001
 	symrefs
@@ -170,12 +170,12 @@ test_expect_success 'symrefs parameter' '
 	EOF
 
 	git serve --stateless-rpc <in >out &&
-	test-pkt-line unpack <out >actual &&
+	test-tool pkt-line unpack <out >actual &&
 	test_cmp actual expect
 '
 
 test_expect_success 'sending server-options' '
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	command=ls-refs
 	server-option=hello
 	server-option=world
@@ -190,14 +190,14 @@ test_expect_success 'sending server-options' '
 	EOF
 
 	git serve --stateless-rpc <in >out &&
-	test-pkt-line unpack <out >actual &&
+	test-tool pkt-line unpack <out >actual &&
 	test_cmp actual expect
 '
 
 test_expect_success 'unexpected lines are not allowed in fetch request' '
 	git init server &&
 
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
 	0001
 	this-is-not-a-command
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 3beeed4546..88a886975d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -334,7 +334,7 @@ test_expect_success 'even with handcrafted request, filter does not work if not
 	git -C server config uploadpack.allowfilter 0 &&
 
 	# Custom request that tries to filter even though it is not advertised.
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
 	0001
 	want $(git -C server rev-parse master)
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index d1ccc22331..3f58f05cbb 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -9,14 +9,14 @@ get_actual_refs () {
 		/wanted-refs/d
 		/0001/d
 		p
-		}' <out | test-pkt-line unpack >actual_refs
+		}' <out | test-tool pkt-line unpack >actual_refs
 }
 
 get_actual_commits () {
 	sed -n -e '/packfile/,/0000/{
 		/packfile/d
 		p
-		}' <out | test-pkt-line unpack-sideband >o.pack &&
+		}' <out | test-tool pkt-line unpack-sideband >o.pack &&
 	git index-pack o.pack &&
 	git verify-pack -v o.idx | grep commit | cut -c-40 | sort >actual_commits
 }
@@ -61,7 +61,7 @@ test_expect_success 'config controls ref-in-want advertisement' '
 '
 
 test_expect_success 'invalid want-ref line' '
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
 	0001
 	no-progress
@@ -80,7 +80,7 @@ test_expect_success 'basic want-ref' '
 	EOF
 	git rev-parse f | sort >expected_commits &&
 
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
 	0001
 	no-progress
@@ -101,7 +101,7 @@ test_expect_success 'multiple want-ref lines' '
 	EOF
 	git rev-parse c d | sort >expected_commits &&
 
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
 	0001
 	no-progress
@@ -122,7 +122,7 @@ test_expect_success 'mix want and want-ref' '
 	EOF
 	git rev-parse e f | sort >expected_commits &&
 
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
 	0001
 	no-progress
@@ -143,7 +143,7 @@ test_expect_success 'want-ref with ref we already have commit for' '
 	EOF
 	>expected_commits &&
 
-	test-pkt-line pack >in <<-EOF &&
+	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
 	0001
 	no-progress
-- 
2.19.0.rc0.337.ge906d732e7

