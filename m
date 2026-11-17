Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906633;
	b=PI2nuo0bZxFRR3qbVLJC+sp6nGvP1C8RxU921FkckhORpNSJQdYxy49VigcD884kVwoQ
	 A+Pdv/elVPsB9OlGh+3ziwsZWYDE5e7svdj770P4/q9QL8pqY29SksE2s+8yrixo2Y/BD
	 4wuxwxvTWn87oqWXPGOuMVHYmYGOmE1qYFkLY33XZ9BCYWK6a1ZobH0CSDC1XwoTZ9fiT
	 1lKSWqooZTX83e3517cq3Kgg7dPpjYDwdVzSFk50/sTa9BFDfVRlR35EaGjQNyRE96xJU
	 6Au7WrTrood1uhkpzkFBCQKKo6qrtZVKrsB37go6CPi/0qDz3g7Zrsa+o5YPkheKIIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F18inK6yLIcOi5eWW3RvHHYIxArGg7EvI5xpHMpK/7g=;
	b=BANtBH3JfP3a1x3fRJDNX7y9xBtAKu2Lyd1LRQhpoOVOU/gV0u6pvkb68jJt+ZjQNzQM
	 Vipol/st61EArweFOc3q5kLWLlLSU+DRKP+S5Ui5cF84hfCG0pTuBG58FLwZdDnsMT0j/
	 eSJYO3xRo9Am3aR2EuGz93qcc+y447yXnbATb3MtWdQXxBz+dUElHJL95+OAJ0KNQWq7x
	 oojGhfMuTYVBEa6wgUuq7zpU2m08Vm7FQ+zsZJqNt/aDXSqYLz61TXpwnY69Ft2l49DyK
	 A3HHIWDR8PgfYQF6KuGyuRwj5fZh5Oyv0TJCPA2eMFamj+nsgrSZHfG5I2qhAoRbo7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pknIPIIx;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4601606A32A
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 09:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4601606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pknIPIIx
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so43298995e9.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 01:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794906631; x=1795511431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F18inK6yLIcOi5eWW3RvHHYIxArGg7EvI5xpHMpK/7g=;
        b=pknIPIIxqbpMQENzQb28+e9HvK88s5OZE5oYsanYRDp6yoVnXKe06m0RUptlqdedbS
         3TAXmdNby0/LBmGxwK8dnOnskfVINbhKtKkdINYj64t5z/bsiwpSE1HZxcUHB9ebFG33
         TanyA+7BpS5IZMVTSp9RdPdg9vQY1ljEpGS6mcHBUWEXFdJnus5bO3fTOMroKki2GYdn
         Rwu4EJr+tDyv6FgdU4WjddQrCyEsYbw4ms57/97VawRbgivVVuSyk1X1CiWcZkY30I0N
         XFhceB8G/5y2VnzRMCDDkZJpIEqHsUJfNUXzyr9i6BAkgh9cBnV51DoVwqIJquUpm7mH
         tCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794906631; x=1795511431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F18inK6yLIcOi5eWW3RvHHYIxArGg7EvI5xpHMpK/7g=;
        b=qiC5J0sPloFtj4Ck/mtkmvKluofLMARVCoj4v+eiXHosPhZ3DBCj2hp9T5RbsLKo8V
         oXUdbzhQq+klVInhjHEOxrP4UehDx7OERQApfmEDd2lwTUJm9Wjn+SBBRQRVzyaYn/SY
         IC1dE+nef1UT1kmCziY9yy71Aq2Hsf5sLfsVUSQ5kNpTq/mEmyDM95C7KWSxZ53D4AY1
         QaMaPR7NaYS9sOT3+AQV+R64/Dujb4aCVy2Kpla39ugyV1+RmxnYFlbpR2LZ1z1EEbEv
         z/lQHcUxxPMJHQ8dLEvrRJ4vk1fOcjghrlw9Do5EI0bwIRGBV2yduRhqOMnrWW3zuqKQ
         oCnQ==
X-Gm-Message-State: APuU4Z+pEOgJCRK9meNRNBWmgN7bCau81YHSS08g3Xq7q2qZCCWr6bFS
	TzQzQevX2UUQBYtvYpI4ToebFhogGiQTq7OHpPIxnBP6OCh40LoxRM8V8LjU6bonsYU=
