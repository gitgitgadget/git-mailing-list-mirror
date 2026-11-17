Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873660;
	b=o4QTpWX9Kc77Y4sMRPczI/Eul3VqLdm73TU2jpgjGVVjQ3DTDXm7CR796tXWOMJQHnP5
	 djlp9h5z9bUwRAStpv4ZrcWuwJVxh2b6Ny+pEbAryQYjRt2NB3ZVFJVKfOW4fxZjdVWQR
	 2sbekkp3utPdbngK6FSCV7V/ajayUzOkw8d+cim5bZ34C+OXwG+Gj20vDASkamwZpcrDc
	 5Myk8G+75QJY+WRNFS/MwG82HaLxfukWfo2GFX1AlDCMYNjYFsQgL1zIByclNxhXDd6Qy
	 /xZyfIMFB4Pdm0I+BiL6fADY2Dk2U0gCTwDnQc0iRk4qWazz4fvYeh4sqb3a6Nhbtvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f7yqd4Vy/XGxLEBLRXDK/dKu/gqq+ebElaDA04jHlDM=;
	b=Dc/6UUETbPqsRVe1UT6pONyzfkIJLP7Pe3mzhlB68fNG7UY8/AAX0qVF4gFe3JuO4evM
	 h4nZRAQGNyvm2hiTRqZuXdm/xr0DPP1mTR5A4Mi9YT1cjJnwxsAw4K6lg9EnB0w19Od81
	 NOVbxOlqPUBIr5VlDvyIixoqyzSrKd3M6Nmxlui1dH2lKlGhX9Ggz/YySyq6wRzvgIVwB
	 7chQoUBh6JDon3ZOJf52wMFYZmTE9zFMiKcyF+2RuEykc9nxH0qI50d29NXEUniY9eoRG
	 GR1TMD9qu/DO8V4B0MrCV6zIqzZ3XyrkVL5yycD3JfkTe71UUf0Kf3fMMAn/8jIR/eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkQgIM85;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5C5606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 00:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB5C5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkQgIM85
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so26509005e9.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 16:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794873658; x=1795478458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f7yqd4Vy/XGxLEBLRXDK/dKu/gqq+ebElaDA04jHlDM=;
        b=VkQgIM857Y093TJ+uJf+A65EGh7NSZ45xLTaRCA9c81OmDlkfvLbDpQ9ASMyO4WLPs
         68j8hnQ3v0iuUcGayTjiS8EIikOQPg+DfZYcTBDI+DDSkK1zI0u2RD16fEqd5sAs1AG5
         p9vjWkKJjeNZA7iXt9/KfYrv79SRTFySoiOQtfXAIkKsefiGYqMN7809vyo5x3ZwhN25
         a7IwzQmaNIrr4ItKf1SZvIcsOGE8trHkMcBMaAjRAiPDFZs3QGX9MBBGzNQd7BJuH+n4
         sSmGwLnxKFanXtUPl4Zvq17tallUDtIOcR5BszdrxMSAkosX8ZuGOarnszyRMihEqvPt
         qy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794873658; x=1795478458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f7yqd4Vy/XGxLEBLRXDK/dKu/gqq+ebElaDA04jHlDM=;
        b=YNnkLWcsMBLhCD/pWSBYrk0bLcN0tc2Aq4pS+UJ+AddCVf8YSY4ldfjxvMoWt/dorT
         sfbg3FJ5biDH7qh8ezhYcEqoCr0dIjJTSmq47Lr3D9LTB8FgIvpkZU/SwsTL0Wp3MOmz
         ehfcoFTdkJbS8a3Ds8NyuZ+5TzRMpKUFOQu0CaZIKEeXRGS2k24enIbp7w6XVXIy/hYW
         ru5EVG70CxNH5G4vHKObkpHdKYSObomfnEyBbVQH+d/2QqgUoNOgFHk0FHO3136Eomd1
         CXNaoeSTj6gopLK0fBo9U/5qfCBjEVJRPlP5witVg66qXQpgif+w/3i+6HUY8ir/KLDa
         wsbw==
X-Gm-Message-State: APuU4Z/eP9Gh3uXWcjapJmPcGqPcB8HPzuRQOyLutgf4dhPWFgxzYTAP
	e7d9ZiU1Ar6xPn30/8omvvNAr11e/m4nfDTXqMBGkhHwd32FZxvaUNN3QN8rmntOFhE=
