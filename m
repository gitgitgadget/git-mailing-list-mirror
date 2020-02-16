Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTTP_EXCESSIVE_ESCAPES,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3777C3B1BF
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 20:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ED62084E
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 20:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QI0a9HMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgBPUxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 15:53:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34334 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgBPUxh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Feb 2020 15:53:37 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DD29260791;
        Sun, 16 Feb 2020 20:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581886416;
        bh=dXoOMntfiPPgv287VJB8RmIwAwR+J5jO4loS29BmzNQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QI0a9HMAlwRamU2Wh654MOa45Fkk6owgNmbvZBgWmLm2HkQ4qzY2VpsjWlo/hwi/t
         eiz539V8SgQNO6+1NuFF6CTOnn7pX0wLe7AOrGdSQXT8DOmwUxPQ0ddynpuY5AIn33
         ozUoNbJCuKOT7u7vP/Do/LKHb9wWins8sdwWGyJrsgevjQVsVrn2V5UWmQvYTYbbHn
         XYvFcB458t5mvQDm/NDPvayNevZOh7sL5NTRvGZb88FdeqJxHTiNNySQAF1FO+ZR4t
         9zAz18F7A+m1Q5IVSOJ7dLrC9m8svhItMBAvZDhjlE58cpZ2GiBl6gjLeYkDSnllzv
         t6L2h1AhSKasx4l6t3X43ekER3dSr2RsHaSeFMwfvK3o9ehFx2AIQM5+nlTxeSFWSa
         jk9yNyRULoLuzbdJEwjB3i6t7HLpyVaqM7u5BjXRTDDLqXXkoevkUj54oXgikkjHau
         We+0QKgm9x9N4bRZSRJtSLEEJctipTy8oalOI4oswO8iqPAiqDT
Date:   Sun, 16 Feb 2020 20:53:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] credential: allow wildcard patterns when matching
 config
Message-ID: <20200216205329.GD6134@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200214225929.541306-1-sandals@crustytoothpaste.net>
 <20200214225929.541306-4-sandals@crustytoothpaste.net>
 <20200216061323.GA2397568@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <20200216061323.GA2397568@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-16 at 06:13:23, Jeff King wrote:
>    So I think we're OK here, unless you can come up with any more
>    obscure case.

Yeah, I made this implicit in my patch, but I couldn't think of a
situation where we'd hit this case.  I'll update the commit message to
reflect that we don't intend for this behavior to change.

>    Some options are:
>=20
>      - teach urlmatch to pass matching config keys to our callback even
>        if they're "worse" than a previously-seen key, so that we can
>        then record all helpers in the order they appear in the config
>        (retaining the existing behavior)
>=20
>      - use urlmatch's cmp_matches() to order the list of helper. This
>        would be a change in behavior, but I wonder if it might be what
>        people prefer. I suspect it would make some happy (if the
>        host-specific helper can answer the query above, you'd just as
>        soon not run the cache helper at all) and others not (if the
>        host-specific one is expensive or requires user interaction, you
>        may want to try the cache first). So I'm not sure if it would be
>        a good idea or not.

I think it should be reasonably simple to adjust the logic to do the
former.  I'd like to avoid making non-backwards compatible changes in
this series.  I'll add some tests for this case as well, since I think
it's going to be important to get right.  Thanks for the sanity check.

> A few comments on the patch itself:
>=20
> > --- a/Documentation/gitcredentials.txt
> > +++ b/Documentation/gitcredentials.txt
> > @@ -131,7 +131,9 @@ context would not match:
> >  because the hostnames differ. Nor would it match `foo.example.com`; Git
> >  compares hostnames exactly, without considering whether two hosts are =
part of
> >  the same domain. Likewise, a config entry for `http://example.com` wou=
ld not
> > -match: Git compares the protocols exactly.
> > +match: Git compares the protocols exactly.  However, you may use wildc=
ards in
> > +the domain name and other pattern matching techniques as with the `htt=
p.<url>.*`
> > +options.
>=20
> You'd probably want to review the documentation to accommodate any of
> the behavior changes discussed above that we end up with.

As mentioned, my hope is to not need to do this.

> > +	config.section =3D "credential";
> > +	config.key =3D NULL;
> > +	config.collect_fn =3D credential_config_callback;
> > +	config.cascade_fn =3D git_default_config;
> > +	config.cb =3D c;
>=20
> I don't think the old code would ever call git_default_config (we _just_
> want to load values for this specific URL). So I think you'd want to
> leave the cascade_fn NULL here?

Okay, can do.

> > +	credential_describe(c, &url);
> > +	normalized_url =3D url_normalize(url.buf, &config.url);
>=20
> The purpose of credential_describe() so far has been to show the URL to
> the user. It won't do any %-encoding that would be required for more
> exotic URLs. But I assume we'd want that in whatever we feed to
> url_normalize. So for example:
>=20
>   echo url=3Dhttps://example.com/%2566 |
>   GIT_TERMINAL_PROMPT=3D0 git \
>     -c credential.https://example.com/%2566.helper=3D'!echo >&2 run helpe=
r'
>     credential fill
>=20
> matches in the current code, but not after your patch (we decode %25
> into just "%", and then feed "%66" to the url normalizer, which decodes
> it to "f".

Good point.  I'll fix this and add a test.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5Jq8kACgkQv1NdgR9S
9osrKA//VUzSJjgpgBsM9hFBATIpqyzPC2zxxiQQRgFFZmFRuzzbmzgWlvj0ajhz
B0TQw41E625DKaBOxlGj/Bg1g2pmfDP2rsbvUYjLNZEIk12YWg0Sj9lQ+sWRCxkd
6VTlGCns5wRq+iSmLfTL5fQy5LtDugHLiep73eGEZfZWtPuaS6+zJjXWxBSRyLkM
tUNmpOkRz5KeZnbpkYzoIPQuXG/i+zAB8DxqVqOBrDI8XuUTAFfjt9ZoPAD/wZid
IwEAyLgonVvjsNVVMmr+QU9lJv6s6V8I4DLcfRHth9dFIkWw22YPnCuPEwhbFvc0
u2cs7D31Xtt/QGs4oUgfQ2O4rwe819NvzEQ/spfNUb+eng/kxNkAtEdLGxZegxSv
i5+K1owpqfLMz+Cqo69os41CZFkbM86VT//L1nXmU1bETBVXyfE/HEfhWeuwMUNg
FaN1mhxN03VfG3jYmZh2k0XcZuWgPcEMzD/uvIl88MmElhdKBYaUenhGydXQ/tLj
tHGK7vqvTreLsF1NgRsmatM/7eg82n4W7w8yUPK5LBN3XEoiBLYkbbvPKWxgoa4d
D3h42AO3GQw+OCeJKMvH9B6KIbPDbnWASRbKCaOV4vkZ2uPh1zhbYuT+e/+zLYaM
TC95VJSALIhR9fkcGRstwInVoNebzt7zc31wDRIhZpXbB7j+TJY=
=WC26
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
