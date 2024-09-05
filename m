Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC6D1A42CC
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557710; cv=none; b=TYTmkg0OzLshLR1pRoFXbrstHYgcnBz7kfIX8Utgx9dUkKWHHlo5sy7Ku3Uzn7oChHBeE3BXT8Ey9wiK0hjGDut8+fLILi/IdSFu6ekrPJMt17AweGjMKLppelhm4mtZsiE9ngqHmG0fbPsFIfJsxTYlrn8ELY8aHZ4oRHllC8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557710; c=relaxed/simple;
	bh=J2p94uug/oQ0VDvXe5LZDMWHrRJJm4xNjpAQe/b96n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLVm4TDkwMgzFUxIpcgaSbwTH4n99EDKkQDb2neyGBjjI+RsAOpTXJvRjnhauPe6b69SNNK5ehfAJ0Rope8txqouBg6oA4pLV3CGpF9isLEoOiYeDnm0TDvLa9oCfgC28/pzOB1HS6UaacT0Ch5g7ros4EeYJKfiGNntkJsPbt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlPyzr1j; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlPyzr1j"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5dfaff47600so578537eaf.0
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 10:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725557707; x=1726162507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MK3D2tVnTf383ggKOXQT3gAZ7kk4lIC2BnsWfAKrH5U=;
        b=YlPyzr1jwBB1+fTa0IWTi1Eri/uAniTZ6dFlC61HYw/PE0Vd3ayBI1Fssj0gOtAW2h
         fhT5TINpJANa7QlU4uQjf6J+H+4odHq7W1ZTjUWMYOGAQnuBpE761XKWgCUriZpJQmbp
         MUfr2wurcAV7ykdwiHEI9w3gNZLaWt3vBzW+C6v2ET1xINJvbcrJA4btN3OY1MqMmVV+
         Q8Z7UqKVhb+tOZsn9ehDgpQ8NawKIubDe6TxsvmS4sl2KPyvaeGrCgXnd0VkW1O1mPP9
         N5gFS3J5fiUhJ/vOXzgk9CzK+tFjqIieLMQ6F8EHOUtP+lB7JciocDeNjZ4RRdz2JqEG
         Uvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725557707; x=1726162507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MK3D2tVnTf383ggKOXQT3gAZ7kk4lIC2BnsWfAKrH5U=;
        b=dbKaVrEfFpATu8ZUn9WVxxDdKPBH1BiPy82lpi1YCCfc8dg9WSnkvZPD37+sbi+Yb4
         Ork8+6U810tVeqja+SYYyXZr7MK/EjBcECHZxn1DT/Hs3rLvG+TlRHrMcoNYWDO7ZFkK
         b1gDI4OD/lOxU3FkxomXEyfkrMdZPHRnn6i7NwE4V8Om0MaJ90e2lEH3b+TcNaDexcMB
         HTeKKeNTiZRuA5xPhx20GZdw5oYJi9BxJXRtniZKRXL/WorkpE1I1ViTb26li/whaiqr
         C+BPeJWpLSTE/n66BHsTO7zQ9CHFe2DGtrfP8YCVZeeCIiBSviCR2FOxeAwfkRF9JktZ
         OvOg==
X-Gm-Message-State: AOJu0YxIYZil+63+1liTUq59nsdgMhdLFe5AZZySnLisVXOLGQKgW/uh
	xNBqQ7bOWgMrnYDiJ9YP+8KzUeykiOyPxkf++jSUdyyYXFL1n4y26VVKeg==
X-Google-Smtp-Source: AGHT+IGTqXUx26JlD8wnG6BmSAXcpQckhnfaS6L+ua4V9/UZLAS5JUoUWlmb/VKCPBgggTvPozV3Vw==
X-Received: by 2002:a05:6870:e0c9:b0:277:d279:364c with SMTP id 586e51a60fabf-27b4c9abac7mr3035849fac.20.1725557707164;
        Thu, 05 Sep 2024 10:35:07 -0700 (PDT)
Received: from localhost.localdomain (syn-024-241-228-214.res.spectrum.com. [24.241.228.214])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2782c797ec7sm1194116fac.21.2024.09.05.10.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 10:35:06 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>
Subject: [PATCH] interpret-trailers: handle message without trailing newline
Date: Thu,  5 Sep 2024 12:34:40 -0500
Message-ID: <20240905173445.1677704-1-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-interpret-trailers is used to add a trailer to a message that
does not end in a trailing newline, the new trailer is added on the line
immediately following the message instead of as a trailer block
separated from the message by a newline character.

For example, if a message's text was "The subject" with no trailing
newline at all, `git interpret-trailers --trailer my-trailer=true` will
result in the following malformed commit message:

    The subject
    my-trailer: true

While it is generally expected that a commit message should end with a
newline character, git-interpret-trailers should not be returning an
invalid message in this case.

