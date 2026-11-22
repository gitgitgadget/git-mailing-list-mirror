Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795359094;
	b=jpt1TthAuN61+G/PTYJVOABHc/XgWdex8wNWdQty0rTyotEt1Ycoai8JKESIFtKDy3Ag
	 1uiwGUbOR5CkQTxweoIv6wVUbijX+Wuntnu3PslSe3ZYNbrW5pnTVpcnZo8z/cgdvLov0
	 /s/7+QGQRRhsOuAl4GgBCzMd10fuD7Kz0a5yp50lwhvzWZ7+3HhBgFUyOGRZA/XTTfic+
	 s2tAOC6RvVBA8WPjnmx491hdhp0u3GOK3nbCMOG4FF+PBp935kYV8FiwuNc9Nk7mvCuzf
	 l5TO0QfdAXowh9KbzuLQ+xZpDVCzJowUE8Uiag+mtTMq998eyHoSSCsV8ci13K6zfiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795359094;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=csBWu0AI5li1u1BA+lcVogKOzS41Eeoc0zntou9wDyA=;
	b=FRi8Qd9jzC4IDYHQ466rSPP1EOROsdij5q5gVJSz7FTd7XECFZuxNFjQeT1v3c+QDWs/
	 Wy3mNyX4njYSD/rmFfOdiI1Sm9ioJtHtiZZvWpKhaP9mzwvfIZeA4vyNzSmtru5E5lMc1
	 lxhR8TKOBgsEIZg7186vZcpEI0QjVgRISAKDBce7OEetJPGsqj0zvKKI6BNtTkxiuCkiz
	 kXUeuiNlYfYcjgn9BFs6y5p/9h2hGQ9lnxh+PuDagCRVfVSESgV0lleMqN3zXPtvJiFSP
	 lT4JAYUby3k/fEFxrYCnUed58E7135zFHVOwgIXe0K9hZPtLZJTFzvxcDZ6VE54KNyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=psrgQpg5;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE868606A682
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE868606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=psrgQpg5
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AMEpQ7r2232929
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 22 Nov 2026 15:51:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795359088; bh=csBWu0AI5li1u1BA+lcVogKOzS41Eeoc0zntou9wDyA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=psrgQpg5j698w2fA/f/zDNctUtN+NxZx+65Gc0qHilaJ6nnEA0evGoxvEsgg+90Gv
	 mEqDKHEX8pqgQwR6JqooRIpbf1oIVrGqg5buQfCw3Tv5hdnVevgC12/TQdgAlAom4L
	 N9ksD3/m3lCuOcAJRiHlxVcd65ipKzNA7bkvMm+c=
From: Dirk Gouders <dirk@gouders.net>
Date: Sun, 22 Nov 2026 15:51:24 +0100
Subject: [PATCH v5 1/4] utf8: add display_mode_esc_sequence_len_counted()
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261122-master-v5-1-313bd1bb3c45@gouders.net>
References: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
In-Reply-To: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
To: git@vger.kernel.org
Cc: "Junio C Hamano <gitster@pobox.com>, Andy Koppe" <andy.koppe@gmail.com>,
        Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9263; i=dirk@gouders.net;
 h=from:subject:message-id; bh=x+F6CcXjxrpLp/lBZhAhwZC575exYdvzahhuaom1KmU=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLKZGfPDs4s3/bK09U+6dfDzvRvv2W2Y9ex7G5aZvJgXt
 c343jzpTsYJLAyMXAxVYoosSycV2aWprHhR9k01E2YQKxPIFGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIwcIHL8DBrpBekO6fmlKalFxXp5qSWOppZG5kbGrmZmRiaOFq4W5mZuZkamZpaOJqbmro4
 uZsbmxqYmjpbODFycAjDrLJ6x/2avnn7i4K5Hzwz//jq0e5WNuXzdjHVKzHE28vlXVaqZDjbGfo
 qcfOc1878deyXNS9/mXTlt/nRartNcn029Kn65p+Y0PFe9F5bbZ5Uo3jrXefEBZfumN7aWnpcyT
 ywt6mwx25cvcf7K7YrJmlE+iRPfnbnD7ejmttDMIod16wKN+UyJzBG743lsI9asvcOmYmvx2e37
 1dmPxWIP7V388WvVdyv/6muuwQzv5K/JyHZdcJ19a06uruuaOSsLJucveueZueing/Qmx2yjC4U
 MbvZZB6SZr7yd16KqeHf22veTFhiuWpP6YOoGpxmXUq5oVMR+zLmiVcG1akL5to2Tdv8VeHXiZ4
 JXkOANoe+b9JkA
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

From: Junio C Hamano <gitster@pobox.com>

