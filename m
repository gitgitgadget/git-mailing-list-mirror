Received: from cyborg.thican.net (cyborg.thican.net [94.23.45.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11C34DCD2
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.23.45.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775338019; cv=none; b=d4192LgH01eRwuWmtmBLBoCz9Y+GuKKB6Ziv6rD+vfQCgs53hWlqDFJKY9yh7/w8Iuy0DAQ7ZB0djoPDg6T/L+JuwMraZdoRPvS+IMPEFIHt8FO5od2sJUvGVquRRj7gE2+jpEElQ5wPRqdJw4j95QC6NO/o1WPw2hsnirZZQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775338019; c=relaxed/simple;
	bh=39/YsLRbC19hPrS8Z1x80iIvQjIlTVIC45WOiC7cRGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzKv9NkBV4chw3GL74Zud/rsMJWRo1qFRQKNF6aBmpCFmQnOxDNyXuEs4HBAnFg7c/JNCBCVAzBA9uvzLB88OHUalNRfLnFgmO09vHN8LdozUTsIPUX8VdBED0/YTTllZLreuq1OJh+sVDUv0zGCwwsqPBrSvtb9Z9Ew2UdEf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thican.net; spf=pass smtp.mailfrom=thican.net; dkim=pass (2048-bit key) header.d=thican.net header.i=@thican.net header.b=XAyQhm1v; arc=none smtp.client-ip=94.23.45.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thican.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thican.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thican.net header.i=@thican.net header.b="XAyQhm1v"
Received: by cyborg.thican.net (Postfix, from userid 1000)
	id F034E818076; Sat, 04 Apr 2026 23:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thican.net; s=cyborg;
	t=1775338016; bh=39/YsLRbC19hPrS8Z1x80iIvQjIlTVIC45WOiC7cRGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XAyQhm1vcI6BYJ6g0WKi3Y/6K7NEYJvnMtEnn/ntCDcPz3F4vh25rMAR1xgAVOaOR
	 dZlaYBzYY8jKlGsqgPAZ5isneiRumC6DQ0zqJZQVeS001IcpkY3G+UUjvic034jdOf
	 x4K8E51/TWI6mvYs6KizFfVoqyAsAqXz8DULEToekkMvpTf6ied+p5bMj+JEsouvyE
	 bRvooapteSf/Y+pIT71QPYHjQ6ND45NXo1yi7LhA09NeVo4jCNZcDidE6aDgzVqzuJ
	 xTxWvbnj5MTNaYCq+L3hSSEJcQYHrJMfx8YxwdxlueY9dmN4wkMI3J1BcJrYsnAX9f
	 I36hML7XID3Ig==
Date: Sat, 4 Apr 2026 23:26:56 +0200
From: Thibaud CANALE <thican@thican.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] switch: provide configurable detach
Message-ID: <ebp7ebhushwhai3fms7xaseqqdwui7x43i4knwv5tkfkqyksqv@xtzmqnfgjqxc>
References: <njuf62lav6akkmdyqutwk7pim5yutw5cuicjidwpe5eh6qnkqr@4ir6q4uhhvht>
 <CALnO6CA2_MjKENu3CK-zCfoG=edEuMm6rohBtJ_8JC9WgMudEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kgz6lyi5dtfpovrc"
Content-Disposition: inline
In-Reply-To: <CALnO6CA2_MjKENu3CK-zCfoG=edEuMm6rohBtJ_8JC9WgMudEw@mail.gmail.com>


--kgz6lyi5dtfpovrc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] switch: provide configurable detach
MIME-Version: 1.0

On Saturday 2026-04-04 12:58:48-0400, D. Ben Knoble <ben.knoble@gmail.com> =
wrote:

Hello,

> On Sat, Apr 4, 2026 at 10:36=E2=80=AFAM Thibaud CANALE <thican@thican.net=
> wrote:
> >
> > Its purpose is to provide for git-switch(1) same detach behavior on
> > commit it than git-checkout(1) through configuration option
> > `checkout.switchDetach`.
>=20
> I considered contributing something similar at one point, though I
> would call it "switch.detach" ("<command>.<option>").
>=20
> I think I eventually decided against sending a patch because I was
> concerned that such an option might make using git-switch in scripts
> more of a headache. If I'm using it intentionally because it will fail
> in some circumstances without --detach, now I've got to also do "-c
> switch.detach=3Dfalse" or something to control for the new
> configuration.

I see what you mean, I could argue it=E2=80=99s a very niche option, only
concerning git-switch(1), and in case we rely on git to block further
actions if the provided reference is not a branch or simply working on
detached states, it should not have any impact.
This is what the newly implemented test cases are designed to ensure.

As mentioned it only implements the same behavior than git-checkout(1)=E2=
=80=99s
concerning non-branch references.

Full disclosure, I am not even concerned about this feature, as I use
switch/restore daily since 2017, but not everyone I know does; so here I
try to ease transition for them.

> On the one hand, I think that argument applies mostly to plumbing
> rather than porcelain commands. On the other, a command for switching
> branches whose behavior is reliable enough for scripts seems
> worthwhile. So, idk :)
>=20
> --=20
> D. Ben Knoble

Also the purpose of this request is to provide this feature for Windows
environment, which is out of my abilities concerning compilation, cannot
compile without such environment.

Best regards,


--=20
Thibaud CANALE
thican [at] thican [dot] net
https://thican.net/
GPG: rsa4096 2013-10-14 485EF628CB85CDD4CB7CFF0D52F5127650733A18

--kgz6lyi5dtfpovrc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEESF72KMuFzdTLfP8NUvUSdlBzOhgFAmnRghsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEFL1EnZQczoYAawP/iLsu+KbKoX6DvBSyv3F
5gg05OEvJNNJo8kn2AknpfijYKlbWOxu9u2hwoLfUqgJGld0ZkDWud2u5B+VAupg
NNq6QZ3iS3dVQVGng8vTqHH0PLk3CzLEbhqt1kBQ9f+zfab1PQIdahygPsO2Lt6X
wB0qwaDuVCuzqQADqj9stDEQ8mS3FGoNjANWZFXQ2MamLp3o9/50L9mD83Dmczms
ah5fRF3fpFRkFiYLrlpIeGjoKd/qTYuCBTGtjR4hc6F4Hc6N+IRhqZ9lBHWfaTd2
cRKhdLCAcvuUexU+Z7rZsjL4e9O51Ix8CoAMpl+O+WLc5gop5qEDvpeZPXnvKAg1
y/3yG3UdYSm6XxpA7sR0ylLZU8pG5g0/dxGF+2EYiCZpMsuSwVNDvR16AReWv8d+
4p9ngQyoyNld6KhLG+QsOFeCp3VMfVOGEGsiaPlm8CVoQQYN3Zo/2V/dNmoaRjas
IahFXpHE//dASzz8dnGof0mHfOehUpwcAzNTfyk2EHwKaLea5eENoiOdys6c3TIH
vcNBuItSxkL56930KuiL2e/7UrqlFB83/NnPLElwdzefQM8Bym6sIcfSMnElW9Eb
Mp6ahdOZCrpC7N5e1UQyRH4Z6YcgCNK2GQSnx4jdsDUgyIWCOHwqx809MzIxV1ta
N5MpDWCssaxfTMwf6nUy8jaf
=Oyvv
-----END PGP SIGNATURE-----

--kgz6lyi5dtfpovrc--
