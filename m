Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155036;
	b=2RV+FKInqxo4SMu8l2sEuDqe/mZlkgk7Dmc3e2Rrj1mLcC9p4t8kx1FRvAye5iwgG0M2
	 1/wHG2pBCabHpM0UajqbaEoB3pqNzbR/XtP2kHaRc5d8kwXZqZ+BGWfHvxEMWth+iotKO
	 9ZvBZG6ppr/sNNT14FRg91+wa5wHR7Qil0fE6gbIrjm6EjnqmrCo8uS4JDVh7SCfMPoS4
	 biFW7yswXR86WKEgwjOKPiraY9yjPu0PyHvtbJun9wJ78/ojcgjh9aOLFscuN/J0/S+/p
	 E2VfBxQ3Y1FKqBFXlc1DX2lGjNrL03e/SLBCkG4RWsbrTaAxUzRdKSwccVFfyPxQhpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ebO8i2ooxGrBKbFCSykPEL2z76xF+O+fY1xJ+GNt73A=;
	b=4EUda/wspXus0kmLaOSUTa+uNZL7NXnBbaC4abY8AiIExkHVKkINRSQeqZGnkYlqr4rf
	 DaSxt6gb98TYyHgcnhYtJAgj34mHbgVmCJPyN4Q9zQRIrrXKwbcksXpNjjYwhGbZu17u8
	 4wfbZMriN3ktE3xCDxmYMlTCwcUSWAP5lBcCe1qlKck9UNQ7+12KoT2iVt6j5ZEZdnlzo
	 VBMpe7ddHtraW9rJzPbpBfTblMzHohFmjdCxrQ8siz9JfjFfQ4eJJ0hGnhTT/62qHp5o3
	 qnmI5tZeviMkJMo3RAUdmDYS+SOg3tHz4Ec3loZMN63AhKKfu2Bg9I7bMCRHzANDF+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0OJtRGcF;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C569606A527
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 06:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C569606A527
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0OJtRGcF
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso4262155e9.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 22:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795155025; x=1795759825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ebO8i2ooxGrBKbFCSykPEL2z76xF+O+fY1xJ+GNt73A=;
        b=0OJtRGcF7WWt+d2vw2wsLQhkheLUM/9URa1Yyj/yCkvP8cQ/0bnbnsDi5XLYVCf+Wb
         y0F8aZFq3+Ef/StylAKs4vDaTuOn4C0ZlfgW+YAAygeJrgYJo5CmXswH05pyaB6fDmtg
         ZenScw4jqYJ9zDkaCmwjylIlEOyQzdvwObQuisXMNO7BOaK9Ak6RNWZXbK4OW6j+fBAD
         JZf0LfeaH8gJcogdFjlrmVR2dDaW5HMcz8mGgjuauZbns5E2FQbKo+3UUvCdyaOzbaFI
         /58IHd7Psx6wfujzO3ua0aQfOOJB5Wr4dMlDbDWAFhmeSrZ3TabY6oPl+XFaHdgOlbsF
         TeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795155025; x=1795759825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ebO8i2ooxGrBKbFCSykPEL2z76xF+O+fY1xJ+GNt73A=;
        b=WSJqEFQEso6fyroTiGc0JhSskvHkSzJ+yWQNkMfPZvOobNvCRK4tFOd/2utdUB3rLW
         juRf+Vocxdwa2Fzf1h1QNDEETchnZQ8sP8V3f5CyjLZQXzd+saKBY4GKymVxN24kBC2O
         cJDuRlMh5bRam+F2AbzSlf7l057LmM4RlXOwnh9Ey0RjFy8pYoGtYX5IhXHWgvgcQTJS
         HxBp4dwu9WEuuRlOQCzWUrKdtAIW/sByl6S3wDJmsT5+4pFvTCsz/CGqfbnayAaz9CFi
         L+e5lsg3xmMY0EzETfhvtOAdAanzz9yjKQRvFdi5Jy4QBc4BmGheux5h9ueSZxthGTzE
         y37Q==
X-Gm-Message-State: APuU4Z9dQSSXQxvOujURbjxySSe9rtaDIes0Elfa1hRm83q2y2nQRx+/
	j+i4jzllhBU/B2Z4FI9MCiclWlr6ZWwGk7y+lkK9LbMs7359RRpjzQBv7sY+qw==
