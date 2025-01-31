Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD51F3D3A
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738361678; cv=none; b=vEqp3b2D9zXABevECO+6eC7wwJOCju+NTrs+5oODIRoMWZe8j8RKVoDHw3dQyAwnqZDoLEIZW/4vCdpMnkC0Iaqwt9BDlLpgM0aAGRo4CRsUBLzgd1ujfexXn0dcOXLXgV2V7NVhGQ9hzDyAbCtpAvN53pjaXCkUuaEJeeiZ/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738361678; c=relaxed/simple;
	bh=wkSPu4vTPXtGwdAXBJEGWO3kHvkewj74t+0njsY76sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1/spJO3NVaJih8JwZrZPC+XX1voLOGgGTW4tO4/J2peU8eS6W1LJSranecOyDDy3d6VyaOB0VGBlA8lFkYu6sh1A/JdpKWrdyHJueRiWgmbo+4EcmvRdKWY8osJ/SZLP1z8GFntQYbPzMIXXOtEsHzs04gwJakauNV+DktoiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKE2LYyB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKE2LYyB"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so412486466b.2
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 14:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738361674; x=1738966474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nIcFQZE2ytujNnM8WfUXPpvOqEdMTID09V2LTb13DE=;
        b=IKE2LYyBr7db65OWHl5x57xEdZX/WKgkKn+s5pRwsPFF0f+Mf+xj8rWgmlpaifolVa
         bwPdpvs5F4wMAVfk2KMXojj102qg3klBAva4hgc4QMhUnF7Hr4PBYzWRV1Ez+wGYreqa
         g4+IlJqGV+KB0fQXn52UkcFTJFWgJwUJRVS4EPFmUJ0sLVSj2fveDMbHIJkLfmR0pNRe
         CYlKkSVa7XCSIZoF4riM3YDhcWUfoyWUfI6nwOdFC4sXSWeyzIOfuuBBeAZOTILBEV+L
         h9nnQykQJpQDJlg32y/Ok/stuVm4DrRpxPt3QmrnL2WmlOz75ONc2M9Vmaug+SgF3e42
         2wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738361674; x=1738966474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nIcFQZE2ytujNnM8WfUXPpvOqEdMTID09V2LTb13DE=;
        b=bBujbbPBOkJtc+a9kn1B/b0LtOq85ZVB+n9EuTeEDLxs9qBTCX6ImV1gCSfB9ckvKm
         tHWY2fm3G9pl3lN0+gziZqOcNx+xVwmJr3z5I8On7mmL+eyx64nAsNbq/bRhqroKQsHx
         nQqFAHzf5Vl9tRNX53MAdxPqv2e943VqPtD8TbODAE4eTRAUqlXPwKFHuYfqPLlQcMmU
         3v1Hf6TKQtRy+zJgLDztVNRH1AxqWLD8I2XxD5doyELo7zHb16BBl2AReNprz9hgtigJ
         JVl9b9vPjRgyKS8TDiZFoWHIISCJR64VdhtPFZ4pBMuv4gdRbsMV7TjdHhtVXmIy4eo6
         AxPw==
X-Gm-Message-State: AOJu0Yxm+k1KB2Nnqc1nlVnYnljlU0c1BH32TcDFVanDjULFx1TRmbDn
	G13SXkzLHD1tQ42us0ArmABnTWIJfNGc3YAb9UhmkvJCqW5YTM+5JDvq9rQlFsjOJQ==
X-Gm-Gg: ASbGncvV9JR8d14Fzxr7n6MFHEhdAQOwikp5MZhBgB5V8/6bbqyeVSEiAfrBCx7L/QS
	OM/sb/APA6TsHAwMrruIxt/9fSW2Y/cDzcnW8dRUiEJWZ7n5yYUYEEx9T/AeeyGtFS2ItBzG77J
	ydhl7OB9/bXmc76cI5ur/DZQ/Q663Zlm2JhZ3bd0drzPiZD0zD7q1acKd17uSVCrPye3VJ9c67p
	bsvm9bW8Xptfnij8xrWhIEsCFGa4NllM30DHTZ63Vdztuyp9kevT/g8/THmDHM0benH7sao/DT1
	4eHAACqc57iKjfnn7EoQPWy3eLARmR4=
