Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7F8C433EF
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 13:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiFZNK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiFZNKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 09:10:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B932BB7C1
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:10:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i25so3882988wrc.13
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7z8VzqJ+VkTtT25Vm8lkEmhKRt12h3iNvlfPrqtDT44=;
        b=pYJ5sVNn7+yFDv25zMGOAzgsY8HAUOG93KoAZQ/8pcUvgs8eouUAMQHkw/4NWq64dY
         SpV3sz6F18aperBYyofSqEWUyrUXnahYMOQCYr7PZJrkdax4DWRc+UTKnAIZccgcYWKL
         wFVQWhbh6ZIJLYyT2EOwiocCup1MCX/OrSRmc1Sqk/XAr5mLDBUuxKulVgOEk8ZZLdrS
         O0UvwjruqtpaJWKq8+tFNVlGKVbIKnpH+fj4avKkSUBQD/H9+4YCD6I0S0kl0ZAk10fH
         2KOitNHMFD9/I+aatAef3JuPUj05ZYBEKKKFTciiX8zZkJwRmAQKcT91dIAtmOYuHXYG
         9r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7z8VzqJ+VkTtT25Vm8lkEmhKRt12h3iNvlfPrqtDT44=;
        b=wKSBUlu92spdoDiVsowgQ6L65FrbMMt2dFU2eyeH3aFroP1XK1nBDx8ua4mJvAUvp+
         buDI9dLwkvvuesZ5lcn+dwIZc4pZe8hXWbXRxumtXdfoBghRgsBBmqkSzc9gX9PObR0R
         qUnbtXzzcEB//Ea3vkkLVEffRvVrBwcYP+ia5A8BG7/mTYP4crPM/roxTouQ6K75Wj9h
         r33N1f9a8QCDJtwCrMBtsSiSpe1D6Hk39L/b3OhzLzw0/mVPlbBZQRIqEdvRSaBbAodj
         AFZ2xIptARkbpxYqshFHM3vkE5wJ/DAICyOYCmcVNT5wtryE5x5RVtbnHCO7P1OVqnJz
         pkwQ==
X-Gm-Message-State: AJIora+6SKtq/rY0WluD+31Kv5DTMNJqKhtm+enyuLuLiOMtUwLCniA9
        CTAEfKmIV2cxO/Dm4YQp+hEO/0DEDuSWFQ==
X-Google-Smtp-Source: AGRyM1vUGomFFeVK704SvTab0L8M5fUMbAJY+lCh3qzvfebCjt0cuhs+8zb8FALJ1sWBTAEP/UHMTA==
X-Received: by 2002:adf:d084:0:b0:21b:8a7c:d260 with SMTP id y4-20020adfd084000000b0021b8a7cd260mr7725945wrh.68.1656249022952;
        Sun, 26 Jun 2022 06:10:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y21-20020a7bc195000000b0039c362311d2sm16136073wmi.9.2022.06.26.06.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 06:10:22 -0700 (PDT)
Message-Id: <7786dc879f006c8316c33dd70e98888ceb50a014.1656249017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
        <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Jun 2022 13:10:14 +0000
