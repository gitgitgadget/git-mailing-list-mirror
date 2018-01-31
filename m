Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033D81F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753482AbeAaLGa (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:06:30 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38483 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeAaLG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:06:28 -0500
Received: by mail-pf0-f194.google.com with SMTP id k19so12231325pfj.5
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gEEWG3foHc8lbX01kLgAi7mAy9PmUjLLZR1C6L/XpSU=;
        b=pPyxoh64vbN5sQ6sGCuLCyK82khe3vuK0oGjwXM0KbTNBx0k2Ayjzh1ecxrrGaHiMc
         rBxUvNYtcCL5tRtI8VkmO7dp8bXJRU04TgLdih6tzheHBkJE5uW6cxdHmgr3SK2yM9/V
         W+EjoKbBsHk7VGrBddOfMXoojS3RnHxTKH8kRpH6uerU55Bep0pLrFJ5g1p1AyKE194h
         MS99f1OWhp7SzgboCdCCf5MzABolRNf4BF45VeKJYCnAnOzZtIjPXs0i6PDESh4S3u6c
         x3/Eb3C+ROzdBPWHTQPJz9SFqFNxZfWS9HPe1XUgO6bEkNXdlXkGEJ8sgEjda/Z4GMOO
         DmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gEEWG3foHc8lbX01kLgAi7mAy9PmUjLLZR1C6L/XpSU=;
        b=szaPHvUcJbEWb0KC2xO5dBJTRo3gLY5UsO1VxtBB6yv24H61saae1TIvRo4p1qJ5E0
         n0MQ1UoVsD7O6Leo0jFKFijt32xYWESXKUbHnkS4dF5dwm6Sy25mK70zfxcUwjK99OS5
         UytrHjEDBWXhC/oYQhhxgqLlECQuz4CaLCTsZnkS4NE+QbkOVBlgO9LGXHrW4RM2Q+0V
         SWNCQKiHTWFO/zdCEwfLSrO72CHP+H11I+9YNW3ZfWbrXA2kBLZnkezxtcrB9otNPFEA
         qpxaWsBpkEkr0XvRbZN4P6AELKqZ3O1bG4zz0wzKf/URYHrHBcz6bTNftE8Kc5xSCldt
         Lkaw==
X-Gm-Message-State: AKwxytfzZbQZcrUZqb8WWfaZBmG5+F1D9/+SYaoq22/c96gQDGRWkOr/
        hUk9+Tj2ZMcmpRNq+aoR0P4JBQ==
X-Google-Smtp-Source: AH8x227RX/r4xVoWr08pKfKcbmSu7eJmYiNjc8gIgNwO9yfQhToQLPXTrtG5TLQlhQTGVhn8IzlzsQ==
X-Received: by 2002:a17:902:5388:: with SMTP id c8-v6mr27099739pli.91.1517396788241;
        Wed, 31 Jan 2018 03:06:28 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id f12sm25437511pga.67.2018.01.31.03.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:06:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:06:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 06/41] completion: use __gitcomp_builtin in _git_am
Date:   Wed, 31 Jan 2018 18:05:12 +0700
Message-Id: <20180131110547.20577-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are:

--directory
--exclude
--gpg-sign
--include
--keep-cr
--keep-non-patch
--message-id
--no-keep-cr
--patch-format
--quiet
--reject
--resolvemsg=

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/am.c                           | 16 ++++++++--------
 contrib/completion/git-completion.bash |  7 +------
 parse-options.h                        |  4 ++--
 rerere.h                               |  3 ++-
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index acfe9d3c8c..d42832dc0b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2237,18 +2237,18 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG),
 		OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
 			N_("override error message when patch failure occurs")),
-		OPT_CMDMODE(0, "continue", &resume,
+		OPT_CMDMODE_F(0, "continue", &resume,
 			N_("continue applying patches after resolving a conflict"),
-			RESUME_RESOLVED),
-		OPT_CMDMODE('r', "resolved", &resume,
+			RESUME_RESOLVED, PARSE_OPT_NOCOMPLETE),
+		OPT_CMDMODE_F('r', "resolved", &resume,
 			N_("synonyms for --continue"),
-			RESUME_RESOLVED),
-		OPT_CMDMODE(0, "skip", &resume,
+			RESUME_RESOLVED, PARSE_OPT_NOCOMPLETE),
+		OPT_CMDMODE_F(0, "skip", &resume,
 			N_("skip the current patch"),
-			RESUME_SKIP),
-		OPT_CMDMODE(0, "abort", &resume,
+			RESUME_SKIP, PARSE_OPT_NOCOMPLETE),
+		OPT_CMDMODE_F(0, "abort", &resume,
 			N_("restore the original branch and abort the patching operation."),
-			RESUME_ABORT),
+			RESUME_ABORT, PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "committer-date-is-author-date",
 			&state.committer_date_is_author_date,
 			N_("lie about committer date")),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9aa3aa241b..ce53b78c81 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1110,12 +1110,7 @@ _git_am ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--3way --committer-date-is-author-date --ignore-date
-			--ignore-whitespace --ignore-space-change
-			--interactive --keep --no-utf8 --signoff --utf8
-			--whitespace= --scissors
-			"
+		__gitcomp_builtin am "--no-utf8"
 		return
 	esac
 }
diff --git a/parse-options.h b/parse-options.h
index 23c912b842..fa75df17b4 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -146,8 +146,8 @@ struct option {
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
 				      (h), 0, &parse_opt_string_list }
-#define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
+#define OPT_UYN(s, l, v, h, f)      { OPTION_CALLBACK, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_NOARG|(f), &parse_opt_tertiary }
 #define OPT_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("time"),(h), 0,	\
 	  parse_opt_approxidate_cb }
diff --git a/rerere.h b/rerere.h
index c2961feaaa..5e5a312e4c 100644
--- a/rerere.h
+++ b/rerere.h
@@ -37,6 +37,7 @@ extern void rerere_clear(struct string_list *);
 extern void rerere_gc(struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
-	N_("update the index with reused conflict resolution if possible"))
+	N_("update the index with reused conflict resolution if possible"), \
+	PARSE_OPT_NOCOMPLETE)
 
 #endif
-- 
2.16.1.205.g271f633410

