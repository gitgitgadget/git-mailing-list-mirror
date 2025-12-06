Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C72BE05B
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765021684; cv=none; b=id1n04G5tdPa//TtTSe/5yskkuayMGNXMOvFV3YSNSb/Wj3AITNBSJLLRowcyxv3jHn/GdJkAqejd95IqhGVr3b4WsLeGh/ZzvOhj16KX3IuLLh6HkSfrnQAgCNh6Bw7A1Mo+a/om8HbzePoci3A83UE8fnN7mEHiGuYjs/3cP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765021684; c=relaxed/simple;
	bh=5x1BxiWFoSxZtfS/EyxQHQRjcw0EILH4zKO5IXs3yeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qUDUqfx/ETcIzFNnMQAa+idQ3gnOAVAHQkQBEVntlVh4WBmGAcphu4IJny+WdmU1u/I6AyVnHnpMV4wQIZrfBJCi+MvzNzU1RMACBaeFLlZ2P+JzWUQ+RHk2lHVM5mMiRwPWwGuDk9licX6MrluD5jcBbnpDeBA4J4LmDE0fgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V3PVXP4N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xvDp32Oa; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V3PVXP4N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xvDp32Oa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 026A97A0092;
	Sat,  6 Dec 2025 06:48:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 06 Dec 2025 06:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765021680;
	 x=1765108080; bh=sWO+SlVsdsqnXvrm+C4D36y25owpqTRXuKSTkzXPz2A=; b=
	V3PVXP4NCjYKMpLqo328W5JcFZO3dzg9Ai5kmsyvTMuNR449X7QUElXNjKD4TTWE
	va0TzH23+s0voH8trapdZaOGlst1G4yZFP/mnQwq0D3kZUn/NNjO6aQ3RmgQC2yC
	UEtEf8w7dYPomwbnM5/Wux8DpNwi5pXXHV5CLb8RLV2Kx9dmPetu8Ibv3RK/b/Gm
	RkY/7u2sh50sT9JvYAN4vSymvEtH/N04f73xkbOUdxxVzbt5QDyNrfcPfJlRk8I7
	F0/lVwjoeukGAs7vSuMnOKEckQaLPbrEb9kzdASVd1Zt9P9i5rVBHjo6Y53kjSEg
	osaR9m0EDzyjTZF0BGOYvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765021680; x=
	1765108080; bh=sWO+SlVsdsqnXvrm+C4D36y25owpqTRXuKSTkzXPz2A=; b=x
	vDp32Oa1tv2Jnr11oc2LxsG1QJf+CNrwalgSpph4jj9+rAKZSoJx+oapiut+eWBe
	mJt3HKfTbll4bpzBz1fWqSeg0sp3H12Rx97FrxjwW3nmLvU7CCjdSdNr55ZacGYZ
	0qfPyQHI/SD3IhlbTWCO3yTeN+k71ovQakCGeieKQ5KI8jDbPgZ4kVbFEJA4tAdd
	uUI84klZmPD1O7auYIgyqHAw3q0PyvxlPiraD7OYukdC1ANuS6H6ctb85/wxlcQ4
	w66AR+R7ov/z1rF3J+jABSR/+gFV3bcQjbAiwgs3Rx0FnaSFmC5aAMQ5H92+NPZ5
	TpOLZnwlfD8o0KDEvbgnQ==
X-ME-Sender: <xms:8Bc0aZ63-eMFO2BAL0uYEsrmCbEwRbPYVTdtMf_Ei1P7Qxj9O_JhWw>
    <xme:8Bc0aeUZxWdhsji0i261e1Se1FaWio1ObygC4vPijakaW1Ived6Z9LBh5M_G-mGR-
    UNQT-WXrc6J8PjQ15EXzIC09W-Kb8l5DzjPEjpy30v78C1vNcugow>
X-ME-Received: <xmr:8Bc0ad3Mye2ArIpzinap9-dcL4-v6Jast3QpLufq-1_HQNE3inPQo5R6SXu4FEr12iqXceBNtETQ0DEjtzUKUPUv5-pUIv7pvyX60TES>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:8Bc0ab1Lgfe7LD1pS-yg2eBmLsxjVANAWF8OS84a7cQ3Acu3jHBhlQ>
    <xmx:8Bc0aQ-Jtq6g2gEJY0DyMHUipp3b4AyZm2Htc9C7_kFSSmv9sDb_nw>
    <xmx:8Bc0aY1WQckCWe8r9KtUHjDWlWWT9_T3w0XmQtjIySwwSmdZdV-MJw>
    <xmx:8Bc0ad-RY-J9VYMtuoE_QO26KyxuOAhXF0T3_12_qnO6oZAtlayGBw>
    <xmx:8Bc0afCqFOkbKxv6c7fqsemYdJ288NyxsmlxjCSV2FGvHH4QYXCN1eKW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 06:48:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c3b9f18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 6 Dec 2025 11:47:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sat, 06 Dec 2025 12:47:32 +0100
