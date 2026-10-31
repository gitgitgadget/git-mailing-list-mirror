Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793441802;
	b=OZvcSpo5RpIRGYtdF2H6TmX722hHDb87wU41Lu6ofj4blMq8C2AE950bKaxS8uy/X7CN
	 Mva0l7DX3XTXw9bJcmqgjHB/hKUo84EunAJjbBOw1jE3un1bzjxr/nxdQJXCSTJYzGHQO
	 tHlxRTxohHqDrrRWg+CRD7seeSD0Fp+RMO+GFsEGCbBOeAIRppp1DjBSVJkVeEaNOSDzx
	 G/v9Gg2apDU7goZ0TgcqnVTF92oPvhVLVPO4B9GqBiuf7Sc3LAq6KESCOOJPReTsq7k0v
	 IPYnA/a9PaONEzlp2aymxu7yairJAAh27+tPERVAJC7m5EJD4CbIaJshrrJ1fTLh33w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793441802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RvMpcNPDs+Vg3PdF/ODalrFBeTHE/sU5ywl+GdgHms8=;
	b=tPioNbPpKoh0O/m1vWhTF07SD+3oFvZWqND/njXh/afgO0AkKpelFHyJbxJVIOILPPSj
	 ftgS92OBdvqd3yYOsYnRrZqM6XBwUM/1i/f5u4cLwZVQIg//lsG6cdcjz7nEC9f1Vf4Dp
	 /L/ynOINBHAbn+ny7WQv3RDwLBOjKfjgQaNmGxK0O3Mmv5baFsy+zIhgk6QQRLhqiAoJJ
	 T2gAN9NrFkaxGV8AF+HQquEJyWixbYMC7E/2tfSd0ov3X8OkSEKYW56YGgWWIVWRJUsjK
	 uENq2sifMvBL8QBa4RM2ABlLzym9dKFO18xoWvdwNf7qHT3gKGemka+au5TCuEsNMyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WD6P8CMH;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B49606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 10:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55B49606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WD6P8CMH
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48b001cd92bso871092f8f.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 03:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793441801; x=1794046601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RvMpcNPDs+Vg3PdF/ODalrFBeTHE/sU5ywl+GdgHms8=;
        b=WD6P8CMHBkfW3Xc4eqatIQsP/XDg1PM/XsTzdw/9fTWr80lORHvbPiFokystc5S3Kv
         V1cu9Xo3Ip59NoUH7b5eaz2O0gIQFVrIgLDVJR30OHArM9AxfTNIlIt+bSxFFHoEpx8F
         z9j0lNLksNGbC5I58Z/x+XhZocTxhFU103Ta7msX3p+F1FZVz1tP9sOeK6I7ohUizjDU
         +M/s9LAjIYS354WUevsJi3s3LqVeu6RF78bsafX10Syx4c1h8I3R7UwbLJXzzpGFrcwc
         jn2I6zjmlV/PWVVl79j6VkBgK8I/oCn2mU5eLRO+Gyu0dCF37CUm58hWyJeozlynlUYn
         7CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793441801; x=1794046601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RvMpcNPDs+Vg3PdF/ODalrFBeTHE/sU5ywl+GdgHms8=;
        b=KpxVHFpfx0Svwt/JU+VNUEdDJcgjEcwwjbRgJdYZAwDT8xQZhSSkSz76kbyMHqH8s9
         OiKw7MTyI2J82VIJQOmnOEf1GEUejjDujjhdjGmy36pdkgSmXSRrlYYjnVRLmnaBaMr1
         DqclfPZwBGvHcftPxJ6wSIXzPZ8Sayvx8HdsVrqXbjhhLEmzqSmADTcAA9pBVfedAE9Q
         KSXm7F+mZbs3GAYSNEMCnqEVYZMrWpM0bZv+4KjEx4fh9WtsrcfAGXxZmzDAaxanI9Lk
         d8J8V6KSgZer2n3Tzro4XTyu0vZH0K5SK44QMK8DiVBtCXqy1XhbjbcshStfBGrbAB/C
         gtgg==
X-Gm-Message-State: AFq9FYJKLKCMCdfInKbsY8YTZ8MhFIuN+Gw0C2jRCLpsk2Puy2hOMdSl
	7PLS2CCANHYNMX1CqGirVSKjz+FsoH/BpP3Elal/nMdetJVXKiNJ3uY1V+Ownr4z
X-Gm-Gg: AYBFou0Q4rq2ad2w9Pafr7hgExegZU0mURyqblpK8v7bwGinECXYH/6zyznOsf97f/x
	vxLAcPUL8Z30TzynvXEEijfW72DginRXcvJLPImXaCb0X9n6Hj76qLQMiMTlUZp8i+GGXrGtUiM
	ua/79b0n+hz4FD93ggL1CarwXXfBb0Np1hjivWu4Lx8kVKFiMfgqeJdEdOQ/Wr11r234L9rTO2i
	NJfSoFBaU8ZFOHE83M1vW4S19w/mGT2OiyGyZPMb5OR02Yr+piz8Aj0tfnNVUwwUH//yEjETa7y
	I+KEd6f0WNnJvr4kr+dluUxqCNEjRpnlB+nnQKHowI1hr5vIn7y11Jiwp6Pzm6NnViojb0uBJ7e
	wG21I+DNm3GinB7BkmD3Bi6TXZ6Z13CgbEWWn+gUIKCVCgKvoLDoM9JEGZ0f1K2ZTe4+wYJX7Sp
	O/o2Fc/cyJFF35oSA0vWeGOA7tQ7GHGKTDhAOK8M8o08pbr8IdEtiL00+enHQfqOETdPiR033lc
	+dpCh3jqMlBL3FotwQk29oS/eUaD1NRyDKL1pDgXu4o5K4EEQ8Ny0CSdyJof5z/8vqFb/SknBRF
	jvFZvlw32LoVl2EescXy94izxi5wqatj1v+WNml7MivFWQa1IVQTFVNawrs7EiE=
