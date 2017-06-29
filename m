Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9D420281
	for <e@80x24.org>; Thu, 29 Jun 2017 17:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbdF2RCC (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 13:02:02 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33482 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbdF2RCA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 13:02:00 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so12587810pgb.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 10:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5LtUJ7D1Ep4WKCRASaDXvlkuCkIlRJg4/FcNFdijmmQ=;
        b=L28cDvlXbIPulG76z5hQcRRw2IebmpN6O0hp2Sp1PUrtKWoFVGATz6Ir39BQ3TNFQr
         ItsqVQ8AkdtzUW29J4oj1gREtr/VOPWWQJ8to3sBc0iNXpRHtZSsFspqqVe9GYFpPVud
         sMnEQNJKjnovAU0CCSqERDCUGwsPfqY+464x2Eo8bf30YRMRMlk4kmKdoUVtpnXdhNR1
         BbqKkBb41zSV68pVNZ/k62OM/zUEU4M9PpnBdRRXCAM+ImCbsxZBhrGRqtwIIo3OP09d
         e5fyhHrGH2XgNUPou3VbS2ap5ELGxAl80KWOZg6y5jYewc9eYzxGu0DJR87df9e6wnP/
         CwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5LtUJ7D1Ep4WKCRASaDXvlkuCkIlRJg4/FcNFdijmmQ=;
        b=qMzqYuOYiHUWBtbVBteiets7F2WLX3eR6iuMzRT07gwhlP2/ZfZCfm4WpJ25dtjR/N
         0eKbCrDnv/ENPN2lNYQSBNn8Nxga9ZCC55U7pOsEL8tsyYgjWaA+jI7vLIOGplx28Deh
         Ll06oW8nrg6W5T/1kEQhZkIPHTeNHz7PXhrDDalK5DzL0h3W8VrXbECviHWyS51miRv+
         3iW655EA3+srURllWsJIHoz9DiwimTpw7258D43t4kakhxV1+ShW16HqKY3/GFZXNhpe
         f8QWzhHDUXg9YjENQucN67k9qzWmHxrOvtZScHMVnQb8Ta/Z+WlM0ODP/8XJBv2DOzvU
         hdRQ==
X-Gm-Message-State: AKS2vOzeK5uxM3nqvynb78a7wkfYItaypTB701ipamuiG5GF4UatsCTI
        HuH6dSOjIOITOZrbg6K6Pw==
X-Received: by 10.84.217.26 with SMTP id o26mr19487006pli.223.1498755719724;
        Thu, 29 Jun 2017 10:01:59 -0700 (PDT)
Received: from localhost.localdomain ([42.111.134.170])
        by smtp.gmail.com with ESMTPSA id p28sm12962577pfl.102.2017.06.29.10.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 10:01:59 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 1/2] commit-template: remove outdated notice about explicit paths
Date:   Thu, 29 Jun 2017 22:31:19 +0530
Message-Id: <20170629170120.11479-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqqshikvz1s.fsf@gitster.mtv.corp.google.com>
References: <xmqqshikvz1s.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The notice that "git commit <paths>" default to "git commit
--only <paths>" was there since 756e3ee0 ("Merge branch
'jc/commit'", 2006-02-14).  Back then, existing users of Git
expected the command doing "git commit --include <paths>", and
after we changed the behaviour of the command to align with
other people's "$scm commit <paths>", we added the text to help
them transition their expectations.  Remove the message that now
has outlived its usefulness.
---
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

