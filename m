Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE701F405
	for <e@80x24.org>; Fri, 21 Dec 2018 16:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389249AbeLUQ2u (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 11:28:50 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39192 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389223AbeLUQ2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 11:28:42 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so5136764edt.6
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 08:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yrF7xXkPjDiivj6l4klg1X7ZvLX3AUyIO9lCnhrtjys=;
        b=PzRVVC9zNPY88Tga9S8voMba776CgD3vAvBlG419HU6rf97mzK5or7HaFdRuisGUni
         fkD1REkHFa72IuhtUe5bj94qYadLNtwGUD0G2gQhSQgLguuXStCqv8KtjH3IqpO9jOA9
         rRqLmPwwVL+067ATbeC1b5kTLM0qGcS75y0/0vnoeDLABzHYr+1/f6vbVhAaUJl+QSAH
         ZFCXxfLk7FphWO6z0MKbdsWIxgvWn4ZnG1jz5V3pWxLUQuCrJtsPtDG331HAojDmPwHv
         hnBm898lCqhaVvHctMX/FZ+FLOzqFFEslIpM6UUOoLROhZGfjDrs6HVDrXi7osJ2Jbdw
         gwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yrF7xXkPjDiivj6l4klg1X7ZvLX3AUyIO9lCnhrtjys=;
        b=agJ2KvYmmwUjWoUbu0icLrwL4zyxc68OKUQXLsMGOloM8PyQaUvHQjvsTWsJI+cFYH
         zJuZ30h4YTc6A1YcJP/jQHjvDRrPM8+ETICM1qBBnhTcM88uv4sN1tmwdM91H898HLH9
         +rqhx6rM5B3A2dnEEqppKah9ps0qZvwDANl1OVleDy9gewRnwbm4yFlB1zAnMwU1vzg5
         UdDCjWJBjFCBHAgZYvRbgriIIH91M6A2yyzQQGFfwDE6YZBzfTnmWvxGH629uVnIKfZ5
         o6nIkgqeM8+co509COiB1d9tFaL8SBSP4uQ18XuPnhYqN4cXHnRLlj7PU/aaE8788w6X
         Fx4A==
X-Gm-Message-State: AA+aEWYirm35P4m25JX+efINHD4LqzMjKKD6We9HHcpZk6bX8sXuTsg7
        lwutgUtlysIH6IzzKga9XOjtbR7ncSXPUw==
X-Google-Smtp-Source: AFSGD/Xr0lJVCCXnqNGDigdVcQ+4SQWyp+xNPmqTn5LOixoQPkFZsLaa2k7hBbrCNaDhZRYwaleBTg==
X-Received: by 2002:a50:b205:: with SMTP id o5mr2793326edd.245.1545409720895;
        Fri, 21 Dec 2018 08:28:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7-v6sm3605814ejx.68.2018.12.21.08.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 08:28:40 -0800 (PST)
Date:   Fri, 21 Dec 2018 08:28:40 -0800 (PST)
X-Google-Original-Date: Fri, 21 Dec 2018 16:28:33 GMT
Message-Id: <0c29a242fec32b0077291cb36a2831e6202b3453.1545409716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v2.git.gitgitgadget@gmail.com>
References: <pull.92.git.gitgitgadget@gmail.com>
        <pull.92.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 4/7] midx: refactor permutation logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When writing a multi-pack-index, we keep track of an integer
permutation, tracking the list of pack-files that we know about
(both from the existing multi-pack-index and the new pack-files
being introduced) and converting them into a sorted order for
the new multi-pack-index.

In anticipation of dropping pack-files from the existing multi-
pack-index, refactor the logic around how we track this permutation.

First, insert the permutation into the pack_list structure. This
allows us to grow the permutation dynamically as we add packs.

Second, fill the permutation with values corresponding to their
position in the list of pack-files, sorted as follows:

  1. The pack-files in the existing multi-pack-index,
     sorted lexicographically.

  2. The pack-files not in the existing multi-pack-index,
     sorted as discovered from the filesystem.

