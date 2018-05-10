Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64D0C1F406
	for <e@80x24.org>; Thu, 10 May 2018 14:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965611AbeEJOTs (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:19:48 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46867 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965584AbeEJOTn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:19:43 -0400
Received: by mail-lf0-f68.google.com with SMTP id x7-v6so3199251lff.13
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCkBWoizZPyI+/b64HNFvLbzsVbmormsSBsef1wE75k=;
        b=SFxMI0xu+8s1Bnrb27PHyyXcBk4aCJ+SeWMX69ilu6E3kSlomDC15Y0B2YYwh/9G6F
         IpsK3iapkf25Grfj/UkLiamjIVvjLf3SLvQYzv+IB4Lh5w62xEMZpQ8D3FuOjGfQpGus
         bH445GNxrSCQk5C6TRbCvHLbIAD3asReHOOAwdNnb03WQD9nK/MLaZg3U3KyYw1hgAY7
         JLydv/M97EW2K2GqIaN4mO10eysq2sVfy4sQ95XaumW1p5ATR0loO25hFUK+L5nAsguQ
         i24zxUDr26USzR3pUXAl5YaydTaJYyUDTzLaW1LSbXl0g2kePv6AAiqxrXW040q0RYVv
         19MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCkBWoizZPyI+/b64HNFvLbzsVbmormsSBsef1wE75k=;
        b=LmLghf8ooQ9rI5RbElSeq/ATHC66GgblQ/TmesNXALS3te9eE/Xen9mlPSGRbNxJIB
         JpXuJ52zvPcqyzBlr4Ead2wDCyXZa3SRVyT4aMhW7ryzd6bAHRa0wVc9+14b1/v3UfYc
         H6pW2r60AzdVFspx20w2c11MpxofHRXVSwCyoE4e/ut2WJK2/fr1eXpwrCRHTtEDaIiI
         j8jeubnQxRFk6+3RKW8s0c/JO+5sN7HAUX5raHPjEm2YlSHwil34BlnaVMmIfB6RDPSf
         mtI/MNx8GDTyYiAjJ8uHLnw7MNz+zWDYhOHOJcizErwIDY2B61Ah2EKUnbiuyFSiXasJ
         60vw==
X-Gm-Message-State: ALKqPwc2ZJ/4q6D3SSw3DJW5Bw22pfF2YYgRW+3DdmlignXw3jHRJoTG
        NpHUwhpZa/B/D+6QkqOLKzUbrw==
X-Google-Smtp-Source: AB8JxZr12jfWSstfqTQ576oFpPBzJ2OXJourN7xXe9Lm12knS8TGOZ7nkzexgPcfN+lwl5zdi3WUUA==
X-Received: by 2002:a19:c350:: with SMTP id t77-v6mr1092800lff.127.1525961982012;
        Thu, 10 May 2018 07:19:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g2-v6sm194296ljj.82.2018.05.10.07.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 07:19:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 9/9] log-tree: allow to customize 'grafted' color
Date:   Thu, 10 May 2018 16:19:27 +0200
Message-Id: <20180510141927.23590-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510141927.23590-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 76f5df305b (log: decorate grafted commits with "grafted" -
2011-08-18) lets us decorate grafted commits but I forgot about the
color.decorate.* config.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt | 3 ++-
 log-tree.c               | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 91f7eaed7b..c63d66906d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1138,7 +1138,8 @@ color.diff.<slot>::
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
 	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
-	branches, remote-tracking branches, tags, stash and HEAD, respectively.
+	branches, remote-tracking branches, tags, stash and HEAD, respectively
+	and `grafted` for grafted commits.
 
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
diff --git a/log-tree.c b/log-tree.c
index 19cfebd231..414dbce0dd 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -34,6 +34,7 @@ static const char *color_decorate_slots[] = {
 	[DECORATION_REF_TAG]	= "tag",
 	[DECORATION_REF_STASH]	= "stash",
 	[DECORATION_REF_HEAD]	= "HEAD",
+	[DECORATION_GRAFTED]	= "grafted",
 };
 
 static const char *decorate_get_color(int decorate_use_color, enum decoration_type ix)
-- 
2.17.0.705.g3525833791

