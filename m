Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272A171A7
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 05:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714454336; cv=none; b=uopyTrNP+n/U6eoMg5WjcX2Crg5nHcI2cQpcB3QrdvfIQ3BFQmCWlELAssoU5weVhPQ3DOfgfdXG20dkBOGDOXshJkKwsqYptTCgQkZ5TpJYSz/VYDyrjgbZW3hpQD7iMsvgBRxbL/DiwIvg73QLW/DmxzDhCxOIVNT/hbYbxu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714454336; c=relaxed/simple;
	bh=vnrBB4IVmVKIFMclbvuBjb3bERzQ5WO/rsPAM3gz2zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhuhw34F/ck0/YWlSrMij8bnHmGDbjuA6OYunGImGETBstAb+AB4Uhn64nEbvs+/1G8viJFUUZX+UaPHzAuaBJ8UU+cw0eqKEOlZrpDQC5ryEBRjNVOV70q/Qy8ty/50hJU3a1W+tPXSX60ROligBVaLqeNyuxhYjDfMhlwsygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kYY3r4gI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bLTjnfr3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kYY3r4gI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bLTjnfr3"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id C4CE31380F82;
	Tue, 30 Apr 2024 01:18:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 Apr 2024 01:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714454333; x=1714540733; bh=0T1kcGI2mX
	piwplgc3yQxe3Kqk+s4IWFyti3aPttdBA=; b=kYY3r4gIFIjb8SDK7q3ImuRm2a
	PpXdvINuENdgMzU8NTpZ3fNjiVBpeddbv5va2pR+2M1vMw3EkzVyjeLA4UGnj2DC
	O7wVIedGOTFu82E7QRizc9cJRF/bidFJNl3RBJSQPNCoel/HQvMr2rrVlxUndQpP
	eEZ1AsrBbIAs/1zGjvTLXXp5ND0SzNURdzO9V6ixAhuTspDJsTzNGJv83FV6NQ9g
	nddpjb1V7jfRneFhm4qBDLAE7ADXFxUPBvyFe4FMJueSQjPZcHgRvK+AlLRaxd16
	yp+JA9vYuhkzMMFdE2kXIjwRqpxkk4oTvbQZ3ogeyM3DvWoZdM6eLUWC/mDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714454333; x=1714540733; bh=0T1kcGI2mXpiwplgc3yQxe3Kqk+s
	4IWFyti3aPttdBA=; b=bLTjnfr3iElMz2N8QAktu4QmCbVF9FraFzQbR8IzIjYX
	z1DwUa0LGN4CtWo5TfyLnbyN4YdS/4w3WMPm3BBMcq6zeGzmk6A0iDTKcJ3uOHnG
	+ipa/Vvw5nd0RX8Rm0j/5MPKeHgGyVU/Y5ximmlt7EDQViArmU9wHegAKG4MGcTP
	RuiJWqhssSK4soIWZA3IZkcF2gAWbUN+Leb5XKVIknuwXUPVbHTJ2taQaFT9TMZK
	KozLwBenUAxPBRShvlG529c/dTBHHUV8YMZ2vtyF3V661v32bt3K1NpleX65zLO6
	klPh8fceq5YQMcKPtLzwqbxOywAKFKeHnEGhnwpo4g==
X-ME-Sender: <xms:PX8wZqv5rSUKx8O-Z2ttNcnHRreHFzMjJB-Vn6TiscbLbHrYoKDebA>
    <xme:PX8wZvcL_RSoWu0JTIt3gscDzZG-sqGkwVb3IB8IqC_p3N2VDH-xSlrLTIafTdyuD
    LhTyym8L3d0Z4V4gw>
X-ME-Received: <xmr:PX8wZlxaknmc2by0ztFJa6FanbkG2bMnmArxUmbUqjS3iyS4Tsg0zxHS0UXRfAqFC-TCCSRSQtz1crQTJvO_UK_lLASYC2NbaZhc8jI_m_lEMazzVhj7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:PX8wZlONMpptnfWHICoosy-JtL5KJw0NX7BjiRQ2Ad2HkqOSVUq9Mg>
    <xmx:PX8wZq-CRpFrCVjgZ4iHzLbZ-Vw62-nCJQqbIUxkvDUZJ3dUzbd4og>
    <xmx:PX8wZtV6qfD_oKLj3OmUQCFByRKwo9d3pA7M9JwJeUI9_I3MXA3NQw>
    <xmx:PX8wZjc8fiFcbXwRMBleEgCaf1kMUd26eOlVLepX3ZuBESFFoahY4A>
    <xmx:PX8wZsKWV9ZUDMk1PzoKyvjaG-Cx1u2ezrwL9uyvzH1LtUIewMUGhPvw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 01:18:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ddb39b90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 05:18:30 +0000 (UTC)
Date: Tue, 30 Apr 2024 07:18:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] advice: add --no-advice global option
Message-ID: <ZjB_OJUQt7lbkOgz@tanuki>
References: <20240429010925.93205-1-james@jamesliu.io>
 <20240430014724.83813-1-james@jamesliu.io>
 <20240430014724.83813-2-james@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="daM9CXXbAeSyiYBY"
Content-Disposition: inline
In-Reply-To: <20240430014724.83813-2-james@jamesliu.io>


