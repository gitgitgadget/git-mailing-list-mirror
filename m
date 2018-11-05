Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5681F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388048AbeKFEme (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:42:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44198 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbeKFEmd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so9109484lji.11
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kI2E7UrPuttrKLKN0uA73YJErWhEpVV3GJCOF/PQS6Q=;
        b=A1fwey44gxi1/L34wKHvo0VLCq+NwdXJlDfko3V5rfpslC3VXrdW/SVsaQbX/5iy27
         nRF7vS4B+LpUBSHtgc9mOg19G2Th/tzr6IAH9npGnCVBMYLcBnl/OI/rL4W35DMHDXuW
         HgiqlKPO+4/bmxOZf+m0Kn9uj1mB+O1HTncdcspSJjVJuiPeKOP0FQ0R/Rpcpwqd4x/l
         EfBypghB9JhwFLf+CWAljH1msL67SwoUJF5WvBq4oAEnOUfYMKxZBfavCKsO1hOUz8pF
         SCXyCV0b0sP7A24urtx+7hCqlYDEXHgKtVxsGb+fWzj0K5cTg9mQKoOQ0+DQ6AtQBwd9
         If1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kI2E7UrPuttrKLKN0uA73YJErWhEpVV3GJCOF/PQS6Q=;
        b=CW01BvaLsfCtutFukxbPhrKfgz9NBWDkVk+EnQ/zBE5iaMOz2zIwE5rKfI3bBO7zQL
         +CmzIg+TvzG3v797TnV3MmLKhECl+7OQ1YPX8+Dj+IaZOSWXwPTqFFj1JIe3KK56FMRd
         vCSXHmt6uWSQOTEb8DxijGbkk/B7fD25hHTnEuE/BX9C0KGi4JGYlCSDHS+OJYDtpMNs
         wCGsPRJS8lGAZXq50QyBsMUuzFwbAS4fs9YPAoRM6xrRspSSoUnPVFG905Bps4LRbfKh
         jp9Y48DJLV1KYOzRMpScSnwLAQJL/VMK5idjZu/CbWuqMfT7oU5oEJ0KB+Wkrn55Bz24
         EfeA==
X-Gm-Message-State: AGRZ1gL3Rs61+MkOjztvnI2jlaU8habH6BL01UxnNyMKGLNwuGl4cU5Q
        5f5JWECDneeRdqKB2Mhan4M=
X-Google-Smtp-Source: AJdET5dJ6UhP827gjFTCW/ouBx0S08XkP3MoEfxgKXqsrIQAzTH5HsVb8dHzETmIgwta4leOvUJy9Q==
X-Received: by 2002:a2e:4b11:: with SMTP id y17-v6mr14412034lja.42.1541445684014;
        Mon, 05 Nov 2018 11:21:24 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3591056lfe.58.2018.11.05.11.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:21:23 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 14/16] parse-options.c: mark more strings for translation
Date:   Mon,  5 Nov 2018 20:20:57 +0100
Message-Id: <20181105192059.20303-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181105192059.20303-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
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
2.19.1.1005.gac84295441

