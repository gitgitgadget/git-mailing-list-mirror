Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793547418;
	b=1bIggp/vHVIVA/lMtP4pGhxAcpITLB0HsMP+0QpcxKt/volwMJwWuKWgu5WciWeJ+nfa
	 CRcyB3chK5sv3iu0ZP4f2R/1AOBIFkA/zxYrWU8mjPoqsJqxxidECavn9u1bJPN2XEXI+
	 LdOw7llp3+QdgD402DS2zE51T0XSokU36RipQfHO+vIQKMXZpHbsmKGgTbrup5jugWi5p
	 Dn79LH+gwbMpRfPBhlhm0jdd5wKtSiSwR3aLWKqTlFC2fn5s6v/4rMPX6eeu5+N/CDw2c
	 SAh5xkIajnBjsvtar6qMYPvI3urXoprQdUPiuWbrwEuOcBCwIqtJOnhEFFaXJ0DtWDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YMh4c4VkmQ/yYv/XXlB4IurxkSbZBL5yqcukdWFeZHU=;
	b=A44fLwnKvQskuN9YWQ0DlzKFR052JHy9cPgTEQwQDCO/f4bzJPAiPKMEgJoCqhmfc/Tx
	 ReO9iwft83u93SlCd3Y/TbZ3+BAsES+iWbLxFVTmPZccL4N22YORWrOjD/le6ZkzDGn5s
	 BLUNOAI9YWFTVr3F3X0y/nXjbDOiFd1A/dg1ZxMV9IX9UT78cQzOWei8S14ILPn0nCArf
	 ncqCPiFcoY++rfLn32x1P4nlEQfHv0a6xDmT96Tdi/OLcGw54ivsQXYxAAQJ10xzU6kCy
	 cmYG4cSFwQyEaW98swxP9KUrkzU8gEwzAXn2LSg2cFoWy5lz0R1BxdKq9t2MRnfv/Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VT+u4ttp;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD1606A327
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 15:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73AD1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VT+u4ttp
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c4d870d54so1251204f8f.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 07:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793547417; x=1794152217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YMh4c4VkmQ/yYv/XXlB4IurxkSbZBL5yqcukdWFeZHU=;
        b=VT+u4ttpIRuZxp+BBBdUBFnB4j+NxXAv77KrquJj3gPA100/HOqZ6K9AkJjJit4aV/
         6Dp1FeUMjf2qupb33vMaNM/aYosGm2O+f3Dnmp1VRmRkmRz54JGUuPsQzV6gNeIJVTC8
         79Kd2TkRdCrQv4NI5JIlnqNUYaAYYioGcgFR8Cz6fqpLsT15l9mb9s5ka1Gnf2irtvI1
         mNigu1BiM8yZKDW4JD71mMgZwMS/tTDSTpzhK83linr93mLNmQX7GWsUZy/r94Pi0UHO
         pQM8pun2nRB/DXPe41rLn0hOPnVBj91lxU8+KNQJnIoQ7y8th8CpcdVHa2tg1LK1N3GH
         Hs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793547417; x=1794152217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YMh4c4VkmQ/yYv/XXlB4IurxkSbZBL5yqcukdWFeZHU=;
        b=lgTYDfITOZ8chDQEHbNd28jh1VFotTPrBwdwSM62InDNsHzkRdNhFADHHtUzNm6MGs
         AS4OglWF2KToyskWR4d4t4CdWpp4zCmFB7vYxtWWjFIdpn6h9FNnUCDAQZqZgD/zAcN6
         tszMF/325G4Sa8+9oFQtgFUJgI3pOWQbaEnu2QJdyADKcWRWnbt2auK2IluiTyKKNggi
         PsrvYqab3DCdd6jAtpt2vnhkyGk/Krxe/G9hj7X69Mr5KNAyRZSyV4Q97MbNrv6S4knW
         Gper3aTkraVisZq9K4ihr1qtPt/khKWldoQVrE1l19XaJJho6K6KL30wSo2H99sfVFVV
         jwKw==
