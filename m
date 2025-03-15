Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62886F9E8
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 02:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006950; cv=none; b=W3qEBLwcXdWvtYo0pQRSDrvLEYP9rtzEPeIBamUKpDwqErYjAkRVjvBc9e8BAv7U/J0tzUOuU2CF6/C7H2A34pF3ll+pryAwFPqbObdR8efYVEX5Mraz4tbxsfexa5e+yqyDSVApr0s9DI68jBl1t4b0/xMpvebmJErYqdUM98o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006950; c=relaxed/simple;
	bh=Dt0aMehJojiqzWNp7wUCxyh915quNx3jcxsogSibDk4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=W5u9RJtuYlNOJGzy9FwJVm5Ch3Q+PSA2wwkb0rlGJWC2xm1X9SW5Fc6YqfjGUyuUlciStYMakPp0nr7JouNwJrXtI+o66t4pewHcu7U24QXa/cNI4eoRQxdb/RHod+EW5iihttdNNtsi/InYSX7k0mDnCMBM6hhKUHMfbcMPJPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=dyHGEi2x; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="dyHGEi2x"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tHaEtGN1ivxWAtHaFteQCW; Sat, 15 Mar 2025 02:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742006948; bh=K4e21Hy7d+w85pwy9NdgbFGMpmzmmimE0fw2BvpXWBI=;
	h=Date:To:Cc:From:Subject;
	b=dyHGEi2xtfOdUKB5zo3Pzo1roGX+oLYWBKRaaZAZOUSyVOZ1fsvjTiMBMFOPltTw7
	 9nW6lmDnDNTpJMXGQD/SllRdBv4HqtL/cLP/Do2cUy/j0x8OFGra3hV9h/8KXRWuJJ
	 z53d+qoH8Eo7CunDPXTDoUo0nCmgm4HTfSZyCuOM+727Ygj3oE5h6PGS68G/HqddjH
	 W4VnJFbs2mCz8xDir3v/Z7iqsp5YOsHC4dLSdfyjJQw7iEDuav0rHfoiofi+7aa1oC
	 C8Oq7excRw6qEAW+qHIaYNRTwncjKwpkGpqkTbGEHpWJTCj9KOL+JBDjFZnrb0tUja
	 lcEnN6YW49JJQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbDFvdbv c=1 sm=1 tr=0 ts=67d4eaa4
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=CyMKNFq3l4KqDfjKpYsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <90accf50-324a-4bec-b219-f1ca522283cf@ramsayjones.plus.com>
Date: Sat, 15 Mar 2025 02:49:06 +0000
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
Subject: [PATCH 11/12] config.mak.uname; add arc4random to the cygwin build
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPA1kumK2QhGCKsNv4xSTvlSb84LYAKdn68agqtFjKiBuzic05+EhNviv66JtTXIJqX2zvxM64NrNSgDJx92pXCupcyhEcyCbuBo6VjVRWx4MmVxzWL+
 bpxkyM5PXiSPviyqgoRubjo2sD8ERS1soG+b8Pbu/3eDQxTbDsgCZSt0bzXtsiSu92evXgd8dEK/+b2V3wHO7UhLUTqFfnNT0+Y=


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
