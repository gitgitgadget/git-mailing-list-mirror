Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696543;
	b=uvB9J3Em3LHDBTpG7NMILkHla6rTXUb9EZrHANdc8WUdyT5NOZNZbt2RxWPYBvC8+1Bu
	 4RNKdG50hOFHbYS+M0SxZBuhj4qK5SQkbOoLzUaP6ofd479AK8E0YHeGreFimtexeDtvE
	 6LJS6OCW45oZNsWrE8f/3QQaCSKQ8Cz2JMou83TZgZS3VsdsQ7lt/iUoaTuBChH6l7d67
	 EOS1X2VylG3Q3CzSUSwiOMY4ySMGo+IYbPRTfowPAOYyFtDu8s18l1tvQYPnd3XkB8aPR
	 dfHJ4Zvbc9vYf8ykYlb848soL6WBeCK1drIfrRbOk2SekbW5alzB+iHaH6QNV83IzOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696543;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
	 Subject:MIME-Version:Content-Type:Message-ID:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=ROczLhR0XplhisLMRdLU6OdZtVW9fMEBfaFT6Hra7k0=;
	b=v/KxiqgL0tT+aj+RQJsZhS8Z/We3bS7fpNHkPLMdR++rlbzixzqKyFIJEDFdtaLIPEjb
	 KoRbDvdWjaaFvyxp8iZvnIvFdCJBi0+WrwdNB+svUsjJBRH9sXjEy4atPWIWi9tJyXKwP
	 28rJiRAb9pNszdCg11XK2NNJDW01tHVHK5RP6BiID5ulngpWYYIyfK5otO1uv/UnDNAzN
	 Ip7H5RYw/OzTDmK/m5FbsoI6gpw7NGF71ye70agAiVxad0Bk4I3NQnFEMtFJv9vJ9nz/U
	 t5C1THFyB1F3iguWmmCLFj4rBwjYu4C5Lx15iK4a57GkXCWFXSdl+gYvLfCnloLFJZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=PEwnkXr3;
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A409D606A323
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 19:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A409D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=PEwnkXr3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792696540; x=1793301340;
	i=johannes.schindelin@gmx.de;
	bh=ROczLhR0XplhisLMRdLU6OdZtVW9fMEBfaFT6Hra7k0=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=PEwnkXr3bQnaJ/ezy7keJkWK7BVrW6lv+uruY8NNOpjDgvW6O7WvYIWw0FQVW6fx
	 s2KOrf88t0Ai6hslu0/5bNuKvktxwba1hJbaf3KFq5LL3TsWYL/oIWmiUz0kZEXtH
	 bIPek3h8VnDsHbPE65BsevYrZV3FVIQATIhTtZKirpJdEnIuhyI92ZbZZz5roC+jo
	 CWUKCGf/EAaW+LBcQTdOztAyJwlTghEglBk5ytgmzRtmB+Za2CErbLRM2wm7JexNB
	 7G0kDxGb4TKucZc3lUQEer0Bp+eb2rkZFbnUBzdnTe0Tvaxb6dDgv55r4ZwHflZoL
	 ElWpHZQ9UL7bycWvNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKZ3-1x0wbb1lZX-00UldU; Thu, 22
 Oct 2026 21:15:40 +0200
Date: Thu, 22 Oct 2026 21:15:39 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.56.0(3)
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
Message-ID: <1MIdiZ-1xPjYn1zYD-005wYg@mail.gmx.net>
X-Provags-ID: V03:K1:a95VOIgH5A4Q5etSE0N0+Oaqe5uOyR/c0H1jduPgu0AJpD85Tw2
 fkYGCrgKmOS2l16VF+BZ1OdgwM/hHvR7t5F9N5avJv/7R1s+jWvH8+Ime9M1SfrvffgKVMV
 RrwOQQyxz6lmWJ/uFweNAapzZLVZmZ5sGKPb9OLfSxQoG0aDT2lJsVuSkqeISxUtMac0/KE
 DSFMHPIaA1QXqQ1wQL+bw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ER0lpNKjnAY=;AWZxCx3dWmC6C1hH4fgqeWqbgXA
 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
 XEBhCitAxf5hdU/YErWG7ENl9sg==

Dear Git users,

I hereby announce that Git for Windows 2.56.0(3) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.56.0(2) (October 5th 2026):

This is a security fix release, addressing the eMudhra Intermediate CA
Compromise. It also addresses Git LFS' CVE-2026-105803 by upgrading to
v3.8.1.

New Features

  * Comes with OpenSSH v10.6.P1.
  * Comes with cURL v8.23.0.
  * Comes with Git LFS v3.8.1.

Git-2.56.0.3-64-bit.exe | dc6d3db061999136e139f31376c5582a9ed6f36a4ea12f15e54ad7fa2bfc0bf2
PortableGit-2.56.0.3-64-bit.7z.exe | 4fc27b779829a36df77911e3f4dea09c66c790dd6c5f7dfa3b6a5479f1fe354f
MinGit-2.56.0.3-64-bit.zip | 2e5619966e588fde5f8122c5557cad50c0fbafcaed736689f40ec1dfb1d78ea7
MinGit-2.56.0.3-32-bit.zip | eaf8d826a2ff4440db847078424b282d09f9ac9d03524faab8189c279455926d
MinGit-2.56.0.3-busybox-64-bit.zip | ab4aabd3b8b1c2610725f4b48312511b5e4ff7af99f6e0ae1aa286ea19faaf85
MinGit-2.56.0.3-busybox-32-bit.zip | 356374ce00e5facf75b3f14eb60529e6ec692ed92a9f71288e3509743bbc7236
Git-2.56.0.3-64-bit.tar.bz2 | 2460cdc329f9061e0682672eb9995da9da1da0ffb9761494c7abb3559ecbc40e

Ciao,
Johannes
