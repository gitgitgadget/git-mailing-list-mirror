Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422723CEF8
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753548838; cv=none; b=XqVnG8QhWHDGAOEjTJvFA7WPf5ZOH9W5Eh0L130ZNgdApoE/7/D0UlZh41y4mLPulvDakfRa8JXO/Z/D+KwMkbOTTuQwo3bUNjyB0i+LBi6p53xCSWJK5ySuzrV0S+Sf/1hoTrSvhA1xKdd+ALJ3Vowwi8nAaFL7eG0GvkcuRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753548838; c=relaxed/simple;
	bh=elSAhhu4XTHJL6fZqATrXtAskpqIhbCisd8NURMeEs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZfWy9maNCM1IEagUhqbRwdS+HboflY0/j3af9m/Y5pAGgEU5aPWNaHTIXsQFfi1DHZmB2eRJys/15nJGE+UVlFsJyB/bMoSJpaRHrUCN5IOQSplELz7fQ9fApX8xtlC91hQyFgJubj3JBQREtofI2BQbzeGZ6qK0U3G193o7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIOcbg7E; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIOcbg7E"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71840959355so29403257b3.1
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753548835; x=1754153635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkiP8UDwxv4LXk/C/GuQZ8W0lEqEvGZ0Agk9HzHuJ3k=;
        b=MIOcbg7Esfbs1vaOXL2KkS/PZDKt6lo+WCgTZd5uOY+jf2oHd9jj1mh2c4/eYOmcAx
         fQ8PWrG7fMR8w3I5wbM3+JLwqpOt8J9V/HPFbH+4YmSZXJ2l7xqt+hXApHPcAz0S8qCv
         lgnxgXI8ZXbIHQ+c9s94gd0wLXy02AMOMUPEQYxmbPwB6ShTSrbIfmUEtwob7sNJ1Umy
         qOr5FVlFmmyVmdjtaJ7ZUeIcF0ijHDuC+MiG+q4WHbhH8fAQZNR/pDcddW+l9vPoa3AM
         YbfqhARnudyIHH33I8MOeqo2OCtQDNVCLIA7wmzT0iJ+3/kmxiH4RcnhwotmBnfGNcFj
         1qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753548835; x=1754153635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OkiP8UDwxv4LXk/C/GuQZ8W0lEqEvGZ0Agk9HzHuJ3k=;
        b=dWeG5YrzBvhuF0asZa4w5B6zxc3rKQHh46HGpTzBR34Gl83M5LhJCTr4nuQ3MDBWcD
         vpUKbX++sE5SdYRKiByITe/ZGLiezcI/8KDEpMDXHEieVxFGsPWQK9+xd3YguajFp1p5
         mt/Fq+acjICLIR6XcGbdz9l4BcEzdn+e2Q79bLcggDQOXNu8Xs2464wQFcqO9cPaGeKU
         T/VP7jG398Cfpn450jVPTwH4YPRkxoeKGb8vgn3YJnukHbAN9pVdaeWmezxjR49Mu17K
         PlIUtqGPPvX5SzY+wnu0mzdFAasH6HIMR7Bv9/917Xht3uzwEraVUaJSGmyTRDp2hcGE
         PYTg==
X-Gm-Message-State: AOJu0YzG/mA9JYNXKsHnRWFag3+ibqYsZ8QHFzKXfOkvHdc+J779lSIT
	Hkqnorv5Bj3AHisn+WyML6ulzLVEMxOyScOCvTOuLEB1kcL+XMkWW/KfUoRL4PjD
X-Gm-Gg: ASbGncsyXBcNgP1YaIKjVj/VAJ6R4Nj2/q30JF/Iiou/ne/vBIXeEao0Mf9EBgOV1E+
	PrkW1EoUtx4BULSs9PCS4CGqpJrkrNtm4iL/rTeuzsowN4R/Q9Hd6wgN3XA9KE4L4gRU+g0zeXL
	gYL7K5lMzXfh3ATkSebhO8B4/IvbUmTTjHo0Z+9jFHeZXka+GcXXAd/6Zof6/3ZhFL047KaNs+m
	zOy57qonksCUrci34riLbVKpJrBzTliZdnblrD42suk2yFBxUbYdx8+sdYTvCexhA6NcP8D48xP
	5F1Lq65V1bb5ZvZ5v8hAQWzF5lNIQRLysgvQghGZ/0LmmYWVeTnjeASXrftXWNMHad1CTWl/Ryl
	B9UHspAABZowJpruIsZi4DldZxgFd5keFmNm/7vyP/aJ3o7nrqm9pqRya6C+CEE30IuRhTRuv
