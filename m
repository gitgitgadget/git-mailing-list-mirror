Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327340;
	b=OXy1x0HbvHRx0ucxwYE0vtQUDOKgU0CWlV4q0K30EQEdmy0WGqXGGdZ0DoUErwMSe7gW
	 2LfalgEWJ1MnPKhI+TaXnOudv+1KF+ChxZumWsopkYGMgJdKqc2nYjKNhVwOJSZvX/1Pq
	 KWMM7bfDwGere/ldTdFHh7wj6nfbhNatwhTep1PF9E2NxserHMB8Zip2Jv7xoVd+HU2AC
	 zTrrlTARVo49qmVw/nlBRyqv48cfCe5MKiInIw+izP8NsBjoyYCp2veK2AH2WzcrssZAV
	 JUsVvDIfL55Acy6ikCvYyRt1oGCCZaRzAYa3+Ua/9Ixr/IN6cZdEYKOD62O2eSKjbGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m7yMSo9RP4xDtIQgpqDWJChhMP3j2jKw1hHTiRsv2R8=;
	b=anqiD+e2NjRSy8EO8xSpQEq80dPLnjjXxRdSFk6ThZ/MML1AkPd/KE4tC/WvjNCSj2iB
	 vcCLPR2ldbvNBtYKajV7Z0C6MyhDv3T8d+FXAIPvO3toklRk0PThZpXZnFFAO9MoC9pMr
	 lQLqXYhKkY/mpUM2Z1yXzX2PN1Z5q3mehW6ZFtl8p/82DXrCSN0Ijm8s6tHdPxQI9bt36
	 lo2/H2oMJhQ5+lcC1QKI2S+5q6xQFR0AiPskHLkVERf8b4bAgke7bDVMP2rcOQh7GoznM
	 0zsufQTJniTSHYScq8N6jKYsAvDuNTLmLKG46NY3D+p7dAL6L0YoEPYzm7DPb1Bobsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tjYtswL8;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD18606A320
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FD18606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tjYtswL8
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4682977f9aso281360266b.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 08:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794327338; x=1794932138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m7yMSo9RP4xDtIQgpqDWJChhMP3j2jKw1hHTiRsv2R8=;
        b=tjYtswL8ApiLCg8Rinlc8m8K352EMpaPwiYpsvVe7bkrqhEKZ1EansVeBiXbeYCH5U
         0vyCVV4vCpgwQsRr1uhGh7+AoaJc0pPavcld0JkL6Ad2tDZ0K6BTpc20gH8HS1KiALyI
         mVkMV+hInsPT3M7lazYYS1v7IHAg1CmIsfWb0YXSZ2ElqSw3reIXDOTPNHlsSgPbUtXM
         R2NCGtxeEeB2bQgbc/HkH30ewJ941+rM24vCNygM4qb7m6vxJCFkDWFUT7mkTWT9r3od
         1oifdDUPbZNpPdA9PB8HoZzUGtramGtsjxtDOPKCzjcnQKC0Ij4Qov8LeJzwIYAcyWGW
         aDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327338; x=1794932138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m7yMSo9RP4xDtIQgpqDWJChhMP3j2jKw1hHTiRsv2R8=;
        b=mu0WmG4g2H0CMmqf8JicnAVuZUNgx1Pg9bMt2X/uib8rKksGZ67ZRS0j500VWcx61Q
         AXDlIb2yUHSgI+JPyhe/P9qd7phIshCBoGrvGFuWyMKkfzYuOtQEZBnohTAgwc9NB5Zr
         Cickc4wWIgOEDulI6n1UIWHL4IZ2K66KhPzUf6x/nnCVJ0dfVUwp6Zt+F4xQKxNOrVoI
         j+EaW3eK5YP+HrIxS/dWx7AXdztUshst1BugaYc2w5F0vbTSHM/ulawGIvtfzyRlxyw8
         kpAMkDVifcVbVTU7EAo2T7JXQPs6cfH9CXSLsp4I4NBlDQDdtn6RxqNVQRe0eajGUdnJ
         1jRA==
