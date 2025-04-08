Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7AB21ADC3
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744149128; cv=none; b=rDPtsOOaNxrXmYsO60u3DhcHtrEZOIHEFXyAqwwEfciovpyXKGHJoXDXuYq1zjrmX+j6PdAAImCtm5ppvtvgtK6IWs5weN2gIJFpEKFta0qn0nZ+Qhjlrwd2ypWTC5tTasBXy+7zO9hJ1QZkPRzNy87ur7L5x85WjfU4AlhqG4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744149128; c=relaxed/simple;
	bh=FyhBr3v0XvZkQJ4YcBVnUAxZVm/3r4p/UOLUElCgjwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKek7y2Nf4JxHdqDO/kKQZagh+9NzrIWZ2KjEO6kmz5+71cV9hdbglLVM+yH3kyBFtW4gWf5JnigqJxiEQvdGT4CX5b25tfKqXmUdUNvtBLgoaKIYEsx8Z9GhdyJOaAafRWP97OVZlFbcmADk+IqK6x6+7AUvm8TGQ0iO4hX9Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=w1sfDOk0; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="w1sfDOk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1744149123;
	bh=FyhBr3v0XvZkQJ4YcBVnUAxZVm/3r4p/UOLUElCgjwg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=w1sfDOk0H1mNryRnZcgs0r0fHQD3W9oTq1GR/nyB/fF6Rb1PLjyqgjbGFK4A56Sxc
	 XO418LVAz6ckUZUOPLqKZO0AP9BKbImBUvwUseSJliCD/cccRse0vv/cr6RkyPp/jI
	 +iCXarTorg07p1CPF3jJ/Tsfe1LjGVtk9E6jGOYWysZARPMrsFMhIeUmr6PgX48u4a
	 nyEjc714FbNOMs34MAlgf/wcw9zBl1j8SW89peYCThz9+M/6104UGuqdVfyWyW3hPa
	 hylj+XyYeeCfjMGU6q2j8L71/FfOUc8VFgFHCW52TZ46Xp+4vLJpPEbzRvrUJurNx+
	 WuRHganpqC8NabyW+9VsOZdgsXINHU7LfRb7iAHYRt6aGZZvwXldhkVbUn8fLocqH6
	 wKUuPiiRb7s9C9p4xyJuiP4Vbe00Sh9l4x5Q7JE4Wv7e6lBlMg+11OgtHWeZJAQd6V
	 0Yd64aZRx7F9SMHhlC1TjY4Y75Z92X6bqfaUGFDVoQW0+a08RuJ
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 460BA200C9;
	Tue,  8 Apr 2025 21:52:03 +0000 (UTC)
Date: Tue, 8 Apr 2025 21:52:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] GitHub deprecates Ubuntu 20.04 Actions runner image
Message-ID: <Z_WagT6zeeQGNa0k@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqqo6x6wgs8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sWp9Ir6iM+/WB+ak"
Content-Disposition: inline
In-Reply-To: <xmqqo6x6wgs8.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--sWp9Ir6iM+/WB+ak
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-08 at 20:16:07, Junio C Hamano wrote:
> It seems that we are hitting https://github.com/actions/runner-images/iss=
ues/11101
> which deliberately breaks CI jobs running on Ubuntu 20.04 images, in prep=
aration
> for its removal targetted for Apr 15th, 2025.
>=20
> The following is a random/blind attempt, but I need a lot of help ;-).
>=20
> [jc: brian and Taylor CC'ed for their ac112fd4 (Add additional CI
> jobs to avoid accidental breakage, 2024-10-31)]
>=20
>  (1) I do not know if the deprecation schedule at GitHub is the same
>      for native runner images and dockerized ones.  Do we want to
>      leave the linux-TEST-vars that uses image ubuntu:20.04 alone
>      for now?

Yeah, that's a Docker image and we can leave it.  As long as Docker Hub
continues to host that image, there's no problem with us using it.  I
would argue that it's a good idea to use a supported OS, but it's not
urgent to fix.

>  (2) If we were to update it to ubuntu:22.04, would gcc-8 still be
>      the right "ancient-ish" version of the compiler, or should we
>      update it as well?

