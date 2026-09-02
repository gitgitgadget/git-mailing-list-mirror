Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5864AA1C3
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365492; cv=none; b=c4SdrwOEA/16BhR93eUdionvlj7gmtRv445nflHbMreccWABDVNE2mn1PviTrzOdYCfX5jtiQQIqAGDtOHi7EogiAXTazVBsmDN9/Oj6Mi4rq8BUhqFtVFSjDE4isjy0oox8nRbVWqzj/eh7vXpfWKPWKzk7VpyFTcedK+lelIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365492; c=relaxed/simple;
	bh=Li6d/sX76plpC2h795t2j4PJndLq0tcJ/th30PRInKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opQC96suQECOygBCm+GF/2R4n9xdiJ/X3X2UcD+1dD2HS7p0b96wnBF0kwTeZGbqOd3a0F2KB8U0fzmT02rWAipv1ASo2fTkmQSQ1+7HtalIQWghl/lDYzgiENetbCtGoK1eAJA4ofWYn08bl+H7KwWV1vr4BZVhLt0Qg/i1eVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdTvk7Fh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdTvk7Fh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b965570d7so10538855e9.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788365487; x=1788970287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=alfITJZzGMis2rwjVtbInHBJ5BN/qvQNC/Bl1NsZ3JQ=;
        b=kdTvk7FhooH5TKCWXjpsSV9sjgcw7qazzt/aqLnZyA6/FxXu/KbSI+i4hNDgekcKqL
         opGh4znLSHhqsP8zFPSOwhmiXzXEobLoje/4VOURJRfJF1kXAzTYGYGdxkvF9renD0Uy
         c4p7fT7dkR5Pf4wfT9nivgI0IyqysSlovLWHdRjgEKG+wun4HVyYxJDOLXikdYNB6amb
         WOHDTyUMIhxbLySdaoop295VeSIdKRhR35HA/+kXo7QmISMQwWsZkhgRPTVwkDSMMKgR
         Y5sGGPz8I+ccaSRtLNMz0V/6yENbWw35+nD80UweJ0xbOjocthrnSkRkkQnyp69VvF4j
         6a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365487; x=1788970287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=alfITJZzGMis2rwjVtbInHBJ5BN/qvQNC/Bl1NsZ3JQ=;
        b=AksOtySir3EUdm6URZ0V56RIX9LPqRYL0M3qTgGNIK1WdMsA5W6ZNaoBlJsNEHhs0Z
         r2Z7hynwp8zGwWyp0o9dPxLSL59YrT0KBLt0Sb8E4Hb5tgzqi6P/2/RgfHOhGy5Jxp7a
         P5WYXe5tJnLnGhAqdpsAw4Grj6e4V2VCTZRXbjK6dXtVKXd83ufALMryZlE8NkrWUwwC
         C9lg2GGVjeZ5OY0/wH0blQEq4oshTrv0e7nwFF53ppIXjRz9qrw8+PlPTxCT/PaQezaw
         AFVIpUu9lQiigsrRdFYoqbd61dp6op+eht1okvYrOM6Q6KW1wjo6TWn572ibkbpu53Jk
         IBQQ==
X-Gm-Message-State: AFuF++nTKlwNrku2L/7dXJuOqHrDied4sMG6R8hdnvlDYBVHF4fRuUyZ
	ojI4iQu/tdk872XAkoNiM/BXLh5U7NBz1Ybq/OABkn9d1KMY7lE8zrmcLI/UHSQv
X-Gm-Gg: AR+sD10TH0PLuHLT1iVHkxDW3MaT+SkxoNftSZJZw5Gaxb8p6t19Lhh6v5iU/J2Ne7O
	EJ5UELeazfY2SIHjnwgLhNIXgD/IVyStc9STUTX3KgeDBseXXyBLE/rsXkoAvwiag11YEM79tlW
	Hx44O9nC0QamF3lul2xUpGO2TJ6OI+QAuCO3GUnPCuAuLGQNjidRcc8EDsLgg1UTLvg032wxJPI
	YgPAH5QvbStiN2JIjZ03Rqc74AF1SSZAFEmT7c5xJWSSKOLrAXwHxLEdtojPaMPsua7sDJr2EHY
	GGV8+2vF5B3q3iJ64wYtuPlm9hCYLakV21Utsaa0j0kyRhI7uSw3Wxmk3VH4QAtHZ0zfnLGPoiJ
	jr/ScvrN+5v5NBvjm7OEsVErfN+PMx/yYyqHw5p+bc7l3+ziNZEctB79YEBjEpiczrAlBSU/l3i
	K2qn2XnHDCUmoDkP0tJYvCpBUBdmuQ9e3EX18Si8dVGa9OshQpd9/ZMYeNtuPXeFB+/Nu0A/8Md
	6gjGlR/dYiYRnWAU5DxtQuaE7dMb7LM8euQAQJcJT1OrnchyDsQxp57sXuftsGDBXOQmnjMkCOu
	XQP0LAGnDTKu+p6E6bm2638/S2ogY3oeDOHCpf6UYh/oosAyHoyAEli3I1p2u0FqIc5kxnDcpDi
	XPyn8fEuONg==
