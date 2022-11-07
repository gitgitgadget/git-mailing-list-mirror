Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55AEC43217
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiKGSgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiKGSg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6D526AC7
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j15so17559396wrq.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44dn24qGOMEhexAJEfQkrMkQ/mBOQVNND14B5OE1N8E=;
        b=enPep+bMSVW4yMDWJZMcm23omZS61uDWj3SppLm5tEK8oj85qdXjIaavoPufDsa+nj
         ZQxafsI2GOHJKqk4lr3WImz2tQhaySF3LQ7HnpJ+gyf3QZYDnIbNiqatbkLz1B+PyCvp
         qY6KheApHaeqqWfPnuZJCqC5Ay8NH9iU5QHyKYipl8R7hKjGZ9YisifYADOqCLGBm0U7
         rmH5OlMmxBlXqvcDDemxR55PFo4PMZRjLANQ6HOr81pusVlKobVvxtWDYLbmVWe9iXXC
         0qoPd5mg++x/CzrG+01HvTp6G+bTXPam4NV0dvTUeAd6JQqxEYmhLCrEoCz69F6MW3PF
         m1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44dn24qGOMEhexAJEfQkrMkQ/mBOQVNND14B5OE1N8E=;
        b=bnwcWzI8GRSNzusqRmhPbTM3O731UFc2JAx04FZ2InAicSqr8jScPgF7EebmoHItdG
         56OeoYYUytLB63cvCNH7eQ7WwAdsCtG6ZZrKMu0Ilv5e+YTbakr2TZ09kCi+x2Tto8KY
         JMFZ7e4+2FZ5KPBSiYQdJqpw1516Sow4wlr8F87D97Mnm6NFezPA0Sa4ZTk375k24AzY
         6zmuJi4nIMNoIkVXX9UnaFDCl8Y3Z4r1HgaJgHku8fOsL48RaBu99CCeygskQG1n1ZVg
         rtgEkII2jYjcFPgJkv50gX6YthzevvWNUT0ljWywG1I36TQFBdEwXbLW+xdBx0CR/a+K
         xteA==
X-Gm-Message-State: ACrzQf3tkJ61kJf0K+kBmqW7ZMO/ZRk0HJcPUTo5V6f2+UpWuC0ij5Oe
        OPC7nwLtewAwva8GjqfSJuZYhWE2Bhs=
X-Google-Smtp-Source: AMsMyM78mynlrTK1PCvZN90lHu8vV5nZf/+uFrC+4JffEG1mtylPROFhtohVrvHl8nJxiBTIqCeqVQ==
X-Received: by 2002:a5d:548d:0:b0:236:debd:f285 with SMTP id h13-20020a5d548d000000b00236debdf285mr24058614wrv.640.1667846177427;
        Mon, 07 Nov 2022 10:36:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15-20020a056000010f00b0023691d62cffsm8081531wrx.70.2022.11.07.10.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:16 -0800 (PST)
Message-Id: <ebc719f92dd99bb6f5ae92104e87a05e520664d2.1667846164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:45 +0000
Subject: [PATCH 11/30] chunk-format: parse trailing table of contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The new read_trailing_table_of_contents() mimics
read_table_of_contents() except that it reads the table of contents in
reverse from the end of the given hashfile. The file is given as a
memory-mapped section of memory and a size. Automatically calculate the
start of the trailing hash and read the table of contents in revers from
that position.

The errors come along from those in read_table_of_contents(). The one
exception is that the chunk_offset cannot be checked as going into the
table of contents since we do not have that length automatically. That
may have some surprising results for some narrow forms of corruption.
However, we do still limit the size to the size of the file plus the
part of the table of contents read so far. At minimum, the given sizes
can be used to limit parsing within the file itself.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 chunk-format.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 chunk-format.h |  9 +++++++++
 2 files changed, 62 insertions(+)

diff --git a/chunk-format.c b/chunk-format.c
index 3f5cc9b5ddf..e836a121c5c 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -173,6 +173,59 @@ int read_table_of_contents(struct chunkfile *cf,
 	return 0;
 }
 
+int read_trailing_table_of_contents(struct chunkfile *cf,
+				    const unsigned char *mfile,
+				    size_t mfile_size)
+{
+	int i;
+	uint32_t chunk_id;
+	const unsigned char *table_of_contents = mfile + mfile_size - the_hash_algo->rawsz;
+
+	while (1) {
+		uint64_t chunk_offset;
+
+		table_of_contents -= CHUNK_TOC_ENTRY_SIZE;
+
+		chunk_id = get_be32(table_of_contents);
+		chunk_offset = get_be64(table_of_contents + 4);
+
+		/* Calculate the previous chunk size, if it exists. */
+		if (cf->chunks_nr) {
+			off_t previous_offset = cf->chunks[cf->chunks_nr - 1].offset;
+
+			if (chunk_offset < previous_offset ||
+			    chunk_offset > table_of_contents - mfile) {
+				error(_("improper chunk offset(s) %"PRIx64" and %"PRIx64""),
+				previous_offset, chunk_offset);
+				return -1;
+			}
+
+			cf->chunks[cf->chunks_nr - 1].size = chunk_offset - previous_offset;
+		}
+
+		/* Stop at the null chunk. We only need it for the last size. */
+		if (!chunk_id)
+			break;
+
+		for (i = 0; i < cf->chunks_nr; i++) {
+			if (cf->chunks[i].id == chunk_id) {
+				error(_("duplicate chunk ID %"PRIx32" found"),
+					chunk_id);
+				return -1;
+			}
+		}
+
+		ALLOC_GROW(cf->chunks, cf->chunks_nr + 1, cf->chunks_alloc);
+
+		cf->chunks[cf->chunks_nr].id = chunk_id;
+		cf->chunks[cf->chunks_nr].start = mfile + chunk_offset;
+		cf->chunks[cf->chunks_nr].offset = chunk_offset;
+		cf->chunks_nr++;
+	}
+
+	return 0;
+}
+
 static int pair_chunk_fn(const unsigned char *chunk_start,
 			 size_t chunk_size,
 			 void *data)
diff --git a/chunk-format.h b/chunk-format.h
index 39e8967e950..acb8dfbce80 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -46,6 +46,15 @@ int read_table_of_contents(struct chunkfile *cf,
 			   uint64_t toc_offset,
 			   int toc_length);
 
+/**
+ * Read the given chunkfile, but read the table of contents from the
+ * end of the given mfile. The file is expected to be a hashfile with
+ * the_hash_file->rawsz bytes at the end storing the hash.
+ */
+int read_trailing_table_of_contents(struct chunkfile *cf,
+				    const unsigned char *mfile,
+				    size_t mfile_size);
+
 #define CHUNK_NOT_FOUND (-2)
 
 /*
-- 
gitgitgadget

