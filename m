Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4551F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933733AbeF3JUr (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:20:47 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:45135 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbeF3JUl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:20:41 -0400
Received: by mail-lj1-f175.google.com with SMTP id g3-v6so9078203ljk.12
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dUHCZ2CcTmVEmmIJ3W8OydW46SKo3W+FGW729AZwSBc=;
        b=JS0ARgot9wDyB9vvtRPoRu22CXDIJ+5ZA63PfGCQhtyUhL+TPp3vjpQRLTBapnnNwE
         mObHykER0tWHpzA5l1tC8aXxUa530xsehf/dgXWGJ9sFt+YEOTPDceQLBorKykGy7wOO
         17ra9x7VlXCFetY4j6Z7T35op34EbMBn8qbf6jkMUWbIiaSrcU2qIaHBiIW0AxPtAZn1
         LY7HmYjhpBDupMFlf3j501rHWGuKyeAKdpPYgdtxvzvPGxe0URYxZD4qyOC6Uhec1RKp
         kuZqYip+M6OXSgght1pM3W5jT64bpvWmOuej5vSFHUTVq7RgXgDIxv+cRQ2udgEcPzzp
         dAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dUHCZ2CcTmVEmmIJ3W8OydW46SKo3W+FGW729AZwSBc=;
        b=CX1db5j+Ne2jziIPWvrY3WwmjE2BkwjlWvtI9hNTJGrMUj1M4LJkC/4/Xk4V8W7FvX
         IhIfOkGkGtlnJ1h9r/VwaFvxyyqCKm9aWNpF4IheFPK6RQomoVekndAQMSKlVCQsw0yu
         6vOyBmBACO09O/3+8B6yZCEMCu7/Zt9OWEn1g6NqdZvF5LrtxnXlDd5n+FwLJBxVYzUg
         NDsc5nupG1ZVho3tKrqQ/umMLpIbu7YFC2o8IaQiTKWmAC3Gk/lixlNofhH2N5F5Ytf3
         aZdPQUaRBwEA+UwWXQ4gGlyN3RX8ujS7q5dxRmGSwuf0Sj+ljfucbF8vXBhHUdccyX62
         A3AQ==
X-Gm-Message-State: APt69E3XOZRlNKitfWKacPRLVpFS7TZ6u1HuPxzOYQRYqNdpZHyO6yrl
        euEB7PXS4lnD4EYvEWpRXy/Jzg==
X-Google-Smtp-Source: ADUXVKKgHs4kl7sW02BouK5oQMvsw2bW9Ci4TfJcdcsMSySCK2ebuJ2XnDuQJdn7WYwbSYZl7PjHdg==
X-Received: by 2002:a2e:558e:: with SMTP id g14-v6mr12761501lje.4.1530350440134;
        Sat, 30 Jun 2018 02:20:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c20-v6sm1854650lji.82.2018.06.30.02.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:20:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/12] apply.h: drop extern on func declaration
Date:   Sat, 30 Jun 2018 11:20:20 +0200
Message-Id: <20180630092031.29910-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630092031.29910-1-pclouds@gmail.com>
References: <20180630092031.29910-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.h | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/apply.h b/apply.h
index dc4a019057..025dfed7ab 100644
--- a/apply.h
+++ b/apply.h
@@ -110,14 +110,14 @@ struct apply_state {
 	int applied_after_fixing_ws;
 };
 
-extern int apply_parse_options(int argc, const char **argv,
-			       struct apply_state *state,
-			       int *force_apply, int *options,
-			       const char * const *apply_usage);
-extern int init_apply_state(struct apply_state *state,
-			    const char *prefix);
-extern void clear_apply_state(struct apply_state *state);
-extern int check_apply_state(struct apply_state *state, int force_apply);
+int apply_parse_options(int argc, const char **argv,
+			struct apply_state *state,
+			int *force_apply, int *options,
+			const char * const *apply_usage);
+int init_apply_state(struct apply_state *state,
+		     const char *prefix);
+void clear_apply_state(struct apply_state *state);
+int check_apply_state(struct apply_state *state, int force_apply);
 
 /*
  * Some aspects of the apply behavior are controlled by the following
@@ -126,9 +126,8 @@ extern int check_apply_state(struct apply_state *state, int force_apply);
 #define APPLY_OPT_INACCURATE_EOF	(1<<0) /* accept inaccurate eof */
 #define APPLY_OPT_RECOUNT		(1<<1) /* accept inaccurate line count */
 
-extern int apply_all_patches(struct apply_state *state,
-			     int argc,
-			     const char **argv,
-			     int options);
+int apply_all_patches(struct apply_state *state,
+		      int argc, const char **argv,
+		      int options);
 
 #endif
-- 
2.18.0.rc2.476.g39500d3211