X-Received: by 2002:a7b:ca42:0:b0:49b:92df:87be with SMTP id 5b1f17b1804b1-49ce55fbdbemr75594225e9.4.1788365486494;
        Wed, 02 Sep 2026 09:11:26 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5563c6csm50938075e9.4.2026.09.02.09.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:24 -0700 (PDT)
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
Subject: [PATCH 5/6] parse-options: build early scan options from a struct option array
Date: Wed,  2 Sep 2026 18:10:46 +0200
Message-ID: <20260902161047.476753-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.787.g3f9e2241eb.dirty
In-Reply-To: <20260902161047.476753-1-christian.couder@gmail.com>
References: <20260902161047.476753-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A command that scans its arguments early has to know which options take
a value, so that it can skip that value instead of mistaking it for an
option. When it also parses its options with the parse-options API, that
information is already available in its `struct option` array, and
duplicating it by hand in a `struct early_scan_option` array is both
tedious and easy to get out of sync when an option is added.

So let's add early_scan_options_from_options() to build the latter array
from the former, using parse_options_takes_argument() to find out which
options take a value. Its caller only has to name the options it wants
to be reported.

Note: This early scanner translation intentionally leaves out a few
complex option types to keep the scan simple and fast:

- Short options are ignored: early_scan_options_from_options()
  explicitly skips options without a `long_name`, and the scanner only
  looks for `--`. Properly handling short options would require parsing
  bundled flags (e.g., `-abc value`), which requires replicating the
  full parse_options() state machine.

- Conditional values: Options with `PARSE_OPT_LASTARG_DEFAULT` or
  `PARSE_OPT_OPTARG` are treated as not taking a separate argument.
  Because the scanner does not evaluate context (like whether an
  argument is the final one in `argv`), it must err on the side of
  caution to avoid accidentally consuming the `--` separator or a path.

- Abbreviated options remain unrecognized: Even though the scanner is
  now provided with the full option array, the underlying
  early_scan_options() engine still relies on exact string matches.
  Safely resolving abbreviations would require duplicating the
  ambiguity-checking logic from the main parser.

- Negated options are not automatically derived: The scanner strictly
  matches the defined long name. It does not automatically recognize
  the `--no-<name>` variants of boolean options. (This is harmless in
  practice for current callers, as negated options do not take values
  to skip, and boolean defaults align with the ignored state).

The above shortcomings can be addressed later, for example, when
commands that use short options or options with conditional values need
an early scan or are ported to use `struct option`.

Despite these limitations, this abstraction is a significant
improvement. It allows commands like `fast-import` to reuse their
existing `struct option` array for early scanning, ensuring the scanner
and the main parser agree on which options take arguments, and
preventing developers from having to maintain a separate, hardcoded
list that could drift out of sync.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 parse-options.c               | 39 +++++++++++++++++++++++++++++++++++
 parse-options.h               | 22 ++++++++++++++++++++
 t/helper/test-parse-options.c | 32 ++++++++++++++++++++++++++++
 t/helper/test-tool.c          |  1 +
 t/helper/test-tool.h          |  1 +
 t/t0040-parse-options.sh      | 26 +++++++++++++++++++++++
 6 files changed, 121 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 70851a385b..6cdc9c64cc 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1323,6 +1323,45 @@ int early_scan_options(int argc, const char **argv,
 	return argc;
 }
 
