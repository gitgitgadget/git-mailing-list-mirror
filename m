Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E717620248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfBXKLy (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:54 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37680 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbfBXKL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id m12so5220730edv.4
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g7mAQqGPEEotq6e8Ltc1OVzXX9XqMuHLltGTK0Bo6GQ=;
        b=vALSPnDY1kQV5fALaDjmHFGNmtogV7aQ/g6o01lmnQi9oumbJo3EdrdnpTiL1KYMGH
         a5cU7js8FUtjUY8ZSJPwxzkbR4xOFSBqdkU+oYH8lLi4DRgQFTheP1UIWk3kPW3au0XQ
         4WnFxAoxMOILNUvqNXMRWejZEoPeIgbHKuplqL7NknV1heVKtY1WXAAkXBvCC6DPORLk
         syH2R+ZWqZykKHzgJUaLna5BUkwMWmTGyAZ1Y6WEPRFAXKUKXHjvYa+da1rp0Xpa5jGp
         CDy9a4JSZEjoRWCh+V3bdjVOUc0Jk84ZnAYwP9kMlMWY0ZCF+k1gveCHP7lthRVCrIz0
         UkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g7mAQqGPEEotq6e8Ltc1OVzXX9XqMuHLltGTK0Bo6GQ=;
        b=D79Tsu8saSkY2ahbZZ1OE6qct7xLJibtLUcv5wNj8PdIrMqiOtP2Z/kJBDG1EiUIgX
         O2QB7ptRF4cyc+AaTNRrzhKKfQmM80zynjINCXnWmPhK8DkuqQGwAN2jEN43JSzQx2fW
         7/0nRt3OSJiDoHm0ln/62IKTWLbZ/DBpGtLxJQJV/E0xPndtvam4s0fwdKctRbnRICmc
         7GlNq89luYA0BrXR8EA23XfBKF3fBOaR7C2mtEgWAD80w2ibNHCMQSivxkYGsw34TJgP
         f2OINUNam7TgLuHe0Tqp93i/MR8MykTqjs5adN3iMkMqMRS6orEg3mM/QnMH1PXCgCNw
         9I3w==
X-Gm-Message-State: AHQUAuZzuE4vTnBe3x4rwej8ttbHIl+6o1Gh1vprzHWY+Z3UYu+IZImT
        hLlI68PeTgYC7UsxGi9MzXgkxqxM
X-Google-Smtp-Source: AHgI3IbYG7drEovvg44SM9imtrkpAbofxPzJJOuAg7WcReiJAfKJziDImzissbOHipBlCCKu5Qf+4g==
X-Received: by 2002:a17:906:858e:: with SMTP id v14mr3519796ejx.15.1551003085970;
        Sun, 24 Feb 2019 02:11:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p44sm1828580edc.1.2019.02.24.02.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:25 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:25 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:01 GMT
Message-Id: <99c609453637611b1bd47030675cb4b635beed8c.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 13/26] bisect--helper: retire `--bisect-clean-state`
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

The `bisect-clean-state` subcommand is no longer used in the shell
script while the C code uses `bisect_clean_state()` thus remove the
subcommand.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index b9f2138811..b4f84b3041 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,7 +22,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
-	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -795,7 +794,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -812,8 +810,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
-			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
@@ -855,10 +851,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
-	case BISECT_CLEAN_STATE:
-		if (argc != 0)
-			return error(_("--bisect-clean-state requires no arguments"));
-		return bisect_clean_state();
 	case CHECK_EXPECTED_REVS:
 		check_expected_revs(argv, argc);
 		return 0;
-- 
gitgitgadget

