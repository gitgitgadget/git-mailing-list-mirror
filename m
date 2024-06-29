Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87851548E1
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675822; cv=none; b=ZrwveBDxZqiFPO1d/p0kW28nqJz5quR0hH/lG2kPODlhEaPZ7hfx3o6E2rZmkvIZSixuLQn096yzOCbjUvWjc2fn+y9og9shA89ePHa/C0+FNYiHgPnuDDr06kV7eWTx1jnqkcirEkzWw6ZkKFl1cITB47zvkIL6IgEgiSLQo0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675822; c=relaxed/simple;
	bh=YagDGeAKeaNi6n/5iUNHxp9D3X0jc6/m3qGlN9kzldc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AXgRbRceYoN0YayvpRIVyHZZWRKaNB/F+5T5kcFfuXMw478zO83CeJx/LLPU12ipMhI0a5hYm9gt9tGfsoJ0RfNnPWZf9AwOjTBbMfpPisS1YH+ySHreOi4BVQOznYYIYYZ284rxBMUgh5Aa3AmshlIlHGzx4fcfpEFYssvt25Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=TlUsCvmg; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="TlUsCvmg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719675811; x=1720280611; i=l.s.r@web.de;
	bh=5UTXkzhLz+SAaZ89rV8LL96uMktc4A5U3RQRvZ0uXGM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TlUsCvmgd7j2bOVNKjpNyq2bU8lbgW9FyNCN3wLS4knZ6CHhgxeZ/JkieGLuk9CV
	 NIY2mde8MheIpeg9WN6QPO0hqqFt+8wZvc/0c0ds8fcpiVm70SCvnIM0+Lois0VsW
	 fbi+xMo+7ycsFb/fpSII1XkSdZ2KIO7TRaggYTa+7yAHRYpq0ekgSnIhcMyLbPiFc
	 Os9vBGMOjThCctyf3rLT6Gxvmnepsn3jqzj3aydLGqi5ER0ifplem1PNMy0i1OYHB
	 0666fhZIARgASthf59/C4FpFOunWJ5kultwHXCq4kGO2qI4n38hgMFLwCD13oYAAF
	 e5VtWvnf0WgTqZeYPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzkOR-1sAsi212O1-016KIQ; Sat, 29
 Jun 2024 17:43:31 +0200
Message-ID: <8175f239-8d4e-49f7-ae0d-dba7df8c365d@web.de>
Date: Sat, 29 Jun 2024 17:43:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/6] unit-tests: add TEST_RUN
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Language: en-US
In-Reply-To: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fyvu8Y4w7h+gSXZ8rOJ/xIeAIpmWb6oIMgb2fU78LAjJGq59Wx/
 7cDCTBBchyXFzSPmDHI9l2K2q8H5SBinZeM5qzExJmpfHrsoOOysBRw1W9F4QrXSVKdfr0i
 tr4q3PoPRzXrjyODKsp9WixPFHhwk4njrUz3fJFdOEP7lGpdL40gnv9W0TrssXrTd5+L8e8
 sL53IZp0HiuAy/oknl1Og==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:99vhO0vwV3s=;A5jtXjVIWg1ttl5kO9gDuK1iHGw
 TyVkYYhUOLSwr50PQOcI6kXV3rAYFc+bztyUCoKrd0AuZ1IWeSHK2+FEdslrLQrqFnlP/qHPA
 Vwp+Djo5EIas8FWfcYgKL94l27MzIZo0Psj9gf/quSuqCG7AeLd1puUt0Ad5n6q5KU+nGEsdA
 SnWVZKkEGmlzyWHt4MMKJqMHVLrZjZpV8Pu62lPaIXcjqfy95jhwPWBKTWsebqmWu03Dwd0Wy
 Ci5RPy2YPggFX7w00ETaJfywzGBK/v8upnP5/hAz7eruEoR0b4aZAWbSRPA4A8l/MGIWHkk/z
 Tsl1Mna2bgawnfHSwguqg7Gkih4l7E5po1/Zt7fmtnR7Wh+WQD+V4eeFGKBrdG4ZwwaWTwlwS
 1Wp7pmdaMg6dPLYp4GqaFXW6kZM3yCzl99sNuY4NKAeydt/z/Fy3Vg4klkL1c2XvwIUReeu8W
 q7jQXZcODLG6N/PgFf+tIN/xhITfVi/6IF4e8W145MbKJJBEph1o4QC/SMrjArTgUh6TvnuEc
 Lbgqws0xL+DyVWMQutnaO24WHng/Y6wH8unIQcktWu2wCUIMoQe6FngPxmvZyDvkRrHByR3tz
 JgnjJpAPr06QPOAiHp2tVcYd+xTdSwdlHJ2IElZmKW3FLPFt/Fr8IBjJmN2NlBMPYrDItVJp/
 PLE6JPYEyDrSV7fBJ1wD0ODkO8ZQmtF6iHWcnA1VQ3Zu9BJ4wFrbSv9VY2DHd3dL4/4s3GP/K
 g897xeXsMsG76Eht25JGbAJu+eODn9q7wO9YVWMyo3sUq4azdWv0IL1YIPvq8Vz+ooc4aT+m7
 Libm8iROb86HSn4e6j9yUsIs1j5P34ZrzNZpg1B7je1dc=