+struct early_scan_option *
+early_scan_options_from_options(const struct option *options,
+				const char **wanted)
+{
+	struct early_scan_option *early;
+	size_t nr = 0;
+
+	for (const struct option *opt = options; opt->type != OPTION_END; opt++)
+		if (opt->long_name)
+			nr++;
+
+	CALLOC_ARRAY(early, nr + 1);
+
+	nr = 0;
+	for (const struct option *opt = options; opt->type != OPTION_END; opt++) {
+		if (!opt->long_name)
+			continue;
+		early[nr].name = opt->long_name;
+		early[nr].takes_value = !!parse_options_takes_argument(opt);
+		nr++;
+	}
+
+	for (; wanted && *wanted; wanted++) {
+		size_t i;
+
+		for (i = 0; i < nr; i++) {
+			if (strcmp(early[i].name, *wanted))
+				continue;
+			early[i].wanted = 1;
+			break;
+		}
+		if (i == nr)
+			BUG("wanted option '%s' is not in the options array",
+			    *wanted);
+	}
+
+	return early;
+}
+
 static int usage_argh(const struct option *opts, FILE *outfile)
 {
 	const char *s;
diff --git a/parse-options.h b/parse-options.h
index b96e93508e..fb81f2ed38 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -561,6 +561,28 @@ int early_scan_options(int argc, const char **argv,
 		       enum early_scan_flags flags,
 		       early_scan_fn *fn, void *data);
 
+/*
+ * Build the `struct early_scan_option` array to pass to
+ * early_scan_options() from the `options` array that the actual option
+ * parsing uses, so that both agree on which options take a value.
+ *
+ * Note some intentional limitations to keep the scan simple and fast:
+ * short options are ignored, options with PARSE_OPT_LASTARG_DEFAULT or
+ * PARSE_OPT_OPTARG are treated as not taking a separate value, negated
+ * options ("--no-...") are not automatically generated, and abbreviated
+ * options will not be matched.
+ *
+ * The options named in the NULL terminated `wanted` array get their
+ * `wanted` bit set, the other ones are only there to be skipped along
+ * with their value. It is a BUG() for a name in `wanted` not to appear
+ * in `options`.
+ *
+ * The returned array is allocated and should be free()d by the caller.
+ */
+struct early_scan_option *
+early_scan_options_from_options(const struct option *options,
+				const char **wanted);
+
 /*----- incremental advanced APIs -----*/
 
 struct parse_opt_cmdmode_list;
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 96ab941d29..0187a25ccb 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -422,3 +422,35 @@ int cmd__early_scan_options(int argc, const char **argv)
 
 	return 0;
 }
+
+int cmd__early_scan_from_options(int argc, const char **argv)
+{
+	int an_int = 0, a_bool = 0;
+	char *a_string = NULL;
+	const struct option options[] = {
+		OPT_STRING(0, "string", &a_string, "str", "get a string"),
+		OPT_INTEGER(0, "int", &an_int, "get an integer"),
+		OPT_BOOL(0, "bool", &a_bool, "get a boolean"),
+		OPT_STRING_F(0, "optarg", &a_string, "str",
+			     "string with an optional value",
+			     PARSE_OPT_OPTARG),
+		OPT_END()
+	};
+	static const char *wanted[] = { "bool", NULL };
+	struct early_scan_option *early;
+	int stopped;
+
+	early = early_scan_options_from_options(options, wanted);
+
+	for (const struct early_scan_option *o = early; o->name; o++)
+		printf("option: %s takes_value: %d wanted: %d\n",
+		       o->name, o->takes_value, o->wanted);
+
+	stopped = early_scan_options(argc - 1, argv + 1, early, 0,
+				     show_early_option, NULL);
+	printf("stopped at: %d of %d\n", stopped, argc - 1);
+
+	free(early);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 5d2f5877d9..f1b208a5af 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -51,6 +51,7 @@ static struct test_cmd cmds[] = {
 	{ "parse-options", cmd__parse_options },
 	{ "parse-options-flags", cmd__parse_options_flags },
 	{ "early-scan-options", cmd__early_scan_options },
+	{ "early-scan-from-options", cmd__early_scan_from_options },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "parse-subcommand", cmd__parse_subcommand },
 	{ "partial-clone", cmd__partial_clone },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 071306d52d..97334ce3c6 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -44,6 +44,7 @@ int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_options_flags(int argc, const char **argv);
 int cmd__early_scan_options(int argc, const char **argv);
+int cmd__early_scan_from_options(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__parse_subcommand(int argc, const char **argv);
 int cmd__partial_clone(int argc, const char **argv);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index d760d8cfbd..bb72a6544d 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -922,4 +922,30 @@ test_expect_success 'early_scan_options() ignores abbreviated options' '
 	test_cmp expect actual
 '
 
+test_expect_success 'early_scan_options_from_options() derives takes_value' '
+	test-tool early-scan-from-options >actual &&
+	cat >expect <<-\EOF &&
+	option: string takes_value: 1 wanted: 0
+	option: int takes_value: 1 wanted: 0
+	option: bool takes_value: 0 wanted: 1
+	option: optarg takes_value: 0 wanted: 0
+	stopped at: 0 of 0
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options_from_options() skips values' '
+	test-tool early-scan-from-options --string --bool >out &&
+	tail -1 out >actual &&
+	echo "stopped at: 2 of 2" >expect &&
+	test_cmp expect actual &&
+	test-tool early-scan-from-options --string v --bool >out &&
+	tail -2 out >actual &&
+	cat >expect <<-\EOF &&
+	found: bool at 2
+	stopped at: 3 of 3
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.55.0.787.g3f9e2241eb.dirty

