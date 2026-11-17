Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934244;
	b=2D4sCZbNDbSyP0YTduDwFiyZ60v0x+D6Y7MufruW5wjCLpZjMH+rWEkBQQLmKdj0pR5S
	 D4/fHrQr6gaF3izJidOs3WXQzZqUQmONltC3Vmbkl0qOXwZm2OEIRgb7j/4mSQncF5wAq
	 KVy07sxB4qoFFvWkfpFGBZ8HfgrNuFP9Laxve6TzlTRXkAGxrR4+d+ezTSVvqsu5CCw6p
	 Xi+kqXBMBah5oaI/7m0FrwnH8HVyFrcvJS7EA5v3mqaFLxLaosya5UubAYhCf7V9tRFXx
	 E25SF8tSy6usKPWCrrc585LdoTkIKDqjYDxBEcsrfz7C4N5wKfq8kBT+ix9HSiBxPsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934244;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type;
	bh=yjnq/9unDPct0t4+U3Eu0DfO/3+mwwoB+h/PUmiEqMo=;
	b=boPnoY/NJcvFTfz+GxhA43brtNKapRmPq4AvvTk8gnWx1qiitf2xCkIwhLf2s8o7lzuh
	 3+IKnPl+prbE/VHd6tGHs1aFbaKJEotJT4vhiWUZUYwsoa0fNkEoV1n9B00DdtIOInlBU
	 rnrd40ZVMYMgkHpxjd79nVj4/dmefPtk8XY+rj1I9po1uGwLGcKSw+afSsu5TZrvJGlt4
	 nFNs0IgMQneoUi1aYlxcDHeQOOO7BloNb3ioad8PwACe4tOhZtA3NiA7Mkv+w/G3Kh0b+
	 KPADR3uRfV7tySXhHY2yRd9acEdtmCqHdkceXB3u1wnVnP5vYlDnyCNyP+xRSsro9gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LNmxa02p;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CGnT6c+Y;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330DF606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 16:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 330DF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LNmxa02p;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CGnT6c+Y
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6833E1D00259
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 11:50:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 17 Nov 2026 11:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1794934243; x=1795020643; bh=yjnq/9unDPct0t4+U3Eu0DfO/3+mwwoB
	+h/PUmiEqMo=; b=LNmxa02pkK7mPoT6Nr3+kiDAABBO5LzfzAzx71HRQUoAjOOd
	NohWS4c/CjnwhvL6u52CUNH1ntMbBrdf1faEWZKXIO+bE8NY9HrgqkHWtmJe0R3c
	KTz1yPXWa31mkSQ56hb1h1Dh+LGfSYW/eLepusNjIG+s+PF5jLRiN1r0VhRHctzq
	OQauYT3JzKtw9H0wJv21ss6V8WJeCLB34D7T5qok3RivWTVzNTa0riEdycB9E2o+
	Gk3Ex1C3pyxu/q5dwl5Sdcf3SHibUAYHuCwbLotdTKqjjHTvn7Fjh3jcRZ/WFBLa
	ok8YyxkyP3Zl1nIrncQi6l55X+t2TwhTdGdkwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794934243; x=
	1795020643; bh=yjnq/9unDPct0t4+U3Eu0DfO/3+mwwoB+h/PUmiEqMo=; b=C
	GnT6c+YHcL68S7z1WYc2H7xm9NEQ/xgWGO6RpWbYIfc7TtzjE0lEapqQPcft3mOK
	V92v7Kv38mKKNb4+onRfgLxX/asJeAVihbMNrY0+IqQoKPzLzACf6LXTYLS2UVRY
	6K5TDkzdR0fAIoUfuNyltV4zmoSZG/q5fKuZRoLPtQPkF1d1PY6Yk4/Gf42uGH3Q
	FwRROX8kHlb8/odWB7E4N9q43vD0pwUCG1WAHDyy58mypQucsSmoRnddnx/rbFI2
	89wSe6YWHTyjrYWlOZYcZGLgRblZHyd4E5xw36Pbvyx4/0PqPS3iTd6OohVK0GQr
	W2GFPDS+hjxNM8SWNPtTQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794934243; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:U4QanVlUqmTxKGUm8PClsJjLHrR/4qPa9ptVuo0rpcbI5m3
	Z/c949+sAiwWchKbs+QMFLzM+XPvUHIzEc3BWd7aU6UANau9g2Z9nJxUitq18VOo
	Zx5l0IsAKW/XOwT+1AG1eLsS1sjpI1Ch3wIzK6tF+/RiU8f08kOerI/sEukC4gaP
	7TdxqU7VnLGddS68wKOzgUj7mfHWgW3U67y1rqK3cYjyUF4Z2TfA0lTW81y9aM24
	bemeBHyYcXWHfsf5llYpClfrOZU9Fi5MJ4l+ZQ5i8L2sx4sQVwc21s+EbEJGbLf/
	ZT0Rw89ksQbOyXnNdcVLu7QhwlIBqmI4KBAp7Jw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-type,date,feedback-id,from,message-id,
	mime-version,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Xsk3/JuakMYRrgmPiUQQpVALhD51CpnljjTaF4o4VN0=:gj/xN/S7MYDm/v5qNNMk/4DuOpACtvAg4Wyo1kTEje4=;
