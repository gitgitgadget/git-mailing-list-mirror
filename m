Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347052;
	b=ugqWMYDGoiXe2FFI3W4Ara558utvqAy5pa302PWVHgMpSD2sv/wT3WmAQzpGse+RUNqd
	 a+fm49U91F5Zyyi3JYT8BZdrlowbzJFKsowmh+5v6udyChpiLaDWh7GGqcoFLaEkjcF6g
	 V+/QFxEcbUFLqzhc1xbV3RophU5H2hwljuK4q5AltExgEp8Gnhy340RKVOAc2rkxqE97i
	 PzjzQTUIF6EVhC2LvUgOpKBhFM6XNDVDNg3ufxBz4OpPDPW0So8Cyl0CEYZCxuOw+Lrfj
	 7KQdbqVXZyAI9+TEprCKxAb2LVWV4GQC9TaOjaU0pVHTxIVcGjehXmG3yMW83HsVZLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347052;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Date:From:To:Subject:MIME-Version:
	 Content-Type:Message-ID:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=eP2TNIrO4N5oHkLJ/cEXWpvKOtuuPYvpsE5yY502n0U=;
	b=aK+seVy1TNTcS5dpPreqprH9ko/OH6PwEh4PPgeZL4IndItBlSAWh+yFUVCXQdU42Vhi
	 4+lzH0CLSiFhCvj0T2JvNi+9apNZ3xbiyinPgDmYv4ljS+4mZdxlartFPY5Kw1w1iNTgc
	 gzBD8gqoI81WiWaYoLJkLOORB3NyFsx4cec/DWAhxyhfA1BenMT+BujFzkPtlGalzb7AZ
	 yIX5BNIyKZW5fFj9nxA6Iv8fJWMJugx6M6TS1CYyJvr9umXT9K+4/M6tN5MK5C+cE8M8T
	 PVqJWoCaivRcFxy7mhzjkhkZYaHRp8v5NYs5qxXmkqU4aoigFtigCkK/rTc/JZsoU4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=tpeGwPlb;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE17606A321
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 21:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFE17606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=tpeGwPlb
DKIM2-Signature:  i=1; m=1; t=1794347049;
 mf=PGpvaGFubmVzLnNjaGluZGVsaW5AZ214LmRlPg==;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:t6M80FaplLtbcPW1lktWE1CQgNOm
   1mkAd99IGLuXiwIubNXxQTKI1Ue2cAc7bsz++rtTtH02P8rUeaOGlTU/4NHZBEAdRcjx9CL8P7s
   VwSuQG48KBabGHOrGDRo5jQxgYQ8CRK5NqOVN3IfkCJPi6TQuT8QM4CNkN9j3E69c7NvmXKIItN
   j9htmjrzCsEYmaFxv7hLU3LLnyGmGqrFzIt7c4b70MrgcGK5ssFN+KKyEPcESOZWEeiWBiPly4d
   1ICvqtasEUXKH+oINSPQ2L6NZxoS6F3qOqHi9nS0dl5eQMQSUIovY0rFdGqpzcdfGMhMf6mTWAK
   Oy+gZHR9zwpdXA==;
Message-Instance:  m=1;
 h=sha256:
   JiTzdSkDV4xk9mF3Kyw7b2Gmp4WZuLGHjIWv/GjQPgY=:
   Z/qpR5pLbNehb4/GYStiV5fstBiWW4EC4zBTW5rcVzc=,
  sha512:
   dXAYN8S2yMnkk8WBFSyGjQtv03oatYiFMrUygFxvvttYjKN0TpivkuCPfMC3jY8Vs5ypPL/w7GUWWTcZewP0KQ==:
   chJsiuLPFbRP/hkFbY4xcuADlPeFGOIIfXd4V/yrKI8ZnIgjj7gZ7ZyCD4Sm1iScryRsdBeGNKycpjYa7MJm1g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794347049; x=1794951849;
	i=johannes.schindelin@gmx.de;
	bh=eP2TNIrO4N5oHkLJ/cEXWpvKOtuuPYvpsE5yY502n0U=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=tpeGwPlbKZggC8veYfhkUsjJUVQuC0JSD05S2QBD/oCluiCUM4cogmFisV4XEuF2
	 rZHomt2rhp6YY9b1ZRqWdWFm/UsEobP0OQPa3XA8KDxecyxtfXMAoa/NBx6O7SHg2
	 hutCjBZPA6/yfaXw6owkW1wiom9ihtKxyu45mrgGICMS/IasgaqXvMOeEUlWVJvuF
	 aepFFFWEjZ37Oar2kkreMn1xnviaEVXySksRZ+DdnU8s6moZUJTCauzsihx38I3JN
	 sqGDkpSfDvgQ4XGmON7K/qPcvaV2wMTRd9SHYbDVRuC2EDyoRf7/45z5PnXSueHNf
	 sQ2lF7s4VPw0bbV8Uw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbBk-1waaX11Flm-00yvf9; Tue, 10
 Nov 2026 22:44:09 +0100
Date: Tue, 10 Nov 2026 22:44:06 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.56.1
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <1MHoN2-1xEGqd1RFm-00CTnP@mail.gmx.net>
X-Provags-ID: V03:K1:APFmlBUC9U6MD+o4gFKLGMu1Ofosc/nRPqLQNVlkUT6DiDFJTpR
 ppZJzMlfTjWgYKh5tASyEUchqw5bWaZQA1oogh8MDp/q9BT3OAkRn6Mo43/sMzBQaoAaG0V
 +epI870mBzRjL5RooILrLygKpePez3dQfiN4c/I+uRLQ+d/Gv2+5iz9VMbAe9xZsCtypa5q
 9oanTnlFTn1r3Z84K0DsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8DFfjpyl3J0=;cDx7ego5WDaFckQO0mqC81dN2b2
 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
 SMYMK58uMepvZT1+3ZNum9Y

