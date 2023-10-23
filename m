Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6C12B8A
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tS4SEqQI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MunYYnIL"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3196A10CF
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 02:58:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 696A532009B5;
	Mon, 23 Oct 2023 05:58:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 23 Oct 2023 05:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698055085; x=1698141485; bh=9z
	d4TlM2wz3+Oz1Pz221Jq9vYMy+N3swM1nocDbVu/s=; b=tS4SEqQI4gYVzijnxL
	Vu5sbUZTNJOczlYMsT1Nhe9YJsO8rzZ+hCvAR+wFVOt2e30iUgcFGVuyImycS/Lf
	z+UU2G2tLePuMfXLuLBkQ9oacy9j6cfCMBexlkv+UqzlG91bSOtHRVWLICqcBcTW
	PJUspe7P68W36/LOV1m+F+DvINOxuwHyOApUykxQdR5JgA4Q+GDaE3z85OOSU4OS
	+FmVErg62CEYVyBk8kXHDkPXevPmGrdxVRCc3Np1qYtk5sG8/CsOZI0n3pVbqJEt
	dCHl5Ac/AKFsTVwJoDLMiT3ijtvvRCYMbhVlOME7RP1kD6c70BIz++q64GK4iTe3
	gRQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698055085; x=1698141485; bh=9zd4TlM2wz3+O
	z1Pz221Jq9vYMy+N3swM1nocDbVu/s=; b=MunYYnIL2/Ywb7tI5Oshr0K3HHbh+
	V3B9xkdy/2BiUCNkzuXMtvlzCgzS3MfDV1zdsAM3Z5JbRL1X1n4xWU8lRWoxx/N0
	g3AqMd23k6tDhtw/vXqpaLAB3mo/SFXlr9Ogtm30V3qiHZJcN03b48HxZsfkhwit
	CJqueKgMu+V5a+nbv14Ha2HKA05498WyKGYpxY1KX6ufNoqKa4yy6doDjYhczL7s
	zYTGTVYDZrNFke78hI23zka/SEMCrlu5ddwzTH177ZFRTLJqvACXvVrb7t4HlYwX
	3MOyV6jbKyIFsLPKTFnSaAWlQ4aUDo2RCkPS66kLnbhEBoNAgcuGIc/FA==
X-ME-Sender: <xms:rUM2ZYXBOlCWNdM0oIrs6LHFm9Rwqk2WjJN9UeQS2MlD5XrBNMcKpg>
    <xme:rUM2Zcn_c_doONEdg-T8MGl5XCECval64ePxd3e7yhXLVHOXrc6EJAMkJBeZVtEuX
    hskrMbpMH0CXbOhvA>
X-ME-Received: <xmr:rUM2ZcbW3qY-pAcUkp3eQS_bEcx-IHAo9webRRd7bYYI8DnOH_-HvOsbNNamV7__1ZRay2vpXxC8lZA5Lti2GcJITlJhgaVk7s7_YlJ5MIcO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtdfhge
    eftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:rUM2ZXXCQjmyMnvwPElLWwsSDn7kK6yTKj-FdUTbV384Pk_JIN8Zgg>
    <xmx:rUM2ZSmuQVIgIWbdnwNIAba_i4xVtNHs-T5eFkZpSoFCm6UsXrr33A>
    <xmx:rUM2ZceZIqXA1GbJL3mXixbZukJdhlGxuFVnda01IczHFUsWexEIvw>
    <xmx:rUM2ZWvHoblhGlgg5FmdoLX5Cgk1x7MBbB1ARJfh21MTnlwmqNZdiQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 05:58:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 605f7135 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 09:58:01 +0000 (UTC)
Date: Mon, 23 Oct 2023 11:58:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v1 3/4] config: factor out global config file retrieval
Message-ID: <ZTZDqToqcsDiS5AP@tanuki>
References: <cover.1697660181.git.code@khaugsbakk.name>
 <147c767443c35b3b4a5516bf40557f41bb201078.1697660181.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ibb3yXMQcKY5Cqz7"
Content-Disposition: inline
In-Reply-To: <147c767443c35b3b4a5516bf40557f41bb201078.1697660181.git.code@khaugsbakk.name>