X-Gm-Gg: AYBFou21iI+ZCd/i08ZHLXpDf/PUdr4nl/flLQVQzVXmgdhP64hPMDQwbtvMN9VPS3g
	MoGJEydjhwIbTqvJrxmnw/6qz+UPMOkOBlQLlQmqdWHoQgtfq6XIANh1nv2sva+Gt526RBcyKr2
	LA0slQINF3V6aiW6wp8q3+A4B00d+AZ3Fek7EI/r+pJNO6pai1gzwtpNM5B4pEcq2kkkP4Ub4wR
	T3/YZBe+LFsePRWzEKHhjOv5j+liT8SdMK7xRBNSPP5CNerPMjvYlVBV4SNS2oPWHiTdDasl2wT
	xS043FozgkVMXmfAJuvyZewYwI20E/7wEmSqFiifGk3oN3NyB2DDMWfnkpaFskZkL7S6DI8VHzN
	kSQo59JGStZxHDrQhaFgzUFUThQK2nw9ApVrfyhYv31iV6l5vUJ5mHh4+zqpWA5Xb+ge7nJI5bJ
	If1s9yp+n3RduOOO4DH567/T54wEXWJEYfuXifGDzkLn5RelbN0xkl/faiQG34zYbWAqj9olPUm
	4Kzqnv4eut7lY1uZt2sPme72D4CUhrIBsVOFNiUQpIKgMiJO962ia7CAboHIyvLCSkrruSKibVB
	DZvoksuUzB/Owd3FOOIAtsc/lGDuR8oy5ShxMpKudhN/XAbq2ZJM219kzquTXkT2hFNTtDs/xs+
	2yFJoavFSouHGGIEy6dadcA==
X-Received: by 2002:a05:600c:1389:b0:4bb:6519:477e with SMTP id 5b1f17b1804b1-4bb88813b35mr39225825e9.17.1795155025233;
        Thu, 19 Nov 2026 22:10:25 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm64509725e9.6.2026.11.19.22.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:10:24 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH] pretty: add %(body:trailers=<bool>)
Date: Fri, 20 Nov 2026 06:09:30 +0000
Message-ID: <4e6e2c256ef7d13dfc31cf0235f6163cc1509fca.1795153464.git.andy.koppe@gmail.com>
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

While pretty formatting has the "%(trailers)" placeholder for extracting
the trailer block, it does not have a complementary placeholder for
extracting the message body without trailers. That can be useful for:

- Hiding trailers in a compact log format.
- Reflowing the body with "%w" without affecting the trailers.
- Coloring the trailers separately from the rest of the body.
- Getting the body without trailers in scripts and UIs without having
  to post-process "%b".

Add a "%(body)" placeholder that is equivalent to "%b", with a boolean
"trailers" option. With "trailers=no", the trailer block as found by
"%(trailers)" is omitted.

The blank line separating the trailer block from the text before it is
dropped too. Content after the trailer block that "%(trailers)" ignores,
such as comment lines or an old-style "Conflicts:" section, is kept.
When there are no trailers, "%(body:trailers=no)" is the same as "%b".

The placeholder name matches the "%(contents:body)" field of
git-for-each-ref, which also excludes the subject, and the option syntax
follows the options of "%(trailers)" and "%(describe)".

As an example, "%w(72)%(body:trailers=no)%w()%C(dim)%+(trailers)%Creset"
reflows the message body but not the trailers, which are dimmed.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
Coloring the trailers separately as mentioned in the use cases would
greatly benefit from the "pretty: fix lost and leaked colors at line
breaks" patch [1], which in fact was motivated by it. I think the two
patches are independently useful though, which is why I didn't make
them a series.

[1] https://lore.kernel.org/git/e9f88b533dfbd10528c9151e2e87207419d0253d.1794905511.git.andy.koppe@gmail.com

 Documentation/pretty-formats.adoc |  3 ++
 pretty.c                          | 58 +++++++++++++++++++++++++++++++
 t/t4205-log-pretty-formats.sh     | 55 +++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)

diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
index 2ae0eb11a9..39d66d9f73 100644
--- a/Documentation/pretty-formats.adoc
+++ b/Documentation/pretty-formats.adoc
@@ -301,6 +301,9 @@ tags are added or removed at the same time.
 +%f+:: sanitized subject line, suitable for a filename
 +%b+:: body
 +%B+:: raw body (unwrapped subject and body)
+++%(body++`[:trailers[=<bool>]]`++)++:: body, like `%b`. With
+	`trailers=no`, the trailer block (see `%(trailers)` below) and the
+	blank line before it are omitted.
 ifndef::git-rev-list[]
 +%N+:: commit notes
 endif::git-rev-list[]
diff --git a/pretty.c b/pretty.c
index d8a9f370f6..c67c9160c7 100644
--- a/pretty.c
+++ b/pretty.c
@@ -997,6 +997,36 @@ const char *format_subject(struct strbuf *sb, const char *msg,
 	return msg;
 }
 
