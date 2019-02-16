Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 015C51F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfBPLeZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:34:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38746 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfBPLeY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:34:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id m2so3818213pgl.5
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnyrUaL/kZL6vPDg/HP2kg0btx0wRK4SlqgkVv2Eras=;
        b=mL50JMnUsgs8F0USj8mEyqT16/Rn76WMXkBhoLrJ+hrrwPhgJDeQBMFLM1AEdvskgF
         3KvWBQPGLfpcvbhrMv3qKsNqGBSZ1NPaDR2MYTOhEPcxIYP8QxKiqKEoOZG8EQa27xz9
         0uJsJV9Uf7FzqjVfqWSavk0ntr7ALU4bGJU4YINgI0nkXzIgLiOBg7X49sAkcM0qNanP
         Zm8Wz3LQPH73slSxIHXBBmD9hNKdjoFqUDWKTV8vhU4jJgrmHLjGt83qK5dZYIVmNHZ/
         etmQ26YfrBQ8sy8xpeuwJo/6TXQOKdb6StLg/uvQq/cJAN47GVfqkF1OuYMshFBL08nT
         6yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnyrUaL/kZL6vPDg/HP2kg0btx0wRK4SlqgkVv2Eras=;
        b=PqpnAwoVR9suPOBCs2gz2Leax5TBE/rfb3+MFidfexHncvlA2t3B4L2eNtA2RYkjrT
         2tgaKhtc6IG07/yX2lM1LIk3krc3HAG9U/ZLW/+5hfzbSJ1VDWxF7c6BdtHpfE5mIu+F
         jIyxE1yXu5HVgK8yv9mQSogXNZrNQo1K0hCZcAEpwxl+D2Q3U4SX6y3YL9lzXwp/K4Fa
         6E6cTIhxhvNciQk73mGfxC3SrG2Ms9xefNPljN/IkZoxyeErf9hD0c+0KnySU4a1c+/I
         DLyU4GzUgH5uj3uKbtCK4/gqSvvUVg+DfAlC7Tu4D0qV3Te0e9kzYq6Zqm/KgM6qT0Kf
         Dmsw==
X-Gm-Message-State: AHQUAuZFH9vvZCT8ZVAhKkcoI/1oFj/Icj5Afw3470wBfBnWrubkmXdf
        Yxg6AE94v6PJr19sEZJrRR+hz8QN
X-Google-Smtp-Source: AHgI3IbE9ZJ4ivTw6H2wD8lAlVyhV3vfzBOq9gsfDTdnhAk7s5d7BSnq6q90qMHD/Y0HBmWoXKrOoA==
X-Received: by 2002:a63:c204:: with SMTP id b4mr9699905pgd.335.1550316863794;
        Sat, 16 Feb 2019 03:34:23 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id x3sm13593952pgc.80.2019.02.16.03.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:34:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:34:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 03/21] diff-parseopt: convert --dirstat and friends
Date:   Sat, 16 Feb 2019 18:33:28 +0700
Message-Id: <20190216113346.25000-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190216113346.25000-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
 <20190216113346.25000-1-pclouds@gmail.com>
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
 Documentation/diff-options.txt |  7 ++++++
 diff.c                         | 39 +++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 0711734b12..058d93ec4f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -148,6 +148,7 @@ These parameters can also be set individually with `--stat-width=<width>`,
 	number of modified files, as well as number of added and deleted
 	lines.
 
+-X<param1,param2,...>::
 --dirstat[=<param1,param2,...>]::
 	Output the distribution of relative amount of changes for each
 	sub-directory. The behavior of `--dirstat` can be customized by
@@ -192,6 +193,12 @@ directories with less than 10% of the total amount of changed files,
 and accumulating child directory counts in the parent directories:
 `--dirstat=files,10,cumulative`.
 
+--cumulative::
+	Synonym for --dirstat=cumulative
+
+--dirstat-by-file[=<param1,param2>...]::
+	Synonym for --dirstat=files,param1,param2...
+
 --summary::
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
diff --git a/diff.c b/diff.c
index 419b6ac4ae..1cdbe8e688 100644
--- a/diff.c
+++ b/diff.c
@@ -4867,6 +4867,22 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_dirstat(const struct option *opt,
+			    const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!strcmp(opt->long_name, "cumulative")) {
+		if (arg)
+			BUG("how come --cumulative take a value?");
+		arg = "cumulative";
+	} else if (!strcmp(opt->long_name, "dirstat-by-file"))
+		parse_dirstat_opt(options, "files");
+	parse_dirstat_opt(options, arg ? arg : "");
+	return 0;
+}
+
 static int diff_opt_unified(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -4911,6 +4927,18 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "shortstat", &options->output_format,
 			  N_("output only the last line of --stat"),
 			  DIFF_FORMAT_SHORTSTAT, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F('X', "dirstat", options, N_("<param1,param2>..."),
+			       N_("output the distribution of relative amount of changes for each sub-directory"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_dirstat),
+		OPT_CALLBACK_F(0, "cumulative", options, NULL,
+			       N_("synonym for --dirstat=cumulative"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			       diff_opt_dirstat),
+		OPT_CALLBACK_F(0, "dirstat-by-file", options, N_("<param1,param2>..."),
+			       N_("synonym for --dirstat=files,param1,param2..."),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_dirstat),
 		OPT_END()
 	};
 
@@ -4939,16 +4967,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (skip_prefix(arg, "-X", &arg) ||
-		 skip_to_optional_arg(arg, "--dirstat", &arg))
-		return parse_dirstat_opt(options, arg);
-	else if (!strcmp(arg, "--cumulative"))
-		return parse_dirstat_opt(options, "cumulative");
-	else if (skip_to_optional_arg(arg, "--dirstat-by-file", &arg)) {
-		parse_dirstat_opt(options, "files");
-		return parse_dirstat_opt(options, arg);
-	}
-	else if (!strcmp(arg, "--check"))
+	if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
 		options->output_format |= DIFF_FORMAT_SUMMARY;
-- 
2.21.0.rc0.328.g0e39304f8d

