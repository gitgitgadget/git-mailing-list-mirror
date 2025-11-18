Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1D93702F8
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505267; cv=none; b=OvTkGWDfTprPytLkfpbfZYVw2J/sHx2AWlGBdNYGK2n7gggn+To4c9qLm0glyiZtM8E+l+6IVZDSETqIGRHC8MA4OXPAUagl95kinkSH5ZLYEHVEL7JBBNpCKl1B0A+dK7yIEjjUt78jkJbx9GgEVeyxDxrx+LxcJQgpzXRwQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505267; c=relaxed/simple;
	bh=U0stWkjiC5hxQPNi1cPNaT5BprpDuo8viXsJE+HhmaA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N62+J9+FkMBCznPuI6jtMteRqd6+JEqnOLTl3EJ9iYmuVwgu3FnEjZtQv/lNFbPkJAF5fohb7GKmwi7AhpNlo6S0a8qSIcs4n7sSAscPOoeKtsLJgpiKk7dUZh7zuafNFXr2B4O70vx0Uj7cwq0soVLpUinz6HksPWS3v0+HVPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dxy6a+ep; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dxy6a+ep"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297f35be2ffso84558405ad.2
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 14:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763505263; x=1764110063; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4i1A6aK/lm0edNLd33AT6/rgZpnPZ6/0CfPX/YxSCw=;
        b=Dxy6a+epcpTgq0hZ/YmeKVKYlGtjem/IuxYmMIYPAJkIBW1KYQwf8+77c6Nr8WGTDp
         Lx8772Ybb4m5CnKCwENz39iBfjQ/E/nhhzVVTKfR8I8y43EIxkQx83xxxD9B+YfvwODE
         6Lk4bsL/cDFlARxk1vHB85OmTerFPSBkHVynPIQAU8DFZ8SdRW5d1OO8lnbFnLP+vPd+
         cGXAB9xAAKcSBwnNjbGpms7UMv+o3VMpvZ3SyQxF0y3/gacCmr0o2F7+eJ9fg+9JabNj
         1+AB/Jt3N7jrSBA6x34pO4rVGWlQbQNbpgqn00SYe2B069nueayncVkSUSb1JPaNIDll
         Z0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505263; x=1764110063;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W4i1A6aK/lm0edNLd33AT6/rgZpnPZ6/0CfPX/YxSCw=;
        b=uOjpGgZYuaUfhs29CvzJE0C7+4wFK9ozq2WXiq5C5IPRr/fRXlfFDW9afa2A3VIdlX
         XZNQ6C2gE+Lkja8N2vBWULxKE/psXarSinmWLaydU8e7S/K69fOvOHEdqa63t+mGA8Eh
         zyDLTSvwMK1GMlS55cAAEITu4ggq1GakpduOZQDbK8m8bUe9xdgcIoHLp7q0SGrP58gG
         aFd1VbRv/AJzEOExtd8xw3SfG3z4PSX+Ieu59BnwR6Ugm2d5ifpRYhy/x7bsbwofSpYk
         9rtrueOkTDfZobt8qJ3c1I7UPDSffJAquQZPehEvoLtXkXYoZtDyZ0aHuaCApZermtye
         OXKQ==
X-Gm-Message-State: AOJu0YxL7AhAwrVjjGNvTxsVZDPoAa9nq8I3Sh2O+V/dKWpZ6I+kLpKN
	Lmn/TbldQ75PHvw/KKnd8dVKIWxr+pkqbHTHcOvfcjRlvNRC/3UyUOqnxwivaw==
X-Gm-Gg: ASbGnctIIe2S+U5N2T9IlqL/DP2ry38lAcdHkmPL+QR6crj88tFwkDFQCkxVXV2P2Nr
	5Xrrit+DjKHKsjF0HoT6mvo/3bCbQTwgvkb85AjSKC42yhrzvN9uxuIve7c1gAlADXNgOzrYpBT
	FGFCeZi3eA9UBUUkHN71bg5aRBkaAfa0KIvqP6RHjk0fBlahYz+mxUzEFGXdJ1ITLydkA5k0dVY
	QJk2kmoRffQpgjPzqPChbCwtotT6Pbz+nBiMDw3WBPlY2tdXTsG53OMhN1gDOaHVPc9lJs4m1/V
	BRljsTR/NprVer9TTe7kOyN5vm9I6fB5gyrdmI84MuHIPphS8fBdIM00vpl5upqqG/D474sn0cG
	NMVBvmvaHafnuvCjO/7wKq9VtYzIQKeTTPsubmqgN92fKQ3jSvHL3p2usj7NCUl05TgOtaympqF
	V7DVVoPBYsWUdt
X-Google-Smtp-Source: AGHT+IF5FBHccB7N+dLFjDpEbkHSYhpC0cWy/hAlvjneq/wzmfOi//VWT3wTQD+PMt66DVXsJ75iLA==
X-Received: by 2002:a17:902:f607:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-2986a76f33bmr212922805ad.61.1763505263396;
        Tue, 18 Nov 2025 14:34:23 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed23sm183142485ad.87.2025.11.18.14.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:34:22 -0800 (PST)
Message-Id: <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
References: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 22:34:12 +0000
Subject: [PATCH v5 00/10] Xdiff cleanup part2
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
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

