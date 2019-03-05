Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B45C520248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfCEMbM (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:31:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38841 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfCEMbM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:31:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id n125so5592287pfn.5
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T03u+8RSAqswfqwGei0ldkHt4+JM8hrOeRn4b2jcEAY=;
        b=Fb5o05cSJx4QpRVu0/hmZGjz2C2i2RtKmHGFLQ+Ram2EpvNnBdgKAsx+P370AtYOd2
         +iGFNwvMyJ+bwChs3tMdEZD8rnFu0JgNCW36V9hBJUaOWTXFXymIwoISHh8Jk0scbegT
         QLWja6J3KKb7uCmdYrnYDi6xqoZ9Pn6eeqiDg0eH/BFbIKNDDV8GeC0fN+9txPUWYW8s
         Q4zLaX9HFvHH0ddBI1Q5Fa4Nl/n3yjDrk2lgccpYkiiswa0CfDdPo49BZObyWgO6SAFy
         fYJfOWPXmKPBX5jnWb3GXTrdcvzBDkfNn/crmXgFzTQThJvWJ6BKCYjlIMTrx/wC59um
         biHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T03u+8RSAqswfqwGei0ldkHt4+JM8hrOeRn4b2jcEAY=;
        b=FKGZm8S7cewAxe1pHD2vzHx1+q9qrwvRFrInroykKSqoLW0g4xeBrSyh5Hv5KUyrDY
         FqKOv/coV/xUZsqZSnddGn+7/bqqjjE0zGErJI/eH/NU1BKO03Va3VktAjnHXPIam9yt
         bJDdR6VxbCWu5PW1xv6+37ublsshQPZLZVTXJmH5O+kzwu+0vvHPhUNprp93wow/nMyK
         ZeFjOfOWKiAwE+BwdDI4YLOmDqlOjzojludl+NiZt20cLwiA9/acbojg4FPMZoO4vfWT
         Bjp5t4MQwy6eNwATgCcPcdW/1gEnCJAhHJ6WTNbMjG8PSd0UUUY8vz2/fG2u9ck3EyRW
         XbJw==
X-Gm-Message-State: APjAAAUxSuF3ivOWD7DpoHT4wVdt3eWyVUqm4/jX6MLxkDoKRNsoe22a
        XTvdLuu/17ZLfQpVZEMstVvA7BTZ
X-Google-Smtp-Source: APXvYqxdDrWNXklqZE2jIpQ+W7IFi94U79PfK5O+ULuMA9FvdcsbTKEeuPnY3xndCRtvCB4sA+imgQ==
X-Received: by 2002:a63:20a:: with SMTP id 10mr1211681pgc.346.1551789071804;
        Tue, 05 Mar 2019 04:31:11 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id h126sm20449651pfc.135.2019.03.05.04.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:31:11 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:31:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/20] diff-parseopt: convert --binary
Date:   Tue,  5 Mar 2019 19:30:12 +0700
Message-Id: <20190305123026.7266-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190305123026.7266-1-pclouds@gmail.com>
References: <20190305123026.7266-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/diff-options.txt |  2 +-
 diff.c                         | 21 ++++++++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 915f2fec8b..6810c94fea 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -425,7 +425,7 @@ endif::git-format-patch[]
 
 --binary::
 	In addition to `--full-index`, output a binary diff that
-	can be applied with `git-apply`.
+	can be applied with `git-apply`. Implies `--patch`.
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
diff --git a/diff.c b/diff.c
index 5195526db9..214728c892 100644
--- a/diff.c
+++ b/diff.c
@@ -4852,6 +4852,18 @@ static int diff_opt_anchored(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_binary(const struct option *opt,
+			   const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+	enable_patch_output(&options->output_format);
+	options->flags.binary = 1;
+	return 0;
+}
+
 static int diff_opt_break_rewrites(const struct option *opt,
 				   const char *arg, int unset)
 {
@@ -5116,6 +5128,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "compact-summary", options, NULL,
 			       N_("generate compact summary in diffstat"),
 			       PARSE_OPT_NOARG, diff_opt_compact_summary),
+		OPT_CALLBACK_F(0, "binary", options, NULL,
+			       N_("output a binary diff that can be applied"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_binary),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5229,11 +5244,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* flags options */
-	if (!strcmp(arg, "--binary")) {
-		enable_patch_output(&options->output_format);
-		options->flags.binary = 1;
-	}
-	else if (!strcmp(arg, "--full-index"))
+	if (!strcmp(arg, "--full-index"))
 		options->flags.full_index = 1;
 	else if (!strcmp(arg, "-a") || !strcmp(arg, "--text"))
 		options->flags.text = 1;
-- 
2.21.0.rc1.337.gdf7f8d0522

