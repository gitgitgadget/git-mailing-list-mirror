Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06AD81F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 16:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeKSDI5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 22:08:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38699 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeKSDI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 22:08:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so11362750lja.5
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 08:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ks766BWdySH5BvoifD1L397HQ0JeQ64hBWQD8OSJfxg=;
        b=sMwDljqkn+ASDZT74lweV9Wb7iL0VZEpU5tQBCE4+idjuv+6uJ4+M2V+QtpTg7NRw9
         MJTxzbyNzIZ+3xxBesmBW2glEFU8OzexEyEiJ0qsWSF8QN+Q+bBXrIuEdrA8zqM1pVTT
         YcQhJgrf4tpwdi7BDBRSzU17JOPP6Rs6+q6ki/W8wy8gINTTkAfl0u7PV9UD5yaIMf5Y
         QAgQ5bVCuFUjVZLFhHMMQyb9FXpggn5pOxdjPchBd5aOOqYd6IfuDP9plMCjaxnTZTVh
         dT0Ub7p9838dNEjOO7AMgS1dCyHmCMyR4BiwvGxggc04yExVKhHJD7iV4x79ZA2lNIhq
         SaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ks766BWdySH5BvoifD1L397HQ0JeQ64hBWQD8OSJfxg=;
        b=ZDur/vZRNydvDBBf7Z6JWsmiSxIob/3aafkITE5uECzM41BH+VgBLvxMkzKroSejxp
         L0gk4I3qd8Cs/jOUQ+7bfSs+PBsh9otXMPcSsW08W82eoOYb50F1d8rtYPtDHJKjQH0O
         SuSpLtukg6YoZtW+i2UmCw5MyUic6N1OBub3I/HkVtUvDrJxsyaR4E/PZjjOf12vHzTQ
         3FCMkEZDgl/KsrLUSITPUvDOEDlKx4NfWyGZDN6AAmXGxWOtca1DSkKvf4O6pmHRg9Xl
         AHMZddoX+WTrXxvAQ88XaA2/Xnl87mu1xRpM3ri88KzR3t4LRXfMZNNGGF8jVllp2pAP
         XtaQ==
X-Gm-Message-State: AGRZ1gKOTqHxdNPNOlS/ErZ8fvcDyK/Gh0jObA/WGCli61ZbWM5X7fxT
        tIcxeA2Qh7+mjW0J2vyX5c1mAoDD
X-Google-Smtp-Source: AJdET5fmkOBYfp7uMik2G3e0DJq1Kz2d6Ay/EV1Y0QsMM5I8P2E7oYErE04n+UBMK3uv9pzdkDRBcw==
X-Received: by 2002:a2e:99d7:: with SMTP id l23-v6mr9408214ljj.165.1542559690167;
        Sun, 18 Nov 2018 08:48:10 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f29sm4461603lfa.46.2018.11.18.08.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 08:48:09 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/5] pathspec.h: clean up "extern" in function declarations
Date:   Sun, 18 Nov 2018 17:47:58 +0100
Message-Id: <20181118164800.32759-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181118164800.32759-1-pclouds@gmail.com>
References: <20181118164800.32759-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"extern" on functions is not required and the trend has been removing
it from header files.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pathspec.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/pathspec.h b/pathspec.h
index a6525a6551..5fd781d695 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -80,13 +80,13 @@ struct pathspec {
  * Any arguments used are copied. It is safe for the caller to modify
  * or free 'prefix' and 'args' after calling this function.
  */
-extern void parse_pathspec(struct pathspec *pathspec,
-			   unsigned magic_mask,
-			   unsigned flags,
-			   const char *prefix,
-			   const char **args);
-extern void copy_pathspec(struct pathspec *dst, const struct pathspec *src);
-extern void clear_pathspec(struct pathspec *);
+void parse_pathspec(struct pathspec *pathspec,
+		    unsigned magic_mask,
+		    unsigned flags,
+		    const char *prefix,
+		    const char **args);
+void copy_pathspec(struct pathspec *dst, const struct pathspec *src);
+void clear_pathspec(struct pathspec *);
 
 static inline int ps_strncmp(const struct pathspec_item *item,
 			     const char *s1, const char *s2, size_t n)
@@ -106,10 +106,10 @@ static inline int ps_strcmp(const struct pathspec_item *item,
 		return strcmp(s1, s2);
 }
 
-extern void add_pathspec_matches_against_index(const struct pathspec *pathspec,
-					       const struct index_state *istate,
-					       char *seen);
-extern char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
-						   const struct index_state *istate);
+void add_pathspec_matches_against_index(const struct pathspec *pathspec,
+					const struct index_state *istate,
+					char *seen);
+char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
+					    const struct index_state *istate);
 
 #endif /* PATHSPEC_H */
-- 
2.19.1.1327.g328c130451.dirty

