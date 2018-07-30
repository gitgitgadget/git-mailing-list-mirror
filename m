Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E351F597
	for <e@80x24.org>; Mon, 30 Jul 2018 12:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeG3Nwv (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 09:52:51 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:49751 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeG3Nwv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 09:52:51 -0400
Received: by mail-oi0-f74.google.com with SMTP id u74-v6so10708194oie.16
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 05:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ewtBdLlFstyXu2rzv/9mOhAvT2zhsnePDQJRGRvSnD0=;
        b=nXEuM4SzS3hhGoSQB/fm5ZHNlc2pR/fZkdIyZheulErQ3ad9jGo5ICpbmvxP4DO+8U
         mobsp65khnbL4ICWAHt3AhA+XxkxWl+GZSMBjQwXVRoajrxSpUFIJwiuuiczSpdoBN+y
         E7M418B3OZH+Y0grU+leA+p9djgDx4ej4spKWYSZjZsQNzZKmG72Zy7AFSU1nn3kN/83
         eULX6KYjkdlNcMqsuQNydgYP+6tN/iQRSd+fRW33B/mk/H/6qVzt9L0vGDf/CibKy+3f
         GRKEMnz1nhl0nRloHx2KJHneX3haZNfL+7Bhgzr2yUuUNwMN4+dTxtxH5ZBNpARRUZBS
         KPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ewtBdLlFstyXu2rzv/9mOhAvT2zhsnePDQJRGRvSnD0=;
        b=FIQdSmp0+JP9BcF8za0NMj6zUMQBoI2M1OKq1HdS6HDj5oErwHBb3Twxa66g47XZAc
         Gf0lp70rR0geRFarwHf/tsAAAHkg4yqtYak5kUIuDANaDG8VxXg95hkiRHlN5MiT9XKe
         7ppNcKSHdbEYQTV5lLmqJZy8/IzgxYDWTGDgze5UCzrnBNXKFJzqCRYZC78tmb1VlPWF
         mYvK7jKcBDxsxWGj4iZ8sFnVdWVV6DdJbFhLWZDrXTOuUSTT1TEawtK9QF96Y80QMGrX
         Ug0GTL8VCX31EQ8Q8WXwHC2olOY86CVHvyiFwm3d7GOYMLJoFqNkKRltxXhAN5tcb4OB
         STQQ==
X-Gm-Message-State: AOUpUlHQhDZ1+61d2eD4Uo53pHAXeUFFxyDmSPnW4Rh5NOguzY8nIAuV
        njdR4uRnvNHJVe/CYBLdR/dZQeHmexs4ENwaXd0I2bZJuN6V8Pys88KH7WoOlU4iLtxWuAy40rH
        lA6lR6w+XyNJ2Oy1/agKIUl5ILqDGhzkTEcCISV4ociu2kGIrcw+ftxuSYg==
X-Google-Smtp-Source: AAOMgpd73UjqCf8TnyVG0K0g6vMS9YrHcWHwXZen30yVsvilX0sK7JPKdJ4YHJbRQnUDDvaAoPhGrSCb+Xw=
X-Received: by 2002:aca:570c:: with SMTP id l12-v6mr11469154oib.106.1532953087966;
 Mon, 30 Jul 2018 05:18:07 -0700 (PDT)
Date:   Mon, 30 Jul 2018 14:18:00 +0200
Message-Id: <20180730121801.53727-1-hanwen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 1/2] Document git config getter return value.
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 config.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/config.h b/config.h
index b95bb7649..d39256eb1 100644
--- a/config.h
+++ b/config.h
@@ -178,11 +178,16 @@ struct config_set {
 };

 extern void git_configset_init(struct config_set *cs);
-extern int git_configset_add_file(struct config_set *cs, const char *filename);
-extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
+
 extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
 extern void git_configset_clear(struct config_set *cs);
+
+/*
+ * The int return values in these functions is 1 if not found, 0 if found, leaving
+ * the found value in the 'dest' pointer.
+ */
+extern int git_configset_add_file(struct config_set *cs, const char *filename);
+extern int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
 extern int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
 extern int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
 extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
--
2.18.0.345.g5c9ce644c3-goog
