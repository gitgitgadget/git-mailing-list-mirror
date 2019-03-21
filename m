Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C26320248
	for <e@80x24.org>; Thu, 21 Mar 2019 19:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfCUTgU (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 15:36:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41206 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfCUTgS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 15:36:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id a25so6016814edc.8
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gcReCIaPKjlbP2JxG3ikL9kTAApG+3mpQX7Y6HSDMGE=;
        b=hD8pQVL/yVWX/hss8ANgCyB4c67NAFIE7ZiQh9XzDSaBZaGBEa0mMRhyB7sO6CpIkD
         KW/HKJ2Yr6M/SXYuzePynOUhSzllGI1JEX0MOS2f1nDu1/TGGFzIY57CCiLTCqOn+SzP
         OlgnjCINQMWkNGftTAmqDCZ0FZcjB0CuVRT42q8pGL4CLDckYuXYJcXWban0JWIoxpuW
         SIS91eM/Xw/DLkFLVErIoV/xEc9nRip27bRu7K1ipXtXyFUpnXeGilRlw/fOaVq0qaRh
         /aBu0CO7t8v0APOHlW8TYzRgv177G1VFxuPIyd9IymkibayksRJfCz/Gw38nxlssfPW3
         yCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gcReCIaPKjlbP2JxG3ikL9kTAApG+3mpQX7Y6HSDMGE=;
        b=QJmYxMEb1+3FS4dOIseum5Lk38RlLIDjp82SmPSkODKI/D065CIlkoDfSQqVbPuXk6
         euPFT2H0yxKfsjc9sdzmalF9MWNy35YqgbRMgaULLHqZX8JUSh1Ra13KM33vsn/LXO4C
         20sB3ZZSwTWIYUtPjaOd0DC5JrU/5Fq/2BNt2eRXml/uxKz/4YLEUUxSUkLTiRbu6h3g
         g/DR4cgG6a+QQqDjUUdpiS5GSGm5e3Ncq1LrMpgJfV69KyAhhJR5A48Khfi4Lw9YcvpO
         ljf7+BZccs/yw3tJkOhVGqqEoRIyXDcjOZv5P5TAfsdKMrCF/jMm3RS/xpfyzSBG+bs9
         TFeQ==
X-Gm-Message-State: APjAAAVZnQjvrXljN4wcA8CpWfrjO1HHN1UnCmlcOzW9qbFXFdQywAnU
        FRqyuuTY4H7dgTUfpoyNWQuWUShK
X-Google-Smtp-Source: APXvYqzDTF3cVVQmG998qRkT8Cw7gI6GKDrQZvF884VgR67vEoxD5pULO/mxbOIYijDESWiuBa7Vwg==
X-Received: by 2002:a50:b149:: with SMTP id l9mr3557759edd.254.1553196975630;
        Thu, 21 Mar 2019 12:36:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bq13sm1145402ejb.2.2019.03.21.12.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 12:36:15 -0700 (PDT)
Date:   Thu, 21 Mar 2019 12:36:15 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Mar 2019 19:36:10 GMT
Message-Id: <7e98ea005aa62ca36af7da34dc6c21a1f77b351e.1553196970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.166.v3.git.gitgitgadget@gmail.com>
References: <pull.166.v2.git.gitgitgadget@gmail.com>
        <pull.166.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 4/4] midx: during verify group objects by packfile to speed
 verification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach `multi-pack-index verify` to sort the set of object by
packfile so that only one packfile needs to be open at a time.

This is a performance improvement.  Previously, objects were
verified in OID order.  This essentially requires all packfiles
to be open at the same time.  If the number of packfiles exceeds
the open file limit, packfiles would be LRU-closed and re-opened
many times.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 midx.c     | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 packfile.c |  2 +-
 packfile.h |  2 ++
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index e3919387d9..f1cd868f8c 100644
--- a/midx.c
+++ b/midx.c
@@ -962,6 +962,20 @@ static void midx_report(const char *fmt, ...)
 	va_end(ap);
 }
 
