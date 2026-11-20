Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187501;
	b=LES1FTsZEdFxGc4OZexKgfQ9YfRlQiSar70fWtJ6l8gDD1y4g03FzE46wkCBg8A27L6u
	 o+en5eeKTALp6aa3Un3gxDjOYPDMrpVxcoJVPwKZW0/lQZ/kRQtJ7n4C6HvVz0jiA5Xqy
	 m/R9bq4UsdrZtLiEDOM12roXNzabx8ZpgVy0pHYYMRycf3rixHYooF6pHvPZ1+fnnPd60
	 Ll5P8SLWLK2byZ1E6COBbLsVW0N0XbiA+KEj+D7nVhECyZGBmZXdA96CbS0oGgUSjavJC
	 +hdNLh7SUiIor+xfI7USmeQekPa99SFKDDZV492QDT2HX3UUmsjHpB9bo/GwTC+vZ2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187501;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=j4sxIOvMu+q16IHN7AJO+PVupexDDytY9LOBwjatk3o=;
	b=zZjP96Ko2Np/T6cDds31+aVYmS0lYg/yCJfv42AbG8EReE/1ASdLvjAZGDMpbPKKN9Ch
	 b+eZ80ioMSiuosTu2YO6ZKzpU3zmtAj9dhvZ3Nb0hrBTO+LNvQ09C7JVVe6IZKlNtvUDw
	 tsIRMIVjqoxOrtDaajQPUUYi4WTaGxOr/oVjG2TqMQXYms9CEQG8Vfvi4Y6IldKbHSTHt
	 DifwmnA0Yf58mp/+ZoVy9dh1L2ih1Tq3bDtu7Kck7mtQp+lFEm64I6JpYbSzDn1kVvAfZ
	 9ukZhgOzEVwUDLRjQPby4jhHr97BMLk9t+ZZk3nKle0DrixCI1onXmU1dn/fn06tmvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=YE9L57w1;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB260A2600
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 15:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFDB260A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=YE9L57w1
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AKFBTTi2082197
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 20 Nov 2026 16:11:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795187496; bh=j4sxIOvMu+q16IHN7AJO+PVupexDDytY9LOBwjatk3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YE9L57w1rW0rYzAY6vPAyjZez/sCHAX/QLKz3LXB0W/jwzga71GokcmoTDrxdkr0C
	 T03KtyXBiFgF/bXUx8ThJhWZMbZFnRAB1W4ywfSXN2GNDnAGY2NP6t7J2yjT3D/qaV
	 x6yRAB34MaNKi/KZM0kBgQL7YC35wQtGL3utud2c=
From: Dirk Gouders <dirk@gouders.net>
Date: Fri, 20 Nov 2026 16:11:28 +0100
Subject: [PATCH v4 5/5] utf8: introduce display_mode_esc_sequence_len_all()
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-master-v4-5-5ff523db7285@gouders.net>
References: <20261120-master-v4-0-5ff523db7285@gouders.net>
In-Reply-To: <20261120-master-v4-0-5ff523db7285@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4257; i=dirk@gouders.net;
 h=from:subject:message-id; bh=RjG+fnepNNTE4w00aY4Af77Qa72+8JT9B1/UMs+CGOQ=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLIZkpWmr08y57ROeBnwdjsz45XcBJYLoc99Vrvaei3JD
 lPcGu7XyTiBhYGRi6FKTJFl6aQiuzSVFS/KvqlmwgxiZQKZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjpEDRI6fQSO9IN0hPb80JbWoWC8vtcTR1NLI3MjY1czMyMTRwtXC3MzNzMjUzNLRxNTc1dH
 FzNjc2NTE0dKZgYtTAGbdm0McDCtXnIg4mvzZtCd2acqB34FfHpj6PXG+2duz+tr3ewWtu63//b
 r1PUnp49zF73K9vJvfvlIrTCmvfh20afrLmGinqcUu660WXC7b86sxxHeB8bXpPK8X/PWUNrDOU
 YyK8GBm5rLX3N2hEHS6e2OE5rU9K6wErb/xWj077py66ceKGgOHp96Ba8RevXz6p9VJzGw9U2Ty
 1418qhwX7h65+8jG/OC16BRTH+N1AYbzW6qTmL8o5Gw40N7dUP5V9+HXL9fFJ4e93m4zzzmwQOZ
 iAYuH8LwlMf+PVt+cLdRyuvvrqmS9youfZrGfqnzy90RJoJGxyLl9llyyV7YnPAu40jA7rk9JrI
 b5xKL4xyvuWAIA
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

