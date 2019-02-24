Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E417202AA
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfBXKLn (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:43 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45004 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbfBXKLb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:31 -0500
Received: by mail-ed1-f66.google.com with SMTP id b20so5190756edw.11
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gJVa9u1wfPiIxgZuqSzYZ9lWvlQNuPMM5dU5oM8uMr0=;
        b=B7N+wb/V0RWvydEPRdmrlprrK/7nJUY6tk/ZGQFEk0oV10RHV5eEFkWmj7WPmbQxyd
         2qU0pVvgfx0cokcnDAQN5bgQ0EpyL7f5NB55qzk505uMMmd296G2FGFgayc4VrhZZQPu
         GaRQg87/4UZyBUrgR7FPFR3KpykHN5gNsnACnyKte4e/nSt35sbYOf9bhqlhviKrrSnE
         GykRWVr+H+1GDcLR4WGWWF2KC0I0VsgrC+vr1evLPrFt4h5dlP2Rz6IRvWFGFys+I8sX
         IvWaX+IwsaMjutWZBzw2Tn/CraYYT2cjQA9Ni0iIqxijpDnhX7AUpXQ0DoRmHWU2qzYg
         PsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gJVa9u1wfPiIxgZuqSzYZ9lWvlQNuPMM5dU5oM8uMr0=;
        b=rrscTbvgLl5SEmc6VWJBVfqMGOrFey3DY1D7GuQuH3GJF3L/vnQsYeyAbdSEvNFady
         pV9vo+EqmJocttILVydg9yRPxGAw25FJ5ff9Pohdd54IeAQGh+KlxwnltMa2GLVUUVi0
         hHhQaVVuNH+JYsntsOFpl7e3HklZBjTtFmu7IPOYasVBuXSZhi/bBoEsr9V7XUReYZsa
         kxETdBdq8b3cw8PkGDm4+3lI+Fj3GSiJU08klUAyHxVf/t7UTvTR9TClWuaR7bnwi7SS
         r03sTfvw2EriBgs43NGOhs3w3zBpKNFTBW708atvBG2YEUfkZ2rgBnpaBMqbKE+6hVg0
         pNzg==
X-Gm-Message-State: AHQUAuYWoADxdBhMDNHt+e1WSdiTT9Vs1kr++7mVpz611l3Zw7NqSjhJ
        Brrt0uJCwAotqzJB2GzEa1nIZa8n
X-Google-Smtp-Source: AHgI3IZ5vPmhDatiwFk4xiYs8y70QSO8LtiH9pv3fJDIR9mqSFqCVP6rGSlvieXbA99XSY6EG/sY4A==
X-Received: by 2002:a50:8b8f:: with SMTP id m15mr568553edm.132.1551003089054;
        Sun, 24 Feb 2019 02:11:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm1194778eja.11.2019.02.24.02.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:28 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:28 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:05 GMT
Message-Id: <f1db62c3235e5d91a21b3f7b92c5aece8b65f600.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 17/26] bisect--helper: retire `--check-expected-revs`
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

The `--check-expected-revs` subcommand is no longer used in the shell
script and the function `check_expected_revs()` is called from the C
implementation of `bisect_next()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 49ef0ff6bc..9cc11450f4 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -892,7 +892,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		WRITE_TERMS = 1,
-		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
@@ -908,8 +907,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
-			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -950,9 +947,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
-	case CHECK_EXPECTED_REVS:
-		check_expected_revs(argv, argc);
-		return 0;
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-- 
gitgitgadget

