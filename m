Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6CBC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbiKGSgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiKGSgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:10 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BBA240A3
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id y16so17507795wrt.12
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwC5rdCBH8oAZ28SC1bjINPERkNTBY5/ApyQoQryQpE=;
        b=SQeyBlH+F3IEKx0DdJhEp0kc6GA7huuXSGyIt9SNC78aCM+Wy+a+qsbCy+WvhGJdPu
         tvtHlpcKVVSDF0WWxwcqxLsyDmcGQ6VVBm7IOfydwBji5dGPUqzv+jN0t1EahuPmxgK5
         7is0ttJnGz1Fnvr3X3WScPtr3fYituL1XNpmUH6GzL8atFE+KJTTC7GmKZBJZ+NZf4/d
         leqXe26YHBopA9DWwd+aXmK8s9jU8tWQfR4tWgT2qO4KJ7986qXoIssCNPrR93e8viGJ
         XvHOKRoNCYsa+O1x8Z+jH/fT7Th03Li0HonmAnfL5O/44Hqlk6HjrUoraZTGM4bqU97h
         +K+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwC5rdCBH8oAZ28SC1bjINPERkNTBY5/ApyQoQryQpE=;
        b=c7anbCaAeTOPEkCm6xExFYr0cz5obHQEgNrjSwLxY2nU9hgl7fv9bRjTVCBSqgaa5K
         CKnT9eo5kqg0aDXZU4KrjNV5TkpmENou5fXafZkHCi7vG9wINOJkrVa/yEg0fc0VIkWh
         iE4Ktnf/dM3Cf1hytbQZoItzh0/juC7ol3FtKCN5gXvZ6DZpBA+s9wvaCld1gI2eGeyV
         Gkj4pSBv+bYfY9NqE93yMfxa8aE9txAGxpHgyGwIAOxxl/cBRfJHnqVwQbGZCLIjBfEi
         sqfohqcijNrdbgFf//3nhlHF3omzI6EhgwT+JCJlMpI187hu+HC5jSxdSMZewry/6ltO
         8ZeQ==
X-Gm-Message-State: ACrzQf3en++lWUNx7gMXrRE9gqa2JC7s7eQM2/pWArkeAxbMj/QEeIsg
        hbpqkK8tsbXbfhV/uXaSfrUnlalXnrw=
X-Google-Smtp-Source: AMsMyM7xZUl0ylNMZ41dn/zopx24e4xnTYld6JcNmdql4E2RjwPDG+F4GzPcDrtHwQSfjeTlTu8Bvw==
X-Received: by 2002:a5d:52ca:0:b0:236:e9ac:3c3f with SMTP id r10-20020a5d52ca000000b00236e9ac3c3fmr22325891wrv.53.1667846167626;
        Mon, 07 Nov 2022 10:36:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003cf7928e731sm8795380wmi.9.2022.11.07.10.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:06 -0800 (PST)
Message-Id: <71c76d4ccbe577f82e820fb08fe93e5177177804.1667846164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:35 +0000
Subject: [PATCH 01/30] hashfile: allow skipping the hash function
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

The hashfile API is useful for generating files that include a trailing
hash of the file's contents up to that point. Using such a hash is
helpful for verifying the file for corruption-at-rest, such as a faulty
drive causing flipped bits.

Since the commit-graph and multi-pack-index files both use this trailing
hash, the chunk-format API uses a 'struct hashfile' to handle the I/O to
the file. This was very convenient to allow using the hashfile methods
during these operations.

However, hashing the file contents during write comes at a performance
penalty. It's slower to hash the bytes on their way to the disk than
without that step. If we wish to use the chunk-format API to upgrade
other file types, then this hashing is a performance penalty that might
not be worth the benefit of a trailing hash.

For example, if we create a chunk-format version of the packed-refs
file, then the file format could shrink by using raw object IDs instead
of hexadecimal representations in ASCII. That reduction in size is not
enough to counteract the performance penalty of hashing the file
contents. In cases such as deleting a reference that appears in the
packed-refs file, that write-time performance is critical. This is in
contrast to the commit-graph and multi-pack-index files which are mainly
updated in non-critical paths such as background maintenance.

