Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE11D7E5C
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770576630; cv=none; b=Reh6z8fbH43ZRElzh3Va1B3ks84ARp+TkfcVdwODIoSoDms/z7BqShT1tBZVQi4jgUExbCOGPytshkZyfUVvXF0S7165uW8XPb9NMdIj/2aYfEYhEC4/jo+LiRoHmy8odvJwELQ36gbgZOuVYbCM5AvsGNQvukhDqLyHdiO0qKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770576630; c=relaxed/simple;
	bh=F8mpIKivSJNbDTE2ERKkZHyC+zr2ZYvoSfxdc7Iv8SA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZbhnk73fRl6qcMmu48FpuKl2esCX3gW9BnMhpu8omZ/URdR/NprRo6eOVqdoWKP0D4+6bT3HcI1YmcRdpnuW1O7eVC/eeVazmAOgJuggSpgjhBeJS2DEYRPGjglH9a+lI1OHlYEKpCGHS1J/ffXmxI6fnuAOn+w83pitePUTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnFYsqiD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnFYsqiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AF2C4CEF7
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770576629;
	bh=F8mpIKivSJNbDTE2ERKkZHyC+zr2ZYvoSfxdc7Iv8SA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=XnFYsqiDv46ojDHu7nquXsUUblboAJ/0+sZdghONUHBPeNO4k4PWFYJMixFv14DLj
	 wwRuMN7hlz/9c9NI++p1MjV3qGRXtxo72o5DXLxxCvBwDdyYeUgZXpteQ3T36wjsjG
	 N2IM0J5IytW7xt8DjLEMsi5K6AzBPLg6iZ9C990bhNfAGWnHCLZWWUX+rsBnbK5Wm/
	 RsN32NWCDRQRcGknKxHB4H/fG0ZXok2YmDudIRtRJthDdmMsPalmzMCUZ1RFx2xjc4
	 s3YYG4H80TIl7CrSdHwmlcCKMHh//QAdeijuMShgVk0RH7d43XaLe/79NH+clkxOHk
	 ZA8JSQ5OUBsng==
Date: Sun, 8 Feb 2026 19:50:27 +0100
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: Re: color.diff.<slot> for commit headers (Author, Date, ...)
Message-ID: <aYjauDayL_WIBXV2@devuan>
References: <aYjVlRqvafWeePvi@devuan>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lsmqh6ymojrveyxb"
Content-Disposition: inline
In-Reply-To: <aYjVlRqvafWeePvi@devuan>


--lsmqh6ymojrveyxb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: Re: color.diff.<slot> for commit headers (Author, Date, ...)
Message-ID: <aYjauDayL_WIBXV2@devuan>
References: <aYjVlRqvafWeePvi@devuan>
MIME-Version: 1.0
In-Reply-To: <aYjVlRqvafWeePvi@devuan>

On 2026-02-08T19:32:40+0100, Alejandro Colomar wrote:
> Hi!
>=20
> According to git-config(1):
>=20
>      color.diff.<slot>
>          Use customized color for diff colorization.  <slot> specifies
>          which part of the patch to use the specified color, and is one
>          of context (context text - plain is a historical synonym),
>          meta (metainformation), frag (hunk header), func (function in
>          hunk header), old (removed lines), new (added lines), commit
>          (commit headers), whitespace (highlighting whitespace errors),
>          oldMoved (deleted lines), newMoved (added lines),
>          oldMovedDimmed, oldMovedAlternative,
>          oldMovedAlternativeDimmed, newMovedDimmed, newMovedAlternative
>          newMovedAlternativeDimmed (See the <mode> setting of
>          --color-moved in git=E2=80=90diff(1) for details), contextDimmed,
>          oldDimmed, newDimmed, contextBold, oldBold, and newBold (see
>          git=E2=80=90range=E2=80=90diff(1) for details).
>=20
> color.diff.commit (commit headers) would seem to be the slot for
> coloring Author, Date, etc.  However, that colors the commit hash
> exclusively.
>=20
> The documentation should be updated to reflect reality.  Maybe
>=20
> 	s/headers/hash/
>=20
> Also, I'm interested in coloring the actual header fields; that is
> Author, Date, etc.  I think a good name for that slot could be
> 'header'.  Would you mind adding that?

Another thing I'd like to be able to color independently is the subject
(the first line of the commit message).  'subject' would be a good name
for that slot.


Cheers,
Alex

>=20
>=20
> Have a lovely day!
> Alex
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--lsmqh6ymojrveyxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmI2uwACgkQ64mZXMKQ
wqnygw/+J4mqJKDcMm++Sje1p2rqoEzHL1sQnpMbWL7jg0f9iPZLsHZ5mDmLZObD
v2iDLTgvaMajvaW6p59gLthFe+hmRCksI7A2fJV2X4sOX+78UltnW+V0VhTlBYx5
EGnXuPjk4EWH6cum8SREt4paypcU9pVr10/PblFVIBK9uCX9pekz++xb7plPE/+5
g1yhaooTt2U1RfXo2WFxxaKSng6Bt2MR3yrx9Ov1VSOim0KvQQ8JK/hL5fWfCvcl
RnFbxBkr1qzFkYXhrc82sw24N6+5ZVc3bOnQaTX+bAYSvYZncSCTQtc3uVjUI9Ch
Mvwry9lMLypdzLy6sI9TCJqWmfsdMCM8/LVyFkJKmYAes7eX7ZMwHtJMqoMXOIO2
WS0G1SRf3sJF5QKILLsCkpijcyOI86WK+IESQBiTO58FkMuro/nALrQ4DEhTlV02
UWWO47TZ3kDoga0x3rOKwazhuNbnvIrP6HSuNxvskSA0tUocZHaVatrrFwu1bcpr
i63dBZisa8ZCNPPLKEyAVKJowp8UpHUXqGO7tDkpseYzzrBxJwFXU3f2MuuWdS9B
j5vkE+mONb/g9yLFzZanQs6g/LCbP8yVk93RSapjZSsRtDnQrNm2UEWagNakD9Ey
97gO2JEmm5M0s4yJCIc1EE0qxfw9X5mD6adwth35yAXstX49lr0=
=y6uW
-----END PGP SIGNATURE-----

--lsmqh6ymojrveyxb--
