Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890940;
	b=g3vO65T/dFmAEnyj5WTMEDrmWJlMK7wIByev2FigXrKFzKUYbl/ZxySz6rZX888+9EpE
	 sE2PYQzkg8Egbnskv5DuK0kY4dlVw+iPAuQ3k0dp/xkea8wxIUNfRo7AWeiyTWC0cr8Xo
	 sPTYYFZoQ8RJSbZPhSxva1+oiLLlqedCuVwmTJiWXBTeWaUaDzWcUxH8mMxiiUXpbf8cZ
	 Vc0M+YtVs6rrK9RZXTy1IBlDReWtp4inZZF3KfhA9PnzDwJbybpEaAfeccvYVhq8ZS7E3
	 HsCNdyG8NrPnMHFWNwwQraeAAnvcvGaF+GBmTtTSerNFzCH1rKlv8D6FP7XzDT0ke3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890940;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ta1Fz4ae+yEsIfju2ShNhHZgEglYKyBP8t40L6aCmZY=;
	b=ocAIx3yrWvRWtyL7fWDJOh3FJBqBdKVPA5tMV4KQNtzj0ojKA2Ni03LdYWQqXIsIYExM
	 icV5UqoIl38LbXpShN0ck5eG1Cf2tydEiV4G2ecgR5cnw9IMpL4IotQj5NeaEschkPqI8
	 7bsWIlF/VrS13VtJ0+YS7jvLexmr7kTOrej3HHPXg4cm0pczTw7Vh2+ts3qNPBs1tY+0b
	 q5soMEvIDFTgqmJg7qbR8h7m10ipXTvm3cwNmVHxAs7PzBiojKUTBNCOelUtF/4yVbrKZ
	 o+8YNx9V6VaE7UU2DAm+Ittcl8jBYTnJcmHoyuJ8HW/D3eklsu2BMb+sxBo+iqOC61Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=OR0aNtAL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bmx1gr3O;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B053606A33B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B053606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=OR0aNtAL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bmx1gr3O
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1188914000E4
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 10:02:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 05 Nov 2026 10:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793890939;
	 x=1793977339; bh=ta1Fz4ae+yEsIfju2ShNhHZgEglYKyBP8t40L6aCmZY=; b=
	OR0aNtALCzN20U9BfaB49H0MgVxMS4/MWhPVYKN4UOSKCu7ImO1TDeToEH/fAUHJ
	2tDKSAW+HRdz51skEjm+QcxngaY/TBUFQe8+sWto6zkhd1hy9dteeI86XIt+bDCL
	W/WfawdNVLW1aZ/oNATOD5JiTG4j290nl1NUYe3aYimSbwOD1cKxBdax1J5Pg6Ng
	bAT/ZkVztGlU48VxaRk6FqU0iy8oTIFUantgEgZ2kHLrPEx8z9JCVMa1Xnis1EKC
	OnJdCbMu6TNNU7YEMvTW+qXarNXLwCZ6uqunZRDS9fx+Je0jZ5a9FAReW+W9CGCm
	nbCUaYJUS7i2JEi3qzMmBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793890939; x=
	1793977339; bh=ta1Fz4ae+yEsIfju2ShNhHZgEglYKyBP8t40L6aCmZY=; b=b
	mx1gr3O8K+QcRKtWWH1/QcWAX3CdTkx0fh8fnrqO3141jD5jturNDYeRCuWORY+s
	jVbMWY0LUnXlqa1NV251+87WIHgnsh+4QmW3Tqjihj66rfCRtH34msiDHpO/fOMU
	tPyHicO6T+cxi2X4290cC0hRI1ySe5V9Lustv5nmeXx5Fza+JKyoWZ742KDCy2gc
	4I3gaRnlPGkwx/b9ldmR555mKed7gthvZ73akWgttxpKkk0OzIluuDGpYzg0pUDo
	1oaGACpufUZF361VspFN/nFX8zhqxZUo1wN4QSvMWxWKjmjd8BaHPh6A8VETE4CO
	veaT9kgC6MPIO14aYNqMQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793890939; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Ei8imikzbiDZNNswrlPu2uugn3ZCkDduEzCy2FUu2r+ojf7
	kcDOfgxOrwPxxfaZdGUtcPl1GGNOJICsVB6hXZo5Y6k3uASciXM92Nxo2grigKs2
	KLbS3te5Ssjf0W5PLIEw/4zDxHcGLHUbtXZ9i3j0VhTaxjTcaHVAjNYGzvu66gay
	FJWXg2k6gaxZ54r91+zI11Eg52dXJamfAy0HQhNSmtrCxtWHZq1nktjm5zzzUwTP
	meGwzR+Q3+C0XEoW4Mlb4VQ1vIYnRgcJKQZTMh7QjCyBuSGLRriJrN3IUnJKD+n7
	jCDB8k1jdeKaoo9KlRGUk+O3nrJ3CM22fq0finA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BGGg4VhNymIvdjY1F1GS0xI0aKXeslZAoKbqzFSYO+4=:0n6SkpgfEuypFLAwMEHX/WknNIAzbyvN8Q10tUUJ/UU=;
