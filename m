Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794778534;
	b=MQCOsYHozcewDkaBsKmc31hCcWQ81OonIFep+nGfAROv3GTX5DXejjj1zqVvq7QCP3r7
	 hBEIbHvPwkKg8cg4NGcv/HB+sTJWlk4sSQSfA4sk/Fq2LGVv3pHEWAmR+d9d9Rk91kHFa
	 wHT+bE7ERX6XOSDGQ7oKvREPYCFDmkNSRBuZYIVqUPAcFOameP0KrPyl9X/WAjdBpbNN/
	 68+SUMHfzWknXWjbDTednGm8exivZddD/QwlzNfBdagLrMvk1Onc5R+9+4Dyz1xxb11Rk
	 Kv+SkPvub8markjBnQWt7d3xmILSwPejz8nqyG83RqJfplOFSLK13EfywWoIRHErYkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794778534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IXu9Vz6Tx33MKIWx1CYQEI9XZFvExfkQUO8ZJQdObT0=;
	b=BPufkYFEgprDTH4ecdE9gIr3kcTZl1ZVmqD1JOzSYRQ2lkolKB5mTrI/CCxl3q4I8VEV
	 UNLN3tMV7xrAyrrjuXe+Sxa9Z8Hndfk8GchIkDETl13YCNvr6laYgA/ioMAwYsS9gC6ax
	 TaTgVi0+VyK/f6N6YjVF57CWwqfc0c6Zdt8NxMhk7kyzeH8PqC0lXNHHTxOP9tTQxcg7s
	 MyVNMJFvWbqnM/hfr37CKkECMbbwd+Kf5SguHHXWIZ6pvLLHGqPs21gtiYYKWk6i78zvF
	 J+Pm7DSk1TbkIUUU+sD2yZZ9WgG0kSfIxpJ2EV7nJi8V7gmrYCzSrvll0xBqDYZq5KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LzYnKtr9;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C1606A323
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 21:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB5C1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LzYnKtr9
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so1380406f8f.3
        for <git@vger.kernel.org>; Sun, 15 Nov 2026 13:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794778532; x=1795383332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IXu9Vz6Tx33MKIWx1CYQEI9XZFvExfkQUO8ZJQdObT0=;
        b=LzYnKtr9fUhNEdd+qXz2tSP4EeAXqKucO/FztqxH6Iewf/jD6VQbbWqHsyGlaWKcv8
         qMHLjvYFnfg//8Q44ZE9gLVeX+Qj8/maoMFl1CAP5rgEaz09/jiS/pTa6TwSwsZ2N55J
         lxBhhR/SHDM/hFrgvSTEjRZf/zNtLrhC6pk3DzdqnF/MJ2j9rHZ4w429zSOZ/A+UNdW7
         3h7EueNyQqGV79vDR6ie0ekzF6V4ZS34Tnm1iEQOyuKTkepXQFFeVOZ4i2Ul/McVySWw
         VUD19zbxNHzkWnJwvCLtE6lis93Vk/vVCgybOK2IjXQckF3XLuc6d/CNvOGu/LMmJORO
         S0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794778532; x=1795383332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IXu9Vz6Tx33MKIWx1CYQEI9XZFvExfkQUO8ZJQdObT0=;
        b=KPkLv/dDVx9vCtY9PewGdzTdwWocuWlFzUOHeTJR7WK5UrBwiYcOI9+IOA6xZFg4xf
         yw/3G59syKaVYH4OklvwHoOpxDu++D5d/lGeAGJf4mfWzS0co1TAedquWRSIMTnJatMM
         GuCJdHCuXrh88ZetyxLu+w+wsljIKZfJDzRcIxCl6Cm4n2b1wFTZetBB0zgKGRVJGsfG
         MgwNns/J3mRbTFKu0x3vG9PV5NdMLwRuSAojtW/NKDOvCUNYd9S/73YCjEnFMbyYQ/jf
         yXkV9XptfALGPTZnbLpY+py2OygV5En3Ebd1P7bMGgKYvJNrhAd8zcWs268AiVl4G0en
         37tA==
X-Gm-Message-State: APuU4Z83RwwmxSRAPrYhrvt3qgHS8z2hbzWFKGBKZ749q2HSnm6Xs9Tt
	S3rC8CSNj16ibkn2U8J9BIV6Y/1yR+YKt/soxsA7EoycihJ2tZKCIbwFjTy4/w==