--Ibb3yXMQcKY5Cqz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 10:28:40PM +0200, Kristoffer Haugsbakk wrote:
>=20
> Factor out code that retrieves the global config file so that we can use
> it in `gc.c` as well.
>=20
> Use the old name from the previous commit since this function acts
> functionally the same as `git_system_config` but for =E2=80=9Cglobal=E2=
=80=9D.
>=20
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  builtin/config.c | 25 ++-----------------------
>  config.c         | 24 ++++++++++++++++++++++++
>  config.h         |  1 +
>  3 files changed, 27 insertions(+), 23 deletions(-)
>=20
> diff --git a/builtin/config.c b/builtin/config.c
> index 6fff2655816..df06b766fad 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -708,30 +708,9 @@ int cmd_config(int argc, const char **argv, const ch=
ar *prefix)
>  	}
> =20
>  	if (use_global_config) {
> -		char *user_config, *xdg_config;
> -
> -		git_global_config_paths(&user_config, &xdg_config);
> -		if (!user_config)
> -			/*
> -			 * It is unknown if HOME/.gitconfig exists, so
> -			 * we do not know if we should write to XDG
> -			 * location; error out even if XDG_CONFIG_HOME
> -			 * is set and points at a sane location.
> -			 */
> -			die(_("$HOME not set"));
> -
> +		given_config_source.file =3D git_global_config();
>  		given_config_source.scope =3D CONFIG_SCOPE_GLOBAL;
> -
> -		if (access_or_warn(user_config, R_OK, 0) &&
> -		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
> -			given_config_source.file =3D xdg_config;
> -			free(user_config);
> -		} else {
> -			given_config_source.file =3D user_config;
> -			free(xdg_config);
> -		}
> -	}
> -	else if (use_system_config) {
> +	} else if (use_system_config) {
>  		given_config_source.file =3D git_system_config();
>  		given_config_source.scope =3D CONFIG_SCOPE_SYSTEM;
>  	} else if (use_local_config) {
> diff --git a/config.c b/config.c
> index d2cdda96edd..2ff766c56ff 100644
> --- a/config.c
> +++ b/config.c
> @@ -2111,6 +2111,30 @@ char *git_system_config(void)
>  	return system_config;
>  }
> =20
> +char *git_global_config(void)
> +{
> +	char *user_config, *xdg_config;
> +
> +	git_global_config_paths(&user_config, &xdg_config);
> +	if (!user_config)
> +		/*
> +		 * It is unknown if HOME/.gitconfig exists, so
> +		 * we do not know if we should write to XDG

Nit: we don't know about the intent of the caller, so they may not want
to write to the file but only read it.

> +		 * location; error out even if XDG_CONFIG_HOME
> +		 * is set and points at a sane location.
> +		 */
> +		die(_("$HOME not set"));

Is it sensible to `die()` here in this new function that behaves more
like a library function? I imagine it would be more sensible to indicate
the error to the user and let them handle it accordingly.

Patrick

> +
> +	if (access_or_warn(user_config, R_OK, 0) && xdg_config &&
> +	    !access_or_warn(xdg_config, R_OK, 0)) {
> +		free(user_config);
> +		return xdg_config;
> +	} else {
> +		free(xdg_config);
> +		return user_config;
> +	}
> +}
> +
>  void git_global_config_paths(char **user_out, char **xdg_out)
>  {
>  	char *user_config =3D xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
> diff --git a/config.h b/config.h
> index 9f04de8ee3e..5cf961b548d 100644
> --- a/config.h
> +++ b/config.h
> @@ -394,6 +394,7 @@ int config_error_nonbool(const char *);
>  #endif
> =20
>  char *git_system_config(void);
> +char *git_global_config(void);
>  void git_global_config_paths(char **user, char **xdg);
> =20
>  int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
> --=20
> 2.42.0.2.g879ad04204
>=20

--Ibb3yXMQcKY5Cqz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2Q6kACgkQVbJhu7ck
PpRrYw/+NC7OvgP8D808k83+54IN4rD+UtvWPqdTRLUE+3rAzGHigJaSmXP87N2V
UpTWD07YQJSaDk9YHNugC1UuV1lLDpC1ZgNsJzvcYFfmJk67ylbtZShjvRW673IO
btqV/BkeOUVaAwgxlli4Wnre/dhoq8G5LHW12qDNT+KVEXpNv08AvBS6xP0O2yjl
bdH/wF3LaJqztmC8+T4ejhb5VSDpvjnzyHFIAVc4A52g9fPtfdZU/WL62WEvdNu6
ADORamLhTuUdqm0T0QGpmqAUtBUNgZweSCkSvhaPzI1cPKVlWhXBsepn4jKTO4hu
VPFHjObsL/WeoKjwfkL9GPjll331l8TxhIoWemYaV8RNttN8k2v7vzEVrEjGzKBt
1qVDZ65M5KqpJ8wfXysdpfoca7YX56WqZJfYcs4SN1/9fI8XBHV7ZICvhCnooSOs
8lOKmSSS5YW0ZhXJPCjyv4zlGj3b/hBS8kDkA4GMKL1kXCCKDwSLLmtvN9V+oWJP
jkJVTiTWmUXwMDElTHnjKFUCeDM8bJRyPtdJC7exK3K7biN9oOYLwz/AMz/DhiVw
1N0KmtqhgvHJ5NP0XFDcaJaWsgedfmUGt69o76BZX6RVD4PtMbSUaHH49a9axoog
uF9rlqrJLDPQ/tnJNAUnzL565g1AiBQSDoZZEdZIJpKWisizG9o=
=rMXV
-----END PGP SIGNATURE-----

--Ibb3yXMQcKY5Cqz7--
