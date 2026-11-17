Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932340;
	b=ttj/3QQeXaEGsuA7RE1uh1RyFbA8qO7tSAsxRQE+6vVvyEpPX7kNf6TJLYlpzTMicpR9
	 GKICQf0hXyPszSxDCQXx1/PNQZNCxtV+kSVmxZUcdcIsPy6vkrE0lfB7OMUrLl7wnhAHh
	 N6PTspPJnQAyPQe+fNIRnXALlPl+DnxTiGCThVnidjlp4PhF0iaPe+hMUxp85CqG82BTV
	 gE30z3MKPxB9TylCoPf1L28yJWjtg2+jRDlVzfYF3erNtwwpObZOfej1LoELFBnvakxVC
	 DdgyFuHpL4oUWJYwzlI9RIqa8954Wl7ziJjSi/Ssnt3NYPtVptp9Dw9RpQ7y499nRMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932340;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dHeaV32INEi1uUIpx8j0I/XwD+EWmArPFoiqZgEhr38=;
	b=2IKrNAL3vaKqEKcuGZP2YHkbNoWyIweBgQLU4nWtM/PFATNZr7dBNzYqkCz7hnEGS7uE
	 obJyLAF1Qhw/O0H9YSvG6SW75j/mPHzP/LiA/Ic/7InHiG1Iz5U4ZC147GyonHxVTKJsJ
	 Ngf2Db3uUCFL2WNK5u369VAOkgBV4OeDHoEVfDMlb9mk7x3CxAqdHVpVYUAZ345Q0mlje
	 5zx4bAv0vM6oLSyaFMEzL8t9TLgP0XC/+y5JOY7HggTCvQItGNwWou7UcmQoynC2iXhQP
	 bEBcpditBXwRw/P+GYa48WTHu6hurKVnT9iL48ObzHdoJjUQ0NsbxlE5XZ2MT6D1qfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QkqGnAEU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vanWIhwr;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96977606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 16:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96977606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QkqGnAEU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vanWIhwr
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 005401D0023C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 11:18:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 17 Nov 2026 11:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794932338; x=1795018738; bh=dHeaV32INE
	i1uUIpx8j0I/XwD+EWmArPFoiqZgEhr38=; b=QkqGnAEU8KJu+NtoO6MGGghpWx
	AfG84A8Dip3GCPRqJkljR7sWvpm7sBSB2JdeGBBov34uIQYcjtNF8ImZl6XLGR25
	bWNPzvv1C+nwl5wBoa3zVkDvoJt6L/OXQo0seid/wejfte1SftrWQnedvkq/HVUt
	AwQThbl09QQk1jJ2KCIc+wppjNKc/ZAFrEj7XpYBRCgwa7o5hnOjlqO+FxL7pv0F
	l/NJPlrmNpXQialC71m//IYlgsTDBX2la+WymldanUvkJ/q77+NPqq4p5rpHr4yN
	D/LeVe2LxvSdFmo2l5ns+t1w7NmXQh+0Co6xWmPl29YJkAqwNrCBsmQZtiTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794932338; x=1795018738; bh=dHeaV32INEi1uUIpx8j0I/XwD+EWmArPFoi
	qZgEhr38=; b=vanWIhwrGhpawumxhr4vGxhrvTsdkJHMgc0PWd4P8NMSQyTxKy6
	7Tppl47pu99lCd4nsObvKk+EPuPlbBGo2vJ+cCxG7cawcoFShCaZfobiYTo8BxWx
	9OMUP/PFX/ly6b4RtUikYOOYjx+GgSeNTe2RAoRYO+beJA97I51tj1m2bGg2JLZv
	09DhMpKe4B7eeFkrAF0KgCUqPBLOS2tc4MwnAQx+v7JTUD3tojbzcNfrP52wHWpg
	XjbpyU+FipPSDyx3KDQu5HhUe++Jorx0C5NUv+Cdl5lnTLW+zZ0cE8I/cuNImNAN
	87Rt8MPXi1I09aTuUHXXgL15gyFyk0HnNjg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794932338; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WDxZqURn5hm+5EjZZkLkua7dbsL4mGS5UPS9Z5029eoJc9J
	z/SBuYRzLu0zeK0HnyN4QxDxqU2mgPYZ49UVt0dvgeK7nhGQd2qFMt+kTIhcGib3
	gWGmSJAKjD8LiQHmevJxRTz0nztxH/fCkvqpNsDf84nJ7O9+EoYZbi3T2olEMe7v
	YI/lQnWNq2mdVvo9iiVZimUC5wOEbPzj1swN657CIeC6MzsP5koeVUulN8COvJl3
	7zO55kI618kDeyzGLKoSNM18M9vCLLHU2Zk82Z6kwOZknSjZntTx0whMW0wpULnJ
	Dl/J8DWqftiEEfR7dXMJFUlby7zw9BsJD8DV5fQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hx3OmD4eF3OXhHBtfdCxE56OZtrGgvIeSCj/ofMtyC0=:vhHGEVy+XVazUkyxQdlJxIrj7Ave/WorVkNpSLswINM=;
