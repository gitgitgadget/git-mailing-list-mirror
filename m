Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F991F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 09:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfJOJGl (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 05:06:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45086 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfJOJGl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 05:06:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so10546626pgj.12
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u0NadWrCUcjcBtAkG0sbT61miwZyQjEaFhEdj7Qo+Ik=;
        b=nFy0T9OHJWjUI74D74wpNMbStJprqILj94FgXQY9gkCICHLsNdiuzp9CKXT5lbXVX6
         rRUGqkG7yd+4RH9ak+qnL3nzartE3ld8dRwraJjFWAxf6ZSlUgl1j7BT7vJxDdODtEyP
         AT1CR904qQiup6vKo4K2bNx0YnwmnCbhsRWUbNSMtrHEW9CYceMKwXES7abkPX/8VFH0
         9nfJphBlCgInaUOHCOv9Z/S19FZTmYQkIqyvfOUjyFpWH44NRW0aYVA6HYp7Gb/uW0Jd
         8UnGYp55cZDOzwTE0899tpFH6RlmVukM0zwpH28iVSdTpCncm1nWtEtRvO3p9kt+gfSc
         Ayow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u0NadWrCUcjcBtAkG0sbT61miwZyQjEaFhEdj7Qo+Ik=;
        b=oG56cykak8jXbtnSTNL3czI/TNJDOWo9KxQgfc9gdihx16FKWRQrG6zCFIXuQp5yj/
         2oAWWx3iepNlSi56sGPUsu9ksXibGww3jKF34fQdFSluthYhKNqnbU8bKq8EzBri+PG/
         h/H4nwf5TOGW3Kj1qcQLZZz58hc0YrlFzW4cY+/r1CUJETUaHN4vObzBD9HdvK/sUMBy
         WG3vqxZcKobJfZ+07PhA+CqcTiZX4V78XxIHSTNuJd7pq2GSEXjusEqoxijNOPe+ZTNL
         hTyOJIe0gmc0a3SXrsHuIo0QU27la9U4uMYZEbmjJ87Qwf18bmpjoYvyNG0QyH0rvJUT
         fwmA==
X-Gm-Message-State: APjAAAWh1kpBfor+XIy4KJIAwLxjeHEJWbwQybNlmRrpFdVgb7Tt+V0z
        ibOdm2iDxH56WA9+fb3iWTEUuMsq
X-Google-Smtp-Source: APXvYqy3KAuVIr1+79ceHUjuTS2hXydAvHCXoQEV1f+HNRMmrpFQMG4TDBSMGr/+l8ogJRcWu9kTsQ==
X-Received: by 2002:a17:90a:86c2:: with SMTP id y2mr40405956pjv.105.1571130400292;
        Tue, 15 Oct 2019 02:06:40 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id e16sm9457686pgt.68.2019.10.15.02.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 02:06:39 -0700 (PDT)
Date:   Tue, 15 Oct 2019 02:06:37 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v6 2/3] format-patch: use enum variables
Message-ID: <821e706bae6fd15a3d41022934ee0b290bb47ca5.1571130298.git.liu.denton@gmail.com>
References: <cover.1558492582.git.liu.denton@gmail.com>
 <cover.1571130298.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571130298.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, `thread` and `config_cover_letter` were defined as ints even
though they behaved as enums. Define actual enums and change these
variables to use these new definitions.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 351f4ffcfd..d212a8305d 100644
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
2.23.0.17.gd2208d9060

