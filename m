Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD77375ADF
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220949; cv=none; b=rer4F4W7FRwypPLzzY+1VKyvE0bqn9PHrWrJJk+8sITcTkvWlWQHPb/qMlPs74PS4YHaC54rDZ+tyFj+nFlttLXUJGnwf0oEBsZlPFftp0o5vTT1Yc+D7xAV8st5zMyi93og5403b7hlZfzMJDGnJRoBLMEDyJKawlQL0o0afng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220949; c=relaxed/simple;
	bh=SLlB9yyLptn4HKP4kye/DcfcrXND3ho3sO7ZIugltQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BffdrTT2yRV3lfmpr8GiYbkiqOF/TZ3mFLu6Q7AU5LFdp5JylBH7rEytc3KCeG+KsWCvV8XHKI+HB9HUWxe4uAV1hqGjqkhHOWPK65Ib0483jMkNNEqRzzQe1DHs5CdW0HIjs8qHRfHbV54ECblEI0cGwx6Ufsc5qb+u0FADlXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2V+2hc+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2V+2hc+"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698e5859a3cso1864062a12.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784220940; x=1784825740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GO/vXbpx7hOTyloLEulngdOQOlf8JJ9tIozVH2/Tms0=;
        b=C2V+2hc+brQNOjcGazCM3jihjrXkVU/9sRLEQD8GIQVX4yQSzOTVHS/lJ8mIhAVXiu
         VI4sQHH2l8mMujej/JmOgli7rvCd0QaRe7auVSQ/eWg/qwY1UNAM62rBbate5udTqs80
         MGYoCbT0UoM9MnP3DVyXbWaGAGtj+OrMI/KGPtFlFDNLPxvSidMmM2Co/uRWA2Eba/zb
         5N3hCY0hDiyOavYUiLgppy6cr7hRw+NmFY01t8dqcqZpEup0a1V9r1C/nL061q/N5gOo
         U0YVl5DzDcK3N3u8koYo6EsEipuC+SLcdXnEMRkc18KWcQW1u6PQEqvf5Afzn8GWlNkd
         WNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784220940; x=1784825740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GO/vXbpx7hOTyloLEulngdOQOlf8JJ9tIozVH2/Tms0=;
        b=PzZ4If74NH8sLHnRxnNze/8T3Xi07qqtpPlSMHVSpbHlJ9eS8NsWing1BvXaMvLULw
         pNJtf2hrbUiILA1BRO1OCnH3NL7u7zOT5u5ze1D8mkLCU0umXkcZa9KoMZKV/rSwrDU9
         bLtpHvSRWSCPDo6qrYInVqD3lRY1SfCi0bTaZohMVTbfXG4wok51/fOIYH3HF5pOD7D2
         O1NnGA9OCNoqruEvqD2yEJJYGMqHKiuMnDI3zsrfXg57/kciAxA7AysM7StjI7L/gRQm
         07riK01vxJZwvDOs5k/B2T9SDrKoVagKClqyS9ccdQiIZT5P/uY3y2Zyn2q3tF5m3b0z
         ijRw==
X-Gm-Message-State: AOJu0Yx0QdZ0pQ2OvKcPNMjuCgYDuz0tOOL7ZouJkOEAuq1GuGGbw+nk
	knVveyaLwbT/ebdS6sJV5AlQMHFoMj/gibAf9pCm/tJOk2Mn9dD6XqQyltNrWa/Bn2s=
X-Gm-Gg: AfdE7ckM03//I5WVBTCiT8Kvy0XEVzwLHywMoUWmQa265gYrK8YRUIZGbp08zEoPIB0
	RKLj2Nwu9hifjRSBOw8w+kLTJd0riRJH8JLjKfGMsEdEkuFHXzK9VsGhmWyTTztTfBLFqtDGwfv
	Fcp2K4Pye58nm36a1bWzGjzpLMtfyQfGXEFr78YiJeoAu4EAIJ3J2jky9DucC4C8Bf1VEFBjLur
	NnX4tHymZgAPi5zshz6BD6a69tEplNajw69W00FeHQ2+EXHgwtt4i64O/j68u+7XgvJ/nsoucdX
	TYdlYJp7GXZQuPUoFGOTN3s/lDhmN9DZizmaXawdmzorQYEC0ASTUFe/0bVm5uZEllSwd1jZXCm
	FrH2UAtIMsOXj6OHkE8XOCGdYPoA9grgJC59VvFVt0uqtfWdsRB/syUDpjWLJkdoa6C0CuUY2O4
	XobnANu8B0WdijsSRv6P2EhLLwZUJ8PgImRT4gXHnWAww8uxeonz2dj+Ze8YRR/zbzf1ra4JKwp
	n82spVOQS0UBofZrA==
