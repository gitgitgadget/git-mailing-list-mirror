Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F5B202AA
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfBXKLn (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:43 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34991 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbfBXKLb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:31 -0500
Received: by mail-ed1-f68.google.com with SMTP id g19so5234976edp.2
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h7PMWlyKKrpUGCISt24ek3jJZkvQMgstUU3PuPifBtc=;
        b=ce8cZ36O4HzKGCaSXLZv0x/f0KU+e+s0mgFr4BJ+QlXJKI9xLBgYlhq1IbQP6Ig/5r
         Q/otrsa+k+NErlnd5M/S6hLbPO2Sk0swI5in2DZkFR/WgB3aE7/XjTBYoR5SguHmHTDF
         VGm5pfk5L/8BEUDOJJG0TLN9R7WAq/U/fu9EABLQmU8ivL58kGs0ML8ysZyjzhsWFNqI
         QSvKerTz/4ClCUdwP/1koSoFz2R3TlUJPYl6qgnjubegeUAjRbTYNbIDhMzmybSQAEip
         DeRYNgdTPVFEwrrH7PH5ajUEmaPjf9HqVYabNhuweepkKmz164bL9g2jldjUaPNzAHnz
         E+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h7PMWlyKKrpUGCISt24ek3jJZkvQMgstUU3PuPifBtc=;
        b=Dk9WSu5amzqXUJV3R5i6CuCAGs7jR6U/m8uScgCm8PwokCBTC3gHm9U8tXv1PpZyYS
         QVsD08DqgN+EJZRKm0HbOitSIyfCKLRbw/N5UVOgH5znZBu19cYdgTWqiLgWGfM9Yf9Y
         7mZaFueZve2ANY3pkRzg4gp0RCeUZejL1ahvApICw1POpY/J8s5Z1/18z6k9D0emX4kx
         XZEPiD62zD4mU4OMWy4DxF1+xjHY0Qi+b4E06eAw/Msu4V0Ni9UTjSw6cC0kpqdG0u43
         chzBKVLf1bO2lxZK4Eo+W/On+Pt53QokBH0I4K9Q2xUWxaEmNVFT1GIbLr99bgBk7B6j
         djdw==
X-Gm-Message-State: AHQUAua/2iRNQ5TNqESjEp+5ohY8V/5U+uOMdZUq7V6Fmr0Al7l5Ubnm
        C8v/Zxx1HiAuof5r5AIdOukvCVey
X-Google-Smtp-Source: AHgI3IbO714+26mTHKrSIaL/5tt9hBTBGLZwnffhJ1b7heu4ZQGAQ+y4HOb6h9+Q8rhKipUpuJwKNA==
X-Received: by 2002:a17:906:a28c:: with SMTP id i12mr9029821ejz.232.1551003089858;
        Sun, 24 Feb 2019 02:11:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k15sm1855962eda.22.2019.02.24.02.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:29 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:29 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:06 GMT
Message-Id: <64475fcde911a79fdbc207e5d47a526582a38eef.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 18/26] bisect--helper: retire `--write-terms` subcommand
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

The `--write-terms` subcommand is no longer used in the shell script and
the function `write_terms()` is called from the C implementation of
`set_terms()` and `bisect_start()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 9cc11450f4..d6308cabd2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -891,8 +890,7 @@ static int bisect_state(struct bisect_terms *terms, const char **argv,
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		WRITE_TERMS = 1,
-		BISECT_RESET,
+		BISECT_RESET = 1,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
@@ -905,8 +903,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "write-terms", &cmdmode,
-			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -943,10 +939,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case WRITE_TERMS:
-		if (argc != 2)
-			return error(_("--write-terms requires two arguments"));
-		return write_terms(argv[0], argv[1]);
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-- 
gitgitgadget

