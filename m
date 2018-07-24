Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C5E31F597
	for <e@80x24.org>; Tue, 24 Jul 2018 22:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbeGXXSw (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 19:18:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36368 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388668AbeGXXSw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Jul 2018 19:18:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f1fc:eee3:60de:bdd8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EA1576042C;
        Tue, 24 Jul 2018 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532470214;
        bh=e2Zjs0WpOd22e4I7IjfZUh7kSfv6LdSa+OPTtAwK3AM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NLXeVwqctTRgpb3CB+mTRb7Me5otM7S/aSE0oijilzQLpPX0i251Kr0PCiGbw7gAv
         MUQ1wbcyaNDxtl+ickTeVhcS/1eh3K+ufflftmESarIFZC/YM6hpnrn4cJaG5b6AWc
         Od6uuPB7bU3Rz86eGCVI81FZrAt2SmqbwsFmroqNI2z2XAyzo/a63cMpKExPLjhIWt
         x4h9OUDoQe32+7smoK19QQaJrFxjORnIa9v/kxZY2f3ttXPAYMOHMeYiOqyGBDpsph
         54H6X2WC8080yZKJR0LqKJThNl7ISLeKMaqVsvwMX6X1v70fTTArXKCgJ/h26lEvTN
         ZYQGgay/wByy/AYQQGygKffgx0UtKYQ+Kw9eG924BIlEoiiSYb8r6IP6sbiESEjLKQ
         Z6x9YQ6BwDYwmn6jArg6AWePIsf5JQ3sGxMJ3GJlFOuKysY/qhk+uCAA81lplH8P4v
         mPxFI0NZ3EMIu8VWCT7cCAGUq/VJRAyMp7IAKaPnmBeRXGZJWEQ
Date:   Tue, 24 Jul 2018 22:10:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Subject: Re: Hash algorithm analysis
Message-ID: <20180724221008.GI18502@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net>
 <20180724190136.GA5@0f3cdde9c159>
 <CA+55aFwSe9BF8e0hLk9pp3FVD5LaVY5GRdsV3fbNtgzekJadyA@mail.gmail.com>
 <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wjoFZxbW4tu+iR6v"
Content-Disposition: inline
In-Reply-To: <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wjoFZxbW4tu+iR6v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2018 at 02:13:07PM -0700, Junio C Hamano wrote:
> Yup.  I actually was leaning toward saying "all of them are OK in
> practice, so the person who is actually spear-heading the work gets
> to choose", but if we picked SHA-256 now, that would not be a choice
> that Brian has to later justify for choosing against everybody
> else's wishes, which makes it the best choice ;-)

This looks like a rough consensus.  And fortunately, I was going to pick
SHA-256 and implemented it over the weekend.

Things I thought about in this regard:
* When you compare against SHA1DC, most vectorized SHA-256
  implementations are indeed faster, even without acceleration.
* If we're doing signatures with OpenPGP (or even, I suppose, CMS),
  we're going to be using SHA-2, so it doesn't make sense to have our
  security depend on two separate algorithms when either one of them
  alone could break the security when we could just depend on one.

I'll be sending out some patches, probably in a few days, with SHA-256
and some test fixes.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--wjoFZxbW4tu+iR6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltXo78ACgkQv1NdgR9S
9os7mBAAmPEluT/pz/n2k8RTR9iWnZy+CY2G4z3IDmUs72tu7sIW/Xz2Oaf/xb4x
0ZAt8X+yn69IabQMB9+2Vb4ECmDEWrc4zmwM2pRSq/HPVGOmkwEvwgnQ16oOu7nX
exPB8357NyZZN4ZkQmbx7fNKWFPGZ7lIPh84zmKhOu9n6J5x6ICDGKMlZVeD0ybG
LCXD83JTR0Aned/TkKHWvKsGAyqWqE1s40uB6iVjmj7NbnMilWC1nKUBy9WHdwhN
7wgOOKjT8YKk96TZgEBabNQLBMkp08jOn0T/wUMaWV+w1A8Z83QR80saEDB2Yb0q
eUbn8o6JRWN8Miqb3qHIdmPAJIEsWcV1rKWBSU71reKUg4BuZ5PgH041ClQbrkTv
d4G6VQEFmewG2z8NI4QBywQ1znVjfF2pEObVz7qMCaAosljlvwi2hpq+UE8AQN66
XasgOfSN41XD+yySp9OnIqVCPu5m02axWYpGr+BY/v+w2NZCsPlEv5gY90qCEzWu
eXWE6UzpAi163a2H9tesVbsOjwromw8V04mXBXGx0CNhHFMh8d+8MKumdrkKmVHd
fIjfpxfVZ4ys7ZT2JpHtklKuSorkUTTQM72lDaNe7GoSioc0KfoCSmCB8dEb0kod
xITRhimwnQCgnvqy72K5z2rd4fQJGpeJlqexwmx7yLwKztSYekg=
=RElF
-----END PGP SIGNATURE-----

--wjoFZxbW4tu+iR6v--
