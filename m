Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72F3B201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 12:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbdF3MOA (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 08:14:00 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35068 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbdF3MMd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 08:12:33 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so15229714pgc.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Isp04ytecLzB0m3gwpMHCAvIOt79h98NoktSolJD9Zo=;
        b=PpEozNrZhczplfp5fotX3IVItXuwnA/fTzweACSx88xyjI8rMrmc4CcjIIgVuuUrf1
         TjOteWNHjilGtmnaW5Fsd9PtHqX0D0kvCZOhJbsbV7xMn/RBTblnLI41jMAwyYBmeVQR
         02LfNY92YiryLvKDmCsxI22Px2sbdoMXFFFpMmOIccobmo/IUK8fkwl33AKkPiOdnAE+
         qKLtQil63MNhFTYUptbp1befZH4ztYK1TnccBIjOA5VIicRvL6gUR3j4sq+Y7r9mys++
         5OAaLvdP9mzmM5hg/K89gAUKDKYAgo79IhTmurqJ2ytuIi5+msYleltsRBXSvITDdRGI
         yetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Isp04ytecLzB0m3gwpMHCAvIOt79h98NoktSolJD9Zo=;
        b=fl6hE+lSPc7uABvLqMIUGj7tHRgCzGx2UV7CtkoLMDgDVK3J+oavaGRcyWDFqohCdg
         OlcOBS7dBP0z5qGpyJX4KoxGnrJEVcD6Q97c+bVjuzIfjehk2AYCghNH/k4LmvhPjmXM
         ia0fJj98rKak3piGmBVHrkLgeVMTKfS2bVeJpopGXSqiKwYctI0u8osDrUPTGjpQnqlB
         juTtfRpHDcF9cpGZnJJqDfKNwmlp+3b1fAESX83nT2jNAePG6gpUv5F6XYb7dYYQjFLp
         sXKun5JmwnWuPcn6P6rgMTX2kf1/bxZtDNht2PZWGUnplTDalKGBZ6S7VS1uWhHkteSy
         Fr2Q==
X-Gm-Message-State: AKS2vOzwCdfjjFPJQpeeZhtGZXkDAaYdtjUgC4/WAagiVz8iojd2TZwa
        J6djTS6iGuVTKw==
X-Received: by 10.99.117.89 with SMTP id f25mr21186800pgn.5.1498824752646;
        Fri, 30 Jun 2017 05:12:32 -0700 (PDT)
Received: from localhost.localdomain ([42.111.140.60])
        by smtp.gmail.com with ESMTPSA id q29sm8046453pfg.11.2017.06.30.05.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jun 2017 05:12:31 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 1/2] commit-template: remove outdated notice about explicit paths
Date:   Fri, 30 Jun 2017 17:42:20 +0530
Message-Id: <20170630121221.3327-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1498792731.2063.5.camel@gmail.com>
References: <1498792731.2063.5.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The notice that "git commit <paths>" default to "git commit
--only <paths>" was there since 756e3ee0 ("Merge branch
'jc/commit'", 2006-02-14).  Back then, existing users of Git
expected the command doing "git commit --include <paths>", and
after the behaviour of the command was changed to align with
other people's "$scm commit <paths>", the text was added to help
them transition their expectations.

Remove the message that now has outlived its usefulness.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Only commit message has been changed. Modified it a little
 to remove the self referencing words that didn't seem to suit
 well with the commit's author (that's just me :))
 
 builtin/commit.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8d1cac062..64701c8f4 100644
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
@@ -1208,8 +1204,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
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

