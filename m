Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B91D555
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776393; cv=none; b=A8mho9y+LwQyQlctZEyoxoIvJaVQD1VaJ6n9T/KcvWCjJMkEIeHEyvcuydwpVFpuynZ+5hlN/38/wgd6e/PLbGK80lyX8qZl3oqWVdq2Ego8XP898amNXx6EjBVhvDwhI2QYacN9s1+FKfAHcG8O7uN7rqtmDViMlQ8Jqsr1F98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776393; c=relaxed/simple;
	bh=Qj+zC/5krDarcp5DpIpTiJzmf1rKhmo8c4VhMBAqtc4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mb16E6kGCKxn+hjBxCmKPW+2ceI5X1IemfpkIL/Ku1kDworUX5oLfRyrr15SrMTRLFrguqVuI1BXpYdjhzJgdaqj/zMWYZWdK2IZjZRgoXEfUgKC6DFyDZcaZ+Q+U4+hFmsZyQUf6DPSh4UllVAQo1JIP+nYWpEYjSG2SW0AQA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOrHO0Vn; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOrHO0Vn"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430b621ec08so3115215ab.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761776390; x=1762381190; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkV2ji/9UYakfSjqOlTY67+NG5hvHni5U/nBbWHulpg=;
        b=hOrHO0VnRfFWEybysLCjs1iFlQSmx2uDx97jvLvxpw9wl1MtSvKhct7mWn9AuHsKm6
         jFpY380TcvssE8oUTWpOVvM+3OhLxFGtIgFMMI8PKToltTvzWYpUPHx54H72b8EeNUHF
         arhBDhha42gm9eVz6+GcYKWREvcMZJpG8MhwXhJASABp5B65Sq8EIg4j3RerS/Cm1ERK
         vsa9LDsBlY+jlp/B9Z2Rl+iTb1m23QmH1v0KZkvvexyHkMpZTkjL4pxMI0Jg9IaSV5ev
         97gFngEeI+BOs6sN1DmBPyhinU34w3l2TBktoYQVgJYVqJOc+9UCIWX5JYOeAfdDmdzb
         k7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776390; x=1762381190;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkV2ji/9UYakfSjqOlTY67+NG5hvHni5U/nBbWHulpg=;
        b=Qppu7HgEbGXiSRvYI/JasmcLJVdYXYc7fTabDEHhza9yYm8Yw4IU5lxeV9leh2F+tF
         B2xyp6A+0wnZ0NZJWBNnBgBtmsWNj6JFzwA3htJuXtLqkMA8Th2+F2rMMvMnltFnCqZ8
         wmoJBCWW3gLOymNgQK0z/GRfS4KllCm2zae/m2bDQHStT0BBohiK9+ddGyZrRL0YF92B
         67E41L8UTCHcXouGv2LaI4I+vadZDtr3sgqfBpdSzP8ai+lcIC5SifoLvnA4yYJtw3n3
         9pcX8LIRI761hPHy+ohkzKTpmsf+FsdF/Qt6fudIVXPNyzxqXlshuJjKADvOuBoZkU2s
         S5wg==
X-Gm-Message-State: AOJu0YyfDorMBCqYHzYQcjaFk84o3Tt98X+dF5iaSCrjmF9hcQ5brF8m
	9c6zdDECRNADD0zRz6sIDtZmyZdSQJ+iNjnNbJ3bpJQOYHBBuKNdr9F3YHnJeg==
X-Gm-Gg: ASbGncsaMUe8SKKX5nNx9zdIJOdtnk2c8nEw50QCFZmLGjKo6ZRcokXPAVkn0MP/RaF
	++AOyKrhqlzd8408iN5+v5s+9HVndCo/NnGCp3eTCZUIteezkpNa5nCaz1fXNrWrDDJhhtjDh8F
	uakIZO20pX5ERv2i3ehLVkVJHvhtMftz5oqykVCchE0Q5ydXu/ySmWGOF2/y7JvVgUjeKtootxJ
	lEnu738CEkGa2OdE1Kaz0vemiDGLAYyAooU6fw/ORUxTbXtU3Gif+BiDfdZZ9m6iC60VuO8dQaB
	fre8ZCaspUdjtqygre8g6jQoYFknOLEVGVCsXy4fDwRygh2ELcAvpc9JhE5Z0AXUWkmLbeaHmOX
	fGQWkbdy03r0W+nWbuJmDr+sFrFYRal3oxuXJOeaJ0dSxuC4LwfaKsowEOifigKSqIlk5kLDcKF
	VQzg==