X-Gm-Gg: AYBFou1YhyRrqi42L6C8wvQkuCvXA8pplXlkwffrCKx+3nQ0K/Di3NX0tejZOwTctD0
	haj9SY3nb3tQluWC4uEPP5A5HsF0xQYw2wYGs4chkUFFKuI3xuRbRiiB0qiCQrsrIO7FR6sy2my
	NwcrucCMS8YD7qFzsLXkPFiDnVLGRnwQvaM3rEL9npSoXqUxRXfeQLMwN3ZeRr1NbmFxsG0/T2C
	BHtd0nHXm3iBpQov4pq7ySROo2BXWNafUPxAmLiJpxZDrxoY4eM+htdLDLJ6igPOmS4IlCTtOsh
	TcjxF6LwRVf6osLbTMC/CyAvPeKm7D69cUyNPV1SENTxK36IhvMPMAIWDU2vq44ZLmmwzzqEPv6
	2qTok8SPvs8JoPmzw0r8mtD26anOGIwPlBqJBZ/hE69hUt6jrHo0wLvnrpmp1j6TlB7bnupwp+/
	8HXRXfsiNCUCTfOn6slC0ElryOlDNY44K7mxmNAx7bbZCr0u+hu3jcbLgaQvtKrUD0gUU1Hda7f
	pfcuc3G30EwlGHqIKqFlf7avn+n0x+nxZfkRcTgZO41gRdrk137qSickxQFwbmDceSghk0tB2cL
	RSbiC3KV4PFCIX+nj8Ol0XXucHECl9fME3mlGMXxMSFVTc1Yq/QrGBuENJ/h83vsKxNfwRDex36
	vWcRtHXlx8YkAJ9NXD2SQZdzdRIGIRDJfopWHVeZKTCE=
X-Received: by 2002:a05:600c:3d91:b0:4bb:6861:657d with SMTP id 5b1f17b1804b1-4bb686166e8mr179888075e9.21.1794906630677;
        Tue, 17 Nov 2026 01:10:30 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7839cabbsm50386575e9.11.2026.11.17.01.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:10:29 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH v3] pretty: fix lost and leaked colors at line breaks
Date: Tue, 17 Nov 2026 09:10:17 +0000
Message-ID: <e9f88b533dfbd10528c9151e2e87207419d0253d.1794905511.git.andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.GIT
In-Reply-To: <2f9f835e3f99d7de5bbf51be2e8ef4dc0485a46e.1794778250.git.andy.koppe@gmail.com>
References: <2f9f835e3f99d7de5bbf51be2e8ef4dc0485a46e.1794778250.git.andy.koppe@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Colors in custom log formats remain in effect until reset, including
across line breaks. Lines therefore don't necessarily set their own
colors, nor reset them at their end, which leads to two problems.

Firstly, lines that continue colors from preceding lines lose them when
--graph edges or color-aware pagers such as less reset colors at line
breaks. For example, "%C(bold)%w(72)%s" then only makes the first line
of a wrapped subject bold, and "%C(cyan)%b" only colors the first line
of the message body.

Secondly, colors that are still active at the end of a line can leak
into what follows. For example, with --graph, "%C(red)%s" also colors a
'*' commit marker at the start of the next line, because unlike the '|',
'/' and '\' edges, it isn't colored. Attributes such as bold still leak
into the edges, though, as the graph only resets colors after each one.

The default log formats as well as git grep and diff avoid both problems
by ensuring that the coloring of each line is self-contained: they do
not rely on colors carrying across line breaks and always reset colors
at the end of each line. Custom formats can do the same at %n line
breaks, but not within placeholders that expand to multiple lines.

Fix both problems by automating this for custom formats. When color
output is enabled, scan their output for color escape sequences,
collecting those since the last reset. If any are active at a newline,
insert a reset before it, and replay them at the start of the next
non-empty line, unless that begins with a reset. Also append a reset at
the end if any colors are still active there.

Doing this in repo_format_commit_message() covers all color sequences
and line breaks, whether they come from placeholders, auto colors,
manual %x1b sequences, or message content.

Resets are only recognized as the first code of a sequence, which is
where git puts them. A reset later in a sequence would cancel the codes
before it, so it is unlikely to be used deliberately, and missing one
merely adds to the replayed sequences.

To keep overhead to a minimum, avoid buffer inserts and use memchr() and
strcspn() to skip to escapes and newlines. If there are no escapes, the
only cost is an unsuccessful memchr() call. The buffer is only copied if
colors are active at a line break.

Formats that have come to rely on --graph or a pager resetting colors at
line breaks will need explicit resets, which they already require when
neither is used.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
Sorry, this code keeps on bouncing around my head, so here's one more
tweak to try to make it clearer. (The algorithm has been annoyingly
difficult to pin down considering it's a pretty simple idea.)

- Combine the reset and replay conditionals.
- Rename the reset variables, for consistency with 'replay'.

 pretty.c                      | 102 ++++++++++++++++++++++++++++++++++
 t/t4205-log-pretty-formats.sh |  80 ++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)

