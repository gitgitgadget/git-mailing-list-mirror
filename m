Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0604C20248
	for <e@80x24.org>; Sun, 17 Mar 2019 10:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfCQKQM (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 06:16:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44660 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfCQKQL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 06:16:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id h34so9358095pgh.11
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K83xnFPAcB1VIULC86KP35ikutyNj0u9e1zEXL9YwpU=;
        b=iNzkGkT+roTqVyjABIFfCxN2Rh4mqNWYVsTljIoMvuu2fkerPFMY8Uj47SbkUkx996
         nJ21dbvGsB0l0EPoWp8+ViqM+ywa+bR8AF800Sc0lVhUPgQk3T4UmDWiTcfI2mOBorKX
         /9sWpiQsDxMd4WFXb53aDRYZlzXu3kqwYBNe6E1uXPLtqClSLJLAhuXpvU5DXMpEyMFG
         lrynZ7K7rL2uzbu30a62hi55KfeTJI/RmhRoYvUNnQE2kSh+NJH29Cv8NC+sFLBO6sPR
         LrS3gjHyTdIBQ2lTuWk98T+6w1KqJ85KIRP4tmcs2znC0dPLRxrcv7lZYSnHm4P/zDGn
         VDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K83xnFPAcB1VIULC86KP35ikutyNj0u9e1zEXL9YwpU=;
        b=B9RGYRCLwN589hUIZ1xIfw7EcCrBbIvqRYVhqF+ElkL6lB/OjSkIHAVZMhpNb0R83G
         njLAkhcbm+QpF0DFjRxWCzMMlcxeFGzAphO3pBjGo6dC41bnUAy6bo94bZnvLOsyWhsV
         BsbrWyB5BtmG5XU2tRLj/0fLKwhXIUPCGDTTGklnVaxEHtEytFTjSjwc4g0UHp3AaIq4
         Xmx0gU10444UBqt5Uy34ApzbGs/V7O+hWStWk2A7CK1j05z0gcUvH6ab+n4aNUwy5Um8
         9Bt0aWX7a33FDpcXbZOTb+uR3dvQyUYlQFjgG155d4WqyMeVi41I+M/5A4E03QQ0PsYk
         G6xg==
X-Gm-Message-State: APjAAAVEvSouHEEJbjHMobEiXf77JDxzYNvl9R/x8clGr4eWgpyzyFI1
        fo/GwY2/m8Q1t7RCzcQmcN832/5L
X-Google-Smtp-Source: APXvYqzh7d+YvzjR4jYXsajNsGSJZyTeMIj87K2CR0UFKZ4ffhpZSxKOgfQZbTsCuz4ZI/u79a/MGQ==
X-Received: by 2002:aa7:8d17:: with SMTP id j23mr10279103pfe.62.1552817770403;
        Sun, 17 Mar 2019 03:16:10 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id o7sm16967952pfi.105.2019.03.17.03.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 03:16:09 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:16:07 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v8 06/11] parse-options.h: extract common --cleanup option
Message-ID: <19cdc7528c155cd887299a7c24b3bd5ce05a67a6.1552817044.git.liu.denton@gmail.com>
References: <cover.1552275703.git.liu.denton@gmail.com>
 <cover.1552817044.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552817044.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --cleanup option is commonly used. Extract it so that its definition
is not repeated.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/commit.c | 2 +-
 builtin/tag.c    | 3 +--
 parse-options.h  | 1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0df15e4851..8277da8474 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1473,7 +1473,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('s', "signoff", &signoff, N_("add Signed-off-by:")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
-		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
+		OPT_CLEANUP(&cleanup_arg),
 		OPT_BOOL(0, "status", &include_status, N_("include status in commit message template")),
 		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
diff --git a/builtin/tag.c b/builtin/tag.c
index 02f6bd1279..a3870fbdba 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -397,8 +397,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
-		OPT_STRING(0, "cleanup", &cleanup_arg, N_("mode"),
-			N_("how to strip spaces and #comments from message")),
+		OPT_CLEANUP(&cleanup_arg),
 		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
 					N_("use another key to sign the tag")),
 		OPT__FORCE(&force, N_("replace the tag if exists"), 0),
diff --git a/parse-options.h b/parse-options.h
index 7d83e2971d..85faaee390 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -303,5 +303,6 @@ int parse_opt_passthru_argv(const struct option *, const char *, int);
 #define OPT_NO_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("no-contains", v, h, PARSE_OPT_NONEG)
 #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
 #define OPT_WITHOUT(v, h) _OPT_CONTAINS_OR_WITH("without", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
+#define OPT_CLEANUP(v) OPT_STRING(0, "cleanup", v, N_("mode"), N_("how to strip spaces and #comments from message"))
 
 #endif
-- 
2.21.0.512.g57bf1b23e1

