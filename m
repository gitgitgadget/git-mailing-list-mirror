Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354341;
	b=kxCauGl2Nt3wVUyNUSvHesXUkNDHbh8a1o7KwkBr1EFdkXXstMsmgsj3lKiejCAU71IG
	 PbLm3taCsk7g0HvzjOgKSuvbjgi5J/5XqypMa+Ypb6Kz3KKef112oxmshsVcEjXk2wJ60
	 9iUSRFI7TmAzC7MYiVG1VxA36HVeDitGXVwXFm0I/OFLOev22HX/xHhQLviBnuDEhwRy/
	 zvUrXYKVEJ2QJ0Plx9Dx+yFlyvsB7Gqj8cFXo2GIrNfVbzm6gbRXDjvkil+Fbl9qrqHRD
	 XDjalfzOGKHi2dGgYtDc7SAKcnuWdPuOVPt3FHYu7rJI4lQlNKbemDx+4ktylJU+r1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0yuVB2QPGYFxZhqHLqluowKqlNUo1ufQKo3ulDSqXjE=;
	b=oc6rF5hQ5WzVThYlm7rxbp3n8w3ziyzeDgh1oL2qUYXJW82FX/bLU8psK4UBj7bqsp05
	 e4/BDg+NN1liappJj2JYLE/Y/wRxVhdRZEG0DUSLy+5iPUy78lPRmJ7+BRWMkvKHj8PXp
	 b9NpIzNImI54p1gCvQb768CCThDZCpx3Ke/dvUW3XXGYaf+tXZHTVan/m7FpyAf9S88m9
	 TtzBQeKk2j+Abu5j9ShXIzlW7ext+96IIZqn+qgXoF0/2RoBSZDRUG4yDXOaYTYRc4ALJ
	 B6+YTrii6EJh7DrxjvFMgICamkJ5DEMhvg/zx4dhqQVmdczBzRME+FAvuCSUtGzoUtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TFH9TqOK;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70309606A31D
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70309606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TFH9TqOK
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48df4f540ebso232353f8f.3
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 02:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793354340; x=1793959140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0yuVB2QPGYFxZhqHLqluowKqlNUo1ufQKo3ulDSqXjE=;
        b=TFH9TqOKbphuSHhRgZNjbwBfMvr6p1UUI8u7KX8j2kGMlMteqa0VqAU6zf/mWFWB/i
         kWMfguA97AmvzPA2UnT6a37Zx+GLmuAg6AaHEnaWiFGNEObztYhBsRUf/d1gMYUf6GIc
         GYYgiG24bn4xoAnJMmetfPjPyB0AR5cD9e+iiV68gVSVj9i5vfrgcs6na37AaWkoKd8R
         KvuGR4EXgt9dtOFSG5fT+N5LY5nm4czE0owcf796YoacO9oR8njyK0+QhvSF3A4XAk03
         8JNr72+NuD+lHCKOQt6+hHQkhmLuIDioWMziddcant2+u3y2hbGhYi08AOnxzyyunMS1
         +A1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793354340; x=1793959140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0yuVB2QPGYFxZhqHLqluowKqlNUo1ufQKo3ulDSqXjE=;
        b=nWIS16TNgABC7Vj7LyI+APootRZ4RjSB0/CMowPNPRfINJI8yb8Gd/LmnEbcYGO2kT
         QK6/pRbzUsZZLuuSUNU+jQOAOoF+e1KF8KO/9bDbW+yTu+xzUL/yBpJebyR8JX2DfOGg
         cI0/VlOIPdKHB5hmrIw4FOyCaM+wZz1M4RIAhlAzE/a65No+XGyKiPLsX8dxflPZDId+
         JzK2Na791a1RQzm7e3TTpRGU4Efgbl7cvFJHjIFPMSmFKxN/efUfuGkHemuR0AB/OnKC
         ExaPrmy0s0yVpkEdhg3p79D5z4gt19IIeiDzEEHbZzpaAKEnmRiprLZ7t98k/XOGYCUy
         OCPg==
X-Gm-Message-State: AFq9FYLIQ7/vJtojXLg8UCI6oNWGvx0FRL+tAk7KYReBiAqcpWQxNkqe
	02AkveX9NjHPV+phGlY6Pg0d4WBsHBWOyY53jPWFozwg/+mcvzddonTWLDd0Dln5
