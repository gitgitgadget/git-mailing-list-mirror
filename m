Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F612201A0
	for <e@80x24.org>; Sat,  1 Jul 2017 00:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbdGAA3B (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 20:29:01 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33349 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752143AbdGAA2y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 20:28:54 -0400
Received: by mail-pg0-f41.google.com with SMTP id f127so70380942pgc.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 17:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8qkn9FmByF8IXJBIBU5eZkBQ6hXS1jjgkGu4UNLZgGE=;
        b=M+Z+TZ97tLcJK8a1+GmGfZf+gGyNKnjWLJ4TBlvwJ/9UhVfwv2tZsa681imqKJy2HG
         g6cc5rM+n9z4KE4AzhUdbEiucirLn4+56V/RReKeZ9Glb9BkTzvnfpDbaSBw3I+jJmsK
         z9+NjBAH43L/Oym3qjVbKFltGL5J6X/mjwsTLr+UjE71rrGpvFJBt3/NnFWqtfeTg84y
         LCzGG//FwzY/DDTHbBh4LSoLThcv+DO5gmaS5AxbjGnAUm/jB1TNcYpQbO3C16WACEYP
         0E3dVUVdzsIXFJMX8RcXD2usrLrST4K/1Ol19t2RlRUbtReOHIvwi/iZoTlK3z02AOWU
         U3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8qkn9FmByF8IXJBIBU5eZkBQ6hXS1jjgkGu4UNLZgGE=;
        b=bubVL2P5j5R1Db3BlggyeNaV1uyoeQY+PwSbN7KnD+wYjs0UYfXXZCF4F8XxO0fiI+
         aR1fb5kyU77+5HSIpdmuVMmEqVLCKtUmKfG6Yx5e0njwgKR5TLoyVK++H04+QipnprS8
         SgkPHLREzI1vSL25QNMg99w7zZYV1wQu5gq8gLrLY2YRcbATQJXcZ7mJ7rSgDsSWq7q0
         3cCf0pXM3iPkmv+u4jhyzT6z8Znk/exLrQ5GF33BUdUdYpCfk70QucmRfXh2t9iwLlKc
         MduwigfRhLDW8U7JTJZAxz1ja9xTPVy5Veq5CbvH4FdfvxtHkF3raiZYb89yO2GyjBH9
         ojNA==
X-Gm-Message-State: AKS2vOylElHyzZkLrjFNoSQ22haOpWbA0dpcaFoVyvJ5FkVqvw/VMcix
        VWAPsOjOHyuChPptLQy1UQ==
X-Received: by 10.84.128.69 with SMTP id 63mr26895232pla.54.1498868928921;
        Fri, 30 Jun 2017 17:28:48 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:cc8b:7c8c:8e14:f9b5])
        by smtp.gmail.com with ESMTPSA id e189sm18932978pfe.100.2017.06.30.17.28.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 17:28:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/10] patch-ids.c: drop hashmap_cmp_fn cast
Date:   Fri, 30 Jun 2017 17:28:34 -0700
Message-Id: <20170701002838.22785-7-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170701002838.22785-1-sbeller@google.com>
References: <20170701002838.22785-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 patch-ids.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index b4166b0f38..9ea523984b 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -35,11 +35,16 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
  * the side of safety.  The actual value being negative does not have
  * any significance; only that it is non-zero matters.
  */
-static int patch_id_cmp(struct diff_options *opt,
-			struct patch_id *a,
-			struct patch_id *b,
+static int patch_id_cmp(const void *cmpfn_data,
+			const void *entry,
+			const void *entry_or_key,
 			const void *unused_keydata)
 {
+	/* NEEDSWORK: const correctness? */
+	struct diff_options *opt = (void*)cmpfn_data;
+	struct patch_id *a = (void*)entry;
+	struct patch_id *b = (void*)entry_or_key;
+
 	if (is_null_oid(&a->patch_id) &&
 	    commit_patch_id(a->commit, opt, &a->patch_id, 0))
 		return error("Could not get patch ID for %s",
@@ -58,8 +63,7 @@ int init_patch_ids(struct patch_ids *ids)
 	ids->diffopts.detect_rename = 0;
 	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
 	diff_setup_done(&ids->diffopts);
-	hashmap_init(&ids->patches, (hashmap_cmp_fn)patch_id_cmp,
-		     &ids->diffopts, 256);
+	hashmap_init(&ids->patches, patch_id_cmp, &ids->diffopts, 256);
 	return 0;
 }
 
-- 
2.13.0.31.g9b732c453e