Most users of display_mode_esc_sequence_len() need to know the length
of *all* leading ANSI display mode escape sequences and use
display_mode_esc_sequence_len() in a loop.

Introduce display_mode_esc_sequence_len_all() for convenience and
to reduce the risk of bugs.

Add tests for this function as well.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 t/unit-tests/u-utf8-ansi.c | 26 ++++++++++++++++++++++++++
 utf8.c                     | 34 +++++++++++++++++++++++++---------
 utf8.h                     |  1 +
 3 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/t/unit-tests/u-utf8-ansi.c b/t/unit-tests/u-utf8-ansi.c
index cb75c8612b..909643d07d 100644
--- a/t/unit-tests/u-utf8-ansi.c
+++ b/t/unit-tests/u-utf8-ansi.c
@@ -2,6 +2,32 @@
 #include "utf8.h"
 #include "strbuf.h"
 
+/*
+ * Test the greedy function display_mode_esc_sequence_len_all().
+ */
+void test_utf8_ansi__sgr_len_greedy(void)
+{
+	char *s1 = (char *)"no ESC sequence";
+	char *s2 = (char *)"\033[m";
+	char *s3 = (char *)"\033[0;31m";
+	char *s4 = (char *)"\033[0m\033[31m";
+
+	/* no sequences */
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_all("", ""));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_all(s1, s1 + 5));
+
+	/* single sequences */
+	cl_assert_equal_i(3, display_mode_esc_sequence_len_all(s2, s2 + 3));
+	cl_assert_equal_i(7, display_mode_esc_sequence_len_all(s3, s3 + 7));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_all(s3, s3 + 3));
+
+	/* multiple sequences */
+	cl_assert_equal_i(4, display_mode_esc_sequence_len_all(s4, s4 + 4));
+	cl_assert_equal_i(9, display_mode_esc_sequence_len_all(s4, s4 + 9));
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_all(s4, s4 + 3));
+	cl_assert_equal_i(4, display_mode_esc_sequence_len_all(s4, s4 + 8));
+}
+
 /*
  * Test display_mode_esc_sequence_len() for NUL terminated strings.
  */
diff --git a/utf8.c b/utf8.c
index 291f34db7e..9478985cbb 100644
--- a/utf8.c
+++ b/utf8.c
@@ -39,6 +39,26 @@ size_t display_mode_esc_sequence_len(const char *start, const char *end)
 	return p - start;
 }
 
+/*
+ * Count the lenght of all leading ANSI display mode escape sequences that
+ * are a prefix of the string at start up to end.
+ */
+size_t display_mode_esc_sequence_len_all(const char *start, const char *end)
+{
+	size_t seq_len = 0;
+
+	while (start + seq_len < end) {
+		size_t count = display_mode_esc_sequence_len(start + seq_len, end);
+
+		if (!count)
+			break;
+
+		seq_len += count;
+	}
+
+	return seq_len;
+}
+
 /* auxiliary function for binary search in interval table */
 static int bisearch(ucs_char_t ucs, const struct interval *table, int max)
 {
@@ -227,8 +247,7 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 		size_t remainder;
 
 		if (skip_ansi) {
-			while ((skip = display_mode_esc_sequence_len(string, end)))
-				string += skip;
+			string += display_mode_esc_sequence_len_all(string, end);
 
 			if (string >= end)
 				break;
@@ -313,10 +332,8 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 
 	for (;;) {
 		char c;
-		size_t skip;
 
-		while ((skip = display_mode_esc_sequence_len(text, end)))
-			text += skip;
+		text += display_mode_esc_sequence_len_all(text, end);
 
 		c = *text;
 		if (!c || isspace(c)) {
@@ -394,10 +411,9 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
 		int glyph_width;
 		size_t n;
 
-		while ((n = display_mode_esc_sequence_len(src, end))) {
-			strbuf_add(&dst, src, n);
-			src += n;
-		}
+		n = display_mode_esc_sequence_len_all(src, end);
+		strbuf_add(&dst, src, n);
+		src += n;
 
 		if (src >= end)
 			break;
diff --git a/utf8.h b/utf8.h
index 7eb7bf042a..fdde5af782 100644
--- a/utf8.h
+++ b/utf8.h
@@ -6,6 +6,7 @@ struct strbuf;
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
 size_t display_mode_esc_sequence_len(const char *start, const char *end);
+size_t display_mode_esc_sequence_len_all(const char *start, const char *end);
 int utf8_width(const char **start, size_t *remainder_p);
 int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
 int utf8_strwidth(const char *string);

-- 
2.55.0

