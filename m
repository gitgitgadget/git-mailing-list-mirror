Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76BC24EAB7
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369125; cv=none; b=u6SIVdx+PSmmL3S2yy5OtmlbmSNhX7KqnO6KcZkpsGyoxJPGZqnvThVY66CYofS/BmIYUD/8TA+LjdV33AFUnsy17n6n0iQotbacBW4h+mWr3p61XJqKz49sXBiApcQ2Rm6R76AX/YmjruGJ0SET3oy0STmLQcgVv3WMjgaGSlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369125; c=relaxed/simple;
	bh=ZhWYH9jjBv7Uyk+RY0wtudJBWUtR6xNsvFVTJy814KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oz6kJaf4w+QByebMsg3pSEhlMHDjTjzCKvNDREPTZ7JL7dm3WncE8V/ISlhC9ME0yMNU2heIWQYYEzciCk7B1uAl/QzHCJIoY17ZTM2xVM6IMb6ywP5GAQ5qZLyGfhFrCuQ1jMBU798y0nmy4XcSKEZtxKMja3hDkZxTfglA9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUIAZ2qV; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUIAZ2qV"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bd21f887aso59480231fa.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742369121; x=1742973921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bc8zgkSIWBKAVbCPavklAohqEmAoFhBmo0Jaap5WPCI=;
        b=MUIAZ2qV/iBosOszCqDtPjzUGlVih9z9niR3SiMZJOfB0iLFnRmKXyGJreRa/cJAN3
         OMBJcWPC1whSSDGbalNDDq1Y4nea8WCdWHJM1sW8plSOft4TQhTWSoKfPybDAscIcs76
         GikiDuPYXzv8wGzrLuYRc9v5/+S2amQJV22hZLyfJhC8VZdd6CI/b4CdX7aAxRJTwgbw
         LekYYdf5EZdzEsDO1zHxu853FhfwtLFnXyVOrV6e1RyMEgd/2Opyye7tjRZtzrQxGeyR
         J+mIt6ox5YPC5UL9kkZCatc3siU6c3K6vZO+EH8fiFwRARnaSyfe8U1SRzstSYhPli+v
         B0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742369121; x=1742973921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bc8zgkSIWBKAVbCPavklAohqEmAoFhBmo0Jaap5WPCI=;
        b=cO4amyJ1DYFAHLYkTw0DQRciItBMOpZuKxIvZXLkpU+DCmkC9Bn0SuMPN3pcsq1Bdt
         4pwkYkGcFPzWDesZgnjighQyyVmjBKyhiT+2iJWwgMwSXeNHhHAo8P7Y0b4G29Hh2Gai
         +rkIf5Y/BxHxcthxkDIrGQF4ck0J+PUrEzv4sCMvB0Nm65J4xUqJizw7BZHrsaFiEdV1
         z9GjSbEjYh2eKIk6kyvr07mFUPuUCq3RgOVyC8IbXnV8P0hXJSzqV+A/s8+3juT1WdAF
         0c7XD/P50jvCOboK/nCf3CDpGX2xY9JngbDwX/4xDrQf3+euUShzYEiNe8Z48ffGNAri
         v1/A==
X-Gm-Message-State: AOJu0YyfmfOGSSJwt/94V3qDYumz8grqsG3G+YT69WJHBRvH62lQOxMX
	M0TYo093vUtKLdBUu7a/Am3fSQ1+2gQmo+Yos1xJkaMzb8U9nr17YKYzMw==
X-Gm-Gg: ASbGncsy8bAkkHHpUquogGAGROv79A4OKZau8LtXe7w+6K2Kg0U/9T8Kn+GKu7YIJkU
	LzuW87V9ZuepTc8sVWKsuYVGeG/Wz5RiI0rPAYWpbcSeHAbkmGxi+EBaJF2ROUSILDp+G4zcSej
	AfQ5RyPScycmmucwFtmSZisob9M0KDmLc1+EpwVoZi9AjpO7IvSXD0ressls1TcXJjihIJLgSob
	qvljDxXLWnCB3ByAgdprnpZOusjbhLQaSF1Ny6GwFVtTo2Bvxj7tCSIR8wce752MKLbcIC0IOuO
	xw5HHr5eI7f/O/fkxr1v9gY+uojNhjJjuJp6sQG3z+qTZpMX2FQZF0qZvoJCtg==
