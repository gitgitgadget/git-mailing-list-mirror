Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304B4477F7
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791101; cv=none; b=l+sdMJbfgWmO+f1HVBjWmJ3DsLzShwLlOAmtj8jRzn/m65Fh4D+PE1bjV6a4Ig9If9uzN/FTVOG0UOX+Pjuj7KjnE+XVFo4mm5cvBpFO8C66Qeq1Ov+BayZJHtQM4oOE9xRtxw4SWxifwfHO191nAf8ORO2/+Yf8qVorbEzljQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791101; c=relaxed/simple;
	bh=Jp2elNvJsdQfRKqbBoZzLB4Gp9/Nmy1oHW/OF3HojZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=US9u9+e7ciQVBlAJBPBLrguoPFQts2QaXOu3CyR5X7AYGcWt6KDe2tiKeWgSZSdnYwT/OBds4HqynNr2XuQ4UWAXGLglEkb4qNadA9Jb4rO5QdWzTWTxNepdCYr8TosSMojPr4taXi1RDpSZ3Eol6BPrs+IuiSogwMp5oCBwjkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kByFf13G; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kByFf13G"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so10448335e9.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 00:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791791098; x=1792395898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rb9/vl6lTqBhLeKptlhg4ipfsTo/v61C436fKup+5dY=;
        b=kByFf13GbEnuBb43MLhD2gYwzuyogCENC2Op+Waz+1sKClZBNpvm/Opn1gO53A//4x
         vVF1cxkkAIR0WXevGjHuRnri3pkt4DMC+YTYuAKsydiPPnIFtD4bR3s7NTcKkH5CwbnP
         WjhvVsI5ELOiDmyeZJFbEkkcbel3D12xH9fuEWkbPJjcVBrfgsaqZTf23rWYf/xWMFxF
         dTKHXUKbZhUfnY5XeV3eEMiRIv+90iR3pCTaMCHfDmvXD7WZfu9UkG7/K14/oOWqFHqR
         W3HNYfAlS9X8eIfzntL+LXIU0FdtAzQrSSrzVcJlTBP8bxMRMI9919zhY0DhAH4oVnj8
         3Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791791098; x=1792395898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rb9/vl6lTqBhLeKptlhg4ipfsTo/v61C436fKup+5dY=;
        b=ltMSK35cVYjUQKBN6Bpsf8gBZmCYdHjnmCrdpd+QihwUZ3WbUz5PZggJ+hU6SIVgzB
         WLStb92HMXfy4FpwKUahyuIuIuMaIJAwYCKjuLmFBOU7bbLqTsJOOiYE+G3f97ByzZ57
         KsGPbS6Y1Qa+szeDzqW8zOCLppKgd86I8RGQ9iZcRsZhtWHDtrk0qh35gt6hzSbXyXO1
         WFkTasK4neXAGJ+BhiFDiRAaQ3KGtKVU9YuK+BZN0zzrcdVSGKDysNCRQqw1V4/IxOwA
         K10aklnQBeor8EuVxLmLPr1SR85i3IK1VLN8ZP2tzSmoS/usLblSApcm6xuQkfMWt5Au
         1M0g==
X-Gm-Message-State: AFq9FYII/R3KR35otixCFLoYxDCXj+8dg63Bz2u7LTp5L0WwBajb3zKc
	U/0E7SFIMbmvvtbiWgxcEwwc3mtZoDhK6rA5ysOxItozzSgE6wsLdgFEB0L2xQ==
