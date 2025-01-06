Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BC1DA2E0
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202776; cv=none; b=sGcTxSwPmqYsORXXDCK4spjoRhqtfk8/Z7Y6TOk1ycqQOsICNvH6GxlPXnPjzK7f6qYcqw2GDbZ1UNkqegGLQ0boKbc2pyRKa+wWuS06w/1BriTPfMkIJ1kv4Gr6aXHcd0wMER1uOgFlfEcLnv5p0882ngiZomDVwNFznDrJ7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202776; c=relaxed/simple;
	bh=+5MGJZ1MnH9tZTz++TDLlSG42YI/MCUgnCacNiNF4a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiqiTutpU6bNVATzMvEeza7N1Hie4POkAUcwpvksnljjJOZolegBqsFVA/yUZi0G0eKDJOLYx48YlwR6c16cSSTYUwEB+Rp+UCoLhCSZBDhDDGF3tDKqb2lEf92F2nieSLocRgLVy8R097lRoebzejr7AS3sgQMifpYazmUGPbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=G3jfrntO; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="G3jfrntO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736202772;
	bh=+5MGJZ1MnH9tZTz++TDLlSG42YI/MCUgnCacNiNF4a4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=G3jfrntOAqSOv5q/NRyPHVhr1GkzYSVRiRtQ49UxNyV1vXbKGRR+MP2/M0DreEErv
	 h8OTMYMGxnk8smzheutYjNJVTpH8Gn+nOS2MPHRQAT9W516tbATTU3jPOBfUxKhqqi
	 2MnDCeNumn8FVTHP3z01epefjL1uRwCY574w/gBC7zl2D9B+aIPOYQfwsaampN0hoP
	 f1DSG9SQYxzQkv1XKdwfWn5iTN15Go/vTut8YncHWJPA96WdufPAJckeVRxTd2khSJ
	 bjZ8OHDCLM6MXtiz7nnUtd3bGirVc/UVk0rrgjBh/BENcTW6ndCE7A5Z1B/q+TfR4l
	 slZ6A0yNnbs8JEnvxHAb7esqnqjdmLr8KMeGB2ZYQGHRaINzbYS7YGxk1kyOtLeIoE
	 tVt55ZMu+J4+qgFr2X9JNhkPdWw+BbZtuBiqVYDX+4V8vRsc13SFcuZZTaMK5ilqyt
	 RAHLPV0CpnGymJlOyZfp8xzvmnYdZxT4xXF3fxsP0VcBWlYlcRb
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4633F20991;
	Mon,  6 Jan 2025 22:32:52 +0000 (UTC)
Date: Mon, 6 Jan 2025 22:32:51 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2] credential-cache: respect request capabilities
Message-ID: <Z3xaE_v45G447HQe@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
References: <pull.1842.git.1734729534213.gitgitgadget@gmail.com>
 <pull.1842.v2.git.1736193131798.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lL+OdaE96X8zzn82"
Content-Disposition: inline
In-Reply-To: <pull.1842.v2.git.1736193131798.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--lL+OdaE96X8zzn82
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-06 at 19:52:11, M Hickford via GitGitGadget wrote:
> From: M Hickford <mirth.hickford@gmail.com>
>=20
> Previously, credential-cache responded with capability[]=3Dauthtype
> regardless of request.

That's the correct behaviour.

> The capabilities in a credential helper response should be a subset of
> the capabilities in the request.

No, it should not.  Otherwise, it's impossible for Git to know whether
the helper does or does not support the capability.  We rely on that
information to correctly pass data back when saving data.

> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cach=
e--daemon.c
> index bc22f5c6d24..692216cf83c 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -134,17 +134,16 @@ static void serve_one_client(FILE *in, FILE *out)
>  	else if (!strcmp(action.buf, "get")) {
>  		struct credential_cache_entry *e =3D lookup_credential(&c);
>  		if (e) {
> -			e->item.capa_authtype.request_initial =3D 1;
> -			e->item.capa_authtype.request_helper =3D 1;
> -
> -			fprintf(out, "capability[]=3Dauthtype\n");
> +			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONS=
E)) {
> +				fprintf(out, "capability[]=3Dauthtype\n");
> +			}

This part is not correct.

>  			if (e->item.username)
>  				fprintf(out, "username=3D%s\n", e->item.username);
>  			if (e->item.password)
>  				fprintf(out, "password=3D%s\n", e->item.password);
> -			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER)=
 && e->item.authtype)
> +			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONS=
E) && e->item.authtype)
>  				fprintf(out, "authtype=3D%s\n", e->item.authtype);
> -			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_HELPER)=
 && e->item.credential)
> +			if (credential_has_capability(&c.capa_authtype, CREDENTIAL_OP_RESPONS=
E) && e->item.credential)

This part may very well be correct.

>  				fprintf(out, "credential=3D%s\n", e->item.credential);
>  			if (e->item.password_expiry_utc !=3D TIME_MAX)
>  				fprintf(out, "password_expiry_utc=3D%"PRItime"\n",
> diff --git a/t/lib-credential.sh b/t/lib-credential.sh
> index 58b9c740605..324ecc792d5 100644
> --- a/t/lib-credential.sh
> +++ b/t/lib-credential.sh
> @@ -566,6 +566,21 @@ helper_test_authtype() {
>  		EOF
>  	'
> =20
> +	test_expect_success "helper ($HELPER) get authtype only if request has =
authtype capability" '
> +		check fill $HELPER <<-\EOF
> +		protocol=3Dhttps
> +		host=3Dgit.example.com
> +		--
> +		protocol=3Dhttps
> +		host=3Dgit.example.com
> +		username=3Daskpass-username
> +		password=3Daskpass-password
> +		--
> +		askpass: Username for '\''https://git.example.com'\'':
> +		askpass: Password for '\''https://askpass-username@git.example.com'\'':
> +		EOF
> +	'
> +
>  	test_expect_success "helper ($HELPER) stores authtype and credential wi=
th username" '
>  		check approve $HELPER <<-\EOF
>  		capability[]=3Dauthtype
>=20
> base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
> --=20
> gitgitgadget

--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--lL+OdaE96X8zzn82
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.45 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ3xaEwAKCRB8DEliiIei
gdZHAP9AloIQNL9q0PAG005jEE5yTMA+DxMQDtrD7H3rzdO1lwEA9gLAlvqgNeoi
RG8jS/PpSMHzmsRpWm4lIynW9OlNcQk=
=1zdD
-----END PGP SIGNATURE-----

--lL+OdaE96X8zzn82--
