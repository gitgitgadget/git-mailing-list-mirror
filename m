Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D7F1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 20:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932842AbeGFUSu (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 16:18:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52900 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932502AbeGFUSt (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jul 2018 16:18:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:294b:af98:ff6d:ed6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B92FE60431;
        Fri,  6 Jul 2018 20:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530908328;
        bh=IvrRqCR7LRBgrOQCTpDo4uI7X8TV+LJL92iNSDxyzDo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BMUEnsLxCQoY3Mjoqr8F5FCFKQlPSF0k5nYnQa7V2bh2nfr7QtvfsLBLV8la/GqPT
         lx3VYuNuq9TH5kjiSE6kA35njwOSuB02gB9tHGHciuIgHWzp+LqNItG6c/mIex+C4T
         aim5+N7kbMaGNy7QvHugMrpCmHGB3j3KnyGONAezm+swobiYTPvbHylZZfzZ96QKkx
         Cnefi/yx6nuTQvZWrllcAK5suUMwQZdPefrX7why8MN3gXcSZBo911DAOiBj9PNiqN
         oW1dPyStmcrL3EMj+jGzOWnKdHVYTvNnpcu+hbeyB7yvjdUpREGRYDrM6nUP9VpL7E
         hkMMA9puLlhy3SG8rE7ct6PdqO5QMWHVULi7XBTA4zAa6Sr5HHUQwW5wz3H6HvOdUG
         3fBPb1uyuT84lttNDVULlmvGfYixQGiYKyLajsTDc7NalCfsbu0x3AReEG8e1DBe6V
         VQmYNm+ZEs3GznXqijBxQCe3xL/T7uirJfq8w2JVpcgonGts0VJ
Date:   Fri, 6 Jul 2018 20:18:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] send-email: accept long lines with suitable transfer
 encoding
Message-ID: <20180706201843.GF7697@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20180706022357.739657-1-sandals@crustytoothpaste.net>
 <20180706022357.739657-3-sandals@crustytoothpaste.net>
 <20180706122604.GA9255@homura.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline
In-Reply-To: <20180706122604.GA9255@homura.localdomain>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 06, 2018 at 08:26:04AM -0400, Drew DeVault wrote:
> On 2018-07-06  2:23 AM, brian m. carlson wrote:
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index a76953c310..4ea30c4070 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1899,6 +1899,10 @@ sub validate_patch {
> >  		return $hook_error if $hook_error;
> >  	}
> > =20
> > +	# Any long lines will be automatically fixed if we use a suitable tra=
nsfer
> > +	# encoding.
> > +	return if $xfer_encoding =3D~ /^(?:auto|quoted-printable|base64)$/;
>=20
> Rather than returning in this case I'd sooner wrap the length check in
> this test. If additional checks are added in the future it'd be too easy
> to accidentally skip them if the transfer encoding is quoted-printable.

Okay, that's fair.  I can do that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAls/zqIACgkQv1NdgR9S
9otNaA//eM3eitfpOExpiqSsMN1Um8V0Biu9F4NHQ/cmgJ3U81HOZr7IruY8rvlx
cOh/WdKiQB7v2vBwm7l4Ue/qYbHRQ1Baejbtr+G+BTxjzyxkLbBINy+GcRFWG1mK
+f1BQUow8TOdhBL4CQknDYNsE7OPSb3iorHrjHuoRqDqkr1nPjd0f7VD4tX2+p86
xcoVa+pnYUW4NdACKpLjWZmtkmMwhKlRd0DyzjQFkFXf8yJqdT0+wXjZwLqDh5ik
87w1aFiX7FsiNH5kKqUrk5K1hoko9YYFYVZ38/ClsPYLBg6543z2eX+uv8Om1gbe
y9m7C+rNyh3e1rAGAhmXAAZMYUHq8xPRNB07pMB8aZQNNfbLNXypA0bwIPS27Y1C
tuiY+cm2FKy4r2fhyxv2qgufBCXedErQyhAsO6Fj0JX15Yp8t68jnMM8cx+/UWYC
vnzNK1GquVfH9gbBcs1dYMslx0IKqT8JfCgv1GMaytSmgeeqG6z3LTkseSYILjzQ
Iog8MyZgbLwXsLIFbh6g67SrNKbxBPuVo7CxPF6PnC4ZufixzB+FBrQzmq5GQrTh
QV7ogXVEoTSaQLvL5JmFRvHqKUpkH9LgHL1zZ4fZTi11S/WlHcCTkPioipNlVgUZ
lw+XO+fW2Qjb17e+9La+ka3HIPs2DRTBUhFdaXoYT/h8Pz0NI7M=
=djtC
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
