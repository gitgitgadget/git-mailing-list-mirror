Received: from smtp-good-out-3.t-2.net (smtp-good-out-3.t-2.net [93.103.246.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4361E4BE
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.103.246.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772868065; cv=none; b=AKkMuw81BQezkTra1nrIMvmE6g3qHSzM+efZEH7cfF2Q3S/qoHNCKWKQvpTz6HKw/isHyLFwOEmlspkeZw2EXxD9FFd8vV2OMgzUuycb/XsEps2qQJmeEsFnEIN9LRTLjxD7A2q2AdSieZT5vT2Uxf/lWeVIH0QPD7OOTm+YaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772868065; c=relaxed/simple;
	bh=tHUr3yLAaK+Fp5XfNzus4lk+4QWCzbCaa1MdbVVD0No=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lBou1/L20jnAJg7GCDExs7y1hcE/G8YgWx4/mUwTqoXsD64anfoY/6TwLmXxvnmRBUoEyq6AcnLRZTctZOy2V7MN6vs/WPMrI5KXZi7gIPWbquv/3y+HyLBElZ2o06wLz/ei8HZ1WVB19aAZTVqijxA0x2QQOM8JoSp9WpUWRVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net; spf=pass smtp.mailfrom=t-2.net; dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b=mayX81OY; arc=none smtp.client-ip=93.103.246.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-2.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b="mayX81OY"
Received: from smtp-2.t-2.si (smtp-2.t-2.si [84.255.208.31])
	by smtp-good-out-3.t-2.net (Postfix) with ESMTP id 4fSZJk1yycz9vhVW;
	Sat,  7 Mar 2026 08:14:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
	s=smtp-out-2; t=1772867654;
	bh=tHUr3yLAaK+Fp5XfNzus4lk+4QWCzbCaa1MdbVVD0No=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mayX81OY7ElaYrm6/cdBRQH0uW0RQxQ5W7ZXtpELC/8KErzmHbEqv3z2e8zrPXzi4
	 aC/2NZAMR5iQ4CIver1SpgJxsQBdTOl9rOvEDvVhmOk99Igk+Wz7Gt2VW2oeVA8OX0
	 RbLkPGc9JFngF8qiL+YakgCX7853fEkxd6H6olPg=
X-Virus-Scanned: amavis at mail.t-2.net
Received: from [IPv6:2a00:1a20:218f:f69b:42ce:89ff:f869:9062] (unknown [IPv6:2a00:1a20:218f:f69b:42ce:89ff:f869:9062])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: samo_pogacnik@t-2.net)
	by smtp-2.t-2.si (Postfix) with ESMTPSA id 4fSZJQ6sCzzMrVKs;
	Sat,  7 Mar 2026 08:13:58 +0100 (CET)
Message-ID: <418dfce27b2812a696dee791e81a0049400e50f4.camel@t-2.net>
Subject: Re: [PATCH v2] shallow: set borders which are all reachable after
 clone shallow since
From: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date: Sat, 07 Mar 2026 08:13:40 +0100
In-Reply-To: <xmqqy0l5b06m.fsf@gitster.g>
References: <pull.2107.git.git.1763807914242.gitgitgadget@gmail.com>
	 <pull.2107.v2.git.git.1763926552033.gitgitgadget@gmail.com>
	 <xmqqh5ujuekq.fsf@gitster.g> <xmqqfr80xanx.fsf@gitster.g>
	 <3253600a3c96144744d3371a7ec2a66cb87d4b60.camel@t-2.net>
	 <a60fc6aed8ab7345219118f933ac0eb61140334f.camel@t-2.net>
	 <xmqqy0l5b06m.fsf@gitster.g>
Autocrypt: addr=samo_pogacnik@t-2.net; prefer-encrypt=mutual;
 keydata=mQINBFwCXogBEAC4B5dfY/m82d0d5VBtFeVAjtUrOOdrLgbYJZFUXsX9pya5x0QdYeTP4
 afUZ73e7zMe0ozH8UMz6iv1niPfPkMorUzNcALDcotZ8Vvf3bMdndV7lHk8jScAMoW2L7VHGn1N+H
 8yJ5WufqF/yNBLqmVqaLqNjHejZN+Ld+/4AaJ/gQzWVqYH6EaJZd/LSqppJWGOHGGURFakFSDp3Bi
 6n8SOQmarOt6mGX5wsiHNwa8NtNX1cEJPT8YCQUR7o5fTHb3AEemLRFJoGjeH2RjzPloyTlwSjLXd
 Egph2uUGqiBKD1dREfIuIWtFAJF+iMRHhIEJSF4hvUYrYAV+7ZTlIo3NnDLIeNn40Qmn++9Uh8FbL
 YdFb14dyBkw8MBBQPQNCCpBflK7aaSFWpHv6nk/Z7fGrkwrD51CHsDut8PGQMtmSYMoSCWRI1wChn
 peoZn4Cq3yG1rj90IVv/rxmvL3oMQfE2oSMAhpyRPi0vK68cG4ILpO65Aulr0wr4JFdZBNmpf8BCF
 4jqpN1HsQJCYUYBMeMeOMkH9Gz3DBWuszvjjs7wmesMkEz5C92UlK6FWGUz6Ioi2bfRGOzx0+AjpZ
 rUaSIQ+5MCPxjWkxl3EQQFL2U3ItxxpaDO46AoRFj4oKKeHoteiwpziY8whIFmDXWfy7nDfp76RiS
 riLtyZiFEuzLwARAQABtCZTYW1vIFBvZ2HEjW5payA8c2Ftb19wb2dhY25pa0B0LTIubmV0PokCTg
 QTAQoAOBYhBNCCwgeDpWpcp2HPBvAkWUZaOuMIBQJcAl6IAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4
 BAheAAAoJEPAkWUZaOuMIKE8QAJ04bxv8nXpY3Tp5nWOIOsBmEHWvVEIdD2kxjC9YCQeKx4gJLADa
 RcuXhFbwi0NQtuSRf1G11ZGqxBM/YHvSd4Rtqbag4P9UY/ZdvMAe1zW4HTO9c2mtoWN3WYxS/gkX+
 wBLVIy+eqrsG5peJmRlq3fTbCxLprgqp6B2IUcTEBa8Iynv7B/1qsG2rd0y8pY+ZHIUtz2ZJHoYz2
 Lx091uYwy9aozibWRot+vZNx4QipOmsoZOm+e5FvTf4yvmFYJ3iR8fUfq9gpCokRNtPG5NvqNLApk
 EwEAlaXH7flAUwF/uRBUASZeyEeKGRtXOUYeGXFyOgykbmIs9IXDms8OLj/TZlSzECeoSX25I0P8M
 QrMb7GChMME4W9i9+ZZc8VWPyYW8W6dyNfBb05lu0XMB62oiYim7cOXiDV49EBYtiXIwUnbfQYVSA
 U8MTvZKS4ek2KGc9OJNLnm8dP2u31jvMUts7AEoU3vxwv8tUBEm4Zpzv8+HvzpAGAnbGc/kiLClaH
 j8E5d/3XIyq0TXlZf7B5Fq+lwa3gXMiLWko7m3PfOFtvbsSWPxplka6r2T2GMt9e51sctckfd7V/F
 unQvSwML0gpE6YicA/OcoFFOwoipilJ4D0YcqLgO8FNQdXukJciq0xeeBWY4t8Oo5M88J4YzAKMr9
 PU/BhjCBDTyCb2b1
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-DWUsOf4KfjNXXopgUFMz"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-DWUsOf4KfjNXXopgUFMz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-02-06 at 21:19 -0800, Junio C Hamano wrote:
> Samo Poga=C4=8Dnik <samo_pogacnik@t-2.net> writes:
>=20
> > On Wed, 2026-01-28 at 05:23 +0100, Samo Poga=C4=8Dnik wrote:
> > > On Tue, 2026-01-20 at 12:59 -0800, Junio C Hamano wrote:
> > > ...
> > > > After this exchange, the topic has been dormant for almost full two
> > > > months.=C2=A0 As I do not deal with shallow clones myself, even tho=
ugh I
> > > > understand that some folks rely on it working, I'd really prefer to
> > > > see somebody who are familiar with the underlying logic to review
> > > > this patch if we were to move forward with it.
> > > >=20
> > >=20
> > > I=E2=80=99m currently rewriting the patch and the commit message tryi=
ng to
> > > address the boundary/border dilemma. I hope to be able to send a new
> > > version by the end of this week.
> >=20
> > I posted a new version of patch '[PATCH v3] shallow: ensure all boundar=
y
> > commits
> > are reachable with --shallow-since' on 31st of January. I hope you've s=
een
> > it.
> >=20
> > thanks, Samo
>=20
> For those of you on the original CC: list taken from v2 review
> thread, who may be more qualified to review this topic than I am,
> the v3 is found at:
>=20
> =C2=A0
> https://lore.kernel.org/git/pull.2107.v3.git.git.1769876930544.gitgitgadg=
et@gmail.com/
>=20

Could you please check this correction.

Thanks, Samo


--=-DWUsOf4KfjNXXopgUFMz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0ILCB4OlalynYc8G8CRZRlo64wgFAmmr0CQACgkQ8CRZRlo6
4wi8lhAAgBQ7ARxbpOi7nAC5EGANDgc6UAioRUTTiKulgQXdYJJr5Gcq9b425jz1
Z18bIxgNsk8pq/G2AEM+krgep/DfFMQJ8bsKPQgYkOFOxSTnZPFfzN1ciEzLjJMu
YbRmHFeSdG50ULSVA/NeZZGgLsi2s0VRPyRMoXYvZ15Q4tlY1AdBLHCsE0r2LVDp
BChttujKcotVhxqM6u9sEbHgKo+x2sk+b3M41osxpDhZlCAxlqU4+UDJT4I59Q/C
NxVrCILSpS2Rty0JyBchdWxT4GlTZDJoByriXCDf6rhcupMAgvdk2JBVb2bXJori
o5RZp6QkKJzRwrEaQxXemmB4xxwmua1WMuEZ38+59Gz6GXP38/+BQ44SGDjs9VUM
E8vUVi/ykklmbeYFdYPnGNGyk/BqUs+InvOD+xATiz3ovbkf1nlBiQhqk3c6uKbO
ubuN09Y37+W0JeMcri+uLDVgrTPdpdVQpsswuPRSIguolNYift/8Roc7O3varsiY
3vsetjezVVqPNjr8v8SeEoJPh27B11GaC309ojEYIbraqOFUbDAd1Q5Bj3p+wNNw
X+U5bGuy5KSJT5Ae4/djrKYBsap9ItO7PJjhlEtbw35utl2pqglUEdWTGNST9qOY
nzE7qxUs2FIpH15edmIJo6jRu+N5qna0Ny4ml2oSRPlOaZsJoy4=
=8t+a
-----END PGP SIGNATURE-----

--=-DWUsOf4KfjNXXopgUFMz--
