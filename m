Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3389B1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 18:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeJaDeo (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 23:34:44 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:40931 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaDen (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 23:34:43 -0400
Received: by mail-pf1-f175.google.com with SMTP id g21-v6so6284787pfi.7
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mbgw8hWhS1sFl5zl1zaPv5luAHpmILd/F1As+gfv2aw=;
        b=WeJ1TbbmpT5P7ivrIiwruac/OpQ+a4UKpIQeDH830lD0aWHrRRRLbQXFQBbl59+iBY
         9qdmbL7+itHd91uy8z5uSo2Fk2ELjsP+Q9j7NqzFcSQj4F5+ozcT2H/X28NLT/d1ujsR
         SgJgKSxoM0fxd3DJNk9uOIqHPxmxfdPBzIBnnZUPEDXPpkqWkVOtkUtIgqKKslHgPivY
         vMr8P3txGkvLTDHFHpV7dl9DW9ieQgR8Uansli3151RQS6PSG/wpoasoXBkiXZ9LVG88
         yjnrExPVED0LAC37ygKybbORG1obY8yDhAARvY3seWf4EnuGMI7dzIrQUHDA09Xj5gtt
         VlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mbgw8hWhS1sFl5zl1zaPv5luAHpmILd/F1As+gfv2aw=;
        b=YbzigLPx5ldScE8ZY9TnAzmP9/1x+GqnkFKqWdsZbQkUUGTfIE+0F2J/kCVOsd1uvy
         uqO0+DbiEV8ie9DNqvi1Xjstj1ev+PFznbDuqOx4oaGGcE8884JXtFCy8SWYeCDnQrAf
         1DPmnyfbyC+q/AQe2tGmrrTfY4yF9TpbTqD5oWdgooprGvC3kRctodUu34xlzslSFjgZ
         AHlRj2xCQ3Z2yahY8o+UBJ7aM/4sgDOizhNYfhgIaH9HiZ6bsZSAEkq2gPT4oX4x5C+Y
         1LT/HLx9XfCX6OErqFFwBJdo3zc9sI25cWSH8TxcJZmnALZBEW7MwFUhz7dkzjgbK1gc
         cK5A==
X-Gm-Message-State: AGRZ1gJUvAldVej7JPo51A3rNZGm6lZbnOPZXQgtP6AGW1/2S2B6G0K6
        WBd20QXUe6/y4ytdr8g1nRfSCA6i
X-Google-Smtp-Source: AJdET5dNSOzqN2CSzIYpbqaamjM8+paciy56z7dL3WD7kohnCPl7ouSDeHTEjCVBThRHYXec+uvd/A==
X-Received: by 2002:a63:9304:: with SMTP id b4-v6mr45712pge.36.1540924805639;
        Tue, 30 Oct 2018 11:40:05 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id k13-v6sm25430234pff.30.2018.10.30.11.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:40:04 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:40:04 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 18:39:57 GMT
Message-Id: <f4050b432d509e6696e630a174dfdfef4e4a66dd.1540924800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.62.git.gitgitgadget@gmail.com>
References: <pull.62.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/4] Allow for platform-specific core.* config settings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the Git for Windows project, we have ample precendent for config
settings that apply to Windows, and to Windows only.

Let's formalize this concept by introducing a platform_core_config()
function that can be #define'd in a platform-specific manner.

This will allow us to contain platform-specific code better, as the
corresponding variables no longer need to be exported so that they can
be defined in environment.c and be set in config.c

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c    | 5 +++++
 compat/mingw.h    | 3 +++
 config.c          | 6 +++---
 git-compat-util.h | 8 ++++++++
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 81ef24286..293f286af 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -203,6 +203,11 @@ static int ask_yes_no_if_possible(const char *format, ...)
 	}
 }
 
+int mingw_core_config(const char *var, const char *value, void *cb)
+{
+	return 0;
+}
+
 /* Normalizes NT paths as returned by some low-level APIs. */
 static wchar_t *normalize_ntpath(wchar_t *wbuf)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index f31dcff2b..e9d2b9cdd 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -11,6 +11,9 @@ typedef _sigset_t sigset_t;
 #undef _POSIX_THREAD_SAFE_FUNCTIONS
 #endif
 
+extern int mingw_core_config(const char *var, const char *value, void *cb);
+#define platform_core_config mingw_core_config
+
 /*
  * things that are not available in header files
  */
diff --git a/config.c b/config.c
index 3687c6783..646b6cca9 100644
--- a/config.c
+++ b/config.c
@@ -1093,7 +1093,7 @@ int git_config_color(char *dest, const char *var, const char *value)
 	return 0;
 }
 
-static int git_default_core_config(const char *var, const char *value)
+static int git_default_core_config(const char *var, const char *value, void *cb)
 {
 	/* This needs a better name */
 	if (!strcmp(var, "core.filemode")) {
@@ -1363,7 +1363,7 @@ static int git_default_core_config(const char *var, const char *value)
 	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
-	return 0;
+	return platform_core_config(var, value, cb);
 }
 
 static int git_default_i18n_config(const char *var, const char *value)
@@ -1451,7 +1451,7 @@ static int git_default_mailmap_config(const char *var, const char *value)
 int git_default_config(const char *var, const char *value, void *cb)
 {
 	if (starts_with(var, "core."))
-		return git_default_core_config(var, value);
+		return git_default_core_config(var, value, cb);
 
 	if (starts_with(var, "user."))
 		return git_ident_config(var, value, cb);
diff --git a/git-compat-util.h b/git-compat-util.h
index 96a3f86d8..3a08d9916 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -342,6 +342,14 @@ typedef uintmax_t timestamp_t;
 #define _PATH_DEFPATH "/usr/local/bin:/usr/bin:/bin"
 #endif
 
+#ifndef platform_core_config
+static inline int noop_core_config(const char *var, const char *value, void *cb)
+{
+	return 0;
+}
+#define platform_core_config noop_core_config
+#endif
+
 #ifndef has_dos_drive_prefix
 static inline int git_has_dos_drive_prefix(const char *path)
 {
-- 
gitgitgadget

