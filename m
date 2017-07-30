Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B875020899
	for <e@80x24.org>; Sun, 30 Jul 2017 23:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdG3XA1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 19:00:27 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:42952 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750961AbdG3XA0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Jul 2017 19:00:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5BA1D280AD;
        Sun, 30 Jul 2017 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1501455625;
        bh=skOCS/bdeyO8c284CWN//LfGod/wKJ2S05a1ioByxAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N7Mg4UPW17u9LXuircW8aSHpE4UcO5goTQlXCeASbcqAgZwrvVkZhIuxI8ZTemEcj
         TUxsLB9ylQ6xFwWZx9kv5E/8E8TsyjtGqt1tO8jjilJUUZ8wsYNGKgZ+1V+JhfuOTi
         04ExdPZRDa31KAb/cDZriTv9bxr7IqUcmRkF4Ojyn8igsxM1JOS7WJ9CKlULhoM/Cl
         IIBK417o1Vllwg9rWtIXTLTHH2mJnZ42g0LyHsz8tmw+gtRltyRcVeyvV/N7g9FZhB
         sPpQQAnqQ/+elA1j17Wx9W9vtTLpxEUrdNoQpPDqtOcQ3OCksYDUMz8sgCV4h/i5FQ
         yAlM6n7Aw47GK9PiGO82SqgFpr1sBfSKy5w8bm8RpscheC09fL38/9DaEbXshPmtVf
         eTKZoUfjGAwDhGbrf8SvlbGmic0HyYW5tJMZr7sue4ky0jzVo+KSUqyrD8IzygDRJO
         pqp1GdRzrdbWsVxuOwRncTyikU9QKaZf2ZdOn8gpu5YOxJ7WY/Q
Date:   Sun, 30 Jul 2017 23:00:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] t6500: mark tests as SHA1 reliant
Message-ID: <20170730230019.ch74ska6wgbrh7ql@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20170728171817.21458-1-sbeller@google.com>
 <20170728171817.21458-3-sbeller@google.com>
 <xmqq379gmco6.fsf@gitster.mtv.corp.google.com>
 <20170729175833.4idan3befldn5vgp@genre.crustytoothpaste.net>
 <xmqqini9k4cx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jst6tiahopjbmqjj"
Content-Disposition: inline
In-Reply-To: <xmqqini9k4cx.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jst6tiahopjbmqjj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 30, 2017 at 02:21:50PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > One approach I had considered taking is having a helper of some sort
> > that wrapped a simple key/value store.  We could pass the wrapper the
> > SHA-1 value (or, if necessary, an arbitrary key) and have it return the
> > proper value based on the given hash function.
> >
> > That does have the downsides that the values may not present in the
> > tests themselves, and that people adding new tests will of course need
> > to run the test suite twice.  But it does make the tests easier to read.
> >
> > Opinions on the desirability of this approach are of course welcome.
>=20
> I am not quite sure if I follow.  There was a proposal to tweak the
> commit format that uses the new hash in such a way that we can tell
> what SHA-1 would have been used if everything were SHA-1 (I think it
> was from Jonathan, but I may be mistaken), and I recall that
> generally the list were receptive to the idea.  But I have a feeling
> that your "helper of some sort" is something else.
>=20
> If your <key,value> is about letting us store something like
>=20
>  - If you hash "hello\n" the resulting blob in SHA-1 world has this
>    object name, and with that, you can find out the equivalent
>    object name in SHA-256 world.
>=20
>  - If you have a tree with the above blob at path P and nothing
>    else, then the object name of that tree in the SHA-1 world and
>    SHA-256 world are different and we can map between them.
>=20
>  - Likewise for a commit that points at the above tree with fixed
>    date, author and message.
>=20
> I am not sure how much it would help.  Are you aiming to make it
> easier and more structured to create a patch like what Stefan did
> recently for t8008 in 0ba9c9a0 ("t8008: rely on rev-parse'd HEAD
> instead of sha1 value", 2017-07-26)?

Yes, basically, but a bit more generally.  There will always be cases in
which we need to specify an object ID or an arbitrary string and the
behavior will need to vary based on the hash.  That can be something
like, in this case, the two blob contents that would have the similar
prefix.

So in this case, we pass the helper the string "263 410" and get back a
value for either the hacked SHA-1 hash or the SHA-256 or whatever we're
using.

This was basically a nicer way of wrapping the case statement that you
had given as an example.  Of course, it doesn't relieve us of doing the
hard work of analyzing the tests, which Stefan is doing, and with which
I don't want to interfere.

It was simply a proposal for a future direction which we could take if
we found ourselves needing to write a large number of hash-specific case
statements.  I'm happy to wait to actually implement that code until we
decide we need such a thing.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--jst6tiahopjbmqjj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAll+ZQMACgkQv1NdgR9S
9ouN/xAAuC2JuZrcDS1vPUee3Ua8OCYyZq60M3+fU0tbh+RRaVx7m64vnysN74u+
17+I/L0s8ITMZJ+jwUSz4Q+cwNIdq+w8/JTRxatgb9Rt6Gbs6dmqs37QAjG8eOfW
O5RSSEdRi14QVDGgt2fhGb7Ohs64O+je5Ma+vYaAraIv3ED70gqSEeZt4USHQrO9
NQvHSdQ7A1GPB+ODdMgMMqjRY+p9eJkQbkePWAEZwjozB7yJIZqPcCQRQMtfiMw+
gOwkm2PQtqbR/zOGPHUsjRvYZZPbolKRfqdFJCfipIoLR370Tl4RqjxsMMcCBPFY
+gKrwOhBvTXscBy5SBpUT0dEo0VZ+GEym+K+qxeK5e/mx8czpFnIIgnkSFP+a2pF
Tf1XwJm0UJLuRTsRP2pboKBU8gZcajdc7eC5PEhcroQeUAWHQm0nRELsF2lSxnOF
MfmH6mV4sygD322eKoL2tHH6Tns3uAykEye6btfX779TT2TwfsKOWC8vGCRaZE/5
1qxaoq/RbpELrsRLbIHv0Ogg2gBL2dYZBwa62PUqtR7lntla77O8nUqIrSPNb+pL
ufHrX2ALCx8/3p1jpCh2L9cDpqqbu4D7Sf/bzP1VS9KUSZALm2sJPwtNrKThIC0a
WR2fSzdyOY2NwUxo5G1sGAf7CJoJdvDKraBUyWS25MgRQNBD2ok=
=aUId
-----END PGP SIGNATURE-----

--jst6tiahopjbmqjj--
