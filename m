Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADC2B1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfAXVwA (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:52:00 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45959 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfAXVv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:51:59 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so5799865edb.12
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 13:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DLIPd3bITa4K2fjCV1YYrBf98h0dmsqGlSEuJaeGE5M=;
        b=ToPh5gRGNTtbQGpwvsC855StIIoWvSI/HOxT5atnEKjr2HlTS0z8Tl7Edp6gXJaGs0
         9qbGC/USzJMhcVB115USKsnU7RXAVUpbqVZwKwkGf5TopnpLRQzpe5rs0empHX5v50L+
         eOqglApmLKqv6GDxusjiiOryg3bzeGn3WeQQ/3uil6yxgIWlCOubQu0fBrY3db8Zk4A9
         YGRo0OpOdJQwTqkvEqKf6/KYY9kv3DgE9ssNGxcoqfcNTA4kC18Hk4RPHsWPaZ2pnLLY
         AnEnZ6cdQkrVEkMJ4on3DqQmwTgElxHaVyZdWlrtPp66/BHd9NigOHN94jreiu7uzbc9
         4kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DLIPd3bITa4K2fjCV1YYrBf98h0dmsqGlSEuJaeGE5M=;
        b=OBLLg550RxZGF+zHbydA7S5V0mlZSxK0gix+JKYfZaPbAh/e2R92ISGxWeWr8Rtgu3
         sjFAlnQNe4gdNfZuh9S1efqxGj0TLjqrT/b3vDQpInwXKDOrCSeUHW/7RDRMbXQp0dna
         uCKpVduytSCOehFMvQSw5wJT50Ag06s44tCWRYqMAHaPYjK7oW7+rrecMYSvdIoQpsia
         KhfGHG4cQiIzxEI9HyGhA1SkWJP32m3LsrRHzYIZGB0We8pSzuBVoUv06B4UQDzV8G3m
         B3qiQmd3/ZcCY6VYfoPe2wIL6WYY7tPpK6QFJurqnqQhjjTqvJNFgNtPV0Jlvs+I3WgW
         tjXg==
X-Gm-Message-State: AJcUukcPN/BX9pOHRsY1sLSdYzYqWZ7zVYsF30iktB8AGrLnfGeed02o
        kLEHBKB84O5dZuON5QrCHalB68Cc
X-Google-Smtp-Source: ALg8bN5UK7Ijk/Ho/hvu3Vpac0MOZBWW1LpVsyU+94IdhskcidNgjvey0X07EgeiBx3p0HHcqNq9iA==
X-Received: by 2002:a50:a938:: with SMTP id l53mr7976673edc.194.1548366717692;
        Thu, 24 Jan 2019 13:51:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4sm11198770eda.50.2019.01.24.13.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:51:57 -0800 (PST)
Date:   Thu, 24 Jan 2019 13:51:57 -0800 (PST)
X-Google-Original-Date: Thu, 24 Jan 2019 21:51:47 GMT
Message-Id: <d55c1d7ee7b3f3089540cb9554013b6909c70c0f.1548366713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v4.git.gitgitgadget@gmail.com>
References: <pull.92.v3.git.gitgitgadget@gmail.com>
        <pull.92.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 04/10] midx: simplify computation of pack name lengths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before writing the multi-pack-index, we compute the length of the
pack-index names concatenated together. This forms the data in the
pack name chunk, and we precompute it to compute chunk offsets.
The value is also modified to fit alignment needs.

Previously, this computation was coupled with adding packs from
the existing multi-pack-index and the remaining packs in the object
dir not already covered by the multi-pack-index.

In anticipation of this becoming more complicated with the 'expire'
subcommand, simplify the computation by centralizing it to a single
loop before writing the file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/midx.c b/midx.c
index bb825ef816..f087bbbe82 100644
--- a/midx.c
+++ b/midx.c
@@ -383,7 +383,6 @@ struct pack_list {
 	uint32_t nr;
 	uint32_t alloc_list;
 	uint32_t alloc_names;
-	size_t pack_name_concat_len;
 	struct multi_pack_index *m;
 };
 
@@ -418,7 +417,6 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 		}
 
 		packs->names[packs->nr] = xstrdup(file_name);
-		packs->pack_name_concat_len += strlen(file_name) + 1;
 		packs->nr++;
 	}
 }
@@ -762,6 +760,7 @@ int write_midx_file(const char *object_dir)
 	uint32_t nr_entries, num_large_offsets = 0;
 	struct pack_midx_entry *entries = NULL;
 	int large_offsets_needed = 0;
+	int pack_name_concat_len = 0;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -777,7 +776,6 @@ int write_midx_file(const char *object_dir)
 	packs.alloc_names = packs.alloc_list;
 	packs.list = NULL;
 	packs.names = NULL;
-	packs.pack_name_concat_len = 0;
 	ALLOC_ARRAY(packs.list, packs.alloc_list);
 	ALLOC_ARRAY(packs.names, packs.alloc_names);
 
@@ -788,7 +786,6 @@ int write_midx_file(const char *object_dir)
 
 			packs.list[packs.nr] = NULL;
 			packs.names[packs.nr] = xstrdup(packs.m->pack_names[i]);
-			packs.pack_name_concat_len += strlen(packs.names[packs.nr]) + 1;
 			packs.nr++;
 		}
 	}
@@ -798,10 +795,6 @@ int write_midx_file(const char *object_dir)
 	if (packs.m && packs.nr == packs.m->num_packs)
 		goto cleanup;
 
-	if (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
-		packs.pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
-					      (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
-
 	ALLOC_ARRAY(pack_perm, packs.nr);
 	sort_packs_by_name(packs.names, packs.nr, pack_perm);
 
@@ -814,6 +807,13 @@ int write_midx_file(const char *object_dir)
 			large_offsets_needed = 1;
 	}
 
+	for (i = 0; i < packs.nr; i++)
+		pack_name_concat_len += strlen(packs.names[i]) + 1;
+
+	if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
+		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
+					(pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
+
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
@@ -831,7 +831,7 @@ int write_midx_file(const char *object_dir)
 
 	cur_chunk++;
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDFANOUT;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + packs.pack_name_concat_len;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
 
 	cur_chunk++;
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
-- 
gitgitgadget

