Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF641A900
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437234; cv=none; b=i/KaXPIqzGtcf7pHs1rlHQnD2mQp35szx/w/LdjNQpChXrnc2Mop6z8L7dvf71NbAEqoOCFSSZtWd4EXKlNe6eTCxiA2c1qYrqSwBQ88wT5bXmk4WlrcOmRCfBceTvo6DCQpvjvJVICBb5Eu+f3P1r2EwpQxT8qczCGmbo9QSyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437234; c=relaxed/simple;
	bh=mbJKmDgGz4x+KW3TGWDZJO7QNXtlKbiEfywLWj5I18k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVJ/DkB0j59kCD1mOXIL/TyLDqdVtNuEGsXbpIVqv/ma8fLUmglaeXrAITw3I5PucijvSitBke71Wox46epFbxNUTpkwTocD4DJ0Ao+vlYS7Ps90VQFXPIM19o59QBjv0671rFGFVkc+vz3BkBFNwCHghOXblCoEcUhNGO95lcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbAl1eEb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbAl1eEb"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so4267655e9.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437231; x=1787042031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dHrw9Di1IvuosOcJDRC5c4Azms7ZfaEmNmO/4YpxSZE=;
        b=lbAl1eEb8A78TP87o3b0DKFMSoN7E+tlkdcmCh4wmzExMm4Cc7UwbXJhah/UA2FCqI
         2rj+jpU0GuKvACMaMTBLY9pFzbaPlpCHWI2hH2ZjlQuWNye36ukYJvw00P2eAWLEszwl
         4tWtDTkQlW9f1l0MPXDoWvciZTJGs0y170XM0aHcRQtKU2BV9rXNewWgH3bxGOPxyexE
         soHENC2WrJd6p+2Q76FWSwrDR+7+6hvad4OxYTeD4Ih4+FAEWOIKNokbWAX3OnOppGTY
         y/3onqhPQ8IePFz1sihyg0PmjoTO/0JvHOfZ0vLXsiKsq0GvdMmoPMK6ne2ctjrwMjU2
         QzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437231; x=1787042031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dHrw9Di1IvuosOcJDRC5c4Azms7ZfaEmNmO/4YpxSZE=;
        b=cAk4t69SWbtO2HwNy444H74rLqzQo826HV9tUO7F7jOBN6pDtXe3o/tamknNpVfLcp
         G1fWXMKCaif+akhWS1wdGY95tAuygEdavnIHw5kQ34Y8NfKYjmadLnLuyor9M8cX8iq0
         sYGNo2llJsJ9bv9BnHPUoKKyHOrlU/Ld+cwmC3DiNDioi0QTRwYpq2c5mhiL8RG02Eie
         fRt3b+EipqlOh6+oLNjAprpiWbC6/Y+g6zkzQ6IFONUlFAIstgpITM/rDt6otSuexAxr
         Y8ThlNIL4Jfo5XW1zQhcBoVXXIqJ43udYLSG6rQP6HU0JsHjyB/YZAnjqxPvED5pY4KD
         dSFg==
X-Gm-Message-State: AOJu0YyJIhHbmiRcQviO58Ppl0oU+S4tGrn/Na98hx+fzga9I6+l+Y0S
	NMAV4YQAkW5HjMdI0G9NJ4vekMmaLUmN63kjw0C0JXzV+ihaVQ6rLgRmerZTyw==
