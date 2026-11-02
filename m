Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632533;
	b=SGMFUWMtjlXKSrjq/CM7FoC8CF+XQJr/Sgh66QBEJay2nDyVfUrPjGPetFZVDk6J+l2K
	 3CRcYIbv/5zyvMoGsqWxud0BpYzUc334YgElwPGPAjnWD6UK9QZGZFl9AGYcLwgk+VjfR
	 JfIdQUuesMyD5Jl/1YT8kDgSf3UYHc2ixL9RdQbsjzcL+tg1mRLJtu94srhrd/iEKDi5L
	 0hNMM/JVoQHP1Tzv92CKhZ08c/va1WRCFXzzbNj0QMaUtPHRChOcx4kKMsF8nBNnpOkSq
	 Rh0+8a65fpfrFFb7tZ0k6Vb48luznI7phH0LO2kDvF7W0UbPErHeqn2JQXwA7cOnfAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fmJAD8PKzERx3pdbUSqheFcCdGvssWIjAF3WuHOQhRI=;
	b=VGB9V4QnaJquo/bLS97i3DTJFCeoO03G4kWoXlRwFfI+D4uBem+BZGh/zuOP/1SZQ479
	 cdEBReXzLpvzftKIkkXaFwxbqBFsAS8/zekI5Dccf7Z719wy933512vFilqESZyVg2La4
	 a4n7q1WY4/He0Se9/1KDFoHcQE37cMXBqdiXWsTY+TIsizzRfmr0dSBHopSkAYKDpjRFa
	 1E0J6stY54jL0EHmx3DvVY7hAhgB54NuCoEfWPwIWStvaD2wmUS73Mix9cwWqwkXCSmN6
	 bI1wbCxklvv+HEwtvlxA06eWzlD0433K5NRsPwOQji3EnCoSGQpCUP37QTP0TaVGxpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kWMvIERT;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09737607B443
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 15:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09737607B443
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kWMvIERT
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48df8fe8513so2703962f8f.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 07:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632531; x=1794237331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fmJAD8PKzERx3pdbUSqheFcCdGvssWIjAF3WuHOQhRI=;
        b=kWMvIERTWbQ7ZGzFIBgcJfTSNY787boKhjBLV/ylCD8CnonvRDCY0WaNH/k9Vm8oR+
         eKBGT4osTGVwxtVPngO2CF9GXp8AI1n4kdBUM2ElErWLpgZMElJ7UjjmBeVJDt0fFr+K
         CdipSglC+AOv6xXWwBq/L4gbr54xSeWlM5hd4CuOEsaumtF1uIsYTmfB8+I4F14Myb71
         hp1MFCjbNM+nVz8P362tw9I/f2O70G7WjTZ3IP6sflnSxKaRMAoKL8g6ACtvU1RneQgw
         q6ZSMfEqFsdJ82svREH4dz/ZRYQyZIDgc9Qvgiw8neQsVdJgVyzAuq1K7Xr5GXQ8SjUi
         TPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632531; x=1794237331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fmJAD8PKzERx3pdbUSqheFcCdGvssWIjAF3WuHOQhRI=;
        b=OPEngodQUg9AEEro9xNuyZPZITGfHocLwZZq0pIpIoQ3v3tj3YDvJAl4cjbTqkXIN/
         m4a+tdXIcYvc3e1OKLubr2uB+2O6XNyGAth5K52MrxkWIMGxLaU57xgVaGtgK4x98zk8
         K4vjUSN5M/8zZXM+6Z9QeuI197/qXGjtO0ALDKW5BZtQ11jvvDarsRN+Bhg/8WpYRC+U
         qQlR8ZkVkqDnyxhUDBeUPpPxOOaMUMw1TBCWnjgsh4z3zOKBDGdasgod7EsQinwrNeQD
         IaDqcg0iF7aJixYXrY2mudQj5xP2SEXd19i4XLrCFR2keq6im6Le4kFkwjs/z+v9+4Js
         CBcw==
X-Gm-Message-State: APuU4Z/TgDUCwg59bJyS2Vx5uTiFxsAv9F/FMEcPnXT68VnXF3ZHingo
	8brL0TBS4/oDJLgZIaEGPZHD40toIJKxcqvdmGjyfee6DUg+SU/ouqArK5ZXnw==
