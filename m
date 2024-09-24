Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B41823D7
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159518; cv=none; b=MJuNn1mz6b1L9geDKglpFRQKLKnqZ+/+behbJjhaQ9H35ivT223OGW6NVtyiF89jEvgVGZwZQ55ZHxRsBwYCsLbV5TpZf2C2i7Hur6ztkB2hYSE0vSDMxsHIvARbbncLx6Ccpi6z9/mRklYxbbG8R1hPMJt3aP6mQtow3D3CyQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159518; c=relaxed/simple;
	bh=aaDMb6g5o5TglT4Vs8DzJOkFMV69g6xW3ns+v1Hp5+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBV3o1AoZUR+V+0fLdiBES27ooNlehu/K/0QpT8ebwJHHaDuKsrA/zZG1tQBxh2DiB3Hvr0Rh+Q/gmfWJY/Jj1BeKLdTNYvBCt8ZbI0GaJtNinRLQoh0iZexpq8hnadAOmIDr8PztEEZUUqtOR7cK4v3eWeFcLjEH2L7rE7ae2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GpiYEkdr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nv63pO0+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GpiYEkdr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nv63pO0+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 82A7913802E6;
	Tue, 24 Sep 2024 02:31:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 24 Sep 2024 02:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159515; x=1727245915; bh=fQq6mkzbcW
	xBoTl4pB9Ywl4/GE5jtkddJtwy321EBRw=; b=GpiYEkdr9gmlfKp8MwWnRuQWbj
	fQzXwQ+xFLbjUG266nXEGAW5qa5IPYaRGm7pSs62ffIiipSeMYNR2tV8cn3Wsdhs
	W4mm115+rIwtiRhJiLq+TZqkIAR9LwdUGGosXr3nlo7oJbgXa/yM9htuFvBGe8h+
	/Q/u3e1CUylEvwmzQgMVEFv/ACzjO7pqELCgWs9CaGaolEwF42G8VRgUvDoDgokP
	u8l8d9ueSoqD0l5tVj/aw+mG5UkEQTtfj3aDa4eAin5Nv0J7QG9uNSRZEoJCjdeN
	86ZJl2RV77HRjbFnjKFxYK4l4CEVKFasH4nQf/Cq8B1uxzfwseq5HgtfFezg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159515; x=1727245915; bh=fQq6mkzbcWxBoTl4pB9Ywl4/GE5j
	tkddJtwy321EBRw=; b=Nv63pO0+hvwu7RXDDgeh3cG3X20kdMTdAa0Dvz6SE0FW
	AQCu4WY01bPCaFIwVDwTiBBPsEGoR/Mexncw6dPoE5gz1gkrgmbhmylllYFPwNfl
	HeM1miQa7ID4WzkNSxYMp9fJ4X97i6YkqhJ4ADOK3XTjjyhxjgR1FmkaK/4Jqfqu
	StfKNCxpGpL4VtIJK3IhjLpl6zc483HzYYi1rVVQfbYmYGR5uQVyDCA+L3U5faEN
	eLMHLCbRd8mq9FFAUriyj1amyNhNJOhlh5uCRgWvPDM8lCV0IP+/aEUNT9X7rz5M
	hf4HKxX1p2LmxfsaGjyL6q7CL9gyipQK3nWvzgRR9A==
X-ME-Sender: <xms:21zyZvrQAgj8CrlxF61nU3c2YrbIUdTWH_v2MmUJEaBaGD4SOedv0Q>
    <xme:21zyZpqyYatFy3ai7Y0R-mUUmQCk3D9_-3h-nndlB9ZNru9NcHzm2-eLGhE41r_6E
    VibcK7HJBCUmVoXVw>
X-ME-Received: <xmr:21zyZsO_Z-hxFXnLnQDjL_16t094rih6t-CMcJknYNZE_pz3OZyTMYmXl7Ty2TtPjWwRGA8RsR6DstahPJb4RPvJ3bg595I8xl0Z9WgedOTOaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:21zyZi5EHVGCKEf_Ok7SrOPmycX149KDGFQkeCaqL_aU7LvvCN4zKg>
    <xmx:21zyZu4fY8-YEWARTDvjkzBNoeV6WaZoqTFG3tmPTqC6qcV5xv686Q>
    <xmx:21zyZqgIM7Dyyf9ysLfUary1OvAHhp0jTVbjkBBFeXUL0WgaBXAZGA>
    <xmx:21zyZg4x__wJdzn2JTlRJAA5jM8EdYxM_jDhHy0OJdT7bMA-N1HuJQ>
    <xmx:21zyZknb5OYUiiC0auC-fjHBVyfyadLSe6yzJLCQjuq5E38eE67FW5Pg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:31:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec5670bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:31:19 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:31:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/22] reftable: handle allocation errors
