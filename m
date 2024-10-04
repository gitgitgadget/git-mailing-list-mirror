Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD6E1870
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728003960; cv=none; b=oLJGg5SLqYR4mK5Y+1TqCRHPMHELFAjbQBZglP2a62ab+mNt5ZGEemkPnxVrt862dTDfcSwMVFJVoNyNj5HaJVYgC5Ve2ZspwHG+Rsgq/2gjOg3/oJdbfFT81L1EF9etjW1vAfYuu2qCjUDw5L17T9L1FohUcMHLUabOQeo+fW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728003960; c=relaxed/simple;
	bh=iG37FqaWq+FNaR1J7f7sCGn9Y0ve0Z9uML5Ui+MpL+c=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=L01rL5I2TppgQSFsAgWri8mj5Y42Au9AGmUeqRigcM8PkbUCcFaVFy02Y+uujtIS+VUtd59yaS5BBYY4wkkglMnPR4n6lwMlOU/6q197p7RvkMk79+E8iKrVm2XK/VRfKwX5w+uinwlPjlWezrU6Gr9nWRCxpwjJTMZBottkjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=fail (2048-bit key) header.d=plus.com header.i=@plus.com header.b=MeH1dhS5 reason="signature verification failed"; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plus.com header.i=@plus.com header.b="MeH1dhS5"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id wWiSsenDPAMaswWiUsS1U8; Fri, 04 Oct 2024 02:02:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1728003766; bh=KeRRJ0ZG04AYeHXofDmW5bVXpHfhbPDTTiRYuQz8YoA=;
	h=Date:From:To:Cc:Subject;
	b=MeH1dhS5Vo0xb2BhqqcyKdpZl7YwdvORJFX1rurwKxPMDvxrqsIgIqpH3wdWGl8e7
	 yi0bivKSkPQP9962SjWBBZ2FuaIDuA/gBNVsaxOFNTxSipbLR8zFeFEuBbJDdeKq7O
	 qgOMyTwM1Wyl+waciAyJEbLGfxhOEvEm+VGBEmhf/zhn6wfvLRtHjSoGKrJBDuqNbE
	 JUe7wkwZdxM0PYSip7wonxl4wkv7gjlDoz1AYq30WbWHiRYNFZNg+JTN9yXwnwFMPq
	 wU6BUemUNS6IwundpRX0bEe1U2+SX6p4nh5KMugeLWvlalOU7+IXovzJFXTD65qPZQ
	 CDUU4fF64GScg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JP6YsNKb c=1 sm=1 tr=0 ts=66ff3eb6
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=0qD2sCX9qt3bZXsXbVgA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
Date: Fri, 4 Oct 2024 02:02:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: v2.47.0-rc1 test failure on cygwin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCM93n+v0kNr9N5r4eEoVGLP8KXfyzoZZK/KQgqkN8dw32co+FPm7W83ICCA6LttX5B2DpDHOIO73IGdICpFLZ9Opx57ZOdYSwBWIqpe/nseO+1N3sp2
 AB9unT1/30Dxy2PsI4oGEakBopblou6EP7wsDq9fB/8s/thZXeIXV+xCtMdGMF2tWxCqRtOhdhAoJyeXBJ2iUZ7lCizL7ke9RNU=

Hi Patrick,

Just a quick heads up: t0610-reftable-basics.sh test 47 (ref transaction: many
concurrent writers) fails on cygwin. The tail end of the debug output for this
test looks like:

..

++ wait
fatal: update_ref failed for ref 'refs/heads/branch-82': reftable: transaction prepare: I/O error
fatal: update_ref failed for ref 'refs/heads/branch-2': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-3': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-27': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-10': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-21': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-14': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-9': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-19': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-33': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-28': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-29': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-25': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-53': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-41': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-37': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-36': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-50': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-62': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-48': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-49': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-59': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-67': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-81': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-72': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-70': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-54': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-71': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-74': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-95': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-87': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-92': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-64': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-94': cannot lock references
fatal: update_ref failed for ref 'refs/heads/branch-100': cannot lock references
++ git for-each-ref --sort=v:refname
++ test_cmp expect actual
++ test 2 -ne 2
++ eval 'diff -u' '"$@"'
+++ diff -u expect actual
--- expect	2024-10-03 23:21:01.284020500 +0000
+++ actual	2024-10-03 23:21:19.881283200 +0000
@@ -1,101 +1,66 @@
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-1
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-2
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-3
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-4
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-5
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-6
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-7
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-8
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-9
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-10
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-11
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-12
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-13
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-14
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-15
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-16
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-17
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-18
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-19
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-20
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-21
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-22
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-23
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-24
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-25
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-26
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-27
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-28
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-29
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-30
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-31
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-32
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-33
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-34
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-35
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-36
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-37
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-38
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-39
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-40
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-41
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-42
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-43
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-44
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-45
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-46
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-47
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-48
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-49
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-50
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-51
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-52
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-53
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-54
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-55
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-56
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-57
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-58
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-59
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-60
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-61
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-62
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-63
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-64
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-65
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-66
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-67
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-68
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-69
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-70
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-71
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-72
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-73
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-74
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-75
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-76
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-77
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-78
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-79
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-80
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-81
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-82
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-83
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-84
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-85
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-86
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-87
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-88
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-89
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-90
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-91
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-92
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-93
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-94
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-95
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-96
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-97
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-98
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-99
-68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/branch-100
 68d032e9edd3481ac96382786ececc37ec28709e commit	refs/heads/main
error: last command exited with $?=1
not ok 47 - ref transaction: many concurrent writers

..

t0610-reftable-basics.sh passed on 'rc0', but this test (and the timeout facility)
is new in 'rc1'. I tried simply increasing the timeout (10 fold), but that didn't
change the result. (I didn't really expect it to - the 'reftable: transaction
prepare: I/O error' does not look timing related!).

Again, just a heads up. (I can't look at it until tomorrow now; any ideas?)

ATB,
Ramsay Jones


