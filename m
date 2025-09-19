Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CAB78C9C
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309323; cv=none; b=gZ51fVEyBHf3zXumYZvjQFWSUhrgxS9uPRBzO3O14/8NGFtzQv/hrwDKOViMZ7RlGnVpUEWWJQacjfYoE1Xa13NV6dkCoL7DSMv8QlefRY630Y7b55j3glK6P8jOATEgY35MzFBXAiWk3gDpbdU29T7eZ2ufZtIPGBeCFpxNscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309323; c=relaxed/simple;
	bh=OPKuLME9c+gdu/Uqy/ZgJySO9jQSVFgpuqEpVX8/HOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuF/R086l/KjeYNOQIQH2bygq0/l+XKYhkhjcfMCfXZM1eHoXqa86YTvk9FGyFto+6qXILl/gB8xOjXO7FALdX+1a87ygwk0v+CXmJq8gUHhNVhF/91KYCfyJpMuxPdfcCH0WChvh8sXnbLyKVfFhZHDrpVrSD5Pt9cMw/MuwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=m/N1WYWy; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="m/N1WYWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758309312;
	bh=OPKuLME9c+gdu/Uqy/ZgJySO9jQSVFgpuqEpVX8/HOQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=m/N1WYWyFo07gtRm6TbRiqEOeVy6kWH27o56NqxE0D0rCLNESSkx8Itu/8jVgAFTR
	 o6d/9/jU41YVIf8tewN1RxOcExLAFprXVb5Z9sRWMNSV/dkotrOBsfMO9eykRX7tyr
	 yO9iaDktRWLJx3EAVButLbGJsL0K2U13sBkJc0k6mHGlGO8aHyMVs0NnnWwN/kVfx2
	 ih6WsJbRUw8psI1WNLPyfMHBitV2sUKoebv58dPq/jisjlh6mdXPSirRdwoyzT1MVw
	 tlGz57DoM/Rd7FqFn6Oe65TsextUHIcMKKVENntdKAAhY25iHR1CEqnBzofydADlVz
	 l678aivPNZHiWhOK92eZO61NCA1asbeX8uBm6YfxljP8SsfYS43ZidDw7lZwKxRIkA
	 H0OqeFVzoe1Fh19GJRXj5MdKoCKRNqk4mWfhX+FlnDryUmn8EwW/j47P9py2M4t5w1
	 2n2cQ94BYOfJcUVexOhSWUgoxBlVdNh8c/PQWH8jIT+ZIAuLma+
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:69d9:2a04:7f4c:de5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 65B0020105;
	Fri, 19 Sep 2025 19:15:12 +0000 (UTC)
Date: Fri, 19 Sep 2025 19:15:11 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/9] docs: add documentation for loose objects
Message-ID: <aM2rv33nL8swECpn@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-6-sandals@crustytoothpaste.net>
 <xmqqv7le45t3.fsf@gitster.g>
 <xmqqms6q45nl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ikvEPN5/NR4ZP38H"
Content-Disposition: inline
In-Reply-To: <xmqqms6q45nl.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ikvEPN5/NR4ZP38H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-19 at 19:13:34, Junio C Hamano wrote:
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index 4404c623f0..93fa3dee8b 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -171,6 +171,7 @@ manpages =3D {
>    'gitformat-chunk.adoc' : 5,
>    'gitformat-commit-graph.adoc' : 5,
>    'gitformat-index.adoc' : 5,
> +  'gitformat-loose.adoc' : 5,
>    'gitformat-pack.adoc' : 5,
>    'gitformat-signature.adoc' : 5,
>    'githooks.adoc' : 5,

I'll figure it out for v2.  Thanks for the tip; I'll send out v2 once
others have provided any other comments.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ikvEPN5/NR4ZP38H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaM2rvgAKCRB8DEliiIei
gZQjAP4s3Oi/qFF2iIVCvnE7pYXuXMHqf61/6elq/oi4HoPr6QEA/avm4YbMMs9Z
UW/uC9y/uzMTqq0NMjEHHSlZW5q0ywI=
=ISca
-----END PGP SIGNATURE-----

--ikvEPN5/NR4ZP38H--