X-Google-Smtp-Source: AGHT+IHR1k/gHK5SyUqB1BH+3c/AacRfGS0mFa2mAuUsKkW1RkOLcy2yHZYl0HlhiK6cudJpPONTEw==
X-Received: by 2002:a05:690c:4c07:b0:719:a0ff:1bd1 with SMTP id 00721157ae682-719e329a4a8mr75159867b3.3.1753548835142;
        Sat, 26 Jul 2025 09:53:55 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:2412:fdcb:5dca:324c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f2152de0sm4964067b3.2.2025.07.26.09.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 09:53:54 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Andrzej Hunt <ajrhunt@google.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 2/4] parse-options: name flags passed to usage_with_options_internal
Date: Sat, 26 Jul 2025 12:53:12 -0400
Message-ID: <20250726165320.4039-3-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726165320.4039-1-ben.knoble+github@gmail.com>
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading or editing calls to usage_with_options_internal, it is
difficult to tell what trailing "0, 0", "0, 1", "1, 0" arguments mean
(NB there is never a "1, 1" case).

Give the flags readable names to improve call-sites.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 parse-options.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 5224203ffe..c3222cc9bb 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -953,10 +953,21 @@ static void free_preprocessed_options(struct option *options)
 	free(options);
 }
 
+enum usage_style {
+	style_normal = 0,
+	style_full = 1,
+};
+
+enum usage_output {
+	to_out = 0,
+	to_err = 1,
+};
+
 static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *,
 							 const char * const *,
 							 const struct option *,
-							 int, int);
+							 enum usage_style,
+							 enum usage_output);
 
 enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 					 const struct option *options,
@@ -1088,7 +1099,7 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 		}
 
 		if (internal_help && !strcmp(arg + 2, "help-all"))
-			return usage_with_options_internal(ctx, usagestr, options, 1, 0);
+			return usage_with_options_internal(ctx, usagestr, options, style_full, to_out);
 		if (internal_help && !strcmp(arg + 2, "help"))
 			goto show_usage;
 		switch (parse_long_opt(ctx, arg + 2, options)) {
@@ -1129,7 +1140,7 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 	return PARSE_OPT_DONE;
 
  show_usage:
-	return usage_with_options_internal(ctx, usagestr, options, 0, 0);
+	return usage_with_options_internal(ctx, usagestr, options, style_normal, to_out);
 }
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
@@ -1278,10 +1289,11 @@ static const struct option *find_option_by_long_name(const struct option *opts,
 static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 							 const char * const *usagestr,
 							 const struct option *opts,
-							 int full, int err)
+							 enum usage_style help_style,
+							 enum usage_output to_where)
 {
 	const struct option *all_opts = opts;
-	FILE *outfile = err ? stderr : stdout;
+	FILE *outfile = to_where == to_err ? stderr : stdout;
 	int need_newline;
 
 	const char *usage_prefix = _("usage: %s");
@@ -1327,7 +1339,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 	if (!usagestr)
 		return PARSE_OPT_HELP;
 
-	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
+	if (to_where != to_err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
 		fprintf(outfile, "cat <<\\EOF\n");
 
 	while (*usagestr) {
@@ -1373,7 +1385,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 				fprintf(outfile, "%s\n", _(opts->help));
 			continue;
 		}
-		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
+		if (help_style != style_full && (opts->flags & PARSE_OPT_HIDDEN))
 			continue;
 
 		if (need_newline) {
@@ -1435,7 +1447,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 	}
 	fputc('\n', outfile);
 
-	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
+	if (to_where != to_err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
 		fputs("EOF\n", outfile);
 
 	return PARSE_OPT_HELP;
@@ -1444,7 +1456,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 void NORETURN usage_with_options(const char * const *usagestr,
 			const struct option *opts)
 {
-	usage_with_options_internal(NULL, usagestr, opts, 0, 1);
+	usage_with_options_internal(NULL, usagestr, opts, style_normal, to_err);
 	exit(129);
 }
 
@@ -1453,7 +1465,7 @@ void show_usage_with_options_if_asked(int ac, const char **av,
 				      const struct option *opts)
 {
 	if (ac == 2 && !strcmp(av[1], "-h")) {
-		usage_with_options_internal(NULL, usagestr, opts, 0, 0);
+		usage_with_options_internal(NULL, usagestr, opts, style_normal, to_out);
 		exit(129);
 	}
 }
-- 
2.48.1

