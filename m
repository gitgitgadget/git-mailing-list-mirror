Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8908F201A0
	for <e@80x24.org>; Tue,  4 Jul 2017 14:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbdGDOpw (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 10:45:52 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53584 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750872AbdGDOpv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jul 2017 10:45:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0C16B280AD;
        Tue,  4 Jul 2017 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499179550;
        bh=FAbCi0yLsjyNBnVfxwMteFrbGfgdMON3Mi4hvjzmUwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fP91ovrqG0dtUKQOynjvzDh5zXtCvWgDJZsqiaht71fGAyMxfh0N4ELCE4OQpjq8R
         OFptAz1HA076ji19sdq8ygLrpASU3LLFUXiMfR5i4HABy84lOkU27HnaLRJZmj9oJ7
         YM+d7pPF11oSNs08qG5l2okyz9pMtFGir1kIMZb/+0twBAkxvCMqlQn18ZEj+YJZ35
         C7BQPck3Cu47gNllQ3AAZoIHoE4iH0c5WpdBNUyK0X7hesfWvs2lX55KWyLGMrXxPe
         SBwcYOL2KwjvOlkbOGFfQ9tBm+Q43mcVLjpIc+kaXRiBkySRbYjX6Oix2o5Wg1tAfC
         s2Xvl5wbGk4F7ae0/auexIiAeve+FpLp3CqFnKIAeuiWOCST66EmLPXdVsHL2uE1OL
         fFA7U1oVZSPR5Q4s8hqosryY6cNET/yMs5st8yMGqRji/8aYdclnjOF41+IfGc0dh8
         gMjqcnykzDhznt7I6tifLVTySi0nWMJEzIkN1pm6xaIvdH40Ky9
Date:   Tue, 4 Jul 2017 14:45:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/12] builtin/update_ref: convert to struct object_id
Message-ID: <20170704144544.zo2lkf2p7jnzxyzf@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
 <20170703185533.51530-7-sandals@crustytoothpaste.net>
 <8737adckkc.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="36vjxheipz6jqhjd"
Content-Disposition: inline
In-Reply-To: <8737adckkc.fsf@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--36vjxheipz6jqhjd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2017 at 10:49:39PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> On Mon, Jul 03 2017, brian m. carlson jotted:
> > [...]
> >  1 file changed, 34 insertions(+), 35 deletions(-)
> > [...]
> >  	struct strbuf err =3D STRBUF_INIT;
> >  	char *refname;
> > -	unsigned char new_sha1[20];
> > -	unsigned char old_sha1[20];
> > +	struct object_id new_oid, old_oid;
> > [...]
>=20
> It's easier to skim these when you leave changes in the number of lines
> to separate commits which do more than just rename boilerplate code,
> e.g. as in 05/12 where `const char *p` is introduced.

I can do that in the future.  I've received feedback in the past that I
could coalesce them into one line instead of needing multiple lines, but
since I don't have a preference either way, I'm happy to do whatever
makes review easier.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--36vjxheipz6jqhjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAllbqhgACgkQv1NdgR9S
9otBohAAo9Ou2pztvJkFuJ8fFlgbwiuSaFS94rYo5QJ8h+IdYwufnAzTLKKjyjMk
mjcnEez+qhLLq4ahRIbQmYxpjtoELZMBkwE97gid3q/ezYq6OmZzN+Kxpf83gUc3
8tTmdadnnKMpcDigtjtB1q9bPNPVUrdGrrHabFHwEkmlP8k2ON0oBqjN6nbIjy/j
+DVZrGc++LWDgB//niYTjnGU8U1RhYcPtVLAzNGcA/f77qz12KClo1A4pnAHty0Q
L8MJQuQqqa+KPV5u02nL8UnKzd1bFwseJeoZFJdICL2jxJHmqKux8LUKxDg5vdgf
kFMDqXm8l78Q+CLWIojiJbUF4in3SlvuC+1Hx+32Re9h+8eB5IfoYlJVr3AcVkTh
7mmeaRJZw55V+f3uhc2VTc822CfrZKD2WFU59AT2kFvOzCPXCga0uVl6Z0oXW6aK
N1aphayP9ALPvSmRj4XFFedknhJcPLrR2DVAQqqOKtZO1CtdwaKUp3jFllTYmTe1
bWLzh50deqdRu1pKYiRiYnYVRVYiLUCEkLI0gVj6iawrufK7+4xtEcdRAAGY1m7K
N/mv0tRo8M8XYinuNAKZmhc88f42qM9XOQNmEaz6+Lz7OrpgHSra6rh0B6dOWI4C
wFZJolCzLlk6z8pKg5cxL32+asWJkTh+7y849CndNlT1RfPsgIo=
=x9IR
-----END PGP SIGNATURE-----

--36vjxheipz6jqhjd--
