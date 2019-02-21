Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B2631F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfBULRp (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:17:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43596 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfBULRp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:17:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so13596419pfh.10
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eMfHUqCAVCI4ZbqEwjqUPBY9f95j0/Ci5hjPvacspYw=;
        b=NYwvz+hQAwDbeBF+CNSI0y3bED75EjP2vZYhtfLBkWDbZkvtJG/bfSPDuc4KztlA8Q
         jcEMjZ0Iv3jl3ogD1opAGz3Lx1IEtPoCOg9QFx8VyEPxfWHeC4n1OKWBTCCO4GWcLjtQ
         lAnCQufsVm+xPang09y01bgheCzdi0iAJUcWfqjBz4riYPEoFoom/Q4I3mswF63IKI1i
         vXZmUAdLoweLFFSvF3+xWAyCshZOj/VCuGQvqKKZ2hye1parVnzFUgk/++uy0sk+lRjH
         V1Ax0cchHGMsX5jxdCQe3uEM+wEzIUs62e6MK2nJBOExAhVS3nMh5lOk0nwSvfmotjKG
         XR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eMfHUqCAVCI4ZbqEwjqUPBY9f95j0/Ci5hjPvacspYw=;
        b=o5MdD2VMZV6jH8umO4/l1glVG/8/s7sQhYeBBzTFof8tsSSvB35ioy3icTt45iCNJR
         ffhxcgZpPIG/Dg5qn9o5qxr9KzxPnSLlD7hgorDKkpmEUvBMNRQ8rmEWyTJbcE8qCsxN
         xmiNJC6Nl8EqH0OIbOViP2NwALKm6wp3acZxKbcqXPHFSshjLTCgvbbrbDXF+LDPtlAZ
         /KmBRUb3Y7AzlJSTj+inXOO28Hm/mdXNciNRGDn7+ErqPls2vMXM21zBwLZNUybwxkaU
         GQPGHEaa0DWALg3OZfG1uaQq0zf33hnhT9AJ4HbElmPeEGksnitxrb5nAGF2JfKay+uC
         qz6w==
X-Gm-Message-State: AHQUAuY4Bxhqsd/oReHf0qL3kqgQZds/qAp0jCAyExfeaCXDO3zVx/4J
        byDln9xyzTpINVN89Brr0z9hw4ND
X-Google-Smtp-Source: AHgI3IakSh10Ojw3PW4bc63dwZtmI6HWx8TIslhY50pLmV8qo+Fp83837+CMqTb9mXhv2n30TYzyYA==
X-Received: by 2002:a63:db08:: with SMTP id e8mr34476365pgg.293.1550747863988;
        Thu, 21 Feb 2019 03:17:43 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id r80sm33297706pfa.111.2019.02.21.03.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:17:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:17:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 14/21] diff-parseopt: convert -M|--find-renames
Date:   Thu, 21 Feb 2019 18:16:14 +0700
Message-Id: <20190221111621.27180-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190221111621.27180-1-pclouds@gmail.com>
References: <20190216113655.25728-1-pclouds@gmail.com>
 <20190221111621.27180-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index d2139082b7..2c904e0526 100644
--- a/diff.c
+++ b/diff.c
@@ -4909,6 +4909,22 @@ static int diff_opt_dirstat(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_find_renames(const struct option *opt,
+				 const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!arg)
+		arg = "";
+	options->rename_score = parse_rename_score(&arg);
+	if (*arg != 0)
+		return error(_("invalid argument to %s"), opt->long_name);
+
+	options->detect_rename = DIFF_DETECT_RENAME;
+	return 0;
+}
+
 static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 					     const struct option *opt,
 					     const char *arg, int unset)
@@ -5040,6 +5056,10 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("break complete rewrite changes into pairs of delete and create"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_break_rewrites),
+		OPT_CALLBACK_F('M', "find-renames", options, N_("<n>"),
+			       N_("detect renames"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_find_renames),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5074,13 +5094,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (starts_with(arg, "-M") ||
-		 skip_to_optional_arg(arg, "--find-renames", NULL)) {
-		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
-			return error("invalid argument to -M: %s", arg+2);
-		options->detect_rename = DIFF_DETECT_RENAME;
-	}
-	else if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
+	if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
 		options->irreversible_delete = 1;
 	}
 	else if (starts_with(arg, "-C") ||
@@ -5363,13 +5377,10 @@ static int diff_scoreopt_parse(const char *opt)
 		if (skip_prefix(opt, "find-copies", &opt)) {
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'C';
-		} else if (skip_prefix(opt, "find-renames", &opt)) {
-			if (*opt == 0 || *opt++ == '=')
-				cmd = 'M';
 		}
 	}
-	if (cmd != 'M' && cmd != 'C')
-		return -1; /* that is not a -M, or -C option */
+	if (cmd != 'C')
+		return -1; /* that is not a -M option */
 
 	opt1 = parse_rename_score(&opt);
 	if (*opt != 0)
-- 
2.21.0.rc1.337.gdf7f8d0522

