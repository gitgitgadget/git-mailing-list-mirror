Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C16C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 00:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355200AbiFVAso (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 20:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiFVAsn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 20:48:43 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4EF2F3AC
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 17:48:42 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6C58B5A47F;
        Wed, 22 Jun 2022 00:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1655858921;
        bh=BU3TXgEQbUV564FY9Q34PyAQQ9M1YenZoWOCro2n6lk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OVY+XIv1pVEz8IHlVqe/4twykmQZvhrH4omppbtIc0ijOHChdOXzUtqxjwFeQ5rvK
         uPqcJzMs+T+cQpgQRNug1zHyK6Wr+zEipvuz9jMsvabhUtz1cEdQBY8zxPngHrYhFU
         pzVi0KhU6Mpgbapup1M/qzKu3fmGyrwc5FgkYQXqCbizrf9Uvh41SHWRWZYliqGHnG
         KKcZU9ON6Qho6ZS9QckNBqDOhZtFf7gqqjGEl6G7GunCBVm1Tvodp7bka5+OBiLdu9
         lXohxEx9WZyD9rqZlEGOFlfwNc55DH4++wEfIQa5Tta98foEl+ALa1A19x8vJCdogY
         VBuw5FL5PS/HEL+XG9I7+e7226o3y2rwDVknPD4FIL3/YejQT9r2lGmHsc7Jc8OeZw
         zkSZzcN/zQsuoBeA9bq0/BCg6V4moq+21kK/YTSVzJiix17s4zHlcQSc72H536b1Tx
         jH1EHBjMe84sgDNmFgvU68F3p+GMhV4MnoiCFwHq0VAX3ihu1+v
Date:   Wed, 22 Jun 2022 00:48:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stewart Smith <trawets@amazon.com>, git@vger.kernel.org,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] git-send-email: Add --no-validate-email option
Message-ID: <YrJm6KactXg4elvD@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stewart Smith <trawets@amazon.com>, git@vger.kernel.org,
        Todd Zullinger <tmz@pobox.com>
References: <20220620004427.3586240-1-trawets@amazon.com>
 <YrEMq+slLOHqw/hz@camp.crustytoothpaste.net>
 <220622.864k0dmzl9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tBECWPhGfq0GJZe1"
Content-Disposition: inline
In-Reply-To: <220622.864k0dmzl9.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tBECWPhGfq0GJZe1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-21 at 22:12:24, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Tue, Jun 21 2022, brian m. carlson wrote:
>=20
> > Email::Valid is in fact correct.  However, the email which you want to
> > use doesn't conform to the RFC and isn't valid.  So this should probably
> > say something like, "Allow people to use an email address which is not
> > valid according to the RFCs if the server accepts it."
>=20
> That's fair, but that rationale is quite disconnected from how the code
> works now. You happen to get that check if you have Email::Valid
> installed, otherwise not.
>=20
> So if it's a use-case we care about we should make it a hard dependency.

Git has traditionally tried to avoid having lots of hard dependencies on
Perl modules.  For example, Perl modules are a hassle with Homebrew.

Most packagers prefer to enable the full suite of Perl modules, but it
is a bit nicer to not make it mandatory.  However, if you feel strongly,
we can change that.

> > I think this patch would be fine as it stands with those changes. Unlike
> > =C3=86var, I don't think we should get rid of Email::Valid, just like I=
 don't
> > think we should get rid of the transfer encoding checks.  I support
> > warning people before sending invalid emails, especially since I believe
> > the address in question would not be deliverable through some mail
> > servers (such as mine).
>=20
> Would this be addressed by instead opening a connection to the server,
> and seeing if it is willing to accept these addresess on a "RCPT TO"
> line?

No, because that tells you whether your smarthost will accept it.  There
are often multiple different parties involved in SMTP (including various
filtering programs, smarthosts, and relays) and all you'll know is
whether the first one of them accepts it.  I have seen systems where
there could well be four or five stages of processing an email before
it even left the host.

This is no different than with things like lines longer than 998 octets,
SMTPUTF8, or various other SMTP protocol issues.  The only surefire way
to know that your email will be accepted by the remote system is to
speak the protocol properly.  If people want an option to break the
protocol, that's fine, but we should try to avoid doing that by default.

The benefit to using Email::Valid in most cases is it prevents lots of
obvious mistakes, where the email address is clearly syntactically
invalid and undeliverable, especially due to bad author and committer
metadata.  The Linux kernel history shows that this is not uncommon and
it's useful to avoid this problem so you don't have to blow up people's
inboxes with a v2 right away just because you got an invalid address on
v1.  (Says the guy who has had to do almost exactly this.)
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--tBECWPhGfq0GJZe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYrJm6AAKCRB8DEliiIei
gfhIAP9ouBU+R3GesYTHhWcH9JBJUGEynnNccnI/KalU+6EXWwEA1k+m9J2f4rNe
jebS56zKR39viq631GPUgP4arTZPPgo=
=6gUN
-----END PGP SIGNATURE-----

--tBECWPhGfq0GJZe1--
