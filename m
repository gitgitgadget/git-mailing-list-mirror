Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 672601F462
	for <e@80x24.org>; Mon, 20 May 2019 23:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfETXpQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 19:45:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36672 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbfETXpQ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 May 2019 19:45:16 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:74ed:a2ab:30b2:5a04])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D48FC60443;
        Mon, 20 May 2019 23:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1558395914;
        bh=ni2oyvDToubR/A/qAegnaLRwaGqx9+47Cyg2NGGxvrc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xXbxlPnxPHSxDEL6onD1EZfnEnZCvGYH+hA/fY5l7ytGHtzUvCjm721+O0biNT7rz
         f7lNFxnw5/pRZQtEvQf7ylfPF3i+IWwKprWlYsTQnb6YS+lbWOHf0MLA7umkq4Hrn3
         WXKtpS8uZ3mBEbxriSxjIC7wHiFHAMPyfS6QyBvq2xxxFVtmelKAcdJyTn1zOMBMeg
         2ATEt89Q/BRYROY8yxKOzDMlhQM2KX10TgbVHYCCNeGMMVRT5TQhHMK26F5D5SlenF
         W160Q49xib8j9llxYxbBlDo2FJwk+wuywWCsd+l2njIdIwKnMfvqYSiwkZr351kW3i
         p3dZ3WEvvJkWORJNU7U/oLSprPn8r6STo7280fobNW97i5ooOzFvNIHRLm3bExE7MD
         t2395hrFcksS+et9rGXlQEB5I4/G9Evau2ywmmsB5jBuHoYay90bAFnNPbysOhPc1E
         mzeTB3yBxWm4bf9wT7+A6t8unUxMHZqsi1y7Ul+OF1zDYqjtw9n
Date:   Mon, 20 May 2019 23:45:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Olegzandr von Denman (ORESoftware)" <alex@oresoftware.com>
Cc:     git@vger.kernel.org
Subject: Re: improvement to pre-commit hook
Message-ID: <20190520234509.GB8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Olegzandr von Denman (ORESoftware)" <alex@oresoftware.com>,
        git@vger.kernel.org
References: <CAMsBkhmt0Xxe7EHSXJjxeZa4-CmF8oVgJiTFo2uHQOMcyKfCvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <CAMsBkhmt0Xxe7EHSXJjxeZa4-CmF8oVgJiTFo2uHQOMcyKfCvw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-19 at 06:03:11, Olegzandr von Denman (ORESoftware) wrote:
> I was expected an env var like:
>=20
> GIT_DESIRED_COMMIT_MESSAGE
>=20
> to show up when .git/hooks/pre-commit is run
>=20
> but as described here, there doesn't appear to be any args to the
> script and the environment variable isn't there?
>=20
> https://stackoverflow.com/questions/56205170/retrieving-desired-git-commi=
t-message-in-pre-commit-hook

In general, the pre-commit hook isn't the right place to inspect the
commit message. If the user hasn't specified the commit message on the
command line, then they will be prompted for it using their editor, and
there will be nothing to process.

Furthermore, since the prepare-commit-msg hook hasn't run, there could
be arbitrary changes to the commit message after the pre-commit hook
runs. You'd want to use the prepare-commit-msg hook to modify the commit
message and then use the commit-msg hook to accept or reject it. Despite
the name, the commit-msg hook can be used to perform arbitrary analysis
of the commit and reject it for any reason if you require the commit
message to do so.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzjPAUACgkQv1NdgR9S
9otESg/+PzAm5TOvDK58wfUFJUuWHTypMKKVfnjUFne8MMBrCct86ePCFy1Zle7u
VwsN3RSoDJkQA73suwPryLuE10rCqr5ojK4eK/RTdj6k21+qqORCCLywCvePBY+l
z3Y2CRHFxgKN4bDwBVCUYzGdzKCIUjn5NB/R6mpDEIJ/spxnXqaX4tb9oFYJgLrW
sbthQWERfKpV1sE9AC0t4/58IiU9i5GD+IC7lRdzmvbfMc4KYg5D2KWKuh9E11OR
yr0zws/HG3UJAMsWDqzv8R0i3ncG8vfEMtmqimipIhzlWtsMmzeC35EPtmc4k0DV
ADxK2gnpdJOpmePJUjfJRjI3wJ3rTF6PuTpwhIdKD1KK9/IRpbxNoIAvVxCHbFBp
LQDkjPWM3EGnDULqVllvCXD1Xtuvy2E9s4Xjz0nbHkaeUOMihVJ5DdW7rQ4XBZ3l
3Le2cDK4W/Thv4yG7okbj1kvAIrFf1VvHENuNgquRJxG321KCL2Vpc2FLKMipcBI
StlQBA2qA/wvMiDpSXD9Iqub2Cyqwzwb9a17kOyAqTluUMpDJP7wP7zCfcb7PHTy
5XM4jTl7slcOhaNS/mScH6UmHTTQj5B2q+FUEnUTPoRKaxzOb06doUB8M0fYEL50
A3+unhm4Oo+V0Qc1viX900uUw7Wz0GiXZf9ozWdlNL8w5UJCzro=
=7eZe
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
