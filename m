Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D86D342CA9
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776462699; cv=none; b=Uh1YJ2gqSaQgGOfKXmxGbDBC/Cgaa9PXFlmtJxSOeFDMk/ddXXwNyXAFnq2rCw5cnHdjatEJUpY2lWeABNY52/+bwVwriVMCRIj/wa7g1q8ybVKCEf1jB5mWqlOtdElAExNCLaEh1ZycbWv97qAYYNg1+qoPGh1VFLV+K63kZmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776462699; c=relaxed/simple;
	bh=C8v91OGFhAI3AZIr1hyLv1jEsgKvuzq/3afLU+C5K3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPwYmlRrTosRY0aB+6mx6Vmv3zqm192jC4LZ8k/qV5edDlOj7nNf92GJpFxnRG8WrM7VhRA8rv7G/SH6FuROYB2PG+JVkHg1AAnSMfQITTgDIBK0M1SMOC3pei6LBEPBpd2kCxiBrWOXv9FFbaQiTJBV5S+WLIN36jTVK0OFnPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=OEeiBQQo; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OEeiBQQo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1776462689;
	bh=C8v91OGFhAI3AZIr1hyLv1jEsgKvuzq/3afLU+C5K3k=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=OEeiBQQoDVMfw7UjOtpDYOO2Xmw309faN8AITSBwv0v3dtVOfXpXwgXbUfksGV/e7
	 S5SyBoDYFRW1e1FLQlVOpQGMIz1SZW/He6r/fD81nnHTDBmG2MDNUyqO3kJiDv8k/8
	 OT4KYgn5df9CMj1XqTPhN1MdJyBLshBYurEFEcSQAV3dGIhwDLbPdSMMqo/LgbTqCJ
	 7Npg0VWhwF6JSahuUw8IB0xUXDPbhhYU1RhhRXOwqUe0NO+anU74L6gvJPlp4T+4eY
	 +vz12BnLbUdan2clm7L9q0wz2JhTpx/FtRFSoMKyVsip+NYxsW12EHn32zct3oG/ud
	 I4jVkg8APIK8XUa8l5dX0m+RZIFR4BfaKvOsRpGp7lp62aFKMhzi42tlMq1HQlgceZ
	 Y/iOBtj8WAeUx+/gJBP4HPgm6y9QUl2L9+Sy3Ux1DVogzckyYJsXy4fUE8B4eHRtau
	 1nujTHm6bwoDaYSUq84Ywz438nys0iL9J94BHLL5v7ntf1eMLh7
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8578B200FF;
	Fri, 17 Apr 2026 21:51:29 +0000 (UTC)
Date: Fri, 17 Apr 2026 21:51:27 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <aeKrXwdnHjhsVQBI@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
References: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
 <20260416-pks-libgit-in-subdir-v1-2-03afc731df55@pks.im>
 <aeKHhHVPUxqMa18L@fruit.crustytoothpaste.net>
 <xmqqfr4twaj6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k6xFpy62zoWg1vEH"
Content-Disposition: inline
In-Reply-To: <xmqqfr4twaj6.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--k6xFpy62zoWg1vEH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-17 at 21:18:37, Junio C Hamano wrote:
> I do not mind a move to thin the set of regular files out of the
> top-level directory.  I have forever been annoyed by my buil<TAB>
> no longer complete to builtin (anticipating either .h or /) and
> it would be nice if build.rs is renamed away, or builtin{.h,/}
> are moved away, to restore the convenience of tab completion back.

The `build.rs` file needs to go at the same level as the Rust `src`
directory so `cargo` can invoke it properly.  I think Patrick had wanted
to put the Rust code in a directory called `rust`, which would move that
out of the root of the repository and fix that.  As long as it continues
to build gracefully on a variety of platforms, I think that would be
okay.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--k6xFpy62zoWg1vEH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmniq18JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ1M0IdSapMnLG2W6dL3ZbwxRYpWR8AYAPZLiZYsq7wMM
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAIjHAP48qSmb+A198pCEiKSHXvBDp28j
A68qGS1nQu1/k3N6HwEA150X7eMcqw7QiSu7LPQSV6MmXGZ8SLhuRMvYLBaawAY=
=GkCw
-----END PGP SIGNATURE-----

--k6xFpy62zoWg1vEH--