The macro TEST only allows defining a test that consists of a single
expression.  Add the new macro, TEST_RUN, which provides a way to define
unit tests that are made up of one or more statements.  A test started
with it implicitly ends when the next test is started or test_done() is
called.

TEST_RUN allows defining self-contained tests en bloc, a bit like
test_expect_success does for regular tests.  Unlike TEST it does not
require defining wrapper functions for test statements.

No public method is provided for ending a test explicitly, yet; let's
see if we'll ever need one.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-example-tap.c | 33 +++++++++++++++++++++++++++++
 t/t0080/expect              | 35 ++++++++++++++++++++++++++++++-
 t/unit-tests/test-lib.c     | 42 +++++++++++++++++++++++++++++++++++--
 t/unit-tests/test-lib.h     |  8 +++++++
 4 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
index d072ad559f..7b02177a9f 100644
=2D-- a/t/helper/test-example-tap.c
+++ b/t/helper/test-example-tap.c
@@ -92,5 +92,38 @@ int cmd__example_tap(int argc, const char **argv)
 	test_res =3D TEST(t_empty(), "test with no checks");
 	TEST(check_int(test_res, =3D=3D, 0), "test with no checks returns 0");

+	if (TEST_RUN("TEST_RUN passing test"))
+		check_int(1, =3D=3D, 1);
+	if (TEST_RUN("TEST_RUN failing test"))
+		check_int(1, =3D=3D, 2);
+	if (TEST_RUN("TEST_RUN passing TEST_TODO()"))
+		TEST_TODO(check(0));
+	if (TEST_RUN("TEST_RUN failing TEST_TODO()"))
+		TEST_TODO(check(1));
+	if (TEST_RUN("TEST_RUN test_skip()")) {
+		check(0);
+		test_skip("missing prerequisite");
+		check(1);
+	}
+	if (TEST_RUN("TEST_RUN test_skip() inside TEST_TODO()"))
+		TEST_TODO((test_skip("missing prerequisite"), 1));
+	if (TEST_RUN("TEST_RUN TEST_TODO() after failing check")) {
+		check(0);
+		TEST_TODO(check(0));
+	}
+	if (TEST_RUN("TEST_RUN failing check after TEST_TODO()")) {
+		check(1);
+		TEST_TODO(check(0));
+		check(0);
+	}
+	if (TEST_RUN("TEST_RUN messages from failing string and char comparison"=
)) {
+		check_str("\thello\\", "there\"\n");
+		check_str("NULL", NULL);
+		check_char('a', =3D=3D, '\n');
+		check_char('\\', =3D=3D, '\'');
+	}
+	if (TEST_RUN("TEST_RUN test with no checks"))
+		; /* nothing */
+
 	return test_done();
 }
diff --git a/t/t0080/expect b/t/t0080/expect
index 0cfa0dc6d8..92526e1b06 100644
=2D-- a/t/t0080/expect
+++ b/t/t0080/expect
@@ -40,4 +40,37 @@ not ok 17 - messages from failing string and char compa=
rison
 # BUG: test has no checks at t/helper/test-example-tap.c:92
 not ok 18 - test with no checks
 ok 19 - test with no checks returns 0
