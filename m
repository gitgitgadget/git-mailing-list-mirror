Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945982;
	b=uKOJPftWGz9vbNQwoLLK5Wqp+gwd/8WjLeDSfuwqy0dLJFP/VtVsmzIjzZdVinI2l+bu
	 4LdfnFx+2Mvh0WjiYZcFPekRt7wK1Ap2mELtC5YY7v1/+6LJdlgVM8YboS93CKdTmUIpz
	 eCnBiz8KEmmLK04GGj2ZAudapQvsQzsxZlKi9ll/7lHZdNJJiBTWYKJ1r/BiohIFWqx/n
	 J1i1hjRg6i27cFq4zLIfRuIdKwFSVF0AJIBLXTdkjRxBzXgLwEJJUw8dBAdjx5ziYlHso
	 D7TzA8kwImTKbtkQ0Rlo2LL0QX1V4WsQEtMtEycujXo6nJNzuK04ss2rtpkG0Wk+joQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945982;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=UPWSReX2Tt8Cdw2lEFlmDnm9milvPdWDCebkqbAi4Ls=;
	b=onAadd2e4daV5QOg8hDuxH0C7LlucrzUEMWFo+/yq9rfoidOnCr1HGqt5jAQHgXyj6MX
	 5KKs5+7mAkSDSVzc5QpFAUF9/XVvcGn9gtTOV5dRoGpcemHtahZ3aZVRzzAJlwz441p46
	 Ddrc6C4oDHwb/zKHjpiO1fAD8u7vSDAfhtJWu7ZHDSUskjpiCSLdeLvj0gBN7UHF7cZMy
	 3o1/Ys+OmkqB1sMMaIF+Vd7H61tjJhLTU2uh3boHNlUnrkc1TArb/I9Zev+9k9PLGzeIT
	 3ecaRr0LFcwJMV5xfXzLgIsSNfE0+O9KhsndxzXmz4aaWAymFd6nP2erwcnxXbL6DKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Tgj6FKrc;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=M4QhbW3X;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFB3606A337
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 20:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FFB3606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Tgj6FKrc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=M4QhbW3X
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 924CD7A01D6
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 15:06:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 17 Nov 2026 15:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794945981; x=1795032381; bh=UPWSReX2Tt
	8Cdw2lEFlmDnm9milvPdWDCebkqbAi4Ls=; b=Tgj6FKrcNH7WAVynJRDJ87NJG0
	Fwh/frHkVu6d9bdgHErP+4AUkUiFrkvgDwBkLXc5thUpzMXoApaoG/7wpeuYQtnO
	gPlFxFxCiUqf2AM/Qo/7UmbsjzNNdGGjtVXsH5oC4hA6whqriliuFOeMri5C+lV2
	pZA7hb6Tu1Wp2ieihlzy8ifcHzRcDxY0WLZzI1XQ0HASVrbDmdHNSjdG+lZ/rKKH
	iMvuxqqoJd1scpmd2mta5h8QPQqrjFImcBL+VwfYnRPf32wD4yhcnNs605iS7dy9
	w575lfe6QKVIM2rYe32yowWQ9HfRpc+xywRFniPkB55NWVafyTgLRm0DEGNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794945981; x=1795032381; bh=UPWSReX2Tt8Cdw2lEFlmDnm9milvPdWDCeb
	kqbAi4Ls=; b=M4QhbW3XAGY3YRINfPeuSLetDiYqOqTl1IfsLsbfl+6pDTqG4WU
	8GeaiB+5NWIAJvIPFRMGg0DL12v8OB+rbpbnWroDC1OfYXMcGXvRuqkYY93kqAqp
	cjEWW+NAWxv3ajS0gSw9m8VokwyPlQJvzX8yPrSLuw7a0XWHgyE7t0zBr8841QlE
	2vl821gpliKm4W8yqx2DIo+FHNZlQtg37Tm1qERNW94/OFQ8dM+iGKXvRRk65NPm
	6CxQa53LWyqAxrsuuk9iTxnjIi4ZUM4G1cGIgXHW6kicRBJmQRvB3OOPvsnCPCji
	6Ds7FGz9wNTa9pPAyJ1323sM84qUbbP9WGQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794945981; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:X01ZjvpdgDwTytVmUWH7+2/M4rJANLZwnknGco0JH4mHmzw
	4Nb1qZdFEXHsXGVsSnhcMfYhC8fQR63KoVU9T/ojpkoFB6pk5ubg8o5OfdgRiIgS
	3IOJ8t2eYehIeFxURGLRG3qDR4DTPiIbr4cb4Kl2IVIQTVzJ+EuCP2C6NyChUQhm
	dUxXQXsj+ggd2xMD3sN0vimqu5hgOq8NNWM0W6hZqg5z7xxj0nNWOcXflUNY8YWt
	jiZF0N61tsXgtRRnAbv/UDMLXpqmLpVmD2De9TeFD6SBK2uEcGcwZbu4QkEjBsDG
	B8eP49mPqaB/U+KjXQ+pQTTHSZ9DSH5oKcmwS8A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zncp7oT+C5yXIgLwfLjUe/627MQCLz5WXLvcjuh0Oow=:v67LEkEytsgKS0IqqASN3rDXbb8j/wDHdgXIcS/bfUs=;