Subject: [PATCH v2 1/3] t/unit-tests: update clar to 39f11fe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251206-b4-pks-clar-update-v2-1-9a14b10c1a36@pks.im>
References: <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
In-Reply-To: <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.3

Update clar to commit 39f11fe (Merge pull request #131 from
pks-gitlab/pks-integer-double-evaluation, 2025-12-05). This commit
includes the following changes relevant to Git:

  - There are now typesafe integer comparison functions. Furthermore,
    the range of comparison functions has been included to also have
    relative comparisons, like "greater than".

  - There is a new `cl_failf()` macro that allows the caller to specify
    an error message with formatting directives.

  - The TAP format has been fixed to correctly terminate YAML blocks
    with "...\n" instead of "---\n".

Note that we already had a `cl_failf()` function declared in our own
sources. This function is equivalent to the upstreamed function, so we
can simply drop it now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/.github/workflows/ci.yml         |   2 +-
 t/unit-tests/clar/clar.c                           | 146 ++++++++++++++++++++-
 t/unit-tests/clar/clar.h                           |  82 +++++++++++-
 t/unit-tests/clar/clar/print.h                     |   2 +-
 t/unit-tests/clar/test/expected/quiet              |  40 +++++-
 .../clar/test/expected/summary_with_filename       |  42 +++++-
 .../clar/test/expected/summary_without_filename    |  42 +++++-
 t/unit-tests/clar/test/expected/tap                |  88 +++++++++++--
 t/unit-tests/clar/test/expected/without_arguments  |  42 +++++-
 t/unit-tests/clar/test/selftest.c                  |  10 +-
 t/unit-tests/clar/test/suites/combined.c           |  65 ++++++++-
 t/unit-tests/unit-test.h                           |   6 -
 12 files changed, 508 insertions(+), 59 deletions(-)

diff --git a/t/unit-tests/clar/.github/workflows/ci.yml b/t/unit-tests/clar/.github/workflows/ci.yml
index 4d4724222c..14cb4ed1d4 100644
--- a/t/unit-tests/clar/.github/workflows/ci.yml
+++ b/t/unit-tests/clar/.github/workflows/ci.yml
@@ -53,7 +53,7 @@ jobs:
       if: matrix.platform.image == 'i386/debian:latest'
       run: apt -q update && apt -q -y install cmake gcc libc6-amd64 lib64stdc++6 make python3
     - name: Check out
-      uses: actions/checkout@v4
+      uses: actions/checkout@v6
     - name: Build
       shell: bash
       run: |
diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index d6176e50b2..e959a5ae02 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -24,6 +24,14 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
+#ifndef va_copy
+#	ifdef __va_copy
+#		define va_copy(dst, src) __va_copy(dst, src)
+#	else
+#		define va_copy(dst, src) ((dst) = (src))
+#	endif
+#endif
+
 #if defined(__UCLIBC__) && ! defined(__UCLIBC_HAS_WCHAR__)
 	/*
 	 * uClibc can optionally be built without wchar support, in which case
@@ -76,8 +84,10 @@
 #			define S_ISDIR(x) ((x & _S_IFDIR) != 0)
 #		endif
 #		define p_snprintf(buf,sz,fmt,...) _snprintf_s(buf,sz,_TRUNCATE,fmt,__VA_ARGS__)
+#		define p_vsnprintf _vsnprintf
 #	else
 #		define p_snprintf snprintf
+#		define p_vsnprintf vsnprintf
 #	endif
 
 #	define localtime_r(timer, buf) (localtime_s(buf, timer) == 0 ? buf : NULL)
@@ -86,6 +96,7 @@
 #	include <unistd.h>
 #	define _MAIN_CC
 #	define p_snprintf snprintf
+#	define p_vsnprintf vsnprintf
 	typedef struct stat STAT_T;
 #endif
 
@@ -699,13 +710,14 @@ void clar__skip(void)
 	abort_test();
 }
 
-void clar__fail(
+static void clar__failv(
 	const char *file,
 	const char *function,
 	size_t line,
+	int should_abort,
 	const char *error_msg,
 	const char *description,
-	int should_abort)
+	va_list args)
 {
 	struct clar_error *error;
 
@@ -725,9 +737,19 @@ void clar__fail(
 	error->line_number = _clar.invoke_line ? _clar.invoke_line : line;
 	error->error_msg = error_msg;
 
-	if (description != NULL &&
-	    (error->description = strdup(description)) == NULL)
-		clar_abort("Failed to allocate description.\n");
+	if (description != NULL) {
+		va_list args_copy;
+		int len;
+
+		va_copy(args_copy, args);
+		if ((len = p_vsnprintf(NULL, 0, description, args_copy)) < 0)
+			clar_abort("Failed to compute description.");
+		va_end(args_copy);
+
+		if ((error->description = calloc(1, len + 1)) == NULL)
+			clar_abort("Failed to allocate buffer.");
+		p_vsnprintf(error->description, len + 1, description, args);
+	}
 
 	_clar.total_errors++;
 	_clar.last_report->status = CL_TEST_FAILURE;
@@ -736,6 +758,34 @@ void clar__fail(
 		abort_test();
 }
 
+void clar__failf(
+	const char *file,
+	const char *function,
+	size_t line,
+	int should_abort,
+	const char *error_msg,
+	const char *description,
+	...)
+{
+	va_list args;
+	va_start(args, description);
+	clar__failv(file, function, line, should_abort, error_msg,
+		    description, args);
+	va_end(args);
+}
+
+void clar__fail(
+	const char *file,
+	const char *function,
+	size_t line,
+	const char *error_msg,
+	const char *description,
+	int should_abort)
+{
+	clar__failf(file, function, line, should_abort, error_msg,
+		    description ? "%s" : NULL, description);
+}
+
 void clar__assert(
 	int condition,
 	const char *file,
@@ -889,6 +939,92 @@ void clar__assert_equal(
 		clar__fail(file, function, line, err, buf, should_abort);
 }
 
+void clar__assert_compare_i(
+	const char *file,
+	const char *func,
+	size_t line,
+	int should_abort,
+	enum clar_comparison cmp,
+	intmax_t value1,
+	intmax_t value2,
+	const char *error,
+	const char *description,
+	...)
+{
+	int fulfilled;
+	switch (cmp) {
+	case CLAR_COMPARISON_EQ:
+		fulfilled = value1 == value2;
+		break;
+	case CLAR_COMPARISON_LT:
+		fulfilled = value1 < value2;
+		break;
+	case CLAR_COMPARISON_LE:
+		fulfilled = value1 <= value2;
+		break;
+	case CLAR_COMPARISON_GT:
+		fulfilled = value1 > value2;
+		break;
+	case CLAR_COMPARISON_GE:
+		fulfilled = value1 >= value2;
+		break;
+	default:
+		cl_assert(0);
+		return;
+	}
+
+	if (!fulfilled) {
+		va_list args;
+		va_start(args, description);
+		clar__failv(file, func, line, should_abort, error,
+			    description, args);
+		va_end(args);
+	}
+}
+
+void clar__assert_compare_u(
+	const char *file,
+	const char *func,
+	size_t line,
+	int should_abort,
+	enum clar_comparison cmp,
+	uintmax_t value1,
+	uintmax_t value2,
+	const char *error,
+	const char *description,
+	...)
+{
+	int fulfilled;
+	switch (cmp) {
+	case CLAR_COMPARISON_EQ:
+		fulfilled = value1 == value2;
+		break;
+	case CLAR_COMPARISON_LT:
+		fulfilled = value1 < value2;
+		break;
+	case CLAR_COMPARISON_LE:
+		fulfilled = value1 <= value2;
+		break;
+	case CLAR_COMPARISON_GT:
+		fulfilled = value1 > value2;
+		break;
+	case CLAR_COMPARISON_GE:
+		fulfilled = value1 >= value2;
+		break;
+	default:
+		cl_assert(0);
+		return;
+	}
+
+	if (!fulfilled) {
+		va_list args;
+		va_start(args, description);
+		clar__failv(file, func, line, should_abort, error,
+			    description, args);
+		va_end(args);
+	}
+}
+
 void cl_set_cleanup(void (*cleanup)(void *), void *opaque)
 {
 	_clar.local_cleanup = cleanup;
diff --git a/t/unit-tests/clar/clar.h b/t/unit-tests/clar/clar.h
index ca72292ae9..f7e4363022 100644
--- a/t/unit-tests/clar/clar.h
+++ b/t/unit-tests/clar/clar.h
@@ -7,6 +7,7 @@
 #ifndef __CLAR_TEST_H__
 #define __CLAR_TEST_H__
 
+#include <inttypes.h>
 #include <stdlib.h>
 #include <limits.h>
 
@@ -149,6 +150,7 @@ const char *cl_fixture_basename(const char *fixture_name);
  * Forced failure/warning
  */
 #define cl_fail(desc) clar__fail(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, "Test failed.", desc, 1)
+#define cl_failf(desc,...) clar__failf(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, "Test failed.", desc, __VA_ARGS__)
 #define cl_warning(desc) clar__fail(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, "Warning during test execution:", desc, 0)
 
 #define cl_skip() clar__skip()
@@ -168,9 +170,42 @@ const char *cl_fixture_basename(const char *fixture_name);
 #define cl_assert_equal_wcsn(wcs1,wcs2,len) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,"String mismatch: " #wcs1 " != " #wcs2, 1, "%.*ls", (wcs1), (wcs2), (int)(len))
 #define cl_assert_equal_wcsn_(wcs1,wcs2,len,note) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,"String mismatch: " #wcs1 " != " #wcs2 " (" #note ")", 1, "%.*ls", (wcs1), (wcs2), (int)(len))
 
