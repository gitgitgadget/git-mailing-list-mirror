Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC681FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 13:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbdF1N3W (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 09:29:22 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35363 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdF1N3V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 09:29:21 -0400
Received: by mail-pg0-f67.google.com with SMTP id f127so8261124pgc.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vn6RlE95V51BNrTB+5uj4RJVJ/PFeiQ7letEG7aX1zs=;
        b=EzaaSz+4AUtpnLQjmi42eLCs9Ey2Gtd1pB+93ft5Y2ACXn4I5pXu80HCbwy7L1OELJ
         YNIvf6F+ziyWX+dibvioGsEJWdTABZm0SgM0nh6zOYxX5IE3pLnt71PcWnzvwuoKbZmF
         +0LKa7NvbEbhzCqr5hyuSYAHDCWjZMtk28B7UYLGRjKoIKiBb0jE4G2ya9xAm60Qq0B9
         nsnWeJwfvN5JDlZdwwbbtR1PJDz2jrknOVZM9y+wuVr/Z0UIAazM+RwP8s+hCd3CfUv3
         cqCuPBG336bLBEFCxodOkfVTm5uL3HOmrqDAfZ0cz8Oh/2WEqej/EHw0rX1949cWkPtr
         k1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vn6RlE95V51BNrTB+5uj4RJVJ/PFeiQ7letEG7aX1zs=;
        b=jwu1jQjhSbsNBaEubyI0DlP4oRwjr2g/Kohe8FK0QlbAXeF35nKTUhV92Zai954n/4
         1Y0YFsxLDClW6p+vKFjDA+NNKw/GiP4Y9XfbQxUfq6e627OeEtdfCtZfOEwMk3PMar8X
         1I/JBsv2kUMMMczOeC7NvuB9uQG0awtWdIMeO/WJuc2qMzlm6FFhrC3RmJdaAdHh15dM
         PZokk5vBhLJf02AahNXfmz2955WNjff/fa8nIujGhvoAlgsPc6L+X+jtSkWYdFcIjiqO
         NvHkjrRxfWEyyEIh3mrrzTE5/f2HpqAItXVUU9YoOOgw9hK5xEjsQGZXjEdgPrvPKDne
         U2qA==
X-Gm-Message-State: AKS2vOyeKS6/YE5xYgJFz74N67DUvxOIZL/IY5dGmLfyNwTjezjaua8n
        MquAAjng+D61AQ==
X-Received: by 10.98.19.136 with SMTP id 8mr10763735pft.105.1498656560623;
        Wed, 28 Jun 2017 06:29:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:704f:df41:415d:a82f:3a7d:1434])
        by smtp.gmail.com with ESMTPSA id q19sm4760474pfq.86.2017.06.28.06.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2017 06:29:20 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] commit-template: improve readability of commit template
Date:   Wed, 28 Jun 2017 18:59:10 +0530
Message-Id: <20170628132910.7940-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqqwp7x1fie.fsf@gitster.mtv.corp.google.com>
References: <xmqqwp7x1fie.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit template adds the optional parts without
a new line to distinguish them. This results in
difficulty in interpreting it's content. Add new
lines to separate the distinct parts of the template.

The warning about usage of 'explicit paths without
any corresponding options' has outlived it's purpose of
warning users about the usage '--only' as default rather
than '--include'. Remove it.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 builtin/commit.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8d1cac062..22d17e6f2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -139,7 +139,6 @@ static enum commit_whence whence;
 static int sequencer_in_use;
 static int use_editor = 1, include_status = 1;
 static int show_ignored_in_status, have_option_m;
-static const char *only_include_assumed;
 static struct strbuf message = STRBUF_INIT;
 
 static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
@@ -841,9 +840,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				  "with '%c' will be kept; you may remove them"
 				  " yourself if you want to.\n"
 				  "An empty message aborts the commit.\n"), comment_line_char);
-		if (only_include_assumed)
-			status_printf_ln(s, GIT_COLOR_NORMAL,
-					"%s", only_include_assumed);
 
 		/*
 		 * These should never fail because they come from our own
@@ -877,8 +873,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				(int)(ci.name_end - ci.name_begin), ci.name_begin,
 				(int)(ci.mail_end - ci.mail_begin), ci.mail_begin);
 
-		if (ident_shown)
-			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
+		status_printf_ln(s, GIT_COLOR_NORMAL, "%s", ""); /* Add new line for clarity */
 
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
@@ -1208,8 +1203,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
 	if (argc == 0 && (also || (only && !amend && !allow_empty)))
 		die(_("No paths with --include/--only does not make sense."));
-	if (argc > 0 && !also && !only)
-		only_include_assumed = _("Explicit paths specified without -i or -o; assuming --only paths...");
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
 		cleanup_mode = use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
 	else if (!strcmp(cleanup_arg, "verbatim"))
-- 
2.11.0

