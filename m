Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A219AD90
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151393; cv=none; b=c5BDv4gEDB+spNtyHR9oWX/qmWIA38DDLhKjOAT0rXimwkIFDEg8uMnWnyViNmXzRf3ml/4/vk3kN9/LzclNaNIm7taGHxgoH+pOn3UkgicrxAWFKAzrImpkooLS5BfqVP6f1HTlOV4SZ4lRpULe19WhFvB79w5Mm7lEd30ZoV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151393; c=relaxed/simple;
	bh=aKkDzKB+oISkFKtZMKWotZqRiG90T9jqlD/x75gpZI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsGeE7hAqiObrtJTdvbVDjJjX2FDYQIYzni0QXiCTvuLru0Smc1e3DKKeo/nuHN7VhvaK7mdGqtT2NMwaJqFi7zsQkhSrylcIZzAhgJUNwFay4TZhkiW880ENH+NxlgVkzXxxl2RUgqqE4bJnzYHehY4z96r3AbIzvC8t/+H8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=zX8obPOk; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="zX8obPOk"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e53a5ff2233so5105725276.3
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 14:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737151389; x=1737756189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOwGVygbJEjHRYxUTH69QRUA3edUAEhmW2mIYP+F6Lg=;
        b=zX8obPOk+3p3PkEG/2Cc8ysEOhb3x8bASk9lmX/tzfRFE/vbesWy9NIr34/Ef+0kgv
         8IMojwG5W6JSjCzNm8t8MoRltrDB5kIdCMwkFwIq/KyhIvhD/i3kkr1F6PWEEODEyWJe
         KDIFM74/Dl9+S66NafeN2u+vBCJ8WMrOBu6y76LgVxzGQ/x3j6RrUbFosJCWp8sFoCYE
         MchRozmc++aSo/AH33WVPqCFKzCcBcR+0F2u53i6J9CKJ4XKOz1cOMAHJQJltHRWdSOH
         TwMKN3SPgVQY2rRC+x3xDftODW3HHjsas0elJgMPfwZ0sdKwmngu5Td4NBjt+GypHZT3
         PNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151389; x=1737756189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOwGVygbJEjHRYxUTH69QRUA3edUAEhmW2mIYP+F6Lg=;
        b=F/EHKQS3Vu5wpLFR81G/MT37q+j6Nxs0H0vAcbN2Ap4rUUyRvQa3muq6guttK0UV1g
         PMRqThCVPROQqlvDJmF2PK7ExWQiKzhaOKtCZKKLkGIhV6OkCpeEqRdsP4iB7dc1WLn5
         54t5fJj6BBdCaqEku+jpLfQR0eB7fF674NaB6yJfKSEryjvh1X6g7IttypmNkogZvlbu
         bU1IsIpeeY6sR9rymBlu6siPVmcW9mSCRD5VtNl0uv52gLWJTRZmRKDSFmGenSgsJ4W5
         sOLzV6sFJUUMlHv/TFGDe83rdBuRRrn1EQBeQ0mkYFw0E2GH2S2zdhoILZLDeJLxfsRz
         lYMg==
X-Gm-Message-State: AOJu0Yy9QTc8uOh4sFUL71PqPcDKYZoBbOB3DhFx6iSr1suiUGwZOijr
	8QnCPT10GOz1Qwpa/NwYDH/GTsipZ81PVsbuXJdaQNXe0+YzKMHY5ArbXhfkksQm/fIoyA+EcmG
	q5AU=
X-Gm-Gg: ASbGncvGtYn9mCZAScT2l7s3OVScxh1byki4UNTmMJbfXp/YH0CZrOyNssK43eKm1wF
	wjFa8p33lFKsKVdoJIK3+GVBR6QUVd8YMwxyLTsrXvRcRysHkpl48IYkoZzhFfhjLDhEH066cWG
	5R2W2UaH9SjTESqqKTxqyBmykvTiAAWsTxblRjhXP8HI9ZVTd50FaDGaQB9F+IkO9arsK5QGHEt
	jDatCXDevGHxAj9Or2cxfcMwHqe85xetKo2tJJEn1I0wyO5SpcZihMuP+HqQqbSTXlykqa6eLb7
	o//29Ji6aRawbnlA8VvCak30a69T
X-Google-Smtp-Source: AGHT+IE8sOqiVyNzdcDQMx9XFgL6lW0/DLfxA3Wp7CB4IrLrtbyqoZYZfjV8aw4MBCciTfZv2olbxg==
X-Received: by 2002:a05:690c:9a13:b0:6ee:6c7d:4888 with SMTP id 00721157ae682-6f6eb68b298mr36280057b3.22.1737151388785;
        Fri, 17 Jan 2025 14:03:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e647e885sm5907467b3.67.2025.01.17.14.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 14:03:08 -0800 (PST)
Date: Fri, 17 Jan 2025 17:03:07 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/8] hash: introduce unsafe_hash_algo(), drop unsafe_
 variants
Message-ID: <cover.1737151386.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732130001.git.me@ttaylorr.com>

(This series is based on 14650065b7 (RelNotes/2.48.0: fix typos etc.,
2025-01-07)).

The bulk of this series is unchanged since last time, save for a couple
of typofixes on spots noticed by Peff and Patrick Steinhardt. More
importantly, it fixes hash_algo_by_ptr() when passing the unsafe SHA-1
variant.

There were a couple of other ideas floated around, but I don't think
they panned out as we had hoped in practice, so I think that this
version should be good to go.

The original cover letter is as follows:

------------

This series implements an idea discussed in [2] which suggests that we
introduce a way to access a wrapped version of a 'struct git_hash_algo'
which represents the unsafe variant of that algorithm, rather than
having individual unsafe_ functions (like unsafe_init_fn() versus
init_fn(), etc.).

