Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33A801F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeKJPZe (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:25:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36021 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeKJPZd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:25:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id s15-v6so3380269lji.3
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sipCyQwCG1obRQlfhpmxNdrxYzAveeHmrOqAondgFjQ=;
        b=AgpRvJb7QV4kJO2SYiDlRotWNdgAlINwW3ZF2NoX+UeM9HInKQtSg8AnA7UujObTK6
         Ufu6UcZgLkMAKi7yvikXFgayDl/aFzk6lW5ekkVsy2on365QGIDIdlcEBL641827hcJ6
         /FZZRevglJXeQPX/GnFu7nppex/diem+0lgxZdktsdgzrbeFpQcTGd0/8M90l9069f/y
         F8qIO0jrMTl0ngvgQuU36GQs4bt7mIKY0gwHFgipraOj9q9B/CfISz81mriCHuPmgOkw
         G8U2hUNYuAgfoN1Hfb/oLBcVLffGv2t7Dv2ESLSVkxtiQNeTvDeUcikuajYwLggvJfQV
         3rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sipCyQwCG1obRQlfhpmxNdrxYzAveeHmrOqAondgFjQ=;
        b=erm/XG1ufVxqZIxtdeyHRtTHByCRXEvzpujMhrg3jQn1cZpwEfamlthmHOvWchyq8/
         7h9Z3P0prexXxph5g1A3J/u/AKfBr6FlTJTr7OYC/CTI3kEnO7YDQp/s0giAy17OeZBm
         0Ql+QM7YKPCj4Wl8Jjo9zhGPaiyFNPmAQrviwh4A1A+9LBsJFXDT+eFAfM7fRklX83ym
         sEjEWI4i7b4J3L9/n3veDaT0YxCYAnh6GELWA1xLip41jUUVSjKjrRuP18srpmWuV8vY
         OkGEz2egopQCldVG6k7nKisOldoxXDsIyfEiYoIAJlTq08LSfwXU6lMMB2Qv8fhIvmsw
         3xJg==
X-Gm-Message-State: AGRZ1gJvWhEKYsCCYJR1ZMp814SCMwItiwFgcBp2DwTHv4yLEkRDiADU
        unkkozHPCOPF6xNG2N5Wnmc=
X-Google-Smtp-Source: AJdET5dwDLOc07k3EJGycILXsSZnISXFEI/7T0RO2a/GOS+ERZ9B88b5tMXNe/BFI3VXmUcpzwu3sg==
X-Received: by 2002:a2e:8605:: with SMTP id a5-v6mr6296688lji.145.1541826997981;
        Fri, 09 Nov 2018 21:16:37 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:37 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 14/16] parse-options.c: mark more strings for translation
Date:   Sat, 10 Nov 2018 06:16:13 +0100
Message-Id: <20181110051615.8641-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110051615.8641-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
 <20181110051615.8641-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One error is updated to start with lowercase to be consistent with the
rest.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c          | 14 +++++++-------
 t/t0040-parse-options.sh |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 3f5f985c1e..86aad2e185 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -319,8 +319,8 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 	}
 
 	if (ambiguous_option) {
-		error("Ambiguous option: %s "
-			"(could be --%s%s or --%s%s)",
+		error(_("ambiguous option: %s "
+			"(could be --%s%s or --%s%s)"),
 			arg,
 			(ambiguous_flags & OPT_UNSET) ?  "no-" : "",
 			ambiguous_option->long_name,
@@ -353,7 +353,7 @@ static void check_typos(const char *arg, const struct option *options)
 		return;
 
 	if (starts_with(arg, "no-")) {
-		error ("did you mean `--%s` (with two dashes ?)", arg);
+		error(_("did you mean `--%s` (with two dashes ?)"), arg);
 		exit(129);
 	}
 
@@ -361,7 +361,7 @@ static void check_typos(const char *arg, const struct option *options)
 		if (!options->long_name)
 			continue;
 		if (starts_with(options->long_name, arg)) {
-			error ("did you mean `--%s` (with two dashes ?)", arg);
+			error(_("did you mean `--%s` (with two dashes ?)"), arg);
 			exit(129);
 		}
 	}
@@ -644,11 +644,11 @@ int parse_options(int argc, const char **argv, const char *prefix,
 		break;
 	default: /* PARSE_OPT_UNKNOWN */
 		if (ctx.argv[0][1] == '-') {
-			error("unknown option `%s'", ctx.argv[0] + 2);
+			error(_("unknown option `%s'"), ctx.argv[0] + 2);
 		} else if (isascii(*ctx.opt)) {
-			error("unknown switch `%c'", *ctx.opt);
+			error(_("unknown switch `%c'"), *ctx.opt);
 		} else {
-			error("unknown non-ascii option in string: `%s'",
+			error(_("unknown non-ascii option in string: `%s'"),
 			      ctx.argv[0]);
 		}
 		usage_with_options(usagestr, options);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 17d0c18feb..e46b1e02f0 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -228,7 +228,7 @@ EOF
 test_expect_success 'detect possible typos' '
 	test_must_fail test-tool parse-options -boolean >output 2>output.err &&
 	test_must_be_empty output &&
-	test_cmp typo.err output.err
+	test_i18ncmp typo.err output.err
 '
 
 cat >typo.err <<\EOF
@@ -238,7 +238,7 @@ EOF
 test_expect_success 'detect possible typos' '
 	test_must_fail test-tool parse-options -ambiguous >output 2>output.err &&
 	test_must_be_empty output &&
-	test_cmp typo.err output.err
+	test_i18ncmp typo.err output.err
 '
 
 test_expect_success 'keep some options as arguments' '
-- 
2.19.1.1231.g84aef82467