X-ME-Sender: <xms:44X8avovmtKg5C5J8iWoXlheQaQx25syVrbiWlI8Nv_GlEjRiyb2KQ>
    <xme:44X8ahEBC-unL9aWWORbBX6Zb8LywNEZv6H09b1_jZcix4yeq_zSv9nH7lp-j_yKM
    yS5MhJrzayP0nDAVcyJki-KsRq8qY6MczTeAV14AhJxOrOcZjIOlRg>
X-ME-Received: <xmr:44X8apnCzuTlDOStyn8S2Jh5MIv4Sa273W5V1teZFWiXr4WD_x3dWTHsVLygUCmBnELGnVgFkahC8VZdTObBsU9YiE3lOS_btGtE>
X-ME-Proxy-Cause: dmFkZTF49Du4HQNHuDpJCme7JMBf3EXeQQ+LSw7JKBMhKu4siT/6xlk10qWJgf5MPhTonE
    SJnNogJ409CfU/lBjIgtGPPv++jk+jkNPzGgcH1n9ACRygwCA7tdPkgsICPgisL84iXWW2
    /ByHCio+nsODKJzk/TnmYRh+90qNOXsNEa8af9AXBIBeD2t4H62xf1nTH8Hl4JatnW33Zf
    MaP0hyy4L8MYg5DET2WhCPxPizYkm0OIEL9ri4pa+KiYWGrGjdO7p0F+/8esl0TCTtjDv/
    sElWwNjzwpOD60x0F3Bsw63aKdqwGNzhUkYfvZ1aRf83Khl9KdvdQPeOy0mrf14+uyPuqh
    yOgnnLkO9eWGAn6lB9cgaJjQlezFGnJyNVoPz2wC3EkPdDlEP2SxIH86HXa+JvuJaWc6ai
    O3ctRrcAhdcG6m/2vHtBvR9PHVzX4zUhVzWVZxbhUHBfKPUHVZGQc18vNGOgLBxDhXDG1O
    1zx2bL2hjTOQY1l1gg9HUNkmcvpR4f1Hw4g+ivm37TtiZDhFiNgPtYwO0avKhqULvNlk4H
    2RBwlezXCoSJUonn5AMAzSXuWMTB9wLJuHVs0bSZri15XGhz43zLyYYBPJDEeSH/vpi/v9
    Mtvvay/w4vxp6nQHPqU+r71JCs/x6LPi8r8Zr428wfSDuzocuebhv21teVHQ
X-ME-Proxy: <xmx:44X8asnUtCqVWPfDJKDeAIknq7vSfMA5-FWpdhycrWukqHsrl1DnTg>
    <xmx:44X8aiur2IcWGqmyd9Pa1Qb91rDkfFGW9ErNmg9SEjoo9FLWckxxJg>
    <xmx:44X8ankEP6FHatXfITb1-slX_M2P6ASieCOpDVP57xYSwyovE9rfZA>
    <xmx:44X8alunOMHoHYAnF4Vomf4rLh5wXAR62qMQuNK-cHPOruEE1N9mag>
    <xmx:44X8apuewqXGjEKe7f-tXcnhqHWDPrOJTjOy3a8sJ2pCvDoKnXQI3Npw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 11:50:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>
Subject: [PATCH] utf8: make display_mode_esc_sequence_len() take a length
Date: Tue, 17 Nov 2026 08:50:41 -0800
Message-ID: <xmqqmrr7fllq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

