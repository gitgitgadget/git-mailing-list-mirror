Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D6A1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfA0AhI (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:37:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45187 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfA0AhH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:37:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so6348811pfd.12
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fhoF58I9lMut1AS4XvKN9biwYIqyd+/9sY10TF4bwLs=;
        b=DcYgxpEvWYxX0BGVxupeqW3YZIA8c4XU8+fvHPdc9emP0xTeqoyu+8b2tu/3yqwtpS
         7hpxBBZM56nishqiERUFrZOU0tss239Y1gsbMJxrySse62dBWY7zRFf64Gou6hKw0Pq2
         ni6itEm+DuBC+JhRRDG4EeLiiKV54HGcMsBLDRGGNIXr/vb2k2WuD5FNe9EjVZ1iKGYZ
         QCpHnOmmB5zXYoCkJCOnY1P5IV9myulzcmvNraFr+q84twVeS9sdoiRl1dIU147/8cA+
         6Qr4THyzrpyMRP6Bib/ew/TLk3mIERBnGCeRzefQ/w1wDQ13QZxypMLNNLy3WePHaq/s
         ZpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fhoF58I9lMut1AS4XvKN9biwYIqyd+/9sY10TF4bwLs=;
        b=gOwp1oCX6owqtlDFiW8Z221719cbAu8XMaNzEuozxlywjXLHIfVFYyTKHM1ULIigJa
         qwPCDABqRbLT1elcwSXFivn6L3VFAh7y/hBZUrozPT0arPGGhuDN/iOtvq0SIwzT86b4
         OoUuTwrBiAOlq57OXVGB02+zwVdp7RW45hmBNVAU0LF6HyAj1WPkkhO5ovNDeMR+FrUy
         6zVPwHxqkTfeDPdOMPymx7LMbTvOqdjw769u9nIAnpfNwIJY1x8wybY7u/x0id8BCPTQ
         ePiqXDu6HKkdap7UonHxG1rBt4gTNfXi4OOZOQ/Wg1GVJ/R7vRR4JPmg4ArkDA2rBGf4
         9xgg==
X-Gm-Message-State: AJcUukfZ9cgEFNTf97pqzpf+vF/CiloqsRpVBg0um37K4i58GA3SnnWx
        s2iTU4TlT/MuF4yh2vxg4gX5U0s5
X-Google-Smtp-Source: ALg8bN7+h4R7/DCmuSPHFXv9d96r1BRUCEZDypdebEEzb2v1GkHFMqb6rmUbiVCthZDU54foP3N4vA==
X-Received: by 2002:a65:448a:: with SMTP id l10mr15018185pgq.387.1548549426975;
        Sat, 26 Jan 2019 16:37:06 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id m65sm68163048pfg.180.2019.01.26.16.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 16:37:06 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 27 Jan 2019 07:37:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/14] diff.c: convert -U|--unified
Date:   Sun, 27 Jan 2019 07:35:33 +0700
Message-Id: <20190127003535.28341-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190127003535.28341-1-pclouds@gmail.com>
References: <20190127003535.28341-1-pclouds@gmail.com>
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
 Documentation/diff-options.txt |  2 +-
 diff.c                         | 23 ++++++++++++++++++++---
 parse-options.h                |  5 +++--
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b94d332f71..0711734b12 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -36,7 +36,7 @@ endif::git-format-patch[]
 -U<n>::
 --unified=<n>::
 	Generate diffs with <n> lines of context instead of
-	the usual three.
+	the usual three. Implies `--patch`.
 ifndef::git-format-patch[]
 	Implies `-p`.
 endif::git-format-patch[]
diff --git a/diff.c b/diff.c
index a4a40e4aa8..093158244e 100644
--- a/diff.c
+++ b/diff.c
@@ -4867,6 +4867,22 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_unified(const struct option *opt,
+			    const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+	char *s;
+
+	BUG_ON_OPT_NEG(unset);
+
+	options->context = strtol(arg, &s, 10);
+	if (*s)
+		return error(_("%s expects a numerical value"), "--unified");
+	enable_patch_output(&options->output_format);
+
+	return 0;
+}
+
 static void prep_parse_options(struct diff_options *options)
 {
 	struct option parseopts[] = {
@@ -4877,6 +4893,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BITOP('u', NULL, &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
+		OPT_CALLBACK_F('U', "unified", options, N_("<n>"),
+			       N_("generate diffs with <n> lines context"),
+			       PARSE_OPT_NONEG, diff_opt_unified),
 		OPT_END()
 	};
 
@@ -4905,9 +4924,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (opt_arg(arg, 'U', "unified", &options->context))
-		enable_patch_output(&options->output_format);
-	else if (!strcmp(arg, "--raw"))
+	if (!strcmp(arg, "--raw"))
 		options->output_format |= DIFF_FORMAT_RAW;
 	else if (!strcmp(arg, "--patch-with-raw")) {
 		enable_patch_output(&options->output_format);
diff --git a/parse-options.h b/parse-options.h
index ce75278804..7d83e2971d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -134,6 +134,8 @@ struct option {
 #define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l), (v), NULL, \
 					  (h), PARSE_OPT_NOARG | (f), NULL, (i) }
 #define OPT_BOOL_F(s, l, v, h, f)   OPT_SET_INT_F(s, l, v, h, 1, f)
+#define OPT_CALLBACK_F(s, l, v, a, h, f, cb)			\
+	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), (cb) }
 
 #define OPT_END()                   { OPTION_END }
 #define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, NULL, \
@@ -164,8 +166,7 @@ struct option {
 #define OPT_EXPIRY_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("expiry-date"),(h), 0,	\
 	  parse_opt_expiry_date_cb }
-#define OPT_CALLBACK(s, l, v, a, h, f) \
-	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), 0, (f) }
+#define OPT_CALLBACK(s, l, v, a, h, f) OPT_CALLBACK_F(s, l, v, a, h, 0, f)
 #define OPT_NUMBER_CALLBACK(v, h, f) \
 	{ OPTION_NUMBER, 0, NULL, (v), NULL, (h), \
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
-- 
2.20.1.560.g70ca8b83ee

