Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401444E532F
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558576; cv=none; b=KWES00/4vB09dBqPIwpuGwonKoJVcy5RJlIAWQMIErURRqghup87QfR+duM5gABxN0ajpSs96loXtjiP+0FJRhQKiWIS8XWmAUnZzNReQoBHMmijk7Com8BhQs47D8RmXl5bbjHoL6sQxnIB4zwlN0k7NYjl84+z/FVJQRYdCB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558576; c=relaxed/simple;
	bh=0JJLVpGxbJQBnY+SwwzHxxF2Unih382yPWR5N/bh0Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q10F8wsuV/Y0Z8Q+lS7MFYNgoNR6yZHDU0WIe9j8vWLTEp96WDO/XNQkvW0Jlg1hTKftNqGi5oiH+8qy7tSy8D59UQDP786IVirBqpI6xm4J2h0ABZNAlxInl4/bCIKwP/YvnAhn/I5gY+iW5AuZ+z6q4F8tc2qDyjf0Rsq68pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCNsRW1E; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCNsRW1E"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2171862a91.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791558574; x=1792163374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qJrJpJ7BFHj5+2g7FGW4UZWuZ6Crmssb0Gw6er7lVhY=;
        b=UCNsRW1EwDpdARTK15s348OW1xzUQO3vLPOoxFwdT4u1fV5eTDnWSgoK6S973Bg3UF
         diH2fRyHHU0u2NbciZJPyZMSVSMWPsuo1DDSYNubl4zbFwlt+UI+ktVMbKcUmEai7r34
         B1KbNQw5+ecHmC2HdjgRK6hg0VLmq29mwZngJQBj+XEQLKJQ8gZN7/VP+0RJIhJ8/2HE
         ixNEPoyJ7Cj2+W6PRbUkHN+W5mEalbGKXIz+2eoJAbSGBvsBu5hsGJrUIU345NoB3A4c
         REzAA/+usGZOef9wte7J3uRr4aIgaLZxTKJvBceTxTjeAckbauis0g5AAuWnHXSoQmp/
         sxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791558574; x=1792163374;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qJrJpJ7BFHj5+2g7FGW4UZWuZ6Crmssb0Gw6er7lVhY=;
        b=QQGeEpzjaxAaMuzezeg1WyILIOJG9yoNrLFm6eYLsbX6FQfjBizohGj/xIwvJyk4wh
         /hmoHYnq7j9HTAWNV3CrP8tDRsCHgR6qbuZzzlzc3HbR9F1YujeEWQaaQTkosViqREuu
         iT6JZbMt6E9QEYzYV8Ie5ocy/6CjYUT2Z7k5U0X89mL77w22RHY/zCRA0EGpX+/+zhwA
         SonciioW70/TxT2RT1khcrRdGUmTrkoUMmyY9kR2Oz/lps68BINdSOF7yGPu0kP4fldY
         8jzyDV4PDSYHC0oi+mKoBCUYb5DdRDpP/yYhy1IRBTTYirM31XVvv8prg+huqAQT5h8Y
         NQqw==
X-Gm-Message-State: AFq9FYIJ+Pvc6pp4WJxRFlCZyjukI/kcYLoV19yhSXA2OVh2q75r4awP
	qOJFlExgnsWaUlUUdDY6I9vxaNvZZLBa6w3xd/neZ3PXS6swml1+E9FH1Yij31oo974=