-#define cl_assert_equal_i(i1,i2) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#i1 " != " #i2, 1, "%d", (int)(i1), (int)(i2))
-#define cl_assert_equal_i_(i1,i2,note) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#i1 " != " #i2 " (" #note ")", 1, "%d", (i1), (i2))
-#define cl_assert_equal_i_fmt(i1,i2,fmt) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#i1 " != " #i2, 1, (fmt), (int)(i1), (int)(i2))
+#define cl_assert_compare_i_(i1, i2, cmp, error, ...) clar__assert_compare_i(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, cmp, \
+									     (i1), (i2), "Expected comparison to hold: " error, __VA_ARGS__)
+#define cl_assert_compare_i(i1, i2, cmp, error, fmt) do { \
+	intmax_t v1 = (i1), v2 = (i2); \
+	clar__assert_compare_i(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, cmp, \
+			       v1, v2, "Expected comparison to hold: " error, fmt, v1, v2); \
+} while (0)
+#define cl_assert_equal_i_(i1, i2, ...)    cl_assert_compare_i_(i1, i2, CLAR_COMPARISON_EQ, #i1 " == " #i2, __VA_ARGS__)
+#define cl_assert_equal_i(i1, i2)          cl_assert_compare_i (i1, i2, CLAR_COMPARISON_EQ, #i1 " == " #i2, "%"PRIdMAX " != %"PRIdMAX)
+#define cl_assert_equal_i_fmt(i1, i2, fmt) cl_assert_compare_i_(i1, i2, CLAR_COMPARISON_EQ, #i1 " == " #i2,  fmt " != " fmt, (int)(i1), (int)(i2))
+#define cl_assert_lt_i_(i1, i2, ...) cl_assert_compare_i_(i1, i2, CLAR_COMPARISON_LT, #i1 " < " #i2, __VA_ARGS__)
+#define cl_assert_lt_i(i1, i2)       cl_assert_compare_i (i1, i2, CLAR_COMPARISON_LT, #i1 " < " #i2, "%"PRIdMAX " >= %"PRIdMAX)
+#define cl_assert_le_i_(i1, i2, ...) cl_assert_compare_i_(i1, i2, CLAR_COMPARISON_LE, #i1 " <= " #i2, __VA_ARGS__)
+#define cl_assert_le_i(i1, i2)       cl_assert_compare_i (i1, i2, CLAR_COMPARISON_LE, #i1 " <= " #i2, "%"PRIdMAX " > %"PRIdMAX)
+#define cl_assert_gt_i_(i1, i2, ...) cl_assert_compare_i_(i1, i2, CLAR_COMPARISON_GT, #i1 " > " #i2, __VA_ARGS__)
+#define cl_assert_gt_i(i1, i2)       cl_assert_compare_i (i1, i2, CLAR_COMPARISON_GT, #i1 " > " #i2, "%"PRIdMAX " <= %"PRIdMAX)
+#define cl_assert_ge_i_(i1, i2, ...) cl_assert_compare_i_(i1, i2, CLAR_COMPARISON_GE, #i1 " >= " #i2, __VA_ARGS__)
+#define cl_assert_ge_i(i1, i2)       cl_assert_compare_i (i1, i2, CLAR_COMPARISON_GE, #i1 " >= " #i2, "%"PRIdMAX " < %"PRIdMAX)
+
+#define cl_assert_compare_u_(u1, u2, cmp, error, ...) clar__assert_compare_u(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, cmp, \
+									     (u1), (u2), "Expected comparison to hold: " error, __VA_ARGS__)
+#define cl_assert_compare_u(u1, u2, cmp, error, fmt) do { \
+	uintmax_t v1 = (u1), v2 = (u2); \
+	clar__assert_compare_u(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, cmp, \
+			       v1, v2, "Expected comparison to hold: " error, fmt, v1, v2); \
+} while (0)
+#define cl_assert_equal_u_(u1, u2, ...) cl_assert_compare_u_(u1, u2, CLAR_COMPARISON_EQ, #u1 " == " #u2, __VA_ARGS__)
+#define cl_assert_equal_u(u1, u2)       cl_assert_compare_u (u1, u2, CLAR_COMPARISON_EQ, #u1 " == " #u2, "%"PRIuMAX " != %"PRIuMAX)
+#define cl_assert_lt_u_(u1, u2, ...) cl_assert_compare_u_(u1, u2, CLAR_COMPARISON_LT, #u1 " < " #u2, __VA_ARGS__)
+#define cl_assert_lt_u(u1, u2)       cl_assert_compare_u (u1, u2, CLAR_COMPARISON_LT, #u1 " < " #u2, "%"PRIuMAX " >= %"PRIuMAX)
+#define cl_assert_le_u_(u1, u2, ...) cl_assert_compare_u_(u1, u2, CLAR_COMPARISON_LE, #u1 " <= " #u2, __VA_ARGS__)
+#define cl_assert_le_u(u1, u2)       cl_assert_compare_u (u1, u2, CLAR_COMPARISON_LE, #u1 " <= " #u2, "%"PRIuMAX " > %"PRIuMAX)
+#define cl_assert_gt_u_(u1, u2, ...) cl_assert_compare_u_(u1, u2, CLAR_COMPARISON_GT, #u1 " > " #u2, __VA_ARGS__)
+#define cl_assert_gt_u(u1, u2)       cl_assert_compare_u (u1, u2, CLAR_COMPARISON_GT, #u1 " > " #u2, "%"PRIuMAX " <= %"PRIuMAX)
+#define cl_assert_ge_u_(u1, u2, ...) cl_assert_compare_u_(u1, u2, CLAR_COMPARISON_GE, #u1 " >= " #u2, __VA_ARGS__)
+#define cl_assert_ge_u(u1, u2)       cl_assert_compare_u (u1, u2, CLAR_COMPARISON_GE, #u1 " >= " #u2, "%"PRIuMAX " < %"PRIuMAX)
 
 #define cl_assert_equal_b(b1,b2) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#b1 " != " #b2, 1, "%d", (int)((b1) != 0),(int)((b2) != 0))
 
