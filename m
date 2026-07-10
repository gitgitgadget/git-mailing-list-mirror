Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88F28373
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783708730; cv=none; b=lWpON1OhzBOJV5miMxXu2rIeUu5NyQKf4ohs485yitTJdS1Sbi1PYvr6lgs3remwuEbqPOoBYoGaMssq+0/4H6X6GbJTbo0+M4GXQDnLyuH4nTavFfmtA9lWtPBt5WqI4jQcCdnAn9jlxm7jWYuk5iw+JyhxHuGDCaE4c3BeEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783708730; c=relaxed/simple;
	bh=Z2cPrODQfNwBRLWEp+plAGrACon8BdDqNYRTOGo1Ibc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gtjaWOWWpx07HuVb13ffLAMP8PbDoeStbC0uJW0uqFftRNFGDv+VXgEAcLV9CGuEr7hBlM/NCNSbKl9DgWvaa1NZoT35gacuDISpHJtPFlGiKMWaX5WwgtssZpCD39e5ThX63p70sSwSSrI5RLg8LYwpJRbVh318+guYPcJ0qXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=TxX5rxMh; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="TxX5rxMh"
Received: from [10.0.2.15] ([195.99.11.174])
	by smtp with ESMTPA
	id iG7YwG9Y0kMb1iG7ZwGpzc; Fri, 10 Jul 2026 19:38:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1783708725; bh=mP/moTDXy6puberTGtdJkdHqLJuRnxqfMtOgKFKQZSw=;
	h=Date:To:Cc:From:Subject;
	b=TxX5rxMh67ggsQsRXjVeIrEpgdhbqnzwgxUQ95oTlbRTtCjfSt8lJM6Fk3ZnFlqRX
	 xel6ATCFNFPf3GPzq0Ars3zeWheJLLHySPXFM+RWX0gDC5jHo3SE4H6D+JNjbNVCTq
	 hKWbP4KDjmc/pmgglO4a3P1q9bmRJVmZi1Hs0ZMv+DPSQdmDOWHgOULuBmmhOgp5hA
	 8w50XV7rI5b5ErfR47U6FuakOl1x0eSiWg8iameLwvRsDp3vlcSytFqIWYhoOXyJGt
	 Izcn8z1lG0L+1S78rFAopwR3z1I4A29jwAx76PXb3RbHQCIzIy9cQZCfqPQb8tTLW0
	 0E5qSKOtQTzLQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=AMGJABRe c=1 sm=1 tr=0 ts=6a513c35
 a=rWEfxJwGD0TuYe46u5FB7A==:117 a=rWEfxJwGD0TuYe46u5FB7A==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=VXpWQFiRVPoNdADV5XgA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <0c94331b-7eb1-4116-afa5-811082ad5854@ramsayjones.plus.com>
Date: Fri, 10 Jul 2026 19:38:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] Makefile: fix up lib directory move
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfON8/1MHkGRzzpwety9btnkxdjxVN1rOxo6ARUh8642fyzb6U7XPFffYiTVZeQBKWt6FjtBKOUakYu5ceBphoyPFczRM4kbII1D5Ch20t8J7G84qv9Ax
 NUh8/mESqBqRGqV9F+DiGcKH/lj+jnSo4tmPLZFMGoZgDLXH9EeNMcrbDpDJXwUyq99YbAzkmIa3LPoAN+xwLbrkY3WFo/X0kCQ=


Commit 9759608622 ("Move libgit.a sources into separate "lib/" directory",
2026-06-22) moved some files into a lib directory, but forgot to update
a sparse dependency in the Makefile, resulting in a sparse error:

      SP lib/pack-revindex.c
  lib/pack-revindex.c:78:17: error: memset with byte count of 262144
  make: *** [Makefile:3446: lib/pack-revindex.sp] Error 1

Add the missing 'lib/' prefix to the pack-revindex.sp path.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Patrick,

If you need to re-roll your 'ps/libgit-in-subdir' branch, could you please squash
this into the relevant patch. (This patch was created directly on top of the 'seen'
branch, rather than on top of your branch).

Thanks

ATB,
Ramsay Jones


 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 703772ba4f..a36d2c1942 100644
--- a/Makefile
+++ b/Makefile
@@ -2974,7 +2974,7 @@ lib/gettext.sp lib/gettext.s lib/gettext.o: EXTRA_CPPFLAGS = \
 http-push.sp lib/http.sp lib/http-walker.sp remote-curl.sp imap-send.sp: SP_EXTRA_FLAGS += \
 	-DCURL_DISABLE_TYPECHECK
 
-pack-revindex.sp: SP_EXTRA_FLAGS += -Wno-memcpy-max-count
+lib/pack-revindex.sp: SP_EXTRA_FLAGS += -Wno-memcpy-max-count
 
 ifdef NO_EXPAT
 lib/http-walker.sp lib/http-walker.s lib/http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
-- 
2.55.0