X-Gm-Gg: AYBFou23OGuuCVuQA1ObyhaDmiTyFSdr7jZHjqpLqtIv7X3eCFR9z+oUCdX1L/zFAtC
	Vl624R4LJOqjM7Kz5wgYXHUTeAl+JpRHFc7jEJNKrKLdh1PwYeigsILVXcZZ4yJN1pnEdiDGlB+
	b5doX8xYmy9rvxDg+jhfmfcMWZmziYytF/H/RiOU+wmss6Wd2BKZ9W1xc9Ezr1Qo7KI6JnfpcVv
	0Z1oelS03Rf4XIkcYonrWEjn6Q1UQx9NDUbp/3xip1p2BPShqyshFcseXG12r8yVPV1XhLQmhJd
	aSF7ET+YS1Bjx1rBkf+eM7q0BhHMipwYrZlsBC9fyu5FL/uAV/AJLmYzdwgFjoRET8FkDoDDA4A
	/SNJ6ZaNNeev5R4SyRKT4S520QwZcWfwuqhUkp98kqo4BW7QFR8v74N/pDznUvKC8GMRYi6aBf9
	+StEKZJ5ZCs2QAFrkErpeO3aB1Mr+SEn3WDHVsCUUBAr9DMr8TVvRYCp6ypxQ9NgI1yzNM1/mZc
	ZCqbrAvPAVVHmlCnE9PFTKj0FR8mMvNe/rUM9waQn2+uBsaEEe/qpwQ3P1nO+uHRhTYlW4/ry9l
	aJrS6gappxsgAvZ7M9RNFN3uwIQ33QRehk75EqrawE5+VjaNtecA/77ZrohMv+e23huxb4BmOZC
	fwKrAnUMziiD8MhDcpWoYRw==
X-Received: by 2002:a05:600c:1553:b0:4bb:5e6b:49e with SMTP id 5b1f17b1804b1-4bb5e6b0656mr213020645e9.6.1794873658148;
        Mon, 16 Nov 2026 16:00:58 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a2ea918d24sm3328850f8f.54.2026.11.16.16.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 16:00:57 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2] pretty: fix lost and leaked colors at line breaks
Date: Tue, 17 Nov 2026 00:00:36 +0000
Message-ID: <845c622dc7fd33306beca5488a74a89dee8a2e38.1794872505.git.andy.koppe@gmail.com>
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
Changes since v1 in response to Junio's review:

- Point out that custom formats cannot make lines self-contained within
  placeholders that expand to multiple lines, which is why the formatted
  output is processed instead.
- Drop the mentions of grepping colored output.
- Clarify the --graph examples, which looked contradictory: the graph
  only resets colors after its colored edges, so colors carried across
  a line break are lost after an edge, yet leak into an uncolored '*'
  commit marker.
- Rebase onto maint, where v1 was queued.

Other changes, from looking at the code with fresh eyes again:

- Move the line break handling into the branch for active colors, as
  it can't trigger otherwise.
- Comment on the handling of NULs, which also stop strcspn().
- Add a test with embedded and trailing NULs.

 pretty.c                      | 101 ++++++++++++++++++++++++++++++++++
 t/t4205-log-pretty-formats.sh |  80 +++++++++++++++++++++++++++
 2 files changed, 181 insertions(+)

diff --git a/pretty.c b/pretty.c
index d8a9f370f6..983bd4fc71 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1997,6 +1997,103 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
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
@@ -2010,6 +2107,7 @@ void repo_format_commit_message(struct repository *r,
 	};
 	const char *output_enc = pretty_ctx->output_encoding;
 	const char *utf8 = "UTF-8";
