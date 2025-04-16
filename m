Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C8120FAA4
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845607; cv=none; b=ZR3J27LGwwT4AuP1zfznx75p9UdqDBg1/pV20d3Y+AR6YYc3aYrIenbNFWkag0ihK0/PJsalCGZtOB/1gBtiK1pr44e/Yfi/8ZF0TyIz3hh215GSJvFNSC/q4kBMXbjxXyu3mWrj0Zw3kPv9mzkFmITfrgNjAOpsn9MjSWAOfgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845607; c=relaxed/simple;
	bh=HkNW7cuoDWl4XhklhRJwIxG6tOiKTr9ERcnjguDtIRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIVewwWNglK5Mj7aV54Yy1OTx1eRoOrnvUaADuj7q7lGY1Q6sHFltWcOzPmKnrHYSnpcWCcKrzEhYC+dM6E6nxKz82iXSjhtpPo7tyALQ+kV8jsYjZ9sEbRfGS72RMvo1ZSg1qKnpaFrBubPg+wPqksgyjLzkxTKL38+wRScS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Y+zvOmcQ; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Y+zvOmcQ"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 5C1quLy9hjZe55C33u8KQ5; Thu, 17 Apr 2025 00:20:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845605; bh=5lWh3o2+oYum279FiaEdzjvKc73v9eSC7ilp55a+Qj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+zvOmcQVl68VT/Egip+TPDFmCOPMipD8xje1t59+4K6ruVzSuHFYYlqqigqLxYHs
	 HpFzN6EBOp3qO4VRfah0Qp3CxoKAmOp5f6BVDR4vwYCLputd4qdI7cP7Lqzzc8C3o3
	 UPpcwiJHN4pdO92iNTSP4//TV48K5SC9bpih82tQMa/nmkdyLZ+zpYuTT9XPXhbTlP
	 cxxwJK8flvRfsfaQ37aKJJyocFyk2c1Qim5m8kc1gMqO55982MeW3nEuBL07zwOtwb
	 zbhjXYicG5uAeZqo7qLqzxER3XoGBeE4cLH5mKGyoHU0XmH+pfezpbT0WxqypUdDQI
	 eQKLyRztl6E6g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003b25
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=CyMKNFq3l4KqDfjKpYsA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 12/13] config.mak.uname: add arc4random to the cygwin build
Date: Thu, 17 Apr 2025 00:18:33 +0100
Message-ID: <20250416231835.2492562-13-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKUr3KsZKM32kbWkt5meEngj4arj3/CEdWjuG5T3dTND8gTKYH11rFif/7bHOPzxXHmfp80SZZdUVkrlW7XRURV3liiKpba7Z6MXfcU+/twMumM54pLK
 5smME/Mnad4kGsUZewo3AID8Cv0x9pzrRlemdUaZq1vVLJkgs77+4CBsBu/ByP6YZkWVhGymRWO2zMq/SgBa7wWLRJb6eNC9B1U=

The arc4random_buf() function has been available in cygwin since
about 2016 (somewhere in the v2.x branch). Set the CSPRNG_METHOD
build variable to 'arc4random', in the cygwin section, to enable
the use of this cryptographically-secure pseudorandom number
function. Note that the autoconf and new meson builds also enable
this function.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index e7bd07cf6e..330741eb5a 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -254,6 +254,7 @@ ifeq ($(uname_O),Cygwin)
 	HAVE_CLOCK_GETTIME = YesPlease
 	HAVE_CLOCK_MONOTONIC = YesPlease
 	HAVE_SYSINFO = YesPlease
+	CSPRNG_METHOD = arc4random
 	HAVE_ALLOCA_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
-- 
2.49.0