Message-ID: <cover.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

Hi,

this is the second patch series that converts the reftable library to
start handling allocation errors. This is done such that the reftable
library can truly behave like a library and let its callers handle such
conditions.

Changes compared to v1:

  - Remove our use of `st_mult()` in `reftable_calloc()`.

  - Initialize the `*dest` pointer with `NULL` in case creating a new
    indexed table iterator fails.

Thanks!

Patrick

Patrick Steinhardt (22):
  reftable/error: introduce out-of-memory error code
  reftable/basics: merge "publicbasics" into "basics"
  reftable: introduce `reftable_strdup()`
  reftable/basics: handle allocation failures in `reftable_calloc()`
  reftable/basics: handle allocation failures in `parse_names()`
  reftable/record: handle allocation failures on copy
  reftable/record: handle allocation failures when decoding records
  reftable/writer: handle allocation failures in `writer_index_hash()`
  reftable/writer: handle allocation failures in `reftable_new_writer()`
  reftable/merged: handle allocation failures in
    `merged_table_init_iter()`
  reftable/reader: handle allocation failures for unindexed reader
  reftable/reader: handle allocation failures in `reader_init_iter()`
  reftable/stack: handle allocation failures on reload
  reftable/stack: handle allocation failures in `reftable_new_stack()`
  reftable/stack: handle allocation failures in `stack_compact_range()`
  reftable/stack: handle allocation failures in auto compaction
  reftable/iter: handle allocation failures when creating indexed table
    iter
  reftable/blocksource: handle allocation failures
  reftable/block: handle allocation failures
  reftable/pq: handle allocation failures when adding entries
  reftable/tree: handle allocation failures
  reftable: handle trivial allocation failures

 Makefile                            |   1 -
 refs/reftable-backend.c             |  39 ++++--
 reftable/basics.c                   |  92 ++++++++++++++-
 reftable/basics.h                   |  13 +-
 reftable/block.c                    |  23 +++-
 reftable/block.h                    |   4 +-
 reftable/blocksource.c              |  25 +++-
 reftable/error.c                    |   2 +
 reftable/iter.c                     |  20 +++-
 reftable/iter.h                     |   2 +-
 reftable/merged.c                   |  84 ++++++++-----
 reftable/merged.h                   |   6 +-
 reftable/pq.c                       |   7 +-
 reftable/pq.h                       |   2 +-
 reftable/publicbasics.c             |  66 -----------
 reftable/reader.c                   |  68 ++++++++---
 reftable/reader.h                   |   6 +-
 reftable/record.c                   | 164 +++++++++++++++++++-------
 reftable/record.h                   |   6 +-
 reftable/reftable-basics.h          |  18 +++
 reftable/reftable-error.h           |   3 +
 reftable/reftable-malloc.h          |  18 ---
 reftable/reftable-merged.h          |   8 +-
 reftable/reftable-reader.h          |   8 +-
 reftable/reftable-stack.h           |   8 +-
 reftable/reftable-writer.h          |  12 +-
 reftable/stack.c                    | 177 ++++++++++++++++++++++------
 reftable/tree.c                     |  42 +++++--
 reftable/tree.h                     |  21 +++-
 reftable/writer.c                   | 150 +++++++++++++++--------
 t/helper/test-reftable.c            |  10 +-
 t/unit-tests/lib-reftable.c         |   8 +-
 t/unit-tests/t-reftable-basics.c    |  11 +-
 t/unit-tests/t-reftable-block.c     |  24 ++--
 t/unit-tests/t-reftable-merged.c    |  16 ++-
 t/unit-tests/t-reftable-readwrite.c |  61 ++++++----
 t/unit-tests/t-reftable-stack.c     |   4 +-
 t/unit-tests/t-reftable-tree.c      |  10 +-
 38 files changed, 853 insertions(+), 386 deletions(-)
 delete mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reftable-basics.h
 delete mode 100644 reftable/reftable-malloc.h