X-Google-Smtp-Source: AGHT+IH7mI/+N/M8oNPNbzmO4xRUylsVBznBwECVfqC0URy+cbZOO2qNZLc5URhjqVrLgvg+AQPoTQ==
X-Received: by 2002:a05:6e02:1a2a:b0:42d:86f3:a2d1 with SMTP id e9e14a558f8ab-43301550f7bmr16412745ab.25.1761776390130;
        Wed, 29 Oct 2025 15:19:50 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea73dbf57sm5975737173.8.2025.10.29.15.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:19:49 -0700 (PDT)
Message-Id: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Oct 2025 22:19:38 +0000
Subject: [PATCH v2 00/10] Xdiff cleanup part2
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

Changes in v2:

 * Added documentation about unambiguous types and FFI
 * Addressed comments on the mailing list


Original cover letter below:
============================

Maintainer note: This patch series builds on top of en/xdiff-cleanup and
am/xdiff-hash-tweak (both of which are now in master).

The primary goal of this patch series is to convert every field's type in
xrecord_t and xdfile_t to be unambiguous, in preparation to make it more
Rust FFI friendly. Additionally the ha field in xrecord_t is split into
line_hash and minimal_perfect hash.

The order of some of the fields has changed as called out by the commit
messages.

Before:

typedef struct s_xrecord {
	char const *ptr;
	long size;
	unsigned long ha;
} xrecord_t;

typedef struct s_xdfile {
	xrecord_t *recs;
	long nrec;
	long dstart, dend;
	bool *changed;
	long *rindex;
	long nreff;
} xdfile_t;


After part 2

typedef struct s_xrecord {
	uint8_t const *ptr;
	size_t size;
	uint64_t line_hash;
	size_t minimal_perfect_hash;
} xrecord_t;

typedef struct s_xdfile {
	xrecord_t *recs;
	size_t nrec;
	bool *changed;
	size_t *reference_index;
	size_t nreff;
	ssize_t dstart, dend;
} xdfile_t;


Ezekiel Newren (10):
  doc: define unambiguous type mappings across C and Rust
  xdiff: use ssize_t for dstart/dend, make them last in xdfile_t
  xdiff: make xrecord_t.ptr a uint8_t instead of char
  xdiff: use size_t for xrecord_t.size
  xdiff: use unambiguous types in xdl_hash_record()
  xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
  xdiff: make xdfile_t.nrec a size_t instead of long
  xdiff: make xdfile_t.nreff a size_t instead of long
  xdiff: change rindex from long to size_t in xdfile_t
  xdiff: rename rindex -> reference_index

 .../technical/unambiguous-types.adoc          | 229 ++++++++++++++++++
 xdiff-interface.c                             |   2 +-
 xdiff/xdiffi.c                                |  29 ++-
 xdiff/xemit.c                                 |  28 +--
 xdiff/xhistogram.c                            |   4 +-
 xdiff/xmerge.c                                |  30 +--
 xdiff/xpatience.c                             |  14 +-
 xdiff/xprepare.c                              |  58 ++---
 xdiff/xtypes.h                                |  15 +-
 xdiff/xutils.c                                |  32 +--
 xdiff/xutils.h                                |   6 +-
 11 files changed, 338 insertions(+), 109 deletions(-)
 create mode 100644 Documentation/technical/unambiguous-types.adoc


