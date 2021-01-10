Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8439C433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 20:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA9B2251F
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 20:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbhAJUgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 15:36:04 -0500
Received: from zucker.schokokeks.org ([178.63.68.96]:55539 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbhAJUgE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 15:36:04 -0500
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jan 2021 15:36:04 EST
Received: from localhost (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1.3,256bits,TLS_AES_256_GCM_SHA384)
  by zucker.schokokeks.org with ESMTPSA
  id 0000000000000148.000000005FFB63B6.000076BA; Sun, 10 Jan 2021 21:29:42 +0100
Date:   Sun, 10 Jan 2021 21:29:41 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        "=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason" <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v6 2/8] config: add new way to pass config via
 `--config-env`
Message-ID: <X/tjtVGRKRhX0ZvU@ruderich.org>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610001187.git.ps@pks.im>
 <9b8461010e641369316d00e2fc58c16e0e191f42.1610001187.git.ps@pks.im>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512; protocol="application/pgp-signature"; boundary="=_zucker.schokokeks.org-30394-1610310582-0001-2"
Content-Disposition: inline
In-Reply-To: <9b8461010e641369316d00e2fc58c16e0e191f42.1610001187.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-30394-1610310582-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 07, 2021 at 07:36:52AM +0100, Patrick Steinhardt wrote:
> [snip]
>
> +void git_config_push_env(const char *spec)
> +{
> +	struct strbuf buf =3D STRBUF_INIT;
> +	const char *env_name;
> +	const char *env_value;
> +
> +	env_name =3D strrchr(spec, '=3D');
> +	if (!env_name)
> +		die("invalid config format: %s", spec);
> +	env_name++;
> +
> +	env_value =3D getenv(env_name);
> +	if (!env_value)
> +		die("config variable missing for '%s'", env_name);

I think "environment variable" should be mentioned in the error
message to make it clear what kind of "variable" is missing.

Btw. shouldn't these strings get translated (or does die() do
that automatically)?

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-30394-1610310582-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAl/7Y7EACgkQkv79t+RM
MvkSAA//WOv6dLmL9FFb1KXZ0b5lMPW2uDXM5TsdsUMdHoSMEM4KwU2qHafu3IDj
PvaavyYWF34eJ0442HUvBJCpGG7cwAO/VWn3TZrTOIDBAG+HPq9F+Z/2OV+CXmQD
ledpQEEiXf5H0e4jHCEoBgruLIHS+2q8eER009LUT9Z7TWx/0yNck5zlQLxfxyZm
YnvDNJuC7h6aUXl0Yj1H1PpCzzX3aUuoS+8oEPrN3955UEpf9+ToNz3kSjE95FoY
ZnHWjw75gNlQH4sGVO9ukii/bfMAEF4nVf9SrmQ/blvqEKsoG6F/JzP3NF29t1e2
wfnsDhIlW2uasjFC0c7LhqMRBjvodx2LUFs0aN8hDQ73R9qRD+jWfxwvIEKdBWOG
j/kNx8+HFUHdVXzVr8na70qN9OUvJhgl9QPD8YDlq3FRJ4ufok55FIgxHVBMwfEx
dOzvuB72Pu4BpR0fkfDLmSMQ6C22J6GZhiQRck7H991Z6WBqIsWh6ua2gzrGucvd
7CtzCi+w8iPyef9KIfvMuqC2CZtjUcWkgO4TUkg3WyHGbX/8aqaF33jgX5JLilJD
4ECkytteVoVBu6XIX+hye1e7CeFizoVIbDZ0jfQ2L2SNWpqeY4YvCSUHBcqXswSp
DyRwKEvt00J+HNNXRfbDylaOvnFDCuu6rd3B6YiI3N4wq5F2wIQ=
=d/3d
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-30394-1610310582-0001-2--