@@ -186,6 +221,15 @@ void clar__fail(
 	const char *description,
 	int should_abort);
 
+void clar__failf(
+	const char *file,
+	const char *func,
+	size_t line,
+	int should_abort,
+	const char *error,
+	const char *description,
+	...);
+
 void clar__assert(
 	int condition,
 	const char *file,
@@ -204,6 +248,38 @@ void clar__assert_equal(
 	const char *fmt,
 	...);
 
+enum clar_comparison {
+	CLAR_COMPARISON_EQ,
+	CLAR_COMPARISON_LT,
+	CLAR_COMPARISON_LE,
+	CLAR_COMPARISON_GT,
+	CLAR_COMPARISON_GE,
+};
+
+void clar__assert_compare_i(
+	const char *file,
+	const char *func,
+	size_t line,
+	int should_abort,
+	enum clar_comparison cmp,
+	intmax_t value1,
+	intmax_t value2,
+	const char *error,
+	const char *description,
+	...);
+
+void clar__assert_compare_u(
+	const char *file,
+	const char *func,
+	size_t line,
+	int should_abort,
+	enum clar_comparison cmp,
+	uintmax_t value1,
+	uintmax_t value2,
+	const char *error,
+	const char *description,
+	...);
+
 void clar__set_invokepoint(
 	const char *file,
 	const char *func,
diff --git a/t/unit-tests/clar/clar/print.h b/t/unit-tests/clar/clar/print.h
index 89b66591d7..6a2321b399 100644
--- a/t/unit-tests/clar/clar/print.h
+++ b/t/unit-tests/clar/clar/print.h
@@ -164,7 +164,7 @@ static void clar_print_tap_ontest(const char *suite_name, const char *test_name,
 			printf("      file: '"); print_escaped(error->file); printf("'\n");
 			printf("      line: %" PRIuMAX "\n", error->line_number);
 			printf("      function: '%s'\n", error->function);
-			printf("    ---\n");
+			printf("    ...\n");
 		}
 
 		break;
diff --git a/t/unit-tests/clar/test/expected/quiet b/t/unit-tests/clar/test/expected/quiet
index 280c99d8ad..a93273b5a2 100644
--- a/t/unit-tests/clar/test/expected/quiet
+++ b/t/unit-tests/clar/test/expected/quiet
@@ -18,27 +18,57 @@ combined::strings_with_length [file:42]
 
   5) Failure:
 combined::int [file:42]
-  101 != value ("extra note on failing test")
+  Expected comparison to hold: 101 == value
   101 != 100
 
   6) Failure:
+combined::int_note [file:42]
+  Expected comparison to hold: 101 == value
+  extra note on failing test
+
+  7) Failure:
 combined::int_fmt [file:42]
-  022 != value
+  Expected comparison to hold: 022 == value
   0022 != 0144
 
-  7) Failure:
+  8) Failure:
 combined::bool [file:42]
   0 != value
   0 != 1
 
-  8) Failure:
+  9) Failure:
 combined::multiline_description [file:42]
   Function call failed: -1
   description line 1
   description line 2
 
-  9) Failure:
+  10) Failure:
 combined::null_string [file:42]
   String mismatch: "expected" != actual ("this one fails")
   'expected' != NULL
 
+  11) Failure:
+combined::failf [file:42]
+  Test failed.
+  some reason: foo
+
+  12) Failure:
+combined::compare_i [file:42]
+  Expected comparison to hold: two < 1
+  2 >= 1
+
+  13) Failure:
+combined::compare_i_with_format [file:42]
+  Expected comparison to hold: two < 1
+  foo: bar
+
+  14) Failure:
+combined::compare_u [file:42]
+  Expected comparison to hold: two < 1
+  2 >= 1
+
+  15) Failure:
+combined::compare_u_with_format [file:42]
+  Expected comparison to hold: two < 1
+  foo: bar
+
diff --git a/t/unit-tests/clar/test/expected/summary_with_filename b/t/unit-tests/clar/test/expected/summary_with_filename
index 460160791d..a9471cc7d5 100644
--- a/t/unit-tests/clar/test/expected/summary_with_filename
+++ b/t/unit-tests/clar/test/expected/summary_with_filename
@@ -1,6 +1,6 @@
 Loaded 1 suites:
 Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')
