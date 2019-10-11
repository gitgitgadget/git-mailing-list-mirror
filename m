Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED791F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 19:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfJKTM6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 15:12:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39439 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbfJKTM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 15:12:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id e1so6322621pgj.6
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=orb1ohQste3Ur6dznYHPAYahOGsw8zbQhhPr3gx4pPk=;
        b=UrbAEzjDYseZqyT9z5XhgBIUvnRhV9x9uz6alu6/iSxU4jKQphF9d29gEaAmIMGDN0
         G/KtxmGhVnuw4vM14byvi7kvZG2sTzknf2fLsnxlMMsk28hGA7JRtnemY5clWL1+yQOD
         PwdReUdE5o+XSvPmxJyKO5coh7+o+RLBUH2CprtNwZb8uW8x7BehV636NJORx/WgWH0s
         0xuyWu3V5KgSW9EDLRk8k2HZLUIV90VbzKOAen+0644yXFtuEcCbMNtfGnWlshirO6W0
         24Yl0o5OZ2Ab6LmALmQ8wc7UvMokLa9qMf7rAd/hEVZekDu+gKzC/l+8Hof+TSmBPxK9
         2XsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=orb1ohQste3Ur6dznYHPAYahOGsw8zbQhhPr3gx4pPk=;
        b=Wwk9XmP3MtcaiilrlZ0LmWwM9vtdhUjduYcDoQY3JMz8l4ZhurY2AfadFXgm8hEz/O
         HUBue1URtCZLpq6o2Z//eiDoy+8C4YJVDkZfeY4Blk6t3IuIN80cBUyKmt+NTgzIoi0B
         oDZ0oOl9rx1QbaGwOm8GQPJ7ikWR4/g/PMD4rB/DJ/Kqhyvj5KMiFCQ3Dsf4KvtONoQO
         VABgS1UU7iQD4DjXA6yaX6/uU8clsAEyj2hGlvZjZr6UdV4ZQzlgm2zNkRs+KRh1LS2D
         jjjkgtiNSxPgSXjlMXhqgMrhucfkHY4/XNIYghd+krPICV7wrUKoYFguBP+1WUeJ/Gmz
         atbQ==
X-Gm-Message-State: APjAAAWMXnWpyY4SgoMtKfHH1Ra933iSubFwARgBRXbTJ4Pam9lTw5iz
        5Do0Tw3HPgXQqDKSgmcnq9/FWBlu
X-Google-Smtp-Source: APXvYqwasO5WFRnbviHyvBTWMrEbZLFB/OnbBT+anfnqzt3qjqel3WvNOR63WVZO/+YY8qirSuARMQ==
X-Received: by 2002:a62:2581:: with SMTP id l123mr18362795pfl.197.1570821176741;
        Fri, 11 Oct 2019 12:12:56 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id z13sm11261827pfg.172.2019.10.11.12.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 12:12:56 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:12:54 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 2/3] format-patch: use enum variables
Message-ID: <19ee1f71493fa584991f530e952d9198880208eb.1570821015.git.liu.denton@gmail.com>
References: <cover.1566285151.git.liu.denton@gmail.com>
 <cover.1570821015.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570821015.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, `thread` and `config_cover_letter` were defined as ints even
though they behaved as enums. Define actual enums and change these
variables to use these new definitions.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 7d658cecef..f06f5d586b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -764,24 +764,28 @@ static void add_header(const char *value)
 	item->string[len] = '\0';
 }
 
-#define THREAD_SHALLOW 1
-#define THREAD_DEEP 2
-static int thread;
+enum cover_setting {
+	COVER_UNSET,
+	COVER_OFF,
+	COVER_ON,
+	COVER_AUTO
+};
+
+enum thread_level {
+	THREAD_UNSET,
+	THREAD_SHALLOW,
+	THREAD_DEEP
+};
+
+static enum thread_level thread;
 static int do_signoff;
 static int base_auto;
 static char *from;
 static const char *signature = git_version_string;
 static const char *signature_file;
-static int config_cover_letter;
+static enum cover_setting config_cover_letter;
 static const char *config_output_directory;
 
-enum {
-	COVER_UNSET,
-	COVER_OFF,
-	COVER_ON,
-	COVER_AUTO
-};
-
 static int git_format_config(const char *var, const char *value, void *cb)
 {
 	struct rev_info *rev = cb;
@@ -1248,9 +1252,9 @@ static int output_directory_callback(const struct option *opt, const char *arg,
 
 static int thread_callback(const struct option *opt, const char *arg, int unset)
 {
-	int *thread = (int *)opt->value;
+	enum thread_level *thread = (enum thread_level *)opt->value;
 	if (unset)
-		*thread = 0;
+		*thread = THREAD_UNSET;
 	else if (!arg || !strcmp(arg, "shallow"))
 		*thread = THREAD_SHALLOW;
 	else if (!strcmp(arg, "deep"))
-- 
2.23.0.17.g7cce04acd6.dirty

