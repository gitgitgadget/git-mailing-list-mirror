Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C713FF9
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZMEyZJ8z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R5GACEYV"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6248210DA
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 02:58:12 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 6CFFF32009B2;
	Mon, 23 Oct 2023 05:58:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 23 Oct 2023 05:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698055090; x=1698141490; bh=yw
	gb0hL70aysY6W2SSCONSbzFm6xD7S5auuvZRKExTw=; b=ZMEyZJ8z5FPeN2hdVS
	coO4+G9o4yAWUka0QWio2WtOfUYedgpiAZYqPqUgaX/5epOMrBuT+h5xjHJvyLg8
	KWBQR1cdnMfjoOMG6CoWbusXnEA/oFaTcsNhoJZOrTEWPwKwwWZOn02kQk3KHemP
	Nl0rVtn5+YnJcJRV6BL92IKmpPco2Be7QtIzEW2C+OJmO5OO0HH4SzfNnDFukat+
	Pd/tPQkN0dvr9idP7+IRw5375evj0wCcry6+b0hKbsNgtH10z/G8mvQCVzdgN4hR
	KPT7l2oTI5q3W/XZpK6Fmb5FWtEGHDSHv2mqA7Yqx3CJh0wizBc5Zy5CGY2SqqVf
	W+NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698055090; x=1698141490; bh=ywgb0hL70aysY
	6W2SSCONSbzFm6xD7S5auuvZRKExTw=; b=R5GACEYVKfQx7AeSsojt30hbueOGB
	b6hD/NEXJt5+iOWAK+kph89zJHhiO4GeUayBNcbE8Vu5PDzARKSc9Hzzppwu8atF
	rO7nFir23hifY+SlWoM9hE4ui2RTX00AWqc6WSGNQesMVXf8htG3ras6KdGfTh3h
	pn2iel0SPlruANOjCde8XHTjYFe9IQBiqbXalFt7UrJpIT48v81uW6NUUJioJ5ax
	unECjb9dIP4vUgt42Eh+x7LqdxO4yEbPVzk8jV1V8WtEIqUelO9xY+0vecLu9/Tn
	A7/SjFyR9LMxdCJy/Ku7GJOtB7Qz1mZSLeX95tJMQkjK66wZzi9ADU2zw==
X-ME-Sender: <xms:skM2ZTUmH04DQRwiYrwgFObECq5LAa87HIQ4RP3LjtedFwMNKfFzCQ>
    <xme:skM2Zbn-aLaE3KekoH0sOGcgtQJhQvbTGCI6ojqGaALbMXcDSJjOUiNEftW3ixsLO
    JBEROmLxiolzrjJrg>
X-ME-Received: <xmr:skM2ZfYCezeLakHSsBN5Nyt40nI_gk2pobzQjeXRZQxjFS5J1CN5yJeGlOsU5tYmHA8kQLX5j1D7ukNZGISSaTzDuOdWUDqD-a4uOK-IzZPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:skM2ZeWytHfO85LndcaS0ubZdU8C977sxGYeDuiTu32dbq3CjT8oaw>
    <xmx:skM2ZdmtCQ7DLnRNuudCZXWTPS9cdLFuX6pYt4v7hywks8PknPS83w>
    <xmx:skM2ZbeXQp9XnqkAuMsIEcqA55QpqFVpH8RcexUWA3WI51jdLegAlw>
    <xmx:skM2ZdtV19pG6dqUUe4iogLrqqs3BK3SKh9-wut2cx4IOBO9ljakeQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 05:58:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 387dc6b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 09:58:07 +0000 (UTC)
Date: Mon, 23 Oct 2023 11:58:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v1 4/4] maintenance: use XDG config if it exists
Message-ID: <ZTZDsIcrB0zwHlFR@tanuki>
References: <cover.1697660181.git.code@khaugsbakk.name>
 <1e2376a4b998b5b182cc5f72afc7282134bcdf2c.1697660181.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rZM+V7zZIRSMB2HI"
Content-Disposition: inline
In-Reply-To: <1e2376a4b998b5b182cc5f72afc7282134bcdf2c.1697660181.git.code@khaugsbakk.name>