X-Google-Smtp-Source: AGHT+IH2297ywTuUmmKbfbSmDvCP8iOVK5h0I0IB29oN5vJDkSQQcYBbGHwa5t+xHhyd4/WPE4nBgQ==
X-Received: by 2002:a05:651c:2120:b0:30b:fd28:a771 with SMTP id 38308e7fff4ca-30d6a1cc588mr6734551fa.0.1742369121259;
        Wed, 19 Mar 2025 00:25:21 -0700 (PDT)
Received: from localhost.localdomain ([217.116.228.14])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f209d6esm22089541fa.112.2025.03.19.00.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:25:19 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 6/8] pretty: refactor parsing of line-wrapping "%w" placeholder
Date: Wed, 19 Mar 2025 08:23:39 +0100
Message-ID: <465c91155eb30197b5eac00d294dc6e7ea2dd310.1742367347.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec
In-Reply-To: <cover.1742367347.git.martin.agren@gmail.com>
References: <cover.1742367347.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Our parsing of a "%w" placeholder is quite a big chunk of code in
the middle of our switch for handling a few different placeholders. We
parse into three different variables, then use them to compare to and
update existing values in the big `struct format_commit_context`.

Pull out a helper function for parsing such a "%w" placeholder. Define a
struct for collecting the three variables.

Unlike recent commits, parsing and subsequent use are already a bit more
separated in the sense that we don't parse directly into the big context
struct. Thus, unlike the preceding commits, this does not fix any bugs
that I'm aware of. There's still value in separating parsing and usage
more clearly and simplifying `format_commit_one()`.

Note that we use two different types for these values, `unsigned long`
when parsing, `size_t` when eventually applying. Let's go for `size_t`
in our struct. I don't know if there are platforms where assigning an
`unsigned long` to a `size_t` could truncate the value, but since we
already verify the values to be at most 16 KiB, we should be able to fit
them into any sane `size_t`s.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 pretty.c | 120 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 44 deletions(-)

diff --git a/pretty.c b/pretty.c
index f53e77ed86..c44ff87481 100644
--- a/pretty.c
+++ b/pretty.c
@@ -893,6 +893,10 @@ struct padding_args {
 	int padding;
 };
 
