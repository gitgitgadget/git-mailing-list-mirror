Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D6418360
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437254; cv=none; b=cjeOgyXxNrStxzGtQ+z5q0yV9uJAZy2kURXraM0m+3+AM1g3/KlaTdV18UNKGUbvir5GxH6FQhIKchE/PlnU7GF0ynLkyd7JCgOjBHr1o7Rv5ilUnoRKqujFUj0Pv3OgXTGsUWCVSPhwqEznohEqN3l3m83Ww/q80XaxBmZ4Q98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437254; c=relaxed/simple;
	bh=zQWkvCpfUlABcEM19GFc1OqEy5eC3L6wWNI+FPZEsao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgShHyHVKnbVn+GydDbe438xzxm+GRhnK208rYbac9xhLJFWVO/7+cD/ZFR5PHXu3O8kgr6yJDU7yC8sBWpMWgtyBKX7GWZbTiIyCfYi4xv+/ApjGf51Xf1sSB+LNMzt0oQXYCHMXIr16Jo694XsOiomxqLmAdGv1SEMGzi21Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VE2K9vkk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE2K9vkk"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso26381325e9.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437251; x=1787042051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M+ayxE7ebOw3oHGwqgeqsw61oZGJlISLMiFIqwh2ZcU=;
        b=VE2K9vkkdiXrUbQ/fuey5LWmRIt9R0mJoJJdiqgb3LI1oxnqTjPH0BLv7SizfkAx9M
         qehVBJX1xUgwGa+qBKvYfcdq6wk9tDyCCLE5V2scDjyCICKn0ZKlWWwgeQvpSbHdnIuN
         v+jp2MuBsSW/ovZ0I62gpl2OFzsZMg4mjaO8m6XqSsqwCF3+wWwGB2OCLga62BrYkYuo
         obbRBckeSAJ2OX4QMgYBfAWKj/TV2oNmL5FhI/Y8fW84sLtI3h0K1Zf+jwaCdTd3wGyW
         2DNnmQS3vBz6qjsiNLtt6ngfnQS1aLwWAb5TwyOlh4UMhuIynLd2tiDp5WmRvmDGH+0R
         M8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437251; x=1787042051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M+ayxE7ebOw3oHGwqgeqsw61oZGJlISLMiFIqwh2ZcU=;
        b=e/J8aNN1J8tDy+F5wuYyDRB1k5kobQOcPv3O6qgYlMV+7S3dCHo410WQmksXlt2pCu
         fDhdBnF69cmHpXi5BYDoe98lsiVljd5tLg7PXS8gI+Yp9JP4WUs5GFPRz8pMolWKlY10
         iL51QcIAh1GC11msc2/OijE6oH/nAsHn+uzG9xCSG8e7ynWovrWJonVqML/mL9BX/8ps
         1Yf02kqmIVaWvNaKIun+n7IkVEJASTRLESOn+s9F7/H871ww7cQYeU6OtoWRyhYzA/Ax
         0S7bMk3NecVohSlG153L2L4G2rDjjEY746L3AAawqT8fr+RtlzQWJo7ShC0G4H99b/vX
         H3NQ==
X-Gm-Message-State: AOJu0YwynSB2D/hLvWIBRao0WKnohrpxCSWby+eT4VcLXzoMtqRpbGWl
	yo/YGpYG494mFWMgGVF9DGcequ2XcSf+kyTEve1AuXSyQ1kVKtKt7XucqKbe6A==
X-Gm-Gg: AR+sD11njgls9c0b9Ci67w76OjaKoOOvApJgaB1vJmcZu6bBdDuDFkIXkNDY5Mk5ktL
	WWWZSFPRvJMuJEi4I0kXDPnnjVGWYen980/vGqAbokSa2f7NcHbIt7In93FrHzG+H/q6lkquMPR
	muza1pw92RTyWqD69Nx8Iyp4Hns+lbwoPu/781fdttSa/ytKPiF1SKykUG3OfL7PswrCt3bOWmn
	zsn1kAEbx+645G5ucqnRjhd2om95URwwQbSOsp7ugit6CsvtirHbcEElhIAPrZsGkrB3NVY4ZPH
	mQadPoi9ZhAnPyYHry9cteMCKBPkiWJxxJg/cL+REGTvMeBwne2/1VkbrXzidxgoaIMY1l1+jaT
	ZQCalWIyIWHUkeBOVv9QGChaZcUCGBOiDOVgPSRdLqij0g1EYud2YUKdscsoow0Sn54Ms7PCdp5
	APdt7ilPxPnZ9wNJ1QwEK/fVytFdHyxWoGbsVXQr53/6u6LvaJC8EDhRVN+pw7to/CEkl45iTh1
	zHmQiST6sOOxCupATIOoKvk4mdRlfG/pbnkoyrRObQUUBt81UGoRMgRViGFpAQuThSZPYyTz/UB
	Ddo=
X-Received: by 2002:a05:600c:1f83:b0:499:521d:bff1 with SMTP id 5b1f17b1804b1-4997840c242mr28420025e9.2.1786437211345;
        Tue, 11 Aug 2026 01:33:31 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c3:4d0d:8be2:b2d7:3667:a5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c302sm18728075e9.1.2026.08.11.01.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:33:30 -0700 (PDT)
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
Subject: [PATCH v3 01/12] parse-options: introduce OPT_HIDDEN_GROUP
Date: Tue, 11 Aug 2026 10:33:03 +0200
Message-ID: <20260811083314.2023489-2-christian.couder@gmail.com>
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

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 parse-options.c               |  4 ++--
 parse-options.h               |  5 +++++
 t/helper/test-parse-options.c |  4 ++++
 t/t0040-parse-options.sh      | 25 ++++++++++++++++++++++++-
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 08c21d9fc0..4519ead9dc 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1414,6 +1414,8 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 
 		if (opts->type == OPTION_SUBCOMMAND)
 			continue;
+		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
+			continue;
 		if (opts->type == OPTION_GROUP) {
 			fputc('\n', outfile);
 			need_newline = 0;
@@ -1421,8 +1423,6 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 				fprintf(outfile, "%s\n", _(opts->help));
 			continue;
 		}
-		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
-			continue;
 
 		if (need_newline) {
 			fputc('\n', outfile);
diff --git a/parse-options.h b/parse-options.h
index 3ec8ba5cc8..d7f896a933 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -237,6 +237,11 @@ struct option {
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
index a22533f9ed..449fff4d34 100755
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
 	test-tool parse-options -h >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
+test_expect_success 'test --help-all shows hidden group and options' '
+	cat expect-part1 expect-noop expect-part2 expect-hidden >expect-help-all &&
+	test-tool parse-options --help-all >output 2>output.err &&
+	test_must_be_empty output.err &&
+	test_cmp expect-help-all output
+'
+
 mv expect expect.err
 
 check () {
-- 
2.55.0.530.gdb3615d990.dirty