X-Gm-Gg: AYBFou39knCOmZXezp0R91ockApaTYafUqL+KkHAjoUtYPDciGN4vFLE/n7XxmGKm+L
	7jg29+jUqd9x5lbAqEQFYbC+GW9QTuWILR6KslO49zdMf0hmicA46XrrFyH2ibc3L/Yxc3h2own
	dkat2pj8vjDgbkvOV+JGuj2PcD55371uWAlr4Adk0MfcJccS1mVwDmQ1JJoqozLY/XtBxhhSDu7
	A0gIsMWOXWN1LSYt2+ejHeFMlmyItOVt37/vEmoWdmh9CNUpwX5m3v5RceWdz/Nz72LtzpFwwVB
	qer6pa19PzSn7SIZ1D6PnEhrQ1V+q134IpQ931sPDaRfddm2gC1Y3YTEEw0GSsXItz0F3RUv1X5
	LltpwvTGvCViBGYbUev+PJhDStnqrttcBHKGgw2kV/N7FbpxwCQIYSg3uo/4+DKw1WWp1stl4VA
	uZGEsjiq093uujrGMXySV9GX4hUVNo2oSHCM+CViM5i4pBaZlOb+STAd6jdJd7LYJtC1xSJ/UY+
	jjm5g==
X-Received: by 2002:a17:90b:1850:b0:3a6:d94d:e147 with SMTP id 98e67ed59e1d1-3ab3a94fffemr1759960a91.15.1791558569752;
        Fri, 09 Oct 2026 08:09:29 -0700 (PDT)
