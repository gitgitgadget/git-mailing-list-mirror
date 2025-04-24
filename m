Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022627BF8E
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499151; cv=none; b=KNoDirZWfEe+caa1a0nBXiXVKG1M9w8FdVOI2fKQNMr81c8jfqBgw+eym+XHo5+M7ail5/Ild0WZwRACC1EcVGPRyVlnUD7A7LBbb34n98Q1Bz/00BIRTlq5LUgV6f1heYJRCvvU3bEPyeIzicRTBrkwRPbueUhjPAqhn/97ZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499151; c=relaxed/simple;
	bh=c6qXOPW/vjjXhxtKy0piVs1p0f/vomzHrBGkIxQiJ/U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MgDtKioHIWqZg/OO0tpx2+X8eb6T+ZcKkJRBBSLhcB9n/OeY1OtulxK6f/PYa5/El9DdI/7JQJO0GMJ1uUli2nQtBgQfVemY8Jbl9fpjAaZj5imFUX3hfK7tblSe1LL96DNCVslOBU2Qhk4Jqp+AmICy9l5m47KRxQM8He9HoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=owhbU0K6; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="owhbU0K6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745499146; x=1746103946;
	i=johannes.schindelin@gmx.de;
	bh=c6qXOPW/vjjXhxtKy0piVs1p0f/vomzHrBGkIxQiJ/U=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=owhbU0K68ruJl7fjQ2joukasv2Y8/BjHv+0+gwtVvkTXwRRFgh9UXMLR/evxrqfc
	 aTKB81a/twKr7xaVxjLUbTUKVv0Mtu4Hc+WOLJy5OLiH/eKJV/64deky1cuDvfbWs
	 L+xfNhMVl8OzrQpJ0Zr6KZd5Tt0vT486uUyPj1F+wHHEFrDErnuMFavelFdjQHjeO
	 6TDXcHy25BR5NcTumUbCEUB2eV1Z1I8FWaLDD+vaXXQr4sNZK/nVY9eUCKbb6yk5i
	 qKs5z61TvRqTjXEGHkIWgMnD4CVyQSjv9XGEVryos0iDCpnMIZw1QjryCEkQYg4Rw
	 IsSXx9VHf7c0JfIjUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.93]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV63g-1uYuse1Bsk-00Q5Xw; Thu, 24
 Apr 2025 14:52:26 +0200
Date: Thu, 24 Apr 2025 14:52:25 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Lars Eriksen - DSV <lars.eriksen@dsv.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: cURL in git for windows does not support HTTP/2 anymore
In-Reply-To: <GV1PR10MB76004D6F2617B561A7718A099B852@GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <1cb70ac5-31ee-ec1b-dea5-e900f28a38f2@gmx.de>
References: <GV1PR10MB76004D6F2617B561A7718A099B852@GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6SjPL84Rhwe9pfdtx0j05jDqWBA6TksIwcvy1cY3GK8OU4PFh4P
 OnUdmckbRkdzf8XjI5kwtE/MdqyGZnAl7JLQMG3KQaY4hnAk28cuDHj8grggPf45/7Q7kla
 4ZKGbHF2SIHvDvyq7s66JER371Z2y6BejqOnyS9Kyvqysoh+IMLM7iAMT/BGSqAL3e+iuXt
 4GDrxSoEQ7NIYCnxjp9dA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ol5Hzob5u3s=;cgjIMBbTCWGAy951QPbdiUf1Fms
 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
 osSbyOHJzYxENpMbvF7NQP70o
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On Thu, 24 Apr 2025, Lars Eriksen - DSV wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> Upgraded to a recent git for windows found here: https://git-scm.com/dow=
nloads
>=20
> What did you expect to happen? (Expected behavior)
> The embedded curl should be able to use HTTP/2 against our backend.
>=20
> What happened instead? (Actual behavior)
> After updating git for windows curl is unable to authenticate to our bac=
kend that requires HTTP/2. curl --version shows it is not compiled in. It =
worked in the prior version, 2.39.0.windows.2

Careful: `curl.exe` does not necessarily show the same capabilities as are
in effect when using Git. The reason is that the default SSL/TLS backend
is Secure Channel, whereas Git can be configured to use OpenSSL instead.

And looking at the most recent build of Git for Windows' cURL, I see in
https://github.com/git-for-windows/git-for-windows-automation/actions/runs=
/14221753030/job/39851304688#step:16:1230
that the OpenSSL version is compiled with HTTP/2 support whereas
https://github.com/git-for-windows/git-for-windows-automation/actions/runs=
/14221753030/job/39851304688#step:16:2854
shows that the Secure Channel version is compiled without HTTP/2 support.

When you configure `http.sslBackend =3D openssl`, does it work then?

Ciao,
Johannes

P.S.: The bug reporting template of `git bugreport` sadly omits useful
hints such as including the contents of `/etc/install-options.txt`, where
others could easily see whether you chose the Secure Channel or the
OpenSSL backend as Git's default.

>=20
> What's different between what you expected and what actually happened?
> I expected curl to be able to run as before when contacting our backend =
in our maintenance scripts. I'm not allowed to install a custom curl on ou=
r corporate network, and the windows version does not support HTTP/2 eithe=
r. But the git version used to.
>=20
> Anything else you want to add:
>=20
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>=20
>=20
> [System Info]
> git version:
> git version 2.49.0.windows.1
> cpu: x86_64
> built from commit: cca1f38702730b35f52c29efd62864b85e85ddcc
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
> feature: fsmonitor--daemon
> libcurl: 8.12.1
> OpenSSL: OpenSSL 3.2.4 11 Feb 2025
> zlib: 1.3.1
> uname: Windows 10.0 20348
> compiler info: gnuc: 14.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash=
.exe
>=20
>=20
> [Enabled Hooks]
> not run from a git repository - no hooks to show
>=20
> DSV internal
>=20
>=20