-1..19
+ok 20 - TEST_RUN passing test
+# check "1 =3D=3D 2" failed at t/helper/test-example-tap.c:98
+#    left: 1
+#   right: 2
+not ok 21 - TEST_RUN failing test
+not ok 22 - TEST_RUN passing TEST_TODO() # TODO
+# todo check 'check(1)' succeeded at t/helper/test-example-tap.c:102
+not ok 23 - TEST_RUN failing TEST_TODO()
+# check "0" failed at t/helper/test-example-tap.c:104
+# skipping test - missing prerequisite
+# skipping check '1' at t/helper/test-example-tap.c:106
+ok 24 - TEST_RUN test_skip() # SKIP
+# skipping test - missing prerequisite
+ok 25 - TEST_RUN test_skip() inside TEST_TODO() # SKIP
+# check "0" failed at t/helper/test-example-tap.c:111
+not ok 26 - TEST_RUN TEST_TODO() after failing check
+# check "0" failed at t/helper/test-example-tap.c:117
+not ok 27 - TEST_RUN failing check after TEST_TODO()
+# check "!strcmp("\thello\\", "there\"\n")" failed at t/helper/test-examp=
le-tap.c:120
+#    left: "\011hello\\"
+#   right: "there\"\012"
+# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:121
+#    left: "NULL"
+#   right: NULL
+# check "'a' =3D=3D '\n'" failed at t/helper/test-example-tap.c:122
+#    left: 'a'
+#   right: '\012'
+# check "'\\' =3D=3D '\''" failed at t/helper/test-example-tap.c:123
+#    left: '\\'
+#   right: '\''
+not ok 28 - TEST_RUN messages from failing string and char comparison
+# BUG: test has no checks at t/helper/test-example-tap.c:125
+not ok 29 - TEST_RUN test with no checks
+1..29
diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 3c513ce59a..fc50755fae 100644
=2D-- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -16,6 +16,8 @@ static struct {
 	unsigned running :1;
 	unsigned skip_all :1;
 	unsigned todo :1;
+	char *desc;
+	char *location;
 } ctx =3D {
 	.lazy_plan =3D 1,
 	.result =3D RESULT_NONE,
@@ -123,9 +125,45 @@ void test_plan(int count)
 	ctx.lazy_plan =3D 0;
 }

-int test_done(void)
+static void test__run_maybe_end(void)
 {
+	if (ctx.running) {
+		assert(ctx.location);
+		assert(ctx.desc);
+		test__run_end(0, ctx.location, "%s", ctx.desc);
+		FREE_AND_NULL(ctx.location);
+		FREE_AND_NULL(ctx.desc);
+	}
 	assert(!ctx.running);
+	assert(!ctx.location);
+	assert(!ctx.desc);
+}
+
+int test__run(const char *location, const char *format, ...)
+{
+	va_list ap;
+	char *desc;
+
+	test__run_maybe_end();
+
+	va_start(ap, format);
+	desc =3D xstrvfmt(format, ap);
+	va_end(ap);
+
+	if (test__run_begin()) {
+		test__run_end(1, location, "%s", desc);
+		free(desc);
+		return 0;
+	} else {
+		ctx.location =3D xstrdup(location);
+		ctx.desc =3D desc;
+		return 1;
+	}
+}
+
+int test_done(void)
+{
+	test__run_maybe_end();

 	if (ctx.lazy_plan)
 		test_plan(ctx.count);
@@ -169,7 +207,7 @@ void test_skip_all(const char *format, ...)

 int test__run_begin(void)
 {
-	assert(!ctx.running);
+	test__run_maybe_end();

 	ctx.count++;
 	ctx.result =3D RESULT_NONE;
diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
index 2de6d715d5..6df40e3b12 100644
=2D-- a/t/unit-tests/test-lib.h
+++ b/t/unit-tests/test-lib.h
@@ -21,6 +21,13 @@
  */
 void test_plan(int count);

+/*
+ * Start a test, returns 1 if the test was actually started or 0 if it
+ * was skipped.  The test ends when the next test starts or test_done()
+ * is called.
+ */
+#define TEST_RUN(...) test__run(TEST_LOCATION(), __VA_ARGS__)
+
 /*
  * test_done() must be called at the end of main(). It will print the
  * plan if plan() was not called at the beginning of the test program
@@ -156,6 +163,7 @@ extern union test__tmp test__tmp[2];
 int test__run_begin(void);
 __attribute__((format (printf, 3, 4)))
 int test__run_end(int, const char *, const char *, ...);
+int test__run(const char *location, const char *format, ...);
 void test__todo_begin(void);
 int test__todo_end(const char *, const char *, int);

=2D-
2.45.2
