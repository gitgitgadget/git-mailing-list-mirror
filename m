Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE524C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE32061139
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbhJGU1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbhJGU1N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:27:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9A3C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 13:25:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r18so22794894wrg.6
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 13:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=lRt0YDtEucEdxdnGC+DTgxGWN3EcjeuHExE4vzJtCt0=;
        b=n/vDrwph7qM/Z7rtl4wg2LL7EjKFbbWT/13B/aEEmQQQztXbZ7M4/Cx1NIlb6k8ZWz
         tEnyRGWsobsTKBvu5fDRQWj+b+HgHld7QH3w9FMCG/TknuJ96Jhwf3LnMjDZZ/8mwzN8
         tnWQlJjKn0Yt+LSwcgU5PPatTcSDDUnVgSEhWC9sYgfjC5tp/ualJPikwv+zOrmrFjGa
         WutXnO2X8QBnt9456YWcG7WT3mgwdvCHR5fmIV66jaDrG4F7NOV4dJkkdfLMRWMzxq5Z
         O03fUxeq1cVso8DhlGsE/zqkL9BWtepI1CC8ucXNTYR82M3dDDxO3MwUMIYSmxeKZtrg
         1PMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=lRt0YDtEucEdxdnGC+DTgxGWN3EcjeuHExE4vzJtCt0=;
        b=NU14mh63y4LryIRjldtpOP+b7jsYCntTQCPaeszkSqOcfStyLBhaBau3+VJ8dmIncb
         xUxidS2HLa6/JPxRJEHPtsCVQOzQPpCdRP7k+E5HjdSdcS0+/hswEbnqmHPIFgbMp7r8
         Gw/LqDaFhojX8f0QrFSSfONCuMPDAwljty2z2a0jl74wCtQQoJWFxNKJ7D0QvNnQyi6t
         VHoJChXWa8mF4W5J7W4NNWrMisCMXR12J095dseublbIBX0G07tUMPO2SDg5n/n4mIiF
         wBNQCpjWImIaKWrLhYsb9HU8CnznB3WcokYQ2/zVO/JqhsL0Oj7mLvyO1pY5KmLgwYGP
         K3xQ==
X-Gm-Message-State: AOAM5315SReXq7U6NiMtra8Ny6QdLagvUDYDxOiS36C5uwsiQR6+MT7q
        MtyO/1Mgf9iOS6UwLv4IcvkQCIAhyec=
X-Google-Smtp-Source: ABdhPJwY5JNQX3pM6kyOSQcmN16jGSRMTAeM0qNGMF4WgBBhKcq2ev6lnfO5h/uGDUC+uzbHucJlPA==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr19064429wmc.86.1633638317723;
        Thu, 07 Oct 2021 13:25:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l21sm377275wmh.31.2021.10.07.13.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:25:17 -0700 (PDT)
Message-Id: <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 20:24:56 +0000
Subject: [PATCH v4 00/19] Adds reftable library code from https://github.com/hanwen/reftable.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reftable format is described in Documentation/technical/reftable.txt.

This is a fully reentrant implementation of reading and writing the reftable
file format, and should be suitable for embedding in libgit2 too. It does
not hook the code up to git to function as a ref storage backend yet.

v4:

 * fixes by Carlo Belón.
 * remove RFC from LICENSE commit.

