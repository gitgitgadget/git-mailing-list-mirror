Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612E21F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfBULRu (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:17:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44883 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBULRt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:17:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id c4so8994973pls.11
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ANNYIgTQy7D5xyHBis28X+JNmulRc3W33H+PvFRaho=;
        b=r8nfx0cwuwHBAmg2Rpf7k15HoZkxI6bdtbg8OG/oismbfhQCRqBMuytVmn2Q+YFzxE
         xhvISs/ow4kYPmgCN4dI9v6mh/i3UzJN4wyR0f9JhNDfj4A9VZH1uRGuFFxifAFpALvB
         tfYJOcKHiB5CEh86E4NQF5L+wjAJMXEjUeJM+TcvWKLW7bmHWcn3/V4Uj/glUOKc81On
         F5MXVIKf0CKIi5pDv3tbCRU3YK0rzEz4RvqXh3KWwbKppzz5ibzzvXW6PG7qB+SWMKa7
         ojLJm+LsORowekvE+U+6sp57Alz/V8wyExneVofc0JrCOyIfJKyJE0PK/fQEWt07Tep6
         naLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ANNYIgTQy7D5xyHBis28X+JNmulRc3W33H+PvFRaho=;
        b=HIBlcrDx3ymgicBy6NxJlpwld/++DkW2hTz97ji/99RayAAKpL1ZkegubTqCY1IxRU
         LKjIlWosZAPSDpuS7R3OmM+k+j8SNWfmkz4pstSo9SjlitttNZtzedxh+xoUMloaP3kr
         916BLYdkaeclyf0pVjO0/eNhmr7uUwpAoF/QYNWgbh2yYdcNeKaVmWtLWuASuD9b/BnC
         YEwgRiODra26HWGDPhtAd4Jn6CSFY1JxrUMxtN0Vh0A29KBvx/VNchVMXIBLqy3w2nOy
         cJUn6rEDmrNxz9ayJyUvD/4xOhC5l0/44QT3s18fYjYt3rz7RQioWReZtsXe3tGY0oXZ
         2+1Q==
X-Gm-Message-State: AHQUAuZePT9Jtrohn3L0N9RslrcRxa1m0mVSKHffKBaEQtjOzFZwSjAU
        140Nz+VwZNrgsbbMbt0UlAvUt9Qv
X-Google-Smtp-Source: AHgI3IbSLNmJ592T/1m7OE7OURyTpb7awPoZWv/0YheGp51jPJNbNK5haQxbth2vi1l9dEuKBYl/qQ==
X-Received: by 2002:a17:902:b590:: with SMTP id a16mr795533pls.22.1550747869166;
        Thu, 21 Feb 2019 03:17:49 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id c23sm50864996pfe.156.2019.02.21.03.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:17:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:17:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 15/21] diff-parseopt: convert -D|--irreversible-delete
Date:   Thu, 21 Feb 2019 18:16:15 +0700
Message-Id: <20190221111621.27180-16-pclouds@gmail.com>
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
 diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 2c904e0526..e51f6b3005 100644
--- a/diff.c
+++ b/diff.c
@@ -5060,6 +5060,9 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("detect renames"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_find_renames),
+		OPT_SET_INT_F('D', "irreversible-delete", &options->irreversible_delete,
+			      N_("omit the preimage for deletes"),
+			      1, PARSE_OPT_NONEG),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5094,10 +5097,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
-		options->irreversible_delete = 1;
-	}
-	else if (starts_with(arg, "-C") ||
+	if (starts_with(arg, "-C") ||
 		 skip_to_optional_arg(arg, "--find-copies", NULL)) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
 			options->flags.find_copies_harder = 1;
-- 
2.21.0.rc1.337.gdf7f8d0522