X-Gm-Gg: AYBFou0m0mRol5LAMvnLmza9G4sqr4P2uZcb2ed7iGHJ9keVK4XO4WVQCaD/flGVhAm
	FfhBjKdfQQ/z8euNNLWWwEp5/GAEvOOwNrDVf+CKzwgN1Ozr43e033CndkEgisD67yw6jUxRJjb
	FXw+ABEQbpafN0mV3D+12/JhxUz5tskogEhtvhwjyoMvBH2W82EdGxaJk3+RZ6Eyj2oXQbQrNHL
	XaNzyLUcIu6KQ8W0G6dB+r1+bCCrCBoE9Q4LAYvrw3j0OZnOemQxuuI4Zjk1UEfHTP82SKK+jg3
	pRefJ/1J2DO/7n5i8neXKk3xwGRg+kp74zCYlD7hnSPo13rDDa2/9NiiGBb3DFr+RkSzYpCw0NA
	qoHjwUcozS8sVfSyVoUkBThAK+FrlvEhVZXbZuljpQql1ewjHhRh5uKJ+TTQ5iWGTh+RhznsxB6
	ax9eW4gIrhla+5c+Tpe0C0gdbrc+9fNo+/Jj0/JS6O8maKMxM1fTSyw53b+v5HZXf58zu5BIHJX
	CSl3RdjGhQ3aRyFdCny8xkCxaGtHeefDYbjoZJpUUzGM+3QEG+/T6MBr+ldvdpDvkr1ZbXrOcg0
	2jwTxc7M/0aUqcdLsTH7yF5TapzeLmG0BlS0QXR16tkMYCorcO/hLI0htCKzhr13Ytl0y574HH1
	JlemnmWnn4YXgOI78TDYO6U7Ye8GBWpN3mKfCZq8Gl28=
X-Received: by 2002:a05:6000:4693:b0:490:c68e:5d5d with SMTP id ffacd0b85a97d-49c74864785mr12228428f8f.49.1794778531719;
        Sun, 15 Nov 2026 13:35:31 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5fb58fefsm20165297f8f.26.2026.11.15.13.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 13:35:30 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH] pretty: fix lost and leaked colors at line breaks
Date: Sun, 15 Nov 2026 21:35:03 +0000
Message-ID: <2f9f835e3f99d7de5bbf51be2e8ef4dc0485a46e.1794778250.git.andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.GIT
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
shown without that context. Notably, --graph and color-aware pagers such
as less reset colors at line breaks, so for example "%C(bold)%w(72)%s"
only makes the first line of a wrapped subject bold, and "%C(cyan)%b"
only colors the first line of the message body. The same can happen to
lines picked out by grepping colored output.

Secondly, colors that are still active at the end of a line can leak
into what follows. For example, with --graph, "%C(red)%s" also colors a
'*' commit marker at the start of the next line, because the graph does
not reset colors before drawing. Attributes such as bold also leak into
the '|', '/' and '\' edges, as their colors don't override them. When
grepping colored output, colors can similarly leak into unrelated lines.

The default log formats as well as git grep and diff avoid both problems
by ensuring that the coloring of each line is self-contained: they do
not rely on colors carrying across line breaks and always reset colors
at the end of each line.

Fix both problems by taking the same approach for custom formats. When
color output is enabled, scan their output for color escape sequences,
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
 pretty.c                      | 98 +++++++++++++++++++++++++++++++++++
 t/t4205-log-pretty-formats.sh | 70 +++++++++++++++++++++++++
 2 files changed, 168 insertions(+)

diff --git a/pretty.c b/pretty.c
index d8a9f370f6..58ccf304be 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1997,6 +1997,100 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
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
+		char *end;
+		bool replay = false, is_reset, is_reset_only;
+
+		if (!colors.len) {
+			/* look for colors to collect */
+			p = memchr(p, '\033', sb_end - p);
+			if (!p)
+				break;
+		} else {
+			/* look for more colors or the line end */
+			p += strcspn(p, "\033\n");
+		}
+
+		if (*p == '\n') {
+			/* leave room for added resets and colors */
+			if (!tmp.len)
+				strbuf_grow(&tmp, sb->len * 3 / 2);
+
+			/* reset active colors at line end */
+			strbuf_add(&tmp, copied, p - copied);
+			copied = p;
+			strbuf_addstr(&tmp, GIT_COLOR_RESET);
+
+			while (*++p == '\n')
+				; /* skip empty lines */
+
+			if (p == sb_end) {
+				/* no line left to replay colors on */
+				strbuf_reset(&colors);
+				break;
+			}
+			replay = true;
+		}
+
+		esc_len = display_mode_esc_sequence_len(p);
+		is_reset = esc_len && !strtoul(p + 2, &end, 10);
+		is_reset_only = is_reset && *end == 'm';
+
+		if (replay && !is_reset) {
+			strbuf_add(&tmp, copied, p - copied);
+			copied = p;
+			strbuf_addbuf(&tmp, &colors);
+		}
+
+		if (esc_len) {
+			if (is_reset)
+				strbuf_reset(&colors);
+			if (!is_reset_only)
+				strbuf_add(&colors, p, esc_len);
+			p += esc_len;
+		} else {
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
@@ -2010,6 +2104,7 @@ void repo_format_commit_message(struct repository *r,
 	};
 	const char *output_enc = pretty_ctx->output_encoding;
 	const char *utf8 = "UTF-8";
+	size_t orig_len = sb->len;
 
 	while (strbuf_expand_step(sb, &format)) {
 		size_t len;
@@ -2023,6 +2118,9 @@ void repo_format_commit_message(struct repository *r,
 	}
 	rewrap_message_tail(sb, &context, 0, 0, 0);
 
+	if (want_color(pretty_ctx->color))
+		make_line_colors_self_contained(sb, orig_len);
+
 	/*
 	 * Convert output to an actual output encoding; note that
 	 * format_commit_item() will always use UTF-8, so we don't
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 01b97c8888..43a7de3f37 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -538,6 +538,76 @@ test_expect_success 'strbuf_utf8_replace() not producing NUL' '
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

base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
-- 
2.56.GIT