X-Gm-Message-State: APuU4Z/2nXHS5De7a63UXj8ruNsFED8itvhmdAipTUR5nkClKAuAWpTo
	yQP8zAe5dI0OIfzTL+0ugFN6L1adEzPUvLPK2VYu8ekpOd9ebekcURITYBMP2/1ypKw=
X-Gm-Gg: AYBFou3pSJBcB4cwyTJykVrPtY7fKocZDUgNYYbJflJuclNFq2ifP36mOkcwB23O4zP
	i8qwyy1CUZXx6IcavaDoq2+KoO1mHYT956CbJcrbwvrnG8LkencZLIS92Gw++9cwcwg1QraxMDk
	YMIsv3T2Wrv/lMlNb7d1PL47AcIhC/uDMIa0TZuGDng/Qi4CH7Lb02xDTeFr42SDtUEn6iTpW8T
	ZTNqq0CjSPvJqS45Se9nLifsrp0W6/dF+gQiasfmL2fEzePvOoGeZJ3nulwM4kgbjxOYarsdsMe
	jraL/CQvgtvmz9nI8OKfjVDWQbv+0bG2bTMlpI/wCrU8hxttHpfKl97AzJtzVEwVY2IEjiZ4Ttp
	AYgIHJ2t/Xjmgv2l0gYtMS7n7fS108i0ViXlQZg24EG/W7B9tKmaejATD8Rrn3tPQE72p31Ini8
	TMfJbCcFGPluQP/XI1setbS5lu8ab2iAzxcJW1Oz+YXTnUWVRErUOVdJCPkabHimZg21Zzl92LB
	4U4QamgVOrlKgFGol4jAbYQQDHO9v/7zTvyMbKZsr9mDknhDJqidBBWOyZnhtmwhVC40tgmNeaV
	qmmOXVTYvbYs5l1pSmJgpM2rSmyGYK4C7lXW1SbqmjQhKXxhUTd2+GkFhqFsksg8
X-Received: by 2002:a17:907:1c9b:b0:c50:6222:7b0b with SMTP id a640c23a62f3a-c5062227f51mr26245266b.2.1794327337528;
        Tue, 10 Nov 2026 08:15:37 -0800 (PST)
