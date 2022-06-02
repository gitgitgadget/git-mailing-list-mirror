Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001B8C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 00:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiFBAl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 20:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiFBAl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 20:41:58 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1F61737CC
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 17:41:56 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1A4A35A26C;
        Thu,  2 Jun 2022 00:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1654130516;
        bh=2CrRjuWqEZ7+ddbpMqzaoWTfC5sD4ty1XUyG3B1NUF4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uYtHyBeP3FjvKarLHLh2CXmd0q7yb1983/znQm18SZlYmonLj+Z4EYyEvGxULPQk6
         LmbRBRmG+1Rh+TLxV1xbTQjOLuFb1F6CD+2aX3ZfeDazfuz4auWcMM6iF4TfDHfREg
         vF90k9+RnURw8xktRPx196N5xZtObe5BSTIZkqIl23Wa5ZZfsOjlxiwI2FKQWCpQq8
         UF1aMfn2atP8kAicbaF5mI3ZZCCx3Mz+lbvPpnm1fc4BLVT6ZE7k6vgZSHxpWHvwwe
         3G3RB0vjw5S6W7S4RohL21rgwd+REMt726hBMFTQGDzi58jEogpWIilJ3jtgMcjzS2
         sYuCWD1phvFBqKBakaBipqTpNhLDRRdChAEO2c58BDnUPgf7A5SvtQHRC0q6kKChwk
         RXnCuYVz47H8+tVC0UoOARGVqIqnWTU1kCcTW6YMKDGXqKlPyVQRmieOwx8ZDyZH+u
         1Lkv9yYgy83d6k8bkxUpqbeVf+xY7HYsNXjWnWhgZgHMiw6uhyj
Date:   Thu, 2 Jun 2022 00:41:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jason Yundt <jason@jasonyundt.email>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] gitweb: switch to a modern DOCTYPE
Message-ID: <YpgHUm93840oBtib@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Yundt <jason@jasonyundt.email>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20220601012647.1439480-1-jason@jasonyundt.email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RMMu15q2FwuiS3lj"
Content-Disposition: inline
In-Reply-To: <20220601012647.1439480-1-jason@jasonyundt.email>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RMMu15q2FwuiS3lj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-01 at 01:26:47, Jason Yundt wrote:
> According to the HTML Standard FAQ:
>=20
> 	=E2=80=9CWhat is the DOCTYPE for modern HTML documents?
>=20
> 	In text/html documents:
>=20
> 		<!DOCTYPE html>
>=20
> 	In documents delivered with an XML media type: no DOCTYPE is required
> 	and its use is generally unnecessary. However, you may use one if you
> 	want (see the following question). Note that the above is well-formed
> 	XML.=E2=80=9D
>=20
> 	Source: [1]
>=20
> Gitweb uses an XHTML 1.0 DOCTYPE:
>=20
> 	<!DOCTYPE html PUBLIC
> 	"-//W3C//DTD XHTML 1.0 Strict//EN"
> 	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
>=20
> While that DOCTYPE is still valid [2], it has several disadvantages:
>=20
> 1. It=E2=80=99s misleading. The DTD that browsers are supposed to use wit=
h that
>    DOCTYPE has nothing to do with XHTML 1.0 and isn=E2=80=99t available a=
t the URL
>    that is given [2].

While the WHATWG may claim that, an XML parser is absolutely within its
rights to refer to and use that DTD, and in fact should do so unless its
catalog directs it elsewhere.  It may be that some browsers use an
internal catalog that refers to a different DTD, however.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 606b50104c..1835487ab2 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4219,7 +4219,10 @@ sub git_header_html {
>  	my $mod_perl_version =3D $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
>  	print <<EOF;
>  <?xml version=3D"1.0" encoding=3D"utf-8"?>
> -<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.=
org/TR/xhtml1/DTD/xhtml1-strict.dtd">
> +<!DOCTYPE html [
> +	<!ENTITY nbsp "&#xA0;">
> +	<!ENTITY sdot "&#x22C5;">
> +]>

I think this should be fine.  It defines the entities we need and
appears to be valid XML.  I don't think there should be any problem
upgrading to XHTML 5 here.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--RMMu15q2FwuiS3lj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYpgHUAAKCRB8DEliiIei
gQEFAQDxmqKfWUc7Go/oOVpcOnombx2j4rDsUFU+j+/q9m9ahAEAzB0H3oy/xfHk
RW5cnHSYq7mJGI0FTzJ+BoAA1jhSUAE=
=WtMm
-----END PGP SIGNATURE-----

--RMMu15q2FwuiS3lj--