+	size_t orig_len = sb->len;
 
 	while (strbuf_expand_step(sb, &format)) {
 		size_t len;
@@ -2023,6 +2121,9 @@ void repo_format_commit_message(struct repository *r,
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

Range-diff against v1:
1:  1e5e3188cd ! 1:  845c622dc7 pretty: fix lost and leaked colors at line breaks
    @@ Commit message
         colors, nor reset them at their end, which leads to two problems.
     
         Firstly, lines that continue colors from preceding lines lose them when
    -    shown without that context. Notably, --graph and color-aware pagers such
    -    as less reset colors at line breaks, so for example "%C(bold)%w(72)%s"
    -    only makes the first line of a wrapped subject bold, and "%C(cyan)%b"
    -    only colors the first line of the message body. The same can happen to
    -    lines picked out by grepping colored output.
    +    --graph edges or color-aware pagers such as less reset colors at line
    +    breaks. For example, "%C(bold)%w(72)%s" then only makes the first line
    +    of a wrapped subject bold, and "%C(cyan)%b" only colors the first line
    +    of the message body.
     
         Secondly, colors that are still active at the end of a line can leak
         into what follows. For example, with --graph, "%C(red)%s" also colors a
    -    '*' commit marker at the start of the next line, because the graph does
    -    not reset colors before drawing. Attributes such as bold also leak into
    -    the '|', '/' and '\' edges, as their colors don't override them. When
    -    grepping colored output, colors can similarly leak into unrelated lines.
    +    '*' commit marker at the start of the next line, because unlike the '|',
    +    '/' and '\' edges, it isn't colored. Attributes such as bold still leak
    +    into the edges, though, as the graph only resets colors after each one.
     
         The default log formats as well as git grep and diff avoid both problems
         by ensuring that the coloring of each line is self-contained: they do
         not rely on colors carrying across line breaks and always reset colors
    -    at the end of each line.
    +    at the end of each line. Custom formats can do the same at %n line
    +    breaks, but not within placeholders that expand to multiple lines.
     
    -    Fix both problems by taking the same approach for custom formats. When
    -    color output is enabled, scan their output for color escape sequences,
    +    Fix both problems by automating this for custom formats. When color
    +    output is enabled, scan their output for color escape sequences,
         collecting those since the last reset. If any are active at a newline,
         insert a reset before it, and replay them at the start of the next
         non-empty line, unless that begins with a reset. Also append a reset at
    @@ pretty.c: void userformat_find_requirements(const char *fmt, struct userformat_w
     +			if (!p)
     +				break;
     +		} else {
    -+			/* look for more colors or the line end */
    ++			/* look for more colors, the line end, or a NUL */
     +			p += strcspn(p, "\033\n");
    -+		}
     +
    -+		if (*p == '\n') {
    -+			/* leave room for added resets and colors */
    -+			if (!tmp.len)
    -+				strbuf_grow(&tmp, sb->len * 3 / 2);
    ++			if (*p == '\n') {
    ++				if (!tmp.len) {
    ++					/* make room for resets and replays */
    ++					strbuf_grow(&tmp, sb->len * 3 / 2);
    ++				}
     +
    -+			/* reset active colors at line end */
    -+			strbuf_add(&tmp, copied, p - copied);
    -+			copied = p;
    -+			strbuf_addstr(&tmp, GIT_COLOR_RESET);
    ++				/* reset active colors at line end */
    ++				strbuf_add(&tmp, copied, p - copied);
    ++				copied = p;
    ++				strbuf_addstr(&tmp, GIT_COLOR_RESET);
     +
    -+			while (*++p == '\n')
    -+				; /* skip empty lines */
    ++				while (*++p == '\n')
    ++					; /* skip empty lines */
     +
    -+			if (p == sb_end) {
    -+				/* no line left to replay colors on */
    -+				strbuf_reset(&colors);
    -+				break;
    ++				if (p == sb_end) {
    ++					/* no line left to replay colors on */
    ++					strbuf_reset(&colors);
    ++					break;
    ++				}
    ++
    ++				replay = true;
     +			}
    -+			replay = true;
     +		}
     +
     +		esc_len = display_mode_esc_sequence_len(p);
    @@ pretty.c: void userformat_find_requirements(const char *fmt, struct userformat_w
     +				strbuf_add(&colors, p, esc_len);
     +			p += esc_len;
     +		} else {
    ++			/* skip anything else, including NULs */
     +			p++;
     +		}
     +	}
    @@ t/t4205-log-pretty-formats.sh: test_expect_success 'strbuf_utf8_replace() not pr
     +	test_cmp expect actual
     +'
     +
    ++test_expect_success 'colors carry across lines with NULs' '
    ++	git log -1 --color=always --format="%C(red)a%x00%x00b%nc%x00" >raw &&
    ++	nul_to_q <raw | test_decode_color >actual &&
    ++	cat >expect <<-\EOF &&
    ++	<RED>aQQb<RESET>
    ++	<RED>cQ<RESET>
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
     +test_expect_success 'colors carry across lines with --graph' '
     +	git log -1 --graph --color=always --format="%C(red)a%nb" >raw &&
     +	test_decode_color <raw >actual &&

base-commit: 03b41523c576f26ad34085378717a0c1b287470f
-- 
2.56.GIT