Subject: [PATCH v2 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Teach git to provide a way for users to enable/disable bitmap lookup
table extension by providing a config option named 'writeBitmapLookupTable'.
Default is true.

Also add test to verify writting of lookup table.

Co-Authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/config/pack.txt |  7 +++++++
 builtin/multi-pack-index.c    |  8 ++++++++
 builtin/pack-objects.c        | 10 +++++++++-
 midx.c                        |  3 +++
 midx.h                        |  1 +
 pack-bitmap-write.c           |  2 ++
 t/t5310-pack-bitmaps.sh       |  3 ++-
 t/t5326-multi-pack-bitmaps.sh | 13 +++++++++++++
 8 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index ad7f73a1ead..6e1f454c4d6 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -164,6 +164,13 @@ When writing a multi-pack reachability bitmap, no new namehashes are
 computed; instead, any namehashes stored in an existing bitmap are
 permuted into their appropriate location when writing a new bitmap.
 
+pack.writeBitmapLookupTable::
+	When true, git will include a "lookup table" section in the
+	bitmap index (if one is written). This table is used to defer
+	loading individual bitmaps as late as possible. This can be
+	beneficial in repositories which have relatively large bitmap
+	indexes. Defaults to true.
+
 pack.writeReverseIndex::
 	When true, git will write a corresponding .rev file (see:
 	link:../technical/pack-format.html[Documentation/technical/pack-format.txt])
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5edbb7fe86e..3757616f09c 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -87,6 +87,13 @@ static int git_multi_pack_index_write_config(const char *var, const char *value,
 			opts.flags &= ~MIDX_WRITE_BITMAP_HASH_CACHE;
 	}
 
+	if (!strcmp(var, "pack.writebitmaplookuptable")) {
+		if (git_config_bool(var, value))
+			opts.flags |= MIDX_WRITE_BITMAP_LOOKUP_TABLE;
+		else
+			opts.flags &= ~MIDX_WRITE_BITMAP_LOOKUP_TABLE;
+	}
+
 	/*
 	 * We should never make a fall-back call to 'git_default_config', since
 	 * this was already called in 'cmd_multi_pack_index()'.
@@ -123,6 +130,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 	};
 
 	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
+	opts.flags |= MIDX_WRITE_BITMAP_LOOKUP_TABLE;
 
 	git_config(git_multi_pack_index_write_config, NULL);
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 39e28cfcafc..d6a33fd486c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -228,7 +228,7 @@ static enum {
 	WRITE_BITMAP_QUIET,
 	WRITE_BITMAP_TRUE,
 } write_bitmap_index;
-static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
+static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE | BITMAP_OPT_LOOKUP_TABLE;
 
 static int exclude_promisor_objects;
 
@@ -3148,6 +3148,14 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		else
 			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
 	}
+
+	if (!strcmp(k, "pack.writebitmaplookuptable")) {
+		if (git_config_bool(k, v))
+			write_bitmap_options |= BITMAP_OPT_LOOKUP_TABLE;
+		else
+			write_bitmap_options &= ~BITMAP_OPT_LOOKUP_TABLE;
+	}
+
 	if (!strcmp(k, "pack.usebitmaps")) {
 		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
diff --git a/midx.c b/midx.c
index 5f0dd386b02..9c26d04bfde 100644
--- a/midx.c
+++ b/midx.c
@@ -1072,6 +1072,9 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
 		options |= BITMAP_OPT_HASH_CACHE;
 
+	if (flags & MIDX_WRITE_BITMAP_LOOKUP_TABLE)
+		options |= BITMAP_OPT_LOOKUP_TABLE;
+
 	prepare_midx_packing_data(&pdata, ctx);
 
 	commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, ctx);
diff --git a/midx.h b/midx.h
index 22e8e53288e..5578cd7b835 100644
--- a/midx.h
+++ b/midx.h
@@ -47,6 +47,7 @@ struct multi_pack_index {
 #define MIDX_WRITE_REV_INDEX (1 << 1)
 #define MIDX_WRITE_BITMAP (1 << 2)
 #define MIDX_WRITE_BITMAP_HASH_CACHE (1 << 3)
+#define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
 
 const unsigned char *get_midx_checksum(struct multi_pack_index *m);
 void get_midx_filename(struct strbuf *out, const char *object_dir);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 899a4a941e1..79be0cf80e6 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -713,6 +713,7 @@ static void write_lookup_table(struct hashfile *f,
 	for (i = 0; i < writer.selected_nr; i++)
 		table_inv[table[i]] = i;
 
+	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", the_repository);
 	for (i = 0; i < writer.selected_nr; i++) {
 		struct bitmapped_commit *selected = &writer.selected[table[i]];
 		uint32_t xor_offset = selected->xor_offset;
@@ -725,6 +726,7 @@ static void write_lookup_table(struct hashfile *f,
 
 	free(table);
 	free(table_inv);
+	trace2_region_leave("pack-bitmap-write", "writing_lookup_table", the_repository);
 }
 
 static void write_hash_cache(struct hashfile *f,
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f775fc1ce69..c669ed959e9 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -38,7 +38,8 @@ test_expect_success 'full repack creates bitmaps' '
 	ls .git/objects/pack/ | grep bitmap >output &&
 	test_line_count = 1 output &&
 	grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
-	grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace
+	grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace &&
+	grep "\"label\":\"writing_lookup_table\"" trace
 '
 
 basic_bitmap_tests
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 4fe57414c13..43be49617b8 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -307,4 +307,17 @@ test_expect_success 'graceful fallback when missing reverse index' '
 	)
 '
 
+test_expect_success 'multi-pack-index write writes lookup table if enabled' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+		test_commit base &&
+		git repack -ad &&
+		GIT_TRACE2_EVENT="$(pwd)/trace" \
+			git multi-pack-index write --bitmap &&
+		grep "\"label\":\"writing_lookup_table\"" trace
+	)
+'
 test_done
-- 
gitgitgadget

