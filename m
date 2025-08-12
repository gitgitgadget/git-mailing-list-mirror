Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB4D25D8E8
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992474; cv=none; b=Ofadf8h/wvJFJUQA8zzIw+Y0SL/q74IAc4PxFlHt8W0BpRVJqsgy1Otnhf3q96qRAHGiy25+7V+GD+o6HsHnQ8FV/i88XhrGS2JJtccKblKuPuD+3BkHa0fqfDl8nRvhgHj/IlJAYicxpHfZYN8/amEz3caSKwKUhSkDWlLeDlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992474; c=relaxed/simple;
	bh=+Vn8T0CDwUxMlRRrVsEsLNCwFq6f2hr/6s2rYDmHZt8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=MKP/8M4F/f1NVPc+VlKgGVZ+mJYuz0cFsm2SocbM01KN3BNHhAcASnHdFlkhlTSIb1siywfV4LdoTNigpKLP01H9c8jtFm5D31jHZaPJRZib2NZfHR/vs2F5zVExll8xmQh5boKwdY/2xH2TtEi74qCnEMg0For6TVcDvcFh79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VGvqYuLj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nsiJYqzg; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VGvqYuLj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nsiJYqzg"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 62FBE14001EA;
	Tue, 12 Aug 2025 05:54:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 12 Aug 2025 05:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754992471;
	 x=1755078871; bh=IfRHbqgVFXZef8yHSE1WUP/jEN9qGVrIdCB/hi0PHCE=; b=
	VGvqYuLjEfx7wNKuSMA2r2mDZ+PwyTWDEqLUBf3zOU9RQNsKB9HEhr4cWbK0cprJ
	PTXZgqkC+Q6AFpcvZpfGYmJCi5kiqtiqfZSfrlhvCdKMGEPyzqg9BoUyzzikbAPv
	5ov0NTdQwsClkv8y1GO+mHHn0gwAzCG9TkITa1MDeJBfaaye0kPfvS6DgBgq/CvC
	OHbCwxzFbhI6PZcV03+aIJalfcvjOMdkyzpdKcYgFiTAM5nYIzIzN5LOWaGHOWUY
	DHi83U3MBLNtzwpPYN/XvKYSjeJbQxjvg0X1MOI/byM1GnbX9teBUf1gExhozXoQ
	BG37S+qepyl40ZI/ZB96qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754992471; x=
	1755078871; bh=IfRHbqgVFXZef8yHSE1WUP/jEN9qGVrIdCB/hi0PHCE=; b=n
	siJYqzguQAMFt/4X5Y0+6LzF6fEmMCAV302czYp8GGGmfzl9ix31zKKbE61AsZS8
	X6I6rq78mtFvY2eFDx18b26wTF3yciodr9rPQQacq1E4lPpoAGWrWBrfh9+SQ/zO
	YTBKLcZI7O6XpnO3qNAAww7aJ6ClyqaS5TKtBHEN+AouJ032v39hO2z1VlnaOhNz
	c5UNYHC9dp0FD62PVSkaD8TIYQnH9FG5oE05+mMohj/c5FMfeoQ4+rRx6CzgOMVn
	KEtQiIdaeBvNcQQpK+TeDfFii7orAVBucD9/hy4w25A4raVC+B6v+WdxFYaZ8F5D
	RYWNYdDjNR5VB3ZGyBDwA==
X-ME-Sender: <xms:Vw-baGjbiqvXGZp7kDH15zMXUCHBGL9BRbcZsUyk6jYz4XepHDaEhQ>
    <xme:Vw-baChuMeL6Out7VNzRTJzme3wkTzTBS6LPj1daQSDsfFRwm6UrIm1eL3gmOCbl-
    40quxRLrHsZo1upkg>
X-ME-Received: <xmr:Vw-baEgBhXrEwVS2ruAmi64K4i2McKdnfOBnZRh3CpKLoXsuPurbY1KgH5ID7IqlRuqpMzPSAYSnd5-DODbj9VjzP-8viLO_XdnLS-xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Vw-baKL4PX124T_I4HQP9NmIMPm74JitEUkbrS-o8drja5-qzVL4Wg>
    <xmx:Vw-baLHCGLZ6RLNIuXYsksTiOgMCfWbSlQtdx9GxQYn9-NzIDpqMBg>
    <xmx:Vw-baGQz2xZaa8N6AxUKnJAQ5XpmijyYwx3jmv0gDyRO9Vgr5FQq4A>
    <xmx:Vw-baPf6IbuNkb5wLfS1o3uWgZFqiyvIQHoUw8M6SLWPnqC_D32Q0Q>
    <xmx:Vw-baNdHj6heJTFdrlqDg_tcI4-9e-k2PJE_e4BNb8Ft42KASQVf6GyO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 05:54:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e7d604d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 12 Aug 2025 09:54:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/8] reftable: a couple of improvements for libgit2
