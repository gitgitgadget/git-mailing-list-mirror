Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 509F11F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfBGKfP (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:35:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42290 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBGKfP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:35:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so4304266pga.9
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1a6kuNMj1vAlQCir1oAcdX/kXyA6nZe/F4Uqtf4wQH0=;
        b=RW3tVP934wIJgQZ+ll3V9md037J6ZKh4YDlE016bcFPWDlf5OJ+P7XxMznxnRE3SQx
         8kg08k+aoDLJMZi3hM5hq6iPiE098qAfDKqJOJwvfLLMuGQv53yirup1cCpfcnrPVbLJ
         7LqnEFAL4Qmrx95jdtDTziFv5KzzLw8zt21XuTVOBDZxvjQIOFJLJVTFlZMPDY4Fx4Xz
         yOy2CuHlhLQRRWCfKiNr1ThMX5I4MXe2OCrdN7VeAZk0qbudN0+MeH4zdf0DoRPIlGn+
         aNEI8FIG1MDNn0h4Uu/e0WM18YA3cy//ka8WhlX0SW0+UsVoxUQP+gZ326FBTYio1f6C
         zFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1a6kuNMj1vAlQCir1oAcdX/kXyA6nZe/F4Uqtf4wQH0=;
        b=D6PphI6ySHj4BqXCY1m2RiluoP0iu6mWs1lbGYF8j1/N0mNxRZR91MRUzSYzOYQJte
         snzbBNzeMzL0kSa3wFkZEzkaSjM3BJvnhOyCLtOmyjPaQwIIb4OSwV5+zXaL3dtZg3aK
         qbydbdNkc2FFCI8IogDB0WHTIMctZS2EVXYD5mAWVf7u4d/JXqXMzAgVGqqYgBohpkeA
         nIrZCetYUqP+MoHs49tnev6Nau9VCTgV3KC7r/SOJd+ltByguI0R9FXF5Kf35Ac664lj
         whLyjOKzlZF09x6UXsdsdsKhlVyyjS7dF6zhkLU/tBiqYIv9aTWY9Xm9M3OTv+Jc6TeW
         FWPg==
X-Gm-Message-State: AHQUAua3mz9tjw99NRa49nD3rMJkaIn4cWNG4ztkAEqSgpRSRXK3z5SR
        WxRiadTkZkJ6m1cYRO1ML5fXQ+Pp
X-Google-Smtp-Source: AHgI3IbL4trOJBy6BAJWdX0iWyRN6XC/vjin39gZ/FBxawKkCpn8OjdIpGf5QIN/vLPPIlSrUeyUIg==
X-Received: by 2002:aa7:8245:: with SMTP id e5mr6613169pfn.172.1549535714100;
        Thu, 07 Feb 2019 02:35:14 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l8sm20839315pfb.68.2019.02.07.02.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:35:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:35:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/21] diff.c: convert --no-renames|--[no--rename-empty
Date:   Thu,  7 Feb 2019 17:33:23 +0700
Message-Id: <20190207103326.10693-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For --rename-empty, see 90d43b0768 (teach diffcore-rename to
optionally ignore empty content - 2012-03-22) for more information.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/diff-options.txt |  3 +++
 diff.c                         | 13 ++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index d3e8d634b2..4c0d40881b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -392,6 +392,9 @@ endif::git-format-patch[]
 	Turn off rename detection, even when the configuration
 	file gives the default to do so.
 
+--[no-]rename-empty::
+	Whether to use empty blobs as rename source.
+
 ifndef::git-format-patch[]
 --check::
 	Warn if changes introduce conflict markers or whitespace errors.
diff --git a/diff.c b/diff.c
index abb1566f95..d423a06b41 100644
--- a/diff.c
+++ b/diff.c
@@ -5087,6 +5087,11 @@ static void prep_parse_options(struct diff_options *options)
 			       diff_opt_find_copies),
 		OPT_BOOL(0, "find-copies-harder", &options->flags.find_copies_harder,
 			 N_("use unmodified files as source to find copies")),
+		OPT_SET_INT_F(0, "no-renames", &options->detect_rename,
+			      N_("disable rename detection"),
+			      0, PARSE_OPT_NONEG),
+		OPT_BOOL(0, "rename-empty", &options->flags.rename_empty,
+			 N_("use empty blobs as rename source")),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5121,13 +5126,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (!strcmp(arg, "--no-renames"))
-		options->detect_rename = 0;
-	else if (!strcmp(arg, "--rename-empty"))
-		options->flags.rename_empty = 1;
-	else if (!strcmp(arg, "--no-rename-empty"))
-		options->flags.rename_empty = 0;
-	else if (skip_to_optional_arg_default(arg, "--relative", &arg, NULL)) {
+	if (skip_to_optional_arg_default(arg, "--relative", &arg, NULL)) {
 		options->flags.relative_name = 1;
 		if (arg)
 			options->prefix = arg;
-- 
2.20.1.682.gd5861c6d90

