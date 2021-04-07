Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABBDC433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 13:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B4C61363
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 13:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347556AbhDGNs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 09:48:57 -0400
Received: from cressida.uberspace.de ([185.26.156.202]:33572 "EHLO
        cressida.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhDGNs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 09:48:57 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Apr 2021 09:48:56 EDT
Received: (qmail 32581 invoked from network); 7 Apr 2021 13:42:04 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by cressida.uberspace.de with SMTP; 7 Apr 2021 13:42:04 -0000
Date:   Wed, 7 Apr 2021 15:42:01 +0200
From:   Matthias Beyer <mail@beyermatthias.de>
To:     git@vger.kernel.org
Subject: signed-off-by not overwritten with GIT_AUTHOR_NAME...?
Message-ID: <20210407134201.kxijiev5sn346bsy@hoshi>
Reply-To: Matthias Beyer <mail@beyermatthias.de>
X-message-flag: Mails containing HTML will not be read!  Please send only
 plain text.
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7pkadnh2mliea7vo"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7pkadnh2mliea7vo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I just found that overwriting the GIT_AUTHOR_EMAIL and GIT_AUTHOR_NAME env
variables does alter the author when committing, but does not overwrite the
--signoff entry. Is this intentional?

To reproduce:

    cd /tmp
    mkdir foo
    cd foo
    git init
    touch foo
    git add foo
    GIT_AUTHOR_EMAIL=3Dnobody@nomail.de GIT_AUTHOR_NAME=3D"Someone Else" gi=
t commit -s -m test
    git show


I'm tested this for 2.29.3 and 2.29.2.

The manpage (2.29.3) does not say anything related to that under the `--sig=
noff`
entry, nor under the `COMMIT INFORMATION` section!

If this is a bug, I'd love to contribute a patch, if someone can take my ha=
nd
and guide me to the right places!

Please keep me in CC, I'm not subscribed.

--=20
Matthias

--7pkadnh2mliea7vo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEUJGUus1GMTrRclzcEKWX9Kitz80FAmBttqYACgkQEKWX9Kit
z805ZxAAsqA7HPegrThbgO8kDulKiMVW6bwg4nJuCVxIjXqkpHBae9z6nOWxaF7A
SN2zfcfJbBTjRz/4L46TmQSUWAW0GAS2TnL7PoALsESqIPYAyvnnIuXId0M4xTj5
pqqQtDIathOoBYrfmaJV7I9gc0DkoPD1DUeLAPjnu47i0hYCI5NT99TfDU//p7Z2
hZcLAaiO3S5ePWbF9ThkSHct7sn57UFNtByzxyx/UyXPeAa8iTFc9t7JrokBB3uS
wTDx8iIQNi+18rR+s5wbPg2VJC9XdzI7Vkp5hxJD6lF+x7zs4N9JaIlpnUXbIruQ
XRVbBQk3xov67lcA/In6H/S5i+NxuFBD9avELAwUvGOc8z8mGzI90ROUD9i6Sg+c
3v8kp+ueQPWOJSn0cwg0XQSa9JkMrplxBgP6PicokV4Sp1phFWrBA85QRiBnM2Sk
wo0IdDO/lhOsEZa4PEXPONN8aJ1xEFfOzzbSATTqfcug0mBXaZcVk6Kp0Ekyfv8z
j0fE2GOw33knuYSzfWRZSKgoqQ8I/bIpIDdawQ+1GL28Vw8Zl0yrBJXnNn3KUCKS
UmpEINhfpTS/aocKjh8FRTfQOfgO17BmiXpWOnsr+TuyyV6dxGG9ATfvTblkjWKp
v8dbGNML3snmiAQu5RSSGNqsf66rIi60bV5/S7RPIFhWq1DQqVc=
=r9H8
-----END PGP SIGNATURE-----

--7pkadnh2mliea7vo--
