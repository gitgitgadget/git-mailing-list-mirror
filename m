Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C9420248
	for <e@80x24.org>; Thu, 21 Mar 2019 06:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfCUGxz (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 02:53:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38384 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfCUGxz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 02:53:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id v1so3576077pgi.5
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 23:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K83xnFPAcB1VIULC86KP35ikutyNj0u9e1zEXL9YwpU=;
        b=dI6BMzhZPqUwRwa8aU3Xy7GlO6hZFX7rLI8qa+DS0cEo5RFKUidDofZwlxWz16ur6W
         7dTbcofYdkjlgJUl1NGiHcYQqn8JMb4ozhNtr3k+w9/wR6meqRCBcEujSqe3+G0P+oHK
         2CzlGFr5PvucHyM7TDUUtjIzmYDMmnapJPPbJrWMDXrn7d6Itpvx1Z6bP4rnGqI1xy/v
         u+J63n1mK4yYOTA9kSqvRRjfNxRONvO3bFC5vToBzr1tbUxJR5QYlVWB4XEa232u9xFq
         ETdE4BxkZcLJZCpLEImoIYrt+RGHrwjRITcAz2aeF3A0+fY+R+D/LfpIlH63owTMzu0L
         tjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K83xnFPAcB1VIULC86KP35ikutyNj0u9e1zEXL9YwpU=;
        b=n00PdRqLGYBdT31DhKoGek1p4rjFBKk+klinsdmGzklMums/vDfx6Vkdr/t2E4T90U
         ZqoxYjb5wofV61PG5Hu/MMtYhTWFyz6tf+c+HWG4jTIAKxaeLtbrsVDoC9OtHxzM+mbf
         5kXZNKrh0NsvWVS3qg7BErHfKNzBNPc9T2FD9shsEZQGl+xkU22UgQUWcb2GOOyJJuqj
         yx/q1ZrloBDYjOAzHwF1E27fsRPYiZsCQ7GNmBqiRGX8zWp90kSTi5fVbKrnGA2Zw26t
         J67RTaFxcdAdJpT5/E5aGPAWkU+o1N58AOANNB2KBTYD1UNUvWF4jxhH+NvO57kdMxmj
         KqUw==
X-Gm-Message-State: APjAAAXBBVYjM4/ylJLhY5TCUz3NstQQYF87fLYX86452XQkKH+pW2py
        rcNhL3l2lDUSsLeFMeXd69IedGP0ZIc=
X-Google-Smtp-Source: APXvYqwiw8TE7QqFRxXTf06wjx/nX6hoKWotmThtTTZuwH0JxLDCt5zmcX96DRadM9ByfGhJLTmGnA==
X-Received: by 2002:a17:902:7786:: with SMTP id o6mr1977749pll.206.1553151234119;
        Wed, 20 Mar 2019 23:53:54 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id k17sm4808647pfk.166.2019.03.20.23.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 23:53:53 -0700 (PDT)
Date:   Wed, 20 Mar 2019 23:53:51 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v9 06/11] parse-options.h: extract common --cleanup option
Message-ID: <2c966ae31840cff8f58e64d203fdddbf9ad57f87.1553150827.git.liu.denton@gmail.com>
References: <cover.1552817044.git.liu.denton@gmail.com>
 <cover.1553150827.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553150827.git.liu.denton@gmail.com>
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

