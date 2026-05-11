Received: from mx1.b1-systems.de (mx1.b1-systems.de [159.69.135.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43E3815CE
	for <git@vger.kernel.org>; Mon, 11 May 2026 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.135.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778534504; cv=none; b=Cz6ahydL6x8Jv+270DJ7NUpZX8Su/0Z0n7mLYsLXmDeG4X4nb+kOZvBgLLQfMcTrtzMObOCqyAuxXjJvWkNkgDbY1Gwh8/uSXfeHIPMpghnBwZGxggAqVXocfwV7MuikjUY4mIUbmNdVO1/3POQoW9/d69JQCOOj1Nud//Dgtno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778534504; c=relaxed/simple;
	bh=VAZEgMTLUyL6ypAnCPT0fKCVlU4tV88tU3KulEuGKgw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=g1gf4EPOIhCq1zI5Ada79PgsOKY4z/F2ke60eEgbFdOqu2fCSWkGmZFSSJHxyZt8IGcsK4MZab7/XkwAvlBATwZsUV3gwEY4HVX51Rkqm1T6ZQmWj7fYSVS7m5VxhIOrnqsUc4n66WhKnMmcxjIbf6lYL26dFlgxJH31eZWCdho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1-systems.de; spf=pass smtp.mailfrom=b1-systems.de; dkim=pass (1024-bit key) header.d=b1-systems.de header.i=@b1-systems.de header.b=LdQLD4XH; arc=none smtp.client-ip=159.69.135.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1-systems.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1-systems.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=b1-systems.de header.i=@b1-systems.de header.b="LdQLD4XH"
Date: Mon, 11 May 2026 23:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=b1-systems.de;
	s=default; t=1778533999;
	bh=VAZEgMTLUyL6ypAnCPT0fKCVlU4tV88tU3KulEuGKgw=;
	h=Date:From:To:Subject:From;
	b=LdQLD4XHq9fTUFWohOLt65GK7YAAM750umcF+13IdbHa/iSy6eSs6XxVl/w2KDE8q
	 If9RcEnkJVapx3rYo6r0jR9VR9Yj74ZrUXBQ58VUI/yCYnp6JNnMiWOCJPAh7V2A9q
	 U8gWfYej6aWdVP+fF1DQqosvNcobSHBYnEtR0/fU=
From: Thorsten Glaser <tglaser@b1-systems.de>
To: git@vger.kernel.org
Subject: git hard-codes use of /bin/sh for aliases
Message-ID: <6791cb26-16af-dcda-1dae-82b85da6fb0f@b1-systems.de>
x-ms-reactions: disallow
X-Zitierstil: Wir wechseln gerne von TOFU auf den Usenet-Zitierstandard; sprechen Sie uns einfach an!
X-Quoting-Style: We will gladly switch from top-posting to Usenet standard quoting style; please just ask!
Content-Language: ksh-Latn-DE-u-ca-iso8601-co-POSIX-kk-false-em-text-rg-denw-tz-utc-va-posix, de-DE-1901-u-ca-iso8601-co-POSIX-kk-false-em-text-rg-denw-tz-utc-va-posix, de-Latf-DE-1901-u-ca-iso8601-co-POSIX-kk-false-em-text-rg-denw-tz-utc-va-posix, en-GB-u-ca-iso8601-fw-mon-hc-h23-co-POSIX-kk-false-cu-eur-em-text-rg-denw-ms-metric-mu-celsius-tz-utc-va-posix, und-Zsym-u-ca-iso8601-fw-mon-hc-h23-co-POSIX-kk-false-cu-eur-em-text-rg-denw-ms-metric-mu-celsius-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

git aliases don=E2=80=99t use the user=E2=80=99s shell but a hardcoded /bin=
/sh,
and this cannot be made configurable.

This, unfortunately, breaks quite some aliases and they cannot
be made portable by adding something like core.sh =3D /bin/mksh
to the .gitconfig.

I=E2=80=99d love if this could be made configurable.

bye,
//Thorsten
--=20
Thorsten Glaser
Linux / Unix Developer
Tel.: +49 160 91168501
E-Mail: tglaser@b1-systems.de

B1 Systems GmbH
Osterfeldstra=C3=9Fe 7 / 85088 Vohburg / https://www.b1-systems.de/
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt, HRB 3537
