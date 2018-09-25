Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B771F453
	for <e@80x24.org>; Tue, 25 Sep 2018 13:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbeIYTff (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 15:35:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45249 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeIYTfe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 15:35:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id l2-v6so13272473qtr.12
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 06:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Se3NxHRQNb7SWftCIIptMmABYA0ofXxGlVVOuPR0Xo8=;
        b=qLXxMeXAhx5929vY9XLD8Uj7Kytd7/8d4XS+3ObMLzF5++VbMvEmd40pfuVpVtw3fu
         VdapInHGYHPebfHffCpDQG8vYEePnnH96ZxafETfACt1ehzqqWOd6f2uH+YV9OzYdPlV
         iJxPNdKFxDWpa3tn6Yq2oCJUc2k2girY5IOp5jig9sGeBtzG7s2IiB9MZRm5HH9j77Tx
         QtL5VNsVIo7+gfn33yZNtH0TkbRVlIr/aye6xBEJpw/yY1lV3oeNgZirMGtscHswKgwy
         B0CasCtrclVeemPzv2UkjSWIPiCO14WAEjnCBpxKAHArsSSR0sK1aw7pNYhJQy6TW8SV
         c+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Se3NxHRQNb7SWftCIIptMmABYA0ofXxGlVVOuPR0Xo8=;
        b=W6/F68c1F59XVZc0Kd5zvkymDRFeqAhZbw63S+VJ8+aMMNPyOasD1/kawLAzcYlv4r
         TIq34BAajPH+4/Pk2U/cf5F3UxqZVEfJtd1RgcWYIFhBaymWdoWZrbZbU7fZg/He2ztf
         iwfQkaKy5MeuNSgiLC+JX6ajZMaZCpA6Wc6fUPQk6ut5t7IxpevQid993Uc1YiIFCEDu
         eEBtd2Eqo1tJRfLI/ko0stooQrGuNA65PGZGmd4FwVqdVkm+0XrRaSZdf29hrI4LJk1N
         V23Yr/F1whwzirSVhsAniaEtdYqunq7Ccg0ugsV6TjosfwX0hTeL62fp6gSMKx/jRw20
         RIDQ==
X-Gm-Message-State: ABuFfogzwWL1v2NzT5trpipn/qZRk0i+qoy0QIllPw0XdDwptWILhqp6
        Sq+hjGI8Ikn/EKBY4pAgDkASrvSi
X-Google-Smtp-Source: ACcGV61fO3+coA/q8LQUmHNTpN4etVnT/0HA2MBD5L+Ffh9I9lWU48R9QSnNWmuktJczQbbRpTjZYw==
X-Received: by 2002:aed:3e4d:: with SMTP id m13-v6mr733891qtf.99.1537882079883;
        Tue, 25 Sep 2018 06:27:59 -0700 (PDT)
Received: from stolee-linux.mshome.net ([167.220.148.125])
        by smtp.gmail.com with ESMTPSA id h68-v6sm1157628qkc.97.2018.09.25.06.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 06:27:51 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] commit-reach: cleanups in can_all_from_reach...
Date:   Tue, 25 Sep 2018 13:27:41 +0000
Message-Id: <20180925132741.223513-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <pull.39.v4.git.gitgitgadget@gmail.com>
References: <pull.39.v4.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Due to a regression introduced by 4fbcca4e "commit-reach: make
can_all_from_reach... linear" the series including b67f6b26
"commit-reach: properly peel tags" was merged to master quickly.

There were a few more cleanups left to apply in the series, which
are included by this change:

1. Clean up a comment that is in the incorrect style.

2. Replace multiple calls to clear_commit_marks() with one call to
   clear_commit_marks_many().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 5a845440a9..66aa41262c 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -558,7 +558,8 @@ int can_all_from_reach_with_flag(struct object_array *from,
 		from_one = deref_tag(the_repository, from_one,
 				     "a from object", 0);
 		if (!from_one || from_one->type != OBJ_COMMIT) {
-			/* no way to tell if this is reachable by
+			/*
+			 * no way to tell if this is reachable by
 			 * looking at the ancestry chain alone, so
 			 * leave a note to ourselves not to worry about
 			 * this object anymore.
@@ -622,10 +623,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 	}
 
 cleanup:
-	for (i = 0; i < nr_commits; i++) {
-		clear_commit_marks(list[i], RESULT);
-		clear_commit_marks(list[i], assign_flag);
-	}
+	clear_commit_marks_many(nr_commits, list, RESULT | assign_flag);
 	free(list);
 
 	for (i = 0; i < from->nr; i++)

base-commit: 4067a64672f9db8ca38d5a2682a7cdba7938c18b
-- 
2.19.0

