Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB552EB1D
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742007032; cv=none; b=HE6U6G/cjn/gmZN/uI2Z2JjljST1d/svLu9aaSpre1OOnSV9XWBO5Noj2D3hs59Af0v4/Lh6PUk/MAxVmofCI4uRvDRH1WtdL48qaSKRiAf/5UirW4W5RRm2QDvBGkfU1BjWloN/wytiOuihNKKj7UuAQkEFLSgp19Tp8vieoXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742007032; c=relaxed/simple;
	bh=E8dCf67V3hnwc/foh1Iax6n91fE44I5imhFgZ3YQxSw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=eTFzNM/cjQUPnqDdwOtHsWcep9Lb+c0TqslnhmV1Nv5y3oT+HtWTW3sBp3yz+b9He+ryXr7Yw129/6zGRD+UDwVX+WUiyEZvdaIB/qKagX4D+thgIKmoBeKfdC1MPuyQ0yTW1sKHivNKtgo+2fvbyAHlKkSN1jFKNnSTBRA8hMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=joRTqBMm; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="joRTqBMm"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tHYdtGMtUvxWAtHYfteQBu; Sat, 15 Mar 2025 02:47:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742006849; bh=8pINdvtOrZejwqEDmdH/CJOm6n8/6gghfHbuxzfCmto=;
	h=Date:To:Cc:From:Subject;
	b=joRTqBMmJIBzTz3PuwTEFHmEKmEdpNpX5Xtzhnn0p7jqsSEteqQ8pvCcuVzshYClV
	 qNM6c1x1YyWDxxPC52m6WnWL6hUNY1JuDnIFvfsz97EoUnNxbxaAQKQpF/N140OCJJ
	 VDrutQzO4kt3YohV2c4yRqedHcVxekIwUQe+bISCR7jY9VD9HBv6xSwDYj3cVduTkL
	 TWDEWaqxXJSru67AH9nYNqyU+mPy8MedcVvsx+UJu4Lhqgn978GUtmRCgUCndu3RVM
	 VAGyvZ0KNiNogupkELm/movqZSC1fc1BbMFeV0F+akyKG6+yeoqE6VCqI4SiT3aEiN
	 sl9gGW0J0x8Mg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbDFvdbv c=1 sm=1 tr=0 ts=67d4ea41
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=fVsHCq2i0Zt6NT_ZDjwA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <a3dbc1df-61e4-4216-96c8-3414d68b82e9@ramsayjones.plus.com>
Date: Sat, 15 Mar 2025 02:47:27 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 05/12] config.mak.uname: add a note about NO_STRLCPY for Linux
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBBjrRIhqpJ1xoh+90xcIkO0opkCNhLoHeALsUqrsF3oOW7QRKyYWR2L0gMuTZQBaZ8PLA8deeHCRzx5eL/N8x0bBiilwaLCEjX3FPuudkXbWEqZcMB4
 LLFaWbZg3kfbzp6SpMzpfEwWvNm/JexvFB/lxLG4B2s+j0Zxtny+nqj0xnZC5mehNTvzvLrGeGF9Y2J/lI/UmJ2MHmPKcuDDjPc=


Commit 817151e61a ("Rename safe_strncpy() to strlcpy().", 2006-06-24)
added the NO_STRLCPY make variable to allow the conditional use of
the gitstrlcpy() compat function on those platforms which didn't
provide the 'standard' strlcpy() function.

Recently, in the summer of 2023, the strlcpy() and strlcat() functions
were added to the glibc library (v2.38), so some of the more up-to-date
Linux distributions no longer need to set NO_STRLCPY. For example, both
Ubuntu 24.04 LTS and RHEL 10 beta have glibc v2.39. However, several
distributions, which are still within their support window, have an
earlier version and must still use the 'compat' version of strlcpy().

If the meson or autoconf build systems are used on newer platforms, then
they will be configured to to use strlcpy() from glibc, whereas the make
build will always choose the 'compat' function instead. Add a note to
the config.mak.uname file, in the Linux section, to prompt make users to
override NO_STRLCPY in the config.mak file, if appropriate.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 88007c4f13..ae6ba15586 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -48,6 +48,7 @@ ifeq ($(uname_S),OSF1)
 endif
 ifeq ($(uname_S),Linux)
 	HAVE_ALLOCA_H = YesPlease
+	# override in config.mak if you have glibc >= 2.38
 	NO_STRLCPY = YesPlease
 	HAVE_PATHS_H = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
-- 
2.49.0