+struct rewrap_args {
+	size_t width, indent1, indent2;
+};
+
 struct format_commit_context {
 	struct repository *repository;
 	const struct commit *commit;
@@ -902,7 +906,7 @@ struct format_commit_context {
 	struct signature_check signature_check;
 	const char *message;
 	char *commit_encoding;
-	size_t width, indent1, indent2;
+	struct rewrap_args rewrap;
 	int auto_color;
 	struct padding_args pad;
 
@@ -1034,18 +1038,21 @@ static void strbuf_wrap(struct strbuf *sb, size_t pos,
 
 static void rewrap_message_tail(struct strbuf *sb,
 				struct format_commit_context *c,
-				size_t new_width, size_t new_indent1,
-				size_t new_indent2)
+				const struct rewrap_args *new_rewrap)
 {
-	if (c->width == new_width && c->indent1 == new_indent1 &&
-	    c->indent2 == new_indent2)
+	const struct rewrap_args *old_rewrap = &c->rewrap;
+
+	if (old_rewrap->width == new_rewrap->width &&
+	    old_rewrap->indent1 == new_rewrap->indent1 &&
+	    old_rewrap->indent2 == new_rewrap->indent2)
 		return;
+
 	if (c->wrap_start < sb->len)
-		strbuf_wrap(sb, c->wrap_start, c->width, c->indent1, c->indent2);
+		strbuf_wrap(sb, c->wrap_start, old_rewrap->width,
+			    old_rewrap->indent1, old_rewrap->indent2);
+
 	c->wrap_start = sb->len;
-	c->width = new_width;
-	c->indent1 = new_indent1;
-	c->indent2 = new_indent2;
+	c->rewrap = *new_rewrap;
 }
 
 static int format_reflog_person(struct strbuf *sb,
@@ -1443,6 +1450,57 @@ static void free_decoration_options(const struct decoration_options *opts)
 	free(opts->tag);
 }
 
+static size_t parse_rewrap(const char *placeholder, struct rewrap_args *rewrap)
+{
+	unsigned long width = 0, indent1 = 0, indent2 = 0;
+	char *next;
+	const char *start;
+	const char *end;
+
+	memset(rewrap, 0, sizeof(*rewrap));
+
+	if (placeholder[1] != '(')
+		return 0;
+
+	start = placeholder + 2;
+	end = strchr(start, ')');
+
+	if (!end)
+		return 0;
+	if (end > start) {
+		width = strtoul(start, &next, 10);
+		if (*next == ',') {
+			indent1 = strtoul(next + 1, &next, 10);
+			if (*next == ',') {
+				indent2 = strtoul(next + 1,
+						 &next, 10);
+			}
+		}
+		if (*next != ')')
+			return 0;
+	}
+
+	/*
+	 * We need to limit the format here as it allows the
+	 * user to prepend arbitrarily many bytes to the buffer
+	 * when rewrapping.
+	 */
+	if (width > FORMATTING_LIMIT ||
+	    indent1 > FORMATTING_LIMIT ||
+	    indent2 > FORMATTING_LIMIT)
+		return 0;
+
+	/*
+	 * These values are small enough to fit in any
+	 * real-world size_t.
+	 */
+	rewrap->width = width;
+	rewrap->indent1 = indent1;
+	rewrap->indent2 = indent2;
+
+	return end - placeholder + 1;
+}
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				struct format_commit_context *c)
@@ -1478,40 +1536,13 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			return ret;
 		}
 	case 'w':
-		if (placeholder[1] == '(') {
-			unsigned long width = 0, indent1 = 0, indent2 = 0;
-			char *next;
-			const char *start = placeholder + 2;
-			const char *end = strchr(start, ')');
-			if (!end)
-				return 0;
-			if (end > start) {
-				width = strtoul(start, &next, 10);
-				if (*next == ',') {
-					indent1 = strtoul(next + 1, &next, 10);
-					if (*next == ',') {
-						indent2 = strtoul(next + 1,
-								 &next, 10);
-					}
-				}
-				if (*next != ')')
-					return 0;
-			}
-
-			/*
-			 * We need to limit the format here as it allows the
-			 * user to prepend arbitrarily many bytes to the buffer
-			 * when rewrapping.
-			 */
-			if (width > FORMATTING_LIMIT ||
-			    indent1 > FORMATTING_LIMIT ||
-			    indent2 > FORMATTING_LIMIT)
-				return 0;
-			rewrap_message_tail(sb, c, width, indent1, indent2);
-			return end - placeholder + 1;
-		} else
-			return 0;
-
+		{
+			struct rewrap_args rewrap;
+			res = parse_rewrap(placeholder, &rewrap);
+			if (res)
+				rewrap_message_tail(sb, c, &rewrap);
+			return res;
+		}
 	case '<':
 	case '>':
 		return parse_padding_placeholder(placeholder, &c->pad);
@@ -2005,6 +2036,7 @@ void repo_format_commit_message(struct repository *r,
 	};
 	const char *output_enc = pretty_ctx->output_encoding;
 	const char *utf8 = "UTF-8";
+	const struct rewrap_args rewrap_reset = { 0 };
 
 	while (strbuf_expand_step(sb, &format)) {
 		size_t len;
@@ -2016,7 +2048,7 @@ void repo_format_commit_message(struct repository *r,
 		else
 			strbuf_addch(sb, '%');
 	}
-	rewrap_message_tail(sb, &context, 0, 0, 0);
+	rewrap_message_tail(sb, &context, &rewrap_reset);
 
 	/*
 	 * Convert output to an actual output encoding; note that
-- 
2.49.0.472.ge94155a9ec