+static void format_body_without_trailers(struct strbuf *sb, const char *msg,
+					 const char *body)
+{
+	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+	struct trailer_block *trailer_block;
+	const char *trailer_start, *trailer_end;
+	LIST_HEAD(trailers);
+
+	opts.no_divider = 1;
+	trailer_block = parse_trailers(&opts, msg, &trailers);
+	trailer_start = msg + trailer_block_start(trailer_block);
+	trailer_end = msg + trailer_block_end(trailer_block);
+	trailer_block_release(trailer_block);
+	free_trailers(&trailers);
+
+	if (trailer_start == trailer_end) {
+		strbuf_addstr(sb, body);
+		return;
+	}
+
+	if (trailer_start > body) {
+		/* Include the preceding blank line in the chunk to cut. */
+		while (--trailer_start > body && trailer_start[-1] != '\n')
+			; /* back to the start of the line */
+	}
+
+	strbuf_add(sb, body, trailer_start - body);
+	strbuf_addstr(sb, trailer_end);
+}
+
 static void parse_commit_message(struct format_commit_context *c)
 {
 	const char *msg = c->message + c->message_off;
@@ -1251,6 +1281,14 @@ static int match_placeholder_bool_arg(const char *to_parse, const char *candidat
 	return 1;
 }
 
+static int parse_body_options(const char **p, int *trailers)
+{
+	while (**p != ')')
+		if (!match_placeholder_bool_arg(*p, "trailers", p, trailers))
+			return -1;
+	return 0;
+}
+
 static int format_trailer_match_cb(const struct strbuf *key, void *ud)
 {
 	const struct string_list *list = ud;
@@ -1771,6 +1809,26 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		return 1;
 	}
 
+	if (skip_prefix(placeholder, "(body", &arg)) {
+		int trailers = 1;
+
+		if (*arg == ':') {
+			arg++;
+			if (parse_body_options(&arg, &trailers))
+				return 0;
+		}
+		if (*arg != ')')
+			return 0;
+
+		if (trailers)
+			strbuf_addstr(sb, msg + c->body_off);
+		else
+			format_body_without_trailers(sb, msg + c->subject_off,
+						     msg + c->body_off);
+
+		return arg - placeholder + 1;
+	}
+
 	if (skip_prefix(placeholder, "(trailers", &arg)) {
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 		struct string_list filter_list = STRING_LIST_INIT_NODUP;
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 01b97c8888..4e90243616 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -662,6 +662,61 @@ test_expect_success 'set up trailer tests' '
 	EOF
 '
 
+test_expect_success '%(body) is equivalent to %b' '
+	git log --no-walk --pretty="%(body)" >actual &&
+	git log --no-walk --pretty="%b" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(body:trailers) is equivalent to %b' '
+	git log --no-walk --pretty="%(body:trailers)" >actual &&
+	git log --no-walk --pretty="%b" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(body) with unknown option is left as is' '
+	git log --no-walk --pretty="tformat:%(body:bogus)" >actual &&
+	echo "%(body:bogus)" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(body:trailers=no) omits trailers' '
+	git log --no-walk --pretty="%(body:trailers=no)" >actual &&
+	cat >expect <<-\EOF &&
+	This commit is a test commit with trailers at the end. We parse this
+	message and display the trailers using %(trailers).
+
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '%(body:trailers=no) ignores Conflicts: section' '
+	test_when_finished "git reset --hard HEAD^" &&
+	printf "subject\n\nConflicts:\n\tfile.c\n" |
+	git commit --allow-empty --cleanup=verbatim -F - &&
+	git log --no-walk --pretty="%(body:trailers=no)" >actual &&
+	git log --no-walk --pretty="%b" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(body:trailers=no) keeps text after trailers' '
+	test_when_finished "git reset --hard HEAD^" &&
+	printf "subject\n\nbody\n\nA: b\n\nConflicts:\n\tfile.c\n" |
+	git commit --allow-empty --cleanup=verbatim -F - &&
+	git log --no-walk --pretty="%(body:trailers=no)" >actual &&
+	printf "body\n\nConflicts:\n\tfile.c\n\n" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(body:trailers=no) is empty with only trailers' '
+	test_when_finished "git reset --hard HEAD^" &&
+	printf "subject\n\nA: b\n" |
+	git commit --allow-empty --cleanup=verbatim -F - &&
+	git log --no-walk --pretty="%(body:trailers=no)" >actual &&
+	echo >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'pretty format %(trailers) shows trailers' '
 	git log --no-walk --pretty="%(trailers)" >actual &&
 	{

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
2.56.GIT

