Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA86F9E8
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006962; cv=none; b=nmMry5JR2Jbe2RFln2saWg+/9acv6P4jg3fJCFpGND/LWnzoTNrbY5VCzSgB2esjXTaT6GcM1Ec/nJqFtFnfSPPDo3ZcqatWHOu76WIROITjooNj1NdWFeWfJ+KM63L4B7EnprfgBnSHA5o02VxlYAUEKta9cRzw5TaTijb2n7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006962; c=relaxed/simple;
	bh=EZsVx2TrLOEmOvwx/TJdZgVO1C35OtndEJ19feemzek=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QPaSQixKqBsZmuR0ac7wuBjSxxTwe8DHOpBFzJnrVpZVAZu49qm+PhE7mSctwU12MvGzrmKdvDEYeM1Yd/QT8U2dJK1p3IgdAhxk6yBPRlvW6IAoNfUW3XQVN2RAo9kDyiZHv1TRe0uoqknBXK3Ax7zkNvNrOL9SwyFbdePSvfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Vqx4AyVf; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Vqx4AyVf"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tHaQtGN2LvxWAtHaRteQCb; Sat, 15 Mar 2025 02:49:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742006960; bh=1FrD92wT2ji08kHaIl1qvpFeLrCGSiS5kbknCXkwWts=;
	h=Date:To:Cc:From:Subject;
	b=Vqx4AyVf22CjyPl5kKnCHzJMyTfLiPgip/3lAN/mos1lmeMFsy67peseaIMWKXQxu
	 oLFcOuUnUhbmQxsQJjubBtrZl7vwngfob44KkEHkZRqQpq/F6PoHsV31kfO4xheI8K
	 Ri2Z1SDNAIlKw22qLmy837izKnM9TuShKri7REbjoAtyIdUnSEgcZ/hivmoNGIl0tB
	 m6JTffAfhTPZXXMDLcvhlH0U0nfsdtZAlxZBaVbw4AYyUCPpsHG6IIjqIeKewLtYMf
	 qKuPY2iIFMshzQiWZRglPrkG43eHf7dJdE9lz1X6Ar9Zy/ZJhQnQFuPeWUGomk2ZTX
	 bT8ERxfQYIUWw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbDFvdbv c=1 sm=1 tr=0 ts=67d4eab0
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=7vm066By3dVxp98ELJ0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <8c8e16ae-87a2-44bf-a87b-7422eb04fec2@ramsayjones.plus.com>
Date: Sat, 15 Mar 2025 02:49:18 +0000
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
Subject: [PATCH 12/12] config.mak.uname: add a note about CSPRNG_METHOD for
 Linux
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHRVsYg0ivunrRnwGrwu9kTPnv/tBER24XDSHVsWENNaZpZtJ2fTkA4n1RowCjtNQbInRl5wNofZoz0/FCweBepcxaUuDE8lZ/t5f5DD73WBwTQ7g+D5
 GWqSjceQJCo4xlpU8bItGvI4y9+xBYM2lwCPUC3bFpX+r+f2hROe4vmam1qJQytQM1SLCxaapo9nGEeqo6h6DMe2EOEJURNa1Oc=


Commit 05cd988dce ("wrapper: add a helper to generate numbers from a
CSPRNG", 2022-01-17) added a csprng_bytes() function which used one
of several interfaces to provide a source of cryptographically secure
pseudorandom numbers. The CSPRNG_METHOD make variable was provided to
determine the choice of available 'backends' for the source of random
bytes.

Commit 05cd988dce did not set CSPRNG_METHOD in the Linux section of
the config.mak.uname file, so it defaults to using '/dev/urandom' as
the source of random bytes. The 'backend' values which could be used
on Linux, in order of preference, are 'arc4random', 'getrandom' or
'getentropy' ('openssl' is an option, but seems to be discouraged).

The arc4random routines (ar4random_buf() is the one actually used) were
added to glibc in version 2.36, while both getrandom() and getentropy()
were included in 2.25. So, some of the more up-to-date distributions of
Linux (eg Debian 12, Ubuntu 24.04) would be able to use the preferred
'arc4random' setting.

If the meson build system is used on a newer platform, then they will be
configured to use 'arc4random', whereas the make build will currently
default to using '/dev/urandom'. Add a note to the config.mak.uname file,
in the Linux section, to prompt make users to override CSPRNG_METHOD in
the config.mak file, if appropriate.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 4f6770a5f4..1a897bd022 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -50,6 +50,8 @@ ifeq ($(uname_S),Linux)
 	HAVE_ALLOCA_H = YesPlease
 	# override in config.mak if you have glibc >= 2.38
 	NO_STRLCPY = YesPlease
+	# set to arc4random (in config.mak) if you have glibc >= 2.36
+	CSPRNG_METHOD =
 	HAVE_PATHS_H = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
 	HAVE_DEV_TTY = YesPlease
-- 
2.49.0