Han-Wen Nienhuys (19):
  hash.h: provide constants for the hash IDs
  reftable: add LICENSE
  reftable: add error related functionality
  reftable: utility functions
  reftable: add blocksource, an abstraction for random access reads
  reftable: (de)serialization for the polymorphic record type.
  Provide zlib's uncompress2 from compat/zlib-compat.c
  reftable: reading/writing blocks
  reftable: a generic binary tree implementation
  reftable: write reftable files
  reftable: generic interface to tables
  reftable: read reftable files
  reftable: reftable file level tests
  reftable: add a heap-based priority queue for reftable records
  reftable: add merged table view
  reftable: implement refname validation
  reftable: implement stack, a mutable database of reftable files.
  reftable: add dump utility
  Add "test-tool dump-reftable" command.

 Makefile                                   |   53 +-
 ci/lib.sh                                  |    1 +
 compat/.gitattributes                      |    1 +
 compat/zlib-uncompress2.c                  |   95 ++
 config.mak.uname                           |    5 +
 configure.ac                               |   13 +
 contrib/buildsystems/CMakeLists.txt        |   14 +-
 contrib/buildsystems/Generators/Vcxproj.pm |   11 +-
 hash.h                                     |    6 +
 object-file.c                              |    7 +-
 reftable/LICENSE                           |   31 +
 reftable/basics.c                          |  128 ++
 reftable/basics.h                          |   60 +
 reftable/basics_test.c                     |   98 ++
 reftable/block.c                           |  437 ++++++
 reftable/block.h                           |  127 ++
 reftable/block_test.c                      |  120 ++
 reftable/blocksource.c                     |  148 +++
 reftable/blocksource.h                     |   22 +
 reftable/constants.h                       |   21 +
 reftable/dump.c                            |  107 ++
 reftable/error.c                           |   41 +
 reftable/generic.c                         |  169 +++
 reftable/generic.h                         |   32 +
 reftable/iter.c                            |  194 +++
 reftable/iter.h                            |   69 +
 reftable/merged.c                          |  362 +++++
 reftable/merged.h                          |   38 +
 reftable/merged_test.c                     |  468 +++++++
 reftable/pq.c                              |  105 ++
 reftable/pq.h                              |   33 +
 reftable/pq_test.c                         |   82 ++
 reftable/publicbasics.c                    |   65 +
 reftable/reader.c                          |  801 +++++++++++
 reftable/reader.h                          |   64 +
 reftable/readwrite_test.c                  |  652 +++++++++
 reftable/record.c                          | 1212 +++++++++++++++++
 reftable/record.h                          |  139 ++
 reftable/record_test.c                     |  412 ++++++
 reftable/refname.c                         |  209 +++
 reftable/refname.h                         |   29 +
 reftable/refname_test.c                    |  102 ++
 reftable/reftable-blocksource.h            |   49 +
 reftable/reftable-error.h                  |   62 +
 reftable/reftable-generic.h                |   47 +
 reftable/reftable-iterator.h               |   39 +
 reftable/reftable-malloc.h                 |   18 +
 reftable/reftable-merged.h                 |   72 +
 reftable/reftable-reader.h                 |  101 ++
 reftable/reftable-record.h                 |  114 ++
 reftable/reftable-stack.h                  |  128 ++
 reftable/reftable-tests.h                  |   23 +
 reftable/reftable-writer.h                 |  148 +++
 reftable/reftable.c                        |  115 ++
 reftable/stack.c                           | 1396 ++++++++++++++++++++
 reftable/stack.h                           |   41 +
 reftable/stack_test.c                      |  953 +++++++++++++
 reftable/system.h                          |   32 +
 reftable/test_framework.c                  |   23 +
 reftable/test_framework.h                  |   53 +
 reftable/tree.c                            |   63 +
 reftable/tree.h                            |   34 +
 reftable/tree_test.c                       |   61 +
 reftable/writer.c                          |  690 ++++++++++
 reftable/writer.h                          |   50 +
 t/helper/test-reftable.c                   |   21 +
 t/helper/test-tool.c                       |    4 +-
 t/helper/test-tool.h                       |    2 +
 t/t0032-reftable-unittest.sh               |   15 +
 69 files changed, 11125 insertions(+), 12 deletions(-)
 create mode 100644 compat/.gitattributes
 create mode 100644 compat/zlib-uncompress2.c
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/basics_test.c
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c
 create mode 100644 reftable/blocksource.c
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/error.c
 create mode 100644 reftable/generic.c
 create mode 100644 reftable/generic.h
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/pq_test.c
 create mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/readwrite_test.c
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/record_test.c
 create mode 100644 reftable/refname.c
 create mode 100644 reftable/refname.h
 create mode 100644 reftable/refname_test.c
 create mode 100644 reftable/reftable-blocksource.h
 create mode 100644 reftable/reftable-error.h
 create mode 100644 reftable/reftable-generic.h
 create mode 100644 reftable/reftable-iterator.h
 create mode 100644 reftable/reftable-malloc.h
 create mode 100644 reftable/reftable-merged.h
 create mode 100644 reftable/reftable-reader.h
 create mode 100644 reftable/reftable-record.h
 create mode 100644 reftable/reftable-stack.h
 create mode 100644 reftable/reftable-tests.h
 create mode 100644 reftable/reftable-writer.h
 create mode 100644 reftable/reftable.c
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/stack_test.c
 create mode 100644 reftable/system.h
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/tree_test.c
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 t/helper/test-reftable.c
 create mode 100755 t/t0032-reftable-unittest.sh


