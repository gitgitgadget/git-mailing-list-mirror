Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50811E991C
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740865650; cv=none; b=a+nZmgZTV7wPqDwFZo9zZGvz8PK/yv9VAzI5fKi5JhRAMCzuHBmbsZZYHkOpOk/vsyPspAxN8KbJeI1QLpeTkxvXW16XIhsnPlt4uEUxgvaWWS+nIdx2GzDokFsZRyF+9ZORKVdUTegxRIy9oSn35JUp5JPUgpQe8cW1kByllMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740865650; c=relaxed/simple;
	bh=3p3CjtTAA9Tyll1U8MG8IX6QmrC0iBIV+FCZXB6bduU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1PsdnMVNuHYKSCgYSP9z8+hqczRhgYObCmqCY2TTsEjz+3ACnASnMmDWfTNcrMkmMBPuuwCVQ7BV4OeTf5zodubyfFzsuKRtkb4hXmfsZ+wsDDdMU+eWR5gY6LhfzPcHBJ24H5h6T66+18caxDHfyt0qaUuzzuDJxWfbPIP8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FycFI8nY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FycFI8nY"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4399deda4bfso20683905e9.0
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 13:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740865646; x=1741470446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRmau5uUyHk6jNgM0jPab9HfShG255P/19UzAucOb4Y=;
        b=FycFI8nYj7OqyscZ0G5MsVszMRn2gQsi1zPMEGknbnKsxSBoUDeKXxYIvn7xKrBf81
         oQ8IAlNJs5TlgwO4xpSF27vkS0WIYXU3FC1sYkb+6tqlyjsw/R+DYXpXiP+vyNDdOVKt
         Z5ryNwv4lBfgWwpW+CIIkbEWuxfkS7g0LJ7rfLGiWpBdy/a9+6Xf8jWnIIsLRLFeepKK
         Aredz5tckjbmwsoHXhzqLiUz00Q8gAaUX0042uLhl81Rn0avRWNGDVhKwRNLt0Ql1fab
         kWcuy9HTegBreOmCgMOkNiPwVwM8DdVmjHwQofcO9Hs33XlWOfhe97t1B2aRKOYEtlH+
         JoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740865646; x=1741470446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRmau5uUyHk6jNgM0jPab9HfShG255P/19UzAucOb4Y=;
        b=k/JMgMyHPUFUrwrSGcTpwnUR0HaqgzzrEPNmw/vs2ECEJeTVVWxlOy/RKQqz81QN4N
         NBiXTESmfZRWebbSavwzIYgRhbNoUNrphRfvF7rttNzjQa1XYbovyKxSw6xtNzXA7ywa
         1e1pXG0su4qPgpdqLGeX044J41ctUykJIdB1o/tZNgQXzVPjzzZ9ECboju1SSevf/N5b
         59Rumnbyfi3IMa73WT3785CFr6Y7uwnTvF/j75nE6JXpf8GhYC25XHQoI7DdvvWABhGW
         bUh+0S32ajpCOqJV9KsjC3yx7ZW3k6pZflCtukj+BHKrcxMLJgdydf3V6+hCK3zJqcpg
         BHHA==
X-Gm-Message-State: AOJu0YzbGyhtc3qNIQ+5VNgTrqaNACpFqYS95OEcYmsVdPwsx/yqFX6X
	XDWu+k42SzvbnvS6GcNbj93T8Q2rnxbj7cQvU6VPvynWkUfOa0GXmnexz+u+
X-Gm-Gg: ASbGncv3HO9wxERmXABPC7UuQFRL4QoOPpjNDKTi2d2ShpsCwXCabwwoMjV/0E2TQ7A
	nR8x+WbpG02WVMLunudq9OrCJJcJh4CQ8B392BH/40A4Qy4Uc0kfi1Zos7OkCrFvcdZDu7eRtcx
	TOcE0hlWreRnlh/NBfGsw8oQLevojEHatyJME4tSGVSHc5mAruivZ/l4PKnijtIS2uSiQvxVzM2
	UXpkGbkHanVMumggN8d4CPBhDH6Bkz3OKkpunnw8pF5tEe6YM9jjfMw3PIgG0Gj03Bo4C1jKk9B
	B0NPBFb1Hw2CFVEWCqpeV36G3PZ0GsWp/D5EGgiR2w5vaqQk4skK62Q42d9Z/G+dLFd05xq7EP6
	OrIpk
X-Google-Smtp-Source: AGHT+IEoDKyV8U94UTAwuvgcbbrF6vO8KNH0a81w/zDqXwCHyvItScMYsjc87Gi0qRYlpiPg6Pny6w==
X-Received: by 2002:a5d:6da3:0:b0:390:e76f:163 with SMTP id ffacd0b85a97d-390eca52819mr7643482f8f.45.1740865645860;
        Sat, 01 Mar 2025 13:47:25 -0800 (PST)
Received: from aleksbgbg.communityfibre.co.uk ([103.205.25.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a72d5sm9603474f8f.31.2025.03.01.13.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 13:47:24 -0800 (PST)
From: Aleks Todorov <aleks.todorov.1337@gmail.com>
To: git@vger.kernel.org
Cc: Aleks Todorov <aleks.todorov.1337@gmail.com>
Subject: [PATCH 3/7] pretty: Add F and L format specifiers
Date: Sat,  1 Mar 2025 21:45:02 +0000
Message-ID: <20250301214652.536439-4-aleks.todorov.1337@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
References: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the F (filename) and L (line number) format specifiers. These are to
be used with blame only and therefore only work with blame.

Signed-off-by: Aleks Todorov <aleks.todorov.1337@gmail.com>
---
 pretty.c | 14 ++++++++++++++
 pretty.h |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/pretty.c b/pretty.c
index 0bc8ad8a9a..d2b7284854 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1446,6 +1446,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	const char *arg, *eol;
 	size_t res;
 	char **slot;
+	char line_number[16];
 
 	/* these are independent of the commit */
 	res = strbuf_expand_literal(sb, placeholder);
@@ -1549,6 +1550,19 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	if (!commit->object.parsed)
 		parse_object(the_repository, &commit->object.oid);
 
+	if (c->pretty_ctx->is_blame) {
+		switch (placeholder[0]) {
+		case 'F':		/* filename */
+			strbuf_addstr(sb, c->pretty_ctx->filename);
+			return 1;
+		case 'L':		/* line number */
+			snprintf(line_number, sizeof(line_number), "%zu",
+				 c->pretty_ctx->line);
+			strbuf_addstr(sb, line_number);
+			return 1;
+		}
+	}
+
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
diff --git a/pretty.h b/pretty.h
index df267afe4a..eb54070ecb 100644
--- a/pretty.h
+++ b/pretty.h
@@ -51,6 +51,11 @@ struct pretty_print_context {
 	unsigned encode_email_headers:1;
 	struct pretty_print_describe_status *describe_status;
 
+	/* Blame fields */
+	bool is_blame;
+	const char *filename;
+	size_t line;
+
 	/*
 	 * Fields below here are manipulated internally by pp_* functions and
 	 * should not be counted on by callers.
-- 
2.43.0