Changes in v5:

 * Remove the non-word 'signless', and rephrase that paragraph in
   unambiguous-types.adoc
 * Cast to char in xdiffi.c:get_indent() rather than changing the local
   variable to uint8_t

Changes in v4:

 * Update documentation to not mention Unicode except once
 * Don't move dstart/dend with in the xdfile_t struct
 * Rephrase justification on changing xrecord_t.ptr's type

Changes in v3:

 * Address comments about commit messages and documentation
 * Add unambiguous-types.adoc to Makefile and Meson
 * Use markdown style to avoid asciidoc issues

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
	ptrdiff_t dstart, dend;
	bool *changed;
	size_t *reference_index;
	size_t nreff;
} xdfile_t;


Ezekiel Newren (10):
  doc: define unambiguous type mappings across C and Rust
  xdiff: use ptrdiff_t for dstart/dend
  xdiff: make xrecord_t.ptr a uint8_t instead of char
  xdiff: use size_t for xrecord_t.size
  xdiff: use unambiguous types in xdl_hash_record()
  xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
  xdiff: make xdfile_t.nrec a size_t instead of long
  xdiff: make xdfile_t.nreff a size_t instead of long
  xdiff: change rindex from long to size_t in xdfile_t
  xdiff: rename rindex -> reference_index

 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/unambiguous-types.adoc          | 224 ++++++++++++++++++
 xdiff-interface.c                             |   2 +-
 xdiff/xdiffi.c                                |  29 ++-
 xdiff/xemit.c                                 |  28 +--
 xdiff/xhistogram.c                            |   4 +-
 xdiff/xmerge.c                                |  30 +--
 xdiff/xpatience.c                             |  14 +-
 xdiff/xprepare.c                              |  60 ++---
 xdiff/xtypes.h                                |  15 +-
 xdiff/xutils.c                                |  32 +--
 xdiff/xutils.h                                |   6 +-
 13 files changed, 336 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/technical/unambiguous-types.adoc


base-commit: a99f379adf116d53eb11957af5bab5214915f91d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2070%2Fezekielnewren%2Fxdiff_cleanup_part2-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2070/ezekielnewren/xdiff_cleanup_part2-v5
Pull-Request: https://github.com/git/git/pull/2070

Range-diff vs v4:

  1:  af732beb69 !  1:  8b56bf1172 doc: define unambiguous type mappings across C and Rust
     @@ Documentation/technical/unambiguous-types.adoc (new)
      +has additional semantics and platform-dependent behavior that can cause
      +problems, as discussed below.
      +
     -+C comparison problem: While the sign of `char` is implementation defined, it's
     -+also signless (neither signed nor unsigned). When building with
     -+`make DEVELOPER=1` it will complain about a "differ in signedness" when `char`
     -+is compared with `uint8_t` or `int8_t`.
     ++The C language leaves the signedness of `char` implementation defined. Because
     ++our developer build enables -Wsign-compare, comparison of a value of `char`
     ++type with either signed or unsigned integers may trigger warnings from the
     ++compiler.
      +
      +Note: Rust's `char` type is an unsigned 32-bit integer that is used to describe
      +Unicode code points.
  2:  b60a03eb31 =  2:  c4193d11f5 xdiff: use ptrdiff_t for dstart/dend
  3:  042fbb11d0 !  3:  dd76d4f586 xdiff: make xrecord_t.ptr a uint8_t instead of char
     @@ Commit message
          Make xrecord_t.ptr uint8_t because it's referring to bytes in memory.
      
          In order to avoid a refactor avalanche, many uses of this field were
     -    cast to char* or similar. One exception is in get_indent() where the
     -    local variable `char c` was changed to `uint8_t c`.
     +    cast to char* or similar.
      
          Places where casting was unnecessary:
          xemit.c:156
     @@ xdiff/xdiffi.c: static int get_indent(xrecord_t *rec)
       
       	for (i = 0; i < rec->size; i++) {
      -		char c = rec->ptr[i];
     -+		uint8_t c = rec->ptr[i];
     ++		char c = (char) rec->ptr[i];
       
       		if (!XDL_ISSPACE(c))
       			return ret;
  4:  c103fa6bea !  4:  11cec1d2ec xdiff: use size_t for xrecord_t.size
     @@ xdiff/xdiffi.c: static int recs_match(xrecord_t *rec1, xrecord_t *rec2)
       
      -	for (i = 0; i < rec->size; i++) {
      +	for (size_t i = 0; i < rec->size; i++) {
     - 		uint8_t c = rec->ptr[i];
     + 		char c = (char) rec->ptr[i];
       
       		if (!XDL_ISSPACE(c))
      @@ xdiff/xdiffi.c: static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
  5:  2ee9a74653 =  5:  6f267360b7 xdiff: use unambiguous types in xdl_hash_record()
  6:  f044274bd5 =  6:  78af0f16f4 xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
  7:  f7a3731d94 =  7:  5c19f9ded3 xdiff: make xdfile_t.nrec a size_t instead of long
  8:  93f84ae72e =  8:  d1f498edb1 xdiff: make xdfile_t.nreff a size_t instead of long
  9:  39369becc8 =  9:  bc4941c146 xdiff: change rindex from long to size_t in xdfile_t
 10:  950d1e6193 = 10:  dcc9d6bfaf xdiff: rename rindex -> reference_index

-- 
gitgitgadget
