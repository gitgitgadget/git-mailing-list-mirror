Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8F620248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfBXKLi (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45100 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbfBXKLe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id d9so5178228edh.12
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/DGZbxQ0LK5qVdcc2aMZ3kSC+FWi24C6/OVtM5nKCCg=;
        b=hEynk5oHZnpkAqVzd+OcLDNsS2f+L9GHjzjtwFUjaAInRKdaVfJin9q6Gykfaj+NDl
         mswUyJuhZXoc1TW+D5eABffpwbgABMnN+ho+2Ss/qmj4LpYMIPu9RhzVDJ+a4WpEHYDH
         9mZ6mbIJ/MWkoJB15BwFYVzD2xwXzYQeXSL70A8mifJj1ye6NmZDjVw7GQCU2alcj5iy
         O0f2WzWEFIM+DXml9//0I4GHy6dZY6vjR7TkipKN4J8U3kdv6p+Ujv3hy5B/kJFhx4Ve
         3ItZjGHkema55YQnTg4myPXCfiad98grbGaREV9UULTGVRrNyEw4fNRC8jTDbNiXLxJs
         J0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/DGZbxQ0LK5qVdcc2aMZ3kSC+FWi24C6/OVtM5nKCCg=;
        b=k88m2IK0LlHHtHz8cHV9o7yut+9GtVuVf0RSjwSJvx1n749TMZfCnFp3oRybRsq7be
         nStLDEtbIS1geKXvi1KFJFWzS517N+0MGsTjzdRPC8HA5IgoTKXP1b3sclVA5I9nV/EN
         9Njmb/AdMwjXpqWOI9vJI58gNhLfU+qsuURrHLsWgt+R0rfA7Ad1vuG4GwYgr1cQa+iq
         yXiwfSWyZUvMG6B/p28NF9NRQWSSj8JWbV8yiH5e89pWybE5g4QmxLZIOfCxlnPcxsmp
         /xIMym/5TAz4UtQjFZJJUhn+Wy0ZCxN0kpXK+GimsAYE1MzaeSFpLybSzmV2uGepNJhV
         eNiw==
X-Gm-Message-State: AHQUAuZKkAuzr1XIqY6ecwyHhhhvwEOO76PwcQwWbv6xvvsPxX81JiRL
        bzwpRB5FBJTfOvaeTOkdnPYotRAe
X-Google-Smtp-Source: AHgI3IZ9AiAS5gRvAgxsL74liEUMbh2qiNsspggY1nAV7MrJHTszr/Hs09MFAOq/Sb4dDWsroSc32A==
X-Received: by 2002:a50:b646:: with SMTP id c6mr10341416ede.149.1551003092049;
        Sun, 24 Feb 2019 02:11:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f40sm1288740eda.25.2019.02.24.02.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:31 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:31 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:09 GMT
Message-Id: <beeb6967e93bb1e6733411404d437970510d2a97.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 21/26] bisect--helper: retire `--bisect-write` subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-write` subcommand is no longer used in the shell script
and the function `bisect_write()` is called from the C implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 6a1920d3e7..6cd74049e8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
@@ -1015,7 +1014,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
@@ -1031,8 +1029,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-write", &cmdmode,
-			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
@@ -1072,12 +1068,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-		return !!bisect_reset(argc ? argv[0] : NULL);
-	case BISECT_WRITE:
-		if (argc != 4 && argc != 5)
-			return error(_("--bisect-write requires either 4 or 5 arguments"));
-		set_terms(&terms, argv[3], argv[2]);
-		res = bisect_write(argv[0], argv[1], &terms, nolog);
+		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
 	case CHECK_AND_SET_TERMS:
 		if (argc != 3)
-- 
gitgitgadget