-FFFFFFFFF
+FFFFFFFFFFFFFFF
 
   1) Failure:
 combined::1 [file:42]
@@ -22,28 +22,58 @@ combined::strings_with_length [file:42]
 
   5) Failure:
 combined::int [file:42]
-  101 != value ("extra note on failing test")
+  Expected comparison to hold: 101 == value
   101 != 100
 
   6) Failure:
+combined::int_note [file:42]
+  Expected comparison to hold: 101 == value
+  extra note on failing test
+
+  7) Failure:
 combined::int_fmt [file:42]
-  022 != value
+  Expected comparison to hold: 022 == value
   0022 != 0144
 
-  7) Failure:
+  8) Failure:
 combined::bool [file:42]
   0 != value
   0 != 1
 
-  8) Failure:
+  9) Failure:
 combined::multiline_description [file:42]
   Function call failed: -1
   description line 1
   description line 2
 
-  9) Failure:
+  10) Failure:
 combined::null_string [file:42]
   String mismatch: "expected" != actual ("this one fails")
   'expected' != NULL
 
+  11) Failure:
+combined::failf [file:42]
+  Test failed.
+  some reason: foo
+
+  12) Failure:
+combined::compare_i [file:42]
+  Expected comparison to hold: two < 1
+  2 >= 1
+
+  13) Failure:
+combined::compare_i_with_format [file:42]
+  Expected comparison to hold: two < 1
+  foo: bar
+
+  14) Failure:
+combined::compare_u [file:42]
+  Expected comparison to hold: two < 1
+  2 >= 1
+
+  15) Failure:
+combined::compare_u_with_format [file:42]
+  Expected comparison to hold: two < 1
+  foo: bar
+
 written summary file to different.xml
diff --git a/t/unit-tests/clar/test/expected/summary_without_filename b/t/unit-tests/clar/test/expected/summary_without_filename
index 7874c1d98b..83ba770d00 100644
--- a/t/unit-tests/clar/test/expected/summary_without_filename
+++ b/t/unit-tests/clar/test/expected/summary_without_filename
@@ -1,6 +1,6 @@
 Loaded 1 suites:
 Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')
-FFFFFFFFF
+FFFFFFFFFFFFFFF
 
   1) Failure:
 combined::1 [file:42]
@@ -22,28 +22,58 @@ combined::strings_with_length [file:42]
 
   5) Failure:
 combined::int [file:42]
-  101 != value ("extra note on failing test")
+  Expected comparison to hold: 101 == value
   101 != 100
 
   6) Failure:
+combined::int_note [file:42]
+  Expected comparison to hold: 101 == value
+  extra note on failing test
+
+  7) Failure:
 combined::int_fmt [file:42]
-  022 != value
+  Expected comparison to hold: 022 == value
   0022 != 0144
 
-  7) Failure:
+  8) Failure:
 combined::bool [file:42]
   0 != value
   0 != 1
 
-  8) Failure:
+  9) Failure:
 combined::multiline_description [file:42]
   Function call failed: -1
   description line 1
   description line 2
 
-  9) Failure:
+  10) Failure:
 combined::null_string [file:42]
   String mismatch: "expected" != actual ("this one fails")
   'expected' != NULL
 
+  11) Failure:
+combined::failf [file:42]
+  Test failed.
+  some reason: foo
+
+  12) Failure:
+combined::compare_i [file:42]
+  Expected comparison to hold: two < 1
+  2 >= 1
+
+  13) Failure:
+combined::compare_i_with_format [file:42]
+  Expected comparison to hold: two < 1
+  foo: bar
+
+  14) Failure:
+combined::compare_u [file:42]
+  Expected comparison to hold: two < 1
+  2 >= 1
+
+  15) Failure:
+combined::compare_u_with_format [file:42]
+  Expected comparison to hold: two < 1
+  foo: bar
+
 written summary file to summary.xml
diff --git a/t/unit-tests/clar/test/expected/tap b/t/unit-tests/clar/test/expected/tap
index bddbd5dfe9..e67118d3ae 100644
--- a/t/unit-tests/clar/test/expected/tap
+++ b/t/unit-tests/clar/test/expected/tap
@@ -8,7 +8,7 @@ not ok 1 - combined::1
       file: 'file'
       line: 42
       function: 'func'
-    ---
+    ...
 not ok 2 - combined::2
     ---
     reason: |
@@ -17,7 +17,7 @@ not ok 2 - combined::2
       file: 'file'
       line: 42
       function: 'func'
-    ---
+    ...
 not ok 3 - combined::strings
     ---
     reason: |
@@ -27,7 +27,7 @@ not ok 3 - combined::strings
       file: 'file'
       line: 42
       function: 'func'
-    ---
+    ...
 not ok 4 - combined::strings_with_length
     ---
     reason: |
@@ -37,28 +37,38 @@ not ok 4 - combined::strings_with_length
       file: 'file'
       line: 42
       function: 'func'
-    ---
+    ...
 not ok 5 - combined::int
     ---
     reason: |