X-Gm-Message-State: APuU4Z8+YHj1BDj6xnY8mt6QAxCJBu0x7jzSmtNYiDT9h3S5ZqZCgBm2
	172zBatfyytF5vVam3mnaJ+ceKGMxiL9O0vi/OFvJK0Q82gG5joiF6W7cd6ukOD1
X-Gm-Gg: AYBFou3f5ewZfr94b733VzsyqHjvdhHCwzdpOH/7nzrjHrYyDfzkBz+mdrRVU6WGNcF
	tvdSdONus6NjLH4sCxN29/V2NWaTvsrWQ1lJC83zq8EUrGzoDFo5DjJCG6AxoIgLEPdg0OV4B60
	GJRb4Wvyfl5vUcMIV4nkVdD9L+seTkk2AwqH8J1dh+L+6HrhFd+vfkHZbXVrKXHymuQ/jAh/7k6
	rQ+fwXojxIrfWkln7le6WKhjnQgqV0h3Ta0hZ59E1GCOBgwtvG8im3M0JtNLL1FtWrcGHVzRSNG
	VCiGQcVs8YHF30Ya9+dP2/LempKxPdOmNKhTgAZD1pPY1uFnh/MfhlYoPI8mtobLz7PFyKryZz2
	H88l8JlF8zv8atjQfXSZHiijSaMe7BqRokVFfpGkhOEj/h/cwt+Lgiks+15CK1VzdndmXSlNsH5
	mf1Ozjky+srrCO+zkFGN7PK0W1CwYlEi0lDOolXJXZScEoGDwDyihXuBMMfahgoZ/qEfe8ys73o
	brgRcbWMTT+ZJBsjKdXkzA84qHelpi37SrrjBMzUWx+iIyEds8yIJKe4JR8Gas3gLt0LEQcRKDS
	lfk7kNMCwVV0N5Z1gAh/6K3oLKHUH7KW9BoONvWlLVTzv8soXLjZOgsx47rv4b0=
X-Received: by 2002:a05:6000:4b0b:b0:48e:1b11:7ed0 with SMTP id ffacd0b85a97d-48e6e2ff15bmr15563718f8f.33.1793547416626;
        Sun, 01 Nov 2026 07:36:56 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7246fsm14908450f8f.19.2026.11.01.07.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:36:55 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Neeraj Singh <neerajsi@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Montalbo <mmontalbo@gmail.com>
Subject: [PATCH 0/3] use size_t for a few sizes that are 32 bits everywhere
Date: Sun,  1 Nov 2026 16:36:48 +0100
Message-ID: <cover.1793546752.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Unlike the previous series, these aren't about "long" on Windows: the
types involved ("uint32_t", "int", "unsigned int") are 32 bits on every
platform. They were found by scanning a native 64-bit Linux build with
-Wshorten-64-to-32. That scan sees the "unsigned long" -> 32-bit
conversions that a Windows target can't see, because there "long" is
already 32 bits.

- 1/3 hashwrite(): a corrupt pack when pack-objects writes a compressed
  buffer of 4GiB or more in one call;
- 2/3 count_lines(): a wrong diff -B --stat for files of 2GiB or more;
- 3/3 hash_chars(): renames of files of 4GiB or more aren't recognised.

No tests, because they need GiB-sized inputs; each was verified by
simulating the truncation at 16 bits.

The other results of that scan are bounded by the format or by the input
(options, masks, line lengths, xdiff limited to 1023MiB). It doesn't
depend on the other series in flight and merges cleanly with them. Based
on master 50fe5cc63f.

Elia Pinto (3):
  csum-file: use size_t for the count passed to hashwrite()
  diff: use size_t for the size passed to count_lines()
  diffcore-delta: use size_t for the size of the buffer to hash

 csum-file.c      | 2 +-
 csum-file.h      | 2 +-
 diff.c           | 2 +-
 diffcore-delta.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)


base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
2.53.0