X-ME-Sender: <xms:cn78ant4zTy3hXf1zWQYv_8tsDn8HmwxSlzDyyx8m0UxBErIzDzzjQ>
    <xme:cn78av7F8Oo2My2rQCjG0fC1IsSsBBIErnTrL91OTbydq1FFG142lWsG46ooo-ajn
    I3KxKBO2TrZsw4rW9qPVAV8VBQKFrFL3Y1tF2EGqbvsUJenSTYJe7g>
X-ME-Received: <xmr:cn78aoKJDFlgrtrSs6WC7XLKiojgFsGEoX5jWwzxCvNE7elYCZsOpkE-R5Tjc7bQmyvoSELQxvJFLYAKodJ7jf8-mtbn5xQsn49L>
X-ME-Proxy-Cause: dmFkZTE1ucg4P2OlWOwAy1VP6jQBMfsImeamTXqMnyWD9Nlq4Jjee5NurqNVsJaYuYOwg2
    C8ZaOE29PJ3AxXZdR1cBx0uWFlkI5z4kYKyRiduPVnPuezuKVxaeFbSKC9k7BYYX9Kugz3
    SpaDCkn5OcYKznur4SKe2T8XrMpk5T4bKcbEYgQgzp3LmqaM6cR1AFvx29ds3YgGe6qPIf
    jZ5Fe4piIpBZiyRIO0FKxqvkuP8i2gfHiPVRB4RPM6c2tN6VekqUd5DhcBXUvI/gExVgHx
    T2UoMz1iyGF4licv4JclaXdBGxxLQN2MnvV7DM1lSEzlOelwf+dj9cQKH0RLrvcu8DbDW+
    LkLYMXYtbs/hH6vTSSnNFK/xDEUR+oStNpMPRS7SxPCucMrrfGhkjVrh/4Y4k3YAFShKRf
    On9LnZYq4hfBZGOb/t9J4fbn5KyiOpbitQYH1v2CO0hWxG4YL/D1/blmeFS7Vp11hFHY6G
    5aVqYNOxPIYWqQi4J04NeWQmt3+J5NVYAUNt765r0qxg04N7e/qW1FOGlJ8yO0GrFsV8Dk
    ZeQ9mfCEy4GisSrDeGde4keopprNqV3HbtbaMnDB8xlmRlRb+rHhSv98BJ7BqoG1I7Qx+p
    Q4DdPvSymWrlOII5ds7J9CXPWLUIwvwohJxK6IkSZ3CF32mfIDTpm74+Y+eA
X-ME-Proxy: <xmx:cn78av7bg5YTVbKMfH7Y_BirDxCoxC0vJwr3KXnSqB9ax2CLeqq2Gw>
    <xmx:cn78arxaVAprWVJ2AH-Hzus5TYgBijWO6MnEOS6vAZa0syb2IYcEiQ>
    <xmx:cn78ajYLUecH1i_RKJr67hi67M8H2bqkpDL_p2pamR6s8pJ1cvzMKg>
    <xmx:cn78atRTL-VOslRqpn-3GaPb8DhH_UuQDzKsD9vUesSWGgaWG-AtKw>
    <xmx:cn78anjSagzBF59RUUHYIsoF-wCgJDDVsYuCpaa8KYQs8RQSciTjyU1f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 11:18:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] utf8: respect bounds in utf8_strnwidth()
In-Reply-To: <xmqqld6siau9.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	16 Nov 2026 16:02:38 -0800")
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
	<20261116-master-v1-1-dc2a50ce0aa0@gouders.net>
	<xmqqld6siau9.fsf@gitster.g>
Date: Tue, 17 Nov 2026 08:18:56 -0800
Message-ID: <xmqqse0zfn2n.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> The problem is well spotted, but isn't the blame slightly misplaced?
> ...
> Even if display_mode_esc_sequence_len() were updated to take the
> remaining number of bytes in string (which I think *is* a good
> change, by the way), ...

An update to display_mode_esc_sequence_len() to take the length
limit, including its fallout, is shown below, and it does not look
too bad.  Not even compile-tested, but it should be sufficient as an
illustration of the idea.

This does not make your "after display_mode_esc_sequence_len()
skips, make sure if we still have remaining string to grab one UTF-8
character" change unnecessary, as I said.


 pretty.c |  3 ++-
 utf8.c   | 27 ++++++++++++++++++---------
 utf8.h   |  2 +-
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git c/pretty.c w/pretty.c
index 0bc8ad8a9a..a20fd61909 100644
--- c/pretty.c
+++ w/pretty.c
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
diff --git c/utf8.c w/utf8.c
index 96460cc414..544c5329f3 100644
--- c/utf8.c
+++ w/utf8.c
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
diff --git c/utf8.h w/utf8.h
index cf8ecb0f21..fb2227a9e2 100644
--- c/utf8.h
+++ w/utf8.h
@@ -5,7 +5,7 @@ struct strbuf;
 
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
-size_t display_mode_esc_sequence_len(const char *s);
+size_t display_mode_esc_sequence_len(const char *s, size_t len);
 int utf8_width(const char **start, size_t *remainder_p);
 int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
 int utf8_strwidth(const char *string);