--rZM+V7zZIRSMB2HI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 10:28:41PM +0200, Kristoffer Haugsbakk wrote:
>=20
> `git maintenance register` registers the repository in the user's global
> config. `$XDG_CONFIG_HOME/git/config` is supposed to be used if
> `~/.gitconfig` does not exist. However, this command creates a
> `~/.gitconfig` file and writes to that one even though the XDG variant
> exists.
>=20
> This used to work correctly until 50a044f1e4 (gc: replace config
> subprocesses with API calls, 2022-09-27), when the command started calling
> the config API instead of git-config(1).
>=20
> Also change `unregister` accordingly.
>=20
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  builtin/gc.c           | 23 +++++------------------
>  t/t7900-maintenance.sh | 21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+), 18 deletions(-)
>=20
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 17fc031f63a..7b780f2ab38 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1526,19 +1526,12 @@ static int maintenance_register(int argc, const c=
har **argv, const char *prefix)
> =20
>  	if (!found) {
>  		int rc;
> -		char *user_config =3D NULL, *xdg_config =3D NULL;
> =20
> -		if (!config_file) {
> -			git_global_config_paths(&user_config, &xdg_config);
> -			config_file =3D user_config;
> -			if (!user_config)
> -				die(_("$HOME not set"));
> -		}
> +		if (!config_file)
> +			config_file =3D git_global_config();
>  		rc =3D git_config_set_multivar_in_file_gently(
>  			config_file, "maintenance.repo", maintpath,
>  			CONFIG_REGEX_NONE, 0);
> -		free(user_config);
> -		free(xdg_config);

Don't we have to free `config_file` now?

>  		if (rc)
>  			die(_("unable to add '%s' value of '%s'"),
> @@ -1595,18 +1588,12 @@ static int maintenance_unregister(int argc, const=
 char **argv, const char *prefi
> =20
>  	if (found) {
>  		int rc;
> -		char *user_config =3D NULL, *xdg_config =3D NULL;
> -		if (!config_file) {
> -			git_global_config_paths(&user_config, &xdg_config);
> -			config_file =3D user_config;
> -			if (!user_config)
> -				die(_("$HOME not set"));
> -		}
> +
> +		if (!config_file)
> +			config_file =3D git_global_config();
>  		rc =3D git_config_set_multivar_in_file_gently(
>  			config_file, key, NULL, maintpath,
>  			CONFIG_FLAGS_MULTI_REPLACE | CONFIG_FLAGS_FIXED_VALUE);
> -		free(user_config);
> -		free(xdg_config);

Same here.

>  		if (rc &&
>  		    (!force || rc =3D=3D CONFIG_NOTHING_SET))
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 487e326b3fa..a11e6c61520 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -67,6 +67,27 @@ test_expect_success 'maintenance.auto config option' '
>  	test_subcommand ! git maintenance run --auto --quiet  <false
>  '
> =20
> +test_expect_success 'register uses XDG_CONFIG_HOME config if it exists' '
> +	XDG_CONFIG_HOME=3D.config &&
> +	test_when_finished rm -r "$XDG_CONFIG_HOME"/git/config &&
> +	export "XDG_CONFIG_HOME" &&

Style: there is no need to quote here.

Also, I think we need to unset this variable at the end of this test as
tests don't run in a subshell. In theory, we should also be able to
leave this variable unset completely as it will be derived from HOME
automatically anyway.

> +	mkdir -p "$XDG_CONFIG_HOME"/git &&
> +	touch "$XDG_CONFIG_HOME"/git/config &&
> +	git maintenance register &&
> +	git config --file=3D"$XDG_CONFIG_HOME"/git/config --get maintenance.rep=
o >actual &&
> +	pwd >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'register does not need XDG_CONFIG_HOME config to ex=
ist' '
> +	test_when_finished git maintenance unregister &&
> +	test_path_is_missing "$XDG_CONFIG_HOME"/git/config &&
> +	git maintenance register &&
> +	git config --global --get maintenance.repo >actual &&
> +	pwd >expect &&
> +	test_cmp expect actual
> +'
> +

As you also change the code of `git maintenance unregister`, should we
test its behaviour, as well?

Patrick

>  test_expect_success 'maintenance.<task>.enabled' '
>  	git config maintenance.gc.enabled false &&
>  	git config maintenance.commit-graph.enabled true &&
> --=20
> 2.42.0.2.g879ad04204
>=20

--rZM+V7zZIRSMB2HI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2Q68ACgkQVbJhu7ck
PpS0EhAAj4X/GwiGsqg1oMJHnJKi/I/QwQR5K/9siZ8XyVaaJt2nMvKaAyD51h4H
7rmdLcB/A0Ud+HWYm2aSYzD1pUWcHrKs4ZZhX4mbh4msmVjNjxAhXzyHs9sA4JXm
En9wdbEcupJf5ljy7anL+VxTSQe17OE5yPiXrQWr07V+b08UQ4/9n2yke8ctxkCc
Cr6eEiKQPKUSy7yFHiUDs2+V8a44LM8nHaAP7cqBZktuDve3ZcIJOpApdmABCeg/
F4w3R5SVgJ5fzISr2icfkBOuT7txxN0GL4nYknwDMmdLObEIeer3Gid/r3l6fP1L
z9ey7MxT7u4DQOXM02daAUtIRvNuxJdOKTIw7yOJLaoxqjTH0liSyI8HvGITsOj8
vz5XJ1EZzcb8Z3/qgCf/wOMWLm8xaj3AZUZfjhxWS+RGfVcfIidlRnpbnTMuvs/F
HrMMW/Ai3x5CnEtFak8a6xXYmapjqtvnsKY5CDGt/A6t8xV06ngBhcaq62/LTC/m
0C0GaD2yQ8HmisW8MeMzp9hSjlWbrFSKcEg3ufs5fIVUiTXOioXThei0OBUJNq0W
uY3zodo+KgDnLG/xWp8cOj4wyjqXM2lgPc9hPZSijm7WjcJxXrQdJrwFa9lfIa0y
wqkyLPCZpkQS9BNbpAzechmu2MZTwtUyKCxibi6S5R3jcimd93M=
=W0cy
-----END PGP SIGNATURE-----

--rZM+V7zZIRSMB2HI--