X-ME-Sender: <xms:eprsam3FZPRT2ruy4k9Y84CftAv6CnxD9jBTaM49J3k4UaY6dBnl9g>
    <xme:eprsagASZMUGh9wqJhm6EIvoV6odt0p6-x5Pak7Rh23ngQhZXaoEIuKSbcezvf1HD
    is5VwR9KDOIvS68f0_DDMKdh62MG30IWKGulo5jxxQ9xIv175TDEWE>
X-ME-Received: <xmr:eprsakgV6gc4bfOYkKgVxH-FDL3tssTOLfrJHgg8Vj-t0m2w0SGp3Q>
X-ME-Proxy-Cause: dmFkZTGqtABMV/Ng5DPpJnKcqa/f6eamioVcKyE6/bDZ5WBL3jEqqBxrtFxVMCtiLJAgJY
    mBLrBuN2AF2kwsfF0Qes9TVosqOyScdmOuCblWuAw42/c5XS8xOFxs34vvPTvyZ44mOf02
    a9XyoJsfBm2gsCrkzTIX4eTJQpYiHwEs8z2RmoA4aAcOW5fgoZLqp6cBheKxcJQht4FqxK
    wvOec/TsgLHDkrqXlPa6AZSM/YfhwXRwdeAHlIdggR0o4ciOiW4HcZLBWP93BkQuUwZFKS
    2onmbQDox5lGtDDWmVDbnN32lykStH9d8vqcpCi/poZ2EuQ251IJ1ZZ2QOkgoISKIvIQaj
    aScY+WJv5QvwXZvrR+cpPNZ4s+VAh7YMYCYRU2NrwCeuQ8gBMY/oqUF8xFexeDlkyAwEZ5
    ds85ba4PflThhl6UR7TrobZWUgozqU26u38cT9VcYQbwgcNuSYw9VYwHk5EvEgyLgw0p5X
    JvidxE6baZYWXkToUvvdQnCgHe5IK0OByAuiUMN/jGTaYl4a9yo2oOT2qnJqLM/tQb+2MT
    NP6itlXqpd/sYrb3Cq9pDvFPJw0Pjvl9+kNvPIKrj4P4C3nNQId74jmikEitHoIhwSDhbp
    3x6CmL87P48wX6vTAStjgdnSwfsh9521fZ9DvzkJSmCv+T2+eVCkU166WmRQ
X-ME-Proxy: <xmx:eprsas9AnyS_NwJ5G-Rc6rEYjzCWWEGQmxWdotWXK3YUxrNQVZy9eg>
    <xmx:eprsao-HAY4AnJAE0OUu2BZsMi7tK4mes78JuUP0PB9QLWu6Xl36HA>
    <xmx:eprsatAe8JHfJ5SxT85KaVGD4iFLoy4r2rl8acY_W93Lw3dYEQbFmA>
    <xmx:eprsagwIq7UvlglE2tXHoj5m3ygvBH-ORgSjIomDfk_yvyDnO7z9OQ>
    <xmx:e5rsagFisepKDisDI2eR3xRF0e1RAP9Q9zblEvhQrmS4O3vrwJLqCIOj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 5 Nov 2026 10:02:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8440a118 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 5 Nov 2026 15:02:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Nov 2026 16:02:06 +0100
Subject: [PATCH 5/5] t: allow testing with a non-default object storage
 foramt
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-pks-storage-format-improvements-v1-5-870bb4212518@pks.im>
References: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
In-Reply-To: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

It is already possible to test Git with a non-default ref storage format
by specifying `GIT_TEST_DEFAULT_REF_STORAGE_FORMAT`. We don't provide
the same mechanism yet for testing the object storage format, and will
instead use the default ("files"). Even worse though, we may inherit
whatever the user has configured in `GIT_DEFAULT_OBJECT_STORAGE_FORMAT`.

Introduce `GIT_TEST_DEFAULT_OBJECT_STORAGE_FORMAT` and have it default
to the "files" backend.

Note that this environment variable isn't all that useful, as we do not
have an alternative backend. But what it does allow is to figure out
which tests will definitely break once we do have an alternative backend
because they assume that objects exist in ".git/objects", as we can now
move objects into a different location by specifying a payload.

Sure enough, running with "files://objdir" shows that around 1105 or our
tests are failing. This is a surprisingly small number of failures, but
we'll have to fix them if we ever want to introduce an alternative
backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a893963f86c..7fdd8272162 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -576,9 +576,13 @@ export EDITOR
 GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')
 GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
 export GIT_DEFAULT_HASH
+
 GIT_DEFAULT_REF_STORAGE_FORMAT="${GIT_TEST_DEFAULT_REF_STORAGE_FORMAT:-files}"
 export GIT_DEFAULT_REF_STORAGE_FORMAT
 
+GIT_DEFAULT_OBJECT_STORAGE_FORMAT="${GIT_TEST_DEFAULT_OBJECT_STORAGE_FORMAT:-files}"
+export GIT_DEFAULT_OBJECT_STORAGE_FORMAT
+
 # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
 GIT_TRACE_BARE=1
 export GIT_TRACE_BARE

-- 
2.56.0.500.g5d06dc02cd.dirty

