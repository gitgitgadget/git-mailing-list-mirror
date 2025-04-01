Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687320C47B
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522932; cv=none; b=Uo8YIb9MtGsnSjoA+L/Uyjmcp3f4uOZXJrMei7vAMdcYT0UHo+l66E+ux+BIoYSwOF1HQ+E9FJ3mchE/P7212+fhWYYeEEZNgIvha2x3pBOPQtnfcMjtbS4yT7/gSYjbnhvCRKRSnc62c5v0GY2mo8Tl2BlSMEHRbKtjJCA76pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522932; c=relaxed/simple;
	bh=/LuiMP3E70SHA/FZbpjtXvIinhR66n6f04fRLwCK7lw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jhYkgZrYKO+KHh3EwRb/KuI/Iv38lnKO4vNSMeWJZha116kAbTgjq4gFXNt/8ZI63E7jwDCgTcM8pjfkssb5Xy9s74SsRtUzfGXLRIM6elJnQI2vj0nLjlEnou2b3baYcgUenEzg/cfLBTucJITECMpKaKzJt/jo7nvkESa1gTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=TONP0PII; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="TONP0PII"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743522927; x=1744127727;
	i=johannes.schindelin@gmx.de;
	bh=ebQfqIAH1iJqZr5oyvWUdjwZppfqr0E0xOic7lReIEs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TONP0PIIDafwfCRRBzedDYz0ouxTILXKdluA+PoIMcu+vISltzcMB6QdxcFhbYLs
	 IU6/RHUoRRIDux5Ziw7XD9dJVqte5hDRG1hKwgCt8dAE+lzVRy7Vfkub/C9WmHbJz
	 jd+TD7DAaoGJxMM+VBkBqXqeQPCzixMap6FVbinH9L6Xc/82aW7bhFa41/jRAbDAR
	 rhCaEI0/2bKevtejGxsqbwZQTZq6YI/IrnSWwepNFLYW/ts7SdQPhMlBXBpMGmH28
	 KYZm00tWWiRbOCF25uC0Y0N2pFoPlCDc+Axvp14AUjswMNfz50bG7xa2U06EE0HTn
	 f0guUjboGNZe5KbE4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXtS-1tZLdH2z20-00YUse; Tue, 01
 Apr 2025 17:55:27 +0200