--daM9CXXbAeSyiYBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 11:47:24AM +1000, James Liu wrote:
[snip]
> diff --git a/environment.h b/environment.h
> index 05fd94d7be..26e87843e1 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -57,6 +57,13 @@ const char *getenv_safe(struct strvec *argv, const cha=
r *name);
>  #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
>  #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
> =20
> +/*
> + * Environment variable used to propagate the --no-advice global option =
to the
> + * advice_enabled() helper, even when run in a subprocess.
> + * This is an internal variable that should not be set by the user.
> + */
> +#define GIT_ADVICE "GIT_ADVICE"

Almost all of the other defines in this file have an "_ENVIRONMENT"
suffix. We should probably do the same here to mark it as the name of
the environment variable, which otherwise wouldn't be obvious.

>  /*
>   * Environment variable used in handshaking the wire protocol.
>   * Contains a colon ':' separated list of keys with optional values
> diff --git a/git.c b/git.c
> index 654d615a18..6283d126e5 100644
> --- a/git.c
> +++ b/git.c
> @@ -38,7 +38,7 @@ const char git_usage_string[] =3D
>  	   "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--i=
nfo-path]\n"
>  	   "           [-p | --paginate | -P | --no-pager] [--no-replace-object=
s] [--bare]\n"
>  	   "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=
=3D<name>]\n"
> -	   "           [--config-env=3D<name>=3D<envvar>] <command> [<args>]");
> +	   "           [--config-env=3D<name>=3D<envvar>] [--no-advice] <comman=
d> [<args>]");
> =20
>  const char git_more_info_string[] =3D
>  	N_("'git help -a' and 'git help -g' list available subcommands and some=
\n"
> @@ -337,6 +337,10 @@ static int handle_options(const char ***argv, int *a=
rgc, int *envchanged)
>  			setenv(GIT_ATTR_SOURCE_ENVIRONMENT, cmd, 1);
>  			if (envchanged)
>  				*envchanged =3D 1;
> +		} else if (!strcmp(cmd, "--no-advice")) {
> +			setenv(GIT_ADVICE, "0", 1);
> +			if (envchanged)
> +				*envchanged =3D 1;
>  		} else {
>  			fprintf(stderr, _("unknown option: %s\n"), cmd);
>  			usage(git_usage_string);
> diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
> index 0dcfb760a2..2ce2d4668a 100755
> --- a/t/t0018-advice.sh
> +++ b/t/t0018-advice.sh
> @@ -29,4 +29,24 @@ test_expect_success 'advice should not be printed when=
 config variable is set to
>  	test_must_be_empty actual
>  '
> =20
> +test_expect_success 'advice should not be printed when --no-advice is us=
ed' '
> +	cat << EOF > expect &&

We typically write those `cat >expect <<-EOF`. I assume you cannot use
the dash here because the "README" string is indented by a tab. But the
order of redirects should still be reversed.

> +On branch master
> +
> +No commits yet
> +
> +Untracked files:
> +	README
> +
> +nothing added to commit but untracked files present
> +EOF
> +
> +	git init advice-test &&
> +  test_when_finished "rm -fr advice-test" &&

Let's run `test_when_finished` before creating the repo.

> +  cd advice-test &&
> +  touch README &&
> +  git --no-advice status > ../actual &&
> +  test_cmp ../expect ../actual

Nit: these should be indented by tabs, not spaces.

> +'

We could add two more tests that explicitly set the environment
variable, once to `true` and once to `false`. This would at least
somewhat represent the case of running Git subcommands, even though we
cannot test whether Git actually knows to set the envvar like this.

Patrick

>  test_done
> --=20
> 2.44.0
>=20
>=20

--daM9CXXbAeSyiYBY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYwfzgACgkQVbJhu7ck
PpSSow//Wzd1McLROZfE4P7T2+LY3TrY0P3LPu1DOal70WGBEdp2qaCXVVVFYlWo
rGayw2LLTuqsN7B/imaVRr3qmUTNCuksAXoQGvR4gT6y95b1UEghKPHA1dePmjO5
eYllz3Crsc33B8hV282MYMcWtwK/7+ZXfkysP2ipoOWBuFKMOPpG8cYrb1rHHCdU
G0bR06FdVrzoL8zN68nBkAwXgEhCk0xcurwZLtFZvROEVk75de09k1VlDpxlxKYG
mGVDkYuih2pYqJa2Yccy74BwCk8MYnKsrUo/ndw68L2px9OL7aOQDwidWlBs+jQ1
d/HVGwgm3UMTwzXQ8CowpTpCvg6lDZr9H4FIOUPqY+wq/FhRAtFalLUeFKTexNbv
OmxewPGGL1oc8jd0oI1Xte6VX7GV9gIkmM7mu9I+ILre45CXLwGRs8xj8M+enGI+
JWvocHNbzkVTz+ifltrwLf57GWW6IizUH749Eo8wf8BYTApVSZyYwjCUZsFPhwzS
Ql1tErLqvagnVKMKUR9dbxDhf9CsONln8ez9GBtMAwYcx3p3dEOyypH6PwbyUAOF
t6KBdXcEmEUSB77+qWWzVclCaylW1r0CsGe8kONrdbHSnAcyj6R/ggautV+7TgUs
yNSMtijB6ScKwBn8AHRaTQap8NqYjrQoFxErmL2qgQGFXmTm0Ag=
=OLLW
-----END PGP SIGNATURE-----

--daM9CXXbAeSyiYBY--
