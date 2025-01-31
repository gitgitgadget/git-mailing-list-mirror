Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4001F4298
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738361681; cv=none; b=ZtffBXnzPsfQZF2jdcc4OlZqT798rkOLjmwmJ9KGDH5Q0YWQkfK704zBhQ+noY+Ryt8PxY+LRMuzFH5IqFILyWSpDaGYsiiFAKyhSYvdiGTD5FrZaVfF1zA86j0Iy6g8h5RdGhGEoSvCReXWElI0Z4Hu4ChxyKPvH5J9QWM2hRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738361681; c=relaxed/simple;
	bh=okHr2gtasWkVrcn92IMvdzKaNlhk8G7QcTsQpnRvXqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKf+MpfHfg1n4qS4xK1PZV6b81L3mtFehQPY1bwhIXcP6Zy0utmcRy+VN88tEa8ROPv/nnsQcjIs2zPrGikgU+tCWufKz/Y2kJ3Uan57it50QOpxorBkiR/xayhusnyP8lZHxer6ugqlW9E8wZRgrxQzlI+onjwVUr8mrmnVJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+YjZOMK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+YjZOMK"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaeef97ff02so427078766b.1
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 14:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738361677; x=1738966477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UZBfc4J4wKHnHbI83gsUAxBGAfnhfMWWFs7BlRqEXs=;
        b=C+YjZOMKQ6U75WvkUeOTwsAxMfvMt8BaVmtuvMSecEgl+rf6rp3VplsQxmV1pkCVXR
         uvu6oILCAttZoTov/Tqq+SXfkqpKsXGSDvL/QqxVBYPoKodK3xxGNjHdkVcrR5QQDKW7
         Y4lf/wyuv5YmgefTzC743IavsskX8oJh9gyzitN/T69CMW95HhrddkWWIkoFbfgBGQZe
         NYUlDys4D0eOF95UZ+BICdkya4qeFGxpV1lbeIvI0G3eObkLIOj4CLWNh5edC5Cl207p
         iDbRnMZAOX0GzIGvShBElSDCMurkQpZzjZng0W2VU5QltDoaZi0lmsF1vZVAo/CMhQPj
         oItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738361677; x=1738966477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UZBfc4J4wKHnHbI83gsUAxBGAfnhfMWWFs7BlRqEXs=;
        b=S6jdeE5qpXikBaEsiyQ0pnO6kTBSg08JDgJQVcQtk6LeYsUtDNqGxmETRZz2sjpgat
         3Z6VlcXPW0+R3CVgHIVbKFbjhq5vkuPWkvlJ3y5l8wys3W8fPgTKk8RJXIn5l1Vie4Uk
         FengpKymWphP/ZwJQI+ssWs5/hjZ5UxL2Rr/GoEkGNmzXv+erd76KD1dm+5rDaJFtXsY
         G97XsaEFmdTLDMYfA3mKaGNGCiTKjF8oUUwE6sbCL4h+SmmAZlU4pWVCAXlCJHF4DQ9w
         xT3D3X5rpJmEQevkLdtlLnuCjGRFj5uivtlhOPx1j0m0dzg5Yp/bMdkZreJFCiIpS8AT
         wY4A==
X-Gm-Message-State: AOJu0YxwIeBpxhM29momFEr+rLLWFsOBHRV+OMv6zH9xThLL7CMfsCH2
	ySVOkOZJX+Ei7EiEKGuqnPeE5V+naQ+Wonv/gYEoiYaDsEcow+pjId0nUYS4cRuIwg==
X-Gm-Gg: ASbGnctLAaANEJXELmxPqlfuO0FxnxJBnA8iEy8T18EuAbgVw6sYthvMqAk9uLt2D1d
	6LWInUTvKXoGN620cj3/oT/HJ6nj1Joy3o79q7HwKT/Cb4/0FBRXaAVVDghse17dbfBYu//xQs3
	dZwJDD6d6ZqN8p8MVEf4gu/0Pj5PEhHscMF4NqBuWjqc5SUXaQpDqqcYQKKn2Fhrlmf7ORSM8KK
	46kgcpP3sx/1apl8zHOBQTQeN/VjcWDHWeumWNWWRA4fnGaa99WSP4HD493ltfoDi7bE6nHMatM
	lJLa82/oA9787hIbmR74D+HQtjE9T8E=
X-Google-Smtp-Source: AGHT+IETTrrpbsG3nGxOiSJxgbadim1sGQwPeK2xaYH98gAkGU3csv71t15DcUPoHuOzaQC948ZAKw==
X-Received: by 2002:a17:907:7da5:b0:ab2:db7b:5db3 with SMTP id a640c23a62f3a-ab6cfe12dbamr1357515766b.54.1738361676968;
        Fri, 31 Jan 2025 14:14:36 -0800 (PST)
