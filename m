Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6D5C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 15:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiCQP5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbiCQP46 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 11:56:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2884520DB15
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 08:55:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d7so7966630wrb.7
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 08:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uhbQM6c/LOAyK0X3Mgbqn0rKlR9OyZQqNJeZg1wj7lk=;
        b=P09LSwYFUem3watChyohLo1MNXAc4lXwgklRBxVj1J//CIKAZAC0wA32Yd3cKyBzQn
         lLSobDg/3q3sJiHCsLlZ+8lFVIrLPX8Pse4m7nGmr92qxtZ02nhBcuOS3hSLexe68D/+
         LiINAEkRDhSXkyfFw4oJMaO8RrCNJrRE4WuhIUxT3HzpFd72oOOTo/eTjP4XtU6MFHdq
         tHfww8hG39iSw2DQlD/v/V6Buz41VGAaS8BPDDXKoZ4zmkPg5eR+jBp2rLh2rEZ6zZb1
         yZu+Pf/WCvpsSWoqIct3tKJWRFpKdd0y/f7R/PK087npAr1jFpzg5rUWMd8t3N1pj+xp
         11BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uhbQM6c/LOAyK0X3Mgbqn0rKlR9OyZQqNJeZg1wj7lk=;
        b=UzPDMKWS8hB+g+j4xTClqDBMhDj3uygK1rBFTnA6i+KKKZjX0hftQ9r3DbEEqsY9ox
         mSaBUfiBsVJQ2d3K4ZafOlEyovjxWKaMuv9kMeaIn1tYV80oD22cwZDkL+fZdIBXHn0g
         W+QksXb1w3bFhX8EMQqYdIYNmp/6FMpUUGpNIIeftQz+NItJZkOl0Iikwi1ZiKavs990
         eh5XxoOgaaTLCX55Zxyn/GAAHQkpFW947csNH3xqQp8ow33cl/oLxsMhLQCmjl9owssp
         r3I+S0zYbFnI8y4w4wCdRo/UYTTFKpR1oJJ33X5CR0QypkZIU67MmMV73QSPp34teWLS
         rYsA==
X-Gm-Message-State: AOAM530KSzKU5zIlliZYLvhQVuOmsDO7yE0eYej1lNkii1Z6LLgt4csa
        HrI/Y8Mk7VD8x4wLL85RJyD5omBB8cg=
X-Google-Smtp-Source: ABdhPJw9lCyoaFNAdvknF97+8s4VjaiA/OSy5RELdFyiX5l/sGT25p0eoNuUu1U3yhWb3YW/iJpp2g==
X-Received: by 2002:a05:6000:1d82:b0:203:e5cc:c19b with SMTP id bk2-20020a0560001d8200b00203e5ccc19bmr4462484wrb.553.1647532540587;
        Thu, 17 Mar 2022 08:55:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389a558670fsm7838053wmi.11.2022.03.17.08.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 08:55:40 -0700 (PDT)
Message-Id: <d74b304f560a789594cfa6eb57e677464a0b34cb.1647532537.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1179.v2.git.1647532536.gitgitgadget@gmail.com>
References: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
        <pull.1179.v2.git.1647532536.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Mar 2022 15:55:36 +0000
Subject: [PATCH v2 3/3] Revert "unpack-trees: improve performance of
 next_cache_entry"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

This reverts commit f2a454e0a5 (unpack-trees: improve performance of
next_cache_entry, 2021-11-29).

The "hint" value was originally needed to improve performance in 'git reset
-- <pathspec>' caused by 'cache_bottom' lagging behind its correct value
when using a sparse index. The 'cache_bottom' tracking has since been
corrected, removing the need for an additional "pseudo-cache_bottom"
tracking variable.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 unpack-trees.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index b82c1a9705e..7f528d35cc2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -644,24 +644,17 @@ static void mark_ce_used_same_name(struct cache_entry *ce,
 	}
 }
 
-static struct cache_entry *next_cache_entry(struct unpack_trees_options *o, int *hint)
+static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
 {
 	const struct index_state *index = o->src_index;
 	int pos = o->cache_bottom;
 
-	if (*hint > pos)
-		pos = *hint;
-
 	while (pos < index->cache_nr) {
 		struct cache_entry *ce = index->cache[pos];
-		if (!(ce->ce_flags & CE_UNPACKED)) {
-			*hint = pos + 1;
+		if (!(ce->ce_flags & CE_UNPACKED))
 			return ce;
-		}
 		pos++;
 	}
-
-	*hint = pos;
 	return NULL;
 }
 
@@ -1409,13 +1402,12 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 
 	/* Are we supposed to look at the index too? */
 	if (o->merge) {
-		int hint = -1;
 		while (1) {
 			int cmp;
 			struct cache_entry *ce;
 
 			if (o->diff_index_cached)
-				ce = next_cache_entry(o, &hint);
+				ce = next_cache_entry(o);
 			else
 				ce = find_cache_entry(info, p);
 
@@ -1777,7 +1769,7 @@ static int verify_absent(const struct cache_entry *,
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
 	struct repository *repo = the_repository;
-	int i, hint, ret;
+	int i, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
 	int free_pattern_list = 0;
@@ -1869,15 +1861,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		info.pathspec = o->pathspec;
 
 		if (o->prefix) {
-			hint = -1;
-
 			/*
 			 * Unpack existing index entries that sort before the
 			 * prefix the tree is spliced into.  Note that o->merge
 			 * is always true in this case.
 			 */
 			while (1) {
-				struct cache_entry *ce = next_cache_entry(o, &hint);
+				struct cache_entry *ce = next_cache_entry(o);
 				if (!ce)
 					break;
 				if (ce_in_traverse_path(ce, &info))
@@ -1898,9 +1888,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	/* Any left-over entries in the index? */
 	if (o->merge) {
-		hint = -1;
 		while (1) {
-			struct cache_entry *ce = next_cache_entry(o, &hint);
+			struct cache_entry *ce = next_cache_entry(o);
 			if (!ce)
 				break;
 			if (unpack_index_entry(ce, o) < 0)
-- 
gitgitgadget
