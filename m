Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB99C3DA6F
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 21:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjHWVy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 17:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238324AbjHWVyC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 17:54:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3A1E52
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:54:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59224c40275so37267937b3.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692827640; x=1693432440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yn516+F8TP3bMPM3VH2wJkYdgK3cLGYRbNTqJIasxT0=;
        b=osnzKv9ddHHup4gqPx43FrUu5V5hwIRUdLEt5jj1lH6lE/a5OUdcscX3Kl2kqCJXBq
         2hvoy2TStvUZz7NBnwr001PL62rjwVVWUiBxHzEcdMiCLjG6rkOj+Vb4OwtXB2O0NJ+0
         K+TfvDr9YVkEuRe5P15oi24WT0Aa1xi95LZQK1E/sDF4uyW+xndfgdI8uvYq+X+do+Oy
         hds+OmwiXvY005jv0xNMSJDW7QuOeyBoP1BeV2xyzVo3KeWeVe0XIP9Ykkh/sOxNAePb
         hYKrxvCn4wPMHAYKA9dAhEN0WeH5vwP3AiJ0h3e0HOGQM67HnB+RDjIrZpy4Evj0SDT7
         rc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692827640; x=1693432440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yn516+F8TP3bMPM3VH2wJkYdgK3cLGYRbNTqJIasxT0=;
        b=Wk5o03wD21Vn0SlWWz37OciMjNMhJLxgiD6rJfdzo+Ih46rs/vuSlamYjizc3jYnlv
         VEv/FitN0tG7C4wKfRFXVOMaPPBLby2ufqxmMPR+GweK2fm1zLW7CUlJ5nLYq9yOK2gf
         zhl8HgvY0+1a+BrxjMyQ8Gmr3I+47OyKpGObR07qSvJxKfpSMcyV9aAuqIVMPaxhWyvV
         bUMoN0C/LKNlpuPkp28Cnhy0WooCWnUdfZnFEvJck1/nzOT2m7VNUo0a3a08cLDrwBWi
         DWxi/MYr5pTXZDKuIa3j3f26Uf/fUziHl263lq7Opc4HE1VknjtKbhTV/Wk5RE+se+Z+
         Fy6A==
X-Gm-Message-State: AOJu0YwRoQU/UBVyIwINT4tsriTZWnx2x0JjDO5hYHlGQv+CFcbslwuO
        2GJABeDteRqJax7DLwNInAG9iitD0nyKpAWsnF2/Os0jqZvZ6IPmD+gjeAYRmFNpqH/7MAq2pMa
        mebBIhPusq1iPCy7QljHu5EHOn5NN8c/zxvlOfPs1XJB9Y8PRthVULj/Zu08cmLA=
X-Google-Smtp-Source: AGHT+IGnoYQd/eVmBhC2CASpbTP8TGduWNo+3ttHxSt3/uswsQWVTOWJKpQ6emvfr359Rf6KVg9uzuA5CJiEGg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:83ba:288:9608:d4be])
 (user=steadmon job=sendgmr) by 2002:a25:ce44:0:b0:d72:8661:ee25 with SMTP id
 x65-20020a25ce44000000b00d728661ee25mr183737ybe.2.1692827639756; Wed, 23 Aug
 2023 14:53:59 -0700 (PDT)
Date:   Wed, 23 Aug 2023 14:53:50 -0700
In-Reply-To: <cover.1692827403.git.steadmon@google.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com> <cover.1692827403.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <e034d0780c886a334c51bc91fe8f145cbba65353.1692827403.git.steadmon@google.com>
Subject: [PATCH v2 3/4] config.c: accept config_parse_options in git_config_from_stdin
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, calvinwan@google.com, glencbz@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

A later commit will move git_config_from_stdin() to a library, so it
will need to accept event listeners.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 config.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index 6cf4dafc6c..40cc9dbc40 100644
--- a/config.c
+++ b/config.c
@@ -2024,12 +2024,11 @@ static int do_config_from_file(config_fn_t fn,
 }
 
 static int git_config_from_stdin(config_fn_t fn, void *data,
-				 enum config_scope scope)
+				 enum config_scope scope,
+				 const struct config_parse_options *config_opts)
 {
-	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
-
 	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
-				   data, scope, &config_opts);
+				   data, scope, config_opts);
 }
 
 int git_config_from_file_with_options(config_fn_t fn, const char *filename,
@@ -2264,7 +2263,8 @@ int config_with_options(config_fn_t fn, void *data,
 	 * regular lookup sequence.
 	 */
 	if (config_source && config_source->use_stdin) {
-		ret = git_config_from_stdin(fn, data, config_source->scope);
+		ret = git_config_from_stdin(fn, data, config_source->scope,
+					    &opts->parse_options);
 	} else if (config_source && config_source->file) {
 		ret = git_config_from_file_with_options(fn, config_source->file,
 							data, config_source->scope,
-- 
2.42.0.rc1.204.g551eb34607-goog