Received: from zito.localdomain ([102.90.126.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a69ce38sm126209666b.84.2026.11.10.08.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:15:36 -0800 (PST)
From: Azuama Odinaka Maximus <azuama69@gmail.com>
To: git@vger.kernel.org
Cc: tangajoris@gmail.com,
	pushkarkumarsingh1970@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	Azuama Odinaka Maximus <azuama69@gmail.com>
Subject: [RFC PATCH 2/2] parse-options: add early option scanning
Date: Tue, 10 Nov 2026 17:13:13 +0100
Message-ID: <20261110161314.35213-3-azuama69@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110161314.35213-1-azuama69@gmail.com>
References: <20261110161314.35213-1-azuama69@gmail.com>
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

Signed-off-by: Azuama Odinaka Maximus <azuama69@gmail.com>
---
 parse-options.c               | 249 ++++++++++++++++++++++++++++++----
 parse-options.h               |  22 +++
 t/helper/test-parse-options.c | 236 ++++++++++++++++++++++++++++++++
 t/t0040-parse-options.sh      |   6 +
 4 files changed, 484 insertions(+), 29 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 283a0f1dc2..dbf2dbb04a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -423,6 +423,25 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 	return -1;
 }
 
+int parse_options_takes_argument(const struct option *opt)
+{
+	switch (opt->type) {
+	case OPTION_STRING:
+	case OPTION_FILENAME:
+	case OPTION_INTEGER:
+	case OPTION_UNSIGNED:
+	case OPTION_CALLBACK:
+		break;
+	default:
+		return 0;
+	}
+
+	if (opt->flags & (PARSE_OPT_NOARG | PARSE_OPT_OPTARG))
+		return 0;
+
+	return 1;
+}
+
 static enum parse_opt_result parse_short_opt(struct parse_opt_ctx_t *p,
 					     const struct option *options)
 {
@@ -515,17 +534,36 @@ static void register_abbrev(struct parse_opt_ctx_t *p,
 	abbrev->option = option;
 	abbrev->flags = flags;
 }
+enum long_opt_lookup {
+	LONG_OPT_EXACT,      /* exact match found */
+	LONG_OPT_ABBREV,     /* unambiguous abbreviation found */
+	LONG_OPT_AMBIGUOUS,  /* more than one candidate abbreviation */
+	LONG_OPT_UNKNOWN,    /* nothing matches */
+};
 
-static enum parse_opt_result parse_long_opt(
+/*
+ * Look up the long option named by `arg` (without its leading "--")
+ * without acting on it. (Neither prints nor dies.)
+ *
+ * `found` contains the matching option and flags.
+ * `other` is meaningful only for LONG_OPT_AMBIGUOUS.
+ * `stuck` points after '=' when an argument is attached, or is NULL.
+ */
+static enum long_opt_lookup lookup_long_opt(
 	struct parse_opt_ctx_t *p, const char *arg,
-	const struct option *options)
+	const struct option *options, struct parsed_option *found,
+	struct parsed_option *other, const char **stuck)
 {
+	enum opt_parsed flags = OPT_LONG;
 	const char *arg_end = strchrnul(arg, '=');
 	const char *arg_start = arg;
-	enum opt_parsed flags = OPT_LONG;
 	int arg_starts_with_no_no = 0;
-	struct parsed_option abbrev = { .option = NULL, .flags = OPT_LONG };
-	struct parsed_option ambiguous = { .option = NULL, .flags = OPT_LONG };
+
+	found->option = NULL;
+	found->flags = OPT_LONG;
+	other->option = NULL;
+	other->flags = OPT_LONG;
+	*stuck = NULL;
 
 	if (skip_prefix(arg_start, "no-", &arg_start)) {
 		if (skip_prefix(arg_start, "no-", &arg_start))
@@ -554,45 +592,75 @@ static enum parse_opt_result parse_long_opt(
 
 		if (skip_prefix(arg_start, long_name, &rest)) {
 			if (*rest == '=')
-				p->opt = rest + 1;
+				*stuck = rest + 1;
 			else if (*rest)
 				continue;
-			return get_value(p, options, flags ^ opt_flags);
+			found->option = options;
+			found->flags = flags ^ opt_flags;
+			return LONG_OPT_EXACT;
 		}
 
-		/* abbreviated? */
 		if (!strncmp(long_name, arg_start, arg_end - arg_start))
 			register_abbrev(p, options, flags ^ opt_flags,
-					&abbrev, &ambiguous);
+					found, other);
 
-		/* negated and abbreviated very much? */
 		if (allow_unset && starts_with("no-", arg))
 			register_abbrev(p, options, OPT_UNSET ^ opt_flags,
-					&abbrev, &ambiguous);
+					found, other);
 	}
 
-	if (disallow_abbreviated_options && (ambiguous.option || abbrev.option))
-		die("disallowed abbreviated or ambiguous option '%.*s'",
-		    (int)(arg_end - arg), arg);
-
-	if (ambiguous.option) {
-		error(_("ambiguous option: %s "
-			"(could be --%s%s or --%s%s)"),
-			arg,
-			(ambiguous.flags & OPT_UNSET) ?  "no-" : "",
-			ambiguous.option->long_name,
-			(abbrev.flags & OPT_UNSET) ?  "no-" : "",
-			abbrev.option->long_name);
-		return PARSE_OPT_HELP_ERROR;
-	}
-	if (abbrev.option) {
+	if (other->option)
+		return LONG_OPT_AMBIGUOUS;
+
+	if (found->option) {
 		if (*arg_end)
-			p->opt = arg_end + 1;
-		return get_value(p, abbrev.option, abbrev.flags);
+			*stuck = arg_end + 1;
+		return LONG_OPT_ABBREV;
 	}
-	return PARSE_OPT_UNKNOWN;
+
+	return LONG_OPT_UNKNOWN;
+}
+
+static enum parse_opt_result parse_long_opt(
+	struct parse_opt_ctx_t *p, const char *arg,
+	const struct option *options)
+{
+	struct parsed_option found;
+	struct parsed_option other;
+	const char *stuck;
+	enum long_opt_lookup result = lookup_long_opt(p, arg, options,
+						      &found, &other, &stuck);
+
+	switch (result) {
+	case LONG_OPT_UNKNOWN:
+		return PARSE_OPT_UNKNOWN;
+	case LONG_OPT_ABBREV:
+	case LONG_OPT_AMBIGUOUS:
+		if (disallow_abbreviated_options) {
+			const char *arg_end = strchrnul(arg, '=');
+			die("disallowed abbreviated or ambiguous option '%.*s'",
+			    (int)(arg_end - arg), arg);
+		}
+		if (result == LONG_OPT_AMBIGUOUS) {
+			error(_("ambiguous option: %s "
+				"(could be --%s%s or --%s%s)"),
+			      arg,
+			      (other.flags & OPT_UNSET) ? "no-" : "",
+			      other.option->long_name,
+			      (found.flags & OPT_UNSET) ? "no-" : "",
+			      found.option->long_name);
+			return PARSE_OPT_HELP_ERROR;
+		}
+		/* fallthrough */
+	case LONG_OPT_EXACT:
+		p->opt = stuck;
+		return get_value(p, found.option, found.flags);
+	}
+
+	BUG("unknown enum long_opt_lookup value '%d'", result);
 }
 
+
 static enum parse_opt_result parse_nodash_opt(struct parse_opt_ctx_t *p,
 					      const char *arg,
 					      const struct option *options)
@@ -1248,6 +1316,129 @@ int parse_options(int argc, const char **argv,
 	return parse_options_end(&ctx);
 }
 
+/*
+ * Look for `name`, a long option without its leading "--", among
+ * `option`, the way parse_options() would. Return true if it names an
+ * option exactly, or as an unambiguous abbreviation that is not
+ * disallowed, with `found` set to that option and its flags, and
+ * `stuck` to the value stuck to it, if any, or to NULL.
+ */
+static bool find_early_scan_option(struct parse_opt_ctx_t *p,
+				   const char *name,
+				   const struct option *option,
+				   bool disallow_abbrev,
+				   struct parsed_option *found,
+				   const char **stuck)
+{
+	struct parsed_option other;
+	enum long_opt_lookup result = lookup_long_opt(p, name, option,
+						      found, &other, stuck);
+
+	switch (result) {
+	case LONG_OPT_EXACT:
+		return true;
+	case LONG_OPT_ABBREV:
+		return !disallow_abbrev;
+	case LONG_OPT_AMBIGUOUS:
+	case LONG_OPT_UNKNOWN:
+		return false;
+	}
+
+	BUG("unknown enum long_opt_lookup value '%d'", result);
+}
+
+struct early_scan_state {
+	struct parse_opt_ctx_t ctx;
+	const struct option *option;
+	enum early_scan_flags flags;
+	early_scan_fn *fn;
+	void *data;
+	bool disallow_abbrev;
+};
+
+/*
+ * Look at argv[*i]. Return true to go on scanning, with *i on the
+ * last argument consumed. Return false to stop, with *i set to the
+ * first argument not consumed.
+ */
+static bool early_scan_one_option(struct early_scan_state *s,
+				  int argc, const char **argv, int *i)
+{
+	const char *name;
+	const char *value;
+	struct parsed_option found;
+	bool unset;
+	int pos = *i;
+	const char *arg = argv[pos];
+
+	if (!strcmp(arg, "--") || !strcmp(arg, "--end-of-options"))
+		return false;
+
+	/* Non-option */
+	if (*arg != '-' || !arg[1])
+		return !(s->flags & EARLY_SCAN_STOP_AT_NON_OPTION);
+
+	/* Short option */
+	if (!skip_prefix(arg, "--", &name))
+		return false;
+
+	if (!find_early_scan_option(&s->ctx, name, s->option,
+				    s->disallow_abbrev, &found, &value))
+		return false;
+
+	/* A low-level callback may consume any number of arguments. */
+	if (found.option->ll_callback)
+		return false;
+
+	unset = !!(found.flags & OPT_UNSET);
+
+	if (value && (unset || (found.option->flags & PARSE_OPT_NOARG)))
+		return false;
+
+	if (!value && !unset && parse_options_takes_argument(found.option)) {
+		if (pos + 1 < argc)
+			value = argv[++*i];
+		else if (found.option->flags & PARSE_OPT_LASTARG_DEFAULT)
+			value = (const char *)found.option->defval;
+		else
+			return false;
+	}
+	if ((found.option->flags & PARSE_OPT_EARLY) &&
+	    s->fn(found.option, value, unset, pos, s->data)) {
+		++*i;
+		return false;
+	}
+	return true;
+}
+
+int early_scan_options(int argc, const char **argv,
+		       const struct option *option,
+		       enum early_scan_flags flags,
+		       early_scan_fn *fn, void *data)
+{
+	struct early_scan_state s = {
+		.flags = flags,
+		.fn = fn,
+		.data = data,
+		.disallow_abbrev =
+			git_env_bool("GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS", 0),
+	};
+	struct option *real_option = preprocess_options(&s.ctx, option);
+	int i;
+
+	s.option = real_option ? real_option : option;
+	parse_options_check(s.option);
+
+	for (i = 0; i < argc; i++)
+		if (!early_scan_one_option(&s, argc, argv, &i))
+			break;
+
+	free_preprocessed_options(real_option);
+	free(s.ctx.alias_groups);
+	return i;
+}
+
+
 static int usage_argh(const struct option *opts, FILE *outfile)
 {
 	const char *s;
diff --git a/parse-options.h b/parse-options.h
index f68b51ceca..9c012b87a3 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -51,6 +51,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NODASH = 1 << 5,
 	PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
 	PARSE_OPT_FROM_ALIAS = 1 << 7,
+	PARSE_OPT_EARLY = 1 << 8, /* only for early_scan_options() */
 	PARSE_OPT_NOCOMPLETE = 1 << 9,
 	PARSE_OPT_COMP_ARG = 1 << 10,
 	PARSE_OPT_CMDMODE = 1 << 11,
@@ -423,6 +424,27 @@ int parse_options(int argc, const char **argv, const char *prefix,
 		  const struct option *options,
 		  const char * const usagestr[],
 		  enum parse_opt_flags flags);
+int parse_options_takes_argument(const struct option *opt);
+/*
+ * Called for each argument matching an option marked PARSE_OPT_EARLY.
+ */
+typedef int early_scan_fn(const struct option *option, const char *value,
+			  bool unset, int pos, void *data);
+
+enum early_scan_flags {
+	EARLY_SCAN_STOP_AT_NON_OPTION = 1 << 0,
+};
+
+/*
+ * Scan argv for options marked PARSE_OPT_EARLY.
+ * argv is not modified.
+ *
+ * Returns the index of the first argument not consumed by the scan.
+ */
+int early_scan_options(int argc, const char **argv,
+		       const struct option *option,
+		       enum early_scan_flags flags,
+		       early_scan_fn *fn, void *data);
 
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 950db78673..da66855f28 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -109,8 +109,244 @@ static void show(struct string_list *expect, int *status, const char *fmt, ...)
 	strbuf_release(&buf);
 }
 
+static int test_parse_options_takes_argument(void)
+{
+	int integer = 0;
+	int count = 0;
+	char *string = NULL;
+	unsigned int unsigned_value = 0;
+	char *filename = NULL;
+
+	struct option options[] = {
+		OPT_STRING(0, "string", &string, "value", "string option"),
+		OPT_INTEGER(0, "integer", &integer, "integer option"),
+		OPT_COUNTUP(0, "count", &count, "count option"),
+		{
+			.type = OPTION_CALLBACK,
+			.long_name = "optional",
+			.flags = PARSE_OPT_OPTARG,
+		},
+		{
+			.type = OPTION_CALLBACK,
+			.long_name = "noarg",
+			.flags = PARSE_OPT_NOARG,
+		},
+		{
+			.type = OPTION_CALLBACK,
+			.long_name = "callback",
+		},
+		OPT_UNSIGNED(0, "unsigned", &unsigned_value, "unsigned option"),
+		OPT_FILENAME(0, "filename", &filename, "filename option"),
+		OPT_END(),
+	};
+
+	if (!parse_options_takes_argument(&options[0]))
+		return error("STRING option should take an argument");
+
+	if (!parse_options_takes_argument(&options[1]))
+		return error("INTEGER option should take an argument");
+
+	if (parse_options_takes_argument(&options[2]))
+		return error("COUNTUP option should not take an argument");
+
+	if (parse_options_takes_argument(&options[3]))
+		return error("OPTIONAL argument should not be required");
+
+	if (parse_options_takes_argument(&options[4]))
+		return error("NOARG option should not take an argument");
+
+	if (!parse_options_takes_argument(&options[5]))
+		return error("required CALLBACK option should take an argument");
+	if (!parse_options_takes_argument(&options[6]))
+		return error("UNSIGNED option should take an argument");
+
+	if (!parse_options_takes_argument(&options[7]))
+		return error("FILENAME option should take an argument");
+
+	return 0;
+}
+
+struct early_scan_test_data {
+	int calls;
+	int pos;
+	const char *value;
+	int stop;
+};
+
+static int early_scan_test_callback(const struct option *option UNUSED,
+				    const char *value, bool unset UNUSED,
+				    int pos, void *data)
+{
+	struct early_scan_test_data *test_data = data;
+
+	test_data->calls++;
+	test_data->pos = pos;
+	test_data->value = value;
+
+	return test_data->stop;
+}
+
+static int test_early_scan_options(void)
+{
+	char *early_value = NULL;
+	char *ordinary_value = NULL;
+	struct early_scan_test_data data = { 0 };
+	struct option options[] = {
+		OPT_STRING(0, "early", &early_value, "value", "early option"),
+		OPT_STRING(0, "ordinary", &ordinary_value, "value",
+			"ordinary option"),
+		OPT_STRING(0, "early-default", &early_value, "value",
+			"early option with default"),
+		OPT_END(),
+	};
+	const char *args[] = {
+		"--ordinary", "ignored",
+		"--early=attached",
+		"--early", "separate",
+		"--", "--early", "after-dashdash",
+	};
+	const char *positional_args[] = {
+		"positional", "--early", "value",
+	};
+	const char *end_of_options_args[] = {
+		"--end-of-options", "--early", "ignored",
+	};
+	const char *short_option_args[] = {
+		"-e", "--early", "ignored",
+	};
+	const char *unknown_option_args[] = {
+		"--unknown", "--early", "ignored",
+	};
+	const char *missing_value_args[] = {
+		"--early",
+	};
+	const char *lastarg_default_args[] = {
+		"--early-default",
+	};
+	const char *callback_stop_args[] = {
+		"--early=attached", "--early", "ignored",
+	};
+	const char *stop_args[] = {
+		"--early", "separate", "--ordinary",
+	};
+
+	int ret;
+
+	options[0].flags |= PARSE_OPT_EARLY;
+	options[2].flags |= PARSE_OPT_EARLY | PARSE_OPT_LASTARG_DEFAULT;
+	options[2].defval = (intptr_t)"default";
+
+	data.calls = 0;
+	data.stop = 1;
+
+	ret = early_scan_options(ARRAY_SIZE(callback_stop_args),
+		callback_stop_args, options, 0,
+		early_scan_test_callback, &data);
+
+	if (ret != 1)
+		return error("expected callback to stop scan at argument 1, got %d",
+			ret);
+
+	if (data.calls != 1)
+		return error("expected callback to run once before stopping");
+	data.calls = 0;
+	data.stop = 0;
+
+	ret = early_scan_options(ARRAY_SIZE(args), args, options, 0,
+				 early_scan_test_callback, &data);
+
+	if (ret != 5)
+		return error("expected scan to stop at argument 5, got %d", ret);
+
+	if (data.calls != 2)
+		return error("expected 2 early callbacks, got %d", data.calls);
+
+	if (strcmp(data.value, "separate"))
+		return error("expected separate argument value, got %s",
+			     data.value);
+
+	if (data.pos != 3)
+		return error("expected second early option at position 3, got %d",
+			     data.pos);
+
+	data.calls = 0;
+
+	ret = early_scan_options(ARRAY_SIZE(stop_args), stop_args,
+		options, 0,
+		early_scan_test_callback, &data);
+
+	if (ret != 2)
+		return error("expected scan to stop at argument 2, got %d", ret);
+
+	if (data.calls != 1)
+		return error("expected 1 early callback before stopping, got %d",
+			     data.calls);
+
+	if (strcmp(data.value, "separate"))
+		return error("expected separate argument value before stopping");
+
+	data.calls = 0;
+	data.stop = 0;
+
+	ret = early_scan_options(ARRAY_SIZE(positional_args), positional_args,
+				 options, EARLY_SCAN_STOP_AT_NON_OPTION,
+				 early_scan_test_callback, &data);
+
+	if (ret != 0)
+		return error("expected scan to stop at positional argument");
+
+	if (data.calls != 0)
+		return error("early callback should not run after positional argument");
+
+	data.calls = 0;
+
+	ret = early_scan_options(ARRAY_SIZE(end_of_options_args),
+				 end_of_options_args, options, 0,
+				 early_scan_test_callback, &data);
+	if (ret != 0 || data.calls)
+		return error("scanner should stop at --end-of-options");
+
+	ret = early_scan_options(ARRAY_SIZE(short_option_args),
+				 short_option_args, options, 0,
+				 early_scan_test_callback, &data);
+	if (ret != 0 || data.calls)
+		return error("scanner should stop at short options");
+
+	ret = early_scan_options(ARRAY_SIZE(unknown_option_args),
+				 unknown_option_args, options, 0,
+				 early_scan_test_callback, &data);
+	if (ret != 0 || data.calls)
+		return error("scanner should stop at unknown options");
+
+	ret = early_scan_options(ARRAY_SIZE(missing_value_args),
+				 missing_value_args, options, 0,
+				 early_scan_test_callback, &data);
+	if (ret != 0 || data.calls)
+		return error("scanner should stop when a required value is missing");
+
+	data.calls = 0;
+
+	ret = early_scan_options(ARRAY_SIZE(lastarg_default_args),
+		lastarg_default_args, options, 0,
+		early_scan_test_callback, &data);
+
+	if (ret != ARRAY_SIZE(lastarg_default_args))
+		return error("expected last-argument default to be consumed");
+
+	if (data.calls != 1)
+		return error("expected early callback for default argument");
+
+	if (strcmp(data.value, "default"))
+		return error("expected default value, got %s", data.value);
+	return 0;
+}
+
 int cmd__parse_options(int argc, const char **argv)
 {
+	if (argc == 2 && !strcmp(argv[1], "--test-takes-argument"))
+		return test_parse_options_takes_argument();
+	if (argc == 2 && !strcmp(argv[1], "--test-early-scan"))
+		return test_early_scan_options();
 	const char *prefix = "prefix/";
 	const char *usage[] = {
 		"test-tool parse-options <options>",
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ec55bb1414..1bf802da5b 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -860,5 +860,11 @@ test_expect_success 'u16 limits range' '
 	test_must_fail test-tool parse-options --u16 65536 2>err &&
 	test_grep "value 65536 for option .u16. not in range \[0,65535\]" err
 '
+test_expect_success 'parse_options_takes_argument' '
+        test-tool parse-options --test-takes-argument
+'
+test_expect_success 'early_scan_options' '
+	test-tool parse-options --test-early-scan
+'
 
 test_done
-- 
2.53.0

