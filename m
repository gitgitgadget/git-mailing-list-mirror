Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182AE1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfBULRY (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:17:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36965 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBULRX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:17:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id q3so6650213pll.4
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EEq+eIXonT0BQZL+ZgiZjh9AEaB+/hyZRQt9vqFQMOU=;
        b=Eh5XTKb9oxpEhNMvrY7gudzXLPaYOsqLC9kSdaYrRJzyrYCMZBOc/ACqgPF5QBoa4z
         G9ox0iLoSn6SCpujx9kSL5gBbvrC9jpKReBIHdU4I9s1sKdFHy24F3kbWuW6PdIczlTY
         Viq65oKBIZak5C8AKAK8h6yVIQ1Xa0IJhNo119sOKQHSoRV+3YOD9uwaFOxWrK6IoJZu
         xPveHO7+Eljhrz4hMN1zpX2+FFV+TVLJfag0svdyRsPPGmXrInT9CDst0IxL8HI6R2Pa
         u2Y9x8Cplw0gpKu4PAGWEeOB/yOjvqg1oA6YjU7wmAeezu/58ExMauWPcLvBtDwMGJVB
         hGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EEq+eIXonT0BQZL+ZgiZjh9AEaB+/hyZRQt9vqFQMOU=;
        b=rp2JpD4kyEwI1RTOl0mHD1LxpqvnRa9FqDyIf+JUbpZF/9KPIUawaV2zjkO98F2s5L
         e+l8TlPgQHRFdiO/WSmu3VCAKVhreQok8ierl03udPOJvqbLZQJk5VWUXZgdd2yZemm9
         RGoNWtMk29R2Mwl+myS/ws8FcxJBQtjm0HBeqnVhGsD78Pd1ef0NWZnSSD5ek25pZO8+
         QOOAQ6xHfqcD7T20tH0erMVn8m3wJcJY655n6h1mhNj/uCHNuVvOo69+2tLJoHJTk4VG
         yT035ubi4TeinrAmHv+Dh9e1DfEoFjp5UGZ0ecDHUlyhv/ZWntLc2Wbf3sx4NFGujev+
         LZiw==
X-Gm-Message-State: AHQUAuZF/6HpIbr8taE5J/ZDMnohcFoKUZyCHWYUjcFY+vo4TFLAJeVe
        C7bRYOzdKlEBDDAGPhCxoeZv6mYy
X-Google-Smtp-Source: AHgI3IbMeegpYwPv3VnHtotB++FRsqskA8BR4sVSVOv/fDlEslTlh+PWw1lwYvAW3gMVnoqzK5vhbA==
X-Received: by 2002:a17:902:296a:: with SMTP id g97mr42266730plb.317.1550747842920;
        Thu, 21 Feb 2019 03:17:22 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id k26sm36204358pfb.87.2019.02.21.03.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:17:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:17:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 10/21] diff-parseopt: convert --stat*
Date:   Thu, 21 Feb 2019 18:16:10 +0700
Message-Id: <20190221111621.27180-11-pclouds@gmail.com>
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
 diff.c | 118 +++++++++++++++++++++++++--------------------------------
 1 file changed, 52 insertions(+), 66 deletions(-)

diff --git a/diff.c b/diff.c
index 9c8f5336bc..1feb13deb3 100644
--- a/diff.c
+++ b/diff.c
@@ -104,11 +104,6 @@ static const char *color_diff_slots[] = {
 	[DIFF_FILE_NEW_BOLD]	      = "newBold",
 };
 
-static NORETURN void die_want_option(const char *option_name)
-{
-	die(_("option '%s' requires a value"), option_name);
-}
-
 define_list_config_array_extra(color_diff_slots, {"plain"});
 
 static int parse_diff_color_slot(const char *var)
@@ -4661,77 +4656,56 @@ int parse_long_opt(const char *opt, const char **argv,
 	return 2;
 }
 
