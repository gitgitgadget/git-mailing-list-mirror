Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC5B5672
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364152; cv=none; b=c4Z1c2k9zZP4cgoY8a//j43zgOJYeA/mBhoswctwLt0bbGvWEScVBasVJD9zqr7C1JlNhZXSo8UWkQ2lBulq7xtJbin1i8Uud4wbIEZt236XLLKOXKlSIkRFNwRAcuhPh8zu6WBPBKz7dcO3FQaRiiAY0Jv1T//X6PfLyQM9DtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364152; c=relaxed/simple;
	bh=xc7C9xO/oAAhBQd5t3u6QRsqBp/VfNSTgKKaH2a8G7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbJTw/RTavVbj4hi+gDpyDjcjwI5N8vTirAyj6dQTwsYk4pKLv1GAFUHIaH1zUescy+CfgwNVS16hFUcAgT7SNVbhW5JgCTFJELQnzxXYirS+MScEp4SgmyIyt/muPot4hwV5BzPGRJpGOhXhSfkO40pK3Pe+wMqq+ovCGoXff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vdiN5WlI; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vdiN5WlI"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e22cb0b19aso10410567b3.1
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727364149; x=1727968949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3YJFs0N/VAzKPwDonhfVMmQmqZtS4sm0/drwtyI7h8=;
        b=vdiN5WlIysZZ61z9xb5og80KOPWF+l6XU9l0Kh44RHfvD6mtFem0j5I6CS+v7C24QS
         6DDhdjZjt061oP4hkjpaV2JGM27PmGIshUTT6iz1XnGt8GoioZrz8ZzkH2mBisxSxbSg
         TidFMLZaWrFhyHIAJgr56ln5dq5FCulP9VvBOSBl/Xskm5NMY04ybWrpVNGk2wlug205
         wamDsgRV9Pmf0zJ7BpxrSV9Of6K3q5o19E+lDMHyGgj/Ah9S2v6esYuJKbuCsHBU5zhv
         JSAR3Ppt1zHRdqoC6BIPqfsBAQpuLA+Z1MlcFP+XoIXk0U043rTnbfqdyMGzhblNcOEN
         WAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727364149; x=1727968949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3YJFs0N/VAzKPwDonhfVMmQmqZtS4sm0/drwtyI7h8=;
        b=TfqpXjd6lRTIwtn+S+C1QQBCnEUN0gmz/HsmqwAfcvocMakxk1WcyxhWa8hvXzrdVt
         D8cFj0v0znF6VaEs6BC65m/N1Jmcu2Jaf0bupLIQasCRNS0KneIykQqxeKe5FNA5hMxQ
         8NQV19OUG1isca6wQxHGMQXwAJelml5pRbjNLtPyLecuzhJIXBs6z24UsHxds/TiemBD
         eubfhqSvTrNq62ce8UxoEDJOIRjojQfxWDvL0+ZGsZjj3cHGZMzOV8b08kFeD4VOYGj4
         ZDopj5Ux7ABfCPSUrJm/6irYJFZ2WZJynbgyuOSIdZdKRcdOu6jAt3findYUzG7F2vH+
         fkNQ==
X-Gm-Message-State: AOJu0YwNvZP4ObeBs+6yfqCv3ZnGJsOycXJK9R1Fc7t5VGM+F8WfUIlw
	MVs7Ge+hCgOR2YYTqkgizzCkB/9ogR30gtEDfovyCFeLM4gZTp0ypMCfsdImwpI1MixlYaQvt+T
	uBeA=
X-Google-Smtp-Source: AGHT+IG1DN2wMpDw9+CxTnMBkcHAU5/fxB7NltREE26csd1Aq1T0xRBf64w66ZQufpzHxK2hgVXTjQ==
X-Received: by 2002:a05:690c:15:b0:65f:cd49:48e0 with SMTP id 00721157ae682-6e21d9baf76mr63838377b3.31.1727364148632;
        Thu, 26 Sep 2024 08:22:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e245386789sm158997b3.104.2024.09.26.08.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:22:28 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:22:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 0/8] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <cover.1727364141.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725206584.git.me@ttaylorr.com>

Here is a minor reroll of mine and Peff's series to add a build-time
knob to allow selecting an alternative SHA-1 implementation for
non-cryptographic hashing within Git, starting with the `hashwrite()`
family of functions.

This version has changes which are limited to the commit messages only,
and amount to:

  - Updated rationale for skipping the collision check from within
    finalize_object_file() when handling loose objects.

  - Updated commit message with some over-eager s/fast/unsafe/
    conversions in the final patch.