X-Gm-Gg: AYBFou0lpEd+eHccC6KBGDJHi2NTK7U+lW43SmvKn+1HCmFi8zaUlafVmDf0d30dBXY
	+U8QDPmkIFVL/YMVvx51q5z3Ol1YKNG67yS7wHnpIh/cB3f+4JC++HDIimDca9KsIkmpZ1zhztT
	RaObuoLTpnLnMdtZlRPh8kjQ0naWnWQMUERV0uAY7JR5H/NAvs98sdIMTMolAEJetF8VEj9sY8G
	3uC9wobS8J2aXg3b0brKgKcxpprckjUJ9WSSdarDEJEPeK6n7WNZSjBJRsGIe8V423ZJ4kZka19
	zkJvQmHBilVkh/JYj1KIGCfadydX9jImL/AJ1+ETZeVCMPNP85xSuY7/GkMYsPWnTM24PZliW0K
	4vZSPeHPk0MysQYt3YYRzlLTGcVtkXLHdyZYlpwxdMBr5YflcmNZ3vBCbxQpNYvnszCVruxE2In
	ZU0C0XJba5Gt+8j/uA/TP/9yMPEpPZ+o9cgAFBTiJfZokF4XFwN3vU6ccpbmrGtj7Fx5ldQ5PUP
	Ze6Ws479xvDzpnv3wBTYLgWTyVmolrGjdq4QVh9H8U3aEUu72Lpvlc6AN1t6reilvsiYuG6RHZS
	+fVbn4jUeRutBAK+/FlSJnQev0QeulaY/1uc+oWYLjLRkGwxwOglPKe8djnglKMm/caGmPfCa0t
	6KAahOO0Zc8NFv4wR8VUd8ZhywExGTq3GFgAb8zRSpXkNfgPzCANx/mAwz3RBkcj4//AIElhCgo
	IeICvvYK4Sf6Lww9+zOdz90v+WYfw7PYynzD+WsAzm
X-Received: by 2002:a05:6000:290d:b0:48e:75f:477d with SMTP id ffacd0b85a97d-48e6e2dba63mr22006345f8f.7.1793632527261;
        Mon, 02 Nov 2026 07:15:27 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80eb1sm21851553f8f.34.2026.11.02.07.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:15:26 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Cynthia Uche <herroyalpriestess@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 4/4] fast-import: use early_scan_options() for --allow-unsafe-features
Date: Mon,  2 Nov 2026 16:14:52 +0100
Message-ID: <20261102151447.734680-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.4.gceeb21e89e
In-Reply-To: <20261102151447.734680-6-christian.couder@gmail.com>
References: <20261012074413.337183-1-christian.couder@gmail.com>
 <20261102151447.734680-6-christian.couder@gmail.com>
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
Helped-by: Cynthia Uche <herroyalpriestess@gmail.com>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/git-fast-import.adoc |  7 -----
 builtin/fast-import.c              | 42 ++++++++++++++++++------------
 t/t9300-fast-import.sh             | 36 +++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 24 deletions(-)

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
index fbd919982c..863938bb27 100644
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
@@ -4218,23 +4230,19 @@ int cmd_fast_import(int argc,
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
+	 *
+	 * EARLY_SCAN_STOP_AT_NON_OPTION is passed even though parse_options()
+	 * is not called with PARSE_OPT_STOP_AT_NON_OPTION, as any non-option
+	 * argument makes parse_argv() reject the command line, and the stream
+	 * should not have been processed with unsafe features by then.
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
index d9de2ef0d8..9a5964c7ad 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2344,6 +2344,42 @@ test_expect_success 'R: export-marks options can be overridden by commandline op
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
+test_expect_success 'R: --allow-unsafe-features after a non-option' '
+	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
+	test_must_fail git fast-import --depth 5 extra \
+		--allow-unsafe-features <input 2>err &&
+	test_grep "forbidden in input without --allow-unsafe-features" err
+'
+
 test_expect_success 'R: catch typo in marks file name' '
 	test_must_fail git fast-import --import-marks=nonexistent.marks </dev/null &&
 	echo "feature import-marks=nonexistent.marks" |
-- 
2.56.0.4.gceeb21e89e

