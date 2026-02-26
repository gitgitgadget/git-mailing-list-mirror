Received: from mailprz1.bwi.de (mailprz1.bwi.de [91.221.58.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5E3603ED
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.221.58.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129385; cv=none; b=XDI0UlMldwyIZEUF6P5QlfO7BKhmMYpuT0JcCj5vv/UU/tGR1TOk5UdNZHozAHUebhWPCS2zA0Bcuf1KW4LxiMsaMnRRlryWk95crMB+B1/Rnlu+X3YH/EL9+xoW9IAeZAsRfSKmV984di8RRJMAO23qW0+JYl5U/ehDdRzoq0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129385; c=relaxed/simple;
	bh=oRh4KMn8BoptI6CKxCdq47STbz3DTdOdIweT9PMMtv4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qWpnSINtj2J0si/IE9Aqk7wfdirCK8jM4upqh5jIkAjtemnvfDw/LbJjxPztVarK1NIbJ5thNDUvvp3PpUovdbhO144iI34R1sNYxuXNWk0gAtXJUiQKdowG4e2mi79Fdg97Fqi2fWj6OJWJF2ADxdsYbAZa8WCCPiJhMVIVUK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bwi.de; spf=pass smtp.mailfrom=bwi.de; dkim=pass (2048-bit key) header.d=bwi.de header.i=@bwi.de header.b=e177uBLu; arc=none smtp.client-ip=91.221.58.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bwi.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bwi.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bwi.de header.i=@bwi.de header.b="e177uBLu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bwi.de; i=@bwi.de; q=dns/txt; s=przbwi2023;
  t=1772129382;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=oRh4KMn8BoptI6CKxCdq47STbz3DTdOdIweT9PMMtv4=;
  b=e177uBLu7KLcEpE1WhTOU+baUgrTDpuqxuibiRqgCYHURKM3aDBd0HrZ
   Y6M/UfSjzBjFopov4AOegeAvoQXS+izKTABTZ1/o4tZHjkhkZk+ywrtbg
   e7izFSdkUQc89zAA3zuWW6mjnRQ0T4IkWA6jH3+/Mmr4+lknbzC3DqLLv
   qOjEoTmXzF4pYgfVTHedrRuWEFmCXOUNRX3Q3C3gQFXPLF/0Aea4h43+b
   4lpYtI/HNLXQTX2B6WYq/9QMWEaM0QvDNuvXR2yCKruCVjjyHPSIGeOrp
   zRdnXXzkQmmJAd370Po/qgIDwFsXyHXiWAyJJK+6zDMP04R3KxhqTvADy
   w==;
X-CSE-ConnectionGUID: aQ7e6MrET6iQEiMXc/dBzg==
X-CSE-MsgGUID: LNpEmubMQxapOXupsik7Kg==
From: "Matthiesen, Jan" <Jan.Matthiesen@bwi.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git for Win - CVE-2025-68121 - Impact Analysis and Fix
Thread-Topic: Git for Win - CVE-2025-68121 - Impact Analysis and Fix
Thread-Index: AdynSnlZfBwFj+LpQzSrdRmiBOyHMw==
Date: Thu, 26 Feb 2026 18:08:29 +0000
Message-ID: <d65bd23d95fb4ae19651e83f4578850a@bwi.de>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clsdocindexref: 5c50aef7-7c3f-4f9f-86c0-2837fc1f8cb6
x-esetresult: clean, is OK
x-esetid: 37303A2963F7B850607360
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Git dev team,

we've noted above critical CVE (CVSS 10.0) and wanted to inquire about any =
possible dependencies for the (2.53.0) x64 version of Git for Windows and a=
ny fix perspective.=20
Given Git is not a Google tool it should be quick to decide and respond to.

The CVE relates to packet crypto/tls in the standard library of Go (Golang)=
.
Impacted software: Go-versions prior to 1.26.0-rc.1 plus distros based on i=
t (e.g. Debian Bullseye/Bookworm, RHEL 10, Ubuntu).

How can we ensure the latest Git version is not or no longer impacted by th=
is CV?

Kind regards
Jan.Matthiesen@bwi.de
