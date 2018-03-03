Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 269411F576
	for <e@80x24.org>; Sat,  3 Mar 2018 09:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeCCJX1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 04:23:27 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43035 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeCCJX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 04:23:26 -0500
Received: by mail-pg0-f65.google.com with SMTP id e9so4768773pgs.10
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 01:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+UmFVLv7UY/B1KtX2259qUUt++GKrcZPXcgt8PMS4DE=;
        b=e4wEn7yLnf2UJx/gxq4Qn3tHqgGxu+hyoFs7Ak4xIxyWde8eupBu9PiRn4jhyx4aHL
         Gdgz2OACnluo3oHvPb9CuozbHil03DmYGjj2kfNi8smaLeBGvUjFchQdeIoXy39gg2by
         lgDN/H2silBqB4fvjQ4P1jYS4jVEZ99J5uGDTA9fyKt2C6ZsI3msF6i0Ruy3f0wo1NBa
         CqyRM8Nj+unsSLHMLl5qT1CAd3QbnFixJTsl6MT34y2mtGLwBPa4Cf9DXPC9pdloA5WE
         +FdMfBnsQsCfBmg4vd4U6x2K6YdIQhN5PYlpkOHOOUvGNFFFJVjT6sD53F4Qq/dt5Sla
         2JpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+UmFVLv7UY/B1KtX2259qUUt++GKrcZPXcgt8PMS4DE=;
        b=YsjJW0QbShAhOnCJW0Ufcg6ohb3COeUgIgGgxmQMn87ofkabECzGrG48IVYvSlrTkE
         t9Nro/OYp/n/vglsMILSIaGJrtJbTkICIYX2n6UmZfHf/+M2YBGz8lLziwDbo7RuG4Lm
         402sC0X0WK+f6+q7KkOlvGNG+vKVVZTG+EY3T8izxmfw11te7tstxY4kdaeeCcIHDHkW
         IBcn8bKfB9IJEPgecUNdFBH9EASPi9T96Y1N9YFvST85gNbIsrGfP0Drlv4ep/oZ2CdV
         cSL/FryaMQ60cdg7CDfp5J88t+LT97UK3NLh4iu/ShtkGasEkMBZocgMfoLB+J/JMXn7
         yzqQ==
X-Gm-Message-State: APf1xPAse5ZExUn51Lp6rZZJFIaLFmSU5zgq9EUFFNFNpRnkugeN34g7
        G2orMGl+VC+8vZX8hZP6Plw3RA==
X-Google-Smtp-Source: AG47ELv6VMFE7XGqedqogla6GlyABjMkoGud9rkahBMD0Th72ph90Q4+NHpVs3jsLZSdH/wrXSIPuQ==
X-Received: by 10.98.17.86 with SMTP id z83mr8461992pfi.207.1520069005577;
        Sat, 03 Mar 2018 01:23:25 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 184sm15121498pfd.156.2018.03.03.01.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 01:23:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 16:23:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] completion: don't set PARSE_OPT_NOCOMPLETE on --rerere-autoupdate
Date:   Sat,  3 Mar 2018 16:23:06 +0700
Message-Id: <20180303092307.3796-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303092307.3796-1-pclouds@gmail.com>
References: <20180303092307.3796-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is not a strong reason to hide this option, and git-merge already
completes this one. Let's allow to complete this for all commands (and
let git-completion.bash do the suppressing if neede).

This makes --rerere-autoupdate completable for am, cherry-pick and
revert.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 parse-options.h                        | 4 ++--
 rerere.h                               | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0ddf40063b..c310b241d3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1754,8 +1754,7 @@ _git_merge ()
 
 	case "$cur" in
 	--*)
-		__gitcomp_builtin merge "--rerere-autoupdate
-				--no-rerere-autoupdate
+		__gitcomp_builtin merge "--no-rerere-autoupdate
 				--no-commit --no-edit --no-ff
 				--no-log --no-progress
 				--no-squash --no-stat
diff --git a/parse-options.h b/parse-options.h
index 0ba08691e6..ab1cc362bf 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -148,8 +148,8 @@ struct option {
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
 				      (h), 0, &parse_opt_string_list }
-#define OPT_UYN(s, l, v, h, f)      { OPTION_CALLBACK, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG|(f), &parse_opt_tertiary }
+#define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
 #define OPT_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("time"),(h), 0,	\
 	  parse_opt_approxidate_cb }
diff --git a/rerere.h b/rerere.h
index 5e5a312e4c..c2961feaaa 100644
--- a/rerere.h
+++ b/rerere.h
@@ -37,7 +37,6 @@ extern void rerere_clear(struct string_list *);
 extern void rerere_gc(struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
-	N_("update the index with reused conflict resolution if possible"), \
-	PARSE_OPT_NOCOMPLETE)
+	N_("update the index with reused conflict resolution if possible"))
 
 #endif
-- 
2.16.1.435.g8f24da2e1a

