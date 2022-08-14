Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC9CC25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 17:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbiHNRAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 13:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbiHNQ7p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 12:59:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC89B62DF
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 09:55:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h13so6630315wrf.6
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Fir1tozSe6riEGrxncc2/FDO3x0dsVejSnmsGJfL5Vs=;
        b=jtjYkriGp3hHCBqMZRZaB2Tqqy/EWQUQN43ORlztEjOxsoVQ9wizLGQwnLsgTAgA4D
         WUw0rImYq0Pg5QkXUnvHzy+0ey6qWaunmx9dQKsWF5gEjm3rh7Hll00BXTkbbITZB4ch
         4rx/fI1jhyP8oKzwWWmQDU1vjF26xVKU/+8utdnNRGYqX5Z70adPq8OUby6Sz1lxi3a4
         bFH5zSOxCk+EDRjxQG9KnWxdDYXB3JgGTxxUHpRGFuEZRZZYTww5hJ/5r0OcgjUAXTTF
         jGjvYuI3jmThL94THuAJNUAu2GU/gDdTl1QX9N/0qvlLeQpfpOiKo43Tb51++cINH8Fq
         qYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Fir1tozSe6riEGrxncc2/FDO3x0dsVejSnmsGJfL5Vs=;
        b=AO6NT3dfs++EG7ZBygQqTZrBzzQrpGa8XTkDxe4tFyNwwwksg+5uDhZAf1NgmF0dQD
         u153MzieQR9eEN5hj2MtZPDk324LnELeu5Chz5eQG9BQXrhMfCSIpHKcGHRUKJiUN8wv
         fmxBLGvvpAGmvZCXwYXBd7asHgifjv2hcWz2LQHP+6g1goCfhqu/LO0eqbc/Ho8pkB5W
         Z4g5Gpdj8JUX29IFbYYs1+OJykt+07dmTz2IyOFSbAQorc+4h254jgdcfERPp9jCSyHS
         +yzhJQ3v602iRVWVoMU4KN0k86BxCoCqavBUKLJumva5rIJHRj34P4FnKfzBWc8KgsRC
         qxdg==
X-Gm-Message-State: ACgBeo1ZOwgFGWSM4/0mt2TqbEAxgiq+jK/oWC72RZGwJERB14wcI1DF
        NreUb4v2p8aT9dW7wErcLnkSpFJG2Vc=
X-Google-Smtp-Source: AA6agR6dBUZeVGJXDtSoZONBii+En4nIJ8YuBQ4Q8S2riU8rGEMQvmNWHy5HSVv8CTtKxTnzso9BOw==
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id v13-20020adfe28d000000b0021e4c3bb446mr6408233wri.300.1660496117015;
        Sun, 14 Aug 2022 09:55:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18-20020adff0d2000000b0021e45afa7b0sm4871786wro.109.2022.08.14.09.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 09:55:16 -0700 (PDT)
Message-Id: <92ca58fbeeb0ac74a411fc2e67fcbceccc819883.1660496112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
References: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
        <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Aug 2022 16:55:07 +0000
Subject: [PATCH v6 2/6] bitmap: move `get commit positions` code to
 `bitmap_writer_finish`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

The `write_selected_commits_v1` function takes care of writing commit
positions along with their corresponding bitmaps in the disk. It is
OK because this `search commit position of a given commit` algorithm
is needed only once here. But in later changes of the `lookup table
extension series`, we need same commit positions which means we have
to run the above mentioned algorithm one more time.

Move the `search commit position of a given commit` algorithm to
`bitmap_writer_finish()` and use the `commit_positions` array
to get commit positions of their corresponding bitmaps.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 pack-bitmap-write.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 4fcfaed428f..9b1be59f6d3 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -650,20 +650,15 @@ static const struct object_id *oid_access(size_t pos, const void *table)
 
 static void write_selected_commits_v1(struct hashfile *f,
 				      struct pack_idx_entry **index,
-				      uint32_t index_nr)
+				      uint32_t index_nr,
+				      uint32_t *commit_positions)
 {
 	int i;
 
 	for (i = 0; i < writer.selected_nr; ++i) {
 		struct bitmapped_commit *stored = &writer.selected[i];
 
-		int commit_pos =
-			oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
-
-		if (commit_pos < 0)
-			BUG("trying to write commit not in index");
-
-		hashwrite_be32(f, commit_pos);
+		hashwrite_be32(f, commit_positions[i]);
 		hashwrite_u8(f, stored->xor_offset);
 		hashwrite_u8(f, stored->flags);
 
@@ -697,6 +692,8 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	static uint16_t flags = BITMAP_OPT_FULL_DAG;
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct hashfile *f;
+	uint32_t *commit_positions = NULL;
+	uint32_t i;
 
 	struct bitmap_disk_header header;
 
@@ -715,7 +712,20 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	dump_bitmap(f, writer.trees);
 	dump_bitmap(f, writer.blobs);
 	dump_bitmap(f, writer.tags);
-	write_selected_commits_v1(f, index, index_nr);
+
+	ALLOC_ARRAY(commit_positions, writer.selected_nr);
+
+	for (i = 0; i < writer.selected_nr; i++) {
+		struct bitmapped_commit *stored = &writer.selected[i];
+		int commit_pos = oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
+
+		if (commit_pos < 0)
+			BUG(_("trying to write commit not in index"));
+
+		commit_positions[i] = commit_pos;
+	}
+
+	write_selected_commits_v1(f, index, index_nr, commit_positions);
 
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
@@ -730,4 +740,5 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 		die_errno("unable to rename temporary bitmap file to '%s'", filename);
 
 	strbuf_release(&tmp_file);
+	free(commit_positions);
 }
-- 
gitgitgadget