Received: from archlinux ([2409:40f4:3151:37e2:36ef:bf3c:7f30:217e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da03f449sm1113553a12.28.2026.10.09.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:09:29 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH v3 4/4] t: retire the sorting benchmark and mergesort helper
Date: Fri,  9 Oct 2026 20:38:50 +0530
Message-ID: <d4814912d234fa1347a823b1a411159b50ae3449.1791556668.git.dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791556668.git.dilsheddilu123@gmail.com>
References: <cover.1791365181.git.dilsheddilu123@gmail.com> <cover.1791556668.git.dilsheddilu123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

p0071 was added to compare sorting implementations during mergesort
development. Retire that benchmark. A benchmark can be added again if
future sorting changes need measurements.

With the numeric tests now in Clar, p0071 is the last user of test-tool
mergesort. Remove the helper and its command and build registrations.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Muhammed Dilshad A <dilsheddilu123@gmail.com>
---
 Makefile                  |  1 -
 t/helper/meson.build      |  1 -
 t/helper/test-mergesort.c | 65 ---------------------------------------
 t/helper/test-tool.c      |  1 -
 t/helper/test-tool.h      |  1 -
 t/meson.build             |  1 -
 t/perf/p0071-sort.sh      | 52 -------------------------------
 7 files changed, 122 deletions(-)
 delete mode 100644 t/helper/test-mergesort.c
 delete mode 100755 t/perf/p0071-sort.sh

diff --git a/Makefile b/Makefile
index cac535ba19..4b35808b2e 100644
--- a/Makefile
+++ b/Makefile
@@ -835,7 +835,6 @@ TEST_BUILTINS_OBJS += test-hexdump.o
 TEST_BUILTINS_OBJS += test-json-writer.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
-TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-name-hash.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 3235f10ab8..e94e6f10fb 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -32,7 +32,6 @@ test_tool_sources = [
   'test-json-writer.c',
   'test-lazy-init-name-hash.c',
   'test-match-trees.c',
-  'test-mergesort.c',
   'test-mktemp.c',
   'test-name-hash.c',
   'test-online-cpus.c',
diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
deleted file mode 100644
index d22a139f9e..0000000000
--- a/t/helper/test-mergesort.c
+++ /dev/null
@@ -1,65 +0,0 @@
-#include "test-tool.h"
-#include "mem-pool.h"
-#include "mergesort.h"
-#include "strbuf.h"
-
-struct line {
-	char *text;
-	struct line *next;
-};
-
-DEFINE_LIST_SORT(static, sort_lines, struct line, next);
-
-static int compare_strings(const struct line *x, const struct line *y)
-{
-	return strcmp(x->text, y->text);
-}
-
-static int sort_stdin(void)
-{
-	struct line *lines;
-	struct line **tail = &lines;
-	struct strbuf sb = STRBUF_INIT;
-	struct mem_pool lines_pool;
-	char *p;
-
-	strbuf_read(&sb, 0, 0);
-
-	/*
-	 * Split by newline, but don't create an item
-	 * for the empty string after the last separator.
-	 */
-	if (sb.len && sb.buf[sb.len - 1] == '\n')
-		strbuf_setlen(&sb, sb.len - 1);
-
-	mem_pool_init(&lines_pool, 0);
-	p = sb.buf;
-	for (;;) {
-		char *eol = strchr(p, '\n');
-		struct line *line = mem_pool_alloc(&lines_pool, sizeof(*line));
-		line->text = p;
-		*tail = line;
-		tail = &line->next;
-		if (!eol)
-			break;
-		*eol = '\0';
-		p = eol + 1;
-	}
-	*tail = NULL;
-
-	sort_lines(&lines, compare_strings);
-
-	while (lines) {
-		puts(lines->text);
-		lines = lines->next;
-	}
-	return 0;
-}
-
-int cmd__mergesort(int argc, const char **argv)
-{
-	if (argc == 2 && !strcmp(argv[1], "sort"))
-		return sort_stdin();
-	fprintf(stderr, "usage: test-tool mergesort sort\n");
-	return 129;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b71a22b43b..2e80dc7ab8 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -42,7 +42,6 @@ static struct test_cmd cmds[] = {
 	{ "json-writer", cmd__json_writer },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "match-trees", cmd__match_trees },
-	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
 	{ "name-hash", cmd__name_hash },
 	{ "online-cpus", cmd__online_cpus },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f2885b33d5..9442c61ffd 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -35,7 +35,6 @@ int cmd__hexdump(int argc, const char **argv);
 int cmd__json_writer(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__match_trees(int argc, const char **argv);
-int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
 int cmd__name_hash(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
diff --git a/t/meson.build b/t/meson.build
index 2752321e0d..07436b63f4 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1146,7 +1146,6 @@ benchmarks = [
   'perf/p0006-read-tree-checkout.sh',
   'perf/p0007-write-cache.sh',
   'perf/p0008-odb-fsync.sh',
-  'perf/p0071-sort.sh',
   'perf/p0090-cache-tree.sh',
   'perf/p0100-globbing.sh',
   'perf/p1006-cat-file.sh',
diff --git a/t/perf/p0071-sort.sh b/t/perf/p0071-sort.sh
deleted file mode 100755
index ae4ddac864..0000000000
--- a/t/perf/p0071-sort.sh
+++ /dev/null
@@ -1,52 +0,0 @@
-#!/bin/sh
-
-test_description='Basic sort performance tests'
-. ./perf-lib.sh
-
-test_perf_default_repo
-
-test_expect_success 'setup' '
-	git ls-files --stage "*.[ch]" "*.sh" |
-	cut -f2 -d" " |
-	git cat-file --batch >unsorted
-'
-
-test_perf 'sort(1) unsorted' '
-	sort <unsorted >sorted
-'
-
-test_expect_success 'reverse' '
-	sort -r <unsorted >reversed
-'
-
-for file in sorted reversed
-do
-	test_perf "sort(1) $file" "
-		sort <$file >actual
-	"
-done
-
-for file in unsorted sorted reversed
-do
-
-	test_perf "string_list_sort() $file" "
-		test-tool string-list sort <$file >actual
-	"
-
-	test_expect_success "string_list_sort() $file sorts like sort(1)" "
-		test_cmp_bin sorted actual
-	"
-done
-
-for file in unsorted sorted reversed
-do
-	test_perf "DEFINE_LIST_SORT $file" "
-		test-tool mergesort sort <$file >actual
-	"
-
-	test_expect_success "DEFINE_LIST_SORT $file sorts like sort(1)" "
-		test_cmp_bin sorted actual
-	"
-done
-
-test_done
-- 
2.55.0

