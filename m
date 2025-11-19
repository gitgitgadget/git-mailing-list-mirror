Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B61A31ED7A
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593464; cv=none; b=OP6a15i3G6szP28Xq8dt9W7ix12vWsjpXjZq8dvvOZlvszV3g1io14SO7r8MzNYuyQTiDvWRUj1zzWNWOPn9Iom4RaC219Rah/cpDiGVoWKUFT5OrYuLBKEO81CZfhbn4Sm7OCYOPsVcwDJh9M52+WyeSSAf5BsPB/ypcAcoMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593464; c=relaxed/simple;
	bh=Nup93W7UhcWf8KiH5VaDfP7o3fNzQIlXwFdBpFq5HS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAtyleBX5uWG5pAb33yRmOwLlHcXvMOceEWk4UwykWmwgsHhV9ftBoWuCtm/4DPZ6YfohAwfLTqPdrzDXIrnicb0cYBRQgO4dp25IOeyc8zDasy1+BopjhnxJpgvAKq9dCPUwndHdRlKRvHzTmpItdjJmo34HR6FdIp8CHjta0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=rTxUH44l; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rTxUH44l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763593453;
	bh=Nup93W7UhcWf8KiH5VaDfP7o3fNzQIlXwFdBpFq5HS4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=rTxUH44lz+9QO4UH8x26khgvihK/9vpw68j+R1gkN++nwMMEnohiU0bxLC8zc4I+5
	 DeihB1jfQa41da3wiRi+KozF2v63MtPT63d6dTXWbRpS0vqoj49sxy2mXaZU0cuobI
	 WdRakU84pkFd6GP6lEb6H7Ate+qsHrz/8TLZ0516E0SRM9SQWWoiDpBcPsJqmFua8e
	 DHzWCe7wqdqYAjeg+Ygp3l9a4mpKsA7WovrmRqbs4QcY0EEKRx61zrwcqQNKpeaGoH
	 h2OkNVr8jr49NdWjIERqdwGMDb1p0RIDOUXbuNDNg4HktkeQZPz+/UKJfkQplOPasm
	 Kjct1ooWSHNUh0i2AKDj5VGsyR+CXcfXbBLQzaakhVOGyJ21/Oxr8yZNcBBjYcH9BG
	 EBSeHZYPccrvZDH2Kkene5nYrA0VPoXFxRtSBNYFpokwGBkQkR0o1+Z92w+k/cdEmf
	 Rl/tSu3CYwb/9hqkrpzW8mASLwqMhYnL0yMeoYcZ2E/W+X1iQaw
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ecdf:ab92:a9ef:e071])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id ECC3C20065;
	Wed, 19 Nov 2025 23:04:13 +0000 (UTC)
Date: Wed, 19 Nov 2025 23:04:11 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
Message-ID: <aR5M65HDuGlTsR77@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <xmqq7bvsjzlx.fsf@gitster.g>
 <xmqqpl9h9mgo.fsf@gitster.g>
 <aRudLpkRdRtCAoi3@fruit.crustytoothpaste.net>
 <xmqq4iqsgpu3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Y5qo1p6jlq7k7FZ"
Content-Disposition: inline
In-Reply-To: <xmqq4iqsgpu3.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--4Y5qo1p6jlq7k7FZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-18 at 00:13:40, Junio C Hamano wrote:
> Thanks.
>=20
>     $ git log --oneline --first-parent -4 seen
>     3f252ac9fe Merge branch 'ar/run-command-hook' into seen
>     672cb7c62e ### CI
>     3af201233b Merge branch 'bc/sha1-256-interop-02' into seen
>     950efaac03 Merge branch 'cc/fast-import-strip-if-invalid' into seen
>=20
> It seems that 672cb7c62e (which is an empty commit on top of the
> merge of v2 of this series) fails win+Meson
>=20
>   https://github.com/git/git/actions/runs/19447841443/job/55646336507#ste=
p:6:689
>=20
> but 950efaac03 (which is the merge before v2 of this series is
> merged to 'seen') is happy with it.
>=20
>   https://github.com/git/git/actions/runs/19448271167/job/55647611566
>=20
> These two runs roughly corresponds to the with=3Dbad/without=3Dgood pair
> in the message you are reponding to, but with the v1 of this series.

Yes, I think we'll need someone familiar with Windows to take a look at
that.  The message doesn't indicate anything obvious and I don't have
any Windows systems available to investigate.

My guess is that it's something to do with the build.rs file, but I'm
not certain.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--4Y5qo1p6jlq7k7FZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaR5M6gAKCRB8DEliiIei
gRBpAPwJuG4smqO9XodIsd23I5UAK0Qa6disG5TWVrbU2gA/aAEA0uKkleRoGke7
ZTj8zYEAVBml5pK5u60ds/8B2oXZowY=
=pOlR
-----END PGP SIGNATURE-----

--4Y5qo1p6jlq7k7FZ--
