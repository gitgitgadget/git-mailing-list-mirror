Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF62B16A95B
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868444; cv=none; b=t3hPmp4YJt+0e/W+4SILqR2aNmQfldm5TFFuM4vQU8LSJ4RhC7c+bcz3/8emGGI9FSH6z4uY7No79M4yYNU+evWxIg8FxsKaP4aINVt+3yvOocXJzwzRV3EhFDFPlJnNg1foFnPThzHrf0jKDxPbdt/iDm1lb+OG62LRmIpfADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868444; c=relaxed/simple;
	bh=BrL3xGuoQoG4CHLB4ugTJV3XYqnzsNDxxdAOzGj7QFQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=RHAu0cGfhqX/ilN1Aiell2OPCWfFfqxzJSkcmZszO1S5d28bza1ESVOy+H0a7do7hVt1KZ5964WoouZEkBN+1J4FZ2piPIJpULH/BYq9ayJX3UursULr1TrKU5fhb1uBUZ743yBc6UoBYUK5dyFyGn8NYJVyq38YN6NYF5OG9Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr; spf=pass smtp.mailfrom=online.fr; dkim=pass (2048-bit key) header.d=online.fr header.i=@online.fr header.b=Y4Tx0pNs; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.fr header.i=@online.fr header.b="Y4Tx0pNs"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id BFC7483594C
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 20:00:30 +0100 (CET)
Received: from [IPV6:2a01:e0a:ecb:c5f0:b08c:2444:f366:f208] (unknown [IPv6:2a01:e0a:ecb:c5f0:b08c:2444:f366:f208])
	(Authenticated sender: thomas.koutcher@online.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 7963D19F734;
	Thu,  6 Feb 2025 20:00:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=online.fr;
	s=smtp-20201210; t=1738868423;
	bh=BrL3xGuoQoG4CHLB4ugTJV3XYqnzsNDxxdAOzGj7QFQ=;
	h=Date:From:Subject:To:From;
	b=Y4Tx0pNsBeJUl5sqvavIWb6a8Hh4XHU92L9lzhLcXOxewhJdtpAoowhecpMJNy0Cq
	 qe9uPX2A2Uz7Dsi4l3g7xJK1JNpw5l1JNh+0BmR15swTsZ5n4mtIX811YNj+avzMi2
	 nikXh7XeFIL3sSiVrw85MmbaqyHpK/cALKRSxjhScIL52jnh7PggHC0fP67Tfujyiz
	 MmLMPthACjxb0L+eS4f5Dxhq/PBgjaTLqR4pnNW9f9VZu0Nr4cmy63qibjz1RLtcHk
	 q99/dR2ubOrwxOrui8Mhq27SDQIodRfpFrWBM6z4EqWQ41SpZXvEaiDWNogMM3Fd+l
	 NXD81geL7PKHQ==
Message-ID: <466060ab-ea6c-4c13-93f7-2de7a380429d@online.fr>
Date: Thu, 6 Feb 2025 20:00:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Koutcher <thomas.koutcher@online.fr>
Subject: [ANNOUNCE] tig-2.5.12
To: git@vger.kernel.org
Content-Language: en-GB, et, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I am pleased to announce Tig version 2.5.12 fixing a regression
introduced in 2.5.11 affecting 32-bit x86 builds. See the release notes
below for a detailed list of changes.

What is Tig?
------------

Tig is an ncurses-based text-mode interface for git. It functions mainly
as a Git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various Git
commands.

- Homepage:https://jonas.github.io/tig/
- Manual:https://jonas.github.io/tig/doc/manual.html
- Tarballs:https://github.com/jonas/tig/releases
- Gitter:https://gitter.im/jonas/tig
- Q&A:https://stackoverflow.com/questions/tagged/tig

Release notes
-------------
Bug fixes:

  - Fix empty blame view when opened from the diff view on i586. (#1362)

Change summary
--------------
The diffstat and log summary for changes made in this release.

  INSTALL.adoc | 4 ++--
  Makefile     | 2 +-
  NEWS.adoc    | 8 ++++++++
  src/diff.c   | 2 +-
  4 files changed, 12 insertions(+), 4 deletions(-)

Thomas Koutcher (2):
       Fix empty blame view when opened from the diff view on i586
       tig-2.5.12

--
Thomas Koutcher



