Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8406D1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeF3JUp (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:20:45 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:46875 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeF3JUn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:20:43 -0400
Received: by mail-lj1-f180.google.com with SMTP id u6-v6so9066141lju.13
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G9DKFZs3DN5DgM2IGjo5Cg8tmwta/4YRSUPMcf9wyWo=;
        b=u9VwC7PnbQ7PBCA+Avx2hUYYA7HqP17PkggFUp7Wp9I7a9TTQkg1m3IA5mTNQzOAwU
         xvBRu/SVSU1chgiYMsRgXdCPjrRHl1jteDraOg0P3ZUPj9Jv7OGop8SiBuY61RlA/axL
         rKonpYj/doXrl9B6IojsylOvtgnbTI9KSCbNZ8qfitC+39RMN1MbsDrFyVk1+gJw2Ofm
         +0WCzBr8iJjbySwA53fSYDhhA5dUvASG2oI0DyvBc2Mosz1UI2ozHuI01hrwFTC7qqDb
         0PkH8GxG9bEOc7gqvaRdrwZ2oTUYcesyi/6ckaYQ70IZtKGG72ZYbk/22wfEmWbrjmnV
         SqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G9DKFZs3DN5DgM2IGjo5Cg8tmwta/4YRSUPMcf9wyWo=;
        b=FP7rDo/Sxjyya39G7je85YtfQHZMMEoEmcaoehvVsdkE1Ey3995eLAQgEUQSic01H3
         4rWC0FFoaZknYzUGEs/Y3OG1wCftXClauWNp69RCm+RR77MVQAQg+hxWP0grLZVe4Kah
         bl9slbKKYZa16soVdQJSOPzBaabkEp2XKspP2h53Dk3bi6okHINMGHYDU8na+26BizU8
         pjyiOEPxnC2mU0Gm31/pZNtDlGB3Ht27TjRiKBPCBRc8/yLalkopShMppM524Am+a1UL
         8rd7ToUg1LeBr3bBzrUFVN/K6ZDOXXzIyZbTG41B7aO5tifDLjDjgZtaADzzOVlgm+Pn
         k+RA==
X-Gm-Message-State: APt69E0cgmic/WtgVDcA10UE1jxK9agiO2FHOsUF780m91GZ8FYcmZbp
        asRb489hcUP8NJ1c8pyaDHQkjA==
X-Google-Smtp-Source: AAOMgpd3cxv2aEHGom1/Rrg4CjUm+IF9QQOfQLsS/JStP1aHafH4Xvc31fKErjZ1vRYpRBlVhSi7dw==
X-Received: by 2002:a2e:52c3:: with SMTP id n64-v6mr4002612lje.90.1530350441527;
        Sat, 30 Jun 2018 02:20:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c20-v6sm1854650lji.82.2018.06.30.02.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:20:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/12] attr.h: drop extern from function declaration
Date:   Sat, 30 Jun 2018 11:20:21 +0200
Message-Id: <20180630092031.29910-3-pclouds@gmail.com>
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
 attr.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/attr.h b/attr.h
index 442d464db6..46340010bb 100644
--- a/attr.h
+++ b/attr.h
@@ -42,31 +42,31 @@ struct attr_check {
 	struct attr_stack *stack;
 };
 
-extern struct attr_check *attr_check_alloc(void);
-extern struct attr_check *attr_check_initl(const char *, ...);
-extern struct attr_check *attr_check_dup(const struct attr_check *check);
+struct attr_check *attr_check_alloc(void);
+struct attr_check *attr_check_initl(const char *, ...);
+struct attr_check *attr_check_dup(const struct attr_check *check);
 
-extern struct attr_check_item *attr_check_append(struct attr_check *check,
-						 const struct git_attr *attr);
+struct attr_check_item *attr_check_append(struct attr_check *check,
+					  const struct git_attr *attr);
 
-extern void attr_check_reset(struct attr_check *check);
-extern void attr_check_clear(struct attr_check *check);
-extern void attr_check_free(struct attr_check *check);
+void attr_check_reset(struct attr_check *check);
+void attr_check_clear(struct attr_check *check);
+void attr_check_free(struct attr_check *check);
 
 /*
  * Return the name of the attribute represented by the argument.  The
  * return value is a pointer to a null-delimited string that is part
  * of the internal data structure; it should not be modified or freed.
  */
-extern const char *git_attr_name(const struct git_attr *);
+const char *git_attr_name(const struct git_attr *);
 
-extern int git_check_attr(const char *path, struct attr_check *check);
+int git_check_attr(const char *path, struct attr_check *check);
 
 /*
  * Retrieve all attributes that apply to the specified path.
  * check holds the attributes and their values.
  */
-extern void git_all_attrs(const char *path, struct attr_check *check);
+void git_all_attrs(const char *path, struct attr_check *check);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
@@ -76,6 +76,6 @@ enum git_attr_direction {
 void git_attr_set_direction(enum git_attr_direction new_direction,
 			    struct index_state *istate);
 
-extern void attr_start(void);
+void attr_start(void);
 
 #endif /* ATTR_H */
-- 
2.18.0.rc2.476.g39500d3211