-      101 != value ("extra note on failing test")
+      Expected comparison to hold: 101 == value
       101 != 100
     at:
       file: 'file'
       line: 42
       function: 'func'
+    ...
+not ok 6 - combined::int_note
     ---
-not ok 6 - combined::int_fmt
+    reason: |
+      Expected comparison to hold: 101 == value
+      extra note on failing test
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ...
+not ok 7 - combined::int_fmt
     ---
     reason: |
-      022 != value
+      Expected comparison to hold: 022 == value
       0022 != 0144
     at:
       file: 'file'
       line: 42
       function: 'func'
-    ---
-not ok 7 - combined::bool
+    ...
+not ok 8 - combined::bool
     ---
     reason: |
       0 != value
@@ -67,8 +77,8 @@ not ok 7 - combined::bool
       file: 'file'
       line: 42
       function: 'func'
-    ---
-not ok 8 - combined::multiline_description
+    ...
+not ok 9 - combined::multiline_description
     ---
     reason: |
       Function call failed: -1
@@ -78,8 +88,8 @@ not ok 8 - combined::multiline_description
       file: 'file'
       line: 42
       function: 'func'
-    ---
-not ok 9 - combined::null_string
+    ...
+not ok 10 - combined::null_string
     ---
     reason: |
       String mismatch: "expected" != actual ("this one fails")
@@ -88,5 +98,55 @@ not ok 9 - combined::null_string
       file: 'file'
       line: 42
       function: 'func'
+    ...
+not ok 11 - combined::failf
+    ---
+    reason: |
+      Test failed.
+      some reason: foo
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ...
+not ok 12 - combined::compare_i
     ---
-1..9
+    reason: |
+      Expected comparison to hold: two < 1
+      2 >= 1
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ...
+not ok 13 - combined::compare_i_with_format
+    ---
+    reason: |
+      Expected comparison to hold: two < 1
+      foo: bar
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ...
+not ok 14 - combined::compare_u
+    ---
+    reason: |
+      Expected comparison to hold: two < 1
+      2 >= 1
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ...
+not ok 15 - combined::compare_u_with_format
+    ---
+    reason: |
+      Expected comparison to hold: two < 1
+      foo: bar
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ...
+1..15
diff --git a/t/unit-tests/clar/test/expected/without_arguments b/t/unit-tests/clar/test/expected/without_arguments
index 1111d418a0..9891f45a70 100644
--- a/t/unit-tests/clar/test/expected/without_arguments
+++ b/t/unit-tests/clar/test/expected/without_arguments
@@ -1,6 +1,6 @@
 Loaded 1 suites:
 Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')
-FFFFFFFFF
+FFFFFFFFFFFFFFF
 
   1) Failure:
 combined::1 [file:42]
@@ -22,27 +22,57 @@ combined::strings_with_length [file:42]
 
   5) Failure:
 combined::int [file:42]
-  101 != value ("extra note on failing test")
+  Expected comparison to hold: 101 == value
   101 != 100
 
   6) Failure:
+combined::int_note [file:42]
+  Expected comparison to hold: 101 == value
+  extra note on failing test
+
+  7) Failure:
 combined::int_fmt [file:42]
-  022 != value
+  Expected comparison to hold: 022 == value
   0022 != 0144
 
-  7) Failure:
+  8) Failure:
 combined::bool [file:42]
   0 != value
   0 != 1
 
-  8) Failure:
+  9) Failure:
 combined::multiline_description [file:42]
   Function call failed: -1
   description line 1
   description line 2
 
-  9) Failure:
+  10) Failure:
 combined::null_string [file:42]
   String mismatch: "expected" != actual ("this one fails")
   'expected' != NULL
 
+  11) Failure:
+combined::failf [file:42]
+  Test failed.
+  some reason: foo
+
+  12) Failure:
+combined::compare_i [file:42]
+  Expected comparison to hold: two < 1
+  2 >= 1
+
+  13) Failure:
+combined::compare_i_with_format [file:42]
+  Expected comparison to hold: two < 1
+  foo: bar
+
+  14) Failure:
+combined::compare_u [file:42]
+  Expected comparison to hold: two < 1
+  2 >= 1
+
+  15) Failure:
+combined::compare_u_with_format [file:42]
+  Expected comparison to hold: two < 1
+  foo: bar
+
diff --git a/t/unit-tests/clar/test/selftest.c b/t/unit-tests/clar/test/selftest.c
index eed83e4512..6eadc64c48 100644
--- a/t/unit-tests/clar/test/selftest.c
+++ b/t/unit-tests/clar/test/selftest.c
@@ -298,7 +298,7 @@ void test_selftest__help(void)
 
 void test_selftest__without_arguments(void)
 {
-	cl_invoke(assert_output("combined", "without_arguments", 9, NULL));
+	cl_invoke(assert_output("combined", "without_arguments", 15, NULL));
 }
 
 void test_selftest__specific_test(void)
