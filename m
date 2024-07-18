Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE7620
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721265146; cv=none; b=ST1LpS8vdpQLqaiFKgk9aIAXeGQhqpVqNvFzZ7ARiEiUiRrHK+7ulBtPIgyAzU1evwDH073oFn5Z8O17nO2LnsR1pjfdXCFSJ+Gu9CMxgLFFfJ2gbNYwaCl5Crni/xKEOoIq4osQAUu0iIAQaU7KE5/voIMs1JfMFI3z3D6d8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721265146; c=relaxed/simple;
	bh=R1774bcsnpwu6tpk44VeUXIhwD7RFid2qgn6g0PQpp8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=DVIcsJIZ2DB6OBd0n9POaHDSRxP4GMo+AN7TRKze4Xb6rXkjoSUSnMs+jN+PggBwm+A2LOYSvEUumwDDqvtNHgL/DQbjp0WvbyBj0Lq3xQLsP5+Sbx8eTyqSFHZTQwB00MMwRNgJQi19KpVIvf8/0n/ZV6rPhn5QCWLa13seijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=DhQWGPio; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="DhQWGPio"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id UFgxs5ypoX9c9UFgys8mRE; Thu, 18 Jul 2024 02:12:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721265140; bh=9yqFoZFLPSkgXcSaw4vNlk8O9vhgJnxnIJTFUNL3Fyg=;
	h=Date:To:Cc:From:Subject;
	b=DhQWGPioP09Dukis187+/i3O385ade43Dkz65kwwFXz38k4YjgahzOcLKWW6wN9uW
	 aeLWZ5pMlOb+JdZ0ngxPVg6ii6ELJeZrDibmX9uPxvY06uOp0r1BKVAuUHwL9DQu0X
	 T9ivTwVLNkbrdvY6G++DNZTS41/QuCDeafPa4+jiXkZgD6zl9tDXGfE4ZTF+OJ80n0
	 2oVI3dyqvDinDAEQTCBfqJbB6ITdhMbV45XdzJi3IVGCgqk4BqonHHjfLtoMPIO6Ly
	 WDswAWInKw8kgUi/lkhaoAGcT7gDhIMDnERUJQmTNRmcv0aNEa20mWuAWC3SG2dZJs
	 8MiPrqNLqDALw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=NPx2+F6g c=1 sm=1 tr=0 ts=66986bf4
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=F33gzw5oEhwVvDhVDBYA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <587e339a-8520-48d5-8090-e8d8bfb0c1f4@ramsayjones.plus.com>
Date: Thu, 18 Jul 2024 02:12:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Makefile: drop -Wno-universal-initializer from SP_EXTRA_FLAGS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMsqAFvOnfQ40n4bYxT6HhQJXD6p8nTFp3lPUyHWNkG/455r+sJA7RogGgGrGOYhLcBBv9heUnBz3mMXG8EpnivzDbCcsPcnYPw4qrvEHkCfNx55Go1/
 OssZS9NK7WYwJdbCWk8laIvld4wNoH2N6BkHb8LmCzU5koDrqX/nxhr2w3uEHE7jS6VFFOZhnICjXTupe3MbskTqGivtNzun4SA=


Commit 1c96642326 ("sparse: allow '{ 0 }' to be used without warnings",
2020-05-22) added -Wno-universal-initializer to the SP_EXTRA_FLAGS in
order to suppress potential sparse warnings from using '{0}' as an
aggregate initializer. At that time, the default was for sparse to
issue warnings (i.e. the default was -Wuniversal-initializer) if such
an initializer was used to initialize an aggregate whose first member
was a pointer type. However, this default was changed just a few days
later to -Wno-universal-initializer (first released in sparse v0.6.2)
and has been so in all subsequent release versions of sparse.  Thus,
including -Wno-universal-initializer in the SP_EXTRA_FLAGS variable is
redundant.

Remove the unnecessary warning flag from SP_EXTRA_FLAGS, essentially
reverting commit 1c96642326.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d6479092a0..ce3ff2476c 100644
--- a/Makefile
+++ b/Makefile
@@ -1376,7 +1376,7 @@ PTHREAD_CFLAGS =
 
 # For the 'sparse' target
 SPARSE_FLAGS ?= -std=gnu99
-SP_EXTRA_FLAGS = -Wno-universal-initializer
+SP_EXTRA_FLAGS =
 
 # For informing GIT-BUILD-OPTIONS of the SANITIZE=leak,address targets
 SANITIZE_LEAK =
-- 
2.45.0
