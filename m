Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12DE11F42D
	for <e@80x24.org>; Sat, 26 May 2018 13:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754736AbeEZNz6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 09:55:58 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36990 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754669AbeEZNzw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 09:55:52 -0400
Received: by mail-wr0-f193.google.com with SMTP id i12-v6so13553319wrc.4
        for <git@vger.kernel.org>; Sat, 26 May 2018 06:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0pprU2flx/6Xtl//F7eDqcJSQvomkXaA/ukcHZi/JU=;
        b=HU/f6BMmWYTy6uTBgZT5dE6pMTzcdmPZqzpSG2r2o30zg3NsU1Ed/NyV4rUMhXqfSz
         yGjNekgdqJmfVHwr3mpiTyk5rvbdBxDYqdTUHJBZyQQqBK+HhNqmgpcHcpKBbc8+hbf1
         8JeU64s2aq3j+iHmK85WgUq6tyLbJmQqvS+patsSBthT4DJgBz+HJ+HXlVNXEk26ya1m
         yPuRt+4fxaMYuYrb7WDkruoncwHMfsoCC1kfGtETkL6nhm0F6H9qZzd0yb5qJF6Xxeny
         puU0dmzCgJowcvFUbesvYtWmOZLuNMG7xISrxrYIj+cuCNimaQsdmU3liFW2MeHoI++z
         x+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0pprU2flx/6Xtl//F7eDqcJSQvomkXaA/ukcHZi/JU=;
        b=sX57KWlON84SWAv7VJSCsJdMeopwvkEZS+GObDxFcLK+AIfeKjlpWm6oMH/IfRYqbM
         i6paxIVc+1Gx6ncjGcuFVmLKNQ5MbYBVDn2KrGfl7ZH435tp/eaduUzyOEL+BUZ2GuPO
         HelsJ71fCgCai02KnZdZ3nVVRvVJj4a2iMUzaPkRLxjKIrs9+hVU5JmNmF6DMSqpYvln
         pW6M//NMTCK4Fa0Dc9MssxE29lgHqTKuSPfAckBOM2z+HTAybbiP/KAynfGjgkTxB/Nv
         0DunxJNM8sDhoQX9z+fXzuZvEaDAywbrl5HVMiXCdRAcC9A2X7ycRjIP5MTmSsYFiyq1
         uwoA==
X-Gm-Message-State: ALKqPwdb4Bo4is7a15tsC1Q28BEUyF//Hqfcjt4Qa4WF+zrJpOKmLY3M
        5D9Rxyj5gh+LZmNE7P4HGtQ=
X-Google-Smtp-Source: ADUXVKKW6oYrp175zmnu/ggWmyIL/MQii6xotOp3Kxnx3ULg86UUYFla3eqVz0u/km3F2NDxl/fiYA==
X-Received: by 2002:a19:190f:: with SMTP id 15-v6mr3693534lfz.139.1527342951782;
        Sat, 26 May 2018 06:55:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z4-v6sm4941431lji.14.2018.05.26.06.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 06:55:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 11/11] log-tree: allow to customize 'grafted' color
Date:   Sat, 26 May 2018 15:55:31 +0200
Message-Id: <20180526135531.4516-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180526135531.4516-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
 <20180526135531.4516-1-pclouds@gmail.com>
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
index ab641bf5a9..1cc18a828c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1162,7 +1162,8 @@ color.diff.<slot>::
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
 	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
-	branches, remote-tracking branches, tags, stash and HEAD, respectively.
+	branches, remote-tracking branches, tags, stash and HEAD, respectively
+	and `grafted` for grafted commits.
 
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
diff --git a/log-tree.c b/log-tree.c
index 284ce0e3c5..d3a43e29cd 100644
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