Received: from localhost.localdomain ([154.120.111.177])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab6e49ff77fsm359288966b.108.2025.01.31.14.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 14:14:36 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 3/4] t/unit-tests: convert strbuf test to use clar test framework
Date: Fri, 31 Jan 2025 23:14:19 +0100
Message-ID: <20250131221420.38161-4-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250131221420.38161-1-kuforiji98@gmail.com>
References: <20250130091334.39922-1-kuforiji98@gmail.com>
 <20250131221420.38161-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt strbuf test script to clar framework by using clar assertions
where necessary.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                |   2 +-
 t/meson.build                           |   2 +-
 t/unit-tests/{t-strbuf.c => u-strbuf.c} | 115 ++++++++++++------------
 3 files changed, 58 insertions(+), 61 deletions(-)
 rename t/unit-tests/{t-strbuf.c => u-strbuf.c} (35%)

diff --git a/Makefile b/Makefile
index 732d765f1c..358193597f 100644
--- a/Makefile
+++ b/Makefile
@@ -1344,6 +1344,7 @@ CLAR_TEST_SUITES += u-hashmap
 CLAR_TEST_SUITES += u-mem-pool
 CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-tree
+CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
@@ -1361,7 +1362,6 @@ UNIT_TEST_PROGRAMS += t-reftable-reader
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
-UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGRAMS += t-urlmatch-normalization
diff --git a/t/meson.build b/t/meson.build
index c7e08eca6f..6cb72842b1 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -6,6 +6,7 @@ clar_test_suites = [
   'unit-tests/u-mem-pool.c',
   'unit-tests/u-prio-queue.c',
   'unit-tests/u-reftable-tree.c',
+  'unit-tests/u-strbuf.c',
   'unit-tests/u-strvec.c',
 ]
 
@@ -57,7 +58,6 @@ unit_test_programs = [
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
-  'unit-tests/t-strbuf.c',
   'unit-tests/t-strcmp-offset.c',
   'unit-tests/t-trailer.c',
   'unit-tests/t-urlmatch-normalization.c',
diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/u-strbuf.c
similarity index 35%
rename from t/unit-tests/t-strbuf.c
rename to t/unit-tests/u-strbuf.c
index 3f4044d697..caa5d78aa3 100644
--- a/t/unit-tests/t-strbuf.c
+++ b/t/unit-tests/u-strbuf.c
@@ -1,4 +1,4 @@
-#include "test-lib.h"
+#include "unit-test.h"
 #include "strbuf.h"
 
 /* wrapper that supplies tests with an empty, initialized strbuf */
@@ -9,8 +9,8 @@ static void setup(void (*f)(struct strbuf*, const void*),
 
 	f(&buf, data);
 	strbuf_release(&buf);
-	check_uint(buf.len, ==, 0);
-	check_uint(buf.alloc, ==, 0);
+	cl_assert_equal_i(buf.len, 0);
+	cl_assert_equal_i(buf.alloc, 0);
 }
 
 /* wrapper that supplies tests with a populated, initialized strbuf */
@@ -20,49 +20,45 @@ static void setup_populated(void (*f)(struct strbuf*, const void*),
 	struct strbuf buf = STRBUF_INIT;
 
 	strbuf_addstr(&buf, init_str);
-	check_uint(buf.len, ==, strlen(init_str));
+	cl_assert_equal_i(buf.len, strlen(init_str));
 	f(&buf, data);
 	strbuf_release(&buf);
-	check_uint(buf.len, ==, 0);
-	check_uint(buf.alloc, ==, 0);
+	cl_assert_equal_i(buf.len, 0);
+	cl_assert_equal_i(buf.alloc, 0);
 }
 
-static int assert_sane_strbuf(struct strbuf *buf)
+static void assert_sane_strbuf(struct strbuf *buf)
 {
 	/* Initialized strbufs should always have a non-NULL buffer */
-	if (!check(!!buf->buf))
-		return 0;
+	cl_assert(buf->buf != NULL);
 	/* Buffers should always be NUL-terminated */
-	if (!check_char(buf->buf[buf->len], ==, '\0'))
-		return 0;
+	cl_assert(buf->buf[buf->len] == '\0');
 	/*
-	 * Freshly-initialized strbufs may not have a dynamically allocated
-	 * buffer
-	 */
-	if (buf->len == 0 && buf->alloc == 0)
-		return 1;
-	/* alloc must be at least one byte larger than len */
-	return check_uint(buf->len, <, buf->alloc);
+         * In case the buffer contains anything, `alloc` must alloc must
+         * be at least one byte larger than `len`.
+         */
+	if (buf->len)
+            cl_assert(buf->len < buf->alloc);
 }
 
-static void t_static_init(void)
+void test_strbuf__static_init(void)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	check_uint(buf.len, ==, 0);
-	check_uint(buf.alloc, ==, 0);
-	check_char(buf.buf[0], ==, '\0');
+	cl_assert_equal_i(buf.len, 0);
+	cl_assert_equal_i(buf.alloc, 0);
+	cl_assert(buf.buf[0] == '\0');
 }
 