diff --git a/pretty.c b/pretty.c
index d8a9f370f6..78be2ae034 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1997,6 +1997,104 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
 	}
 }
 
+/*
+ * Make the coloring of each line in 'sb' from offset 'start' onwards
+ * self-contained, so that it survives --graph and color-aware pagers such as
+ * 'less -R' resetting colors at line breaks, and doesn't leak into what
+ * follows, for example the graph.
+ *
+ * Color escape sequences since the last reset are collected, and if any are
+ * active at a newline, a reset is inserted before it. They are replayed at the
+ * start of the next non-empty line, unless that begins with a reset. A reset is
+ * also appended at the end if colors are still active there.
+ *
+ * Resets, which have a zero or empty code, are only recognized at the start of
+ * a sequence. They make little sense elsewhere, and missing one merely adds to
+ * the replayed sequences.
+ */
+static void make_line_colors_self_contained(struct strbuf *sb, size_t start)
+{
+	struct strbuf colors = STRBUF_INIT; /* colors since last reset */
+	struct strbuf tmp = STRBUF_INIT;
+
+	const char *copied = sb->buf;
+	const char *sb_end = sb->buf + sb->len;
+	const char *p = sb->buf + start;
+
+	while (p < sb_end) {
+		size_t esc_len;
+		bool replay = false, reset, reset_only;
+		char *reset_end;
+
+		if (!colors.len) {
+			/* look for colors to collect */
+			p = memchr(p, '\033', sb_end - p);
+			if (!p)
+				break;
+		} else {
+			/* look for more colors, the line end, or a NUL */
+			p += strcspn(p, "\033\n");
+
+			if (*p == '\n') {
+				if (!tmp.len) {
+					/* make room for resets and replays */
+					strbuf_grow(&tmp, sb->len * 3 / 2);
+				}
+
+				/* reset active colors at line end */
+				strbuf_add(&tmp, copied, p - copied);
+				copied = p;
+				strbuf_addstr(&tmp, GIT_COLOR_RESET);
+
+				while (*++p == '\n')
+					; /* skip empty lines */
+
+				if (p == sb_end) {
+					/* no line left to replay colors on */
+					strbuf_reset(&colors);
+					break;
+				}
+
+				replay = true;
+			}
+		}
+
+		esc_len = display_mode_esc_sequence_len(p);
+		reset = esc_len && !strtoul(p + 2, &reset_end, 10);
+		reset_only = reset && *reset_end == 'm';
+
+		if (reset) {
+			strbuf_reset(&colors);
+		} else if (replay) {
+			strbuf_add(&tmp, copied, p - copied);
+			copied = p;
+			strbuf_addbuf(&tmp, &colors);
+		}
+
+		if (esc_len) {
+			/* collect the sequence if it's more than a reset */
+			if (!reset_only)
+				strbuf_add(&colors, p, esc_len);
+			p += esc_len;
+		} else {
+			/* skip anything else, including NULs */
+			p++;
+		}
+	}
+
+	if (tmp.len) {
+		strbuf_add(&tmp, copied, sb_end - copied);
+		strbuf_swap(sb, &tmp);
+	}
+
+	/* reset active colors at buffer end */
+	if (colors.len)
+		strbuf_addstr(sb, GIT_COLOR_RESET);
+
+	strbuf_release(&tmp);
+	strbuf_release(&colors);
+}
+
 void repo_format_commit_message(struct repository *r,
 				const struct commit *commit,
 				const char *format, struct strbuf *sb,
@@ -2010,6 +2108,7 @@ void repo_format_commit_message(struct repository *r,
 	};
 	const char *output_enc = pretty_ctx->output_encoding;
 	const char *utf8 = "UTF-8";
+	size_t orig_len = sb->len;
 
 	while (strbuf_expand_step(sb, &format)) {
 		size_t len;
@@ -2023,6 +2122,9 @@ void repo_format_commit_message(struct repository *r,
 	}
 	rewrap_message_tail(sb, &context, 0, 0, 0);
 
+	if (want_color(pretty_ctx->color))
+		make_line_colors_self_contained(sb, orig_len);
+
 	/*
 	 * Convert output to an actual output encoding; note that
 	 * format_commit_item() will always use UTF-8, so we don't
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 01b97c8888..7a3a3a4639 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -538,6 +538,86 @@ test_expect_success 'strbuf_utf8_replace() not producing NUL' '
 	test_grep ! Q actual
 '
 
+test_expect_success 'colors carry across lines' '
+	git log -1 --color=always \
+		--format="%C(bold)%C(red)a%n%C(green)b" >raw &&
+	test_decode_color <raw >actual &&
+	cat >expect <<-\EOF &&
+	<BOLD><RED>a<RESET>
+	<BOLD><RED><GREEN>b<RESET>
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'colors carry across wrapped lines' '
+	commit=$(echo "one two three" | git commit-tree HEAD^{tree}) &&
+	git log -1 --color=always --format="%C(bold)%w(7)%s" $commit >raw &&
+	test_decode_color <raw >actual &&
+	cat >expect <<-\EOF &&
+	<BOLD>one two<RESET>
+	<BOLD>three<RESET>
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'colors are reset at the end of each commit' '
+	git log -2 --color=always --format="%C(red)a" >raw &&
+	test_decode_color <raw >actual &&
+	cat >expect <<-\EOF &&
+	<RED>a<RESET>
+	<RED>a<RESET>
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'colors are not replayed on empty lines or before resets' '
+	git log -1 --color=always \
+		--format="%C(red)a%n%n%C(reset)b%C(green)%nc%n" >raw &&
+	test_decode_color <raw >actual &&
+	cat >expect <<-\EOF &&
+	<RED>a<RESET>
+
+	<RESET>b<GREEN><RESET>
+	<GREEN>c<RESET>
+
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'resets followed by colors carry across lines' '
+	git log -1 --color=always \
+		--format="%C(red)%C(blue reset)a%nb%x1b[0;31m%nc%x1b[0m%nd" \
+		>raw &&
+	test_decode_color <raw >actual &&
+	cat >expect <<-\EOF &&
+	<RED><;BLUE>a<RESET>
+	<;BLUE>b<RESET;RED><RESET>
+	<RESET;RED>c<RESET>
+	d
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'colors carry across lines with NULs' '
+	git log -1 --color=always --format="%C(red)a%x00%x00b%nc%x00" >raw &&
+	nul_to_q <raw | test_decode_color >actual &&
+	cat >expect <<-\EOF &&
+	<RED>aQQb<RESET>
+	<RED>cQ<RESET>
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'colors carry across lines with --graph' '
+	git log -1 --graph --color=always --format="%C(red)a%nb" >raw &&
+	test_decode_color <raw >actual &&
+	cat >expect <<-\EOF &&
+	* <RED>a<RESET>
+	<RED>|<RESET> <RED>b<RESET>
+	EOF
+	test_cmp expect actual
+'
+
 # --date=[XXX] and corresponding %a[X] %c[X] format equivalency
 test_expect_success '--date=iso-strict %ad%cd is the same as %aI%cI' '
 	git log --format=%ad%n%cd --date=iso-strict >expected &&

Range-diff against v2:
1:  845c622dc7 ! 1:  e9f88b533d pretty: fix lost and leaked colors at line breaks
    @@ pretty.c: void userformat_find_requirements(const char *fmt, struct userformat_w
     +
     +	while (p < sb_end) {
     +		size_t esc_len;
    -+		char *end;
    -+		bool replay = false, is_reset, is_reset_only;
    ++		bool replay = false, reset, reset_only;
    ++		char *reset_end;
     +
     +		if (!colors.len) {
     +			/* look for colors to collect */
    @@ pretty.c: void userformat_find_requirements(const char *fmt, struct userformat_w
     +		}
     +
     +		esc_len = display_mode_esc_sequence_len(p);
    -+		is_reset = esc_len && !strtoul(p + 2, &end, 10);
    -+		is_reset_only = is_reset && *end == 'm';
    ++		reset = esc_len && !strtoul(p + 2, &reset_end, 10);
    ++		reset_only = reset && *reset_end == 'm';
     +
    -+		if (replay && !is_reset) {
    ++		if (reset) {
    ++			strbuf_reset(&colors);
    ++		} else if (replay) {
     +			strbuf_add(&tmp, copied, p - copied);
     +			copied = p;
     +			strbuf_addbuf(&tmp, &colors);
     +		}
     +
     +		if (esc_len) {
    -+			if (is_reset)
    -+				strbuf_reset(&colors);
    -+			if (!is_reset_only)
    ++			/* collect the sequence if it's more than a reset */
    ++			if (!reset_only)
     +				strbuf_add(&colors, p, esc_len);
     +			p += esc_len;
     +		} else {

base-commit: 03b41523c576f26ad34085378717a0c1b287470f
-- 
2.56.GIT