display_mode_esc_sequence_len() scans for an ANSI display mode
escape sequence (e.g. "ESC [ 1 ; 31 m") at the start of a string,
relying on NUL termination to stop.  Some callers, however, work on
a counted buffer: utf8_strnwidth() takes <string, len> and must not
scan past it, while strbuf_utf8_replace() and
strbuf_add_wrapped_text() know (or can cheaply learn) the end.

Add display_mode_esc_sequence_len_counted() taking <ptr, len>,
which never reads at or beyond ptr[len], and make
display_mode_esc_sequence_len() a thin wrapper for NUL-terminated
strings.

Use the counted variant in utf8_strnwidth() for correctness, and in
strbuf_utf8_replace() and strbuf_add_wrapped_text() (computing the
end once upfront in the latter) to avoid measuring the remaining
text in each iteration.

[Dirk Gouders: allow SIZE_MAX to be passed for NUL-terminated strings
 to avoid O(n²) degradation as suggested by Andy Koppe.  Also add
 tests for these functions.]

Helped-by: Andy Koppe <andy.koppe@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Makefile                   |  1 +
 t/meson.build              |  1 +
 t/unit-tests/u-utf8-ansi.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 utf8.c                     | 39 +++++++++++++++------
 utf8.h                     |  1 +
 5 files changed, 117 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 4c84eea6e2..db8f7f5c60 100644
--- a/Makefile
+++ b/Makefile
@@ -1563,6 +1563,7 @@ CLAR_TEST_SUITES += u-string-list
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_SUITES += u-trailer
 CLAR_TEST_SUITES += u-urlmatch-normalization
+CLAR_TEST_SUITES += u-utf8-ansi
 CLAR_TEST_SUITES += u-utf8-width
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
diff --git a/t/meson.build b/t/meson.build
index 1cf1d95f70..ae7479a98e 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -26,6 +26,7 @@ clar_test_suites = [
   'unit-tests/u-strvec.c',
   'unit-tests/u-trailer.c',
   'unit-tests/u-urlmatch-normalization.c',
+  'unit-tests/u-utf8-ansi.c',
   'unit-tests/u-utf8-width.c',
 ]
 
diff --git a/t/unit-tests/u-utf8-ansi.c b/t/unit-tests/u-utf8-ansi.c
new file mode 100644
index 0000000000..d969737000
--- /dev/null
+++ b/t/unit-tests/u-utf8-ansi.c
@@ -0,0 +1,86 @@
+#include "unit-test.h"
+#include "utf8.h"
+#include "strbuf.h"
+
+/*
+ * Test display_mode_esc_sequence_len_counted() for NUL-terminated strings.
+ */
+void test_utf8_ansi__sgr_len_counted(void)
+{
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("", SIZE_MAX));
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033", SIZE_MAX));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033[", SIZE_MAX));
+	cl_assert_equal_i(3, display_mode_esc_sequence_len_counted("\033[m", SIZE_MAX));
+	cl_assert_equal_i(3, display_mode_esc_sequence_len_counted("\033[ma", SIZE_MAX));
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033[3", SIZE_MAX));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033[31", SIZE_MAX));
+	cl_assert_equal_i(5, display_mode_esc_sequence_len_counted("\033[31m", SIZE_MAX));
+	cl_assert_equal_i(5, display_mode_esc_sequence_len_counted("\033[31ma", SIZE_MAX));
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033[31;", SIZE_MAX));
+	cl_assert_equal_i(6, display_mode_esc_sequence_len_counted("\033[31;m", SIZE_MAX));
+	cl_assert_equal_i(6, display_mode_esc_sequence_len_counted("\033[31;ma", SIZE_MAX));
+
+	cl_assert_equal_i(7, display_mode_esc_sequence_len_counted("\033[31;0m", SIZE_MAX));
+	cl_assert_equal_i(7, display_mode_esc_sequence_len_counted("\033[31;0ma", SIZE_MAX));
+}
+
+/*
+ * Same test as above for the wrapper display_mode_esc_sequence_len().
+ */
+void test_utf8_ansi__sgr_len(void)
+{
+	cl_assert_equal_i(0, display_mode_esc_sequence_len(""));
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033"));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033["));
+	cl_assert_equal_i(3, display_mode_esc_sequence_len("\033[m"));
+	cl_assert_equal_i(3, display_mode_esc_sequence_len("\033[ma"));
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033[3"));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033[31"));
+	cl_assert_equal_i(5, display_mode_esc_sequence_len("\033[31m"));
+	cl_assert_equal_i(5, display_mode_esc_sequence_len("\033[31ma"));
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033[31;"));
+	cl_assert_equal_i(6, display_mode_esc_sequence_len("\033[31;m"));
+	cl_assert_equal_i(6, display_mode_esc_sequence_len("\033[31;ma"));
+
+	cl_assert_equal_i(7, display_mode_esc_sequence_len("\033[31;0m"));
+	cl_assert_equal_i(7, display_mode_esc_sequence_len("\033[31;0ma"));
+}
+
+/*
+ * Test display_mode_esc_sequence_len_counted() with end pointers.
+ */
+void test_utf8_ansi__sgr_len_limited(void)
+{
+	/* sequences followed by one non-sequence character */
+	char sgr_1[] = "\033[ma";
+	char sgr_2[] = "\033[31ma";
+	char sgr_3[] = "\033[31;ma";
+	char sgr_4[] = "\033[31;0ma";
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted(sgr_1, 0));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted(sgr_1, 1));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted(sgr_1, 2));
+	cl_assert_equal_i(3, display_mode_esc_sequence_len_counted(sgr_1, 3));
+	cl_assert_equal_i(3, display_mode_esc_sequence_len_counted(sgr_1, 4));
+
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted(sgr_2, 3));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted(sgr_2, 4));
+	cl_assert_equal_i(5, display_mode_esc_sequence_len_counted(sgr_2, 5));
+	cl_assert_equal_i(5, display_mode_esc_sequence_len_counted(sgr_2, 6));
+
+	cl_assert_equal_i(6, display_mode_esc_sequence_len_counted(sgr_3,
+								   sizeof(sgr_3) - 2));
+	cl_assert_equal_i(6, display_mode_esc_sequence_len_counted(sgr_3,
+								   sizeof(sgr_3) - 1));
+
+	cl_assert_equal_i(7, display_mode_esc_sequence_len_counted(sgr_4,
+								   sizeof(sgr_4) - 2));
+	cl_assert_equal_i(7, display_mode_esc_sequence_len_counted(sgr_4,
+								   sizeof(sgr_4) - 1));
+}
diff --git a/utf8.c b/utf8.c
index 96460cc414..503edb8edc 100644
--- a/utf8.c
+++ b/utf8.c
@@ -16,18 +16,31 @@ struct interval {
 	ucs_char_t last;
 };
 
