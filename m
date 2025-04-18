Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983D4CB5B
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995752; cv=none; b=gtQF0Ybrf4rWMOOq799tH5/hZIvkv7JEj/In9PuUkBI3VXnDGTo6CsTzZo7nGSB3n7zVLcLlYrj1p8/pCRBe9hx2ntcaymTHI32a3XLuFuL4QKPmYNcEmkwrWakui4DrU+LAxkGaRB/l0dTBCYReI26O2+sGzeAAIOB6oHO6X8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995752; c=relaxed/simple;
	bh=DkTIc+k0jM7SeNa8TxenRmZEYT4lAgWMnjb1xHaA758=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fSlZ8sIuEtVz0tw+SHtQ0ONalkjUdcyIs15aHkqKt1ny+lh6f7Nn+Skacp2/G0NYJBLh1XUiyAYITe3XWHYEl9pAuQoQ7LObQfALnphzrr8g7Em0pd5xsAu9CgDb04oouA9rMc1O+ZdnYtpRRoNLE2MN4ID05XJSH+HS1XdPDxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Qzmx8UpF; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Qzmx8UpF"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 5p3fuwOZCbpaN5p3gusVZU; Fri, 18 Apr 2025 17:59:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744995560; bh=ebuge/toTHkDbwYU8buPTmFqW34V2Qj+K6ExU4N3ES0=;
	h=Date:To:Cc:From:Subject;
	b=Qzmx8UpFs+7ayAxOK6YdWpzgLnAcuzqscshWNXbw/CsOj8VxeZ+TBT/s3ywAXpa/p
	 tcqpy0j0AwjLKvjK6uiGnWCl+CLRvxv5zDK4geS6C0TJEgX7ljhQrDyj+v8xQTv1ns
	 +oE54YKJcR1GDl8DOElMq2YshGYQiR+IXzwPl8ET1TOEudm3mJVPrF/z8a7n+Kc4kG
	 BR7c00kAl42h76R2gj8XFwLsumGUKr5+XWpQtfrYwmnldiRW28i5ebjtmIQz7qthyr
	 aXBwn1SZGbADask8wibw6oUL2VtjHl2GbwH5V4seB6TDFZTYQXFE3XwE+/Neapj41j
	 npV+6C2uvjTtg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=680284e8
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=N3v7StLmO1EeATad3UUA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <67c50fde-d29c-404b-a296-9f0e482acaf3@ramsayjones.plus.com>
Date: Fri, 18 Apr 2025 17:59:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] t/meson.build: remove deleted performance test script
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGfXJa2dO0sQSQBriU4hU1Yhj3o0zTAPkzW8TDWejXOzmsVzdxCL/rnnnSS96Mo5hzw4xYvuAmAdq+c9paQM7CEhfGg9nqTzXzIns+2xiGGpqihDa5n/
 pWVQfY6XQC0NhcasBpJ2sTrk60C1kQ4NXyTnTMzqfSAvTxoXNkf26XjoOiNX8Nd4aMz6EoBN7rmFQ0FqTyw2/ogUnKHQqtC7dG0=


Commit 8b0b5c7046 (p5312: removed duplicate performance test script,
2025-04-17) removed the 't/perf/p5312-pack-bitmaps-revs.sh' script, but
forgot to remove it from 't/meson.build', resulting in a broken build.

In order to fix the build, remove the script from 't/meson.build'.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Taylor, Junio,

If you need to re-roll the 'tb/pack-bitmap-lookup-tables' branch, could
you please squash this into commit 8b0b5c7046. (the meson build on the
current 'seen' branch is broken otherwise).

Thanks!

ATB,
Ramsay Jones
 
 t/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/meson.build b/t/meson.build
index 6eeb10d616..97e6d62228 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1132,7 +1132,6 @@ benchmarks = [
   'perf/p5304-prune.sh',
   'perf/p5310-pack-bitmaps.sh',
   'perf/p5311-pack-bitmaps-fetch.sh',
-  'perf/p5312-pack-bitmaps-revs.sh',
   'perf/p5313-pack-objects.sh',
   'perf/p5314-name-hash.sh',
   'perf/p5326-multi-pack-bitmaps.sh',
-- 
2.49.0