Dear Git users,

I hereby announce that Git for Windows 2.56.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.56.0(4) (October 26th 2026):

This addresses the security issues CVE-2026-111760, CVE-2026-113408,
CVE-2026-114466, CVE-2026-114467, CVE-2026-114469 and CVE-2026-105437.

Security bug fixes

  * CVE-2026-111760:

    Recursive clones are susceptible to Remote Code Execution: an
    attacker-controlled repository can be crafted in a way that
    exploits a bug in Git whereby Git can be fooled into overwriting a
    gitfile (used for submodules) with a symbolic link that then points
    to a directory with malicious config or hooks. The config or hooks
    may have attacker-specified code.

  * CVE-2026-113408:

    It is possible for a server to advertise an unborn HEAD that
    contains path-traversal characters (e.g., refs/heads/../../../
    TARGET). With the files ref backend that can lead to ref-updating
    actions to write to unwanted files.

  * CVE-2026-114467:

    When Git strips the GPG signatures from a commit message, it only
    accounts for two signatures. A commit message containing more than
    two signatures therefore causes a stack memory corruption.

    This can be triggered when using git merge with a tag which
    contains more than two signatures. As such, this makes way for a
    DoS attack which can potentially also affect forges when such a tag
    is pushed to a remote and a merge action is initiated.

  * CVE-2026-114469:

    Git rejects patches larger than ~1 GiB, because its patch
    application code does not work well with large files. That check,
    however, only considered the size of the patch as it appears in the
    input, which for binary patches is much smaller than the size of
    the file the patch describes, as binary patches are compressed and
    encoded. A binary patch that inflates to a very large size
    therefore slipped past the check and crashed Git with an
    out-of-bounds read.

  * CVE-2026-105437:

    When merging, Git computes the size of the buffer holding the merge
    result in a way that can overflow for very large merges, which can
    be triggered by a large number of conflicts combined with a large
    conflict-marker-size. The resulting buffer can then be too small,
    and Git writes past its end (and, before and after that, before its
    start), corrupting the heap.

  * CVE-2026-114466:

    In response to CVE-2019-1348, fast-import disallows the
    export-marks feature by default. The features rewrite-submodules-to
    and rewrite-submodules-from as well as the option export-pack-edges
    that were introduced in the meantime also allow reading from
    arbitrary paths, and are therefore now also disallowed by default.

New Features

  * Comes with Git v2.56.1.

Git-2.56.1-64-bit.exe | c330c72e10b408cc39994bfefdb63542b0d93d21699325c3e0bd874af8a5a559
Git-2.56.1-arm64.exe | 6fe770b534a459d1158011e6ec0cd8390a3bcf44e542bee9e9a650310e111234
PortableGit-2.56.1-64-bit.7z.exe | 9dd04a608ceb5f6ab32a73709e0ecb159d211da71b697c45ff81f6dd0c6b49c7
PortableGit-2.56.1-arm64.7z.exe | 0dca0d9f760924a7e6752235d7dd6eb1a9b508ee714b6ed15d89252e5a58c5c9
MinGit-2.56.1-64-bit.zip | 4a92850b6e917da4fd010669b614b55dccf5b0ec333a534cc4be4700dfefdafd
MinGit-2.56.1-arm64.zip | 96571e442e90523a90e5fd8661b4c4e43bc192910f3c6db938816e6955b4cc8c
MinGit-2.56.1-32-bit.zip | e9b2c628c6d3bfc86405568d05979c605ee994172eb232cc4cbc4daf54425829
MinGit-2.56.1-busybox-64-bit.zip | baa40c1b8d5897826f47c2b819156553b89833bc52cb42cdfca7d1f0faeed34a
MinGit-2.56.1-busybox-arm64.zip | 42396e389d1b38861fea05edc716b2389e071008c44dd62a53ba05bb85f65494
MinGit-2.56.1-busybox-32-bit.zip | 125c9cb25499e27f66bc5c8357ac74fd4bc8b104ee45054d741aeb2bd0fffe60
Git-2.56.1-64-bit.tar.bz2 | d7d89e69855f00e73d957b513c49538a420c465c84b9d212cf1add400eecdf54
Git-2.56.1-arm64.tar.bz2 | 4a5e1555ac8453033d504930857ec8ba4eef20275d784b4e71df84a3da071afb
Git-2.56.1-mingw64.tar.bz2 | 94cd91e7d44a925cbc22da6e21fc8c2582985e885de2a5c3cb6346599c7cf297
MinGit-2.56.1-mingw64.zip | f50f51c81a335b1cbf08c47094bfea1c38f9b23486d880662c480166ef12a793
MinGit-2.56.1-busybox-mingw64.zip | 275b3129c9cea50a91466f7991c43cde345431eaa45a41b1443e8f26fc1437ab
PortableGit-2.56.1-mingw64.7z.exe | d23741a1bc1ef914cef238d8d6f2260663ec6bb2f3f6ac0528abeb64d2c3fbc6
Git-2.56.1-mingw64.exe | e5385040aa21c4cea02319368d0891412d0ded64b9ce1da97d21d9ff74a6ab8b

Ciao,
Johannes