X-Google-Smtp-Source: AGHT+IFTK1Fnn+W8jGLnQ/KsnS48WCSWjkM2YK32iu03x2qDnSZtO0gFL4tZpYqrZBNYQZf1uxlgeQ==
X-Received: by 2002:a17:906:a3d3:b0:ab6:d9f7:fd71 with SMTP id a640c23a62f3a-ab6d9f83783mr1136600266b.51.1738361673740;
        Fri, 31 Jan 2025 14:14:33 -0800 (PST)
Received: from localhost.localdomain ([154.120.111.177])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab6e49ff77fsm359288966b.108.2025.01.31.14.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 14:14:33 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 2/4] t/unit-tests: adapt example decorate test to use clar test framework
Date: Fri, 31 Jan 2025 23:14:18 +0100
Message-ID: <20250131221420.38161-3-kuforiji98@gmail.com>
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

Introduce `test_example_decorate__initialize()` to explicitly set up
object IDs and retrieve corresponding objects before tests run. This
ensures a consistent and predictable test state without relying on data
from previous tests.

Add `test_example_decorate__cleanup()` to clear decorations after each
test, preventing interference between tests and ensuring each runs in
isolation.

Adapt example decorate test script to clar framework by using clar
assertions where necessary. Previously, tests relied on data written by
earlier tests, leading to unintended dependencies between them. This
explicitly initializes the necessary state within
`test_example_decorate__readd`, ensuring it does not depend on prior
test executions.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                      |  2 +-
 t/meson.build                                 |  2 +-
 ...xample-decorate.c => u-example-decorate.c} | 76 ++++++++-----------
 3 files changed, 35 insertions(+), 45 deletions(-)
 rename t/unit-tests/{t-example-decorate.c => u-example-decorate.c} (30%)

diff --git a/Makefile b/Makefile
index 2d9dad119a..732d765f1c 100644
--- a/Makefile
+++ b/Makefile
@@ -1338,6 +1338,7 @@ THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
 CLAR_TEST_SUITES += u-ctype
+CLAR_TEST_SUITES += u-example-decorate
 CLAR_TEST_SUITES += u-hash
 CLAR_TEST_SUITES += u-hashmap
 CLAR_TEST_SUITES += u-mem-pool
@@ -1349,7 +1350,6 @@ CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
-UNIT_TEST_PROGRAMS += t-example-decorate
 UNIT_TEST_PROGRAMS += t-oid-array
 UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