Detect when a message exists but does not end with a newline character,
and add an extra newline before appending the new trailer.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 builtin/interpret-trailers.c  | 12 ++++++-----
 t/t7513-interpret-trailers.sh | 40 +++++++++++++++++++++++++++++++++++
 trailer.c                     | 18 ++++++++++++++++
 trailer.h                     |  5 +++++
 4 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 1d969494cf..9d8f94341d 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -153,13 +153,15 @@ static void interpret_trailers(const struct process_trailer_options *opts,

 	info = parse_trailers(opts, sb.buf, &head);

-	/* Print the lines before the trailers */
-	if (!opts->only_trailers)
+	if (!opts->only_trailers) {
+		/* Print the lines before the trailers */
 		fwrite(sb.buf, 1, trailer_block_start(info), outfile);

-	if (!opts->only_trailers && !blank_line_before_trailer_block(info))
-		fprintf(outfile, "\n");
-
+		if (message_without_trailing_newline_before_trailer_block(info))
+			fprintf(outfile, "\n\n");
+		else if (!blank_line_before_trailer_block(info))
+			fprintf(outfile, "\n");
+	}

 	if (!opts->only_input) {
 		LIST_HEAD(config_head);
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 3d3e13ccf8..d5303c3f74 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -175,6 +175,46 @@ test_expect_success 'with only a title in the message' '
 	test_cmp expected actual
 '

+test_expect_success 'with a bodiless message that lacks a trailing newline after the subject' '
+	cat >expected <<-\EOF &&
+		area: change
+
+		Reviewed-by: Peff
+		Acked-by: Johan
+	EOF
+	printf "area: change" | \
+	git interpret-trailers --trailer "Reviewed-by: Peff" \
+		--trailer "Acked-by: Johan" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with a bodied message that lacks a trailing newline after the body' '
+	cat >expected <<-\EOF &&
+		area: change
+
+		details about the change.
+
+		Reviewed-by: Peff
+		Acked-by: Johan
+	EOF
+	printf "area: change\n\ndetails about the change." | \
+	git interpret-trailers --trailer "Reviewed-by: Peff" \
+		--trailer "Acked-by: Johan" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with a message that lacks a trailing newline after the trailers' '
+	cat >expected <<-\EOF &&
+		area: change
+
+		Reviewed-by: Peff
+		Acked-by: Johan
+	EOF
+	printf "area: change\n\nReviewed-by: Peff" | \
+	git interpret-trailers --trailer "Acked-by: Johan" >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with multiline title in the message' '
 	cat >expected <<-\EOF &&
 		place of
diff --git a/trailer.c b/trailer.c
index 72e5136c73..9c19632b6d 100644
--- a/trailer.c
+++ b/trailer.c
@@ -18,6 +18,12 @@ struct trailer_info {
 	 */
 	int blank_line_before_trailer;

+	/*
+	 * True if the last character before the location pointed to be
+	 * trailer_block_start is a newline character.
+	 */
+	int message_without_trailing_newline_before_trailer;
+
 	/*
 	 * Offsets to the trailer block start and end positions in the input
 	 * string. If no trailer block is found, these are both set to the
@@ -946,6 +952,11 @@ static int ends_with_blank_line(const char *buf, size_t len)
 	return is_blank_line(buf + ll);
 }

+static int has_message_without_trailing_newline_char(const char *buf, size_t len)
+{
+	return len > 0 && buf[len - 1] != '\n';
+}
+
 static void unfold_value(struct strbuf *val)
 {
 	struct strbuf out = STRBUF_INIT;
@@ -1017,6 +1028,8 @@ static struct trailer_info *trailer_info_get(const struct process_trailer_option

 	info->blank_line_before_trailer = ends_with_blank_line(str,
 							       trailer_block_start);
+	info->message_without_trailing_newline_before_trailer
+		= has_message_without_trailing_newline_char(str, trailer_block_start);
 	info->trailer_block_start = trailer_block_start;
 	info->trailer_block_end = end_of_log_message;
 	info->trailers = trailer_strings;
@@ -1090,6 +1103,11 @@ int blank_line_before_trailer_block(struct trailer_info *info)
 	return info->blank_line_before_trailer;
 }

+int message_without_trailing_newline_before_trailer_block(struct trailer_info *info)
+{
+	return info->message_without_trailing_newline_before_trailer;
+}
+
 void trailer_info_release(struct trailer_info *info)
 {
 	size_t i;
diff --git a/trailer.h b/trailer.h
index 6eb53df155..04148be432 100644
--- a/trailer.h
+++ b/trailer.h
@@ -125,6 +125,11 @@ size_t trailer_block_end(struct trailer_info *);
  */
 int blank_line_before_trailer_block(struct trailer_info *);

+/*
+ * Return 1 if the trailer block had a newline character
+ */
+int message_without_trailing_newline_before_trailer_block(struct trailer_info *);
+
 /*
  * Free trailer_info struct.
  */
--
2.45.2
