Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405E36F433
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621403; cv=none; b=Ftm5ah7CZHTwg2FBU3OrKT2vWPs+199hhdTYN7yNy4yf/Fcgp/bl9XtPukf3JS7crUpTIrXkn6vrW7ulSKLPWTZCt9XDawcN0CI7jEKoH3WKsB2nYKETkNHzLu1bH4Uz1JmL3/A5mvhMuygz5OUgE+oCZ9DUEcznBf76sOnnTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621403; c=relaxed/simple;
	bh=3xBvEGfRXoeS9tt+ZdX3u5BM1euqEtOC8LIr8YEQns8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TSb4PvvlGTMt6Ep3r1cKrxw5A7Zbleycj+7kn1zgaHrhtLvgasFNs1rylgLFTutF0xfFKLLmITalfWWN7n56aiONNnQcgK/Cvkkcjb7ZrJTqQZoYFVyBP0VAF1KDREER8OJ7rpfXjP+lN+dUxzWzmgkzVeUK1ep8X1EhvXryJW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1dGfP2a; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1dGfP2a"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ce9df48e1bso52543196d6.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 07:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781621401; x=1782226201; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6E+F06YfbBk+sI1tLN64rhreN+MTvEM64R7ioefDY8w=;
        b=Q1dGfP2adzmBoqQ+HiRqmwV5Lt24uevkYdRe0yakXNZdjjPUCLGF7RRr5GMI1djOZ/
         4lxFhAZrP+BSKPPaN0x53WvY2UpvKZnVHcV8oTlI9wyNIxkPnez6DbPqfLok4Xl0RH8a
         g8YB+S6u0AbWPD2nLwv/Y86a4bmEx7bz9tZs8LTwLwEEfnprQ+R4aq+S0rUGuB8aQQ7J
         q9yieztuImCHxyVMr/SWCoKOvxApKrs9Vu8oVrGtgNgmeM205AM8XSlwDEjkuiiAHieo
         08tOF+xvxT0QrpjxMOXw4E1H7L/r9lJHfaSIhHd0TzskNWG2v71kTNi9Gjiq7WyyOzo8
         7uTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781621401; x=1782226201;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6E+F06YfbBk+sI1tLN64rhreN+MTvEM64R7ioefDY8w=;
        b=GnByeoGQHOT+1JIMvrPS28/SPXGWTL1121kmyUHi9JODdFSDAIo6p5MUdkpV46xuz6
         8T1L7Tb5I79fJymhuJGFkr2WedKXmEs8c1iVlgcIM0gNELyn7qF0WJKI+Q1Hb9YLQIA/
         mENGLM/pMZdVYx047vCHBO2XCTp332FSzrFm5EXXy3w+0MdJjqGxV1Zkp/lujzLUlxJP
         6w1QEzBdOqo69emIn0AyUmwBhwhymQrctB7mYNJKT5Dym2dTdkrY9rHvtVFbuSPPDrb0
         4smFJiTUo3fUoRvuEwI5DlTpe1zKcULuYUsHL+ExqIomtepEkCyx5DC5hGURB10IAn70
         qgWQ==
X-Gm-Message-State: AOJu0Yyz11qfYviRJZuJeWMHf7SRiQKgzMEh5BMndo8xfwYjSLKpSGWG
	NUae4f6aV3o6rDbJ6JrlIWR6OpqGon0vtcUFAFS0HEG23TELO7fMYegUEj27qw==
X-Gm-Gg: Acq92OEmC7UZVST8m+kukI6QEIy+T/9hqa4AFvhdVg3tYItnwV5iZP5khv4t71lO3l3
	8Et5NK8Q2nHVtL9DhHIHpwAFqy7I8aHJU0adYOwYPsPtYkt+Nhq8Hu7XcuSlcA8fdJ7vA5SlZl0
	uCLcO8IvRFnqTsxLWc1iVgPY3MHfvVk2U1sha6vjfyRXhco2r94qWtgycIn1Pu/+XHrxXPyq7zG
	1u+VRX7d4tM1VwOiKPRpCNseYzl4SRLGic4h/ecuuUdwl7ruRdHDAFHSMDP4b71mK9X511czB97
	QzQw4ME4wmccgI6KTOMeVVjDUrUJinR4H8cgrggAZNlUmGLOd3A5Ij8dglecPtSGpL0c3okrPlB
	bANMXI8SzLMtAytCUsGVaE/pYMWfq3XRDkU9B9S8dTrQSbYtjYIicWhdahFgxXjFXs5g4pwrQHc
	63zh0Zgn70ZaTiMoziJLAz2hjBAg==
X-Received: by 2002:a05:620a:2907:b0:915:7f9e:a407 with SMTP id af79cd13be357-91d879a3ef8mr4253185a.0.1781621400614;
        Tue, 16 Jun 2026 07:50:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.77.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a03bd31sm1493052985a.34.2026.06.16.07.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:49:59 -0700 (PDT)
