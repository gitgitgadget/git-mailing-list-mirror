Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6843C1F454
	for <e@80x24.org>; Mon, 22 Oct 2018 20:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeJWEnh (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 00:43:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36474 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJWEnh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 00:43:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id x2-v6so4323067eds.3
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+IdKjyf31efNmGF2qSdKh34ykgC2kG6Vu4Viul2FQQA=;
        b=VLC79HvWStHP2VttfrtXuyTfAIgLGwHkxBhAoyE49C11hPNd9ftvPmI4PyoIytRpzU
         s3nkPEXc8K1AdyHxvD6yDJA60IuIjxHVCtE3dwnnn0DZkwloi7GQaLnm247KAiq35uqk
         DFsg6NZRGgV+UZFTqyxbRw1BmXbNKMYEW2D7sLgUWtCZkZkMQkE1ZvrzthPXuwXMeSZc
         71jJMCGjV+4KdTArnjH3asZhty2IJG2pvQ7WQnAjD2Zz+kVnnR27+NL0mpHuxMmWT4N0
         mQrYodwyqTGcS6aatY61m3MARtQk3rMecztqfEOGYSZDtxuYWdMzf5JiHhKUgGsf3Zka
         yJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+IdKjyf31efNmGF2qSdKh34ykgC2kG6Vu4Viul2FQQA=;
        b=AzIxPNOvzyaLNJseoNRegBp2FyUiZKxYH0CxZfwa7uFw5kGNs/rk+5TBb6BImWasGl
         qialCBIHmSe12tx1jtcixYzcbSf7oStf4+QcYyToBHfRdJoNGId0FKXvh6y76zOlYxz7
         Su3d5kUogUY76GiuYDoO7UfO+PFYmrJmxLLgKt9RahqRCJWgxhwDJG2gcwtBLFO/Yh6r
         uT4WT4OHwZbbShgcern9MMDTanZym7sfFHxo8Gg9nFLl74qHMv8CbzjN31BT15IK0OFh
         zTO5zCH4tdByeE6vIx2KNs4rXroXCuTHlpBlR5pcXoGPiikiI4op1dDMW8vx+R4F8Js1
         VHhw==
X-Gm-Message-State: ABuFfogp1ob+B0kWonBSru6oF1mfEz6pMVI2ha03qGmZ4aKSTzJvFyvA
        DF2zKKB2zpTnEx6Kr2DYPiF4FYoH
X-Google-Smtp-Source: ACcGV61++Z1ZY9yRHUWpsBavyPMmtdIhmWyxRqzZsLc88+ef2zSwZM/oVtpTrgRHRquYf+q6WlDKkg==
X-Received: by 2002:a50:e38d:: with SMTP id b13-v6mr14257183edm.263.1540239815639;
        Mon, 22 Oct 2018 13:23:35 -0700 (PDT)
Received: from localhost.localdomain (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id h21-v6sm16882228eda.23.2018.10.22.13.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 13:23:34 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 6/8] gettext: use an enum for the mode of GETTEXT POISONing
Date:   Mon, 22 Oct 2018 22:22:39 +0200
Message-Id: <20181022202241.18629-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.681.g6bd79da3f5
In-Reply-To: <20181022202241.18629-1-szeder.dev@gmail.com>
References: <20181022153633.31757-1-pclouds@gmail.com>
 <20181022202241.18629-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The next patch will add a different mode of GETTEXT POISON-ing,
therefore named constants will be better than magic numbers.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 gettext.c | 12 ++++++------
 gettext.h | 12 +++++++++---
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/gettext.c b/gettext.c
index a9509a5df3..c50d1e0377 100644
--- a/gettext.c
+++ b/gettext.c
@@ -47,17 +47,17 @@ const char *get_preferred_languages(void)
 }
 
 #ifdef GETTEXT_POISON
-int use_gettext_poison(void)
+enum poison_mode use_gettext_poison(void)
 {
-	static int poison_requested = -1;
-	if (poison_requested == -1) {
+	static enum poison_mode poison_mode = poison_mode_uninitialized;
+	if (poison_mode == poison_mode_uninitialized) {
 		const char *v = getenv("GIT_GETTEXT_POISON");
 		if (v && *v)
-			poison_requested = 1;
+			poison_mode = poison_mode_default;
 		else
-			poison_requested = 0;
+			poison_mode = poison_mode_none;
 	}
-	return poison_requested;
+	return poison_mode;
 }
 #endif
 
diff --git a/gettext.h b/gettext.h
index 8e279622f6..fcb6bfaa2c 100644
--- a/gettext.h
+++ b/gettext.h
@@ -42,7 +42,13 @@ static inline int gettext_width(const char *s)
 #endif
 
 #ifdef GETTEXT_POISON
-extern int use_gettext_poison(void);
+enum poison_mode {
+	poison_mode_uninitialized = -1,
+	poison_mode_none = 0,
+	poison_mode_default
+};
+
+extern enum poison_mode use_gettext_poison(void);
 
 #define GETTEXT_POISON_MAGIC "# GETTEXT POISON #"
 #endif
@@ -52,7 +58,7 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 	if (!*msgid)
 		return "";
 #ifdef GETTEXT_POISON
-	if (use_gettext_poison())
+	if (use_gettext_poison() == poison_mode_default)
 		return GETTEXT_POISON_MAGIC;
 #endif
 	return gettext(msgid);
@@ -62,7 +68,7 @@ static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
 const char *Q_(const char *msgid, const char *plu, unsigned long n)
 {
 #ifdef GETTEXT_POISON
-	if (use_gettext_poison())
+	if (use_gettext_poison() == poison_mode_default)
 		return GETTEXT_POISON_MAGIC;
 #endif
 	return ngettext(msgid, plu, n);
-- 
2.19.1.681.g6bd79da3f5