X-Received: by 2002:a05:600c:1c0f:b0:4a2:150f:1601 with SMTP id 5b1f17b1804b1-4ac1709a7bdmr107132165e9.12.1793441800475;
        Sat, 31 Oct 2026 03:16:40 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf60f1076sm127220015e9.6.2026.10.31.03.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:16:40 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Toon Claes <toon@iotcl.com>,
	Shuqi Liang <cheskaqiqi@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v3 0/4] use size_t for a few more object and buffer sizes
Date: Sat, 31 Oct 2026 11:16:31 +0100
Message-ID: <cover.1793439137.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793352943.git.gitter.spiros@gmail.com>
References: <cover.1793352943.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks to Patrick Steinhardt for reviewing v2.

Changes since v2:

 - Patch 1: drop the redundant file size check since the OID printed by
   `hash-object -w` already proves the content is complete, using
   `cat-file -e` just to verify the object exists. This also avoids
   reading and writing the same file unnecessarily.
 - Patch 2 & 3: unchanged.
 - Patch 4: shortened commit message following Patrick's comments.

Link to v2:
  https://lore.kernel.org/git/cover.1793352943.git.gitter.spiros@gmail.com/

Elia Pinto (4):
  odb: use size_t for the length of objects to write
  diff: use size_t for the allocation size of word-diff buffers
  convert: use size_t for buffer sizes
  convert: use size_t for text statistics and ident counts

 attr.c                 |  2 +-
 convert.c              | 24 ++++++++++++------------
 diff.c                 |  4 ++--
 odb.c                  |  2 +-
 odb.h                  |  4 ++--
 odb/source-inmemory.c  |  2 +-
 odb/source-loose.c     |  2 +-
 odb/source.h           |  2 +-
 read-cache-ll.h        |  2 +-
 read-cache.c           |  4 ++--
 t/t1007-hash-object.sh | 11 +++++++++++
 11 files changed, 35 insertions(+), 24 deletions(-)

Range-diff against v2:
1:  8fcb9f10f1 ! 1:  4961a1824a odb: use size_t for the length of objects to write
    @@ Commit message
     
         The existing "hash filtered files over 4GB correctly" test in t1007
         only hashes, so add a variant that writes the object with "git
    -    hash-object -w" and checks both its object ID and its size. Like the
    +    hash-object -w" and checks its object ID and that it exists. Like the
         other tests over 4GB, it needs EXPENSIVE and SIZE_T_IS_64BIT. Truncating
         the length to 32 bits in odb_write_object_ext(), as happens on Windows
         without this patch, makes it fail with a different object ID.
    @@ t/t1007-hash-object.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
     +	echo "big filter=null-filter" >.gitattributes &&
     +	git hash-object -w -- big >actual &&
     +	test_cmp expect actual &&
    -+	echo $((5*1024*1024*1024)) >expect &&
    -+	git cat-file -s $(cat actual) >actual &&
    -+	test_cmp expect actual
    ++	git cat-file -e "$(cat actual)"
     +'
     +
      test_done
2:  42d4eae985 = 2:  b27ef2a888 diff: use size_t for the allocation size of word-diff buffers
3:  88ca2ceb80 = 3:  1617177880 convert: use size_t for buffer sizes
4:  84e9e38a3e ! 4:  153463b531 convert: use size_t for text statistics and ident counts
    @@ Metadata
      ## Commit message ##
         convert: use size_t for text statistics and ident counts
     
    -    gather_stats() counts NULs, CRs, LFs, CRLFs and (non)printable
    -    characters in "unsigned" fields of struct text_stat, and
    -    count_ident() counts "$Id$" markers in an "int". Now that the buffer
    -    sizes they work on are size_t, a large enough buffer overflows them.
    -    Unlike the previous patches, this is not specific to LLP64: "unsigned"
    -    is 32 bits wide on all the platforms we care about.
    +    gather_stats() and count_ident() use "unsigned" and "int" counters to
    +    count characters and markers in buffers whose sizes are measured in
    +    size_t. On platforms where size_t can exceed 32 bits, large inputs can
    +    overflow these counters.
     
    -    The counters only drive decisions, but a wrapped counter makes the
    -    wrong one. For example, a file with exactly 2^32 lone LFs gets
    -    lonelf == 0, so will_convert_lf_to_crlf() decides there is nothing
    -    to convert, and a wrapped "printable" or "nonprintable" can fool the
    -    heuristic in convert_is_binary(). In count_ident(), going past
    -    INT_MAX is undefined behaviour.
    +    For example, a file with exactly 2^32 lone LFs wraps lonelf back
    +    to zero, causing will_convert_lf_to_crlf() to miss the conversion.
     
    -    This is not a memory safety problem: the counts are only used as
    -    hints to strbuf_grow() in crlf_to_worktree() and ident_to_worktree(),
    -    and the buffers are then filled with strbuf_add(), which grows them
    -    as needed.
    +    Switch the counters to size_t and check the size hint for overflow.
     
    -    Use size_t for all of them, and compute the size hint in
    -    ident_to_worktree() with st_add() and st_mult(), so that it dies
    -    instead of wrapping around.
    -
    -    Triggering any of this needs more than 4GiB of input, so no test is
    -    added.
    +    Triggering this requires processing over 4GiB of input, so no test
    +    is added.
     
         Suggested-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>

base-commit: b9e5cff1803ab24582201ef059516eb16014b9d9
-- 
2.53.0