Range-diff against v1:
 1:  8c99ecc3255 =  1:  8c99ecc3255 reftable/error: introduce out-of-memory error code
 2:  4dcdf1d48ec =  2:  4dcdf1d48ec reftable/basics: merge "publicbasics" into "basics"
 3:  21fa9b15d96 =  3:  21fa9b15d96 reftable: introduce `reftable_strdup()`
 4:  e6ded75f630 !  4:  f6ad92ffd01 reftable/basics: handle allocation failures in `reftable_calloc()`
    @@ Commit message
     
         Handle allocation failures in `reftable_calloc()`.
     
    +    While at it, remove our use of `st_mult()` that would cause us to die on
    +    an overflow. From the caller's point of view there is not much of a
    +    difference between arguments that are too large to be multiplied and a
    +    request that is too big to handle by the allocator: in both cases the
    +    allocation cannot be fulfilled. And in neither of these cases do we want
    +    the reftable library to die.
    +
    +    While we could use `unsigned_mult_overflows()` to handle the overflow
    +    gracefully, we instead open-code it to further our goal of converting
    +    the reftable codebase to become a standalone library that can be reused
    +    by external projects.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## reftable/basics.c ##
    -@@ reftable/basics.c: void *reftable_calloc(size_t nelem, size_t elsize)
    +@@ reftable/basics.c: void reftable_free(void *p)
    + 
    + void *reftable_calloc(size_t nelem, size_t elsize)
      {
    - 	size_t sz = st_mult(nelem, elsize);
    - 	void *p = reftable_malloc(sz);
    +-	size_t sz = st_mult(nelem, elsize);
    +-	void *p = reftable_malloc(sz);
    +-	memset(p, 0, sz);
    ++	void *p;
    ++
    ++	if (nelem && elsize > SIZE_MAX / nelem)
    ++		return NULL;
    ++
    ++	p = reftable_malloc(nelem * elsize);
     +	if (!p)
     +		return NULL;
    - 	memset(p, 0, sz);
    ++
    ++	memset(p, 0, nelem * elsize);
      	return p;
      }
    + 
 5:  1f98abe9812 =  5:  ad028020df7 reftable/basics: handle allocation failures in `parse_names()`
 6:  fa32be01e50 =  6:  df713fbe08c reftable/record: handle allocation failures on copy
 7:  372e36f880e =  7:  870bb003c0a reftable/record: handle allocation failures when decoding records
 8:  7404d648a9d =  8:  1d47e425009 reftable/writer: handle allocation failures in `writer_index_hash()`
 9:  d6afb30221e =  9:  caa71f0a775 reftable/writer: handle allocation failures in `reftable_new_writer()`
10:  349fd785a81 = 10:  a84e9cadae4 reftable/merged: handle allocation failures in `merged_table_init_iter()`
11:  c4985e64ce2 = 11:  20d38330141 reftable/reader: handle allocation failures for unindexed reader
12:  94c85ffd5ec = 12:  e35c3a705d5 reftable/reader: handle allocation failures in `reader_init_iter()`
13:  6ef25b6c655 = 13:  ca3b57f151e reftable/stack: handle allocation failures on reload
14:  f5583cc2300 = 14:  7377421a632 reftable/stack: handle allocation failures in `reftable_new_stack()`
15:  3393a59ce42 = 15:  244e8667c5d reftable/stack: handle allocation failures in `stack_compact_range()`
16:  2c19f258fe7 = 16:  99f4868c38f reftable/stack: handle allocation failures in auto compaction
17:  32fead57de9 ! 17:  271839a6260 reftable/iter: handle allocation failures when creating indexed table iter
    @@ reftable/iter.c: int new_indexed_table_ref_iter(struct indexed_table_ref_iter **
      	itr->offset_len = offset_len;
      
      	err = indexed_table_ref_iter_next_block(itr);
    --	if (err < 0) {
     +	if (err < 0)
     +		goto out;
     +
    @@ reftable/iter.c: int new_indexed_table_ref_iter(struct indexed_table_ref_iter **
     +	err = 0;
     +
     +out:
    -+	if (err < 0)
    + 	if (err < 0) {
    ++		*dest = NULL;
      		reftable_free(itr);
     -	} else {
     -		*dest = itr;
    --	}
    + 	}
      	return err;
      }
    - 
     
      ## reftable/iter.h ##
     @@ reftable/iter.h: void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
18:  4d672ab9b15 = 18:  c41808e9d75 reftable/blocksource: handle allocation failures
19:  4fa47a559b2 = 19:  9348b0a4575 reftable/block: handle allocation failures
20:  a569c39fd8e = 20:  445daf9464d reftable/pq: handle allocation failures when adding entries
21:  99bca688f2a = 21:  c31f9e53f52 reftable/tree: handle allocation failures
22:  02073dafb96 = 22:  d0fe9993716 reftable: handle trivial allocation failures
-- 
2.46.0.551.gc5ee8f2d1c.dirty

