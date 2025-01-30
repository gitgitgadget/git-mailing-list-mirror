Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702EE2BAF9
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738204188; cv=none; b=ICNh1vmqe9+mFwo7tsv077vOqSP51rLEWo6UV+n/CToxU/bngeAMdNiG21OwR+Nk8gKxsIgYa1hZissAAAIUWq8z2LISFDB9fYnjoyosy1FN0q6h8ZhrgPUHb9vKSstd/88lV6g1n4m28ndRmvOPj4V2IcFcf7aZpl89HBeLUYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738204188; c=relaxed/simple;
	bh=QFAOOv1XGCrilCz07D4HjFlKnew6EMOO1GLPXwoCYAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYrId1vbSABzxWgGSPuwu9MEAtEE51k4iDnAblKUrNSk7MENL0F+/fXUKMs+F3fW732oS7JPmEEfhM2SJip9VsIiFuULmteepRUvujIJUx60C0HTVrmIznodN+AnyFyPbf8q1xAHxCMtcI2+4vxdS1065Jg8KZsD9slNZRR5U9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wTz1BU+E; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wTz1BU+E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738204184;
	bh=QFAOOv1XGCrilCz07D4HjFlKnew6EMOO1GLPXwoCYAY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=wTz1BU+EGNLvp6l0dCx7znm46DAN77yWkUQVbc2Qq3yhylC6L7UwRzsGeixl/498z
	 gRoPfU92BT5AKxh29G6NNW0zlxzG4EtUYjWTXMaq5GWFHhWWoMuCtgMJawoq7CHLHq
	 5XBJdt/FKibA+NZ9sKLNpfGS0TLSmcrLywQMeB20SRC/8HZOMSk2+yDVy8S52cY3ba
	 jxPM5XbwapcTN+mt0v90IEAiwrVPqecZvcCQC7HIfpIYPAa1v3kfvNIjrTIzVyUvmW
	 8UmjtxAM6TELFB0RKVYC0KvIou2q5m9GtQ3SPm4xAz8ngtuPG3c+S++7daGHPdYTav
	 a+L+slqG+KBgHwxkIO8KLlPAGcpCCPYi3Tkb6kXNwQxnu2JzZhUoT3BFMSkXbDg9ik
	 zXZJj915AokZDSPPi4K6a9O7NEKWLjnO7fcxqxehSSvckA6xWHqRGFG7rd0Bm/Vt2N
	 JI5LPVK3CcpKRjOb5aCfm27Mvn10C12G4RHMEjmiQmyleyWTQ3s
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E392220042;
	Thu, 30 Jan 2025 02:29:43 +0000 (UTC)
Date: Thu, 30 Jan 2025 02:29:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #07; Fri, 24)
Message-ID: <Z5rkFcp_awa2hjxu@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
References: <xmqqwmekvubv.fsf@gitster.g>
 <20250128164606.GA1688180@coredump.intra.peff.net>
 <xmqq8qquom4t.fsf@gitster.g>
 <xmqq4j1iokvv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vBMQD6y+QhwcQG5l"
Content-Disposition: inline
In-Reply-To: <xmqq4j1iokvv.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--vBMQD6y+QhwcQG5l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-28 at 18:26:12, Junio C Hamano wrote:
> Here is what I'd directly apply to 'next'.  The merge-fix mechanism
> knows about the same change, so when I merge the bc/doc-adoc-not-txt
> topic down to 'master', the same tweak will be made as an evil
> merge.

I agree that seems like the right solution.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--vBMQD6y+QhwcQG5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ5rkFQAKCRB8DEliiIei
gXNsAQCY8bPSQJ77i+istH3iULD3pkpKKSK5EdkcGLyG0xICVgEAhKlNLWGPufmo
aynXVu89WFty+1pdYNJn+NxRS0xzows=
=H1R0
-----END PGP SIGNATURE-----

--vBMQD6y+QhwcQG5l--
