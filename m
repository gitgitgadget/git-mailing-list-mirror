Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D8971F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934995AbeF3JVJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:21:09 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:44391 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeF3JUu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:20:50 -0400
Received: by mail-lf0-f54.google.com with SMTP id h7-v6so413279lfc.11
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g3d3/7qGmZubFzw1kj8elXFG/Kl0Xc6L8lLoxZ9FgAw=;
        b=gka1XdwC0lP7IXkHnKHK9iBWie0Oc2YF4qB8KI6cBiUYwCGyLqGsUojQFeLI/i0S7M
         qwbH60X1DRBNq5Ah4fZBJYLjefAs4EvJrMXU8UD/TngKwjFD3+iXuzJfQEcM+NzC2upr
         MYDXz8HQtr2pnkLA7OZu+K0XvXR9oBnhFK6n4IxXa4P4A4vdwwm6Nhitf/BfmO+qBB9n
         NdV5hQNADDEAOvLp7rmm2mTS8mAHYOITeCEknJY2ATESepD5pM+11yuN+i27+YOzi530
         tKqsv7AiPthK6azg4cAd48WJyJYkJw6WSQmPERqDbXQANaVK+iPY7YBKtztCSmMNxBYi
         UUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g3d3/7qGmZubFzw1kj8elXFG/Kl0Xc6L8lLoxZ9FgAw=;
        b=WeWuJmsTNaL0onC6O+vHEW3cQwuI1M/YoC1i8KBvsrkfsYNdgJXEs6KdhZ0nS3Ozr0
         s4S0eK1zxu5HksGI65tTUbZ0XD66XelX7mgiGMmNeNds7KSoYhF6hQubQkNaKsRnDx2v
         yH22qXGcpLUCX6Vz9h/reDKAtHNzD6w+sEOOk2AtUqh6v5K3xoe2cmyoGo3dkZWhn8Dp
         8UVIDYQxNLozRjLPxDk5vMzeg8iZFMjxKbyZyDvZdzOAk/BnhpwkftFchM04xzLpAtTI
         +hHw5cUkQ6pSlvFEJJzQ4icHUJSBCUUvMfgdvthOYprtdIQ+29c1Q+V2zBEauoAuJFVc
         ku0g==
X-Gm-Message-State: APt69E3gIJh7xun2RXe2f4rvFM5WS6tA5+aCVS4IYd0G1khBy+LbvFG7
        GdN4M9F4smUz5fqDHK9ZRMaqkw==
X-Google-Smtp-Source: AAOMgpcoYTLJ4n7i+vyLM85hDencOEN5evolcjZyvl32PliGzkl0fBPn0g1c95m6sh5ocIV3qcmAkg==
X-Received: by 2002:a19:f50d:: with SMTP id j13-v6mr11389901lfb.127.1530350448404;
        Sat, 30 Jun 2018 02:20:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c20-v6sm1854650lji.82.2018.06.30.02.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:20:47 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/12] rerere.h: drop extern from function declaration
Date:   Sat, 30 Jun 2018 11:20:28 +0200
Message-Id: <20180630092031.29910-10-pclouds@gmail.com>
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
 rerere.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/rerere.h b/rerere.h
index c2961feaaa..cd948f28f4 100644
--- a/rerere.h
+++ b/rerere.h
@@ -22,19 +22,19 @@ struct rerere_id {
 	int variant;
 };
 
-extern int setup_rerere(struct string_list *, int);
-extern int rerere(int);
+int setup_rerere(struct string_list *, int);
+int rerere(int);
 /*
  * Given the conflict ID and the name of a "file" used for replaying
  * the recorded resolution (e.g. "preimage", "postimage"), return the
  * path to that filesystem entity.  With "file" specified with NULL,
  * return the path to the directory that houses these files.
  */
-extern const char *rerere_path(const struct rerere_id *, const char *file);
-extern int rerere_forget(struct pathspec *);
-extern int rerere_remaining(struct string_list *);
-extern void rerere_clear(struct string_list *);
-extern void rerere_gc(struct string_list *);
+const char *rerere_path(const struct rerere_id *, const char *file);
+int rerere_forget(struct pathspec *);
+int rerere_remaining(struct string_list *);
+void rerere_clear(struct string_list *);
+void rerere_gc(struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
 	N_("update the index with reused conflict resolution if possible"))
-- 
2.18.0.rc2.476.g39500d3211