One way to allow future chunked formats to not suffer this penalty would
be to create an abstraction layer around the 'struct hashfile' using a
vtable of function pointers. This would allow placing a different
representation in place of the hashfile. This option would be cumbersome
for a few reasons. First, the hashfile's buffered writes are already
highly optimized and would need to be duplicated in another code path.
The second is that the chunk-format API calls the chunk_write_fn
pointers using a hashfile. If we change that to an abstraction layer,
then those that _do_ use the hashfile API would need to change all of
their instances of hashwrite(), hashwrite_be32(), and others to use the
new abstraction layer.

Instead, this change opts for a simpler change. Introduce a new
'skip_hash' option to 'struct hashfile'. When set, the update_fn and
final_fn members of the_hash_algo are skipped. When finalizing the
hashfile, the trailing hash is replaced with the null hash.

This use of a trailing null hash would be desireable in either case,
since we do not want to special case a file format to have a different
length depending on whether it was hashed or not. When the final bytes
of a file are all zero, we can infer that it was written without
hashing, and thus that verification is not available as a check for file
consistency. This also means that we could easily toggle hashing for any
file format we desire. For the commit-graph and multi-pack-index file,
it may be possible to allow the null hash without incrementing the file
format version, since it technically fits the structure of the file
format. The only issue is that older versions would trigger a failure
during 'git fsck'. For these file formats, we may want to delay such a
change until it is justified.

However, the index file is written in critical paths. It is also
frequently updated, so corruption at rest is less likely to be an issue
than in those other file formats. This could be a good candidate to
create an option that skips the hashing operation.

A version of this patch has existed in the microsoft/git fork since
2017 [1] (the linked commit was rebased in 2018, but the original dates
back to January 2017). Here, the change to make the index use this fast
path is delayed until a later change.

[1] https://github.com/microsoft/git/commit/21fed2d91410f45d85279467f21d717a2db45201

Co-authored-by: Kevin Willford <kewillf@microsoft.com>
Signed-off-by: Kevin Willford <kewillf@microsoft.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 csum-file.c | 14 +++++++++++---
 csum-file.h |  7 +++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 59ef3398ca2..3243473c3d7 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -45,7 +45,8 @@ void hashflush(struct hashfile *f)
 	unsigned offset = f->offset;
 
 	if (offset) {
-		the_hash_algo->update_fn(&f->ctx, f->buffer, offset);
+		if (!f->skip_hash)
+			the_hash_algo->update_fn(&f->ctx, f->buffer, offset);
 		flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
@@ -64,7 +65,12 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	int fd;
 
 	hashflush(f);
-	the_hash_algo->final_fn(f->buffer, &f->ctx);
+
+	if (f->skip_hash)
+		memset(f->buffer, 0, the_hash_algo->rawsz);
+	else
+		the_hash_algo->final_fn(f->buffer, &f->ctx);
+
 	if (result)
 		hashcpy(result, f->buffer);
 	if (flags & CSUM_HASH_IN_STREAM)
@@ -108,7 +114,8 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 			 * the hashfile's buffer. In this block,
 			 * f->offset is necessarily zero.
 			 */
-			the_hash_algo->update_fn(&f->ctx, buf, nr);
+			if (!f->skip_hash)
+				the_hash_algo->update_fn(&f->ctx, buf, nr);
 			flush(f, buf, nr);
 		} else {
 			/*
@@ -153,6 +160,7 @@ static struct hashfile *hashfd_internal(int fd, const char *name,
 	f->tp = tp;
 	f->name = name;
 	f->do_crc = 0;
+	f->skip_hash = 0;
 	the_hash_algo->init_fn(&f->ctx);
 
 	f->buffer_len = buffer_len;
diff --git a/csum-file.h b/csum-file.h
index 0d29f528fbc..29468067f81 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -20,6 +20,13 @@ struct hashfile {
 	size_t buffer_len;
 	unsigned char *buffer;
 	unsigned char *check_buffer;
+
+	/**
+	 * If set to 1, skip_hash indicates that we should
+	 * not actually compute the hash for this hashfile and
+	 * instead only use it as a buffered write.
+	 */
+	unsigned int skip_hash;
 };
 
 /* Checkpoint */
-- 
gitgitgadget