base-commit: 106298f7f9cca4158a980de149ef217751e1f943
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1081%2Fhanwen%2Fjust-library-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1081/hanwen/just-library-v4
Pull-Request: https://github.com/git/git/pull/1081

Range-diff vs v3:

  1:  b2f8dc32bfc =  1:  9cc44f78377 hash.h: provide constants for the hash IDs
  2:  2597ddfeae1 !  2:  6a5ee5db472 reftable: RFC: add LICENSE
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    reftable: RFC: add LICENSE
     +    reftable: add LICENSE
      
          The objective of this code is to be usable as a C library, so it can be reused
          in libgit2.
  3:  41b1ff1293f !  3:  bf51bc9ab0c reftable: add error related functionality
     @@ Commit message
          reftable: add error related functionality
      
          The reftable/ directory is structured as a library, so it cannot
     -    crash on misuse. Instead, it returns an error codes.
     +    crash on misuse. Instead, it returns an error code.
      
     -    In addition, the error code can be used to signal conditions from lower levels
     -    of the library to be handled by higher levels of the library. For example, a
     -    transaction might legitimately write an empty reftable file, but in that case,
     -    we'd want to shortcut the transaction overhead.
     +    In addition to signaling errors, the error code can be used to signal
     +    conditions from lower levels of the library to be handled by higher
     +    levels of the library. For example, in a transaction we might
     +    legitimately write an empty reftable file, but in that case, we want to
     +    shortcut the transaction.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
  4:  c03043c5e63 !  4:  318e7ad41e5 reftable: utility functions
     @@ reftable/publicbasics.c (new)
      +#include "basics.h"
      +#include "system.h"
      +
     -+static void *(*reftable_malloc_ptr)(size_t sz) = &malloc;
     -+static void *(*reftable_realloc_ptr)(void *, size_t) = &realloc;
     -+static void (*reftable_free_ptr)(void *) = &free;
     ++static void *(*reftable_malloc_ptr)(size_t sz);
     ++static void *(*reftable_realloc_ptr)(void *, size_t);
     ++static void (*reftable_free_ptr)(void *);
      +
      +void *reftable_malloc(size_t sz)
      +{
     -+	return (*reftable_malloc_ptr)(sz);
     ++	if (reftable_malloc_ptr)
     ++		return (*reftable_malloc_ptr)(sz);
     ++	return malloc(sz);
      +}
      +
      +void *reftable_realloc(void *p, size_t sz)
      +{
     -+	return (*reftable_realloc_ptr)(p, sz);
     ++	if (reftable_realloc_ptr)
     ++		return (*reftable_realloc_ptr)(p, sz);
     ++	return realloc(p, sz);
      +}
      +
      +void reftable_free(void *p)
      +{
     -+	reftable_free_ptr(p);
     ++	if (reftable_free_ptr)
     ++		reftable_free_ptr(p);
     ++	else
     ++		free(p);
      +}
      +
      +void *reftable_calloc(size_t sz)
  5:  317a6aaa357 =  5:  80036f93e2e reftable: add blocksource, an abstraction for random access reads
  6:  55e66b7a74f =  6:  f2cd2876265 reftable: (de)serialization for the polymorphic record type.
  7:  4f6ecd3646a !  7:  6cbc2f758df Provide zlib's uncompress2 from compat/zlib-compat.c
     @@ config.mak.uname: ifeq ($(uname_S),FreeBSD)
       	NO_STRCASESTR = YesPlease
       	NO_MEMMEM = YesPlease
       	USE_ST_TIMESPEC = YesPlease
     +@@ config.mak.uname: ifeq ($(uname_S),Interix)
     + 	endif
     + endif
     + ifeq ($(uname_S),Minix)
     ++	NO_UNCOMPRESS2 = YesPlease
     + 	NO_IPV6 = YesPlease
     + 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
     + 	NO_NSEC = YesPlease
      
       ## configure.ac ##
      @@ configure.ac: AC_LINK_IFELSE([ZLIBTEST_SRC],
  8:  04f2d74df51 !  8:  1002d6f526c reftable: reading/writing blocks
     @@ Commit message
      
          This commit provides the logic to read and write these blocks.
      
     +    Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     @@ reftable/block.c (new)
      +
      +int block_writer_finish(struct block_writer *w)
      +{
     -+	int i = 0;
     ++	int i;
      +	for (i = 0; i < w->restart_len; i++) {
      +		put_be24(w->buf + w->next, w->restarts[i]);
      +		w->next += 3;
     @@ reftable/block.c (new)
      +
      +	if (block_writer_type(w) == BLOCK_TYPE_LOG) {
      +		int block_header_skip = 4 + w->header_off;
     -+		uint8_t *compressed = NULL;
     -+		int zresult = 0;
      +		uLongf src_len = w->next - block_header_skip;
     -+		size_t dest_cap = src_len;
     ++		uLongf dest_cap = src_len * 1.001 + 12;
      +
     -+		compressed = reftable_malloc(dest_cap);
     ++		uint8_t *compressed = reftable_malloc(dest_cap);
      +		while (1) {
      +			uLongf out_dest_len = dest_cap;
     -+
     -+			zresult = compress2(compressed, &out_dest_len,
     -+					    w->buf + block_header_skip, src_len,
     -+					    9);
     -+			if (zresult == Z_BUF_ERROR) {
     ++			int zresult = compress2(compressed, &out_dest_len,
     ++						w->buf + block_header_skip,
     ++						src_len, 9);
     ++			if (zresult == Z_BUF_ERROR && dest_cap < LONG_MAX) {
      +				dest_cap *= 2;
      +				compressed =
      +					reftable_realloc(compressed, dest_cap);
     -+				continue;
     ++				if (compressed)
     ++					continue;
      +			}
      +
      +			if (Z_OK != zresult) {
  9:  f6c2da61208 =  9:  96e490ac32c reftable: a generic binary tree implementation
 10:  277a1f662e3 = 10:  daf9cc897d1 reftable: write reftable files
 11:  f97182dec1f = 11:  c9a5813b211 reftable: generic interface to tables
 12:  13de5d03a71 ! 12:  854b30268b6 reftable: read reftable files
     @@ reftable/reader.c (new)
      +	return 0;
      +}
      +
     -+int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
     -+		struct reftable_record *rec)
     ++static int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
     ++		       struct reftable_record *rec)
      +{
      +	uint8_t typ = reftable_record_type(rec);
      +
     @@ reftable/reader.h (new)
      +
      +int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
      +		const char *name);
     -+int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
     -+		struct reftable_record *rec);
      +void reader_close(struct reftable_reader *r);
      +const char *reader_name(struct reftable_reader *r);
      +
 13:  8efc3c2b6ab = 13:  c0d0427d52c reftable: reftable file level tests
 14:  e89b16a37e6 ! 14:  6e5ee043083 reftable: add a heap-based priority queue for reftable records
     @@ reftable/pq_test.c (new)
      +
      +void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
      +{
     -+	int i = 0;
     ++	int i;
      +	for (i = 1; i < pq.len; i++) {
      +		int parent = (i - 1) / 2;
      +
     -+		assert(pq_less(&pq.heap[parent], &pq.heap[i]));
     ++		EXPECT(pq_less(&pq.heap[parent], &pq.heap[i]));
      +	}
      +}
      +
 15:  40a91b14be8 ! 15:  0b86f6c2327 reftable: add merged table view
     @@ reftable/merged.h (new)
      +	struct reftable_table *stack;
      +	size_t stack_len;
      +	uint32_t hash_id;
     ++
     ++	/* If unset, produce deletions. This is useful for compaction. For the
     ++	 * full stack, deletions should be produced. */
      +	int suppress_deletions;
      +
      +	uint64_t min;
     @@ reftable/merged_test.c (new)
      +	reftable_writer_free(w);
      +}
      +
     ++static void write_test_log_table(struct strbuf *buf,
     ++				 struct reftable_log_record logs[], int n,
     ++				 uint64_t update_index)
     ++{
     ++	int i = 0;
     ++	int err;
     ++
     ++	struct reftable_write_options opts = {
     ++		.block_size = 256,
     ++		.exact_log_message = 1,
     ++	};
     ++	struct reftable_writer *w = NULL;
     ++	w = reftable_new_writer(&strbuf_add_void, buf, &opts);
     ++	reftable_writer_set_limits(w, update_index, update_index);
     ++
     ++	for (i = 0; i < n; i++) {
     ++		int err = reftable_writer_add_log(w, &logs[i]);
     ++		EXPECT_ERR(err);
     ++	}
     ++
     ++	err = reftable_writer_close(w);
     ++	EXPECT_ERR(err);
     ++
     ++	reftable_writer_free(w);
     ++}
     ++
      +static struct reftable_merged_table *
      +merged_table_from_records(struct reftable_ref_record **refs,
      +			  struct reftable_block_source **source,
     @@ reftable/merged_test.c (new)
      +	int i = 0;
      +
      +	EXPECT_ERR(err);
     ++	EXPECT(reftable_merged_table_hash_id(mt) == GIT_SHA1_FORMAT_ID);
     ++	EXPECT(reftable_merged_table_min_update_index(mt) == 1);
     ++
      +	while (len < 100) { /* cap loops/recursion. */
      +		struct reftable_ref_record ref = { NULL };
      +		int err = reftable_iterator_next_ref(&it, &ref);
     @@ reftable/merged_test.c (new)
      +	reftable_free(bs);
      +}
      +
     ++static struct reftable_merged_table *
     ++merged_table_from_log_records(struct reftable_log_record **logs,
     ++			      struct reftable_block_source **source,
     ++			      struct reftable_reader ***readers, int *sizes,
     ++			      struct strbuf *buf, int n)
     ++{
     ++	int i = 0;
     ++	struct reftable_merged_table *mt = NULL;
     ++	int err;
     ++	struct reftable_table *tabs =
     ++		reftable_calloc(n * sizeof(struct reftable_table));
     ++	*readers = reftable_calloc(n * sizeof(struct reftable_reader *));
     ++	*source = reftable_calloc(n * sizeof(**source));
     ++	for (i = 0; i < n; i++) {
     ++		write_test_log_table(&buf[i], logs[i], sizes[i], i + 1);
     ++		block_source_from_strbuf(&(*source)[i], &buf[i]);
     ++
     ++		err = reftable_new_reader(&(*readers)[i], &(*source)[i],
     ++					  "name");
     ++		EXPECT_ERR(err);
     ++		reftable_table_from_reader(&tabs[i], (*readers)[i]);
     ++	}
     ++
     ++	err = reftable_new_merged_table(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
     ++	EXPECT_ERR(err);
     ++	return mt;
     ++}
     ++
     ++static void test_merged_logs(void)
     ++{
     ++	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1 };
     ++	uint8_t hash2[GIT_SHA1_RAWSZ] = { 2 };
     ++	uint8_t hash3[GIT_SHA1_RAWSZ] = { 3 };
     ++	struct reftable_log_record r1[] = {
     ++		{
     ++			.refname = "a",
     ++			.update_index = 2,
     ++			.value_type = REFTABLE_LOG_UPDATE,
     ++			.value.update = {
     ++				.old_hash = hash2,
     ++				/* deletion */
     ++				.name = "jane doe",
     ++				.email = "jane@invalid",
     ++				.message = "message2",
     ++			}
     ++		},
     ++		{
     ++			.refname = "a",
     ++			.update_index = 1,
     ++			.value_type = REFTABLE_LOG_UPDATE,
     ++			.value.update = {
     ++				.old_hash = hash1,
     ++				.new_hash = hash2,
     ++				.name = "jane doe",
     ++				.email = "jane@invalid",
     ++				.message = "message1",
     ++			}
     ++		},
     ++	};
     ++	struct reftable_log_record r2[] = {
     ++		{
     ++			.refname = "a",
     ++			.update_index = 3,
     ++			.value_type = REFTABLE_LOG_UPDATE,
     ++			.value.update = {
     ++				.new_hash = hash3,
     ++				.name = "jane doe",
     ++				.email = "jane@invalid",
     ++				.message = "message3",
     ++			}
     ++		},
     ++	};
     ++	struct reftable_log_record r3[] = {
     ++		{
     ++			.refname = "a",
     ++			.update_index = 2,
     ++			.value_type = REFTABLE_LOG_DELETION,
     ++		},
     ++	};
     ++	struct reftable_log_record want[] = {
     ++		r2[0],
     ++		r3[0],
     ++		r1[1],
     ++	};
     ++
     ++	struct reftable_log_record *logs[] = { r1, r2, r3 };
     ++	int sizes[3] = { 2, 1, 1 };
     ++	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
     ++	struct reftable_block_source *bs = NULL;
     ++	struct reftable_reader **readers = NULL;
     ++	struct reftable_merged_table *mt = merged_table_from_log_records(
     ++		logs, &bs, &readers, sizes, bufs, 3);
     ++
     ++	struct reftable_iterator it = { NULL };
     ++	int err = reftable_merged_table_seek_log(mt, &it, "a");
     ++	struct reftable_log_record *out = NULL;
     ++	size_t len = 0;
     ++	size_t cap = 0;
     ++	int i = 0;
     ++
     ++	EXPECT_ERR(err);
     ++	EXPECT(reftable_merged_table_hash_id(mt) == GIT_SHA1_FORMAT_ID);
     ++	EXPECT(reftable_merged_table_min_update_index(mt) == 1);
     ++
     ++	while (len < 100) { /* cap loops/recursion. */
     ++		struct reftable_log_record log = { NULL };
     ++		int err = reftable_iterator_next_log(&it, &log);
     ++		if (err > 0) {
     ++			break;
     ++		}
     ++		if (len == cap) {
     ++			cap = 2 * cap + 1;
     ++			out = reftable_realloc(
     ++				out, sizeof(struct reftable_log_record) * cap);
     ++		}
     ++		out[len++] = log;
     ++	}
     ++	reftable_iterator_destroy(&it);
     ++
     ++	EXPECT(ARRAY_SIZE(want) == len);
     ++	for (i = 0; i < len; i++) {
     ++		EXPECT(reftable_log_record_equal(&want[i], &out[i],
     ++						 GIT_SHA1_RAWSZ));
     ++	}
     ++
     ++	err = reftable_merged_table_seek_log_at(mt, &it, "a", 2);
     ++	EXPECT_ERR(err);
     ++	reftable_log_record_release(&out[0]);
     ++	err = reftable_iterator_next_log(&it, &out[0]);
     ++	EXPECT_ERR(err);
     ++	EXPECT(reftable_log_record_equal(&out[0], &r3[0], GIT_SHA1_RAWSZ));
     ++	reftable_iterator_destroy(&it);
     ++
     ++	for (i = 0; i < len; i++) {
     ++		reftable_log_record_release(&out[i]);
     ++	}
     ++	reftable_free(out);
     ++
     ++	for (i = 0; i < 3; i++) {
     ++		strbuf_release(&bufs[i]);
     ++	}
     ++	readers_destroy(readers, 3);
     ++	reftable_merged_table_free(mt);
     ++	reftable_free(bs);
     ++}
     ++
      +static void test_default_write_opts(void)
      +{
      +	struct reftable_write_options opts = { 0 };
     @@ reftable/merged_test.c (new)
      +
      +int merged_test_main(int argc, const char *argv[])
      +{
     ++	RUN_TEST(test_merged_logs);
      +	RUN_TEST(test_merged_between);
      +	RUN_TEST(test_merged);
      +	RUN_TEST(test_default_write_opts);
 16:  46c2ddf07cf = 16:  c600e1f975c reftable: implement refname validation
 17:  3db887bc078 ! 17:  55dacc6760f reftable: implement stack, a mutable database of reftable files.
     @@ reftable/stack_test.c (new)
      +	return len;
      +}
      +
     -+// Work linenumber into the tempdir, so we can see which tests forget to
     -+// cleanup.
     ++/*
     ++ * Work linenumber into the tempdir, so we can see which tests forget to
     ++ * cleanup.
     ++ */
      +static char *get_tmp_template(int linenumber)
      +{
      +	const char *tmp = getenv("TMPDIR");
     @@ reftable/stack_test.c (new)
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
      +
     ++	st->disable_auto_compact = 1; /* call manually below for coverage. */
      +	for (i = 0; i < N; i++) {
      +		char name[100];
      +		struct reftable_ref_record ref = {
     @@ reftable/stack_test.c (new)
      +		err = reftable_stack_add(st, &write_test_ref, &ref);
      +		EXPECT_ERR(err);
      +
     ++		err = reftable_stack_auto_compact(st);
      +		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
      +	}
      +
     @@ reftable/stack_test.c (new)
      +
      +static void unclean_stack_close(struct reftable_stack *st)
      +{
     -+	// break abstraction boundary to simulate unclean shutdown.
     ++	/* break abstraction boundary to simulate unclean shutdown. */
      +	int i = 0;
      +	for (; i < st->readers_len; i++) {
      +		reftable_reader_free(st->readers[i]);
 18:  795a15000fb = 18:  2f825cdb2d4 reftable: add dump utility
 19:  7b3215aef39 = 19:  c8428cb0df8 Add "test-tool dump-reftable" command.

-- 
gitgitgadget