-size_t display_mode_esc_sequence_len(const char *s)
+/*
+ * Return the length of the ANSI display mode escape sequence (e.g.,
+ * "\033[1;31m") that appears at the beginning of the "len" bytes
+ * of string "s", or 0 if the bytes do not begin with a complete
+ * such sequence.  Never looks at s[len] or beyond.
+ */
+size_t display_mode_esc_sequence_len_counted(const char *s, size_t len)
 {
-	const char *p = s;
-	if (*p++ != '\033')
+	size_t i = 0;
+
+	if (i >= len || s[i++] != '\033')
 		return 0;
-	if (*p++ != '[')
+	if (i >= len || s[i++] != '[')
 		return 0;
-	while (isdigit(*p) || *p == ';')
-		p++;
-	if (*p++ != 'm')
+	while (i < len && (isdigit(s[i]) || s[i] == ';'))
+		i++;
+	if (i >= len || s[i++] != 'm')
 		return 0;
-	return p - s;
+	return i;
+}
+
+/* Same as above, but for a NUL-terminated string "s". */
+size_t display_mode_esc_sequence_len(const char *s)
+{
+	return display_mode_esc_sequence_len_counted(s, SIZE_MAX);
 }
 
 /* auxiliary function for binary search in interval table */
@@ -218,7 +231,8 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 		size_t skip;
 
 		while (skip_ansi &&
-		       (skip = display_mode_esc_sequence_len(string)) != 0)
+		       (skip = display_mode_esc_sequence_len_counted(string,
+							orig + len - string)) != 0)
 			string += skip;
 
 		glyph_width = utf8_width(&string, NULL);
@@ -279,6 +293,7 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 {
 	int indent, w, assume_utf8 = 1;
 	const char *bol, *space, *start = text;
+	const char *end = text + strlen(text);
 	size_t orig_len = buf->len;
 
 	if (width <= 0) {
@@ -299,7 +314,8 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 		char c;
 		size_t skip;
 
-		while ((skip = display_mode_esc_sequence_len(text)))
+		while ((skip = display_mode_esc_sequence_len_counted(text,
+								end - text)))
 			text += skip;
 
 		c = *text;
@@ -378,7 +394,8 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
 		int glyph_width;
 		size_t n;
 
-		while ((n = display_mode_esc_sequence_len(src))) {
+		while ((n = display_mode_esc_sequence_len_counted(src,
+								  end - src))) {
 			strbuf_add(&dst, src, n);
 			src += n;
 		}
diff --git a/utf8.h b/utf8.h
index cf8ecb0f21..57ca2ab270 100644
--- a/utf8.h
+++ b/utf8.h
@@ -6,6 +6,7 @@ struct strbuf;
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
 size_t display_mode_esc_sequence_len(const char *s);
+size_t display_mode_esc_sequence_len_counted(const char *s, size_t len);
 int utf8_width(const char **start, size_t *remainder_p);
 int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
 int utf8_strwidth(const char *string);

-- 
2.55.0