base-commit: 143f58ef7535f8f8a80d810768a18bdf3807de26
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2070%2Fezekielnewren%2Fxdiff_cleanup_part2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2070/ezekielnewren/xdiff_cleanup_part2-v2
Pull-Request: https://github.com/git/git/pull/2070

Range-diff vs v1:

  -:  ---------- >  1:  88133848d1 doc: define unambiguous type mappings across C and Rust
  1:  1fa9a7d7d1 !  2:  9197903add xdiff: use ssize_t for dstart/dend, make them last in xdfile_t
     @@ xdiff/xtypes.h: typedef struct s_xrecord {
       	bool *changed;
       	long *rindex;
       	long nreff;
     -+	ssize_t dstart, dend;
     ++	ptrdiff_t dstart, dend;
       } xdfile_t;
       
       typedef struct s_xdfenv {
  2:  7b9e8961d4 !  3:  46bc1b3e25 xdiff: make xrecord_t.ptr a uint8_t instead of char
     @@ Commit message
          xdiff: make xrecord_t.ptr a uint8_t instead of char
      
          Rust uses u8 to refer to bytes in memory. Since xrecord_t.ptr is also
     -    referring to bytes in memory, rather than unicode code points, use
     +    referring to bytes in memory, rather than Unicode code points, use
          uint8_t instead of char.
      
     +    Every usage of this field was inspected and cast to char*, or similar,
     +    to avoid signedness warnings/errors from the compiler. Casting was used
     +    so that the whole of xdiff doesn't need to be refactored in order to
     +    change the type of this field.
     +
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xdiffi.c ##
  3:  ae15ed7121 =  4:  07e28aad3b xdiff: use size_t for xrecord_t.size
  4:  7fcd83c990 !  5:  1ade7d8165 xdiff: use unambiguous types in xdl_hash_record()
     @@ Metadata
       ## Commit message ##
          xdiff: use unambiguous types in xdl_hash_record()
      
     +    Convert the function signature and body to use unambiguous types. char
     +    is changed to uint8_t because this function processes bytes in memory.
     +    unsigned long to uint64_t so that the hash output is consistent across
     +    platforms. `flags` was changed from long to uint64_t to ensure the
     +    high order bits are not dropped on platforms that treat long as 32
     +    bits.
     +
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff-interface.c ##
  5:  a3e706ecda =  6:  59054ea0cb xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
  6:  5767ba4ee8 =  7:  f91be17858 xdiff: make xdfile_t.nrec a size_t instead of long
  7:  4caa6a4669 !  8:  e2a6a23cc4 xdiff: make xdfile_t.nreff a size_t instead of long
     @@ xdiff/xtypes.h: typedef struct s_xdfile {
       	long *rindex;
      -	long nreff;
      +	size_t nreff;
     - 	ssize_t dstart, dend;
     + 	ptrdiff_t dstart, dend;
       } xdfile_t;
       
  8:  6dca5e6222 !  9:  3b6054945f xdiff: change rindex from long to size_t in xdfile_t
     @@ Commit message
          xdiff: change rindex from long to size_t in xdfile_t
      
          rindex describes a index offset which means it's an index into memory
     -    which should use size_t. dstart and dend will be deleted in a future
     -    patch series. Move them to the end to help avoid refactor conflicts.
     +    which should use size_t.
     +
     +    Changing the type of rindex from long to size_t has no cascading
     +    refactor impact because it is only ever used to directly index other
     +    arrays.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     @@ xdiff/xtypes.h: typedef struct s_xdfile {
      -	long *rindex;
      +	size_t *rindex;
       	size_t nreff;
     - 	ssize_t dstart, dend;
     + 	ptrdiff_t dstart, dend;
       } xdfile_t;
  9:  518e5f5557 ! 10:  1856a29026 xdiff: rename rindex -> reference_index
     @@ xdiff/xtypes.h: typedef struct s_xdfile {
      -	size_t *rindex;
      +	size_t *reference_index;
       	size_t nreff;
     - 	ssize_t dstart, dend;
     + 	ptrdiff_t dstart, dend;
       } xdfile_t;

-- 
gitgitgadget
