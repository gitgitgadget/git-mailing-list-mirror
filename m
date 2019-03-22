Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D5F20248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfCVJcL (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:32:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46178 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfCVJcL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:32:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id a22so1099810pgg.13
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j5b7Hi0QW5VFWXhXSUf1XmIgv+P5jKo7W6wPVYCQRqw=;
        b=p66aleF83IBqQQ99/AuQ8YauyjzTQDZLlSKJ5t5JCQLJ1ittTEe9gElrZ2asEJOdIj
         21jpUIM3Gbu3Rjcz0UEmgr5Mmw8g+CHye5zfTBIxdkv9eEpumzlNFbj0QtwpRunRPUiA
         vPAOEXJIdx79+/CYs0zBr48NNOa3G8zNRy2dycOVSAlz4wrVRZuL6GNNBpvOq2ODpsGq
         bjSZRcPuUEP59LJhq53bFlL8vmmAorBakcpsS5yyJX2xLAm92ibU2WXLUNm996auud9B
         Grerhsg/b8yFzDetENrjCTYS70knZC1pz9wegH5cznzWE9S88KmOwOE8wIS9NASN5lHq
         FGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j5b7Hi0QW5VFWXhXSUf1XmIgv+P5jKo7W6wPVYCQRqw=;
        b=RCcG8rj+SvTctM+EAqZzj0roGwvLS2pHqKijNw/ZrYhSd389PDooPAvCwZfu4tAWG9
         OBsLv7bwoAWH867YN1ik8rCzFnLL/Sq7kE/d5juGrR/JBcqKPLaX2+/bo0rqGhhu8DMk
         0Q3tgAS4X8V7p+T+S1RQSvjFgvExK797m7Rp/0SajIabJxV3p76L+vYHKp62CRq6QZIh
         IATDY8PZntJGDP/0EdsBajcZOjYvbLHCSpwUGeNjoe10uZTmnHGVgYoZCvYhDpXn7Sho
         5lUAfS753DNMQ+7DzSpzgf8NlctNAPM5f8fKnr+xOqt2shuhp/f3XCGoqhYQTLY/b77w
         XRlA==
X-Gm-Message-State: APjAAAWikmGc+6yDtkdoVSw3GQgye1fLn0PLoOUTfwJpZ0sKhyNdrCRm
        zrckOelRI2AcX+CCgZQb/5dhRBsUznU=
X-Google-Smtp-Source: APXvYqwjnQcf1oUVDaaAc6RzKNYArQHNPq0A90ZS3TfeJsfkQcwyC9pRDQ/M9LLcHHaQ2qE6qlON7w==
X-Received: by 2002:a62:6d81:: with SMTP id i123mr8108817pfc.235.1553247130910;
        Fri, 22 Mar 2019 02:32:10 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id x13sm8006662pgr.87.2019.03.22.02.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 02:32:10 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 22 Mar 2019 16:32:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/4] unpack-trees: keep gently check inside add_rejected_path
Date:   Fri, 22 Mar 2019 16:31:35 +0700
Message-Id: <20190322093138.13765-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190322093138.13765-1-pclouds@gmail.com>
References: <20190322093138.13765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This basically follows the footsteps of 6a143aa2b2 (checkout -m:
attempt merge when deletion of path was staged - 2014-08-12) where
there gently check is moved inside reject_merge() so that callers do
not accidentally forget it.

add_rejected_path() has the same usage pattern. All call sites check
gently first, then decide to call add_rejected_path() if needed. Move
the check inside.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 22c41a3ba8..e6c1cc8302 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -219,6 +219,9 @@ static int add_rejected_path(struct unpack_trees_options *o,
 			     enum unpack_trees_error_types e,
 			     const char *path)
 {
+	if (o->gently)
+		return -1;
+
 	if (!o->show_all_errors)
 		return error(ERRORMSG(o, e), super_prefixed(path));
 
@@ -268,8 +271,7 @@ static int check_submodule_move_head(const struct cache_entry *ce,
 		flags |= SUBMODULE_MOVE_HEAD_FORCE;
 
 	if (submodule_move_head(ce->name, old_id, new_id, flags))
-		return o->gently ? -1 :
-				   add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
+		return add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
 	return 0;
 }
 
@@ -1645,8 +1647,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 static int reject_merge(const struct cache_entry *ce,
 			struct unpack_trees_options *o)
 {
-	return o->gently ? -1 :
-		add_rejected_path(o, ERROR_WOULD_OVERWRITE, ce->name);
+	return add_rejected_path(o, ERROR_WOULD_OVERWRITE, ce->name);
 }
 
 static int same(const struct cache_entry *a, const struct cache_entry *b)
@@ -1693,8 +1694,7 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 			int r = check_submodule_move_head(ce,
 				"HEAD", oid_to_hex(&ce->oid), o);
 			if (r)
-				return o->gently ? -1 :
-					add_rejected_path(o, error_type, ce->name);
+				return add_rejected_path(o, error_type, ce->name);
 			return 0;
 		}
 
@@ -1712,8 +1712,7 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 	}
 	if (errno == ENOENT)
 		return 0;
-	return o->gently ? -1 :
-		add_rejected_path(o, error_type, ce->name);
+	return add_rejected_path(o, error_type, ce->name);
 }
 
 int verify_uptodate(const struct cache_entry *ce,
@@ -1835,8 +1834,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 		d.exclude_per_dir = o->dir->exclude_per_dir;
 	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
 	if (i)
-		return o->gently ? -1 :
-			add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
+		return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
 	free(pathbuf);
 	return cnt;
 }
@@ -1905,8 +1903,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 			return 0;
 	}
 
-	return o->gently ? -1 :
-		add_rejected_path(o, error_type, name);
+	return add_rejected_path(o, error_type, name);
 }
 
 /*
-- 
2.21.0.548.gd3c7d92dc2