X-Gm-Gg: AYBFou2Ituy6sCjamuS2wNDHORVnO902yyyqnksFARB9FqSakpNrs7ZW/kD7hW0e4Rd
	g7RmvNk/IJEPbE+QlUPv8+tEnGtwjtXBksF1u5t2hGPD4rlsGJp4i3kKZe4EXMKOW0d6hJ/Ts2B
	iMJ4bNaC/K1AtSCqvKvhMbgTABRsp/Wg1xURmQAgQ2LNlSo/OvOIxDaLnDLN/5INq0gI9bCZQkP
	BJ6HFjFMX7WZJhlFFB1GHyszK4RsomkMndJlp4r9TylzwSgWvfbAtdVGZGbF9LKI0g107X9CLVE
	w4hU7VCj1DOx9TOXIKS0xvt8I9rqz7WpsPpmPZ3ibrD2LT9tI7s+l6JvdkgaIMTdGeEECOvlDn+
	eQ+yKpJ8yHJ4EsM56oXdw0/cBYi7Xa3iTWOJopyIOOHs5y77u+AaaaAPqlaCTBvxn9FnozrjPSu
	F1+IaRaMcPvXfsJlIfuGoE9m/1UbjiQfxXAOSwx3pckgC+QO47EdTlocBJc3ORRHblwtl8FxTLY
	O0XRr81XRMRqFrECRMfY8xtqj3pZL0cb+vgToP1idI6Lryg8unbSuzk3J2kWIjeiY6QsaLk4y9x
	41Ie0TYxe13za5Ngpsaqk0SzbRnViqD0FJ1ouOqtW4LDxyS5fOMiN5v0lWxQP9mHF7tDFVYazxt
	OYJ9tVewkS/ZcJz9cS7A=
X-Received: by 2002:a05:600c:3111:b0:4a1:811c:8069 with SMTP id 5b1f17b1804b1-4a18e49d640mr164738035e9.8.1791791097723;
        Mon, 12 Oct 2026 00:44:57 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db99b800asm17680723f8f.22.2026.10.12.00.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:44:56 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 4/4] fast-import: use early_scan_options() for --allow-unsafe-features
Date: Mon, 12 Oct 2026 09:44:13 +0200
Message-ID: <20261012074413.337183-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f6092
In-Reply-To: <20261012074413.337183-1-christian.couder@gmail.com>
References: <20260923080928.1534413-1-christian.couder@gmail.com>
 <20261012074413.337183-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "feature" lines at the start of the stream are processed before the
command line options are parsed, so cmd_fast_import() scans its
arguments early to find out if `--allow-unsafe-features` was given.

That scan doesn't know which options take their value as a separate
argument, and it stops at the first argument that doesn't start with a
dash. So it disagrees with parse_options(), which accepts values
separated from their option by a space, for a command line like
"--depth 5 --allow-unsafe-features": the scan stops at "5" and never
sees the option, so unsafe "feature" commands from the stream are
refused even though the option was given.

Let's fix this by using early_scan_options(), which scans the very
same `struct option` array that parse_options() uses, so that both
agree on which options take a value, and by marking
`--allow-unsafe-features` with PARSE_OPT_EARLY so that the scan
reports it.

As early_scan_options() looks up long options the same way as
parse_options(), the two also agree on abbreviations now. So
`--allow-unsafe` allows unsafe "feature" commands, while
"--quiet --export-pack --allow-unsafe-features" refuses them, as
parse_options() takes `--allow-unsafe-features` there as the value of
`--export-pack-edges`. (The old scan wrongly allowed them in this
case, as all the arguments start with a dash.)

The note about having to spell the option in full in the
documentation is therefore removed, and so is the NEEDSWORK comment
about it.

Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/git-fast-import.adoc |  7 ------
 builtin/fast-import.c              | 37 ++++++++++++++++--------------
 t/t9300-fast-import.sh             | 29 +++++++++++++++++++++++
 3 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index fd165e11d2..7c5900e048 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -65,13 +65,6 @@ Only enable this option if you trust the program generating the
 fast-import stream! This option is enabled automatically for
 remote-helpers that use the `import` capability, as they are
 already trusted to run their own code.
-+
-Note that this option has to be spelled in full, and has to appear
-before any option whose value is separated from it by a space, for
-the unsafe `feature` commands in the stream to be allowed. So
-`--allow-unsafe` or `--depth 5 --allow-unsafe-features` still refuse
-them, while `--allow-unsafe-features --depth 5` and
-`--depth=5 --allow-unsafe-features` allow them.
 
 `--signed-tags=<mode>`::
 	Specify how to handle signed tags. Behaves in the same way as
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index fbd919982c..2e667af349 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -4120,6 +4120,18 @@ static int option_parse_quiet(const struct option *opt UNUSED,
 	return 0;
 }
 