We should update that as well, since I doubt GCC 8 is still available.
I'd normally look at https://packages.ubuntu.com/gcc to see what version
is the default but it's down right now.

>  (3) Linux32 job running on image i386/ubuntu:focal has comments
>      that says it is supported until 2025-04-02; should we simply
>      drop that job, as 32-bit platforms are less and less relevant
>      these days?  It is not so urgent but debian-11 job also should
>      be replaced with something slightly newer next summer.

We could update it to a newer version of Ubuntu, such as
i386/ubuntu:jammy.  That would probably work fine, although I know
Ubuntu was making i386 a more limited distro with fewer packages.
Perhaps Debian might be a better choice, then.

>  (4) I have no idea how the "sparse" job, which seems to download
>      pre-built sparse using magic incantation
>=20
>       - name: Download a current `sparse` package
>         uses: git-for-windows/get-azure-pipelines-artifact@v0
>         with:
>           repository: git/git
>           definitionId: 10
>           artifact: sparse-20.04
>       - name: Install the current `sparse` package
>         run: sudo dpkg -i sparse-20.04/sparse_*.deb
>=20
>      is supposed to be updated.  Should that be coordinated with the
>      git-for-windows project, where its .github/workflows/test.yml
>      has a similar insn to build sparse-20.04?
>=20
>      It appears that Dscho (CC'ed) is futzing with the generation of
>      sparse package on Ubuntu 20.04 and 22.04 and getting affected
>      by the same 20.04 brownout
>=20
>      https://dev.azure.com/git/git/_build/results?buildId=3D2396&view=3Dr=
esults
>=20
>      so probably I do not have to worry about it and let Dscho take
>      care of the whole thing?

I think Dscho may find a good solution for this, so we can let him start
to look at it.

I apologize that I don't have a lot of time today to look into this,
since I have something to do this evening, but if we don't get it sorted
out in the next couple of days, I can try to send a patch to fix things.

> diff --git c/.github/workflows/main.yml w/.github/workflows/main.yml
> index 9959b61ece..1d4422c898 100644
> --- c/.github/workflows/main.yml
> +++ w/.github/workflows/main.yml
> @@ -372,7 +372,7 @@ jobs:
>            image: ubuntu:rolling
>            cc: clang
>          - jobname: linux-TEST-vars
> -          image: ubuntu:20.04
> +          image: ubuntu:22.04

This doesn't strictly have to change, but because Ubuntu 20.04 is going
EOL, we probably should change it.  Nothing will break if we don't,
though.

>            cc: gcc
>            cc_package: gcc-8
>          - jobname: linux-breaking-changes
> @@ -446,7 +446,7 @@ jobs:
>      if: needs.ci-config.outputs.enabled =3D=3D 'yes'
>      env:
>        jobname: sparse
> -    runs-on: ubuntu-20.04
> +    runs-on: ubuntu-22.04

This definitely needs to change.  Anything that does "runs-on" is a
runner type and Ubuntu 20.04 is going away for runners.

>      concurrency:
>        group: sparse-${{ github.ref }}
>        cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =
=3D=3D 'yes' }}
> @@ -457,9 +457,9 @@ jobs:
>        with:
>          repository: git/git
>          definitionId: 10
> -        artifact: sparse-20.04
> +        artifact: sparse-22.04
>      - name: Install the current `sparse` package
> -      run: sudo dpkg -i sparse-20.04/sparse_*.deb
> +      run: sudo dpkg -i sparse-22.04/sparse_*.deb

I don't know how these are generated, but this seems like a good start
to try and we can adjust it later on if there's more moving parts to
fix.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--sWp9Ir6iM+/WB+ak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ/WagQAKCRB8DEliiIei
gROIAQCreeFVT8BEw6jkhWNiDrMCtGoIJkSrinMuxqlj/7O2EQEAh3e3Xs9ynqSM
QO2/IXlLbs8NdQHUWCaSV03O+C5DpQU=
=8MFG
-----END PGP SIGNATURE-----

--sWp9Ir6iM+/WB+ak--
