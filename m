Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF100C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91C860FC0
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbhJ0OmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238841AbhJ0Ol7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 10:41:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35CAC061220
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:39:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m42so2856404wms.2
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nEih7G58FeXZR7VfCiUcLv0bmQevEM54qXiHHW/Vpvo=;
        b=mS5GBY3gCI4NiNMCM7r3FYnAdSjzATfxo9FQPnDGHJjamKo8Z2uxQbF6E2c+9TnE+w
         hEexrgRGFs8xULrKaFl9yXfxGzREi3W/gSZFirHORen+ChecdhF90yhmEfnzuowpWt3l
         pW1QKJa1J/gU0dnSVGKfTGLP60HDPTnEjqlKBdanLTZ8pK74BdmKPdjQitcms/+lwsgw
         pJfdm//19jRCWN3Zu5q+vVTI/8CGaKPoYVbfxeRFpAB7/dEepRpPI/ssg8MuAjKJ43fY
         DtOi36D3VzWiSVE+cU7si9gjENOoaICh2G5lC6wVjgDtX4KgfsXPD72qDYRAr2QHTjcn
         JP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nEih7G58FeXZR7VfCiUcLv0bmQevEM54qXiHHW/Vpvo=;
        b=zxV8Eq7qASu1RlnUm8tHLVuU30OR+xO+2Co3qhD/FJO0ZBU9RSgOcgpmgLrgWHmc72
         Ph+HRvIWCo9TLDNfRDvjgwNBDnh1pJjfxMaaNtW0hc463ZCjl45VbbXNPpXLVtcb2BbW
         1FCQArIYnob/ALZ1xJWDTsVcBsPPfjuRxRaLRknW0FKgUMGgkROElPXQin5gji+prcLJ
         zfTfBYeOHGdYkW29flWvzY2DigsfRegtg4n9NEN6N/nNH0gTN7AyZT6acXOFL5oJtnFL
         OsUWnZpDIXlMddrB5SpXXlRMNLPQYzg2Qi+Ls2aOmYznUYDh3x8KJqOwGfzgGP8Dbbva
         qqvw==
X-Gm-Message-State: AOAM531oyEyKuTO4NP3zpt8GX4awzoPxne+TGaDfBoQEK3FqqaO9Zn+f
        u64OMUNthIU436KF9doirYBp9rjoIwQ=
X-Google-Smtp-Source: ABdhPJz5R4k6rc5pjaDR7yOcelK670LD1iWtREfu0i0SA+emW9KEiA0CU2IFpWT9NxYedIcBa7qQWQ==
X-Received: by 2002:a1c:7e41:: with SMTP id z62mr6163079wmc.9.1635345569492;
        Wed, 27 Oct 2021 07:39:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2sm76616wrb.20.2021.10.27.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:39:29 -0700 (PDT)
Message-Id: <f91d1dcf024bfc5639db40d113985cb3094eddad.1635345563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
References: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
        <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 14:39:23 +0000
Subject: [PATCH v5 8/8] unpack-trees: improve performance of next_cache_entry
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
        Emily Shaffer <emilyshaffer@google.com>,
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