Message-Id: <pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Jun 2026 14:49:51 +0000
Subject: [PATCH v2 0/6] Support hashing objects larger than 4GB on Windows
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

Philip Oakley has contributed these patches ~4.5 years ago, and they have
been carried in Git for Windows ever since.

Now that there are already other patch series flying around that try to
address various aspects about >4GB objects (which aren't handled well by Git
until it stops forcing unsigned long to do size_t's job), it seems a good
time to upstream these patches, too, at long last.

Changes since v1:

 * Rebased to current master to resolve the conflicts with
   ps/odb-source-loose
 * Dropped the !LONG_IS_64BIT prereq from the added/touched tests, as it is
   now no longer needed

Philip Oakley (6):
  hash-object: demonstrate a >4GB/LLP64 problem
  object-file.c: use size_t for header lengths
  hash algorithms: use size_t for section lengths
  hash-object --stdin: verify that it works with >4GB/LLP64
  hash-object: add another >4GB/LLP64 test case
  hash-object: add a >4GB/LLP64 test case using filtered input

 object-file.c          | 14 +++++++-------
 object-file.h          |  6 +++---
 odb/source-files.c     |  2 +-
 odb/source-inmemory.c  |  2 +-
 odb/source-loose.c     |  4 ++--
 odb/source.h           |  2 +-
 sha1dc_git.c           |  3 +--
 sha1dc_git.h           |  2 +-
 t/t1007-hash-object.sh | 39 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 56 insertions(+), 18 deletions(-)


base-commit: 700432b2ba22603a0bcb71475c9c333d17c9b0d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2138%2Fdscho%2FPhilipOakley%2Fhashliteral_t-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2138/dscho/PhilipOakley/hashliteral_t-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2138

Range-diff vs v1:

 1:  84e1cd0aa0 = 1:  9c01bac407 hash-object: demonstrate a >4GB/LLP64 problem
 2:  809d83e46f ! 2:  aa5859c14f object-file.c: use size_t for header lengths
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## object-file.c ##
     -@@ object-file.c: int odb_source_loose_read_object_info(struct odb_source *source,
     +@@ object-file.c: int parse_loose_header(const char *hdr, struct object_info *oi)
       static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
       			     const void *buf, unsigned long len,
       			     struct object_id *oid,
     @@ object-file.c: int odb_source_loose_read_object_info(struct odb_source *source,
      @@ object-file.c: static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_c
       }
       
     - static void write_object_file_prepare(const struct git_hash_algo *algo,
     --				      const void *buf, unsigned long len,
     -+				      const void *buf, size_t len,
     - 				      enum object_type type, struct object_id *oid,
     --				      char *hdr, int *hdrlen)
     -+				      char *hdr, size_t *hdrlen)
     + void write_object_file_prepare(const struct git_hash_algo *algo,
     +-			       const void *buf, unsigned long len,
     ++			       const void *buf, size_t len,
     + 			       enum object_type type, struct object_id *oid,
     +-			       char *hdr, int *hdrlen)
     ++			       char *hdr, size_t *hdrlen)
       {
       	struct git_hash_ctx c;
       
     @@ object-file.c: out:
       
       	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
       }
     -@@ object-file.c: cleanup:
     +
     + ## object-file.h ##
     +@@ object-file.h: int finalize_object_file_flags(struct repository *repo,
     + 			       enum finalize_object_file_flags flags);
     + 
     + void hash_object_file(const struct git_hash_algo *algo, const void *buf,
     +-		      unsigned long len, enum object_type type,
     ++		      size_t len, enum object_type type,
     + 		      struct object_id *oid);
     + void write_object_file_prepare(const struct git_hash_algo *algo,
     +-			       const void *buf, unsigned long len,
     ++			       const void *buf, size_t len,
     + 			       enum object_type type, struct object_id *oid,
     +-			       char *hdr, int *hdrlen);
     ++			       char *hdr, size_t *hdrlen);
     + int write_loose_object(struct odb_source_loose *loose,
     + 		       const struct object_id *oid, char *hdr,
     + 		       int hdrlen, const void *buf, unsigned long len,
     +
     + ## odb/source-files.c ##
     +@@ odb/source-files.c: static int odb_source_files_freshen_object(struct odb_source *source,
     + }
     + 
     + static int odb_source_files_write_object(struct odb_source *source,
     +-					 const void *buf, unsigned long len,
     ++					 const void *buf, size_t len,
     + 					 enum object_type type,
     + 					 struct object_id *oid,
     + 					 struct object_id *compat_oid,
     +
     + ## odb/source-inmemory.c ##
     +@@ odb/source-inmemory.c: static int odb_source_inmemory_count_objects(struct odb_source *source,
       }
       
     - int odb_source_loose_write_object(struct odb_source *source,
     --				  const void *buf, unsigned long len,
     -+				  const void *buf, size_t len,
     - 				  enum object_type type, struct object_id *oid,
     - 				  struct object_id *compat_oid_in,
     - 				  enum odb_write_object_flags flags)
     -@@ object-file.c: int odb_source_loose_write_object(struct odb_source *source,
     + static int odb_source_inmemory_write_object(struct odb_source *source,
     +-					    const void *buf, unsigned long len,
     ++					    const void *buf, size_t len,
     + 					    enum object_type type,
     + 					    struct object_id *oid,
     + 					    struct object_id *compat_oid UNUSED,
     +
     + ## odb/source-loose.c ##
     +@@ odb/source-loose.c: static int odb_source_loose_freshen_object(struct odb_source *source,
     + }
     + 
     + static int odb_source_loose_write_object(struct odb_source *source,
     +-					 const void *buf, unsigned long len,
     ++					 const void *buf, size_t len,
     + 					 enum object_type type, struct object_id *oid,
     + 					 struct object_id *compat_oid_in,
     + 					 enum odb_write_object_flags flags)
     +@@ odb/source-loose.c: static int odb_source_loose_write_object(struct odb_source *source,
       	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
       	struct object_id compat_oid;
       	char hdr[MAX_HEADER_LEN];
     @@ object-file.c: int odb_source_loose_write_object(struct odb_source *source,
       	/* Generate compat_oid */
       	if (compat) {
      
     - ## object-file.h ##
     -@@ object-file.h: int odb_source_loose_freshen_object(struct odb_source *source,
     - 				    const struct object_id *oid);
     - 
     - int odb_source_loose_write_object(struct odb_source *source,
     --				  const void *buf, unsigned long len,
     -+				  const void *buf, size_t len,
     - 				  enum object_type type, struct object_id *oid,
     - 				  struct object_id *compat_oid_in,
     - 				  enum odb_write_object_flags flags);
     -@@ object-file.h: int finalize_object_file_flags(struct repository *repo,
     - 			       enum finalize_object_file_flags flags);
     - 
     - void hash_object_file(const struct git_hash_algo *algo, const void *buf,
     --		      unsigned long len, enum object_type type,
     -+		      size_t len, enum object_type type,
     - 		      struct object_id *oid);
     - 
     - /* Helper to check and "touch" a file */
     + ## odb/source.h ##
     +@@ odb/source.h: struct odb_source {
     + 	 * return 0 on success, a negative error code otherwise.
     + 	 */
     + 	int (*write_object)(struct odb_source *source,
     +-			    const void *buf, unsigned long len,
     ++			    const void *buf, size_t len,
     + 			    enum object_type type,
     + 			    struct object_id *oid,
     + 			    struct object_id *compat_oid,
 3:  253d6f8004 ! 3:  b401eb490f hash algorithms: use size_t for section lengths
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## object-file.c ##
     -@@ object-file.c: int odb_source_loose_read_object_info(struct odb_source *source,
     +@@ object-file.c: int parse_loose_header(const char *hdr, struct object_info *oi)
       }
       
       static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
     @@ object-file.c: int odb_source_loose_read_object_info(struct odb_source *source,
       			     struct object_id *oid,
       			     char *hdr, size_t *hdrlen)
       {
     -@@ object-file.c: static void write_object_file_prepare(const struct git_hash_algo *algo,
     +@@ object-file.c: void write_object_file_prepare(const struct git_hash_algo *algo,
       	/* Generate the header */
       	*hdrlen = format_object_header(hdr, *hdrlen, type, len);
       
     @@ t/t1007-hash-object.sh: test_expect_success '--stdin outside of repository (uses
       '
       
      -test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
     -+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
     ++test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
       		'files over 4GB hash literally' '
       	test-tool genzeros $((5*1024*1024*1024)) >big &&
       	test_oid large5GB >expect &&
 4:  ba629a3f03 ! 4:  411727336a hash-object --stdin: verify that it works with >4GB/LLP64
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t1007-hash-object.sh ##
     -@@ t/t1007-hash-object.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
     +@@ t/t1007-hash-object.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
       	test_cmp expect actual
       '
       
     -+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
     ++test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
      +		'files over 4GB hash correctly via --stdin' '
      +	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
      +	test_oid large5GB >expect &&
 5:  f48d570bba ! 5:  e6bb4e6228 hash-object: add another >4GB/LLP64 test case
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t1007-hash-object.sh ##
     -@@ t/t1007-hash-object.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
     +@@ t/t1007-hash-object.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
       	test_cmp expect actual
       '
       
     -+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
     ++test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
      +		'files over 4GB hash correctly' '
      +	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
      +	test_oid large5GB >expect &&
 6:  8a6beeb16d ! 6:  568807ac34 hash-object: add a >4GB/LLP64 test case using filtered input
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t1007-hash-object.sh ##
     -@@ t/t1007-hash-object.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
     +@@ t/t1007-hash-object.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
       	test_cmp expect actual
       '
       
      +# This clean filter does nothing, other than excercising the interface.
      +# We ensure that cleaning doesn't mangle large files on 64-bit Windows.
     -+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
     ++test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
      +		'hash filtered files over 4GB correctly' '
      +	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
      +	test_oid large5GB >expect &&

-- 
gitgitgadget