-static void t_dynamic_init(void)
+void test_strbuf__dynamic_init(void)
 {
 	struct strbuf buf;
 
 	strbuf_init(&buf, 1024);
-	check(assert_sane_strbuf(&buf));
-	check_uint(buf.len, ==, 0);
-	check_uint(buf.alloc, >=, 1024);
-	check_char(buf.buf[0], ==, '\0');
+	assert_sane_strbuf(&buf);
+	cl_assert_equal_i(buf.len, 0);
+	cl_assert(buf.alloc >= 1024);
+	cl_assert(buf.buf[0] == '\0');
 	strbuf_release(&buf);
 }
 
@@ -73,16 +69,12 @@ static void t_addch(struct strbuf *buf, const void *data)
 	size_t orig_alloc = buf->alloc;
 	size_t orig_len = buf->len;
 
-	if (!check(assert_sane_strbuf(buf)))
-		return;
+	assert_sane_strbuf(buf);
 	strbuf_addch(buf, ch);
-	if (!check(assert_sane_strbuf(buf)))
-		return;
-	if (!(check_uint(buf->len, ==, orig_len + 1) &&
-	      check_uint(buf->alloc, >=, orig_alloc)))
-		return; /* avoid de-referencing buf->buf */
-	check_char(buf->buf[buf->len - 1], ==, ch);
-	check_char(buf->buf[buf->len], ==, '\0');
+	assert_sane_strbuf(buf);
+	cl_assert_equal_i(buf->len, orig_len + 1);
+	cl_assert(buf->alloc >= orig_alloc);
+	cl_assert(buf->buf[buf->len] == '\0');
 }
 
 static void t_addstr(struct strbuf *buf, const void *data)
@@ -92,31 +84,36 @@ static void t_addstr(struct strbuf *buf, const void *data)
 	size_t orig_alloc = buf->alloc;
 	size_t orig_len = buf->len;
 
-	if (!check(assert_sane_strbuf(buf)))
-		return;
+	assert_sane_strbuf(buf);
 	strbuf_addstr(buf, text);
-	if (!check(assert_sane_strbuf(buf)))
-		return;
-	if (!(check_uint(buf->len, ==, orig_len + len) &&
-	      check_uint(buf->alloc, >=, orig_alloc) &&
-	      check_uint(buf->alloc, >, orig_len + len) &&
-	      check_char(buf->buf[orig_len + len], ==, '\0')))
-	    return;
-	check_str(buf->buf + orig_len, text);
+	assert_sane_strbuf(buf);
+	cl_assert_equal_i(buf->len, orig_len + len);
+	cl_assert(buf->alloc >= orig_alloc);
+	cl_assert(buf->buf[buf->len] == '\0');
+	cl_assert_equal_s(buf->buf + orig_len, text);
 }
 
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
+void test_strbuf__add_single_char(void)
 {
-	if (!TEST(t_static_init(), "static initialization works"))
-		test_skip_all("STRBUF_INIT is broken");
-	TEST(t_dynamic_init(), "dynamic initialization works");
-	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
-	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
-	TEST(setup_populated(t_addch, "initial value", "a"),
-	     "strbuf_addch appends to initial value");
-	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
-	TEST(setup_populated(t_addstr, "initial value", "hello there"),
-	     "strbuf_addstr appends string to initial value");
-
-	return test_done();
+	setup(t_addch, "a");
+}
+
+void test_strbuf__add_empty_char(void)
+{
+	setup(t_addch, "");
+}
+
+void test_strbuf__add_append_char(void)
+{
+	setup_populated(t_addch, "initial value", "a");
+}
+
+void test_strbuf__add_single_str(void)
+{
+	setup(t_addstr, "hello there");
+}
+
+void test_strbuf__add_append_str(void)
+{
+	setup_populated(t_addstr, "initial value", "hello there");
 }
-- 
2.47.0.86.g15030f9556

