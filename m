Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1BBC25B08
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 20:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiHDUqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbiHDUqP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 16:46:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C54D6D9F2
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 13:46:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso3076297wme.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=jJaSEVKwQhml2+4LWjNX91pEEGO/vyJ/R3TEpmXMzGg=;
        b=a+tcdQu+zt/+T0U+ik6hWr8HDBHCgOaKltuadKNzuMs2c43MFxuxLg7WUaSuNs7HP4
         Evh2JBy8yzP6ubSETM5d6+5e/TbK2ka6Vkxt+sZBqrsN+Py2dbq0mzInzHMR1/jR3+Uh
         CN49FfDfOD+VZ2MkpHoMUYpHNRvs59LLsMPIYaiYy/RhpS3ug6RZ4naP3pdgDXVe848E
         D8XqND6R9SYFIueophCggx6s//Wty7sCtoIEsqWFH2pVx6j5YlmCq9RC1pFIWIBNp55C
         FhpZB4TWUEURgMCPGdMtaxGARwnRFxqFzulA25fdzgWzy+vLUVZh8qoChO0qQaF/q1BU
         5iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=jJaSEVKwQhml2+4LWjNX91pEEGO/vyJ/R3TEpmXMzGg=;
        b=SRkaUCtCIouYrkxpluMOoKvT4pcAeHG0PRjcQHqwxYN/Oo5tI9Gx+ziJ8Zr8eNE1I2
         fRC0BKB014hbr0Bz3TFuX1kTUkn0XJrZoS6+zUs01DQQnhQ2OM6dn04tGH3ALKdEizWy
         /SlyRPmdGq8eSC4H4IC1nk+LzsvsHbu65MeRYnKKveYOJtqVcGlZd8we6Nbk3ec56w/v
         LpZE0i6/SMFQojrzJ5XQUfQX8i7eHsy+wsh/+p8sJ8MYnjPo9WxWTz8MiJx5DZ0C/6Qx
         wigAomTHlmPGGW9XMZUCAR5UdH/wA4EeLZim4SMvrmQiUGy6kg/4UKasVdQmoubeGPpt
         LADw==
X-Gm-Message-State: ACgBeo0rmpOhL+Xg5WvkajKHQi315/UGhzu2Uzxu6GYjc2NQr7Yyev/R
        1J5AU4m31RhwOgQB2DG2UDTDGgQPtqE=
X-Google-Smtp-Source: AA6agR66rmubaE9hObYbarq+LU7kIhsynTmVFhJ6+pcLtvroDiazyOx6899AqRbLxkP5WiHNSOAyMA==
X-Received: by 2002:a1c:7503:0:b0:3a3:2db1:d37e with SMTP id o3-20020a1c7503000000b003a32db1d37emr2517181wmc.47.1659645972235;
        Thu, 04 Aug 2022 13:46:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18-20020a5d4352000000b0021d69860b66sm2635249wrr.9.2022.08.04.13.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 13:46:11 -0700 (PDT)
Message-Id: <f7978d223fe86b6d0d43e905ee3abdc02fef8b7d.1659645967.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 20:46:06 +0000
Subject: [PATCH 3/4] cache.h: replace 'index_entry_exists()' with
 'index_name_pos_sparse()'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, shaoxuan.yuan02@gmail.com,
        newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Replace 'index_entry_exists()' (which returns a binary '1' or '0' depending
on whether a specified entry exists in the index) with
'index_name_pos_sparse()' (which behaves the same as 'index_name_pos()',
except that it does not expand a sparse index to search for an entry inside
a sparse directory).

'index_entry_exists()' was original implemented in 20ec2d034c (reset: make
sparse-aware (except --mixed), 2021-11-29) to allow callers to search for an
index entry without expanding a sparse index. That particular case only
required knowing whether the requested entry existed. This patch expands the
amount of information returned by indicating both 1) whether the entry
exists, and 2) its position (or potential position) in the index.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 cache-tree.c |  2 +-
 cache.h      | 15 +++++++--------
 read-cache.c |  4 ++--
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 56db0b5026b..ff0c1733356 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -798,7 +798,7 @@ static void prime_cache_tree_rec(struct repository *r,
 			 * as normal.
 			 */
 			if (r->index->sparse_index &&
-			    index_entry_exists(r->index, tree_path->buf, tree_path->len))
+			    index_name_pos_sparse(r->index, tree_path->buf, tree_path->len) >= 0)
 				prime_cache_tree_sparse_dir(sub->cache_tree, subtree);
 			else
 				prime_cache_tree_rec(r, sub->cache_tree, subtree, tree_path);
diff --git a/cache.h b/cache.h
index 4aa1bd079d5..6bfd1d80b24 100644
--- a/cache.h
+++ b/cache.h
@@ -831,14 +831,13 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
 int index_name_pos(struct index_state *, const char *name, int namelen);
 
 /*
- * Determines whether an entry with the given name exists within the
- * given index. The return value is 1 if an exact match is found, otherwise
- * it is 0. Note that, unlike index_name_pos, this function does not expand
- * the index if it is sparse. If an item exists within the full index but it
- * is contained within a sparse directory (and not in the sparse index), 0 is
- * returned.
- */
-int index_entry_exists(struct index_state *, const char *name, int namelen);
+ * Like index_name_pos, returns the position of an entry of the given name in
+ * the index if one exists, otherwise returns a negative value where the negated
+ * value minus 1 is the position where the index entry would be inserted. Unlike
+ * index_name_pos, however, a sparse index is not expanded to find an entry
+ * inside a sparse directory.
+ */
+int index_name_pos_sparse(struct index_state *, const char *name, int namelen);
 
 /*
  * Some functions return the negative complement of an insert position when a
diff --git a/read-cache.c b/read-cache.c
index 4de207752dc..a85b922a3bc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -620,9 +620,9 @@ int index_name_pos(struct index_state *istate, const char *name, int namelen)
 	return index_name_stage_pos(istate, name, namelen, 0, EXPAND_SPARSE);
 }
 
-int index_entry_exists(struct index_state *istate, const char *name, int namelen)
+int index_name_pos_sparse(struct index_state *istate, const char *name, int namelen)
 {
-	return index_name_stage_pos(istate, name, namelen, 0, NO_EXPAND_SPARSE) >= 0;
+	return index_name_stage_pos(istate, name, namelen, 0, NO_EXPAND_SPARSE);
 }
 
 int remove_index_entry_at(struct index_state *istate, int pos)
-- 
gitgitgadget

