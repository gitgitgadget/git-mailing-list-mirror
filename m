Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41702C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbiF0ShE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiF0Sg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD68C18B1C
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k22so14269649wrd.6
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8MAL6kv4INxPRvKLx6NLKMqEw4XIEcWrotDyLEp0s8c=;
        b=TG6FnHdttTWoA9jXwXVy75YoIfcSt8Yp9lMlj40LQTG858Uv3JCp/HGkvbySm0gNFG
         gKEdtq5HKDRDvqP2VnmUZ9lQhFaVY14JWb8WCMl04+dixbUMPmFZILHcIs7D6la2xj6R
         Gmkjw4YNMyZisnGIIWnTtWf3rysurEd7gihFuzbFSstftofhisnhFDuSzk3H04eusBf4
         025InuOgGzNFxmZTC8E16eZAtjVv7jQsQOdzAaEpS1nANqmkXpsEcUdx5LfHAjkZO5KQ
         4huPlSDPW6I8FzNVuVZQMkvoZ/9AjNblVdb35heHLQnkQMNffxQ6tmoPbU+K4+r1henT
         K78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8MAL6kv4INxPRvKLx6NLKMqEw4XIEcWrotDyLEp0s8c=;
        b=kXUQTV4qhbnrmW5xVk7xER4/eNdgHDpHTK5S03pwN0FqOFuPTN0/CAF5lipOaKFuPq
         GR61L6UKatZgfGaeu5TAr13Cxdi7N4u6qh8lm3HaIq+W+OFivKJ+zsLosSwgGrX+CWox
         bij1xJjnmz+8HC0RbW8yyA7++uFzDT21BLgMlYgfoM1TZRu81yiwIwfTxZXkkFUnjLvY
         qwtb7zqqhWlEQmHhg6COBp5jCFnTPdT5m3wHG7wNe7evsxU6MnC/utmGd5NiVqbVH2cH
         iCUibDx7excW570Zha3NP/jJb6DVwtypmVFi7hLILPXU3w8/nYZA/iX+W7H0Xr2SzxjH
         Hxdg==
X-Gm-Message-State: AJIora8UYVSSPLn37sBniiEkDFhFSUoUKVBDyO1+//IxFJaa1gL/Bo2C
        olW03vzDsTDOw70bNZdQCAGB0JGPoEB2kw==
X-Google-Smtp-Source: AGRyM1uaEwoXaYraY9iMQwmAxrCBbtq5BLPHmPRsKLiZX8jIapEmNNBKAZiXdbO1mfDLgU0pbYF3vw==
X-Received: by 2002:adf:d1ea:0:b0:21b:a6cb:fcf6 with SMTP id g10-20020adfd1ea000000b0021ba6cbfcf6mr13522253wrd.477.1656354692987;
        Mon, 27 Jun 2022 11:31:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8-20020a7bc448000000b003a0332760c0sm13967688wmi.16.2022.06.27.11.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:32 -0700 (PDT)
Message-Id: <ce508583e455a1dbb7620a238edb11dae195f00d.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:12 +0000
Subject: [PATCH v4 11/16] bisect--helper: return only correct exit codes in
 `cmd_*()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Exit codes cannot be negative, but `error()` returns -1.

Let's just go with the common pattern and call `die()` in
`cmd_bisect__helper()` when incorrect arguments were detected.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 22099b9ebe2..86195058cd5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1327,7 +1327,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_TERMS:
 		if (argc > 1)
-			return error(_("--bisect-terms requires 0 or 1 argument"));
+			die(_("--bisect-terms requires 0 or 1 argument"));
 		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
 		break;
 	case BISECT_SKIP:
@@ -1337,13 +1337,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_NEXT:
 		if (argc)
-			return error(_("--bisect-next requires 0 arguments"));
+			die(_("--bisect-next requires 0 arguments"));
 		get_terms(&terms);
 		res = bisect_next(&terms, prefix);
 		break;
 	case BISECT_RESET:
 		if (argc > 1)
-			return error(_("--bisect-reset requires either no argument or a commit"));
+			die(_("--bisect-reset requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
 	case BISECT_VISUALIZE:
@@ -1352,18 +1352,18 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_REPLAY:
 		if (argc != 1)
-			return error(_("no logfile given"));
+			die(_("no logfile given"));
 		set_terms(&terms, "bad", "good");
 		res = bisect_replay(&terms, argv[0]);
 		break;
 	case BISECT_LOG:
 		if (argc)
-			return error(_("--bisect-log requires 0 arguments"));
+			die(_("--bisect-log requires 0 arguments"));
 		res = bisect_log();
 		break;
 	case BISECT_RUN:
 		if (!argc)
-			return error(_("bisect run failed: no command provided."));
+			die(_("bisect run failed: no command provided."));
 		get_terms(&terms);
 		res = bisect_run(&terms, argv, argc);
 		break;
-- 
gitgitgadget