This approach is relatively straightforward to implement, and removes a
significant deficiency in the original implementation of
unsafe/non-cryptographic hash functions by making it impossible to
switch between safe- and unsafe variants of hash functions. It also
cleans up the sha1-unsafe test helper's implementation by removing a
large number of "if (unsafe)"-style conditionals.

The series is laid out as follows:

  * The first two patches prepare the hashfile API for the upcoming
    change:

      csum-file: store the hash algorithm as a struct field
      csum-file.c: extract algop from hashfile_checksum_valid()

  * The next patch implements the new 'unsafe_hash_algo()' function at
    the heart of this series' approach:

      hash.h: introduce `unsafe_hash_algo()`

  * The next two patches convert existing callers to use the new
    'unsafe_hash_algo()' function, instead of switching between safe and
    unsafe_ variants of individual functions:

      csum-file.c: use unsafe_hash_algo()
      t/helper/test-hash.c: use unsafe_hash_algo()

  * The final patch drops the unsafe_ function variants following all
    callers being converted to use the new pattern:

      hash.h: drop unsafe_ function variants

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im/
[2]: https://lore.kernel.org/git/20241107013915.GA961214@coredump.intra.peff.net/

Taylor Blau (8):
  t/helper/test-tool: implement sha1-unsafe helper
  csum-file: store the hash algorithm as a struct field
  csum-file.c: extract algop from hashfile_checksum_valid()
  hash.h: introduce `unsafe_hash_algo()`
  csum-file.c: use unsafe_hash_algo()
  t/helper/test-hash.c: use unsafe_hash_algo()
  csum-file: introduce hashfile_checkpoint_init()
  hash.h: drop unsafe_ function variants

 builtin/fast-import.c  |  2 +-
 bulk-checkin.c         |  9 ++++++---
 csum-file.c            | 40 +++++++++++++++++++++++++---------------
 csum-file.h            |  2 ++
 hash.h                 | 28 ++++++++++++----------------
 object-file.c          | 41 ++++++++++++++++++++++++++---------------
 t/helper/test-hash.c   |  4 +++-
 t/helper/test-sha1.c   |  7 ++++++-
 t/helper/test-sha1.sh  | 38 ++++++++++++++++++++++----------------
 t/helper/test-sha256.c |  2 +-
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  3 ++-
 12 files changed, 107 insertions(+), 70 deletions(-)

Range-diff against v2:
1:  4c1523a04f1 = 1:  ae6b8c75294 t/helper/test-tool: implement sha1-unsafe helper
2:  99cc44895b5 ! 2:  2b79c76e471 csum-file: store the hash algorithm as a struct field
    @@ Commit message
         csum-file: store the hash algorithm as a struct field
     
         Throughout the hashfile API, we rely on a reference to 'the_hash_algo',
    -    and call its _usnafe function variants directly.
    +    and call its _unsafe function variants directly.
     
         Prepare for a future change where we may use a different 'git_hash_algo'
         pointer (instead of just relying on 'the_hash_algo' throughout) by
3:  1ffab2f8289 = 3:  d7deb3f338e csum-file.c: extract algop from hashfile_checksum_valid()
4:  99dcbe2e716 ! 4:  b6b2bb2714f hash.h: introduce `unsafe_hash_algo()`
    @@ Commit message
             if (unsafe)
               algop = unsafe_hash_algo(algop);
     
    -        the_hash_algo->init_fn(...);
    -        the_hash_algo->update_fn(...);
    -        the_hash_algo->final_fn(...);
    +        algop->init_fn(...);
    +        algop->update_fn(...);
    +        algop->final_fn(...);
     
         This removes the existing shortcoming by no longer forcing the caller to
         "remember" which variant of the hash functions it wants to call, only to
    @@ Commit message
         functions, this too will go away after subsequent commits remove all
         direct calls to the unsafe_ variants.
     
    +    Note that hash_algo_by_ptr() needs an adjustment to allow passing in the
    +    unsafe variant of a hash function. All other query functions on the
    +    hash_algos array will continue to return the safe variants of any
    +    function.
    +
         Suggested-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ hash.h: struct git_hash_algo {
      };
      extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
      
    -@@ hash.h: static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
    - 	return p - hash_algos;
    +@@ hash.h: int hash_algo_by_length(int len);
    + /* Identical, except for a pointer to struct git_hash_algo. */
    + static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
    + {
    +-	return p - hash_algos;
    ++	size_t i;
    ++	for (i = 0; i < GIT_HASH_NALGOS; i++) {
    ++		const struct git_hash_algo *algop = &hash_algos[i];
    ++		if (p == algop || (algop->unsafe && p == algop->unsafe))
    ++			return i;
    ++	}
    ++	return GIT_HASH_UNKNOWN;
      }
      
     +const struct git_hash_algo *unsafe_hash_algo(const struct git_hash_algo *algop);
5:  2dcc2aa6803 = 5:  ca67de80971 csum-file.c: use unsafe_hash_algo()
6:  a2b9ef03080 = 6:  21b175b07ff t/helper/test-hash.c: use unsafe_hash_algo()
7:  94c07fd8a55 = 7:  850d4f407db csum-file: introduce hashfile_checkpoint_init()
8:  f5579883816 ! 8:  0c4d006e6e8 hash.h: drop unsafe_ function variants
    @@ Commit message
     
         to
     
    -        unsafe_hash_algo(the_hash_algo)->unsafe_init_fn();
    +        unsafe_hash_algo(the_hash_algo)->init_fn();
     
         and similar, we can remove the scaffolding for the unsafe_ function
         variants and force callers to use the new unsafe_hash_algo() mechanic

base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
-- 
2.48.0.rc2.35.g0c4d006e6e8
