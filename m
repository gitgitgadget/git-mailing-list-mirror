Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AEF101DA
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708860457; cv=none; b=LUJ4BaHqs48QFWyyhVn+XE42qs3Yt0VhiDwuW/UiAWRuJJ5hLDp6O7ACOvacSMcAKKB74HZ4J1xAin6a/S/mzyVSqzzjeTY+M4TACFdWIVPZd/JQF832CCMO2EmaWHR5PBgGnmhTtZ9x9TrrbT4VaWcE0QnxzodT2mv+7U8pgQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708860457; c=relaxed/simple;
	bh=qWfM/AJw1sXlo8kLMBbOWl6z8Mc2EVc+YcyYyhS1ZUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qKTAAIIZ+xGSj6VOIxzZfrErXCQY3Z70THrhyhjDDZnARkd6UjzjcX0IeA6H5e45toAcsZzQU97POaE/6FUWNeNxtP40ytZsvohMP0Ni4YbW6LH65W8NmEAW2iilfKYLWJgkLNnUuv50bXbf8zYO/u55Tp7t7rs+OzDPsRiGSXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=lrdmd5MH; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="lrdmd5MH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708860451; x=1709465251; i=l.s.r@web.de;
	bh=qWfM/AJw1sXlo8kLMBbOWl6z8Mc2EVc+YcyYyhS1ZUs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=lrdmd5MHtCLj2l+sTS/KeM/e5B5ZO2PSEaClkFxDUdX85xVCZVoKXH4IQ16zot91
	 hdduq7SzXyneLeaYAzHWgCl1k2KWayff/igZlv3uKw/IVYDz27aMKYqXzsWmwbc45
	 PXLNiEpFdkJ8gOd3q8E0s4G7yl79jZLR4cLgnnCPyMIB3yOt9KcjWO0ftOJbJYTnc
	 DnInscIAxxDoSsHDE5xpld2kdqj7DsT/EAkxIomWkS8yKfvQyeDOP7rgEa+cOoRCn
	 dm+vxnSUJjtZRPEoqgwheqhFtNJtfpNq6dLjAICl6NbvQ1GRtZXPXi12k7DppBAQL
	 6M1x7MJ2oQLeW2aT0Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MftC1-1qyIPa1lG5-00gCcC; Sun, 25 Feb 2024 12:27:31 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/3] t-ctype: simplify unit test definitions
Date: Sun, 25 Feb 2024 12:27:17 +0100
Message-ID: <20240225112722.89221-1-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zo5ge99zYySLrHg4cDhq/fEdB3OsqfnB0QniLvOPHS03hQ68C70
 D9nf5fjyeJtPE04CFiX6JPYQXXuTKTwllAX0hGafAZokRqzojaEdbD63IYO+pzqStb3ynwO
 AMtodpqCtyLMEYdu9XSKj+9mvp3dy/gRULExG/GbY8OaigtPf9FoQlOos0qiv/B4GLpn5o2
 wZSxNB6szS9Ji/T0YL9nw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8D3f5NoyDdI=;yZ8ynq3guJblWghYCZ+GArQP9hJ
 bqW5jdGKQbAOoHHb358QK6TSajoO4A/N1MkaHn04qKdPf1byMalDOSdrEAAF716kMpLUGMR77
 HqMSA9uv7TNlvyKu67Rdchr1DaD+6KOlMvSuc4cF7uZIw2B3X5fIr1jYIwhmlZtRXKPeZokhy
 DxPhw9QYnrlErtZZj5aFjz2oxuQxd6/EwZjBr4CkCQw/TQEwpfUIjCOLV5Kt5mBXEmXCkLQkX
 CBpkGT0NeMuWuyfsbWrF48hXq4jWN1CrO16SOXpKQwWq584KKImLpt8YReLc7PklmVO4F8n9f
 JX20bJIrvmdS/x45O6T7XedTFwc8P9Ws3gUM9TA+qLcaDWqmF3RyFkoMU78ciB+k9v7PSzmh6
 lm+OrEI2rgv3lBhGATgEx3QycOc1vtdcwc1587mTHexNPolQK16lOAOFdIfdblyk+yzMhn0cE
 bcMtX1brk+rv3jLJ4HZpzo22e5/Geq9fZCJPnUVIqJHdqbgBc/+v3UYVZX8oi0tJe7dYVxRcl
 zpdgg6EZqMaWp2yjYpVKIDRr/6P1/wqxRS9tMRq3CK66zfzn8BhxISOAofru5l1IiokoYWyfk
 u9ucuBZ4Qr5SGzb0ZdkKRYbodaaa6dfMCGFnGOXI4BZ0ZVwsqE8s13IoSAqz8+RBxoMf7syyj
 1VFpxsASFuxOnY75RgEfzR7cwU+91/19hGwoUVlQeb/rVsL9CbKOK8fvRLGJdCwB7KgiOTKFf
 eOgGs6uKmeBe1kpygZDhlYh2gGFpq8BiKpAYDWY54EG1aSQh2CZu2caWDgppnlZA1o6n8zDqX
 EaLkgh0e4NrLAbWoFtILRJ9loFSA1aygwPXD+PyReSz8w=

Simplify the ctype unit tests to allow combining specification strings
in any order and no longer require repeating class names.  Patch 3 gets
rid of aggregation by class and implements the tests in arguably the
most basic and straight-forward way for the unit test framework, at the
cost of producing raw and lengthy output.

  t-ctype: allow NUL anywhere in the specification string
  t-ctype: avoid duplicating class names
  t-ctype: do one test per class and char

 t/unit-tests/t-ctype.c | 73 ++++++++++++------------------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

=2D-
2.44.0