Date: Tue, 1 Apr 2025 17:55:27 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Milan AJDINOVIC <milan.ajdinovic@se.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git client bug with branch containing "."
In-Reply-To: <VI1PR04MB695864E125F3381932332BDC91AC2@VI1PR04MB6958.eurprd04.prod.outlook.com>
Message-ID: <4dad78d0-efe2-e01f-cd5f-097259bf961f@gmx.de>
References: <VI1PR04MB695864E125F3381932332BDC91AC2@VI1PR04MB6958.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1o+asThwjbMC6YV0OjLY4qmTpAwmznEByi0cPTbBTf2q9yTZSiL
 YZfcZs1erf29GARj/k+eEo2NwUFTTBSrAS8j8et8MXv+myL/XHBFCpGz3WYQUbctmtSJYo8
 J1x9YdMUOkgw/IVZrSC60jN8yQzbYsCE3hVs20NLDVAGCUpuYnbYAYNqsUM1Wqi9a84kGcp
 rjzpei/OQgHOrqXvlvIVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m2IOm75odPQ=;8wR3lxWyJdQE/GacMdGa++IzptO
 y7WMXNFAVGn/rgdDa61qKYi1DYz1Mte6n61N2hQ0h/Wix2pvA7E2hmgVvTfCP0z9U2jU666W5
 UGOYBzqIdRCMuHif76YHVdr5QuWZYQnjGCJTNqYOGg7rnKkEi6RIIwAyENcDabCBLzZO/ykDC
 mYTqoHsN5lG9NaZPJ08ueRjiK2g+/RaUN8jbGz+ah7CtjhG+Qci3cemkbo3P21lRuhtdIR7+J
 7CuknnK/482fg7h+0B22FuYh1QXBwUJbXtuECPryqDKNYC6P4yZk/fOGS2LW/BLWWyzDnaMUe
 2dGfsQIy0na9CwGnWl93xjNEw9mFFpdJOmn8/l6DyOrn3hzQZUO4sXC+urg4RneH9VrX6/hw8
 nd+hhYmUoQkLP1fPdZCBM02pKgGCtq6e6cUXTTPBsQRGbUSuU4RSLMtRkcsqSmf32vKBpQT7g
 h8X4VN2mGdFhBsCYZSYCheORJqwkZoeIxqNnZVF88rXW8j5++wDsZgxqZQUQWPChB9DN+v5Ic
 YWZaq8x53+ef/rOoGE2D2KXDJJc/prdqRdfEes3ljU0bYF5FXKQKhNEsvrr1lGqUIvgUlVM2J
 pS2ly890QUpJ7vF4zuekEsylg/GR0De9qYXnocMf+Z7IqW3aaeFWFQOMMFBVAS6YYJlwiB817
 qjH8qcJ4eY33ewdC1aktIMPDZUUpRBwZlCAIbYkDI8cKZYXMrpfU5kQ1wCB6xJZX8lSDAIb5v
 PL5HF9f2szAW+6tMj+PJ5sRZhqaZssLXEkxPWnuElabfWPzPQQnw9VprxLTVXijF3j66grhvx
 Dj3NZgDKVGWsgyWG+GVIkqFPrF5NZukiIoSM8iiH6gPGYGiu2gc58b/IVg+BCNUwwbLSkjpGW
 0XXTlqmUI+SrYNR0D3Z9vTtPiQ3ImSqtzOeNGlPa477unwQ1nFQsjq1EU8s41Qj5n3lBrl8IA
 ubQsH06GRlt1VgoN+UtU37J9KcFf+ff3TcXuf1A6zn+JNp+3HOZz/SRzEG2AAr0J2SsMp7Js5
 BsRob/TwZNCvxDUd/aQt6ASXv8r3rxkBiGUP0O9411sVWhEscFUpA2FYT6cv9wqIUfjiqr/sf
 Hj2BPF0SAoC1sfgcxTw4h/1hXLB7VYxH6OCwjntWYlyRFeCFwkN8u6djsqmet3t5QVLTca5ZE
 Dc+DKnQHsJKStz8jlhNRnXpOR8LeSeVAyqgd55JfK52Gh93vwmeUGpol98gtzZ6AMUXDKvUtl
 hZ7sIbSyb+POfDs6fXA83r+NrjyUiCnmPHHlOxRSTHKM6auBa1ForZvwqZdrw/SE1CBmYG6HE
 5Eb5jy6eZUGKGDSop2HnLtWBKAQZ4HPGnCTozQzqjbJwmE//V30PFKWVFeuXafSCrSIzukEB7
 VXaEjIJCewskyoBhmEmHuegKrJ4fNdtswk1in6HUY0ytSfNg1R0reMxN3z/+ui6CibV72XD4c
 bF/swELRnuXUvrshEg+4xKg7purIwsUVtnnkRhyFo/SHK1StS
Content-Transfer-Encoding: quoted-printable

Hi Milan,

On Tue, 1 Apr 2025, Milan AJDINOVIC wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> On GitHub Enterprise server I have created a branch named: features/team=
1/feature./1.0/main in my repo.
> I tried to fetch the branch and switch to it.
>
> What did you expect to happen? (Expected behavior)
> I expected for branch to be switched to:features/team1/feature./1.0/main
> What happened instead? (Actual behavior)
> I got an error: fatal: cannot lock ref 'refs/heads/features/team1/featur=
e./1.0/main': unable to create directory for .git/refs/heads/features/team=
1/feature./1.0/main
> What's different between what you expected and what actually happened?
> The branch did no switch.
> Anything else you want to add:
> From my analisys the problem is because my branch have "feature." in it =
and Windows can not create directory with "." at the end.

That analysis and conclusion is correct, as per
https://learn.microsoft.com/en-us/windows/win32/fileio/naming-a-file:

	Do not end a file or directory name with a space or a period.
	Although the underlying file system may support such names, the
	Windows shell and user interface does not.

The problem here is the directory name `feature.`. You cannot even track
this locally, at least not with the way Git implemented its default refs
backend because it wants to map the ref name to a path in the filesystem.

Note: It _might_ pretend to work when you clone, but any subsequent fetch
that updates that ref will fail.

Your only chance to track the ref locally is to map it to a different name
in your Git config, like so (`git config edit`):

	[remote "origin"]
		url =3D [...]
		fetch =3D +refs/heads/*:refs/remotes/origin/*
		fetch =3D ^refs/heads/features/team1/feature./1.0/main
		fetch =3D refs/heads/features/team1/feature./1.0/main:refs/heads/feature=
s/team1/feature/1.0/main

After that, you should be able to fetch and then check out that branch
under the name on the right-hand side, i.e. without that `.` after
`feature`.

Ciao,
Johannes

> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.42.0.windows.2
> cpu: x86_64
> built from commit: 2f819d1670fff9a1818f63b6722e9959405378e3
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19045
> compiler info: gnuc: 13.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
>
>
>
>
>
>
>
>
>
> General
>
>
>