X-ME-Sender: <xms:vbP8ajpSAuCA3M7BlThE0YPJzbTxKA8F5-TED-QIBDxkdA6FIA2hOg>
    <xme:vbP8alEWJ0K00-bSRPUYucKoyLCOb4k2PfzyNXRqgO72HRI2Flx2TWq3PqUvIPdMb
    BR_vjUEOasElb5PCfJFoYarsFuob3pzO5SY1rByu1Zc5KgEJPT6eb8>
X-ME-Received: <xmr:vbP8atlO201xWmMjJRM9xSfb0YmmInd9zqy_nJVQDjxolhf32gAdKb3PeUGy0jFpjwdIzD171EsMrUgWEf3ZVTmOylw3oyV3Q7LT>
X-ME-Proxy-Cause: dmFkZTEpQEaTeZ+mpD+cqIv7npVuVm5BAL+S6a1AzkV2XVtNTmyODxOqhXGLsrBvgsxeT0
    NEKyJseBrFH6PXfVhNoCricUKdrqJzcss8I78TPauqayPVpVYONXBZg7DvhePqh6tCV5jQ
    XUJG+T40trkqk+fdz31wFTIxnsubXxT8vXnjH6ihqy+4Nw/cKH+V7gNMi+5N3zYXaXieoW
    tho5iiOm+96HoneG/v52trrlDpbEpbX+taSvkKsdSW7Xy7OASKa5ATTfU++G3Yid/jPYLN
    9wzNuyXZjnnW0D52YyJ4FefG09eVPRDUfyiG5gsKypdiBDvSioMFWPY/cpyKY9I/qanGmG
    mKOjAnkP88ftpntfdj33cKAn6EX8MQvYGrLce5MBHj80mvzISiQYhXn5bsua3ZO65hfn+g
    nR2FbGJnAGoDgWj5kkM/11uh1fcWVmk517eaGoNfui3sfWDhgz/2XQD5A+uCvCb8ooFl29
    E6BImyX8l9bK7aB8dvOZSb9wSoNl0SR+sLsdmkPxm5t0MmhjqBj2TOFBYQv6uWYXIOxNc8
    enKmh7siLOSO5oX2X3xSHfg7GzfVjiXG3W5uL7dkO9o8XGyMMJV+CSSxCdbTeGwhqzKXeY
    DvR8CHD3Yx8LmjtvRsoSFdTHftS0XphtPffwTHmIebpeUxasr8Nm3c7RayQQ
X-ME-Proxy: <xmx:vbP8agkMDvZrN0EdORMdEksLdOXQ8OpMkyR_I7Fpy3bHJQpHvJX1gQ>
    <xmx:vbP8amuxeLOivlPFzViqQjWDQx61ZXAbWu0yezN53NwoOgP6rHoTiA>
    <xmx:vbP8arkt_zzp18Ndb5atYCd01rjZyGh6C2KBJvzhKq9-zHhqG6X3SQ>
    <xmx:vbP8apu3GT7rgvh3SgCJhLb-I9MpDMhR_2AcnLKeLYSnqedHLCSV1w>
    <xmx:vbP8attPCOW_vtFbNTt89MwQ3XNVkd0VJvAle8SbeG3sITy9Izez-Igi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 15:06:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>
Subject: [PATCH v2] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <xmqqmrr7fllq.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	17 Nov 2026 08:50:41 -0800")
References: <xmqqmrr7fllq.fsf@gitster.g>
Date: Tue, 17 Nov 2026 12:06:19 -0800
Message-ID: <xmqqqzgjcjes.fsf@gitster.g>
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

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * As there are new patches that want to add new callers to this
   function, let's keep the original with the same API while adding
   a new helper function that allows us to limit the scan.

 utf8.c | 35 ++++++++++++++++++++++++++---------
 utf8.h |  1 +
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/utf8.c b/utf8.c
index 96460cc414..d0546ab31f 100644
--- a/utf8.c
+++ b/utf8.c
@@ -16,20 +16,33 @@ struct interval {
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
 
+/* Same as above, but for a NUL-terminated string "s". */
+size_t display_mode_esc_sequence_len(const char *s)
+{
+	return display_mode_esc_sequence_len_counted(s, strlen(s));
+}
+
 /* auxiliary function for binary search in interval table */
 static int bisearch(ucs_char_t ucs, const struct interval *table, int max)
 {
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
2.56.1-740-gf38658f3d0