display_mode_esc_sequence_len() scans for an ANSI display mode
escape sequence (e.g. "ESC [ 1 ; 31 m"), relying on NUL termination
to stop.  Some callers, however, use a counted <ptr, len> buffer or
need to stop at a specific position.

Teach it to take a buffer length and never read at or beyond
ptr[len], returning the length of a complete sequence at the start
or 0 otherwise.

Update the callers to pass the remaining byte count.  For
strbuf_add_wrapped_text(), which takes a NUL-terminated string,
compute the end once upfront instead of calling strlen() each time.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Copy of https://lore.kernel.org/git/xmqqse0zfn2n.fsf@gitster.g/
   with a proposed commit log message.

 pretty.c |  3 ++-
 utf8.c   | 27 ++++++++++++++++++---------
 utf8.h   |  2 +-
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/pretty.c b/pretty.c
index 0bc8ad8a9a..a20fd61909 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1834,7 +1834,8 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 			while (p > sb->buf && ch - p < 10 && *p != '\033')
 				p--;
 			if (*p != '\033' ||
-			    ch + 1 - p != display_mode_esc_sequence_len(p))
+			    ch + 1 - p != display_mode_esc_sequence_len(p,
+								ch + 1 - p))
 				break;
 			/*
 			 * got a good ansi sequence, put it back to
diff --git a/utf8.c b/utf8.c
index 96460cc414..544c5329f3 100644
--- a/utf8.c
+++ b/utf8.c
@@ -16,16 +16,23 @@ struct interval {
 	ucs_char_t last;
 };
 
-size_t display_mode_esc_sequence_len(const char *s)
+/*
+ * Return the length of the ANSI display mode escape sequence (e.g.,
+ * "\033[1;31m") that appears at the beginning of the "len" bytes
+ * of string "s", or 0 if the bytes do not begin with a complete
+ * such sequence.  Never looks at s[len] or beyond.
+ */
+size_t display_mode_esc_sequence_len(const char *s, size_t len)
 {
-	const char *p = s;
-	if (*p++ != '\033')
+	const char *p = s, *end = s + len;
+
+	if (end <= p || *p++ != '\033')
 		return 0;
-	if (*p++ != '[')
+	if (end <= p || *p++ != '[')
 		return 0;
-	while (isdigit(*p) || *p == ';')
+	while (p < end && (isdigit(*p) || *p == ';'))
 		p++;
-	if (*p++ != 'm')
+	if (end <= p || *p++ != 'm')
 		return 0;
 	return p - s;
 }
@@ -218,7 +225,8 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 		size_t skip;
 
 		while (skip_ansi &&
-		       (skip = display_mode_esc_sequence_len(string)) != 0)
+		       (skip = display_mode_esc_sequence_len(string,
+							     orig + len - string)) != 0)
 			string += skip;
 
 		glyph_width = utf8_width(&string, NULL);
@@ -279,6 +287,7 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 {
 	int indent, w, assume_utf8 = 1;
 	const char *bol, *space, *start = text;
+	const char *end = text + strlen(text);
 	size_t orig_len = buf->len;
 
 	if (width <= 0) {
@@ -299,7 +308,7 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 		char c;
 		size_t skip;
 
-		while ((skip = display_mode_esc_sequence_len(text)))
+		while ((skip = display_mode_esc_sequence_len(text, end - text)))
 			text += skip;
 
 		c = *text;
@@ -378,7 +387,7 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
 		int glyph_width;
 		size_t n;
 
-		while ((n = display_mode_esc_sequence_len(src))) {
+		while ((n = display_mode_esc_sequence_len(src, end - src))) {
 			strbuf_add(&dst, src, n);
 			src += n;
 		}
diff --git a/utf8.h b/utf8.h
index cf8ecb0f21..fb2227a9e2 100644
--- a/utf8.h
+++ b/utf8.h
@@ -5,7 +5,7 @@ struct strbuf;
 
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
-size_t display_mode_esc_sequence_len(const char *s);
+size_t display_mode_esc_sequence_len(const char *s, size_t len);
 int utf8_width(const char **start, size_t *remainder_p);
 int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
 int utf8_strwidth(const char *string);
-- 
2.56.1-740-gf38658f3d0