I think most of the review dust has settled up to this point, so I'm
imagining that this is the final version of this series for now, or at
least very close to it. But if something new comes up, please let me
know!

Thanks in advance for your review!

Taylor Blau (8):
  finalize_object_file(): check for name collision before renaming
  finalize_object_file(): refactor unlink_or_warn() placement
  finalize_object_file(): implement collision check
  pack-objects: use finalize_object_file() to rename pack/idx/etc
  sha1: do not redefine `platform_SHA_CTX` and friends
  hash.h: scaffolding for _unsafe hashing variants
  Makefile: allow specifying a SHA-1 for non-cryptographic uses
  csum-file.c: use unsafe SHA-1 implementation when available

 Makefile                              |  25 ++++++
 block-sha1/sha1.h                     |   2 +
 csum-file.c                           |  18 ++--
 hash.h                                |  72 +++++++++++++++
 object-file.c                         | 124 ++++++++++++++++++++++++--
 object-file.h                         |   6 ++
 pack-write.c                          |   7 +-
 sha1/openssl.h                        |   2 +
 sha1dc_git.h                          |   3 +
 t/t5303-pack-corruption-resilience.sh |   7 +-
 tmp-objdir.c                          |  26 ++++--
 11 files changed, 266 insertions(+), 26 deletions(-)

Range-diff against v4:
-:  ---------- > 1:  6f1ee91fff finalize_object_file(): check for name collision before renaming
-:  ---------- > 2:  133047ca8c finalize_object_file(): refactor unlink_or_warn() placement
1:  ed9eeef851 ! 3:  41d38352a4 finalize_object_file(): implement collision check
    @@ Commit message
             object name, so checking for collisions at the content level doesn't
             add anything.
     
    -        This is why we do not bother to check the inflated object contents
    -        for collisions either, since either (a) the object contents have the
    -        fingerprint of a SHA-1 collision, in which case the collision
    -        detecting SHA-1 implementation used to hash the contents to give us
    -        a path would have already rejected it, or (b) the contents are part
    -        of a colliding pair which does not bear the same fingerprints of
    -        known collision attacks, in which case we would not have caught it
    -        anyway.
    +        Adding a content-level collision check would have to happen at a
    +        higher level than in finalize_object_file(), since (avoiding race
    +        conditions) writing an object loose which already exists in the
    +        repository will prevent us from even reaching finalize_object_file()
    +        via the object freshening code.
    +
    +        There is a collision check in index-pack via its `check_collision()`
    +        function, but there isn't an analogous function in unpack-objects,
    +        which just feeds the result to write_object_file().
     
             So skipping the collision check here does not change for better or
             worse the hardness of loose object writes.
    @@ Commit message
     
         Co-authored-by: Jeff King <peff@peff.net>
         Signed-off-by: Jeff King <peff@peff.net>
    +    Helped-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## object-file.c ##
2:  3cc7f7b1f6 = 4:  611475d83e pack-objects: use finalize_object_file() to rename pack/idx/etc
3:  8f8ac0f5b0 = 5:  9913a5d971 sha1: do not redefine `platform_SHA_CTX` and friends
4:  d300e9c688 = 6:  65de6d724d hash.h: scaffolding for _unsafe hashing variants
5:  af8fd9aa4e = 7:  3884cd0e3a Makefile: allow specifying a SHA-1 for non-cryptographic uses
6:  4b83dd05e9 ! 8:  62abddf73d csum-file.c: use unsafe SHA-1 implementation when available
    @@ Commit message
     
         These callers only use the_hash_algo to produce a checksum, which we
         depend on for data integrity, but not for cryptographic purposes, so
    -    these callers are safe to use the unsafe (and potentially non-collision
    -    detecting) SHA-1 implementation.
    +    these callers are safe to use the unsafe (non-collision detecting) SHA-1
    +    implementation.
     
         To time this, I took a freshly packed copy of linux.git, and ran the
         following with and without the OPENSSL_SHA1_UNSAFE=1 build-knob. Both
    @@ Commit message
             $ callgrind_annotate --inclusive=yes | grep hashwrite | head -n1
              59,164,001,176 (58.79%)  /home/ttaylorr/src/git/csum-file.c:hashwrite [/home/ttaylorr/src/git/git-pack-objects]
     
    -    , and generate the resulting "clone" much unsafeer, in only 11.597 seconds
    +    , and generate the resulting "clone" much faster, in only 11.597 seconds
         of wall time, 11.37 seconds of user time, and 0.23 seconds of system
         time, for a ~40% speed-up.
     

base-commit: 6258f68c3c1092c901337895c864073dcdea9213
-- 
2.46.1.507.gffd0c9a15b2.dirty