+struct pair_pos_vs_id
+{
+	uint32_t pos;
+	uint32_t pack_int_id;
+};
+
+static int compare_pair_pos_vs_id(const void *_a, const void *_b)
+{
+	struct pair_pos_vs_id *a = (struct pair_pos_vs_id *)_a;
+	struct pair_pos_vs_id *b = (struct pair_pos_vs_id *)_b;
+
+	return b->pack_int_id - a->pack_int_id;
+}
+
 /*
  * Limit calls to display_progress() for performance reasons.
  * The interval here was arbitrarily chosen.
@@ -976,6 +990,7 @@ static void midx_report(const char *fmt, ...)
 
 int verify_midx_file(const char *object_dir)
 {
+	struct pair_pos_vs_id *pairs = NULL;
 	uint32_t i;
 	struct progress *progress;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
@@ -1019,16 +1034,42 @@ int verify_midx_file(const char *object_dir)
 	}
 	stop_progress(&progress);
 
+	/*
+	 * Create an array mapping each object to its packfile id.  Sort it
+	 * to group the objects by packfile.  Use this permutation to visit
+	 * each of the objects and only require 1 packfile to be open at a
+	 * time.
+	 */
+	ALLOC_ARRAY(pairs, m->num_objects);
+	for (i = 0; i < m->num_objects; i++) {
+		pairs[i].pos = i;
+		pairs[i].pack_int_id = nth_midxed_pack_int_id(m, i);
+	}
+
+	progress = start_sparse_progress(_("Sorting objects by packfile"),
+					 m->num_objects);
+	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
+	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
+	stop_progress(&progress);
+
 	progress = start_sparse_progress(_("Verifying object offsets"), m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
 		struct object_id oid;
 		struct pack_entry e;
 		off_t m_offset, p_offset;
 
-		nth_midxed_object_oid(&oid, m, i);
+		if (i > 0 && pairs[i-1].pack_int_id != pairs[i].pack_int_id &&
+		    m->packs[pairs[i-1].pack_int_id])
+		{
+			close_pack_fd(m->packs[pairs[i-1].pack_int_id]);
+			close_pack_index(m->packs[pairs[i-1].pack_int_id]);
+		}
+
+		nth_midxed_object_oid(&oid, m, pairs[i].pos);
+
 		if (!fill_midx_entry(&oid, &e, m)) {
 			midx_report(_("failed to load pack entry for oid[%d] = %s"),
-				    i, oid_to_hex(&oid));
+				    pairs[i].pos, oid_to_hex(&oid));
 			continue;
 		}
 
@@ -1043,11 +1084,13 @@ int verify_midx_file(const char *object_dir)
 
 		if (m_offset != p_offset)
 			midx_report(_("incorrect object offset for oid[%d] = %s: %"PRIx64" != %"PRIx64),
-				    i, oid_to_hex(&oid), m_offset, p_offset);
+				    pairs[i].pos, oid_to_hex(&oid), m_offset, p_offset);
 
 		midx_display_sparse_progress(progress, i + 1);
 	}
 	stop_progress(&progress);
 
+	free(pairs);
+
 	return verify_midx_error;
 }
diff --git a/packfile.c b/packfile.c
index 16bcb75262..d2bcb2f860 100644
--- a/packfile.c
+++ b/packfile.c
@@ -309,7 +309,7 @@ void close_pack_windows(struct packed_git *p)
 	}
 }
 
-static int close_pack_fd(struct packed_git *p)
+int close_pack_fd(struct packed_git *p)
 {
 	if (p->pack_fd < 0)
 		return 0;
diff --git a/packfile.h b/packfile.h
index d70c6d9afb..b1c18504eb 100644
--- a/packfile.h
+++ b/packfile.h
@@ -76,6 +76,8 @@ extern int open_pack_index(struct packed_git *);
  */
 extern void close_pack_index(struct packed_git *);
 
+int close_pack_fd(struct packed_git *p);
+
 extern uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
-- 
gitgitgadget
