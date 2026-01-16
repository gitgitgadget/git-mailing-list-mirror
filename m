Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8C22EB860
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768596156; cv=none; b=VWAg3d/9jhZA4a4+ewFStbHNvel1/U0BbwUoE3YfM9obO/70lxBEbxg6wHJR7NxWnm2nARvq6nA4zK80bbF5p7w+2oyqs1myDo3PHnh50vpyYgr4wmb3CGGN1MPyxXgQdZ4VcqJGvueXO6j0bNh/JdTpQ99/00eqHTohNbZeuN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768596156; c=relaxed/simple;
	bh=g6B1of826bGJQ2AZxt4rwWUkx2eQJjVuW0UUFUp5IwU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=c1Hx0b2Jc7u+KeBSYyyTNSO1LqO22epz89aySXy3S56CXLGlEaTYVG7ryp1QJIDDj7KdCOhj98+05j2w5SkduXPYEOqdQfbEti9H06FHza6MArhBmFoPaqQdcbfXNkcSKMzgU0hw0RwQEcCKePrXB5yff5vm771IGrJFvbwbXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=puLyQjfi; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="puLyQjfi"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id gqbGvtpaekJhVgqbHvUOE9; Fri, 16 Jan 2026 20:39:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1768595963; bh=s+b+Enlfj/XpJnhcPoZBRqf0hU/nHy1fM6UA7raSqU4=;
	h=Date:To:Cc:From:Subject;
	b=puLyQjfiFdXs7v/qm3U6097Ki/6jCqVE2Irc+qrnQuQudXmpQxHtamt0R1FN/puL8
	 Wgd7ThlPquJb0vbIvzHCAOHcPolCIm+dd4g6+iwkHvDXQaqN2jWB6My9fMRqOGdPAv
	 veyoQ1CbYcpWzL6SJC1X5I5Df+qooAqpcXE4AIvIJVt9CLrNhqGXCGr6Q1a0Y28J+1
	 sUV877jEOYUUyBusbjcVrkfPCfjl+hGqMUzELSTIbVulwtcGDASlKjeRhBWSGte7LC
	 QdV0kAD6I/DiGJU32PdonMRRoz0N9e1tWHGFrs7qafbwEL00kr46ZgiYOUNeutbVHe
	 yI2JAW7wPtIww==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=C+5KyhP+ c=1 sm=1 tr=0 ts=696aa1fb
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=oNCcxfqqJUetTbtaa5oA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <3f8925eb-7602-433c-83e0-a88cf8d155fa@ramsayjones.plus.com>
Date: Fri, 16 Jan 2026 20:39:18 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Subject: [PATCH 0/2] v2.53.0-rc0 test failures on cygwin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEjZiwqqnK69FGeyS5v73cAQvCVrqd337FmyDa64PH0UhCsayRsuH7zIce6zXTgCFnoZkPGm9NsMUihoC04YYL+ZfVxZSyhsmlisgbC/YHbCeCTF1n9l
 s1MOFsqC0vV7nQrzseqpIzuFwp/nEhVqzrjGRoX/7Ou0uYUNUbqd8dblYBwIUtKKJzLGiZtCvD1IZFLvcpdbQyd7ySLXAZx2/fA=



This cycle brings a t9700 test failure on cygwin, see patch #1.
The second patch was owed from the last cycle, sorry about not
getting to it sooner, but it is _still_ a puzzle. ;)

I have tested these patches on Linux without issue. On cygwin
the t0610 test passes with '--stress' which it failed earlier
and the t9700 test has only been tested by hand.

Directly after sending these patches, I will start a '-j8' run
of the full testsuite on cygwin and let you know if it fails
(it should not!). ;)

[When I run the testsuite like this on cygwin I can't use the
laptop for anything else and the keyboard gets _very_ toasty!]

Thanks

Ramsay Jones

Ramsay Jones (2):
  t9700/test.pl: fix path type expectation on cygwin
  t0610-reftable-basics: mitigate a flaky test on cygwin

 t/t0610-reftable-basics.sh | 2 +-
 t/t9700/test.pl            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.52.0