X-Gm-Gg: AYBFou13BvR1cOfpOJ+0hovOsYjwVuK6kKrnjyGKmHTuHr4eAbpc7y1CRvPSVCeXCJl
	YWFybiyNFyAdyWm4HrUrNipXI33I7UpPBsKxZ8B2c97Qb8JHMSvqpaF8TFpi2i+83vccxRhiVDJ
	CtGjp3hKLxxipBEeVrg1EjFueRRcHVh7Tr9rWAiPOZfxTMGYklx4gHsqmxhtE5Y+hiOVp89CPMa
	jXX+FMvKbbSlVjOAhqDOilKL1aMZ66HB9qXN/X5dI1PGEyWHHlrxH1+adIsjRWnd+RjfgiHCblI
	w/ImbwsSqcYDZ4wBw7XwG/x7PEoy7bTpSFui6Tw+6XcItWXVrGn9sa3CA05pedkadH2+6qUqpln
	u3wAhRBXukG2Nicgy6ymUwsMFjPGY3oO1e5X/3kzsBwY94yxQZcN5XnDmVrQH+mhCmaq+F475ce
	bi+cXxaYXRoKjUww03BQt3+53psNUC2UKfNXg7sbLoqKEOTnhJmhfkzQfE8qLvte/DdDqEiWjG+
	Jo86sip/0I5DQRVZJVmq9n47IGkdTmOnieUGZJUaIjFWPtOeh8Bxm0hIi8J38riSxyzc31l1xqf
	yaIub7BdZ7PvEEUNbg/UCatxKuV8bZlY9MPGeC+CU20uyfi6DA==
X-Received: by 2002:adf:e001:0:10b0:48d:f470:6b3e with SMTP id ffacd0b85a97d-48e6e30722amr3250182f8f.13.1793354339631;
        Fri, 30 Oct 2026 02:58:59 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9b54dsm2359421f8f.47.2026.10.30.02.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:58:59 -0700 (PDT)
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
Subject: [PATCH v2 0/4] use size_t for a few more object and buffer sizes
Date: Fri, 30 Oct 2026 10:58:49 +0100
Message-ID: <cover.1793352943.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021101640.329990-1-gitter.spiros@gmail.com>
References: <20261021101640.329990-1-gitter.spiros@gmail.com>
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

On 64-bit Windows "long" is still 32 bits wide, so a size_t that goes
through an "unsigned long" loses anything above 4 GiB. Like v1, this
series widens three such places: the length taken by the object
write API (patch 1), the allocation size of the word-diff buffers
(patch 2) and the buffer sizes in convert.c (patch 3). Patch 4 is
new. The cover letter of v1 explains how these were found:

  https://lore.kernel.org/git/20261021101640.329990-1-gitter.spiros@gmail.com/

Changes since v1, all following Patrick's review (thanks!):

 - Patch 1 adds the test Patrick asked for. The existing "hash
   filtered files over 4GB correctly" test in t1007 only hashes; the
   new one writes the object with "git hash-object -w" and checks its
   object ID and size. It is EXPENSIVE and SIZE_T_IS_64BIT, like its
   neighbours. Truncating the length to 32 bits in
   odb_write_object_ext() on Linux, to mimic Windows, makes it fail.

 - Patch 4 is new and answers Patrick's question on patch 3: struct
   text_stat still counted in "unsigned", and count_ident() in an
   "int". Note that this one is not specific to LLP64, as "unsigned"
   is 32 bits everywhere; it is in this series because it came up
   in the review and touches the same code. A wrapped counter only
   leads to a wrong decision (e.g. no CRLF conversion for a file with
   exactly 2^32 lone LFs), not to a memory safety problem, because
   the counts are only size hints for strbuf_grow().

 - Rebased on current master; no conflicts.

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
 t/t1007-hash-object.sh | 13 +++++++++++++
 11 files changed, 37 insertions(+), 24 deletions(-)

Range-diff against v1:
1:  0fff9532f9 ! 1:  8fcb9f10f1 odb: use size_t for the length of objects to write
    @@ Commit message
         source.
     
         The existing "hash filtered files over 4GB correctly" test in t1007
    -    only hashes. Running the same with "git hash-object -w" on Windows
    -    shows the problem, but needs another pass over a 5GiB file, so no new
    -    test is added here.
    +    only hashes, so add a variant that writes the object with "git
    +    hash-object -w" and checks both its object ID and its size. Like the
    +    other tests over 4GB, it needs EXPENSIVE and SIZE_T_IS_64BIT. Truncating
    +    the length to 32 bits in odb_write_object_ext(), as happens on Windows
    +    without this patch, makes it fail with a different object ID.
     
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
     
    @@ odb/source.h: static inline int odb_source_freshen_object(struct odb_source *sou
      					  enum object_type type,
      					  const struct object_id *oid,
      					  const struct object_id *compat_oid,
    +
    + ## t/t1007-hash-object.sh ##
    +@@ t/t1007-hash-object.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
    + 	test_cmp expect actual
    + '
    + 
    ++test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
    ++		'write filtered files over 4GB correctly' '
    ++	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
    ++	test_oid large5GB >expect &&
    ++	test_config filter.null-filter.clean "cat" &&
    ++	echo "big filter=null-filter" >.gitattributes &&
    ++	git hash-object -w -- big >actual &&
    ++	test_cmp expect actual &&
    ++	echo $((5*1024*1024*1024)) >expect &&
    ++	git cat-file -s $(cat actual) >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_done
2:  4ab9569f13 = 2:  42d4eae985 diff: use size_t for the allocation size of word-diff buffers
3:  7ea1a566b5 = 3:  88ca2ceb80 convert: use size_t for buffer sizes
-:  ---------- > 4:  84e9e38a3e convert: use size_t for text statistics and ident counts

base-commit: b9e5cff1803ab24582201ef059516eb16014b9d9
-- 
2.53.0

