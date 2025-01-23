Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E45A4D5
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653661; cv=none; b=dzUSycTdKfdMzE1gzP4/V4Cvl0YGLrRy3MLnM3dUz8wUEydakYJe+zK+bulmgcLVMCLLeCj3Nd6Ebw5Dn5g/av6R7Blftc6ULn+z/t9g9Xb0yqLGkJPB3LUCjRo2qCY+C3RmwyrNbE2sm2cpb2ks5i70X5YE3ErCB/uNcEzNCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653661; c=relaxed/simple;
	bh=SRS9AL8ZMTLUOM2dGi7bFw9Ace6/02/dahFuTgB1Agg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eO6NvFr9jzVrBLsYLIkFlSvY7mpuqlVHfh5hWjtC3uHNGVoqb35XspNnBHt4OiM+X1oeFSjBN5ZcZHSupkz7cWaJdb57kVWnM8ug6fKn80urG8yQA+gXr9vDiPRTgv720wFXma7jvzwZikmwNH8Di23Wq3IKVIH81jWidZHdAEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=S9dOntBB; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="S9dOntBB"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e46c6547266so1754588276.3
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 09:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737653658; x=1738258458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8GLzVrLuYEk+jQD/Y5GdWBTrUXzIf7+zx8qZbwTKumQ=;
        b=S9dOntBBrVTvqx67U7s6CJoakS9mKcrWsYRtvGniJ0P+P46f6c4zQZcRi5qa7FuANm
         8aymgyhO/4qsEp/x/FoxFiXWneVXICflCnSWtK4jtwdd8ewFpZ91XSuE12i3i2b9cA7Z
         6/H6shhbcpNzxdnjCjH/9KH11wk3zXoXfTzsLKlSkh1tIQTGAzuJ0tniZSnnbrv7Fjgy
         bUVVem8umfE3ezH2ftw8KqzAsQmIds4TuJVTshdrHH8A4j7/XNEal5z1rB48eqHIXKe5
         VDff3+jmuLk+GSruUSoOVkRj8JRzNfMyK12Z10QdAgz6NIQzd09RWdgBN3I7N6ZcGWpE
         4fVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737653658; x=1738258458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GLzVrLuYEk+jQD/Y5GdWBTrUXzIf7+zx8qZbwTKumQ=;
        b=MPOoCma9QqvKjFNMv1hp9n/KrF33Kjle4J7FXwpeSo5QNx9LYh0jNKIihJ25oaXxWZ
         JrlRrvcqpu7MKclMu7aqca+b1JdJMKmWnIgkJVKI8YI/JxGvCQxu/+UBXWVPtu1zSRCD
         dszQa+e+Dn60Sj7BdOm3lp5+dOKDMqIHxJs9NuYhUpi4Z/R4JhnWVMSTfXSFpc+qaEN8
         zuRDyQlI/HMtv1bE+VGoVfgrFyrVoIRFQ+bW3nkT2TDQ/vEbNFnvA0mHWPrBxUBNkdaU
         LziskHz4o7mtIZSgtLqtfiLs4FQVqaUTueBuQK4XJjE80zFlkxG2QxvkDagCNJwZofpB
         4S9A==
X-Gm-Message-State: AOJu0YzZdSy2+PaSdouOWkMrc1FbsPXhDfgktQG4mkMAf7H33WelpPH0
	SdA/39fPwXYGUo61wq0tZSyzc1MqiIiUYRNca7x2Qw7NERkzYE1qhTWnwZ8mPBz4Tvxemliqz32
	QKV4=
X-Gm-Gg: ASbGncuh9bnb3yA0h/400cXtL5Zt6mFY2VhsaAa3PsbBGTzFrFd5PwNm2o8i/XvljU6
	BTXuEX+wsNYqcEfKXMVHUM4J8SCwp221JDYCXnfgfuxNaeAK6g2QIZNSYCNO7M0n8sng/pDyM55
	WEoBhtTXdZLJGHYLd2Y5OgoRS+4YzIdUEgZtr/WIAXWTBJhi7YIQXvHNqYntXGDYNdKewuOfKjK
	/nVt+QdlmHqRRa8q9I/RxE8pjbxpMy652urwBD8KZ4iTzrMNCC/r9Gp/ZS+9UC4Wi4TGGAl4nwc
	5hbkevBRh1Lb+SzixpgYf+kzVhdhRoWNh/g3NhpUckoZc4eWDKJX
X-Google-Smtp-Source: AGHT+IG1ldhAdwS3pDWtAsVAjpQWtui83fT4NveBLQ+RXSp83GjbwWaZQuxS8iXVSsqePtBf00f9LQ==
X-Received: by 2002:a05:690c:6f8d:b0:6ef:579c:38e6 with SMTP id 00721157ae682-6f6eb90d626mr207579477b3.28.1737653657912;
        Thu, 23 Jan 2025 09:34:17 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f7578770b1sm483497b3.8.2025.01.23.09.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:34:17 -0800 (PST)
Date: Thu, 23 Jan 2025 12:34:12 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/8] hash: introduce unsafe_hash_algo(), drop unsafe_
 variants
Message-ID: <cover.1737653640.git.me@ttaylorr.com>
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

Here is a hopefully final version of my series to harden the unsafe hash
algorithm changes added in v2.47.0. The only difference from last time
is that hash_algo_by_ptr() now returns GIT_HASH_UNKNOWN for NULL and
unsafe variants, which is a strict improvement from both v3 of this
series and the status-quo on master.

As usual, a (small) range-diff is included below for convenience, and
the original cover letter is as follows:

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

Range-diff against v3:
1:  ae6b8c75294 = 1:  b64ae238248 t/helper/test-tool: implement sha1-unsafe helper
2:  2b79c76e471 = 2:  d03f503682f csum-file: store the hash algorithm as a struct field
3:  d7deb3f338e = 3:  73554c3b881 csum-file.c: extract algop from hashfile_checksum_valid()
4:  b6b2bb2714f ! 4:  ae01f1f4274 hash.h: introduce `unsafe_hash_algo()`
    @@ hash.h: int hash_algo_by_length(int len);
     +	size_t i;
     +	for (i = 0; i < GIT_HASH_NALGOS; i++) {
     +		const struct git_hash_algo *algop = &hash_algos[i];
    -+		if (p == algop || (algop->unsafe && p == algop->unsafe))
    ++		if (p == algop)
     +			return i;
     +	}
     +	return GIT_HASH_UNKNOWN;
5:  ca67de80971 = 5:  64a850c77ae csum-file.c: use unsafe_hash_algo()
6:  21b175b07ff = 6:  3dcccccf752 t/helper/test-hash.c: use unsafe_hash_algo()
7:  850d4f407db = 7:  da97157c4a1 csum-file: introduce hashfile_checkpoint_init()
8:  0c4d006e6e8 = 8:  0ba27182b5e hash.h: drop unsafe_ function variants

base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
-- 
2.48.0.rc2.35.gd215225db14