diff --git a/t/meson.build b/t/meson.build
index af597f9804..c7e08eca6f 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1,5 +1,6 @@
 clar_test_suites = [
   'unit-tests/u-ctype.c',
+  'unit-tests/u-example-decorate.c',
   'unit-tests/u-hash.c',
   'unit-tests/u-hashmap.c',
   'unit-tests/u-mem-pool.c',
@@ -45,7 +46,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-example-decorate.c',
   'unit-tests/t-oid-array.c',
   'unit-tests/t-oidmap.c',
   'unit-tests/t-oidtree.c',
diff --git a/t/unit-tests/t-example-decorate.c b/t/unit-tests/u-example-decorate.c
similarity index 30%
rename from t/unit-tests/t-example-decorate.c
rename to t/unit-tests/u-example-decorate.c
index bfc776e223..9b1d1ce753 100644
--- a/t/unit-tests/t-example-decorate.c
+++ b/t/unit-tests/u-example-decorate.c
@@ -1,6 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
-#include "test-lib.h"
+#include "unit-test.h"
 #include "object.h"
 #include "decorate.h"
 #include "repository.h"
@@ -11,64 +11,54 @@ struct test_vars {
 	int decoration_a, decoration_b;
 };
 
-static void t_add(struct test_vars *vars)
+static struct test_vars vars;
+
+void test_example_decorate__initialize(void)
 {
-	void *ret = add_decoration(&vars->n, vars->one, &vars->decoration_a);
+	struct object_id one_oid = { { 1 } }, two_oid = { { 2 } }, three_oid = { { 3 } };
 
-	check(ret == NULL);
-	ret = add_decoration(&vars->n, vars->two, NULL);
-	check(ret == NULL);
+	vars.one = lookup_unknown_object(the_repository, &one_oid);
+	vars.two = lookup_unknown_object(the_repository, &two_oid);
+	vars.three = lookup_unknown_object(the_repository, &three_oid);
 }
 
-static void t_readd(struct test_vars *vars)
+void test_example_decorate__cleanup(void)
 {
-	void *ret = add_decoration(&vars->n, vars->one, NULL);
-
-	check(ret == &vars->decoration_a);
-	ret = add_decoration(&vars->n, vars->two, &vars->decoration_b);
-	check(ret == NULL);
+	clear_decoration(&vars.n, NULL);
 }
 
-static void t_lookup(struct test_vars *vars)
+void test_example_decorate__add(void)
 {
-	void *ret = lookup_decoration(&vars->n, vars->one);
-
-	check(ret == NULL);
-	ret = lookup_decoration(&vars->n, vars->two);
-	check(ret == &vars->decoration_b);
-	ret = lookup_decoration(&vars->n, vars->three);
-	check(ret == NULL);
+	cl_assert_equal_p(add_decoration(&vars.n, vars.one, &vars.decoration_a), NULL);
+	cl_assert_equal_p(add_decoration(&vars.n, vars.two, NULL), NULL);
 }
 
-static void t_loop(struct test_vars *vars)
+void test_example_decorate__readd(void)
 {
-	int objects_noticed = 0;
-
-	for (size_t i = 0; i < vars->n.size; i++) {
-		if (vars->n.entries[i].base)
-			objects_noticed++;
-	}
-	check_int(objects_noticed, ==, 2);
+	cl_assert_equal_p(add_decoration(&vars.n, vars.one, &vars.decoration_a), NULL);
+	cl_assert_equal_p(add_decoration(&vars.n, vars.two, NULL), NULL);
+	cl_assert_equal_p(add_decoration(&vars.n, vars.one, NULL), &vars.decoration_a);
+	cl_assert_equal_p(add_decoration(&vars.n, vars.two, &vars.decoration_b), NULL);
 }
 
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
+void test_example_decorate__lookup(void)
 {
-	struct object_id one_oid = { { 1 } }, two_oid = { { 2 } }, three_oid = { { 3 } };
-	struct test_vars vars = { 0 };
+	cl_assert_equal_p(add_decoration(&vars.n, vars.two, &vars.decoration_b), NULL);
+	cl_assert_equal_p(add_decoration(&vars.n, vars.one, NULL), NULL);
+	cl_assert_equal_p(lookup_decoration(&vars.n, vars.two), &vars.decoration_b);
+	cl_assert_equal_p(lookup_decoration(&vars.n, vars.one), NULL);
+}
 
-	vars.one = lookup_unknown_object(the_repository, &one_oid);
-	vars.two = lookup_unknown_object(the_repository, &two_oid);
-	vars.three = lookup_unknown_object(the_repository, &three_oid);
+void test_example_decorate__loop(void)
+{
+	int objects_noticed = 0;
 
-	TEST(t_add(&vars),
-	     "Add 2 objects, one with a non-NULL decoration and one with a NULL decoration.");
-	TEST(t_readd(&vars),
-	     "When re-adding an already existing object, the old decoration is returned.");
-	TEST(t_lookup(&vars),
-	     "Lookup returns the added declarations, or NULL if the object was never added.");
-	TEST(t_loop(&vars), "The user can also loop through all entries.");
+	cl_assert_equal_p(add_decoration(&vars.n, vars.one, &vars.decoration_a), NULL);
+	cl_assert_equal_p(add_decoration(&vars.n, vars.two, &vars.decoration_b), NULL);
 
-	clear_decoration(&vars.n, NULL);
+	for (size_t i = 0; i < vars.n.size; i++)
+		if (vars.n.entries[i].base)
+			objects_noticed++;
 
-	return test_done();
+	cl_assert_equal_i(objects_noticed, 2);
 }
-- 
2.47.0.86.g15030f9556