@@ -313,12 +313,12 @@ void test_selftest__stop_on_failure(void)
 
 void test_selftest__quiet(void)
 {
-	cl_invoke(assert_output("combined", "quiet", 9, "-q", NULL));
+	cl_invoke(assert_output("combined", "quiet", 15, "-q", NULL));
 }
 
 void test_selftest__tap(void)
 {
-	cl_invoke(assert_output("combined", "tap", 9, "-t", NULL));
+	cl_invoke(assert_output("combined", "tap", 15, "-t", NULL));
 }
 
 void test_selftest__suite_names(void)
@@ -329,7 +329,7 @@ void test_selftest__suite_names(void)
 void test_selftest__summary_without_filename(void)
 {
 	struct stat st;
-	cl_invoke(assert_output("combined", "summary_without_filename", 9, "-r", NULL));
+	cl_invoke(assert_output("combined", "summary_without_filename", 15, "-r", NULL));
 	/* The summary contains timestamps, so we cannot verify its contents. */
 	cl_must_pass(stat("summary.xml", &st));
 }
@@ -337,7 +337,7 @@ void test_selftest__summary_without_filename(void)
 void test_selftest__summary_with_filename(void)
 {
 	struct stat st;
-	cl_invoke(assert_output("combined", "summary_with_filename", 9, "-rdifferent.xml", NULL));
+	cl_invoke(assert_output("combined", "summary_with_filename", 15, "-rdifferent.xml", NULL));
 	/* The summary contains timestamps, so we cannot verify its contents. */
 	cl_must_pass(stat("different.xml", &st));
 }
diff --git a/t/unit-tests/clar/test/suites/combined.c b/t/unit-tests/clar/test/suites/combined.c
index e8b41c98c3..9e9dbc2fb1 100644
--- a/t/unit-tests/clar/test/suites/combined.c
+++ b/t/unit-tests/clar/test/suites/combined.c
@@ -55,7 +55,12 @@ void test_combined__strings_with_length(void)
 void test_combined__int(void)
 {
 	int value = 100;
-	cl_assert_equal_i(100, value);
+	cl_assert_equal_i(101, value);
+}
+
+void test_combined__int_note(void)
+{
+	int value = 100;
 	cl_assert_equal_i_(101, value, "extra note on failing test");
 }
 
@@ -83,3 +88,61 @@ void test_combined__null_string(void)
 	cl_assert_equal_s(actual, actual);
 	cl_assert_equal_s_("expected", actual, "this one fails");
 }
+
+void test_combined__failf(void)
+{
+	cl_failf("some reason: %s", "foo");
+}
+
+void test_combined__compare_i(void)
+{
+	int one = 1, two = 2;
+
+	cl_assert_equal_i(one, 1);
+	cl_assert_equal_i(one, 1);
+	cl_assert_equal_i_(one, 1, "format");
+	cl_assert_lt_i(one, 2);
+	cl_assert_lt_i_(one, 2, "format");
+	cl_assert_le_i(one, 2);
+	cl_assert_le_i(two, 2);
+	cl_assert_le_i_(two, 2, "format");
+	cl_assert_gt_i(two, 1);
+	cl_assert_gt_i_(two, 1, "format");
+	cl_assert_ge_i(two, 2);
+	cl_assert_ge_i(3, two);
+	cl_assert_ge_i_(3, two, "format");
+
+	cl_assert_lt_i(two, 1); /* this one fails */
+}
+
+void test_combined__compare_i_with_format(void)
+{
+	int two = 2;
+	cl_assert_lt_i_(two, 1, "foo: %s", "bar");
+}
+
+void test_combined__compare_u(void)
+{
+	unsigned one = 1, two = 2;
+
+	cl_assert_equal_u(one, 1);
+	cl_assert_equal_u_(one, 1, "format");
+	cl_assert_lt_u(one, 2);
+	cl_assert_lt_u_(one, 2, "format");
+	cl_assert_le_u(one, 2);
+	cl_assert_le_u(two, 2);
+	cl_assert_le_u_(two, 2, "format");
+	cl_assert_gt_u(two, 1);
+	cl_assert_gt_u_(two, 1, "format");
+	cl_assert_ge_u(two, 2);
+	cl_assert_ge_u(3, two);
+	cl_assert_ge_u_(3, two, "format");
+
+	cl_assert_lt_u(two, 1); /* this one fails */
+}
+
+void test_combined__compare_u_with_format(void)
+{
+	unsigned two = 2;
+	cl_assert_lt_u_(two, 1, "foo: %s", "bar");
+}
diff --git a/t/unit-tests/unit-test.h b/t/unit-tests/unit-test.h
index 39a0b72a05..5398b44917 100644
--- a/t/unit-tests/unit-test.h
+++ b/t/unit-tests/unit-test.h
@@ -7,9 +7,3 @@
 #else
 # include GIT_CLAR_DECLS_H
 #endif
-
-#define cl_failf(fmt, ...) do { \
-	char desc[4096]; \
-	snprintf(desc, sizeof(desc), fmt, __VA_ARGS__); \
-	clar__fail(__FILE__, __func__, __LINE__, "Test failed.", desc, 1); \
-} while (0)

-- 
2.52.0.239.gd5f0c6e74e.dirty

