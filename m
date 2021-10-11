Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76159C433FE
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE9360C4C
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhJKUch (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbhJKUcd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:32:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D70C061762
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:30 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t2so59908923wrb.8
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nEih7G58FeXZR7VfCiUcLv0bmQevEM54qXiHHW/Vpvo=;
        b=f9jD/6bVwIGH4TKaTR4C/F2tgShYRvzaEG32CY5XT+9as571+S2sFswKlNPcERxuV/
         XfXED3GsYWO8Y35WpA3XatS5E9pIlEgJxkkAdzRNWNYjwUV+NCcXsES2yYwQaCcSsDaF
         vber7ZvMhWsQhy1x66ypLY4y/H1ZEivEnRXgVvwubSecBY+zgGhpx0geheyzPu0/kBXe
         4V7b6Py6ADbmYc6aEPAqlWSwBDXqNcIXJkStWSDH8qiZvdUh4h6x2JcObv8gICisjIkV
         LebQmHKxK05hsUbdL+rW28avWvC8fKEHU+LAy27g8Q0B3bUDp9jm2RqScUn1cfK9nDtw
         +j9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nEih7G58FeXZR7VfCiUcLv0bmQevEM54qXiHHW/Vpvo=;
        b=r7D+zdj3dYx0hHBZS8ScDN7mhOM17598KOrtuXKgm9UKQ68TeDJwjuc1xuYFGo1dAh
         38SiEQXVgGL9156URb8K0740DqbPN8iaU5kPC/SXtJFt3bZMtabrylpV54CZLPUON2kt
         p7ajD1b6IEBB08bdD6m6yIsRMK7r4LLM5bQTSOpkyg/5upF5gifJYYbe//C0h3qx0Bpj
         iVCXpGCdwFo+TCKVazm1qzscj7wRmda/+O6U7ribUuvFtSsmYr7Vg0N39Qr/Hayth7Zu
         F/yv4o1W/WvjEHnBUWXQB2ydlo4jSDgvM79JZfJJ+4mBgOC1hdRgg2k7XQqdR4wDeqhq
         I2NA==
X-Gm-Message-State: AOAM530bjVTYfNq+y8a8XqVvU5JY6h9u7PRkEPsgLpiFkUgXHEB2hMZ7
        oZeQoWj44jHFB/T2MWdtSZP8D1By9r0=
X-Google-Smtp-Source: ABdhPJyPSZKKYX3D2t2kTy+epVv3JPdhGQib9a9BrWwuHKX5sCsZ5TauHid0rdSfIAl5jiXFH5AHXA==
X-Received: by 2002:a1c:988c:: with SMTP id a134mr1231708wme.116.1633984228847;
        Mon, 11 Oct 2021 13:30:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm8495712wro.76.2021.10.11.13.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 13:30:28 -0700 (PDT)
Message-Id: <e523dadb8bfced1874fe40f36c0873a52f0f0594.1633984223.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
References: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Oct 2021 20:30:22 +0000
Subject: [PATCH v4 8/8] unpack-trees: improve performance of next_cache_entry
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

To find the first non-unpacked cache entry, `next_cache_entry` iterates
through index, starting at `cache_bottom`. The performance of this in full
indexes is helped by `cache_bottom` advancing with each invocation of
`mark_ce_used` (called by `unpack_index_entry`). However, the presence of
sparse directories can prevent the `cache_bottom` from advancing in a sparse
index case, effectively forcing `next_cache_entry` to search from the
beginning of the index each time it is called.

The `cache_bottom` must be preserved for the sparse index (see 17a1bb570b
(unpack-trees: preserve cache_bottom, 2021-07-14)). Therefore, to retain the
benefit `cache_bottom` provides in non-sparse index cases, a separate `hint`
position indicates the first position `next_cache_entry` should search,
updated each execution with a new position.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 unpack-trees.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 8ea0a542da8..b94733de6be 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -645,17 +645,24 @@ static void mark_ce_used_same_name(struct cache_entry *ce,
 	}
 }
 
-static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
+static struct cache_entry *next_cache_entry(struct unpack_trees_options *o, int *hint)
 {
 	const struct index_state *index = o->src_index;
 	int pos = o->cache_bottom;
 
+	if (*hint > pos)
+		pos = *hint;
+
 	while (pos < index->cache_nr) {
 		struct cache_entry *ce = index->cache[pos];
-		if (!(ce->ce_flags & CE_UNPACKED))
+		if (!(ce->ce_flags & CE_UNPACKED)) {
+			*hint = pos + 1;
 			return ce;
+		}
 		pos++;
 	}
+
+	*hint = pos;
 	return NULL;
 }
 
@@ -1365,12 +1372,13 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 
 	/* Are we supposed to look at the index too? */
 	if (o->merge) {
+		int hint = -1;
 		while (1) {
 			int cmp;
 			struct cache_entry *ce;
 
 			if (o->diff_index_cached)
-				ce = next_cache_entry(o);
+				ce = next_cache_entry(o, &hint);
 			else
 				ce = find_cache_entry(info, p);
 
@@ -1690,7 +1698,7 @@ static int verify_absent(const struct cache_entry *,
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
 	struct repository *repo = the_repository;
-	int i, ret;
+	int i, hint, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
 	int free_pattern_list = 0;
@@ -1763,13 +1771,15 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		info.pathspec = o->pathspec;
 
 		if (o->prefix) {
+			hint = -1;
+
 			/*
 			 * Unpack existing index entries that sort before the
 			 * prefix the tree is spliced into.  Note that o->merge
 			 * is always true in this case.
 			 */
 			while (1) {
-				struct cache_entry *ce = next_cache_entry(o);
+				struct cache_entry *ce = next_cache_entry(o, &hint);
 				if (!ce)
 					break;
 				if (ce_in_traverse_path(ce, &info))
@@ -1790,8 +1800,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	/* Any left-over entries in the index? */
 	if (o->merge) {
+		hint = -1;
 		while (1) {
-			struct cache_entry *ce = next_cache_entry(o);
+			struct cache_entry *ce = next_cache_entry(o, &hint);
 			if (!ce)
 				break;
 			if (unpack_index_entry(ce, o) < 0)
-- 
gitgitgadget
