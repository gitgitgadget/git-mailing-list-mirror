Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0B4C20248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfC3LWe (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:22:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38304 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbfC3LWe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:22:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id g37so2221840plb.5
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1353qhiBFkvg4CjMPjTgaQAM7MfVk9j47bxGFKrEJdQ=;
        b=r6W9CF8SzUt170BJMqHnUDj5gENKlPoiF0uTYhXiYTvxHWxRtkHkHb2sc7LLpGhzMn
         eOZrR5wK/PjZiR2b5lGD2qjdQrcwrVFIsMLbXbC1TS1/pl2TmDny0ZI3sk8Y1ztqXH4p
         DFS7XuvRdlZGPijNbkG8tE0W+BKis+KPMrUz/hGHG3XSv5GH08TeJkZHWej16BIGuAI+
         tmI8f/MMEkWJaVGaBrvZzjmGG92NcRe5ZGNBiVUyRvvSxeFSyLhF4dfHPsm3UT8G/lKB
         FWaNWQl6zSZ24yrZPK8W5NgQPT/UqmR0KYHmoR6dBl2oV2xt4izHDudEYJ5I7XXUMBax
         qEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1353qhiBFkvg4CjMPjTgaQAM7MfVk9j47bxGFKrEJdQ=;
        b=knVXaV2UP/KBUm/56ndMoNG+nzS41QgbA2f6CZ5/yvvRInj1toiwaZxT1APCMsctaJ
         mk2RmzvLE7M/Ls2LMr694VjUgGeAttvNjGuLA1q0TKPBxbOHGKCT1UUlJtDtKjsTNo8q
         Z7I7QoursUmkNhtj75gIK9MyQ65l6iOI++8LxunHNRbLVWYJ+hMrsX3qyCUGFHpmY7nK
         8gf5dw4GMC/qule8ij5k5nbfo/HTW2u/AtNlJEXIB9LSjXzUnTJJEbrJ/xaCG021JKl5
         KnkK4b61NxP7JEdXBEn1HF4TAMxduA9XB2aIi2zcI/kOnoE3+GqqTXr30VxZTZ3eeVnS
         X1rQ==
X-Gm-Message-State: APjAAAVi6MZ4foAkrNCMcmNPalEQTpTVbQ2dVe3ha8bTmN7mZ8dKIYdc
        Rrp1A43ZYQ7Z8uB+OqtZMVBj6+ne
X-Google-Smtp-Source: APXvYqyMykcIYA3v9DoHBgdWWWtU02dSknILzQIVqQAbfkUrMLhLTTpDb3ZE8IRyGm5JnLVzc0+XQw==
X-Received: by 2002:a17:902:9001:: with SMTP id a1mr23734442plp.96.1553944953520;
        Sat, 30 Mar 2019 04:22:33 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id g4sm8538804pfm.115.2019.03.30.04.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:22:32 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:22:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 25/31] sha1-name.c: remove the_repo from resolve_relative_path()
Date:   Sat, 30 Mar 2019 18:19:21 +0700
Message-Id: <20190330111927.18645-26-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"remove" is not entirely correct. But at least the function is aware
that if the given repo is not the_repository, then $CWD and
is_inside_work_tree() means nothing.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 6caf3f4e3a..6b53ea2eeb 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1719,12 +1719,12 @@ static void diagnose_invalid_index_path(struct repository *r,
 }
 
 
-static char *resolve_relative_path(const char *rel)
+static char *resolve_relative_path(struct repository *r, const char *rel)
 {
 	if (!starts_with(rel, "./") && !starts_with(rel, "../"))
 		return NULL;
 
-	if (!is_inside_work_tree())
+	if (r != the_repository || !is_inside_work_tree())
 		die("relative path syntax can't be used outside working tree.");
 
 	/* die() inside prefix_path() if resolved path is outside worktree */
@@ -1785,7 +1785,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			stage = name[1] - '0';
 			cp = name + 3;
 		}
-		new_path = resolve_relative_path(cp);
+		new_path = resolve_relative_path(repo, cp);
 		if (!new_path) {
 			namelen = namelen - (cp - name);
 		} else {
@@ -1839,7 +1839,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			const char *filename = cp+1;
 			char *new_filename = NULL;
 
-			new_filename = resolve_relative_path(filename);
+			new_filename = resolve_relative_path(repo, filename);
 			if (new_filename)
 				filename = new_filename;
 			if (flags & GET_OID_FOLLOW_SYMLINKS) {
-- 
2.21.0.479.g47ac719cd3

