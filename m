Received: from mail02.ukr.de (mail02.ukr.de [193.175.194.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA8301484
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.194.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397109; cv=none; b=BWFOiywF4uRt8Sc/olY4v7hSp61YdsNrNAGMs01rW2yqQ0bN6isVaVLiACVergvhhXdmaHTiIoX5HzraKnvwSOTeEK/JALP+ZFmTcUeS9QaZb6IwbT8eIF98OW1gL124xlEc0zF0ZYfb4VwluWQaCTavsVU/og0wXTqVM4Q2bys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397109; c=relaxed/simple;
	bh=PVabJP0WEBClMDwYc+e3jAVx/Y0hvIgt9V2aCszHQk4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iWOeg2Z8k+VSja17IzI7bXJea+gUPI5olYwrFM14T9m4p3Y7m3PBTGUjGEDgE0FcbK0NPuUGWsw+q6jOvEJhXypcqqxdwT95D0JntpG2PCp+/di+rlKEQLjSV4DXcdMSP53EEl2LbvF1RZcvwlUdt/sgVA2glRqm8mMKeVYLjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de; spf=pass smtp.mailfrom=ukr.de; arc=none smtp.client-ip=193.175.194.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ukr.de
X-CSE-ConnectionGUID: WVug0PqyT1OpnQPsFmxsvQ==
X-CSE-MsgGUID: VKTm6yvsTfSGwEyDP3HXsg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="2078685"
X-IronPort-AV: E=Sophos;i="6.18,309,1751234400"; 
   d="scan'208";a="2078685"
Received: from unknown (HELO ukr-excmb07.ukr.local) ([172.24.2.107])
  by dmz-infcsg02.ukr.dmz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 11:23:52 +0200
Received: from ukr-excmb07.ukr.local (172.24.2.107) by ukr-excmb07.ukr.local
 (172.24.2.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Thu, 2 Oct
 2025 11:23:51 +0200
Received: from ukr-excmb07.ukr.local ([fe80::4dee:3e0b:b33f:60ac]) by
 ukr-excmb07.ukr.local ([fe80::4dee:3e0b:b33f:60ac%8]) with mapi id
 15.02.2562.027; Thu, 2 Oct 2025 11:23:51 +0200
From: "Windl, Ulrich" <u.windl@ukr.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Broken handling of "J" hunks for "add --interactive"?
Thread-Topic: Broken handling of "J" hunks for "add --interactive"?
Thread-Index: AdwzfilpD7r3qdjNSYOSD2oDe4E/Gw==
Date: Thu, 2 Oct 2025 09:23:51 +0000
Message-ID: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: 2117DB834113CDB8C3A06CB6117D0B1A8D4E67D492A863A6E4D470BA5F2173A42000:8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git add --interactive

answer some "y", some "n", one "J"

What did you expect to happen? (Expected behavior)
git will ask at end for exactly the one "J" hunk

What happened instead? (Actual behavior)
git asked about the hunk rejected before the "J" hunk also
(asked for two hunks instead of one)

What's different between what you expected and what actually happened?
I did not observer that in an older version of git (like 2.26.2)

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.51.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.6.0
OpenSSL: OpenSSL 3.1.4 24 Oct 2023
zlib: 1.2.13
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.4.0-150600.23.65-default #1 SMP PREEMPT_DYNAMIC Tue Aug 12 0=
0:37:41 UTC 2025 (aedcb04) x86_64
compiler info: gnuc: 7.5
libc info: glibc: 2.38
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
