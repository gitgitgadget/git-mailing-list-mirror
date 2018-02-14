Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E52B1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162541AbeBNTBr (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:47 -0500
Received: from mail-qk0-f201.google.com ([209.85.220.201]:37419 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162545AbeBNTBp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:45 -0500
Received: by mail-qk0-f201.google.com with SMTP id a143so9635693qkg.4
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=9JsIwYGkJPRILNO7NgrVun1c0iovMb7FeIi/o7ZtUio=;
        b=ZA5RGnds1oHEfNRN5kER9mqoQHRn0AmZoTyw6SHp3AJLDumTqhC3TfE+rX3EhSKGuK
         Y3BdLRY61nVgg8Meiw/pB5skRO1K5RR+LA2XNBXmE4nOBoP52O366b8LYE1sknL3+foX
         B4unW2MXbWVQB4nNLTg6uzrsFIQb7et76t27myu7lzfGI73E9lfvJhTbmL+NV1RcgbnC
         RMMz6oo8VvT2eralRpVtGTuDKoszQPi/bow0qJze9Qn7ccdWyZoxOEEmXc8qf1oN1V3q
         ddHiXB5YR8BA+LjFYZMN/qeSOyD1Ij5ZkhxDgl1G5wNqTQ6G94WslyETDWjgzIcVrCKZ
         a9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=9JsIwYGkJPRILNO7NgrVun1c0iovMb7FeIi/o7ZtUio=;
        b=EondMQOqsnV8jnKLdQPjccS7UHECA3XO0sbdq5Xjhby58+OnECEhroLAS5pHXEdSsA
         h9c8AE3lTUmc5S42LO6tW+V6/wF7djzel9/7NfcHh+mYefmkoSALQlmPoJUiCKvOEkr7
         J87hnyOJy60hGsMF1vTlsLOM93HC75VilN0/LZTg8Ob6Y/xV/UGpAqRZQ3fmL0WPLB86
         KVJuS1snkhFiN21w2FpzktzH+pUcuuLlz8U2ycWQhss02UNWeCwZGYjrdBCbJB2Zeolj
         uTgEeLXselZqglf2YgXWIpCpNRGNfxShEB1ewiszo90NuAETaIE/MZ3+14EBePv1eYbl
         NwdQ==
X-Gm-Message-State: APf1xPCIiCtS8HsmRhgxuguQYFmCvuiBJ4kVxxhTUaEQwWEXExXDE0kN
        rwax9nOp/HcMgwzNc05FqrRHrEXT9E14LF5PLjCAm/c8BWg6pFDxV+BQ+IeZBR3NJAWsDbIQ8Gw
        xLHv8XfbY90HsQJTdMfvdXil1SMm/Y64qjobVHlslHKQZaSFYvXfw7oZZfg==
X-Google-Smtp-Source: AH8x225NO03K1LgrI4Vl8VkxS+fSvBS4AK7RZCqJV4xbfLjBNKsYbo7OIS6ZKlBWyTG5ZdlLnuxVFO8TLIM=
MIME-Version: 1.0
X-Received: by 10.55.151.68 with SMTP id z65mr51166qkd.30.1518634904118; Wed,
 14 Feb 2018 11:01:44 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:45 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-24-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 23/37] read-cache: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 read-cache.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b..b22668bfa 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -70,20 +70,20 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 
 void rename_index_entry_at(struct index_state *istate, int nr, const char *new_name)
 {
-	struct cache_entry *old = istate->cache[nr], *new;
+	struct cache_entry *old_entry = istate->cache[nr], *new_entry;
 	int namelen = strlen(new_name);
 
-	new = xmalloc(cache_entry_size(namelen));
-	copy_cache_entry(new, old);
-	new->ce_flags &= ~CE_HASHED;
-	new->ce_namelen = namelen;
-	new->index = 0;
-	memcpy(new->name, new_name, namelen + 1);
+	new_entry = xmalloc(cache_entry_size(namelen));
+	copy_cache_entry(new_entry, old_entry);
+	new_entry->ce_flags &= ~CE_HASHED;
+	new_entry->ce_namelen = namelen;
+	new_entry->index = 0;
+	memcpy(new_entry->name, new_name, namelen + 1);
 
-	cache_tree_invalidate_path(istate, old->name);
-	untracked_cache_remove_from_index(istate, old->name);
+	cache_tree_invalidate_path(istate, old_entry->name);
+	untracked_cache_remove_from_index(istate, old_entry->name);
 	remove_index_entry_at(istate, nr);
-	add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+	add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 }
 
 void fill_stat_data(struct stat_data *sd, struct stat *st)
@@ -615,18 +615,18 @@ static struct cache_entry *create_alias_ce(struct index_state *istate,
 					   struct cache_entry *alias)
 {
 	int len;
-	struct cache_entry *new;
+	struct cache_entry *new_entry;
 
 	if (alias->ce_flags & CE_ADDED)
 		die("Will not add file alias '%s' ('%s' already exists in index)", ce->name, alias->name);
 
 	/* Ok, create the new entry using the name of the existing alias */
 	len = ce_namelen(alias);
-	new = xcalloc(1, cache_entry_size(len));
-	memcpy(new->name, alias->name, len);
-	copy_cache_entry(new, ce);
+	new_entry = xcalloc(1, cache_entry_size(len));
+	memcpy(new_entry->name, alias->name, len);
+	copy_cache_entry(new_entry, ce);
 	save_or_free_index_entry(istate, ce);
-	return new;
+	return new_entry;
 }
 
 void set_object_name_for_intent_to_add_entry(struct cache_entry *ce)
@@ -1379,7 +1379,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	added_fmt = (in_porcelain ? "A\t%s\n" : "%s needs update\n");
 	unmerged_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
 	for (i = 0; i < istate->cache_nr; i++) {
-		struct cache_entry *ce, *new;
+		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
 		int changed = 0;
 		int filtered = 0;
@@ -1408,10 +1408,10 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (filtered)
 			continue;
 
-		new = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
-		if (new == ce)
+		new_entry = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
+		if (new_entry == ce)
 			continue;
-		if (!new) {
+		if (!new_entry) {
 			const char *fmt;
 
 			if (really && cache_errno == EINVAL) {
@@ -1440,7 +1440,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 			continue;
 		}
 
-		replace_index_entry(istate, i, new);
+		replace_index_entry(istate, i, new_entry);
 	}
 	return has_errors;
 }
-- 
2.16.1.291.g4437f3f132-goog