+static int option_parse_early_allow_unsafe(const struct option *option,
+					   const char *value UNUSED,
+					   bool unset, int pos UNUSED,
+					   void *data)
+{
+	struct fast_import_state *state = data;
+
+	if (!strcmp(option->long_name, "allow-unsafe-features"))
+		state->allow_unsafe_features = !unset;
+	return 0;
+}
+
 int cmd_fast_import(int argc,
 		    const char **argv,
 		    const char *prefix,
@@ -4184,7 +4196,7 @@ int cmd_fast_import(int argc,
 		OPT_HIDDEN_GROUP(N_("Advanced")),
 		OPT_BOOL_F(0, "allow-unsafe-features", &state.allow_unsafe_features,
 			   N_("allow unsafe mark commands from the stream"),
-			   PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
+			   PARSE_OPT_HIDDEN | PARSE_OPT_NONEG | PARSE_OPT_EARLY),
 		OPT_CALLBACK_F(0, "export-pack-edges", &state, N_("file"),
 			       N_("dump edge commits to <file>"),
 			       PARSE_OPT_HIDDEN | PARSE_OPT_NONEG,
@@ -4218,23 +4230,14 @@ int cmd_fast_import(int argc,
 	 * line to override stream data). But we must do an early parse of any
 	 * command-line options that impact how we interpret the feature lines.
 	 *
-	 * NEEDSWORK: This scan only matches the exact "--allow-unsafe-features"
-	 * spelling and stops at the first argument that doesn't start with a
-	 * dash. As parse_options() below also accepts unambiguous abbreviations
-	 * and values separated by a space from their option, the two disagree
-	 * for command lines like "--allow-unsafe" or "--depth 5
-	 * --allow-unsafe-features": parse_options() accepts the option, but
-	 * this scan doesn't see it, so unsafe features from the stream are
-	 * still refused. This errs on the safe side, but should be fixed by
-	 * teaching this scan about the options that take a value.
+	 * The scan uses the same options as parse_options() below, so the
+	 * two agree on which options take a value and on abbreviations. In
+	 * case of doubt, the scan stops early, so unsafe features are then
+	 * refused rather than wrongly allowed.
 	 */
-	for (int i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (*arg != '-' || !strcmp(arg, "--"))
-			break;
-		if (!strcmp(arg, "--allow-unsafe-features"))
-			state.allow_unsafe_features = 1;
-	}
+	early_scan_options(argc - 1, argv + 1, fast_import_options,
+			   EARLY_SCAN_STOP_AT_NON_OPTION,
+			   option_parse_early_allow_unsafe, &state);
 
 	rc_free = mem_pool_alloc(&fi_mem_pool, cmd_save * sizeof(*rc_free));
 	for (unsigned int i = 0; i < (cmd_save - 1); i++)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index d9de2ef0d8..85059a5385 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2344,6 +2344,35 @@ test_expect_success 'R: export-marks options can be overridden by commandline op
 	test_path_is_missing feature-sub
 '
 
+test_expect_success 'R: --allow-unsafe-features found after a value' '
+	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
+	git fast-import --allow-unsafe-features <input &&
+	git fast-import --depth=5 --allow-unsafe-features <input &&
+	git fast-import --depth 5 --allow-unsafe-features <input &&
+	git fast-import --date-format raw --allow-unsafe-features <input
+'
+
+test_expect_success 'R: --allow-unsafe-features can be abbreviated' '
+	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+	git fast-import --allow-unsafe <input
+'
+
+test_expect_success 'R: disallowed abbreviation of --allow-unsafe-features' '
+	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
+	test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
+		git fast-import --allow-unsafe <input 2>err &&
+	test_grep "forbidden in input without --allow-unsafe-features" err
+'
+
+test_expect_success 'R: --allow-unsafe-features as the value of an abbreviation' '
+	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
+	test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+		git fast-import --quiet --export-pack \
+		--allow-unsafe-features <input 2>err &&
+	test_grep "forbidden in input without --allow-unsafe-features" err
+'
+
 test_expect_success 'R: catch typo in marks file name' '
 	test_must_fail git fast-import --import-marks=nonexistent.marks </dev/null &&
 	echo "feature import-marks=nonexistent.marks" |
-- 
2.56.0.116.g6de20f6092