X-Received: by 2002:a05:6402:5052:b0:698:3c82:1a38 with SMTP id 4fb4d7f45d1cf-69e38cb84b2mr1779941a12.2.1784220939929;
        Thu, 16 Jul 2026 09:55:39 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2937527sm5017149a12.20.2026.07.16.09.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:55:39 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/7] parse-options: introduce OPT_HIDDEN_GROUP
Date: Thu, 16 Jul 2026 18:55:11 +0200
Message-ID: <20260716165517.433849-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.185.g9120d2b5c0
In-Reply-To: <20260716165517.433849-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hidden options are not shown by `git <cmd> -h`, but are still shown by
`git <cmd> --help-all`. If there are a lot of hidden options or if they
don't belong to the same categories as other options, there is
currently no way to properly group them.

Using `OPT_GROUP("Foo")` means that "Foo" will always be shown which we
don't want if that group contains only hidden options.

To provide a way to have groups shown only when hidden options are
shown, let's implement an OPT_HIDDEN_GROUP macro.

To test this new macro, let's also improve `test-tool parse-options`
and test its output with `--help-all`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 parse-options.c               |  4 ++--
 parse-options.h               |  5 +++++
 t/helper/test-parse-options.c |  4 ++++
 t/t0040-parse-options.sh      | 25 ++++++++++++++++++++++++-
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index f4647e0099..640e600de8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1404,6 +1404,8 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 
 		if (opts->type == OPTION_SUBCOMMAND)
 			continue;
+		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
+			continue;
 		if (opts->type == OPTION_GROUP) {
 			fputc('\n', outfile);
 			need_newline = 0;
@@ -1411,8 +1413,6 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 				fprintf(outfile, "%s\n", _(opts->help));
 			continue;
 		}
-		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
-			continue;
 
 		if (need_newline) {
 			fputc('\n', outfile);
diff --git a/parse-options.h b/parse-options.h
index 0d1f738f8d..a28b3cd942 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -236,6 +236,11 @@ struct option {
 	.type = OPTION_GROUP, \
 	.help = (h), \
 }
+#define OPT_HIDDEN_GROUP(h) { \
+	.type = OPTION_GROUP, \
+	.help = (h), \
+	.flags = PARSE_OPT_HIDDEN, \
+}
 #define OPT_BIT(s, l, v, h, b)      OPT_BIT_F(s, l, v, h, b, 0)
 #define OPT_BITOP(s, l, v, h, set, clear) { \
 	.type = OPTION_BITOP, \
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 68579d83f3..f181f0c02d 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -209,6 +209,10 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_GROUP("Alias"),
 		OPT_STRING('A', "alias-source", &string, "string", "get a string"),
 		OPT_ALIAS('Z', "alias-target", "alias-source"),
+		OPT_HIDDEN_GROUP("Hidden options"),
+		OPT_HIDDEN_BOOL(0, "hidden-bool", &boolean, "get a boolean"),
+		OPT_INTEGER_F('k', "hidden-integer", &integer, "get a integer",
+			      PARSE_OPT_HIDDEN),
 		OPT_END(),
 	};
 	int ret = 0;
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ca55ea8228..4040333185 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -7,7 +7,7 @@ test_description='our own option parser'
 
 . ./test-lib.sh
 
-cat >expect <<\EOF
+cat >expect-part1 <<\EOF
 usage: test-tool parse-options <options>
 
     A helper function for the parse-options API.
@@ -41,6 +41,9 @@ String options
     --[no-]string2 <str>  get another string
     --[no-]st <st>        get another string (pervert ordering)
     -o <str>              get another string
+EOF
+
+cat >expect-part2 <<\EOF
     --longhelp            help text of this entry
                           spans multiple lines
     --[no-]list <str>     add str to list
@@ -67,12 +70,32 @@ Alias
 
 EOF
 
+cat >expect-noop <<\EOF
+    --[no-]obsolete       no-op (backward compatibility)
+EOF
+
+cat >expect-hidden <<\EOF
+Hidden options
+    --[no-]hidden-bool    get a boolean
+    -k, --[no-]hidden-integer <n>
+                          get a integer
+
+EOF
+
 test_expect_success 'test help' '
+	cat expect-part1 expect-part2 >expect &&
 	test_must_fail test-tool parse-options -h >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
+test_expect_success 'test --help-all shows hidden group and options' '
+	cat expect-part1 expect-noop expect-part2 expect-hidden >expect-help-all &&
+	test_must_fail test-tool parse-options --help-all >output 2>output.err &&
+	test_must_be_empty output.err &&
+	test_cmp expect-help-all output
+'
+
 mv expect expect.err
 
 check () {
-- 
2.55.0.185.g9120d2b5c0