There is a subtle thing in how we initialize this permutation,
specifically how we use 'i' for the initial value. This will
matter more when we implement the logic for dropping existing
packs, as we will create holes in the ordering.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/midx.c b/midx.c
index bb825ef816..3bd7183a53 100644
--- a/midx.c
+++ b/midx.c
@@ -380,9 +380,11 @@ static size_t write_midx_header(struct hashfile *f,
 struct pack_list {
 	struct packed_git **list;
 	char **names;
+	uint32_t *perm;
 	uint32_t nr;
 	uint32_t alloc_list;
 	uint32_t alloc_names;
+	uint32_t alloc_perm;
 	size_t pack_name_concat_len;
 	struct multi_pack_index *m;
 };
@@ -398,6 +400,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 
 		ALLOC_GROW(packs->list, packs->nr + 1, packs->alloc_list);
 		ALLOC_GROW(packs->names, packs->nr + 1, packs->alloc_names);
+		ALLOC_GROW(packs->perm, packs->nr + 1, packs->alloc_perm);
 
 		packs->list[packs->nr] = add_packed_git(full_path,
 							full_path_len,
@@ -417,6 +420,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			return;
 		}
 
+		packs->perm[packs->nr] = packs->nr;
 		packs->names[packs->nr] = xstrdup(file_name);
 		packs->pack_name_concat_len += strlen(file_name) + 1;
 		packs->nr++;
@@ -443,7 +447,7 @@ static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *p
 	ALLOC_ARRAY(pairs, nr_packs);
 
 	for (i = 0; i < nr_packs; i++) {
-		pairs[i].pack_int_id = i;
+		pairs[i].pack_int_id = perm[i];
 		pairs[i].pack_name = pack_names[i];
 	}
 
@@ -755,7 +759,6 @@ int write_midx_file(const char *object_dir)
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct pack_list packs;
-	uint32_t *pack_perm = NULL;
 	uint64_t written = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
@@ -774,18 +777,22 @@ int write_midx_file(const char *object_dir)
 
 	packs.nr = 0;
 	packs.alloc_list = packs.m ? packs.m->num_packs : 16;
-	packs.alloc_names = packs.alloc_list;
+	packs.alloc_perm = packs.alloc_names = packs.alloc_list;
 	packs.list = NULL;
 	packs.names = NULL;
+	packs.perm = NULL;
 	packs.pack_name_concat_len = 0;
 	ALLOC_ARRAY(packs.list, packs.alloc_list);
 	ALLOC_ARRAY(packs.names, packs.alloc_names);
+	ALLOC_ARRAY(packs.perm, packs.alloc_perm);
 
 	if (packs.m) {
 		for (i = 0; i < packs.m->num_packs; i++) {
 			ALLOC_GROW(packs.list, packs.nr + 1, packs.alloc_list);
 			ALLOC_GROW(packs.names, packs.nr + 1, packs.alloc_names);
+			ALLOC_GROW(packs.perm, packs.nr + 1, packs.alloc_perm);
 
+			packs.perm[packs.nr] = i;
 			packs.list[packs.nr] = NULL;
 			packs.names[packs.nr] = xstrdup(packs.m->pack_names[i]);
 			packs.pack_name_concat_len += strlen(packs.names[packs.nr]) + 1;
@@ -802,10 +809,9 @@ int write_midx_file(const char *object_dir)
 		packs.pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
 					      (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
 
-	ALLOC_ARRAY(pack_perm, packs.nr);
-	sort_packs_by_name(packs.names, packs.nr, pack_perm);
+	sort_packs_by_name(packs.names, packs.nr, packs.perm);
 
-	entries = get_sorted_entries(packs.m, packs.list, pack_perm, packs.nr, &nr_entries);
+	entries = get_sorted_entries(packs.m, packs.list, packs.perm, packs.nr, &nr_entries);
 
 	for (i = 0; i < nr_entries; i++) {
 		if (entries[i].offset > 0x7fffffff)
@@ -923,8 +929,8 @@ int write_midx_file(const char *object_dir)
 
 	free(packs.list);
 	free(packs.names);
+	free(packs.perm);
 	free(entries);
-	free(pack_perm);
 	free(midx_name);
 	return 0;
 }
-- 
gitgitgadget

