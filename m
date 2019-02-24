Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E79420248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfBXKLu (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:50 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43112 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfBXKLh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id m35so5189872ede.10
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rHrKf0HyWkGAG1dPNbeHAHHAkpadTVmL0jgrmdZlU3c=;
        b=aMz0o6tmGg8tgcX9mPVOYPnFcW8Yy+GzfsOi9usW7o4aGO8lNYvfmAs7cp6x4jfzbl
         nJiQkLaACINotHzORNMqmss/OPIiFqdhx3qXYqnegd3VYmT6YSVdkPoAxQLkzQcefx27
         SKUM4THpImTCvQX8iBci1FplnAEOr759sdJL514sN2ZTCx7KJDuuDQhXzySHpjxfoBbk
         NmzYgtmuevkB49pUhWQv65OEfYWzsvO6ORQjAJXJoq7uQOiMUGCEW6CPtzF3lRqBeEJ7
         bMZIHHE/ioS62pxF5w5I55EHHA/lMGKdRe4Zn71tCiUWrH6gDNlquAR4gWL1Ws4PpWQq
         29jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rHrKf0HyWkGAG1dPNbeHAHHAkpadTVmL0jgrmdZlU3c=;
        b=lGB459fMouWC4/obEcSEJino6QAA1qv5SMTyuL8sTDjqrhCLCyLe0TNHHBSZjsFbPH
         Afs++MFyke7YpOJ/4E2LOzun9Wnx1aY8SI8pxfjzT6cUW8Hq2WbnjQZkh2CQy4XOrmR+
         pAD1i5Kf0XmkDI0Ne5P0TZxeOWv849IKTmnZFvYIcRCyVy9hUwYFk701/BLZiPuAdw2J
         H1OVCMdK7T/3bEsdgXgUy46JnkXaloW4LJ2x9SAiAT5dd8ccGV1L3WFoWZySYH1IRFWW
         EkLDAwsBewAC6ngMWp8sgY53WSNm30qILa+8qNrhiOgCcuEm6SPiUO9kgspL5Em2+RnZ
         LI5Q==
X-Gm-Message-State: AHQUAuYOn4U6rylkh6wspuhpPXI17XVDtEs12MivFkrwQSyzbugvtkXA
        euk2VtO5soHMyzbh43NTODqwSeIX
X-Google-Smtp-Source: AHgI3IYB8hl7ywPluw8YRiFAPoHatYmKKn9qYvsnvovoSeK2GZejbs8P/YgwXAkCv+Ma3W8CSpPnuQ==
X-Received: by 2002:a17:906:24ca:: with SMTP id f10mr9323920ejb.240.1551003095658;
        Sun, 24 Feb 2019 02:11:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm1178356ejf.65.2019.02.24.02.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:35 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:35 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:14 GMT
Message-Id: <ee4eaeacc1c9f209a19e3b1dfc626e91522e770e.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 26/26] bisect--helper: retire `--check-and-set-terms`
 subcommand
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

The `--check-and-set-terms` subcommand is no longer used in the shell
script and the function `check_and_set_terms()` is called from the C
implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamil.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 0818dbf8ff..99e2c06ae5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
@@ -1034,7 +1033,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
@@ -1048,8 +1046,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
-			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
 			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
@@ -1087,12 +1083,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
-	case CHECK_AND_SET_TERMS:
-		if (argc != 3)
-			return error(_("--check-and-set-terms requires 3 arguments"));
-		set_terms(&terms, argv[2], argv[1]);
-		res = check_and_set_terms(&terms, argv[0]);
-		break;
 	case BISECT_NEXT_CHECK:
 		if (argc != 2 && argc != 3)
 			return error(_("--bisect-next-check requires 2 or 3 arguments"));
-- 
gitgitgadget
