Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C621C19F
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489233; cv=none; b=W7tOneEx643T6Vdy+FCPZPnZPSP5RJtOYR9AkiVWgm87hzazggDB2Mzjn1OzUPd8gXmI4D7dqACFxuvY8ihG4huT/DLc4rgyHX8YZHeTay3ihfbByORAqU0B0MNI29WvvCXZzqVX83D8co3n6ZBISpZuxm12F/JpzODhUwOa2sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489233; c=relaxed/simple;
	bh=/wHTxbcEDiCWLdPrenKKeZ1wQGESxnzqaAiGinQLwzc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BvIjvej5vAn22uMF8Tf2ITKTKfUUOMRvXITGsIokI7YrDcjUgd3NH7HC9ujrHwUxugCmEyEkevRyj86vqzHY4oTfEj+OQRuCM2/kpcxE9IprtQowgpEdjO8SnbCO3AvwE0ngdcAeJODwcMkG2lkVHvW/ttGTkz+3lscJHtdZYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=T60mCN3y; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="T60mCN3y"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id Og43uLKq0QUSmOg44uP3ub; Mon, 09 Jun 2025 18:13:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1749489220; bh=gwU1KLHtOozxnMlhf+mWLLlxmnC/j7iDEMStR2K6e4E=;
	h=Date:To:Cc:From:Subject;
	b=T60mCN3y4UDLBIxkIIKrXvM6b+xQhEoC6EcvY92AZY+nMYZvyp/0jCN1Ysg7qvtGg
	 CpLyyg7bJ/oGamE2KfI2tbe0XG09XPjaxh0W7kFsAEcv57lLDk1hCSOlOsoiMntbL6
	 9r2TrUWRP6mERMiJYEolCazieSgLkdIC8KOv/SI+U3WmpiHJkGaS09Gm9HgveaeiE4
	 5x++lF8lbP6/TfrqjSMZ1KJjxoNm7d97yZDptpaIanFBaISYFTNeqPx5i59BmIZSXL
	 GpXVXQD/wzLA3kYcoMM8q7iNKOTxyxx/hDh9y6v6ODyAb5W6O+jKHf15mFHaBqjguw
	 EgJevDP0tML3A==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Ss4z6+O0 c=1 sm=1 tr=0 ts=68471644
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=z907-DpXflYRDE9FQIEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <33de9e5d-24c8-47cf-b858-6d55d26803b0@ramsayjones.plus.com>
Date: Mon, 9 Jun 2025 18:13:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH] test-lib: add missing prerequisites for Darwin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAy7jVHnDsw2WeOdLJAK9VJdklU1Zba+B8TtkZQmniar8/Wl96HC+hyLw1i4Y+oncNe1tahC/XWzhTGTg2hwr/zJrbgEXnX32EZtEOgPRd1KIl1kH5Qb
 YCsubYKdrZyO9KzzpjGjdVv252WuWrX24HbyZo1yEMwGbxwt9vi83MniLDuV4Ryx6fr3qKRjaMyJAO7+KGnGikwG2jRAZTRtCW0=


commit d3d8c601fd ("t7815: fix unexpectedly passing test on macOS",
2025-06-02) added a MACOS prerequisite by adding a 'Darwin' case
label to the 'OS-specific' case statement. However, this commit
forgot to set several prerequisites which appear in the 'default'
case label, in addition to the new MACOS prerequisite. This causes
several tests, which macOS should pass, being skipped.

In order to run all applicable tests on macOS, add the missing
prerequisites to the 'Darwin' case.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio, Patrick,

I was looking at something else when I noticed this ... but I can't test
this, since I don't have access to a macOS system (indeed I can't confirm
that is actually a problem, but lots of tests should be being skipped! ;) ).

I initially deleted the 'Darwin' case and set the MACOS prerequisite after
the case statement - which may be a better solution. dunno.

I marked this RFC because I can't test this. Hint, Hint ...

Note, commit d3d8c601fd is only in next. If this is not going to be
part of the release, then this (or something similar) could be squashed
into it when the next branch is re-wound.

Thanks.

ATB,
Ramsay Jones

 t/test-lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9ffcae0472..51370a201c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1647,6 +1647,9 @@ uname_s=$(uname -s)
 case $uname_s in
 Darwin)
 	test_set_prereq MACOS
+	test_set_prereq POSIXPERM
+	test_set_prereq BSLASHPSPEC
+	test_set_prereq EXECKEEPSPID
 	;;
 *MINGW*)
 	# Windows has its own (incompatible) sort and find
-- 
2.49.0
