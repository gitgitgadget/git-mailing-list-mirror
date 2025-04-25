Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BF423FC49
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578162; cv=none; b=VS8GHlWrncLEnHHiWZ7Z+qxIQrKSD1F7dHSgBKOULZSpp9zzTkUue9l36jE9DLw7LnMdSXdudKanra84J714KecBZnhu6GanRqYrp4GAi/CAhEyIzXNRvVSLH+LK5zePp61zOush1msh1Rbkr93Wmm3wQ4MteBfCNMxhYJUO28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578162; c=relaxed/simple;
	bh=S+gD3tdJgcgq+ux0hrTFc3IMaZKSmKMfYBdzkRFVmlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TybQ6oIc7mT/KUdreeqvyqshvHdG9eYV1on7koklWdZgcIajvNIc3qz9zkJChV/TH5d2xM10MYhka1r/3RBPzlJ5fbBfKiXOUJe+npvqExdT9GIt4Glh1NaX3V7Nu0E5yDwBk6ofVjTZ3PjI5dyApDIb+ml0jrW32/+WQay3kxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fmAZVwSN; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fmAZVwSN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1745578152;
	bh=S+gD3tdJgcgq+ux0hrTFc3IMaZKSmKMfYBdzkRFVmlo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=fmAZVwSN41sIe46kY5vWysVoUZ7LWWigvlkQeDKIFK1QO0rfy7AmLBV0mMgEbdwMe
	 2lhIUKVfH9k6GRowbAvL1WxUr3r3kwYqR5VSJl0XnudT37HBgyLS800IIpZpwMX0ya
	 aNd6Y3XArtGI6ZD+EHRU5Jovdpe/MZQREY17evFqOQpMPbwVVqH2Iu7MAvLOVeFCp5
	 /PWMmljcNql8f0c1ibK0T/jyfOQdPU4EBSm/0HpOBAz4cOU1Dh0RCFilYmVnUCMiTj
	 ZJB1tXJ52YZy3l1sj3xh8Rj4z2i2biN0Kj4QVdg+txD4T4XK34GlzQhBPbqKAOWQ+g
	 ACm2/o5aEPF5QReRLKQA3ceqtBUJUbEPHbCOrRgaDCgfk0QNJ4t3+hg0bfrMqRoZ1/
	 Q5tMr33bC9y5VGO/DyEmUjszkfXIuxJqf9HYpTvxXUMv/bHt2k2nLrC+gz31kY+9Rx
	 l5t8jY0Ipyi3KT5rs3b9lvvAh1gbMnhPuOpF90KwVibMJ2sefQT
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0089120114;
	Fri, 25 Apr 2025 10:49:11 +0000 (UTC)
Date: Fri, 25 Apr 2025 10:49:10 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 2/2] meson: prefer POSIX-specified shell path
Message-ID: <aAtopiMkJpF2RdjG@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Peter Seiderer <ps.report@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Justin Tobler <jltobler@gmail.com>
References: <20250425-pks-meson-posix-shell-v2-0-fddc6123511b@pks.im>
 <20250425-pks-meson-posix-shell-v2-2-fddc6123511b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gSGnO/frsapWRZFe"
Content-Disposition: inline
In-Reply-To: <20250425-pks-meson-posix-shell-v2-2-fddc6123511b@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--gSGnO/frsapWRZFe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-25 at 05:47:45, Patrick Steinhardt wrote:
> Meson detects the path of the target shell via `find_program("sh")`,
> which essentially does a lookup via `PATH`. This may easily lead to a
> subtly-broken Git distribution when the build host has its shell in a
> non-standard location that the target host doesn't know about.
>=20
> Fix the issue by appending "/bin" to the custom program path, which
> causes us to prefer "/bin/sh" over a `PATH` lookup. As this location is
> specified by POSIX this should make us pick a better default shell path
> on all POSIX-compliant systems.

Can you provide a citation for that?  I don't see that in the POSIX
1003.1-2024 directory structure document[0].  More specifically, I think
there are some proprietary Unix systems where `/bin/sh` is the original
Bourne shell and is not POSIX compliant and some other path is the
POSIX-compliant `sh`.

I'll also point out that we require more than POSIX compliance in that
we require `local`, so even if `/bin/sh` is POSIX compliant, that
doesn't mean that it's suitable for Git.  `/bin/sh` meets our needs on
all the Linux distros I'm aware of, plus the BSDs, but if it were AT&T
ksh, that would not meet our needs since it doesn't support `local`,
even though it's POSIX compliant.

[0] https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap10.html
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--gSGnO/frsapWRZFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgLaKYJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ0ub0BNKpxm/Il3NLUhRqcL/Wry5czjFg8msbYSjFhkb
FiEECCzmip28ZfuD0cORfAxJYoiHooEAADayAPwIyOp5MYur0cMvZ1sDVz1ap+8M
K6NfpAQpqxTmIC6nngEAlvkMgYWlePopE3cZIb4qRg8s6vlrlCW7e3Oj03PJ6Aw=
=pkRj
-----END PGP SIGNATURE-----

--gSGnO/frsapWRZFe--