X-Gm-Gg: AR+sD119jEr0drPQvq6EBHQlIG2FIWFQxrgQ45QeFATsQ5wV8Cd2ZDDqRH3hnAV4LRf
	OEDpscSQTnAi4F2uYs3gR9SLX73vNGI8LiracQwgu01mPvXvtQWhob7LuCTkVoj8OTOkmoDgfUJ
	yIGTkHaguwKto1XNcR8dBbSBqXArqY5HJvNZRg/Yqd+XGly8I2afVVTJrHwuhUkalTw6x884gws
	1NPyA0Ulpp1VbNaQeNmLyNuW5v2X6+oa0keMAildg4wjOzKq66Kg9e8r4OLnRb7nmJFVp5YPzqk
	COVu719Mm29Var5Qv65Y6l6AGm5f/X+7fXpODwhCb7prCM4MKN64hCI8KoCtqcYzXjFnldv/VoX
	aBqQNr/axB8fNRFMKLDqUdGOvUwgqOdtVZVfOVgLiuFvY67npqjrvfRkxwk9PgBZnzvA1Y9RO1w
	6yQvLuqyGQu67fbILUYVJCTdAgAVUG+ZpVD6DYm+8m12Y7KZg/1HkSwtf05EVQx9DY6ctNqraXj
	sxgAW+4yrJwrZwk05T18La/uINoOtiA1Cj/OrZ2SNMV/6c/PsOYrpjRoVmHRYl7AC98c1+K8aKY
	kos=
X-Received: by 2002:a05:600c:a49:b0:499:596b:2e91 with SMTP id 5b1f17b1804b1-49978ec80f3mr19721495e9.3.1786437231047;
        Tue, 11 Aug 2026 01:33:51 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c3:4d0d:8be2:b2d7:3667:a5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c302sm18728075e9.1.2026.08.11.01.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:33:50 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 10/12] fast-import: use callbacks to parse some options
Date: Tue, 11 Aug 2026 10:33:12 +0200
Message-ID: <20260811083314.2023489-11-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260811083314.2023489-1-christian.couder@gmail.com>
References: <20260804100355.1299498-1-christian.couder@gmail.com>
 <20260811083314.2023489-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit started using the parse-option API to generate proper
`git fast-import -h` and `git fast-import --help-all` output.

Let's prepare for when we can use that API to also parse the options by
using OPT_CALLBACK for some options that require special processing of
their arguments.

A following commit will actually parse the options using these
callbacks.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/fast-import.c | 208 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 168 insertions(+), 40 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 879c286043..40cc9c4a23 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -4008,6 +4008,126 @@ static void parse_argv(struct fast_import_state *state)
 	build_mark_map(&sub_marks_from, &sub_marks_to);
 }
 
