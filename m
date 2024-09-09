Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4161B2ED5
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875077; cv=none; b=Nk1ika8GMGH1xk+x1QswHQ44B/ZjJhhiUu6DGF9rrHnaGkDq+KfJ6oCZCg7MRU/vP2brg5WgJtaAbxFhZ+0dWq6misiQGLaTNqSFfhYAPaxH2RERxeO5AR2wUO2yjHgBH84pnBHtV7Y8Fi/qidnJwOUx1z/uprOdEjpu9qquE0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875077; c=relaxed/simple;
	bh=upicJ/WYRln9UqrCxZ5KZtv+BP3eiu/T5Q20v97aPao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nh2irDEG1A0UZHDpXi4MgQQ6Iif5PN1dq+aWONy8aHA5t5AToeyLmsfjuMkK9BXrshWy1VTQ1t9WdwJUUbbMt+NS0+gafD0U+LmG8N+eVCA1CZgn6zPgOk5Pco4dFYRqrDDmA4sOAWOvsGdic+Nx7JjXdw9lplCCJqLlfVaerHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YWd5lME3; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YWd5lME3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1725875067;
	bh=upicJ/WYRln9UqrCxZ5KZtv+BP3eiu/T5Q20v97aPao=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YWd5lME3dE09DFj9GmM2MTdemEEwXgFNkIpe9cfQRO87ljG4TB+tr918UaxgWOa1S
	 HUhh18/idf1YBlk+syntCO7CaXi632qeZEccu1JaBXL0YQVkwUUR9NZ7EPwHXAvCgX
	 d4etl5j3SlQG2zARkGtuGZFam+jswN4IeDDxOJw6uZLd4Bi3wPUPkDRm5egaHSVnCU
	 K4UprzlpfN+JxazvXreSN/XkDNibu2CijR6jxQJoM2YJYRDQOosHpfUrevU7IATTkn
	 AS52p2eqzobXZZsI/RmtAUF3JOq8ttJQekfLXydK8tO2ufWrY6NQvMwc9uNh44m2jm
	 dWV38bPahOdxe30Lxvx8/3+X/q5+wnayXUGZbBBed3HZi/6+7rThWuCPIaC2JJb59v
	 SwG0O4f8msIVVzOwNHWS9faTmLv+StixnNqj+FV+VrlTeM2tf+5j3TpFUrDXXKtMkz
	 6+p9MHXlyXTO5tpSlKRBJkoqVfJLHXmSimEiRnIw6Q+LoKaE3av
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 86BCF2445C;
	Mon,  9 Sep 2024 09:44:27 +0000 (UTC)
Date: Mon, 9 Sep 2024 09:44:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: header signatures for hash transition?
Message-ID: <Zt7Deq2vzZKSTbfU@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20240908233636.GA4026999@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ke8PD+wDSQFH3B3q"
Content-Disposition: inline
In-Reply-To: <20240908233636.GA4026999@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Ke8PD+wDSQFH3B3q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-08 at 23:36:36, Jeff King wrote:
> Is this a direction that we were going to go in, but ultimately didn't?
> Or is it something that just hasn't yet been fully implemented?

I had not intended to add more functionality here.  I don't recall what
I was doing, but I think we either needed to parse this for some set of
atoms somewhere or I had intended to replace all callers with
`parse_signature` instead of `parse_signed_buffer`.

I remember briefly working on this code and that it was a bear to get
working, but not anything more than that.

> We still separately find the start of the in-body signature and return a
> "size_t nonsiglen", though it's a bit awkward (it's counting from the
> body start, and I am coming from the subject start, but if we assume
> they're contiguous, it's just a little pointer math). So if this
> approach is still useful in the long run, I can work around it. But my
> initial approach (before digging in the history) was to drop the
> separate buffer, something like the patch below, since it also drops
> some useless extra copying of the tag contents.

It was probably that this code was to fix one or more of the
signature-related atoms in the tests, but I can't speak to it more than
that.  I trust that you'll make a suitable change that fixes the issue,
but I'm afraid I can't be more help than that.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Ke8PD+wDSQFH3B3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZt7DeQAKCRB8DEliiIei
gYxrAQCh0xS4T/e19qkf6H7H7hBy8/UkZ5NtWZSOe9cbewL7xQEAo1Cww5NeUke3
kT4fPCqRhjjnOmElKkCCl45jdpjU+g8=
=H71v
-----END PGP SIGNATURE-----

--Ke8PD+wDSQFH3B3q--