Date: Tue, 12 Aug 2025 11:54:14 +0200
Message-Id: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEYPm2gC/43NQQ7CIBAF0KsY1o4BCqS48h7GRalDO7G2DTRE0
 /TuggvjTpd/8v+blUUMhJEddysLmCjSNOZQ7Xes7ZuxQ6BrzkxyqXnNBcy3CAH90rgBwdMDI/g
 pwECuo0WCNtJZbRtteMUyMuduKWXjfMm5p7hM4fn+l0S5/k0nARy8UgZFW1Wts6c8ONCdFTfJb
 0v9tGSx0HMjuW1srT7Wtm0vDcnyIRUBAAA=
X-Change-ID: 20250801-pks-reftable-fixes-for-libgit2-562b959a5603
In-Reply-To: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series contains a couple of improvements I required for
libgit2. With those changes libgit2 is now able to run its full test
suite with reftable-enabled repositories. I still need to invest a bit
of work to make it memory-leak free and compile on Windows, but overall
I think that support for reftables is almost ready.

Changes in v2:
  - Another commit that fixes handling of outdated stacks when doing
    compaction. This issue is hit in libgit2, which has a test that
    performs writes with a couple dozen concurrent threads.
  - Add a link to past discussions around `{0}` vs `{{0}}` as provided
    by Eric.
  - Link to v1: https://lore.kernel.org/r/20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im

Changes in v3:
  - Adapt `reftable_stack_init_addition()` to `memset()` the addition
    instead of using `{{0}}`.
  - Add another commit on top that makes the `flock` interface more
    robust by not relying on `errno`.
  - Add another commit to fix races with concurrent writers caused by
    the backend not passing `REFTABLE_STACK_NEW_ADDITION_RELOAD`.
  - Link to v2: https://lore.kernel.org/r/20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (8):
      reftable/writer: fix type used for number of records
      reftable/writer: drop Git-specific `QSORT()` macro
      reftable/stack: reorder code to avoid forward declarations
      reftable/stack: fix compiler warning due to missing braces
      reftable/stack: allow passing flags to `reftable_stack_add()`
      reftable/stack: handle outdated stacks when compacting
      reftable: don't second-guess errors from flock interface
      refs/reftable: always reload stacks when creating lock

 refs/reftable-backend.c         |  23 ++-
 reftable/reftable-stack.h       |   9 +-
 reftable/reftable-writer.h      |   4 +-
 reftable/stack.c                | 439 +++++++++++++++++++---------------------
 reftable/system.c               |   2 +-
 reftable/system.h               |   4 +-
 reftable/writer.c               |  23 ++-
 t/unit-tests/t-reftable-stack.c |  50 ++---
 8 files changed, 275 insertions(+), 279 deletions(-)

Range-diff versus v2:

1:  ce08ba1217 = 1:  1613715dc9 reftable/writer: fix type used for number of records
2:  80a87ff19a = 2:  4a082b71fb reftable/writer: drop Git-specific `QSORT()` macro
3:  e230c97347 < -:  ---------- reftable/stack: fix compiler warning due to missing braces
4:  dd413b76a2 ! 3:  3977a1f497 reftable/stack: reorder code to avoid forward declarations
    @@ reftable/stack.c: int reftable_stack_reload(struct reftable_stack *st)
      	struct reftable_stack *stack;
     @@ reftable/stack.c: struct reftable_addition {
      
    - #define REFTABLE_ADDITION_INIT {{0}}
    + #define REFTABLE_ADDITION_INIT {0}
      
     +static void reftable_addition_close(struct reftable_addition *add)
     +{
-:  ---------- > 4:  e8424dd2ee reftable/stack: fix compiler warning due to missing braces
5:  494bbd6c97 ! 5:  4f0f5cd8e1 reftable/stack: allow passing flags to `reftable_stack_add()`
    @@ reftable/stack.c: static int reftable_stack_init_addition(struct reftable_additi
     -			 void *arg)
     +			 void *arg, unsigned flags)
      {
    - 	struct reftable_addition add = REFTABLE_ADDITION_INIT;
    --	int err = reftable_stack_init_addition(&add, st, 0);
    -+	int err = reftable_stack_init_addition(&add, st, flags);
    + 	struct reftable_addition add;
    + 	int err;
    + 
    +-	err = reftable_stack_init_addition(&add, st, 0);
    ++	err = reftable_stack_init_addition(&add, st, flags);
      	if (err < 0)
      		goto done;
      
6:  46411bf2c2 = 6:  e6e06c8d34 reftable/stack: handle outdated stacks when compacting
-:  ---------- > 7:  86d57dad6e reftable: don't second-guess errors from flock interface
-:  ---------- > 8:  b7bb745ffb refs/reftable: always reload stacks when creating lock

---
base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
change-id: 20250801-pks-reftable-fixes-for-libgit2-562b959a5603