+static int option_parse_date_format(const struct option *opt UNUSED,
+				    const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_date_format(arg);
+	return 0;
+}
+
+static int option_parse_export_pack_edges(const struct option *opt,
+					  const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_export_pack_edges(opt->value, arg);
+	return 0;
+}
+
+static int option_parse_max_pack_size(const struct option *opt UNUSED,
+				      const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_max_pack_size(arg);
+	return 0;
+}
+
+static int option_parse_big_file_threshold(const struct option *opt UNUSED,
+					   const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_big_file_threshold(arg);
+	return 0;
+}
+
+static int option_parse_signed_commits(const struct option *opt UNUSED,
+				       const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_signed_commits(arg);
+	return 0;
+}
+
+static int option_parse_signed_tags(const struct option *opt UNUSED,
+				    const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_signed_tags(arg);
+	return 0;
+}
+
+static int option_parse_rewrite_submodules_from(const struct option *opt,
+						const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_rewrite_submodules(opt->value, arg, &sub_marks_from);
+	return 0;
+}
+
+static int option_parse_rewrite_submodules_to(const struct option *opt,
+					      const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_rewrite_submodules(opt->value, arg, &sub_marks_to);
+	return 0;
+}
+
+static int option_parse_cat_blob_fd(const struct option *opt,
+				    const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_cat_blob_fd(opt->value, arg);
+	return 0;
+}
+
+static int option_parse_import_marks(const struct option *opt,
+				     const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_import_marks(opt->value, arg, 0, 0);
+	return 0;
+}
+
+static int option_parse_import_marks_if_exists(const struct option *opt,
+					       const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_import_marks(opt->value, arg, 0, 1);
+	return 0;
+}
+
+static int option_parse_export_marks(const struct option *opt,
+				     const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_export_marks(opt->value, arg);
+	return 0;
+}
+
+static int option_parse_depth(const struct option *opt UNUSED,
+			      const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_depth(arg);
+	return 0;
+}
+
+static int option_parse_active_branches(const struct option *opt UNUSED,
+					const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_active_branches(arg);
+	return 0;
+}
+
+static int option_parse_quiet(const struct option *opt UNUSED,
+			      const char *arg UNUSED, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_quiet();
+	return 0;
+}
+
 int cmd_fast_import(int argc,
 		    const char **argv,
 		    const char *prefix,
@@ -4015,10 +4135,6 @@ int cmd_fast_import(int argc,
 {
 	struct fast_import_state state;
 
-	unsigned long pack_size_limit, big_file_threshold;
-	char *edges, *signed_commits, *signed_tags, *date_format;
-	char *import_marks_if_exists, *submodules_from, *submodules_to;
-
 	/*
 	 * NEEDSWORK: For now this is used only to render
 	 * `-h`/`--help-all` usage messages. The actual parsing is
@@ -4026,58 +4142,70 @@ int cmd_fast_import(int argc,
 	 */
 	struct option fast_import_options[] = {
 		OPT_GROUP(N_("Common")),
-		OPT_STRING_F(0, "date-format", &date_format, N_("fmt"),
-			   N_("format of the commit/tag dates"), PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "date-format", NULL, N_("fmt"),
+			       N_("format of the commit/tag dates"),
+			       PARSE_OPT_NONEG, option_parse_date_format),
 		OPT_BOOL_F(0, "stats", &show_stats,
 			   N_("display some basic statistics (objects, packfiles and memory)"),
 			   PARSE_OPT_NONEG),
-		OPT_BOOL_F(0, "quiet", &quiet,
-			   N_("disable the output shown by --stats"), PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "quiet", NULL, NULL,
+			       N_("disable the output shown by --stats"),
+			       PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			       option_parse_quiet),
 		OPT_BOOL_F(0, "force", &force_update,
 			   N_("force updating modified existing branches"), PARSE_OPT_NONEG),
 		OPT_BOOL_F(0, "done", &require_explicit_termination,
 			   N_("require a terminating 'done' command"), PARSE_OPT_NONEG),
-		OPT_UNSIGNED(0, "max-pack-size", &pack_size_limit,
-			     N_("maximum size of each output pack file")),
-		OPT_UNSIGNED(0, "big-file-threshold", &big_file_threshold,
-			     N_("maximum size of a blob that will be deltified")),
-		OPT_UNSIGNED(0, "depth", &max_depth,
-			     N_("maximum delta depth")),
-		OPT_UNSIGNED(0, "active-branches", &max_active_branches,
-			     N_("maximum number of branches to maintain active")),
+		OPT_CALLBACK_F(0, "max-pack-size", NULL, N_("n"),
+			       N_("maximum size of each output pack file"),
+			       PARSE_OPT_NONEG, option_parse_max_pack_size),
+		OPT_CALLBACK_F(0, "big-file-threshold", NULL, N_("n"),
+			       N_("maximum size of a blob that will be deltified"),
+			       PARSE_OPT_NONEG, option_parse_big_file_threshold),
+		OPT_CALLBACK_F(0, "depth", NULL, N_("n"),
+			       N_("maximum delta depth"),
+			       PARSE_OPT_NONEG, option_parse_depth),
+		OPT_CALLBACK_F(0, "active-branches", NULL, N_("n"),
+			       N_("maximum number of branches to maintain active"),
+			       PARSE_OPT_NONEG, option_parse_active_branches),
 		OPT_GROUP(N_("Marks")),
-		OPT_STRING_F(0, "import-marks", &import_marks_file, N_("file"),
-			     N_("import marks from <file>"), PARSE_OPT_NONEG),
-		OPT_STRING_F(0, "import-marks-if-exists", &import_marks_if_exists, N_("file"),
-			     N_("import marks from <file> if it exists"), PARSE_OPT_NONEG),
-		OPT_STRING_F(0, "export-marks", &export_marks_file, N_("file"),
-			     N_("dump marks to <file>"), PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "import-marks", &state, N_("file"),
+			       N_("import marks from <file>"),
+			       PARSE_OPT_NONEG, option_parse_import_marks),
+		OPT_CALLBACK_F(0, "import-marks-if-exists", &state, N_("file"),
+			       N_("import marks from <file> if it exists"),
+			       PARSE_OPT_NONEG, option_parse_import_marks_if_exists),
+		OPT_CALLBACK_F(0, "export-marks", &state, N_("file"),
+			       N_("dump marks to <file>"),
+			       PARSE_OPT_NONEG, option_parse_export_marks),
 		OPT_BOOL(0, "relative-marks", &relative_marks_paths,
 			 N_("are --(import|export)-marks= paths relative to '.git/info/fast-import'?")),
 		OPT_GROUP(N_("Submodule rewrite")),
-		OPT_STRING_F(0, "rewrite-submodules-from", &submodules_from, N_("name:filename"),
-			     N_("rewrite object IDs for submodule <name> from <filename>"),
-			     PARSE_OPT_NONEG),
-		OPT_STRING_F(0, "rewrite-submodules-to", &submodules_to, N_("name:filename"),
-			     N_("rewrite object IDs for submodule <name> to <filename>"),
-			     PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "rewrite-submodules-from", &state, N_("name:filename"),
+			       N_("rewrite object IDs for submodule <name> from <filename>"),
+			       PARSE_OPT_NONEG, option_parse_rewrite_submodules_from),
+		OPT_CALLBACK_F(0, "rewrite-submodules-to", &state, N_("name:filename"),
+			       N_("rewrite object IDs for submodule <name> to <filename>"),
+			       PARSE_OPT_NONEG, option_parse_rewrite_submodules_to),
 		OPT_GROUP(N_("Signing")),
-		OPT_STRING_F(0, "signed-commits", &signed_commits, N_("mode"),
-			     N_("how to handle signed commits"),
-			     PARSE_OPT_NONEG),
-		OPT_STRING_F(0, "signed-tags", &signed_tags, N_("mode"),
-			     N_("how to handle signed tags"),
-			     PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "signed-commits", NULL, N_("mode"),
+			       N_("how to handle signed commits"),
+			       PARSE_OPT_NONEG, option_parse_signed_commits),
+		OPT_CALLBACK_F(0, "signed-tags", NULL, N_("mode"),
+			       N_("how to handle signed tags"),
+			       PARSE_OPT_NONEG, option_parse_signed_tags),
 		OPT_HIDDEN_GROUP(N_("Advanced")),
 		OPT_BOOL_F(0, "allow-unsafe-features", &state.allow_unsafe_features,
 			   N_("allow unsafe mark commands from the stream"),
 			   PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
-		OPT_STRING_F(0, "export-pack-edges", &edges, N_("file"),
-			     N_("dump edge commits to <file>"),
-			     PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
-		OPT_INTEGER_F(0, "cat-blob-fd", &cat_blob_fd,
-			    N_("write some responses to <fd> instead of stdout"),
-			      PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "export-pack-edges", &state, N_("file"),
+			       N_("dump edge commits to <file>"),
+			       PARSE_OPT_HIDDEN | PARSE_OPT_NONEG,
+			       option_parse_export_pack_edges),
+		OPT_CALLBACK_F(0, "cat-blob-fd", &state, N_("fd"),
+			       N_("write some responses to <fd> instead of stdout"),
+			       PARSE_OPT_HIDDEN | PARSE_OPT_NONEG,
+			       option_parse_cat_blob_fd),
 		OPT_END()
 	};
 
-- 
2.55.0.530.gdb3615d990.dirty