-static int stat_opt(struct diff_options *options, const char **av)
+static int diff_opt_stat(const struct option *opt, const char *value, int unset)
 {
-	const char *arg = av[0];
-	char *end;
+	struct diff_options *options = opt->value;
 	int width = options->stat_width;
 	int name_width = options->stat_name_width;
 	int graph_width = options->stat_graph_width;
 	int count = options->stat_count;
-	int argcount = 1;
+	char *end;
 
-	if (!skip_prefix(arg, "--stat", &arg))
-		BUG("stat option does not begin with --stat: %s", arg);
-	end = (char *)arg;
+	BUG_ON_OPT_NEG(unset);
 
-	switch (*arg) {
-	case '-':
-		if (skip_prefix(arg, "-width", &arg)) {
-			if (*arg == '=')
-				width = strtoul(arg + 1, &end, 10);
-			else if (!*arg && !av[1])
-				die_want_option("--stat-width");
-			else if (!*arg) {
-				width = strtoul(av[1], &end, 10);
-				argcount = 2;
-			}
-		} else if (skip_prefix(arg, "-name-width", &arg)) {
-			if (*arg == '=')
-				name_width = strtoul(arg + 1, &end, 10);
-			else if (!*arg && !av[1])
-				die_want_option("--stat-name-width");
-			else if (!*arg) {
-				name_width = strtoul(av[1], &end, 10);
-				argcount = 2;
-			}
-		} else if (skip_prefix(arg, "-graph-width", &arg)) {
-			if (*arg == '=')
-				graph_width = strtoul(arg + 1, &end, 10);
-			else if (!*arg && !av[1])
-				die_want_option("--stat-graph-width");
-			else if (!*arg) {
-				graph_width = strtoul(av[1], &end, 10);
-				argcount = 2;
-			}
-		} else if (skip_prefix(arg, "-count", &arg)) {
-			if (*arg == '=')
-				count = strtoul(arg + 1, &end, 10);
-			else if (!*arg && !av[1])
-				die_want_option("--stat-count");
-			else if (!*arg) {
-				count = strtoul(av[1], &end, 10);
-				argcount = 2;
-			}
+	if (!strcmp(opt->long_name, "stat")) {
+		if (value) {
+			width = strtoul(value, &end, 10);
+			if (*end == ',')
+				name_width = strtoul(end+1, &end, 10);
+			if (*end == ',')
+				count = strtoul(end+1, &end, 10);
+			if (*end)
+				return error(_("invalid --stat value: %s"), value);
 		}
-		break;
-	case '=':
-		width = strtoul(arg+1, &end, 10);
-		if (*end == ',')
-			name_width = strtoul(end+1, &end, 10);
-		if (*end == ',')
-			count = strtoul(end+1, &end, 10);
-	}
+	} else if (!strcmp(opt->long_name, "stat-width")) {
+		width = strtoul(value, &end, 10);
+		if (*end)
+			return error(_("%s expects a numerical value"),
+				     opt->long_name);
+	} else if (!strcmp(opt->long_name, "stat-name-width")) {
+		name_width = strtoul(value, &end, 10);
+		if (*end)
+			return error(_("%s expects a numerical value"),
+				     opt->long_name);
+	} else if (!strcmp(opt->long_name, "stat-graph-width")) {
+		graph_width = strtoul(value, &end, 10);
+		if (*end)
+			return error(_("%s expects a numerical value"),
+				     opt->long_name);
+	} else if (!strcmp(opt->long_name, "stat-count")) {
+		count = strtoul(value, &end, 10);
+		if (*end)
+			return error(_("%s expects a numerical value"),
+				     opt->long_name);
+	} else
+		BUG("%s should not get here", opt->long_name);
 
-	/* Important! This checks all the error cases! */
-	if (*end)
-		return 0;
 	options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	options->stat_name_width = name_width;
 	options->stat_graph_width = graph_width;
 	options->stat_width = width;
 	options->stat_count = count;
-	return argcount;
+	return 0;
 }
 
 static int parse_dirstat_opt(struct diff_options *options, const char *params)
@@ -4958,6 +4932,21 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "name-status", &options->output_format,
 			  N_("show only names and status of changed files"),
 			  DIFF_FORMAT_NAME_STATUS, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "stat", options, N_("<width>[,<name-width>[,<count>]]"),
+			       N_("generate diffstat"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_stat),
+		OPT_CALLBACK_F(0, "stat-width", options, N_("<width>"),
+			       N_("generate diffstat with a given width"),
+			       PARSE_OPT_NONEG, diff_opt_stat),
+		OPT_CALLBACK_F(0, "stat-name-width", options, N_("<width>"),
+			       N_("generate diffstat with a given name width"),
+			       PARSE_OPT_NONEG, diff_opt_stat),
+		OPT_CALLBACK_F(0, "stat-graph-width", options, N_("<width>"),
+			       N_("generate diffstat with a given graph width"),
+			       PARSE_OPT_NONEG, diff_opt_stat),
+		OPT_CALLBACK_F(0, "stat-count", options, N_("<count>"),
+			       N_("generate diffstat with limited lines"),
+			       PARSE_OPT_NONEG, diff_opt_stat),
 		OPT_END()
 	};
 
@@ -4986,10 +4975,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (starts_with(arg, "--stat"))
-		/* --stat, --stat-width, --stat-name-width, or --stat-count */
-		return stat_opt(options, av);
-	else if (!strcmp(arg, "--compact-summary")) {
+	if (!strcmp(arg, "--compact-summary")) {
 		 options->flags.stat_with_summary = 1;
 		 options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	} else if (!strcmp(arg, "--no-compact-summary"))
-- 
2.21.0.rc1.337.gdf7f8d0522

