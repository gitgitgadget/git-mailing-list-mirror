Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422E191F68
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968410; cv=none; b=YzoLvat+7xnVpGrhRrg5H7B1QTb3mdSVkE8QzskDlnFov1u33jWki4V10v2VcHBZyZdtPC+NlS2a9nasbEtA45VkVTUV/SIfURw0XG9diZVtpKZsW/kJfpJ7uTQOIy81eO4QCSk4VC5+dqsaNkRclUY3mJJ7J+rubhKeLZLKc8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968410; c=relaxed/simple;
	bh=kJZgKxp7Fy9KMGWRDLp5vqyevpJTW8A7qlgNvCp1IJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUzty+U2Ayex5P3mSh1vNHg3lsoYFMEpaDvV/JEnxcsg3G/H8FS/9fY6Ldxj/hRm81fQAuse2/FEe/dxwk8wxxbtLJhBOEGR/DNI1ubwaOqIEC9RYWePMziZ4Mgsi6Y93+J77eg7x77NZl1cVoVm+uBjIEwWY3Uj3bCcdADmIP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=UjGihXTJ; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="UjGihXTJ"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 1VpUuYqwzbpaN1VqiupkMO; Sun, 06 Apr 2025 20:40:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968408; bh=KHkUsw3IdorHcjR63aRIIyQzDIRE+3Cj9Isj1jUCdZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UjGihXTJ0JqkPdPH/I69XGwToG20N3nxg+LMrogutT6YmSqG7Rgw0LrOM3Nifd/E1
	 KDlpn2VskoSXBt4r+EixDGoNUJQHRPgegq3x5GvUufGSwwZTXVBGSPm9YwUHaI3bF0
	 leA8EdkwCjuc5q9tG+ip4tTXtFWZFJpgtL3dvqbBN2dnLqA3bB1Yy/ACeLPEH9hdCo
	 cSKVM857hT9dMpVeJZfZknX60PWkD6yvG7dtM4+h+UCWoU5QXDl9XCDq6cl3GXmih3
	 A7XlpGmv/pWSdpq6a91rdmOr1u8nX/I1WNyvAWJuia7XC7DCmzo3wWtvp4Y0wlxBDC
	 hXhy6Im/iLvzw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2d898
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=CyMKNFq3l4KqDfjKpYsA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 12/13] config.mak.uname: add arc4random to the cygwin build
Date: Sun,  6 Apr 2025 20:38:38 +0100
Message-ID: <422d4b2571c718dd605dd0d924252c618b9e7e73.1743859985.git.ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com> <cover.1743859985.git.ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPTvGPQhmRg9GmgWWDbCkwvMiOR5Sbz6sSLiPMMLkPglsAjpkJVxIwAiWxQ+sa4eL9sowWNXAnNuHlzsaodB4KqNpvbe4AvmSygfUusu3tmaCqzYKc3h
 EolSaHYJuiRBVGz2e7AAn615EuzUv3CNdFODWdWD5TIVhG+fxW9MP+1n18Q2LeXPhDZ5cyr3jwq87KAXPFPhgwGYmov0IX4Tk+A=

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
index 0e29341056..4f6770a5f4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -254,6 +254,7 @@ ifeq ($(uname_O),Cygwin)
 	HAVE_CLOCK_GETTIME=YesPlease
 	HAVE_CLOCK_MONOTONIC=YesPlease
 	HAVE_SYSINFO = YesPlease
+	CSPRNG_METHOD = arc4random
 	HAVE_ALLOCA_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
-- 
2.49.0

