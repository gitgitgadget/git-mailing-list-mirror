Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F1A20248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfBXKLz (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45003 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfBXKL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id b20so5190686edw.11
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bMojXkWX7U1iCqlvCmYP8jCehWsev2f4wdsNuVIS0ig=;
        b=O+11UUr8Zg9zEaTi6dg1lZ8qD+O1Dqwopf7OjXiCUYT7AwUjOXTeo99124FYzdDnqO
         w6hg9Im7yvWUT4Ef51jjIwkLeDeTwT4Ui/3ysjrEdiHLz9z3c8G8SRHcqejiSBIRLYkR
         KTdu2n4L/6PBEhgfnvsjXjjyWXWIKZTOVGPBYTiqGusfLF2RAg993uqnsjppG0ewhUFo
         ieXgfRgTKugeZquGisNplH9ICm8+BbLndk1ze7GMCg8/UeqjmcnfSoqRce1TvujjOLTb
         1FVp7cwRgW2cPodrgQk0gs07xUvjYjCafdd/vmc6ZDMmjwAh5q3KBia4ULSVGmtcfRPk
         Vl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bMojXkWX7U1iCqlvCmYP8jCehWsev2f4wdsNuVIS0ig=;
        b=f7sH2AbemKNJWCFOrS+clEwU2MgSBuJeh5fuJfNugfp5n5CzRRnngM3YZCqvjE5YL5
         sqngDW45lm3mZTxyi9LDavjty7Futwnre/I8qPZTbw30HIYdJCfO1TOb6YEW/28Qd+wr
         SdDbjsUgL/x2FlTLJ3zOM2xkHKqDe8Oz8ifxiMZMnh3ikq/mQoJLJFkHj7E2pjFslEJg
         KY7UycaF+N6TCzOFAWnIVBJx6hN1M21NPgKtJXHxgHT/hkWGlxgn7vwzU0BlLSXYDwQX
         4zd1ffePVky/jvLqTNjty6HuiMuP9djG5Q/BaF75mueJ6fSwKk8VaEYC+VvtSUlgsn+6
         TRSg==
X-Gm-Message-State: AHQUAuYCG9t514lnW1CCm1ZhoFh+9ttc3lSQmqCarLyanZ9pt2+3/01v
        lhxKEUW3AqIIi8715lLRWo6MEFW7
X-Google-Smtp-Source: AHgI3IZMpUv8P+siZ39ETQX79I21/OzIlz6aoUwE5957O8ITvQ51hUhGA3skAJisVctQqUqhvJtStQ==
X-Received: by 2002:a50:9737:: with SMTP id c52mr10601500edb.190.1551003086690;
        Sun, 24 Feb 2019 02:11:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm1847537edb.11.2019.02.24.02.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:26 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:26 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:02 GMT
Message-Id: <4b417e183243300d94ed26d9bcf530613cb6d8f7.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 14/26] bisect--helper: retire `--next-all` subcommand
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

The `--next-all` subcommand is no longer used in the shell script and
the function `bisect_next_all()` is called from the C implementation of
`bisect_next()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index b4f84b3041..1a525faf27 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
@@ -792,8 +791,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		NEXT_ALL = 1,
-		WRITE_TERMS,
+		WRITE_TERMS = 1,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -806,8 +804,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "next-all", &cmdmode,
-			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
@@ -844,9 +840,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case NEXT_ALL:
-		res = bisect_next_all(prefix, no_checkout);
-		break;
 	case WRITE_TERMS:
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
-- 
gitgitgadget

